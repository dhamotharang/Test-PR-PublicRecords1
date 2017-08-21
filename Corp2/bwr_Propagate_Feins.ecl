string				pNewVersion					:= '20080208b'	;
set of string	pSetPropagateStates	:= ['MI']				;
string				pPropagateVersion		:= 'father'			;
boolean				pOverwrite					:= false				;

#workunit('name', 'Corp2 Propagate Feins Process ' + pNewVersion);

corp2.proc_Propagate_Feins(

	 pNewVersion
	,pSetPropagateStates
	,pPropagateVersion
	,pOverwrite
	
);