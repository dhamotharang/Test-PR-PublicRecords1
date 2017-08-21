IMPORT	BIPV2_Best_SBFE,	Tools,	VersionControl;

EXPORT Build_Keys(STRING	pVersion,
													Constants().buildType	pBuildType	=	Constants().buildType.Daily)	:=	MODULE

	SHARED	bestNames	:=	BIPV2_Best_SBFE.Keynames(pVersion);
	SHARED	isDelta		:=	pBuildType=Constants().buildType.Daily;

	VersionControl.macBuildNewLogicalKeyWithName(BIPV2_Best_SBFE.Key_LinkIds(pVersion,pBuildType).key	,bestNames.LinkIDS.new	,BuildSBFEBestLinkIdsKey);

	EXPORT full_build :=
	SEQUENTIAL(
		BuildSBFEBestLinkIdsKey			
		,Promote(pversion,pIsDeltaBuild:=isDelta).BuildFiles.New2Built
	);
		
	EXPORT All :=
	IF(tools.fun_IsValidVersion(pVersion)
		,full_build
		,OUTPUT('No Valid version parameter passed, skipping BIPV2_Best_SBFE.Build_Keys attribute')
	);

END;