export Remove_Deletes(

	  dataset(layouts.base	)	pInputFile	
	 ,dataset(layouts.base	)	pBaseFile	

) :=
function

	dconcat := project(pInputFile + pBaseFile, transform({boolean ShouldDelete,layouts.base}, self.ShouldDelete := false;self := left;));
	ddist 	:= distribute(dconcat, hash64(rawfields.rmsid));
	dsort 	:= sort (ddist, rawfields.rmsid, -dt_vendor_last_reported, -rawfields.DeleteFlag	, local);
	dgroup	:= group(dsort, rawfields.rmsid 																									, local);
	diterate	:= group(iterate(dgroup
		,transform(
			 recordof(dgroup)
			,self.ShouldDelete  := if(left.ShouldDelete = true or right.rawfields.DeleteFlag = 'D', true, false);
			 self 							:= right;
	)));
	
	dGoodRecs 		:= diterate(ShouldDelete = false);
	dDeletedRecs	:= diterate(ShouldDelete = true	);

	return project(dGoodRecs,transform(layouts.base, self := left));

end;