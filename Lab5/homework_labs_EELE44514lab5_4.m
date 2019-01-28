% file for EELE445 Lab 5 data import and analysis
%  last edit date:2/09/12avo

%Note to Students, modify this program as you see fit to the data looking
%like you want.  example: you could add a section of code to estimate the
%number of effective bits based on the SQNR you measure...



%************ read in the data file in csv format
echo off
clc
% filename = input('data file name ?','s'); %prompt for input file--  must
% %be in the matlab search path

filename = 'EELE445lab5data4.csv'; %input your data file name here
data = csvread(filename); %create data matrix- (time,voltage)
tdata = data(:,1);
Vdata = data(:,2);

% tdata = 0:.001:9.999;  %alternate time vector
% y = 1*cos(2*pi*10*tdata);  %alternate signal vector
% Vnoise = 10^0  %rms noise is the std dev
% Vdata = Vnoise*randn(size(tdata)) + y ;  %noisy signal, 

ts =(tdata(length(tdata))-tdata(1))/length(tdata);  %find the sample time
fs = 1/ts;   % sample frequency
t = 0:ts:ts*(length(tdata)-1);  %set up time vector
N = length(tdata);   %length for the FFT
Fdata = fft(Vdata)/N;  %FFT of the waveform normalized
f =[0:fs/(length(Fdata)-1):fs]-fs/2;%frequency vector for FFT with fftshift
df = fs/N;  %Resolution bandwidth or cell size of the FFT

%find the minimum non-zero step change in Vdata
min_search = abs(diff(Vdata));
min_search(min_search==0) = Inf;
dV = min(min_search);
Vrange = dV*512;

Ptime = var(Vdata); %Total power of waveform-
Pfft = sum(abs(Fdata).^2); %should be same as Ptime
  %Pnoise assumes white noise and no signal from 1000 to 6000 points
% Pnoise = sum(abs(Fdata(1000:6000).^2))*length(Fdata)/5000 ; 
% SQNR = 10*log10((Pfft-Pnoise)/Pnoise);
Vdc = mean(Vdata);  %dc voltage of waveform
Vrms = std(Vdata);  % Rms voltage of waveform, or use sqrt(Ptime)
Vpp = max(Vdata) - min(Vdata);
Pac = Ptime - Vdc^2;  %mean squared value - squared mean value

%calculate dynamic range
Vnoise = .0037457;
Pnoise = Vnoise^2;
SNQR_max = 20*log((Vrange/2)/Vnoise);

clf
figure(1)
plot(t,Vdata);
xlabel('Time');
% title({' time waveform';['Total power = ',num2str(Ptime)];...
%     ['DC Voltage = ',num2str(Vdc)];['RMS Voltage = ',num2str(Vrms)];...
%     ['Vp-p = ',num2str(Vpp)]});

title({' time waveform';['Total power = ',num2str(Ptime),' W'];...
    ['DC Voltage = ',num2str(Vdc),' V'];['\sigma = ',num2str(Vrms),' V_{rms}'];...
    ['V_{p-p} = ',num2str(Vpp),' V_{p-p}']});
figure(2)
plot(f,fftshift(abs(Fdata).^2));

xlabel('Frequency Hz');
ylabel(['Watts per ',num2str(df),' Hz RBW']); %
title({['FFT of time waveform  ',filename];['Total power = ',num2str(Pfft),' W'];...
    ['Noise power = ',num2str(Pnoise),' W'];['SQNR = ',num2str(SNQR_max),' dB']});

figure(3)
subplot(2,1,1)
plot(f,fftshift(20*log(abs(Fdata))));
xlabel('Frequency')
ylabel(['dBVolts peak per ',num2str(df),' Hz RBW']);
title('Log Magnitude-Spectrum ')
% pause % Press akey to see the plot of the Fourier Transform derived numerically.
subplot(2,1,2)
plot((Vdata(1000:1100)));
hold on;
stem(abs(diff(Vdata(1000:1100))))   %(1000:1100))))
hold off;
xlabel('point')
ylabel('Voltage step size ')
title({['Quantization step size using "diff"'];['\DeltaV = ',num2str(dV),' V'];...
    ['Vrange = ',num2str(Vrange),' V']})
