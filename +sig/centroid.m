% SIG.CENTROID
%
% Copyright (C) 2017 Olivier Lartillot
% ? 2007-2009 Olivier Lartillot & University of Jyvaskyla
%
% All rights reserved.
% License: New BSD License. See full text of the license in LICENSE.txt in
% the main folder of the MiningSuite distribution.

function varargout = centroid(varargin)
    varargout = sig.operate('sig','centroid',...
                            initoptions,@init,@main,@after,varargin);
end


%%
function options = initoptions
    options = sig.Signal.signaloptions('FrameAuto',.05,.5);
end


%%
function [x type] = init(x,option,frame)
    if x.istype('sig.Signal')
        x = sig.spectrum(x,'FrameConfig',frame);
    end
    type = 'sig.Signal';
end


function out = main(in,option)
    x = in{1};
    if ~strcmpi(x.yname,'Centroid')
        res = sig.compute(@routine,x.Ydata,x.xdata);
        x = sig.Signal(res,'Name','Centroid',...
                       'Srate',x.Srate,'Ssize',x.Ssize,...
                       'FbChannels',x.fbchannels);
    end
    out = {x};
end


function out = routine(d,f)
    e = d.apply(@sig.centroid.algo,{f},{'element'},1);
    out = {e};
end


function x = after(x,option)
end