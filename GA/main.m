clear all;
close all;
clc;


POPSIZE=76;    %polulation size        
MAXGENS=5;    %max number of generations
NVARS=55;    %no. of problem variables
PXOVER=0.8;    %propability of crossover
PMUTATION=0.2;    %propability of mutation


%**************************************************************************
%Main function: Each generation involves selecting the best members,
%performing crossover & mutation and then evaluating the resulting
%population, until the terminating condition is satisfied. 
%**************************************************************************


%/////////////////*necessary data to run the simulink model*///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
m_chassis = 80;
m_driver = 70;
m_total = m_chassis + m_driver;
r = 0.27;
Cr = 0.005;
Af = 0.8;
Cd = 0.21;
P_air = 101325;
R_air = 287.05; 
multiple_gears = 0; %disable=0
gear_ef = 0.95;
single_gear_ratio = 0.1;
m_gear = 0.5;
first_ratio = 0.07143;
second_ratio = 0.1;
third_ratio = 0.125;
first_max_speed = 2.23;
second_max_speed = 5;
J_gear = 0.06;

%dc motor characteristics
%no_load_current = 1.8;
%Ra_motor = 0.068;
%Tc_motor = 0.3668;
%Ke = 0.0489;
%tao_w = 127;
%tao_h = 991;
%R_ha = 1.3;
%R_wh = 1.85;
%Temp_max_motor = 125;
%n_motor = 1;
%motor = 1; %for axi 2 for dc
T_amb_air = 20;
%T_amb = 40;
make_track = 0; %enable = 1
s_tot = 1630;
t_tot = 220;
t1 = 20;
t3 = 15;

% TRack speed, acceleration and position  vector - resolution [per second]
%=========================================================================
t0 = 1;		% prerace time
% constant velocity time calculation
t2 = t_tot - t1 -t3;
% constant velocity calculation
v_constant = 2*s_tot/(t1 + 2*t2 + t3);
 % Initial conditions
v1_1(1) = 0;    %initial velocity
s1_1(1) = 0;    %starting position
s3_1(1) = 0;    %
%***********************************
a_acc = v_constant/t1;	% acceleration [m/s^2]
a_br = v_constant/t3;	% retardation
% Calculating Acceleration distance
t_acc = [0:t1];
s_acc_t = 0.*t_acc+0.5.*a_acc.*t_acc.^2;
s_acc = s_acc_t(end);
% Calculating Retardation distance
t_br = [0:t3];
s_br_t = v_constant.*t_br - 0.5.*a_br.*t_br.^2;
s_br = s_br_t(end);
%***************************************************************************
% Vector creati0ns - per section
%***************************************************************************
% Pre Race
	v_0 = zeros([1 t0]);
	s_0 = zeros([1 t0]);
	t_0 = length(v_0);
	a_0 = zeros([1 t0]);
% Lap 1
	% Acceleration	
	for i = 2:t1
		v1_1(i) = v1_1(i-1) + a_acc*1;
		s1_1(i) = v1_1(1)*i + 0.5*a_acc*i^2;
		a1_1(i) = a_acc;
	end
	% Constant velocity	
	t2_1 = round((s_tot-s_acc-s_br)/v_constant);
	for i = 1:t2_1
		v2_1(i) = v_constant;
		s2_1(i) = v2_1(i)*i;
		a2_1(i) = 0;
    end
	% Retardation
	v3_1(1) = v2_1(t2_1); %[m/s]
	for i = 2:t3
		v3_1(i) = v3_1(i-1) - a_br*1;
		s3_1(i) = v3_1(1)*i - 0.5*a_br*i^2;
		a3_1(i) = -a_br;
    end
	v_1 = [v1_1,v2_1,v3_1];
	s_1 = [s1_1, s1_1(t1)+s2_1, s1_1(t1)+s2_1(t2_1)+s3_1];
	a_1 = [a1_1,a2_1,a3_1];
	t_1 = t1+t2_1+t3;
