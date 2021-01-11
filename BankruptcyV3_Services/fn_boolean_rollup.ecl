IMPORT AutoStandardI;
IMPORT BankruptcyV3_Services, bankruptcyv3, codes;

EXPORT fn_boolean_rollup(
  DATASET(bankruptcyv3_services.layouts.layout_tmsid_ext) in_tmsids0,
  UNSIGNED in_limit,
  STRING6 in_ssn_mask,
  BOOLEAN in_isSearch = FALSE,
  STRING1 in_party_type = '',
  BOOLEAN isFCRA = FALSE,
  STRING32 appType
  ) :=
    FUNCTION
      in_tmsids := in_tmsids0;
      temp_records_search :=
        JOIN(
          in_tmsids,
          bankruptcyV3.key_bankruptcyV3_search_full_bip(isFCRA),
          KEYED(LEFT.tmsid = RIGHT.tmsid),
          TRANSFORM(
            BankruptcyV3_Services.Layout_key_bankruptcyV3_search_full_bip_plus_case_numbers,
            SELF.full_case_number := '',
            SELF := RIGHT,
            SELF := LEFT),
          LIMIT(0),
          KEEP(BankruptcyV3_Services.consts.KEEP_LIMIT));
          
      // Pull any debtor records that are in the pull file
      temp_records_searchD := IF (isFCRA, temp_records_search(name_type[1]=BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR), fn_pullIDs(temp_records_search(name_type[1]=BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR),FALSE,apptype));
      // Now, join back against our TMSIDs... and leave only those TMSIDs that have NO suppressed debtors.
      in_tmsids_less_pulled_by_debtor := JOIN(in_tmsids, DEDUP(SORT(temp_records_searchD,tmsid),tmsid),
        LEFT.tmsid = RIGHT.tmsid,
        TRANSFORM(LEFT));
      
      // Pull any attorney records that are in the pull file
      temp_records_searchA := IF (isFCRA, temp_records_search(name_type[1]=BankruptcyV3_Services.consts.NAME_TYPES.ATTORNEY), fn_pullIDs(temp_records_search(name_type[1]=BankruptcyV3_Services.consts.NAME_TYPES.ATTORNEY),TRUE,apptype)); // TRUE here means to pull ONLY the attorney being suppressed, NOT ALL attorneys
      // Pull any other records that are in the pull file
      temp_records_searchOthers := IF (isFCRA, temp_records_search(name_type[1]<>BankruptcyV3_Services.consts.NAME_TYPES.ATTORNEY AND name_type[1] <> BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR),
                                               fn_pullIds(temp_records_search(name_type[1]<>BankruptcyV3_Services.consts.NAME_TYPES.ATTORNEY AND name_type[1]<>BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR),TRUE,apptype)); // this may be the empty SET ALL the time??
      // Add together all records NOT pulled (including debtors)
      temp_records := SORT(temp_records_searchD + temp_records_searchA + temp_records_searchOthers, tmsid);
          

      temp_records_main :=
        JOIN(
          in_tmsids_less_pulled_by_debtor,
          bankruptcyV3.key_bankruptcyV3_main_full(isFCRA),
          KEYED(LEFT.tmsid = RIGHT.tmsid),
          TRANSFORM(
            {RECORDOF(bankruptcyV3.key_bankruptcyV3_main_full()),BOOLEAN isDeepDive, BOOLEAN suppressT},
            SELF.SuppressT := FALSE;
            SELF := RIGHT,
            SELF := LEFT),
          LIMIT(0),
          KEEP(BankruptcyV3_Services.consts.KEEP_LIMIT));
          
      temp_records_main_final := IF (isFCRA, temp_records_main, bankruptcyv3_services.fn_pullTrusteeIds(temp_records_main,appType)); // NO FCRA??
      
      temp_top_slim :=
        PROJECT(
          temp_records_main_final,
          TRANSFORM(
            bankruptcyv3_services.layouts.layout_rollup,
            SELF.filer_type_ex := codes.BANKRUPTCIES.FILER_TYPE(LEFT.filer_type),
            SELF.trustee.DID := IF (LEFT.suppressT, '', LEFT.DID);
            SELF.trustee.trusteeID := LEFT.trusteeID;
            SELF.trustee.app_SSN := IF (LEFT.suppressT, '', LEFT.app_SSN);
            SELF.trustee.orig_name := IF (LEFT.suppressT, '', LEFT.trusteeName);
            SELF.trustee.orig_address := IF (LEFT.suppressT, '', LEFT.trusteeAddress);
            SELF.trustee.orig_city := IF (LEFT.suppressT, '', LEFT.trusteeCity);
            SELF.trustee.orig_st := IF (LEFT.suppressT, '', LEFT.trusteeState);
            SELF.trustee.orig_zip := IF (LEFT.suppressT, '', LEFT.trusteeZip);
            SELF.trustee.orig_zip4 := IF (LEFT.suppressT, '', LEFT.trusteeZip4);
            SELF.trustee.phone := IF (LEFT.suppressT, '', LEFT.trusteePhone);
            SELF.trustee := IF (~LEFT.suppressT, LEFT); // pick up ALL cleaned name/address fields
            SELF := LEFT,
            SELF := []));
      temp_top_dedup :=
        DEDUP(
          SORT(
            temp_top_slim,
            tmsid,RECORD),
          tmsid);
      temp_pen_slim :=
        PROJECT(
          temp_records,
          TRANSFORM(
            bankruptcyv3_services.layouts.layout_rollup,
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
        bankruptcyv3_services.fn_rollup_debtors(temp_records_searchD,in_ssn_mask),
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
            bankruptcyv3_services.fn_rollup_parties(temp_records_searchA,in_ssn_mask),
            LEFT.tmsid = RIGHT.tmsid,
            TRANSFORM(
              RECORDOF(temp_top_dedup),
              SELF.attorneys := PROJECT(RIGHT.parties, layouts.layout_party_slim),
              SELF := LEFT),
            LEFT OUTER));
      temp_top_add_status :=
        IF(in_isSearch,
          temp_top_add_attorneys,
          JOIN(
            temp_top_add_attorneys,
            bankruptcyv3_services.fn_rollup_statuses(
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
            bankruptcyv3_services.fn_rollup_comments(
              PROJECT(
                temp_records_main,
                RECORDOF(bankruptcyv3.key_bankruptcyV3_main_full()))),
            LEFT.tmsid = RIGHT.tmsid,
            TRANSFORM(
              RECORDOF(temp_top_dedup),
              SELF.comment_history := RIGHT.comments,
              SELF := LEFT),
            LEFT OUTER));
      RETURN
        temp_top_add_comments;
    END;
    
