IMPORT AutoStandardI,bankruptcyv3,codes,doxie,doxie_cbrs,bankruptcyv2_services,BIPV2,CriminalRecords_Services, ut, Suppress,bankruptcyv3_services;

it := input.it;
gm := input.gm;
inner_params := input.params;
inner_id_search(
  input.params in_mod,
  DATASET(doxie.layout_references) in_dids,
  DATASET(doxie_cbrs.layout_references) in_bdids,
  DATASET(bankruptcyv2_services.layout_tmsid_ext) in_tmsids0,
  DATASET(BIPV2.IDlayouts.l_xlink_ids) in_bids,
  STRING1 bid_fetch_level = BIPV2.IDconstants.Fetch_Level_SELEID,
  UNSIGNED in_limit,
  STRING6 in_ssn_mask,
  BOOLEAN in_isSearch = FALSE,
  BOOLEAN in_all_bks_for_all_debtors = FALSE,
  STRING1 in_party_type = '',
  STRING2 in_filing_jurisdiction = '',
  BOOLEAN isFCRA = FALSE,
  BOOLEAN includeCriminalIndicators = FALSE,
  BOOLEAN in_include_AttorneyTrustee = FALSE
  ) := FUNCTION
  doxie.MAC_Header_Field_Declare(isFCRA)
  //Initial lookup
  in_tmsids1 := bankruptcy_ids(in_dids,in_bdids,in_tmsids0,in_bids,bid_fetch_level,in_limit,in_party_type,isFCRA,in_mod);
  
  temp_records_search0 :=
    JOIN(
      in_tmsids1,
      bankruptcyv3.key_bankruptcyV3_search_full_bip(isFCRA),
      KEYED(LEFT.tmsid = RIGHT.tmsid),
      TRANSFORM(
        RECORDOF(bankruptcyv3.key_bankruptcyV3_search_full_bip()),
        SELF := RIGHT,
        SELF := LEFT),
    KEEP(1000));
  temp_debtor_dids := PROJECT(DEDUP(SORT(temp_records_search0((UNSIGNED)did != 0 AND name_type[1] = 'D'),did),did),TRANSFORM(doxie.layout_references,SELF.did := (UNSIGNED)LEFT.did));
  temp_debtor_bdids := PROJECT(DEDUP(SORT(temp_records_search0((UNSIGNED)bdid != 0 AND name_type[1] = 'D'),bdid),bdid),TRANSFORM(doxie_cbrs.layout_references,SELF.bdid := (UNSIGNED)LEFT.bdid));
      
  //Additional lookup
  empty_bids := DATASET([],BIPV2.IDLayouts.l_xlink_ids);
  temp_addl_tmsids := bankruptcyv2_services.bankruptcy_ids(temp_debtor_dids,temp_debtor_bdids,in_tmsids0(FALSE),empty_bids,,IF(in_limit = 0,0,in_limit - COUNT(in_tmsids1)),in_party_type, isFCRA,in_mod);
  
  in_tmsids := in_tmsids1 + IF(in_all_bks_for_all_debtors AND (in_limit = 0 OR COUNT(in_tmsids1) < in_limit),temp_addl_tmsids);
                             
  temp_records_search1 :=
    JOIN(
      temp_addl_tmsids,
      bankruptcyv3.key_bankruptcyV3_search_full_bip(isFCRA),
      KEYED(LEFT.tmsid = RIGHT.tmsid),
      TRANSFORM(
        RECORDOF(bankruptcyv3.key_bankruptcyV3_search_full_bip()),
        SELF := RIGHT,
        SELF := LEFT),
      KEEP(1000));
  temp_records_search := temp_records_search0 + IF(in_all_bks_for_all_debtors AND (in_limit = 0 OR COUNT(in_tmsids1) < in_limit),temp_records_search1);

  // Pull any debtor records that are in the pull file
  temp_records_searchD := IF (isFCRA, temp_records_search(name_type[1]='D'), bankruptcyv2_services.fn_pullIDs(temp_records_search(name_type[1]='D'),FALSE,application_type_value));
  // Now, join back against our TMSIDs... and leave only those TMSIDs that have NO suppressed debtors.
  in_tmsids_less_pulled_by_debtor := JOIN(in_tmsids, DEDUP(SORT(temp_records_searchD,tmsid),tmsid),
    LEFT.tmsid = RIGHT.tmsid,
    TRANSFORM(LEFT));
      
  // Pull any attorney records that are in the pull file
  temp_records_searchA := IF (isFCRA, temp_records_search(name_type[1]='A'), bankruptcyv2_services.fn_pullIDs(temp_records_search(name_type[1]='A'),TRUE,application_type_value)); // TRUE here means to pull ONLY the attorney being suppressed, NOT ALL attorneys
  // Pull any other records that are in the pull file
  temp_records_searchOthers := IF (isFCRA, temp_records_search(name_type[1] <> 'A' AND name_type[1] <> 'D'),
          fn_pullIds(temp_records_search(name_type[1]<>'A' AND name_type[1] <>'D'),TRUE,application_type_value)); // this may be the empty SET ALL the time??
  // Add together all records NOT pulled (including debtors)
  temp_records := SORT(temp_records_searchD + temp_records_searchA + temp_records_searchOthers, tmsid);
  
  
  // pull IDs using the party info, then join those IDs back against the input set of tmsids
  
  //Trustee information with Bkv2 used to be available in the search key; however, in the Bkv3 it is available in the main key.
  //Below we are making sure to assign Criminal Indicators and timezone if trustee information are requested
  //we are also doing the trustee suppression similar to Bkv3
  //In addition, some fields used to be available in Bkv2 main key but are now available in the Bkv2 search key so we are also adding these now.
  temp_rec_main := RECORD
    RECORDOF(bankruptcyV3.key_bankruptcyV3_main_full());
    STRING4 timezone :='';
    BOOLEAN HasCriminalConviction := FALSE;
    BOOLEAN IsSexualOffender := FALSE;
    BOOLEAN isDeepDive;
    STRING12 UniqueId;
    BOOLEAN SuppressT;
  END;
      
  temp_rec_mainT := RECORD
    RECORDOF(bankruptcyv3.key_bankruptcyv3_main_full());
    BOOLEAN isDeepDive;
    BOOLEAN SuppressT;
  END;

  temp_records_main := // need to account for suppressing attorney names IN here.
    JOIN(
      in_tmsids_less_pulled_by_debtor,
      bankruptcyv3.key_bankruptcyV3_main_full(isFCRA),
      KEYED(LEFT.tmsid = RIGHT.tmsid),
      TRANSFORM(temp_rec_mainT,
        SELF := RIGHT,
        SELF := LEFT,
        SELF.suppressT := FALSE),
      KEEP(1000));
      
  temp_records_mainT := IF(isFCRA, temp_records_main, bankruptcyv3_services.fn_pullTrusteeIDs(temp_records_main,application_type_value));
  temp_records_main_final := PROJECT(temp_records_mainT,
    TRANSFORM(temp_rec_main,
      SELF.UniqueId := LEFT.did,
      SELF := LEFT));
  
  // filter by jurisdiction if provided
  temp_records_main_jur0 := IF(in_filing_jurisdiction <> '',
                              temp_records_main_final(filing_jurisdiction = in_filing_jurisdiction),
                              temp_records_main_final);
      
  suppressT := in_isSearch AND ~in_include_AttorneyTrustee;
  Suppress.MAC_Mask(temp_records_main_jur0, trustees_masked, app_SSN, null, TRUE, FALSE, maskVal:=in_ssn_mask);
  ut.getTimeZone(trustees_masked,trusteePhone,timezone,temp_records_main_jur_w_tzone);
  CriminalRecords_Services.MAC_Indicators(temp_records_main_jur_w_tzone,temp_records_main_jur_w_crim_indic);
  temp_records_main_jur := IF(suppressT, temp_records_main_jur0, IF(includeCriminalIndicators, temp_records_main_jur_w_crim_indic, temp_records_main_jur_w_tzone));

  BankruptcyV2_Services.layouts.layout_party_slim to_trustee(temp_rec_main L) := TRANSFORM
    SELF.names := PROJECT(L, TRANSFORM(BankruptcyV2_Services.layouts.layout_name,
      SELF.orig_name := LEFT.trusteeName,
      SELF.ssn := LEFT.app_ssn, //there are no ssn field
      SELF := LEFT,
      SELF := [])); //no app_tax_id AND tax_id fields
    SELF.addresses := PROJECT(L, TRANSFORM(BankruptcyV2_Services.layouts.layout_address,
      SELF.orig_addr1 := LEFT.trusteeAddress,
      SELF.orig_city := LEFT.trusteeCity,
      SELF.orig_st := LEFT.trusteeState,
      SELF.orig_zip5 := LEFT.trusteeZip,
      SELF.orig_zip4 := LEFT.trusteeZip4,
      SELF := LEFT,
      SELF := [])); //orig_addr2, orig_county
    SELF.phones := PROJECT(L, TRANSFORM(BankruptcyV2_Services.layouts.layout_phone,
      SELF.phone := LEFT.trusteePhone,
      SELF.timezone := LEFT.timezone,
      SELF.orig_fax := '')); //no fax field
    SELF.emails := PROJECT(L, TRANSFORM(BankruptcyV2_Services.layouts.layout_email,
      SELF.orig_email := LEFT.trusteeEmail));
    SELF := L;
    SELF.ssn := L.app_ssn;
    SELF := []; //no app_tax_id, tax_id AND BDID AND BIP fields
  END;
      
  temp_top_slim :=
    JOIN(
      temp_records_main_jur,
      temp_records_search,
      LEFT.tmsid = RIGHT.tmsid,
      TRANSFORM(
        bankruptcyv2_services.layouts.layout_rollup,
        SELF.filer_type_ex := codes.BANKRUPTCIES.FILER_TYPE(LEFT.filer_type),
        SELF.trustees := IF(~suppressT AND ~LEFT.suppressT, PROJECT(LEFT, to_trustee(LEFT)));
        //fields that were in BKv2 main but now are in BKv3 search
        SELF.orig_filing_type_ex := codes.BANKRUPTCIES.FILING_TYPE(RIGHT.filing_type),
        SELF.orig_filing_type := RIGHT.filing_type,
        SELF.chapter := RIGHT.chapter,
        SELF.pro_se_ind := RIGHT.pro_se_ind,
        SELF.disposed_date := RIGHT.discharged,
        SELF.disposition := RIGHT.disposition,
        SELF.corp_flag := RIGHT.corp_flag,
        SELF.converted_date := RIGHT.converted_date,
        SELF := LEFT,
        SELF := []),
      LIMIT(0), KEEP(1)); //might have more than one match, but we only need to KEEP one of them
  temp_top_dedup :=
    DEDUP(SORT(temp_top_slim,tmsid,RECORD),tmsid);
  // penalty
  temp_pen_slim :=
    PROJECT(temp_records,
      TRANSFORM(bankruptcyv2_services.layouts.layout_rollup,
        SELF.penalt := fn_penalty(LEFT);
        SELF.matched_party.parsed_party := IF(DisplayMatchedParty_value,LEFT);
        SELF.matched_party.address := IF(DisplayMatchedParty_value,LEFT);
        SELF := LEFT;
        SELF := [];
    ));

  temp_pen_dedup :=
    DEDUP(SORT(temp_pen_slim,tmsid,penalt,RECORD),tmsid);
  temp_top_join :=
    JOIN(
      temp_top_dedup,
      temp_pen_dedup,
      LEFT.tmsid = RIGHT.tmsid,
      TRANSFORM(
        RECORDOF(temp_pen_dedup),
        SELF.penalt := RIGHT.penalt,
        dmp := NOT LEFT.isdeepdive;
        SELF.matched_party.party_type := IF(dmp, RIGHT.matched_party.party_type,''),
        SELF.matched_party.parsed_party := IF(dmp, RIGHT.matched_party.parsed_party),
        SELF.matched_party.address := IF(dmp, RIGHT.matched_party.address);
        SELF := LEFT
        ),
      LEFT OUTER);
  temp_top_add_debtors := JOIN(
    temp_top_join,
    bankruptcyv2_services.fn_rollup_debtors(temp_records_searchD,in_ssn_mask,includeCriminalIndicators),
    LEFT.tmsid = RIGHT.tmsid,
    TRANSFORM(
      RECORDOF(temp_top_dedup),
      SELF.debtors := RIGHT.parties,
      SELF := LEFT),
    LEFT OUTER);
  temp_top_add_attorneys :=
    IF(in_isSearch AND ~in_include_AttorneyTrustee,
      temp_top_add_debtors,
      JOIN(
        temp_top_add_debtors,
        bankruptcyv2_services.fn_rollup_parties(temp_records_searchA,in_ssn_mask,includeCriminalIndicators),
        LEFT.tmsid = RIGHT.tmsid,
        TRANSFORM(
          RECORDOF(temp_top_dedup),
          SELF.attorneys := PROJECT(RIGHT.parties, BankruptcyV2_Services.layouts.layout_party_slim);
          SELF := LEFT),
        LEFT OUTER));
            
  temp_records_main_full := PROJECT(temp_records_main_jur,
    RECORDOF(bankruptcyv3.key_bankruptcyV3_main_full()));
            
  temp_top_add_status :=
    IF(in_isSearch,
      temp_top_add_attorneys,
      JOIN(
        temp_top_add_attorneys,
        bankruptcyv2_services.fn_rollup_statuses(temp_records_main_full),
        LEFT.tmsid = RIGHT.tmsid,
        TRANSFORM(
          RECORDOF(temp_top_dedup),
          SELF.status_history := RIGHT.statuses,
          SELF := LEFT),
        LEFT OUTER));
  temp_top_add_comments :=
    IF(in_isSearch,
      temp_top_add_status,
      JOIN(
        temp_top_add_status,
        bankruptcyv2_services.fn_rollup_comments(temp_records_main_full),
        LEFT.tmsid = RIGHT.tmsid,
        TRANSFORM(
          RECORDOF(temp_top_dedup),
          SELF.comment_history := RIGHT.comments,
          SELF := LEFT),
        LEFT OUTER));
            
  // output(in_tmsids1, named('in_tmsids1_v2'));
  // output(temp_records_search0, named('temp_records_search0_v2'));
  // output(temp_records_search, named('temp_records_searchv2'));
  // output(tmsids_pulled, named('tmsids_pulledv2'));
  // output(in_tmsids_pulled , named('in_tmsids_pulled'));
  // output(temp_records_main_jur, named('temp_records_main_jur_v2'));
  // output(temp_top_add_status, named('temp_top_add_status'));
  // output(temp_top_add_comments,named('temp_top_add_comments_v2'));
  RETURN SORT(temp_top_add_comments,-orig_filing_date,-date_filed,RECORD);
