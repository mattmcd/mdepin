classdef MovieListerTest < matlab.unittest.TestCase
    %MOVIELISTERTEST Acceptance test for Martin Fowler example
    %   Martin Fowler descibes inversion of control and dependency
    %   injection in his article http://www.martinfowler.com/injection.html
    %   In this example there is a MovieLister object that uses a
    %   MovieFinder to retrieve all movies then show those by a particular
    %   director.  Dependency injection is used to inject different
    %   implementations of the finder class.
    
    properties
        Lister
    end
    
    methods (Test)
        function listMoviesFromFile(testCase)
            testCase.createMovieListerFromFile();
            movies = testCase.getMoviesByAlice();
            expectedMovies =  {'My First Movie', 'Movie the Second'};
            testCase.assertEqual(movies.Title, expectedMovies);
        end
        
        function listMoviesFromURL(testCase)
            testCase.createMovieListerFromURL();
            movies = testCase.getMoviesByAlice();
            expectedMovies =  {'My First Movie', 'Movie the Second'};
            testCase.assertEqual(movies.Title, expectedMovies);
        end
    end
    
end

