classdef (HandleCompatible) Bean
    %BEAN Constructor settable bean for dependency injection
    %   Constructor takes a single argument Config object which specified
    %   the values of properties to be set for the object.  This allows
    %   dependency injection of any services that the object requires.
    %
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
        
    methods
        function obj = Bean(config)
            for prop=config.getProperties();
                obj.(prop{1}) = config.get(prop{1});
            end
        end
    end
    
end

