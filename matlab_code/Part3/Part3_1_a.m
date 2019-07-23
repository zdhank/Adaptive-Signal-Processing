clear all;
close all;
init;
%param
N=1000;
iter=100;
sigma=1;
mu=0.1;
M = 2;
b = [1.5+1i, 2.5-0.5i];
%WLMA
wn = randn(N,iter)+1j*randn(N,iter); %wgn(N,iter,pow2db(sigma), 'complex');
y=WLMA(b,1,wn);
xin=[zeros(M-1,iter);wn];
%init matrix
e_clms=complex(zeros(N,iter));
e_aclms=complex(zeros(N,iter));
for i=1:iter
    [~,~,e_clms(:,i)] = clms(xin(:,i), y(:,i), mu, M);
    [~,~,~,e_aclms(:,i)] = aclms(xin(:,i), y(:,i), mu, M);
end
%scatter plot
figure(1);
scatter(real(y(:,1)), imag(y(:,1)), 25, 'filled', 'DisplayName', 'WLMA(1)')
hold on
scatter(real(wn(:,1)), imag(wn(:,1)), 25, 'filled', 'DisplayName', 'WGN')
title('Circularity of WLMA Prcess');
xlabel('Real Part');
ylabel('Imaginary Part');
legend('show', 'location', 'northwest');
grid on; 
axis([-10 10 -6 6]);
%learning curve
figure(2);
plot(pow2db(mean(abs(e_clms).^2, 2)), 'DisplayName', 'CLMS');
hold on
plot(pow2db(mean(abs(e_aclms).^2, 2)), 'DisplayName', 'ACLMS');
title('Learning Curves for CLMS and ACLMS');
xlabel('N');
ylabel('Squared Error (dB)');
legend show;
grid on;
ylim([-350 120]);
function y=WLMA(b,a,x)
    [N,M] = size(x);
    y = zeros(N, M);
    x = [zeros(1,M); x];
    for j=1:M
        for i=1:N
            y(i,j) = a * x(i+1,j) + b(1) * x(i,j) + b(2) * conj(x(i,j));
        end
    end
end