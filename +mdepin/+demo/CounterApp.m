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
            obj.GUI.constructGUI();
            obj.GUI.initGUI();
            % Delete application if GUI closed
            addlistener(ancestor(obj.GUI.ParentHandle, 'figure'), ...
                'ObjectBeingDestroyed', @(s,e) delete(obj));
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
            obj = mdepin.createApplication( ctx, 'App' );
            % Insert commands
            ctx.Increment.class = 'mdepin.demo.IncrementCommand';
            ctx.Increment.Data = obj.Data;
            ctx.Decrement.class = 'mdepin.demo.DecrementCommand';
            ctx.Decrement.Data = obj.Data;   
            obj.GUI.Command.Up = mdepin.createApplication(ctx, 'Increment');
            obj.GUI.Command.Down = mdepin.createApplication(ctx, 'Decrement');
            % Create GUI
            f = figure('Name', 'Up Down Display', 'NumberTitle', 'off', ...
                'MenuBar', 'none', 'Position', [100 200 400 300]);
            controlPanel = uipanel( 'Parent', f, 'Units', 'Normalized', ...
                'Position', [0 0 0.5 1]);
            dispPanel = uipanel( 'Parent', f, 'Units', 'Normalized', ...
                'Position', [0.5 0 0.5 1]);
            dispH = uicontrol('Parent', dispPanel, 'style', 'text', ...
                'Units', 'Normalized', 'Position', [0 0 1 1], ...
                'FontSize', 18, 'String', num2str(obj.Data.Value));
            % Two panel GUI with control and display
            obj.GUI.ParentHandle = controlPanel;
            obj.init();
            addlistener( obj.Data, 'Value', 'PostSet', ...
                @(s,e) set(dispH, 'String', num2str(e.AffectedObject.Value)));
            if nargout>0
                varargout{1} = obj;
            end
        end
    end
    
end

