import tools, _control, ut, std, dops, Scrubs, Scrubs_OPM, Orbit3;
						
export Build_All(
	 string															pversion
	,string													    pDirectory			= '/data/Builds/builds/OPM/' + pversion[1..8]	 
	,string															pServerIP				= _control.IPAddress.bctlpedata11
	,string															pFilename				= '*NonDOD*.txt'
	,string															pGroupName			= STD.System.Thorlib.Group( )
	,boolean														pIsTesting			= false
	,boolean														pOverwrite			= false																												
	,dataset(Layouts.Sprayed_Input	)		pSprayedFile		= Files().Input.using
	,dataset(Layouts.Base )             pBaseFile       = Files().base.qa
) :=
function

	full_build :=
	sequential( Create_Supers
							,Spray (pversion,pServerIP,pDirectory,pFilename,pGroupName,pIsTesting,pOverwrite) 
							,Scrubs.ScrubsPlus('OPM','Scrubs_OPM','Scrubs_OPM_Raw','Raw',pversion,Email_Notification_Lists(pIsTesting).BuildFailure,false)
							,Build_Base (pversion,pIsTesting,pSprayedFile,pBaseFile)
							,Build_Strata(pversion,pOverwrite,,,pIsTesting)
							,Promote().Inputfiles.using2used
							,Promote().Buildfiles.Built2QA
							,QA_Records()
							,Orbit3.proc_Orbit3_CreateBuild('OPM',pversion,'N')
 	          ): success(Send_Emails(pversion,,not pIsTesting).Roxie), 
   	           failure(Send_Emails(pversion,,not pIsTesting).buildfailure);
	
	return
		if(tools.fun_IsValidVersion(pversion)
			,full_build
			,output('No Valid version parameter passed, skipping OPM.Build_All')
		);

end;