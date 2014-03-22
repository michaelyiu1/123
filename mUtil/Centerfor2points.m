function [c1 c2]=Centerfor2points(a,b,r)
% [c1 c2]=Centerfor2points(a,b,r)
%
% Computes the center of a circle that pass from two known points and a
% given radius. Because there are two possible centers this function
% returns both of them.
%
% This function is used for the distribution of the layers in the z
% direction. See the example in the help file
%
%
% Input
% a : a 2D point
% b : a 2D point
% r : radius of the circle
%
% Ouput
% c1 : 1st center
% c2 : 2nd center
%
%
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date 4-Apr_2013 
% Department of Land Air and Water
% University of California Davis

m=(a+b)/2;
p=[b(2)-a(2) a(1)-b(1)];
d=sqrt(r*r/(p*p')-0.25);
c1=m+p*d;
c2=m-p*d;
