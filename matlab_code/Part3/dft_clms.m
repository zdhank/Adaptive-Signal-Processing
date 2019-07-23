function [y, h, e] = dft_clms(xin, d, mu, gamma) 
% CLMS	Complex Least Mean Square (CLMS) adaptive filter.
%       - X: design matrix, size(X)=[N 1]
%       - d: target vector, size(d)=[N 1]
%       - mu: step size, scalar
%       * y: filter output, size(y)=[N 1]
%       * e: prediction error, d(n) - y(n)
%       * h: filter weights, size(W)=[order N]
    
    % sizes
    [K,N]=size(xin);
    h=complex(zeros(K,N));
    e=complex(zeros(N,1));
    y=complex(zeros(N,1));  
    % iterate over time
    for n=1:N
        % filter output n, y(n)
        y(n) = h(:, n)' * xin(:, n);
        % prediction error n, e(n)
        e(n) = d(n) - y(n);
        % weights update rule (leaky)
        h(:, n+1) = (1-gamma*mu)*h(:, n) + mu * conj(e(n)) * xin(:, n);
    end
    h=h(:,2:end);
end