% generateSynthesisFilters.m
% Author: Kevin Chu
% Last Modified: 04/25/2020

function b = generateSynthesisFilters(p,varargin)
    % Generate synthesis filters for vocoder
    %
    % Args:
    %   -p (struct): CI processing map
    %   -varargin: option to include current decay rate
    %
    % Returns:
    %   -b (nChannels x nFrames matrix): FIR filter coefficients

    % Parameters
    filter_order = 512;

    b = cell(numel(p.char_freqs),1);    
    for i = 1:numel(p.char_freqs)
        switch nargin
            % No current spread
            case 1
                b{i} = fir1(filter_order,[p.char_freqs(i)-p.band_widths(i)/2,p.char_freqs(i)+p.band_widths(i)/2]/p.audio_sample_rate);
            % Current spread
            case 2
                b{i} = generateSynthesisFilter(p.char_freqs(i),p.audio_sample_rate,varargin{1},filter_order);
        end
    end
    
    b = vertcat(b{:});

end
