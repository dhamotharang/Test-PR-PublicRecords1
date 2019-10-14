IMPORT	VersionControl,	Tools,	ut;

EXPORT	proc_build_keys(STRING	pVersion,
												Constants.buildType	pBuildType	=	Constants.buildType.Daily)	:=	MODULE

/*****************/
/*	Build Keys   */
/*****************/
	SHARED	names			:=	keynames(pVersion);
	SHARED	bestNames	:=	gateway_collection_log.Keynames(pVersion);
	SHARED	isDelta		:=	pBuildType=Constants.buildType.Daily;

	VersionControl.macBuildNewLogicalKeyWithName(gateway_collection_log.KeyPrep_GatewayCollectionlog_DID(pVersion,pBuildType),
	                                             names.kGatewayCollectionDid.new,BuildGatewayCollectionKey);

	EXPORT	full_build	:=
		                    SEQUENTIAL( BuildGatewayCollectionKey
			                             ,Promote(pVersion,'key',pIsDeltaBuild:=isDelta).BuildFiles.New2Built
			                             ,Promote(pVersion,'key',pIsDeltaBuild:=isDelta).BuildFiles.Built2QA
	                              	);

	EXPORT	All	:=
		IF(VersionControl.IsValidVersion(pVersion)
			,full_build
			,OUTPUT('No Valid version parameter passed, skipping GatewaycollectionLogs.proc_build_keys().All attribute')
		);

END;
