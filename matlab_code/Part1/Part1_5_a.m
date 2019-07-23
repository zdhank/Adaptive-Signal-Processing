%% preprocessing raw ecg data
% clear all;
% close all;
% load ecg_raw.mat
% ECG1=data(20*fs:200*fs,1);
% ECG2=data(260*fs:480*fs,1);
% ECG3=data(510*fs:end,1);
% [xRRI1,fsRRI]=ECG_to_RRI(ECG1,fs);
% [xRRI2,fsRRI]=ECG_to_RRI(ECG2,fs);
% [xRRI3,fsRRI]=ECG_to_RRI(ECG3,fs);
% save('ecg_data.mat','xRRI1','xRRI2','xRRI3','fs','fsRRI');
%%
clear all;
close all;init;
load ecg_data.mat;
fs=1000;
xRRI={xRRI1;xRRI2;xRRI3};
n=1024;
for j=1:length(xRRI)
    x=xRRI{j}-mean(xRRI{j});
    N=length(x);
    x=[x,zeros(1,n-N)];
    %standard
    [px_std, w]=periodogram(x,[],fs,fsRRI);
    figure;
    plot(w,10*log10(px_std));
    title(sprintf('Standard periodogram: Tail %d',j));
    xlabel('Frequency (Hz)');
    ylabel('Power density (dB)');
    ylim([-100 0]);
    grid on;
    
    t=[150 100 50];
    %sample_rate
    figure;
    for i=1:length(t)
        L=t(i)*fsRRI;
        K=n/L;
        h=rectwin(L);
        px_seg=[];
        for jj=1:K
            [px_seg(:,jj),w]=periodogram(x((jj-1)*L+1:jj*L),h,fs,fsRRI);
        end
        px_mean(:,i)=mean(px_seg,2);
        plot(w,10*log10(px_mean(:,i)));
        hold on
    end
    title(sprintf('Average periodogram: Tail %d',j));
    legend('width=150','width=100','width=50');
    xlabel('Frequency (Hz)');
    ylabel('Power density (dB)');
    grid on;
end