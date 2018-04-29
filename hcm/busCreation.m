clear

LT.Flatf = 0;
LT.Flatr = 0;
LT.Flongf = 0;
LT.Flongr = 0;
LT.Mlong = 0;
LT.Mlat = 0;
LT.Ful = 0;
LT.Fur = 0;
Simulink.Bus.createObject(LT);
LT = slBus1; clearvars slBus1

C.rolldd = 0;
C.pitchdd = 0;
C.Zsdd = 0;
C.roll = 0;
C.pitch = 0;
C.Zs = 0;
C.sprung_vel = [0; 0];
C.sprung_disp = [0; 0];
C.Fcs = [0; 0];
C.Fks = [0; 0];
C.Faero = 0;
Simulink.Bus.createObject(C);
C = slBus1; clearvars slBus1

U.Cs = 0;
U.damperVel = 0;
U.Fn = 0;
U.Zu = 0;
U.Zud = 0;
U.Zr = 0;
U.Zrd = 0;
U.gc = 0;
U.dt = 0;
U.Fcu = 0;
U.Fku = 0;
U.Fcs = 0;
U.Fks = 0;
U.ZuZr = 0;
U.ZsZu = 0;
U.ZudZrd = 0;
U.ZsdZud = 0;
U.Zudd = 0;
U.Zs = 0;
U.Zsd = 0;
Simulink.Bus.createObject(U)
U = slBus1; clearvars slBus1

ARB.Farb = 0;
ARB.Marb = 0;
ARB.roll_u = 0;
Simulink.Bus.createObject(ARB)
ARB = slBus1; clearvars slBus1

SIM.V = 0;
SIM.L = 0;
SIM.Alat = 0;
SIM.Along = 0;
SIM.sim_time = 0;
SIM.sim_step = 0;
SIM.time_step = 0;
SIM.your_dut = 0;
SIM.front_rear = 0;
Simulink.Bus.createObject(SIM)
SIM = slBus1; clearvars slBus1

save('buses.mat')

