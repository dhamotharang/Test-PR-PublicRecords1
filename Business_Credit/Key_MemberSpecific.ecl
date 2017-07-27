IMPORT	Business_Credit,	lib_date,	STD;
EXPORT	Key_MemberSpecific(	STRING pVersion	=	(STRING8)Std.Date.Today(),
														Constants().buildType	pBuildType	=	Constants().buildType.Daily)	:=	FUNCTION

	dMemberSpecific	:=	Business_Credit.Files().MemberSpecific(active);
	
	rMemberSpecificKey	:=	RECORD
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
		STRING20	Name_Of_Value;
		STRING250	Value_String;
		STRING1		Privacy_Indicator;
	END;

	rMemberSpecificKey	tMemberSpecificKey(dMemberSpecific	pInput)	:=	TRANSFORM
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

	dMemberSpecificKey			:=	PROJECT(dMemberSpecific,tMemberSpecificKey(LEFT));
	dMemberSpecificKeyDist	:=	SORT(	DISTRIBUTE(dMemberSpecificKey,
															HASH(	Sbfe_Contributor_Number, Contract_Account_Number, Account_Type_Reported,
																		Name_Of_Value, Value_String, Privacy_Indicator)),
																		//	SORT
																		Sbfe_Contributor_Number, Contract_Account_Number, Account_Type_Reported,
																		Name_Of_Value, Value_String, Privacy_Indicator,
																		dt_first_seen, LOCAL);
	
	rMemberSpecificKey	tFillDates(rMemberSpecificKey	L,	rMemberSpecificKey	R)	:=	TRANSFORM
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

	dMemberSpecificWithDates	:=	ROLLUP(
																dMemberSpecificKeyDist,
																	LEFT.Sbfe_Contributor_Number		=	RIGHT.Sbfe_Contributor_Number			AND
																	LEFT.Contract_Account_Number		=	RIGHT.Contract_Account_Number			AND
																	LEFT.Account_Type_Reported			=	RIGHT.Account_Type_Reported				AND
																	LEFT.Name_Of_Value							=	RIGHT.Name_Of_Value								AND
																	LEFT.Value_String								=	RIGHT.Value_String								AND
																	LEFT.Privacy_Indicator					=	RIGHT.Privacy_Indicator,
																tFillDates(LEFT,RIGHT),
																LOCAL
															);

		// If this is a daily build then only create a key with today's records
	dKeyResult	:=	IF(	pBuildType	= Constants().buildType.Daily,
											dMemberSpecificWithDates(Version=pVersion),
											dMemberSpecificWithDates);

	RETURN	INDEX(dKeyResult,{Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported},{dKeyResult},Business_Credit.keynames().MemberSpecific.QA);
END;