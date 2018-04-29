%% README and TODO

% This constants file serves the full car model.

%% Lengths and heights

fcm.cg = 0.5; % [-] Higher cg > 0.5: toward rear

fcm.Lc = 1.525; % [m]
fcm.Lcw = 1.2; % [m]

fcm.Lcf = fcm.cg*fcm.Lc; % [m]
fcm.Lcr = fcm.Lc - fcm.Lcf; % [m]

fcm.Lfw = 0.7; % [m] Front wing length

fcm.Hcgu = 0.19; % [m]
fcm.Hcgs = 0.28; % [m]

fcm.Rcf = 0.0525; % [m]
fcm.Rcr = 0.08; % [m]

fcm.Pc = 0.084; % [m]

%% Masses and Inertia's

fcm.fwsu = 1; % [-] Percentage of the front wing that acts on the unsprung
fcm.rwsu = 1; % [-] Percentage of the rear wing that acts on the unsprung

fcm.Mfw = 2.8/2; % [kg]
fcm.Mrw = 4/2; % [kg]
fcm.Mdriver = 70; % [kg]

fcm.Muf = 12 + fcm.fwsu*fcm.Mfw; % [kg] 
fcm.Mur = 12 + fcm.rwsu*fcm.Mrw; % [kg]
 
fcm.Mcar = 167;

fcm.Ms = ((fcm.Mcar + fcm.Mdriver)/2) - fcm.Muf - fcm.Mur; % [kg]

fcm.Msf = (1 - fcm.cg)*fcm.Ms; % [kg] This values is multiplied by 
                                 % two in the left-right model
fcm.Msr = fcm.Ms - fcm.Msf; % [kg]

fcm.Ipitch = 50; % [kg*m^2] 
fcm.Iroll = 30; % [kg*m^2]
fcm.Iyaw = 80; % [kg*m^2]

%% Spring and damper constants

% Note for dampers, bound means compression, rebound means tension

fcm.MRF = 1;
fcm.MRR = 1;

fcm.Kfi = 50000;
fcm.Kri = 50000;

fcm.Ksf = fcm.Kfi; % [N/m]
fcm.Csfb = 2200; % [N/(m/s)] Bound
fcm.Csfr = 1600; % [N/(m/s)] Rebound
fcm.Csfbs = 1600; % [N/(m/s)] Bound second curve
fcm.Csfrs = 500; % [N/(m/s)] Rebound second curve
fcm.Csfbt = 0.02; % [m/s] Bound treshold
fcm.Csfrt = -0.02; % [m/s] Rebound treshold

fcm.Ksr = fcm.Kri; % [N/m]
fcm.Csrb = fcm.Csfb; % [N/(m/s)] Bound
fcm.Csrr = fcm.Csfr; % [N/(m/s)] Rebound
fcm.Csrbs = fcm.Csfbs; % [N/(m/s)] Bound second curve
fcm.Csrrs = fcm.Csfrs; % [N/(m/s)] Rebound second curve
fcm.Csrbt = fcm.Csfbt; % [m/s] Bound treshold
fcm.Csrrt = fcm.Csfrt; % [m/s] Rebound treshold

fcm.Kuf = 95000; % [N/m]
fcm.Kur = 95000; % [N/m]

fcm.Cuf = 0; % [N/(m/s)]
fcm.Cur = 0; % [N/(m/s)]

%% Tyre constants

fcm.mu0 = 1.4; % [-] Friction coefficient

fcm.Td = 0.18415*2; % [m] Tire radius
fcm.Tw = 0.21844; % [m] Tire width

fcm.Rr = 0.02; % [-] Rolling resistance

fcm.Trl = 0.2; % [-] Tire relaxation length

%% Aerodynamics

fcm.ClA = 4.2; % [-] Total lift area coefficient
fcm.CdA = 2.5; % [-] Total drag area coefficient

fcm.fw = 0.35; % [-] Front wing percentage
fcm.fwu = fcm.fwsu*fcm.fw; % [-] Front wing unsprung percentage
fcm.fws = fcm.fw - fcm.fwu; % [-] Front wing sprung percentage

fcm.rw = 0.35; % [-] Rear wing percentage
fcm.rwu = fcm.rwsu*fcm.rw; % [-] Rear wing unsprung percentage
fcm.rws = fcm.rw - fcm.rwu; % [-] Rear wing sprung percentage

fcm.sp = 1 - fcm.fw - fcm.rw; % [-] Side pods percentage

fcm.cp = 0.4; % [-] Center of pressure

fcm.L = 0.5*fcm.V^2*fcm.ClA*fcm.rho0; % [N] Total lift 

%% Anti-roll bar

fcm.arbkf = 1200; % [N/m] ARB spring stiffness
fcm.arbarmf = 0.1; % [m] ARB 'arm' length

fcm.arbkr = 1200; % [N/m] ARB spring stiffness
fcm.arbarmr = 0.1; % [m] ARB 'arm' length

fcm.arbsf = fcm.arbkf*fcm.arbarmf; % [(N*m)/deg] Stiffness front
fcm.arbsr = fcm.arbkr*fcm.arbarmr; % [(N*m)/deg] Stiffness rear

%% Resting displacements (due to gravity)

Kxf = (fcm.Msf*fcm.g0 + 0.5*(fcm.sp*fcm.cp + fcm.fws)*fcm.L) /(fcm.Ksf*fcm.MRF) ;% [m]
Kxr = (fcm.Msr*fcm.g0 + 0.5*(fcm.sp*(1 - fcm.cp) + fcm.rws)*fcm.L)/(fcm.Ksr*fcm.MRR); % [m]

Txf = ((fcm.Msf + fcm.Muf)*fcm.g0 + 0.5*((fcm.fw + fcm.sp*fcm.cp)*fcm.L))/(fcm.Kuf); % [m]
Txr = ((fcm.Msr + fcm.Mur)*fcm.g0 + 0.5*((fcm.rw + fcm.sp*(1 - fcm.cp))*fcm.L))/(fcm.Kur); % [m]

Zsf0 = Kxf + Txf; % [m]
Zuf0 = Txf; % [m]

Zsr0 = Kxr + Txr; % [m]
Zur0 = Txr; % [m]

%% Other

fcm = struct(fcm);