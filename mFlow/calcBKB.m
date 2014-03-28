function BKB=calcBKB(B,K,opt,ii)
% BKB = calcBKB(B, K, opt, ii)
% computes the product B'*K*B in a vectorized fashion
%
% Input
% B : [Nel x N_sh^2] contains the contributions of each element to the final
%      conductance matrix
% K : [Nel x Nanis] Hydraulic conductiviy element values. The number of columns 
%     is defined by the anisotropy. Maximum number is 3.
% opt : Structure variable with the following fields
%       dim : dimension of the elements
%       el_type : the element type
%       el_order : the element order
% ii : In case of nested assembly this indicates the iteration. In
%       vectorized assembly this is not used
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


if opt.dim==1
        switch opt.el_order
            case 'linear'
                BKB=calcBKBline_Lin(B,K,ii);
            case 'quadratic'
                BKB=calcBKBline_quad(B,K,ii);
        end
elseif opt.dim==2
    if size(K,2)==1
        K=[K K];
    end
    switch opt.el_type
        case 'triangle'
            switch opt.el_order
                case 'linear'
                    BKB=calcBKBtriang_Lin(B,K,ii);
                case 'quadratic'
                    BKB=calcBKBtriang_quad(B,K,ii);
            end
        case 'quad'
            switch opt.el_order
                case 'linear'
                    BKB=calcBKBQuad_Lin(B,K,ii);
                case 'quadratic_9'
                    BKB=calcBKBQuad_quad_9(B,K,ii);
            end
    end
elseif opt.dim==3
    if size(K,2)==1
        K=[K K K];
    elseif size(K,2)==2
        K=[K(:,1) K(:,1) K(:,2)];
    end;
    switch opt.el_type
        case 'prism'
            switch opt.el_order
                case 'linear'
                    BKB=calcBKBPrism_Lin(B,K,ii);
                case 'quadratic'
                    BKB=calcBKBPrism_quad(B,K,ii);
            end
        case 'hex'
            switch opt.el_order
                case 'linear'
                    BKB=calcBKBHex_Lin(B,K,ii);
                case 'quadratic_27'
                    BKB=calcBKBHex_quad_27(B,K,ii);
            end
    end
end