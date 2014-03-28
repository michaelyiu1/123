%% Assemble_LHS
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% Assembles the conductance matrix
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
% Date 18-Mar-2014
%
% Department of Land Air and Water
%
% University of California Davis
%
%% Usage 
% [Kglo H]= Assemble_LHS(p, MSH, K, CH, GHB, opt)
%
%% Input
% _*p*_: [Np x 3] Coodrinates of nodes [x1 y1 z1; x2 y2 z2;...xn yn zn], 
% where Np is the number of nodes
%
% _*MSH*_: [Nel x Np_el] id of elements. Each row correspond to an element.
% Nel is the number of elements and Np_el is the number of dofs per element
%
% _*K*_ : Hydraulic Conductivity defined on nodes or elements, 
% If size(_*K*_,1)==Np then K is defined on nodes.
% If size(_*K*_,1)=Nel then K is defined on elements.
% If size(_*K*_,2)==1 then aquifer is isotropic Kx=Ky=Kz.
% If size(_*K*_,2)==2 then aquifer is anisotropic Kx=Ky~=Kz.
% If size(_*K*_,2)==3 then aquifer is anisotropic Kx~=Ky~=Kz.
%
% _*CH*_: [nx2] the first column contains the id of the nodes with constant
% head boundary conditions. The second contains the values
%
% _*GHB*_: [nx3] : id of node connected with a GHB, head, conductance
%
% _*opt*_ : Simulation options with the following fields:
% _dim_: Dimension of the problem : 1, 2 or 3.
% _el_type_: type of element e.g. triangle, prism etc... 
% _el_order_: order of the element: linear or quadratic 
% _assemblemode_: 'vect', 'nested','serial'(Use always vect) 
%
%% Output
% _*Kglo*_: Global conductance matrix (sparse)
% _*H*_ : vector with nan values for the unknowns and scalar for the
% dirichlet nodes
%%
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%