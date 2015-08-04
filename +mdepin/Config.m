classdef Config
    %CONFIG Bean configuration
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    methods (Abstract)
        % Get object properties defined in this configuration
        props = getProperties(obj)
        
        % Retrieve a specific property by name
        prop = get(obj, propName)
    end
    
end

