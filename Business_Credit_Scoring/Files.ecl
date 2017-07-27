IMPORT	tools,	ut,	STD;
EXPORT	Files(STRING	pFilename	=	'',
							BOOLEAN	pUseProd	=	FALSE) := MODULE

	EXPORT	DBTAverage			:=	DATASET(
																IF(pFilename='',Filenames(pUseProd:=pUseProd).Base.DBTAverage.QA,pFilename)
																,Business_Credit_Scoring.Layouts.rDBTAverage,THOR,__compressed__);

	EXPORT	Scores					:=	DATASET(
																IF(pFilename='',Filenames(pUseProd:=pUseProd).Base.Scores.QA,pFilename)
																,Business_Credit_Scoring.Layouts.rScores,THOR,__compressed__);

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