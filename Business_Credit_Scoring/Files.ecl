IMPORT	tools,	ut,	STD,	Business_Risk_BIP;
EXPORT	Files(STRING	pFilename	=	'',
							BOOLEAN	pUseProd	=	FALSE) := MODULE

	EXPORT	UniqueLinkIDs		:=	DATASET(
																IF(pFilename='',Filenames(pUseProd:=pUseProd).Base.UniqueLinkIDs.QA,pFilename)
																,Business_Risk_BIP.Layouts.Input,THOR,__compressed__);

	EXPORT	Scores1					:=	DATASET(
																IF(pFilename='',Filenames(pUseProd:=pUseProd).Base.Scores1.QA,pFilename)
																,Business_Credit_Scoring.Layouts.rScores,THOR,__compressed__);

	EXPORT	Scores2					:=	DATASET(
																IF(pFilename='',Filenames(pUseProd:=pUseProd).Base.Scores2.QA,pFilename)
																,Business_Credit_Scoring.Layouts.rScores,THOR,__compressed__);

	EXPORT	Scores3					:=	DATASET(
																IF(pFilename='',Filenames(pUseProd:=pUseProd).Base.Scores3.QA,pFilename)
																,Business_Credit_Scoring.Layouts.rScores,THOR,__compressed__);

	EXPORT	Scores4					:=	DATASET(
																IF(pFilename='',Filenames(pUseProd:=pUseProd).Base.Scores4.QA,pFilename)
																,Business_Credit_Scoring.Layouts.rScores,THOR,__compressed__);

	EXPORT	Scores5					:=	DATASET(
																IF(pFilename='',Filenames(pUseProd:=pUseProd).Base.Scores5.QA,pFilename)
																,Business_Credit_Scoring.Layouts.rScores,THOR,__compressed__);

	EXPORT	Scores6					:=	DATASET(
																IF(pFilename='',Filenames(pUseProd:=pUseProd).Base.Scores6.QA,pFilename)
																,Business_Credit_Scoring.Layouts.rScores,THOR,__compressed__);

	EXPORT	Scores7					:=	DATASET(
																IF(pFilename='',Filenames(pUseProd:=pUseProd).Base.Scores7.QA,pFilename)
																,Business_Credit_Scoring.Layouts.rScores,THOR,__compressed__);

	EXPORT	Scores					:=	Scores1
															+Scores2
															+Scores3
															+Scores4
															+Scores5
															+Scores6
															+Scores7;

	EXPORT	DBTAverage			:=	DATASET(
																IF(pFilename='',Filenames(pUseProd:=pUseProd).Base.DBTAverage.QA,pFilename)
																,Business_Credit_Scoring.Layouts.rDBTAverage,THOR,__compressed__);

	EXPORT	ScoringIndex		:=	IF(pFilename<>'',
																	DATASET(pFilename,Layouts.rScoringIndex,THOR,__compressed__),
																	IF(NOTHOR(STD.File.GetSuperFileSubCount(Filenames(pUseProd:=pUseProd).out.ScoringIndex.QA) <> 0),
																		DATASET(Filenames(pUseProd:=pUseProd).out.ScoringIndex.QA,Layouts.rScoringIndex,THOR,__compressed__),
																		DATASET([],Layouts.rScoringIndex)
																	)
															);

															//	This is a Persist file which is used to Calucualte DBT.
	EXPORT	TradelineDBT		:=	DATASET(PersistNames.TradelineDBT,Layouts.rTradelineDBT,THOR,__compressed__);
	
END;