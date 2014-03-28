function BKB=calcBKBPrism_Lin(B,K,ii)
% BKB = calcBKBPrism_Lin(B, K, ii)
%
% Computes the product B'*K*B in vectorized manner for linear Prism
% elements
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
%%% how to calculate the above expression using matlab symbolic toolbox
% 
% syms b1 b2 b3 b4 b5 b6
% syms b7 b8 b9 b10 b11 b12
% syms b13 b14 b15 b16 b17 b18
% syms kx ky kz
% B=[b1 b2 b3 b4 b5 b6;b7 b8 b9 b10 b11 b12;b13 b14 b15 b16 b17 b18];
% BT=[b1 b7 b13;b2 b8 b14;b3 b9 b15;b4 b10 b16;b5 b11 b17;b6 b12 b18];
% K=[kx 0 0;0 ky 0;0 0 kz];
% BKB=BT*K*B
%
% see also calcBKB, Assemble_LHS



kx=K(:,1);ky=K(:,2);kz=K(:,3);
if isempty(ii)
	BKB(:,1) = kx.*B(:,1).^2 + ky.*B(:,7).^2 + kz.*B(:,13).^2;
    BKB(:,2) = B(:,1).*B(:,2).*kx + B(:,7).*B(:,8).*ky + B(:,13).*B(:,14).*kz;
    BKB(:,3) = B(:,1).*B(:,3).*kx + B(:,7).*B(:,9).*ky + B(:,13).*B(:,15).*kz;
    BKB(:,4) = B(:,1).*B(:,4).*kx + B(:,7).*B(:,10).*ky + B(:,13).*B(:,16).*kz;
    BKB(:,5) = B(:,1).*B(:,5).*kx + B(:,7).*B(:,11).*ky + B(:,13).*B(:,17).*kz;
    BKB(:,6) = B(:,1).*B(:,6).*kx + B(:,7).*B(:,12).*ky + B(:,13).*B(:,18).*kz;
    
    BKB(:,7) = B(:,1).*B(:,2).*kx + B(:,7).*B(:,8).*ky + B(:,13).*B(:,14).*kz;
    BKB(:,8) = kx.*B(:,2).^2 + ky.*B(:,8).^2 + kz.*B(:,14).^2;
    BKB(:,9) = B(:,2).*B(:,3).*kx + B(:,8).*B(:,9).*ky + B(:,14).*B(:,15).*kz;
    BKB(:,10) = B(:,2).*B(:,4).*kx + B(:,8).*B(:,10).*ky + B(:,14).*B(:,16).*kz;
    BKB(:,11) = B(:,2).*B(:,5).*kx + B(:,8).*B(:,11).*ky + B(:,14).*B(:,17).*kz;
    BKB(:,12) = B(:,2).*B(:,6).*kx + B(:,8).*B(:,12).*ky + B(:,14).*B(:,18).*kz;
    
    BKB(:,13) = B(:,1).*B(:,3).*kx + B(:,7).*B(:,9).*ky + B(:,13).*B(:,15).*kz;
    BKB(:,14) = B(:,2).*B(:,3).*kx + B(:,8).*B(:,9).*ky + B(:,14).*B(:,15).*kz;
    BKB(:,15) = kx.*B(:,3).^2 + ky.*B(:,9).^2 + kz.*B(:,15).^2;
    BKB(:,16) = B(:,3).*B(:,4).*kx + B(:,9).*B(:,10).*ky + B(:,15).*B(:,16).*kz;
    BKB(:,17) = B(:,3).*B(:,5).*kx + B(:,9).*B(:,11).*ky + B(:,15).*B(:,17).*kz;
    BKB(:,18) = B(:,3).*B(:,6).*kx + B(:,9).*B(:,12).*ky + B(:,15).*B(:,18).*kz;
    
    BKB(:,19) = B(:,1).*B(:,4).*kx + B(:,7).*B(:,10).*ky + B(:,13).*B(:,16).*kz;
    BKB(:,20) = B(:,2).*B(:,4).*kx + B(:,8).*B(:,10).*ky + B(:,14).*B(:,16).*kz;
    BKB(:,21) = B(:,3).*B(:,4).*kx + B(:,9).*B(:,10).*ky + B(:,15).*B(:,16).*kz;
    BKB(:,22) = kx.*B(:,4).^2 + ky.*B(:,10).^2 + kz.*B(:,16).^2;
    BKB(:,23) = B(:,4).*B(:,5).*kx + B(:,10).*B(:,11).*ky + B(:,16).*B(:,17).*kz;
    BKB(:,24) = B(:,4).*B(:,6).*kx + B(:,10).*B(:,12).*ky + B(:,16).*B(:,18).*kz;
    
    BKB(:,25) = B(:,1).*B(:,5).*kx + B(:,7).*B(:,11).*ky + B(:,13).*B(:,17).*kz;
    BKB(:,26) = B(:,2).*B(:,5).*kx + B(:,8).*B(:,11).*ky + B(:,14).*B(:,17).*kz;
    BKB(:,27) = B(:,3).*B(:,5).*kx + B(:,9).*B(:,11).*ky + B(:,15).*B(:,17).*kz;
    BKB(:,28) = B(:,4).*B(:,5).*kx + B(:,10).*B(:,11).*ky + B(:,16).*B(:,17).*kz;
    BKB(:,29) = kx.*B(:,5).^2 + ky.*B(:,11).^2 + kz.*B(:,17).^2;
    BKB(:,30) = B(:,5).*B(:,6).*kx + B(:,11).*B(:,12).*ky + B(:,17).*B(:,18).*kz;
    
    BKB(:,31) = B(:,1).*B(:,6).*kx + B(:,7).*B(:,12).*ky + B(:,13).*B(:,18).*kz;
    BKB(:,32) = B(:,2).*B(:,6).*kx + B(:,8).*B(:,12).*ky + B(:,14).*B(:,18).*kz;
    BKB(:,33) = B(:,3).*B(:,6).*kx + B(:,9).*B(:,12).*ky + B(:,15).*B(:,18).*kz;
    BKB(:,34) = B(:,4).*B(:,6).*kx + B(:,10).*B(:,12).*ky + B(:,16).*B(:,18).*kz;
    BKB(:,35) = B(:,5).*B(:,6).*kx + B(:,11).*B(:,12).*ky + B(:,17).*B(:,18).*kz;
    BKB(:,36) = kx.*B(:,6).^2 + ky.*B(:,12).^2 + kz.*B(:,18).^2;
