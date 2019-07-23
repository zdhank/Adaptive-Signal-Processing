clear all;
close all;
init;
load data/EEG/EEG_Data_Assignment1.mat;
%init
N=1200;
K=2^12;
mu = 1;
%EEG POz
a=1000;
POz=POz-mean(POz);
y=POz(a:a+N-1);
%
xin = (1/K)*exp(1j*(1:N).'*2*pi*(0:(K-1))/ K).';
[~,h,~]=dft_clms(xin, y, mu, 0.01);
% remove outliers
H=abs(h).^2;
medianH =110*median(median(H));
H(H>medianH)=medianH;
figure();
surf(1:N, (0:K-1).*fs/K, H, 'LineStyle', 'none');
view(2);
title('Leaky DFT-CLMS estimated EEG Spectrum');
xlabel('Time Index, N');
ylabel('Frequency (Hz)');
grid on;
ylim([0,70]);
