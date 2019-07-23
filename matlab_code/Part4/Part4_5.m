clear all; close all;
init;
epoch=100;
load time-series.mat;
N=length(y);
p=4;
a=50;b='on';
mu=1*10^-5;
%init
xin=[zeros(p,1);y];
w_init=zeros(p,N);
%% std LMS
[yhat, ~, e] = lms1(xin, y, mu, p);
mse=mean(abs(e).^2);
rp=10*log10(var(yhat)/var(e));
figure();
plot(y);
hold on;
plot(yhat);
plot([0 N],[mean(yhat) mean(yhat)]);
title(sprintf('Standard LMS: Non-zero mean series\n MSE=%.3f, Rp=%.3f', mse, rp'));
legend('y[n]','$\hat y[n]$','$\mathit{E}\{\hat y[n]\}$','Interpreter','Latex','Orientation','horizontal');
grid on;
%% Dynamic percetron
for i=1:epoch
    [~, w(:,:,i), ~] = lms_tanh(xin, y, mu, p, a, b, w_init);
    w_init=w(:,:,i);
end
%train
[yhat, ~, e] = lms_tanh(xin, y, mu, p, a, b, w_init);
mse=mean(abs(e).^2);
rp=10*log10(var(yhat)/var(e));
figure();
plot(y);
hold on;
plot(yhat);
plot([0 N],[mean(yhat) mean(yhat)]);
title(sprintf('Initial weights perceptron: Non-zero mean series\n a=%d, MSE=%.3f, Rp=%.3f', a, mse, rp'));
legend('y[n]','$\hat y[n]$','$\mathit{E}\{\hat y[n]\}$','Interpreter','Latex','Orientation','horizontal');
grid on;
