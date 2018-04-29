function [U] = unsprung_mass(Zud, Zu, Zrd, Zr, Zsd, Zs, Fu, loc, SIM, Zs0, hcm)
    
    MR = hcm.MR(loc);
    
    dat = hcm.damper_data(:,:,loc);
    mode = hcm.damper_mode(loc);
    vel = (Zsd - Zud)*MR;
    disp = (Zs - Zu)*MR;
    
    Cs = get_damper(vel, mode, dat, hcm.Cs);
    Ks = hcm.Ks(loc);
    
    Cu = hcm.Cu(loc);
    Ku = hcm.Ku(loc);
    
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
    
    Faero = -0.5*hcm.fwu*SIM.L;
    
    Zudd = (1/hcm.Muloc(loc))*(Fcu + Fku + Fks + Fcs + Faero + Fu - hcm.Muloc(loc)*hcm.g0);
 
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