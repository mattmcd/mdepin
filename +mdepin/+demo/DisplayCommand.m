classdef DisplayCommand < mdepin.demo.AbstractCommand
    %DISPLAYCOMMAND Display name of command to command line
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    properties
        DisplayName
    end
    
    methods
        function obj = DisplayCommand(config)
            obj = obj@mdepin.demo.AbstractCommand(config);
        end
        
        function execute(obj)
            disp(['Command: ', obj.DisplayName]);
        end
    end
    
end

