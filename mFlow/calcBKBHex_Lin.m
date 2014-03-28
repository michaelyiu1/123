function BKB=calcBKBHex_Lin(B,K,ii)
% BKB = calcBKBHex_Lin(B, K, ii)
% Computes the product B'*K*B in vectorized manner for linear hexahedral
% elements
%
% Input
% B : [Nel x N_sh^2] contains the contributions of each element to the final
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
%
% syms b1 b2 b3 b4 b5 b6 b7 b8
% syms b9 b10 b11 b12 b13 b14 b15 b16
% syms b17 b18 b19 b20 b21 b22 b23 b24 
% syms kx ky kz
% B=[b1 b2 b3 b4 b5 b6 b7 b8;...
%    b9 b10 b11 b12 b13 b14 b15 b16;...
%    b17 b18 b19 b20 b21 b22 b23 b24];
% 
% BT=[ b1 b9 b17;...
%      b2 b10 b18;...
%      b3 b11 b19;...
%      b4 b12 b20;...
%      b5 b13 b21;...
%      b6 b14 b22;...
%      b7 b15 b23;...
%      b8 b16 b24];
%  
% K=[kx 0 0;...
%     0 ky 0;...
%     0  0  kz];
%  
% BKB=BT*K*B
%
% see also calcBKB, Assemble_LHS

kx=K(:,1);ky=K(:,2);kz=K(:,3);

