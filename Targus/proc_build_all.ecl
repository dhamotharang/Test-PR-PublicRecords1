import ut, Orbit3;

export proc_build_all(string versionDate, string emailList='') := function
	email := FileServices.sendemail('qualityassurance@seisint.com','TARGUS MONTHLY SAMPLE READY','at ' + thorlib.WUID());
	
	buildBase	:=	proc_build_base;
	
	orbit_update := Orbit3.proc_Orbit3_CreateBuild_AddItem('White Pages',(string)versionDate,'N');
	orbit_updatef := Orbit3.proc_Orbit3_CreateBuild_AddItem('FCRA_White_Pages',(string)versionDate,'F');
		
	return sequential(
		spray_targusOrig(versionDate),
		sample_targusIn,
		buildBase(versionDate,EmailList),
		proc_build_keys(versionDate),
		parallel(
			sample_TargusBase,
			strata_popFileConsumerBase,
			strata_consumerAsHeaderstats(versionDate)
		),
		email,
		orbit_update,
		orbit_updatef
	);
end;