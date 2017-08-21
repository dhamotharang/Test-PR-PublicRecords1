export fTransitiveClosure(
							dataset(Layout_Relative_Link.Relative_Flagged) pInputFile 
						) :=
function


	pInputFile_Dist := distribute(pInputFile,hash(bdid1));

	Layout_Relative_Link.RelativesDegrees tPairTransitiveClosure(pInputFile l,pInputFile r) := 
	transform
		self.bdid1		:= l.bdid2;
		self.bdid2		:= r.bdid2;
		self.dlinks		:= dataset([{l.bdid2, r.bdid2, 'Transitive'}], Layout_Relative_Link.Relative_Flagged) + l + r;
		self.nDegrees	:= count(self.dlinks);
	end;

	Layout_Relative_Link.RelativesDegrees t2degrees(pInputFile l) := 
	transform
		self.bdid1		:= l.bdid1;
		self.bdid2		:= l.bdid2;
		self.dlinks		:= l;
		self.nDegrees	:= 1;
	end;
	// This self join piece performs the pair-part of the transitive closure
	// Specifically if we have
	// 3 -- 1
	// 3 -- 2
	// then this inserts
	// 2 -- 1
	PairsTransitiveClosure := join( pInputFile_Dist
						,pInputFile_Dist
						,	left.bdid1 = right.bdid1 
						and left.bdid2 > right.bdid2
						,tPairTransitiveClosure(left,right)
						,local
						);
	inputfileproj := project(pInputFile, t2degrees(left));
	
	PairsTransitiveClosure_dedup_Global	:= dedup(inputfileproj+PairsTransitiveClosure, bdid1, bdid2, nDegrees,all);

	PairsTransitiveClosure_dist			:= distribute(PairsTransitiveClosure_dedup_Global,hash(bdid1));

	PairsTransitiveClosure_sort			:= sort(PairsTransitiveClosure_dist	,bdid1	,bdid2	,nDegrees,local);

	//****** Map each old field down to the lowest possible new field
	// The links we lose here we will get back by chaining the children together
	
	PairsTransitiveClosure_dedup := dedup(PairsTransitiveClosure_sort,bdid1,local);

	ChainChild1 := Business_Header.fChainChild(PairsTransitiveClosure_dedup);
	ChainChild2 := Business_Header.fChainChild(ChainChild1);
	ChainChild3 := Business_Header.fChainChild(ChainChild2);
	
	return ChainChild3;

end;