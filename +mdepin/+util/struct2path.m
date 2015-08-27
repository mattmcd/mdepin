function pathArray = struct2path( inStruct )
%MDEPIN.UTIL.STRUCT2PATH Convert struct to paths to leaf nodes
%
%   USAGE:
%       pathArray = mdepin.util.struct2path( inStruct )
%
%   INPUT:
%       inStruct - input struct
%
%   OUTPUT:
%       pathArray - cell array of strings

% Copyright Matt McDonnell, 2015
% See LICENSE file for license details

pathArray = cell(0,1);
pathArray = iAux(inStruct, '', pathArray);

end

function pathArray = iAux(inStruct, currentPath, pathArray)
fields = fieldnames(inStruct);
pathArray = [pathArray; strcat(currentPath, '/', fields)];
for field = fields(:)'
    if isstruct(inStruct.(field{1}))
        pathArray = iAux( ...
            inStruct.(field{1}), ...
            strcat(currentPath, '/', field{1}), pathArray);
    end
end
end