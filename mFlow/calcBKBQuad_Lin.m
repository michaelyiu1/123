function BKB=calcBKBQuad_Lin(B,K,ii)
% BKB = calcBKBQuad_Lin(B, K, ii)
%
% Computes the product B'*K*B in vectorized manner for linear quadrilateral
% elements
%
% Input
% B : [Nel x 8] contains the contributions of each element to the final
%      conductance matrix
% K : [Nel x Nanis] Hydraulic conductiviy element values. The number of columns 
%     is defined by the anisotropy. Maximum number is 3.
% ii : In case of nested assembly this indicates the iteration. In
%       vectorized assembly this is empty 
%
% Output
% BKB the product B'*K*B
%
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date 18-Dec_2012
% Department of Land Air and Water
% University of California Davis
%
% how to compute the product using matlab symbolic toolbox
% syms b1 b2 b3 b4
% syms b5 b6 b7 b8
% syms kx ky
% B=[b1 b2 b3 b4; b5 b6 b7 b8];
% BT = [b1 b5; b2 b6; b3 b7; b4 b8];
% BKB = BT*[kx 0; 0 ky]*B
%
% see also calcBKB, Assemble_LHS

kx=K(:,1);ky=K(:,2);
if isempty(ii)
	BKB(:,1)=kx.*B(:,1).^2 + ky.*B(:,5).^2;
	BKB(:,2)=B(:,1).*B(:,2).*kx + B(:,5).*B(:,6).*ky;
	BKB(:,3)=B(:,1).*B(:,3).*kx + B(:,5).*B(:,7).*ky;
	BKB(:,4)=B(:,1).*B(:,4).*kx + B(:,5).*B(:,8).*ky;
	BKB(:,5)=B(:,1).*B(:,2).*kx + B(:,5).*B(:,6).*ky;
	BKB(:,6)=kx.*B(:,2).^2 + ky.*B(:,6).^2;
	BKB(:,7)=B(:,2).*B(:,3).*kx + B(:,6).*B(:,7).*ky;
	BKB(:,8)=B(:,2).*B(:,4).*kx + B(:,6).*B(:,8).*ky;
	BKB(:,9)=B(:,1).*B(:,3).*kx + B(:,5).*B(:,7).*ky;
	BKB(:,10)=B(:,2).*B(:,3).*kx + B(:,6).*B(:,7).*ky;
	BKB(:,11)=kx.*B(:,3).^2 + ky.*B(:,7).^2;
	BKB(:,12)=B(:,3).*B(:,4).*kx + B(:,7).*B(:,8).*ky;
	BKB(:,13)=B(:,1).*B(:,4).*kx + B(:,5).*B(:,8).*ky;
	BKB(:,14)=B(:,2).*B(:,4).*kx + B(:,6).*B(:,8).*ky;
	BKB(:,15)=B(:,3).*B(:,4).*kx + B(:,7).*B(:,8).*ky;
	BKB(:,16)=kx.*B(:,4).^2 + ky.*B(:,8).^2;
else
	if ii==1;BKB=kx.*B(:,1).^2 + ky.*B(:,5).^2;				return;end
	if ii==2;BKB=B(:,1).*B(:,2).*kx + B(:,5).*B(:,6).*ky;   return;end
	if ii==3;BKB=B(:,1).*B(:,3).*kx + B(:,5).*B(:,7).*ky;   return;end
	if ii==4;BKB=B(:,1).*B(:,4).*kx + B(:,5).*B(:,8).*ky;   return;end
	if ii==5;BKB=B(:,1).*B(:,2).*kx + B(:,5).*B(:,6).*ky;   return;end
	if ii==6;BKB=kx.*B(:,2).^2 + ky.*B(:,6).^2;             return;end
	if ii==7;BKB=B(:,2).*B(:,3).*kx + B(:,6).*B(:,7).*ky;   return;end
	if ii==8;BKB=B(:,2).*B(:,4).*kx + B(:,6).*B(:,8).*ky;   return;end
	if ii==9;BKB=B(:,1).*B(:,3).*kx + B(:,5).*B(:,7).*ky;   return;end
	if ii==10;BKB=B(:,2).*B(:,3).*kx + B(:,6).*B(:,7).*ky;  return;end
	if ii==11;BKB=kx.*B(:,3).^2 + ky.*B(:,7).^2;            return;end
	if ii==12;BKB=B(:,3).*B(:,4).*kx + B(:,7).*B(:,8).*ky;  return;end
	if ii==13;BKB=B(:,1).*B(:,4).*kx + B(:,5).*B(:,8).*ky;  return;end
	if ii==14;BKB=B(:,2).*B(:,4).*kx + B(:,6).*B(:,8).*ky;  return;end
	if ii==15;BKB=B(:,3).*B(:,4).*kx + B(:,7).*B(:,8).*ky;  return;end
	if ii==16;BKB=kx.*B(:,4).^2 + ky.*B(:,8).^2;            return;end
end
 