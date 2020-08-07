function  Result=getlinkNU(Alpha,Beta,G,tmp,rank)
      parfor i=1:rank
           Result(i,:)=linkNU2(Alpha,Beta,G,tmp(i,:));
      end
end
