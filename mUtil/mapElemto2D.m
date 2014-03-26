function [pxt pyt pzt]=mapElemto2D(px,py,pz)
% [pxt pyt pzt]=mapElemto2D(px,py,pz)
% Projects triangles and quadrilaterals defined in the 3D space to the 2D space
% while preserving the area and length sides of the original shape. This is
% used internally during assembly of the fluxes
%
% Input:
% px,py pz: the 3D element coordinates. Each row corresponds to an element.
%
% Output
% pxt pyt pzt: coordinates of the element. The output triangle will be
% rotated in most cases.
%
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date 26-Mar_2014 
% Department of Land Air and Water
% University of California Davis

if size(px,2)==3
    [pxt pyt pzt]=map3DTriangleto2D(px,py,pz);
elseif size(px,2)==4
    [pxt1 pyt1 pzt1]=map3DTriangleto2D(px(:,[1 3 2]),py(:,[1 3 2]),pz(:,[1 3 2]));
    [pxt2 pyt2 pzt2]=map3DTriangleto2D(px(:,[1 3 4]),py(:,[1 3 4]),pz(:,[1 3 4]));
    pxt=[pxt1(:,1) pxt1(:,3) pxt1(:,2) pxt2(:,3)];
    pyt=[pyt1(:,1) -pyt1(:,3) pyt1(:,2) pyt2(:,3)];
    pzt=[pzt1(:,1) pzt1(:,3) pzt1(:,2) pzt2(:,3)];
end




function [pxt pyt pzt]=map3DTriangleto2D(px,py,pz)
[n m]=size(px);
pxt=zeros(n,m);
pyt=zeros(n,m);
pzt=zeros(n,m);
%Find the distances p1-p2 ans p1-p3
dst1=sqrt((px(:,2)-px(:,1)).^2+(py(:,2)-py(:,1)).^2+(pz(:,2)-pz(:,1)).^2);
dst2=sqrt((px(:,3)-px(:,1)).^2+(py(:,3)-py(:,1)).^2+(pz(:,3)-pz(:,1)).^2);
%calculate the angle at point 1   
v3=[px(:,3)-px(:,1) py(:,3)-py(:,1) pz(:,3)-pz(:,1)];
v2=[px(:,2)-px(:,1) py(:,2)-py(:,1) pz(:,2)-pz(:,1)];
ang=(180/pi).*acos(sum((v2.*v3),2)./(sqrt(sum(v2.^2,2)).*sqrt(sum(v3.^2,2))));

%set p1 to (0,0) and p2 tp (dst1,0)
pxt(:,1)=0;
pyt(:,1)=0;
pxt(:,2)=dst1;
pyt(:,2)=0;
pxt(:,3)=dst2.*cosd(ang);
pyt(:,3)=dst2.*sind(ang);
