clear all;
close all;
%param
N=1000;iter=100;
p=2;
b=[1 0.9];
sigma=0.5;
mu0=0.1; alpha=0.8;ro=0.01;
mode='Benbeniste';
%AR
wn=normrnd(0,sigma,N,iter);
x = filter(b, 1, wn);
%delay
xin =[zeros(p-1,iter);wn];
%initialize
w=zeros(p,N,iter,2);
e=zeros(N,iter,2);
%LMS
for j=1:2
    for i=1:iter
        if j==1
            %GASS
            [~, w(:,:,i,j), e(:,i,j)] = GASS(xin(:,i),x(:,i),p,mu0,string(mode),alpha,ro);
        else
            %GAND
            [~, w(:,:,i,j), e(:,i,j)] = GNGD(xin(:,i),x(:,i),mu0,p,ro);
        end
    end
end
error_w=squeeze(mean(w,3));
figure(1)
for i = 1:2
    plot(error_w(2,:,i))
    hold on;
end
legend('Benbeniste','GNGD','location','best')
title('Estimated Weight Curves (\mu=0.1)');
xlabel('N');
ylabel('Weights Error(w_0-w)');
xlim([0,100]);
grid on;
figure(2);
for i=1:2
    plot(pow2db(mean(e(:, :, i), 2).^2));
    hold on;
end
legend('Benbeniste','GNGD','location','best')
title('Squared Error Curves (\mu=0.1)');
xlabel('N');
ylabel('Squared Error');
xlim([0,500]);
grid on;



