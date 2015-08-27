classdef AbstractView < handle & mdepin.Bean
    %ABSTRACTVIEW Holds view handles and sets up callbacks
    %   
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    properties
        ParentHandle
        GUIHandle
        Command
        IsFigure = false
    end
    
    methods
        function obj = AbstractView(config)
            obj = obj@mdepin.Bean(config);
        end     
        
        function call(obj, control, evtData)
            if ~exist('evtData', 'var')
                evtData = [];
            end
            cbFun = get(obj.GUIHandle.(control), 'Callback');
            cbFun(obj.GUIHandle.(control), evtData);
        end
        
        function setCallback(obj, control, command)
            assert(numel(control)==numel(command), ...
                'number:mismatch', 'Must specify command for each control');
            for ii = 1:numel( control )
                thisControl = control{ii};
                thisCommand = command{ii};
                thisHandle = obj.GUIHandle.(thisControl);
                assert(ishandle(thisHandle), ...
                    'null:handle', ...
                    'Control %s does not exist', thisControl);
                
                commandMissing = isempty(obj.Command) || ...
                    (isstruct(obj.Command) && ~isfield(obj.Command, thisCommand));
                if commandMissing
                    set(thisHandle, 'Callback', @(s,e) disp(thisCommand));
                else
                    thisCommandObj = obj.Command.(thisCommand);
                    set(thisHandle, 'Callback', @(s,e) thisCommandObj.execute());
                end
            end
        end
    end
    
    methods (Abstract)
        constructGUI(obj)
        initGUI(obj)
    end
    
end

