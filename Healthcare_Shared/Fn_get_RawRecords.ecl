EXPORT Fn_get_RawRecords := module
	//The module is intended to be used as a collector of raw data based on the results from the header search
	Export getEnclarityRecords (dataset(Healthcare_Shared.Layouts_Header.CandidateRecords) recs,dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
		Enclarity := Healthcare_Shared.Fn_get_MPRD.get_mprd_entity(recs(src = Healthcare_Shared.Constants.SRC_MPRD),input,cfg);
		return Enclarity;
	end;
	// Export getAMSRecords (dataset(Healthcare_Shared.Layouts_Header.CandidateRecords) recs,dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
		// AMS := Healthcare_Shared.Fn_get_AMS.get_ams_entity(recs(src = Healthcare_Shared.Constants.SRC_AMS),input,cfg);
		// return AMS;
	// end;
	Export getDEARecords (dataset(Healthcare_Shared.Layouts_Header.CandidateRecords) recs,dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
		DEA := Healthcare_Shared.Fn_get_DEA.get_dea_entity(recs(src = Healthcare_Shared.Constants.SRC_DEA),input,cfg);
		return DEA;
	end;
	Export getNPPESRecords (dataset(Healthcare_Shared.Layouts_Header.CandidateRecords) recs,dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
		NPPES := Healthcare_Shared.Fn_get_NPPES.get_nppes_entity(recs(src = Healthcare_Shared.Constants.SRC_NPPES),input,false,cfg);
		return NPPES;
	end;
	Export getProfLicRecords (dataset(Healthcare_Shared.Layouts_Header.CandidateRecords) recs,dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
		ProfLic := Healthcare_Shared.Fn_get_ProfLic.get_proflic_entity(recs(src = Healthcare_Shared.Constants.SRC_PROFLIC),input,cfg);
		return ProfLic;
	end;
	Export getCLIARecords (dataset(Healthcare_Shared.Layouts_Header.CandidateRecords) recs,dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
		Clia := Healthcare_Shared.Fn_get_CLIA.get_clia_entity(recs(src = Healthcare_Shared.Constants.SRC_CLIA),input,cfg);
		return Clia;
	end;
	Export getNCPDPRecords (dataset(Healthcare_Shared.Layouts_Header.CandidateRecords) recs,dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
		NCPDP := Healthcare_Shared.Fn_get_NCPDP.get_ncpdp_entity(recs(src = Healthcare_Shared.Constants.SRC_NCPDP),input,cfg);
		return NCPDP;
	end;
	Export getProviderRecords (dataset(Healthcare_Shared.Layouts_Header.CandidateRecords) recs,dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
		filterProviders := recs(srcIndividualHeader=true);
		getProviders := getEnclarityRecords(filterProviders,input,cfg) +
										// getAMSRecords(filterProviders,input,cfg) +
										getDEARecords(filterProviders,input,cfg) +
										getNPPESRecords(filterProviders,input,cfg) +
										getProfLicRecords(filterProviders,input,cfg);
		baseRecs := sort(getProviders,acctno,lnpid);
		return baseRecs;
	end;
	Export getFacilityRecords (dataset(Healthcare_Shared.Layouts_Header.CandidateRecords) recs,dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
		filterFacilities := recs(srcBusinessHeader=true);
		getFacilities := getEnclarityRecords(filterFacilities,input,cfg) +
										getDEARecords(filterFacilities,input,cfg) +
										getNPPESRecords(filterFacilities,input,cfg) +
										getProfLicRecords(filterFacilities,input,cfg) +
										getCLIARecords(filterFacilities,input,cfg) +
										getNCPDPRecords(filterFacilities,input,cfg);
		baseRecs := sort(getFacilities,acctno,lnfid);
		return baseRecs;
	end;
	Export getRecords (dataset(Healthcare_Shared.Layouts_Header.CandidateRecords) recs,dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
		getProviders := getProviderRecords(recs,input,cfg);
		getFacilities := getFacilityRecords(recs,input,cfg);
		baseRecs := sort(getProviders+getFacilities,acctno,lnpid,lnfid);
		return baseRecs;
	end;
end;