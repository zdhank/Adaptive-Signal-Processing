clear all;
close all;
init;
%param
N=1000;
iter=100;
M=1:20;
b=[1 0 0.5];
t=1:N;
mu0=0.01;
v=normrnd(0,1,N,iter);
eta=filter(b,1,v);
x=sin(0.01*pi*t);
%init
for j=1:length(M)
    for delay=1:25
        x_hat=zeros(N,iter);
        for i=1:iter
            s=x'+eta(:,i);
            u=[zeros(M(j)+delay-1,1);s];
            [x_hat(:,i), ~, ~] = lms1(u, s, mu0, M(j));
            mse(j,delay,i)= mean((x' - x_hat(:, i)).^2);
        end
        mpse(j,delay)=mean(mse(j,delay,:),3);
    end
end
figure();
for j=1:length(M)
    if mod(j,5)==0
        plot(mpse(j,:),'DisplayName', sprintf('M=%d',M(j)))
        hold on;
    end
end
xlabel('M, order');
ylabel('MSPE');
title('Effect of order=M on MPSE');
legend('show','location', 'northwest');
ylim([0.2,0.9]);
grid on;
figure();
for i=[3,5,10,15]
    plot(mpse(:,i),'DisplayName', sprintf('\\Delta=%d',i))
    hold on;
end

xlabel('\Delta, delay');
ylabel('MSPE');
title('Effect of \Delta on MPSE');
legend('show','location', 'northwest');
ylim([0.25,0.6]);
grid on;
