// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
EXPORT PhoneFinderReportService() :=
MACRO
IMPORT Address, AutoStandardI, Gateway, iesp, PhoneFinder_Services, doxie, AutoheaderV2, Autokey_batch;
  #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	// parse ESDL input
  dIn       := DATASET([], iesp.phonefinder.t_PhoneFinderSearchRequest) : STORED('PhoneFinderSearchRequest',FEW);
  pfRequest := dIn[1] : INDEPENDENT;

	// Searchby request
	pfSearchBy:= GLOBAL(pfRequest.SearchBy);

	// User setttings
	pfUser := GLOBAL(pfRequest.User);

  // Report options
  pfOptions := GLOBAL(pfRequest.Options);

	// Gateway information
	dGateways := Gateway.Configuration.Get();

  // #store some standard input parameters (generally, for search purpose)
  iesp.ECL2ESP.SetInputBaseRequest(pfRequest);
  iesp.ECL2ESP.SetInputReportBy(PROJECT(pfSearchBy,
																				TRANSFORM(iesp.bpsreport.t_BpsReportBy,
																									SELF.Phone10 := LEFT.PhoneNumber,
																									SELF         := LEFT,
																									SELF         := [])));
	iesp.ECL2ESP.SetInputSearchOptions(PROJECT(pfOptions,TRANSFORM(iesp.share.t_BaseSearchOptionEx,SELF := LEFT;SELF := [])));

	// Global module
	globalMod := AutoStandardI.GlobalModule();
	mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(globalMod);

	// Search module
	searchMod := PROJECT(globalMod,PhoneFinder_Services.iParam.DIDParams,OPT);
	reportMod := PhoneFinder_Services.iParam.GetSearchParams(pfOptions,pfUser);

	// Create dataset from search request
	Autokey_batch.Layouts.rec_inBatchMaster tFormat2Batch() :=
	TRANSFORM
		// Clean name and address
		cleanName := Address.GetCleanNameAddress.fnCleanName(pfSearchBy.Name);
		cleanAddr := Address.CleanAddressFieldsFips(AutoStandardI.InterfaceTranslator.clean_address.val(searchMod)).addressrecord;

		SELF.acctno      := '1';	// since there would only be one record
		SELF.name_first  := IF( AutoStandardI.InterfaceTranslator.fname_val.val(searchMod) != '',
														AutoStandardI.InterfaceTranslator.fname_val.val(searchMod),
														cleanName.fname);
		SELF.name_middle := IF( AutoStandardI.InterfaceTranslator.mname_val.val(searchMod) != '',
														AutoStandardI.InterfaceTranslator.mname_val.val(searchMod),
														cleanName.mname);
		SELF.name_last   := IF( AutoStandardI.InterfaceTranslator.lname_val.val(searchMod) != '',
														AutoStandardI.InterfaceTranslator.lname_val.val(searchMod),
														cleanName.lname);
		SELF.name_suffix := cleanName.name_suffix;
		SELF.z5          := IF(cleanAddr.zip != '', cleanAddr.zip, searchMod.Zip);
		SELF.ssn         := IF( AutoStandardI.InterfaceTranslator.ssn_value.val(searchMod) != '',
														AutoStandardI.InterfaceTranslator.ssn_value.val(searchMod),
														searchMod.SSN);
		Input_PhoneNumber   := IF( AutoStandardI.InterfaceTranslator.phone_value.val(searchMod) != '',
														AutoStandardI.InterfaceTranslator.phone_value.val(searchMod),
														searchMod.Phone);
		SELF.homephone  := IF(reportMod.IsPrimarySearchPII, '', Input_PhoneNumber);
		SELF.DID         := IF( AutoStandardI.InterfaceTranslator.did_value.val(searchMod) != '',
														(UNSIGNED6)AutoStandardI.InterfaceTranslator.did_value.val(searchMod),
														(UNSIGNED6)searchMod.DID);
		SELF             := cleanAddr;
		SELF             := [];
	END;

	dReqBatch := DATASET([tFormat2Batch()]);

	iesp.phonefinder.t_PhoneFinderSearchBy CleanupSearch(recordof(dReqBatch) l) := TRANSFORM
		self.Name.first := l.name_first;
		self.Name.middle := l.name_middle;
		self.Name.last := l.name_last;
		self.Name.suffix := l.name_suffix;
		self.Address.streetNumber := l.prim_range;
		self.Address.streetPreDirection := l.predir;
		self.Address.streetName := l.prim_name;
		self.Address.streetSuffix := l.addr_suffix;
		self.Address.streetPostDirection := l.postdir;
		self.Address.unitDesignation := l.unit_desig;
		self.Address.unitNumber := l.sec_range;
		self.Address.streetAddress1 := Address.Addr1FromComponents(l.prim_range,l.predir,l.prim_name,l.addr_suffix,
																										l.postdir,l.unit_desig,l.sec_range);
		self.Address.city := l.p_city_name;
		self.Address.state := l.st;
		self.Address.zip5 := l.z5;
		self.Address.zip4 := l.zip4;
		self.PhoneNumber := l.homephone;
		self.UniqueId := (STRING)l.did;
		self := l;
		self := [];
	END;

	cleanpSearchBy := PROJECT(dReqBatch, CleanupSearch(LEFT));

	formattedSearchBy := cleanpSearchBy[1];

  dPFGateways := IF(reportMod.TransactionType = PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT,
                    dGateways(servicename IN PhoneFinder_Services.Constants.PhoneRiskAssessmentGateways),
                    dGateways);

	modRecords := PhoneFinder_Services.PhoneFinder_Records(dReqBatch, reportMod, dPFGateways, formattedSearchBy, pfSearchBy);

  iesp.phonefinder.t_PhoneFinderSearchResponse tFormat2IespResponse() :=
  TRANSFORM
    SELF._Header   := iesp.ECL2ESP.GetHeaderRow();
    SELF.Records   := PROJECT(modRecords.dFormat2IESP, TRANSFORM(iesp.phonefinder.t_PhoneFinderSearchRecord,
                                                                SELF.PrimaryPhoneDetails := PROJECT(LEFT.PrimaryPhoneDetails, TRANSFORM(iesp.phonefinder.t_PhoneFinderDetailedInfo, SELF := LEFT));
                                                                SELF.OtherPhones         := PROJECT(LEFT.OtherPhones, TRANSFORM(iesp.phonefinder.t_PhoneFinderInfo, SELF := LEFT));
                                                                SELF := LEFT));
    SELF.InputEcho := pfSearchBy;
  END;

  dPhoneFinder := DATASET([tFormat2IespResponse()]);

 // return blank  dataset when identities child dataset is blank and carrier name is blank
	IsIdentitiesExist := EXISTS(dPhoneFinder.records[1].identities);
	IsCarrierInfoExist := dPhoneFinder.records[1].PrimaryPhoneDetails.OperatingCompany.name <> '';

  results := if(~reportMod.SuppressNonRelevantRecs or (reportMod.SuppressNonRelevantRecs and (IsIdentitiesExist or IsCarrierInfoExist)),
                        dPhoneFinder);

  royalties	:= modRecords.dRoyalties;
  Zumigo_Log := modRecords.Zumigo_History_Recs;
  PF_Reporting_Dataset := modRecords.ReportingDataset;

  OUTPUT(results, named('Results'));
  OUTPUT(royalties, named('RoyaltySet'));
  OUTPUT(Zumigo_Log, named('LOG_DELTA__PHONEFINDER_DELTA__PHONES__GATEWAY'));
  OUTPUT(PF_Reporting_Dataset, named('LOG_DELTABASE'));
ENDMACRO;
