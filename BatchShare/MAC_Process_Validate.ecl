//This Function Macro processes the batch input validates the minimal input criteria per validMinInput_enum
EXPORT MAC_Process_Validate(ds_in
                            ,validateInput=true
                            ,validMinInput_enum=BatchShare.Constants.Valid_Min_Cri.DID_OR_Name_Address_WITH_DOB_OR_SSN
                           ) := FUNCTIONMACRO
IMPORT BatchShare,AutoKeyI;
	BatchShare.MAC_SequenceInput(ds_in, ds_seq);		
	BatchShare.MAC_CapitalizeInput(ds_seq, ds_cap);
	// if you need to make MAC_CleanAddresses conditional,
	// try using BatchShare.MAC_ProcessInput once it is cleared for use....
	BatchShare.MAC_CleanAddresses(ds_cap, ds_clean);
	
	//the project below adds error code 301 (INSUFFICIENT_INPUT) per validMinInput_enum rule
	validated := PROJECT(ds_clean
	                     ,TRANSFORM(RECORDOF(ds_clean)
												  ,SELF.error_code:=IF(BatchShare.MAC_IsInputValid(LEFT,validMinInput_enum)
																					     ,BatchShare.Constants.ValidInput
																					     ,AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT)
												  ,SELF:=LEFT));
													
	RETURN IF(validateInput,validated,ds_clean);
ENDMACRO;