classdef URLMovieFinder < mdepin.demo.MovieFinder
    %URLMOVIEFINDER Find table of movies from URL
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    properties
        URL
    end
    
    methods
        function obj = URLMovieFinder(config)
            obj = obj@mdepin.demo.MovieFinder(config);
        end
        
        function movies = findAll(obj)
            tmp = tempname();
            urlwrite(obj.URL, tmp);
            movies = readtable(tmp);
            delete(tmp);
        end
    end
    
end

