%% Mesh Generation
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% For the mesh generation, mSim uses the 
% <http://geuz.org/gmsh/ |Gmsh|>  mesh generator. Gmsh has its own user interface, however
% mSim takes advantage of the Gmsh scripting capabilities.
% 
% In general there are many ways to describe the geometry of a domain. Here
% we assume that the geometry is written in shapefiles. If the Mapping
% toolbox is available then one can easily read and write shapefile using
% the
% <http://www.mathworks.com/help/map/ref/shaperead.html |shaperead|> and 
% <http://www.mathworks.com/help/map/ref/shapewrite.html |shapewrite|>
% respectively. 
%
% In general the geometry is defined as a struct variable with the following fields:
% 
% * Geometry
% * X
% * Y
%
% The following examples demonstrate how to create 2D and 3D meshes using the mSim
% functions. The workflow in all the examples is the same. 
%%
% 
% # First we describe the geometry of the domain in a shapefile-like structure.
% # Next we create aCSG  geometry object 
% # Then we write the Gmsh input file and create the mesh by running Gmsh
% # Finally import the mesh into matlab workspace
%
% Optionally we can write the mesh into paraview files for visualization.
%
%% 
% The following 4 tutorials cover almost all the possible ways options to generate
% mesh using mSim
%
% * <mesh_matlab_only.html |Mesh Generation based on Matlab|>
% * <mesh_matlab_shapef.html |Mesh Generation based on Matlab from shapefiles|>
% * <mesh_withquads.html |Generate quadrilateral mesh|>
% * <mesh_arcgis.html |Mesh Generation based on ArcGIS|>
%
%%
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
