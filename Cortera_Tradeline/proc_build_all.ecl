import Cortera;
EXPORT proc_build_all ( string version) := function

build_name := 'Cortera Tradeline';


stats1 :=	Cortera_Tradeline.Ingest().DoStats;
stats2 := Cortera_Tradeline.Ingest().ValidityStats;
lfn := Cortera_Tradeline.Promote().sfBase + '::' + version;
allrecs := Cortera_Tradeline.Ingest().AllRecords_notag;
newbase := Cortera_Tradeline.proc_link_bip(Cortera_tradeline.proc_remove_dups(allrecs));

build_all := SEQUENTIAL(
  OUTPUT(version, named('version')),
	cortera_tradeline.Spray(version),
	OUTPUT(newbase,,lfn,compressed, overwrite, named('allrecs')),
	OUTPUT(CHOOSEN(Cortera_Tradeline.Ingest().newrecords, 500), named('newrecords')),
	OUTPUT(CHOOSEN(Cortera_Tradeline.Ingest().updatedrecords, 500), named('updated')),
	cortera_Tradeline.promote().PromoteBase(lfn),
	cortera_tradeline.BuildKeys(version),
  OUTPUT(Cortera_Tradeline.Ingest().StandardStats(), ALL, NAMED('StandardStats')),
	stats1, stats2,
	Cortera_Tradeline.BuildTradelineScrubsReport(version),
	Cortera.UpdateDops(version,build_name),
	Cortera.UpdateOrbit(version,build_name)
	) : success(Cortera.Send_Email(version,build_name).buildsuccess), failure(Cortera.Send_Email(version,build_name).buildfailure);
return build_all;
end;