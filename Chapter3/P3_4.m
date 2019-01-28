close all
clear all

A = 1;
f = 0:1:50000;
f1 = 2500;
f2 = 4000;

m = A/(f2-f1);

W = [ones(1,2501) zeros(1,length(f)-2501)];
for(a = 2502:1:4001);
    W(a) = W(a-1) - m;
end;

W = [fliplr(W(2:length(W))) W];
    
% figure(1),plot(-5000:1:5000,W)

fs = 10000;
tau = 50e-6;
Ts = 1/fs;
d = tau/Ts;

H = tau*sin(pi*tau*f)./(pi*tau*f);

H = [fliplr(H(2:length(H))) H];

Ws = zeros(1,length(H));


for(ff = 1:1:length(Ws));
    for(k = -5:1:5);
        if((ff-k*fs) > 0) && ((ff-k*fs) < length(Ws))
            Ws(ff) = Ws(ff) + W(ff-k*fs);
        end;
    end;
end;

Ws = 1/Ts.*H.*Ws;

figure(1)
subplot(3,1,1),plot([-length(W)/2:1:length(W)/2-1],abs(W)),ylabel('|W(f)|')
subplot(3,1,2),plot([-length(H)/2:1:length(W)/2-1],abs(H)),ylabel('|H(f)|')
subplot(3,1,3),plot([-length(Ws)/2:1:length(Ws)/2-1],abs(Ws)),ylabel('|Ws(f)|')