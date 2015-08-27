classdef IncrementCommand < mdepin.demo.AbstractCommand
    %INCREMENTCOMMAND Command to decrement counter
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    properties
        Data
    end
    
    methods
        function obj = IncrementCommand(config)
            obj = obj@mdepin.demo.AbstractCommand(config);
        end
        
        function execute(obj)
            obj.Data.increment();
        end
    end
    
end

