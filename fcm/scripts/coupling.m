function [Zsfldd, Zsfrdd, Zsrldd, Zsrrdd] = coupling(rollfdd, rollrdd, pitchdd, Zsdd, fcm)
    
    Zsfldd = Zsdd + fcm.Lcf*pitchdd + (fcm.Lcw/2)*rollfdd;
    Zsfrdd = Zsdd + fcm.Lcf*pitchdd - (fcm.Lcw/2)*rollfdd;
    Zsrldd = Zsdd - fcm.Lcr*pitchdd + (fcm.Lcw/2)*rollrdd;
    Zsrrdd = Zsdd - fcm.Lcr*pitchdd - (fcm.Lcw/2)*rollrdd;

end