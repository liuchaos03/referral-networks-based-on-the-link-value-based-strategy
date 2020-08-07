function IU=linkIU2(Alpha,Beta,G,ID)
c=0;
I=eye(length(G));
one=ones(length(G),1);
G_1=G;
G_1(ID)=1;

A=I/(Beta*I-G);
A_1=I/(Beta*I-G_1);

%---IU-------
Pt=(1/4)*(Alpha-c*one)'*A*(Alpha-c*one);
Pt_1=(1/4)*(Alpha-c*one)'*A_1*(Alpha-c*one);
IU=Pt_1-Pt;
end