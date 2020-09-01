% generateVocodedSpeechWithCurrentSpread.m
% Author: Kevin Chu
% Last Modified: 05/02/2020

function audio = generateVocodedSpeechWithCurrentSpread(p,y,filter_slope)
    % This function implements a sine wave vocoder with current spread. 
    % Current spread is modeled by calculating a weighted sum of the 
    % analysis band envelopes. The weights simulate the exponential decay 
    % in current that occurs for linear increases in distance from the 
    % stimulated channel. The amount of current spread is controlled by 
    % the filter_slope parameter. This implementation is based on Oxenham 
    % and Kreft, 2014.
    %
    % Args:
    %   -p (struct): CI processing map
    %   -y (struct): output of CI processed signal
    %   -filter_slope (double): slope of synthesis filters in dB/octave.
    %   Note that this value is positive.
    %
    % Returns:
    %   -audio (array): array containing the vocoded signal
    %
    % References:
    %   -A. J. Oxenham and H. A. Kreft, "Speech Perception in Tones and
    %   Noise via Cochlear Implants Reveals Influence of Spectral
    %   Resolution on Temporal Processing," Trends in Hearing, vol. 18, pp.
    %   1-14, 2014.

    % Invert channel mapping and loudness growth processes to obtain
    % envelope amplitudes
    y = Channel_mapping_inv_proc(p,y);
    y = LGF_sequence_inv_proc(p,y);
    
    % Reconstruction rate of vocoded speech
    oversample_factor = 2;
    
    % Stimulation period in samples
    period = y.periods/10^6*p.audio_sample_rate;
    
    % Audio length
    aud_length = oversample_factor*round(numel(y.channels)*period);
    
    % Determine channel weights needed to achieve desired current spread
    w = getChannelWeights(filter_slope,p.char_freqs);

    % Create sine wave carriers at the center frequencies of the analysis
    % filters (obtained from CI processing map)
    carriers = sin(2*pi*repmat(p.char_freqs,1,aud_length)/(p.audio_sample_rate*oversample_factor).*repmat(1:aud_length,p.num_bands,1));

    % Calculate the unweighted envelopes of the analysis bands using
    % overlap and add
    modulation = zeros(p.num_bands,aud_length);
    for i = 1:numel(y.channels)
        if y.channels(i) ~= 0       
            t = round(i*period*oversample_factor);
            window_len = min(p.block_length,aud_length-t);
            modulation(y.channels(i),t:t+window_len-1) = modulation(y.channels(i),t:t+window_len-1) + (p.window(1:window_len)*y.magnitudes(i))';
        end
    end

    % Calculate weighted sum of envelopes and modulate the carriers
    mod_weighted = sqrt(((w.^2)*(modulation.^2)));
    audio = sum(mod_weighted.*carriers,1);
    
    % Downsample to original sampling frequency and normalize to [-1,1] to
    % eliminate clipping
    audio = decimate(audio,oversample_factor);
    audio = audio/max(abs(audio));
end
