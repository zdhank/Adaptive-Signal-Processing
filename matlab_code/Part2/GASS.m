function [y, w, e] = GASS(xin,d,order,mu0,mode,alpha,ro)
% GASS	Gradient Adaptive Step-Size (GASS) Least Mean Square (LMS) adaptive filter.
%       - xin: design matrix, size(X)=[M N]
%       - d: target vector, size(d)=[N 1]
%       - mu0: initial step size, scalar
%       - ro: learning rate, scalar
%       - order: model order
%       - mode: algorithm name, string from
%               {'benvenist', 'ang_farhang', 'matthews_xie'}
%       - alpha: Ang & Farhang learning parameter, scalar
%       * y: filter output, size(y)=[N 1]
%       * e: prediction error, d(n) - y(n)
%       * W: filter weights, size(W)=[M N]
%   [y, e, W] = GASS(X, d, mu_0, rho, gamma, algo, alpha) train Gass filter on Xd data.
[N,~]=size(d);
w=zeros(order,N);
e=zeros(N,1);
y=zeros(N,1);
mu=zeros(N,1);
mu(1)=mu0;
phi=zeros(order,N);
for n=1:N
    y(n)=w(:,n)'*xin(n+1:-1:n);
    e(n)=d(n)-y(n);
    w(:,n+1)=w(:,n)+mu(n)*e(n)*xin(n+1:-1:n);
    switch mode
        case 'Benbeniste'
            phi(:,n+1)=(eye(order)-mu(n)*xin(n+1:-1:n)*xin(n+1:-1:n)')*phi(:,n)+e(n)*xin(n+1:-1:n);
        case 'Ang&Farhang'
            phi(:,n+1)=alpha*phi(:,n)+e(n)*xin(n+1:-1:n);
        case 'Matthews&Xie'
            phi(:,n+1)=e(n)*xin(n+1:-1:n);
    end
    mu(n+1)=mu(n)+ro*e(n)*xin(n+1:-1:n)'*phi(:,n);
end
    w=w(:,2:end);
end

