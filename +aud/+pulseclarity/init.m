% AUD.PULSECLARITY.INIT
%
% Copyright (C) 2017 Olivier Lartillot
%
% All rights reserved.
% License: New BSD License. See full text of the license in LICENSE.txt in
% the main folder of the MiningSuite distribution.

function [x, type] = init(x,option,frame,tempo_frame,tempo_noframe)
    if nargin < 4
        tempo_frame = @aud_tempo_frame;
        tempo_noframe = @aud_tempo_noframe;
    end
%         if isframed(x)
%             warning('WARNING IN MIRTEMPO: The input should not be already decomposed into frames.');
%             disp('Suggestion: Use the ''Frame'' option instead.')
%         end
    if x.istype('sig.Autocor')
        type = {'sig.signal','sig.Autocor'};
    elseif length(option.model) > 1
        %...
    else
        if option.model
            switch option.model
                case 1
                case 2
                    option.envmeth = 'Filter';
                    option.fbtype = 'Gammatone';
                    option.mu = 0;
                    option.r = 0;
                    option.lambda = .8;
                    option.sum = 'After';
            end
        end
        if length(option.stratg)>7 && strcmpi(option.stratg(end-6:end),'Autocor')
            if (strcmpi(option.stratg,'MaxAutocor') || ...
                    strcmpi(option.stratg,'MinAutocor') || ...
                    strcmpi(option.stratg,'EntropyAutocor'))
                option.m = 0;
            end
            if strcmpi(option.stratg,'MinAutocor')
                option.enh = 0;
            end
            if ~isempty(frame) && frame.toggle
                x = tempo_frame(x,option,frame);
            else
                x = tempo_noframe(x,option);
            end
            type = {'sig.signal','sig.Autocor'};
        end
    end
end


function y = aud_tempo_frame(x,option,frame)
    y = aud.tempo(x,option.fea,'Method',option.envmeth,...
                    option.band,...
                    'Sum',option.sum,'Enhanced',option.enh,...
                    'Smooth',option.aver,...
                    'HalfwaveDiff',option.diffhwr,...
                    'Lambda',option.lambda,...
                    'FilterbankType',option.fbtype,...
                    'FilterType',option.ftype,...
                    'Filterbank',option.fb,'Mu',option.mu,...
                    'Log',option.log,...
                    'Inc',option.inc,'Halfwave',option.hw,...
                    'Median',option.median(1),option.median(2),...
                    'Min',option.mi,'Max',option.ma,...
                    'Total',option.m,'Contrast',option.thr,...
                    'Frame','FrameSize',frame.size.value,frame.size.unit,...
                    'FrameHop',frame.hop.value,frame.hop.unit);
end


function y = aud_tempo_noframe(x,option)
    y = aud.tempo(x,option.fea,'Method',option.envmeth,...
                    option.band,...
                    'Sum',option.sum,'Enhanced',option.enh,...
                    'Smooth',option.aver,...
                    'HalfwaveDiff',option.diffhwr,...
                    'Lambda',option.lambda,...
                    'FilterbankType',option.fbtype,...
                    'FilterType',option.ftype,...
                    'Filterbank',option.fb,'Mu',option.mu,...
                    'Log',option.log,...
                    'Inc',option.inc,'Halfwave',option.hw,...
                    'Median',option.median(1),option.median(2),...
                    'Min',option.mi,'Max',option.ma,...
                    'Total',option.m,'Contrast',option.thr);
end