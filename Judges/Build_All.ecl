import tools, _control;
export Build_All(
	 string														pversion
	,string														pDirectory			= '/prod_data_build_13/eval_data/judge_data/'
	,string														pServerIP				= _control.IPAddress.edata10
	,string														pFilename				= '*txt'
	,string														pGroupName			= _dataset().groupname																		
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
		,Build_Base			(pversion,pIsTesting,pSprayedFile,pBaseFile	).all
		,Build_Keys			(pversion																		).all
		,Build_Strata		(pversion	,pOverwrite,,,	pIsTesting				)
		,Promote().Inputfiles.using2used
		,Promote().Buildfiles.Built2QA
		,Build_Output		(pversion,pIsTesting,pBaseFile							).all
		,QA_Records()
		,Despray				(pversion,pServerIP,pDirectory,pOverwrite)
	) : success(Send_Emails(pversion,,not pIsTesting).Roxie), failure(send_emails(pversion,,not pIsTesting).buildfailure);
	
	return
		if(tools.fun_IsValidVersion(pversion)
			,full_build
			,output('No Valid version parameter passed, skipping Judges.Build_All')
		);
end;
