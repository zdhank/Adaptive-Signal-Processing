clear all;
close all;
init;
fs=1000;
load ecg_data.mat;
xRRI={xRRI1;xRRI2;xRRI3};
n=1024;
for j=1:length(xRRI)
    x=xRRI{j}-mean(xRRI{j});
    N=length(x);
    x=[x,zeros(1,n-N)];
    %standard
    [px_std, w]=periodogram(x,[],fs,fsRRI);
    figure(j);
    plot(w,10*log10(px_std),'linewidth',1.5,'displayname','standard');
    ylim([-100 0]);
    hold on;
    %AR
    p=2:4:21;
    for i=1:length(p)
        [ap,sigma]=aryule(x,p(i));
        [estH,estF] = freqz(sqrt(sigma),ap,[],fsRRI);
        plot(estF,20*log10(abs(estH)),'linewidth',2,'displayname',sprintf('p=%d',p(i)));
    end
    title(sprintf('Standard vs AR model periodogram: Tail %d',j));
    xlabel('Frequency (Hz)');
    ylabel('Power density (dB)');
    grid on;
    lgd = legend('show');
    lgd.NumColumns = 3;
    hold off;
end