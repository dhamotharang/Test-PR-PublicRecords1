import Cortera;
EXPORT proc_build_all ( string pversion, boolean pDeltaBuild = false, boolean pIsTesting = false) := function

	build_name := 'Cortera Tradeline';
	
	BuildType := if (pDeltaBuild, 1, 2);

	build_all := SEQUENTIAL(
			OUTPUT(pversion, named('pversion')),
			Cortera_Tradeline.Create_Supers,
			Cortera_Tradeline.Spray(pversion),
			if (BuildType = Cortera_Tradeline._Flags.BuildType.DeltaBuild,
					Cortera_Tradeline.Build_Base(pversion,,pDeltaBuild),
					Cortera_Tradeline.Build_Base(pversion)
				 ),
			Cortera_Tradeline.BuildKeys(pversion,pDeltaBuild),
			Cortera_Tradeline.Promote(pversion, pIsDeltaBuild:=pDeltaBuild).Buildfiles.Built2QA,
			Cortera_Tradeline.BuildTradelineScrubsReport(pversion),
			Cortera_Tradeline.Promote().Inputfiles.Using2Used,
			Cortera.UpdateDops(pversion,build_name),
			Cortera.UpdateOrbit(pversion,build_name)
	): 
		success(Cortera.send_emails(pversion,,not pIsTesting,,,,Cortera_Tradeline._Constants().Name).buildsuccess), 
		failure(Cortera.send_emails(pversion,,not pIsTesting,,,,Cortera_Tradeline._Constants().Name).buildfailure);
		
	return build_all;
end;