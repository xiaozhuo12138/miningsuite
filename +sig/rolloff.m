% SIG.ROLLOFF
%
% Copyright (C) 2014, 2017-2018 Olivier Lartillot
% Copyright (C) 2007-2009 Olivier Lartillot & University of Jyvaskyla
%
% All rights reserved.
% License: New BSD License. See full text of the license in LICENSE.txt in
% the main folder of the MiningSuite distribution.

function varargout = rolloff(varargin)
    varargout = sig.operate('sig','rolloff',...
                      initoptions,@init,@main,@after,varargin);
end


%%
function options = initoptions
    options = sig.Signal.signaloptions('FrameAuto',.05,.5);

        p.key = 'Threshold';
        p.type = 'Numeric';
        p.default = 85;
    options.p = p;

%         minrms.key = 'MinRMS';
%         minrms.when = 'After';
%         minrms.type = 'Numerical';
%         minrms.default = .005;
%     options.minrms = minrms;
end


%%
function [x,type] = init(x,option,frame)
    if x.istype('sig.Signal')
        if option.frame
            x = sig.frame(x,'FrameSize',option.fsize.value,option.fsize.unit,...
                            'FrameHop',option.fhop.value,option.fhop.unit);
        end
        x = sig.spectrum(x);   
    end
    type = 'sig.Signal';
end


function out = main(in,option)
    x = in{1};
    if option.p>1
        option.p = option.p/100;
    end
    if ~strcmpi(x.yname,'Roll-off')
        res = sig.compute(@routine,x.Ydata,x.xdata,option.p);
        x = sig.Signal(res,'Name','Roll-off','Unit','Hz.',...
                           'Srate',x.Srate,'Sstart',x.Sstart,'Send',x.Send,...
                           'Ssize',x.Ssize,'FbChannels',x.fbchannels);
    end
    out = {x};
end


function out = routine(d,f,p)
    d = d.apply(@algo,{f,p},{'element'},1);
    out = {d};
end


function v = algo(m,f,p)
    cs = cumsum(m);          % accumulation of spectrum energy
    thr = cs(end)*p;   % threshold corresponding to the rolloff point
    fthr = find(cs >= thr,1); % find the location of the threshold
    if isempty(fthr)
        v = NaN;
    else
        v = f(fthr);
    end
end


function x = after(x,option)
end