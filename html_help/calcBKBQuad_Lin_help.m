%% calcBKBQuad_Lin
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
%
% Computes the product B' x K x B for 2D linear quadrilateral elements in vectorized manner
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
% BKB = calcBKBQuad_Lin(B, K, ii)
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
syms b1 b2 b3 b4
syms b5 b6 b7 b8
syms kx ky
B=[b1 b2 b3 b4; b5 b6 b7 b8];
BT = [b1 b5; b2 b6; b3 b7; b4 b8];
BKB = BT*[kx 0; 0 ky]*B
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