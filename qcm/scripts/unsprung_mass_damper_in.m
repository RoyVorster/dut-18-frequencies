function [U] = unsprung_mass_damper_in(Zud, Zu, Zrd, Zr, Zsd, Zs, Cs, loc, SIM, Zs0, qcm)
    
    MR = qcm.MR(loc);

    vel = (Zsd - Zud)*MR;
    disp = (Zs - Zu)*MR;
    
    Ks = qcm.Ks(loc);
    
    Cu = qcm.Cu(loc);
    Ku = qcm.Ku(loc);
    
    if (Zu - Zr) > 0
        Fku = 0;
        Fcu = 0;
    else
        Fcu = -Cu*(Zud - Zrd);
        Fku = -Ku*(Zu - Zr); 
    end
    
    Fcs = Cs*vel*MR;    
    Fks = Ks*disp*MR;
    
    Fn = Fku - Fks;
    
    Faero = -0.5*qcm.fwu*SIM.L;
    
    Zudd = (1/qcm.Muloc(loc))*(Fcu + Fku + Fks + Fcs + Faero - qcm.Muloc(loc)*qcm.g0);
 
    U.Cs = Cs;
    U.damperVel = vel;
    U.Fn = Fn;
    U.Zu = Zu;
    U.Zud = Zud;
    U.Zr = Zr;
    U.Zrd = Zrd;
    
    [gc, dt] = get_position(Zs, Zu, Zr, loc, Zs0);
    U.gc = gc;
    U.dt = dt;
    
    U.Fcu = Fcu;
    U.Fku = Fku;
    U.Fcs = Fcs;
    U.Fks = Fks;
    
    U.ZuZr = Zu - Zr;
    U.ZsZu = Zs - Zu;
    U.ZudZrd = Zud - Zrd;
    U.ZsdZud = Zsd - Zud;
    
    % Model outputs
    U.Zudd = Zudd;
    U.Zs = Zs;
    U.Zsd = Zsd;
    
end