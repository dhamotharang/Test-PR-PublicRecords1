import business_header,business_header_ss,did_add,ut,mdr,AID;

export Update_Base(
										dataset(layouts.Input)	pUpdateFile
									 ) := function
								
		dStandardizedInputFile  := 	CNLD_Practitioner.StandardizeInputFile.fAll  (pUpdateFile);
																
		dCleanNameAddr					:=	CNLD_Practitioner.fCleanNameAddr(dStandardizedInputFile);
											
		dAppendADLS							:= 	CNLD_Practitioner.fAppend_ADLS(dCleanNameAddr);
	
		// dRollupBase							:= 	CNLD_Practitioner.fRollupBase	(dAppendADLS);
   
		return dAppendADLS;
end;