/*--SOAP--
<message name="SearchService">
	<!-- COMPLIANCE SETTINGS -->
	<part name="HealthCareConsolidatedSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
	<part name="DumpCleanandConfig" 			type="xsd:boolean"/> 		
	<part name="DumpHeader" 			type="xsd:boolean"/> 		
	<part name="DumpSourceData" 	type="xsd:boolean"/> 		
	<part name="DumpRules"				type="xsd:boolean"/> 		
	<part name="DumpScore"				type="xsd:boolean"/> 		
	<part name="DumpPenalty"			type="xsd:boolean"/> 		
	
</message>
*/

import iesp, AutoStandardI,ut,Healthcare_Consolidated,Healthcare_Shared,std;

export ResearchService := MACRO
	ds_in := DATASET ([], iesp.healthcareconsolidatedsearch.t_HealthCareConsolidatedSearchRequest) : STORED('HealthCareConsolidatedSearchRequest', FEW);
	returnCleanConfig := false : STORED('DumpCleanandConfig'); 		
	returnHeader := false : STORED('DumpHeader'); 		
	returnSourceData := false : STORED('DumpSourceData'); 		
	returnRules := false : STORED('DumpRules'); 		
	returnScore := false : STORED('DumpScore'); 		
	returnPenalty := false : STORED('DumpPenalty'); 		

	first_row := ds_in[1] : INDEPENDENT;	
	iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);
	iesp.ECL2ESP.SetInputSearchOptions(first_row.options);	  
	iesp.ECL2ESP.SetInputReportBy (ROW (first_row.searchBy, transform (iesp.bpsreport.t_BpsReportBy, Self := Left, Self := [])));
	string11 Taxid       := trim(first_row.searchBy.Taxid);
	#stored('Taxid', Taxid);
	string11 Fein       := trim(first_row.searchBy.FEIN);
	#stored('Fein', Fein);
  STRING CompanyName := trim(first_row.searchBy.CompanyName);
	#STORED('CompanyName', CompanyName);
	unsigned2 PenaltThreshold := first_row.Options.penaltythreshold;
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
															],Healthcare_Shared.Iparams.licenseinfo);
  	
	input_params := AutoStandardI.GlobalModule();
	aInputData:= MODULE(PROJECT(input_params, Healthcare_Shared.Iparams.searchParams,opt))		
		EXPORT STRING 		NPI := first_row.searchby.NPINumber;
		EXPORT STRING 		UPIN := first_row.searchby.UPIN;
		EXPORT string11 	Fein := AutoStandardI.InterfaceTranslator.fein_val.val(project(input_params, AutoStandardI.InterfaceTranslator.fein_val.params));  
		EXPORT STRING 		MedicalSchoolName := first_row.searchby.MedicalSchoolName;
		EXPORT integer 		GraduationYear := first_row.searchby.GraduationYear;
		EXPORT STRING30 	LastName := AutoStandardI.InterfaceTranslator.lname_value.val(project(input_params, AutoStandardI.InterfaceTranslator.lname_value.params));      			
		EXPORT STRING30 	FirstName := AutoStandardI.InterfaceTranslator.fname_value.val(project(input_params, AutoStandardI.InterfaceTranslator.fname_value.params));      			
		EXPORT STRING30 	MiddleName := AutoStandardI.InterfaceTranslator.mname_value.val(project(input_params, AutoStandardI.InterfaceTranslator.mname_value.params));      			
		EXPORT string120 	CompanyName := AutoStandardI.InterfaceTranslator.company_name.val(project(input_params, AutoStandardI.InterfaceTranslator.company_name_value.params));
		Export dataset(Healthcare_Shared.Iparams.licenseinfo) StateLicenses := stateLicenseDS;
		EXPORT STRING 		DEA := first_row.searchby.DEANumber;
		EXPORT string15		CLIANumber := first_row.searchby.CLIANumber;
		EXPORT string15		Taxonomy := first_row.searchby.Taxonomy;
		export unsigned6  ProviderId := (integer)first_row.searchby.ProviderId;
		export string5  	ProviderSrc := stringlib.StringToUpperCase(first_row.searchby.ProviderSrc);
	END;

	maxPenalty := if(input_params.penalty_threshold=0,10,input_params.penalty_threshold);
	Healthcare_Shared.Layouts.common_runtime_config buildConfig():=transform
		self.CustomerID := first_row.user.CompanyId;	
		self.OneStepRule := first_row.searchby.VerificationConfiguration;
		self.penalty_threshold := input_params.penalty_threshold;
		self.MaxResults := first_row.options.MaxResults;
		self.DRM := first_row.user.DataRestrictionMask;
		self.glb_ok := ut.glb_ok ((integer)first_row.user.GLBPurpose);
		self.dppa_ok := ut.dppa_ok((integer)first_row.user.DLPurpose);
		self.Restrictions := Healthcare_Shared.Restrictions.setRestrictionFlags(first_row.user.DataRestrictionMask,first_row.user.DataPermissionMask);
		self.doDeepDive := first_row.options.IncludeAlsoFound;
		self.excludeSourceAMS := first_row.options.ExcludeSourceAMS;
		self.excludeSourceNPPES := first_row.options.ExcludeSourceNPPES;
		self.excludeSourceDEA := first_row.options.ExcludeSourceDEA;
		self.excludeSourceProfLic := first_row.options.ExcludeSourceProfLic;
		self.excludeSourceSelectFile := first_row.options.ExcludeSourceSelectFile;
		self.excludeSourceCLIA := first_row.options.ExcludeSourceCLIA;
		self.excludeSourceNCPDP := first_row.options.ExcludeSourceNCPDP;
		self.excludeLegacySanctions := first_row.options.ExcludeLegacySanctions;
		self.IncludeAlsoFound := first_row.options.IncludeAlsoFound;
		self.includeCustomerData := true;
		self.IncludeProvidersOnly := first_row.options.IncludeProvidersOnly;
		self.IncludeSanctionsOnly := first_row.options.IncludeSanctionsOnly;
		self.IncludeSanctions := true;
		self.IncludeGroupAffiliations := first_row.options.IncludeHospitalAffiliations;
		self.IncludeHospitalAffiliations := first_row.options.IncludeGroupAffiliations;
		self.IncludeSpecialties  := first_row.options.IncludeSpecialties;
		self.IncludeLicenses  := first_row.options.IncludeLicenses;
		// self.IncludeResidencies  := first_row.options.IncludeResidencies;
		self.IncludeABMSBoardCertifiedSpecialty := first_row.options.IncludeBoardCertifiedSpecialty;
		self.IncludeABMSCareer := true;
		self.IncludeABMSEducation := true;
		self.IncludeABMSProfessionalAssociations := true;
		self.IncludeDOB := first_row.options.IncludeDOB;
		self.IncludeDOD := first_row.options.IncludeDOD;
		self.IncludeSSN := first_row.options.IncludeSSN;
		self.IncludeTaxID := first_row.options.IncludeTaxID;
		self.IncludeDegree := first_row.options.IncludeDegree;
		self.IncludeMedSchool := first_row.options.IncludeMedSchool;
		self.IncludeTaxonomy := first_row.options.IncludeTaxonomy;
		self.IncludeUPIN := first_row.options.IncludeUPIN;
		self.IncludeNPI := first_row.options.IncludeNPI;
		self.IncludeDEA := first_row.options.IncludeDEA;
		self.IncludeMedicare := first_row.options.IncludeMedicare;
		self.IncludeStateControlledSubstance := first_row.options.IncludeStateControlledSubstance;
		self.IncludeCLIA := first_row.options.IncludeCLIA;
		self.IncludeNCPDP := first_row.options.IncludeNCPDP;
		self.IncludeFEIN := first_row.options.IncludeFEIN;
		self.IncludeAffiliations := first_row.options.IncludeAffiliations;
		self.IncludeEssentialCommunityResources := first_row.options.IncludeEssentialCommunityResources;//hidden[internal]
		self.IncludeOfficeAttributes := first_row.options.IncludeOfficeAttributes;//hidden[internal]
		// self:=[];Do not uncomment otherwise the default values will not get set.
	end;
	cfg:=dataset([buildConfig()]);
	input := Healthcare_Consolidated.Transforms.convertInputtoDataset(aInputData);
	if(returnCleanConfig,output(input, named('FormattedInput')));
	if(returnCleanConfig,output(cfg, named('RuntimeConfig')));
	CommonizedInput := Healthcare_Shared.getCandidateRecords.getCommonizedInput(input,,,cfg);
	if(returnCleanConfig,output(CommonizedInput, named('CommonizedInput')));
	IndividualRecords:=Healthcare_Shared.getCandidateRecords.getProviderRecords(CommonizedInput);
	if(returnHeader,output(IndividualRecords, named('IndividualRecords')));
	hdrIndvs := Healthcare_Shared.Fn_search_Ind_Header.getHdrLNPids(IndividualRecords,cfg);
	if(returnHeader,output(hdrIndvs, named('IndividualHeaderRecords')));
	providercandidates := Healthcare_Shared.getCandidateRecords.getProviderCandidates(CommonizedInput,cfg);
	if(returnHeader,output(providercandidates, named('ProviderCandidates')));
	FacilityRecords:=Healthcare_Shared.getCandidateRecords.getFacilitiesRecords(CommonizedInput);
	if(returnHeader,output(FacilityRecords, named('FacilityRecords')));
	hdrFacs :=Healthcare_Shared.Fn_search_Bus_Header.getHdrLNFids(FacilityRecords,cfg);
	if(returnHeader,output(hdrFacs, named('FacilityHeaderRecords')));
	facilitycandidates := Healthcare_Shared.getCandidateRecords.getFacilitiesCandidates(CommonizedInput,cfg);
	if(returnHeader,output(facilitycandidates, named('FacilityCandidates')));
	//To here is about 3 seconds
	//TO update this to represent all data connectors.
	Enclarity := Healthcare_Shared.Fn_get_RawRecords.getEnclarityRecords(providercandidates+facilitycandidates,CommonizedInput,cfg);
	if(returnSourceData,output(Enclarity,Named('Enclarity_Records')));
	DEA := Healthcare_Shared.Fn_get_RawRecords.getDEARecords(providercandidates+facilitycandidates,CommonizedInput,cfg);
	if(returnSourceData,output(DEA,Named('DEA_Records')));
	NPPES := Healthcare_Shared.Fn_get_RawRecords.getNPPESRecords(providercandidates+facilitycandidates,CommonizedInput,cfg);
	if(returnSourceData,output(NPPES,Named('NPPES_Records')));
	ProfLic := Healthcare_Shared.Fn_get_RawRecords.getProfLicRecords(providercandidates+facilitycandidates,CommonizedInput,cfg);
	if(returnSourceData,output(ProfLic,Named('ProfLic_Records')));
	CLIA := Healthcare_Shared.Fn_get_RawRecords.getCLIARecords(providercandidates+facilitycandidates,CommonizedInput,cfg);
	if(returnSourceData,output(CLIA,Named('CLIA_Records')));
	NCPDP := Healthcare_Shared.Fn_get_RawRecords.getNCPDPRecords(providercandidates+facilitycandidates,CommonizedInput,cfg);
	if(returnSourceData,output(NCPDP,Named('NCPDP_Records')));
	
	//To here is about 35 seconds
	//Rollup across Data Sources
	groupedRecs := group(Enclarity+DEA+NPPES+ProfLic+CLIA+NCPDP, acctno,internalID,lnpid,lnfid);
	rolledRecs := rollup(groupedRecs, group, Healthcare_Shared.Transforms.doMergeSourcesRollup(left,rows(left),cfg));
	// output(rolledRecs,Named('Consolidated_Records'));
	// output(STD.System.Debug.msTick(), named('TimeConsolidated'));
	//Score Records
	scoredRecs := if(cfg[1].SkipScoring,rolledRecs,Healthcare_Shared.Functions_Score_Record.ScoreRec(rolledRecs));
	// output(scoredRecs,Named('Consolidated_Records_Scored'));
	//Update Verification Flags with Header Results
	scoredRecs_W_Flags := project(scoredRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResults,
						filterCandidates := providercandidates+facilitycandidates(acctno=left.acctno and lnpid=left.lnpid and lnfid=left.lnfid);
						filterTable := dedup(sort(filterCandidates,acctno),acctno);
						Verif := project(filterTable, transform(Healthcare_Shared.Layouts.Verifications,
															self.NPISuppliedExists := filterTable[1].IndivFlags.NPIUserSuppliedExists;
															self.NPISuppliedExistsAuth := filterTable[1].IndivFlags.NPIUserSuppliedExistsAuth;
															self.NPIFlags := filterTable[1].IndivFlags.NPIHeaderFlag;
															self.DEASuppliedExists := filterTable[1].IndivFlags.DEA1UserSuppliedExists;
															self.DEASuppliedExistsAuth := filterTable[1].IndivFlags.DEA1UserSuppliedExistsAuth;
															self.DEAFlags := filterTable[1].IndivFlags.DEA1HeaderFlag;
															self.DEA2SuppliedExists := filterTable[1].IndivFlags.DEA2UserSuppliedExists;
															self.DEA2SuppliedExistsAuth := filterTable[1].IndivFlags.DEA2UserSuppliedExistsAuth;
															self.DEA2Flags := filterTable[1].IndivFlags.DEA2HeaderFlag;
															self.UPINSuppliedExists := filterTable[1].IndivFlags.UPINUserSuppliedExists;
															self.UPINSuppliedExistsAuth := filterTable[1].IndivFlags.UPINUserSuppliedExistsAuth;
															self.UPINFlags := filterTable[1].IndivFlags.UPINHeaderFlag;
															self.License1SuppliedExists := filterTable[1].IndivFlags.StLic1UserSuppliedExists;
															self.License1SuppliedExistsAuth := filterTable[1].IndivFlags.StLic1UserSuppliedExistsAuth;
															self.License1Flags := filterTable[1].IndivFlags.StLic1HeaderFlag;
															self.CLIASuppliedExists := filterTable[1].BusFlags.CLIAUserSuppliedExists;
															self.CLIASuppliedExistsAuth := filterTable[1].BusFlags.CLIAUserSuppliedExistsAuth;
															self.CLIAFlags := filterTable[1].BusFlags.CLIAHeaderFlag;
															self.NCPDPSuppliedExists := filterTable[1].BusFlags.NCPDPUserSuppliedExists;
															self.NCPDPSuppliedExistsAuth := filterTable[1].BusFlags.NCPDPUserSuppliedExistsAuth;
															self.NCPDPFlags := filterTable[1].BusFlags.NCPDPHeaderFlag;
															self := left;));
								self.VerificationInfo := Verif;
								self:=left;));
	if(returnScore,output(scoredRecs_W_Flags,Named('Consolidated_Records_Scored_W_Flags')));
	// 50 seconds to here 
	//Run Rules Manager to populate Child datasets with Best data and set Correction data
	RulesProcessNameDES := project(Healthcare_Rules_DES_MF.Rules_Name_Default(scoredRecs_W_Flags,cfg),
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left));
	if(returnRules,output(RulesProcessNameDES,Named('BestRules_Name_DES')));
	RulesProcessAddressDES := project(Healthcare_Rules_DES_MF.Rules_Address_Default(scoredRecs_W_Flags,cfg),
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left));
	if(returnRules,output(RulesProcessAddressDES,Named('BestRules_Address_DES')));
	// 52 seconds to here 
	RulesProcessPhoneDES := project(Healthcare_Rules_DES_MF.Rules_Phones_Default(scoredRecs_W_Flags,cfg),
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left));
	if(returnRules,output(RulesProcessPhoneDES,Named('BestRules_Phone_DES')));
	RulesProcessDOBDES := project(map(not cfg[1].IncludeDOB => scoredRecs_W_Flags,
												Healthcare_Rules_DES_MF.Rules_DOB_Default(scoredRecs_W_Flags,cfg)),
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left));
	if(returnRules and cfg[1].IncludeDOB,output(RulesProcessDOBDES,Named('BestRules_DOB_DES')));
	RulesProcessSSNDES := project(map(not cfg[1].IncludeSSN => Healthcare_Rules_DES_MF.Rules_SSN_Suppress(scoredRecs_W_Flags,cfg),
												Healthcare_Rules_DES_MF.Rules_SSN_Default(scoredRecs_W_Flags,cfg)),
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left));
	if(returnRules and cfg[1].IncludeSSN,output(RulesProcessSSNDES,Named('BestRules_SSN_DES')));
	RulesProcessUPINDES := project(map(not cfg[1].IncludeUPIN => scoredRecs_W_Flags,
												Healthcare_Rules_DES_MF.Rules_UPIN_Default(scoredRecs_W_Flags,cfg)),
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left));
	if(returnRules and cfg[1].IncludeUPIN,output(RulesProcessUPINDES,Named('BestRules_UPIN_DES')));
	RulesProcessNPIDES := project(map(not cfg[1].IncludeNPI => scoredRecs_W_Flags,
												Healthcare_Rules_DES_MF.Rules_NPI_Default(scoredRecs_W_Flags,cfg)),
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left));
	if(returnRules and cfg[1].IncludeNPI,output(RulesProcessNPIDES,Named('BestRules_NPI_DES')));
	// 74 sec to here
	RulesProcessDEADES := project(map(not cfg[1].IncludeDEA => scoredRecs_W_Flags,
												Healthcare_Rules_DES_MF.Rules_DEA_Default(scoredRecs_W_Flags,cfg)),
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left));
	if(returnRules and cfg[1].IncludeDEA,output(RulesProcessDEADES,Named('BestRules_DEA_DES')));
	RulesProcessCLIADES := project(map(not cfg[1].IncludeCLIA => scoredRecs_W_Flags,
												Healthcare_Rules_DES_MF.Rules_CLIA_Default(scoredRecs_W_Flags,cfg)),
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left));
	if(returnRules and cfg[1].IncludeCLIA,output(RulesProcessCLIADES,Named('BestRules_CLIA_DES')));
	RulesProcessNCPDPDES := project(map(not cfg[1].IncludeNCPDP => scoredRecs_W_Flags,
												Healthcare_Rules_DES_MF.Rules_NCPDP_Default(scoredRecs_W_Flags,cfg)),
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left));
	if(returnRules and cfg[1].IncludeNCPDP,output(RulesProcessNCPDPDES,Named('BestRules_NCPDP_DES')));
	//72 sec to here
	RulesProcessStateLicenseDES := project(map(not cfg[1].IncludeLicenses => scoredRecs_W_Flags,
												Healthcare_Rules_DES_MF.Rules_StateLicense_Default(scoredRecs_W_Flags,cfg)),
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left));
	if(returnRules and cfg[1].IncludeLicenses,output(RulesProcessStateLicenseDES,Named('BestRules_License_DES')));
	RulesProcessFEINDES := project(map(not cfg[1].IncludeFein => scoredRecs_W_Flags,
												Healthcare_Rules_DES_MF.Rules_FEIN_Default(scoredRecs_W_Flags,cfg)),
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left));
	if(returnRules and cfg[1].IncludeFEIN,output(RulesProcessFEINDES,Named('BestRules_FEIN_DES')));
	RulesProcessDegreeDES := project(map(not cfg[1].IncludeDegree => scoredRecs_W_Flags,
												Healthcare_Rules_DES_MF.Rules_Degree_Default(scoredRecs_W_Flags,cfg)),
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left));
	if(returnRules and cfg[1].IncludeDegree,output(RulesProcessDegreeDES,Named('BestRules_Degree_DES')));
	RulesProcessSpecialtyDES := project(map(not cfg[1].IncludeSpecialties => scoredRecs_W_Flags,
												Healthcare_Rules_DES_MF.Rules_Specialty_Default(scoredRecs_W_Flags,cfg)),
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left));
	if(returnRules and cfg[1].IncludeSpecialties,output(RulesProcessSpecialtyDES,Named('BestRules_Specialty_DES')));
	RulesProcessMedSchoolDES := project(map(not cfg[1].IncludeMedSchool => scoredRecs_W_Flags,
												Healthcare_Rules_DES_MF.Rules_MedSchool_Default(scoredRecs_W_Flags,cfg)),
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left));
	if(returnRules and cfg[1].IncludeMedSchool,output(RulesProcessMedSchoolDES,Named('BestRules_MedSchool_DES')));
	RulesProcessTaxonomyDES := project(map(not cfg[1].IncludeTaxonomy => scoredRecs_W_Flags,
												Healthcare_Rules_DES_MF.Rules_Taxonomy_Default(scoredRecs_W_Flags,cfg)),
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left));
	if(returnRules and cfg[1].IncludeTaxonomy,output(RulesProcessTaxonomyDES,Named('BestRules_Taxonomy_DES')));
	RulesProcessMedicareDES := project(map(not cfg[1].IncludeMedicare => scoredRecs_W_Flags,
												Healthcare_Rules_DES_MF.Rules_Medicare_Default(scoredRecs_W_Flags,cfg)),
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left));
	if(returnRules and cfg[1].IncludeMedicare,output(RulesProcessMedicareDES,Named('BestRules_Medicare_DES')));
	RulesProcessMiscInfoDES := project(Healthcare_Rules_DES_MF.Rules_MiscInfo_Default(scoredRecs_W_Flags,cfg),
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left));
	if(returnRules,output(RulesProcessMiscInfoDES,Named('BestRules_Misc_DES')));
	RulesProcessSanctionsDES := project(map(not cfg[1].IncludeSanctions =>  scoredRecs_W_Flags, //If flag turned off skip processing
												Healthcare_Rules_DES_MF.Rules_Sanctions_Default(scoredRecs_W_Flags,cfg)),
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left));
	if(returnRules and cfg[1].IncludeSanctions,output(RulesProcessSanctionsDES,Named('BestRules_Sanctions_DES')));
	RulesProcessStateControlledSubstanceDES := project(map(not cfg[1].IncludeStateControlledSubstance => scoredRecs_W_Flags,
												Healthcare_Rules_DES_MF.Rules_StateControlledSubstance_Default(scoredRecs_W_Flags,cfg)),
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left));
	if(returnRules and cfg[1].IncludeStateControlledSubstance,output(RulesProcessStateControlledSubstanceDES,Named('BestRules_StateControlledSubstance_DES')));
	RulesProcessEssentialCommunityResourcesDES := project(map(not cfg[1].IncludeEssentialCommunityResources => scoredRecs_W_Flags,
												Healthcare_Rules_DES_MF.Rules_EssentialCommunityResources_Default(scoredRecs_W_Flags,cfg)),
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left));
	if(returnRules and cfg[1].IncludeEssentialCommunityResources,output(RulesProcessEssentialCommunityResourcesDES,Named('BestRules_EssentialCommunityResources_DES')));
	RulesProcessFacilityContactsDES := project(map(not cfg[1].IncludeFacilityContacts => scoredRecs_W_Flags,
												Healthcare_Rules_DES_MF.Rules_FacilityContacts_Default(scoredRecs_W_Flags,cfg)),
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left));
	if(returnRules and cfg[1].IncludeFacilityContacts,output(RulesProcessFacilityContactsDES,Named('BestRules_FacilityContacts_DES')));
	RulesProcessFacilityAttributesDES := project(map(not cfg[1].IncludeFacilityAttributes => scoredRecs_W_Flags,
												Healthcare_Rules_DES_MF.Rules_FacilityAttributes_Default(scoredRecs_W_Flags,cfg)),
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left));
	if(returnRules and cfg[1].IncludeFacilityAttributes,output(RulesProcessFacilityAttributesDES,Named('BestRules_FacilityAttributes_DES')));
	//100 sec to here
	RulesProcessGroupAffiliationDES := project(map(not cfg[1].IncludeGroupAffiliations => scoredRecs_W_Flags,
												Healthcare_Rules_DES_MF.Rules_GroupAffiliations_Default(scoredRecs_W_Flags,cfg)),
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left));
	if(returnRules and cfg[1].IncludeGroupAffiliations,output(RulesProcessGroupAffiliationDES,Named('BestRules_GroupAffiliation_DES')));
	RulesProcessHospitalAffiliationDES := project(map(not cfg[1].IncludeHospitalAffiliations => scoredRecs_W_Flags,
												Healthcare_Rules_DES_MF.Rules_HospitalAffiliations_Default(scoredRecs_W_Flags,cfg)),
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left));
	if(returnRules and cfg[1].IncludeHospitalAffiliations,output(RulesProcessHospitalAffiliationDES,Named('BestRules_HospitalAffiliation_DES')));
	DESParallelRules := Healthcare_Rules_DES_MF.RulesManager.processParallelRules(scoredRecs_W_Flags,cfg);
	//97 seconds to here.
	RulesProcessDODDES := map(not cfg[1].IncludeDOD => Healthcare_Rules_DES_MF.Rules_DOD_Suppress(DESParallelRules,cfg),
												Healthcare_Rules_DES_MF.Rules_DOD_Default(DESParallelRules,cfg));
	if(returnRules and cfg[1].IncludeDOD,output(project(RulesProcessDODDES,transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left)),Named('BestRules_DOD_DES')));
	appendDODDES := join(DESParallelRules,RulesProcessDODDES,left.acctno=right.acctno and left.internalid=right.internalid,
													transform(Healthcare_Shared.Layouts.CombinedHeaderResults,
																		self.dods := right.dods;
																		self:=left),left outer,
													keep(Healthcare_Shared.Constants.MAX_SEARCH_RECS), limit(0));
	RulesProcessTaxIDDES := map(not cfg[1].IncludeTaxID => appendDODDES,
												Healthcare_Rules_DES_MF.Rules_TaxID_Default(appendDODDES,cfg));
	appendTaxIDDES := join(appendDODDES,RulesProcessTaxIDDES,left.acctno=right.acctno and left.internalid=right.internalid,
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults,
																			self.taxids := right.taxids;
																			self.Corrections.tin_correction := right.Corrections.tin_correction;
																			self.Corrections.tin_correction_st := right.Corrections.tin_correction_st;
																			self.Corrections.tin_correction_distance := right.Corrections.tin_correction_distance;
																			self.UStat.tin_ustat := right.UStat.tin_ustat;
																			self.CIC.tin_cic := right.CIC.tin_cic;
																			self:=left),left outer,
														keep(Healthcare_Shared.Constants.MAX_SEARCH_RECS), limit(0));
	if(returnRules and cfg[1].IncludeTaxID,output(project(appendTaxIDDES,transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left)),Named('BestRules_TAXID_DES')));
	//146 sec to here
	RulesProcessProviderDES := Healthcare_Rules_DES_MF.Rules_Provider_Default(appendTaxIDDES,cfg);
	if(returnRules,output(Project(RulesProcessProviderDES,transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left)),Named('BestRules_Provider_DES')));
	appendProviderDES := join(appendDODDES,RulesProcessProviderDES,left.acctno=right.acctno and left.internalid=right.internalid,
														transform(Healthcare_Shared.Layouts.CombinedHeaderResults,
																			self.Status := right.Status;
																			self.QuestionCodes := right.QuestionCodes;
																			self.UStat.provider_ustat := right.UStat.provider_ustat;
																			self.UStat.dos_ustat := right.UStat.dos_ustat;
																			self.UStat.death_provider_ustat := right.UStat.death_provider_ustat;
																			self.CIC.provider_cic := right.CIC.provider_cic;
																			self.RecordsRaw := if(cfg[1].keepRawRecs,left.RecordsRaw,dataset([],Healthcare_Shared.layouts_commonized.std_record_struct));
																			self:=left),left outer,
														keep(Healthcare_Shared.Constants.MAX_SEARCH_RECS), limit(0));
	if(returnRules,output(Project(appendProviderDES,transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.RecordsRaw:=[];self:=left)),Named('BestRules_Final_DES')));
	//97 sec to here
	//Do Penalty
	applyPenalty := Healthcare_Shared.Functions.doPenalty(appendProviderDES,dedup(sort(CommonizedInput,acctno),acctno),cfg[1]);
	if(returnPenalty,output(applyPenalty,Named('applyPenalty')));
	//Get Additional Append Data for customer data
	refmtResults := project(applyPenalty, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,self:=left;self:=[];));
	// refmtInput := project(input, transform(Healthcare_Shared.Layouts.autokeyInput, self:=left;self:=[]));
	// Valid_Lic_Company := Healthcare_CustomerLicense.Raw.verify_Company(cfg[1].CustomerID);
	// fmtRec_w_CustomerLicense := if(cfg[1].includeCustomerData and Valid_Lic_Company,Healthcare_Shared.Fn_get_CustomerData.appendCustomerLicenseData(refmtInput, refmtResults,cfg),refmtResults);
	// Valid_Death_Company := Healthcare_CustomerDeath.Raw.verify_Company(cfg[1].CustomerID);
	// fmtRec_w_CustomerDeath := if(cfg[1].includeCustomerData and Valid_Death_Company,Healthcare_Shared.Fn_get_CustomerData.appendCustomerDeathData(refmtInput, fmtRec_w_CustomerLicense,cfg),fmtRec_w_CustomerLicense);
	//Populate Validations  Reveiw CIC's for Exists fields that are not getting populate yet.
	//109 secs to here
	fmtRec_Final := Healthcare_Shared.Fn_do_Validation.processVerifications(refmtResults,cfg);
	output(fmtRec_Final,Named('GoldenRecord_Output'));
	//106 secs to here.
ENDMACRO;

