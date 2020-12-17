IMPORT doxie,BIPV2,doxie_cbrs,Alerts,AutoStandardI;

EXPORT bankruptcy_raw(BOOLEAN isFCRA = FALSE) :=
  MODULE
    SHARED UNSIGNED8 maxResults_val := AutoStandardI.InterfaceTranslator.maxResults_val.val(PROJECT(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.InterfaceTranslator.maxResults_val.params));
    SHARED UNSIGNED2 penalt_threshold := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(PROJECT(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.InterfaceTranslator.penalt_threshold_value.params));
    SHARED STRING32 applicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(PROJECT(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.InterfaceTranslator.application_type_val.params));

    SHARED empty_dids := DATASET([],doxie.layout_references);
    SHARED empty_bdids := DATASET([],doxie_cbrs.layout_references);
    SHARED empty_tmsids := DATASET([],bankruptcyv2_services.layout_tmsid_ext);
    SHARED empty_bids := DATASET([],BIPV2.IDlayouts.l_xlink_ids);
    //----------------
    // The search view
    //----------------
    EXPORT search_view(
      STRING6 in_ssn_mask = 'NONE',
      STRING1 in_party_type = '',
      STRING2 in_filing_jurisdiction = '',
      BOOLEAN in_includeCriminalIndicators = FALSE,
      BOOLEAN in_Include_AttorneyTrustee = FALSE,
      DATASET(BIPV2.IDlayouts.l_xlink_ids) in_bids = empty_bids,
      STRING1 bid_fetch_level = BIPV2.IDconstants.Fetch_Level_SELEID
      ) :=
        FUNCTION
          temp_results := bankruptcyv2_services.fn_rollup(empty_dids,empty_bdids,empty_tmsids,in_bids,bid_fetch_level,0,in_ssn_mask,TRUE,,in_party_type,in_filing_jurisdiction,isFCRA,,in_includeCriminalIndicators,in_Include_AttorneyTrustee);

          temp_sorted := SORT(
            temp_results(penalt <= penalt_threshold),
            IF(isdeepdive,1,0),penalt,-date_filed,case_number,
            IF(debtors[1].names[1].cname <> '', debtors[1].names[1].cname, debtors[1].names[1].lname), RECORD);
          
          Alerts.mac_ProcessAlerts(temp_sorted,BankruptcyV2_services.alert,temp_final);

          RETURN temp_final;
        END;
    //----------------
    // The report view
    //----------------
    EXPORT report_view(
      DATASET(doxie.layout_references) in_dids = empty_dids,
      DATASET(doxie_cbrs.layout_references) in_bdids = empty_bdids,
      DATASET(bankruptcyv2_services.layout_tmsid_ext) in_tmsids = empty_tmsids,
      UNSIGNED in_limit = 0,
      STRING6 in_ssn_mask = 'NONE',
      STRING1 in_party_type = '',
      BOOLEAN in_includeCriminalIndicators = FALSE
      ) :=
        FUNCTION
          temp_results := bankruptcyv2_services.fn_rollup(in_dids,in_bdids,in_tmsids,empty_bids,,in_limit,in_ssn_mask,FALSE,,in_party_type,,,,in_includeCriminalIndicators);
          RETURN temp_results;
        END;
    //----------------
    // The source view
    //----------------
    EXPORT source_view(
      DATASET(doxie.layout_references) in_dids = empty_dids,
      DATASET(doxie_cbrs.layout_references) in_bdids = empty_bdids,
      DATASET(bankruptcyv2_services.layout_tmsid_ext) in_tmsids = empty_tmsids,
      UNSIGNED in_limit = 0,
      STRING6 in_ssn_mask = 'NONE',
      BOOLEAN in_all_bks_for_all_debtors = FALSE,
      STRING1 in_party_type = '',
      BOOLEAN in_includeCriminalIndicators = FALSE,
      BOOLEAN skip_ids_search = FALSE
      ) :=
        FUNCTION
          temp_results := bankruptcyv2_services.fn_rollup(in_dids,in_bdids,in_tmsids,empty_bids,,in_limit,in_ssn_mask,FALSE,in_all_bks_for_all_debtors,in_party_type,,,,in_includeCriminalIndicators, ,skip_ids_search);
          RETURN temp_results;
        END;
    //----------------
    // The source view for Boolean
    //----------------
    EXPORT boolean_source_view(
      DATASET(bankruptcyv2_services.layout_tmsid_ext) in_tmsids = empty_tmsids,
      UNSIGNED in_limit = 0,
      STRING6 in_ssn_mask = 'NONE',
      STRING1 in_party_type = ''
      ) :=
        FUNCTION
          temp_results := bankruptcyv2_services.fn_boolean_rollup(in_tmsids,in_limit,in_ssn_mask,FALSE,in_party_type,isFCRA,applicationType);
          RETURN temp_results;
        END;
  END;
  
  
