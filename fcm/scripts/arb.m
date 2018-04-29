function ARB = arb(Zur, Zul, roll, loc, fcm)
    
    if (loc == 0) % Front ARB
        arbs = fcm.arbsf;
    elseif (loc == 1) % Rear ARB
        arbs = fcm.arbsr;
    end

    roll_u = (Zur - Zul)/fcm.Lcw;
    Marb = -(roll - roll_u)*(180/pi)*arbs;
    
    Fu = Marb*0.5*fcm.Lcw;
    
    ARB.Farb = Fu;
    ARB.Marb = Marb;    
    ARB.roll_u = roll_u;
    
end