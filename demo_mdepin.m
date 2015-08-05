%% MATLAB Dependency Injection
% Dependency injection is a technique for constructing an application from
% components without the individual components needing to be coupled to a
% paticular implementation of other components.
%
% In this script we construct a simple MovieLister application that lists
% movies by a specified directory.  Internally the MovieLister relies on a 
% MovieFinder service to read a list of movies.  This use of Dependency
% Injection allows us to plug in different implementations of the finder
% e.g. a finder that reads from a local file or one that reads from a URL.

%% MovieFinder from File
% We first define the application context as a struct of components:

% The Lister relies on a finder component with ID FileFinder
ctxFile.Lister.class = 'mdepin.demo.MovieLister';
ctxFile.Lister.Finder = 'FileFinder';
% Specify the FileFinder as a separate field of the struct
ctxFile.FileFinder.class = 'mdepin.demo.FileMovieFinder';
% The mdepin.demo.FileMovieFinder class has a FileName property that
% specifies the location of the local file to read from.
fileLoc = fullfile( ...
    fileparts(which('mdepin.demo.MovieLister')), 'Movies.csv');
ctxFile.FileFinder.FileName = fileLoc;
% Create the lister
lister = mdepin.createApplication(ctxFile, 'Lister');

disp('Movies by Alice (from file):')
movies = lister.getMoviesDirectedBy('Alice').Title';
fprintf('  %s\n', movies{:})

%% MovieFinder from URL
% We now want to read our list of movies from a URL rather than local file.
% Do this by creating a new application that uses a different Finder
% component:
ctxURL.Lister.class = 'mdepin.demo.MovieLister';
ctxURL.Lister.Finder = 'URLFinder';
ctxURL.URLFinder.class = 'mdepin.demo.URLMovieFinder';
ctxURL.URLFinder.URL = 'http://www.matt-mcdonnell.com/mdepin_demo_Movies.csv';
% Create the new lister 
listerURL = mdepin.createApplication(ctxURL, 'Lister');

disp('Movies by Alice (from URL):')
movies = listerURL.getMoviesDirectedBy('Alice').Title';
fprintf('  %s\n', movies{:})

%%
% Copyright Matt McDonnell, 2015
% See LICENSE file for license details