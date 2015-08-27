function theStruct = structpathasgn( theStruct, valPath, value )
%MDEPIN.UTIL.STRUCTPATHREF Retrieve struct value at specified path
%
%   USAGE:
%       theStruct = mdepin.util.structpathasgn(theStruct,valPath, value)
%
%   INPUT:
%       theStruct - input struct
%
%       valPath - path to value e.g. /A/B for s.A.B 
%
%       value - value to set
%
%   OUTPUT:
%       theStruct - struct with value set

% Copyright Matt McDonnell, 2015
% See LICENSE file for license details

sArray = regexp(valPath, '/(?<subs>[^/]+)', 'names');
[sArray.type] = deal('.');
theStruct = subsasgn( theStruct, sArray, value );

end