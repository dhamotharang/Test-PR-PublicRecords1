import tools, _control, Scrubs, Scrubs_Credit_Unions;

export Build_All(

	 string														pversion
	,string														pDirectory			= '/data_build_5_2/credit_union/data'
	,string														pServerIP				= _control.IPAddress.bctlpedata10
	,string														pFilename				= '*txt'
	,string														pGroupName			= _Constants().groupname																		
	,boolean													pIsTesting			= false
	,boolean													pOverwrite			= false																															
	,dataset(Layouts.Input.Sprayed	)	pSprayedFile		= Files().Input.using
	,dataset(Layouts.Base						)	pBaseFile				= Files().base.qa										

) :=
function

	full_build :=
	sequential(
		Create_Supers
		,Spray					(pversion,pServerIP,pDirectory,pFilename,pGroupName,pIsTesting,pOverwrite)
		,Build_Base			(pversion,pIsTesting,pSprayedFile,pBaseFile	)
		,Scrubs.ScrubsPlus('Credit_Unions','Scrubs_Credit_Unions','Scrubs_Credit_Unions_Base', 'Base', pversion,Credit_Unions.Email_Notification_Lists(pIsTesting).Stats,false)
		,Build_Keys			(pversion																		).all
		,Build_Strata		(pversion	,pOverwrite,,,	pIsTesting				)
		,Promote().Inputfiles.using2used
		,Promote().Buildfiles.Built2QA
		,QA_Records()
		//,BIPStats(pversion,'Credit_Unions')

	) : success(Send_Emails(pversion,,not pIsTesting).Roxie), failure(send_emails(pversion,,not pIsTesting).buildfailure);
	
	return
		if(tools.fun_IsValidVersion(pversion)
			,full_build
			,output('No Valid version parameter passed, skipping Credit_Unions.Build_All')
		);

end;