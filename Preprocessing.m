%Get the list of files
train_files = dir('C:\Users\admin\Desktop\ActivityRecognition\SlidingWindow\train_data\*.csv');
test_files = dir('C:\Users\admin\Desktop\ActivityRecognition\SlidingWindow\test_data\*.csv');
outs = cell(numel(train_files),1);

%Read train data from the folder and store in cell array
for i = 1:numel(train_files)
    outs{i} = csvread(train_files(i).name)
end

%Merge the outputs into one bigger matrix
train_data = vertcat(outs{:});

%Read test data from the folder
test_data = csvread(test_files.name)

%Extract colums as vectors
train_ax = train_data(:,1);
train_ay = train_data(:,2);
train_az = train_data(:,3);
%train_gx = train_data(:,4);
%train_gy = train_data(:,5);
%train_gz = train_data(:,6);
train_actid = train_data(:,7);
%train_typeid = train_data(:,8);
train_subid = train_data(:,9);

test_ax = test_data(:,1);
test_ay = test_data(:,2);
test_az = test_data(:,3);
%test_gx = test_data(:,4);
%test_gy = test_data(:,5);
%test_gz = test_data(:,6);
test_actid = test_data(:,7);
%test_typeid = test_data(:,8);
test_subid = test_data(:,9);

%Concatenate acceleration
ax = [train_ax; test_ax];
ay = [train_ay; test_ay];
az = [train_az; test_az];
%gx = [train_gx; test_gx];
%gy = [train_gy; test_gy];
%gz = [train_gz; test_gz];

%Concatenate labels
actid = [train_actid; test_actid];
%typeid = [train_typeid; test_typeid];
subid = [train_subid; test_subid];

%Create activity type labels and activity type labels
%typenames = {'static activity','dynamic activity','transitional
%activity'};
actnames = {'standing','sleeping','watching TV','walking','running','sweeping','stand-to-sit','sit-to-stand','stand-to-walk','walk-to-stand','lie-to-sit','sit-to-lie'};

%Define sample frequency and time vector
fs = 102.4;
t = (1/fs)*(0:size(ax)-1);

% Concatenate all acceleration components together
accxyz = [ax,ay,az];

%low pass butterworth filter with 20 Hz cutoff frequency to remove the noise
Wn1 = 20/fs;
[b,a] = butter(3,Wn1);
filtered1_ax = filtfilt(b,a,ax);
filtered1_ay = filtfilt(b,a,ay);
filtered1_az = filtfilt(b,a,az);
plot(t,ax);
hold on
plot(t,filtered1_ax);

%median filter to remove noise and solve the signal delay
filtered2_ax = medfilt1(filtered1_ax,3);
filtered2_ay = medfilt1(filtered1_ay,3);
filtered2_az = medfilt1(filtered1_az,3);
plot(t,ax);
hold on
plot(t,filtered2_ax);

% high pass butterworth filter with 0.3 Hz cutoff frequency to seperate
% body acceleration and gravity
Wn2 = 0.3/fs;
[B,A] = butter(3,Wn2,'high');
bax = filtfilt(B,A,filtered2_ax);
bay = filtfilt(B,A,filtered2_ay);
baz = filtfilt(B,A,filtered2_az);
plot(t,filtered2_ax);
hold on
plot(t,bax);

gax = filtered2_ax - bax;
gay = filtered2_ay - bay;
gaz = filtered2_az - baz;
plot(t,filtered2_ax);
hold on
plot(t,gax);

