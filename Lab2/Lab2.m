close all
clear all

n = 1:1:25;

c_n = .4*sin(.2*n*pi)./(.2*n*pi);
Vrms = 2*c_n/sqrt(2);

P_per = [.42.^2/sum(Vrms.^2)];

for a = 1:25
    P_per = [P_per sum(Vrms(1:a).^2)/sum(Vrms.^2)];
end

figure(1),stem([0 n], [.42 Vrms])

figure(2),plot([0 n], P_per)