%\END Lap 1
%************************************************************************************
% Race -vector sumations
%************************************************************************************
% Minus 1; to get  the same length as for"speed" and "position"
time = [0:(t_0+t_1)-1];
speed = [v_0, v_1];
acceleration = [a_0, a_1];
position = [s_0, s_0(end)+ s_1,s_0(end)+s_1(end)];
 assignin('base', 'time', time);
 assignin('base', 'speed', speed);
 
%////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



warning off

population = struct('gene', zeros(1, NVARS), 'fitness', 0, 'probability', 0,  'lower', zeros(1, NVARS), 'upper', zeros(1, NVARS));
newpopulation = struct('gene', zeros(1, NVARS), 'fitness', 0, 'probability', 0,  'lower', zeros(1, NVARS), 'upper', zeros(1, NVARS));
generation = 1; 


% H = waitbar(0,'proodos genetikou');
    
[population, distance]=initialize(NVARS, POPSIZE, population);


t=[1:220]';
x=zeros(POPSIZE,NVARS);
y=zeros(NVARS,1);
f=zeros(MAXGENS,POPSIZE);
o=zeros(NVARS,POPSIZE);
q=zeros(220,POPSIZE);

for mem=1:POPSIZE
     l=population(mem).gene;
     m=round(resample(l,4,1));  %Changes the sampling rate of a signal. Convert from 55 times to 220 (linear interpolation) that the model gets as input. 
     m(218)=5;  
     m(219)=3;
     m(220)=0;
     y=round(m/3.6);    %Convert from km to m.
            
     SimOut=sim('MODEL.slx');   %Call the simulink model. We give as an input the population/velocity profile and we get as an output the mean  vehicle's power in Watt.
     [population]=evaluate(POPSIZE,NVARS,population, mem, power, distance);   %
%    waitbar((mem)/(MAXGENS*POPSIZE),H,['proodos genetikou ' num2str(100*(mem)/(MAXGENS*POPSIZE)) '% complete'] );
%    clear memory
end
  
filename='outpop.xlsx';
filename2='outfitness.xlsx';
filename3='outpop220.xlsx';


[ population ]=keep_the_best(population, POPSIZE, NVARS);

for gen_count=2:MAXGENS

generation=generation+1;
disp('GENERATION COUNT:');
disp(gen_count);


    for mem=1:POPSIZE
        f(gen_count,mem)=population(mem).fitness;
        for i=1:NVARS        
            o(i,mem)=round((population(mem).gene(i)));
        end
    end
    
    xlswrite(filename,o,gen_count,'A1:BX55');
    
    [population ]=tournamentselection(population,POPSIZE, NVARS);

 

    
    [ population ]=crossover(POPSIZE, NVARS, PXOVER, population );
    [ population ]=mutate(POPSIZE,NVARS,PMUTATION,population, gen_count, MAXGENS);
    

   % [population]=report(POPSIZE,population);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      

    for mem=1:POPSIZE
        l=population(mem).gene;
        m=round(resample(l,4,1));   %Changes the sampling rate of a signal. Convert from 55 times to 220 (linear interpolation) that the model gets as input.
        m(218)=0;
        m(219)=0;
        m(220)=0;
        for i=1:220        
            q(i,mem)=m(i);
        end
        y=round(m/3.6); %Convert from km to m.
       
        SimOut=sim('MODEL.slx');
        [population]=evaluate(POPSIZE,NVARS,population, mem, power, distance);    %Call the simulink model. We give as an input the population/velocity profile and we get as an output the mean  vehicle's power in Watt.
    end
    
    
    k=zeros(1,POPSIZE);
    for i=1:POPSIZE
    k(i)=population(i).fitness;
    end
    [M,I] = min(k) 
    disp(distance);
     
        
    xlswrite(filename3,q,gen_count,'A1:BX220');
    
     [population]=elitist(POPSIZE,population,NVARS);
    


%     waitbar((gen_count*POPSIZE+i)/(MAXGENS*POPSIZE),H,['proodos genetikou ' num2str(100*(gen_count*POPSIZE+i)/(MAXGENS*POPSIZE)) '% complete'] );
%     clear memory

end
 
xlswrite(filename2,f,1,'A1:BX100');


disp('Simulation completed');
disp('Success');


warning on