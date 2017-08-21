pversion				:= '20110705'													;
pDirectory			:= '/prod_data_build_13/eval_data/fdic';
pServerIP				:= _control.IPAddress.edata10					;
pFilename				:= '*.csv'															;
pGroupName			:= FDIC_sod_annual._Constants().groupname	;																
pIsTesting			:= false															;
pOverwrite			:= false															;															
pSprayedFile		:= FDIC_sod_annual.Files().Input.using								;
pBaseFile				:= FDIC_sod_annual.Files().base.qa										;

#workunit('name', FDIC_sod_annual._Constants().Name + ' Build ' + pversion);
FDIC_sod_annual.Build_All(
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