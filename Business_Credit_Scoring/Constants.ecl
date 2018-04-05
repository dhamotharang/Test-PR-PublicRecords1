IMPORT	Business_Credit_Scoring,	BusinessCredit_Services,	MDR,	ut,	RiskWise;
EXPORT	Constants(string	pFileDate='')	:=
MODULE

	EXPORT	source					:=	MDR.sourceTools.src_Business_Credit;

	EXPORT	threads					:=	2;

	EXPORT	RoxieIP					:=	RiskWise.shortcuts.prod_batch_analytics_roxie;

	EXPORT	Score_Name			:=	'CREDIT_SCORE';
	
	EXPORT	MonthsToKeep		:=	24;

	//	Score MIN and MAX
	EXPORT	Min_Score_Range	:=	BusinessCredit_Services.Constants.MIN_SCORE_RANGE;
	EXPORT	Max_Score_Range	:=	BusinessCredit_Services.Constants.MAX_SCORE_RANGE;

	//	DBT MIN and MAX
	EXPORT	Min_DBT_range		:=	BusinessCredit_Services.Constants.DBT_MIN_RANGE;
	EXPORT	Max_DBT_range		:=	BusinessCredit_Services.Constants.DBT_MAX_RANGE;
	
	EXPORT	SET_BUSINESS_ONLY_MODEL	:=	BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT;

END;
