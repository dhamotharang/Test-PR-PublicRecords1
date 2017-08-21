import ut;

export proc_build_all(string versionDate, string emailList='') := function
	email := FileServices.sendemail('qualityassurance@seisint.com','TARGUS MONTHLY SAMPLE READY','at ' + thorlib.WUID());
	
	buildBase	:=	proc_build_base;
		
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
		email
	);
end;