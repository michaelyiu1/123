function dst=Dist_Point_LineSegment(px,py,L)
% dst=Dist_Point_LineSegment(px,py,L)
% Computes the minimum distance between a point and a line segment.
% the routine is vectorized only for one point many lines or many points
% one line
%
% Input: 
% px, py: coordinates of the points [N x 1]
% L : coodrinate of the lines in the format [x1 y1 x2 y2].
% 
% Output: 
% dst : the distance between the point the the line [N x 1]
% This function has to return the dst in the same format the px py are given 
%
% see also CSGobj_v2
%
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date 18-Dec_2012
% Department of Land Air and Water
% University of California Davis

% http://www.exaflop.org/docs/cgafaq/cga1.html
Ldst=sqrt((L(:,3)-L(:,1)).^2+(L(:,4)-L(:,2)).^2);
r=((L(:,2)-py).*(L(:,2)-L(:,4))-(L(:,1)-px).*(L(:,3)-L(:,1)))./Ldst.^2;
%http://mathworld.wolfram.com/Point-LineDistance2-Dimensional.html
dst=abs((L(:,3)-L(:,1)).*(L(:,2)-py)-(L(:,1)-px).*(L(:,4)-L(:,2)))./Ldst;
if size(px,1)==1
    id_out=find(r>1 | r<0);
    dst(id_out)=min([sqrt((L(id_out,1)-px).^2+(L(id_out,2)-py).^2) sqrt((L(id_out,3)-px).^2+(L(id_out,4)-py).^2)],[],2);
else
    id_out=logical(r>1 | r<0);
    temp1=sqrt((L(:,1)-px(id_out)).^2+(L(:,2)-py(id_out)).^2);
    temp2=sqrt((L(:,3)-px(id_out)).^2+(L(:,4)-py(id_out)).^2);
    tf=temp1<temp2;
    temp2(tf)=temp1(tf);
    dst(id_out)=temp2;
end
