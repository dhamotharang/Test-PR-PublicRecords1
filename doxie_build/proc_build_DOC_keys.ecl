import doxie_build,Criminal_Records;
export proc_build_DOC_keys(string filedate) := function

return sequential(
		Criminal_Records.proc_build_autokey(filedate),
		proc_build_DOC_offenders_key(filedate),
		proc_build_DOC_offenses_key(filedate),
		proc_build_DOC_activity_key(filedate),
		proc_build_DOC_court_offenses_key(filedate),
		proc_build_DOC_punishment_key(filedate));
//	  proc_build_DOC_FCRA_keys(filedate));
		
end;