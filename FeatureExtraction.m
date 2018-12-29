

%segment the signal using buffer function into data frames with 256
%samples(2.5 s) and 50% overlapping
seg_bax = buffer(bax,256);
seg_bay = buffer(bay,256);
seg_baz = buffer(baz,256);

seg_gax = buffer(gax,256);
seg_gay = buffer(gay,256);
seg_gaz = buffer(gaz,256);

%extract features
%initialize feature vector
feat = zeros(77,8543);

% body acceleration time domain features
%average value in the segmented buffer for body x, y, z acceleration.
feat(1,:) = mean(seg_bax);
feat(2,:) = mean(seg_bay);
feat(3,:) = mean(seg_baz);

%Root mean squared value in the segmented buffer for body x,y,z acceleration.
feat(4,:) = rms(seg_bax);
feat(5,:) = rms(seg_bay);
feat(6,:) = rms(seg_baz);

%Standard deviation in the segmented buffer for body x,y,z acceleration
feat(7,:) = std(seg_bax);
feat(8,:) = std(seg_bay);
feat(9,:) = std(seg_baz);

%Median absolute deviation in the segmented buffer for body x,y,z acceleration
feat(10,:) = mad(seg_bax);
feat(11,:) = mad(seg_bay);
feat(12,:) = mad(seg_baz);

%Range between the max and min value of the signal
feat(13,:) = range(seg_bax);
feat(14,:) = range(seg_bay);
feat(15,:) = range(seg_baz);

%Correlation coefficient between different axis
    for i = 1:8543
        F1 = corrcoef(seg_bax(:,i),seg_bay(:,i));
        feat(16,:) = F1(1,2);
    end
    
     for i = 1:8543
        F2 = corrcoef(seg_bax(:,i),seg_baz(:,i));
        feat(17,:) = F2(1,2);
     end
     
     for i = 1:8543
        F3 = corrcoef(seg_bay(:,i),seg_baz(:,i));
        feat(18,:) = F3(1,2);
    end
    
%Signal Magnitude Area
feat(19,:) = (sum(abs(seg_bax))+sum(abs(seg_bay))+sum(abs(seg_baz)))/256;

%Tilt angle of three axis
feat(20,:) = mean(atan(seg_bax./sqrt(seg_bay.^2+seg_baz.^2))*180/pi);
feat(21,:) = mean(atan(seg_bay./sqrt(seg_bax.^2+seg_baz.^2))*180/pi);
feat(22,:) = mean(atan(seg_baz./sqrt(seg_bax.^2+seg_bay.^2))*180/pi);

%Body acceleration frequency domain features
%Spectral Engergy
feat(23,:) = sum(abs(fft(seg_bax)).^2);
feat(24,:) = sum(abs(fft(seg_bay)).^2);
feat(25,:) = sum(abs(fft(seg_baz)).^2);

%Spectral Entropy
feat(26,:) = sum(abs(fft(seg_bax)).*log(1./abs(fft(seg_bax))));
feat(27,:) = sum(abs(fft(seg_bay)).*log(1./abs(fft(seg_bay))));
feat(28,:) = sum(abs(fft(seg_baz)).*log(1./abs(fft(seg_baz))));

%Frequency signal skewness
feat(29,:) = skewness(seg_bax);
feat(30,:) = skewness(seg_bay);
feat(31,:) = skewness(seg_baz);

%Frequency signal kurtosis
feat(32,:) = kurtosis(seg_bax);
feat(33,:) = kurtosis(seg_bay);
feat(34,:) = kurtosis(seg_baz);

%Largest frequency component
feat(35,:) = max(abs(fft(seg_bax)));
feat(36,:) = max(abs(fft(seg_bay)));
feat(37,:) = max(abs(fft(seg_baz)));

%Frequency signal weighted average
feat(38,:) = sum(abs(fft(seg_bax)).*seg_bax)./sum(abs(fft(seg_bax)));
feat(39,:) = sum(abs(fft(seg_bay)).*seg_bay)./sum(abs(fft(seg_bay)));
feat(40,:) = sum(abs(fft(seg_baz)).*seg_baz)./sum(abs(fft(seg_baz)));

