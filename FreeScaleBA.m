function [sc A]=BA1(N)
%function [sc A]=BA1(m0,m,N)
% ���ɱ�׼BA����(m0>=m,m0���ܵ���1), AΪ�ڽӾ���sparse matrix����������ļ���(mat����txt)
% mat���ϡ�����sf,
% txt���BA����ÿ���ߵĽڵ��
 m0 = 7;% m0 ��ʼ�ڵ㣬ȫ����
 m = 4;% m ��һ�����ͬʱ�ӵı���
% N �ܵĽڵ���
% list----���ɵ�һ�������������������е�Ԫ��Ϊÿ���߶˵�Ľڵ㡣for example, ���������нڵ�4�Ķ�Ϊ7������list�����л����7��4������7��4��λ�ò�һ����������һ��ġ�
% preferential attachment����������Ĵ�list������ѡȡԪ�أ�ѡ���ĸ�Ԫ�أ���Ԫ�ر�ʾ�Ľڵ㼴��ѡ�С�����list������ÿ���ڵ�ĸ��������Ķ��йأ���ˣ���Խ��ĵ㱻ѡ�еĸ���Խ��

sf=zeros(N);
sf(1:m0,1:m0)=1;
sf(1:m0,1:m0)=sf(1:m0,1:m0)-eye(m0);

% hand=waitbar(m0/N,'BA model building');

for i=1:m0-1
for j=1:m0
list((i-1)*m0+j)=j; %��ʼm0���ڵ�ȫ���ӣ�ÿ���ڵ���list�г��� m0-1��
end
end
d=(m0-1)*m0;

for n=m0+1:N
t=d+2*m*(n-m0-1);
for i=1:m
list(t+i)=n; % in the list, every time the above m is n, it represents that the nth nodes is connected to other m nodes
end
k=1;
while k<m+1 % grow other m nodes
p(k)=round((t+1)*rand(1)); % random choose an integer from 1~N
if p(k)>0&p(k)<(t+1)
if sf(n,list(p(k)))==0
list(t+m+k)=list(p(k));
sf(n,list(p(k)))=1;
sf(list(p(k)),n)=1;
k=k+1;
end 
end 
end %end for k
% waitbar(n/N,hand);
end %end for n
% close(hand);

%�����ɵ�BA���磨ϡ�����A�������ļ�BA.mat,�ļ��е�����Ϊ�������A����ȡ��load����������ڷ���A�Ϳɵõ�BA����
A=sf;
% save BA1000 A

%degree distribution 
% df=sum(A>0);                                   % ���� ��
% pp2=tabulate(df);                              % ͳ�Ƹ���
% sw=find(pp2(:,3)>0);
% loglog(pp2(sw,1),pp2(sw,3)/100,'b*');
% lsline %��С�������ֱ��
% title('BA�ޱ������ȷֲ�ͼ')
% xlabel('k');
% ylabel('P(k)');

%��BA����ÿ���ߵĽڵ�Ŵ���ھ���sc�У�������������ı�BA.txt
% [R,L]=int16(find(A==1));
% sc=[L,R];

 h=1;
 for i=1:N-1
 for j=i+1:N
 if A(i,j)==1 
 sc(h,:)=[i j];
 h=h+1;
 end
 end
 end
%[w,x]=size(sc); 
% fid=fopen('BAn100k101.txt','wt');
% for i=1:w
% for j=1:x
% fprintf(fid,'%d',sc(i,j)); 
% fprintf(fid,'\t'); %��������и�ʽ�������������ÿ��Ԫ�ص�ֵ����ո�Ҳ���ỻ�����
% end
% fprintf(fid,'\n');
% end
% fclose(fid);