if isempty(ii)
	BKB(:,1)=kx.*B(:,1).^2 + ky.*B(:,9).^2 + kz.*B(:,17).^2;
	BKB(:,2)=B(:,1).*B(:,2).*kx + B(:,9).*B(:,10).*ky + B(:,17).*B(:,18).*kz;
	BKB(:,3)=B(:,1).*B(:,3).*kx + B(:,9).*B(:,11).*ky + B(:,17).*B(:,19).*kz;
	BKB(:,4)=B(:,1).*B(:,4).*kx + B(:,9).*B(:,12).*ky + B(:,17).*B(:,20).*kz;
	BKB(:,5)=B(:,1).*B(:,5).*kx + B(:,9).*B(:,13).*ky + B(:,17).*B(:,21).*kz;
	BKB(:,6)=B(:,1).*B(:,6).*kx + B(:,9).*B(:,14).*ky + B(:,17).*B(:,22).*kz;
	BKB(:,7)=B(:,1).*B(:,7).*kx + B(:,9).*B(:,15).*ky + B(:,17).*B(:,23).*kz;
	BKB(:,8)=B(:,1).*B(:,8).*kx + B(:,9).*B(:,16).*ky + B(:,17).*B(:,24).*kz;
	BKB(:,9)=B(:,1).*B(:,2).*kx + B(:,9).*B(:,10).*ky + B(:,17).*B(:,18).*kz;
	BKB(:,10)=kx.*B(:,2).^2 + ky.*B(:,10).^2 + kz.*B(:,18).^2;
	BKB(:,11)=B(:,2).*B(:,3).*kx + B(:,10).*B(:,11).*ky + B(:,18).*B(:,19).*kz;
	BKB(:,12)=B(:,2).*B(:,4).*kx + B(:,10).*B(:,12).*ky + B(:,18).*B(:,20).*kz;
	BKB(:,13)=B(:,2).*B(:,5).*kx + B(:,10).*B(:,13).*ky + B(:,18).*B(:,21).*kz;
	BKB(:,14)=B(:,2).*B(:,6).*kx + B(:,10).*B(:,14).*ky + B(:,18).*B(:,22).*kz;
	BKB(:,15)=B(:,2).*B(:,7).*kx + B(:,10).*B(:,15).*ky + B(:,18).*B(:,23).*kz;
	BKB(:,16)=B(:,2).*B(:,8).*kx + B(:,10).*B(:,16).*ky + B(:,18).*B(:,24).*kz;
	BKB(:,17)=B(:,1).*B(:,3).*kx + B(:,9).*B(:,11).*ky + B(:,17).*B(:,19).*kz;
	BKB(:,18)=B(:,2).*B(:,3).*kx + B(:,10).*B(:,11).*ky + B(:,18).*B(:,19).*kz;
	BKB(:,19)=kx.*B(:,3).^2 + ky.*B(:,11).^2 + kz.*B(:,19).^2;
	BKB(:,20)=B(:,3).*B(:,4).*kx + B(:,11).*B(:,12).*ky + B(:,19).*B(:,20).*kz;
	BKB(:,21)=B(:,3).*B(:,5).*kx + B(:,11).*B(:,13).*ky + B(:,19).*B(:,21).*kz;
	BKB(:,22)=B(:,3).*B(:,6).*kx + B(:,11).*B(:,14).*ky + B(:,19).*B(:,22).*kz;
	BKB(:,23)=B(:,3).*B(:,7).*kx + B(:,11).*B(:,15).*ky + B(:,19).*B(:,23).*kz;
	BKB(:,24)=B(:,3).*B(:,8).*kx + B(:,11).*B(:,16).*ky + B(:,19).*B(:,24).*kz;
	BKB(:,25)=B(:,1).*B(:,4).*kx + B(:,9).*B(:,12).*ky + B(:,17).*B(:,20).*kz;
	BKB(:,26)=B(:,2).*B(:,4).*kx + B(:,10).*B(:,12).*ky + B(:,18).*B(:,20).*kz;
	BKB(:,27)=B(:,3).*B(:,4).*kx + B(:,11).*B(:,12).*ky + B(:,19).*B(:,20).*kz;
	BKB(:,28)=kx.*B(:,4).^2 + ky.*B(:,12).^2 + kz.*B(:,20).^2;
	BKB(:,29)=B(:,4).*B(:,5).*kx + B(:,12).*B(:,13).*ky + B(:,20).*B(:,21).*kz;
	BKB(:,30)=B(:,4).*B(:,6).*kx + B(:,12).*B(:,14).*ky + B(:,20).*B(:,22).*kz;
	BKB(:,31)=B(:,4).*B(:,7).*kx + B(:,12).*B(:,15).*ky + B(:,20).*B(:,23).*kz;
	BKB(:,32)=B(:,4).*B(:,8).*kx + B(:,12).*B(:,16).*ky + B(:,20).*B(:,24).*kz;
	BKB(:,33)=B(:,1).*B(:,5).*kx + B(:,9).*B(:,13).*ky + B(:,17).*B(:,21).*kz;
	BKB(:,34)=B(:,2).*B(:,5).*kx + B(:,10).*B(:,13).*ky + B(:,18).*B(:,21).*kz;
	BKB(:,35)=B(:,3).*B(:,5).*kx + B(:,11).*B(:,13).*ky + B(:,19).*B(:,21).*kz;
	BKB(:,36)=B(:,4).*B(:,5).*kx + B(:,12).*B(:,13).*ky + B(:,20).*B(:,21).*kz;
	BKB(:,37)=kx.*B(:,5).^2 + ky.*B(:,13).^2 + kz.*B(:,21).^2;
	BKB(:,38)=B(:,5).*B(:,6).*kx + B(:,13).*B(:,14).*ky + B(:,21).*B(:,22).*kz;
	BKB(:,39)=B(:,5).*B(:,7).*kx + B(:,13).*B(:,15).*ky + B(:,21).*B(:,23).*kz;
	BKB(:,40)=B(:,5).*B(:,8).*kx + B(:,13).*B(:,16).*ky + B(:,21).*B(:,24).*kz;
	BKB(:,41)=B(:,1).*B(:,6).*kx + B(:,9).*B(:,14).*ky + B(:,17).*B(:,22).*kz;
	BKB(:,42)=B(:,2).*B(:,6).*kx + B(:,10).*B(:,14).*ky + B(:,18).*B(:,22).*kz;
	BKB(:,43)=B(:,3).*B(:,6).*kx + B(:,11).*B(:,14).*ky + B(:,19).*B(:,22).*kz;
	BKB(:,44)=B(:,4).*B(:,6).*kx + B(:,12).*B(:,14).*ky + B(:,20).*B(:,22).*kz;
	BKB(:,45)=B(:,5).*B(:,6).*kx + B(:,13).*B(:,14).*ky + B(:,21).*B(:,22).*kz;
	BKB(:,46)=kx.*B(:,6).^2 + ky.*B(:,14).^2 + kz.*B(:,22).^2;
	BKB(:,47)=B(:,6).*B(:,7).*kx + B(:,14).*B(:,15).*ky + B(:,22).*B(:,23).*kz;
	BKB(:,48)=B(:,6).*B(:,8).*kx + B(:,14).*B(:,16).*ky + B(:,22).*B(:,24).*kz;
	BKB(:,49)=B(:,1).*B(:,7).*kx + B(:,9).*B(:,15).*ky + B(:,17).*B(:,23).*kz;
	BKB(:,50)=B(:,2).*B(:,7).*kx + B(:,10).*B(:,15).*ky + B(:,18).*B(:,23).*kz;
	BKB(:,51)=B(:,3).*B(:,7).*kx + B(:,11).*B(:,15).*ky + B(:,19).*B(:,23).*kz;
	BKB(:,52)=B(:,4).*B(:,7).*kx + B(:,12).*B(:,15).*ky + B(:,20).*B(:,23).*kz;
	BKB(:,53)=B(:,5).*B(:,7).*kx + B(:,13).*B(:,15).*ky + B(:,21).*B(:,23).*kz;
	BKB(:,54)=B(:,6).*B(:,7).*kx + B(:,14).*B(:,15).*ky + B(:,22).*B(:,23).*kz;
	BKB(:,55)=kx.*B(:,7).^2 + ky.*B(:,15).^2 + kz.*B(:,23).^2;
	BKB(:,56)=B(:,7).*B(:,8).*kx + B(:,15).*B(:,16).*ky + B(:,23).*B(:,24).*kz;
	BKB(:,57)=B(:,1).*B(:,8).*kx + B(:,9).*B(:,16).*ky + B(:,17).*B(:,24).*kz;
	BKB(:,58)=B(:,2).*B(:,8).*kx + B(:,10).*B(:,16).*ky + B(:,18).*B(:,24).*kz;
	BKB(:,59)=B(:,3).*B(:,8).*kx + B(:,11).*B(:,16).*ky + B(:,19).*B(:,24).*kz;
	BKB(:,60)=B(:,4).*B(:,8).*kx + B(:,12).*B(:,16).*ky + B(:,20).*B(:,24).*kz;
	BKB(:,61)=B(:,5).*B(:,8).*kx + B(:,13).*B(:,16).*ky + B(:,21).*B(:,24).*kz;
	BKB(:,62)=B(:,6).*B(:,8).*kx + B(:,14).*B(:,16).*ky + B(:,22).*B(:,24).*kz;
	BKB(:,63)=B(:,7).*B(:,8).*kx + B(:,15).*B(:,16).*ky + B(:,23).*B(:,24).*kz;
	BKB(:,64)=kx.*B(:,8).^2 + ky.*B(:,16).^2 + kz.*B(:,24).^2;
