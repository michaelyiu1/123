%% readArcGisASCIIfile
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% Reads ARCGIS raster data in ascii format
%
% Version : 1.0
%
% Author : George Kourakos
%
% email: giorgk@gmail.com
%
% web : http://groundwater.ucdavis.edu/msim
%
% Date 18-Dec_2012
%
% Department of Land Air and Water
%
% University of California Davis
%
%% Usage:
% [ data  info ] = readArcGisASCIIfile( 'datafile.asc' );
%
% or
%
% data = readArcGisASCIIfile( 'datafile.asc' );
%
%% Input: 
% filename : The filename needs to be given with the extension
%
%% Output: 
% data : A matrix that contains the data
%
% info : A structure with the raster infos
%
%      such as # rows and columns, cell size,
%      coordinates of left lower corner of the grid and
%      No data value
%
%%
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%