IMPORT AutoStandardI, bankruptcyv3, bankruptcyv3_services, codes,
       doxie, Suppress;

EXPORT fn_rollup_corrections(
  DATASET(bankruptcyv3_services.Layout_key_bankruptcyv3_search_full_bip_plus_case_numbers) ds_search,
  DATASET(RECORDOF(bankruptcyv3.key_bankruptcyv3_main_full())) ds_main,
  STRING6 in_ssn_mask = '',
  BOOLEAN in_isSearch = FALSE,
  BOOLEAN isFCRA = FALSE
  ) :=
    FUNCTION
      doxie.MAC_Header_Field_Declare(isFCRA) //only for DisplayMatchedParty_value

      temp_records_search := ds_search;
      //temp_records_main := ds_main;

     // call suppress macro to suppress the trustee app_ssn field.
      Suppress.MAC_Mask(ds_main, temp_records_main, app_ssn, null, TRUE, FALSE, maskVal:=in_ssn_mask);

      temp_top_slim :=
        PROJECT(
          temp_records_main,
          TRANSFORM(
            bankruptcyv3_services.layouts.layout_rollup,
            SELF.filer_type_ex := codes.BANKRUPTCIES.FILER_TYPE(LEFT.filer_type),
            SELF.trustee.DID := LEFT.DID;
            SELF.trustee.trusteeID := LEFT.trusteeID;
            SELF.trustee.app_SSN := LEFT.app_SSN;
            SELF.trustee.orig_name := LEFT.trusteeName;
            SELF.trustee.orig_address := LEFT.trusteeAddress;
            SELF.trustee.orig_city := LEFT.trusteeCity;
            SELF.trustee.orig_st := LEFT.trusteeState;
            SELF.trustee.orig_zip := LEFT.trusteeZip;
            SELF.trustee.orig_zip4 := LEFT.trusteeZip4;
            SELF.trustee.phone := LEFT.trusteePhone;
            SELF.trustee := LEFT; // pick up ALL cleaned name/address fields
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
          temp_records_search,
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
            SELF.matched_party.party_type := IF(DisplayMatchedParty_value
                                               ,IF(LEFT.name_type=BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR
                                               ,LEFT.debtor_type
                                               ,LEFT.name_type)
                                               ,''),
            SELF.matched_party.parsed_party := IF(DisplayMatchedParty_value,LEFT),
            SELF.matched_party.address := IF(DisplayMatchedParty_value,LEFT),
            SELF.matched_party.did := LEFT.did,
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
            dmp := NOT LEFT.isdeepdive;
            SELF.matched_party.party_type := IF(dmp, RIGHT.matched_party.party_type,''),
            SELF.matched_party.parsed_party := IF(dmp, RIGHT.matched_party.parsed_party),
            SELF.matched_party.address := IF(dmp, RIGHT.matched_party.address);
            SELF.matched_party.did := IF(dmp, RIGHT.matched_party.did, ''),
            SELF := LEFT
            ),
          LEFT OUTER);

      temp_top_add_debtors := JOIN(
        temp_top_join,
        bankruptcyv3_services.fn_rollup_debtors(temp_records_search(name_type[1] = BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR),in_ssn_mask),
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
            bankruptcyv3_services.fn_rollup_parties(temp_records_search(name_type[1] = BankruptcyV3_Services.consts.NAME_TYPES.ATTORNEY),in_ssn_mask),
            LEFT.tmsid = RIGHT.tmsid,
            TRANSFORM(
              RECORDOF(temp_top_dedup),
              SELF.attorneys := PROJECT(RIGHT.parties, layouts.layout_party_slim),
              SELF := LEFT),
            LEFT OUTER));

      temp_records_main_full := PROJECT(temp_records_main,
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

      RETURN
        SORT(temp_top_add_comments,-orig_filing_date,-date_filed,RECORD);
    END;