else
	if ii==1;BKB=kx.*B(:,1).^2 + ky.*B(:,9).^2 + kz.*B(:,17).^2;                     return;end
	if ii==2;BKB=B(:,1).*B(:,2).*kx + B(:,9).*B(:,10).*ky + B(:,17).*B(:,18).*kz;    return;end
	if ii==3;BKB=B(:,1).*B(:,3).*kx + B(:,9).*B(:,11).*ky + B(:,17).*B(:,19).*kz;    return;end
	if ii==4;BKB=B(:,1).*B(:,4).*kx + B(:,9).*B(:,12).*ky + B(:,17).*B(:,20).*kz;    return;end
	if ii==5;BKB=B(:,1).*B(:,5).*kx + B(:,9).*B(:,13).*ky + B(:,17).*B(:,21).*kz;    return;end
	if ii==6;BKB=B(:,1).*B(:,6).*kx + B(:,9).*B(:,14).*ky + B(:,17).*B(:,22).*kz;    return;end
	if ii==7;BKB=B(:,1).*B(:,7).*kx + B(:,9).*B(:,15).*ky + B(:,17).*B(:,23).*kz;    return;end
	if ii==8;BKB=B(:,1).*B(:,8).*kx + B(:,9).*B(:,16).*ky + B(:,17).*B(:,24).*kz;    return;end
	if ii==9;BKB=B(:,1).*B(:,2).*kx + B(:,9).*B(:,10).*ky + B(:,17).*B(:,18).*kz;    return;end
	if ii==10;BKB=kx.*B(:,2).^2 + ky.*B(:,10).^2 + kz.*B(:,18).^2;                   return;end
	if ii==11;BKB=B(:,2).*B(:,3).*kx + B(:,10).*B(:,11).*ky + B(:,18).*B(:,19).*kz;  return;end
	if ii==12;BKB=B(:,2).*B(:,4).*kx + B(:,10).*B(:,12).*ky + B(:,18).*B(:,20).*kz;  return;end
	if ii==13;BKB=B(:,2).*B(:,5).*kx + B(:,10).*B(:,13).*ky + B(:,18).*B(:,21).*kz;  return;end
	if ii==14;BKB=B(:,2).*B(:,6).*kx + B(:,10).*B(:,14).*ky + B(:,18).*B(:,22).*kz;  return;end
	if ii==15;BKB=B(:,2).*B(:,7).*kx + B(:,10).*B(:,15).*ky + B(:,18).*B(:,23).*kz;  return;end
	if ii==16;BKB=B(:,2).*B(:,8).*kx + B(:,10).*B(:,16).*ky + B(:,18).*B(:,24).*kz;  return;end
	if ii==17;BKB=B(:,1).*B(:,3).*kx + B(:,9).*B(:,11).*ky + B(:,17).*B(:,19).*kz;   return;end
	if ii==18;BKB=B(:,2).*B(:,3).*kx + B(:,10).*B(:,11).*ky + B(:,18).*B(:,19).*kz;  return;end
	if ii==19;BKB=kx.*B(:,3).^2 + ky.*B(:,11).^2 + kz.*B(:,19).^2;                   return;end
	if ii==20;BKB=B(:,3).*B(:,4).*kx + B(:,11).*B(:,12).*ky + B(:,19).*B(:,20).*kz;  return;end
	if ii==21;BKB=B(:,3).*B(:,5).*kx + B(:,11).*B(:,13).*ky + B(:,19).*B(:,21).*kz;  return;end
	if ii==22;BKB=B(:,3).*B(:,6).*kx + B(:,11).*B(:,14).*ky + B(:,19).*B(:,22).*kz;  return;end
	if ii==23;BKB=B(:,3).*B(:,7).*kx + B(:,11).*B(:,15).*ky + B(:,19).*B(:,23).*kz;  return;end
	if ii==24;BKB=B(:,3).*B(:,8).*kx + B(:,11).*B(:,16).*ky + B(:,19).*B(:,24).*kz;  return;end
	if ii==25;BKB=B(:,1).*B(:,4).*kx + B(:,9).*B(:,12).*ky + B(:,17).*B(:,20).*kz;   return;end
	if ii==26;BKB=B(:,2).*B(:,4).*kx + B(:,10).*B(:,12).*ky + B(:,18).*B(:,20).*kz;  return;end
	if ii==27;BKB=B(:,3).*B(:,4).*kx + B(:,11).*B(:,12).*ky + B(:,19).*B(:,20).*kz;  return;end
	if ii==28;BKB=kx.*B(:,4).^2 + ky.*B(:,12).^2 + kz.*B(:,20).^2;                   return;end
	if ii==29;BKB=B(:,4).*B(:,5).*kx + B(:,12).*B(:,13).*ky + B(:,20).*B(:,21).*kz;  return;end
	if ii==30;BKB=B(:,4).*B(:,6).*kx + B(:,12).*B(:,14).*ky + B(:,20).*B(:,22).*kz;  return;end
	if ii==31;BKB=B(:,4).*B(:,7).*kx + B(:,12).*B(:,15).*ky + B(:,20).*B(:,23).*kz;  return;end
	if ii==32;BKB=B(:,4).*B(:,8).*kx + B(:,12).*B(:,16).*ky + B(:,20).*B(:,24).*kz;  return;end
	if ii==33;BKB=B(:,1).*B(:,5).*kx + B(:,9).*B(:,13).*ky + B(:,17).*B(:,21).*kz;   return;end
	if ii==34;BKB=B(:,2).*B(:,5).*kx + B(:,10).*B(:,13).*ky + B(:,18).*B(:,21).*kz;  return;end
	if ii==35;BKB=B(:,3).*B(:,5).*kx + B(:,11).*B(:,13).*ky + B(:,19).*B(:,21).*kz;  return;end
	if ii==36;BKB=B(:,4).*B(:,5).*kx + B(:,12).*B(:,13).*ky + B(:,20).*B(:,21).*kz;  return;end
	if ii==37;BKB=kx.*B(:,5).^2 + ky.*B(:,13).^2 + kz.*B(:,21).^2;                   return;end
	if ii==38;BKB=B(:,5).*B(:,6).*kx + B(:,13).*B(:,14).*ky + B(:,21).*B(:,22).*kz;  return;end
	if ii==39;BKB=B(:,5).*B(:,7).*kx + B(:,13).*B(:,15).*ky + B(:,21).*B(:,23).*kz;  return;end
	if ii==40;BKB=B(:,5).*B(:,8).*kx + B(:,13).*B(:,16).*ky + B(:,21).*B(:,24).*kz;  return;end
	if ii==41;BKB=B(:,1).*B(:,6).*kx + B(:,9).*B(:,14).*ky + B(:,17).*B(:,22).*kz;   return;end
	if ii==42;BKB=B(:,2).*B(:,6).*kx + B(:,10).*B(:,14).*ky + B(:,18).*B(:,22).*kz;  return;end
	if ii==43;BKB=B(:,3).*B(:,6).*kx + B(:,11).*B(:,14).*ky + B(:,19).*B(:,22).*kz;  return;end
	if ii==44;BKB=B(:,4).*B(:,6).*kx + B(:,12).*B(:,14).*ky + B(:,20).*B(:,22).*kz;  return;end
	if ii==45;BKB=B(:,5).*B(:,6).*kx + B(:,13).*B(:,14).*ky + B(:,21).*B(:,22).*kz;  return;end
	if ii==46;BKB=kx.*B(:,6).^2 + ky.*B(:,14).^2 + kz.*B(:,22).^2;                   return;end
	if ii==47;BKB=B(:,6).*B(:,7).*kx + B(:,14).*B(:,15).*ky + B(:,22).*B(:,23).*kz;  return;end
	if ii==48;BKB=B(:,6).*B(:,8).*kx + B(:,14).*B(:,16).*ky + B(:,22).*B(:,24).*kz;  return;end
	if ii==49;BKB=B(:,1).*B(:,7).*kx + B(:,9).*B(:,15).*ky + B(:,17).*B(:,23).*kz;   return;end
	if ii==50;BKB=B(:,2).*B(:,7).*kx + B(:,10).*B(:,15).*ky + B(:,18).*B(:,23).*kz;  return;end
	if ii==51;BKB=B(:,3).*B(:,7).*kx + B(:,11).*B(:,15).*ky + B(:,19).*B(:,23).*kz;  return;end
	if ii==52;BKB=B(:,4).*B(:,7).*kx + B(:,12).*B(:,15).*ky + B(:,20).*B(:,23).*kz;  return;end
	if ii==53;BKB=B(:,5).*B(:,7).*kx + B(:,13).*B(:,15).*ky + B(:,21).*B(:,23).*kz;  return;end
	if ii==54;BKB=B(:,6).*B(:,7).*kx + B(:,14).*B(:,15).*ky + B(:,22).*B(:,23).*kz;  return;end
	if ii==55;BKB=kx.*B(:,7).^2 + ky.*B(:,15).^2 + kz.*B(:,23).^2;                   return;end
	if ii==56;BKB=B(:,7).*B(:,8).*kx + B(:,15).*B(:,16).*ky + B(:,23).*B(:,24).*kz;  return;end
	if ii==57;BKB=B(:,1).*B(:,8).*kx + B(:,9).*B(:,16).*ky + B(:,17).*B(:,24).*kz;   return;end
	if ii==58;BKB=B(:,2).*B(:,8).*kx + B(:,10).*B(:,16).*ky + B(:,18).*B(:,24).*kz;  return;end
	if ii==59;BKB=B(:,3).*B(:,8).*kx + B(:,11).*B(:,16).*ky + B(:,19).*B(:,24).*kz;  return;end
	if ii==60;BKB=B(:,4).*B(:,8).*kx + B(:,12).*B(:,16).*ky + B(:,20).*B(:,24).*kz;  return;end
	if ii==61;BKB=B(:,5).*B(:,8).*kx + B(:,13).*B(:,16).*ky + B(:,21).*B(:,24).*kz;  return;end
	if ii==62;BKB=B(:,6).*B(:,8).*kx + B(:,14).*B(:,16).*ky + B(:,22).*B(:,24).*kz;  return;end
	if ii==63;BKB=B(:,7).*B(:,8).*kx + B(:,15).*B(:,16).*ky + B(:,23).*B(:,24).*kz;  return;end
	if ii==64;BKB=kx.*B(:,8).^2 + ky.*B(:,16).^2 + kz.*B(:,24).^2;					 return;end
end
 