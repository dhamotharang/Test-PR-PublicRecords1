import doxie_build,Criminal_Records;
export proc_build_DOC_keys(string filedate) := function

return sequential(
		hygenics_crim.proc_build_DOC_offenders_key(filedate),
		hygenics_crim.proc_build_DOC_fcra_offenders_key(filedate),
		hygenics_crim.proc_build_autokey(filedate),
		hygenics_crim.proc_build_DOC_offenses_key(filedate),
		hygenics_crim.proc_build_DOC_activity_key(filedate),
		hygenics_crim.proc_build_DOC_court_offenses_key(filedate),
		hygenics_crim.proc_build_DOC_punishment_key(filedate)
		);
end;