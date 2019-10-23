IMPORT business_header;

EXPORT Update_Base(
  
	STRING                                              pversion
 ,DATASET(QA_Data.Layouts.Input.Sprayed_Addresses)    pSprayedAddrFile  = QA_Data.Files().Input_Addr.sprayed
 ,DATASET(QA_Data.Layouts.Input.Sprayed_Transactions) pSprayedTransFile = QA_Data.Files().Input_Trans.sprayed
 ,DATASET(QA_Data.Layouts.Base)                       pBaseFile         = QA_Data.Files().base.qa	
 ,BOOLEAN                                             pShouldUpdate     = QA_Data._Flags.UpdateExists 

) := FUNCTION

	dStandardizedInputFile	:= QA_Data.Standardize_Input.fAll(pSprayedAddrFile, pSprayedTransFile, pversion);
	
	base_file								:= PROJECT(pBaseFile, TRANSFORM(QA_Data.Layouts.Base, SELF.record_type := 'H'; SELF := LEFT));
	
	update_combined					:= IF(pShouldUpdate
																,dStandardizedInputFile + base_file
																,dStandardizedInputFile);

	dStandardize_Addr		    := QA_Data.Standardize_NameAddr.fAll(update_combined,	pversion);
	dAppendIds							:= QA_Data.Append_Ids.fAll(dStandardize_Addr, pversion);
	dRollup									:= QA_Data.Rollup_Base(dAppendIds);

	RETURN dRollup;
	
END;