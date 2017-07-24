function varargout = skewness(varargin)
    varargout = sig.operate('sig','skewness',...
                            initoptions,@init,@main,@after,varargin);
end


%%
function options = initoptions
    options = sig.signal.signaloptions('FrameAuto',.05,.5);
end


%%
function [x type] = init(x,option,frame)
    if x.istype('sig.signal')
        x = sig.spectrum(x,'FrameConfig',frame);
    end
    type = 'sig.signal';
end


function out = main(in,option)
    x = in{1};
    if ~strcmpi(x.yname,'Skewness')
        res = sig.compute(@routine,x.Ydata,x.xdata);
        x = sig.signal(res,'Name','Skewness',...
                       'Srate',x.Srate,'Ssize',x.Ssize,...
                       'FbChannels',x.fbchannels);
    end
    out = {x};
end


function out = routine(d,f)
    e = d.apply(@algo,{f},{'element'},1);
    out = {e};
end


function y = algo(d,f)
    [s,c] = sig.spread.algo(d,f);
    y = sum((f'-c).^3.* (d/sum(d)) ) ./ s.^3;
end


function x = after(x,option)
end