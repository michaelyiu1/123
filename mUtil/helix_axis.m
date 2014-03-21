function [xp yp zp] = helix_axis(p1, p2, Nlay, Nppl, rd)
% [xp yp zp] = helix_axis(p1, p2, Nlay, Nppl, rd)
%
% Generate points along a helix with axis defined by the points p1 p2.
% The density of the points is controled by the Nlay, Nppl, rd parameters
%
% Input data
% p1, p2 : coordinates of starting and ending points of the line that
%          defines the axis
% Nlay   : defines the number of pitches or number of layers
% Nppl   : defines the number of points per pitch of layer
% rd     : is the radius
%
% Output data
% xp, yp, zp : coordinates of the points along the helix
%
% Example:
% p1 = [1000, 1000, 100];
% p2 = [1500, 1500, 500];
% Nlay = 25;
% Nppl = 20;
% rd = 100;
% [xp yp zp] = helix_axis(p1, p2, Nlay, Nppl, rd)
% plot3(xp, yp, zp, '.-')
% hold on
% plot3([p1(1) p2(1)], [p1(2) p2(2)], [p1(3) p2(3)],'.-r')
%
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date 09-May_2013
% Department of Land Air and Water
% University of California Davis




 
t = 0:pi/(Nppl/2):Nlay*2*pi;

xh = rd * sin(t);
yh = rd * cos(t);


% Calculate translation data
dx = -p1(1); dy = -p1(2); dz = -p1(3);
p1 = p1 + [dx dy dz];
p2 = p2 + [dx dy dz];

% Scale on the z axis
L = sqrt( (p1(1) - p2(1))^2 + (p1(2) - p2(2))^2 + (p1(3) - p2(3))^2);
Lxy = sqrt( (p1(1) - p2(1))^2 + (p1(2) - p2(2))^2);
zh = L/t(end) * t;
p2 = p2./Lxy;

% Calculate rotation data
d =  dot([0 0 1],p2);
thetaZ = acos( d/(1 * sqrt(sum(p2.^2))) );
thetaX = asin(p2(2));

pr = nan(length(xh),3);
for j = 1:length(xh)
	pr(j,[1,3]) = [[cos(-thetaZ) -sin(-thetaZ); sin(-thetaZ) cos(-thetaZ)]*[xh(j);zh(j)]]';
	pr(j,[1,2]) = [[cos(thetaX) -sin(thetaX); sin(thetaX) cos(thetaX)]*[pr(j);yh(j)]]';
end
xp = pr(:,1) - dx;
yp = pr(:,2) - dy;
zp = pr(:,3) - dz;






