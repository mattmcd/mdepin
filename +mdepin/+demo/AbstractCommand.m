classdef AbstractCommand < handle & mdepin.Bean
    %ABSTRACTCOMMAND Command Design Pattern
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details  
    
    methods
        function obj = AbstractCommand(config)
            obj = obj@mdepin.Bean(config);
        end
    end
    
    methods (Abstract)
        execute(obj)
    end
    
end

