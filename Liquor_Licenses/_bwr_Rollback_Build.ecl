////////////////////////////////////////////////////////////////////
// -- Change the pState attribute to a specific state to 
// -- rollback just that state.  When blank, it rolls back all states
////////////////////////////////////////////////////////////////////

pstate := '';
Workunitname := if(pstate = ''
									,'Rollback ' + Liquor_Licenses._Dataset.name + ' Build'
									,'Rollback ' + Liquor_Licenses._Dataset.name + ' ' + pstate + ' Build'
								);

#workunit('name', Workunitname);

sequential(
	 Liquor_Licenses.Rollback(pstate).Input.Used2Sprayed()
	,Liquor_Licenses.Rollback(pstate).Father2QA()
);