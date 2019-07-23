clear all; close all;
init;
load time-series.mat;
p=4;
N=length(y);
epoch=100;
mu=1*10^-5;
xin=[zeros(p,1); y];
a=50;
b={'off' 'on'};
figure();
for j=1:length(b)
    w_init=zeros(p,N);
    yhat=[];w=[];e=[];
    for i=1:epoch
        [yhat(:,i), w(:,:,i), e(:,i)] = lms_tanh(xin, y, mu, p, a, b{j}, w_init);
        w_init=w(:,:,i);
    end
    mse=pow2db(mean(abs(e).^2));
    plot(mse,'DisplayName',sprintf('bias %s',b{j}));
    hold on;
end
title('Mean Squared Error of with/without bias');
ylabel('MSE (dB)');
xlabel('Epoch');
legend show;
grid on;

figure();
mse=pow2db(mean(abs(e(:,end)).^2));
rp=10*log10(var(yhat(:,epoch))/var(e(:,end)));
plot(y);
hold on;
plot(yhat(:,epoch));
plot([0 N],[mean(yhat(:,epoch)) mean(yhat(:,epoch))]);
title(sprintf('None-zero mean time-series\n a=%d, MSE=%.3f, Rp=%.3f', a, mse, rp'));
legend('y[n]','$\hat y[n]$','$\mathit{E}\{\hat y[n]\}$','Interpreter','Latex','Orientation','horizontal');
grid on;