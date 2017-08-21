import _control;

string4 force := 'thor' : stored('did_add_force');		//only on dataland, force thor

pversion						:= '20120910'															;
pDirectory					:= '/prod_data_build_13/eval_data/dca/test/20120718'		;
pServerIP						:= _control.IPAddress.edata10							;
pFilenameint				:= '*ddca*int*txt'												;
pFilenameprv				:= '*ddca*prv*txt'												;
pFilenamepub				:= '*ddca*pub*txt'												;
pFilenamepriv				:= '*privco*txt'													;
pFilenamePeop				:= '*corpaffilPeople*txt'									;
pFilenamePos				:= '*corpaffilPositions*txt'              ;
pFilenameBoard			:= '*corpaffilBoards*txt'                 ;
pFilenameKill				:= '*KillReport*txt'                      ;
pFilenameMA					:= '*M_A_*txt'                            ;
pGroupName					:= DCAV2._Constants().groupname						;	
pIsTesting					:= DCAV2._Constants().IsDataland					;
pPullBasesFromProd	:= DCAV2._Constants().IsDataland					;
pShouldSpray				:= true																		;
pOverwrite					:= false																	;				
pKeyDatasetName			:= 'DCA'																	;
pSprayedintFile			:= DCAV2.files().input.int.using					;
pSprayedprvFile			:= DCAV2.files().input.prv.using					;
pSprayedpubFile			:= DCAV2.files().input.pub.using					;
pSprayedPrivcoFile	:= DCAV2.files().input.privco.using				;
pBaseCompaniesFile	:= DCAV2.Files(,pPullBasesFromProd).base.companies.qa	;
pBaseContactsFile		:= DCAV2.Files(,pPullBasesFromProd).base.contacts.qa	;

#workunit('name', DCAV2._Constants().Name + ' Build ' + pversion);
DCAV2.Build_All(
	 pversion					
	,pDirectory				
	,pServerIP					
	,pFilenameint			
	,pFilenameprv			
	,pFilenamepub	
	,pFilenamepriv	
	,pFilenamePeop	
	,pFilenamePos	
	,pFilenameBoard
	,pFilenameKill	
	,pFilenameMA		
	,pGroupName				
	,pIsTesting				
	,pPullBasesFromProd
	,pShouldSpray			
	,pOverwrite				
	,pKeyDatasetName		
	,pSprayedintFile					
	,pSprayedprvFile					
	,pSprayedpubFile					
	,pSprayedPrivcoFile			
	,pBaseCompaniesFile
	,pBaseContactsFile	
);
