IMPORT	Business_Credit,	lib_date,	STD;
EXPORT	Key_MasterAccount(STRING pVersion	=	(STRING8)Std.Date.Today(),
													Constants().buildType	pBuildType	=	Constants().buildType.Daily)	:=	FUNCTION

	dMasterAccount	:=	Business_Credit.Files().MasterAccount(active);
	
	rMasterAccountKey	:=	RECORD
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
		STRING50	Master_Account_Or_Contract_Number_Identifier;
	END;

	rMasterAccountKey	tMasterAccountKey(dMasterAccount	pInput)	:=	TRANSFORM
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
	
	dMasterAccountKey			:=	PROJECT(dMasterAccount,tMasterAccountKey(LEFT));
	dMasterAccountKeyDist	:=	SORT(	DISTRIBUTE(dMasterAccountKey,
															HASH(	Sbfe_Contributor_Number, Contract_Account_Number, Account_Type_Reported,
																		Master_Account_Or_Contract_Number_Identifier)),
																		//	SORT
																		Sbfe_Contributor_Number, Contract_Account_Number, Account_Type_Reported,
																		Master_Account_Or_Contract_Number_Identifier,
																		dt_first_seen, LOCAL);
	
	rMasterAccountKey	tFillDates(rMasterAccountKey	L,	rMasterAccountKey	R)	:=	TRANSFORM
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
	
	dMasterAccountWithDates	:=	ROLLUP(
																dMasterAccountKeyDist,
																	LEFT.Sbfe_Contributor_Number		=	RIGHT.Sbfe_Contributor_Number			AND
																	LEFT.Contract_Account_Number		=	RIGHT.Contract_Account_Number			AND
																	LEFT.Account_Type_Reported			=	RIGHT.Account_Type_Reported				AND
																	LEFT.Master_Account_Or_Contract_Number_Identifier	=	RIGHT.Master_Account_Or_Contract_Number_Identifier,
																tFillDates(LEFT,RIGHT),
																LOCAL
															);

		// If this is a daily build then only create a key with today's records
	dKeyResult	:=	IF(	pBuildType	= Constants().buildType.Daily,
											dMasterAccountWithDates(Version=pVersion),
											dMasterAccountWithDates);

	RETURN	INDEX(dKeyResult,{Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported},{dKeyResult},Business_Credit.keynames().MasterAccount.QA);
END;