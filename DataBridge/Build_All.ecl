import tools, _control, ut, std, Scrubs, Scrubs_DataBridge, Orbit3, dops;
						
export Build_All(
	 string															pversion
	,string													    pDirectory			= '/data/hds_180/DataBridge/data/' + pversion[1..8]	 
	,string															pServerIP				= 'uspr-edata11.risk.regn.net'
	,string															pFilename				= 'LN_*_database.txt'
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
		,Scrubs.ScrubsPlus('DataBridge','Scrubs_DataBridge','Scrubs_DataBridge', 'Base', pversion,Email_Notification_Lists(pIsTesting).BuildFailure,false)
    ,if(Scrubs.mac_ScrubsFailureTest('DataBridgeKeys',pversion)
		    ,sequential(Build_Keys(pversion).all   
		               ,Build_Strata(pversion,pOverwrite,,,pIsTesting)
		               ,Promote().Inputfiles.using2used
		               ,Promote().Buildfiles.Built2QA
		               ,QA_Records()
	                 ,dops.updateversion('DataBridgeKeys',pversion,DataBridge.Email_Notification_Lists().BuildSuccess,,'N')
		               ,Orbit3.proc_Orbit3_CreateBuild('DataBridge',pversion,'N')
									 )
				,OUTPUT('Scrubs Failed',NAMED('Scrubs_Failure'))
				)
	) : success(Send_Emails(pversion,,not pIsTesting).Roxie), 
	    failure(Send_Emails(pversion,,not pIsTesting).buildfailure);
	
	return
		if(tools.fun_IsValidVersion(pversion)
			,full_build
			,output('No Valid version parameter passed, skipping DataBridge.Build_All')
		);

end;