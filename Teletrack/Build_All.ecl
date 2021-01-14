import versioncontrol, _control, Orbit3;

export Build_All(

	 string		pversion
	,string		pDirectory							= '/data/data_build_1/teletrack/build'
	,string		pServerIP								= _control.IPAddress.bctlpedata11
	,string		pFile										= '*TT_LN_*.TXT'  
	,string		pGroupName							= _dataset().groupname																		
	,boolean	pIsTesting							= false
	,boolean	pOverwrite							= false																															

) :=
module

	export spray_files := if(pDirectory != '', fSprayFiles(
		 pServerIP
		,pDirectory 
		,pFile
		,pversion
		,pGroupName
		,pIsTesting
		,pOverwrite

	));
	
	updateorbit := Orbit3.Proc_Orbit3_CreateBuild('Teletrack',(pversion));
	
	
	export full_build := sequential(
		 create_supers
		,spray_files
		,Build_Base(pversion).all
		,Build_Keys(pversion).all
		,Promote(pversion).buildfiles.Built2QA
		,Strata_Population_Stats(pversion).all
		,QA_Records
		,updateorbit
	) : success(Send_Email(pversion,, not pIsTesting).BuildSuccess), failure(send_email(pversion,, not pIsTesting).buildfailure);
	
	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Teletrack.Build_All')
	);

end;