clear all;
close all;
init;
load data/EEG/EEG_Data_Assignment2.mat
%init
N=length(POz);
t=1:N;
f0=50;
f=f0/fs;
mu=[0.001,0.005,0.01];
M=[5,10,15];

L=2^12;
overlap=0.5;
K=2^14;
%noise signal
x=sin(2*pi*f*t);
v=normrnd(0,0.3,N,1);
y=x'+v;
% Detrend the POz
POz=POz-mean(POz);
% Origin spectral
figure(1);
spectrogram(POz, rectwin(L), round(overlap * L), K, fs, 'yaxis');
title('EEG: POz Original Spectrogram');
yticks(0:10:60);
ylim([0 60]);
c = colorbar;
c.Label.String = "Power/frequency (dB/Hz)";
%%
%ANC POz
count=0;
for i=1:length(M)
    u_anc=[zeros(M(i)-1,1);y];
    for j=1:length(mu)
        count=count+1;
        [eta_hat(:,i,j), ~, ~] = lms1(u_anc, POz, mu(j), M(i));
        poz_anc(:,i,j)=POz-eta_hat(:,i,j);
        figure();
        spectrogram(poz_anc(:,i,j), rectwin(L), round(overlap * L), K, fs, 'yaxis');
        title(sprintf('M=%d \\mu=%.3f',M(i),mu(j)));
        yticks(0:10:60);
        ylim([0 60]);
        c = colorbar;
        c.Label.String = "Power/frequency (dB/Hz)";
    end
end
%%
% Periodogram
figure();
% origin
[Po, wo] = periodogram(POz, rectwin(N), K, fs,'onesided');
% ANC
[Panc, wanc] = periodogram(poz_anc(:,2,1), rectwin(N), K, fs,'onesided');
plot(wo, pow2db(Po), 'DisplayName', 'Original POz');
hold on;
plot(wanc, pow2db(Panc), 'DisplayName', 'ANC POz');
title('Original POz and ANC Periodogram');
xlabel("Frequency (Hz)");
ylabel("Power Density (dB)");
xticks(0:10:60);
ylim([-170 -80]);
xlim([0 60]);
grid on;
legend("show", "Location", "SouthWest");
% Squared error
figure();
plot(wo, pow2db(abs(Po-Panc)));
title('Squared Error Periodogram');
xlabel("Frequency (Hz)");
ylabel("Power Density (dB)");
xticks(0:10:60);
ylim([-170 -80]);
xlim([0 60]);
grid on;

