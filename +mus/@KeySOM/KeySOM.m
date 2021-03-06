% MUS.KEYSOM CLASS
%
% Copyright (C) 2017-2018 Olivier Lartillot
%
% All rights reserved.
% License: New BSD License. See full text of the license in LICENSE.txt in
% the main folder of the MiningSuite distribution.

classdef KeySOM < sig.Signal
    methods
        function s = KeySOM(varargin)
            s = s@sig.Signal(varargin{:});
            if strcmp(s.yname,'Signal')
                s.yname = 'Key SOM';
            end
            s.Xaxis.name = '?';    
            s.xsampling = 1;
        end
        display(obj)
    end
end