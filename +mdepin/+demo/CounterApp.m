classdef CounterApp < handle & mdepin.Bean
    %COUNTERAPP Simple counter application  
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    properties
        GUI
        Data
    end
    
    methods
        function obj = CounterApp(config)
            obj = obj@mdepin.Bean(config);
        end
        
        function delete(obj)
            % Close figures and remove underlying data objects.
            
            % Close the figure even if we've added extra views outside main
            % GUI
            delete(ancestor(obj.GUI.ParentHandle, 'figure'));
            delete(obj.Data);
        end
        
        function init(obj)
            obj.GUI.init();
            % Delete application if GUI closed
            addlistener(ancestor(obj.GUI.ParentHandle, 'figure'), ...
                'ObjectBeingDestroyed', @(s,e) delete(obj));
            % Trigger GUI update
            val = obj.Data.Value;
            obj.Data.Value = val;
        end
    end
    
    methods (Static)
        function varargout = create()
            %MDEPIN.DEMO.COUNTERAPP.CREATE Create demo CounterApp
            
            ctx.App.class = 'mdepin.demo.CounterApp';
            ctx.App.GUI = 'View';
            ctx.App.Data = 'Counter';
            ctx.Counter.class = 'mdepin.demo.Counter';
            ctx.View.class = 'mdepin.demo.UpDownView';                  
            ctx.View.Command.Up = 'Increment';
            ctx.View.Command.Down = 'Decrement';
            % Insert commands
            ctx.Increment.class = 'mdepin.demo.IncrementCommand';
            ctx.Increment.Data = 'Counter';
            ctx.Decrement.class = 'mdepin.demo.DecrementCommand';
            ctx.Decrement.Data = 'Counter';               
            % Create GUI
            f = figure('Name', 'Up Down Display', 'NumberTitle', 'off', ...
                'MenuBar', 'none', 'Position', [100 200 400 300]);
            controlPanel = uipanel( 'Parent', f, 'Units', 'Normalized', ...
                'Position', [0 0 0.5 1]);
            dispPanel = uipanel( 'Parent', f, 'Units', 'Normalized', ...
                'Position', [0.5 0 0.5 1]);
            dispH = uicontrol('Parent', dispPanel, 'style', 'text', ...
                'Units', 'Normalized', 'Position', [0 0.25 1 0.5], ...
                'FontSize', 18);
            % Two panel GUI with control and display
            ctx.View.ParentHandle = controlPanel;
            obj = mdepin.createApplication( ctx, 'App' );
            obj.init();
            addlistener( obj.Data, 'Value', 'PostSet', ...
                @(s,e) set(dispH, 'String', num2str(e.AffectedObject.Value)));
            obj.Data.Value = 0;
            if nargout>0
                varargout{1} = obj;
            end
        end
    end
    
end

