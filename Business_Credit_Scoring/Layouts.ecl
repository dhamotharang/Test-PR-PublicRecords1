IMPORT	Business_Credit,	BIPV2,	iesp;
EXPORT	Layouts	:=	MODULE

	SHARED	rBaseLayouts	:=	Business_Credit.Layouts;
	SHARED	rLinkIDs			:=	rBaseLayouts.SBFEAccountLayout;

	EXPORT	rTradelineDBT	:=	RECORD
		rLinkIDs.process_date;
		rLinkIDs.Record_Type;
		rLinkIDs.Sbfe_Contributor_Number;
		rLinkIDs.Contract_Account_Number;
		rLinkIDs.Account_Type_Reported;
		rLinkIDs.Extracted_Date;
		rLinkIDs.Cycle_End_Date;
		rLinkIDs.dt_vendor_first_reported;
		rLinkIDs.dt_vendor_last_reported;
		rLinkIDs.Tradeline.Past_Due_Aging_Amount_Bucket_1;
		rLinkIDs.Tradeline.Past_Due_Aging_Amount_Bucket_2;
		rLinkIDs.Tradeline.Past_Due_Aging_Amount_Bucket_3;
		rLinkIDs.Tradeline.Past_Due_Aging_Amount_Bucket_4;
		rLinkIDs.Tradeline.Past_Due_Aging_Amount_Bucket_5;
		rLinkIDs.Tradeline.Past_Due_Aging_Amount_Bucket_6;
		rLinkIDs.Tradeline.Past_Due_Aging_Amount_Bucket_7;
		rLinkIDs.Tradeline.Remaining_Balance;
		rLinkIDs.Tradeline.past_due_amount;
		STRING3		DBT;
		BIPV2.IDlayouts.l_xlink_ids;
	END;
	
	EXPORT	rDBTAverage	:=	RECORD
		rLinkIDs.process_date;
		rLinkIDs.Sbfe_Contributor_Number;
		rLinkIDs.Contract_Account_Number;
		rLinkIDs.Account_Type_Reported;
		rLinkIDs.dt_vendor_first_reported;
		rLinkIDs.dt_vendor_last_reported;
		BIPV2.IDlayouts.l_xlink_ids;
		INTEGER		Min_DBT_range;
		INTEGER		Max_DBT_range;
		STRING3		DBT;
		STRING25	Classification_Code;
		STRING2		source	:=	Business_Credit_Scoring.Constants().source;
	END;

	EXPORT	rScoreReason	:=	RECORD
		INTEGER		Sequence;
		STRING5		ReasonCode;
		STRING150 Description;
	END;														
	
	EXPORT	rScoring	:=	RECORD
		STRING25	Score_Name			:=	Business_Credit_Scoring.Constants().Score_Name; // Credit Score,  Failure Score or Future LN Credit Score etc..
		INTEGER		Min_Score_Range	:=	(INTEGER)Business_Credit_Scoring.Constants().Min_Score_Range;
		INTEGER		Max_Score_Range	:=	(INTEGER)Business_Credit_Scoring.Constants().Max_Score_Range;
		INTEGER		Score;
		STRING25	Model_Name;
		DATASET(rScoreReason)	ScoreReasons{MAXCOUNT(iesp.constants.SBAnalytics.MaxHRICount)};
	END;
	
	EXPORT	rScores	:=	RECORD
		BIPV2.IDlayouts.l_xlink_ids;
		DATASET(rScoring)	Scores;
		STRING2		source	:=	Business_Credit_Scoring.Constants().source;
	END;

	EXPORT	rScoringIndex	:=	RECORD
		BIPV2.IDlayouts.l_xlink_ids;
		STRING		Version;
		STRING8		date_scored;
		STRING25	Classification_Code;
		STRING250	Classification_Code_Description;
		STRING3		Industry_Score_Avg;
		INTEGER		Min_DBT_range	:=	Business_Credit_Scoring.Constants().Min_DBT_range;
		INTEGER		Max_DBT_range	:=	Business_Credit_Scoring.Constants().Max_DBT_range;
		STRING3		DBT;
		STRING3		Industry_DBT_Avg;
		DATASET(rScoring)	Scores;
		STRING2		source				:=	Business_Credit_Scoring.Constants().source;
	END;
	
	EXPORT	rReleaseDates	:=	RECORD
		STRING9	version;
		STRING8	date_scored;
		STRING8	start_date;
		STRING8	end_date;
		STRING2	source					:=	Business_Credit_Scoring.Constants().source;
	END;
	
END;