%% read_2D_Gmsh
%
% Reads the .msh file generated from Gmsh
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
% [p MSH]=read_2D_Gmsh(varargin)
%
%% Input
% The function can take up to three inputs. _*filename*_, _*display_count*_,
% _*Use_Cpp*_. The inputs have to be used in the same order. If one wants
% to specify _*Use_Cpp*_ this has to be the 3rd input and a
% value at least an empty argument [] for _*display_count*_ is required.
% 
% _*filename*_:  the name of file without the extension *.msh
%
% *_display_count*_ : when the meshes are very large this function can be time
% consuming. Because I'm very impatient and always want to
% know that my script is running I allow to display the
% loop counters by setting this to 1. 0 or empty does not
% display anything
%
% _*Use_Cpp*_: Setting this to 1 will run some parts of the code in c++. 
% This is experimental and should be used only for very
% large meshes. It needs to be compiled of course and the function is
% written for matlab interface only at the moment.
%
%% Output
% _*p*_: coordinates of points
%
% _*MSH*_: A structure with 3 rows. The first row corresponds to the zero
% dimension elements (e.g. points) The second row to 1D elements
% (lines) and the third row to 2D elements (triangles or
% quadrilaterals). 
% Each row has the field _elem_. The _elem_ consist of one or more rows
% where each row correspond to a different type of elements. If only
% one type of element is used then elem has only one row. Each row of
% elem has the following fields:
% _type_ is the type of element. for example 'triangle' 'quad'
% _id_ is the matrix which contains the connentivity of the points
% the last field is _dom_ and it was supposed to be used when the Gmesh 
% partition the mesh for parallel assembly, Currently we are doing this out of Gmsh. 