% spread2slope.m
% Author: Kevin Chu
% Last Modified: 05/01/2020

function as = spread2slope(ac)
    % Converts from current spread in dB/mm to slope of synthesis filters in
    % dB/mm
    %
    % Args:
    %   -ac (double): current decay in dB/mm
    %
    % Returns:
    %   -as (double): slope of synthesis filters in dB/mm

    % Constants (don't change)
    dr_nh = 50; % dB
    dr_ci = 15; % dB
    
    as = ac*dr_nh/dr_ci; % dB/mm
end