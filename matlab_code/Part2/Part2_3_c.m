clear all;
close all;
init;
%param
N=1000;
iter=100;
M=3;
b=[1 0 0.5];
t=1:N;
mu0=0.01;
%noise
v=normrnd(0,1,N,iter);
eta=filter(b,1,v);
%unkown relationship
epu = eta * 0.7 + 0.01;
x=sin(0.01*pi*t);
%init
eta_hat=zeros(N,iter);
xhat_anc=zeros(N,iter);
delay=3;
for i=1:iter
    s=x'+eta(:,i);
    %ANC
    u_anc=[zeros(M-1,1);epu(:,i)];
    [eta_hat(:,i), ~, ~] = lms1(u_anc, s, mu0, M);
    xhat_anc(:,i)=s-eta_hat(:,i);
    mse_anc(i)= mean((x' - xhat_anc(:, i)).^2);
    figure(1);
    plt1(1)=plot(s,'color',COLORS(1,:),'DisplayName', 's(n)');
    hold on;
    %ALE
    u_ale=[zeros(M+delay-1,1);s];
    [xhat_ale(:,i), w, ~] = lms1(u_ale, s, mu0, M);
    mse_ale(i)= mean((x' - xhat_ale(:, i)).^2);
    figure(2);
    plt(1)=plot(s,'color',COLORS(1,:),'DisplayName', 's(n)');
    hold on;
end
%MSPE
mspe_anc=mean(mse_anc);
mspe_ale=mean(mse_ale);
%plot
for i=1:iter
    figure(1)
    plt1(2)=plot(xhat_anc(:,i),'color',COLORS(3,:),'DisplayName', 'x\_hat(n)');
    figure(2)
    plt(2)=plot(xhat_ale(:,i),'color',COLORS(3,:),'DisplayName', 'x\_hat(n)');
end
figure(1)
plt1(3)=plot(x,'y','color',COLORS(2,:),'DisplayName', 'x(n)');
title(sprintf('ANC: M=%d, MSPE=%0.4f',M,mspe_anc));
xlabel('N');
lgd = legend(plt1);
lgd.NumColumns = length(plt1);
grid on;
ylim([-5 5]);

figure(2)
plt(3)=plot(x,'color',COLORS(2,:),'DisplayName', 'x(n)');
title(sprintf('ALE: delay=%d, M=%d, MSPE=%0.4f',delay,M,mspe_ale));
xlabel('N');
lgd = legend(plt);
lgd.NumColumns = length(plt);
grid on;
ylim([-5 5]);
%plt mean
figure(3);
plot(mean(xhat_anc,2));
hold on;
plot(mean(xhat_ale,2));
plot(x,'color',COLORS(3,:));
title(sprintf('ANC and ALE: Average x(n)'));
xlabel('N');
legend('ANC','ALE','x(n)','orientation','horizontal');
grid on;
