clear all;
close all;
init;
%init
N=1500;
sigma=0.05;
fs=1600;
p=1;
mu = [0.002 0.01 0.05 0.5];
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
xin=[zeros(p,1);y];
for i=1:length(mu)
    [~,h_clms,~]=clms(xin, y, mu(i), p);
    for n = 1:N
        % estimation
        [h, w] = freqz(1, [1; -conj(h_clms(n))], 1024, fs);
        % storage
        H(:, n) = abs(h).^2;
    end
    % remove outliers
    medianH = 50 * median(median(H));
    H(H > medianH) = medianH;
    figure();
    surf(1:N, w, H, 'LineStyle', 'none');
    view(2);
    title(sprintf('CLMS estimated Spectrum, \\mu=%.3f', mu(i)));
    xlabel('Time Index, N');
    ylabel('Frequency (Hz)');
    grid on; 
end