% frq2place.m
% Author: Kevin Chu
% Last Modified: 04/25/2020

function x = frq2place(F)
    % Converts frequency (Hz) to location along the basilar membrane (in
    % mm) using Greenwood's place-to-frequency function
    %
    % Args:
    %   -F (double or vector): frequency (Hz)
    %
    % Returns:
    %   -x (double): location along the basilar membrane (mm)

    % Constants
    A = 165.4;
    a = 0.06;
    k = 1;
    
    x = log10(F/A + k)*1/a;

end