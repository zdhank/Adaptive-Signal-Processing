function [y, w, e] = lms_tanh(xin, d, mu, order, a, b, w_init)
% LMS with activation function tanh adaptive filter.
%       - xin: design matrix, size(X)=[M N]
%       - d: target vector, size(d)=[N 1]
%       - mu: step size, scalar
%       - order: model order
%       - a(optional): scale activation function, scalar
%       - b(optional): with or without bias (defaul False), bool
%       - w_init(optional): scale actication function, size(w_init)=[order M]
%       * y: filter output, size(y)=[1 N]
%       * e: prediction error, d(n) - y(n)
%       * H: filter weights, size(W)=[M N]

    % sizes
    [N,~]=size(d);
    e=zeros(N,1);
    y=zeros(N,1);
    %init a
    if nargin<5
        a=1;w=zeros(order,N);
    end
    %init b
    if nargin<6
        b='off';w=zeros(order,N);
    end
    %bias on
    if nargin>=6 && strcmp(b,'on')
        w=zeros(order+1,N);
    end
    % initial weights
    if nargin==7
        [M,m]=size(w_init);
        w(1:M,1)=w_init(:,end);
    end
    % iterate over time
    for n=1:N
        % augment input if bias on
        if nargin>=6 && strcmp(b,'on')
            x=[1; xin(n+order-1:-1:n)];
        else
            x=xin(n+order-1:-1:n);
        end
        % filter output n, y(n)
        y(n) = a*tanh(w(:,n)' * x);
        % prediction error n, e(n)
        e(n) = d(n) - y(n);
        % weights update rule
        w(:, n+1) = w(:, n) + mu * e(n) * x;
    end
    w=w(:,2:end);
end