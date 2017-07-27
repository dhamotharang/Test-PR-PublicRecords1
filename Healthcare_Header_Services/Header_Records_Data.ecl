EXPORT Header_Records_Data := module
	//The module is intended to be used as a collector of raw data based on the results from the header search
	Export getEnclarityRecords (dataset(Layouts.searchKeyResults_plus_input) inputraw,dataset(Layouts.common_runtime_config) cfg):= function
		dataRestrictEnclarity := cfg[1].DRM[19] not in ['0',''];//if there is a value other than blank or Zero Restrict
		input := if (dataRestrictEnclarity,dataset([],Layouts.searchKeyResults_plus_input),inputraw);
		Enclarity := Healthcare_Header_Services.Datasource_SelectFile.get_selectfile_entity(input(src = Constants.SRC_SELECTFILE),cfg);
//output(inputraw,named('inputgetEnclarityRecords'),extend);		
		return Enclarity;
	end;
	
	
	Export getDEARecords (dataset(Layouts.searchKeyResults_plus_input) input,dataset(Layouts.common_runtime_config) cfg):= function
		DEA := Healthcare_Header_Services.Datasource_DEA.get_dea_entity(input(src = Constants.SRC_DEA),cfg);
		return DEA;
	end;
	Export getNPPESRecords (dataset(Layouts.searchKeyResults_plus_input) input,dataset(Layouts.common_runtime_config) cfg):= function
		NPPES := Healthcare_Header_Services.Datasource_NPPES.get_nppes_entity(input(src = Constants.SRC_NPPES),false,cfg);
		return NPPES;
	end;
	Export getProfLicRecords (dataset(Layouts.searchKeyResults_plus_input) input,dataset(Layouts.common_runtime_config) cfg):= function
		ProfLic := Healthcare_Header_Services.Datasource_ProfLic.get_proflic_entity(input(src = Constants.SRC_PROFLIC),cfg);
		return ProfLic;
	end;
	Export getCLIARecords (dataset(Layouts.searchKeyResults_plus_input) input,dataset(Layouts.common_runtime_config) cfg):= function
		Clia := Healthcare_Header_Services.Datasource_Clia.get_clia_entity(input(src = Constants.SRC_CLIA),cfg);
		return Clia;
	end;
	Export getNCPDPRecords (dataset(Layouts.searchKeyResults_plus_input) input,dataset(Layouts.common_runtime_config) cfg):= function
		NCPDP := Healthcare_Header_Services.Datasource_NCPDP.get_ncpdp_entity(input(src = Constants.SRC_NCPDP),cfg);
		return NCPDP;
	end;
	
  Export getHMSRecords (dataset(Layouts.searchKeyResults_plus_input) input,dataset(Layouts.common_runtime_config) cfg):= function
		   HMS := Healthcare_Header_Services.Datasource_hms.get_hms_entity(input,cfg);
		 return HMS;
	end;	
	
	Export getRecords (dataset(Layouts.searchKeyResults_plus_input) input,dataset(Layouts.common_runtime_config) cfg):= function
		//data from each datasource and merger
		EnclarityIndv := getEnclarityRecords(input,cfg);
		HMSIndv := getHMSRecords(input,cfg);
		DeaIndv := getDEARecords(input,cfg);
		NpiIndv := getNPPESRecords(input,cfg);
		ProfLicIndv := getProfLicRecords(input,cfg);
		combined := EnclarityIndv+HMSIndv+DeaIndv+NpiIndv+ProfLicIndv;
		getFailed := join(input,combined,left.acctno=right.acctno,transform(layouts.CombinedHeaderResults, self:=left,self:=[];),left only);
		baseRecs := group(sort(combined+getFailed,acctno,lnpid),acctno,lnpid);
		//Rollup Records
		baseRecs_Rolled := rollup(baseRecs, group, Transforms.doFinalRollup(left,rows(left)));
		 
		return baseRecs_Rolled;
	end;
	Export getBusRecords (dataset(Layouts.searchKeyResults_plus_input) input,dataset(Layouts.common_runtime_config) cfg):= function
		//data from each datasource and merger
		EnclarityBus := getEnclarityRecords(input,cfg);
		DeaBus := getDEARecords(input,cfg);
		NpiBus := getNPPESRecords(input,cfg);
		ProfLicBus := getProfLicRecords(input,cfg);
		CLIABus := getCLIARecords(input,cfg);
		NCPDPBus := getNCPDPRecords(input,cfg);
		HMSBus:=    getHMSRecords(input,cfg);
		baseRecs := group(sort(EnclarityBus+DeaBus+NpiBus+ProfLicBus+CLIABus+NCPDPBus+HMSBus,acctno,lnpid,facilitytype<>''),acctno,lnpid,facilitytype<>'');
		//Rollup Records
		baseRecs_Rolled := rollup(baseRecs, group, Transforms.doFinalRollup(left,rows(left)));
		return baseRecs_Rolled;
	end;
end;