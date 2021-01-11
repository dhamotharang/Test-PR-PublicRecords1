// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- Replacement for Moxie bpssearch */
IMPORT iesp, AutoStandardI, doxie, Royalty;

EXPORT PersonSearchService () := MACRO
 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	//The following macro defines the field sequence on WsECL page of query.
	WSInput.MAC_PersonSearch_Services_PersonSearchService();

	#constant('IncludeHRI', true);
	#constant('BpsLeadingNameMatch', true);
	#constant('UseSSNFallBack', true);
	#constant('AllowFuzzyDOBMatch', false);
	#constant('FuzzySecRange', 1);
	#constant('IncludeZeroDIDRefs', true);  // allow for matches from the daily fetches that don't have a DID


  rec_in := iesp.bpssearch.t_BpsSearchRequest;
  ds_in := DATASET ([], rec_in) : STORED ('BpsSearchRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;

  //set options
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

  //set main search criteria:
	search_by := global (first_row.SearchBy);
	search_options := global (first_row.Options);

  // Added for the FDN project, to handle 3 FDN only required input fields
	fdn_user := global (first_row.FDNUser);
	#stored ('GlobalCompanyId', fdn_user.GlobalCompanyId);
	#stored ('IndustryType',  fdn_user.IndustryType);
	#stored ('ProductCode', fdn_user.ProductCode);

  // this will set SSN, DID, Name and Address
  report_by := ROW (search_by, transform (iesp.bpsreport.t_BpsReportBy, Self := Left; Self := []));

	clean_inputs := true;
  iesp.ECL2ESP.SetInputReportBy (report_by, clean_inputs);

	#stored ('ZipRadius', search_by.Radius);
	#stored ('AgeLow', search_by.AgeRange.Low);
	#stored ('AgeHigh', search_by.AgeRange.High);
  #stored ('allownicknames', search_options.UseNicknames);
  #stored ('phoneticmatch', search_options.UsePhonetics);
  #stored ('StrictMatch', search_options.StrictMatch);
  #stored ('IncludeBankruptcies', search_options.IncludeBankruptcy);
  #stored ('IncludePriorAddresses', search_options.IncludePriorAddresses);
  #stored ('IncludeSourceDocCounts', search_options.IncludeSourceDocCounts);
  #stored ('ReturnAlsoFound', search_options.ReturnAlsoFound);
	#stored ('IncludePhonesPlus', search_options.IncludePhonesPlus or search_options.IncludeAlternatePhonesCount);
	#stored ('IncludeAlternatePhonesCount', search_options.IncludeAlternatePhonesCount);
	#stored ('includealldidrecords', search_options.IncludeAllUniqueIdRecords);
	#stored ('IncludeCriminalIndicators', search_options.IncludeCriminalIndicators);
	#stored ('EnhancedSort', search_options.EnhancedSort);
	#stored ('IncludePhonesFeedback', search_options.IncludePhonesFeedback);
	#stored ('IncludeAddressFeedback', search_options.IncludeAddressFeedback);
	boolean in_IncludeAlternatePhonesCount := false : stored('IncludeAlternatePhonesCount');
	boolean in_IncludePhonesPlus := search_options.IncludePhonesPlus;
  boolean in_returnAlsoFound := false : stored('ReturnAlsoFound');

	#stored ('CheckNameVariants', search_options.CheckNameVariants);
  boolean BlanksFilledIn := search_options.BlanksFilledIn;
  #stored ('DoNotFillBlanks', ~BlanksFilledIn);

	// default Addr HRI to true, others to false
  boolean in_includeSSNHri := false : stored('IncludeSSNHri');
  boolean in_includeAddrHri := true : stored('IncludeAddrHri');
  boolean in_includePhoneHri := false : stored('IncludePhoneHri');

	#stored ('UsePartialSSNMatch', search_options.UsePartialSSNMatch);
	boolean in_PartialSSNMatch := false : stored('UsePartialSSNMatch');
	boolean in_allowEditDist := false : stored('CheckNameVariants');
	boolean in_IncludeCriminalIndicators := false : stored('IncludeCriminalIndicators');
	boolean in_EnhancedSort := false : stored('EnhancedSort');
	boolean in_IncludePhonesFeedback := false : STORED('IncludePhonesFeedback');
	boolean in_IncludeAddressFeedback := false : STORED('IncludeAddressFeedback');
	set of string in_IncludeSourceList := SET(search_options.IncludeSourceList, value);

  // Added for the FDN project, 1 new input option & 3 required input fields
	#stored ('IncludeFraudDefenseNetwork', search_options.IncludeFraudDefenseNetwork);
  boolean in_IncludeFraudDefenseNetwork := false : stored('IncludeFraudDefenseNetwork');
	unsigned6 in_FDN_gcid     := 0 : stored('GlobalCompanyId');
	unsigned2 in_FDN_indtype  := 0 : stored('IndustryType');
	unsigned6 in_FDN_prodcode := 0 : stored('ProductCode');

	input_params := AutoStandardI.GlobalModule();
	mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);
	tempmod := module(input_params, mod_access)
		export string DataPermissionMask := mod_access.DataPermissionMask; //conflicting definition
		export string DataRestrictionMask := mod_access.DataRestrictionMask; //conflicting definition
		export returnAlsoFound := in_returnAlsoFound;
		export includeSSNHri := in_includeSSNHri;
		export includeAddrHri := in_includeAddrHri;
		export includePhoneHri := in_includePhoneHri;
		export allowPartialSSNMatch := in_PartialSSNMatch;
		export allowEditDist := in_allowEditDist;
		export IncludeAlternatePhonesCount := in_IncludeAlternatePhonesCount;
		export includePhonesPlus := in_IncludePhonesPlus;
    export IncludeCriminalIndicators := in_IncludeCriminalIndicators;
		export EnhancedSort := in_EnhancedSort;
		export IncludePhonesFeedback := in_IncludePhonesFeedback;
		export IncludeAddressFeedback := in_IncludeAddressFeedback;
		export unsigned SourceDocFilter := doxie.SourceDocFilter.GetBitmask(in_IncludeSourceList);
    // Added for the FDN project, 1 new input option & 3 required input fields
		export IncludeFraudDefenseNetwork  := in_IncludeFraudDefenseNetwork;
	  export unsigned6 FDNinput_gcid     := in_FDN_gcid;
	  export unsigned2 FDNinput_indtype  := in_FDN_indtype;
	  export unsigned6 FDNinput_prodcode := in_FDN_prodcode;
	end;
	mod_search := PROJECT(tempmod, PersonSearch_Services.Search_Records.params, OPT);

	tempresults := PersonSearch_Services.Search_Records.val(mod_search);
	FDN_check     := tempresults(FDNResultsFound=true);
  FDN_Royalties := Royalty.RoyaltyFDNCoRR.GetOnlineRoyalties(FDN_check);
  royalties     := if(mod_search.IncludeFraudDefenseNetwork, FDN_Royalties);
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tempresults, results,
                         iesp.bpssearch.t_BpsSearchResponse, Records, false, SubjectTotalCount);

  output(royalties,named('RoyaltySet'));
  output(results,named('Results'));

ENDMACRO;
