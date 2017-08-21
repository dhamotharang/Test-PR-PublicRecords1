IMPORT	AID_Build,	VersionControl,	STD;

EXPORT	proc_build_keys(STRING	pVersion							=	(STRING8)Std.Date.Today(),
												BOOLEAN	pUseOtherEnvironment	=	FALSE)	:=	MODULE

/*****************/
/*	Build Keys   */
/*****************/

	VersionControl.macBuildNewLogicalKeyWithName(AID_Build.Key_AID_Base_AddressLookup(pVersion,pUseOtherEnvironment,FALSE)	,AID_Build.Keynames(pVersion,pUseOtherEnvironment,FALSE).Addrline1_Addrlinelast.new,	BuildBaseAddressLookup);
	VersionControl.macBuildNewLogicalKeyWithName(AID_Build.Key_AID_Base_AddressLookup(pVersion,pUseOtherEnvironment,TRUE)		,AID_Build.Keynames(pVersion,pUseOtherEnvironment,TRUE).Addrline1_Addrlinelast.new,		BuildBaseAddressLookupFCRA);

	EXPORT	full_build	:=
		SEQUENTIAL(
			PARALLEL(
				BuildBaseAddressLookup
				// ,BuildBaseAddressLookupFCRA	//	FCRA
			)
			,Promote(pVersion,'key').BuildFiles.New2Built
			,Promote(pVersion,'key').BuildFiles.Built2QA
		);

	EXPORT	All	:=
		IF(VersionControl.IsValidVersion(pVersion)
			,full_build
			,OUTPUT('No Valid version parameter passed, skipping AID_Build.proc_build_keys().All attribute')
		);

END;
