function [S] = sprung_mass(Zufl, Zufld, Zsfl, Zsfld, Zufr, Zufrd, Zsfr, Zsfrd, Zurl, Zurld, Zsrl, Zsrld, Zurr, Zurrd, Zsrr, Zsrrd, Mlatf, Mlatr, Mlong, Marbf, Marbr, SIM, Fx, Fy, fcm)

    sprung_vel = [(Zsfld - Zufld)*fcm.MR(1); (Zsfrd - Zufrd)*fcm.MR(2); ...
                    (Zsrld - Zurld)*fcm.MR(3); (Zsrrd - Zurrd)*fcm.MR(4);];
    sprung_disp = [(Zsfl - Zufl)*fcm.MR(1); (Zsfr - Zufr)*fcm.MR(2); ...
                    (Zsrl - Zurl)*fcm.MR(3); (Zsrr - Zurr)*fcm.MR(4);];
                         
    Cs = zeros(4,1);
    Fcs = zeros(4,1);
    Fks = zeros(4,1);
    for i = 1:4
        vel = sprung_vel(i);
        disp = sprung_disp(i);
        
        dat = fcm.damper_data(:,:,i);
        mode = fcm.damper_mode(i);
        
        C = get_damper(vel, mode, dat, fcm.Cs);
        K = fcm.Ks(i);
        Cs(i) = C;
        
        Fcs(i) = -C*vel*fcm.MR(i);
        Fks(i) = -K*disp*fcm.MR(i);
    end
    
    Faero = -(fcm.sp + fcm.fws + fcm.rws)*SIM.L;
    Fg = -fcm.Ms*fcm.g0;
    
    Zsdd = (1/fcm.Ms)*(sum(Fcs) + sum(Fks) + Faero + Fg);
    
    pitchdd = (1/fcm.Ipitch)*((Fks(1) + Fks(2) + Fcs(1) + Fcs(2))*fcm.Lcf - (Fks(3) + Fks(4) + Fcs(3) + Fcs(4))*fcm.Lcr ...
                + Faero*((fcm.cp - fcm.cg)*fcm.Lc) + Mlong);

    yawdd = (1/fcm.Iyaw)*((Fx(1) + Fx(3) - Fx(2) - Fx(4))*(fcm.Lcw/2) + (Fy(1) + Fy(2) - Fy(3) - Fy(4)));
    yawdd = yawdd/fcm.Iyaw;
   
    rollfdd = (1/fcm.Iroll)*((Fks(1) + Fcs(1) - Fcs(2) - Fks(2))*(fcm.Lcw/2) + Mlatf + Marbf);
    rollrdd = (1/fcm.Iroll)*((Fks(3) + Fcs(3) - Fcs(4) - Fks(4))*(fcm.Lcw/2) + Mlatr + Marbr);
    
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
    S.Fcs = Fcs;
    S.Fks = Fks;
    S.Faero = Faero;
   
end