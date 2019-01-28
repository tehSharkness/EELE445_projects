close all
clear all
% 
% Fs = 100;
% 
% f = 0:.2:20;
% 
% H = 1-exp(-j*2*pi*f*.1);
% 
% figure(1)
% stem(f,abs(H)),xlabel('Frequency [Hz]'),ylabel('|H(f)|')
% 
% tt = -2:1/Fs:2;
% 
% x = [zeros(1,Fs), ones(1,2*Fs), zeros(1,Fs), 0];
% 
% a = [1 0];
% b = [1 zeros(1,Fs/10) -1];
% 
% y = filter(b,a,x);
% 
% Y_f = fft(y);
% 
% figure(2)
% plot([Fs:Fs:Fs*length(Y_f)],abs(Y_f))

Td = .1;

fs = 100;                             % Number of samples per second
t = -2:1/fs:2;                          % Time vector
x = rectpuls(t,1);                 % Generating rectangular pulse 
figure(1),plot(t,x), axis([-2 2 -0.2 1.2])   % Plotting the pulse

bb = zeros(1,fs*Td);
bb(1) = 1;
bb(length(bb)) = -1;

y = filter(bb,[1],x);

figure(2),plot(t,y), axis([-2 2 -1.2 1.2])

figure(3),freqz(bb,100,fs)

H = fft(y)./fft(x);

figure(4),plot(abs(H))
figure(5),plot(20*log10(abs(H)))

ww = 0:pi/16:2*pi/.1;

H = 1-exp(-j*ww*.1);

figure(6),plot(ww,abs(H))