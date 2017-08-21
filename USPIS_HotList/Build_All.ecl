import versioncontrol, _control;

export Build_All(

	 string		pversion
	,string		pDirectory							= '/hds_180/uspis_hotlist/out'
	,string		pServerIP								= _control.IPAddress.edata12
	,string		pFilename								= 'all*csv'
	,string		pGroupName							= _dataset().groupname																		
	,boolean	pIsTesting							= false
	,boolean	pOverwrite							= true																															
	,boolean	pSkipUSPIS							= false

) :=
module

	export spray_files := 
	if(			pDirectory																											!= '' 
			and count(nothor(fileservices.superfilecontents(Filenames().Input.using))) 	 = 0
		,fSprayFiles(
			 pversion
			,pServerIP
			,pDirectory 
			,pFilename
			,pGroupName
			,pIsTesting
			,pOverwrite
		));
	
	export Build_USPIS := sequential(
		 Create_Supers()
		,spray_files
		,Build_Base(pversion,pOverwrite).all
		,Build_Keys(pversion,pOverwrite).all
		,Out_Base_Stats_Population(pVersion)
		,Promote().Built2QA
		,Promote().using2used

	) : success(Send_Emails(pversion).buildsuccess), failure(send_emails(pversion).buildfailure);
	
	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,if(pSkipUSPIS = false
				,Build_USPIS
				,Rename_Keys(pversion,false)
		)
		,output('No Valid version parameter passed(' + pversion + '), skipping USPIS_HotList.Build_All')
	);

end;