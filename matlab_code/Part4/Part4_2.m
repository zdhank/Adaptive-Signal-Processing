close all;clear all;
init;
load time-series.mat;
y=y-mean(y);
N=length(y);
p=4;
mu=1*10^-5;
xin=[zeros(p,1);y];
[yhat, ~, ~] = lms_tanh(xin, y, mu, p);
figure();
plot(y);
hold on;
plot(yhat);
title('Dynamcal perceptron of zero-mean time-series');
legend('y[n]','$\hat y[n]$','Interpreter','Latex','Orientation','horizontal');
grid on