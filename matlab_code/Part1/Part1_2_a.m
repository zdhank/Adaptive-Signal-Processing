clear all;close all;
init;
load sunspot.dat
% raw data
x=sunspot(:,2);
t=sunspot(:,1);
%Length
N=length(x);
%zero-padding
n=2^10;
% detrend & mean
x1=detrend(x);
x3=x-mean(x);
% log & mean
x2=log(x+eps)-mean(log(x+eps));
% window
h=hanning(N);
figure(1);
plot(t,x,t,x1,t,x3,t,x2);
title('Time siers of sunspots');
xlabel('Time (year)');
ylabel('Number of sunspots');
lgd=legend('raw sunspots', 'derend','mean', 'log&mean');
lgd.NumColumns = 2;
grid on;
%rect window PSD
figure(2);
[pxx,w] = periodogram(x,h,n,2);
plot(w,10*log10(pxx));
hold on
% detrend data
[pxx1,w1] = periodogram(x1,h,n,2);
plot(w1,10*log10(pxx1));
%mean data
[pxx3,w3] = periodogram(x3,h,n,2);
plot(w3,10*log10(pxx3));
% log data
[pxx2,w2] = periodogram(x2,h,n,2);
plot(w2,10*log10(pxx2));
title('Sunpots Periodogram with Hanning window');
xlabel('Normalised Frequency (units of \pi)');
ylabel('Power Density (dB)');
lgd=legend('raw sunspots', 'derend','mean', 'log&mean');
lgd.NumColumns = 2;
ylim([-20 60]);
grid on;
