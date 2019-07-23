clear all;
close all;
init;
load data/PCR/PCAPCR.mat;
% OLS
B_ols = inv(Xnoise' * Xnoise)* Xnoise' * Y;
Y_ols=Xnoise*B_ols;
Y_ols_test=Xtest*B_ols;
train_ols=norm(Y-Y_ols,'fro');
test_ols=norm(Ytest-Y_ols_test,'fro');
% PCR
for r=1:10
    %train
    [U1,S1,V1]=svd(Xnoise);
    Xnoisetrain=U1(:,1:r)*S1(1:r,1:r)*V1(:,1:r)';
    B_pcr=V1(:,1:r)*inv(S1(1:r,1:r))*U1(:,1:r)'*Y;
    Y_pcr=Xnoisetrain*B_pcr;
    train_pcr(r)=norm(Y-Y_pcr,'fro');
    %test
    [U2,S2,V2]=svd(Xtest);
    Xnoisetest=U2(:,1:r)*S2(1:r,1:r)*V2(:,1:r)';
    Y_pcr_test=Xnoisetest*B_pcr;
    test_pcr(r)=norm(Ytest-Y_pcr_test,'fro');
end
figure;
plot(1:10,train_pcr,'linewidth',2);
hold on;
plot([1,10],[train_ols,train_ols],'--','linewidth',2)
grid on;
title('Trianing error');
xlabel('Rank');
ylabel('Error');
legend('PCR','OLS');
ylim([55 inf]);
figure;
plot(1:10,test_pcr,'linewidth',2);
hold on;
plot([1,10],[test_ols,test_ols],'--','linewidth',2)
grid on;
title('Test error');
xlabel('Rank');
ylabel('Error');
legend('PCR','OLS');
ylim([40 inf]);