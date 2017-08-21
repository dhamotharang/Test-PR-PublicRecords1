import ut, VersionControl,Roxiekeybuild, tools, _control;

export Build_All(
   string													pversion
	,boolean												pIsTesting	 = false
	,boolean												pOverwrite	 = false																															
	,dataset(Layouts.Input.sprayed)	pSprayedFile = Files().Input.using
	,dataset(Layouts.Base					)	pBaseFile		 = Files().base.qa	
) := function

	full_build :=	sequential(
		Create_Supers
		,VersionControl.fSprayInputFiles(Spray(pversion).Input)
		,Build_Base		(pversion,pIsTesting,pSprayedFile,pBaseFile)
		,Build_Keys		(pversion).all
		,RoxieKeyBuild.updateversion('ExperianFEINKeys',pversion,_control.MyInfo.EmailAddressNotify,,'N')
		,Build_Strata	(pversion,pOverwrite,,,pIsTesting)
	  ,Promote().Inputfiles.using2used
		,Promote().Buildfiles.Built2QA
		,QA_Records()
		
	) : success(Send_Emails(pversion).BuildSuccess), 
	    failure(send_emails(pversion).BuildFailure);
	
	return
		if(tools.fun_IsValidVersion(pversion)
			,full_build
			,output('No Valid version parameter passed, skipping Experian_FEIN.Build_All')
		);

end;