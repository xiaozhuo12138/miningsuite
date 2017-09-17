% SIG.AUTOCOR CLASS
%
% Copyright (C) 2014, 2017 Olivier Lartillot
%
% All rights reserved.
% License: New BSD License. See full text of the license in LICENSE.txt in
% the main folder of the MiningSuite distribution.

classdef Autocor < sig.Signal
    properties
        normalized = 0;
        window
        normwin
    end
    methods
        function s = Autocor(varargin)
          	s = s@sig.Signal(varargin{:});
            if strcmp(s.yname,'Signal')
                s.yname = 'Autocor';
            end
            s.Xaxis.subunit = sig.subunit('Frequency','Hz',@time2freq);
            s.xname = 'Lag';
            s.xunit = 's';
        end
        
        obj = normalize(obj,win);
        obj = hwr(obj);
        obj = enhance(obj,param);
    end
end


function f = time2freq(t)
    f = 1./t;
end