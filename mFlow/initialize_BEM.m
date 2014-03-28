function BEM=initialize_BEM(Nel,opt)
% BEM = initialize_BEM(Nel, opt)
%
% Initialize the matrix that will hold the shape functions derivatives
% values. This is used internaly during the assemble of glabal conductance matrix 
%
% Inputs
% Nel: Number of elements
% opt : structure with the following fields:
%       dim : dimension of the problem
%       el_type : element type (e.g. triangle, quad, prism, hex)
%       el_order : element order, linear od quadratic
%
% Output: 
% BEM [NelxN_sh^2], where N_sh is the number of shape functions per element
%
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date 18-Dec_2012
% Department of Land Air and Water
% University of California Davis

if opt.dim==1
    switch opt.el_order
        case 'linear'
            BEM=zeros(Nel,2^2);
        case 'quadratic'
            BEM=zeros(Nel,3^2);
    end
elseif opt.dim==2
    switch opt.el_type
        case 'triangle'
            switch opt.el_order
                case 'linear'
                    BEM=zeros(Nel,3^2);
                case 'quadratic'
                    BEM=zeros(Nel,6^2);
            end
        case 'quad'
            switch opt.el_order
                case 'linear'
                    BEM=zeros(Nel,4^2);
                case 'quadratic_9'
                    BEM=zeros(Nel,9^2);
            end
    end
elseif opt.dim==3
    switch opt.el_type
        case 'prism'
            switch opt.el_order
                case 'linear'
                    BEM=zeros(Nel,6^2);
                case 'quadratic'
                    BEM=zeros(Nel,18^2);
            end
        case 'hex'
            switch opt.el_order
                case 'linear'
                    BEM=zeros(Nel,8^2);
                case 'quadratic_27'
                    BEM=zeros(Nel,27^2);
            end
    end
end