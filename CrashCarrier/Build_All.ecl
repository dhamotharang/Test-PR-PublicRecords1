import _control, tools, ut, Orbit3, scrubs, Scrubs_CrashCarrier;

export Build_All( 
	 string		pversion
	,string		pDirectory				= '/data/hds_180/CrashCarrier/data/'+ pversion
	,string		pServerIP					= _control.IPAddress.bctlpedata11
	,string		pFilename					= _Dataset().pName+'*txt'
	,string		pGroupName				= _Constants().groupname
	,boolean	pUseOtherEnviron	= false
	,boolean	pIsTesting				= false
	,boolean	pOverwrite				= false
	,dataset(Layouts.Input.Sprayed	)		pSprayedFile		= Files().Input.using
	,dataset(Layouts.Base						)		pBaseFile				= Files().base.qa	
) :=
function	
 orbit_update := Orbit3.proc_Orbit3_CreateBuild_AddItem('Crash Carrier',(string)pversion,'N');
	full_build :=
	sequential(
		 Create_Supers
		,Spray					(pversion,pServerIP,pDirectory,pFilename,pGroupName,pIsTesting,pOverwrite)
		,Scrubs.ScrubsPlus('CrashCarrier','Scrubs_CrashCarrier','Scrubs_CrashCarrier','', pversion,CrashCarrier.Email_Notification_Lists(pIsTesting).BuildFailure,false)
		,if(scrubs.mac_ScrubsFailureTest('Scrubs_CrashCarrier',pversion)
		 	 ,OUTPUT('Scrubs passed.  Continuing to the Build_Base step.')				
			 ,FAIL('Scrubs failed.  Base and keys not built.  Processing stopped.  Resolve scrubs issues before you run again.')
		   )		
		,Build_Base			(pversion,pIsTesting,pSprayedFile,pBaseFile	)
		,Build_Keys			(pversion																		).all
		,Build_Strata		(pversion	,pOverwrite,,,pUseOtherEnviron,,pIsTesting				)
		,Promote().Inputfiles.using2used
		,Promote().Buildfiles.Built2QA
		,QA_Records()
		,orbit_update
		
	) : success(Send_Emails(pversion,,not pIsTesting).Roxie), failure(send_emails(pversion,,not pIsTesting).buildfailure);
	
	return
		if(tools.fun_IsValidVersion(pversion)
			,full_build
			,output('No Valid version parameter passed, skipping CrashCarrier.Build_All')
			);	
end;