END;


EXPORT fn_rollup(
  DATASET(doxie.layout_references) in_dids,
  DATASET(doxie_cbrs.layout_references) in_bdids,
  DATASET(bankruptcyv2_services.layout_tmsid_ext) in_tmsids0,
  DATASET(BIPV2.IDlayouts.l_xlink_ids) in_bids,
  STRING1 bid_fetch_level = BIPV2.IDconstants.Fetch_Level_SELEID,
  UNSIGNED in_limit,
  STRING6 in_ssn_mask,
  BOOLEAN in_isSearch = FALSE,
  BOOLEAN in_all_bks_for_all_debtors = FALSE,
  STRING1 in_party_type = '',
  STRING2 in_filing_jurisdiction = '',
  BOOLEAN isFCRA = FALSE,
  STRING32 ApplicationType = '',
  BOOLEAN includeCriminalIndicators = FALSE,
  BOOLEAN in_include_AttorneyTrustee = FALSE,
  BOOLEAN skip_ids_search = FALSE
  ) := FUNCTION
  
  temp_mod_one := MODULE(PROJECT(gm,inner_params,OPT))
    EXPORT skip_ids_search := ^.skip_ids_search;
  END;
  temp_mod_two := MODULE(PROJECT(gm,inner_params,OPT))
    //export nofail := true;
    EXPORT firstname := gm.entity2_firstname;
    EXPORT middlename := gm.entity2_middlename;
    EXPORT lastname := gm.entity2_lastname;
    EXPORT unparsedfullname := gm.entity2_unparsedfullname;
    EXPORT allownicknames := gm.entity2_allownicknames;
    EXPORT phoneticmatch := gm.entity2_phoneticmatch;
    EXPORT companyname := gm.entity2_companyname;
    EXPORT addr := gm.entity2_addr;
    EXPORT city := gm.entity2_city;
    EXPORT state := gm.entity2_state;
    EXPORT zip := gm.entity2_zip;
    EXPORT zipradius := gm.entity2_zipradius;
    EXPORT phone := gm.entity2_phone;
    EXPORT fein := gm.entity2_fein;
    EXPORT bdid := gm.entity2_bdid;
    EXPORT did := gm.entity2_did;
    EXPORT ssn := gm.entity2_ssn;
    EXPORT skip_ids_search := ^.skip_ids_search;
  END;
  
  party_one_results := inner_id_search(temp_mod_one, in_dids, in_bdids, in_tmsids0, in_bids, bid_fetch_level, in_limit, in_ssn_mask, in_isSearch, in_all_bks_for_all_debtors,in_party_type, in_filing_jurisdiction,isFCRA,includeCriminalIndicators,in_include_AttorneyTrustee);
  party_two_results := inner_id_search(temp_mod_two, in_dids, in_bdids, in_tmsids0, in_bids, bid_fetch_level, in_limit, in_ssn_mask, in_isSearch, in_all_bks_for_all_debtors,in_party_type, in_filing_jurisdiction,isFCRA,includeCriminalIndicators,in_include_AttorneyTrustee);
  //Debug
  //output(party_one_results,named('P1'));
  //output(party_two_results,named('P2'));
  two_party_search_results := 
    JOIN(party_one_results, party_two_results,
    LEFT.tmsid= RIGHT.tmsid,
    TRANSFORM(LEFT),
    KEEP(1),
    LIMIT(0));

  selected_results := IF(gm.TwoPartySearch,
  two_party_search_results,
  party_one_results);
  //output(selected_results,named('selected_results'));

  RETURN selected_results;
        
END;
