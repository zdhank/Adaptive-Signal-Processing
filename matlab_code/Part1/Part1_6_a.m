clear all;
close all;
init;
load data/PCR/PCAPCR.mat
s=svd(X);
s_noise=svd(Xnoise);
figure();
stem([s_noise,s]);
title('Sigular values of X, Xnoise');
legend('Xnoise','X');
error=(s-s_noise).^2;
figure();
stem(error);
title('Square error');
