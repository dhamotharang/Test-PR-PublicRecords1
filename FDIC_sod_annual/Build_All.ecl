import tools, _control;

export Build_All(

	 string														pversion
	,string														pDirectory			= '/prod_data_build_13/eval_data/fdic'
	,string														pServerIP				= _control.IPAddress.edata10
	,string														pFilename				= '*csv'
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
	  ,Build_Base (pversion,pIsTesting,pSprayedFile,pBaseFile) 
	  ,Build_Keys (pversion																		).all
	  ,Build_Autokeys(pversion)
		,Build_Strata		(pversion	,pOverwrite,,,	pIsTesting				)
		,Promote().Inputfiles.using2used
		,Promote().Buildfiles.Built2QA
		,QA_Records()
	)	: success(Send_Emails(pversion,,not pIsTesting).Roxie), failure(send_emails(pversion,,not pIsTesting).buildfailure);
	
	return
		if(tools.fun_IsValidVersion(pversion)
			,full_build
			,output('No Valid version parameter passed, skipping FDIC_sod_annual.Build_All')
		);

end;