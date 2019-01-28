close all
clear all

tt = [0:.1:10000];

f_m = 1e3;
f_c = 12e3;

m = 2*cos(2*pi*f_m*tt);
c = 2*cos(w*pi*f_c*tt);

s = m.*c;

S = fft(s);
