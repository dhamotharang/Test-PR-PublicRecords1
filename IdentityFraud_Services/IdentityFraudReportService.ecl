// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
// TODO: define ESDL interface
// TODO: expose "get minors"
IMPORT iesp, doxie, AutoHeaderI, AutoStandardI, IdentityFraud_Services, PersonReports, ut, seed_files, suppress;

EXPORT IdentityFraudReportService () := MACRO
#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
#onwarning(4207, warning);
#constant('SelectIndividually', true); // we will setup all components explicitly

// need these for imposters
#constant('IncludeAKAs', true);
#constant('IncludeImposters', true);

#constant('IncludeAllDIDRecords',true); //
#constant('useOnlyBestDID',true); // narrows down the search results (for example, by ssn, or by by phone+fname).
#constant('IsCRS',true);
#constant('UsingKeepSSNs', false); // to ensure that we will always keep old SSNs (i.e. no pruning)

// suppress all masking in the legacy code, since these values are used for linking, matching, etc.
#constant ('SSNMask', 'NONE');
#constant ('DLMask', false);
#constant ('DOBMask', 'NONE');
// for a client sending masking parameters outside of ESDL structure:
string ssn_mask_overload := '' : stored ('SSNMask_Overload');
boolean dl_mask_overload := false : stored ('DLMask_Overload');
string dob_mask_overload := '' : stored ('DOBMask_Overload');

  // for convenience only: to make it work from flat SOAP
  SetLegacyInput (iesp.identityfraudreport.t_IdentityFraudReportBy xml_in) := function
				#stored ('dl_state', xml_in.DLState);
				#stored ('dl_number', xml_in.DLNumber);
				iesp.ECL2ESP.EnforceRead ();
    return 0;
  end;

  // parse ESDL input
  ds_in := DATASET ([], iesp.identityfraudreport.t_IdentityFraudReportRequest) : STORED ('IdentityFraudReportRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;

  // this will #store some standard input parameters (generally, for search purpose)
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  // may be needed, since we calculate penalty; but it will require change in ESP
  iesp.ECL2ESP.SetInputReportBy (project (first_row.ReportBy, transform (iesp.bpsreport.t_BpsReportBy, self := Left; Self := [])));
  SetLegacyInput (global (first_row.ReportBy));

  // there are not too much options for report, so I'll skip reading them separately for ESDL and SOAP modes
  tag_options := global (first_row.Options);
  options := module
    export boolean include_phonesplus := tag_options.IncludePhonesPlus	:	stored('IncludePhonesPlus');
				export boolean include_identity_risk_level := tag_options.IncludeIdentityRisklevel : stored('IncludeIdentityRisklevel');
				export boolean include_source_risk_level := tag_options.IncludeSourceRisklevel : stored('IncludeSourceRisklevel');
				export boolean include_velocity_risk_level := tag_options.IncludeVelocityRisklevel : stored('IncludeVelocityRisklevel');
				export boolean skip_penalty_filter := tag_options.SkipPenaltyFilter : stored('SkipPenaltyFilter');
  end;

  // get search parameters from global #stored variables;
  gmod := AutoStandardI.GlobalModule();
  search_mod := module (project (gmod, PersonReports.IParam._didsearch, opt))
  end;
  t_user := global(first_row.User);

  // Now define all report parameters, redefine defaults
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(gmod);

  report_mod := module (mod_access, options)
    max_imp := iesp.constants.IFR.MaxAssociatedIdentities : stored ('MaxImposters');
    export unsigned max_imposters := min (iesp.constants.IFR.MaxAssociatedIdentities, max_imp);

    // Do all required cleaning/translations here
    export unsigned1 score_threshold := AutoStandardI.InterfaceTranslator.score_threshold_value.val (search_mod);
    export boolean include_ri_uspis := true;
    export boolean include_ri_advo := true;

    // set up masking restrictions: to be applied at the very end of the report
    // if no other than "default" values provided in User structure, use new masking parameters
    string ssn_mask_esdl := stringlib.StringToUpperCase (t_user.SSNMask);
    export string ssn_mask := if (ssn_mask_esdl != '', ssn_mask_esdl, ssn_mask_overload);
    export unsigned1 dl_mask  := if (t_user.DLMask or dl_mask_overload, 1, 0);
    export unsigned1 dob_mask := suppress.date_mask_math.MaskIndicator (if (t_user.DOBMask != '', t_user.DOBMask, dob_mask_overload));

    // debug:
    export boolean count_by_source := false : stored('CountBySource');
    export unsigned1 max_top_hri := 6 : stored ('MaxTopHRIs');
    export boolean include_summary := false : stored('IncludeSummary');
    export unsigned1 indicators_per_imposter := 3 : stored('MaxIndicatorsPerImposter');
  end;

  // dids from input
  did_value := AutoStandardI.InterfaceTranslator.did_value.val(project(search_mod,AutoStandardI.InterfaceTranslator.did_value.params));
  dids_input := dataset ([(unsigned6) did_value], doxie.layout_references);

  // dids from standard header search
  dids_search := PROJECT(AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do(search_mod), doxie.layout_references);

  // dids by DL and state (can also read them directly from XML)
  string  dl_number := '' : stored ('dl_number'); //"translation" is trivial
  string2 dl_state  := '' : stored ('dl_state');
  dids_dl := IdentityFraud_Services.Functions.GetDidsByDL (stringlib.StringToUpperCase (dl_number), stringlib.StringToUpperCase (dl_state));

  dids := MAP (did_value != '' => dids_input,
               dl_number != '' => dids_dl,
               dids_search);

	ifrReportMod	:=	IdentityFraud_Services.IdentityFraudReport (dids, project (report_mod, IdentityFraud_Services.IParam._identityfraudreport, OPT), FALSE);

  // main records
  main_results := ifrReportMod.results;

	// email royalties
	email_recs	:=	ifrReportMod.email_results;

	// ROYALTIES
	Royalty.MAC_RoyaltyEmail(email_recs, royalties_email,, false)

  // test run
  boolean is_testrun := first_row.User.TestDataEnabled : stored ('TestDataEnabled');
  string20 testrun_tablename := first_row.User.TestDataTableName : stored ('TestDataTableName');

  this_hash := seed_files.hash_instantid (trim (search_mod.firstname), trim (search_mod.lastname), trim (search_mod.ssn),
                                          '', trim (search_mod.zip), trim (search_mod.phone), '');

  test_key := seed_files.key_identityreport;
  // additional test in case of hash conflicts
  is_matched := (test_key.firstname = search_mod.firstname) and (test_key.lastname = search_mod.lastname) and
                (test_key.ssn = search_mod.ssn) and (test_key.zip5 = search_mod.zip) and (test_key.phone = search_mod.phone);

  key_match := test_key (keyed (hashvalue = this_hash), ut.NNEQ (testrun_tablename, test_key.table_name), is_matched);
  hash_match := limit (key_match, 1, fail (203, doxie.ErrorCodes (203)));
  test_results := IdentityFraud_Services.IdentityFraudReportTest (project (hash_match, Seed_Files.layout_identityreport.rec_in_slim));

  integer cnt := if (is_testrun, count (hash_match), count (dids));
  results := if (is_testrun, test_results, main_results);

  MAP (cnt > 1 => fail (203, doxie.ErrorCodes (203)), // 'Too many subjects found'
       // cnt = 0 => fail (10, doxie.ErrorCodes (10)), // 'No records found'
       sequential (//output (is_testrun, named ('test_run')),
                   //output (this_hash, named ('this_hash')),
                   output (results, named ('Results')),
									 output (royalties_email,named('RoyaltySet'))));

ENDMACRO;
// IdentityFraudReportService ();
