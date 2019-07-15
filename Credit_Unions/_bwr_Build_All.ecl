IMPORT _control;

pversion				:= '20110303'													;
pDirectory			:= '/data_build_5_2/credit_union/data';
pServerIP				:= _control.IPAddress.bctlpedata10		;
pFilename				:= '*txt'		                        	;
pGroupName			:= Credit_Unions._Constants().groupname	;																
pIsTesting			:= false															;
pOverwrite			:= false															;															
pSprayedFile		:= Credit_Unions.Files().Input.using								;
pBaseFile				:= Credit_Unions.Files().base.qa										;

#workunit('name', 'Yogurt: ' + Credit_Unions._Constants().Name + ' Build ' + pversion);
Credit_Unions.Build_All(
	 pversion		 
	,pDirectory	
	,pServerIP		
	,pFilename		
	,pGroupName	
	,pIsTesting	
	,pOverwrite	
	,pSprayedFile
	,pBaseFile		

);