IMPORT AutoStandardI;
IMPORT bankruptcyv3, codes, doxie, bankruptcyv2_services, ut, Suppress;
EXPORT fn_boolean_rollup(
  DATASET(bankruptcyv2_services.layout_tmsid_ext) in_tmsids0,
  UNSIGNED in_limit,
  STRING6 in_ssn_mask,
  BOOLEAN in_isSearch = FALSE,
  STRING1 in_party_type = '',
  BOOLEAN isFCRA = FALSE,
  STRING32 appType
  ) := FUNCTION
  in_tmsids := in_tmsids0;
  temp_records_search :=
    JOIN(
      in_tmsids,
      BankruptcyV3.key_bankruptcyV3_search_full_bip(isFCRA),
      KEYED(LEFT.tmsid = RIGHT.tmsid),
      TRANSFORM(
        RECORDOF(BankruptcyV3.key_bankruptcyV3_search_full_bip()),
        SELF := RIGHT,
        SELF := LEFT),
      KEEP(1000));
  // Pull any debtor records that are in the pull file
  temp_records_searchD := IF (isFCRA, temp_records_search(name_type[1]='D'), bankruptcyv2_services.fn_pullIDs(temp_records_search(name_type[1]='D'),FALSE,appType));
  // Now, join back against our TMSIDs... and leave only those TMSIDs that have NO suppressed debtors.
  in_tmsids_less_pulled_by_debtor := JOIN(in_tmsids, DEDUP(SORT(temp_records_searchD,tmsid),tmsid),
    LEFT.tmsid = RIGHT.tmsid,
    TRANSFORM(LEFT));
  
  // Pull any attorney records that are in the pull file
  temp_records_searchA := IF (isFCRA, temp_records_search(name_type[1]='A'), bankruptcyv2_services.fn_pullIDs(temp_records_search(name_type[1]='A'),TRUE,appType)); // TRUE here means to pull ONLY the attorney being suppressed, NOT ALL attorneys
  temp_records_searchT := IF (isFCRA, temp_records_search(name_type[1]='T'), bankruptcyv2_services.fn_pullIDs(temp_records_search(name_type[1]='T'), TRUE,appType)); // TRUE here mean to pull only the trustee being suppressed, NOT ALL trustees
  // Pull any other records that are in the pull file
  temp_records_searchOthers := IF (isFCRA, temp_records_search(name_type[1]<>'A' AND name_type[1]<>'D' AND name_type[1]<>'T'),
                  bankruptcyv2_services.fn_pullIds(temp_records_search(name_type[1]<>'A' AND name_type[1]<>'D' AND name_type[1]<>'T'),TRUE,appType)); // this may be the empty SET ALL the time??
  // Add together all records NOT pulled (including debtors)
  temp_records := SORT(temp_records_searchD + temp_records_searchA + temp_records_searchT + temp_records_searchOthers, tmsid);
  
  //Trustee information with Bkv2 used to be available in the search key; however, in the Bkv3 it is available in the main key.
  //Below we are making sure to assign timezone if trustee information are requested
  //In addition, some fields used to be available in Bkv2 main key but are now available in the Bkv2 search key so we are also adding these now.
  temp_rec_main := RECORD
    RECORDOF(bankruptcyV3.key_bankruptcyV3_main_full());
    STRING4 timezone :='';
    BOOLEAN isDeepDive;
  END;
  
  temp_records_main0 :=
    JOIN(
      in_tmsids_less_pulled_by_debtor,
      bankruptcyv3.key_bankruptcyV3_main_full(isFCRA),
      KEYED(LEFT.tmsid = RIGHT.tmsid),
      TRANSFORM(
        temp_rec_main,
        SELF := RIGHT,
        SELF := LEFT),
      KEEP(1000));
      
  Suppress.MAC_Mask(temp_records_main0, trustees_masked, app_SSN, null, TRUE, FALSE, maskVal:=in_ssn_mask);
  ut.getTimeZone(trustees_masked,trusteePhone,timezone,temp_records_main_w_tzone);
  temp_records_main := IF(in_isSearch, temp_records_main0, temp_records_main_w_tzone);
  
  BankruptcyV2_Services.layouts.layout_party_slim to_trustee(temp_rec_main L) := TRANSFORM
    SELF.names := PROJECT(L, TRANSFORM(BankruptcyV2_Services.layouts.layout_name,
      SELF.orig_name := LEFT.trusteeName,
      SELF.ssn := LEFT.app_ssn, //there is no ssn field
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
    SELF.ssn := L.app_SSN;
    SELF := []; //no app_tax_id, tax_id AND BDID AND BIP fields
  END;
  
  temp_top_slim :=
    JOIN(
      temp_records_main,
      temp_records_search,
      LEFT.tmsid = RIGHT.tmsid,
      TRANSFORM(
        bankruptcyv2_services.layouts.layout_rollup,
        SELF.filer_type_ex := codes.BANKRUPTCIES.FILER_TYPE(LEFT.filer_type),
        SELF.trustees := IF(~in_isSearch, PROJECT(LEFT, to_trustee(LEFT)));
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
      LIMIT(0), KEEP(1));
  temp_top_dedup :=
    DEDUP(
      SORT(
        temp_top_slim,
        tmsid,RECORD),
      tmsid);
  temp_pen_slim :=
    PROJECT(
      temp_records_search,
      TRANSFORM(
        bankruptcyv2_services.layouts.layout_rollup,
        tempmod := MODULE(PROJECT(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.LIBIN.PenaltyI_Indv.full,OPT))
          EXPORT BOOLEAN allow_wildcard := FALSE;
          EXPORT STRING city_field := LEFT.v_city_name;
          EXPORT STRING city2_field := '';
          EXPORT STRING county_field := '';
          EXPORT STRING did_field := LEFT.did;
          EXPORT STRING dob_field := '';
          EXPORT STRING fname_field := LEFT.fname;
          EXPORT STRING lname_field := LEFT.lname;
          EXPORT STRING mname_field := LEFT.mname;
          EXPORT STRING phone_field := LEFT.phone;
          EXPORT STRING pname_field := LEFT.prim_name;
          EXPORT STRING postdir_field := LEFT.postdir;
          EXPORT STRING prange_field := LEFT.prim_range;
          EXPORT STRING predir_field := LEFT.predir;
          EXPORT STRING ssn_field := LEFT.ssn;
          EXPORT STRING state_field := LEFT.st;
          EXPORT STRING suffix_field := LEFT.addr_suffix;
          EXPORT STRING zip_field := LEFT.zip;
        END;
        SELF.penalt := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempmod),
        SELF := LEFT,
        SELF := []));
  temp_pen_dedup :=
    DEDUP(
      SORT(
        temp_pen_slim,
        tmsid,penalt,RECORD),
      tmsid);
  temp_top_join :=
    JOIN(
      temp_top_dedup,
      temp_pen_dedup,
      LEFT.tmsid = RIGHT.tmsid,
      TRANSFORM(
        RECORDOF(temp_pen_dedup),
        SELF.penalt := RIGHT.penalt,
        SELF := LEFT),
      LEFT OUTER);
  temp_top_add_debtors := JOIN(
    temp_top_join,
    bankruptcyv2_services.fn_rollup_debtors(temp_records_searchD,in_ssn_mask),
    LEFT.tmsid = RIGHT.tmsid,
    TRANSFORM(
      RECORDOF(temp_top_dedup),
      SELF.debtors := RIGHT.parties,
      SELF := LEFT),
    LEFT OUTER);
  temp_top_add_attorneys :=
    IF(in_isSearch,
      temp_top_add_debtors,
      JOIN(
        temp_top_add_debtors,
        bankruptcyv2_services.fn_rollup_parties(temp_records_searchA,in_ssn_mask),
        LEFT.tmsid = RIGHT.tmsid,
        TRANSFORM(
          RECORDOF(temp_top_dedup),
          SELF.attorneys := PROJECT(RIGHT.parties, BankruptcyV2_Services.layouts.layout_party_slim),
          SELF := LEFT),
        LEFT OUTER));
  temp_top_add_status :=
    IF(in_isSearch,
      temp_top_add_attorneys,
      JOIN(
        temp_top_add_attorneys,
        bankruptcyv2_services.fn_rollup_statuses(
          PROJECT(
            temp_records_main,
            RECORDOF(bankruptcyv3.key_bankruptcyV3_main_full()))),
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
        bankruptcyv2_services.fn_rollup_comments(
          PROJECT(
            temp_records_main,
            RECORDOF(bankruptcyv3.key_bankruptcyV3_main_full()))),
        LEFT.tmsid = RIGHT.tmsid,
        TRANSFORM(
          RECORDOF(temp_top_dedup),
          SELF.comment_history := RIGHT.comments,
          SELF := LEFT),
        LEFT OUTER));
  RETURN temp_top_add_comments;
END;
    
