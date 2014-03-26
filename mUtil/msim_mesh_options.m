function opt=msim_mesh_options
% opt=msim_mesh_options
%
% Returns a structure variable with default options to run Gmsh. The
% primary purpose of this function is to return a variable with all
% necessary fields that one need to edit, so that users are unlikely to
% forget any field.
% fields:
%       lc_gen : Maximum size of element
%       embed_points : Embed or not the point in the mesh
%       embed_lines : Embed or not the lines in the mesh
%       el_type : valid options are 'triangle' and 'quad'
%       el_order : 1->linear, 2->quadratic
%       incomplete : in case of quadratic elements this generates incomplete.
%                    (However incomplete elements are not supported)
%
%
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date 18-Dec_2012
% Department of Land Air and Water
% University of California Davis


opt.lc_gen = 1000; %Maximum size of element
opt.embed_points  = 0; % Embed or not the point in the mesh 
opt.embed_lines  = 0; % Embed or not the lines in the mesh 
opt.el_type = 'triangle'; % valid options are 'triangle' and 'quad'. 
% In fact trangle option simply ignores the code associated with quads
opt.el_order = 1; % 1: linear , 2: quadratic
opt.incomplete = 0; % in case of quadratic elements this generates incomplete.
% (However incomplete elements are not supported

