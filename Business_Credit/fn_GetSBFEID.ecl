IMPORT	Business_Credit,	STD,	ut;
EXPORT	fn_GetSBFEID(DATASET(RECORDOF(Layouts.AccountDataLayout))	pInput)	:=	FUNCTION

	dSBFEIDCache			:=	Business_Credit.Files().SBFEIDCache;
	dSBFEIDCacheDist	:=	SORT(DISTRIBUTE(dSBFEIDCache,
													HASH(	Sbfe_Contributor_Number,Original_Contract_Account_Number)),
																Sbfe_Contributor_Number,Original_Contract_Account_Number,LOCAL);

		// First add a sequence number field
	rAddSequenceNumberField	:=	RECORD
		pInput;
		UNSIGNED6	sequenceNum	:=	0;
	END;
	
	dAddSequenceNumberField	:=	PROJECT(pInput,TRANSFORM(rAddSequenceNumberField,SELF:=LEFT));
	ut.MAC_Sequence_Records(dAddSequenceNumberField,sequenceNum,dInputWithSequenceNumber); // Add a sequence number to all records
	
	rSlimInputLayout	:=	RECORD
		STRING30	Sbfe_Contributor_Number	:=	TRIM(dInputWithSequenceNumber.portfolioHeader.Sbfe_Contributor_Number,LEFT,RIGHT);
		STRING50	Original_Contract_Account_Number	:=	TRIM(dInputWithSequenceNumber.Original_Contract_Account_Number,LEFT,RIGHT);
		// Filter out bad History Records
		DATASET(Layouts.AH)	history				:=	dInputWithSequenceNumber.history(
																									STD.Str.FindReplace(previous_account_number, '0','')<>''	AND
																									TRIM(previous_account_number,LEFT,RIGHT) NOT IN ['','0','B','P']);
		UNSIGNED8	sbfe_id									:=	0;
		UNSIGNED6	sequenceNum							:=	dInputWithSequenceNumber.sequenceNum;
	END;
	
		// Now slim down to only the fields we need so that we're not moving the entire record around
	dSlimInput	:=	TABLE(dInputWithSequenceNumber,rSlimInputLayout);
	
	//	Get the Persistent SBFE ID the normal way
	dGetSBFEID	:=	JOIN(
										SORT(DISTRIBUTE(dSlimInput,
											HASH(	Sbfe_Contributor_Number,Original_Contract_Account_Number)),
														Sbfe_Contributor_Number,Original_Contract_Account_Number,LOCAL),
										dSBFEIDCacheDist,
											LEFT.Sbfe_Contributor_Number					=	RIGHT.Sbfe_Contributor_Number	AND
											LEFT.Original_Contract_Account_Number	=	RIGHT.Original_Contract_Account_Number,
										TRANSFORM(RECORDOF(LEFT),SELF.sbfe_id:=RIGHT.sbfe_id;SELF:=LEFT),
										LEFT OUTER,
										LOCAL
									);
										
	dTempHasSBFEID	:=	dGetSBFEID(sbfe_id>0);
	
	//	Now try getting the SBFE ID using the history data if it exists.  The history data may include a new
	//	Member ID (not likely) so we have to check that as well.
	rTempNoSBFEID	:=	RECORD
		dGetSBFEID;
		STRING30	Temp_Sbfe_Contributor_Number;
		STRING50	Temp_Original_Contract_Account_Number;
	END;
	
	rTempNoSBFEID	tTempNoSBFEID(dGetSBFEID	L)	:=	TRANSFORM
		SELF.Temp_Sbfe_Contributor_Number	:=	TRIM(IF(COUNT(L.history)>0 AND L.history[1].Previous_Member_ID<>'',
																					L.history[1].Previous_Member_ID,
																					L.Sbfe_Contributor_Number),LEFT,RIGHT);
		SELF.Temp_Original_Contract_Account_Number	:=	TRIM(IF(COUNT(L.history)>0,L.history[1].Previous_Account_Number,L.Original_Contract_Account_Number),LEFT,RIGHT);
		SELF															:=	L;
	END;
	
	dTempNoSBFEID	:=	PROJECT(dGetSBFEID(sbfe_id=0),tTempNoSBFEID(LEFT));
	
	dGetSBFEIDsWithHistory
								:=	JOIN(
											SORT(DISTRIBUTE(dSBFEIDCache,
												HASH(	Sbfe_Contributor_Number,Original_Contract_Account_Number)),
															Sbfe_Contributor_Number,Original_Contract_Account_Number,LOCAL),
											SORT(DISTRIBUTE(dTempNoSBFEID(COUNT(history)>0),
												HASH(	Temp_Sbfe_Contributor_Number,Temp_Original_Contract_Account_Number)),
															Temp_Sbfe_Contributor_Number,Temp_Original_Contract_Account_Number,LOCAL),
												LEFT.Sbfe_Contributor_Number					=	RIGHT.Temp_Sbfe_Contributor_Number	AND
												LEFT.Original_Contract_Account_Number	=	RIGHT.Temp_Original_Contract_Account_Number,
											TRANSFORM(RECORDOF(RIGHT),SELF.sbfe_id:=LEFT.sbfe_id;SELF:=RIGHT),
											RIGHT OUTER,
											LOCAL
										);
	
		//	These records have an SBFE ID
	dHasSBFEID	:=	dTempHasSBFEID+
									PROJECT(dGetSBFEIDsWithHistory(sbfe_id>0),RECORDOF(dGetSBFEID));
		//	These records require a new SBFE ID.
	dNoSBFEID		:=	dTempNoSBFEID(COUNT(history(STD.Str.FindReplace(previous_account_number, '0','')<>''	AND
														TRIM(previous_account_number,LEFT,RIGHT) NOT IN ['','0','B','P']))=0)+dGetSBFEIDsWithHistory(sbfe_id=0);
	
	Layouts.rSBFEIDCache	tNewSBFEIDs(dNoSBFEID	L)	:=	TRANSFORM
		SELF.Sbfe_Contributor_Number					:=	L.Temp_Sbfe_Contributor_Number;
		SELF.Original_Contract_Account_Number	:=	L.Temp_Original_Contract_Account_Number;
		SELF.sbfe_id													:=	HASH64(	TRIM(SELF.Sbfe_Contributor_Number,LEFT,RIGHT)+
																											TRIM(SELF.Original_Contract_Account_Number,LEFT,RIGHT));
	END;
	
	dGetNewSBFEIDs	:=	PROJECT(dNoSBFEID,tNewSBFEIDs(LEFT));
	
		//  After creating an sbfe_id using the history info, add the same sbfe_id for the orginal account data too.
	dGetNewSBFEIDsPrim	:=	JOIN(
														SORT(DISTRIBUTE(dGetNewSBFEIDs,
															HASH(	Sbfe_Contributor_Number,Original_Contract_Account_Number)),
																		Sbfe_Contributor_Number,Original_Contract_Account_Number,LOCAL),
														SORT(DISTRIBUTE(dNoSBFEID(COUNT(history)>0),
															HASH(	Temp_Sbfe_Contributor_Number,Temp_Original_Contract_Account_Number)),
																		Temp_Sbfe_Contributor_Number,Temp_Original_Contract_Account_Number,LOCAL),
															LEFT.Sbfe_Contributor_Number					=	RIGHT.Temp_Sbfe_Contributor_Number	AND
															LEFT.Original_Contract_Account_Number	=	RIGHT.Temp_Original_Contract_Account_Number,
														TRANSFORM(
															RECORDOF(LEFT),
															SELF.Sbfe_Contributor_Number					:=	RIGHT.Sbfe_Contributor_Number;
															SELF.Original_Contract_Account_Number	:=	RIGHT.Original_Contract_Account_Number;
															SELF.sbfe_id													:=	LEFT.sbfe_id;
														),
														LOCAL
													);
	
	
	dNewSBFEIDs					:=	DEDUP(SORT(DISTRIBUTE(dGetNewSBFEIDs+dGetNewSBFEIDsPrim,
														HASH(	Sbfe_Contributor_Number,Original_Contract_Account_Number)),
																	Sbfe_Contributor_Number,Original_Contract_Account_Number,LOCAL),
																	Sbfe_Contributor_Number,Original_Contract_Account_Number,LOCAL);
													
	basefilename		:=	Business_Credit.Filenames().SBFEIDCache;
	logicalfilename	:=	basefilename+'::'+workunit; // Add WU to create a unique logical file name
	IF(COUNT(dNewSBFEIDs)>0,
		SEQUENTIAL
		(
			OUTPUT(dNewSBFEIDs,,logicalfilename,OVERWRITE,__compressed__);
			FileServices.StartSuperFileTransaction(),
			FileServices.AddSuperFile(basefilename,logicalfilename),
			FileServices.FinishSuperFileTransaction()
		)
	);
	
	dNewSBFEIDCache			:=	IF(COUNT(dNewSBFEIDs)>0,
														DATASET(logicalfilename,Layouts.rSBFEIDCache,THOR),
														DATASET([],Layouts.rSBFEIDCache));
	dNewSBFEIDCacheDist	:=	DEDUP(SORT(DISTRIBUTE(dNewSBFEIDCache,
														HASH(	Sbfe_Contributor_Number,Original_Contract_Account_Number)),
																	Sbfe_Contributor_Number,Original_Contract_Account_Number,LOCAL),
																	Sbfe_Contributor_Number,Original_Contract_Account_Number,LOCAL);
	dFillNewSBFEIDs	:=	JOIN(
												SORT(DISTRIBUTE(dNoSBFEID,
													HASH(	Sbfe_Contributor_Number,Original_Contract_Account_Number)),
																Sbfe_Contributor_Number,Original_Contract_Account_Number,LOCAL),
												dNewSBFEIDCacheDist+dSBFEIDCacheDist,
													LEFT.Sbfe_Contributor_Number					=	RIGHT.Sbfe_Contributor_Number	AND
													LEFT.Original_Contract_Account_Number	=	RIGHT.Original_Contract_Account_Number,
												TRANSFORM(RECORDOF(dSlimInput),SELF.sbfe_id:=RIGHT.sbfe_id;SELF:=LEFT),
												LEFT OUTER,
												LOCAL
											);
	
		// Put everything back together with the updated data
	dFilledSBFEIDs	:=	JOIN(
												SORT(DISTRIBUTE(dInputWithSequenceNumber,HASH(sequenceNum)),sequenceNum,LOCAL),
												SORT(DISTRIBUTE(dHasSBFEID+dFillNewSBFEIDs,HASH(sequenceNum)),sequenceNum,LOCAL),
													LEFT.sequenceNum	=	RIGHT.sequenceNum,
												TRANSFORM(RECORDOF(pInput),
													SELF.sbfe_id	:=	RIGHT.sbfe_id;
													SELF	:=	LEFT),
												LOCAL
											);

	RETURN(dFilledSBFEIDs);

END;