function  Result=getlinkIU(Alpha,Beta,G,tmp,rank)

      parfor i=1:rank
          Result(i,:)=linkIU2(Alpha,Beta,G,tmp(i,:));
      end
end
