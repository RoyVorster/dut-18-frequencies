function [S] = sprung_mass_simple(FL, FR, RL, RR, Mlatf, Mlatr, Mlong, Marbf, Marbr, SIM, Fx, Fy, fcm)

    sprung_vel = [[FL.Zsd - FL.Zud; FR.Zsd - FR.Zud]*fcm.MRF; ... 
                  [RL.Zsd - RL.Zud; RR.Zsd - RR.Zud]*fcm.MRR];
    sprung_disp = [[FL.Zs - FL.Zu; FR.Zs - FR.Zu]*fcm.MRF; ...
                   [RL.Zs - RL.Zu; RR.Zs - RR.Zu]*fcm.MRR];
                         
    Fksfl = -fcm.Ksf*(FL.Zs - FL.Zu);
    Fcsfl = -fcm.Cs*(FL.Zsd - FL.Zud);
    
    Fksfr = -fcm.Ksf*(FR.Zs - FR.Zu);
    Fcsfr = -fcm.Cs*(FR.Zsd - FR.Zud);
    
    Fksrl = -fcm.Ksf*(RL.Zs - RL.Zu);
    Fcsrl = -fcm.Cs*(RL.Zsd - RL.Zud);
    
    Fksrr = -fcm.Ksf*(RR.Zs - RR.Zu);
    Fcsrr = -fcm.Cs*(RR.Zsd - RR.Zud);
    
    Faero = -(fcm.sp + fcm.fws + fcm.rws)*SIM.L;
    Fg = -fcm.Ms*fcm.g0;
    
    Zsdd = (1/fcm.Ms)*(Fksfl + Fcsfl + Fksfr + Fcsfr + Fksrl + Fcsrl + ...
                       Fksrr + Fcsrr + Faero + Fg);
    
    pitchdd = (1/fcm.Ipitch)*((Fksfl + Fksfr + Fcsfl + Fcsfr)*fcm.Lcf - (Fksrl + Fksrr + Fcsrl + Fcsrr)*fcm.Lcr ...
                + Faero*((fcm.cp - fcm.cg)*fcm.Lc) + Mlong);

    yawdd = (1/fcm.Iyaw)*((Fx(1) + Fx(3) - Fx(2) - Fx(4))*(fcm.Lcw/2) + (Fy(1) + Fy(2) - Fy(3) - Fy(4)));
    yawdd = yawdd/fcm.Iyaw;
   
    rollfdd = (1/fcm.Iroll)*((Fksfl + Fcsfl - Fcsfr - Fksfr)*(fcm.Lcw/2) + Mlatf + Marbf);
    rollrdd = (1/fcm.Iroll)*((Fksrl + Fcsrl - Fcsrr - Fksrr)*(fcm.Lcw/2) + Mlatr + Marbr);

    % Output
    S.rollfdd = rollfdd;
    S.rollrdd = rollrdd;
    S.pitchdd = pitchdd;
    S.yawdd = yawdd;
    S.Zsdd = Zsdd;
    
    S.rollf = 0;
    S.rollr = 0;
    S.pitch = 0;
    S.yaw = 0;
    S.Zs = 0;
    
    S.sprung_vel = sprung_vel;
    S.sprung_disp = sprung_disp;
    S.Fcs = [Fcsfl; Fcsfr; Fcsrl; Fcsrr];
    S.Fks = [Fksfl; Fksfr; Fcsrl; Fcsrr];
    S.Faero = Faero;
   
end