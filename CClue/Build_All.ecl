import tools, _control, _validate, Orbit3;

export Build_All(

	 string															pversion				= ''
	,string															pRemoteIp				= _control.IPAddress.aprod_thor_dali
	,string															pGroupName			= _dataset().groupname
	,string															pFilename				= '~foreign::'+_control.IPAddress.aprod_thor_dali +'::'+'thor::base::cclue::qa::search::output'
	,boolean														pIsTesting			= false
	,boolean														pOverwrite			= false																															
	,dataset(Layouts.Input.Sprayed	)		pSprayedFile		= Files().Input.using
) :=
function

	full_build :=
	sequential(
		 Create_Supers
		,RemoteCopyInfile	(pFilename,pGroupName,pRemoteIp)
		,Build_Base				(pversion,pIsTesting,pSprayedFile	)
		,Build_Keys				(pversion															).all
		,Build_Strata			(pversion	,pOverwrite,,,	pIsTesting	)
	  ,Orbit3.proc_Orbit3_CreateBuild_npf('CCLUE',pversion)
		,Promote().Inputfiles.using2used
		,Promote().Buildfiles.Built2QA
	): success(Send_Emails(pversion,,not pIsTesting).Roxie), failure(send_emails(pversion,,not pIsTesting).buildfailure);
	//): success(Send_Emails(pversion,,not pIsTesting).BuildSuccess), failure(send_emails(pversion,,not pIsTesting).buildfailure);
		
	return
		if(_validate.date.fIsValid(pversion[1..8]) and _validate.date.fIsValid(pversion[1..8],_validate.date.rules.DateInPast)
			,full_build
			,fail('No Valid version parameter passed, skipping CClue.Build_All')
		);

end;