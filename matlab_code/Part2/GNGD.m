function [y, w, e] = GNGD(xin, d, mu, order, ro)   
%       - xin: design matrix, size(X)=[M N]
%       - d: target vector, size(d)=[N 1]
%       - mu: initial step size, scalar
%       - ro: learning rate, scalar
%       - order: model order
%       * y: filter output, size(y)=[N 1]
%       * e: prediction error, d(n) - y(n)
%       * W: filter weights, size(W)=[M N]
    % sizes
    [N,~]=size(d);
    w=zeros(order,N);
    e=zeros(N,1);
    y=zeros(N,1); 
    epu=ones(N,1);
    % iterate over time
    for n=1:N
        % filter output n, y(n)
        y(n) = w(:, n)' * xin(n+1:-1:n);
        % prediction error n, e(n)
        e(n) = d(n) - y(n);
        % weights update rule
        w(:, n+1) = w(:, n) + (1/(epu(n)+xin(n+1:-1:n)'*xin(n+1:-1:n))) * e(n) * xin(n+1:-1:n);
        if n>1
            epu(n+1)=epu(n)-ro*mu*e(n)*e(n-1)*xin(n+1:-1:n)'*xin(n:-1:n-1)/(epu(n-1)+norm(xin(n:-1:n-1))^2)^2;
        end
    end
    w=w(:,2:end);
end