classdef FileMovieFinder < mdepin.Bean & mdepin.demo.MovieFinder
    %FILEMOVIEFINDER Find table of movies from file
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    properties
        FileName
    end
    
    methods
        function obj = FileMovieFinder(config)
            obj = obj@mdepin.Bean(config);
        end
        
        function movies = findAll(obj)
            movies = readtable(obj.FileName);
        end
    end
    
end

