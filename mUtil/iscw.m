function tf=iscw(p,MSH)
% tf=iscw(p, MSH)
% Check if the elements of the mesh are in clockwise orientation. Although
% Matlab has a similar built in function  ispolycw this function is vectorized 
% for meshes
%
% Input
% p : Mesh node coordinates [ np x 2]
% MSH : Mesh [Nel x Nsh]
%
% Output
% tf : true if the polygon orientation is clockwise.
%
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date 25-Mar_2014 
% Department of Land Air and Water
% University of California Davis

signedArea=zeros(size(MSH,1),1);
np=size(MSH,2);
if size(MSH,2)==9 || size(MSH,2)==8;
    numb=[1 5 2 6 3 7 4 8];
    np=length(numb);
elseif size(MSH,2)==6;
    numb=[1 4 2 5 3 6];
else
    numb=1:size(MSH,2);
end
for i=1:np
    x1=p(MSH(:,numb(i)),1);y1=p(MSH(:,numb(i)),2);
    if i==np
        x2=p(MSH(:,numb(1)),1);y2=p(MSH(:,numb(1)),2);
    else    
        x2=p(MSH(:,numb(i+1)),1);y2=p(MSH(:,numb(i+1)),2);
    end
    signedArea=signedArea+x1.*y2-x2.*y1;
end
tf=signedArea<0;
    