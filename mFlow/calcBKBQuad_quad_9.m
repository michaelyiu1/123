function BKB=calcBKBQuad_quad_9(B,K,ii)
% BKB = calcBKBQuad_quad_9(B, K, ii)
%
% Computes the product B'*K*B in vectorized manner for quadratic
% quadrilateral elements with one dof in the center of the element
%
% Input
% B : [Nel x 18] contains the contributions of each element to the final
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
% syms b1 b2 b3 b4 b5 b6 b7 b8 b9
% syms b10 b11 b12 b13 b14 b15 b16 b17 b18
% syms kx ky
% B=[b1 b2 b3 b4 b5 b6 b7 b8 b9;...
%    b10 b11 b12 b13 b14 b15 b16 b17 b18];
% BT = [b1 b10; b2 b11; b3 b12; b4 b13; b5 b14;...
%       b6 b15; b7 b16; b8 b17; b9 b18];
% BKB = BT*[kx 0; 0 ky]*B
%
% see also calcBKB, Assemble_LHS

kx=K(:,1);ky=K(:,2);
if isempty(ii)
	BKB(:,1)=kx.*B(:,1).^2 + ky.*B(:,10).^2;
	BKB(:,2)=B(:,1).*B(:,2).*kx + B(:,10).*B(:,11).*ky;
	BKB(:,3)=B(:,1).*B(:,3).*kx + B(:,10).*B(:,12).*ky;
	BKB(:,4)=B(:,1).*B(:,4).*kx + B(:,10).*B(:,13).*ky;
	BKB(:,5)=B(:,1).*B(:,5).*kx + B(:,10).*B(:,14).*ky;
	BKB(:,6)=B(:,1).*B(:,6).*kx + B(:,10).*B(:,15).*ky;
	BKB(:,7)=B(:,1).*B(:,7).*kx + B(:,10).*B(:,16).*ky;
	BKB(:,8)=B(:,1).*B(:,8).*kx + B(:,10).*B(:,17).*ky;
	BKB(:,9)=B(:,1).*B(:,9).*kx + B(:,10).*B(:,18).*ky;
	BKB(:,10)=B(:,1).*B(:,2).*kx + B(:,10).*B(:,11).*ky;
	BKB(:,11)=kx.*B(:,2).^2 + ky.*B(:,11).^2;
	BKB(:,12)=B(:,2).*B(:,3).*kx + B(:,11).*B(:,12).*ky;
	BKB(:,13)=B(:,2).*B(:,4).*kx + B(:,11).*B(:,13).*ky;
	BKB(:,14)=B(:,2).*B(:,5).*kx + B(:,11).*B(:,14).*ky;
	BKB(:,15)=B(:,2).*B(:,6).*kx + B(:,11).*B(:,15).*ky;
	BKB(:,16)=B(:,2).*B(:,7).*kx + B(:,11).*B(:,16).*ky;
	BKB(:,17)=B(:,2).*B(:,8).*kx + B(:,11).*B(:,17).*ky;
	BKB(:,18)=B(:,2).*B(:,9).*kx + B(:,11).*B(:,18).*ky;
	BKB(:,19)=B(:,1).*B(:,3).*kx + B(:,10).*B(:,12).*ky;
	BKB(:,20)=B(:,2).*B(:,3).*kx + B(:,11).*B(:,12).*ky;
	BKB(:,21)=kx.*B(:,3).^2 + ky.*B(:,12).^2;
	BKB(:,22)=B(:,3).*B(:,4).*kx + B(:,12).*B(:,13).*ky;
	BKB(:,23)=B(:,3).*B(:,5).*kx + B(:,12).*B(:,14).*ky;
	BKB(:,24)=B(:,3).*B(:,6).*kx + B(:,12).*B(:,15).*ky;
	BKB(:,25)=B(:,3).*B(:,7).*kx + B(:,12).*B(:,16).*ky;
	BKB(:,26)=B(:,3).*B(:,8).*kx + B(:,12).*B(:,17).*ky;
	BKB(:,27)=B(:,3).*B(:,9).*kx + B(:,12).*B(:,18).*ky;
	BKB(:,28)=B(:,1).*B(:,4).*kx + B(:,10).*B(:,13).*ky;
	BKB(:,29)=B(:,2).*B(:,4).*kx + B(:,11).*B(:,13).*ky;
	BKB(:,30)=B(:,3).*B(:,4).*kx + B(:,12).*B(:,13).*ky;
	BKB(:,31)=kx.*B(:,4).^2 + ky.*B(:,13).^2;
	BKB(:,32)=B(:,4).*B(:,5).*kx + B(:,13).*B(:,14).*ky;
	BKB(:,33)=B(:,4).*B(:,6).*kx + B(:,13).*B(:,15).*ky;
	BKB(:,34)=B(:,4).*B(:,7).*kx + B(:,13).*B(:,16).*ky;
	BKB(:,35)=B(:,4).*B(:,8).*kx + B(:,13).*B(:,17).*ky;
	BKB(:,36)=B(:,4).*B(:,9).*kx + B(:,13).*B(:,18).*ky;
	BKB(:,37)=B(:,1).*B(:,5).*kx + B(:,10).*B(:,14).*ky;
	BKB(:,38)=B(:,2).*B(:,5).*kx + B(:,11).*B(:,14).*ky;
	BKB(:,39)=B(:,3).*B(:,5).*kx + B(:,12).*B(:,14).*ky;
	BKB(:,40)=B(:,4).*B(:,5).*kx + B(:,13).*B(:,14).*ky;
	BKB(:,41)=kx.*B(:,5).^2 + ky.*B(:,14).^2;
	BKB(:,42)=B(:,5).*B(:,6).*kx + B(:,14).*B(:,15).*ky;
	BKB(:,43)=B(:,5).*B(:,7).*kx + B(:,14).*B(:,16).*ky;
	BKB(:,44)=B(:,5).*B(:,8).*kx + B(:,14).*B(:,17).*ky;
	BKB(:,45)=B(:,5).*B(:,9).*kx + B(:,14).*B(:,18).*ky;
	BKB(:,46)=B(:,1).*B(:,6).*kx + B(:,10).*B(:,15).*ky;
	BKB(:,47)=B(:,2).*B(:,6).*kx + B(:,11).*B(:,15).*ky;
	BKB(:,48)=B(:,3).*B(:,6).*kx + B(:,12).*B(:,15).*ky;
	BKB(:,49)=B(:,4).*B(:,6).*kx + B(:,13).*B(:,15).*ky;
	BKB(:,50)=B(:,5).*B(:,6).*kx + B(:,14).*B(:,15).*ky;
	BKB(:,51)=kx.*B(:,6).^2 + ky.*B(:,15).^2;
	BKB(:,52)=B(:,6).*B(:,7).*kx + B(:,15).*B(:,16).*ky;
	BKB(:,53)=B(:,6).*B(:,8).*kx + B(:,15).*B(:,17).*ky;
	BKB(:,54)=B(:,6).*B(:,9).*kx + B(:,15).*B(:,18).*ky;
	BKB(:,55)=B(:,1).*B(:,7).*kx + B(:,10).*B(:,16).*ky;
	BKB(:,56)=B(:,2).*B(:,7).*kx + B(:,11).*B(:,16).*ky;
	BKB(:,57)=B(:,3).*B(:,7).*kx + B(:,12).*B(:,16).*ky;
	BKB(:,58)=B(:,4).*B(:,7).*kx + B(:,13).*B(:,16).*ky;
	BKB(:,59)=B(:,5).*B(:,7).*kx + B(:,14).*B(:,16).*ky;
	BKB(:,60)=B(:,6).*B(:,7).*kx + B(:,15).*B(:,16).*ky;
	BKB(:,61)=kx.*B(:,7).^2 + ky.*B(:,16).^2;
	BKB(:,62)=B(:,7).*B(:,8).*kx + B(:,16).*B(:,17).*ky;
	BKB(:,63)=B(:,7).*B(:,9).*kx + B(:,16).*B(:,18).*ky;
	BKB(:,64)=B(:,1).*B(:,8).*kx + B(:,10).*B(:,17).*ky;
	BKB(:,65)=B(:,2).*B(:,8).*kx + B(:,11).*B(:,17).*ky;
	BKB(:,66)=B(:,3).*B(:,8).*kx + B(:,12).*B(:,17).*ky;
	BKB(:,67)=B(:,4).*B(:,8).*kx + B(:,13).*B(:,17).*ky;
	BKB(:,68)=B(:,5).*B(:,8).*kx + B(:,14).*B(:,17).*ky;
	BKB(:,69)=B(:,6).*B(:,8).*kx + B(:,15).*B(:,17).*ky;
	BKB(:,70)=B(:,7).*B(:,8).*kx + B(:,16).*B(:,17).*ky;
	BKB(:,71)=kx.*B(:,8).^2 + ky.*B(:,17).^2;
	BKB(:,72)=B(:,8).*B(:,9).*kx + B(:,17).*B(:,18).*ky;
	BKB(:,73)=B(:,1).*B(:,9).*kx + B(:,10).*B(:,18).*ky;
	BKB(:,74)=B(:,2).*B(:,9).*kx + B(:,11).*B(:,18).*ky;
	BKB(:,75)=B(:,3).*B(:,9).*kx + B(:,12).*B(:,18).*ky;
	BKB(:,76)=B(:,4).*B(:,9).*kx + B(:,13).*B(:,18).*ky;
	BKB(:,77)=B(:,5).*B(:,9).*kx + B(:,14).*B(:,18).*ky;
	BKB(:,78)=B(:,6).*B(:,9).*kx + B(:,15).*B(:,18).*ky;
	BKB(:,79)=B(:,7).*B(:,9).*kx + B(:,16).*B(:,18).*ky;
	BKB(:,80)=B(:,8).*B(:,9).*kx + B(:,17).*B(:,18).*ky;
	BKB(:,81)=kx.*B(:,9).^2 + ky.*B(:,18).^2;
