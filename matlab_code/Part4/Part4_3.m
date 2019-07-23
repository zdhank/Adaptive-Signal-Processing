close all;clear all;
init;
load time-series.mat;
N=length(y);
p=4;
mu=1*10^-5;
%% None-zreo mean
xin=[zeros(p,1);y];
i=0;
for a=[20 40 50 60 70 80]
    i=i+1;
    [yhat, ~, e] = lms_tanh(xin, y, mu, p, a);
    mse=mean(abs(e).^2);
    rp=10*log10(var(yhat)/var(e));
    fig=figure();
    plot(y);
    hold on;
    plot(yhat);
    title(sprintf('None-zero: a=%d, MSE=%.3f, Rp=%.3f', a, mse, rp));
    legend('y[n]','$\hat y[n]$','Interpreter','Latex','Orientation','horizontal');
    ylim([-50 50]);
    grid on;
    %saveas(fig, sprintf('/Users/hzd88688126com/Desktop/USFD_Academic-_Report_LaTeX-Template/fig/4/43b%d.eps',i), "epsc");
end
%% Zero mean
y=y-mean(y);
xin=[zeros(p,1);y];
i=0;
for a=[20 40 60 70 80 90]
    i=i+1;
    [yhat, ~, e] = lms_tanh(xin, y, mu, p, a);
    mse=mean(abs(e).^2);
    rp=10*log10(var(yhat)/var(e));
    fig=figure();
    plot(y);
    hold on;
    plot(yhat);
    title(sprintf('Zero mean: a=%d, MSE=%.3f, Rp=%.3f', a, mse, rp));
    legend('y[n]','$\hat y[n]$','Interpreter','Latex','Orientation','horizontal');
    ylim([-50 50]);
    grid on;
    %saveas(fig, sprintf('/Users/hzd88688126com/Desktop/USFD_Academic-_Report_LaTeX-Template/fig/4/43a%d.eps',i), "epsc");
end