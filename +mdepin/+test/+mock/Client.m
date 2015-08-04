classdef Client < mdepin.Bean
    %CLIENT Mock Client
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    properties
        Service
    end
    
    methods
        function obj = Client(config)
            obj = obj@mdepin.Bean(config);
        end
        
        function val = getValue(obj)
            val = obj.Service.getValue();
        end
    end
    
end

