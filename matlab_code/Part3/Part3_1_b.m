clear all;
close all;
init;
% init
N = 5000;
M = 1:25;
mu=[0.001 0.005 0.1];
mode={'High','Medium','Low'};
for l=1:3
    switch mode{l}
        case 'High'
            load data/wind-dataset/high-wind.mat;
        case 'Medium'
            load data/wind-dataset/medium-wind.mat;
        case 'Low'
            load data/wind-dataset/low-wind.mat;
    end
    v=v_east+1j*v_north;
    rho = abs(mean((v).^2)/mean(abs(v).^2));
    figure(l);
    scatter(real(v), imag(v), 25, COLORS(l, :), 'filled')
    title(sprintf('%s wind speed, \\rho=%.3f',mode{l},rho));
    xlabel('v_{east}');
    ylabel('v_{north}');
    grid on;
    
    %LMS
    e_clms=complex(zeros(N,length(M)));
    e_aclms=complex(zeros(N,length(M)));
    for i=1:length(M)
        xin=[zeros(M(i),1);v];
        [~,~,e_clms(:,i)] = clms(xin, v, mu(l), M(i));
        [~,~,~,e_aclms(:,i)] = aclms(xin, v, mu(l), M(i));
    end
    %learning curve
    figure(l+3);
    mpse_clms = pow2db(mean(abs(e_clms).^2));
    plot(M, mpse_clms, 'LineWidth', 2, 'Marker', '.', 'DisplayName', 'CLMS');
    hold on;
    mpse_aclms = pow2db(mean(abs(e_aclms).^2));
    plot(M, mpse_aclms, 'LineWidth', 2, 'Marker', '.', 'DisplayName', 'ACLMS');
    title(sprintf('%s wind : Learning Curves', mode{l}));
    xlabel('Model Order, M');
    ylabel('MPSE (dB)');
    grid on; 
    legend show;
end