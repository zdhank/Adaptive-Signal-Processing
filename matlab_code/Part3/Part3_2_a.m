clear all;
close all;
init;
%init
N=1500;
sigma=0.05;
fs=1600;
wn = wgn(N,1,pow2db(sigma), 'complex');
f=zeros(N,1);
for n=1:N
    if n<=500
        f(n)=100;
    elseif n>500&&n<=1000
        f(n)=100+(n-500)/2;
    else
        f(n)=100+((n-1000)/25).^2;
    end
end
figure();
plot(f);
title('Frequency of FM signal');
xlabel('Time index, N');
ylabel('Frequency (Hz)');
grid on;
%FM signal
phi=cumsum(f);
y=exp(1j*(2*pi*phi/fs+wn));
%total AR
for p=[1 10 15]
    a=aryule(y,p);
    [h,w]=freqz(1,a,N,fs);
    figure();
    psd = mag2db(abs(h));
    plot(w,psd);
    title(sprintf('Whole FM : AR(%d)', p));
    xlabel('Freuqncy (Hz)');
    ylabel('Power Spectral Density (dB)');
    grid on;
end
%segment AR
mode={'Constant';'Linear';'Quadratic'};
for p=[1 15]
    for i=1:3
        a=aryule(y(500*(i-1)+1:500*i,1),p);
        [h,w]=freqz(1,a,N,fs);
        figure();
        psd = mag2db(abs(h));
        plot(w,psd,'color',COLORS(i,:));
        title(sprintf('%s FM segment : AR(%d)', mode{i},p));
        xlabel('Freuqncy (Hz)');
        ylabel('Power Spectral Density (dB)');
        grid on;
    end
end


