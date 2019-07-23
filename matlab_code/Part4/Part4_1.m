clear all;close all;
init;
load time-series.mat;
y=y-mean(y);
N=length(y);
p=4;
mu=1*10^-5;
xin=[zeros(p,1);y];
[yhat, ~, e] = lms1(xin, y, mu, p);
mse=pow2db(mean(abs(e).^2));
rp=10*log10(var(yhat)/var(e));
figure()
plot(y);
hold on;
plot([0 N],[mean(y) mean(y)]);
title('Zero-mean time-series');
legend('y[n]','$\mathit{E}\{y[n]\}$','Interpreter','Latex','Orientation','horizontal');
xlabel('time index (N)');
grid on;

figure();
plot(y);
hold on;
plot(yhat);
plot([0 N],[mean(yhat) mean(yhat)]);
title(sprintf('Predicted time-series, MSE=%.3f, Rp=%.3f', mse, rp'));
legend('y[n]','$\hat y[n]$','$\mathit{E}\{\hat y[n]\}$','Interpreter','Latex','Orientation','horizontal');
xlabel('time index (N)');
grid on;


