#OPTION('MultiplePersistInstances', false);
version := '20181113';
		ingested	:= Cortera_Tradeline.Ingest();


stats1 :=	ingested.DoStats;
stats2 := ingested.ValidityStats;
lfn := Cortera_Tradeline.Promote().sfBase + '::' + version;
allrecs := ingested.AllRecords_notag;
newbase := Cortera_Tradeline.proc_link_bip(Cortera_tradeline.proc_remove_dups(allrecs));

SEQUENTIAL(
  OUTPUT(version, named('version')),
	cortera_tradeline.Spray(version),
	OUTPUT(newbase,,lfn,compressed, overwrite, named('allrecs')),
	OUTPUT(CHOOSEN(ingested.newrecords, 500), named('newrecords')),
	OUTPUT(CHOOSEN(ingested.updatedrecords, 500), named('updated')),
	cortera_Tradeline.promote().PromoteBase(lfn),
	cortera_tradeline.BuildKeys(version),
  OUTPUT(ingested.StandardStats(), ALL, NAMED('StandardStats')),
	stats1, stats2,
	cortera_tradeline.UpdateDops(version),
	cortera_tradeline.CreateOrbitEntry(version)
	);
