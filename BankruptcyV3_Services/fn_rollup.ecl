IMPORT AutoStandardI, bankruptcyv3, bankruptcyv3_services, codes,
       data_services, doxie, doxie_cbrs, dx_banko, suppress;

EXPORT fn_rollup(
  DATASET(doxie.layout_references) in_dids,
  DATASET(doxie_cbrs.layout_references) in_bdids,
  DATASET(bankruptcyv3_services.layouts.layout_tmsid_ext) in_tmsids0,
  UNSIGNED in_limit,
  STRING6 in_ssn_mask,
  BOOLEAN in_isSearch = FALSE,
  BOOLEAN in_all_bks_for_all_debtors = FALSE,
  STRING1 in_party_type = '',
  STRING2 in_filing_jurisdiction = '',
  BOOLEAN isFCRA = FALSE,
  STRING4 in_SSNLast4 = '',
  BOOLEAN include_dockets = FALSE,
  STRING8 lower_entered_date = '',
  STRING8 upper_entered_date = '',
  STRING32 appType,
  BOOLEAN isCaseNumberSearch = FALSE,
  BOOLEAN isAttorneySearch = FALSE
  ) :=
    FUNCTION
      doxie.MAC_Header_Field_Declare(isFCRA)

      //special search case for partial SSNs otherwise go standard method of finding DIDs.
                                              //force FCRA only when using SSNLast4 until it is needed and KEY is built.
       in_tmsids1 := IF (in_SSNLast4 <> '' AND isFCRA,
                          bankruptcy_ids_ssn4(in_limit,in_SSNLast4, in_filing_jurisdiction,in_party_type,lname_value,fname_value,isFCRA),
                            bankruptcy_ids(in_dids,in_bdids,in_tmsids0,in_limit,in_party_type, isFCRA,isCaseNumberSearch,isAttorneySearch)
                          );

      temp_records_search0 :=
        JOIN(
          in_tmsids1,
          bankruptcyv3.key_bankruptcyv3_search_full_bip(isFCRA),
          KEYED(LEFT.tmsid = RIGHT.tmsid),
          TRANSFORM(BankruptcyV3_Services.Layout_key_bankruptcyv3_search_full_bip_plus_case_numbers,
            SELF.full_case_number := '',
            SELF := RIGHT,
            SELF := LEFT),
          LIMIT(0),
          KEEP(BankruptcyV3_Services.consts.KEEP_LIMIT));

      temp_debtor_dids := PROJECT(DEDUP(SORT(temp_records_search0((UNSIGNED)did != 0 AND name_type[1] = BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR),did),did),TRANSFORM(doxie.layout_references,SELF.did := (UNSIGNED)LEFT.did));
      temp_debtor_bdids := PROJECT(DEDUP(SORT(temp_records_search0((UNSIGNED)bdid != 0 AND name_type[1] = BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR),bdid),bdid),TRANSFORM(doxie_cbrs.layout_references,SELF.bdid := (UNSIGNED)LEFT.bdid));
      temp_addl_tmsids := bankruptcyv3_services.bankruptcy_ids(temp_debtor_dids,temp_debtor_bdids,in_tmsids0(FALSE),IF(in_limit = 0,0,in_limit - COUNT(in_tmsids1)),in_party_type, isFCRA,isCaseNumberSearch,isAttorneySearch);
      in_tmsids := in_tmsids1 + IF(in_all_bks_for_all_debtors AND (in_limit = 0 OR COUNT(in_tmsids1) < in_limit),temp_addl_tmsids);

      temp_records_search1 :=
        JOIN(
          temp_addl_tmsids,
          bankruptcyv3.key_bankruptcyv3_search_full_bip(isFCRA),
          KEYED(LEFT.tmsid = RIGHT.tmsid),
          TRANSFORM(bankruptcyv3_services.Layout_key_bankruptcyv3_search_full_bip_plus_case_numbers,
            SELF.full_case_number := '',
            SELF := RIGHT,
            SELF := LEFT),
          LIMIT(0),
          KEEP(BankruptcyV3_Services.consts.KEEP_LIMIT));

      temp_records_search := temp_records_search0 + IF(in_all_bks_for_all_debtors AND (in_limit = 0 OR COUNT(in_tmsids1) < in_limit),temp_records_search1);
      // Pull any debtor records that are in the pull file
      temp_records_searchD := IF (isFCRA, temp_records_search(name_type[1]=BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR), BankruptcyV3_Services.fn_pullIDs(temp_records_search(name_type[1]=BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR),FALSE,appType));
      // Now, join back against our TMSIDs... and leave only those TMSIDs that have NO suppressed debtors.
      in_tmsids_less_pulled_by_debtor := JOIN(in_tmsids, DEDUP(SORT(temp_records_searchD,tmsid),tmsid),
        LEFT.tmsid = RIGHT.tmsid,
        TRANSFORM(LEFT));

      // Pull any attorney records that are in the pull file
      temp_records_searchA := IF (isFCRA, temp_records_search(name_type[1]='A'), BankruptcyV3_Services.fn_pullIDs(temp_records_search(name_type[1]='A'),TRUE,appType)); // TRUE here means to pull ONLY the attorney being suppressed, NOT ALL attorneys
      // Pull any other records that are in the pull file
      temp_records_searchOthers := IF (isFCRA, temp_records_search(name_type[1]<>'A' AND name_type[1]<>BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR),
                                       BankruptcyV3_Services.fn_pullIds(temp_records_search(name_type[1]<>'A' AND name_type[1]<>BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR),TRUE,appType)); // this may be the empty SET ALL the time??
      // Add together all records NOT pulled (including debtors)
      temp_records := SORT(temp_records_searchD + temp_records_searchA + temp_records_searchOthers, tmsid);

      //
      // need to add to temp_records_search the TMSID of the trustee record
      //
      //
      // pull IDs using the party info, then join those IDs back against the input set of tmsids

      temp_records_main :=
        JOIN(
          in_tmsids_less_pulled_by_debtor,
          bankruptcyv3.key_bankruptcyv3_main_full(isFCRA),
          KEYED(LEFT.tmsid = RIGHT.tmsid),
          TRANSFORM(
            {RECORDOF(bankruptcyv3.key_bankruptcyv3_main_full()),BOOLEAN isDeepDive, BOOLEAN suppressT},
            SELF.suppressT := FALSE;
            SELF := RIGHT,
            SELF := LEFT),
          LIMIT(0),
          KEEP(BankruptcyV3_Services.consts.KEEP_LIMIT));

      temp_records_main_final := IF(isFCRA, temp_records_main, bankruptcyv3_services.fn_pullTrusteeIDs(temp_records_main,appType));

      // filter by jurisdiction if provided
      temp_records_main_jur := IF(in_filing_jurisdiction <> '',
                                  temp_records_main_final(filing_jurisdiction = in_filing_jurisdiction),
                                  temp_records_main_final);

      // call suppress macro to suppress the trustee app_ssn field based on app_ssn setting.
      Suppress.MAC_Mask(temp_records_main_jur, temp_records_main_jur_suppressed, app_ssn, null, TRUE, FALSE, maskVal:=in_ssn_mask);

      temp_top_slim :=
        PROJECT(
          temp_records_main_jur_suppressed,
          TRANSFORM(
            bankruptcyv3_services.layouts.layout_rollup,
            SELF.filer_type_ex := codes.BANKRUPTCIES.FILER_TYPE(LEFT.filer_type),
            SELF.trustee.DID := IF (LEFT.suppressT,'', LEFT.DID);
            SELF.trustee.trusteeID := LEFT.trusteeID;
            SELF.trustee.app_SSN := IF (LEFT.suppressT, '', LEFT.app_SSN);
            SELF.trustee.orig_name := IF (LEFT.suppressT, '', LEFT.trusteeName);
            SELF.trustee.orig_address := IF (LEFT.suppressT, '', LEFT.trusteeAddress);
            SELF.trustee.orig_city := IF (LEFT.suppressT, '', LEFT.trusteeCity);
            SELF.trustee.orig_st := IF (LEFT.suppressT, '', LEFT.trusteeState);
            SELF.trustee.orig_zip := IF (LEFT.suppressT, '', LEFT.trusteeZip);
            SELF.trustee.orig_zip4 := IF (LEFT.suppressT, '', LEFT.trusteeZip4);
            SELF.trustee.phone := IF (LEFT.suppressT, '', LEFT.trusteePhone);
            // cleaned names
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
            tempmodi := MODULE(PROJECT(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.LIBIN.PenaltyI_Indv.full,OPT))
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
              EXPORT STRING ssn_field := IF(LEFT.ssn<>'' AND LEFT.ssn[9]<>'',LEFT.ssn,LEFT.app_ssn);
              EXPORT STRING state_field := LEFT.st;
              EXPORT STRING suffix_field := LEFT.addr_suffix;
              EXPORT STRING zip_field := LEFT.zip;
            END;
            tempmodbn := MODULE(PROJECT(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,OPT))
              EXPORT STRING cname_field := LEFT.cname;
            END;
            tempmodf := MODULE(PROJECT(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.LIBIN.PenaltyI_FEIN.full,OPT))
              EXPORT STRING fein_field := LEFT.tax_id;
            END;
            tempmodb := MODULE(PROJECT(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.LIBIN.PenaltyI_BDID.full,OPT))
              EXPORT STRING bdid_field := LEFT.bdid;
            END;
            SELF.penalt :=
              AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempmodi)+
              AutoStandardI.LIBCALL_PenaltyI_BDID.val(tempmodb) +
              AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodbn) +
              AutoStandardI.LIBCALL_PenaltyI_FEIN.val(tempmodf),
            SELF.matched_party.party_type :=
              IF(DisplayMatchedParty_value,
                IF(LEFT.name_type=BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR,
                  LEFT.debtor_type, LEFT.name_type),
              ''),
            SELF.matched_party.parsed_party := IF(DisplayMatchedParty_value,LEFT),
            SELF.matched_party.address := IF(DisplayMatchedParty_value,LEFT),
            SELF.matched_party.did := LEFT.did,
            SELF := LEFT,
            SELF := []));
      temp_pen_dedup :=
      IF(isFCRA AND isCaseNumberSearch AND isAttorneySearch, // We are delibrately keeping multiple attorney records.
        DEDUP(SORT(temp_pen_slim(matched_party.party_type = 'A'),tmsid,
          matched_party.did,matched_party.parsed_party.cname,penalt),
            tmsid,matched_party.did,matched_party.parsed_party.cname),
        DEDUP(SORT(temp_pen_slim,tmsid,penalt,RECORD), tmsid)
      );
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
            SELF.matched_party.parsed_party := IF(dmp , RIGHT.matched_party.parsed_party),
            SELF.matched_party.address := IF(dmp , RIGHT.matched_party.address),
            SELF.matched_party.did := IF(dmp, RIGHT.matched_party.did, ''),
            SELF.ultid := RIGHT.ultid,
            SELF.orgid := RIGHT.orgid,
            SELF.seleid := RIGHT.seleid,
            SELF.proxid := RIGHT.proxid,
            SELF.powid := RIGHT.powid,
            SELF.empid := RIGHT.empid,
            SELF.dotid := RIGHT.dotid,
            SELF := LEFT),
          LEFT OUTER);
      temp_top_add_debtors := JOIN(
        temp_top_join,
        bankruptcyv3_services.fn_rollup_debtors(temp_records_searchD, in_ssn_mask),
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

      temp_records_main_full := PROJECT(temp_records_main_jur,
        RECORDOF(bankruptcyv3.key_bankruptcyv3_main_full()));

      temp_top_add_status :=
        IF(in_isSearch,
          temp_top_add_attorneys,
          JOIN(
            temp_top_add_attorneys,
            bankruptcyv3_services.fn_rollup_statuses(temp_records_main_full),
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
            bankruptcyv3_services.fn_rollup_comments(temp_records_main_full),
            LEFT.tmsid = RIGHT.tmsid,
            TRANSFORM(
              RECORDOF(temp_top_dedup),
              SELF.comment_history := RIGHT.comments,
              SELF := LEFT),
            LEFT OUTER));

      /* key containing docket info
         since we are getting case number from the TMSID, we only need to
         hit the dx_banko.Key_Banko_courtcode_casenumber key
         (NOT: dx_banko.Key_Banko_courtcode_fullcasenumber ) */

      UNSIGNED1 env := IF(isFCRA, Data_Services.data_env.iFCRA, Data_Services.data_env.iNonFCRA);
      k_docket := dx_banko.Key_Banko_courtcode_casenumber(env);

      /* functions for use in getting temp_add_docket_flag */
      court_code_from_tmsid (STRING tmsid) := tmsid[3..7];
      case_number_from_tmsid(STRING tmsid) := tmsid[8.. ];

      /*
        populate flag that tells client whether extra dockets info is available.
        we only started collecting docket (bk events) data in Nov. of 2009,
        so extra dockets info is only available on some cases,
        and only available for some of the events on some cases.
        (i.e. only those events after 11/2009 of that case)

        JIRA RR - 10730 => a new key was created to contain the full case number, so
        Add full case number/BKCaseNumber while adding docket flag

        Because we are replacing a project with the following join, we only
        need to keep(1)
      */

      temp_add_docket_flag :=
        JOIN(temp_top_add_comments,
             k_docket,
             court_code_from_tmsid (TRIM(LEFT.tmsid,ALL)) = RIGHT.court_code AND
             case_number_from_tmsid(TRIM(LEFT.tmsid,ALL)) = RIGHT.casekey,
             TRANSFORM(RECORDOF(LEFT),
              SELF.has_docket_info :=
                court_code_from_tmsid (TRIM(LEFT.tmsid,ALL)) = RIGHT.court_code AND
                case_number_from_tmsid(TRIM(LEFT.tmsid,ALL)) = RIGHT.casekey;
              SELF.full_case_number := RIGHT.BKCaseNumber;
              SELF := LEFT;
              ),
            LEFT OUTER,
            KEEP(BankruptcyV3_Services.consts.MAX_PER_COURT_CASE_LOOKUP));

      temp_top_add_dockets :=
        IF(in_isSearch OR NOT include_dockets,
          temp_add_docket_flag,
          JOIN(temp_add_docket_flag,
            bankruptcyv3_services.fn_rollup_dockets(temp_records_main_full, isFCRA, lower_entered_date, upper_entered_date),
            LEFT.tmsid = RIGHT.tmsid,
            TRANSFORM(
              RECORDOF(temp_top_add_comments),
              SELF.docket_history := RIGHT.dockets,
              SELF := LEFT),
            LEFT OUTER));

// output(in_tmsids1 , named('in_tmsids1'));
// output(temp_records_search0, named('temp_records_search0'));
// output(temp_records_search, named('temp_records_search'));
// output(temp_records_searchA, named('temp_records_searchA'));
// output(temp_records_searchD, named('temp_records_searchD'));
// output(temp_records_search_pulled, named('temp_records_search_pulled'));
// output(tmsids_pulled, named('tmsids_pulled_v3'));
// output(temp_records_main, named('temp_records_mainv3'));
// output(trusteesPulled, named('trusteesPulledv3'));
// output(temp_records_main_jur, named('temp_records_main_jur'),overwrite);
// output(temp_top_slim, named('temp_top_slimv3'), overwrite);

        RETURN SORT(temp_top_add_dockets,-orig_filing_date,-date_filed,RECORD);

    END;
