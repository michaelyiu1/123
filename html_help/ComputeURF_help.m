%% ComputeURF
% 
% <msim_help_main.html | main>   <Tutorials | msim_help_demos.html> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% Computes the Unit Response Function for a given streamline.
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
%% Usage
% URF=ComputeURF(XYZ, Vxyz, opt)
%
%% Input:
% _*XYZ*_  : Streamline coordinates [Np x 3].
%
% _*Vxyz*_ : Velocity of streamline points. 
%
% _*opt*_  : An option structure with the following fields:
%
% dx : discretization along streamline
% 
% dt : time discretization in years
%
% Ttime : Total simulation time
%
% Lmin : Minimum length for numerical solution. For streamlines with
%        length less than Lmin an analytical solution will be used. 
%
% lambda.type : 1->lambda is scalar
%             : 0->variable
%
% lambda.val : if type == 1, decay $\lambda$ = lambda.val(1),
%              if type == 0, decay $\lambda$ = lambda.val ( lambda.val has to
%                             be equal to Np)
%
%% Output data
% _*URF*_  : Unit response function 
%
%
%
%
%
% *Note*: The first point in XYZ is the starting point of the backward particle 
% tracking near the CDS (e.g. the wells). 
%
% In FEM formulation we assume that the first point is near 
% the land surface, therefore we reverse the order inside the script.
%
%
%  |---v1----|---v2---|----v3-----|
%  -------------------------------------
%  x1       x2        x3         x4
%
%%
% 
% <msim_help_main.html | main>   <Tutorials | msim_help_demos.html> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%