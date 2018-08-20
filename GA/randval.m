function [ T ] = randval(NVARS, lbound, ubound, x)

%**************************************************************************
%random value generator: Generates a value within bounds
%**************************************************************************

 
% for i=2:NVARS
%     temp = randi([lbound(i) ubound(i)], 1, 1);
%     
%     lb(i)=lbound(i);
%     ub(i)=ubound(i);
%     
%     if x(i-1)>=0 && x(i-1)<=22         
%         dif=abs(temp-x(i-1));
%         if dif>10
%             lb(i)=x(i-1)-5;
%             if lb(i)<0
%                 lb(i)=x(i-1)+2;
%             end
%             ub(i)=x(i-1)+5;
%             if ub(i)>32
%                 ub(i)=32;
%             end
%             if lb(i)>ub(i) && ub(i)<=10
%                 lb(i)=ub(i)-2;
%             end
%             if lb(i)>ub(i) && ub(i)>10
%                 lb(i)=ub(i)-10;
%             end
%             temp = randi([lb(i) ub(i)], 1, 1);
%         end
%     end
%     
%     if x(i-1)>=23 && x(i-1)<=32
%         dif=abs(temp-x(i-1));
%         if dif>5
%             lb(i)=x(i-1)-2;
%             if lb(i)<0
%                 lb(i)=x(i-1)+1;
%             end                                  
%             ub(i)=x(i-1)+5;
%             if ub(i)>32
%                 ub(i)=32;
%             end
%             if lb(i)>ub(i) && ub(i)<=10
%                 lb(i)=ub(i)-2;
%             end
%             if lb(i)>ub(i) && ub(i)>10
%                 lb(i)=ub(i)-10;
%             end
%             temp = randi([lb(i) ub(i)], 1, 1);
%         end
%     end
%     
% %     if i>=8 && i<=NVARS
% %         while temp==0
% %             temp=randi([lb(i) ub(i)], 1, 1);
% %         end
% %     end
%         
%     x(i)=temp;    
% end
%     
%         
% T = x;      
% 
% end

            

for i=2:NVARS
    temp = randi([lbound(i) ubound(i)], 1, 1);
    
    lb(i)=lbound(i);
    ub(i)=ubound(i);
    
    if x(i-1)>=0 && x(i-1)<=20 && temp>x(i-1)   %acceleration
        dif=abs(x(i)-x(i-1));
        
        if dif>10   %Check that the value difference is not bigger than 10 from the previous, for a velocity between 0-20km.
            lb(i)=x(i-1)-5;
            if lb(i)<18
                lb(i)=18;
            end
            if lb(i)<0  %Check that there are not negative values.
                lb(i)=x(i-1)+2;
            end
            
            ub(i)=x(i-1)+5;
            if ub(i)>32
                ub(i)=32;
            end
            if lb(i)>ub(i) && ub(i)>20  %Check that the lower boundart is not higher than the upper boundary.
                lb(i)=ub(i)-2;
            elseif lb(i)>ub(i) && ub(i)<20
                ub(i)=ub(i)+2;
            end
            temp = randi([lb(i) ub(i)], 1, 1);
        end
        x(i)=temp;                  
    end
    
    if x(i-1)>20 && x(i-1)<=32 && temp>x(i-1)   
        dif=abs(x(i)-x(i-1));
        if dif>5     %Check that the value difference is not bigger than 10 from the previous, for a velocity between 21-32km.
            lb(i)=x(i-1)-5;            
            if lb(i)<18
                lb(i)=18;
            end
            if lb(i)<0  %Check that there are not negative values.
                lb(i)=x(i-1)+2;
            end
            ub(i)=x(i-1)+5;            
            if ub(i)>32
                ub(i)=32;
            end
            if lb(i)>ub(i) && ub(i)>20  %Check that the lower boundart is not higher than the upper boundary.
                lb(i)=ub(i)-2;
            elseif lb(i)>ub(i) && ub(i)<20
                ub(i)=ub(i)+2;
            end
            temp = randi([lb(i) ub(i)], 1, 1);
        end
        x(i)=temp;                  
    end
    
    if x(i-1)>0 && x(i-1)<=20 && temp<x(i-1)    %deceleration
        dif=abs(x(i)-x(i-1));
        if dif>10   %Check that the value difference is not bigger than 10 from the previous, for a velocity between 0-20km.
            lb(i)=x(i-1)-5;                       
            if lb(i)<18
                lb(i)=18;
            end
            if lb(i)<0
                lb(i)=x(i-1)-2;
            end
            ub(i)=x(i-1)+5;            
            if ub(i)>32
                ub(i)=32;
            end            
            if lb(i)>ub(i) && ub(i)>20
                lb(i)=ub(i)-2;
            elseif lb(i)>ub(i) && ub(i)<20
                ub(i)=ub(i)+2;
            end
            temp = randi([lb(i) ub(i)], 1, 1);
        end
        x(i)=temp;                  
    end
    
    if x(i-1)>20 && x(i-1)<=32 && temp<x(i-1)
        dif=abs(x(i)-x(i-1));
        if dif>5    %Check that the value difference is not bigger than 10 from the previous, for a velocity between 21-32km.
            lb(i)=x(i-1)-5;                      
            if lb(i)<18
                lb(i)=18;
            end
            if lb(i)<0
                lb(i)=x(i-1)-2;
            end
            ub(i)=x(i-1)+5;            
            if ub(i)>32
                ub(i)=32;
            end            
            if lb(i)>ub(i) && ub(i)>20
                lb(i)=ub(i)-2;
            elseif lb(i)>ub(i) && ub(i)<20
                ub(i)=ub(i)+2;
            end
            temp = randi([lb(i) ub(i)], 1, 1);
        end
    end
        
        if i>=8 && i<=NVARS
            while temp==0   %Check that there are no zero values since the vehicle starts moving.
                temp=randi([lb(i) ub(i)], 1, 1);
            end
        end
        
        x(i)=temp;                  
end

T=x;

end
    






