%-----------------Start with the largest alpha--------------%
%-------------Only one link is generated for each iteration---------------
%-------------Each iteration is divided into four market situations------------------
% output: IK IU NK NU;   IK{Serial number,approach to start,Referral network} 

tic;

%N=[20 50 100 200 500];
N=100;                 %market size
IK=cell({});IU=cell({});NK=cell({});NU=cell({});
IKMprofit_de=cell({});IUMprofit_de=cell({});NKMprofit_de=cell({});NUMprofit_de=cell({});
SimulateAlpha=cell({});Simulatenetwork=cell({});
netindex=zeros();
gama=0.0;

for simulate=1:500   % Simulation times setting
[Alpha,netF,netS,netG,GF,GS,GG]=SetupNet3(N);
Alpha=Alpha';
Beta=N;
Begintic=[ceil(rand(1)*N),find(Alpha==max(Alpha))];
SimulateAlpha{simulate}=Alpha;
Simulatenetwork{simulate}={{GF},{GS},{GG}};

 for R=1:2
 RBegin=Begintic(R);      %Start at random or start with the largest alpha

%------------Regular network, Scale free-network, Random network------------
for neti=1:3
    switch neti
        case 1
            net=netF;
            GA=GF;
        case 2
            net=netS;
            GA=GS;
        case 3
            net=netG;
            GA=GG;
    end
%-------------IK ---IU ---NK----NU---------------------    
    for NCN=4:-1:1
Mprofit_de=[];
G=zeros(N);
netf=zeros();
nodeID=1:N;
nodeNet=zeros();
k=1;
%----------The first node looks for the second node-------
    tmp=net(net(:,1)==RBegin,:);
    [rank,~]=size(tmp);
    
    nodeID(nodeID==RBegin)=[];             
    nodeNet(k)=RBegin;
    %-----------------------Calculate the profit of each side--------------------
    if NCN==1
    Result=getlinkIK(Alpha,Beta,G,tmp,rank);
    elseif NCN==2
    Result=getlinkIU(Alpha,Beta,G,tmp,rank);
    elseif NCN==3
    Result=getlinkNK(Alpha,Beta,G,tmp,rank);
    elseif NCN==4
    Result=getlinkNU(Alpha,Beta,G,tmp,rank);        
    end
    [order,addre]=sort(Result,'descend');   
    note=0;
%-----------------------Calculate the price-------------------------------------
 if NCN==1
I=eye(length(GA));
A=(sparse(Beta*I-GA)\I);
P=((A+A')^(-1))*A*Alpha;
 elseif NCN==2
P=Alpha/2;     
 elseif NCN==4
P=sum(Alpha)/(2*N);
one=ones(1,N);
P=one*P;
 elseif NCN==3
I=eye(length(GA));
A=(sparse(Beta*I-GA)\I);
one=ones(1,N);
P=(1/2)*(one*A*Alpha)/(one*A*one');  
one=ones(1,N);
P=one*P;
 end
    %-----------------------After finding the largest link, save-------------------
    for i=1:rank
        if order(i)>0 && sum(G(tmp(addre(i),2),:))==0
            if Alpha(tmp(addre(i),2))<=P(tmp(addre(i),2))
                if Alpha(tmp(addre(i),2))>=(1-gama)*P(tmp(addre(i),2))
                Mprofit_de=[Mprofit_de;tmp(addre(i),2),gama*P(tmp(addre(i),2))];
               
                G(tmp(addre(i),1),tmp(addre(i),2))=1;
                G(tmp(addre(i),2),tmp(addre(i),1))=1;
                netf(k,1:3)=[tmp(addre(i),1),tmp(addre(i),2),order(i)];
                note=1;
                nodeID(nodeID==netf(k,2))=[]; 
                k=k+1;
                nodeNet(k)=netf(k-1,2);
                break;
                else
                  continue
                end
            else
            G(tmp(addre(i),1),tmp(addre(i),2))=1;
            G(tmp(addre(i),2),tmp(addre(i),1))=1;
            netf(k,1:3)=[tmp(addre(i),1),tmp(addre(i),2),order(i)];
            k=k+1;
            nodeNet(k)=tmp(addre(i),2);
            note=1;
            break;
            end
        else
            break
        end   
    end 

    
while ~isempty(nodeID)
   tmp=[];
   
   chooseid=net(ismember(net(:,1),nodeNet),:);         
   
   for CP=1:length(nodeNet)
       tmp=[tmp;find(chooseid(:,2)==nodeNet(CP))];
   end
   chooseid(tmp,:)=[];
   tmp=chooseid;
     
    note=0;
    if isempty(tmp)
        break
    end
    [rank,~]=size(tmp);    
    if NCN==1
    Result=getlinkIK(Alpha,Beta,G,tmp,rank);
    elseif NCN==2
    Result=getlinkIU(Alpha,Beta,G,tmp,rank);
    elseif NCN==3
    Result=getlinkNK(Alpha,Beta,G,tmp,rank);
    elseif NCN==4
    Result=getlinkNU(Alpha,Beta,G,tmp,rank);        
    end
    [order,addre]=sort(Result,'descend');   
    for i=1:rank
        if order(i)>0 && sum(G(tmp(addre(i),2),:))==0
            if Alpha(tmp(addre(i),2))<=P(tmp(addre(i),2))
                if Alpha(tmp(addre(i),2))>=(1-gama)*P(tmp(addre(i),2))
                Mprofit_de=[Mprofit_de;tmp(addre(i),2),gama*P(tmp(addre(i),2))];
               
                G(tmp(addre(i),1),tmp(addre(i),2))=1;
                G(tmp(addre(i),2),tmp(addre(i),1))=1;
                netf(k,1:3)=[tmp(addre(i),1),tmp(addre(i),2),order(i)];
                note=1;
                nodeID(nodeID==netf(k,2))=[]; 
                k=k+1;
                nodeNet(k)=netf(k-1,2);
                break;
                else
                  continue
                end
            else
            G(tmp(addre(i),1),tmp(addre(i),2))=1;
            G(tmp(addre(i),2),tmp(addre(i),1))=1;
            netf(k,1:3)=[tmp(addre(i),1),tmp(addre(i),2),order(i)];
            k=k+1;
            nodeNet(k)=tmp(addre(i),2);
            note=1;
            break;
            end
        else
            break;
        end   
    end 
   
%----------------Exit conditions--------------- 
    if note==0
        break;
    end
  nodeID(nodeID==tmp(addre(i),2))=[]; 
end

    if NCN==1
    IK{simulate,R,neti}=netf;
    IKMprofit_de{simulate,R,neti}=Mprofit_de;
    elseif NCN==2
    IU{simulate,R,neti}=netf;
    IUMprofit_de{simulate,R,neti}=Mprofit_de;
    elseif NCN==3
    NK{simulate,R,neti}=netf;
    NKMprofit_de{simulate,R,neti}=Mprofit_de;
    elseif NCN==4
    NU{simulate,R,neti}=netf;
    NUMprofit_de{simulate,R,neti}=Mprofit_de;
    end
    
    end
end
end

toc;

end


