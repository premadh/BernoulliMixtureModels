function manyfigures
% Main program which will call the plotLkhood for resolution to draw the plots
% This code is in the public domain. 
%
% (c) Prem Raj Adhikari
%     www.premraj.me
%     August, 2010

clc;
clear;
%chromo = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21];
chromo = [17 18]; # Chromosomes to plot
res =[393 850];   # Resolutions to plot
k=1;
for j=1:2
    for i=1:size(chromo, 2)
        chr=chromo(1,i);
        plotLkhood(chr,res(1,j),k); # Call the plotting function
        k=k+1;
    end    
end
end
