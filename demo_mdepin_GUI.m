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
ctx.App.Command.Up = 'DisplayUp';
ctx.App.Command.Down =  'DisplayDown';
% Define commands
ctx.DisplayUp.class = 'mdepin.demo.DisplayCommand';
ctx.DisplayUp.DisplayName = 'Up';
ctx.DisplayDown.class = 'mdepin.demo.DisplayCommand';
ctx.DisplayDown.DisplayName = 'Down';

% Create the application object
displayApp = mdepin.createApplication( ctx, 'App' );
% Create the GUI and wire up callbacks
displayApp.init();
clear('ctx'); % To avoid any confusion in next part of script

%% Counter GUI
ctx.App.class = 'mdepin.demo.CounterApp';
ctx.App.GUI = 'View';
ctx.App.Data = 'Counter';
ctx.Counter.class = 'mdepin.demo.Counter';
ctx.View.class = 'mdepin.demo.UpDownView';
ctx.View.Command.Up = 'Increment';
ctx.View.Command.Down = 'Decrement';
% Define commands
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

% Create the application object
obj = mdepin.createApplication( ctx, 'App' );
% Initialize the GUI
addlistener( obj.Data, 'Value', 'PostSet', ...
    @(s,e) set(dispH, 'String', num2str(e.AffectedObject.Value)));
obj.init();

clear('ctx'); % To avoid any confusion on rerunning script

%%
% Copyright Matt McDonnell, 2015
% See LICENSE file for license details