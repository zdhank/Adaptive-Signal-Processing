clear all;close all;
init;
load data/EEG/EEG_Data_Assignment1.mat
%length
N=length(POz);
%centering
poz=POz-mean(POz);
%standard
[px_std, w]=periodogram(poz,[],5*fs,fs);
figure(1);
plot(w,10*log10(px_std));
title('Standard periodogram');
xlabel('Frequency (Hz)');
ylabel('Power density (dB)');
ylim([-150 -100]);
xlim([0 60]);
grid on;

t=[10 5 1];
%sample_rate
for i=1:length(t)
    L=t(i)*fs;
    K=N/L;
    h=rectwin(L);
    for j=1:K
        [px_seg(:,j),w]=periodogram(poz((j-1)*L+1:j*L),h,5*fs,fs);
    end
    px_mean(:,i)=mean(px_seg,2);
    figure(2);
    %plot(w,10*log10(px_std));
    plot(w,10*log10(px_mean(:,i)));
    hold on;
    ylim([-150 -100]);
    xlim([0 60]);
end
title('Periodogram of Bartlett Method');
legend('width=10s','width=5s','width=1s');
xlabel('Frequency (Hz)');
ylabel('Power density (dB)');
grid on;
%%
figure();
plot(w,10*log10(px_std));
hold on;
plot(w,10*log10(px_mean(:,1)),'linewidth',2);
ylim([-150 -100]);
xlim([0 60]);
title('EEG Periodogram');
legend('standard','width=10s');
xlabel('Frequency (Hz)');
ylabel('Power density (dB)');
grid on;

figure();
plot(w,10*log10(px_std));
hold on;
plot(w,10*log10(px_mean(:,3)),'linewidth',2);
ylim([-150 -100]);
xlim([0 60]);
title('EEG Periodogram');
legend('standard','width=1s');
xlabel('Frequency (Hz)');
ylabel('Power density (dB)');
grid on;