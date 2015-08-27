classdef BeanFactory < handle
    %BEANFACTORY Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        IsInitialized = false
        Context
        Beans
    end
    
    methods
        function obj = BeanFactory( context )
            obj.Context = context;
        end
        
        function init(obj)
            % Initialize the BeanFactory by creating all beans from context
            
            % Context defines a graph of bean dependencies.  From this
            % graph we can firstly check that no cyclic dependencies exist
            % and then do a topological sort to ensure that beans are
            % created in order.  
            
            % Retrieve dependency graph as struct of Id, propId, depId  in
            % topologically sorted order
            depGraph = obj.Context.getDependencyGraph();
            nBean = numel( depGraph );
            obj.Beans = containers.Map('KeyType', 'char', 'ValueType', 'any');
            for iBean = 1:nBean
                beanId = depGraph(iBean).Id;
                ctor = obj.Context.getCtor( beanId );
                params = obj.Context.getParams( beanId );
                for iDep = 1:numel( depGraph(iBean).DepId )
                    dep = depGraph(iBean).DepId{iDep};
                    prop = depGraph(iBean).Param{iDep};
                    params = mdepin.util.structpathasgn(...
                        params, prop, obj.Beans(dep));
                    % params.(prop) = obj.Beans(dep);
                end
                config = mdepin.StructConfig( params );
                obj.Beans(beanId) = ctor( config );
            end                                    
        end
        
        function bean = getBean(obj, beanId)
            if ~obj.IsInitialized
                obj.init();
            end
            bean = obj.Beans(beanId);
        end
    end
    
end

