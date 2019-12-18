import AutoStandardI, bankruptcyv3, bankruptcyv3_services, codes,
       doxie, Suppress;

export fn_rollup_corrections(
  dataset(bankruptcyv3_services.Layout_key_bankruptcyv3_search_full_bip_plus_case_numbers) ds_search,
  dataset(recordof(bankruptcyv3.key_bankruptcyv3_main_full())) ds_main,
  string6 in_ssn_mask = '',
  boolean in_isSearch = false,
  boolean isFCRA = false
  ) :=
    function
      doxie.MAC_Header_Field_Declare(isFCRA)  //only for DisplayMatchedParty_value

      temp_records_search := ds_search;
      //temp_records_main := ds_main;

     // call suppress macro to suppress the trustee app_ssn field.
      Suppress.MAC_Mask(ds_main, temp_records_main, app_ssn, null, true, false, maskVal:=in_ssn_mask);

      temp_top_slim :=
        project(
          temp_records_main,
          transform(
            bankruptcyv3_services.layouts.layout_rollup,
            self.filer_type_ex := codes.BANKRUPTCIES.FILER_TYPE(left.filer_type),
            self.trustee.DID := left.DID;
            self.trustee.trusteeID := left.trusteeID;
            self.trustee.app_SSN := left.app_SSN;
            self.trustee.orig_name := left.trusteeName;
            self.trustee.orig_address := left.trusteeAddress;
            self.trustee.orig_city := left.trusteeCity;
            self.trustee.orig_st := left.trusteeState;
            self.trustee.orig_zip := left.trusteeZip;
            self.trustee.orig_zip4 := left.trusteeZip4;
            self.trustee.phone := left.trusteePhone;
            self.trustee := left;   // pick up all cleaned name/address fields
            self := left,
            self := []));

      temp_top_dedup :=
        dedup(
          sort(
            temp_top_slim,
            tmsid,record),
          tmsid);

      temp_pen_slim :=
        project(
          temp_records_search,
          transform(
            bankruptcyv3_services.layouts.layout_rollup,
            tempmodi := module(project(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
              export boolean allow_wildcard := false;
              export string city_field := left.v_city_name;
              export string city2_field := '';
              export string county_field := '';
              export string did_field := left.did;
              export string dob_field := '';
              export string fname_field := left.fname;
              export string lname_field := left.lname;
              export string mname_field := left.mname;
              export string phone_field := left.phone;
              export string pname_field := left.prim_name;
              export string postdir_field := left.postdir;
              export string prange_field := left.prim_range;
              export string predir_field := left.predir;
              export string ssn_field := IF(left.ssn<>'' and left.ssn[9]<>'',left.ssn,left.app_ssn);
              export string state_field := left.st;
              export string suffix_field := left.addr_suffix;
              export string zip_field := left.zip;
            end;
            tempmodbn := module(project(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
              export string cname_field := left.cname;
            end;
            tempmodf := module(project(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.LIBIN.PenaltyI_FEIN.full,opt))
              export string fein_field := left.tax_id;
            end;
            tempmodb := module(project(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.LIBIN.PenaltyI_BDID.full,opt))
              export string bdid_field := left.bdid;
            end;
            self.penalt :=
              AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempmodi)+
              AutoStandardI.LIBCALL_PenaltyI_BDID.val(tempmodb) +
              AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodbn) +
              AutoStandardI.LIBCALL_PenaltyI_FEIN.val(tempmodf),
            self.matched_party.party_type := IF(DisplayMatchedParty_value
                                               ,IF(left.name_type=BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR
                                               ,left.debtor_type
                                               ,left.name_type)
                                               ,''),
            self.matched_party.parsed_party := IF(DisplayMatchedParty_value,LEFT),
            self.matched_party.address :=  IF(DisplayMatchedParty_value,LEFT),
            self.matched_party.did := left.did,
            self := left,
            self := []));

      temp_pen_dedup :=
        dedup(
          sort(
            temp_pen_slim,
            tmsid,penalt,record),
          tmsid);

      temp_top_join :=
        join(
          temp_top_dedup,
          temp_pen_dedup,
          left.tmsid = right.tmsid,
          transform(
            recordof(temp_pen_dedup),
            self.penalt := right.penalt,
            dmp := not left.isdeepdive;
            self.matched_party.party_type := if(dmp, right.matched_party.party_type,''),
            self.matched_party.parsed_party := if(dmp, right.matched_party.parsed_party),
            self.matched_party.address := if(dmp, right.matched_party.address);
            self.matched_party.did := if(dmp, right.matched_party.did, ''),
            self := left
            ),
          left outer);

      temp_top_add_debtors := join(
        temp_top_join,
        bankruptcyv3_services.fn_rollup_debtors(temp_records_search(name_type[1] = BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR),in_ssn_mask),
        left.tmsid = right.tmsid,
        transform(
          recordof(temp_top_dedup),
          self.debtors := right.parties,
          self := left),
        left outer);

      temp_top_add_attorneys :=
        if(in_isSearch,
          temp_top_add_debtors,
          join(
            temp_top_add_debtors,
            bankruptcyv3_services.fn_rollup_parties(temp_records_search(name_type[1] = BankruptcyV3_Services.consts.NAME_TYPES.ATTORNEY),in_ssn_mask),
            left.tmsid = right.tmsid,
            transform(
              recordof(temp_top_dedup),
              self.attorneys := project(right.parties, layouts.layout_party_slim),
              self := left),
            left outer));

      temp_records_main_full := project(temp_records_main,
                                        recordof(bankruptcyv3.key_bankruptcyv3_main_full()));

      temp_top_add_status :=
        if(in_isSearch,
          temp_top_add_attorneys,
          join(
            temp_top_add_attorneys,
            bankruptcyv3_services.fn_rollup_statuses(temp_records_main_full),
            left.tmsid = right.tmsid,
            transform(
              recordof(temp_top_dedup),
              self.status_history := right.statuses,
              self := left),
            left outer));

      temp_top_add_comments :=
        if(in_isSearch,
          temp_top_add_status,
          join(
            temp_top_add_status,
            bankruptcyv3_services.fn_rollup_comments(temp_records_main_full),
            left.tmsid = right.tmsid,
            transform(
              recordof(temp_top_dedup),
              self.comment_history := right.comments,
              self := left),
            left outer));

      return
        sort(temp_top_add_comments,-orig_filing_date,-date_filed,record);
    end;
