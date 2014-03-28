%% Assemble_RHS
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% Assembles the right hand side of the groundwater flow for flows defined
% on elements
%
% Version : 1.0
%
% Author : George Kourakos
%
% email: giorgk@gmail.com
%
% web : http://groundwater.ucdavis.edu/msim
%
% Date 18-Mar-2014
%
% Department of Land Air and Water
%
% University of California Davis
%
%% Usage 
% F = Assemble_RHS(Ndof, p, MSH, FLUX)
%
%% Input
% _*Ndof*_: Number of degrees of freedom
%
% _*p*_: [Np x 3] Coodrinates of nodes [x1 y1 z1; x2 y2 z2;...xn yn zn],
% where Np is the Number of points
%
% _*MSH*_: [Nel x Np_el] id of elements. Each row correspond to an element
% Nel is the number of elements and Np_el is the number of dofs per element
%
% _*FLUX*_: A structure with the following fields
%
% _id_: The id of the elements where the flux conditions are applied.
%
% _val_: the flux values. the size of _val_ must be equal to _id_
%
% _dim_: The structural dimension of the elements. For example in 3D flow
% the groundwater recharge is applied to 2D elements while the well pumping
% can be applied to 3D elements. See also the tutorials
%
% _el_type_: the element type such as 'line', triangle','quad','prism','hex'
% etc.
%
% _el_order_: the element order
%
% _id_el_: This is the index of MSH.elem row. This is commonly 1. On case
% that this is different is the following example. Lets suppose that the
% problem is 3D, discretized in prism elements and the variable MSH containts 
% the mesh info. MSH is a structure where the 2D elements will be on the
% 3rd row.
% MSH(3,1) will have a field _elem_. Each row of MSH(3,1).elem  corresponds
% to the mesh of different type of elements. There will be one row for the
% triangular faces, and one row for the quadrilateral faces. _id_el_ must
% to point to the correct row in MESH(x,1).elem(_id_el_,1).id. See also the
% 3D examples with prism elements.
%
% _assemblemode_: choose the assemble mode 'vect' or 'nested' (use
% always vect)
%
%% Output
% _*F*_: The assembled right hand side
%
%%
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%