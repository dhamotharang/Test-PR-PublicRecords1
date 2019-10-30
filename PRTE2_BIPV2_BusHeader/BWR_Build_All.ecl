import _control;

pversion								:= '20190823'										;
pOverwrite							:= false												;
pShouldPromote2QA 			:= true													;
pShouldUpdateDOPS				:= false												;


#workunit ('name', 'Build PRTE BIPV2 Business Header ' + pversion);
//#workunit ('protect', true);
#OPTION('multiplePersistInstances',FALSE);

PRTE2_BIPV2_BusHeader.proc_Build_All(
	 pversion	
	,pOverwrite
	,pShouldPromote2QA
).all;