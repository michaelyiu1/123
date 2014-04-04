function N=shapefunctions(t,opt)
% N = shapefunctions(t, opt)
%
% Computes the shape functions for a given parametric point and element type
%
% Input 
% t : parametric point[Np x Nt]:
%    Np is the number of parametric points and Nt is the number of natural
%    coordinates required to decsribe the parametric point
% opt : Structure with the following fields:
%       dim : dimension of the element
%       el_type : element type (e.g. triangle, prism, etc...)
%       el_order : element order (e.g. linear, quadratic)
%
% Output
% N : [Np x N_sh] Matrix with the shape function values, (N_sh is the number
%     of shape functions
%
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date : 14-Jan-2013
% Department of Land Air and Water
% University of California Davis

% Changes
% 18-Dec-2012 
% 14-Jan-2013 : Converted to vectorized form (not thoroughly tested)



if opt.dim==1
    switch opt.el_order
        case 'linear'
            N(:,1)=0.5*(1-t(:,1));
            N(:,2)=0.5*(1+t(:,1));
        case 'quadratic'
            N(:,1)=0.5*t.*(t(:,1)-1);
            N(:,2)=0.5*t.*(t(:,1)+1);
            N(:,3)=1-t(:,1).^2;
    end
elseif opt.dim==2
    switch opt.el_type
        case 'triangle'
            switch opt.el_order
                case 'linear'
                    N(:,1)=t(:,1);
                    N(:,2)=t(:,2);
                    N(:,3)=1-t(:,1)-t(:,2);
                case 'quadratic'
                    N(:,1)=t(:,1).*(2.*t(:,1)-1);
                    N(:,2)=t(:,2).*(2.*t(:,2)-1);
                    N(:,3)=(1-t(:,1)-t(:,2)).*(2.*(1-t(:,1)-t(:,2))-1);
                    N(:,4)=4.*t(:,1).*t(:,2);
                    N(:,5)=4.*t(:,2).*(1-t(:,1)-t(:,2));
                    N(:,6)=4.*(1-t(:,1)-t(:,2)).*t(:,1);
            end
        case 'quad'
            switch opt.el_order
                case 'linear'
                    N(:,1)=0.25.*(1-t(:,1)).*(1-t(:,2));
                    N(:,2)=0.25.*(1+t(:,1)).*(1-t(:,2));
                    N(:,3)=0.25.*(1+t(:,1)).*(1+t(:,2));
                    N(:,4)=0.25.*(1-t(:,1)).*(1+t(:,2));
                case 'quadratic_9'
                    N(:,1)=0.25*(t(:,1)-1).*(t(:,2)-1).*t(1).*t(:,2); 
                    N(:,2)=0.25*(t(:,1)+1).*(t(:,2)-1).*t(1).*t(:,2);
                    N(:,3)=0.25*(t(:,1)+1).*(t(:,2)+1).*t(1).*t(:,2);
                    N(:,4)=0.25*(t(:,1)-1).*(t(:,2)+1).*t(1).*t(:,2);
                    N(:,5)=-0.5*(t(:,1).^2-1).*(t(:,2)-1).*t(:,2);
                    N(:,6)=-0.5*(t(:,1)+1).*(t(:,2).^2-1).*t(:,1);
                    N(:,7)=-0.5*(t(:,1).^2-1).*(t(:,2)+1).*t(:,2);
                    N(:,8)=-0.5*(t(:,1)-1).*(t(:,2).^2-1).*t(:,1);
                    N(:,9)=(t(:,1).^2-1).*(t(:,2).^2-1);

            end
    end
elseif opt.dim==3
    xi=t(:,1); eta=t(:,2); zta=t(:,3);
    switch opt.el_type
        case 'prism'
            switch opt.el_order
                case 'linear'
                    N(:,1)=xi.*(1-zta)/2;
                    N(:,2)=eta.*(1-zta)/2;
                    N(:,3)=(1-xi-eta).*(1-zta)/2;
                    N(:,4)=xi.*(1+zta)./2;
                    N(:,5)=eta.*(1+zta)./2;
                    N(:,6)=(1-xi-eta).*(1+zta)/2;
                case 'quadratic'
                    N(:,1) = (xi.*zta.*(2.*xi - 1).*(zta - 1))./2;
                    N(:,2) = (eta.*zta.*(2*eta - 1).*(zta - 1))./2;
                    N(:,3) = (zta.*(zta - 1).*(eta + xi - 1).*(2*eta + 2*xi - 1))./2;
                    N(:,4) = (xi.*zta.*(2.*xi - 1).*(zta + 1))./2;
                    N(:,5) = (eta.*zta.*(2.*eta - 1).*(zta + 1))./2;
                    N(:,6) = (zta.*(zta + 1).*(eta + xi - 1).*(2.*eta + 2.*xi - 1))./2;
                    N(:,7) = 2.*eta.*xi.*zta.*(zta - 1);
                    N(:,8) = -2.*eta.*zta.*(zta - 1).*(eta + xi - 1);
                    N(:,9) = -(xi.*zta.*(zta - 1).*(4.*eta + 4.*xi - 4))/2;
                    N(:,10) = 2.*eta.*xi.*zta.*(zta + 1);
                    N(:,11) = -2.*eta.*zta.*(zta + 1).*(eta + xi - 1);
                    N(:,12) = -(xi.*zta.*(zta + 1).*(4.*eta + 4.*xi - 4))./2;
                    N(:,13) = -xi.*(2.*xi - 1).*(zta.^2 - 1);
                    N(:,14) = -eta.*(2.*eta - 1).*(zta.^2 - 1);
                    N(:,15) = -(zta.^2 - 1).*(eta + xi - 1).*(2.*eta + 2.*xi - 1);
                    N(:,16) = -4.*eta.*xi.*(zta.^2 - 1);
                    N(:,17) = 4.*eta.*(zta.^2 - 1).*(eta + xi - 1);
                    N(:,18) = xi.*(zta.^2 - 1)*(4.*eta + 4.*xi - 4);
            end
        case 'hex'
            switch opt.el_order
                case 'linear'
                    N(:,1)=0.125.*(1-t(:,1)).*(1-t(:,2)).*(1-t(:,3));
                    N(:,2)=0.125.*(1+t(:,1)).*(1-t(:,2)).*(1-t(:,3));
                    N(:,3)=0.125.*(1+t(:,1)).*(1+t(:,2)).*(1-t(:,3));
                    N(:,4)=0.125.*(1-t(:,1)).*(1+t(:,2)).*(1-t(:,3));
                    N(:,5)=0.125.*(1-t(:,1)).*(1-t(:,2)).*(1+t(:,3));
                    N(:,6)=0.125.*(1+t(:,1)).*(1-t(:,2)).*(1+t(:,3));
                    N(:,7)=0.125.*(1+t(:,1)).*(1+t(:,2)).*(1+t(:,3));
                    N(:,8)=0.125.*(1-t(:,1)).*(1+t(:,2)).*(1+t(:,3));
                    
                case 'quadratic_27'
                    N(:,1) = (eta.*xi.*zta.*(eta - 1).*(xi - 1).*(zta - 1))./8;
                    N(:,2) = (eta.*xi.*zta.*(eta - 1).*(xi + 1).*(zta - 1))./8;
                    N(:,3) = (eta.*xi.*zta.*(eta + 1).*(xi + 1).*(zta - 1))./8;
                    N(:,4) = (eta.*xi.*zta.*(eta + 1).*(xi - 1).*(zta - 1))./8;
                    N(:,5) = (eta.*xi.*zta.*(eta - 1).*(xi - 1).*(zta + 1))./8;
                    N(:,6) = (eta.*xi.*zta.*(eta - 1).*(xi + 1).*(zta + 1))./8;
                    N(:,7) = (eta.*xi.*zta.*(eta + 1).*(xi + 1).*(zta + 1))./8;
                    N(:,8) = (eta.*xi.*zta.*(eta + 1).*(xi - 1).*(zta + 1))./8;
                    N(:,9) = -(eta.*zta.*(xi.^2 - 1).*(eta - 1).*(zta - 1))./4;
                    N(:,10) = -(xi.*zta.*(eta.^2 - 1).*(xi + 1).*(zta - 1))./4;
                    N(:,11) = -(eta.*zta.*(xi.^2 - 1).*(eta + 1).*(zta - 1))./4;
                    N(:,12) = -(xi.*zta.*(eta.^2 - 1).*(xi - 1).*(zta - 1))./4;
                    N(:,13) = -(eta.*zta.*(xi.^2 - 1).*(eta - 1).*(zta + 1))./4;
                    N(:,14) = -(xi.*zta.*(eta.^2 - 1).*(xi + 1).*(zta + 1))./4;
                    N(:,15) = -(eta.*zta.*(xi.^2 - 1).*(eta + 1).*(zta + 1))./4;
                    N(:,16) = -(xi.*zta.*(eta.^2 - 1).*(xi - 1).*(zta + 1))./4;
                    N(:,17) = -(eta.*xi.*(zta.^2 - 1).*(eta - 1).*(xi - 1))./4;
                    N(:,18) = -(eta.*xi.*(zta.^2 - 1).*(eta - 1).*(xi + 1))./4;
                    N(:,19) = -(eta.*xi.*(zta.^2 - 1).*(eta + 1).*(xi + 1))./4;
                    N(:,20) = -(eta.*xi.*(zta.^2 - 1).*(eta + 1).*(xi - 1))./4;
                    N(:,21) = (eta.*(xi.^2 - 1).*(zta.^2 - 1).*(eta - 1))./2;
                    N(:,22) = (xi.*(eta.^2 - 1).*(zta.^2 - 1).*(xi + 1))./2;
                    N(:,23) = (eta.*(xi.^2 - 1).*(zta.^2 - 1).*(eta + 1))./2;
                    N(:,24) = (xi.*(eta.^2 - 1).*(zta.^2 - 1).*(xi - 1))./2;
                    N(:,25) = (zta.*(eta.^2 - 1).*(xi.^2 - 1).*(zta - 1))./2;
                    N(:,26) = (zta.*(eta.^2 - 1).*(xi.^2 - 1).*(zta + 1))./2;
                    N(:,27) = -(eta.^2 - 1).*(xi.^2 - 1).*(zta.^2 - 1);
            end
    end
end