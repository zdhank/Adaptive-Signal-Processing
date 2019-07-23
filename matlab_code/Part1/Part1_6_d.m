clear all;
close all;
init;
load data/PCR/PCAPCR.mat;
addpath('data/PCR/');
% OLS
B_ols = inv(Xnoise' * Xnoise)* Xnoise' * Y;
figure;
for i=1:50
    [Yhat_ols,Y_ols]=regval(B_ols);
    e_ols(i)=norm(Y_ols-Yhat_ols,2);
    plot([1,10],[e_ols(i),e_ols(i)],'linewidth',0.5,'Color',COLORS(3,:));
    hold on;
end
% PCR
for r=1:10
    %train
    [U1,S1,V1]=svd(Xnoise);
    Xnoisetrain=U1(:,1:r)*S1(1:r,1:r)*V1(:,1:r)';
    B_pcr=V1(:,1:r)*inv(S1(1:r,1:r))*U1(:,1:r)'*Y;
    for i=1:50
        [Yhat_pcr,Y_pcr]=regval(B_pcr);
        e_pcr(i,r)=norm(Y_pcr-Yhat_pcr,2);
    end
end
plot(1:10,e_pcr,'Color',COLORS(6,:),'linewidth',0.5);
pcr=plot(1:10,mean(e_pcr),'b','displayname','PCR');
ols=plot([1 10],[mean(e_ols) mean(e_ols)],'r--','displayname','OLS');
legend([pcr ols],{'PCR','OLS'});
grid on;
title('Estimated Error');
xlabel('Rank');
ylabel('Error');

