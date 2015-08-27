%% MATLAB Dependency Injection - GUI example
% Dependency injection is a technique for constructing an application from
% components without the individual components needing to be coupled to a
% paticular implementation of other components.
%
% In this script we construct simple Graphical User Interfaces (GUIs) that
% allow the user to press Up and Down buttons.  In the first GUI this
% results in 'Up' or 'Down' being displayed to the command line, while in
% the second a counter is incremented or decremented.  The important thing
% to note is that the difference in behaviour results from plugging
% different components together rather than changing the underlying code.
%
% Additionally, the command pattern is used to decouple the GUI from the
% object on which it performs actions (if any).

%% Up/Down GUI with command line display
% We first define the application context as a struct of components:

ctx.App.class = 'mdepin.demo.UpDownView';
ctx.DisplayUp.class = 'mdepin.demo.DisplayCommand';
ctx.DisplayUp.DisplayName = 'Up';
ctx.DisplayDown.class = 'mdepin.demo.DisplayCommand';
ctx.DisplayDown.DisplayName = 'Down';
displayApp = mdepin.createApplication( ctx, 'App' );
% Insert commands
displayApp.Command.Up = mdepin.createApplication(ctx, 'DisplayUp');
displayApp.Command.Down = mdepin.createApplication(ctx, 'DisplayDown');
% Create the GUI and wire up callbacks
displayApp.init();
clear('ctx'); % To avoid any confusion in next part of script

%% Counter GUI
ctx.App.class = 'mdepin.demo.CounterApp';
ctx.App.GUI = 'View';
ctx.App.Data = 'Counter';
ctx.Counter.class = 'mdepin.demo.Counter';
ctx.View.class = 'mdepin.demo.UpDownView';
obj = mdepin.createApplication( ctx, 'App' );
% Insert commands - these now affect a data object
ctx.Increment.class = 'mdepin.demo.IncrementCommand';
ctx.Increment.Data = obj.Data;
ctx.Decrement.class = 'mdepin.demo.DecrementCommand';
ctx.Decrement.Data = obj.Data;
obj.GUI.Command.Up = mdepin.createApplication(ctx, 'Increment');
obj.GUI.Command.Down = mdepin.createApplication(ctx, 'Decrement');
% Extend GUI by adding display text
f = figure('Name', 'Up Down Display', 'NumberTitle', 'off', ...
    'MenuBar', 'none', 'Position', [100 200 400 300]);
controlPanel = uipanel( 'Parent', f, 'Units', 'Normalized', ...
    'Position', [0 0 0.5 1]);
dispPanel = uipanel( 'Parent', f, 'Units', 'Normalized', ...
    'Position', [0.5 0 0.5 1]);
dispH = uicontrol('Parent', dispPanel, 'style', 'text', ...
    'Units', 'Normalized', 'Position', [0 0.2 1 0.6], ...
    'FontSize', 18, 'String', num2str(obj.Data.Value));
% Two panel GUI with control and display
obj.GUI.ParentHandle = controlPanel;
obj.init();
addlistener( obj.Data, 'Value', 'PostSet', ...
    @(s,e) set(dispH, 'String', num2str(e.AffectedObject.Value)));

%%
% Copyright Matt McDonnell, 2015
% See LICENSE file for license details