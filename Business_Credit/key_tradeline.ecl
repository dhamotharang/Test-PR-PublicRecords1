IMPORT	Business_Credit, Business_Credit_Scoring,	doxie,	Std;
EXPORT	key_tradeline(STRING pVersion	=	(STRING8)Std.Date.Today(),
											Constants().buildType	pBuildType	=	Constants().buildType.Daily)	:=	FUNCTION

	rTradelines	:=	RECORD
		STRING		Version;
		STRING		Original_Version;
		Business_Credit.Layouts.rAccountBase AND NOT [active];
		STRING3		DBT;
	END;
	
	rTradelines	tTradelines(Business_Credit.Layouts.rAccountBase pInput)	:=	TRANSFORM
		SELF.Version					:=	pInput.process_date;
		SELF.Original_Version	:=	IF(	pInput.original_process_date<>'',
																	pInput.original_process_date,
																	pInput.process_date);
		SELF.Original_Process_Date	:=	SELF.Original_Version;
		bHasData				:=	TRIM(pInput.Past_Due_Aging_Amount_Bucket_1,ALL)	<>	''	OR
												TRIM(pInput.Past_Due_Aging_Amount_Bucket_2,ALL)	<>	''	OR
												TRIM(pInput.Past_Due_Aging_Amount_Bucket_3,ALL)	<>	''	OR
												TRIM(pInput.Past_Due_Aging_Amount_Bucket_4,ALL)	<>	''	OR
												TRIM(pInput.Past_Due_Aging_Amount_Bucket_5,ALL)	<>	''	OR
												TRIM(pInput.Past_Due_Aging_Amount_Bucket_6,ALL)	<>	''	OR
												TRIM(pInput.Past_Due_Aging_Amount_Bucket_7,ALL)	<>	''	OR
												TRIM(pInput.Remaining_Balance,ALL)							<>	''	OR
												TRIM(pInput.past_due_amount,ALL)								<>	'';
		AccountBalance	:=	IF((INTEGER)pInput.Remaining_Balance	<	(INTEGER)pInput.past_due_amount,
													(INTEGER)pInput.past_due_amount,
													(INTEGER)pInput.Remaining_Balance);
		SELF.DBT				:=	IF(bHasData,
													IF(AccountBalance>0,
														(STRING3)MAX(MIN(ROUND(
															//	Numerator
															(
																((INTEGER)pInput.Past_Due_Aging_Amount_Bucket_1 * 15)+		//	1-30 Days
																((INTEGER)pInput.Past_Due_Aging_Amount_Bucket_2 * 45)+		//	31-60 Days
																((INTEGER)pInput.Past_Due_Aging_Amount_Bucket_3 * 75)+		//	61-90 Days
																(((INTEGER)pInput.Past_Due_Aging_Amount_Bucket_4+
																	(INTEGER)pInput.Past_Due_Aging_Amount_Bucket_5+
																	(INTEGER)pInput.Past_Due_Aging_Amount_Bucket_6+
																	(INTEGER)pInput.Past_Due_Aging_Amount_Bucket_7) * 105)	//	91+ Days
															)/
															//	Denominator
															AccountBalance
														),Business_Credit_Scoring.Constants().Max_DBT_range
														),Business_Credit_Scoring.Constants().Min_DBT_range
														),'000'
													),''
												);
		SELF					:=	pInput;
	END;
	
	dTradelines			:=	PROJECT(Business_Credit.fn_GetSegments.accountBase(active),tTradelines(LEFT));
	dTradelinesDist	:=	SORT(DISTRIBUTE(dTradelines,HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,Cycle_End_Date)),
																												Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,Cycle_End_Date,LOCAL);
		// If this is a daily build then only create a key with today's records
	dKeyResult			:=	IF(	pBuildType	= Constants().buildType.Daily,
													dTradelinesDist(Version=pVersion),
													dTradelinesDist);
	RETURN	INDEX(dKeyResult,{Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,Cycle_End_Date},{dKeyResult},Business_Credit.keynames().Tradeline.QA);
END;