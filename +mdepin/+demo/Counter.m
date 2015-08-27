classdef Counter < handle & mdepin.Bean
    %COUNTER Counter with increment and decrement methods
        
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    properties (SetObservable)
        Value = 0
    end
    
    methods
        function obj = Counter(config)
            obj = obj@mdepin.Bean(config);
        end
        
        function increment(obj)
            obj.Value = obj.Value + 1;
        end
        
        function decrement(obj)
            obj.Value = obj.Value - 1;
        end
    end
    
end

