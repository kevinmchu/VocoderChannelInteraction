% generateFilterBingabr2008.m
% Author: Kevin Chu
% Last Modified: 05/01/2020

function b = generateFilterBingabr2008(Fc,fs,ac,filter_order)
    % Generates synthesis filter
    %
    % Args:
    %   -Fc (double): filter center frequency in Hz
    %   -fs (double): sampling frequency in Hz
    %   -ac (double): current decay in dB/mm
    %   -filter_order (int): order of bandpass filter
    %
    % Returns:
    %   -b (double): filter coefficients

    % Parameters
    npts = 1000; % number of points used to estimate filter
    
    % Calculate slope of synthesis filter
    as = spread2slope(ac);
    
    % Frequencies used to create the filter
    f = linspace(0,fs,npts);

    % Get vector of locations
    xc = frq2place(Fc); 
    x_band = frq2place(f);

    % Get magnitudes
    m_db = -as*abs(xc - x_band); 
    m = 10.^(m_db/20);

    % Create the filter
    b = fir2(filter_order,f/fs,m);
end