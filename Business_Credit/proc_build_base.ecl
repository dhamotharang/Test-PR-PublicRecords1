IMPORT	Business_Credit,	BIPV2_Best_SBFE,	BIPV2_Best,	BIPV2_Best_Proxid,	BIPV2,	
				VersionControl,	ut, STD;
EXPORT	proc_build_base(STRING	pVersion	,
												Constants().buildType	pBuildType	=	Constants().buildType.Daily)	:=	MODULE

																// Denormalized new file.  Add it to the other Denormalized records.
																// That becomes our new base file.
	EXPORT	dDenormalized			:=	Business_Credit.fn_ProcessSBFEFile(Filenames(pVersion).Input.Using,pVersion)+
																Business_Credit.Files().Denormalized;
	EXPORT	dPreviousDenorm		:=	Business_Credit.Files().Denormalized;
	EXPORT	dActive						:=	Business_Credit.fn_setRecordStatus(pVersion,pBuildType);
	EXPORT	dLinkIds					:=	Business_Credit.fn_linkSBFEFile(pVersion,pBuildType);
	EXPORT	dBIClassification	:=	Business_Credit.fn_GetSegments.BIClassification;
	EXPORT	dBusinessOwner		:=	Business_Credit.fn_GetSegments.businessOwner;
	EXPORT	dCollateral				:=	Business_Credit.fn_GetSegments.collateral;
	EXPORT	dHistory					:=	Business_Credit.fn_GetSegments.history;
	EXPORT	dIndividualOwner	:=	Business_Credit.fn_GetSegments.individualOwner;
	EXPORT	dMasterAccount		:=	Business_Credit.fn_GetSegments.masterAccount;
	EXPORT	dMemberSpecific		:=	Business_Credit.fn_GetSegments.memberSpecific;
	EXPORT  dReleaseDate			:=	Business_Credit.fn_ReleaseDates(pversion);

	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).Base.denormalized.new			,dDenormalized			,Build_Denormalized_File			,TRUE);
	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).Base.denormalized.new			,dPreviousDenorm		,Previous_Denormalized_File		,TRUE);
	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).out.active.new						,dActive						,Build_Active_File						,TRUE);
	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).out.linkids.new						,dLinkIds						,Build_LinkIDs_File						,TRUE);
	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).out.BIClassification.new	,dBIClassification	,Build_BIClassification_File	,TRUE);
	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).out.businessOwner.new			,dBusinessOwner			,Build_BusinessOwner_File			,TRUE);
	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).out.collateral.new				,dCollateral				,Build_Collateral_File				,TRUE);
	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).out.history.new						,dHistory						,Build_History_File						,TRUE);
	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).out.individualOwner.new		,dIndividualOwner		,Build_IndividualOwner_File		,TRUE);
	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).out.masterAccount.new			,dMasterAccount			,Build_MasterAccount_File			,TRUE);
	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).out.memberSpecific.new		,dMemberSpecific		,Build_MemberSpecific_File		,TRUE);
  VersionControl.macBuildNewLogicalFile(Filenames(pVersion).out.releasedate.new				,dReleaseDate				,Build_ReleaseDate_File				,TRUE);
	
	//	SBFE Best Key Base Files
	// SHARED	dHrchyBase		:=	PROJECT(BIPV2_Best_SBFE.CommonBase.DS_SBFE_CLEAN,BIPV2.CommonBase.Layout);
	// SHARED	pInBase				:=	BIPV2_Best.In_Base(dHrchyBase).For_Proxid;
	// SHARED	sInBase				:=	BIPV2_Best.In_Base(dHrchyBase).For_Seleid;
	// SHARED	dBestSBFEFile	:=	BIPV2_Best.fn_Prep_for_Base(pInBase,sInbase,,,dHrchyBase);
  // VersionControl.macBuildNewLogicalFile(BIPV2_Best_SBFE.Filenames(pVersion).Base.bipv2_best.new	,dBestSBFEFile	,Build_SBFEBest_File	,TRUE);
                                                                                      
	EXPORT	full_build	:=
				SEQUENTIAL(
					IF(NOTHOR( STD.File.GetSuperFileSubCount(Filenames(pVersion).Input.Sprayed)
              +	STD.File.GetSuperFileSubCount(Filenames(pVersion).Input.Using))>0,
						SEQUENTIAL(
							Promote(pversion).inputfiles.Sprayed2Using
							,Build_Denormalized_File
							,Promote(pversion).Inputfiles.Using2Used
						),
						//	In event we have to ROLLBACK it's safer to copy yesterday's file with today's filedate.
						SEQUENTIAL(
							Previous_Denormalized_File
						)
					)
					,Promote(pversion, 'base').buildfiles.New2Built
					,Promote(pversion, 'base').buildfiles.Built2QA	
					,Build_Active_File
					,Promote(pversion, 'active').buildfiles.New2Built
					,Promote(pversion, 'active').buildfiles.Built2QA
					,Build_LinkIDs_File
					,Build_BIClassification_File
					,Build_BusinessOwner_File
					,Build_Collateral_File
					,Build_History_File	
					,Build_IndividualOwner_File	
					,Build_MasterAccount_File
					,Build_MemberSpecific_File
					,Build_ReleaseDate_File
					,Promote(pversion, 'out').buildfiles.New2Built
					,Promote(pversion, 'out').buildfiles.Built2QA
					//	Build SBFE Best Key Base Files.  Only build the base files during a Full Build.
					// ,IF(pBuildType	<>	Constants().buildType.Daily,
						// SEQUENTIAL(
							// Build_SBFEBest_File
							// ,BIPV2_Best_Proxid.Keys(pInBase).BuildData
							// ,BIPV2_Best_SBFE.Promote(pVersion).buildfiles.New2Built
						// )
					// )
				);

	EXPORT	ALL	:=
	IF(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Business_Credit.proc_build_base().All attribute')
	);
END;