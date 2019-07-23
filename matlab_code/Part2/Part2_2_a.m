clear all;
close all;
%param
N=1000;
iter=100;
p=2;
b=[1 0.9];
sigma=0.5;
w0=0.9;
alpha=0.8; ro=0.005;
mode={'Benbeniste','Ang&Farhang','Matthews&Xie'};
%AR
wn=normrnd(0,sigma,N,iter);
x = filter(b, 1, wn);
%delay
xin =[zeros(p-1,iter);wn];
%initialize
w=zeros(p,N,iter,length(mode)+1);
e=zeros(N,iter,length(mode)+1);
%LMS
for mu0=[0.01, 0.1]
    for j=1:4
        for i=1:iter
            if j==1
                %LMS
                [~, w(:,:,i,j), e(:,i,j)] = lms1(xin(:,i),x(:,i),mu0,p);
            else
                %GASS
                [~, w(:,:,i,j), e(:,i,j)] = GASS(xin(:,i),x(:,i),p,mu0,string(mode{j-1}),alpha,ro);
            end
        end
    end
    error_w=squeeze(b'-mean(w,3));
    figure()
    for i = 1:4
        plot(error_w(2,:,i))
        hold on;
    end
    legend(sprintf('\\mu=%.2f',mu0),'Benbeniste','Ang&Farhang','Matthews&Xie');
    title('Weight Error Curves');
    xlabel('N');
    ylabel('Weights Error(w_0-w)');
    xlim([0,250]);
    grid on;
    figure();
    for i=1:4
        plot(pow2db(mean(e(:, :, i), 2).^2));
        hold on;
    end
    legend(sprintf('\\mu=%.2f',mu0),'Benbeniste','Ang&Farhang','Matthews&Xie','location','southwest')
    title('Squared Error Curves');
    xlabel('N');
    ylabel('Squared Error');
    xlim([0,N]);
    grid on;
end


