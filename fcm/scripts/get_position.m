function [gc, dt] = get_position(Zs, Zu, Zr, loc, Zs0)
    
    gc = -Zs + Zs0(loc) - Zr;
    dt = Zs - Zu;
    
end