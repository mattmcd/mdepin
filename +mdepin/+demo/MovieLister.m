classdef MovieLister < mdepin.Bean
    %MOVIELISTER List movies by a given director
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    properties
        Finder % Service that finds movies
    end
    
    methods 
        function obj = MovieLister(config)
            obj = obj@mdepin.Bean(config);
        end
        
        function movies = getMoviesDirectedBy(obj, name)
            allMovies = obj.Finder.findAll();
            movies = allMovies(ismember(allMovies.Director,name), :);
        end
    end
    
end

