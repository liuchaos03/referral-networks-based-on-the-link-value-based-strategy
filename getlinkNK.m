function  Result=getlinkNK(Alpha,Beta,G,tmp,rank)

      parfor i=1:rank
           Result(i,:)=linkNK2(Alpha,Beta,G,tmp(i,:));
      end
end
