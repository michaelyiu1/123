%% msim_mesh_options
%
% Returns a structure variable with default options to run Gmsh. The
% primary purpose of this function is to return a variable with all
% necessary fields that one need to edit, so that users are unlikely to
% forget any field.
%
% Version : 1.0
%
% Author : George Kourakos
%
% email: giorgk@gmail.com
%
% web : http://groundwater.ucdavis.edu/msim
%
% Date 18-Dec-2012
%
% Department of Land Air and Water
%
% University of California Davis
%
%% Usage
% opt=msim_mesh_options
%
%% Input
% no input required
%
%% Output
% _*opt*_: A structure variable with the following fields:
%
% lc_gen : Maximum size of element
%
% embed_points : Embed or not the point in the mesh. 1-> the Gmsh will try
% to use the points as mesh nodes. 0->  ignore points
% 
% embed_lines : Embed or not the lines in the mesh. 1-> the Gmsh will try
% to constrain the mesh on the lines. 0-> will ignorethe lines
%
% el_type : valid options are 'triangle' and 'quad'
%
% el_order : 1->linear, 2->quadratic
%
% incomplete : in case of quadratic elements setting to 1 will generates incomplete elements.
% (However incomplete elements are not supported by mSim)
%
%% Example
% The default mSim mesh options are:
opt=msim_mesh_options