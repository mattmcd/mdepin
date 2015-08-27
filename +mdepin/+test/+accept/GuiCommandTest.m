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
            ctx.App.Command.Up = 'DisplayUp';
            ctx.App.Command.Down =  'DisplayDown';
            ctx.DisplayUp.class = 'mdepin.demo.DisplayCommand';
            ctx.DisplayUp.DisplayName = 'Up';
            ctx.DisplayDown.class = 'mdepin.demo.DisplayCommand';
            ctx.DisplayDown.DisplayName = 'Down';   
            testCase.App = mdepin.createApplication( ctx, 'App' );
        end
        
        function createCounterGUI(testCase)
            ctx.App.class = 'mdepin.demo.CounterApp';
            ctx.App.GUI = 'View';
            ctx.App.Data = 'Counter';
            ctx.Counter.class = 'mdepin.demo.Counter';
            ctx.View.class = 'mdepin.demo.UpDownView';                  
            ctx.View.Command.Up = 'Increment';
            ctx.View.Command.Down = 'Decrement';
            ctx.Increment.class = 'mdepin.demo.IncrementCommand';
            ctx.Increment.Data = 'Counter'; 
            ctx.Decrement.class = 'mdepin.demo.DecrementCommand';
            ctx.Decrement.Data = 'Counter';              
            testCase.App = mdepin.createApplication( ctx, 'App' );
        end
        
    end
    
end

