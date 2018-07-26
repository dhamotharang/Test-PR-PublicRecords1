EXPORT GetActiveWU(string wuname) := function

	valid_state := ['','unknown','submitted', 'compiling','compiled','blocked','running','wait'];
	d := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wuname))(wuid <> thorlib.wuid() and state in valid_state), -wuid):independent;
	active_workunit :=  exists(d);

	return active_workunit;

END;