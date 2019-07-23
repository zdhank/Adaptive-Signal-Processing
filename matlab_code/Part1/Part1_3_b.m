clear all;close all;
init;
fs=20;
N=512;
f1=2;f2=3;f3=4;
A1=1;A2=1;A3=1.5;
n=[0:300]./(2*fs);
s=A1*sin(2*pi*f1*n)+A2*sin(2*pi*f2*n)+A3*sin(2*pi*f3*n);
x=[s,zeros(1,N-length(s))];
for i=1:100
    noise=wgn(1,N,2);
    y=x+noise;
    [biased,lag]=xcorr(y,'biased');
    w=lag/max(lag)*fs;
    biased=ifftshift(biased);
    px(:,i)=real(fftshift(fft(biased)));
    plot(w,px(:,i),'c','linewidth',0.5);
    hold on;
end
plot(w,mean(px,2),'linewidth',2)
title('PSD estimates (different realisations and mean)');
xlabel('Frequency (\pi radians)');
ylabel('Power Density');
xlim([0,f3+1]);
grid on;
figure();
plot(w,std(px,1,2),'r','linewidth',2)
title(sprintf('Standard deviation of the PSD estimate'));
xlabel('Frequency (\pi radians)');
ylabel('Power Density');
xlim([0,f3+1]);
grid on;