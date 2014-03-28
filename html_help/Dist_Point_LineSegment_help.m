%% Dist_Point_LineSegment
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
% Computes the minimum distance between a point and a line segment.
% The function is vectorized only for one point many lines or many points
% one line
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
% dst = Dist_Point_LineSegment(px, py, L)
%
%%
%% Input
%
% _*px*_: [n x 1] x coordinates of point/s. n is the number of points. If n > 1
% then the number of lines must be 1.
%
% _*py*_: [n x 1] y coordinate of point/s. n is the number of points. If n > 1
% then the number of lines must be 1.
%
% _*L*_: [N x 4] line defined by two points. The points must be given as 
% follows: [p1x p1y p2x p2y] where (p1x,p1y) are the coordinates of one
% point and (p2x, p2y) the coordinates of the other end of the line. 
% N is the number of lines. If N > 1 then the number of points must be 1.
%
%% Output
%
% _*dst*_: the distance between the point the the lines [N x 1] or the
% points and line.
%
%% Example
% *1st case: Many points one line*
%%%
% Create 10 points and one line
p = 10*rand(10,2);
L= [2 5 7 5];
%%%
% compute the distances between the line and the point
dst = Dist_Point_LineSegment(p(:,1), p(:,2), L)
%%
% Plot the points, the lines and the distances between them
plot(p(:,1),p(:,2),'.'); hold on
plot([L(1,1) L(1,3)], [L(1,2) L(1,4)],'r')
for i = 1:size(p,1)
    text(p(i,1),p(i,2), [' ' num2str(dst(i))])
end
%%
% *2nd case: One point many lines*
%%%
% Create a point and 4 lines
p = [5 5];
L= 10*rand(4,4);
%%%
% compute the distances between the lines and the point
dst = Dist_Point_LineSegment(p(1,1), p(1,2), L)
%%
% Plot the points, the lines and the distances between them
hold off
plot(p(1,1),p(1,2),'or'); hold on
plot([L(1,1) L(1,3)], [L(1,2) L(1,4)],'r')
for i = 1:size(L,1)
    plot([L(i,1) L(i,3)], [L(i,2) L(i,4)],'.-')
    text((L(i,1) + L(i,3))/2, (L(i,2) + L(i,4))/2, [' ' num2str(dst(i))])
end
%%
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
