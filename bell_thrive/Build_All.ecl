import tools, _control;
export Build_All(
	 string														pversion
	,string														pDirectory					= '/prod_data_build_13/eval_data/bell_thrive/20110902'
	,string														pServerIP						= _control.IPAddress.edata10
	,string														pFilename						= 'PD*csv'																							
	,string														pGroupName					= _Constants().groupname																		
	,boolean													pIsTesting					= _Constants().IsDataland
	,boolean													pShouldSpray				= true
	,boolean													pOverwrite					= false																															
	,dataset(Layouts.Input.sprayed	)	pSprayedFile				= Files().Input.using
) :=
function
	full_build :=
	sequential(
		 Create_Supers
		,Spray					(pversion,pServerIP,pDirectory,pFilename,pGroupName,not pShouldSpray,pOverwrite)
		,Build_Base			(pversion,pIsTesting,pSprayedFile)
		,Build_Strata		(pversion	,pOverwrite)
		,Promote().Inputfiles.using2used
		,Promote().Buildfiles.Built2QA
	) : success(Send_Emails(pversion).buildsuccess), failure(send_emails(pversion).buildfailure);
	
	return
		if(tools.fun_IsValidVersion(pversion)
			,full_build
			,output('No Valid version parameter passed, skipping bell_thrive.Build_All')
		);
end;
