export fLNs() :=
function
	maxnum					:= 53;
	
	myrecord := 
	record
		unsigned8 randomnumber;
		real8 percentage;
		unsigned8 randomnumber2;
		unsigned2 LNs;
	end;

	mydataset := dataset([
		 {0	,0.0,0,0}
	], myrecord);

	normdataset := normalize(mydataset, 1000000	// this should get us enough numbers to play with
		,transform(myrecord
			,self.randomnumber	:= random();
			 self.randomnumber2	:= random();
			 self.percentage		:= (real8)self.randomnumber/4294967296.0; // divide it by 2^32(the max random number)
			 self.LNs			:= (self.percentage * maxnum) + 1;
		)
	);

	dedupLNss := dedup(normdataset, hash(LNs,randomnumber2),all);

	return	
	 output(table(sort(choosen(sort(dedupLNss,randomnumber2),6),LNs),{LNs},LNs)	,named('LNsbers'));

end;
