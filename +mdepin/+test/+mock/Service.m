classdef Service < mdepin.Bean
    %SERVICE Mock Service
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    properties
        Value
    end
    
    methods
        function obj = Service(config)
            obj = obj@mdepin.Bean(config);
        end
        
        function val = getValue(obj)
            val = obj.Value;
        end
    end
    
end

