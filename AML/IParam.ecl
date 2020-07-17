IMPORT doxie, risk_indicators, suppress, AutoStandardI;

// AML interfaces
EXPORT IParam := MODULE

  // Main interface: I'm extending IDataAccess just as a starting point, it will be easy to extend it
  // from more generic scoring-oriented interface, when it is available.

  // Module implementing the interface shouldn't be created directly (i.e. as MODULE(IAml)),
  // so I'm not redefining defaults that are different between Scoring and PR.
  // Normal usage is either

  //       mod_aml := MODULE(PROJECT(mod_src, AML.IParam.IAml)
  //         EXPORT unsigned1 glb := ...;
  //         ...
  //       END;

  // or through the function GetAmlInputModule below.

  EXPORT IAml := INTERFACE (doxie.IDataAccess)
    EXPORT unsigned1 bs_version := 1;
    EXPORT unsigned8 bs_options := risk_indicators.iid_constants.BSOptions.IsAML;
    // Other fields to consider: gateways, isPreScreen, doScore, UseXG5

    // EXPORT unsigned1 glb := 0;
    // EXPORT unsigned1 dppa := 0;
    // EXPORT string DataPermissionMask := '';
    // EXPORT string DataRestrictionMask := '111111111111111111111111111111111111111111111111111111111111';
    // EXPORT boolean ln_branded := FALSE;
    // EXPORT boolean probation_override := FALSE;
    // EXPORT string5 industry_class := 'UTILI';
    // EXPORT string32 application_type := '';
    // EXPORT boolean no_scrub := FALSE;
    // EXPORT unsigned3 date_threshold := 0; // a.k.a. dateVal
    // EXPORT boolean suppress_dmv := TRUE;
    // EXPORT unsigned1 reseller_type := 0;
    // EXPORT unsigned1 intended_use := 0;
    // EXPORT boolean log_record_source := TRUE;
    // EXPORT unsigned1 lexid_source_optout := 1;
    // EXPORT boolean show_minors := FALSE;  //a.k.a. OKtoShowMinors
    // EXPORT string ssn_mask := suppress.constants.ssn_mask_type.ALL;
    // EXPORT unsigned1 dl_mask := 1;
    // EXPORT unsigned1 dob_mask := suppress.constants.dateMask.ALL;
    // EXPORT string transaction_id := '';
    // EXPORT unsigned6 global_company_id := 0;
  END;


  // Create a module based on customer's input and AML specifics
  EXPORT GetAmlInputModule () := FUNCTION

    // Redefine the defaults that are different from doxie.IDataAccess;
    // this can be done in more generic scoring-oriented interface, if exists.
    string trans_id := '' : STORED ('_TransactionId');
    string batch_uid := '' : STORED('_BatchUID');
    outofbanddobmask := '' : STORED('DOBMask');

    mod_aml := MODULE (IAml)
      // EXPORT unsigned1 unrestricted := 0;
      EXPORT unsigned1 glb := 0 : STORED('GLBPurpose');
      EXPORT unsigned1 dppa := 3  : STORED('DPPAPurpose');
      EXPORT string DataPermissionMask := risk_indicators.iid_constants.default_DataPermission : STORED('DataPermissionMask');
      //cannot read DRM with default from risk-indicators:
      // EXPORT string DataRestrictionMask := Risk_Indicators.iid_constants.default_DataRestriction : STORED('DataRestrictionMask');
      EXPORT string DataRestrictionMask := AutoStandardI.GlobalModule().DataRestrictionMask;
      EXPORT string5 industry_class := ''; // to warrant isUtility=FALSE
      EXPORT boolean suppress_dmv := FALSE : STORED('ExcludeDMVPII');
      EXPORT unsigned1 lexid_source_optout := 1 : STORED ('LexIdSourceOptout');
      EXPORT string ssn_mask := '' : STORED('SSNMask');
      EXPORT unsigned1 dl_mask :=  0;
      EXPORT unsigned1 dob_mask := suppress.date_mask_math.MaskIndicator (outofbanddobmask);
      EXPORT string transaction_id := IF(trans_id <> '', trans_id, batch_uid);
      EXPORT unsigned6 global_company_id := 0 : STORED('_GCID');
    END;

    RETURN mod_aml;
  END;

END;
