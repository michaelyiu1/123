function V=Calc_volume(p,MSH)
% V=Calc_volume(p,MSH)
% Computes the Volume of 3D elements in a vectorized manner
% Currently only hexahedrals are supported (prism will be added when needed)
%
% Input p [Np x 3] coordinates
% MSH [Nel, Nsh] element ids. the ids correspond to the row of the array p
%
% Output
% V [Nel x 1] The volume of each element
%
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date 13-Feb_2013
% Department of Land Air and Water
% University of California Davis


V=zeros(size(MSH,1),1);
if size(MSH,2)==8;
    % To compute the volume of hexahedral elements we split them into six
    % pyramids.
    %compute the centroid for each element
    cc=zeros(size(MSH,1),3);
    for i=1:8
        cc(:,1)=cc(:,1)+p(MSH(:,i),1);
        cc(:,2)=cc(:,2)+p(MSH(:,i),2);
        cc(:,3)=cc(:,3)+p(MSH(:,i),3);
    end
    cc=cc./8;
    sides=[1 2 3 4; 5 6 7 8; 1 2 6 5; 2 3 7 6; 3 4 8 7; 4 1 5 8];
    for i=1:size(sides,1);
        p1=[p(MSH(:,sides(i,1)),1) p(MSH(:,sides(i,1)),2) p(MSH(:,sides(i,1)),3)];
        p2=[p(MSH(:,sides(i,2)),1) p(MSH(:,sides(i,2)),2) p(MSH(:,sides(i,2)),3)];
        p3=[p(MSH(:,sides(i,3)),1) p(MSH(:,sides(i,3)),2) p(MSH(:,sides(i,3)),3)];
        p4=[p(MSH(:,sides(i,4)),1) p(MSH(:,sides(i,4)),2) p(MSH(:,sides(i,4)),3)];
        V=V+PyramidVolume(p1,p2,p3,p4,cc);% make sure the p4 is always the appex
    end
end

function V=PyramidVolume(b1,b2,b3,b4,ap)
% To compute the volume of a pyramid we split is into 2 tetrahedral elements

V=tetrahedraVolume(b1,b2,b3,ap);
V=V+tetrahedraVolume(b1,b3,b4,ap);

function V=tetrahedraVolume(a,b,c,d)
j1=a-b;
j2=b-c;
j3=c-d;
jdet=j1(:,1).*j2(:,2).*j3(:,3)+j1(:,2).*j2(:,3).*j3(:,1)+j1(:,3).*j2(:,1).*j3(:,2)...
    -j1(:,3).*j2(:,2).*j3(:,1)-j1(:,2).*j2(:,1).*j3(:,3)-j1(:,1).*j2(:,3).*j3(:,2);
V=(1/6)*abs(jdet);


