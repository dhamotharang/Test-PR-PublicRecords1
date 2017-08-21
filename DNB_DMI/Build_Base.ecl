import tools;

export Build_Base(

	 string																			pversion
	,boolean																		pIsTesting						= _Constants().IsDataland
	,boolean																		pUseV1Bases						= false
	,boolean																		pUseV1Inputs					= false
	,dataset(Layouts.Input.raw								)	pRawFile							= Files().Input.raw.using
	,dataset(Layouts.Base.CompaniesForBIP2		)	pBaseCompaniesFile		= Files(,pIsTesting).base.companies.qa									
	,dataset(Layouts.Base.contacts						)	pBaseContactsFile			= if(pUseV1Bases	,File_Contacts_V1_Base	(),Files(,pIsTesting).base.contacts.qa	)								
	,dataset(layouts.input.oldcompanies				)	pInputCompaniesFile		= Files().input.oldcompanies.using	// only for pulling in V1 files
	,dataset(layouts.input.oldcontacts				)	pInputContactsFile		= Files().input.oldcontacts.using		// only for pulling in V1 files					
	,dataset(Layouts.Input.Sprayed						)	pSprayedFile					= Prep_File(pRawFile)
	,boolean																		pWriteFileOnly				= false
	,string																			pKeyDatasetName				= 'DNB'
) :=
function

	return
		if(tools.fun_IsValidVersion(pversion)
				,sequential(
										if(not pWriteFileOnly	,Promote().Inputfiles.Sprayed2Using),
										Updates_base_files(pversion,pSprayedFile,pInputCompaniesFile,pBaseCompaniesFile,pBaseContactsFile,pInputContactsFile,pUseV1Inputs)
										,if(not pWriteFileOnly,Promote(pversion,'base',pDatasetName  := pKeyDatasetName).buildfiles.New2Built)
									 )		
				,output('No Valid version parameter passed, skipping DNB_DMI.Build_Base atribute')
		);
		
end;