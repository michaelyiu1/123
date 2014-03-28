%% Calc_Area
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
%
% Computes the area of 2D mesh elements in a vectorized manner. It workds
% for triangular and quadrilateral elements of any order. However the sides
% of the elements must be striaght lines otherwise the calculation will be
% wrong. 
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
%% Usage
% A = Calc_Area(p, MSH);
%
%% Input:
% _*p*_ : [Np x 2] coordinates
%
% _*MSH*_ : [Nel, Nsh] Mesh element ids. Nel is the number of elements and
% Nsh is the number of shapefunctions. The ids correspond to the row of the
% array _*p*_
%
%% Output
% _*A*_ : [Nel x 1] The area of each element.
%
%% Example
%
% Create a hypothetical mesh
p = 10 * rand(10,2);
MSH = delaunay(p(:,1), p(:,2));
%%%
% Calculate the area of each element
A = Calc_Area(p, MSH);
%%%
% Calculate the barycenter of each element
cc = Calc_Barycenters(p,MSH);
%%%
% Display the area of each element 
triplot(MSH, p(:,1), p(:,2))
hold on
for i = 1:size(cc, 1)
    text(cc(i,1),cc(i,2),num2str(A(i,1)),'HorizontalAlignment','center')
end
%%
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%