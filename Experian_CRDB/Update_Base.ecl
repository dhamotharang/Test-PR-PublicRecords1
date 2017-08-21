import business_header, bipv2, ut;

export Update_Base(string																			pversion
									 ,dataset(Layouts.Input.Sprayed						)	pSprayedFile		= Files().Input.using
									 ,dataset(Layouts.Base										)	pBaseFile			  = Files().base.qa
									 ,boolean																		pShouldUpdate		= _Flags.Update
									 ):= function

	dStandardizedInput  := Standardize_Input.fAll (Files().Input.using, pversion);
	
 	update_combined		  := if(pShouldUpdate
   												 ,dStandardizedInput + pBaseFile
   												 ,dStandardizedInput);
														
	dStandardize_Addr		:= Standardize_NameAddr.fAll(update_combined,	pversion);	
	dRollup							:= Rollup_Base							(dStandardize_Addr);
	dAppendIds					:= Append_Ids.fAll					(dRollup);
		
	return dAppendIds;
		
end;