
export proc_build_all(string version) :=
function
	#workunit('name','FAA Build ' + version)
	import orbit_report,scrubs_faa;
	spray_all := faa.Spray_In(version) : success(output('SPRAY FAA FILES SUCCESS')), failure(output('SPRAY FAA FILES FAILED'));
	build_in := Sequential( aircraft_preprocess(version),airmen_preprocess(version)) : success(output('INPUT FILES BUILT SUCCESSFULLY')), failure(output(' INPUT FILES BUILT FAILED'));
	build_base := proc_build_base(version)    : success(output('BASE FILES BUILT SUCCESSFULLY')), failure(output('BUILDING BASE FILES FAILED'));
	build_keys := proc_build_keys(version)    : success(output('ROXIE KEYS BUILT SUCCESSFULLY')), failure(output('ROXIE KEY BUILD FAILED'));
	build_sample := faa.QA_Samples ;
	build_strata := out_base_dev_stats(version) : success(output('STRATA STATS BUILT SUCCESSFULLY')), failure(output('STRATA STATS FAILED'));
	orbit_report.Aircraft_Stats(getaircraft);
	orbit_report.Airmen_Stats(getairmen);
	return sequential(spray_all,build_in,build_base,build_keys,build_sample,build_strata,Scrubs_FAA.fnRunScrubs(version,''),getaircraft,getairmen,faa.coverage);
end;