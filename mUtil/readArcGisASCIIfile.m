function varargout=readArcGisASCIIfile(filename)
% data=readArcGisASCIIfile(filename)
% Reads ARCGIS raster data in ascii format
%
% Input: 
% filename : The filename needs to be given with the extension
%
% 
% Output: 
% data : A matrix that contains the data
% info : A structure with the raster infos
%       such as # rows and columns cell size etc..
%
%
%
% Usage:
% [data info] = readArcGisASCIIfile('datafile.asc');
% or 
% data = readArcGisASCIIfile('datafile.asc');
%
%
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date 18-Dec_2012
% Department of Land Air and Water
% University of California Davis



fid=fopen(filename,'r');
param=textscan(fid,'%s %f',6);
%x=param{1,2}(3,1)+cumsum(param{1,2}(5,1)*ones(1,param{1,2}(1,1)));
%y=param{1,2}(4,1)+cumsum(param{1,2}(5,1)*ones(1,param{1,2}(2,1)));
A=textscan(fid,'%f',param{1,2}(1,1)*param{1,2}(2,1));
fclose(fid);

%A{1,1}(logical(A{1,1}==param{1,2}(6,1)))=-9;
varargout{1}=flipud(reshape(A{1,1},param{1,2}(1,1),param{1,2}(2,1))');
if nargout == 2
    for i = 1:size(param{1,1},1)
        eval(['metadata.' param{1,1}{i,1} '=' num2str(param{1,2}(i)) ';'])
    end
    varargout{2} = metadata;
end
    