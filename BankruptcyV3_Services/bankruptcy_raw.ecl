IMPORT doxie, doxie_cbrs, Alerts, AutoStandardI, BankruptcyV3_Services,
       NID, address;

EXPORT bankruptcy_raw(BOOLEAN isFCRA = FALSE) :=
  MODULE
    SHARED UNSIGNED8 maxResults_val := AutoStandardI.InterfaceTranslator.maxResults_val.val(PROJECT(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.InterfaceTranslator.maxResults_val.params));
    SHARED UNSIGNED2 penalt_threshold := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(PROJECT(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.InterfaceTranslator.penalt_threshold_value.params));
    SHARED STRING32 applicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(PROJECT(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.InterfaceTranslator.application_type_val.params));
    SHARED STRING4 in_SSNLast4 := '' : STORED('SSNLast4');
    SHARED empty_dids := DATASET([],doxie.layout_references);
    SHARED empty_bdids := DATASET([],doxie_cbrs.layout_references);
    SHARED empty_tmsids := DATASET([],bankruptcyv3_services.layouts.layout_tmsid_ext);
    //----------------
    // The search view
    //----------------
    EXPORT search_view(
      STRING6 in_ssn_mask = 'NONE',
      STRING1 in_party_type = '',
      STRING2 in_filing_jurisdiction = '',
      BOOLEAN suppress_withdrawn_bankruptcy = FALSE,
      BOOLEAN EnableCaseNumberFilter = FALSE,
      STRING2 in_state = '',
      STRING9 in_ssn = '',
      STRING50 in_lname = '',
      STRING30 in_fname = '',
      STRING25 in_case_number = '',
      UNSIGNED6 in_did = 0,
      STRING25 in_city = '',
      STRING120 in_attorney_name = '', // This can be an Attorney Person OR Attorney Company name
      STRING10 in_court_code = ''
      ) := FUNCTION

      AttorneyCompanyName := in_attorney_name;
      cleaned_AttorneyPersonName := Address.CleanPerson73_fields(in_attorney_name);
      AttorneyPersonName_First := cleaned_AttorneyPersonName.fname;
      AttorneyPersonName_Last := cleaned_AttorneyPersonName.lname;
      BOOLEAN isAttorneySearch := in_attorney_name != '';

      temp_results1 := bankruptcyv3_services.fn_rollup(empty_dids,empty_bdids,empty_tmsids,0,in_ssn_mask,TRUE,,
        in_party_type,in_filing_jurisdiction, isFCRA, in_SSNLast4,FALSE,
        '','',applicationType,EnableCaseNumberFilter, isAttorneySearch);

      // FCRA overrides
      temp_results_corr := BankruptcyV3_Services.fn_fcra_correct(temp_results1, in_ssn_mask);
      temp_results2 := IF (isFCRA, temp_results_corr, temp_results1);
      temp_results_raw := BankruptcyV3_Services.fn_add_withdrawn_status(temp_results2, isFCRA, suppress_withdrawn_bankruptcy);

      // When the case number is input, filter the results to remove any records that don't contain the case number
      temp_results_raw_with_case_number := temp_results_raw( case_number = in_case_number OR
                                                              full_case_number = in_case_number);
      SameLocation(ds_debtors, input_state, input_city) := FUNCTIONMACRO
        RETURN
          (EXISTS(ds_debtors.addresses(st = input_state)) OR filing_jurisdiction = input_state ) AND
          (EXISTS(ds_debtors.addresses(p_city_name = input_city)) OR court_location = input_city );
      ENDMACRO;

      SameName(pp, Attorney_First, Attorney_Last, Attorney_Company) := FUNCTIONMACRO
        RETURN
          (NID.PreferredFirstNew(pp.fname) = NID.PreferredFirstNew(Attorney_First) AND
            pp.lname = Attorney_Last)
          OR
            pp.cname = Attorney_Company;
      ENDMACRO;


      attorney_name_search_pre := temp_results_raw_with_case_number(
        (matched_party.party_type = 'A') AND
        SameLocation (debtors, in_state, in_city) AND
        SameName (matched_party.parsed_party, AttorneyPersonName_First, AttorneyPersonName_Last, AttorneyCompanyName)
      );
      /* In case of attorney name, casenumber search, there is possiblity of tmsid duplicates.
        We allowed this to catch both company aswell as person attorney. We are deduping based on TMSID now */
      attorney_name_search := DEDUP(SORT(attorney_name_search_pre,
        tmsid,(UNSIGNED6)matched_party.did), tmsid);

      temp_results_filtered_by_input :=
      MAP(
        in_ssn != '' => temp_results_raw_with_case_number(EXISTS(debtors(in_ssn IN [ssn,app_ssn,ssnmatch]))),
        in_did != 0 => temp_results_raw_with_case_number((UNSIGNED6)matched_party.did = in_did),
        in_fname != '' AND in_lname != '' =>
          temp_results_raw_with_case_number(
            NID.PreferredFirstNew(matched_party.parsed_party.fname) = NID.PreferredFirstNew(in_fname) AND
            matched_party.parsed_party.lname = in_lname AND
            (EXISTS(debtors.addresses(st = in_state)) OR filing_jurisdiction = in_state )
        ),
        isAttorneySearch => attorney_name_search,
        in_court_code != '' => temp_results_raw_with_case_number(court_code = in_court_code),
        DATASET([],RECORDOF(temp_results_raw_with_case_number))
      );

      temp_results := IF(EnableCaseNumberFilter, temp_results_filtered_by_input,
        temp_results_raw);

      temp_sorted := SORT(
        // temp_results(penalt <= in_parms.penalt_threshold),
        temp_results(penalt <= penalt_threshold),
        isdeepdive,penalt,-date_filed,case_number,
        IF(debtors[1].names[1].cname <> '', debtors[1].names[1].cname, debtors[1].names[1].lname), RECORD);

      Alerts.mac_ProcessAlerts(temp_sorted,BankruptcyV3_services.alert,temp_final);

      RETURN temp_final;
    END;

    //----------------
    // The report view
    //----------------
    EXPORT report_view(
      DATASET(doxie.layout_references) in_dids = empty_dids,
      DATASET(doxie_cbrs.layout_references) in_bdids = empty_bdids,
      DATASET(bankruptcyv3_services.layouts.layout_tmsid_ext) in_tmsids = empty_tmsids,
      UNSIGNED in_limit = 0,
      STRING6 in_ssn_mask = 'NONE',
      STRING1 in_party_type = ''
      ) :=
      FUNCTION
        temp_results := bankruptcyv3_services.fn_rollup(in_dids,in_bdids,in_tmsids,in_limit,in_ssn_mask,FALSE,,in_party_type,'',isfcra,'',FALSE,'','',applicationType);
        RETURN temp_results;
      END;
    //----------------
    // The source view
    //----------------
    EXPORT source_view(
      DATASET(doxie.layout_references) in_dids = empty_dids,
      DATASET(doxie_cbrs.layout_references) in_bdids = empty_bdids,
      DATASET(bankruptcyv3_services.layouts.layout_tmsid_ext) in_tmsids = empty_tmsids,
      UNSIGNED in_limit = 0,
      STRING6 in_ssn_mask = 'NONE',
      BOOLEAN in_all_bks_for_all_debtors = FALSE,
      STRING1 in_party_type = '',
      BOOLEAN include_dockets = FALSE,
      STRING8 lower_entered_date = '',
      STRING8 upper_entered_date = '',
      BOOLEAN suppress_withdrawn_bankruptcy = FALSE
      ) := FUNCTION

        temp_results1 := bankruptcyv3_services.fn_rollup(in_dids,in_bdids,in_tmsids,in_limit,in_ssn_mask,FALSE,
          in_all_bks_for_all_debtors,in_party_type, ,isFCRA,,include_dockets,
          lower_entered_date, upper_entered_date,applicationType);

        // FCRA overrides
        temp_results_corr := BankruptcyV3_Services.fn_fcra_correct(temp_results1, in_ssn_mask);
        temp_results := IF (isFCRA, temp_results_corr, temp_results1);

        bk_results := BankruptcyV3_Services.fn_add_withdrawn_status(temp_results,isFCRA,suppress_withdrawn_bankruptcy);

        RETURN bk_results;
      END;

    //----------------
    // The source view for Boolean
    //----------------
    EXPORT boolean_source_view(
      DATASET(bankruptcyv3_services.layouts.layout_tmsid_ext) in_tmsids = empty_tmsids,
      UNSIGNED in_limit = 0,
      STRING6 in_ssn_mask = 'NONE',
      STRING1 in_party_type = ''
      ) := FUNCTION
        temp_results := bankruptcyv3_services.fn_boolean_rollup(in_tmsids,in_limit,in_ssn_mask,FALSE,in_party_type,isFCRA,applicationType);
        RETURN temp_results;
      END;
  END;
