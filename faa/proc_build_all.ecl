
export proc_build_all(string version) :=
function
	#workunit('name','FAA Build ' + version)
	import orbit_report;
	build_base := proc_build_base(version)    : success(output('BASE FILES BUILT SUCCESSFULLY')), failure(output('BUILDING BASE FILES FAILED'));
	build_keys := proc_build_keys(version)    : success(output('ROXIE KEYS BUILT SUCCESSFULLY')), failure(output('ROXIE KEY BUILD FAILED'));
	build_strata := out_base_dev_stats(version) : success(output('STRATA STATS BUILT SUCCESSFULLY')), failure(output('STRATA STATS FAILED'));
	orbit_report.Aircraft_Stats(getaircraft);
	orbit_report.Airmen_Stats(getairmen);
	return sequential(build_base,build_keys,build_strata,getaircraft,getairmen,faa.coverage);
end;