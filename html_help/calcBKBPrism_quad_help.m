%% calcBKBPrism_quad
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
%
% Computes the product B' x K x B for 3D quadratic prism elements in vectorized manner
% This is used internally from <calcBKB_help.html calcBKB>.
%
% Version : 1.0
%
% Author : George Kourakos
%
% email: giorgk@gmail.com
%
% web : http://groundwater.ucdavis.edu/msim
%
% Date 28-Mar-2014
%
% Department of Land Air and Water
%
% University of California Davis
%
%% Usage
% BKB = calcBKBPrism_quad(B, K, ii)
%
%% Input
% _*B*_: [Nel x N_sh^2] contains the contributions of each element to the final
%      conductance matrix
%
% _*K*_ : [Nel x Nanis] Hydraulic conductiviy element values. The number of columns 
%     is defined by the anisotropy. Maximum number is 3.
%
% _*ii*_ : In case of nested assembly this indicates the iteration. In
%       vectorized assembly this is not used 
%
%% Output
% _*BKB*_: the product B'*K*B
%% How to compute
% In mSim we avoid by hand computations at all costs, therefore we used the symbolic 
% toolbox to perform the vectorized computations. The following code show 
% how we computed the products.
syms b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18
syms b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36
syms b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54
syms kx ky kz
B=[b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18;...
   b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36;...
   b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54];

BT=[ b1 b19 b37;...
     b2 b20 b38;...
     b3 b21 b39;...
     b4 b22 b40;...
     b5 b23 b41;...
     b6 b24 b42;...
     b7 b25 b43;...
     b8 b26 b44;...
     b9 b27 b45;...
     b10 b28 b46;...
     b11 b29 b47;...
     b12 b30 b48;...
     b13 b31 b49;...
     b14 b32 b50;...
     b15 b33 b51;...
     b16 b34 b52;...
     b17 b35 b53;...
     b18 b36 b54];
 
K=[kx 0 0;...
    0 ky 0;...
    0  0  kz];
 
BKB=BT*K*B
%%
% Next to convert the above complex expressions to vectorized expresions we
% used the following loop and copy the output to an editor and with minimum
% editing we wrote the final expressions without actually write by hand indices
% and symbols
cnt=0;
for i=1:size(B,2)
    for j=1:size(B,2)
        cnt=cnt+1;
        fprintf(['BKB(:,%d) = ' char(BKB(i,j)) ';\n'],cnt);
    end
end
%%
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%