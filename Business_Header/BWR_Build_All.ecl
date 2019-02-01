import _control;
/*
	Check the following:
	
		business_header.Filters
		business_header.Flags
*/


pversion								:= ''										;
pOverwrite							:= false												;
pShouldPromote2QA 			:= true													;
pShouldRollbackSources	:= true													;
pShouldSendToStrata			:= true													;

#workunit ('name', 'Yogurt:Build Business Header ' + pversion);
#workunit ('protect', true);
#OPTION('multiplePersistInstances',FALSE);

Business_Header.proc_Build_All(
	 pversion	
	,pOverwrite
	,pShouldPromote2QA 		
	,pShouldRollbackSources
	,pShouldSendToStrata
).all;