export Update_NJ(

	 dataset(Layouts.Input.NJ	)	pUpdateFile
	,dataset(Layouts.Base.NJ	)	pBaseFile
	,string											pversion

) :=
function

	dStandardizedInputFile := Standardize_NJ.fAll(pUpdateFile, pversion);

	base_file := project(pBaseFile, transform(Layouts.Base.NJ, self.record_type := 'H'; self := left));

	update_combined	 	  := map(_Flags.Update.NJ =>	dStandardizedInputFile + base_file,
																									dStandardizedInputFile 
												);

	dAppendIds					:= Append_Ids.fAll		(update_combined			);
	dRollup							:= Rollup_NJ					(dAppendIds						);

	return dRollup;

end;