import tools, _control, ut, std, Scrubs, Scrubs_Equifax_Business_Data, dops, Orbit3;

export Build_All(
	 string															        pversion
	,string															        pDirectory			     = '/data/Builds/builds/equifax_business_data/data/processing/' + pversion[1..8]
	,string															        pServerIP		         = _control.IPAddress.bctlpedata11
	,string															        pFilename				     = '*Extract*txt'
	,string															        pFilenameContacts    = '*Contact*txt'
  ,string															        pGroupName			     = STD.System.Thorlib.Group( )
	,boolean														        pIsTesting			     = false
	,boolean														        pOverwrite			     = false																				
	,dataset(Layouts.Sprayed_Input	)		        pSprayedFile		     = Files().Input.Companies.using																									
	,dataset(Layouts.Sprayed_Input_Contacts	)		pSprayedContactsFile = Files().Input.Contacts.using             
	,dataset(Layouts.Base )                     pBaseFile            = Files().base.Companies.qa             
	,dataset(Layouts.Base_Contacts )            pBaseContactsFile    = Files().base.Contacts.qa
) :=
function

	full_build :=
	sequential(
		Equifax_Business_Data.Create_Supers,
		Equifax_Business_Data.Spray(pversion,pServerIP,pDirectory,pFilename,pFilenameContacts,pGroupName,pIsTesting,pOverwrite),
		Scrubs.ScrubsPlus('Equifax_Business_Data','Scrubs_Equifax_Business_Data','Scrubs_Equifax_Business_Data_Contacts', 'Contacts', pversion,Equifax_Business_Data.Email_Notification_Lists(pIsTesting).BuildFailure,false),
		Scrubs.ScrubsPlus('Equifax_Business_Data','Scrubs_Equifax_Business_Data','Scrubs_Equifax_Business_Data_Input', 'Input', pversion,Equifax_Business_Data.Email_Notification_Lists(pIsTesting).BuildFailure,false),		
 		if(scrubs.mac_ScrubsFailureTest('Scrubs_Equifax_Business_Data_Contacts',pversion) AND scrubs.mac_ScrubsFailureTest('Scrubs_Equifax_Business_Data_Input',pversion)
		 	 ,OUTPUT('Scrubs passed.  Continuing to the Build_Base step.')				
			 ,FAIL('Scrubs failed.  Base and keys not built.  Processing stopped.')
		   ),			
 		Equifax_Business_Data.Build_Base(pversion,pIsTesting,pSprayedFile,pSprayedContactsFile,pBaseFile,pBaseContactsFile),
		Equifax_Business_Data.Build_Keys(pversion).all,
		Equifax_Business_Data.Build_Strata(pversion	,pOverwrite,,,	pIsTesting),
		Equifax_Business_Data.Promote().Inputfiles.using2used,
		Equifax_Business_Data.Promote().Buildfiles.Built2QA,
		Equifax_Business_Data.QA_Records(),
		dops.updateversion('EquifaxBusDataKeys',pversion,Equifax_Business_Data.Email_Notification_Lists().BuildSuccess,,'N'),
		Orbit3.proc_Orbit3_CreateBuild('Equifax Marketing Data Solutions (MDS)',pversion,'N'),
	) : success(Send_Emails(pversion,,not pIsTesting).Roxie),
	    failure(Send_Emails(pversion,,not pIsTesting).buildfailure);

	return
		if(tools.fun_IsValidVersion(pversion)
			,
			full_build
			,output('No Valid version parameter passed, skipping Equifax_Business_Data.Build_All')
		)
		;

end;