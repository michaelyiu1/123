function BKB=calcBKBtriang_quad(B,K,ii)
% BKB = calcBKBtriang_quad(B, K, ii)
%
% Computes the product B'*K*B in vectorized manner for quadratic trianlge
% elements
%
% Input
% B : [Nel x 12] contains the contributions of each element to the final
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
% Date : 18-Dec-2012
% Department of Land Air and Water
% University of California Davis
%
% how to compute the product using matlab symbolic toolbox
% syms b1 b2 b3 b4 b5 b6
% syms b7 b8 b9 b10 b11 b12
% syms kx ky
% B=[b1 b2 b3 b4 b5 b6; b7 b8 b9 b10 b11 b12]
% BT = [b1 b7; b2 b8; b3 b9; b4 b10; b5 b11; b6 b12]
% BKB = BT*[kx 0; 0 ky]*B
%
% see also calcBKB, Assemble_LHS

kx=K(:,1); ky=K(:,2);
if isempty(ii)
	BKB(:,1)=kx.*B(:,1).^2 + ky.*B(:,7).^2;
	BKB(:,2)=B(:,1).*B(:,2).*kx + B(:,7).*B(:,8).*ky;
	BKB(:,3)=B(:,1).*B(:,3).*kx + B(:,7).*B(:,9).*ky;
	BKB(:,4)=B(:,1).*B(:,4).*kx + B(:,7).*B(:,10).*ky;
	BKB(:,5)=B(:,1).*B(:,5).*kx + B(:,7).*B(:,11).*ky;
	BKB(:,6)=B(:,1).*B(:,6).*kx + B(:,7).*B(:,12).*ky;
	BKB(:,7)=B(:,1).*B(:,2).*kx + B(:,7).*B(:,8).*ky;
	BKB(:,8)=kx.*B(:,2).^2 + ky.*B(:,8).^2;
	BKB(:,9)=B(:,2).*B(:,3).*kx + B(:,8).*B(:,9).*ky;
	BKB(:,10)=B(:,2).*B(:,4).*kx + B(:,8).*B(:,10).*ky;
	BKB(:,11)=B(:,2).*B(:,5).*kx + B(:,8).*B(:,11).*ky;
	BKB(:,12)=B(:,2).*B(:,6).*kx + B(:,8).*B(:,12).*ky;
	BKB(:,13)=B(:,1).*B(:,3).*kx + B(:,7).*B(:,9).*ky;
	BKB(:,14)=B(:,2).*B(:,3).*kx + B(:,8).*B(:,9).*ky;
	BKB(:,15)=kx.*B(:,3).^2 + ky.*B(:,9).^2;
	BKB(:,16)=B(:,3).*B(:,4).*kx + B(:,9).*B(:,10).*ky;
	BKB(:,17)=B(:,3).*B(:,5).*kx + B(:,9).*B(:,11).*ky;
	BKB(:,18)=B(:,3).*B(:,6).*kx + B(:,9).*B(:,12).*ky;
	BKB(:,19)=B(:,1).*B(:,4).*kx + B(:,7).*B(:,10).*ky;
	BKB(:,20)=B(:,2).*B(:,4).*kx + B(:,8).*B(:,10).*ky;
	BKB(:,21)=B(:,3).*B(:,4).*kx + B(:,9).*B(:,10).*ky;
	BKB(:,22)=kx.*B(:,4).^2 + ky.*B(:,10).^2;
	BKB(:,23)=B(:,4).*B(:,5).*kx + B(:,10).*B(:,11).*ky;
	BKB(:,24)=B(:,4).*B(:,6).*kx + B(:,10).*B(:,12).*ky;
	BKB(:,25)=B(:,1).*B(:,5).*kx + B(:,7).*B(:,11).*ky;
	BKB(:,26)=B(:,2).*B(:,5).*kx + B(:,8).*B(:,11).*ky;
	BKB(:,27)=B(:,3).*B(:,5).*kx + B(:,9).*B(:,11).*ky;
	BKB(:,28)=B(:,4).*B(:,5).*kx + B(:,10).*B(:,11).*ky;
	BKB(:,29)=kx.*B(:,5).^2 + ky.*B(:,11).^2;
	BKB(:,30)=B(:,5).*B(:,6).*kx + B(:,11).*B(:,12).*ky;
	BKB(:,31)=B(:,1).*B(:,6).*kx + B(:,7).*B(:,12).*ky;
	BKB(:,32)=B(:,2).*B(:,6).*kx + B(:,8).*B(:,12).*ky;
	BKB(:,33)=B(:,3).*B(:,6).*kx + B(:,9).*B(:,12).*ky;
	BKB(:,34)=B(:,4).*B(:,6).*kx + B(:,10).*B(:,12).*ky;
	BKB(:,35)=B(:,5).*B(:,6).*kx + B(:,11).*B(:,12).*ky;
	BKB(:,36)=kx.*B(:,6).^2 + ky.*B(:,12).^2;
