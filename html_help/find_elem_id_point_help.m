%% find_elem_id_point
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% Finds the id of the element that contains a given point.
% It workds only for 2D Meshes
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
% id = find_elem_id_point(p, MSH, pnt, Nsearch)
%
%% Input
% _*p*_: Mesh node coordinates [ np x 2]
%
% _*MSH*_ : Mesh [Nel x Nsh]
%
% _*pnt*_ : coordinates of points to search for their element ids [Np x 2]
%
% _*Nsearch*_: The function computes first the barycenters of the elements and
% checks only the Nsearch closer elements for each point
%
%% Output
% _*id*_: a list of element ids
%
%% Example
% Create a hypothetical mesh
p = 10*rand(10,2);
MSH = delaunay(p(:,1), p(:,2));
%%%
% Create 100 random points
pnt = 10*rand(100,2);
%%%
% Now check the element ids of each point
id = find_elem_id_point(p, MSH, pnt, 5);
%%%
% For each element plot which points contains and last plot those that they
% are outside of the mesh
triplot(MSH, p(:,1),p(:,2));
hold on
for i = 1:size(MSH,1)
    plot(pnt(id == i,1), pnt(id == i,2),'.','color',[rand rand rand]);
end
plot(pnt(isnan(id),1), pnt(isnan(id),2),'.k');
%%
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%