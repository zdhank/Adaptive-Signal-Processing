clear all;
close all;
N=1000;
a=[2.76 -3.81 2.65 -0.92];
A = [1 -a];
[H,F] = freqz(1,A,[],2);
xt= randn(N,1);
x=xt(501:end,1);
y = filter(1,A,x);
p=2:14;
for i=1:length(p)
    figure;
    plot(F,20*log10(abs(H)))
    xlabel('Frequency (Hz)')
    ylabel('PSD (dB)')
    hold on
    [ap,sigma]=aryule(y,p(i));
    [estH,estF] = freqz(sigma^(1/2),ap,[],2);
    plot(estF,20*log10(abs(estH)))
    legend('True PSD','Estimated PSD ')
    grid on;
    title(sprintf('AR(%d) Model, N=%d',p(i),N-500));
    xlim([0,0.5]);
end