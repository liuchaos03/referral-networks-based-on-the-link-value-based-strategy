%---------Used to calculate the total profit of a monopolist-----------------
%-------output:  monopolistIK, monopolistIU, monopolistNK and monopolistNU
    N=100;
    N=Beta;
    G=zeros(Beta);
    gama=0.0;

monopolistIK=cell({});monopolistNK=cell({});            %Result storage location
monopolistIU=cell({});monopolistNU=cell({});            %Storage format  ¡°monopolistNU{serial number£¬Initial form£¬Profit results}¡±
for simulate=1:500
    Alpha=SimulateAlpha{simulate};
    for R=1:2
        for neti=1:3
            GA=zeros(N);
            if neti==1
                GA=Simulatenetwork{1,simulate}{1,1}{1,1};
            elseif neti==2
                GA=Simulatenetwork{1,simulate}{1,2}{1,1};
            elseif neti==3
                GA=Simulatenetwork{1,simulate}{1,3}{1,1};            
            end       

            tmp=IK{simulate,R,neti};
            if tmp~=0
            tmp=tmp(:,1:2);
            ID=[tmp(:,2),tmp(:,1)];
            ID=[tmp;ID];             
            P=GlinkIK3(Alpha,Beta,GA,G,ID,gama);  %linkIK2;linkIU2;linkNK2;linNU2;  
            monopolistIK{simulate,R,neti}=P; 
            
            tmp=IU{simulate,R,neti};
            if tmp~=0
            tmp=tmp(:,1:2);
            ID=[tmp(:,2),tmp(:,1)];
            ID=[tmp;ID];             
            P=GlinkIU3(Alpha,Beta,GA,G,ID,gama);  %linkIK2;linkIU2;linkNK2;linNU2;  
            monopolistIU{simulate,R,neti}=P;            
            
            tmp=NK{simulate,R,neti};
            if tmp~=0
            tmp=tmp(:,1:2);
            ID=[tmp(:,2),tmp(:,1)];
            ID=[tmp;ID];             
            P=GlinkNK3(Alpha,Beta,GA,G,ID,gama);  %linkIK2;linkIU2;linkNK2;linNU2;  
            monopolistNK{simulate,R,neti}=P;       
            
            tmp=NU{simulate,R,neti};
            if tmp~=0
            tmp=tmp(:,1:2);
            ID=[tmp(:,2),tmp(:,1)];
            ID=[tmp;ID];             
            P=GlinkNU3(Alpha,Beta,GA,G,ID,gama);  %linkIK2;lIUkIU2;linkNK2;linNU2;  
            monopolistNU{simulate,R,neti}=P;                
            end
            end
            end
            end
        end
   end
end
