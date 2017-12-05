#option('globalAutoHoist', false); 
#option ('optimizeProjects', false);
import RoxieKeyBuild, tools, _control, VersionControl, Scrubs, Scrubs_DNB_DMI, ut, std;
//export Email_Recipients := 'kevin.reeder@lexisnexis.com';
export Build_All(
	 string																	pversion
	,string																	pDirectory					= '/data/prod_data_build_10/production_data/business_headers/dnb/'
	,string																	pServerIP						= IF(VersionControl._Flags.IsDataland,
																																   _control.IPAddress.bctlpedata12,
																																	 _control.IPAddress.bctlpedata11)
	,string																	pFilename						= 'DMI*'
	,string																	pGroupName					= _Constants().groupname																		
	,boolean																pIsTesting					= _Constants().IsDataland
	,boolean																pShouldSpray				= true
	,boolean																pOverwrite					= false																															
	,boolean																pUseV1Bases					= false
	,boolean																pUseV1Inputs				= false
	,string																	pKeyDatasetName			= 'DNB'
	,dataset(Layouts.Input.raw						)	pSprayedFile				= Files().Input.raw.using
	// ,dataset(Layouts.Base.CompaniesForBIP2)	pBaseCompaniesFile	= Files(,pIsTesting).base.companies.qa									
	// ,dataset(Layouts.Base.contacts				)	pBaseContactsFile		= Files(,pIsTesting).base.contacts.qa									
	,dataset(Layouts.Base.CompaniesForBIP2)	pBaseCompaniesFile2	= if(pUseV1Bases	,File_Companies_V1_Base	(),Files(,pIsTesting).base.companies.qa	)	
	,dataset(Layouts.Base.contacts				)	pBaseContactsFile2	= if(pUseV1Bases	,File_Contacts_V1_Base	(),Files(,pIsTesting).base.contacts.qa	)								
	,dataset(layouts.input.oldcompanies		)	pInputCompaniesFile	= Files().input.oldcompanies.using	// only for pulling in V1 files
	,dataset(layouts.input.oldcontacts		)	pInputContactsFile	= Files().input.oldcontacts.using		// only for pulling in V1 files					
) :=
function
	full_build :=
	sequential(
		 Create_Supers(pKeyDatasetName)
		,if(not pUseV1Inputs	,Spray					(pversion,pServerIP,pDirectory,pFilename,pGroupName,not pShouldSpray,pOverwrite)
													,Compile_Old_Inputs()
		)
    ,Build_Base			(pversion,pIsTesting,pUseV1Bases,pUseV1Inputs,pSprayedFile,pBaseCompaniesFile2,pBaseContactsFile2,pInputCompaniesFile,pInputContactsFile,,,pKeyDatasetName)
		,Build_Keys			(pversion	,pKeyDatasetName																	).all
		,Build_Autokeys	(pversion	,pKeyDatasetName																	)
		,Build_Strata		(pversion	,pOverwrite,,,,	pIsTesting				)
		,Promote().Inputfiles.using2used
		,Promote(,'base').Buildfiles.Built2QA
		,Promote(,'key',,,pKeyDatasetName).Buildfiles.Built2QA
		,Scrubs.ScrubsPlus('DNB_DMI','Scrubs_DNB_DMI','Scrubs_DNB_DMI_Raw','Raw' ,pversion,DNB_DMI.Email_Notification_Lists().ScrubsPlus,false)		
		,QA_Records()
		,RoxieKeyBuild.updateversion('DNBKeys',pversion,_Control.MyInfo.EmailAddressNotify,,'N')
	) : success(Send_Emails(pversion,,not pIsTesting,pKeyDatasetName).Roxie), failure(send_emails(pversion,,not pIsTesting).buildfailure);
	
	return
		if(tools.fun_IsValidVersion(pversion)
			,full_build
			,output('No Valid version parameter passed, skipping DNB_DMI.Build_All')
		);
end;
