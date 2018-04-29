function [Zsfdd, Zsrdd] = coupling_bicycle(Zsdd, pitchdd, hcm)
    
   Zsfdd = (pitchdd * hcm.Lcf) + Zsdd;
   Zsrdd = -(pitchdd * hcm.Lcr) + Zsdd;

end