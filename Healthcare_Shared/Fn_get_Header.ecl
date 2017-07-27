IMPORT Healthcare_Shared;
EXPORT Fn_get_Header := module
	//The module is intended to be used as a collector of raw data based on the results from the header search
	Export getEnclarityRecords (dataset(Healthcare_Shared.Layouts.searchKeyResults_plus_input) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
		Enclarity := Healthcare_Shared.Fn_get_MPRD.get_mprd_entity(input(src = Healthcare_Shared.Constants.SRC_MPRD),cfg);
		return Enclarity;
	end;
	Export getAMSRecords (dataset(Healthcare_Shared.Layouts.searchKeyResults_plus_input) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
		AMS := Healthcare_Shared.Fn_get_AMS.get_ams_entity(input(src = Healthcare_Shared.Constants.SRC_AMS),cfg);
		return AMS;
	end;
	Export getDEARecords (dataset(Healthcare_Shared.Layouts.searchKeyResults_plus_input) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
		DEA := Healthcare_Shared.Fn_get_DEA.get_dea_entity(input(src = Healthcare_Shared.Constants.SRC_DEA),cfg);
		return DEA;
	end;
	Export getNPPESRecords (dataset(Healthcare_Shared.Layouts.searchKeyResults_plus_input) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
		NPPES := Healthcare_Shared.Fn_get_NPPES.get_nppes_entity(input(src = Healthcare_Shared.Constants.SRC_NPPES),false,cfg);
		return NPPES;
	end;
	Export getProfLicRecords (dataset(Healthcare_Shared.Layouts.searchKeyResults_plus_input) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
		ProfLic := Healthcare_Shared.Fn_get_ProfLic.get_proflic_entity(input(src = Healthcare_Shared.Constants.SRC_PROFLIC),cfg);
		return ProfLic;
	end;
	Export getCLIARecords (dataset(Healthcare_Shared.Layouts.searchKeyResults_plus_input) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
		Clia := Healthcare_Shared.Fn_get_CLIA.get_clia_entity(input(src = Healthcare_Shared.Constants.SRC_CLIA),cfg);
		return Clia;
	end;
	Export getNCPDPRecords (dataset(Healthcare_Shared.Layouts.searchKeyResults_plus_input) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
		NCPDP := Healthcare_Shared.Fn_get_NCPDP.get_ncpdp_entity(input(src = Healthcare_Shared.Constants.SRC_NCPDP),cfg);
		return NCPDP;
	end;
	Export getRecords (dataset(Healthcare_Shared.Layouts.searchKeyResults_plus_input) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
		//data from each datasource and merger
		EnclarityIndv := getEnclarityRecords(input,cfg);
		AMSIndv := getAMSRecords(input,cfg);
		DeaIndv := getDEARecords(input,cfg);
		NpiIndv := getNPPESRecords(input,cfg);
		ProfLicIndv := getProfLicRecords(input,cfg);
		baseRecs := group(sort(EnclarityIndv+AMSIndv+DeaIndv+NpiIndv+ProfLicIndv,acctno,lnpid),acctno,lnpid);
		//Rollup Records
		baseRecs_Rolled := rollup(baseRecs, group, Healthcare_Shared.Transforms.doFinalRollup(left,rows(left),cfg));
		// output(input,Named('IndividualInput'));
		// output(EnclarityIndv,Named('EnclarityIndv'));
		// output(AMSIndv,Named('AMSIndv'));
		// output(DeaIndv,Named('DeaIndv'));
		// output(NpiIndv,Named('NpiIndv'));
		// output(ProfLicIndv,Named('ProfLicIndv'));
		// output(baseRecs,named('Hdr_Recs_baseRecs'));
		// output(baseRecs_Rolled,named('Hdr_Recs_baseRecs_Rolled'));
		return baseRecs_Rolled;
	end;
	Export getBusRecords (dataset(Healthcare_Shared.Layouts.searchKeyResults_plus_input) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
		//data from each datasource and merger
		EnclarityBus := getEnclarityRecords(input,cfg);
		DeaBus := getDEARecords(input,cfg);
		NpiBus := getNPPESRecords(input,cfg);
		ProfLicBus := getProfLicRecords(input,cfg);
		CLIABus := getCLIARecords(input,cfg);
		NCPDPBus := getNCPDPRecords(input,cfg);
		baseRecs := group(sort(EnclarityBus+DeaBus+NpiBus+ProfLicBus+CLIABus+NCPDPBus,acctno,lnpid),acctno,lnpid);
		//Rollup Records
		baseRecs_Rolled := rollup(baseRecs, group, Healthcare_Shared.Transforms.doFinalRollup(left,rows(left),cfg));
		// output(input,Named('BusinessInput'));
		// output(EnclarityBus,Named('EnclarityBus'));
		// output(DeaBus,Named('DeaBus'));
		// output(NpiBus,Named('NpiBus'));
		// output(ProfLicBus,Named('ProfLicBus'));
		// output(CLIABus,Named('CLIABus'));
		// output(NCPDPBus,Named('NCPDPBus'));
		// output(baseRecs,named('Hdr_Recs_baseRecs'));
		// output(baseRecs_Rolled,named('Hdr_Recs_baseRecs_Rolled'));
		return baseRecs_Rolled;
	end;
end;