else
	if ii==1;BKB=kx.*B(:,1).^2 + ky.*B(:,7).^2;return;end
	if ii==2;BKB=B(:,1).*B(:,2).*kx + B(:,7).*B(:,8).*ky;return;end
	if ii==3;BKB=B(:,1).*B(:,3).*kx + B(:,7).*B(:,9).*ky;return;end
	if ii==4;BKB=B(:,1).*B(:,4).*kx + B(:,7).*B(:,10).*ky;return;end
	if ii==5;BKB=B(:,1).*B(:,5).*kx + B(:,7).*B(:,11).*ky;return;end
	if ii==6;BKB=B(:,1).*B(:,6).*kx + B(:,7).*B(:,12).*ky;return;end
	if ii==7;BKB=B(:,1).*B(:,2).*kx + B(:,7).*B(:,8).*ky;return;end
	if ii==8;BKB=kx.*B(:,2).^2 + ky.*B(:,8).^2;return;end
	if ii==9;BKB=B(:,2).*B(:,3).*kx + B(:,8).*B(:,9).*ky;return;end
	if ii==10;BKB=B(:,2).*B(:,4).*kx + B(:,8).*B(:,10).*ky;return;end
	if ii==11;BKB=B(:,2).*B(:,5).*kx + B(:,8).*B(:,11).*ky;return;end
	if ii==12;BKB=B(:,2).*B(:,6).*kx + B(:,8).*B(:,12).*ky;return;end
	if ii==13;BKB=B(:,1).*B(:,3).*kx + B(:,7).*B(:,9).*ky;return;end
	if ii==14;BKB=B(:,2).*B(:,3).*kx + B(:,8).*B(:,9).*ky;return;end
	if ii==15;BKB=kx.*B(:,3).^2 + ky.*B(:,9).^2;return;end
	if ii==16;BKB=B(:,3).*B(:,4).*kx + B(:,9).*B(:,10).*ky;return;end
	if ii==17;BKB=B(:,3).*B(:,5).*kx + B(:,9).*B(:,11).*ky;return;end
	if ii==18;BKB=B(:,3).*B(:,6).*kx + B(:,9).*B(:,12).*ky;return;end
	if ii==19;BKB=B(:,1).*B(:,4).*kx + B(:,7).*B(:,10).*ky;return;end
	if ii==20;BKB=B(:,2).*B(:,4).*kx + B(:,8).*B(:,10).*ky;return;end
	if ii==21;BKB=B(:,3).*B(:,4).*kx + B(:,9).*B(:,10).*ky;return;end
	if ii==22;BKB=kx.*B(:,4).^2 + ky.*B(:,10).^2;return;end
	if ii==23;BKB=B(:,4).*B(:,5).*kx + B(:,10).*B(:,11).*ky;return;end
	if ii==24;BKB=B(:,4).*B(:,6).*kx + B(:,10).*B(:,12).*ky;return;end
	if ii==25;BKB=B(:,1).*B(:,5).*kx + B(:,7).*B(:,11).*ky;return;end
	if ii==26;BKB=B(:,2).*B(:,5).*kx + B(:,8).*B(:,11).*ky;return;end
	if ii==27;BKB=B(:,3).*B(:,5).*kx + B(:,9).*B(:,11).*ky;return;end
	if ii==28;BKB=B(:,4).*B(:,5).*kx + B(:,10).*B(:,11).*ky;return;end
	if ii==29;BKB=kx.*B(:,5).^2 + ky.*B(:,11).^2;return;end
	if ii==30;BKB=B(:,5).*B(:,6).*kx + B(:,11).*B(:,12).*ky;return;end
	if ii==31;BKB=B(:,1).*B(:,6).*kx + B(:,7).*B(:,12).*ky;return;end
	if ii==32;BKB=B(:,2).*B(:,6).*kx + B(:,8).*B(:,12).*ky;return;end
	if ii==33;BKB=B(:,3).*B(:,6).*kx + B(:,9).*B(:,12).*ky;return;end
	if ii==34;BKB=B(:,4).*B(:,6).*kx + B(:,10).*B(:,12).*ky;return;end
	if ii==35;BKB=B(:,5).*B(:,6).*kx + B(:,11).*B(:,12).*ky;return;end
	if ii==36;BKB=kx.*B(:,6).^2 + ky.*B(:,12).^2;return;end
end
 