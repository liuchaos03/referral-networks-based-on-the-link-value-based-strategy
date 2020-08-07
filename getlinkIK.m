function  Result=getlinkIK(Alpha,Beta,G,tmp,rank)

      parfor i=1:rank
          Result(i,:)=linkIK2(Alpha,Beta,G,tmp(i,:));
      end
end
