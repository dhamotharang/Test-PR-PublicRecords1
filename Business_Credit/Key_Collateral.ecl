IMPORT	Business_Credit,	lib_date,	STD;
EXPORT	Key_Collateral(	STRING pVersion	=	(STRING8)Std.Date.Today(),
												Constants().buildType	pBuildType	=	Constants().buildType.Daily)	:=	FUNCTION

	dCollateral	:=	Business_Credit.Files().Collateral(active);
	
	rCollateralKey	:=	RECORD
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
		STRING1		Collateral_Indicator;
		STRING3		Type_Of_Collateral_Secured_For_This_Account;
		STRING250	Collateral_Description;
		STRING50	UCC_Filing_Number;
		STRING3		UCC_Filing_Type;
		STRING8		UCC_Filing_Date;
		STRING8		UCC_Filing_Expiration_Date;
		STRING100	UCC_Filing_Jurisdiction;
		STRING250	UCC_Filing_Description;
	END;

	rCollateralKey	tCollateralKey(dCollateral	pInput)	:=	TRANSFORM
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
	
	dCollateralKey			:=	PROJECT(dCollateral,tCollateralKey(LEFT));
	dCollateralKeyDist	:=	SORT(	DISTRIBUTE(dCollateralKey,
															HASH(	Sbfe_Contributor_Number, Contract_Account_Number, Account_Type_Reported,
																		Collateral_Indicator,	Type_Of_Collateral_Secured_For_This_Account, Collateral_Description,
																		UCC_Filing_Number, UCC_Filing_Type, UCC_Filing_Date, 
																		UCC_Filing_Expiration_Date, UCC_Filing_Jurisdiction, UCC_Filing_Description)),
																		//	SORT
																		Sbfe_Contributor_Number, Contract_Account_Number, Account_Type_Reported,
																		Collateral_Indicator,	Type_Of_Collateral_Secured_For_This_Account, Collateral_Description,
																		UCC_Filing_Number, UCC_Filing_Type, UCC_Filing_Date,
																		UCC_Filing_Expiration_Date, UCC_Filing_Jurisdiction, UCC_Filing_Description,
																		dt_first_seen, LOCAL);
	
	rCollateralKey	tFillDates(rCollateralKey	L,	rCollateralKey	R)	:=	TRANSFORM
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
	
	dCollateralWithDates	:=	ROLLUP(
																dCollateralKeyDist,
																	LEFT.Sbfe_Contributor_Number		=	RIGHT.Sbfe_Contributor_Number			AND
																	LEFT.Contract_Account_Number		=	RIGHT.Contract_Account_Number			AND
																	LEFT.Account_Type_Reported			=	RIGHT.Account_Type_Reported				AND
																	LEFT.Collateral_Indicator				=	RIGHT.Collateral_Indicator				AND
																	LEFT.Type_Of_Collateral_Secured_For_This_Account	=	RIGHT.Type_Of_Collateral_Secured_For_This_Account	AND
																	LEFT.Collateral_Description			=	RIGHT.Collateral_Description			AND
																	LEFT.UCC_Filing_Number					=	RIGHT.UCC_Filing_Number						AND
																	LEFT.UCC_Filing_Type						=	RIGHT.UCC_Filing_Type							AND
																	LEFT.UCC_Filing_Date						=	RIGHT.UCC_Filing_Date							AND
																	LEFT.UCC_Filing_Expiration_Date	=	RIGHT.UCC_Filing_Expiration_Date	AND
																	LEFT.UCC_Filing_Jurisdiction		=	RIGHT.UCC_Filing_Jurisdiction			AND
																	LEFT.UCC_Filing_Description			=	RIGHT.UCC_Filing_Description,
																tFillDates(LEFT,RIGHT),
																LOCAL
															);
		// If this is a daily build then only create a key with today's records
	dKeyResult	:=	IF(	pBuildType	= Constants().buildType.Daily,
											dCollateralWithDates(Version=pVersion),
											dCollateralWithDates);
	RETURN	INDEX(dKeyResult,{Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported},{dKeyResult},Business_Credit.keynames().Collateral.QA);
END;