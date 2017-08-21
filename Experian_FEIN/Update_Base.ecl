import business_header, bipv2, ut;

export Update_Base( string 	pversion
									 ,dataset(Layouts.Input.sprayed) pSprayedFile = Files().Input.using
									 ,dataset(Layouts.Base 				 ) pBaseFile		= Files().base.qa
									 ,boolean	pShouldUpdate												= _Flags.Update	
 ) := function

	dStandardizedInput := Standardize_Input.fAll (pSprayedFile, pversion);
	
	update_combined		 := if(pShouldUpdate
													,dStandardizedInput + pBaseFile
													,dStandardizedInput);
																
	dStandardize_Addr	 := Standardize_Addr.fAll  (update_combined,	pversion);
	
	// Add source_rec_id  
	Layouts.base tSource(Layouts.base l) := transform
			self.source_rec_id := HASH64( trim(l.Business_Identification_Number,left,right) + 
																		ut.CleanSpacesAndUpper(l.Long_Name)                      + 
																		ut.CleanSpacesAndUpper(l.Business_Name)                  +
																		ut.CleanSpacesAndUpper(l.Business_Address)               + 
																		ut.CleanSpacesAndUpper(l.Business_City)                  + 
																		ut.CleanSpacesAndUpper(l.Business_State)                 + 
																		trim(l.Business_Zip,left,right)                   +
																		trim(l.Norm_Tax_ID,left,right) 		 					  	  +
																		trim(l.Norm_Type,left,right)                      +
																		trim(l.Norm_Confidence_Level,left,right)          +
																		trim(l.Norm_Display_Configuration,left,right)   	);	
		  self 							:= l;
			self 							:= [];
		end;
	
	dSourceRecIds := project(dStandardize_Addr, tSource(left));
	dRollup1			:= Rollup_Base.preIDs	(dSourceRecIds);
	dAppendIds		:= Append_Ids.fAll    (dRollup1);
	dRollup2			:= Rollup_Base.postIDs(dAppendIds);
		
	return dRollup2;
		
end;