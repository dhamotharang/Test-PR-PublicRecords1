IMPORT	_control,	 PRTE_CSV,	Business_Credit_Scoring,	PRTE2_Common;

EXPORT	Proc_Build_SBFECVScoring_Keys(string pIndexVersion, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
	
	is_running_in_prod		:=	PRTE2_Common.Constants.is_running_in_prod;
	doDOPS								:=	is_running_in_prod AND NOT skipDOPS;
	lPRTEkeyTemplate			:=	'~prte::key::'+Business_Credit_Scoring._Dataset().name+'::'+pIndexVersion+'::';
	
	rKeySBFECVScoring__scoringindex__key	:= RECORD
		PRTE_CSV.SBFECVScoring.rthor_data400__key__SBFECVScoring__scoringindex;
	END;
                                                       
	dKeySBFECVScoring__scoringindex__key	:= 	PROJECT(PRTE_CSV.SBFECVScoring.dthor_data400__key__SBFECVScoring__scoringindex, rKeySBFECVScoring__scoringindex__key);	
	kKeySBFECVScoring__scoringindex__key	:=	INDEX(dKeySBFECVScoring__scoringindex__key, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dKeySBFECVScoring__scoringindex__key}, lPRTEkeyTemplate + Business_Credit_Scoring.Keynames().lscoringindex);
	
	//---------- making DOPS optional and only in PROD build -------------------------------													
	notifyEmail 						:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 								:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');						
	PerformUpdate 					:= PRTE.UpdateVersion('SbfeCvScoringKeys',			//	Package name
																								pIndexVersion,						//	Package version
																								notifyEmail,							//	Who to email with specifics
																								'B',											//	B = Boca, A = Alpharetta
																								'N',											//	N = Non-FCRA, F = FCRA
																								'N'												//	N = Do not also include boolean, Y = Include boolean, too
																								);
	PerformUpdateOrNot 			:= IF(doDOPS,PerformUpdate,NoUpdate);

	RETURN	SEQUENTIAL(	BUILD(kKeySBFECVScoring__scoringindex__key, UPDATE),
											PerformUpdateOrNot);

END;
