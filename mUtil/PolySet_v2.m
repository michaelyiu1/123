classdef PolySet_v2
    properties
        pl_id; %contains the id of the lines that the polygon is made of
               %negative sign means the line is in the opposite direction
        Npl=0; %the number of polygons in the set
        alloc; %This is used to allocate space in the pl_id structure
        tol;   %tolerance
    end
    methods
        function PL=PolySet_v2(m,usertol)
            %initialize structure
            % m is used to allocate space for the polygons: make it equal
            % to the number of expected polygons
            if isempty(PL.pl_id)
                PL.pl_id{m,1}=[];
                PL.alloc=m;
                PL.tol=usertol;
            else
                error('LpolySet is not empty') 
            end
        end
        
        function PL=allocate(PL,N)
            PL.pl_id{PL.Npl+N,1}=[];
        end
        
        %input methods
        function PL=readshapefile(PL,SH)
            for ii=1:size(SH,1)
                [Xs Ys]=polysplit(SH(ii,1).X,SH(ii,1).Y);
                for jj=1:size(Xs,1)
                    if jj>size(PL.pl_id,1)
                        PL=PL.allocate(1);
                    end
                    PL=addnewpoly(PL,Xs{jj,1}',Ys{jj,1}');
                end
            end
        end
        
        function [PL LS PS]=addnewpoly(PL,xp,yp,LS,PS)
            %adds a polygon to Polyset and updates the LS PS objects
            PL.Npl=PL.Npl+1;
            for i=1:length(xp)-1
                [PL LS PS]=LS.addline_coord(PL,PS,[xp(i) yp(i) xp(i+1) yp(i+1)]);
            end
            
        end
        
        
    end
end