function [ out_pop ] = elitist(POPSIZE,population,NVARS)

%**************************************************************************
%Elitist function: The best member of the previous generation is stored as
%the last in the array. If the best member of the current generation is
%worse than the best member of the previous generation,  the latter one
%would replace the worst member of the current population
%**************************************************************************

best=population(1).fitness;    %best fitness values
worst=population(1).fitness;    %worst fitness values
% 
% for i=1:POPSIZE-1
%     if population(i).fitness<population(i+1).fitness
%         if population(i).fitness<=best
%             best=population(i).fitness;
%             best_mem=i;    %index of the best member
%         end
%         if population(i+1).fitness>=worst
%             worst=population(i+1).fitness;
%             worst_mem=i+1;    %index of the worst member
%         end
%     else
%         if population(i).fitness>=worst
%             worst=population(i).fitness;
%             worst_mem=i;
%         end
%         if population(i+1).fitness<=best
%             best=population(i+1).fitness;
%             best_mem=i+1;
%         end
%     end
% end



for i=2:POPSIZE
    if population(i).fitness<population(i-1).fitness
        if population(i).fitness<=best
            best=population(i).fitness;
            best_mem=i;    %index of the best member
        end
        if population(i-1).fitness>=worst
            worst=population(i-1).fitness;
            worst_mem=i-1;    %index of the worst member
        end
    else
        if population(i).fitness>=worst
            worst=population(i).fitness;
            worst_mem=i;
        end
        if population(i-1).fitness<=best
            best=population(i-1).fitness;
            best_mem=i-1;
        end
    end
end








%If the best individual from the new population is better than the best
%individual from the previous population, then copy the best from the new
%population; else replace te worst individual from the current population
%with the best one from the previous generation.

if best<=population(POPSIZE).fitness
    for i=1:NVARS
        population(POPSIZE).gene(i)=population(best_mem).gene(i);
        population(POPSIZE).fitness=population(best_mem).fitness;
    end
else
    for i=1:NVARS
        population(worst_mem).gene(i)=population(POPSIZE).gene(i);
        population(worst_mem).fitness=population(POPSIZE).fitness;
    end
end

out_pop=population;

end

