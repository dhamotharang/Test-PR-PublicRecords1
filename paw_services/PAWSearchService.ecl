// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
// For the complete list of SOAP input parameters, please see the newly created (as of 20210126)
// WSinput.MAC_paw_services_PawsSarchService attribute.

/*--INFO-- Returns PAW (People at Work) records.*/
IMPORT AutoheaderV2, AutoStandardI, doxie, paw_services, Suppress, WSInput;

EXPORT PAWSearchService := MACRO

  WSInput.MAC_paw_services_PawSearchService();

  #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  BOOLEAN negate_true_defaults := FALSE : STORED('ECL_NegateTrueDefaults'); // internal ECL use only
  BOOLEAN return_waf := TRUE : STORED('ReturnAlsoFound');

// As of 12/04/20, it does not appear that this is needed any more, since tempmodids is not used anywhere
// and even though ContactID is "stored" in it, that field never shows up in the list of inputs when the query is executed on a
// roxie 8002/WsECL box. However will leave it in for historical purposes.
  // Bug: 45732: Pulled tempmodids from the PAW_Services.PAWSearchService_Records.val
  // attribute. This allows the attribute to find any PAW records given a set
  // of IDs (from any other attribute -- Initially: doxie.HFRS)
  tempmodids := MODULE(PROJECT(AutoStandardI.GlobalModule(),PAW_Services.PAWSearchService_IDs.params,OPT))
    EXPORT ContactID := 0 : STORED('ContactID');
  END;

  gmod := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(gmod);
  tempmod := MODULE(gmod, mod_access)
    EXPORT STRING DataPermissionMask := mod_access.DataPermissionMask; //conflicting definition
    EXPORT STRING DataRestrictionMask := mod_access.DataRestrictionMask; //conflicting definition
    EXPORT UNSIGNED2 REQ_PHONES_PER_ADDR := PAW_Services.Constants.MAX_PHONES_PER_ADDR : STORED('ReqPhonesPerAddr');
    EXPORT UNSIGNED2 REQ_DATES_PER_POSITION := PAW_Services.Constants.MAX_DATES_PER_POSITION : STORED('ReqDatesPerPosition');
    EXPORT UNSIGNED2 REQ_DATES_PER_EMPLOYER := PAW_Services.Constants.MAX_DATES_PER_EMPLOYER : STORED('ReqDatesPerEmployer');
    EXPORT UNSIGNED2 REQ_FEINS_PER_EMPLOYER := PAW_Services.Constants.MAX_FEINS_PER_EMPLOYER : STORED('ReqFeinsPerEmployer');
    EXPORT UNSIGNED2 REQ_COMPANY_NAMES_PER_EMPLOYER := PAW_Services.Constants.MAX_COMPANY_NAMES_PER_EMPLOYER : STORED('ReqCompanyNamesPerEmployer');
    EXPORT UNSIGNED2 REQ_ADDRS_PER_EMPLOYER := PAW_Services.Constants.MAX_ADDRS_PER_EMPLOYER : STORED('ReqAddrsPerEmployer');
    EXPORT UNSIGNED2 REQ_POSITIONS_PER_EMPLOYER := PAW_Services.Constants.MAX_POSITIONS_PER_EMPLOYER : STORED('ReqPositionsPerEmployer');
    EXPORT UNSIGNED2 REQ_SSNS_PER_PERSON := PAW_Services.Constants.MAX_SSNS_PER_PERSON : STORED('ReqSsnsPerPerson');
    EXPORT UNSIGNED2 REQ_NAMES_PER_PERSON := PAW_Services.Constants.MAX_NAMES_PER_PERSON : STORED('ReqNamesPerPerson');
    EXPORT UNSIGNED2 REQ_EMPLOYERS_PER_PERSON := PAW_Services.Constants.MAX_EMPLOYERS_PER_PERSON : STORED('ReqEmployersPerPerson');
    EXPORT UNSIGNED2 PenaltThreshold := 5;
    EXPORT includeAlsoFound := return_waf AND ~negate_true_defaults;
    EXPORT BOOLEAN IncludeCriminalIndicators := FALSE : STORED('IncludeCriminalIndicators');
  END;
  mod_paw := PROJECT(tempmod, PAW_Services.PAWSearchService_Records.params, OPT);

  // Bug: 45732 -
  // removed retrieving IDs from the PAW_Services.PAWSearchService_Records.val
  // attribute to allow the Doxie.HFRS to call the attribute with its IDs
  // allowing the doxie.hfrs to display a PAW-v2 child dataset in
  // standard PAW rollup format
  ids := paw_services.PAWSearchService_IDs.val(mod_paw);

  tempresults := PAW_Services.PAWSearchService_Records.val(ids,mod_paw);

  //Suppress by SSN and DID.
  Suppress.MAC_Suppress_Child.keyLinked(tempresults, , ssn_suppressed, tempmod.applicationType, Suppress.Constants.LinkTypes.SSN, ssn, __seq, ssns, TRUE);
  Suppress.MAC_Suppress(ssn_suppressed, did_suppressed, tempmod.applicationType, Suppress.Constants.LinkTypes.DID, did);

  doxie.MAC_Header_Field_Declare();
  doxie.MAC_Marshall_Results(did_suppressed,tempmarshalled);

  OUTPUT(tempmarshalled,NAMED('Results'));

ENDMACRO;


