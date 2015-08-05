function varargout = createApplication( ctx, id )
%MDEPIN.CREATEAPPLICATION Create application from context struct
%   Uses a context struct specifying the object dependencies to create an
%   application.
%
%   USAGE:
%       app = mdepin.createApplication( ctx, id )
%
%   INPUT:
%       ctx - context struct.  Each field specifies a component ID.
%           Subfield names are either'class' to specify the class to use
%           for the component or the name of a property of the class.  In
%           the latter case if the subfield value is a component ID then
%           that component will be constructed and added to the class.
%
%       id - ID of the component to create.  This must match one of the
%           fieldnames of the context struct.
%
%   OUTPUT:
%       app - constructed application.  (Optional)
%

% Copyright Matt McDonnell, 2015
% See LICENSE file for license details

if isstruct( ctx )
    ctx = mdepin.StructContext(ctx);
end
    
% Construct the application
beanFactory = mdepin.BeanFactory( ctx );
app = beanFactory.getBean(id);

if nargout>0
    varargout{1} = app;
end

end

