close all
clear all

ff = 0:.01:7;

xx = [zeros(1,100*1.34) .588 zeros(1,100*(3.95-1.34)) .28 zeros(1,100*(6.8-3.95)) .144];

xx = [xx zeros(1,length(ff)-length(xx))];

stem(ff,xx)