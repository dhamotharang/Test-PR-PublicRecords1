IMPORT	Business_Credit,	ut;
EXPORT	fn_cleanRawData(DATASET(RECORDOF(Business_Credit.Layouts.AccountDataLayout)) pInput) := FUNCTION 
	
		// First add a sequence number field
	rAddSequenceNumberField	:=	RECORD
		pInput;
		UNSIGNED6	sequenceNum	:=	0;
	END;
	
	dAddSequenceNumberField	:=	PROJECT(pInput,TRANSFORM(rAddSequenceNumberField,SELF:=LEFT));
	ut.MAC_Sequence_Records(dAddSequenceNumberField,sequenceNum,dInputWithSequenceNumber); // Add a sequence number to all records
	
	rSlimInputLayout	:=	RECORD
		STRING30	Sbfe_Contributor_Number	:=	dInputWithSequenceNumber.portfolioHeader.Sbfe_Contributor_Number;
		UNSIGNED6	sequenceNum							:=	dInputWithSequenceNumber.sequenceNum;
	END;
	
		// Now slim down to only the fields we need so that we're not moving the entire record around
	dSlimInput	:=	TABLE(dInputWithSequenceNumber,rSlimInputLayout);

	dRemoveQuaratinedAccounts	:=	dSlimInput(Sbfe_Contributor_Number NOT IN 
																	Business_Credit.Files().Quarantined_SBFE_Contributor_Number_Set);
																	
	dMapSBFEContributorNumber	:=	JOIN(
																	SORT(DISTRIBUTE(dRemoveQuaratinedAccounts,HASH(Sbfe_Contributor_Number)),Sbfe_Contributor_Number,LOCAL),
																	SORT(DISTRIBUTE(Business_Credit.Files().mapSBFEContributorNumber,HASH(Old_Sbfe_Contributor_Number)),Old_Sbfe_Contributor_Number,LOCAL),
																		LEFT.Sbfe_Contributor_Number	=	RIGHT.Old_Sbfe_Contributor_Number,
																	TRANSFORM(RECORDOF(LEFT),
																		SELF.Sbfe_Contributor_Number	:=	
																			IF(RIGHT.New_Sbfe_Contributor_Number<>'',
																				RIGHT.New_Sbfe_Contributor_Number,
																				LEFT.Sbfe_Contributor_Number);
																		SELF	:=	LEFT;
																	),
																	LEFT OUTER,
																	LOOKUP,
																	LOCAL
																);
																
		// Put everything back together with the updated data
	dCleanedRawData	:=	JOIN(
												SORT(DISTRIBUTE(dInputWithSequenceNumber,HASH(sequenceNum)),sequenceNum,LOCAL),
												SORT(DISTRIBUTE(dMapSBFEContributorNumber,HASH(sequenceNum)),sequenceNum,LOCAL),
													LEFT.sequenceNum	=	RIGHT.sequenceNum,
												TRANSFORM(RECORDOF(pInput),
													SELF.portfolioHeader.Sbfe_Contributor_Number	:=	RIGHT.Sbfe_Contributor_Number;
													SELF	:=	LEFT),
												LOCAL
											);

	RETURN(dCleanedRawData);
	
END;
