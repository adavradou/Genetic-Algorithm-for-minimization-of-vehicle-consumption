function [ out_pop ] = keep_the_best(population, POPSIZE, NVARS)

%**************************************************************************
%Keep_the_best_function: This function keeps track of the best member of
%the population. Note that the last entry in the array Population holds a
%copy of the best individual.
%**************************************************************************

cur_best=1;    %stores the index of the best individual

for mem=1:POPSIZE
    if population(mem).fitness<population(POPSIZE).fitness
        cur_best=mem;
        population(POPSIZE).fitness=population(mem).fitness; 
        for i=1:NVARS
            population(POPSIZE).gene(i)=population(cur_best).gene(i);
        end
    end
end



out_pop=population;

end

