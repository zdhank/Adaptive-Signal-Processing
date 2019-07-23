function [y, h, e] = clms(xin, d, mu, order) 
% CLMS	Complex Least Mean Square (CLMS) adaptive filter.
%       - xin: design matrix, size(X)=[M N]
%       - d: target vector, size(d)=[N 1]
%       - mu: step size, scalar
%       - order: model order
%       * y: filter output, size(y)=[N 1]
%       * e: prediction error, d(n) - y(n)
%       * h: filter weights, size(W)=[order N]

    % sizes
    [N,~]=size(d);
    h=complex(zeros(order,N));
    e=complex(zeros(N,1));
    y=complex(zeros(N,1));  
    % iterate over time
    for n=1:N
        % filter output n, y(n)
        y(n) = h(:, n)' * xin(n+order-1:-1:n);
        % prediction error n, e(n)
        e(n) = d(n) - y(n);
        % weights update rule (leaky)
        h(:, n+1) = h(:, n) + mu * conj(e(n)) * xin(n+order-1:-1:n);
    end
    
end