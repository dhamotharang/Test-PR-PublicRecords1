IMPORT	Business_Credit,	lib_date,	STD;
EXPORT	Key_IndividualOwner(STRING pVersion	=	(STRING8)Std.Date.Today(),
														Constants().buildType	pBuildType	=	Constants().buildType.Daily)	:=	FUNCTION

	dIndividualOwner	:=	Business_Credit.Files().IndividualOwner(active);
	
	rIndividualOwnerKey	:=	RECORD
		STRING		Version;
		STRING		Original_Version;
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING50	Original_Contract_Account_Number;
		STRING3		Account_Type_Reported;
		UNSIGNED4	dt_first_seen;
		UNSIGNED4	dt_last_seen;
		UNSIGNED4	dt_vendor_first_reported;
		UNSIGNED4	dt_vendor_last_reported;
		UNSIGNED4	dt_datawarehouse_first_reported;
		UNSIGNED4	dt_datawarehouse_last_reported;
		STRING50	Original_fname;
		STRING50	Original_mname;
		STRING50	Original_lname;
		STRING5		Original_suffix;
		STRING100	E_Mail_Address;
		STRING3		Guarantor_Owner_Indicator;
		STRING3		Relationship_to_Business_Indicator;
		STRING150	Business_Title;
		STRING3		Percent_Of_Liability;
		STRING3		Percent_Of_Ownership;
		//DF-26180 Add CCPA fields to  thor_data400::key::sbfe::qa::individualowner
		UNSIGNED6	did;
		UNSIGNED4	global_sid;
		UNSIGNED8   record_sid;	
	END;

	rIndividualOwnerKey	tIndividualOwnerKey(dIndividualOwner	pInput)	:=	TRANSFORM
		SELF.Version													:=	pInput.process_date;
		SELF.Original_Version									:=	IF(	pInput.original_process_date<>'',
																									pInput.original_process_date,
																									pInput.process_date);
		SELF.dt_first_seen										:=	(UNSIGNED4)pInput.Cycle_End_Date;
		SELF.dt_last_seen											:=	(UNSIGNED4)pInput.Cycle_End_Date;
		SELF.dt_vendor_first_reported					:=	(UNSIGNED4)pInput.process_date;
		SELF.dt_vendor_last_reported					:=	(UNSIGNED4)pInput.process_date;
		SELF.dt_datawarehouse_first_reported	:=	(UNSIGNED4)pInput.Extracted_Date;
		SELF.dt_datawarehouse_last_reported		:=	(UNSIGNED4)pInput.Extracted_Date;
		SELF																	:=	pInput;
	END;
	
	dIndividualOwnerKey			:=	PROJECT(dIndividualOwner,tIndividualOwnerKey(LEFT));
	
  	dIndividualOwnerKeyDist	:=	SORT(	DISTRIBUTE(dIndividualOwnerKey,
																	HASH(	Sbfe_Contributor_Number, Contract_Account_Number, Account_Type_Reported, 
																				Original_fname, Original_mname, Original_lname, Original_suffix, E_Mail_Address,
																				Guarantor_Owner_Indicator, Relationship_to_Business_Indicator,
																				Business_Title, Percent_Of_Liability, Percent_Of_Ownership)),
																				//	SORT
																				Sbfe_Contributor_Number, Contract_Account_Number, Account_Type_Reported,
																				Original_fname, Original_mname, Original_lname, Original_suffix, E_Mail_Address,
																				Guarantor_Owner_Indicator, Relationship_to_Business_Indicator,
																				Business_Title, Percent_Of_Liability, Percent_Of_Ownership, dt_first_seen, LOCAL);
	
	rIndividualOwnerKey	tFillDates(rIndividualOwnerKey	L,	rIndividualOwnerKey	R)	:=	TRANSFORM
		SELF.Version													:=	lib_date.EarliestDateString(L.Version,	R.Version);
		SELF.Original_Version									:=	lib_date.EarliestDateString(L.Original_Version,	R.Original_Version);
		SELF.dt_first_seen										:=	lib_date.EarliestDate(L.dt_first_seen,	R.dt_first_seen);
		SELF.dt_last_seen											:=	lib_date.LatestDate(L.dt_last_seen,	R.dt_last_seen);
		SELF.dt_vendor_first_reported					:=	lib_date.EarliestDate(L.dt_vendor_first_reported,	R.dt_vendor_first_reported);
		SELF.dt_vendor_last_reported					:=	lib_date.LatestDate(L.dt_vendor_last_reported,	R.dt_vendor_last_reported);
		SELF.dt_datawarehouse_first_reported	:=	lib_date.EarliestDate(L.dt_datawarehouse_first_reported,	R.dt_datawarehouse_first_reported);
		SELF.dt_datawarehouse_last_reported		:=	lib_date.LatestDate(L.dt_datawarehouse_last_reported,	R.dt_datawarehouse_last_reported);
		SELF																	:=	L;
	END;
	
	dIndividualOwnerWithDates	:=	ROLLUP(
																		dIndividualOwnerKeyDist,
																			LEFT.Sbfe_Contributor_Number						=	RIGHT.Sbfe_Contributor_Number							AND
																			LEFT.Contract_Account_Number						=	RIGHT.Contract_Account_Number							AND
																			LEFT.Account_Type_Reported							=	RIGHT.Account_Type_Reported								AND
																			LEFT.Original_fname											=	RIGHT.Original_fname											AND
																			LEFT.Original_mname											=	RIGHT.Original_mname											AND
																			LEFT.Original_lname											=	RIGHT.Original_lname											AND
																			LEFT.Original_suffix										=	RIGHT.Original_suffix											AND
																			LEFT.E_Mail_Address											=	RIGHT.E_Mail_Address											AND
																			LEFT.Guarantor_Owner_Indicator					=	RIGHT.Guarantor_Owner_Indicator						AND
																			LEFT.Relationship_to_Business_Indicator	=	RIGHT.Relationship_to_Business_Indicator	AND
																			LEFT.Business_Title											=	RIGHT.Business_Title											AND
																			LEFT.Percent_Of_Liability								=	RIGHT.Percent_Of_Liability								AND
																			LEFT.Percent_Of_Ownership								=	RIGHT.Percent_Of_Ownership,
																		tFillDates(LEFT,RIGHT),
																		LOCAL
																	);
																	
		// If this is a daily build then only create a key with today's records
	dKeyResult	:=	IF(	pBuildType	= Constants().buildType.Daily,
											dIndividualOwnerWithDates(Version=pVersion),
											dIndividualOwnerWithDates);

	RETURN	INDEX(dKeyResult,{Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported},{dKeyResult},Business_Credit.keynames().IndividualOwner.QA);
END;