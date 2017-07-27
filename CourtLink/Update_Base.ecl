export Update_Base(
					dataset(layouts.Input.Sprayed)	pUpdateFile
					,dataset(Layouts.Base)			pBaseFile
					,string	pversion
				  ) := function
				  
	dStandardizedInputFile  := Standardize_Input.fAll  (pUpdateFile, pversion);
	
	update_combined			:= if(_Flags.Update
									,dStandardizedInputFile + pBaseFile
									,dStandardizedInputFile
								  );
								  
	dRollupBase				:= Rollup_Base	(update_combined);
   
	return dRollupBase;
end;