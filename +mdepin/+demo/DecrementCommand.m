classdef DecrementCommand < mdepin.demo.AbstractCommand
    %DECREMENTCOMMAND Command to decrement counter
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    properties
        Data
    end
    
    methods
        function obj = DecrementCommand(config)
            obj = obj@mdepin.demo.AbstractCommand(config);
        end
        
        function execute(obj)
            obj.Data.decrement();
        end
    end
    
end

