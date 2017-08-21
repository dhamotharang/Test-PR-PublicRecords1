IMPORT	PRTE2_Common,	Business_Credit_Scoring,	ut;

EXPORT	SBFECVScoring	:=	MODULE

	SHARED	lSubDirName					:=	'';
	SHARED	lCSVVersion					:=	ut.GetDate;
	SHARED	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
	EXPORT	rthor_data400__key__SBFECVScoring__scoringindex	:=	RECORD
		RECORDOF(Business_Credit_Scoring.Key_ScoringIndex().key);
	END;
	
	EXPORT	dthor_data400__key__SBFECVScoring__scoringindex	:=	DATASET([], rthor_data400__key__SBFECVScoring__scoringindex);

END;
