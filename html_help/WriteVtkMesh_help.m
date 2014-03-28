%% WriteVtkMesh
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% Writes Data to vtk format for visualization with ParaView or Visit
%
%
% Version : 1.0
%
% Author : George Kourakos
%
% email: giorgk@gmail.com
%
% web : http://groundwater.ucdavis.edu/msim
%
% Date 27-Dec-2014
%
% Department of Land Air and Water
%
% University of California Davis
%
%% Usage
% WriteVtkMesh(filename, MSH, p, propND, propCL, eltype)
%
%% Input
% _*filename*_: The name of the file without the suffix .vtk
%
% _*MSH*_: Mesh connectivity [Nel x Nsh], where Nel is the number of
% elements and Nsh is the number of dofs per element
%
% _*p*_: node coordinates [Npx3], where Np is the number points. Optionally
% one can use 2D points. In that case the function will add a zero
% elevation
%
% _*propND*_: Properties assigned on mesh nodes. Use [] if there are no
% properties. _*propND*_ is a structure variable with 3 fields. _name_ a
% string with the name of the property, _val_ the values for the
% property _name_ and _type_ can be either _scalar_ or _vector_. In case of
% _scalar_ the martix _val_ has dimensions [Npx1] whereas in case of
% vectors the _val_ dimensions are [Np x 3].
%
% _*propCL*_: Properties assigned on mesh cells. Use [] if there are no
% properties. _*propCL*_ is a structure variable with 3 fields. _name_ a
% string with the name of the property, _val_ the values for the
% property _name_ and _type_ can be either _scalar_ or _vector_. In case of
% _scalar_ the martix _val_ has dimensions [Nelx1] whereas in case of
% vectors the _val_ dimensions are [Nel x 3].
%
% _*eltype*_: element type :'triangle', 'quad', 'hex', 'prism'. The code will
% determine the element order from the size of the _*MSH*_ argument.
%
%% Output
% This function writes data to a file
%
%% Example
% Example for propND and propCL. In this example we assign a scalar value
% of hydraulic heads and vector values of velocity to mesh nodes. We
% assign also
% scalar values of horizontal and vertical conductivities to mesh cells
%
propND(1,1).name = 'heads';
propND(1,1).val = Hf;
propND(1,1).type = 'scalars';
%%
propND(2,1).name = 'Velocity';
propND(2,1).val = [Vx Vy Vz];
propND(2,1).type = 'vectors';
%%
propCL(1,1).name = 'HorizCond';
propCL(1,1).val = Knd;
propCL(1,1).type = 'scalars';
%%
propCL(2,1).name = 'VertCond';
propCL(2,1).val = Lnd;
propCL(2,1).type = 'scalars';
%%
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%

