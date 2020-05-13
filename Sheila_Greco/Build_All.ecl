import tools, _control ,RoxieKeyBuild, Orbit3, scrubs, scrubs_Sheila_greco;

export Build_All(

	 string		pversion
	,string		pDirectory							= ''
	,string		pServerIP								= _control.IPAddress.bctlpedata10
	,string		pFilename								= '*xml'
	,string		pGroupName							= _Constants().groupname																		
	,boolean	pIsTesting							= false
	,boolean	pOverwrite							= false																															

) :=
module

	lfileversion	:= regexreplace('^.*?/([^/]*)[/]?$', pDirectory, '$1');

	export spray_files := if(pDirectory != '', fSprayFiles(
		 pServerIP
		,pDirectory 
		,pFilename 
		,lfileversion
		,pGroupName
		,pIsTesting
		,pOverwrite

	));

	Build_Companies := Build_File(pversion,Companies	,'Companies'	);
	Build_Contacts	:= Build_File(pversion,Contacts	  ,'Contacts'		);
	
	orbit_update := Orbit3.proc_Orbit3_CreateBuild_AddItem('Sheila Greco',(string)pversion,'N');

	run_scrubs := Scrubs_Sheila_Greco.Fn_RunScrubs(pversion);

	build_keys := IF(Scrubs.mac_ScrubsFailureTest('Scrubs_Sheila_Greco_Contacts,Scrubs_Sheila_Greco_Companies',pversion),Proc_Build_Keys(pversion).all ,OUTPUT('Key update failed due to Scrubs reject warnings',NAMED('Key_Status')));
	
	export full_build := sequential(
		 Create_Supers
		,spray_files
		,Promote().Inputfiles.Sprayed2Using
		,Build_Companies.All
		,Build_Contacts.All
		,run_scrubs
		,Promote().inputfiles.Using2Used
		,Promote().buildfiles.Built2QA
		,build_keys
		,Promote().buildfiles.Built2QA
		,QA_Records
		,Strata_Population_Stats(pversion).all
		,Statistics().all
		,orbit_update
		
	) : success(send_email(pversion,,not pIsTesting and not _Constants().IsDataland).roxie), failure(send_email(pversion).buildfailure);
	  
	
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Sheila_Greco.Build_All')
	);

end;