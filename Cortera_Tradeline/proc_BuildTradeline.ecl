EXPORT proc_BuildTradeline(string version) := FUNCTION

		ingested	:= Cortera_Tradeline.Ingest();


	stats1 :=	ingested.DoStats;
	stats2 := ingested.ValidityStats;
	lfn := Cortera_Tradeline.Promote().sfBase + '::' + version;
	allrecs := ingested.AllRecords_notag;
	newbase := Cortera_Tradeline.proc_link_bip(allrecs);

	return SEQUENTIAL(
		OUTPUT(version, named('version')),
		cortera_tradeline.Spray(version),
		OUTPUT(newbase,,lfn,compressed, overwrite, named('allrecs')),
		OUTPUT(CHOOSEN(ingested.newrecords, 500), named('newrecords')),
		OUTPUT(CHOOSEN(ingested.updatedrecords, 500), named('updated')),
		//OUTPUT(CHOOSEN(ingested.updatedrecords, 500), named('updated')),
		cortera_Tradeline.promote().PromoteBase(lfn),
		stats1, stats2
	);
END;
