function [S] = sprung_mass_bicycle(Zuf, Zufd, Zsf, Zsfd, Zur, Zurd, Zsr, Zsrd, Mlong, SIM, hcm)
    
    sprung_vel = [(Zsfd - Zufd)*hcm.MRF; (Zsrd - Zurd)*hcm.MRR];
    sprung_disp = [(Zsf - Zuf)*hcm.MRF; (Zsr - Zur)*hcm.MRR];
                         
    Cs = zeros(2,1);
    Fcs = zeros(2,1);
    Fks = zeros(2,1);
    
    Cs(1) = get_damper(sprung_vel(1), hcm.damper_mode(1), hcm.damper_data(:,:,1), hcm.Cs);
    Cs(2) = get_damper(sprung_vel(2), hcm.damper_mode(3), hcm.damper_data(:,:,3), hcm.Cs);
    
    Fcs(1) = -Cs(1)*sprung_vel(1)*hcm.MRF;
    Fcs(2) = -Cs(2)*sprung_vel(2)*hcm.MRR;
    
    Fks(1) = -hcm.Ks(1)*sprung_disp(1)*hcm.MRF;
    Fks(2) = -hcm.Ks(3)*sprung_disp(2)*hcm.MRR;
    
    Faero = -0.5*(hcm.sp + hcm.fws + hcm.rws)*SIM.L;
    Fg = -hcm.Ms*hcm.g0/2;
    
    Zsdd = (1/(hcm.Ms/2)) * (sum(Fcs + Fks) + Faero + Fg);
    pitchdd = (1/hcm.Ipitch) * (Mlong - hcm.Lcr*(Fks(2) + Fcs(2)) + hcm.Lcf*(Fks(1) + Fcs(1)) - (hcm.cg - hcm.cp)*hcm.Lc*Faero);

    % Output
    S.rolldd = 0;
    S.pitchdd = pitchdd;
    S.Zsdd = Zsdd;
    
    S.roll = 0;
    S.pitch = 0;
    S.Zs = 0;
    
    S.sprung_vel = sprung_vel;
    S.sprung_disp = sprung_disp;
    S.Faero = Faero;
   
end