else
	if ii==1;BKB=kx.*B(:,1).^2 + ky.*B(:,10).^2;					return;end
	if ii==2;BKB=B(:,1).*B(:,2).*kx + B(:,10).*B(:,11).*ky;         return;end
	if ii==3;BKB=B(:,1).*B(:,3).*kx + B(:,10).*B(:,12).*ky;         return;end
	if ii==4;BKB=B(:,1).*B(:,4).*kx + B(:,10).*B(:,13).*ky;         return;end
	if ii==5;BKB=B(:,1).*B(:,5).*kx + B(:,10).*B(:,14).*ky;         return;end
	if ii==6;BKB=B(:,1).*B(:,6).*kx + B(:,10).*B(:,15).*ky;         return;end
	if ii==7;BKB=B(:,1).*B(:,7).*kx + B(:,10).*B(:,16).*ky;         return;end
	if ii==8;BKB=B(:,1).*B(:,8).*kx + B(:,10).*B(:,17).*ky;         return;end
	if ii==9;BKB=B(:,1).*B(:,9).*kx + B(:,10).*B(:,18).*ky;         return;end
	if ii==10;BKB=B(:,1).*B(:,2).*kx + B(:,10).*B(:,11).*ky;        return;end
	if ii==11;BKB=kx.*B(:,2).^2 + ky.*B(:,11).^2;                   return;end
	if ii==12;BKB=B(:,2).*B(:,3).*kx + B(:,11).*B(:,12).*ky;        return;end
	if ii==13;BKB=B(:,2).*B(:,4).*kx + B(:,11).*B(:,13).*ky;        return;end
	if ii==14;BKB=B(:,2).*B(:,5).*kx + B(:,11).*B(:,14).*ky;        return;end
	if ii==15;BKB=B(:,2).*B(:,6).*kx + B(:,11).*B(:,15).*ky;        return;end
	if ii==16;BKB=B(:,2).*B(:,7).*kx + B(:,11).*B(:,16).*ky;        return;end
	if ii==17;BKB=B(:,2).*B(:,8).*kx + B(:,11).*B(:,17).*ky;        return;end
	if ii==18;BKB=B(:,2).*B(:,9).*kx + B(:,11).*B(:,18).*ky;        return;end
	if ii==19;BKB=B(:,1).*B(:,3).*kx + B(:,10).*B(:,12).*ky;        return;end
	if ii==20;BKB=B(:,2).*B(:,3).*kx + B(:,11).*B(:,12).*ky;        return;end
	if ii==21;BKB=kx.*B(:,3).^2 + ky.*B(:,12).^2;                   return;end
	if ii==22;BKB=B(:,3).*B(:,4).*kx + B(:,12).*B(:,13).*ky;        return;end
	if ii==23;BKB=B(:,3).*B(:,5).*kx + B(:,12).*B(:,14).*ky;        return;end
	if ii==24;BKB=B(:,3).*B(:,6).*kx + B(:,12).*B(:,15).*ky;        return;end
	if ii==25;BKB=B(:,3).*B(:,7).*kx + B(:,12).*B(:,16).*ky;        return;end
	if ii==26;BKB=B(:,3).*B(:,8).*kx + B(:,12).*B(:,17).*ky;        return;end
	if ii==27;BKB=B(:,3).*B(:,9).*kx + B(:,12).*B(:,18).*ky;        return;end
	if ii==28;BKB=B(:,1).*B(:,4).*kx + B(:,10).*B(:,13).*ky;        return;end
	if ii==29;BKB=B(:,2).*B(:,4).*kx + B(:,11).*B(:,13).*ky;        return;end
	if ii==30;BKB=B(:,3).*B(:,4).*kx + B(:,12).*B(:,13).*ky;        return;end
	if ii==31;BKB=kx.*B(:,4).^2 + ky.*B(:,13).^2;                   return;end
	if ii==32;BKB=B(:,4).*B(:,5).*kx + B(:,13).*B(:,14).*ky;        return;end
	if ii==33;BKB=B(:,4).*B(:,6).*kx + B(:,13).*B(:,15).*ky;        return;end
	if ii==34;BKB=B(:,4).*B(:,7).*kx + B(:,13).*B(:,16).*ky;        return;end
	if ii==35;BKB=B(:,4).*B(:,8).*kx + B(:,13).*B(:,17).*ky;        return;end
	if ii==36;BKB=B(:,4).*B(:,9).*kx + B(:,13).*B(:,18).*ky;        return;end
	if ii==37;BKB=B(:,1).*B(:,5).*kx + B(:,10).*B(:,14).*ky;        return;end
	if ii==38;BKB=B(:,2).*B(:,5).*kx + B(:,11).*B(:,14).*ky;        return;end
	if ii==39;BKB=B(:,3).*B(:,5).*kx + B(:,12).*B(:,14).*ky;        return;end
	if ii==40;BKB=B(:,4).*B(:,5).*kx + B(:,13).*B(:,14).*ky;        return;end
	if ii==41;BKB=kx.*B(:,5).^2 + ky.*B(:,14).^2;                   return;end
	if ii==42;BKB=B(:,5).*B(:,6).*kx + B(:,14).*B(:,15).*ky;        return;end
	if ii==43;BKB=B(:,5).*B(:,7).*kx + B(:,14).*B(:,16).*ky;        return;end
	if ii==44;BKB=B(:,5).*B(:,8).*kx + B(:,14).*B(:,17).*ky;        return;end
	if ii==45;BKB=B(:,5).*B(:,9).*kx + B(:,14).*B(:,18).*ky;        return;end
	if ii==46;BKB=B(:,1).*B(:,6).*kx + B(:,10).*B(:,15).*ky;        return;end
	if ii==47;BKB=B(:,2).*B(:,6).*kx + B(:,11).*B(:,15).*ky;        return;end
	if ii==48;BKB=B(:,3).*B(:,6).*kx + B(:,12).*B(:,15).*ky;        return;end
	if ii==49;BKB=B(:,4).*B(:,6).*kx + B(:,13).*B(:,15).*ky;        return;end
	if ii==50;BKB=B(:,5).*B(:,6).*kx + B(:,14).*B(:,15).*ky;        return;end
	if ii==51;BKB=kx.*B(:,6).^2 + ky.*B(:,15).^2;                   return;end
	if ii==52;BKB=B(:,6).*B(:,7).*kx + B(:,15).*B(:,16).*ky;        return;end
	if ii==53;BKB=B(:,6).*B(:,8).*kx + B(:,15).*B(:,17).*ky;        return;end
	if ii==54;BKB=B(:,6).*B(:,9).*kx + B(:,15).*B(:,18).*ky;        return;end
	if ii==55;BKB=B(:,1).*B(:,7).*kx + B(:,10).*B(:,16).*ky;        return;end
	if ii==56;BKB=B(:,2).*B(:,7).*kx + B(:,11).*B(:,16).*ky;        return;end
	if ii==57;BKB=B(:,3).*B(:,7).*kx + B(:,12).*B(:,16).*ky;        return;end
	if ii==58;BKB=B(:,4).*B(:,7).*kx + B(:,13).*B(:,16).*ky;        return;end
	if ii==59;BKB=B(:,5).*B(:,7).*kx + B(:,14).*B(:,16).*ky;        return;end
	if ii==60;BKB=B(:,6).*B(:,7).*kx + B(:,15).*B(:,16).*ky;        return;end
	if ii==61;BKB=kx.*B(:,7).^2 + ky.*B(:,16).^2;                   return;end
	if ii==62;BKB=B(:,7).*B(:,8).*kx + B(:,16).*B(:,17).*ky;        return;end
	if ii==63;BKB=B(:,7).*B(:,9).*kx + B(:,16).*B(:,18).*ky;        return;end
	if ii==64;BKB=B(:,1).*B(:,8).*kx + B(:,10).*B(:,17).*ky;        return;end
	if ii==65;BKB=B(:,2).*B(:,8).*kx + B(:,11).*B(:,17).*ky;        return;end
	if ii==66;BKB=B(:,3).*B(:,8).*kx + B(:,12).*B(:,17).*ky;        return;end
	if ii==67;BKB=B(:,4).*B(:,8).*kx + B(:,13).*B(:,17).*ky;        return;end
	if ii==68;BKB=B(:,5).*B(:,8).*kx + B(:,14).*B(:,17).*ky;        return;end
	if ii==69;BKB=B(:,6).*B(:,8).*kx + B(:,15).*B(:,17).*ky;        return;end
	if ii==70;BKB=B(:,7).*B(:,8).*kx + B(:,16).*B(:,17).*ky;        return;end
	if ii==71;BKB=kx.*B(:,8).^2 + ky.*B(:,17).^2;                   return;end
	if ii==72;BKB=B(:,8).*B(:,9).*kx + B(:,17).*B(:,18).*ky;        return;end
	if ii==73;BKB=B(:,1).*B(:,9).*kx + B(:,10).*B(:,18).*ky;        return;end
	if ii==74;BKB=B(:,2).*B(:,9).*kx + B(:,11).*B(:,18).*ky;        return;end
	if ii==75;BKB=B(:,3).*B(:,9).*kx + B(:,12).*B(:,18).*ky;        return;end
	if ii==76;BKB=B(:,4).*B(:,9).*kx + B(:,13).*B(:,18).*ky;        return;end
	if ii==77;BKB=B(:,5).*B(:,9).*kx + B(:,14).*B(:,18).*ky;        return;end
	if ii==78;BKB=B(:,6).*B(:,9).*kx + B(:,15).*B(:,18).*ky;        return;end
	if ii==79;BKB=B(:,7).*B(:,9).*kx + B(:,16).*B(:,18).*ky;        return;end
	if ii==80;BKB=B(:,8).*B(:,9).*kx + B(:,17).*B(:,18).*ky;        return;end
	if ii==81;BKB=kx.*B(:,9).^2 + ky.*B(:,18).^2;                   return;end
end
 