classdef StructContext < mdepin.Context
    %STRUCTCONTEXT Bean Factory context from struct
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    properties
        Context
    end
    
    methods
        function obj = StructContext( context )
            if nargin<1
                return
            end
            assert( isstruct(context), 'ctor:type', 'Input must be a struct')
            obj.Context = context;
        end
    end
    
    methods 
        % Get dependency graph
        function depGraph = getDependencyGraph(obj)
            allId = obj.getAllId;
            % deps = structfun( @(x) intersect( fieldnames(x), allId), ...
            %    obj.Context, 'UniformOutput', false);
            deps = obj.getDependency(allId);
            depIds = reshape({deps.DepId},[],1);
            sortedId = cell(0,1);
            while ~isempty(setdiff(allId, sortedId))
                ind = cellfun(@isempty, depIds) ...
                    & ~ismember(allId, sortedId);
                if ~any(ind)
                    % Cycle
                    error('dep:cycle', 'Dependency graph contains a cycle')
                end
                sortedId(end+(1:nnz(ind)),:) = allId(ind);
                depIds = cellfun(@(c) setdiff(c, sortedId), depIds, ...
                    'UniformOutput', false); 
            end
            depGraph = obj.getDependency(sortedId);
        end
                
        % Get constructor for beanId
        function ctor = getCtor( obj, beanId)
            ctor = str2func(obj.Context.(beanId).class);
        end
        
        % Get parameters for beanId
        function params = getParams( obj, beanId)
            params = obj.Context.(beanId);
            params = rmfield( params, 'class');
        end
        
        function allId = getAllId(obj)
            allId = fieldnames(obj.Context);
        end
        
        function dep = getDependency(obj, beanId)
            % Determine which properties are dependent on other components
            if iscell(beanId)
                dep = cellfun(@obj.getDependency, beanId);
                return
            end
            params = obj.getParams(beanId);
            allId = obj.getAllId();
            % Parameter is a dependency if it is a string matching a beanId
            % TODO:
            % or a cell array of strings matching a beanId
            paramId = fieldnames(params);
            dep.Id = beanId;
            dep.Param = cell(0,1);
            dep.DepId = cell(0,1);
            for iParam = 1:numel(paramId)
                param = paramId{iParam};
                value = params.(param);
                isBeanId = ischar( value ) && ismember(value, allId);
                % TODO: cell array of dependencies
                % isBeanArray = iscellstr( value ) && all(ismember( value, allId));
                if isBeanId
                    dep.Param{end+1,:} = param;
                    dep.DepId{end+1,:} = value;
                end
            end
        end
    end
    
end
