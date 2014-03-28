function BKB=calcBKBline_Lin(B,K,ii)
% BKB = calcBKBline_Lin(B, K, ii)
%
% Computes the product B'*K*B in vectorized manner for linear line
% elements
%
% Input
% B : [Nel x 2] contains the contributions of each element to the final
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
% Date 18-Dec-2012
% Department of Land Air and Water
% University of California Davis
%
% how to compute the product using matlab symbolic toolbox
% syms b1 b2
% syms kx
% B=[b1 b2]
% BT = [b1;b2]
% BKB = BT*kx*B
%
% see also calcBKB, Assemble_LHS

k=K(:,1);
if isempty(ii)
    BKB(:,1)=B(:,1).^2.*k;
    BKB(:,2)=B(:,1).*B(:,2).*k;
    BKB(:,3)=BKB(:,2);
    BKB(:,4)= (B(:,1).^2).*k;
else
    if ii==1;BKB=B(:,1).^2.*k;return;end
    if ii==2;BKB=B(:,1).*B(:,2).*k;return;end
    if ii==3;BKB=B(:,1).*B(:,2).*k;return;end
    if ii==4;BKB= (B(:,1).^2).*k;return;end
end