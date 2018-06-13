import versioncontrol, paw, corp2, Business_Header_BDL2;

export Stats(

	 string																						pversion
	,dataset(Layout_Business_Header_Base						) pBh										= files().base.business_headers.built
	,dataset(Layout_Business_Header_Base						) pBh_father						= files().base.business_headers.qa
	,dataset(Layout_SIC_Code												) pSic_Code							= Persists().BHBDIDSIC
	,dataset(Layout_Business_Contact_Full_new				)	pBc										= files().base.business_contacts.built	//during a build, this will house the new base file
	,dataset(Layout_Business_Contact_Full_new				)	pBc_father						= files().base.business_contacts.qa			//during a build, this will house the previous base file
	,dataset(Layout_BH_Super_Group									) pSg										= files().base.Super_Group.built
	,dataset(corp2.Layout_Corporate_Direct_Corp_Base)	pInactiveCorps				= PAW.fCorpInactives(pPersistname	:= paw.persistnames().f_CorpInactives + '::stats')
	,unsigned8																				pmax_rcid							= max_rcid()
	,dataset(Layout_Business_Header_Temp						)	pBH_Basic_Match_FEIN	= persists().BHBasicMatchFEIN
	,dataset(Layout_Business_Header_Temp						)	pBH_Basic_Match_SALT	= persists().BHBasicMatchSALT
	,dataset(Layout_Business_Header_Temp						)	pBH_Match_Init				= persists().BHMatchInit
	//,dataset(Layout_SIC_Code												) pSic_Code							= Persists().BHBDIDSIC									
	,dataset(Layout_BDL2														) pBDL									= files().base.bdl2.built
	,boolean																					pOverwrite						= false

) :=
module

	shared bh_stats		:= Business_Header.fStatistics.business_headers		(pbh,pBh_father,pversion,pmax_rcid,pInactiveCorps,pBH_Basic_Match_FEIN,pBH_Basic_Match_SALT,pBH_Match_Init,pSic_Code);
	shared bc2_stats	:= Business_Header.fStatistics.business_contacts	(pbc,pbc_father,pversion);
	shared sg_stats 	:= Business_Header.fStatistics.super_group				(pSg,pversion);
	
	shared all_stats	:= Business_Header.fStatistics.all(pversion,pbh, pBh_father,pbc,pbc_father, psg,pInactiveCorps,pmax_rcid,pBH_Basic_Match_FEIN,pBH_Basic_Match_SALT,pBH_Match_Init,pSic_Code);
	shared BDL_stats 	:= Business_Header_BDL2.fStatistics.BDL						(pBDL,pversion);
	
	shared names := filenames(pversion).stat;
	
	VersionControl.macBuildNewLogicalFile( names.Search.new			,bh_stats		,BuildSearchStats			,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile( names.Contacts.new		,bc2_stats	,BuildContactsStats		,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile( names.SuperGroup.new	,sg_stats		,BuildSuperGroupStats	,,,pOverwrite);

	VersionControl.macBuildNewLogicalFile( names.all_files.new	,all_stats	,BuildAllStats				,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile( names.BDL.new				,BDL_stats	,BuildBDLStats				,,,pOverwrite);
	
	
	export all_files :=
	sequential(
		 BuildAllStats
		,promote(pversion, '::stats::',pClearSuperFirst := false).new2qa
	);
	
	export search_stats :=
	sequential(
		 BuildSearchStats
		,promote(pversion, '::stats::',pClearSuperFirst := false).new2qa
	);

	export contacts_stats :=
	sequential(
		 BuildContactsStats
		,promote(pversion, '::stats::',pClearSuperFirst := false).new2qa
	);

	export supergroup_stats :=
	sequential(
		 BuildSuperGroupStats
		,promote(pversion, '::stats::',pClearSuperFirst := false).new2qa
	);
	
	export BDL2_stats :=
	sequential(
		 BuildBDLStats
		,promote(pversion, '::stats::',pClearSuperFirst := false).new2qa
	);
	
	export all_separate_files :=
	sequential(
		 BuildSearchStats			
		,BuildContactsStats		
		,BuildSuperGroupStats	
		,BuildBDLStats	
		,promote(pversion, '::stats::',pClearSuperFirst := false).new2qa
	);

end;