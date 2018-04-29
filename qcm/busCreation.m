clear

C.Zsdd = 0;
C.Zs = 0;
C.sprung_vel = 0;
C.sprung_disp = 0;
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

SIM.V = 0;
SIM.L = 0;
SIM.sim_time = 0;
SIM.sim_step = 0;
SIM.time_step = 0;
SIM.your_dut = 0;
SIM.loc = 0;
Simulink.Bus.createObject(SIM)
SIM = slBus1; clearvars slBus1

save('buses.mat')

