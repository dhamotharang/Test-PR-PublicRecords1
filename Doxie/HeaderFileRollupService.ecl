// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- This service searches the header file w/ Tsunami tweaks with results rolled up.*/
IMPORT Gong_Services, WSInput, STD;

EXPORT HeaderFileRollupService := MACRO
    #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
    //The following macro defines the field sequence on WsECL page of query.
    WSInput.MAC_HeaderFileRollupService();

    #CONSTANT('UsingKeepSSNs',TRUE);
    #CONSTANT('GONG_SEARCHTYPE','PERSON');

    STRING20  BatchAccount            := ''    : STORED('BatchAccount');
    BOOLEAN   BatchFriendly           := FALSE : STORED('BatchFriendly');
    STRING    DLNumber_Value          := ''    : STORED('DLNumber');
    STRING    DLState_Value           := ''    : STORED('DLState');
    BOOLEAN   IncProgressivePhone     := FALSE : STORED('IncludeProgressivePhone');
    #STORED('dl_number', STD.Str.ToUpperCase(DLNumber_Value));

    doxie.MAC_Header_Field_Declare();
    mod_access := doxie.compliance.GetGlobalDataAccessModule();
    /*  The Business Credit (SBFE) project includes a person & business searches as well
        as a wrapper service (BusinessCredit_Services.BusinessAuthRepSearch) which calls
        both the person search (doxie.headerFileRollupService) and the business search
        (TopBusiness_Services.BusinessSearch). Doxie.HFRS did not have a mechanism to
        return the records. A change with the 3/8 release to prod moved the meat of the
        existing service to a records attribute (doxie.HeaderFileRollupService_Records)
        to allow for a direct call from the wrapper service to get retrieve the records.
    */

    // the call to the records attribute is done in two parts to allow for the various output to
    // remain in tact and not break existing services.
    mod_ta1 :=
      MODULE(doxie.HeaderFileRollupService_IParam.ta1);
        EXPORT BOOLEAN allow_date_seen    := allow_date_seen_value;
        EXPORT BOOLEAN allow_wildcard     := allow_wildcard_val;
        EXPORT INTEGER date_last_seen     := date_last_seen_value;
        EXPORT INTEGER date_first_seen    := date_first_seen_value;
        EXPORT STRING  DLNumber           := DLNumber_Value;
        EXPORT STRING  DLState            := DLState_Value;
        EXPORT STRING  pname              := pname_value;
        EXPORT BOOLEAN reduced_data       := reduced_data_value;
    END;

    // Set progressive phone params
    ProgPhone_mod := doxie.iParam.getProgressivePhoneParams();

    ta1 := doxie.HeaderFileRollupService_Records.fn_get_ta1(mod_access, mod_ta1);

    ta1_results := ta1.Results;
    royalties := ta1.Royalty;
    householdAvailableCount := ta1.householdRecordsAvailable;

    global_mod := AutoStandardI.GlobalModule();

    mod_ta2 :=
      MODULE(PROJECT(global_mod, doxie.HeaderFileRollupService_IParam.ta2, OPT));
        EXPORT BOOLEAN       Include_BusinessCredit   := FALSE : STORED('IncludeBusinessCredit');
        EXPORT BOOLEAN       Include_PhonesFeedback   := FALSE : STORED('IncludePhonesFeedback');
        EXPORT BOOLEAN       Include_AddressFeedback  := FALSE : STORED('IncludeAddressFeedback');
        EXPORT SET OF STRING Include_SourceList       := []    : STORED('IncludeSourceList'); // keeping name in sync with IncludeSourceList in Doxie.HeaderSource_Service
        EXPORT BOOLEAN       Smart_Rollup             := FALSE : STORED('SmartRollup');
      END;

    ta2 := doxie.HeaderFileRollupService_Records.fn_get_ta2(ta1_results, mod_access, mod_ta2);

    ta_phones := doxie.HeaderFileRollupService_Records.get_progressive_phone(ta2,ProgPhone_mod);

    ta_final := IF(IncProgressivePhone, ta_phones, ta2);
    //create flat version specifically designed for batch
    ta1_batch := doxie.fn_flatten_rollup(ta_final, BatchAccount);

    /* Masking DOB Recs (if applicable)

       Note: DOB Masking is not done at doxie.rollup_presentation or doxie.HeaderFileRollupService_Records
       to preserve existing logic in other attributes which may require DOB in Int/Unsigned format
    */
    ta_final_masked := doxie.FN_MaskDOB(ta_final, mod_access.dob_mask);

    OUTPUT(if (~BatchFriendly, ta_final_masked),  NAMED('Results'));
    OUTPUT(if ( BatchFriendly, ta1_batch),        NAMED('BatchResults'));
    OUTPUT(householdAvailableCount,               NAMED('HouseholdRecordsCount'));
    OUTPUT(royalties,                             NAMED('RoyaltySet'));

    // output the telecordia info any time a 10 digit phone is part of the search criteria
    OUTPUT(IF(~reduced_data_value, Gong_Services.Fetch_Telcordia_for_Gong_History), NAMED('TelcordiaRecs'));
ENDMACRO;
