IMPORT $, AutoHeaderI, AutokeyI, AutoStandardI, BatchShare, BIPV2,
       Suppress, TopBusiness_Services, FCRA, FFD, iesp, Address, DeathV2_Services, Doxie;

EXPORT IParam := MODULE

  SHARED it := AutoStandardI.InterfaceTranslator;
  SHARED common_params := INTERFACE(it.did_value.params,
                                         it.bdid_value.params,
                                         it.lname_value.params,
                                         it.state_value.params)
  EXPORT STRING CertificateNumber := '';
  EXPORT UNSIGNED2 pt := 10;
  END;

  EXPORT base_params := INTERFACE(
    AutoKeyI.AutoKeyStandardFetchBaseInterface,
    AutoHeaderI.LIBIN.FetchI_Hdr_Indv.base,
    AutoHeaderI.LIBIN.FetchI_Hdr_Biz.base)
  END;

  EXPORT ak_params := INTERFACE(
    common_params,
    base_params,
    it.ssn_mask_val.params,
    it.party_type.params)
  EXPORT BOOLEAN nodeepdive := FALSE;
  END;

  EXPORT search_params := INTERFACE(
    ak_params,
    it.maxresults_val.params,
    it.liencasenumber_value.params,
    it.FilingNumber_value.params,
    it.FilingJurisdiction_value.params,
    it.IRSSerialNumber_value.params,
    it.rmsid_value.params,
    it.tmsid_value.params,
    TopBusiness_Services.iParam.BIDParams,
    FCRA.iRules)
    EXPORT INTEGER1 non_subject_suppression := Suppress.Constants.NonSubjectSuppression.doNothing;
    EXPORT STRING person_filter_id := '';
    EXPORT BOOLEAN includeCriminalIndicators := FALSE;
    EXPORT BOOLEAN subject_only := FALSE;
  END;

  EXPORT batch_params := INTERFACE (BatchShare.IParam.BatchParams,FCRA.iRules)
    EXPORT SET OF STRING1 party_types := ['A','C','D',''];
    EXPORT BOOLEAN no_did_append := FALSE;
    EXPORT BOOLEAN no_bdid_append := FALSE;
    // Preferential matching:
    EXPORT BOOLEAN MatchName := FALSE;
    EXPORT BOOLEAN MatchStrAddr := FALSE;
    EXPORT BOOLEAN MatchCity := FALSE;
    EXPORT BOOLEAN MatchState := FALSE;
    EXPORT BOOLEAN MatchZip := FALSE;
    EXPORT BOOLEAN MatchSSN := FALSE;
    //Non Subject Suppression param
    EXPORT INTEGER1 non_subject_suppression := Suppress.Constants.NonSubjectSuppression.doNothing;
    EXPORT STRING1 BIPFetchLevel := BIPV2.IDconstants.Fetch_Level_SELEID;
  END;

  EXPORT liensRetrieval_params := INTERFACE (FCRA.iRules, DeathV2_Services.IParam.DeathRestrictions)
    EXPORT STRING32 DeferredTransactionID := ''; // for deferred request
    EXPORT STRING32 TransactionID := ''; // to pass to okc gateway
    EXPORT BOOLEAN DeferredTaskRequest := FALSE;
    EXPORT BOOLEAN InputOk := FALSE;
    EXPORT BOOLEAN Invalid_FilingtypeID := FALSE;
    EXPORT BOOLEAN TestDataEnabled := FALSE;
    EXPORT STRING32 TestDataTableName := '';
  END;

  EXPORT GetLiensRetrievalParams(iesp.riskview_publicrecordretrieval.t_PublicRecordRetrievalRequest request) := FUNCTION

    options := request.options;
    search_by := request.SearchBy;

    //validating the minimum required input fields in the request

    BOOLEAN hasFirstName := search_by.Name.First <> '';
    BOOLEAN hasLastName := search_by.Name.Last <> '';
    STRING60 StreetAddrComp := Address.Addr1FromComponents(
      search_by.Address.StreetNumber, search_by.Address.StreetPreDirection, search_by.Address.StreetName,
      search_by.Address.StreetSuffix, search_by.Address.StreetPostDirection, search_by.Address.UnitDesignation,
      search_by.Address.UnitNumber);
    BOOLEAN hasStreetAddress := search_by.Address.StreetAddress1 <> '' OR StreetAddrComp <>'';
    BOOLEAN hasCity := search_by.Address.City <> '';
    BOOLEAN hasState := search_by.Address.State <>'';
    BOOLEAN hasZip5 := search_by.Address.Zip5 <> '';
    BOOLEAN hasSSN := search_by.SSN <> '';
    BOOLEAN hasFilingTypeID := search_by.FilingTypeID <> '';
    BOOLEAN hasFilingNumber := search_by.FilingNumber <>'';
    BOOLEAN hasBook := search_by.FilingBook <> '';
    BOOLEAN hasPage := search_by.FilingPage <> '';
    BOOLEAN hasRecordID := search_by.RecordID <> '';
    BOOLEAN hasAgency := search_by.Agency <> '';
    BOOLEAN hasAgencyCounty := search_by.AgencyCounty <> '';
    BOOLEAN hasAgencyState := search_by.AgencyState <> '';
    BOOLEAN hasAgencyID := search_by.AgencyID <> '';

    // checking for insufficinet input
    input_ok := 
      ((hasFirstName AND hasLastName AND hasStreetAddress AND hasZip5) OR
        (hasFirstName AND hasLastName AND hasStreetAddress AND hasCity AND hasState) OR
        (hasFirstName AND hasLastName AND hasSSN))
        AND
      ((hasFilingTypeID AND (hasFilingNumber OR (hasBook AND hasPage))) OR hasRecordID)
        AND
      ((hasAgency AND hasAgencyCounty AND hasAgencyState) OR hasAgencyID);

    mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
    death_params := DeathV2_Services.IParam.GetRestrictions(mod_access);
    params := MODULE(PROJECT(death_params, liensRetrieval_params, OPT))
      // EXPORT UNSIGNED6 did := UniqueId;
      EXPORT INTEGER8 FFDOptionsMask := FFD.FFDMask.Get(options.FFDOptionsMask);
      EXPORT INTEGER FCRAPurpose := FCRA.FCRAPurpose.Get(options.FCRAPurpose);
      EXPORT STRING32 DeferredTransactionID := options.DeferredTransactionID;
      EXPORT STRING32 TransactionID := mod_access.transaction_id;
      EXPORT BOOLEAN DeferredTaskRequest := DeferredTransactionID <> '';
      EXPORT BOOLEAN InputOk := input_ok;
      EXPORT BOOLEAN Invalid_FilingtypeID := 
        search_by.FilingTypeID <> '' AND search_by.FilingTypeID NOT IN $.Constants.LIENS_RETRIEVAL.Valid_FilingtypeID;
      EXPORT BOOLEAN TestDataEnabled := request.User.TestDataEnabled;
      EXPORT STRING32 TestDataTableName := request.User.TestDataTableName;
    END;
    RETURN params;
  END;
END;
