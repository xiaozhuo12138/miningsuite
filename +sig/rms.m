% SIG.RMS
%
% Copyright (C) 2014, 2017-2018, Olivier Lartillot
%
% All rights reserved.
% License: New BSD License. See full text of the license in LICENSE.txt in
% the main folder of the MiningSuite distribution.

function varargout = rms(varargin)
    varargout = sig.operate('sig','rms',...
                            initoptions,@init,@main,@after,varargin,'plus');
end


%%
function options = initoptions
    options = sig.Signal.signaloptions('FrameAuto',.05,.5);    
end


%%
function [x,type] = init(x,option)
    if option.frame
        x = sig.frame(x,'FrameSize',option.fsize.value,option.fsize.unit,...
                        'FrameHop',option.fhop.value,option.fhop.unit);
    end
    type = 'sig.Signal';
end


function out = main(in,option)
    x = in{1};
    if ~strcmpi(x.yname,'RMS')
        [d,Sstart,Send] = sig.compute(@routine,x.Ydata,x.Sstart,x.Send);
        x = sig.Signal(d,'Name','RMS',...
                       'Sstart',Sstart,'Send',Send,...
                       'Srate',x.Frate,'Ssize',x.Ssize,...
                       'FbChannels',x.fbchannels);
    end
    out = {x};
end


function out = routine(d,ss,se)
    if find(strcmp('element',d.dims))
        dim = 'element';
    else
        dim = 'sample';
    end
    d = d.apply(@algo,{},{dim},1);
    d = d.deframe;
    out = {d,ss,se};
end


function y = algo(x)
    y = x'*x;
end


function out = after(in,option)
    x = in{1};
    if find(strcmp('element',x.Ydata.dims))
        dim = 'element';
    else
        dim = 'sample';
    end
    x.Ydata = sig.compute(@routine_norm,x.Ydata,x.Ssize,dim);
    out = {x};
end


function d = routine_norm(d,Ssize,dim)
    d = d.apply(@afternorm,{Ssize},{dim},Inf);
end


function d = afternorm(d,l)
    d = sqrt(d/l);
end