function [Flatf, Mlatf, Mlatr, Flatr] = lateral_load(A, fcm)

    Mlatf = A*(fcm.Msloc(1) + fcm.Msloc(2))*(fcm.Hcgs - fcm.Rcf);
    Mlatr = A*(fcm.Msloc(3) + fcm.Msloc(4))*(fcm.Hcgs - fcm.Rcr);
    
    Fuf = (2*A*fcm.Muf*fcm.Hcgu)/fcm.Lcw; 
    Fur = (2*A*fcm.Mur*fcm.Hcgu)/fcm.Lcw;
    
    Flatf = (Fuf + (A*fcm.Msf*fcm.Rcf)/fcm.Lcw);
    Flatr = (Fur + (A*fcm.Msr*fcm.Rcr)/fcm.Lcw);
    
end