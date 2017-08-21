import tools, _control;

export Build_All(

	 string														pversion
	,boolean													pIsTesting					= _Constants().IsDataland
	,boolean													pOverwrite					= false																															
	,dataset(Layouts.Input.sprayed	)	pSprayedFile				= Files().Input.prod_thor.using
	,dataset(Layouts.Base						)	pBaseFile						= files().base.prod_thor.qa							

) :=
function
	full_build :=
	sequential(
		 Create_Supers
		,Build_Base			(pversion,pIsTesting,pSprayedFile,pBaseFile)
		,Build_Strata		(pversion	,pOverwrite)
		,Promote().Inputfiles.using2used
		,Promote().Buildfiles.Built2QA
		,fileservices.deletesuperfile(Filenames().input.prod_thor.sprayed)	//so logs thor process can copy file over without failure
	) : success(Send_Emails(pversion).buildsuccess), failure(send_emails(pversion).buildfailure);
	
	return
		if(tools.fun_IsValidVersion(pversion) and fileservices.superfileexists(Filenames().input.prod_thor.sprayed)
			,full_build
			,output('No Valid version parameter passed or no file from logs thor yet, skipping tin_matching.Build_All')
		);
end;
