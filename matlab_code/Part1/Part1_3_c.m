clear all;
close all;
init;
Part1_3_b;
close all;
for i=1:100
    plot(w,pow2db(px(:,i)),'c','linewidth',0.5);
    hold on;
end
plot(w,pow2db(mean(px,2)),'b','linewidth',1.5)
title('PSD estimates (different realisations and mean)');
xlabel('Frequency (\pi radians)');
ylabel('Power Density (dB)');
xlim([0,f3+1]);
ylim([-40,inf]);
grid on;
figure();
plot(w,pow2db(std(px,1,2)),'r','linewidth',1.5)
title(sprintf('Standard deviation of the PSD estimate'));
xlabel('Frequency (\pi radians)');
ylabel('Power Density (dB)');
xlim([0,f3+1]);
grid on;



