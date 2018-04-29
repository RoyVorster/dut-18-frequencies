function [Zsldd, Zsrdd] = coupling_segway(Zsdd, rolldd, hcm)
    
   Zsldd = (rolldd*0.5*hcm.Lcw) + Zsdd;
   Zsrdd = (rolldd*0.5*hcm.Lcw) + Zsdd;

end