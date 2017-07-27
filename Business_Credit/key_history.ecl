IMPORT	Business_Credit,	STD;
EXPORT	Key_History(STRING pVersion	=	(STRING8)Std.Date.Today(),
										Constants().buildType	pBuildType	=	Constants().buildType.Daily)	:=	FUNCTION

	dHistory	:=	Business_Credit.Files().history(active	AND
																								STD.Str.FindReplace(previous_account_number, '0','')<>''	AND
																								TRIM(previous_account_number,LEFT,RIGHT) NOT IN ['','0','B','P']);
	
	rHistorySlim	:=	RECORD
		STRING		Version;
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING50	Original_Contract_Account_Number;
		STRING3		Account_Type_Reported;
		STRING30	Previous_Sbfe_Contributor_Number;
		STRING50	Previous_Contract_Account_Number;
		STRING3		Previous_Account_Type;
		STRING8		change_date;
	END;
	
	rHistorySlim	tHistorySlim(dHistory	pInput)	:=	TRANSFORM
		SELF.Version													:=	pInput.process_date;
		SELF.Sbfe_Contributor_Number					:=	pInput.Sbfe_Contributor_Number;
		SELF.Contract_Account_Number					:=	pInput.Contract_Account_Number;
		SELF.Original_Contract_Account_Number	:=	pInput.Original_Contract_Account_Number;
		SELF.Account_Type_Reported						:=	pInput.Account_Type_Reported;
		SELF.Previous_Sbfe_Contributor_Number	:=	IF(pInput.Previous_Member_ID<>'',pInput.Previous_Member_ID,SELF.Sbfe_Contributor_Number);
		SELF.Previous_Contract_Account_Number	:=	pInput.Previous_Account_Number;
		SELF.Previous_Account_Type						:=	IF(pInput.Previous_Account_Type<>'',pInput.Previous_Account_Type,SELF.Account_Type_Reported);
		SELF.change_date											:=	pInput.Cycle_End_Date;
	END;

	dHistorySlim			:=	PROJECT(dHistory,tHistorySlim(LEFT));
	dHistorySlimDedup	:=	DEDUP(SORT(DISTRIBUTE(dHistorySlim,
													HASH(	Sbfe_Contributor_Number,Original_Contract_Account_Number,Previous_Sbfe_Contributor_Number,Previous_Contract_Account_Number)),
																Sbfe_Contributor_Number,Original_Contract_Account_Number,Previous_Sbfe_Contributor_Number,Previous_Contract_Account_Number,-change_date,LOCAL),
																Sbfe_Contributor_Number,Original_Contract_Account_Number,Previous_Sbfe_Contributor_Number,Previous_Contract_Account_Number,LOCAL);
		// If this is a daily build then only create a key with today's records
	dKeyResult				:=	IF(	pBuildType	= Constants().buildType.Daily,
														dHistorySlimDedup(Version=pVersion),
														dHistorySlimDedup);
	RETURN	INDEX(dKeyResult,{Sbfe_Contributor_Number,Original_Contract_Account_Number},{dKeyResult},Business_Credit.keynames().History.QA);
END;