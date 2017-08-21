import _control;
/*
	Check the following:
	
		business_header.Filters
		business_header.Flags
*/


pversion								:= ''										;
pOverwrite							:= false												;
pShouldPromote2QA 			:= true													;
pShouldUpdateDOPS				:= false												;


#workunit ('name', 'Build PRTE Business Header ' + pversion);
//#workunit ('protect', true);
#OPTION('multiplePersistInstances',FALSE);

PRTE2_Business_Header.proc_Build_All(
	 pversion	
	,pOverwrite
	,pShouldPromote2QA
).all;