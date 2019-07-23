clear all;
close all;
init;
% init
fs=5000;
f0=50;
N=2000;
t = 1:N;
%clark matrix
C =sqrt(2/3)*[sqrt(2)/2 sqrt(2)/2 sqrt(2)/2; 1 -1/2 -1/2; 0 sqrt(3)/2 -sqrt(3)/2];
%% Balanced
%voltage init
%voltage
Va=1; Vb=1; Vc=1;
V=[Va; Vb; Vc];
%phase
delta_a=0; delta_b=0; delta_c=0;
delta=[delta_a; delta_b; delta_c];
%v
phi=[0; -2*pi/3; 2*pi/3];
v=V.*cos(2*pi*f0/fs*t+delta+phi);
clark_v=C*v;
clark_v=clark_v(2,:)+1j*clark_v(3,:);
rho = abs(mean((clark_v).^2)/mean(abs(clark_v).^2));
%plot
figure();
scatter(real(clark_v), imag(clark_v), 25, 'filled')
title(sprintf('Balanced System, \\rho=%.3f',rho));
xlabel('Real Part, \Re');
ylabel('Imaginary Part, \Im');
axis([-2 2 -2 2]);
grid on;
%% Unbalanced
%voltage init
%voltage
Va=0.5; Vb=1.5; Vc=1;
V=[Va; Vb; Vc];
%phase
delta_a=0; delta_b=0.5; delta_c=0.2;
delta=[delta_a; delta_b; delta_c];
%v
phi=[0; -2*pi/3; 2*pi/3];
v=V.*cos(2*pi*f0/fs*t+delta+phi);
clark_v=C*v;
clark_v=clark_v(2,:)+1j*clark_v(3,:);
rho = abs(mean((clark_v).^2)/mean(abs(clark_v).^2));
%plot
figure();
scatter(real(clark_v), imag(clark_v), 25, 'filled')
title(sprintf('Unbalanced System, \\rho=%.3f\nV_a=0.5 V_b=1.5 \\Delta_b=0.5 \\Delta_c=0.2',rho));
xlabel('Real Part, \Re');
ylabel('Imaginary Part, \Im');
axis([-2 2 -2 2]);
grid on;
%% Unbalanced phase
%voltage init
%voltage
Va=1; Vb=1; Vc=1;
V=[Va; Vb; Vc];
%phase
delta_b=[pi/2 pi/4 pi/6]; delta_c=[pi/3 pi/6 pi/9];
figure();
for i=1:length(delta_c)
    delta=[0; delta_b(i); delta_c(i)];
    %v
    phi=[0; -2*pi/3; 2*pi/3];
    v=V.*cos(2*pi*f0/fs*t+delta+phi);
    clark_v=C*v;
    clark_v=clark_v(2,:)+1j*clark_v(3,:);
    rho = abs(mean((clark_v).^2)/mean(abs(clark_v).^2));
    %plot
    scatter(real(clark_v), imag(clark_v), 30, 'filled')
    hold on;
    title(sprintf('Unbalanced System: Phase distortion'));
    xlabel('Real Part, \Re');
    ylabel('Imaginary Part, \Im');
    axis([-2 2 -2 2]);
    grid on;
end
legend('\Delta_b=\pi/2 \Delta_c=\pi/3', '\Delta_b=\pi/4 \Delta_c=\pi/6', '\Delta_b=\pi/6 \Delta_c=\pi/9','FontSize',14,'Location','northwest');
%% Unbalanced Voltage
%voltage init
%voltage
Va=1.2:0.2:1.8; Vb=1; Vc=0.2:0.2:0.8;
%phase
delta_b=0; delta_c=0;
delta=[0; delta_b; delta_c];
figure();
for i=1:length(Va)
    V=[Va(i); Vb; Vc(i)];
    %v
    phi=[0; -2*pi/3; 2*pi/3];
    v=V.*cos(2*pi*f0/fs*t+delta+phi);
    clark_v=C*v;
    clark_v=clark_v(2,:)+1j*clark_v(3,:);
    rho = abs(mean((clark_v).^2)/mean(abs(clark_v).^2));
    %plot
    scatter(real(clark_v), imag(clark_v), 30, 'filled', 'DisplayName', sprintf('V_a = %.1f V_c = %.1f', Va(i),Vc(i)))
    hold on;
    title(sprintf('Unbalanced System: Magnitude distortion'));
    xlabel('Real Part, \Re');
    ylabel('Imaginary Part, \Im');
    axis([-2 2 -2 2]);
    grid on;
    lgd=legend ('show','FontSize',14,'Location','northwest');
    lgd.NumColumns=2;
end