classdef MovieFinder 
    %MOVIEFINDER Find a table of movies
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
        
    methods (Abstract)
        % Return table of movies Director, Title
        movies = findAll(obj)
    end
    
end

