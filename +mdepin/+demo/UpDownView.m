classdef UpDownView < mdepin.demo.AbstractView
    %UPDOWNVIEW View with buttons to go up and down
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
        
    methods
        function obj = UpDownView(config)
            obj = obj@mdepin.demo.AbstractView(config);
        end
        
        function delete(obj)            
            if obj.IsFigure
                delete(obj.ParentHandle);
            end
        end
        
        function constructGUI(obj)
            parentHandle = obj.ParentHandle;
            noParent = isempty(parentHandle) || ~ishandle(parentHandle);
            if noParent
                parentHandle = figure(...
                    'Name', 'Up and Down', 'NumberTitle', 'off', ...
                    'Position', [200 100 150 300], ...
                    'CloseRequestFcn', @(src,evt) delete(obj));  
                obj.IsFigure = true;
            end
            % Create two buttons
            up = uicontrol('Parent', parentHandle, 'Style', 'pushbutton', ...
                'Units', 'Normalized', ...
                'Position', [0 0.5 1 0.5], 'String', 'Up', 'tag', 'Up');
            down = uicontrol('Parent', parentHandle, 'Style', 'pushbutton', ...
                'Units', 'Normalized', ...
                'Position', [0 0 1 0.5], 'String', 'Down', 'tag', 'Down');
            obj.ParentHandle = parentHandle;
            obj.GUIHandle.UpButton = up;
            obj.GUIHandle.DownButton = down;
        end
        
        function initGUI(obj)
            controls = {'UpButton', 'DownButton'};
            commands = {'Up', 'Down'};
            obj.setCallback(controls, commands);
        end
    end
    
end

