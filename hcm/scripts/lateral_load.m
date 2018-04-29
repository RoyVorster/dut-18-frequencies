function [Flatf, Mlatf] = lateral_load(SIM, hcm)

    d = 0;
    Rc = hcm.Rcr;
    if (SIM.front_rear == 0)
        d = 2;
        Rc = hcm.Rcf;
    end
    
    Mlatf = SIM.Alat*hcm.Msloc(1 + d)*2*(hcm.Hcgs - Rc);
    Fu = (2*SIM.Alat*hcm.Muloc(1 + d)*hcm.Hcgu)/hcm.Lcw; 
    
    Flatf = (Fu + SIM.Alat*hcm.Msloc(1 + d)*2*Rc)/hcm.Lcw;
    
end