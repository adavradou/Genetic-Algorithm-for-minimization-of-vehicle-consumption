function [ out_pop, distance ] = initialize(NVARS, POPSIZE, population)

%**************************************************************************
%Initialization function: Initializes the values of genes withins the
%variables bounds. It also initializes (to zero) all fitness values for
%each member of the population. It reads upper and lower bounds of each
%variable from the input file 'gadata.txt'. It randomly generates values
%between these bounds for each gene of each genotype in the population. The
%format of the input file 'gadata.txt' is
%var1_lower_bound var1_upper bound
%var2_lower_bound var2_upper bound ...
%**************************************************************************


%Initialize variables within the bounds.
%I give an upper and lower boundary. As an upper for the first seconds, I give the maximum
%acceleration that the vehicle is able to give and a "low" acceleration for the last seconds. 
%Then, inbetween I use as lower and upper values the 18 and 32 km respectively.
% 
% lbound=[0	0	3	8	10	12	12	12	12	12	12	12	18	18	18	18	18	18	18	18	18	18	18	18	18	18	18	18	18	18	18	18	18	18	18	18	18	18	18	18	18	18	18	18	18	18	18	18	18	18	18	20	12	6	0];
% ubound=[0	4	9	16	21	22	22	22	22	22	26	29	32	32	32	32	32	32	32	32	32	32	32	32	32	32	32	32	32	32	32	32	32	32	32	32	32	32	32	32	32	32	32	32	32	32	32	32	32	32	27	20	12	6	0];

lbound=[0	4	7	14	18	22	25	25	25	29	29	29	29	29	29	29	29	29	29	32	32	32	29	29	29	29	29	29	29	29	29	32	32	29	29	32	32	32	32	29	29	29	29	29	29	29	29	29	29	29	29	22	22	11	4];
ubound=[0	4	7	14	18	22	25	25	25	29	29	29	29	29	29	29	29	29	29	32	32	32	29	29	29	29	29	29	29	29	29	32	32	29	29	32	32	32	32	29	29	29	29	29	29	29	29	29	29	29	29	22	22	11	4];


x=zeros(1,55);
x(1)=0;

distance=0;

for i=1:POPSIZE
    for j=1:NVARS
         population(i).fitness=0;
         population(i).probability=0;     
         population(i).lower=lbound(j);
         population(i).upper=ubound(j);    
    end
    population(i).gene = randval(NVARS, lbound, ubound, x);
    
     l=population(i).gene;
     m=round(resample(l,4,1));  %Changes the sampling rate of a signal. Convert from 55 times to 220 (linear interpolation) that the model gets as input. 
     m(218)=0;
     m(219)=0;
     m(220)=0;
     y=m;
     distance=trapz(y)/3.6;  %Convert from km to m.
    
    
    while abs(distance-1626)>150    %Check that the initial velocity profile covers the desirable distance: 1626m.
        population(i).gene = randval(NVARS, lbound, ubound, x);
        l=population(i).gene;
        m=round(resample(l,4,1));
        m(218)=0;
        m(219)=0;
        m(220)=0;
        y=m;
        distance=trapz(y)/3.6;  
    end
    
    

end

disp(distance);

out_pop = population;

end

