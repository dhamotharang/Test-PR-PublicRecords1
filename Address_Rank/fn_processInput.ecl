EXPORT fn_processInput(ds_xml_in, 
									     useCannedRecs = FALSE, 
											 skipAddressCleaning = FALSE)  := FUNCTIONMACRO
											 
	IMPORT Address_Rank, AutoKeyI, BatchServices, BatchShare, ut;	
  IMPORT STD; // to cover for ut/hasSufficientInput
	
	batch_input := IF( NOT useCannedRecs, 
										 ds_xml_in, 		 
										 PROJECT(BatchServices._Sample_inBatchMaster('ADDRESS'), TRANSFORM(RECORDOF(ds_xml_in), SELF:=LEFT, SELF:=[]))
										); //permit canned data by sending true param to the service
	//*********************standardize input and acctnos*************************/									
	BatchShare.MAC_SequenceInput(batch_input, ds_in_seq); 
	BatchShare.MAC_CapitalizeInput(ds_in_seq, ds_xml_in_cap);
	BatchShare.MAC_CleanAddresses(ds_xml_in_cap, ds_batch_in);

	ds_batch_in_final := IF(skipAddressCleaning, ds_xml_in_cap, ds_batch_in);

	//********************Check if recs meet minimum input requirements*********/
	RECORDOF(ds_batch_in) checkValidity(ds_batch_in_final l) := TRANSFORM
		SELF.error_code := IF(ut.hasSufficientInput(l, Address_Rank.Constants.Validity_LIMIT),0,AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT); 
		SELF := l;
		SELF := [];
	END;
	batch_in_wErr := PROJECT(ds_batch_in_final, checkValidity(LEFT));

	RETURN batch_in_wErr;
ENDMACRO;
