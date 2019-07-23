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
v=normrnd(0,1,N,iter);
eta=filter(b,1,v);
x=sin(0.01*pi*t);
%init
for delay=1:4
    x_hat=zeros(N,iter);
    figure();
    for i=1:iter
        s=x'+eta(:,i);
        u=[zeros(M+delay-1,1);s];
        [x_hat(:,i), w, ~] = lms1(u, s, mu0, M);
        plt(1)=plot(s,'color',COLORS(1,:),'DisplayName', 's(n)');
        hold on;
    end
    for i=1:iter
        plt(2)=plot(x_hat(:,i),'color',COLORS(3,:),'DisplayName', 'x\_hat(n)');
    end
    plt(3)=plot(x,'y','color',COLORS(2,:),'DisplayName', 'x(n)');
    title(sprintf('ALE: %d Realisations, \\Delta=%d and M=%d', iter, delay, M));
    xlabel('N');
    lgd = legend(plt);
    lgd.NumColumns = length(plt);
    grid on;
    ylim([-5 5]);
    figure();
    plot(mean(x_hat,2));
    title(sprintf('Average with \\Delta=%d', delay));
    xlabel('N');
    ylim([-1 1]);
    grid on;
end
