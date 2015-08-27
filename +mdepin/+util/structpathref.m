function val = structpathref( inStruct, valPath )
%MDEPIN.UTIL.STRUCTPATHREF Retrieve struct value at specified path
%
%   USAGE:
%       val = mdepin.util.structpathref(inStruct,valPath)
%
%   INPUT:
%       inStruct - input struct
%
%       valPath - path to value e.g. /A/B for s.A.B 
%
%   OUTPUT:
%       val - value in struct at specified path

% Copyright Matt McDonnell, 2015
% See LICENSE file for license details

sArray = regexp(valPath, '/(?<subs>[^/]+)', 'names');
[sArray.type] = deal('.');
val = subsref( inStruct, sArray );

end

