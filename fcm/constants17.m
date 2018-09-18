%% README and TODO

% This constants file serves the full car model.

%% Global constants

fcm.g0 = g0;
fcm.rho0 = rho0;

fcm.V = V;
fcm.Alat = Alat;
fcm.Along = Along;

clearvars V g0 rho0 Alat Along

%% Lengths and heights

fcm.cg = 0.495; % [-] if cg > 0.5 -> toward rear

fcm.Lc = 1.53; % [m]
fcm.Lcw = 1.2; % [m]

fcm.Lcf = fcm.cg*fcm.Lc; % [m]
fcm.Lcr = fcm.Lc - fcm.Lcf; % [m]

fcm.Lfw = 0.7; % [m] Front wing length

fcm.Hcgu = 0.19; % [m]
fcm.Hcgs = 0.28; % [m]

fcm.Rcf = 0.05; % [m]
fcm.Rcr = 0.08; % [m]

fcm.Pc = 0.0945; % [m]

%% Masses and Inertia's

fcm.fwsu = 0; % [-] Percentage of the front wing that acts on the unsprung
fcm.rwsu = 0; % [-] Percentage of the rear wing that acts on the unsprung

fcm.Mfw = 2.8/2; % [kg]
fcm.Mrw = 4/2; % [kg]

fcm.Mdriver = 70; % [kg]

fcm.Muf = 12 + fcm.fwsu*fcm.Mfw; % [kg] 
fcm.Mur = 12 + fcm.rwsu*fcm.Mrw; % [kg]
 
fcm.Ms = (168 + fcm.Mdriver) - 2*(fcm.Muf + fcm.Mur); % [kg]

fcm.Msf = fcm.cg*fcm.Ms/2; % [kg] 
fcm.Msr = (1 - fcm.cg)*fcm.Ms/2; % [kg]

fcm.Msloc = [fcm.Msf*[1; 1]; fcm.Msr*[1; 1]];
fcm.Muloc = [fcm.Muf*[1; 1]; fcm.Mur*[1; 1]];

fcm.Ipitch = 50; % [kg*m^2] 
fcm.Iroll = 30; % [kg*m^2]
fcm.Iyaw = 80; % [kg*m^2]

%% Spring constants

fcm.MRF = 1;
fcm.MRR = 1;

fcm.Ksf = 000; % [N/m]
fcm.Ksr = 48000; % [N/m]

fcm.Ks = [fcm.Ksf*[1; 1]; fcm.Ksr*[1; 1]];
fcm.MR = [fcm.MRF*[1; 1]; fcm.MRR*[1; 1]];

%% Damper constants

% FRONT
Csfmode = 2; % Simulation mode (0=linear, 1=from data, 2=constant)

Csft1 = -10; 
Csfl = 2500; 
Csf2 = 3000;

Csft2 = 2; % Threshold at 0, i.e. bump

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
        fcm.damper_data(:,:,i) = Csfdat;
    else
        fcm.damper_data(:,:,i) = Csrdat;
    end
end
      
fcm.damper_mode = [Csfmode*[1; 1]; Csrmode*[1; 1]];          
fcm.Cs = 2250; % Constant value, for mode 2

clearvars Cs* i

%% Tyre constants

fcm.mu0 = 1.6; % [-] Friction coefficient

fcm.Td = 0.18415*2; % [m] Tyre diameter
fcm.Tw = 0.21844; % [m] Tyre width

fcm.Rr = 0.02; % [-] Rolling resistance

fcm.Trl = 0.2; % [-] Tyre relaxation length

fcm.Kuf = 95000; % [N/m] Tyre spring stiffness
fcm.Kur = 95000; % [N/m] Tyre spring stiffness

fcm.Cuf = 0; % [N/(m/s)] Tyre damping coefficient
fcm.Cur = 0; % [N/(m/s)] Tyre damping coefficient

fcm.Ku = [fcm.Kuf*[1; 1]; fcm.Kur*[1; 1]];
fcm.Cu = [fcm.Cuf*[1; 1]; fcm.Cur*[1; 1]];

%% Aerodynamics

fcm.ClA = 4.65; % [-] Total lift area coefficient
fcm.CdA = 1.75; % [-] Total drag area coefficient

fcm.fw = 0.35; % [-] Front wing percentage
fcm.fwu = fcm.fwsu*fcm.fw; % [-] Front wing unsprung percentage
fcm.fws = fcm.fw - fcm.fwu; % [-] Front wing sprung percentage

fcm.rw = 0.35; % [-] Rear wing percentage
fcm.rwu = fcm.rwsu*fcm.rw; % [-] Rear wing unsprung percentage
fcm.rws = fcm.rw - fcm.rwu; % [-] Rear wing sprung percentage

fcm.sp = 1 - fcm.fw - fcm.rw; % [-] Side pots percentage

fcm.cp = 0.51; % [-] Center of pressure

fcm.lploc = [(fcm.sp*fcm.cp + fcm.fw)*[0.5; 0.5]; (fcm.sp*(1 - fcm.cp) + fcm.rw)*[0.5; 0.5]];
fcm.L = 0.5*fcm.V^2*fcm.ClA*fcm.rho0; % [N] Total lift 

%% Anti-roll bar

fcm.arbkf = 0; % [N/m] ARB spring stiffness
fcm.arbarmf = 0.1; % [m] ARB 'arm' length

fcm.arbkr = 0; % [N/m] ARB spring stiffness
fcm.arbarmr = 0.1; % [m] ARB 'arm' length

fcm.arbsf = fcm.arbkf*fcm.arbarmf; % [(N*m)/deg] Stiffness front
fcm.arbsr = fcm.arbkr*fcm.arbarmr; % [(N*m)/deg] Stiffness rear

fcm.ch_stiff = 1200; % [(N*m)/deg] Chassis stiffness

%% Resting displacements (due to gravity)

Zu0 = zeros();
Zs0 = zeros();

if (setV == 0)
    for i = 1:4 % WITH AERO
        Kx = (fcm.Msloc(i)*fcm.g0 + 0.5*fcm.lploc(i)*fcm.L)/(fcm.Ks(i)*(fcm.MR(i))^2);
        Tx = ((fcm.Msloc(i) - fcm.Muloc(i))*fcm.g0 + 0.5*fcm.lploc(i)*fcm.L)/(fcm.Ku(i));

        Zu0(i) = Tx;
        Zs0(i) = Tx + Kx;
    end
else
    for i = 1:4 % WITHOUT AERO
        Kx = (fcm.Msloc(i)*fcm.g0)/(fcm.Ks(i)*(fcm.MR(i))^2);
        Tx = ((fcm.Msloc(i) + fcm.Muloc(i))*fcm.g0)/(fcm.Ku(i));

        Zu0(i) = Tx;
        Zs0(i) = Tx + Kx;
    end
end

clearvars i Tx Kx;

Zs0_chassis = interp1([0 1], [Zs0(1) Zs0(3)], fcm.cg);
pitch0_chassis = atan((sum(Zs0([1 2]))/2 - Zs0_chassis)/fcm.Lcf);

% % Overwrite to zero
Zs0 = [0 0 0 0];
Zs0_chassis = 0;
pitch0_chassis = 0;
Zu0 = [0 0 0 0];

%% Other

fcm = struct(fcm);
