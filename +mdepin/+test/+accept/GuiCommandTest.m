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
    end
    
end