else
	if ii==1;BKB=kx.*B(:,1).^2 + kz.*B(:,13).^2 + ky.*B(:,7).^2;                        return;end
	if ii==2;BKB=B(:,1).*B(:,2).*kx + B(:,13).*B(:,14).*kz + B(:,7).*B(:,8).*ky;        return;end
	if ii==3;BKB=B(:,1).*B(:,3).*kx + B(:,13).*B(:,15).*kz + B(:,7).*B(:,9).*ky;        return;end
	if ii==4;BKB=B(:,13).*B(:,16).*kz + B(:,1).*B(:,4).*kx + B(:,10).*B(:,7).*ky;       return;end
	if ii==5;BKB=B(:,13).*B(:,17).*kz + B(:,1).*B(:,5).*kx + B(:,11).*B(:,7).*ky;       return;end
	if ii==6;BKB=B(:,13).*B(:,18).*kz + B(:,1).*B(:,6).*kx + B(:,12).*B(:,7).*ky;       return;end
    
	if ii==7;BKB=B(:,1).*B(:,2).*kx + B(:,13).*B(:,14).*kz + B(:,7).*B(:,8).*ky;        return;end
	if ii==8;BKB=kz.*B(:,14).^2 + kx.*B(:,2).^2 + ky.*B(:,8).^2;                        return;end
	if ii==9;BKB=B(:,14).*B(:,15).*kz + B(:,2).*B(:,3).*kx + B(:,8).*B(:,9).*ky;        return;end
	if ii==10;BKB=B(:,14).*B(:,16).*kz + B(:,2).*B(:,4).*kx + B(:,10).*B(:,8).*ky;      return;end
	if ii==11;BKB=B(:,14).*B(:,17).*kz + B(:,2).*B(:,5).*kx + B(:,11).*B(:,8).*ky;      return;end
	if ii==12;BKB=B(:,14).*B(:,18).*kz + B(:,2).*B(:,6).*kx + B(:,12).*B(:,8).*ky;      return;end
    
	if ii==13;BKB=B(:,1).*B(:,3).*kx + B(:,13).*B(:,15).*kz + B(:,7).*B(:,9).*ky;       return;end
	if ii==14;BKB=B(:,14).*B(:,15).*kz + B(:,2).*B(:,3).*kx + B(:,8).*B(:,9).*ky;       return;end
	if ii==15;BKB=kz.*B(:,15).^2 + kx.*B(:,3).^2 + ky.*B(:,9).^2;                       return;end
	if ii==16;BKB=B(:,15).*B(:,16).*kz + B(:,3).*B(:,4).*kx + B(:,10).*B(:,9).*ky;      return;end
	if ii==17;BKB=B(:,15).*B(:,17).*kz + B(:,3).*B(:,5).*kx + B(:,11).*B(:,9).*ky;      return;end
	if ii==18;BKB=B(:,15).*B(:,18).*kz + B(:,3).*B(:,6).*kx + B(:,12).*B(:,9).*ky;      return;end
    
	if ii==19;BKB=B(:,13).*B(:,16).*kz + B(:,1).*B(:,4).*kx + B(:,10).*B(:,7).*ky;      return;end
	if ii==20;BKB=B(:,14).*B(:,16).*kz + B(:,2).*B(:,4).*kx + B(:,10).*B(:,8).*ky;      return;end
	if ii==21;BKB=B(:,15).*B(:,16).*kz + B(:,3).*B(:,4).*kx + B(:,10).*B(:,9).*ky;      return;end
	if ii==22;BKB=ky.*B(:,10).^2 + kz.*B(:,16).^2 + kx.*B(:,4).^2;                      return;end
	if ii==23;BKB=B(:,10).*B(:,11).*ky + B(:,16).*B(:,17).*kz + B(:,4).*B(:,5).*kx;     return;end
	if ii==24;BKB=B(:,10).*B(:,12).*ky + B(:,16).*B(:,18).*kz + B(:,4).*B(:,6).*kx;     return;end
    
	if ii==25;BKB=B(:,13).*B(:,17).*kz + B(:,1).*B(:,5).*kx + B(:,11).*B(:,7).*ky;      return;end
	if ii==26;BKB=B(:,14).*B(:,17).*kz + B(:,2).*B(:,5).*kx + B(:,11).*B(:,8).*ky;      return;end
	if ii==27;BKB=B(:,15).*B(:,17).*kz + B(:,3).*B(:,5).*kx + B(:,11).*B(:,9).*ky;      return;end
	if ii==28;BKB=B(:,10).*B(:,11).*ky + B(:,16).*B(:,17).*kz + B(:,4).*B(:,5).*kx;     return;end
	if ii==29;BKB=ky.*B(:,11).^2 + kz.*B(:,17).^2 + kx.*B(:,5).^2;                      return;end
	if ii==30;BKB=B(:,11).*B(:,12).*ky + B(:,17).*B(:,18).*kz + B(:,5).*B(:,6).*kx;     return;end
    
	if ii==31;BKB=B(:,13).*B(:,18).*kz + B(:,1).*B(:,6).*kx + B(:,12).*B(:,7).*ky;      return;end
	if ii==32;BKB=B(:,14).*B(:,18).*kz + B(:,2).*B(:,6).*kx + B(:,12).*B(:,8).*ky;      return;end
	if ii==33;BKB=B(:,15).*B(:,18).*kz + B(:,3).*B(:,6).*kx + B(:,12).*B(:,9).*ky;      return;end
	if ii==34;BKB=B(:,10).*B(:,12).*ky + B(:,16).*B(:,18).*kz + B(:,4).*B(:,6).*kx;     return;end
	if ii==35;BKB=B(:,11).*B(:,12).*ky + B(:,17).*B(:,18).*kz + B(:,5).*B(:,6).*kx;     return;end
	if ii==36;BKB=ky.*B(:,12).^2 + kz.*B(:,18).^2 + kx.*B(:,6).^2;						return;end
end


%%% how to calculate the above expression using matlab symbolic toolbox
%{
syms b1 b2 b3 b4 b5 b6
syms b7 b8 b9 b10 b11 b12
syms b13 b14 b15 b16 b17 b18
syms kx ky kz
B=[b1 b2 b3 b4 b5 b6;b7 b8 b9 b10 b11 b12;b13 b14 b15 b16 b17 b18]
B1=[b1 b7 b13;b2 b8 b14;b3 b9 b15;b4 b10 b16;b5 b11 b17;b6 b12 b18]
K=[kx 0 0;0 ky 0;0 0 kz];
BKB=B1*K*B
%}

% cnt=0;
% for i=1:6
%     for j=1:6
%         cnt=cnt+1;
%         fprintf(['BKB(:,%d) = ' char(BKB(i,j)) ';\n'],cnt);
%     end
% end