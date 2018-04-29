function [S] = sprung_mass_damper_in(Zu, Zud, Zs, Zsd, Cs, SIM, loc, qcm)

    vel = (Zsd - Zud)*qcm.MR(loc);
    disp = (Zs - Zu)*qcm.MR(loc);

    Fks = -qcm.Ks(loc)*disp*qcm.MR(loc);
    Fcs = -Cs*vel*qcm.MR(loc);

    if (loc == 1 || loc == 2)
        Faero = -0.5*(qcm.sp*qcm.cp + qcm.fws)*SIM.L;
    else
        Faero = -0.5*(qcm.sp*qcm.cp + qcm.rws)*SIM.L;
    end

    Zsdd = (1/qcm.Msloc(loc))*(Fks + Faero + Fcs - qcm.Msloc(loc)*qcm.g0);

    % Output
    S.Zsdd = Zsdd;

    S.Zs = 0;
    
    S.sprung_vel = vel;
    S.sprung_disp = disp;
    S.Faero = Faero;
   
end