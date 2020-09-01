% getChannelWeights.m
% Author: Kevin Chu
% Last Modified: 05/02/2020

function w = getChannelWeights(filter_slope,char_freqs)
    % Calculates the weights of the analysis filter envelopes that
    % correspond to the given filter slope in dB/octave.
    %
    % Args:
    %   -filter_slope (double): slope of synthesis filters in dB/octave.
    %   Note that this value is positive.
    %   -char_freqs (nChannelsx1 array): carrier frequencies in Hz
    %
    % Returns:
    %   -w (nChannelsxnChannels matrix): channel weights expressed as
    %   proportion of current at the stimulated channel

    char_freqs = char_freqs(:)';

    % Preallocate matrix of weights
    w = zeros(numel(char_freqs),numel(char_freqs));

    for i = 1:numel(char_freqs)
        deltaOctave = abs(log2(char_freqs/char_freqs(i)));
        w(i,:) = 10.^(-filter_slope*deltaOctave/20);
    end
       
end