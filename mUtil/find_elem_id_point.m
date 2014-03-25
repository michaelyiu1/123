function id = find_elem_id_point(p,MSH,pnt, Nsearch)
% id = find_elem_id_point(p,MSH,pnt, search)
% This function finds the ids of the elements described by MSH that
% contain the points pnt. Curently this works only for 2D
%
% Input:
% p : Mesh node coordinates [ np x 2]
% MSH : Mesh [Nel x Nsh]
% pnt : coordinates of points to search for their element ids [Np x 2]
% Nsearch: The function computes first the barycenters of the elements and
%         then finds the search closer barycenters to each point
%
% Output
% id: a list of element ids for each point.
%
%
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date 25-Mar_2014 
% Department of Land Air and Water
% University of California Davis

Np = size(pnt,1);
[Nel Nsh] = size(MSH);
cc = zeros(Nel,2);
for i = 1:Nsh
    cc(:,1) = cc(:,1) + p(MSH(:,i),1);
    cc(:,2) = cc(:,2) + p(MSH(:,i),2);
end
cc = cc/Nsh;
id = nan(Np,1);
for i = 1:Np
    if exist('OCTAVE_VERSION')
        
    else
        [IDX,~]=knnsearch(cc,pnt(i,:),'K',Nsearch);
    end
    for j = 1:Nsearch
        if Nsh == 3 || Nsh == 6 % if the elements are traingles
            t_temp = coord2param(p,MSH(:,1:3),pnt(i,:),IDX(j));
            test=logical(t_temp(:,1)>=0 & t_temp(:,1)<=1 & ...
                     t_temp(:,2)>=0 & t_temp(:,2)<=1 & ...
                     t_temp(:,3)>=0 & t_temp(:,3)<=1);
            if test
                id(i,1) = IDX(j);
                break
            end
        elseif Nsh == 4 || Nsh >= 8 %the elements are quadrilateral
            t_temp1 = coord2param(p,MSH(:,1:3),pnt(i,:),IDX(j));
            t_temp2 = coord2param(p,MSH(:,[1 3 4]),pnt(i,:),IDX(j));
            test1=logical(t_temp1(:,1)>=0 & t_temp1(:,1)<=1 & ...
                         t_temp1(:,2)>=0 & t_temp1(:,2)<=1 & ...
                         t_temp1(:,3)>=0 & t_temp1(:,3)<=1);
            test2=logical(t_temp2(:,1)>=0 & t_temp2(:,1)<=1 & ...
                         t_temp2(:,2)>=0 & t_temp2(:,2)<=1 & ...
                         t_temp2(:,3)>=0 & t_temp2(:,3)<=1);
            if test1 || test2 
                id(i,1) = IDX(j);
                break
            end
        end
    end
end


function t = coord2param(p,MSH,pnt,idel)
x1=p(MSH(idel,1),1);y1=p(MSH(idel,1),2);
x2=p(MSH(idel,2),1);y2=p(MSH(idel,2),2);
x3=p(MSH(idel,3),1);y3=p(MSH(idel,3),2);
D=1./((x2.*y3-x3.*y2)+x1.*(y2-y3)+y1.*(x3-x2));
DCT=bsxfun(@times, D,[x2.*y3-x3.*y2  y2-y3  x3-x2 ...
                      x3.*y1-x1.*y3  y3-y1  x1-x3 ...
                      x1.*y2-x2.*y1  y1-y2  x2-x1]);
t=[DCT(:,1)+bsxfun(@times,DCT(:,2),pnt(:,1))+bsxfun(@times,DCT(:,3),pnt(:,2))...
   DCT(:,4)+bsxfun(@times,DCT(:,5),pnt(:,1))+bsxfun(@times,DCT(:,6),pnt(:,2))... 
   DCT(:,7)+bsxfun(@times,DCT(:,8),pnt(:,1))+bsxfun(@times,DCT(:,9),pnt(:,2))];
