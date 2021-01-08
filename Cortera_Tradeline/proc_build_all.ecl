import Cortera;
EXPORT proc_build_all ( string pversion, boolean pDeltaBuild = false, boolean pIsTesting = false) := function

	build_name := 'Cortera Tradeline';

	//stats1 :=	Cortera_Tradeline.Ingest(pversion).DoStats;
	//stats2 := Cortera_Tradeline.Ingest(pversion).ValidityStats;
	
	BuildType := if (pDeltaBuild, 1, 2);

	build_all := SEQUENTIAL(
			OUTPUT(pversion, named('pversion')),
			Cortera_Tradeline.Create_Supers,
			Cortera_Tradeline.Spray(pversion),
			if (BuildType = Cortera_Tradeline._Flags.BuildType.DeltaBuild,
					Cortera_Tradeline.Build_Base(pversion,,pDeltaBuild),
					Cortera_Tradeline.Build_Base(pversion)
				 ),

			//OUTPUT(CHOOSEN(Cortera_Tradeline.Ingest(pversion).newrecords, 500), named('newrecords')),
			//OUTPUT(CHOOSEN(Cortera_Tradeline.Ingest(pversion).updatedrecords, 500), named('updated')),
	
			Cortera_Tradeline.BuildKeys(pversion,pDeltaBuild),
			
			Cortera_Tradeline.Promote(pversion, pIsDeltaBuild:=pDeltaBuild).Buildfiles.Built2QA,
			Cortera_Tradeline.Promote().Inputfiles.Using2Used,
			//OUTPUT(Cortera_Tradeline.Ingest(pversion).StandardStats(), ALL, NAMED('StandardStats')),
			//stats1, 
			//stats2,
			Cortera_Tradeline.BuildTradelineScrubsReport(pversion),
			Cortera.UpdateDops(pversion,build_name),
			Cortera.UpdateOrbit(pversion,build_name)

	): 
		success(Cortera.send_emails(pversion,,not pIsTesting,,,,Cortera_Tradeline._Constants().Name).buildsuccess), 
		failure(Cortera.send_emails(pversion,,not pIsTesting,,,,Cortera_Tradeline._Constants().Name).buildfailure);
		
	return build_all;
end;