function [ out_pop ] = evaluate(POPSIZE,NVARS,population, mem, power, distance)

%**************************************************************************
%Evaluation function: This takes a user defined function. Each time this is
%changed, the code has to be recompiled. The current function is our
%simulink model.
%**************************************************************************


distance=0; %The distance covered by the vehicle.
difdistance=0;  %The difference between the desirable distance (1626m) and the one that this population/velocity profile covers. 

l=population(mem).gene;
m=round(resample(l,4,1));   %Changes the sampling rate of a signal. Convert from 55 times to 220 (linear interpolation) that the model gets as input. 
m(218)=0;
m(219)=0;
m(220)=0;
y=m;
distance=trapz(y)/3.6;    %Convert from km to m.
difdistance=1626-distance;

[population(mem).fitness]=mean(power)+(0.2*difdistance);    %We have penalty fitness, which means that if the population/velocity profile does not cover the desirable distance, we add, depending on the difference, a number to the function.



out_pop=population;


end

