export fChainChild(
					dataset(Layout_Relative_Link.RelativesDegrees) pInputFile
					) :=
function


	Layout_Relative_Link.RelativesDegrees tChainChild(pInputFile l,pInputFile r) := 
	transform
		both_dLinks := l.dLinks(bdid1 != 0) + r.dLinks(bdid1 != 0);
		
		self.bdid1		:= l.dLinks[1].bdid1;
		self.bdid2		:= if(r.dLinks[1].bdid2 = 0, l.dLinks[1].bdid2, r.dLinks[1].bdid2);
		self.dlinks		:= if(count(both_dLinks(bdid1 = self.bdid1 and bdid2 = self.bdid2)) = 0,
							dataset([
								{self.bdid1, self.bdid2, 'Child'}
							], Layout_Relative_Link.Relative_Flagged)
							+ both_dLinks,
							both_dLinks);
							
		self.nDegrees	:= count(self.dLinks);
	end;

	jChainChild := join( pInputFile
					
//					,pInputFile(bdid1 > bdid2)
					,pInputFile
					
					,left.bdid2 = right.bdid1
					and left.bdid1 != right.bdid2
					
					,tChainChild(left,right)
					,left outer
					,hash);

	dedupChild := dedup(sort(jChainChild(bdid1 != bdid2)
				,bdid1
				,bdid2
				,nDegrees)
				,bdid1
				,bdid2
				,all);
	
	
	
	
	return dedupChild;

end;
