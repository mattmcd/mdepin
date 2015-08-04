classdef StructConfig < mdepin.Config
    %STRUCTCONFIG Bean configuration from struct
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    properties
        Config
    end
    
    methods
        function obj = StructConfig( config )
            if nargin<1
                return
            end
            assert( isstruct(config), 'ctor:type', 'Input must be a struct')
            obj.Config = config;
        end
    end
    
    methods 
        % Get object properties defined in this configuration
        function props = getProperties(obj)
            props = reshape( fieldnames( obj.Config ), 1, []);
        end
        
        % Retrieve a specific property by name
        function prop = get(obj, propName)
            prop = obj.Config.(propName);
        end
    end
    
end
