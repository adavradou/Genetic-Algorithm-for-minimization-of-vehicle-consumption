function [ out_pop  ] = tournamentselection(population, POPSIZE, NVARS) 

%**************************************************************************
% Description: Perform tournament selection without replacement and return
% the matingpool (index of winners of the tournament).

% @param tournsize is the tournament size (note that population size should
% be a multiplicant of the tournament size).
% @return winners is an array with the index of the individuals that won
% the tournaments.
%**************************************************************************

newpopulation = struct('gene', zeros(1, NVARS), 'fitness', 0, 'probability', 0,  'lower', zeros(1, NVARS), 'upper', zeros(1, NVARS));
tournsize=4;    %size of tournoua


for i=1:POPSIZE 
%Create a random set of competitors
    competitors = randperm(76,tournsize);   %Selects 4 random competitors out of 76
        
%The winner is the competitor with best fitness       
    mem=competitors;    %Initialize to mem in order to be able later to replace everything with min inside a for-loop.
    min=inf;
    for l=1:tournsize
        if population(mem(l)).fitness<min
            min=population(mem(l)).fitness; 
            pos=mem(l);
        end
    end
    newpopulation(i).gene=population(pos).gene;
    newpopulation(i).fitness=population(i).fitness;
    
end

 %Once a new population is created, copy it back
 for i=1:POPSIZE
    population(i)=newpopulation(i);
 end
 

    

out_pop=population;


end




