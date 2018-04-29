function [Fdeltaf, Mlong, Fdeltar] = longitudinal_load(A, fcm)

    Mlong = A*fcm.Ms*(fcm.Hcgs - fcm.Pc);
    
    Fuf = ((fcm.Muf + fcm.Mur)*A*fcm.Hcgu)/fcm.Lcf;
    Fur = ((fcm.Muf + fcm.Mur)*A*fcm.Hcgu)/fcm.Lcr;
    
    Fdeltaf = Fuf + (A*fcm.Ms*fcm.Pc)/fcm.Lc;
    Fdeltar = -(Fur + (A*fcm.Ms*fcm.Pc)/fcm.Lc);

end