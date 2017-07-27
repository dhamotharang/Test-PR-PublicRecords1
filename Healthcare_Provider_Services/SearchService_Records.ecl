import DOXIE,iesp,AutoheaderI,ut,doxie_files, Address,Prof_LicenseV2_Services, Ingenix_NatlProf, doxie_cbrs, clia,Healthcare_Header_Services;

EXPORT SearchService_Records(Healthcare_Header_Services.IParams.searchParams aInputData, dataset(Healthcare_Header_Services.Layouts.common_runtime_config) cfg) := FUNCTION

	provRec := Healthcare_Header_Services.Records.getSearchServiceRecords(aInputData, cfg);
	recs := if(cfg[1].IncludeSanctionsOnly and not cfg[1].IncludeProvidersOnly,provRec(exists(sanctions)),provRec);
	recsFinal := project(recs,transform(iesp.healthcareconsolidatedsearch.t_HealthCareConsolidatedSearchProvider,
											self := left;
											self := []));

	return recsFinal;
	
END;

