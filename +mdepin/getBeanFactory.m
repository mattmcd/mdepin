function factory  = getBeanFactory(file)

run(which(file));
variables = who;

if numel(variables) > 2
    error('only one structure is allowed in context file')
end

ctx = eval(variables{1});

if isstruct( ctx )
    ctx = mdepin.StructContext(ctx);
end
% Construct the application
factory = mdepin.BeanFactory(ctx);
end


