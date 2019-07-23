clear all;
close all;
init;
%init
N=1500;
K=1024;
sigma=0.05;
fs=1600;
mu = 1;
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
%FM signal
phi=cumsum(f);
y=exp(1j*(2*pi*phi/fs+wn));
%
xin = (1/K)*exp(1j*(1:N)'*2*pi*(0:(K-1))/K).';
gamma=[0 0.01 0.1 0.3];
for i=1:length(gamma)
    [~,h,e]=dft_clms(xin, y, mu, gamma(i));
    % remove outliers
    H=abs(h).^2;
    medianH =50*median(median(H));
    H(H>medianH)=medianH;
    figure();
    surf(1:N, (0:K-1).*fs/K, H, 'LineStyle', 'none');
    view(2);
    title(sprintf('DFT-CLMS estimated Spectrum, \\gamma=%.2f', gamma(i)));
    xlabel('Time Index, N');
    ylabel('Frequency (Hz)');
    grid on;
    ylim([0,800]);
end
