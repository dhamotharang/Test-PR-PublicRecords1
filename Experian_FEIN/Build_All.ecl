import ut, VersionControl, dops, tools, _control, Scrubs, std, Scrubs_Experian_FEIN;

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
		,Scrubs.ScrubsPlus('Experian_FEIN','Scrubs_Experian_FEIN','Scrubs_Experian_FEIN_Base', 'Base', pVersion,Experian_FEIN.Email_Notification_Lists().Stats,false)
		,Build_Keys		(pversion).all
		,dops.updateversion('ExperianFEINKeys',pversion,_control.MyInfo.EmailAddressNotify,,'N')
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