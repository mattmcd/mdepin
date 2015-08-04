classdef MockData < mdepin.Bean
    %MOCDATA Simple data object 
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    properties
        NumProp
        CharProp
        ArrayProp
    end
    
    methods
        function obj = MockData(config)
            obj = obj@mdepin.Bean(config);
        end
    end
    
end

