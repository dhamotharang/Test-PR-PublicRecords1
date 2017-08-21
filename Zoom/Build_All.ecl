import tools, _control;

export Build_All(

	 string															pversion
	,string															pDirectory			= '/data/hds_180/zoom/out'
	,string															pServerIP				= _control.IPAddress.bctlpedata11
	,string															pFilename				= 'zoom*csv'
	,string															pFilename2			= 'zoom*xml'
	,string															pGroupName			= _dataset().groupname																		
	,boolean														pIsTesting			= false
	,boolean														pOverwrite			= false																															
	,dataset(layouts.Input.Sprayed		)	pUpdateFile			= Files().Input.Using
	,dataset(Layouts.Base							)	pBaseFile				= Files().Base.QA
	,dataset(Layouts.Input.rawXML			)	pUpdateXMLFile	= Files().InputXML.Using

) :=
module

	lfileversion	:= regexreplace('^.*?/([^/]*)[/]?$', pDirectory, '$1');

	export spray_files := if(
			pDirectory != ''
	and not(			_Flags.ExistCurrentSprayed
						and	_Flags.ExistCurrentXMLSprayed
			)
	
	, fSprayFiles(
		 pServerIP
		,pDirectory 
		,pFilename
		,pFilename2
		,lfileversion
		,pGroupName
		,pIsTesting
		,pOverwrite

	));
	
	export full_build := sequential(
		 Create_Supers
		,spray_files
		,Build_Base(pversion,pUpdateFile,pBaseFile,pUpdateXMLFile).all
		,Build_Roxie_Keys(pversion).all
		,Promote().buildfiles.Built2QA
		,Promote().Inputfiles.Using2Used
		,QA_Records()
		,Strata_Population_Stats(pversion).all
		,Statistics().all

	) : success(Send_Emails(pversion).Roxie), failure(send_emails(pversion).buildfailure);
	
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Zoom.Build_All')
	);

end;