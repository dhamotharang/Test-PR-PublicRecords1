/*--SOAP--
<message name="SearchService">
	<!-- COMPLIANCE SETTINGS -->
	<part name="HealthCareConsolidatedSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/

import iesp, AutoStandardI,ut;

export ResearchService := MACRO
	ds_in := DATASET ([], iesp.healthcareconsolidatedsearch.t_HealthCareConsolidatedSearchRequest) : STORED('HealthCareConsolidatedSearchRequest', FEW);
	
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
	unsigned1 PenaltThreshold := first_row.Options.penaltythreshold;
	#stored ('PenaltThreshold', PenaltThreshold);	
	string50 DataRestrictionMask := first_row.User.DataRestrictionMask;
	#stored('DataRestrictionMask', DataRestrictionMask);
	
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
															],Healthcare_Header_Services.IParams.licenseinfo);
  	
	input_params := AutoStandardI.GlobalModule();
	aInputData:= MODULE(PROJECT(input_params, Healthcare_Header_Services.IParams.searchParams,opt))		
		EXPORT STRING 		NPI := first_row.searchby.NPINumber;
		EXPORT STRING 		UPIN := first_row.searchby.UPIN;
		EXPORT string11 	Fein := AutoStandardI.InterfaceTranslator.fein_val.val(project(input_params, AutoStandardI.InterfaceTranslator.fein_val.params));  
		EXPORT STRING 		MedicalSchoolName := first_row.searchby.MedicalSchoolName;
		EXPORT integer 		GraduationYear := first_row.searchby.GraduationYear;
		EXPORT STRING30 	LastName := AutoStandardI.InterfaceTranslator.lname_value.val(project(input_params, AutoStandardI.InterfaceTranslator.lname_value.params));      			
		EXPORT STRING30 	FirstName := AutoStandardI.InterfaceTranslator.fname_value.val(project(input_params, AutoStandardI.InterfaceTranslator.fname_value.params));      			
		EXPORT STRING30 	MiddleName := AutoStandardI.InterfaceTranslator.mname_value.val(project(input_params, AutoStandardI.InterfaceTranslator.mname_value.params));      			
		EXPORT string120 	CompanyName := AutoStandardI.InterfaceTranslator.company_name.val(project(input_params, AutoStandardI.InterfaceTranslator.company_name_value.params));
		Export dataset(Healthcare_Header_Services.IParams.licenseinfo) StateLicenses := stateLicenseDS;
		EXPORT STRING 		DEA := first_row.searchby.DEANumber;
		EXPORT string15		CLIANumber := first_row.searchby.CLIANumber;
		EXPORT string15		Taxonomy := first_row.searchby.Taxonomy;
		export unsigned6  ProviderId := (integer)first_row.searchby.ProviderId;
		export string5  	ProviderSrc := stringlib.StringToUpperCase(first_row.searchby.ProviderSrc);
	END;

	maxPenalty := if(aInputData.penalty_threshold=0,10,aInputData.penalty_threshold);
	Healthcare_Header_Services.Layouts.common_runtime_config buildConfig():=transform
		self.CustomerID := first_row.user.CompanyId;	
		self.OneStepRule := first_row.searchby.VerificationConfiguration;
		self.penalty_threshold := input_params.penalty_threshold;
		self.MaxResults := first_row.options.MaxResults;
		self.DRM := first_row.user.DataRestrictionMask;
		self.glb_ok := ut.glb_ok ((integer)first_row.user.GLBPurpose);
		self.dppa_ok := ut.dppa_ok((integer)first_row.user.DLPurpose);
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
		self.IncludeResidencies  := first_row.options.IncludeResidencies;
		self.IncludeABMSBoardCertifiedSpecialty := first_row.options.IncludeBoardCertifiedSpecialty;
		self.IncludeABMSCareer := true;
		self.IncludeABMSEducation := true;
		self.IncludeABMSProfessionalAssociations := true;
		// self:=[];Do not uncomment otherwise the default values will not get set.
	end;
	cfgData:=dataset([buildConfig()]);
	input := Healthcare_Header_Services.Records.convertInputtoDataset(aInputData);
	output(input, named('FormattedInput'));
	BusinessRecords := input(comp_name <> '');
	output(BusinessRecords, named('BusinessRecords'));
	IndividualRecords := join(input,BusinessRecords,left.acctno = right.acctno,transform(Healthcare_Header_Services.Layouts.autokeyInput,self:=left;),left only);
	output(IndividualRecords, named('IndividualRecords'));
	hdr := Healthcare_Header_Services.Header_Records_SearchKeys(IndividualRecords,cfgData);
	output(hdr.getHeaderRecords,Named('Raw_HeaderRecords'));
	getIndvLNPIDs := hdr.getHdrLNPids;
	output(getIndvLNPIDs,Named('Formatted_HeaderRecords'));
	BusHdr := Healthcare_Header_Services.Header_Records_SearchBusKey(BusinessRecords,cfgData);
	output(BusHdr.getHeaderRecords,Named('Raw_BusHeaderRecords'));
	getBusLNPIDs := BusHdr.gethdrlnpids;
	output(getBusLNPIDs,Named('Formatted_BusHeaderRecords'));
	getLNPIDs := getIndvLNPIDs+getBusLNPIDs;
	EnclairtyData := Healthcare_Header_Services.Header_Records_Data.getEnclarityRecords(getLNPIDs,cfgData);
	output(EnclairtyData,Named('Enclarity_Records'));
	HMSData := Healthcare_Header_Services.Header_Records_Data.getHMSRecords(getLNPIDs,cfgData);
	output(HMSData,Named('HMS_Records'));
	DEAData := Healthcare_Header_Services.Header_Records_Data.getDEARecords(getLNPIDs,cfgData);
	output(DEAData,Named('DEA_Records'));
	NPPESData := Healthcare_Header_Services.Header_Records_Data.getNPPESRecords(getLNPIDs,cfgData);
	output(NPPESData,Named('NPPES_Records'));
	ProfLicData := Healthcare_Header_Services.Header_Records_Data.getProfLicRecords(getLNPIDs,cfgData);
	output(ProfLicData,Named('ProfLic_Records'));
	CLIAData := Healthcare_Header_Services.Header_Records_Data.getCLIARecords(getLNPIDs,cfgData);
	output(CLIAData,Named('CLIA_Records'));
	NCPDPData := Healthcare_Header_Services.Header_Records_Data.getNCPDPRecords(getLNPIDs,cfgData);
	output(NCPDPData,Named('NCPDP_Records'));
	IndividualData := Healthcare_Header_Services.Header_Records_Data.getRecords(getIndvLNPIDs,cfgData);
	output(IndividualData,Named('Individual_Records'));
	BusinessData := Healthcare_Header_Services.Header_Records_Data.getBusRecords(getBusLNPIDs,cfgData);
	output(BusinessData,Named('Business_Records'));
	NoHitsforIndivDeepDive := join (IndividualRecords,IndividualData,left.acctno=right.acctno,transform(Healthcare_Header_Services.Layouts.autokeyInput,self:=left;),left only);
	IndivDeepDiveData := Healthcare_Header_Services.Datasource_Boca_Header.get_boca_header_entity(NoHitsforIndivDeepDive(cfgData[1].doDeepDive = true),cfgData);
	output(IndivDeepDiveData,Named('Individual_DeepDive_Records'));
	NoHitsforBusDeepDive := join (BusinessRecords,BusinessData,left.acctno=right.acctno,transform(Healthcare_Header_Services.Layouts.autokeyInput,self:=left;),left only);
	BusDeepDiveData := Healthcare_Header_Services.Datasource_Boca_Bus_Header.get_boca_bus_header_entity(NoHitsforBusDeepDive(cfgData[1].doDeepDive = true));
	output(BusDeepDiveData,Named('Business_DeepDive_Records'));
	//Final Individual Records
	collectedIndividuals := IndividualData+IndivDeepDiveData;
	//Final Business Records
	collectedBusiness := BusinessData+BusDeepDiveData;
	//Final Records processing
	mergedRecs := sort(collectedIndividuals+collectedBusiness,acctno,lnpid);
	output(mergedRecs,Named('Collected_Records'));
	groupedRecs := group(mergedRecs, acctno, lnpid);
	rolledRecs := rollup(groupedRecs, group, Healthcare_Header_Services.Transforms.doFinalRollup(left,rows(left)));			
	output(rolledRecs,Named('Rollup_Records'));
	finalRecs := Healthcare_Header_Services.Functions.doPenalty(rolledRecs,input,maxPenalty);
	output(finalRecs,Named('Collected_Records_W_Penalty'));
	rawDoxieFmt := project(finalRecs,Healthcare_Header_Services.Layouts.CombinedHeaderResultsDoxieLayout);
	slim := Healthcare_Header_Services.Functions.getSlimHdrRecords(finalRecs,input);
	output(slim,Named('Slim_Records'));
	fmtRec_w_SSN := Healthcare_Header_Services.Functions.appendSSN(slim,rawDoxieFmt,cfgData);
	output(fmtRec_w_SSN,Named('Records_w_SSN'));
	fmtRec_w_Death := Healthcare_Header_Services.Functions.appendDeath(slim,fmtRec_w_SSN);
	output(fmtRec_w_Death,Named('Records_w_Death'));
	fmtRec_w_CustomerLicense := if(cfgData[1].includeCustomerData,Healthcare_Header_Services.Datasource_CustomerData.appendCustomerLicenseData(input, fmtRec_w_Death, cfgData),fmtRec_w_Death);
	fmtRec_w_CustomerDeath := if(cfgData[1].includeCustomerData,Healthcare_Header_Services.Datasource_CustomerData.appendCustomerDeathData(input, fmtRec_w_CustomerLicense, cfgData),fmtRec_w_CustomerLicense);
	output(fmtRec_w_CustomerDeath,Named('Records_w_CustomerData'));
	fmtRec_w_ABMS := Healthcare_Header_Services.Datasource_ABMS.appendABMSData(input,slim,fmtRec_w_CustomerDeath,cfgData);
	output(fmtRec_w_ABMS,Named('Records_w_ABMSData'));
	getDoxieRaw := join(fmtRec_w_ABMS,input(derivedinputrecord=false),left.acctno=right.acctno,Healthcare_Header_Services.Functions_Validation.processVerifications(left,right,cfgData));
	output(getDoxieRaw,Named('Records_w_Validations'));
	getDoxieFormat := Healthcare_Header_Services.Records.fmtRecordsLegacyReport(getDoxieRaw,cfgData);
	output(getDoxieFormat,Named('Doxie_Ingenix_Provider_Report'));
	getSearchFormat := Healthcare_Header_Services.Records.fmtRecordsSearch(finalRecs);
	output(getSearchFormat,Named('Healthcare_Header_Services_SearchService'));
ENDMACRO;

