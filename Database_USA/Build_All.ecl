import tools, _control, ut, std, Scrubs, Scrubs_Database_USA;
						
export Build_All(
	 string															pversion
	,string													    pDirectory			= '/data/hds_180/Database_USA/data/' + pversion[1..8]	 
	,string															pServerIP				= 'uspr-edata11.risk.regn.net'
	,string															pFilename				= 'LexisNexis_Exec@Home_Database*.txt'
	,string															pGroupName			= STD.System.Thorlib.Group( )
	,boolean														pIsTesting			= false
	,boolean														pOverwrite			= false																												
	,dataset(Layouts.Sprayed_Input	)		pSprayedFile		= Database_USA.Files().Input.using
	,dataset(Layouts.Base )             pBaseFile       = Database_USA.Files().base.qa
) :=
function

	full_build :=
	sequential(
		 Create_Supers
		,Spray (pversion,pServerIP,pDirectory,pFilename,pGroupName,pIsTesting,pOverwrite)    
		,Scrubs.ScrubsPlus('Database_USA','Scrubs_Database_USA','Scrubs_Database_USA_Input', 'Input', pversion,Email_Notification_Lists(pIsTesting).BuildFailure,false) 
		,if(scrubs.mac_ScrubsFailureTest('Scrubs_Database_USA_Input',pversion)
		 	 ,OUTPUT('Scrubs passed.  Continuing to the Build_Base step.')				
			 ,FAIL('Scrubs failed.  Base and keys not built.  Processing stopped.')
		   )	
		,Build_Base (pversion,pIsTesting,pSprayedFile,pBaseFile)
		,Build_Keys (pversion).all  
		,Build_Strata(pversion,pOverwrite,,,pIsTesting)
		,Promote().Inputfiles.using2used
		,Promote().Buildfiles.Built2QA
		,QA_Records()
	): 	success(Send_Emails(pversion,,not pIsTesting).Roxie), 
			failure(Send_Emails(pversion,,not pIsTesting).buildfailure);
	
	return
		if(tools.fun_IsValidVersion(pversion)
			,full_build
			,output('No Valid version parameter passed, skipping Database_USA.Build_All')
		);

end;