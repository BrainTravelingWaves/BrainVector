function [sources_raw] = Amp2sources(sources_raw, Amp,SR )
% sources = Amp2sources(sources_init, Amp,SR);
% sources_init - import from Brainstorm 
% Amp - wave dynamics 
% SR - sampling frequency
% After the procedure, load the source into the brianstorm
    
    sources_raw.ImageGridAmp = Amp;
    N = size(Amp, 2);
    sources_raw.Time = [0:N-1] / SR;
end

