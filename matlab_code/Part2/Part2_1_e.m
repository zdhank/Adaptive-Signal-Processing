clear all;
close all;init;
%param
N=1000;
iter=100;
mu=[0.01,0.05];
p=2;
a=[0.1,0.8];
sigma=0.25;
%AR process
x=filter(1,[1 -a], sqrt(sigma)*randn(N,iter));
%delay
xin=[zeros(p,iter);x];
%initialize
w=zeros(p,N,iter,length(mu));
e=zeros(N,iter,length(mu));
y=zeros(N,iter,length(mu));
%LMS
for gamma=[0.2 0.4 0.6]
    for j=1:length(mu)
        for i=1:iter
            for n=1:N
                y(n,i,j)=w(:,n,i,j).'*xin(n:n+1,i);
                e(n,i,j)=x(n,i)-y(n,i,j);
                w(:,n+1,i,j)=(1-mu(j)*gamma)*w(:,n,i,j)+mu(j)*e(n,i,j)*xin(n:n+1,i);
            end
        end
    end
    
    a2=reshape(mean(w(1,:,:,:),3),[1001,2]);
    a1=reshape(mean(w(2,:,:,:),3),[1001,2]);
    figure();
    plot([1,N],[0.1,0.1],'--','DisplayName','a_1','linewidth',2);
    hold on;
    plot(a1(:,1),'DisplayName','a_1 \mu=0.01','linewidth',2);
    plot(a1(:,2),'DisplayName','a_1 \mu=0.05','linewidth',2);
    
    plot([1,N],[0.8,0.8],'--','DisplayName','a_2','linewidth',2);
    plot(a2(:,1),'DisplayName','a_2 \mu=0.01','linewidth',2);
    plot(a2(:,2),'DisplayName','a_2 \mu=0.05','linewidth',2);
    ylim([0,0.9]);
    xlim([0,N]);
    lgd=legend('Location', 'best','Orientation','horizontal');
    lgd.NumColumns=3;
    title(['Leagky LMS: \gamma= ',num2str(gamma)]);
    xlabel('N');
    ylabel('Weights');
    grid on;
end