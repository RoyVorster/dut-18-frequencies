%% README and TODO

% This constants file serves the half car model.

%% Global constants

qcm.g0 = g0;
qcm.rho0 = rho0;

qcm.V = V;
qcm.Alat = Alat;
qcm.Along = Along;

clearvars V g0 rho0 Alat Along

%% Lengths and heights

qcm.cg = 0.51; % [-] if cg > 0.5 -> toward rear

qcm.Lc = 1.53; % [m]
qcm.Lcw = 1.2; % [m]

qcm.Lcf = qcm.cg*qcm.Lc; % [m]
qcm.Lcr = qcm.Lc - qcm.Lcf; % [m]

qcm.Lfw = 0.7; % [m] Front wing length

qcm.Hcgu = 0.19; % [m]
qcm.Hcgs = 0.28; % [m]

qcm.Rcf = 0.05; % [m]
qcm.Rcr = 0.08; % [m]

qcm.Pc = 0.0945; % [m]

%% Masses and Inertia's

qcm.fwsu = 0; % [-] Percentage of the front wing that acts on the unsprung
qcm.rwsu = 0; % [-] Percentage of the rear wing that acts on the unsprung

qcm.Mfw = 2.8/2; % [kg]
qcm.Mrw = 4/2; % [kg]

qcm.Mdriver = 70; % [kg]

qcm.Muf = 12 + qcm.fwsu*qcm.Mfw; % [kg] 
qcm.Mur = 12 + qcm.rwsu*qcm.Mrw; % [kg]
 
qcm.Ms = (167 + qcm.Mdriver) - 2*(qcm.Muf + qcm.Mur); % [kg]

qcm.Msf = qcm.cg*qcm.Ms/2; % [kg] 
qcm.Msr = (1 - qcm.cg)*qcm.Ms/2; % [kg]

qcm.Msloc = [qcm.Msf*[1; 1]; qcm.Msr*[1; 1]];
qcm.Muloc = [qcm.Muf*[1; 1]; qcm.Mur*[1; 1]];

qcm.Ipitch = 50; % [kg*m^2] 
qcm.Iroll = 30; % [kg*m^2]
qcm.Iyaw = 80; % [kg*m^2]

%% Spring constants

qcm.MRF = 1;
qcm.MRR = 1;

qcm.Ksf = 60000; % [N/m]
qcm.Ksr = 60000; % [N/m]

qcm.Ks = [qcm.Ksf*[1; 1]; qcm.Ksr*[1; 1]];
qcm.MR = [qcm.MRF*[1; 1]; qcm.MRR*[1; 1]];

%% Damper constants

% FRONT
Csfmode = 2; % Simulation mode (0=linear, 1=from data, 2=constant)

Csft1 = -10; 
Csfl = 2500; 
Csf2 = 3000;

Csft2 = 0; % Threshold at 0, i.e. bump

Csf3 = 4150;
Csft3 = 10;
Csf4 = 5000;

Csfdat = [-100      Csfl; ...
          Csft1     Csf2; ...
          Csft2     Csf3; ...
          Csft3     Csf4];

% REAR
Csrmode = 2; % Simulation mode (0=linear, 1=from data, 2=constant)

Csrt1 = -10; 
Csrl = 2500; 
Csr2 = 3000;

Csrt2 = 0; % Threshold at 0, i.e. bump

Csr3 = 4150;
Csrt3 = 10;
Csr4 = 5000;

Csrdat = [-100      Csrl; ...
          Csrt1     Csr2; ...
          Csrt2     Csr3; ...
          Csrt3     Csr4];

for i = 1:4
    if (i == 1 || i == 2)
        qcm.damper_data(:,:,i) = Csfdat;
    else
        qcm.damper_data(:,:,i) = Csrdat;
    end
end
      
qcm.damper_mode = [Csfmode*[1; 1]; Csrmode*[1; 1]];          
qcm.Cs = 2250; % Constant value, for mode 2

% For semi-active damping controller
C_max = 5600;
C_min = 500;

