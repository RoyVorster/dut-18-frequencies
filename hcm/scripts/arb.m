function ARB = arb(Zur, Zul, roll, SIM, hcm)
    
    if (SIM.front_rear == 0) % Front ARB
        arbs = hcm.arbsf;
    else
        arbs = hcm.arbsr;
    end

    roll_u = (Zur - Zul)/hcm.Lcw;
    Marb = -(roll - roll_u)*(180/pi)*arbs;
    
    Fu = Marb*0.5*hcm.Lcw;
    
    ARB.Farb = Fu;
    ARB.Marb = Marb;    
    ARB.roll_u = roll_u;
    
end