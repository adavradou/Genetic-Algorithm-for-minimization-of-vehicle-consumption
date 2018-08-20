function [ out_pop ] = mutate(POPSIZE, NVARS, PMUTATION, population, gen_count, MAXGENS)

%**************************************************************************
%Mutation: RANDOM NON-UNIFORM MUTATION. A variable selected for mutation is
%replaced by a random value between lower and upper bounds of this
%variable.
%**************************************************************************


t=gen_count;
T=MAXGENS;
scale=0.6;
x=0;

for i=1:POPSIZE
    for j=1:NVARS
        x=0 + (1-0)*rand(55,1);  
        if x<PMUTATION
            %Find the bounds on the variable to be mutated
            lbound=population(i).lower(j);
            ubound=population(i).upper(j);
            r=0+(1-0)*rand(1,1);   
            
            if r<0.5
                population(i).gene(j)=population(i).gene(j)+(ubound-population(i).gene(j))*r*(1-t/T)*scale;
            else    
                population(i).gene(j)=population(i).gene(j)-(lbound-population(i).gene(j))*r*(1-t/T)*scale; 
            end        
                                       
        end
    end
end









%**********************************************************************************************************************************************************************************
%PALIO MUTATE: RANDOM UNIFORM MUTATION
%**********************************************************************************************************************************************************************************
% x=0;
% for i=1:POPSIZE
%     for j=1:NVARS
%         x=0 + (1-0)*rand(55,1);  
%         if x<PMUTATION
%             %find the bounds on the variable to be mutated
%             lbound=population(i).lower(j);
%             hbound=population(i).upper(j);
%             population(i).gene(j)=randval(NVARS, lbound, hbound, x);
%         end
%     end
% end

out_pop=population;

end