%Gravity acceleration features
%Average value in the segmented buffer for gravity x, y, z acceleration.
feat(41,:) = mean(seg_gax);
feat(42,:) = mean(seg_gay);
feat(43,:) = mean(seg_gaz);

%Root mean squared value in the segmented buffer for gravity x,y,z acceleration.
feat(44,:) = rms(seg_gax);
feat(45,:) = rms(seg_gay);
feat(46,:) = rms(seg_gaz);

%Standard deviation in the segmented buffer for gravity x,y,z acceleration
feat(47,:) = std(seg_gax);
feat(48,:) = std(seg_gay);
feat(49,:) = std(seg_gaz);

%Median absolute deviation in the segmented buffer for gravity x,y,z acceleration
feat(50,:) = mad(seg_gax);
feat(51,:) = mad(seg_gay);
feat(52,:) = mad(seg_gaz);

%Range between the max and min value of the signal
feat(53,:) = range(seg_gax);
feat(54,:) = range(seg_gay);
feat(55,:) = range(seg_gaz);

%Correlation coefficient between different axis 
    for i = 1:8543
        F4 = corrcoef(seg_gax(:,i),seg_gay(:,i));
        feat(56,:) = F4(1,2);
    end
    
     for i = 1:8543
        F5 = corrcoef(seg_gax(:,i),seg_gaz(:,i));
        feat(57,:) = F5(1,2);
     end
     
     for i = 1:8543
        F6 = corrcoef(seg_gay(:,i),seg_gaz(:,i));
        feat(58,:) = F6(1,2);
     end

%Signal Magnitude Area
feat(59,:) = (sum(abs(seg_gax))+sum(abs(seg_gay))+sum(abs(seg_baz)))/256;

%Body acceleration signal vector magnitude
bodyMag = sqrt(seg_bax.^2+seg_bay.^2+seg_baz.^2);

%Body acceleration signal vector magnitude time domain features
%average value in the body acceleration signal vector magnitude
feat(60,:) = mean(bodyMag);

%Root mean squared value in the body acceleration signal vector magnitude
feat(61,:) = rms(bodyMag);

%Standard deviation in the body acceleration signal vector magnitude
feat(62,:) = std(bodyMag);

%Median absolute deviation in the  body acceleration signal vector magnitude
feat(63,:) = mad(bodyMag);

%Range between the max and min value of the signal
feat(64,:) = range(bodyMag);

%Signal Magnitude Area
feat(65,:) = (sum(abs(bodyMag)))/256;

%Body acceleration  signal vector magnitude frequency domain features
%Spectral Engergy
feat(66,:) = sum(abs(fft(bodyMag)).^2);

%Spectral Entropy
feat(67,:) = sum(abs(fft(bodyMag)).*log(1./abs(fft(bodyMag))));

%Frequency signal skewness
feat(68,:) = skewness(bodyMag);

%Frequency signal kurtosis
feat(69,:) = kurtosis(bodyMag);

%Largest frequency component
feat(70,:) = max(abs(fft(bodyMag)));

%Frequency signal weighted average
feat(71,:) = sum(abs(fft(bodyMag)).*bodyMag)./sum(abs(fft(bodyMag)));


%Gravity acceleration signal vector magnitude
graMag = sqrt(seg_gax.^2+seg_gay.^2+seg_gaz.^2);

%Gravity acceleration signal vector magnitude time domain features
%average value in the gravity acceleration signal vector magnitude
feat(72,:) = mean(graMag);

%Root mean squared value in the gravity acceleration signal vector magnitude
feat(73,:) = rms(graMag);

%Standard deviation in the gravity acceleration signal vector magnitude
feat(74,:) = std(graMag);

%Median absolute deviation in the  body acceleration signal vector magnitude
feat(75,:) = mad(graMag);

%Range between the max and min value of the signal
feat(76,:) = range(graMag);

%Signal Magnitude Area
feat(77,:) = (sum(abs(graMag)))/256;







