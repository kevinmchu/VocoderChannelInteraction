% place2frq
% Author: Kevin Chu
% Last Modified: 04/25/2020

function F = place2frq(x)
    % Converts location along the basilar membrane (in mm) to frequency
    % (Hz) using Greenwood's place-to-frequency function
    %
    % Args:
    %   -x (double or vector): location along the basilar membrane (mm)
    %
    % Returns:
    %   -F (double): frequency (Hz)

    % Constants
    A = 165.4;
    a = 0.06;
    k = 1;
    
    F = A*(10.^(a*x)-k);

end
