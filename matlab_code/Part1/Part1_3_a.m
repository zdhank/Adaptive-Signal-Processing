clear all
close all
% samples
N=1024;
% signal
wgn=randn(N,1);
filter_wgn=filter([1/3 1/3 1/3],1,wgn);
sinwave=randn(N,1)+sin(linspace(0,N,N))';
signal=[wgn,filter_wgn,sinwave];
name={'WGN','Filtered WGN','Noisy Sine'};
for i=1:3
    [unbiased,lag]=xcorr(signal(:,i),'unbiased');
    biased=xcorr(signal(:,i),'biased');
    unb=ifftshift(unbiased);
    b=ifftshift(biased);
    px_unbiased=real(fftshift(fft(unb)));
    px_biased=real(fftshift(fft(b)));
    fs=lag/max(lag);
    subplot(3,2,2*i-1);
    plot(lag,unbiased,lag,biased);
    xlabel('Lag (k)');
    ylabel('ACF');
    title(sprintf('ACF: %s',name{i}));
    xlim([0,N+100]);
    grid on;
    subplot(3,2,2*i);
    plot(fs,px_unbiased,fs,px_biased);
    xlabel('Nomalised frequency');
    ylabel('Power (dB)');
    title(sprintf('Correlogram: %s',name{i}));
    xlim([0,inf]);
    grid on;
end
h=legend('unbiased','biased','location','northoutside','Orientation','horizontal');
newPosition = [0.45 0 0.1 0.1];
newUnits = 'normalized';
set(h,'Position', newPosition,'Units', newUnits);
