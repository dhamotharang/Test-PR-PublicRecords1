import tools, _control,liensv2;

export Build_All(

	 string																			pversion
	,string 																		pFilenamePattern			= '^.*in::liensv2::.*::hgn::okclien$'
	,boolean																		pIsTesting						= false
	,boolean																		pOverwrite						= false																															
	,dataset(Layouts.Input.Layout_Liens_Hogan	)	pSprayedFile					= Files().Input.using
	,dataset(Layouts.Base											)	pBaseFile							= Files().base.qa										
	,boolean																		pShouldCompileInputs	= true																															
	,unsigned																		pStartDate						= _Flags.MaxDtVendorLastReported					

) :=
function

	full_build := sequential(
		 Create_Supers
		,if(not _Flags.ExistCurrentSprayed	,fCompileInputFiles(not pShouldCompileInputs,pFilenamePattern,pStartDate))
		,Build_Base		(pversion,pIsTesting,pSprayedFile,pBaseFile	).all
		,Build_Keys		(pversion																		).all
		,Build_Strata	(pversion	,pOverwrite,,	pIsTesting					).all_stats
		,Promote().buildfiles.Built2QA
		,QA_Records

	) : success(Send_Emails(pversion,,not pIsTesting).BuildSuccess), failure(send_emails(pversion,,pIsTesting).buildfailure);
	
	return
		if(tools.fun_IsValidVersion(pversion)
			,full_build
			,output('No Valid version parameter passed, skipping Garnishments.Build_All')
		);

end;