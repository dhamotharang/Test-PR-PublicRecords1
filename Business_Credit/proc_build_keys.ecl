IMPORT	Business_Credit,	BIPV2_Best_SBFE,	VersionControl,	Tools,	ut;

EXPORT	proc_build_keys(STRING	pVersion,
												Constants().buildType	pBuildType	=	Constants().buildType.Daily)	:=	MODULE

/*****************/
/*	Build Keys   */
/*****************/
	SHARED	names			:=	keynames(pVersion);
	SHARED	bestNames	:=	BIPV2_Best_SBFE.Keynames(pVersion);
	SHARED	isDelta		:=	pBuildType=Constants().buildType.Daily;

	VersionControl.macBuildNewLogicalKeyWithName(Business_Credit.key_history(pVersion,pBuildType)												,names.History.new							,BuildHistoryKey);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Credit.key_tradeline(pVersion,pBuildType)											,names.Tradeline.new						,BuildTradelineKey);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Credit.Key_TradelineGuarantor(pVersion,pBuildType).key				,names.TradelineGuarantor.new		,BuildTradelineGuarantorKey);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Credit.Key_BusinessOwner(pVersion,pBuildType)									,names.BusinessOwner.new				,BuildBusinessOwnerKey);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Credit.Key_Collateral(pVersion,pBuildType)										,names.Collateral.new						,BuildCollateralKey);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Credit.Key_IndividualOwner(pVersion,pBuildType)								,names.IndividualOwner.new			,BuildIndividualOwnerKey);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Credit.Key_MasterAccount(pVersion,pBuildType)									,names.MasterAccount.new				,BuildMasterAccountKey);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Credit.Key_MemberSpecific(pVersion,pBuildType)								,names.MemberSpecific.new				,BuildMemberSpecificKey);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Credit.Key_BusinessClassification(pVersion,pBuildType)				,names.BIClassification.new			,BuildBIClassificationKey);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Credit.Key_BusinessInformation(pVersion,pBuildType)						,names.BusinessInformation.new	,BuildBusinessInformationKey);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Credit.Key_BusinessOwnerInformation(pVersion,pBuildType).key	,names.BOInformation.new				,BuildBOInformationKey);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Credit.Key_IndividualOwnerInformation(pVersion,pBuildType)		,names.IOInformation.new				,BuildIOInformationKey);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Credit.Key_LinkIds(pVersion,pBuildType).key										,names.LinkIDS.new							,BuildLinkIdsKey);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Credit.Key_ReleaseDates(pVersion,pBuildType)									,names.ReleaseDate.new					,BuildReleseDatesKey);
	//	SBFE Best Key
	VersionControl.macBuildNewLogicalKeyWithName(BIPV2_Best_SBFE.Key_LinkIds(pVersion,pBuildType).key										,bestNames.LinkIDS.new					,BuildSBFEBestLinkIdsKey);

	EXPORT	full_build	:=
		SEQUENTIAL(
			PARALLEL(
				BuildHistoryKey
				,BuildTradelineKey
				,BuildTradelineGuarantorKey
				,BuildBusinessOwnerKey
				,BuildCollateralKey
				,BuildIndividualOwnerKey
				,BuildMasterAccountKey
				,BuildMemberSpecificKey
				,BuildBIClassificationKey
				,BuildBusinessInformationKey
				,BuildBOInformationKey
				,BuildIOInformationKey
				,BuildLinkIdsKey	
				,BuildReleseDatesKey
				,BuildSBFEBestLinkIdsKey	//	Build SBFE Best Key
			)
			,Promote(pVersion,'key',pIsDeltaBuild:=isDelta).BuildFiles.New2Built
			,Promote(pVersion,'key',pIsDeltaBuild:=isDelta).BuildFiles.Built2QA
			//	Promote SBFE Best Key
			,BIPV2_Best_SBFE.Promote(pVersion,'key',pIsDeltaBuild:=isDelta).BuildFiles.New2Built
			,BIPV2_Best_SBFE.Promote(pVersion,'key',pIsDeltaBuild:=isDelta).BuildFiles.Built2QA
		);

	EXPORT	All	:=
		IF(VersionControl.IsValidVersion(pVersion)
			,full_build
			,OUTPUT('No Valid version parameter passed, skipping Business_Credit.proc_build_keys().All attribute')
		);

END;
