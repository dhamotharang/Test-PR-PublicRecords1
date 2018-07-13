import tools, _control, ut, std, Scrubs, Scrubs_Infutor_NARB;
						
export Build_All(

	 string															pversion
	,string													    pDirectory			= '/data/hds_180/infutor_narb/data/' + pversion[1..8]
	,string															pServerIP				= 'uspr-edata11.risk.regn.net'
	,string															pFilename				= 'NARB3_1_*.txt'
	,string															pGroupName			= STD.System.Thorlib.Group( )
	,boolean														pIsTesting			= false
	,boolean														pOverwrite			= false																												
	,dataset(Layouts.Sprayed_Input	)		pSprayedFile		= Files().Input.using
	,dataset(Layouts.Base )             pBaseFile       = Files().base.qa
) :=
function

	full_build :=
	sequential(
		 Create_Supers
		,Spray (pversion,pServerIP,pDirectory,pFilename,pGroupName,pIsTesting,pOverwrite)    
		,Build_Base (pversion,pIsTesting,pSprayedFile,pBaseFile)
		,Build_Keys (pversion).all
		,Scrubs.ScrubsPlus('Infutor_NARB','Scrubs_Infutor_NARB','Scrubs_Infutor_NARB_Base', 'Base', pversion,Email_Notification_Lists(pIsTesting).BuildFailure,false)
		,Build_Strata(pversion,pOverwrite,,,pIsTesting)
		,Promote().Inputfiles.using2used
		,Promote().Buildfiles.Built2QA
		,BIPStats (pversion)
		,QA_Records()
	) : success(Send_Emails(pversion,,not pIsTesting).Roxie), 
	    failure(send_emails(pversion,,not pIsTesting).buildfailure);
	
	return
		if(tools.fun_IsValidVersion(pversion)
			,full_build
			,output('No Valid version parameter passed, skipping Infutor_NARB.Build_All')
		);

end;