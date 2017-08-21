import _control;

pversion				:= '20110705'													;
pDirectory			:= '/hds_180/SalesChannel/';
pServerIP				:= _control.IPAddress.edata12					;
pFilename				:= '*txt'															;
pGroupName			:= SalesChannel._Constants().groupname	;																
pIsTesting			:= false															;
pOverwrite			:= false															;															
pSprayedFile		:= SalesChannel.Files().Input.using								;
pBaseFile				:= SalesChannel.Files().base.qa										;
#workunit('name', SalesChannel._Constants().Name + ' Build ' + pversion);
SalesChannel.proc_Build_All(
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
