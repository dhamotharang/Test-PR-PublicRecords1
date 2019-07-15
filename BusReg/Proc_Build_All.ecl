import versioncontrol, _control, orbit3;

export proc_Build_All(

	 string		pversion
	,string		pDirectory					= '/data/prod_data_build_10/production_data/business_headers/accutrend/in/'
	,string		pServerIP						= _control.IPAddress.bctlpedata11
	,string		pFilename						= '*txt'
	,string		pGroupName					= _dataset().groupname																		
	,boolean	pIsTesting					= false
	,boolean	pOverwrite					= false	
	,boolean	pShouldDkcKeys	= true
	,string  PEmailList     = Email_Notification_Lists.ScrubsPlus     
) :=
module

	lfileversion	:= regexreplace('^.*?/([^/]*)[/]?$', pDirectory, '$1');

	export spray_files := if(pDirectory != '', fSprayFiles(
		 pServerIP
		,pDirectory 
		,pFilename 
		,pversion
		,pGroupName
		,pIsTesting
		,pOverwrite
		,PEmailList
	));
	
	shared dAll_filenames := filenames().dAll_filenames + keynames().dAll_filenames;
	
	orbit_update := Orbit3.proc_Orbit3_CreateBuild_AddItem('Business Registrations',pversion,'N');

	export full_build := sequential(
		 versioncontrol.mUtilities.createsupers(dAll_filenames)
		,spray_files
		,proc_Build_Base(pversion).all
		,proc_Build_Keys(pversion).all
		,orbit_update
		,Promote().Built2QA
		,Out_Population_Stats(pversion).All			
		,Query_Population_Stats 
		,Strata_Population_Stats(pversion).all
		,Query_State_Stat
		,output(topn(Files().Base.full.qa(bdid > 0), 100, -dt_last_seen))
     
	) : success(Send_Email(pversion).Roxie), failure(send_email(pversion).buildfailure);
	
	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping BusReg.Proc_Build_All')
	) : success(Send_Email(pversion).Buildsuccess);

end;
