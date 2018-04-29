function [S] = sprung_mass_segway(Zul, Zuld, Zsl, Zsld, Zur, Zurd, Zsr, Zsrd, Mlatf, Marbf, SIM, hcm)
    
    d = 0;
    if (SIM.front_rear == 0)
        d = 2;
    end

    sprung_vel = [(Zsld - Zuld)*hcm.MR(1 + d); (Zsrd - Zurd)*hcm.MR(2 + d)];
    sprung_disp = [(Zsl - Zul)*hcm.MR(1 + d); (Zsr - Zur)*hcm.MR(2 + d)];
                         
    Cs = zeros(2,1);
    Fcs = zeros(2,1);
    Fks = zeros(2,1);
    for i = 1:2
        vel = sprung_vel(i);
        disp = sprung_disp(i);
        
        dat = hcm.damper_data(:,:,i + d);
        mode = hcm.damper_mode(i + d);
        
        C = get_damper(vel, mode, dat, hcm.Cs);
        K = hcm.Ks(i + d);
        Cs(i) = C;
        
        Fcs(i) = -C*vel*hcm.MR(i + d);
        Fks(i) = -K*disp*hcm.MR(i + d);
    end
    
    if (SIM.front_rear == 0)
        Faero = -(hcm.sp*hcm.cp + hcm.fws)*SIM.L;
    else
        Faero = -(hcm.sp*(1 - hcm.cp) + hcm.rws)*SIM.L;
    end
    
    Fg = -hcm.Msloc(1 + d)*2*hcm.g0;
    
    Zsdd = (1 / (hcm.Msloc(1 + d)*2)) * (sum(Fcs + Fks) + Faero + Fg);
    rolldd = (1 / hcm.Iroll) * (Mlatf + Marbf + 0.5 * hcm.Lcw * (Fcs(1) + Fks(1) - Fks(2) - Fcs(2)));

    % Output
    S.rolldd = rolldd;
    S.pitchdd = 0;
    S.Zsdd = Zsdd;
    
    S.roll = 0;
    S.pitch = 0;
    S.Zs = 0;
    
    S.sprung_vel = sprung_vel;
    S.sprung_disp = sprung_disp;
    S.Faero = Faero;
   
end