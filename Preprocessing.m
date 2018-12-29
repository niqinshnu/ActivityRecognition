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

