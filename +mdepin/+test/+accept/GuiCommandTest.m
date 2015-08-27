classdef GuiCommandTest < matlab.unittest.TestCase
    %GUICOMMANDTEST Test GUI constructed with dependency injection
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    properties
        App
    end
    
    methods (Test)
        function testCreateUpDownDisplayGUI(testCase)
            testCase.createSimpleDispGUI()
            testCase.App.constructGUI();
            testCase.App.initGUI();
            testCase.App.call('UpButton');
            testCase.App.call('DownButton');
            delete(testCase.App);
        end
        
        function testCreateUpDownDisplayWithCommandsGUI(testCase)
            testCase.createCommandDispGUI()
            testCase.App.constructGUI();
            testCase.App.initGUI();
            testCase.App.call('UpButton');
            testCase.App.call('DownButton');
            delete(testCase.App);
        end
        
        function testCreateCounterNoDisplayGUI(testCase)
            testCase.createCounterGUI()
            testCase.App.init();
            % Display 
            el = addlistener( testCase.App.Data, 'Value', 'PostSet', ...
                @(s,e) disp(e.AffectedObject.Value));
            testCase.App.GUI.call('UpButton');
            testCase.assertEqual(testCase.App.Data.Value, 1);
            testCase.App.GUI.call('DownButton');
            testCase.App.GUI.call('DownButton');
            testCase.assertEqual(testCase.App.Data.Value, -1);
            delete(testCase.App);
            delete(el);
        end
        
    end
    
    methods
        function createSimpleDispGUI(testCase)
            ctx.App.class = 'mdepin.demo.UpDownView';
            testCase.App = mdepin.createApplication( ctx, 'App' );
        end
        
        function createCommandDispGUI(testCase)
            ctx.App.class = 'mdepin.demo.UpDownView';                  
            ctx.DisplayUp.class = 'mdepin.demo.DisplayCommand';
            ctx.DisplayUp.DisplayName = 'Up';
            ctx.DisplayDown.class = 'mdepin.demo.DisplayCommand';
            ctx.DisplayDown.DisplayName = 'Down';   
            testCase.App = mdepin.createApplication( ctx, 'App' );
            % Insert commands
            testCase.App.Command.Up = mdepin.createApplication(ctx, 'DisplayUp');
            testCase.App.Command.Down = mdepin.createApplication(ctx, 'DisplayDown');
        end
        
        function createCounterGUI(testCase)
            ctx.App.class = 'mdepin.demo.CounterApp';
            ctx.App.GUI = 'View';
            ctx.App.Data = 'Counter';
            ctx.Counter.class = 'mdepin.demo.Counter';
            ctx.View.class = 'mdepin.demo.UpDownView';                  
            testCase.App = mdepin.createApplication( ctx, 'App' );
            % Insert commands
            ctx.Increment.class = 'mdepin.demo.IncrementCommand';
            ctx.Increment.Data = testCase.App.Data;
            ctx.Decrement.class = 'mdepin.demo.DecrementCommand';
            ctx.Decrement.Data = testCase.App.Data;   
            testCase.App.GUI.Command.Up = mdepin.createApplication(ctx, 'Increment');
            testCase.App.GUI.Command.Down = mdepin.createApplication(ctx, 'Decrement');
        end
        
    end
    
end

