%% WriteAscii4Raster
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% Writes grid data to a suitable ascii format for 
% <https://www.arcgis.com/ ARCGIS> or 
% <http://www.qgis.org/ QGIS> import 
%
%
% Version : 1.0
%
% Author : George Kourakos
%
% email: giorgk@gmail.com
%
% web : <www.surface.gr www.surface.gr>
%
% Date 15-Apr-2014
%
% Department of Land Air and Water
%
% University of California Davis
%
%% Usage
% WriteAscii4Raster(filename,TAB, xl, yl, csz, nodata)
%
%% Input
% _*filename*_: The name of the ascii file where the data wil be printed.
% The suffix *.asc* will be append at the end
%
% _*TAB*_: Data matrix
%
% _*xl*_: x coordinate of the left lower corner
%
% _*yl*_: y coordinate of the left lower corner
%
% _*csz*_: cell size
%
% _*nodata*_: Scalar that represents no data value. Do not use nan
%
% *Detailed explanation of the data can be found 
% <http://resources.esri.com/help/9.3/arcgisengine/java/GP_ToolRef/spatial_analyst_tools/esri_ascii_raster_format.htm
% here>*
%
%%  Output
% No output to the matlab workspace. Just creates a file
%
%%
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%