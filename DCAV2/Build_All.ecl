import tools, _control, Scrubs, Scrubs_DCA, ut, std;
export Build_All(
	 string														pversion
	,string														pDirectory					= '/data/prod_data_build_13/eval_data/dca/build/'
	,string														pServerIP						= _control.IPAddress.bctlpedata11 
	,string														pFilenameint				= '*ddca*int*txt'
	,string														pFilenameprv				= '*ddca*prv*txt'
	,string														pFilenamepub				= '*ddca*pub*txt'
	,string														pFilenamepriv				= '*privco*txt'
	,string														pFilenamePeop				= '*corpaffilPeople*txt'
	,string														pFilenamePos				= '*corpaffilPositions*txt'
	,string														pFilenameBoard			= '*corpaffilBoards*txt'
	,string														pFilenameKill				= '*Kill*Report*txt'
	,string														pFilenameMA					= '*M_A_*txt'
	,string														pGroupName					= _Constants().groupname																		
	,boolean													pIsTesting					= _Constants().IsDataland
	,boolean													pPullBasesFromProd	= _Constants().IsDataland
	,boolean													pShouldSpray				= true
	,boolean													pOverwrite					= false																															
	,string														pKeyDatasetName			= 'DCA'
	,dataset(Layouts.Input.sprayed	)	pSprayedintFile			= files().input.int.using
	,dataset(Layouts.Input.sprayed	)	pSprayedprvFile			= files().input.prv.using
	,dataset(Layouts.Input.sprayed	)	pSprayedpubFile			= files().input.pub.using
	,dataset(Layouts.Input.sprayed	)	pSprayedPrivcoFile	= files().input.privco.using
	,dataset(Layouts.Base.companies	)	pBaseCompaniesFile	= Files(,pPullBasesFromProd).base.companies.qa									
	,dataset(Layouts.Base.contacts	)	pBaseContactsFile		= Files(,pPullBasesFromProd).base.contacts.qa								
) :=
function
	full_build :=
	sequential(
		 Create_Supers	(pKeyDatasetName)
		,Spray					(pversion,pServerIP,pDirectory,pFilenameint,pFilenameprv,pFilenamepub,pFilenamepriv,pFilenamePeop,pFilenamePos,pFilenameBoard,pFilenameKill,pFilenameMA,pGroupName,not pShouldSpray,pOverwrite)
		,Build_Base			(pversion,pIsTesting,pSprayedintFile,pSprayedprvFile,pSprayedpubFile,pSprayedPrivcoFile,pBaseCompaniesFile,pBaseContactsFile).doall
		,Scrubs.ScrubsPlus('DCA','Scrubs_DCA','Scrubs_DCA_Base_Companies','Base_Companies',pversion,DCAV2.Email_Notification_Lists().ScrubsPlus,false)
    ,Scrubs.ScrubsPlus('DCA','Scrubs_DCA','Scrubs_DCA_Base_Contacts' ,'Base_Contacts' ,pversion,DCAV2.Email_Notification_Lists().ScrubsPlus,false)	
		,Build_Keys			(pversion	,pKeyDatasetName																	).all
		,Build_Autokeys	(pversion	,pKeyDatasetName																	).all
		,Build_Strata		(pversion	,pOverwrite,pIsTesting			) 
		,QA_Records()
		,Promote().Inputfiles.using2used
		,Promote(,'base').Buildfiles.Built2QA
		,Promote(,'key',,,pKeyDatasetName).Buildfiles.Built2QA
	) : success(Send_Emails(pversion,,,pKeyDatasetName).roxie), failure(send_emails(pversion).buildfailure);
	
	return
		if(tools.fun_IsValidVersion(pversion)
			,full_build
			,output('No Valid version parameter passed, skipping DCAV2.Build_All')
		);
end;
