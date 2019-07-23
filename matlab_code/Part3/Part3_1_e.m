clear all;
close all;
init;
% init
fs=5000;
f0=50;
N=2000;
t = 1:N;
M=1; 
%clark matrix
C = sqrt(2/3)*[sqrt(2)/2 sqrt(2)/2 sqrt(2)/2; 1 -1/2 -1/2; 0 sqrt(3)/2 -sqrt(3)/2];
%% Balanced
%voltage init
%voltage
mu=0.04;
Va=1; Vb=1; Vc=1;
V=[Va; Vb; Vc];
%phase
delta_a=0; delta_b=0; delta_c=0;
delta=[delta_a; delta_b; delta_c];
%v
phi=[0; -2*pi/3; 2*pi/3];
v=V.*cos(2*pi*f0/fs*t+delta+phi);
clark_v=C*v;
clark_v=(clark_v(2,:)+1j*clark_v(3,:)).';
rho = abs(mean((clark_v).^2)/mean(abs(clark_v).^2));
%CLMS & ACLMS
xin=[zeros(M,1);clark_v];
[~,h_clms,e_clms] = clms(xin, clark_v, mu, M);
[~,h_aclms,g_aclms,e_aclms] = aclms(xin, clark_v, mu, M);
%estimate f0
f0_clms=-fs/(2*pi)*atan(imag(h_clms)./real(h_clms) );
f0_aclms=abs(fs/(2*pi)*atan(sqrt(imag(h_aclms).^2-abs(g_aclms).^2)./real(h_aclms)));
%plot error
figure();
plot(pow2db(abs(e_clms).^2), 'DisplayName', 'CLMS')
hold on
plot(pow2db(abs(e_aclms).^2), 'DisplayName', 'ACLMS')
title('Balanced: Learning Curves');
xlabel('N');
ylabel('Squared Error (dB)');
legend show;
grid on;
%frequency estimation
figure();
plot(f0_clms, 'DisplayName', 'CLMS')
hold on;
plot(abs(f0_aclms), 'DisplayName', 'ACLMS')
hold on
plot([0 N], [50 50], 'DisplayName', '50Hz', 'LineStyle', '-.', 'Color', 'black');
title('Balanced: Frequency Estimation');
xlabel('N');
ylabel('Frequency, f_o');
legend show
axis([0 1500 0 150]);
grid on;
%% Unbalanced
%voltage init
%voltage
mu=0.03;
Va=0.5; Vb=1.5; Vc=1;
V=[Va; Vb; Vc];
%phase
delta_a=0; delta_b=0.5; delta_c=0.2;
delta=[delta_a; delta_b; delta_c];
%v
phi=[0; -2*pi/3; 2*pi/3];
v=V.*cos(2*pi*f0/fs*t+delta+phi);
clark_v=C*v;
clark_v=(clark_v(2,:)+1j*clark_v(3,:)).';
rho = abs(mean((clark_v).^2)/mean(abs(clark_v).^2));
%CLMS & ACLMS
xin=[zeros(M,1);clark_v];
[~,h_clms,e_clms] = clms(xin, clark_v, mu, M);
[~,h_aclms,g_aclms,e_aclms] = aclms(xin, clark_v, mu, M);
%estimate f0
f0_clms=-fs/(2*pi)*atan(imag(h_clms)./real(h_clms) );
f0_aclms=abs(fs/(2*pi)*atan(sqrt(imag(h_aclms).^2-abs(g_aclms).^2)./real(h_aclms)));
%plot error
figure();
plot(pow2db(abs(e_clms).^2), 'DisplayName', 'CLMS')
hold on
plot(pow2db(abs(e_aclms).^2), 'DisplayName', 'ACLMS')
title('Unbalanced: Learning Curves');
xlabel('N');
ylabel('Squared Error (dB)');
legend show;
grid on;
%frequency estimation
figure();
plot(f0_clms, 'DisplayName', 'CLMS')
hold on;
plot(f0_aclms, 'DisplayName', 'ACLMS')
hold on
plot([0 N], [50 50], 'DisplayName', '50Hz', 'LineStyle', '-.', 'Color', 'black');
title('Unbalanced: Frequency Estimation');
xlabel('N');
ylabel('Frequency, f_o');
legend show
axis([0 1500 0 150]);
grid on;