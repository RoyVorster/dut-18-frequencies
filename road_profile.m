kVec = 1:9;
sim_time = 10;
V = 13;

hx_left = zeros();
hx_right = zeros();
dist_vec = zeros();
for i = 1:length(kVec)
    [rp, time_step] = road_profile_test(kVec(i), sim_time, V, 0);
    
    for j = 1:length(rp.hx_left)
        hx_left(i,j) = rp.hx_left(j); 
        hx_right(i,j) = rp.hx_right(j); 
        
        dist_vec(i,j) = sim_time*V*(j/length(rp.hx_left));
    end
    
    legendCell{i} = num2str(kVec(i), 'k = %-d');
end

figure 
for i = 1:length(hx_left(:,1))
    plot(hx_left(i,:))
    hold on
end

legend(legendCell)
    

function [rpOut, time_step] = road_profile_test(k, sim_time, V, plotOn)
% Road profile test, largely based on https://nl.mathworks.com/matlabcentral/answers/262428-how-can-i-get-this-pattern

%% Road profile constants

rp.k = k; % Values For ISO Road A-B Roughness Classification, from 1 to 9
rp.L = sim_time * V; % Length Of Road Profile (m)
rp.B  = 0.1; % Sampling Interval (m)
rp.N = rp.L / rp.B; % Number of samples
rp.dn = 1 / rp.L; % Frequency Band
rp.n0 = 0.1; % Spatial Frequency (cycles/m)
rp.n  = rp.dn : rp.dn : rp.N * rp.dn; % Spatial Frequency Band
rp.phi_right =  2 * pi * rand(size(rp.n)); % Random Phase Angle, right
rp.phi_left = 2 * pi * rand(size(rp.n)); % Random Phase Angle, left
rp.Amp1 = sqrt(rp.dn) * (2^rp.k) * (1e-3) * (rp.n0./rp.n); % Amplitude for Road  Class A-B
rp.x = 0:rp.B:rp.L-rp.B; % Abscissa Variable from 0 to L

rp.contact_patch = 0.07; % Contact patch, "12cm with heavy driver"
rp.index_step = (rp.contact_patch / 2) * (rp.N / rp.L); 

rp = struct(rp);

time_step = rp.B / V;

%% Road profile calculations (right)

rp.road_right = zeros(size(rp.x));
for i = 1:length(rp.x)
    rp.road_right(i) = sum(rp.Amp1.*cos(2*pi*rp.n*rp.x(i)+ rp.phi_right));
end
rpOut.hx_right = movmean(rp.road_right,[rp.index_step,rp.index_step]); % moving average
rp.hx_right_lowpass = movmean(rpOut.hx_right,[800, 800]);

%% Road profile calculations (left)

rp.road_left = zeros(size(rp.x));
for i = 1:length(rp.x)
    rp.road_left(i) = sum(rp.Amp1.*cos(2*pi*rp.n*rp.x(i)+ rp.phi_left));
end

rp.hx_left = movmean(rp.road_left,[rp.index_step,rp.index_step]);
rp.hx_left_lowpass = movmean(rp.hx_left,[800, 800]);
rp.left_about_zero = rp.hx_left - rp.hx_left_lowpass;
rpOut.hx_left = rp.hx_right_lowpass + rp.left_about_zero;

%% Road profile plot

if (plotOn)
    plot (rpOut.hx_right) 
    hold on
    plot (rpOut.hx_left)
end

rpOut = struct(rpOut);

end
