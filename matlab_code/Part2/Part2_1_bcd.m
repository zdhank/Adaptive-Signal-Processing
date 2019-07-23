clear all;
close all;
init;
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
for j=1:length(mu)
    %lms
    for i=1:iter
        [~, w(:,:,i,j), e(:,i,j)] = lms1(xin(:,i),x(:,i),mu(j),p);
    end
    %plot
    figure(1);
    plot(pow2db(e(:, 100,j).^2), 'DisplayName', sprintf('u=%.2f', mu(j)));
    hold on;
    figure(2);
    plot(pow2db(mean(e(:, :,j).^2, 2)), 'DisplayName', sprintf('u=%.2f', mu(j)));
    hold on;
end
figure(1);
title('LMS Error with differet steps');
xlabel('N');
ylabel('Error (dB)');
axis([0 1000 -70 30]);
legend('show');
grid on;

figure(2);
title(sprintf('Learning curve: %d Realisations', iter));
xlabel('N');
ylabel('Error (dB)');
axis([0 1000 -10 0]);
legend('show');
grid on;
%%
t=400;
ense=mean(mean(e(t:end, :,:).^2, 2))-sigma;
Mems=ense./sigma
%%
a2=reshape(mean(w(1,:,:,:),3),[N,2]);
a1=reshape(mean(w(2,:,:,:),3),[N,2]);
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
title(sprintf('LMS: Estimated weights'));
xlabel('N');
ylabel('Weights');
grid on;