/*--SOAP--
<message name="SearchService">
	<!-- COMPLIANCE SETTINGS -->
	<part name="HealthCareConsolidatedSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/

import iesp, AutoStandardI;

export ResearchService := MACRO
	ds_in := DATASET ([], iesp.healthcareconsolidatedsearch.t_HealthCareConsolidatedSearchRequest) : STORED('HealthCareConsolidatedSearchRequest', FEW);
	
	first_row := ds_in[1] : INDEPENDENT;	
	iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);
	iesp.ECL2ESP.SetInputSearchOptions(first_row.options);	  
	iesp.ECL2ESP.SetInputReportBy (ROW (first_row.searchBy, transform (iesp.bpsreport.t_BpsReportBy, Self := Left, Self := [])), true);
	string11 Taxid       := trim(first_row.searchBy.Taxid);
	#stored('Taxid', Taxid);
	string11 Fein       := trim(first_row.searchBy.FEIN);
	#stored('Fein', Fein);
  STRING CompanyName := trim(first_row.searchBy.CompanyName);
	#STORED('CompanyName', CompanyName);
	unsigned1 PenaltThreshold := first_row.Options.penaltythreshold;
	#stored ('PenaltThreshold', PenaltThreshold);	
	stateLicenseDS := dataset([{1,1,first_row.searchby.LicenseState,first_row.searchby.LicenseNumber,'',''},
														 {1,2,first_row.searchby.LicenseState2,first_row.searchby.LicenseNumber2,'',''},
														 {1,3,first_row.searchby.LicenseState3,first_row.searchby.LicenseNumber3,'',''},
														 {1,4,first_row.searchby.LicenseState4,first_row.searchby.LicenseNumber4,'',''},
														 {1,5,first_row.searchby.LicenseState5,first_row.searchby.LicenseNumber5,'',''},
														 {1,6,first_row.searchby.LicenseState6,first_row.searchby.LicenseNumber6,'',''},
														 {1,7,first_row.searchby.LicenseState7,first_row.searchby.LicenseNumber7,'',''},
														 {1,8,first_row.searchby.LicenseState8,first_row.searchby.LicenseNumber8,'',''},
														 {1,9,first_row.searchby.LicenseState9,first_row.searchby.LicenseNumber9,'',''},
														 {1,10,first_row.searchby.LicenseState10,first_row.searchby.LicenseNumber10,'',''}
															],Healthcare_Provider_Services.IParams.licenseinfo);
  	
	input_params := AutoStandardI.GlobalModule();
	aInputData:= MODULE(PROJECT(input_params, Healthcare_Provider_Services.IParams.searchParams,opt))		
		EXPORT unsigned2 	penalty_threshold := input_params.penalty_threshold;
		EXPORT STRING 		NPI := first_row.searchby.NPINumber;
		EXPORT STRING 		UPIN := first_row.searchby.UPIN;
		EXPORT string11 	Fein := AutoStandardI.InterfaceTranslator.fein_val.val(project(input_params, AutoStandardI.InterfaceTranslator.fein_val.params));  
		EXPORT STRING 		MedicalSchoolName := first_row.searchby.MedicalSchoolName;
		EXPORT integer 		GraduationYear := first_row.searchby.GraduationYear;
		EXPORT STRING30 	LastName := AutoStandardI.InterfaceTranslator.lname_value.val(project(input_params, AutoStandardI.InterfaceTranslator.lname_value.params));      			
		EXPORT STRING30 	FirstName := AutoStandardI.InterfaceTranslator.fname_value.val(project(input_params, AutoStandardI.InterfaceTranslator.fname_value.params));      			
		EXPORT STRING30 	MiddleName := AutoStandardI.InterfaceTranslator.mname_value.val(project(input_params, AutoStandardI.InterfaceTranslator.mname_value.params));      			
		EXPORT string120 	CompanyName := AutoStandardI.InterfaceTranslator.company_name.val(project(input_params, AutoStandardI.InterfaceTranslator.company_name_value.params));
		EXPORT BOOLEAN 		includeProvidersOnly := first_row.options.IncludeProvidersOnly;
		EXPORT boolean 		IncludeGroupAffiliations := first_row.options.IncludeGroupAffiliations;
		EXPORT boolean 		IncludeHospitalAffiliations := first_row.options.IncludeHospitalAffiliations;
		EXPORT boolean 		IncludeSpecialties  := first_row.options.IncludeSpecialties;
		EXPORT boolean 		IncludeLicenses  := first_row.options.IncludeLicenses;
		EXPORT boolean 		IncludeResidencies  := first_row.options.IncludeResidencies;
		EXPORT BOOLEAN 		includeSanctionsOnly := first_row.options.IncludeSanctionsOnly;
		Export dataset(Healthcare_Provider_Services.IParams.licenseinfo) StateLicenses := stateLicenseDS(LicenseNumber<>'');
		EXPORT STRING 		DEA := first_row.searchby.DEANumber;
		EXPORT string15		CLIANumber := first_row.searchby.CLIANumber;
		EXPORT string15		Taxonomy := first_row.searchby.Taxonomy;
		export unsigned6  ProviderId := (integer)first_row.searchby.ProviderId;
		export string1  	ProviderSrc := stringlib.StringToUpperCase(first_row.searchby.ProviderSrc);
	END;

	maxPenalty := aInputData.penalty_threshold;
	input := Healthcare_Provider_Services.Provider_Records_Consolidated.convertInputtoDataset(aInputData);
	output(input, named('FormattedInput'));
	output(Healthcare_Provider_Services.Provider_Records_SearchKeys.get_ing_recs_License(input),Named('searchby_ing_recs_License'));
	output(Healthcare_Provider_Services.Provider_Records_SearchKeys.get_ams_recs_License(input),Named('searchby_ams_recs_License'));
	output(Healthcare_Provider_Services.Provider_Records_SearchKeys.get_ing_by_fein(input),Named('searchby_ing_by_fein'));
	output(Healthcare_Provider_Services.Provider_Records_SearchKeys.get_ing_by_taxid(input),Named('searchby_ing_by_taxid'));
	output(Healthcare_Provider_Services.Provider_Records_SearchKeys.get_ams_by_fein(input),Named('searchby_ams_by_fein'));
	output(Healthcare_Provider_Services.Provider_Records_SearchKeys.get_ams_by_taxid(input),Named('searchby_ams_by_taxid'));
	output(Healthcare_Provider_Services.Provider_Records_SearchKeys.get_ing_by_upin(input),Named('searchby_ing_by_upin'));
	output(Healthcare_Provider_Services.Provider_Records_SearchKeys.get_ing_by_npi(input),Named('searchby_ing_by_npi'));
	output(Healthcare_Provider_Services.Provider_Records_SearchKeys.get_ams_by_npi(input),Named('searchby_ams_by_npi'));
	output(Healthcare_Provider_Services.Provider_Records_SearchKeys.get_ing_by_dea(input),Named('searchby_ing_by_dea'));
	output(Healthcare_Provider_Services.Provider_Records_SearchKeys.get_ams_by_dea(input),Named('searchby_ams_by_dea'));
	output(Healthcare_Provider_Services.Provider_Records_SearchKeys.get_ing_by_dids(input),Named('searchby_ing_by_dids'));
	output(Healthcare_Provider_Services.Provider_Records_SearchKeys.get_ams_by_dids(input),Named('searchby_ams_by_dids'));
	output(Healthcare_Provider_Services.Provider_Records_SearchKeys.get_sanc_by_dids(input),Named('searchby_sanc_by_dids'));
	output(Healthcare_Provider_Services.Provider_Records_SearchKeys.get_ing_by_ak(input),Named('searchby_get_ing_by_ak'));
	output(Healthcare_Provider_Services.Provider_Records_SearchKeys.get_ams_by_ak(input),Named('searchby_get_ams_by_ak'));
	output(Healthcare_Provider_Services.Provider_Records_SearchKeys.get_sanc_by_ak(input),Named('searchby_get_sanc_by_ak'));
	getPids := Healthcare_Provider_Services.Provider_Records_SearchKeys.getRecordsPIDs(input);
	output(getPids,Named('final_pids'));
	fmtPid_with_Input := Healthcare_Provider_Services.Provider_Records_Functions.appendInputToSearchKeyData(getPids,input);
	ing_pids_raw:= Healthcare_Provider_Services.Provider_Records_Functions.getSearchKeyDataByType(fmtPid_with_Input,Healthcare_Provider_Services.Constants.SRC_ING);
	ams_pids_raw:= Healthcare_Provider_Services.Provider_Records_Functions.getSearchKeyDataByType(fmtPid_with_Input,Healthcare_Provider_Services.Constants.SRC_AMS);
	sanc_pids:= Healthcare_Provider_Services.Provider_Records_Functions.getSearchKeyDataByType(fmtPid_with_Input,Healthcare_Provider_Services.Constants.SRC_SANC);
	getSancBase := Healthcare_Provider_Services.Provider_Records_Sanc.get_sanc_providers_base(sanc_pids,maxPenalty);	
	output(getSancBase,Named('getSancBase'));
	sancLookup := normalize(getSancBase,left.dids,transform(Healthcare_Provider_Services.layouts.autokeyInput, self.did := right.did; self := left; self:=[]));
	output(sancLookup,Named('sancLookup'));
	//Search the data for sanction related ids
	otherLookupPIDs := Healthcare_Provider_Services.Provider_Records_SearchKeys.getRecordsPIDs(sancLookup);
	output(otherLookupPIDs,Named('otherLookupPIDs'));
	//Merge the original input with whatever we found via lookups
	lookupPIDS_with_Input := Healthcare_Provider_Services.Provider_Records_Functions.appendInputToSearchKeyData(otherLookupPIDs,input);
	output(lookupPIDS_with_Input,Named('lookupPIDS_with_Input'));
	combinedPids_with_Input := dedup(sort(fmtPid_with_Input+lookupPIDS_with_Input,acctno,prov_id,src),acctno,prov_id,src);
	output(combinedPids_with_Input,Named('combinedPids_with_Input'));
	getIngBase := Healthcare_Provider_Services.Provider_Records_ING.get_ing_entity(ing_pids_raw,maxPenalty);
	output(getIngBase,Named('getIngBase'));
	slimDown := project(input(providerid>0 or did>0 or bdid>0 or 
														name_first<>'' or name_last<>'' or Comp_name <>'' or
														prim_range<>'' or prim_name<>'' or p_city_name<>'' or st<>'' or z5<>''), 
											transform(Healthcare_Provider_Services.Layouts.layout_slimInput, self:=left;));
	
	//Collect the resolved ing records and filter out to only those we are slimming down
	filterRecs := join (slimDown,getIngBase, left.acctno=right.acctno, 
											transform(Healthcare_Provider_Services.layouts.CombinedHeaderResults, self:=right));
	childDataLicense := normalize(filterRecs,left.StateLicenses,
											transform(Healthcare_Provider_Services.layouts.slimINGforAMSLookup, self := right;self:=left));
	childDataNPI := normalize(filterRecs,left.npis,transform(Healthcare_Provider_Services.layouts.slimINGforAMSLookup, self := right;self:=left));
	childDataDID := normalize(filterRecs,left.dids,transform(Healthcare_Provider_Services.layouts.slimINGforAMSLookup, self := right;self:=left));
	amsLookupRecs := dedup(sort(childDataLicense+childDataNPI+childDataDID,record),record);
	provideridBasedSearch_pids := Healthcare_Provider_Services.Provider_Records_Functions_AMS.checkAMS(amsLookupRecs);
	output(provideridBasedSearch_pids,named('checkAMS'));
	additional_ams_pids:= join(provideridBasedSearch_pids,input, left.acctno = right.acctno, 
														transform(Healthcare_Provider_Services.Layouts.searchKeyResults_plus_input, self:=left;self:=right));
	//Add the lookup pids into the regular pid stream. if the search was initiated via a providerid and it was not a sanction search to start with
	all_ams_pids := if(count(input)=1 and input[1].ProviderID > 0 and input[1].ProviderSrc <> 'S',dedup(sort(ams_pids_raw+additional_ams_pids,acctno,prov_id,src),acctno,prov_id,src),ams_pids_raw);
	getAmsBase := Healthcare_Provider_Services.Provider_Records_AMS.get_ams_entity(all_ams_pids,maxPenalty);
	output(getAmsBase,Named('getAmsBaseWithLookup'));
	customLogic := Healthcare_Provider_Services.Provider_Records_Matching.buildMatchTable(ing_pids_raw,ams_pids_raw);
	output(customLogic,Named('customLogic'));
	ing_providers_final_sorted := sort(getIngBase, acctno, HcId, SrcId, Src);
	ing_providers_final_grouped := group(ing_providers_final_sorted, acctno, HcId, SrcId, Src);
	ing_providers_rolled := rollup(ing_providers_final_grouped, group, Healthcare_Provider_Services.Provider_Records_Transforms.doSrcIdRollup(left,rows(left)));			

	ams_providers_final_sorted := sort(getAmsBase, acctno, HcId, SrcId, Src);
	ams_providers_final_grouped := group(ams_providers_final_sorted, acctno, HcId, SrcId, Src);
	ams_providers_rolled := rollup(ams_providers_final_grouped, group, Healthcare_Provider_Services.Provider_Records_Transforms.doSrcIdRollup(left,rows(left)));	

	ing_providers_w_hcid := Healthcare_Provider_Services.Provider_Records_Functions_Ing.doCustomMatchIng(ing_providers_rolled,customLogic(ingkey <> ''));
	ing_providers_w_hcid_final := project(ing_providers_w_hcid,transform(Healthcare_Provider_Services.Layouts.CombinedHeaderResults, 
																						self.hcid := if(left.hcid=0,left.srcid,left.hcid);self:=left));
	output(ing_providers_w_hcid,named('ing_providers_w_hcid'));
	//set the HCID for AMS records with ing matches
	ams_providers_w_hcid := Healthcare_Provider_Services.Provider_Records_Functions_AMS.doCustomMatchAMS(ams_providers_rolled,customLogic(ingKey <> ''));
	ams_providers_w_hcid_final := project(ams_providers_w_hcid,transform(Healthcare_Provider_Services.Layouts.CombinedHeaderResults, 
																						self.hcid := if(left.hcid=0,left.srcid,left.hcid);self:=left));
	output(ams_providers_w_hcid,named('ams_providers_w_hcid'));
	//Combine the two sources
	combined_ing_ams := ing_providers_w_hcid_final + ams_providers_w_hcid_final;
	output(combined_ing_ams,named('combined_ing_ams'));
	combined_final_sorted := sort(combined_ing_ams, acctno, HCID);
	combined_final_grouped := group(combined_final_sorted, acctno, HCID);
	resultsGetRawRecords := rollup(combined_final_grouped(HCID > 0), group, Healthcare_Provider_Services.Provider_Records_Transforms.doFinalRollup(left,rows(left)));
	output(resultsGetRawRecords,named('resultsGetRawRecords'));
	getRaw := Healthcare_Provider_Services.Provider_Records_Consolidated.getRecordsRaw(input,maxPenalty);
	output(getRaw,Named('getRawRecordFinal'));
	rawDoxieFmt := project(getRaw,Healthcare_Provider_Services.layouts.CombinedHeaderResultsDoxieLayout);
	slim := Healthcare_Provider_Services.Provider_Records_Functions.getSlimRecords(getRaw);
	output(slim,Named('slimRecord'));
	fmtRec_w_Language := Healthcare_Provider_Services.Provider_Records_Functions_ING.appendLanguage(slim,rawDoxieFmt);
	output(fmtRec_w_Language,Named('Raw_w_Language'));
	fmtRec_w_Degree := Healthcare_Provider_Services.Provider_Records_Functions.appendDegree(slim,fmtRec_w_Language);
	output(fmtRec_w_Degree,Named('Raw_w_Degree'));
	fmtRec_w_Specialty := Healthcare_Provider_Services.Provider_Records_Functions.appendSpecialty(slim,fmtRec_w_Degree);
	output(fmtRec_w_Specialty,Named('Raw_w_Specialty'));
	fmtRec_w_Residency := Healthcare_Provider_Services.Provider_Records_Functions_ING.appendResidency(slim,fmtRec_w_Specialty);
	output(fmtRec_w_Residency,Named('Raw_w_Residency'));
	fmtRec_w_MedSchool := Healthcare_Provider_Services.Provider_Records_Functions_ING.appendMedSchool(slim,fmtRec_w_Residency);
	output(fmtRec_w_MedSchool,Named('Raw_w_MedSchool'));
	fmtRec_w_Taxonomy := Healthcare_Provider_Services.Provider_Records_Functions_ING.appendTaxonomy(slim,fmtRec_w_MedSchool);
	output(fmtRec_w_Taxonomy,Named('Raw_w_Taxonomy'));
	slimSanc := Healthcare_Provider_Services.Provider_Records_Functions.getSlimSancRecordsAppendSrcName(Healthcare_Provider_Services.Provider_Records_Functions.getSlimSancRecords(slim,getRaw),input);
	output(slimSanc,Named('slimSanc'));
	fmtRec_w_Sanction := Healthcare_Provider_Services.Provider_Records_Functions.appendSanction(slimSanc,fmtRec_w_Taxonomy);
	output(fmtRec_w_Sanction,Named('Raw_w_Sanction'));
	fmtRec_w_SSN := Healthcare_Provider_Services.Provider_Records_Functions.appendSSN(slimSanc,fmtRec_w_Sanction);
	output(fmtRec_w_SSN,Named('Raw_w_SSN'));
	fmtRec_w_Death := Healthcare_Provider_Services.Provider_Records_Functions.appendDeath(slimSanc,fmtRec_w_SSN);
	output(fmtRec_w_Death,Named('Raw_w_Death'));
	getDoxieRaw := Healthcare_Provider_Services.Provider_Records_Consolidated.getRecordsRawDoxie(Input,maxPenalty);
	output(getDoxieRaw,Named('getDoxieResults'));
	getDoxieFormat := Healthcare_Provider_Services.Provider_Records_Consolidated.fmtRecordsLegacyReport(getDoxieRaw,aInputData);
	output(getDoxieFormat,Named('Doxie_Ingenix_Provider_Report'));
	getSearchFormat := Healthcare_Provider_Services.Provider_Records_Consolidated.fmtRecordsSearch(getRaw);
	output(getSearchFormat,Named('Healthcare_Provider_Services_SearchService'));
	// convertedInput2:=Healthcare_Provider_Services.Provider_Records_Consolidated.convertInputtoDatasetForAutoKeys(aInputData);
	// provRecFinal := project(Healthcare_Provider_Services.Provider_Records_Consolidated.getRecordsRawDoxie(convertedInput2,maxPenalty,true),Healthcare_Provider_Services.Transforms.formatSearchServiceProviderOutput(left,convertedInput2,aInputData));
	// output(provRecFinal,Named('Healthcare_Provider_Services_SearchService_Std_AutoKeys'));
ENDMACRO;

