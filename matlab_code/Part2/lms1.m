function [y, w, e] = lms1(xin, d, mu, order)   
%       - xin: design matrix, size(X)=[M N]
%       - d: target vector, size(d)=[N 1]
%       - mu0: initial step size, scalar
%       - order: model order
%       * y: filter output, size(y)=[N 1]
%       * e: prediction error, d(n) - y(n)
%       * W: filter weights, size(W)=[M N]
    % sizes
    [N,~]=size(d);
    w=zeros(order,N);
    e=zeros(N,1);
    y=zeros(N,1);  
    % iterate over time
    for n=1:N
        % filter output n, y(n)
        y(n) = w(:, n)' * xin(n+order-1:-1:n);
        % prediction error n, e(n)
        e(n) = d(n) - y(n);
        % weights update rule
        w(:, n+1) = w(:, n) + mu * e(n) * xin(n+order-1:-1:n);
    end
    w=w(:,2:end);
end