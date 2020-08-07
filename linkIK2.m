function IK=linkIK2(Alpha,Beta,G,ID)
% c=0;
I=eye(length(G));
% one=ones(length(G),1);
G_1=G;
G_1(ID)=1;


A=(sparse(Beta*I-G)\I);
A_1=(sparse(Beta*I-G_1)\I);


%---IK-------
tmp=sparse(A)\I;
Pt=2*I/( (tmp)+(tmp)' );
Pt=(1/4)*(Alpha)'*Pt*(Alpha);

tmp=sparse(A_1)\I;
Pt_1=2*I/((tmp)+(tmp)');
Pt_1=(1/4)*(Alpha)'*Pt_1*(Alpha);

IK=Pt_1-Pt;
end

