IMPORT	Business_Credit_Scoring,	BusinessCredit_Services,	Business_Credit,	BIPV2,	STD;
EXPORT	fn_GetDBTAverage(	STRING pVersion	=	(STRING8)Std.Date.Today(),
													DATASET(RECORDOF(Business_Credit.Layouts.SBFEAccountLayout)) pInput) := FUNCTION 

	//	Calculate the DBT for all records 
	Layouts.rTradelineDBT	tTradelineDBT(pInput L)	:=	TRANSFORM
		SELF.Past_Due_Aging_Amount_Bucket_1	:=	L.Tradeline.Past_Due_Aging_Amount_Bucket_1;
		SELF.Past_Due_Aging_Amount_Bucket_2	:=	L.Tradeline.Past_Due_Aging_Amount_Bucket_2;
		SELF.Past_Due_Aging_Amount_Bucket_3	:=	L.Tradeline.Past_Due_Aging_Amount_Bucket_3;
		SELF.Past_Due_Aging_Amount_Bucket_4	:=	L.Tradeline.Past_Due_Aging_Amount_Bucket_4;
		SELF.Past_Due_Aging_Amount_Bucket_5	:=	L.Tradeline.Past_Due_Aging_Amount_Bucket_5;
		SELF.Past_Due_Aging_Amount_Bucket_6	:=	L.Tradeline.Past_Due_Aging_Amount_Bucket_6;
		SELF.Past_Due_Aging_Amount_Bucket_7	:=	L.Tradeline.Past_Due_Aging_Amount_Bucket_7;
		SELF.Remaining_Balance							:=	L.Tradeline.Remaining_Balance;
		SELF.past_due_amount								:=	L.Tradeline.past_due_amount;
		bHasData														:=	TRIM(SELF.Past_Due_Aging_Amount_Bucket_1,ALL)	<>	''	OR
																						TRIM(SELF.Past_Due_Aging_Amount_Bucket_2,ALL)	<>	''	OR
																						TRIM(SELF.Past_Due_Aging_Amount_Bucket_3,ALL)	<>	''	OR
																						TRIM(SELF.Past_Due_Aging_Amount_Bucket_4,ALL)	<>	''	OR
																						TRIM(SELF.Past_Due_Aging_Amount_Bucket_5,ALL)	<>	''	OR
																						TRIM(SELF.Past_Due_Aging_Amount_Bucket_6,ALL)	<>	''	OR
																						TRIM(SELF.Past_Due_Aging_Amount_Bucket_7,ALL)	<>	''	OR
																						TRIM(SELF.Remaining_Balance,ALL)							<>	''	OR
																						TRIM(SELF.past_due_amount,ALL)								<>	'';
		AccountBalance											:=	IF((INTEGER)SELF.Remaining_Balance <	(INTEGER)SELF.past_due_amount,
																							(INTEGER)SELF.past_due_amount,
																							(INTEGER)SELF.Remaining_Balance);
		SELF.DBT									:=	IF(bHasData,
																		IF(AccountBalance>0,
																			(STRING3)MAX(MIN(ROUND(
																				//	Numerator
																				(
																					((INTEGER)SELF.Past_Due_Aging_Amount_Bucket_1 * 15)+		//	1-30 Days
																					((INTEGER)SELF.Past_Due_Aging_Amount_Bucket_2 * 45)+		//	31-60 Days
																					((INTEGER)SELF.Past_Due_Aging_Amount_Bucket_3 * 75)+		//	61-90 Days
																					(((INTEGER)SELF.Past_Due_Aging_Amount_Bucket_4+
																						(INTEGER)SELF.Past_Due_Aging_Amount_Bucket_5+
																						(INTEGER)SELF.Past_Due_Aging_Amount_Bucket_6+
																						(INTEGER)SELF.Past_Due_Aging_Amount_Bucket_7) * Constants().Max_DBT_range)	//	91+ Days
																				)/
																				//	Denominator
																				AccountBalance
																			),Business_Credit_Scoring.Constants().Max_DBT_range
																			),Business_Credit_Scoring.Constants().Min_DBT_range
																			),'000'
																		),''
																	);
		SELF																:=	L;
	END;
	
	dTradelineDBT	:=	PROJECT(pInput,tTradelineDBT(LEFT)):PERSIST(PersistNames.TradelineDBT);
	
	//	Get MIN/MAX/AVG DBTs for these Businesses for last month
	Business_Credit_Scoring.Layouts.rDBTAverage	tGetDBTAverage(dTradelineDBT L,	DATASET(RECORDOF(dTradelineDBT)) allRows)	:=	TRANSFORM
		SELF.DotID					:=	0;
		SELF.DotScore				:=	0;
		SELF.DotWeight			:=	0;
		SELF.EmpID					:=	0;
		SELF.EmpScore				:=	0;
		SELF.EmpWeight			:=	0;
		SELF.POWID					:=	0;
		SELF.POWScore				:=	0;
		SELF.POWWeight			:=	0;
		SELF.ProxID					:=	0;
		SELF.ProxScore			:=	0;
		SELF.ProxWeight			:=	0;
		SELF.source					:=	Business_Credit_Scoring.Constants().source;
		SELF.Min_DBT_range	:=	Constants().Min_DBT_range;
		SELF.Max_DBT_range	:=	Constants().Max_DBT_range;
			//	We are only taking the average of the DBT from the prior month.
			//	We also remove blank ('') DBT's as they don't count in our calculations.
		SELF.DBT						:=	IF(COUNT(	allRows(DBT	<>	''																						AND
																							cycle_end_date >=	fn_ReleaseDates(pVersion).StartDate	AND
																							cycle_end_date <=	fn_ReleaseDates(pVersion).EndDate))>0,
														(STRING3)ROUND(AVE(
																			allRows(DBT	<>	''																						AND
																							cycle_end_date >=	fn_ReleaseDates(pVersion).StartDate	AND
																							cycle_end_date <=	fn_ReleaseDates(pVersion).EndDate),
																					(INTEGER)allRows.DBT)),'');
		SELF								:=	L;
		SELF								:=	[];
	END;
	
	dTradelineDBTGroup	:=	GROUP(SORT(DISTRIBUTE(dTradelineDBT(	UltID		>	0 OR 
																																OrgID		>	0 OR 
																																SeleID	>	0 ),
														HASH(	UltID, OrgID, SeleID)),
																	UltID, OrgID, SeleID, LOCAL),
																	UltID, OrgID, SeleID, LOCAL);
																	
	dGetDBTAverage	:=	ROLLUP(dTradelineDBTGroup,GROUP,tGetDBTAverage(LEFT,ROWS(LEFT)));
	
	//	Get the Classification Codes for these Businesses
	dGetSlimLinkIds				:=	PROJECT(pInput,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2,SELF:=LEFT;SELF:=[]));
	dGetSlimLinkIdsDedup	:=	DEDUP(SORT(DISTRIBUTE(dGetSlimLinkIds,
															HASH(	UltID, OrgID, SeleID)),
																		UltID, OrgID, SeleID,LOCAL),
																		UltID, OrgID, SeleID,LOCAL);
	dGetClassificationCodes	:=	BusinessCredit_Services.fn_getPrimaryIndustry(dGetSlimLinkIdsDedup,'000000000001',TRUE).bestIndustryCode;

	dDBTAverage	:=	JOIN(
										SORT(DISTRIBUTE(dGetDBTAverage,
											HASH(	UltID, OrgID, SeleID)),
														UltID, OrgID, SeleID,LOCAL),
										SORT(DISTRIBUTE(dGetClassificationCodes,
											HASH(	UltID, OrgID, SeleID)),
														UltID, OrgID, SeleID,LOCAL),
											LEFT.UltID	=	RIGHT.UltID	AND
											LEFT.OrgID	=	RIGHT.OrgID	AND
											LEFT.SeleID	=	RIGHT.SeleID,
										TRANSFORM(RECORDOF(LEFT),SELF.Classification_Code:=RIGHT.Best_Code;SELF:=LEFT),
										LEFT OUTER,
										LOCAL
									);
									
	RETURN(dDBTAverage);
	
END;
