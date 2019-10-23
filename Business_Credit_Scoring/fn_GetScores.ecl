IMPORT	Business_Credit_Scoring,	Business_Risk_BIP,	LNSmallBusiness,	iesp,	ut, STD;
EXPORT	fn_GetScores(	STRING	pVersion	=	(STRING8)Std.Date.Today(),
											DATASET(RECORDOF(Business_Risk_BIP.Layouts.Input)) pInput,
											INTEGER	pThreads	=	Constants().threads,
											STRING	pRoxieIP	=	Constants().RoxieIP
										) := FUNCTION 
			
	//	This product is not being run for marketing, allow all normal sources
	Marketing_Mode	:=	Business_Risk_BIP.Constants.Default_MarketingMode;
	//	Clean up the Options and make sure that defaults are enforced
	pOptions := MODULE(Business_Risk_BIP.LIB_Business_Shell_LIBIN)
		EXPORT UNSIGNED1	DPPA_Purpose 				:=	1;
		EXPORT UNSIGNED1	GLBA_Purpose 				:=	1;
		EXPORT STRING50		DataRestrictionMask	:=	Business_Risk_BIP.Constants.Default_DataRestrictionMask;
		EXPORT STRING50		DataPermissionMask	:=	'00000000000100000000'; // Set 12th pos = '1' for SBFE data.
		EXPORT STRING10		IndustryClass				:=	Business_Risk_BIP.Constants.Default_IndustryClass;
		EXPORT UNSIGNED1	LinkSearchLevel			:=	Business_Risk_BIP.Constants.LinkSearch.Default;
		EXPORT UNSIGNED1	BusShellVersion			:=	Business_Risk_BIP.Constants.Default_BusShellVersion;
		EXPORT UNSIGNED1	MarketingMode				:=	MAX(MIN(Marketing_Mode, 1), 0);
		EXPORT STRING50		AllowedSources			:=	Business_Risk_BIP.Constants.Default_AllowedSources;
		EXPORT UNSIGNED1	BIPBestAppend				:=	Business_Risk_BIP.Constants.BIPBestAppend.Default; // See enums
		EXPORT UNSIGNED1	OFAC_Version				:=	Business_Risk_BIP.Constants.Default_OFAC_Version;
		EXPORT REAL				Global_Watchlist_Threshold	:=	Business_Risk_BIP.Constants.Default_Global_Watchlist_Threshold;
		EXPORT DATASET(iesp.Share.t_StringArrayItem) Watchlists_Requested := DATASET([],iesp.Share.t_StringArrayItem);
	END;
	
	//	If version equals this month return zero.
	//	If this is a previous month return the date for the first day of that month.
	pToday							:=	(STRING8)Std.Date.Today();
	pHistoryDate	:=	IF(pVersion[1..6]	=	pToday[1..6],0,(UNSIGNED4)(pVersion[1..6]+'01'));
	dFillScores		:=	LNSmallBusiness.soap_SmallBusiness_getScores(	pInput,	//	SBFE Unique SeleIDs
																																	pOptions,										//	Business Shell Options
																																	Constants().SET_BUSINESS_ONLY_MODEL,	//	Names of Models to use
																																	pHistoryDate,								//	Score date (Historical or current)
																																	pThreads,										//	Number of threads to use
																																	pRoxieIP										//	Roxie to call
																																);

	Layouts.rScores	tGetScores(dFillScores pInput)	:=	TRANSFORM
		Layouts.rScoring	tGetScoring(RECORDOF(pInput.ModelResults) pModelResults)	:=	TRANSFORM
			Layouts.rScoreReason	tGetScoreReasons(RECORDOF(pModelResults.ReasonCodes)	pReasonCodes)	:=	TRANSFORM
				SELF.Sequence			:=	(INTEGER)pReasonCodes.SeqNo;
				SELF.ReasonCode		:=	pReasonCodes.ReasonCode;
				SELF.Description	:=	pReasonCodes.ReasonCodeDesc;
			END;
			SELF.ScoreReasons	:=	PROJECT(pModelResults.ReasonCodes,tGetScoreReasons(LEFT));
			SELF.Score				:=	(INTEGER)pModelResults.Score;
			SELF.Model_Name		:=	pModelResults.ModelName
		END;
		SELF.Scores			:=	PROJECT(pInput.modelresults,tGetScoring(LEFT));
		SELF.DotID			:=	0;
		SELF.DotScore		:=	0;
		SELF.DotWeight	:=	0;
		SELF.EmpID			:=	0;
		SELF.EmpScore		:=	0;
		SELF.EmpWeight	:=	0;
		SELF.POWID			:=	0;
		SELF.POWScore		:=	0;
		SELF.POWWeight	:=	0;
		SELF.ProxID			:=	0;
		SELF.ProxScore	:=	0;
		SELF.ProxWeight	:=	0;
		SELF						:=	pInput;
	END;

	dGetScores	:=	PROJECT(dFillScores,tGetScores(LEFT));
	
	RETURN	dGetScores;
END;
