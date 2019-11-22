﻿IMPORT	Header, Address, ut, NID,Std;
EXPORT	fn_setRecordStatus(	STRING	pVersion,
														Constants().buildType	pBuildType	= Constants().buildType.Daily)	:=	FUNCTION

	dDenormed									:=	Business_Credit.Files().Denormalized;
		//	006 Suppress Associated Accounts
	File_Correction_IndicatorSuppressCode:=['006'];
		// 003 = Delete All Account History
		// 080 = Delete Due to Legal Issue (Member Reported)
		// 090 = Delete Due to Fraud (Member Reported)
	sDeleteAccounts	:=	['003','080','090'];
		// 001 = Correction/Replacement of Most Recent Account Update
		// 002 = Delete Most Recent Update Provided for Account
	sDeleteRecords	:=	['001','002'];

		// First add a sequence number field
	rAddSequenceNumberField	:=	RECORD
		dDenormed;
		UNSIGNED6	sequenceNum	:=	0;
	END;
	
	dAddSequenceNumberField	:=	PROJECT(dDenormed,TRANSFORM(rAddSequenceNumberField,SELF:=LEFT));
	ut.MAC_Sequence_Records(dAddSequenceNumberField,sequenceNum,dDenormedWithSequenceNumber); // Add a sequence number to all records
	
	rSlimDenormLayout	:=	RECORD
		STRING		process_date											:=	dDenormedWithSequenceNumber.process_date;
		STRING30	Sbfe_Contributor_Number						:=	dDenormedWithSequenceNumber.portfolioHeader.Sbfe_Contributor_Number;
		STRING8		Extracted_Date										:=	dDenormedWithSequenceNumber.portfolioHeader.Extracted_Date;
		STRING8		Cycle_End_Date										:=	dDenormedWithSequenceNumber.portfolioHeader.Cycle_End_Date;
		STRING50	Contract_Account_Number						:=	dDenormedWithSequenceNumber.Contract_Account_Number;
		STRING50	Original_Contract_Account_Number	:=	dDenormedWithSequenceNumber.Original_Contract_Account_Number;
		STRING3		Account_Type_Reported							:=	dDenormedWithSequenceNumber.Account_Type_Reported;
		STRING3		File_Type_Indicator								:=	dDenormedWithSequenceNumber.fileHeader.File_Type_Indicator;
		STRING3		File_Correction_Indicator					:=	dDenormedWithSequenceNumber.portfolioHeader.File_Correction_Indicator;
		STRING3		Account_Update_Deletion_Indicator	:=	dDenormedWithSequenceNumber.Account_Update_Deletion_Indicator;
		BOOLEAN		active														:=	dDenormedWithSequenceNumber.active;
		STRING1		correction_type										:=	dDenormedWithSequenceNumber.correction_type;
		STRING8		correction_date										:=	dDenormedWithSequenceNumber.correction_date;
		STRING		original_process_date							:=	dDenormedWithSequenceNumber.original_process_date;
		UNSIGNED6	sequenceNum												:=	dDenormedWithSequenceNumber.sequenceNum;
	END;
	
		// Now slim down to only the fields we need so that we're not moving the entire record around
	dSlimDenormed		:=	TABLE(dDenormedWithSequenceNumber,rSlimDenormLayout);
	
	dDenormedSorted	:=	SORT(DISTRIBUTE(dSlimDenormed(active),
												HASH(	Sbfe_Contributor_Number,Original_Contract_Account_Number,Account_Type_Reported)),
															Sbfe_Contributor_Number,Original_Contract_Account_Number,Account_Type_Reported,LOCAL);														
																	
	dMassReplace	:=	dDenormedSorted(File_Type_Indicator='002');
	
	dSetMassDelete	:=	JOIN(
												dDenormedSorted(File_Type_Indicator<>'002'),
												dMassReplace,
													LEFT.Sbfe_Contributor_Number					=	RIGHT.Sbfe_Contributor_Number	AND
													LEFT.Original_Contract_Account_Number	=	RIGHT.Original_Contract_Account_Number	AND
													LEFT.Account_Type_Reported						=	RIGHT.Account_Type_Reported		AND
													LEFT.Extracted_Date										=	RIGHT.Extracted_Date					AND
													LEFT.Cycle_End_Date										=	RIGHT.Cycle_End_Date					AND
													LEFT.process_date											<	RIGHT.process_date,
												TRANSFORM(RECORDOF(LEFT),
													SELF.active						:=	IF(RIGHT.File_Type_Indicator='002',FALSE,TRUE);
													SELF.correction_type	:=	IF(~SELF.active,'A','');
													SELF.correction_date	:=	IF(~SELF.active,RIGHT.process_date[1..8],'');
													SELF				:=	LEFT),
												LEFT OUTER,
												LOCAL
											);
	dMassDelete		:=	dSetMassDelete(~active);
	dStillActive	:=	dSetMassDelete(active)+dMassReplace;
	
	
		// Only keep the latest Account Delete
	dDeleteRecords	:=	DEDUP(SORT(	dStillActive(Account_Update_Deletion_Indicator	IN	sDeleteAccounts),
																	Sbfe_Contributor_Number,Original_Contract_Account_Number,Account_Type_Reported,-Extracted_Date,-process_date,LOCAL),
																	Sbfe_Contributor_Number,Original_Contract_Account_Number,Account_Type_Reported,LOCAL);
	
		// Mark deleted account records as inactive
	dSlimDenormed	tAccountsDeleted(dDenormedSorted	L,	dDeleteRecords	R)	:=	TRANSFORM
		SELF.active						:=	IF(R.Account_Update_Deletion_Indicator	IN	sDeleteAccounts,FALSE,TRUE);										
		SELF.correction_type	:=	IF(~SELF.active,'A','');
		SELF.correction_date	:=	IF(~SELF.active,R.process_date[1..8],'');
		SELF				:=	L;
	END;
	
	dAccountsDeleted	:=	JOIN(
													distribute(dStillActive,HASH(	Sbfe_Contributor_Number,Original_Contract_Account_Number,Account_Type_Reported)),
													distribute(dDeleteRecords,HASH(	Sbfe_Contributor_Number,Original_Contract_Account_Number,Account_Type_Reported)),
														LEFT.Sbfe_Contributor_Number					=		RIGHT.Sbfe_Contributor_Number	AND
														LEFT.Original_Contract_Account_Number	=		RIGHT.Original_Contract_Account_Number	AND
														LEFT.Account_Type_Reported						=		RIGHT.Account_Type_Reported		AND
														LEFT.Extracted_Date										<=	RIGHT.Extracted_Date					AND
														LEFT.process_date											<=		RIGHT.process_date,
													tAccountsDeleted(LEFT,RIGHT),
													LEFT OUTER,
													LOCAL
												);

		// Mark previous record as inactive
	dAccountsDeleted	tDeleteMostRecent(dAccountsDeleted	L,	dAccountsDeleted	R)	:=	TRANSFORM
		SELF.active						:=	IF(	L.Sbfe_Contributor_Number						=		R.Sbfe_Contributor_Number	AND
																	L.Original_Contract_Account_Number	=		R.Original_Contract_Account_Number	AND
																	L.Account_Type_Reported							=		R.Account_Type_Reported		AND
																	L.Account_Update_Deletion_Indicator	IN	sDeleteRecords,
																	FALSE,	TRUE);
		SELF.correction_type	:=	IF(~SELF.active,'A','');
		SELF.correction_date	:=	IF(~SELF.active,R.process_date[1..8],'');
		SELF									:=	R;
	END;											
	dDeleteMostRecent	:=	ITERATE(
													SORT(DISTRIBUTE(dAccountsDeleted(active),
														HASH(	Sbfe_Contributor_Number,Original_Contract_Account_Number)),
																	Sbfe_Contributor_Number,Original_Contract_Account_Number,-process_date,LOCAL),
													tDeleteMostRecent(LEFT,RIGHT),LOCAL);

