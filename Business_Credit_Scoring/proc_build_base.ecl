IMPORT	Business_Credit_Scoring,	Business_Credit,	VersionControl,	STD,	RiskWise;
EXPORT	proc_build_base(	STRING	pVersion	=	(STRING8)STD.Date.Today(),
													INTEGER	pThreads	=	Constants().threads,
													STRING	pRoxieIP	=	Constants().RoxieIP)	:=	MODULE

	EXPORT	dGetUniqueLinkIDs	:=	Business_Credit_Scoring.fn_GetUniqueLinkIDs(
																	pVersion,
																	Business_Credit.Files().LinkIDs(record_type=Business_Credit.Constants().AB AND active));
	SHARED	pSampleSize				:=	5000000;
	EXPORT	dScores1					:=	Business_Credit_Scoring.fn_GetScores(
																	pVersion,
																	CHOOSEN(Files().UniqueLinkIDs,pSampleSize,1),
																	pThreads,
																	pRoxieIP);
	EXPORT	dScores2					:=	Business_Credit_Scoring.fn_GetScores(
																	pVersion,
																	CHOOSEN(Files().UniqueLinkIDs,pSampleSize,pSampleSize+1),
																	pThreads,
																	pRoxieIP);
	EXPORT	dScores3					:=	Business_Credit_Scoring.fn_GetScores(
																	pVersion,
																	CHOOSEN(Files().UniqueLinkIDs,pSampleSize,(pSampleSize*2)+1),
																	pThreads,
																	pRoxieIP);
	EXPORT	dScores4					:=	Business_Credit_Scoring.fn_GetScores(
																	pVersion,
																	CHOOSEN(Files().UniqueLinkIDs,pSampleSize,(pSampleSize*3)+1),
																	pThreads,
																	pRoxieIP);
	EXPORT	dScores5					:=	Business_Credit_Scoring.fn_GetScores(
																	pVersion,
																	CHOOSEN(Files().UniqueLinkIDs,pSampleSize,(pSampleSize*4)+1),
																	pThreads,
																	pRoxieIP);
	EXPORT	dScores6					:=	Business_Credit_Scoring.fn_GetScores(
																	pVersion,
																	CHOOSEN(Files().UniqueLinkIDs,pSampleSize,(pSampleSize*5)+1),
																	pThreads,
																	pRoxieIP);
	EXPORT	dScores7					:=	Business_Credit_Scoring.fn_GetScores(
																	pVersion,
																	CHOOSEN(Files().UniqueLinkIDs,pSampleSize,(pSampleSize*6)+1),
																	pThreads,
																	pRoxieIP);
	EXPORT	dDBTAverage				:=	Business_Credit_Scoring.fn_GetDBTAverage(
																	pVersion,
																	Business_Credit.Files().LinkIDs(record_type=Business_Credit.Constants().AB AND active));
	EXPORT	dScoringIndex	:=	Business_Credit_Scoring.fn_GetScoringIndex(pVersion);

	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).Base.UniqueLinkIDs.new	,dGetUniqueLinkIDs	,Build_UniqueLinkIDs_File		,TRUE);
	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).Base.Scores1.new				,dScores1						,Build_Scores1_File					,TRUE);
	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).Base.Scores2.new				,dScores2						,Build_Scores2_File					,TRUE);
	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).Base.Scores3.new				,dScores3						,Build_Scores3_File					,TRUE);
	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).Base.Scores4.new				,dScores4						,Build_Scores4_File					,TRUE);
	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).Base.Scores5.new				,dScores5						,Build_Scores5_File					,TRUE);
	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).Base.Scores6.new				,dScores6						,Build_Scores6_File					,TRUE);
	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).Base.Scores7.new				,dScores7						,Build_Scores7_File					,TRUE);
	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).Base.DBTAverage.new			,dDBTAverage				,Build_DBTAverage_File			,TRUE);
	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).Out.ScoringIndex.new		,dScoringIndex			,Build_ScoringIndex_File		,TRUE);
                                                                                       
	EXPORT	full_build	:=
				SEQUENTIAL(
					Build_UniqueLinkIDs_File
					,Promote(pversion, 'uniquelinkids').buildfiles.New2Built
					,Promote(pversion, 'uniquelinkids').buildfiles.Built2QA
					,Build_Scores1_File
					,Build_Scores2_File
					,Build_Scores3_File
					,Build_Scores4_File
					,Build_Scores5_File
					,Build_Scores6_File
					,Build_Scores7_File
					,Build_DBTAverage_File
					,Promote(pversion, 'base').buildfiles.New2Built
					,Promote(pversion, 'base').buildfiles.Built2QA
					,Build_ScoringIndex_File
					,Promote(pversion, 'out').buildfiles.New2Built
					,Promote(pversion, 'out').buildfiles.Built2QA
				);

	EXPORT	ALL	:=
	IF(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Business_Credit_Scoring.proc_build_base attribute')
	);
END;