clearvars Cs* i

%% Tyre constants

qcm.mu0 = 1.6; % [-] Friction coefficient

qcm.Td = 0.18415*2; % [m] Tyre diameter
qcm.Tw = 0.21844; % [m] Tyre width

qcm.Rr = 0.02; % [-] Rolling resistance

qcm.Trl = 0.2; % [-] Tyre relaxation length

qcm.Kuf = 95000; % [N/m] Tyre spring stiffness
qcm.Kur = 95000; % [N/m] Tyre spring stiffness

qcm.Cuf = 7; % [N/(m/s)] Tyre damping coefficient
qcm.Cur = 7; % [N/(m/s)] Tyre damping coefficient

qcm.Ku = [qcm.Kuf*[1; 1]; qcm.Kur*[1; 1]];
qcm.Cu = [qcm.Cuf*[1; 1]; qcm.Cur*[1; 1]];

%% Aerodynamics

qcm.ClA = 4.65; % [-] Total lift area coefficient
qcm.CdA = 1.75; % [-] Total drag area coefficient

qcm.fw = 0.35; % [-] Front wing percentage
qcm.fwu = qcm.fwsu*qcm.fw; % [-] Front wing unsprung percentage
qcm.fws = qcm.fw - qcm.fwu; % [-] Front wing sprung percentage

qcm.rw = 0.35; % [-] Rear wing percentage
qcm.rwu = qcm.rwsu*qcm.rw; % [-] Rear wing unsprung percentage
qcm.rws = qcm.rw - qcm.rwu; % [-] Rear wing sprung percentage

qcm.sp = 1 - qcm.fw - qcm.rw; % [-] Side pots percentage

qcm.cp = 0.51; % [-] Center of pressure

qcm.lploc = [(qcm.sp*qcm.cp + qcm.fw)*[0.5; 0.5]; (qcm.sp*(1 - qcm.cp) + qcm.rw)*[0.5; 0.5]];
qcm.L = 0.5*qcm.V^2*qcm.ClA*qcm.rho0; % [N] Total lift 

%% Anti-roll bar

qcm.arbkf = 0; % [N/m] ARB spring stiffness
qcm.arbarmf = 0.1; % [m] ARB 'arm' length

qcm.arbkr = 0; % [N/m] ARB spring stiffness
qcm.arbarmr = 0.1; % [m] ARB 'arm' length

qcm.arbsf = qcm.arbkf*qcm.arbarmf; % [(N*m)/deg] Stiffness front
qcm.arbsr = qcm.arbkr*qcm.arbarmr; % [(N*m)/deg] Stiffness rear

%% Resting displacements (due to gravity)

Zu0 = zeros();
Zs0 = zeros();

if (setV == 0)
    for i = 1:4 % WITH AERO
        Kx = (qcm.Msloc(i)*qcm.g0 + 0.5*qcm.lploc(i)*qcm.L)/(qcm.Ks(i)*(qcm.MR(i))^2);
        Tx = ((qcm.Msloc(i) - qcm.Muloc(i))*qcm.g0 + 0.5*qcm.lploc(i)*qcm.L)/(qcm.Ku(i));

        Zu0(i) = Tx;
        Zs0(i) = Tx + Kx;
    end
else
    for i = 1:4 % WITHOUT AERO
        Kx = (qcm.Msloc(i)*qcm.g0)/(qcm.Ks(i)*(qcm.MR(i))^2);
        Tx = ((qcm.Msloc(i) + qcm.Muloc(i))*qcm.g0)/(qcm.Ku(i));

        Zu0(i) = Tx;
        Zs0(i) = Tx + Kx;
    end
end

clearvars i Tx Kx;

Zs0_chassis = interp1([0 1], [Zs0(1) Zs0(3)], qcm.cg);

% Overwrite to zero
Zs0 = [0 0 0 0];
Zs0_chassis = 0;
Zu0 = [0 0 0 0];

%% Other

qcm = struct(qcm);
