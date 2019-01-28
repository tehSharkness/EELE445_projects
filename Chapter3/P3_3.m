close all
clear all

A = 1;
f = 0:1:5000;
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

n = 1:1:5;

cn = [1/Ts*tau d*sin(n*pi*d)./(n*pi*d)];

ff = 0:1:50000;

S = zeros(1,length(ff));

for(a = 0:1:50000);
    for(b = 0:1:5);
        if(a-b*fs) == 0
            S(a+1) = S(a+1) + cn(b+1);
        end;
    end;
end;

S = [fliplr(S(2:length(S))) S];

% figure(1),stem(S)

Ws = conv(W,S);

figure(1)
subplot(3,1,1),plot([-length(W)/2:1:length(W)/2-1],abs(W)),ylabel('|W(f)|')
subplot(3,1,2),stem([-length(S)/2:1:length(S)/2-1],abs(S)),ylabel('|S(f)|')
subplot(3,1,3),plot([-length(Ws)/2:1:length(Ws)/2-1],abs(Ws)),ylabel('|Ws(f)|')