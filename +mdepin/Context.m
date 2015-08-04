classdef Context 
    %CONTEXT Bean Factory context 
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    methods (Abstract)
        % Get dependency graph in sorted topological order
        depGraph = getDependencyGraph(obj)
                
        % Get constructor for beanId
        ctor = getCtor( obj, beanId)
        
        % Get parameters for beanId
        params = getParams( obj, beanId)
    end
    
end
