IMPORT	Business_Credit, Business_Credit_Scoring,	doxie,	Std,ut;
EXPORT	key_tradeline(STRING pVersion	=	(STRING8)Std.Date.Today(),
											Constants().buildType	pBuildType	=	Constants().buildType.Daily)	:=	FUNCTION

	rTradelines	:=	RECORD
		STRING		Version;
		STRING		Original_Version;
		Business_Credit.Layouts.rAccountBase AND NOT [active];
		STRING3		DBT;
		String3		DBT_V5;
	END;
	//AdjustedArchiveDate:=Std.Date.AdjustCalendar(L.dt_vendor_last_reported,0,0,1);
	rTradelines	tLNDeliquencyDate(Business_Credit.Layouts.rAccountBase L, Business_Credit.Layouts.rAccountBase R)	:=	TRANSFORM
		Midpoint:=map(trim(R.Payment_Interval,left,right)='D'=>-1,//Setting Midpoint by Payment Frequency
					  trim(R.Payment_Interval,left,right)='W'=>-4,
					  trim(R.Payment_Interval,left,right)='BW'=>-7,
					  trim(R.Payment_Interval,left,right)='M'=>-15,
					  trim(R.Payment_Interval,left,right)='BM'=>-30,
					  -1);
		NoCalculateIntervals:=R.Payment_Interval not in ['D','W','BW','M','BM'];

		Hasbucket:=	 (unsigned)TRIM(R.Past_Due_Aging_Amount_Bucket_1,ALL)	<>	0 or
					 (unsigned)TRIM(R.Past_Due_Aging_Amount_Bucket_2,ALL)	<>	0 or
					 (unsigned)TRIM(R.Past_Due_Aging_Amount_Bucket_3,ALL)	<>	0 or
					 (unsigned)TRIM(R.Past_Due_Aging_Amount_Bucket_4,ALL)	<>	0 or
					 (unsigned)TRIM(R.Past_Due_Aging_Amount_Bucket_5,ALL)	<>	0 or
					 (unsigned)TRIM(R.Past_Due_Aging_Amount_Bucket_6,ALL)	<>	0 or
					 (unsigned)TRIM(R.Past_Due_Aging_Amount_Bucket_7,ALL)	<>	0;

		OnlyBucket1:=(unsigned)TRIM(R.Past_Due_Aging_Amount_Bucket_1,ALL)	<>	0 and 
					 (unsigned)TRIM(R.Past_Due_Aging_Amount_Bucket_2,ALL)	=	0 and
					 (unsigned)TRIM(R.Past_Due_Aging_Amount_Bucket_3,ALL)	=	0 and
					 (unsigned)TRIM(R.Past_Due_Aging_Amount_Bucket_4,ALL)	=	0 and
					 (unsigned)TRIM(R.Past_Due_Aging_Amount_Bucket_5,ALL)	=	0 and
					 (unsigned)TRIM(R.Past_Due_Aging_Amount_Bucket_6,ALL)	=	0 and
					 (unsigned)TRIM(R.Past_Due_Aging_Amount_Bucket_7,ALL)	=	0;
		
		NotBucket1 :=(unsigned)TRIM(R.Past_Due_Aging_Amount_Bucket_2,ALL)	<>	0 or
					 (unsigned)TRIM(R.Past_Due_Aging_Amount_Bucket_3,ALL)	<>	0 or
					 (unsigned)TRIM(R.Past_Due_Aging_Amount_Bucket_4,ALL)	<>	0 or
					 (unsigned)TRIM(R.Past_Due_Aging_Amount_Bucket_5,ALL)	<>	0 or
					 (unsigned)TRIM(R.Past_Due_Aging_Amount_Bucket_6,ALL)	<>	0 or
					 (unsigned)TRIM(R.Past_Due_Aging_Amount_Bucket_7,ALL)	<>	0;		

		self.ln_deliquency_date:=map(trim(R.Delinquency_Date,left,right)<>''=>R.Delinquency_Date,//Deliquency Date is populated
									 trim(L.ln_deliquency_date,left,right)<>''=>L.ln_deliquency_date,//preserve Previous Ln_Deliquency_Date
									 trim(L.cycle_end_date,left,right)='' and NoCalculateIntervals=>'-1',//First Record No Deliquency with Payment Intervals not valid for midpoint
									 trim(L.cycle_end_date,left,right)='' and (unsigned)trim(R.Payment_Status_Category,left,right) =1=>(String)Std.Date.AdjustCalendar((UNSIGNED4)R.Cycle_End_Date,0,0,midpoint),//First Record No Deliquency with Deliquency Status =1
									 trim(L.cycle_end_date,left,right)='' and (unsigned)trim(R.Payment_Status_Category,left,right)>1=>'-1',//First Record No Deliquency with Deliquency Status >1
									 trim(L.cycle_end_date,left,right)='' and OnlyBucket1=>(String)Std.Date.AdjustCalendar((UNSIGNED4)R.Cycle_End_Date,0,0,midpoint),//First Record No Deliquency with Bucket Data in 1
									 trim(L.cycle_end_date,left,right)='' and NotBucket1=>'-1',//First Record No Deliquency with Bucket Data in 1
									 trim(R.Payment_Status_Category,left,right)<>'' and (unsigned)trim(R.Payment_Status_Category,left,right)<>0=>(String)Std.Date.AdjustCalendar((UNSIGNED4)R.Cycle_End_Date,0,0,-15),//Healthy to Deliquent using Deliquency Status
									 Hasbucket=>(String)Std.Date.AdjustCalendar((UNSIGNED4)R.Cycle_End_Date,0,0,-15),//Healthy to Deliquent using Bucket Amount
									 (unsigned)R.Past_Due_Amount>0=>'-1',
									 '');
		self:=R;
		self:=[];	
	end;

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
		self.DBT_V5:=(String)ut.DaysApart(pinput.cycle_end_date,pinput.ln_deliquency_date);
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