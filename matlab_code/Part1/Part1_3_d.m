clear all;
close all;
N=[35 40 45 50];
f=[0.32 0.33 0.34 0.35];
for i=1:4
    n=0:N(i);
    noise=0.2/sqrt(2)*(randn(size(n))+1j*randn(size(n)));
    x=exp(1j*2*pi*0.3*n)+exp(1j*2*pi*f(1)*n)+noise;
    subplot(1,4,i)
    [px,w]=periodogram(x,rectwin(length(n)));
    plot(w/max(w),pow2db(px));
    xlim([0.2,0.5]);
    ylim([-40,10]);
    title(sprintf('N= %d',N(i)));
    xlabel('Frequency (\pi)');
    ylabel('Power Density (dB)');
end
figure;
for j=1:4
    n=0:N(1);
    noise=0.2/sqrt(2)*(randn(size(n))+1j*randn(size(n)));
    x=exp(1j*2*pi*0.3*n)+exp(1j*2*pi*f(j)*n)+noise;
    subplot(1,4,j)
    [px,w]=periodogram(x,rectwin(length(n)));
    plot(w/max(w),pow2db(px));
    xlim([0.2,0.5]);
    ylim([-40,10]);
    title(sprintf('frequency= %g',f(j)));
    xlabel('Frequency (\pi)');
    ylabel('Power Density (dB)');
end
