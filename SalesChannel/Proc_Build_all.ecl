import tools, _control;

export proc_Build_All(

	 string											pversion
	,string											pDirectory		= '/data/hds_180/SalesChannel/data_files/'+pversion
	,string											pServerIP			= _control.IPAddress.bctlpedata11
	,string											pFilename			= '*txt'
	,string											pGroupName		= _Constants().groupname																		
	,boolean										pIsTesting		= false
	,boolean										pOverwrite		= false																															
	,dataset(Layouts.Input		)	pSprayedFile	= Files().Input.using
	,dataset(Layouts.Base_new	)	pBaseFile			= Files().base.qa										

) :=
function

	full_build :=
	sequential(
		 Create_Supers
		,Spray								(pversion,pServerIP,pDirectory,pFilename,pGroupName,pIsTesting,pOverwrite)
		,proc_Build_Base			(pversion,pIsTesting,pSprayedFile,pBaseFile	)
		,Build_Keys						(pversion).all
		,proc_Build_Strata		(pversion,pOverwrite,,pIsTesting		)
		,Promote().Inputfiles.using2used
		,Promote().Buildfiles.Built2QA
		,QA_Records()

	) : success(Send_Emails(pversion,,not pIsTesting).roxie), failure(send_emails(pversion,,not pIsTesting).buildfailure);
	
	return
		if(tools.fun_IsValidVersion(pversion)
			,full_build
			,output('No Valid version parameter passed, skipping SalesChannel.Proc_Build_all')
		);

end;