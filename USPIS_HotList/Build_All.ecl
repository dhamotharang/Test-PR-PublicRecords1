import versioncontrol, _control;

export Build_All(

	 string		pversion
	,string		pDirectory							= '/prod_data_build_13/eval_data/uspis_address_inspection_list/'
	,string		pServerIP								= _control.IPAddress.edata10
	,string		pFilename								= 'all.csv'
	,string		pGroupName							= _dataset().groupname																		
	,boolean	pIsTesting							= false
	,boolean	pOverwrite							= true																															

) :=
module

	export spray_files := if(pDirectory != '', fSprayFiles(
		 pversion
		,pServerIP
		,pDirectory 
		,pFilename
		,pGroupName
		,pIsTesting
		,pOverwrite

	));
	
	shared dAll_filenames := filenames().dAll_filenames;

	export full_build := sequential(
		 versioncontrol.mUtilities.createsupers(dAll_filenames)
		,spray_files
		,Build_Base(pversion,pOverwrite).all
		,Build_Keys(pversion,pOverwrite).all
		,Out_Base_Stats_Population(pVersion)
		,Promote().Built2QA

	) : success(Send_Emails(pversion).buildsuccess), failure(send_emails(pversion).buildfailure);
	
	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping USPIS_HotList.Build_All')
	);

end;