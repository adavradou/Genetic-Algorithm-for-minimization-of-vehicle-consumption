function [ out_pop ] = crossover(POPSIZE, NVARS, PXOVER, population)
%**************************************************************************
%Crossover selection: selects two parts that take part in the crossover.
%Implements a HEURISTIC CROSSOVER.   +XOVER+SWAP
%**************************************************************************


X=zeros(1,NVARS);
Y=zeros(1,NVARS);
Xf=0;
Yf=0;

newpopulation = struct('gene', zeros(1, NVARS), 'fitness', 0, 'probability', 0,  'lower', zeros(1, NVARS), 'upper', zeros(1, NVARS));


for mem=1:POPSIZE
    x=0+(1-0)*rand(1,1);
    if x<PXOVER
        rand1=randi(76,1,1);    %Select randomly the 1st parent 
        rand2=randi(76,1,1);   %Select randomly the 2nd parent 
%         while rand1==rand2
%             rand2=randi(76,1,1);    %Check that there are two different parents.
%         end      
        if population(rand1).fitness<=population(rand2).fitness     %Check that the parent with the better (lower) fitness is X variable.
            X=population(rand1).gene;
            Xf=population(rand1).fitness;
            Y=population(rand2).gene;
            Yf=population(rand2).fitness;
        elseif population(rand2).fitness<=population(rand1).fitness
            X=population(rand2).gene;
            Xf=population(rand2).fitness;
            Y=population(rand1).gene;
            Yf=population(rand1).fitness;
        end
        
        p=Yf/(Yf+Xf);     %The probability of X, if e.g. f1<f2 will be:   f2/(f1+f2)
        for i=1:NVARS
            r=0+(1-0)*rand(1,1);
          
            if r<p    %The p will be higher of 0.5, so r probably will have a smaller value, and therefore the newpopulation tha verges to population X.
                newpopulation(mem).gene(i)=X(i);
            else
                newpopulation(mem).gene(i)=Y(i);
            end  
        end
    else
        newpopulation(mem).gene=population(mem).gene;
    end
end


 %Once a new population is created, copy it back
 for i=1:POPSIZE
    population(i)=newpopulation(i);
 end


%**********************************************************************************************************************************************************************************
%PALIO CROSSOVER: SINGLE POINT CROSSOVER
%**********************************************************************************************************************************************************************************
% first=0;    %count of the number of members chosen
% one=1;
% 
% for mem=1:POPSIZE
%     x=0 + (1-0)*rand(1,1);    
%     if x<PXOVER
%         first=first+1; 
%         if  mod(first,2)==0   
%             %select crossover point   %performs crossover of the two selected parents.
%             if NVARS>2
%                 if NVARS==3
%                     point=2;    %crossover point
%                 else
%                     point= (randi([1 55],1,1)); %swsto????
%                 for i=1:point                                            
%                     temp=population(one).gene(i);
%                     population(one).gene(i)=population(mem).gene(i);
%                     population(mem).gene(i)=temp;  
%                 end
%                 end
%             end
%         else
%             one=mem;
%         end
%     end
% end
%     

out_pop=population;

end
   




