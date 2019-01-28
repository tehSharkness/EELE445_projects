f = 0:.1:3;
T = 2;
V = 2*(sin(pi*f)./(pi*f)).^2;
V(1) = 0;

figure(1)
stem(f,V),xlabel('Frequency [Hz]'),ylabel('V(f) [V]'),title('Voltage Spectrum')

P_v = (abs(V)).^2./T;

figure(2)
stem(f,P_v),xlabel('Frequency [Hz]'),ylabel('P_v(f) [W/Hz]'),title('PSD')