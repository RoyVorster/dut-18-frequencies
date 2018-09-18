clc
clear 

addpath(genpath('scripts/'))

busCreation
save buses.mat

%% Global constants

g0 = 9.80665;
rho0 = 1.2250;

sim_time = 20;
sim_step = 1e-3;

your_dut = 18;

setV = 0; % 0 = Use this constant V, Alat and Along. 1 = Use sim vars

%% Simulation input

V = 10;
Alat = 0 * g0; % [ms^-2] 
Along = 0 * g0; % [ms^-2]

if (V ~= 0)
    [road_input, time_step] = sample_road_profile(3, sim_time, 35, 1);
    hx_left = road_input.hx_left;
    hx_right = road_input.hx_right;
else
    hx_left = 0;
    hx_right = 0;
    time_step = 0.001;
end

%% Init

switch your_dut
    case 16
        constants16
    case 17
        constants17
    case 18
        constants18
    otherwise
        disp("Not a car man")
end

clearvars road_input

