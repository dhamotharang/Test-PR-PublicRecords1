import tools, _control, Scrubs, Scrubs_Spoke;

export Build_All(

	 string														pversion
	,string														pDirectory		= '/data/load01/spoke'
	,string														pServerIP			= _control.IPAddress.bctlpedata11
	,string														pFilename			= '*tsv'
	,string														pDelimiter		= '\t'
	,string														pGroupName		= _dataset().groupname																		
	,boolean													pIsTesting		= false
	,boolean													pOverwrite		= false																															
 	,dataset(layouts.Input.Sprayed	)	pUpdateFile		= Files(pDelimiter := pDelimiter).Input.Using
	,dataset(Layouts.Base						)	pBaseFile     = Files().Base.QA			

) :=
module

	lfileversion	:= regexreplace('^.*?/([^/]*)[/]?$', pDirectory, '$1');

	export spray_files := if(pDirectory != ''
	and not(			_Flags.ExistCurrentSprayed
			)
	
	, fSprayFiles(
		 pServerIP
		,pDirectory 
		,pFilename 
		,lfileversion
		,pDelimiter
		,pGroupName
		,pIsTesting
		,pOverwrite

	));

	export full_build := sequential(
		 Create_Supers
		,spray_files
		,Scrubs.ScrubsPlus('Spoke','Scrubs_Spoke','Scrubs_Spoke', 'Input', pversion,Email_Notification_Lists(pIsTesting).BuildFailure,false)
		,if(Scrubs.mac_ScrubsFailureTest('Scrubs_Spoke',pversion)
		    ,sequential(Build_Base(pversion,pDelimiter,pUpdateFile,pBaseFile).all
									,Build_keys(pversion).all
									,Promote().buildfiles.Built2QA
									,output(topn(files().base.qa(did != 0, bdid != 0), 200, -dt_vendor_first_reported),named('SampleNewRecordsForQA'))
									,Strata_Population_Stats(pversion,pIsTesting,pOverwrite)
								  )
			  ,OUTPUT('Scrubs Failed',NAMED('Scrubs_Failure'))
			 )
	) : success(Send_Email(pversion).Roxie), failure(send_email(pversion).buildfailure);
	
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Spoke.Build_All')
	);

end;