import versioncontrol, _control;

export Build_All(

	 string		pversion
	,string		pDirectory							= '/prod_data_build_13/eval_data/sprint_badl/'
	,string		pServerIP								= _control.IPAddress.edata10
	,string		pFilename								= 'LN*IN'
	,string		pEmailAddress						= ''
	,string		pGroupName							= _dataset().groupname																		
	,boolean	pIsTesting							= false
	,boolean	pOverwrite							= false																															

) :=
module

	export spray_files := if(pDirectory != '', fSprayFiles(
		 pServerIP
		,pDirectory 
		,pFilename 
		,pversion
		,pGroupName
		,pIsTesting
		,pOverwrite

	));
	
	shared dAll_filenames := filenames().dAll_filenames;

	export full_build := sequential(
	
		 versioncontrol.mUtilities.createsupers(dAll_filenames)
		,spray_files
		,Build_Base(pversion,pOverwrite).all
		,Promote().Base.Built2QA
		,fDesprayFiles(pversion,pServerIP,pDirectory,pOverwrite)

	) : success(Send_Emails(pversion,pEmailAddress).BuildSuccess), failure(send_emails(pversion,pEmailAddress).buildfailure);
	
	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Sprint_BADL.Build_It')
	);

end;