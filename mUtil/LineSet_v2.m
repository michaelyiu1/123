classdef LineSet_v2
    properties
        l_id %[nx2] id of the line points
        alloc;
        tol;
        Nln=0;
        le;
        DistMin;
        DistMax;
        LcMin;
        LcMax;
    end
    
    methods
        function LS=LineSet_v2(N,usertol)
            %initialize Line set
            if isempty(LS.l_id)
                LS.l_id=nan(N,2);
                LS.alloc=N;
                LS.tol=usertol;
                LS.DistMin=nan(N,1);
                LS.DistMax=nan(N,1);
                LS.LcMin=nan(N,1);
                LS.LcMax=nan(N,1);
                
            else
                error('LineSet is not empty') 
            end
        end
        function LS=addline(LS,id1,id2,thresh)
            %make sure you run the isLineinSet check before running this
            %function
            LS.l_id(LS.Nln+1,:)=[id1 id2];
            LS.DistMin(LS.Nln+1,:)=thresh.DistMin;
            LS.DistMax(LS.Nln+1,:)=thresh.DistMax;
            LS.LcMin(LS.Nln+1,:)=thresh.LcMin;
            LS.LcMax(LS.Nln+1,:)=thresh.LcMax;
            LS.Nln=LS.Nln+1;
            if LS.Nln>size(LS.l_id,1)
                LS.l_id=[LS.l_id;nan(LS.alloc,2)];
                LS.DistMin=[LS.DistMin;nan(LS.alloc,2)];
                LS.DistMax=[LS.DistMax;nan(LS.alloc,2)];
                LS.LcMin=[LS.LcMin;nan(LS.alloc,2)];
                LS.LcMax=[LS.LcMax;nan(LS.alloc,2)];
            end
        end
        
        function id_line=isLineinSet(LS,id1, id2)
            if id1==id2
                id_line=inf;
                return
            end
            if LS.Nln==0
                id_line=nan;
                return
            end
            dst1=sqrt((LS.l_id(:,1)-id1).^2+(LS.l_id(:,2)-id2).^2);
            dst2=sqrt((LS.l_id(:,1)-id2).^2+(LS.l_id(:,2)-id1).^2);
            iid1=find(dst1==0);
            iid2=find(dst2==0);
            if ~isempty(iid1) && ~isempty(iid2)
                error('the lines exist twice in the set')
            elseif ~isempty(iid1)
                id_line=iid1;
            elseif ~isempty(iid2)
                id_line=-iid2;
            else
                id_line=nan;
            end
        end
        
        function pprj=projectpointtobnd(LS,p,Ln)
            %Calculates the coordinates of the projected point p on the line Ln
            %p=[px py]
            %Ln=[x1 y1;x2 y2]
            %http://cs.nyu.edu/~yap/classes/visual/03s/hw/h2/math.pdf
            A=[Ln(2,1)-Ln(1,1) Ln(2,2)-Ln(1,2);...
               Ln(1,2)-Ln(2,2) Ln(2,1)-Ln(1,1)];
            B=-[-p(1,1)*(Ln(2,1)-Ln(1,1))-p(1,2)*(Ln(2,2)-Ln(1,2));...
               -Ln(1,2)*(Ln(2,1)-Ln(1,1))+Ln(1,1)*(Ln(2,2)-Ln(1,2))];
            pb=A\B;%inv(A)*B;
            pprj=pb';
        end
        
        function out=isPointonLine(LS,px,py,x1,y1,x2,y2)
            if length(px)>1
                vect='many_points';
                Np=size(px,1);
                out=nan(Np,1);
            else
                vect='many_lines';
                Nl=size(x1,1);
                out=nan(Nl,1);
            end

            dst=Dist_Point_LineSegment(px, py,[x1 y1 x2 y2]);
            [dst dst_pos]=min(dst);
            id_tol=find(dst<LS.tol);
            if isempty(id_tol)
                return
            end
            switch vect
                case 'many_points'
                    for i=1:size(id_tol,1)
                        pprj(i,:)=LS.projectpointtobnd([px(id_tol(i)) py(id_tol(i))],[x1 y1;x2 y2]);
                    end

                    if abs(x1-x2)<5e-1
                        t=(pprj(:,2)-y1)./(y2-y1);
                        tf = t>=0 & t<=1 & abs(px(id_tol)-x1)<tol;
                        out(id_tol(tf))=t(tf);
                    elseif abs(y1-y2)<5e-1
                        t=(pprj(:,1)-x1)/(x2-x1);
                        tf = t>=0 & t<=1 & abs(py(id_tol)-y1)<tol;
                        out(id_tol(tf))=t(tf);
                    else
                        tx=(pprj(:,1)-x1)/(x2-x1);
                        ty=(pprj(:,2)-y1)/(y2-y1);
                        tf = tx>=0 & tx<=1 & ty>=0 & ty<=1; 
                        out(id_tol(tf))=tx(tf);
                    end
                case 'many_lines'
                    pprj=LS.projectpointtobnd([px py],[x1(dst_pos) y1(dst_pos);x2(dst_pos) y2(dst_pos)]);
                    x1=x1(dst_pos);y1=y1(dst_pos);x2=x2(dst_pos); y2=y2(dst_pos);
                    %find the parametric value of the projected point
                    if abs(x1-x2)<5e-1
                        t=(pprj(1,2)-y1)./(y2-y1);
                    elseif abs(y1-y2)<5e-1
                        t=(pprj(1,1)-x1)/(x2-x1);
                    else
                        tx=(pprj(:,1)-x1)/(x2-x1);
                        ty=(pprj(:,2)-y1)/(y2-y1);
                        t=(tx+ty)/2;
                    end
                    out(dst_pos)=t;
            end
        end
        
        function p=linexline(LS,x1,y1,x2,y2,x3,y3,x4,y4)
            p=nan(LS.Nln,2);
            D=(y4-y3).*(x2-x1)-(x4-x3).*(y2-y1);
            t1=((x4-x3).*(y1-y3)-(y4-y3).*(x1-x3))./D;
            t2=((x2-x1).*(y1-y3)-(y2-y1).*(x1-x3))./D;
            id=find(t1>-1e-6 & t1<1+1e-6 & t2>-1e-6 & t2<1+1e-6);
            p(id,:)=[(x1(id,1)+t1(id,1).*(x2(id,1)-x1(id,1))+x3(id,1)+t2(id,1).*(x4(id,1)-x3(id,1)))/2 ...
                     (y1(id,1)+t1(id,1).*(y2(id,1)-y1(id,1))+y3(id,1)+t2(id,1).*(y4(id,1)-y3(id,1)))/2];
            T=[t1 t2];
        end
        
        function t=find_parametric_point(LS,ln,pnt)
            if abs(ln(1)-ln(3))<5e-1
                t=(pnt(:,1)-ln(2))./(ln(4)-ln(2));
            elseif abs(ln(2)-ln(4))<5e-1
                t=(pnt(:,1)-ln(1))/(ln(3)-ln(1));
            else
                tx=(pnt(:,1)-ln(1))/(ln(3)-ln(1));
                ty=(pnt(:,2)-ln(2))./(ln(4)-ln(2));
                t=(tx+ty)/2;
            end
        end
        
    end
    
    
    
end