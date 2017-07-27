import versioncontrol, _control;

export Build_All(

	 string		pversion
	,string		pDirectory							= '/prod_data_build_10/production_data/business_headers/martindale_hubbell/data/'
	,string		pServerIP								= _control.IPAddress.edata10
	,string		pFilename								= '2*xml'
	,string		pGroupName							= _dataset().groupname																		
	,boolean	pIsTesting							= false
	,boolean	pOverwrite							= false																															
	,boolean	pSkipStrata							= false																															

) :=
module

	lfileversion	:= regexreplace('^.*?/([^/]*)[/]?$', pDirectory, '$1');

	export spray_files := if(
				pDirectory																											!= '' 
		and count(NOTHOR(fileservices.superfilecontents(Filenames().Input.using)))   = 0
		,fSprayFiles(
			 lfileversion
			,pDirectory
			,pServerIP	
			,pFilename	
			,pGroupName
			,pIsTesting
			,pOverwrite
	));

	Build_File(pversion	,Organizations						,'Organizations'						,Build_Organizations						);
	Build_File(pversion	,Affiliated_Individuals		,'Affiliated_Individuals'		,Build_Affiliated_Individuals		);
	Build_File(pversion	,Unaffiliated_Individuals	,'Unaffiliated_Individuals'	,Build_Unaffiliated_Individuals	);

	export full_build := sequential(
		 Create_Supers()
		,spray_files
		,Promote().Sprayed2Using
		,Build_Organizations.All
		,Build_Affiliated_Individuals.All
		,Build_Unaffiliated_Individuals.All
		,Build_Stats(pversion,pOverwrite := pOverwrite).all
		,if(not pSkipStrata	,Strata_Population_Stats(pversion).all)
		,Promote().Using2Used
		,Promote().Built2QA
	) : success(send_email(pversion).buildsuccess), failure(send_email(pversion).buildfailure);
	
	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping build')
	);

end;