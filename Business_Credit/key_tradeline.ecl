IMPORT	Business_Credit, Business_Credit_Scoring,	doxie,	Std,ut;
EXPORT	key_tradeline(STRING pVersion	=	(STRING8)Std.Date.Today(),
											Constants().buildType	pBuildType	=	Constants().buildType.Daily)	:=	FUNCTION

	rTradelines	:=	RECORD
		STRING		Version;
		STRING		Original_Version;
		Business_Credit.Layouts.rAccountBase AND NOT [active];
		string ln_delinquency_date;
		STRING3		DBT;
		string		DBT_V5;
		END;
	//AdjustedArchiveDate:=Std.Date.AdjustCalendar(L.dt_vendor_last_reported,0,0,1);
	Loadfile:=project(Business_Credit.fn_GetSegments.accountBase(active),transform(rTradelines,
		SELF.Version					:=	left.process_date;
		SELF.Original_Version	:=	IF(	left.original_process_date<>'',
																	left.original_process_date,
																	left.process_date);
		SELF.Original_Process_Date	:=	SELF.Original_Version;
		self:=left;
		self:=[];
	));

	SortFile:=sort(distribute(loadfile,hash(Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,Cycle_End_Date,local);
	
	GroupFile:=group(Sortfile,Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,LOCAL);
	
	rTradelines	tLNDeliquencyDate(rTradelines L, rTradelines R,unsigned c)	:=	TRANSFORM
		Midpoint:=map(trim(R.Payment_Interval,left,right)='D'=>-1,//Setting Midpoint by Payment Frequency
					  trim(R.Payment_Interval,left,right)='W'=>-4,
					  trim(R.Payment_Interval,left,right)='BW'=>-7,
					  trim(R.Payment_Interval,left,right)='M'=>-15,
					  trim(R.Payment_Interval,left,right)='BM'=>-30,
					  -15);
		NoCalculateIntervals:=trim(R.Payment_Interval,left,right) not in ['D','W','BW','M','BM',''];

		Hasbucket:=	 (real)TRIM(R.Past_Due_Aging_Amount_Bucket_1,ALL)	<>	0 or
					 (real)TRIM(R.Past_Due_Aging_Amount_Bucket_2,ALL)	<>	0 or
					 (real)TRIM(R.Past_Due_Aging_Amount_Bucket_3,ALL)	<>	0 or
					 (real)TRIM(R.Past_Due_Aging_Amount_Bucket_4,ALL)	<>	0 or
					 (real)TRIM(R.Past_Due_Aging_Amount_Bucket_5,ALL)	<>	0 or
					 (real)TRIM(R.Past_Due_Aging_Amount_Bucket_6,ALL)	<>	0 or
					 (real)TRIM(R.Past_Due_Aging_Amount_Bucket_7,ALL)	<>	0;

		Nobucket:=	 (real)TRIM(R.Past_Due_Aging_Amount_Bucket_1,ALL)	=	0 and 
					 (real)TRIM(R.Past_Due_Aging_Amount_Bucket_2,ALL)	=	0 and 
					 (real)TRIM(R.Past_Due_Aging_Amount_Bucket_3,ALL)	=	0 and 
					 (real)TRIM(R.Past_Due_Aging_Amount_Bucket_4,ALL)	=	0 and 
					 (real)TRIM(R.Past_Due_Aging_Amount_Bucket_5,ALL)	=	0 and 
					 (real)TRIM(R.Past_Due_Aging_Amount_Bucket_6,ALL)	=	0 and 
					 (real)TRIM(R.Past_Due_Aging_Amount_Bucket_7,ALL)	=	0;	

		OnlyBucket1:=(real)TRIM(R.Past_Due_Aging_Amount_Bucket_1,ALL)	<>	0 and 
					 (real)TRIM(R.Past_Due_Aging_Amount_Bucket_2,ALL)	=	0 and
					 (real)TRIM(R.Past_Due_Aging_Amount_Bucket_3,ALL)	=	0 and
					 (real)TRIM(R.Past_Due_Aging_Amount_Bucket_4,ALL)	=	0 and
					 (real)TRIM(R.Past_Due_Aging_Amount_Bucket_5,ALL)	=	0 and
					 (real)TRIM(R.Past_Due_Aging_Amount_Bucket_6,ALL)	=	0 and
					 (real)TRIM(R.Past_Due_Aging_Amount_Bucket_7,ALL)	=	0;
		
		NotBucket1 :=(real)TRIM(R.Past_Due_Aging_Amount_Bucket_2,ALL)	<>	0 or
					 (real)TRIM(R.Past_Due_Aging_Amount_Bucket_3,ALL)	<>	0 or
					 (real)TRIM(R.Past_Due_Aging_Amount_Bucket_4,ALL)	<>	0 or
					 (real)TRIM(R.Past_Due_Aging_Amount_Bucket_5,ALL)	<>	0 or
					 (real)TRIM(R.Past_Due_Aging_Amount_Bucket_6,ALL)	<>	0 or
					 (real)TRIM(R.Past_Due_Aging_Amount_Bucket_7,ALL)	<>	0;

		DaysBetweenOpenCycle:=STD.Date.DaysBetween((unsigned4)R.Date_Account_Opened,(unsigned4)R.cycle_end_date);		
		
		previousfirstrec_DelDate:=trim(L.ln_delinquency_date,left,right) in ['-1','-3','-4'];
		
		
		self.ln_delinquency_date:=map((unsigned)trim(R.Payment_Status_Category,left,right)=0 and Nobucket and (real)R.Past_Due_Amount=0=>'',
									  trim(L.ln_delinquency_date,left,right) not in ['','-1','-2','-3','-4']=>L.ln_delinquency_date,//preserve Previous ln_delinquency_date
									  (c=1 or previousfirstrec_DelDate) and NoCalculateIntervals and DaysBetweenOpenCycle<=60 and (unsigned)trim(R.Payment_Status_Category,left,right) =1=>(String)Std.Date.AdjustCalendar((UNSIGNED4)R.Cycle_End_Date,0,0,-(DaysBetweenOpenCycle/2)),
									  (c=1 or previousfirstrec_DelDate) and NoCalculateIntervals and DaysBetweenOpenCycle<=60 and OnlyBucket1=>(String)Std.Date.AdjustCalendar((UNSIGNED4)R.Cycle_End_Date,0,0,-(DaysBetweenOpenCycle/2)),
									  (c=1 or previousfirstrec_DelDate) and NoCalculateIntervals=>'-1',//First Record No Deliquency with Payment Intervals not valid for midpoint
									  (c=1 or previousfirstrec_DelDate) and (unsigned)trim(R.Payment_Status_Category,left,right) =1=>(String)Std.Date.AdjustCalendar((UNSIGNED4)R.Cycle_End_Date,0,0,midpoint),//First Record No Deliquency with Deliquency Status =1
									  (c=1 or previousfirstrec_DelDate) and (unsigned)trim(R.Payment_Status_Category,left,right)>1=>'-3',//First Record No Deliquency with Deliquency Status >1
									  (c=1 or previousfirstrec_DelDate) and OnlyBucket1=>(String)Std.Date.AdjustCalendar((UNSIGNED4)R.Cycle_End_Date,0,0,midpoint),//First Record No Deliquency with Bucket Data in 1
									  (c=1 or previousfirstrec_DelDate) and NotBucket1=>'-4',//First Record No Deliquency with Bucket Data in 1
									  (unsigned)trim(R.Payment_Status_Category,left,right)>0=>(String)Std.Date.AdjustCalendar((UNSIGNED4)R.Cycle_End_Date,0,0,-15),//Healthy to Deliquent using Deliquency Status
									  Hasbucket=>(String)Std.Date.AdjustCalendar((UNSIGNED4)R.Cycle_End_Date,0,0,-15),//Healthy to Deliquent using Bucket Amount
									  (unsigned)trim(R.Payment_Status_Category,left,right)=0 and Nobucket and (real)R.Past_Due_Amount<>0=>'-2',
									  '');	
		self:=R;
		self:=[];	
	end;

	LoadLnDelinquencyDate:=iterate(Groupfile,tLNDeliquencyDate(left,right,counter));

	rTradelines	tTradelines(rTradelines pInput)	:=	TRANSFORM
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
		self.DBT_V5:=if(trim(pinput.ln_delinquency_date,left,right) in ['','-1','-2','-3','-4'],'',
					 if(length(pinput.ln_delinquency_date)=6,(String)STD.Date.DaysBetween((unsigned4)(pinput.ln_delinquency_date+'15'),(unsigned4)pinput.cycle_end_date),
					 (String)STD.Date.DaysBetween((unsigned4)pinput.ln_delinquency_date,(unsigned4)(pinput.cycle_end_date))));
		
		SELF					:=	pInput;
	END;
	
	dTradelines			:=	PROJECT(LoadLnDelinquencyDate,tTradelines(LEFT));
	dTradelinesDist	:=	SORT(DISTRIBUTE(dTradelines,HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,Cycle_End_Date)),
																												Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,Cycle_End_Date,LOCAL);
		// If this is a daily build then only create a key with today's records
	dKeyResult			:=	IF(	pBuildType	= Constants().buildType.Daily,
													dTradelinesDist(Version=pVersion),
													dTradelinesDist);
	RETURN	INDEX(dKeyResult,{Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,Cycle_End_Date},{dKeyResult},Business_Credit.keynames().Tradeline.QA);
END;