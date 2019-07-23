clear all;
close all;
init;
load data/PCR/PCAPCR.mat;
for r=1:10
    [U,S,V]=svd(Xnoise);
    Xnoisehat=U(:,1:r)*S(1:r,1:r)*V(:,1:r)';
    error(r)=norm(X-Xnoisehat,'fro');
end
e=norm(X-Xnoise,'fro');
plot(1:10,error);
hold on;
plot([1,10],[e,e])
grid on;
title('Approximation errors');
xlabel('Rank');
ylabel('Error');
legend('noiseless error','noise error');
ylim([25 60]);