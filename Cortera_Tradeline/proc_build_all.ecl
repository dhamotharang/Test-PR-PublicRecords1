import Cortera, dops, header;

EXPORT proc_build_all ( string pversion, boolean pDeltaBuild = false, boolean pIsTesting = false) := function

	build_name := 'Cortera Tradeline';
	DopsEmail  := 'Sudhir.Kasavajjala@lexisnexisrisk.com,Michael.Gould@lexisnexis.com,QualityAssurance@seisint.com,Charles.Salvo@lexisnexisrisk.com';
	
	boolean isnewheader := header.IsNewProdHeaderVersion('Utility','bip_build_version');
		
	BuildType := if(pDeltaBuild or ~isnewheader, 1, 2);
	//BuildType := if(pDeltaBuild, 1, 2);
	
	boolean isDelta := nothor(if(BuildType = Cortera_Tradeline._Flags.BuildType.DeltaBuild, true, false));
			
	string1 pUpdateFlag	:=	if(isDelta,'D','F');

	build_all := SEQUENTIAL(
			OUTPUT(pversion, named('pversion')),
			OUTPUT(if(isDelta,'DELTA Build','FULL Build'), named('isDelta')),
			Cortera_Tradeline.Create_Supers,
			Cortera_Tradeline.Spray(pversion),
			Cortera_Tradeline.Build_Base(pversion,pIsTesting,isDelta),
			Cortera_Tradeline.BuildKeys(pversion,isDelta),
			Cortera_Tradeline.Promote(pversion,pIsDeltaBuild:=isDelta).Buildfiles.Built2QA,
			Cortera_Tradeline.BuildTradelineScrubsReport(pversion),
			Cortera_Tradeline.Promote().Inputfiles.Using2Used,
			dops.updateversion('CorteraTradelineKeys',pversion,DopsEmail,,'N',l_updateflag:=pUpdateFlag),
			Cortera.UpdateOrbit(pversion,build_name)

	): 
		success(Cortera.send_emails(pversion,,not pIsTesting,,,,Cortera_Tradeline._Constants().Name).buildsuccess), 
		failure(Cortera.send_emails(pversion,,not pIsTesting,,,,Cortera_Tradeline._Constants().Name).buildfailure);
		
	return build_all;
end;