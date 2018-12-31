import tools, _control, ut, std, Scrubs, Scrubs_Equifax_Business_Data;

export Build_All(
	 string															pversion	
	,string															pDirectory			= '/data/hds_180/Equifax_Business_Data/build/' + pversion[1..8]
	,string															pServerIP				= _control.IPAddress.bctlpedata11
	,string															pFilename				= '*.txt'
  ,string															pGroupName			= STD.System.Thorlib.Group( )	  		
	,boolean														pIsTesting			= false
	,boolean														pOverwrite			= false																												
	,dataset(Layouts.Sprayed_Input	)		pSprayedFile		= Files().Input.using                  
	,dataset(Layouts.Base )   pBaseFile     = Files().base.qa
) :=
function

	full_build :=
	sequential(
		Equifax_Business_Data.Create_Supers,
		Equifax_Business_Data.Spray       (pversion,pServerIP,pDirectory,pFilename,pGroupName,pIsTesting,pOverwrite),
		Equifax_Business_Data.Build_Base(pversion,pIsTesting,pSprayedFile,pBaseFile)
		,Scrubs.ScrubsPlus('Equifax_Business_Data','Scrubs_Equifax_Business_Data','Scrubs_Equifax_Business_Data_Input', 'Input', pversion,Equifax_Business_Data.Email_Notification_Lists(pIsTesting).BuildFailure,false)
		,Equifax_Business_Data.Build_Keys	(pversion).all
		,Scrubs.ScrubsPlus('Equifax_Business_Data','Scrubs_Equifax_Business_Data','Scrubs_Equifax_Business_Data_Base', 'Base', pversion,Equifax_Business_Data.Email_Notification_Lists(pIsTesting).BuildFailure,false)
		,Equifax_Business_Data.Build_Strata(pversion	,pOverwrite,,,	pIsTesting)
		,Equifax_Business_Data.Promote().Inputfiles.using2used
		,Equifax_Business_Data.Promote().Buildfiles.Built2QA
		//for future use
		// ,BIPStats(pversion) 
		,Equifax_Business_Data.QA_Records()
	// ) : success(Send_Emails(pversion,,not pIsTesting).Roxie), 
	) : success(Send_Emails(pversion,,not pIsTesting).buildsuccess), 
	    failure(send_emails(pversion,,not pIsTesting).buildfailure);
	
	return
		if(tools.fun_IsValidVersion(pversion)
			,full_build
			,output('No Valid version parameter passed, skipping Equifax_Business_Data.Build_All')
		);

end;