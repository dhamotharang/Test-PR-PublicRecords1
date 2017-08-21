IMPORT	Business_Credit_Scoring,	VersionControl,	ut;

EXPORT	proc_build_keys(	STRING	pVersion	=	ut.GetDate)	:=	MODULE

/*****************/
/*	Build Keys   */
/*****************/
	SHARED	names		:=	keynames(pVersion);

	VersionControl.macBuildNewLogicalKeyWithName(Business_Credit_Scoring.Key_ScoringIndex(pVersion).key,names.ScoringIndex.new,BuildScoringIndexKey);

	EXPORT	full_build	:=
		SEQUENTIAL(
			BuildScoringIndexKey
			,Promote(pVersion,'key').BuildFiles.New2Built
			,Promote(pVersion,'key').BuildFiles.Built2QA
		);

	EXPORT	All	:=
		IF(VersionControl.IsValidVersion(pVersion)
			,full_build
			,OUTPUT('No Valid version parameter passed, skipping Business_Credit_Scoring.proc_build_keys().All attribute')
		);

END;
