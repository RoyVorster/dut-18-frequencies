function C = get_damper(vel, mode, dat, const)
    
    C = 0;

    if (mode == 0) % Linear mode
        for i = 1:length(dat) - 1
            if (vel <= dat(i + 1,1))
               C = dat(i,2);
               break
            end
        end
        
        if (C == 0)
            C = dat(end,2);
        end
    elseif (mode == 1) % Interpolate data points
        C = interp1(dat(1,:), dat(2,:), vel);
    elseif (mode == 2) % Constant
        C = const;
    end
    
end