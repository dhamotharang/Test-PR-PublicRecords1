import _control,Judges;

pversion				:= '20110303'																	;
pDirectory			:= '/prod_data_build_13/eval_data/judge_data/';
pServerIP				:= _control.IPAddress.edata10									;
pFilename				:= '*txt'																			;
pGroupName			:= Judges._dataset().groupname								;																
pIsTesting			:= false																			;
pOverwrite			:= false																			;															
pSprayedFile		:= Judges.Files().Input.using									;
pBaseFile				:= Judges.Files().base.qa											;

#workunit('name', Judges._Dataset().Name + ' Build ' + pversion);
Judges.Build_All(
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
