classdef MovieListerTest < matlab.unittest.TestCase
    %MOVIELISTERTEST Acceptance test for Martin Fowler example
    %   Martin Fowler descibes inversion of control and dependency
    %   injection in his article http://www.martinfowler.com/injection.html
    %   In this example there is a MovieLister object that uses a
    %   MovieFinder to retrieve all movies then show those by a particular
    %   director.  Dependency injection is used to inject different
    %   implementations of the finder class.
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    properties
        Lister
    end
    
    methods (Test)
        function listMoviesFromFile(testCase)
            testCase.createMovieListerFromFile();
            movies = testCase.getMoviesByAlice();
            expectedMovies =  {'My First Movie'; 'Movie The Second'};
            testCase.assertEqual(movies.Title, expectedMovies);
        end
        
        function listMoviesFromURL(testCase)
            testCase.createMovieListerFromURL();
            movies = testCase.getMoviesByAlice();
            expectedMovies =  {'My First Movie'; 'Movie The Second'};
            testCase.assertEqual(movies.Title, expectedMovies);
        end
    end
    
    methods         
        
        function createMovieListerFromFile(testCase)
            fileLoc = fullfile( ...
                fileparts(which('mdepin.demo.MovieLister')), ...
                'Movies.csv');
            ctx.Lister = struct('class', 'mdepin.demo.MovieLister', ...
                'Finder', 'FileFinder');
            ctx.FileFinder = struct(...
                'class', 'mdepin.demo.FileMovieFinder', ...
                'FileName', fileLoc);
            testCase.Lister = mdepin.BeanFactory( ...
                mdepin.StructContext(ctx)).getBean('Lister');
        end
        
        function createMovieListerFromURL(testCase)
            url =  'http://www.matt-mcdonnell.com/mdepin_demo_Movies.csv';
            ctx.Lister = struct('class', 'mdepin.demo.MovieLister', ...
                'Finder', 'FileFinder');
            ctx.FileFinder = struct(...
                'class', 'mdepin.demo.URLMovieFinder', ...
                'URL', url);
            testCase.Lister = mdepin.BeanFactory( ...
                mdepin.StructContext(ctx)).getBean('Lister');
        end
        
        function movies = getMoviesByAlice(testCase)
            movies = testCase.Lister.getMoviesDirectedBy('Alice');
        end
    end
    
end

