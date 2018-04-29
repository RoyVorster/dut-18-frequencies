clc
clear 

addpath(genpath('scripts/'))
busCreation

clear

load buses.mat

%% Global constants

g0 = 9.80665;
rho0 = 1.2250;

sim_time = 2.0;
sim_step = 1e-3;

your_dut = 18;
front_rear = 1; % Applies to segway models (0 = front, 1 = rear)

setV = 0; % 0 = Use this constant V, Alat and Along. 1 = Use sim vars

loc = 1; % Set location of quarter car model [FL; FR; RL; RR]

%% Simulation input

V = 10;
Alat = 0 * g0; % [ms^-2] 
Along = 0 * g0; % [ms^-2]

if (V ~= 0)
    [road_input, time_step] = sample_road_profile(3, sim_time, 35, 0);
    hx_left = road_input.hx_left;
    hx_right = road_input.hx_right;
else
    hx_left = 0;
    hx_right = 0;
    time_step = 0.001;
end

%% Init

if (your_dut == 16)
    constants16
elseif (your_dut == 18)
    constants18
else
    disp("Niet hopen.")
end

clearvars road_input 

