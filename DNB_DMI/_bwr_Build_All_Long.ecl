import _control;

pversion						:= '20110401'																									;
pDirectory					:= '/prod_data_build_10/production_data/business_headers/dnb/';
pServerIP						:= _control.IPAddress.edata10																	;
pFilename						:= 'DMI*'																											;
pGroupName					:= DNB_DMI._Constants().groupname															;		
pIsTesting					:= DNB_DMI._Constants().IsDataland														;
pShouldSpray				:= true																												;
pOverwrite					:= false																											;			
pUseV1Bases					:= false																											;
pUseV1Inputs				:= false																											;
pKeyDatasetName			:= 'DNB'																											;
pSprayedFile				:= DNB_DMI.Files().Input.raw.using														;
pBaseCompaniesFile	:= DNB_DMI.Files(,pIsTesting).base.companies.qa								;
pBaseContactsFile		:= DNB_DMI.Files(,pIsTesting).base.contacts.qa								;

#workunit('name', DNB_DMI._Constants().Name + ' Build ' + pversion);
DNB_DMI.Build_All(
	 pversion					
	,pDirectory				
	,pServerIP					
	,pFilename					
	,pGroupName				
	,pIsTesting		
	,pShouldSpray
	,pOverwrite	
	,pUseV1Bases			
	,pUseV1Inputs		
	,pKeyDatasetName	
	,pSprayedFile			
	,pBaseCompaniesFile
	,pBaseContactsFile	
);
