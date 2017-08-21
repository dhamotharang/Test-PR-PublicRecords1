import versioncontrol, _control;

export Build_All(

	 string		pversion
	,string		pDirectory							= '/hds_2/cp_utility'
	,string		pServerIP								= _control.IPAddress.edata12
	,string		pFileEntityCur					= '*entity*firm*current*out'  
	,string		pFileSVCAddCur					= '*svcaddr*firm*current*out' 
	,string		pFileEntityHis					= '*entity*firm*history*out'  
	,string		pFileSVCAddHis					= '*svcaddr*firm*history*out' 
	,string		pGroupName							= _dataset().groupname																		
	,boolean	pIsTesting							= false
	,boolean	pOverwrite							= false																															

) :=
module

	export spray_files := if(pDirectory != '', fSprayFiles(
		 pServerIP
		,pDirectory 
		,pFileEntityCur
		,pFileSVCAddCur
		,pFileEntityHis
		,pFileSVCAddHis
		,pversion
		,pGroupName
		,pIsTesting
		,pOverwrite

	));
	
	shared dAll_filenames := filenames().dAll_filenames;

	export full_build := sequential(
		 versioncontrol.mUtilities.createsupers(dAll_filenames)
		,spray_files
		,Build_Base(pversion).all
	) : success(Send_Emails(pversion).BuildSuccess), failure(send_emails(pversion).buildfailure);
	
	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Utility_Business.Build_All')
	);

end;