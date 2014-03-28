%% calcBKBHex_quad_27
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%
%
% Computes the product B' x K x B for 3D quadratic hexahedral elements in vectorized manner
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
% BKB = calcBKBHex_quad_27(B, K, ii)
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
syms b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27
syms b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54
syms b55 b56 b57 b58 b59 b60 b61 b62 b63 b64 b65 b66 b67 b68 b69 b70 b71 b72 b73 b74 b75 b76 b77 b78 b79 b80 b81
syms kx ky kz
B=[b1  b2  b3  b4  b5  b6  b7  b8  b9  b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27;...
   b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54;...
   b55 b56 b57 b58 b59 b60 b61 b62 b63 b64 b65 b66 b67 b68 b69 b70 b71 b72 b73 b74 b75 b76 b77 b78 b79 b80 b81];
B1=[ b1 b28 b55;...
     b2 b29 b56;...
     b3 b30 b57;...
     b4 b31 b58;...
     b5 b32 b59;...
     b6 b33 b60;...
     b7 b34 b61;...
     b8 b35 b62;...
     b9 b36 b63;...
     b10 b37 b64;...
     b11 b38 b65;...
     b12 b39 b66;...
     b13 b40 b67;...
     b14 b41 b68;...
     b15 b42 b69;...
     b16 b43 b70;...
     b17 b44 b71;...
     b18 b45 b72;...
     b19 b46 b73;...
     b20 b47 b74;...
     b21 b48 b75;...
     b22 b49 b76;...
     b23 b50 b77;...
     b24 b51 b78;...
     b25 b52 b79;...
     b26 b53 b80;...
     b27 b54 b81];
 K=[kx 0 0;...
     0 ky 0;...
     0  0  kz];
 BKB=B1*K*B;
%%
% Next to convert the above complex expressions to vectorized expresions we
% used the following loop and copy the output to an editor and with minimum
% editing we wrote the final expressions without actually write by hand indices
% and symbols. In this case we printed the output directly to a file
% because the there are ~700 lines.
 fid=fopen('temp.txt','w');
 cnt=0;
 for i=1:size(B,2)
     for j=1:size(B,2)
         cnt=cnt+1;
         fprintf(fid,['BKB(:,%d) = ' char(BKB(i,j)) ';\n'],cnt);
     end
 end
 fclose(fid);
%%
% 
% <msim_help_main.html | main>   <msim_help_demos.html | Tutorials> 
% <msim_function_categories.html | Functions> <http://www.subsurface.gr | website> |
%