dMassSuppress:=dDeleteMostRecent(active and File_Correction_Indicator in File_Correction_IndicatorSuppressCode);
	
	dSetMassSuppress:=JOIN(
												dDeleteMostRecent(active),
												dMassSuppress,
													LEFT.Sbfe_Contributor_Number					=	RIGHT.Sbfe_Contributor_Number	AND
													LEFT.Original_Contract_Account_Number	=	RIGHT.Original_Contract_Account_Number	AND
													LEFT.process_date											<=	RIGHT.process_date,
												TRANSFORM(RECORDOF(LEFT),
													SELF.active						:=	if(Right.File_Correction_Indicator in File_Correction_IndicatorSuppressCode,false,true);
													SELF.correction_type	:=	if(~Self.active,'A','');
													SELF.correction_date	:=	if(~Self.active,(STRING8)Std.Date.Today(),'');
													SELF				:=	LEFT),
												LEFT OUTER,
												LOCAL
											);
	//	Set the original_process_date to the process_date of an earlier matching record
	dSetOriginalProcessDate	:=	
							JOIN(
								SORT(DISTRIBUTE(dSetMassSuppress(active),
									HASH(	Sbfe_Contributor_Number,Original_Contract_Account_Number,Account_Type_Reported,Extracted_Date,Cycle_End_Date)),
												Sbfe_Contributor_Number,Original_Contract_Account_Number,Account_Type_Reported,Extracted_Date,Cycle_End_Date,LOCAL),
								DEDUP(SORT(DISTRIBUTE(dMassDelete+dAccountsDeleted(~active)+dDeleteMostRecent(~active)+dSetMassSuppress(~active)+dSlimDenormed(~active),
									HASH(	Sbfe_Contributor_Number,Original_Contract_Account_Number,Account_Type_Reported,Extracted_Date,Cycle_End_Date)),
												Sbfe_Contributor_Number,Original_Contract_Account_Number,Account_Type_Reported,Extracted_Date,Cycle_End_Date,process_date,LOCAL),
												Sbfe_Contributor_Number,Original_Contract_Account_Number,Account_Type_Reported,Extracted_Date,Cycle_End_Date,LOCAL),
									LEFT.Sbfe_Contributor_Number					=	RIGHT.Sbfe_Contributor_Number	AND
									LEFT.Original_Contract_Account_Number	=	RIGHT.Original_Contract_Account_Number	AND
									LEFT.Account_Type_Reported						=	RIGHT.Account_Type_Reported		AND
									LEFT.Extracted_Date										=	RIGHT.Extracted_Date					AND
									LEFT.process_date											>	RIGHT.process_date,
								TRANSFORM(
									RECORDOF(rSlimDenormLayout),
									SELF.original_process_date	:=	RIGHT.process_date;
									SELF												:=	LEFT;
								),
								LEFT OUTER,
								LOCAL
							);
		// Put everything back together with the updated active indicator
	dActive	:=	JOIN(
								SORT(DISTRIBUTE(dDenormedWithSequenceNumber(active),HASH(sequenceNum)),sequenceNum,LOCAL),
								SORT(DISTRIBUTE(dMassDelete+dAccountsDeleted(~active)+dDeleteMostRecent(~active)+dSetMassSuppress(~active)+dSetOriginalProcessDate,HASH(sequenceNum)),sequenceNum,LOCAL),
									LEFT.sequenceNum	=	RIGHT.sequenceNum,
								TRANSFORM(
									RECORDOF(dDenormed),
									SELF.active									:=	RIGHT.active;
									SELF.correction_type				:=	RIGHT.correction_type;
									SELF.correction_date				:=	RIGHT.correction_date;
									SELF.original_process_date	:=	RIGHT.original_process_date;
									SELF												:=	LEFT
								),
								LOCAL
							);
		// If this is a daily, don't worry about changing the active flag
	dBuildResult	:=	IF(	pBuildType	= Constants().buildType.Daily,
												dDenormed(process_date=pVersion)+Business_Credit.Files().Active,
												dActive);
	RETURN dBuildResult;
END;
