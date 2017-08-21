import RoxieKeyBuild, business_header, strata, _control,VersionControl, Orbit3;

	
	export Proc_Build_All(

	 string		pversion
	,string		pDirectory							= '/data/thor_back5/bbb/build/'
	,string		pServerIP								= _control.IPAddress.bctlpedata10
	,string		pMemberFilename					= 'member*xml.out'
	,string		pNonMemberFilename			= 'nonmember*xml.out'
	,string		pGroupName							= _dataset().groupname																		
	,boolean	pIsTesting							= false
	,boolean	pOverwrite							= false																															

) := 
module

	export orbitUpdate := Orbit3.proc_Orbit3_CreateBuild('BBB',pversion,'N');

	export spray_files := 
	if(pDirectory != '' 
			and not(_Flags.ExistCurrentMemberSprayed and _Flags.ExistCurrentNonMemberSprayed)
		,fSpray_InputFiles(
			 pDirectory							
			,pServerIP					
			,pMemberFilename		
			,pNonMemberFilename
			,pGroupName				
			,pIsTesting				
			,pOverwrite				
		));

	export full_build := sequential(
		 spray_files
		,Proc_Build_Base(pversion).all
		,Proc_Build_Keys(pversion).all
		,Promote().built2qa
		,send_emails(pversion).roxie.qa
		,Strata_Population_Stats(pversion).all
		,Query_Build_Stats
		,Query_New_Records
		,orbitUpdate
	) : success(send_emails(pversion).BuildSuccess), failure(send_emails(pversion).BuildFailure);
		
	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping BBB2.Proc_Build_All')
	);

end;