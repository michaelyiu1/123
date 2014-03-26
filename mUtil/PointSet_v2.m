classdef PointSet_v2
    properties
        coord;     %contains the coordinates of the point set
        Npnt=0;   %number of points in the set
        tol=[];   %tolerance specified by tolset
        alloc=[]; %allocation size
        pe;       %id of the latest checked point
        type;     %1 domain, 2 line, 3 point
        DistMin;
        DistMax;
        LcMin;
        LcMax
    end
    
    methods
        function PS=PointSet_v2(N,Dim,usertol)
            %This allocates space for N points in the D space
            if isempty(PS.coord)
                PS.coord=nan(N,Dim);
                PS.type=nan(N,1);
                PS.alloc=N;
                PS.tol=usertol;
                PS.DistMin=nan(N,1);
                PS.DistMax=nan(N,1);
                PS.LcMin=nan(N,1);
                PS.LcMax=nan(N,1);
            else
                error('PointSet is not empty') 
            end
        end
        
        function id=isPointonSet(PS,p,ids)
            if isempty(PS.tol)
                error('you need to specify tolerance')
            end
            if PS.Npnt==0
                id=nan;
                return
            end
           if isempty(ids)
                [c d]=min(sqrt(sum((PS.coord(1:PS.Npnt,:)-repmat(p,PS.Npnt,1)).^2,2)));
           else
               [c d]=min(sqrt(sum((PS.coord(ids,:)-repmat(p,length(ids),1)).^2,2)));
           end
           if c<PS.tol
               id=d;
           else
               id=nan;
           end 
        end
       
        function PS=addnewpoint(PS,p,thresh)
            if size(PS.coord,2)~=size(p,2)
                error('the dimensions of new points must be equal with the ones in the set')
            end
            PS.coord(PS.Npnt+1,:)=p;
            PS.DistMin(PS.Npnt+1,:)=thresh.DistMin;
            PS.DistMax(PS.Npnt+1,:)=thresh.DistMax;
            PS.LcMin(PS.Npnt+1,:)=thresh.LcMin;
            PS.LcMax(PS.Npnt+1,:)=thresh.LcMax;
            PS.Npnt=PS.Npnt+1;
            if PS.Npnt>size(PS.coord,1)
                PS.coord=[PS.coord;nan(PS.alloc,size(PS.coord,2))];
                PS.type=[PS.type;nan(PS.alloc,1)];
                PS.DistMin=[PS.DistMin;nan(PS.alloc,1)];
                PS.DistMax=[PS.DistMax;nan(PS.alloc,1)];
                PS.LcMin=[PS.LcMin;nan(PS.alloc,1)];
                PS.LcMax=[PS.LcMax;nan(PS.alloc,1)];
            end
        end
        
        
    end
    
    
end