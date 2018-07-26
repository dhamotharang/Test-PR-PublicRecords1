import tools, _control;

export Proc_Build_All(

	 string																		pversion
	,string																		pDirectory	= '/data/hds_180/targus/pure_business_iyp_cp/data/' + pversion  + '/'
	,string																		pServerIP		= _control.IPAddress.bctlpedata11
	,string																		pFilename		= 'IYP_*.dat*'
	,string																		pGroupName	= constants().groupname																		
	,boolean																	pIsTesting	= Constants().IsTesting
	,boolean																	pOverwrite	= false																															
	,dataset(Layout_YellowPages							)	pUpdateFile	= Files().Input.Using
	,dataset(Layout_YellowPages_Base_V2_BIP	)	pBaseFile		= Files().Base.QA

) :=
module

	export spray_files := if(
			pDirectory != ''
	and not(			_Flags.ExistCurrentSprayed
			)
	, fSpray_Inputfile(
		 pversion
		,pDirectory 
		,pServerIP	
		,pFilename	
		,pGroupName
		,
		,pOverwrite

	));
	
	export full_build := sequential(
		 Create_Supers
		,spray_files
		,Promote().Inputfiles.Sprayed2Using
		,Check_4_New_Fields()
		,Proc_Build_Base(pversion,pUpdateFile,pBaseFile)
		,proc_build_autokeys(pversion)
		,proc_build_keys(pversion)
		,Query_YellowPages_State_Stats()
		,strata_popYellowpages_files_base_qa(pversion,pIsTesting,pOverwrite)
		,strata_asBusinessHeaderStats(pversion,pIsTesting,pOverwrite)
		,Promote().buildfiles.Built2QA
		,Promote().Inputfiles.Using2used
		,QA_samples(pversion,pIsTesting,pOverwrite)

	) : success(Send_Emails(pversion).Roxie), failure(send_emails(pversion).buildfailure);
	
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping YellowPages.Proc_Build_All')
	);

end;