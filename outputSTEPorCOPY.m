function output = outputSTEPorCOPY(STEPorCOPY, step, timeStep_s, accX, accY, accZ, amp, mag)
% outputSTEPorCOPY Summary of this function goes here
% This function enables to generate text data for STEP/COPY array used in 
% input file for COM3 (nonlinear FEM developed in concrete laboratory at 
% UTokyo)
% 
% Detailed explanation goes here futher do: 行列にも対応する

if STEPorCOPY == 'STEP'
    s_steporcopy = sprintf('%-5s', 'STEP');
else
    s_steporcopy = sprintf('%-5s', 'COPY');
end

s_step = sprintf('%5d', step);
s_time = sprintf('%10.2f', timeStep_s);
s_accX = sprintf('%10.2f', accX);
s_accY = sprintf('%10.2f', accY);
s_accZ = sprintf('%10.2f', accZ);
s_amp = sprintf('%30.2f', amp);
s_mag = sprintf('%10.2f', mag);
output = join(horzcat(s_steporcopy, s_step, s_time, s_accX, s_accY, s_accZ, s_amp, s_mag), '');
end

