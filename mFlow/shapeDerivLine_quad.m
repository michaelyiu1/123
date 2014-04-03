function [B Jdet]=shapeDerivLine_quad(p,MSH,xi)
% [B Jdet] = shapeDerivLine_quad(p, MSH, xi)
%
% Computes the shape function derivatives and the determinant of the 
% jacobian matrix for quadratic line elements
% This function is used internally from shapeDerivatives.
% 
% Input
% p   : [Np x 3] Coodrinates of nodes [x1 y1 z1; x2 y2 z2;...xn yn zn]
%        Np : Number of nodes
%
% MSH : [Nel x Np_el] id of elements. Each row correspond to an element
%        Nel : Number of elements
%        Np_el : Number of nodes to define the element
% xi   : the intergration point where the derivatives will be evaluated
%
% Output
% B    : Shape function derivatives
% Jdet : The determinant of the Jacobian Matrix 
%
% Version : 1.0
% Author : George Kourakos
% email: giorgk@gmail.com
% web : http://groundwater.ucdavis.edu/msim
% Date 18-Dec_2012
% Department of Land Air and Water
% University of California Davis
%
%
% quadratic shape function of line
% N1=0.5*ksi*(ksi-1)
% N2=0.5*ksi*(ksi+1)
% N3=1-ksi^2
%
% see also shapeDerivatives

%linearize the coordinates
[b n m]=unique([MSH(:,1);MSH(:,2)]);
p_tmp=p(b,:);
p_tmp_min=min(p_tmp,[],1);
p_tmp_max=max(p_tmp,[],1);
Len=sum(sqrt((p_tmp_max-p_tmp_min).^2));
p_param=nanmean(bsxfun(@rdivide,bsxfun(@minus,p_tmp,p_tmp_min),(p_tmp_max-p_tmp_min)),2);
p_real=p_param.*Len;
p_real=reshape(p_real(m),size(MSH,1),2);
p_real=[p_real (p_real(:,1)+p_real(:,2))/2];

x1=p_real(:,1); 
x2=p_real(:,2);
x3=p_real(:,3);

test=x2<x1;
x2(test)=p_real(test,1);
x1(test)=p_real(test,2);

%Derivatives of shape functions wrt the parametric variable ksi
gn1 = xi - 1/2;
gn2 = xi + 1/2;
gn3 = -2*xi;

Jdet=gn1.*x1+gn2.*x2+gn3.*x3;

B=[gn1./Jdet gn2./Jdet gn3./Jdet];
