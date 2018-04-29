function [Flongf, Flongr, Mlong] = longitudinal_load(SIM, fcm)

    Mlong = SIM.Along*fcm.Ms*(fcm.Hcgs - fcm.Pc);
    
    Fuf = ((fcm.Muf + fcm.Mur)*SIM.Along*fcm.Hcgu)/fcm.Lcf;
    Fur = ((fcm.Muf + fcm.Mur)*SIM.Along*fcm.Hcgu)/fcm.Lcr;
    
    Flongf = Fuf + (SIM.Along*fcm.Ms*fcm.Pc)/fcm.Lc;
    Flongr = -(Fur + (SIM.Along*fcm.Ms*fcm.Pc)/fcm.Lc);

end