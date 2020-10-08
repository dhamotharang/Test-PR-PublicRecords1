IMPORT AutoStandardI, doxie, bankruptcyv3, bankruptcyv2_services;

gm := AutoStandardI.GlobalModule();
inner_params := input.params;

temp_mod_one := MODULE(PROJECT(gm,inner_params,OPT))END;
temp_mod_two := MODULE(PROJECT(gm,inner_params,OPT))
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
END;


EXPORT fn_penalty(RECORDOF(bankruptcyv3.key_bankruptcyV3_search_full_bip()) l) := FUNCTION
 
    tempmodi_1 := MODULE(PROJECT(temp_mod_one,AutoStandardI.LIBIN.PenaltyI_Indv.full,OPT))
      EXPORT BOOLEAN allow_wildcard := FALSE;
      EXPORT STRING city_field := l.v_city_name;
      EXPORT STRING city2_field := '';
      EXPORT STRING county_field := '';
      EXPORT STRING did_field := l.did;
      EXPORT STRING dob_field := '';
      EXPORT STRING fname_field := l.fname;
      EXPORT STRING lname_field := l.lname;
      EXPORT STRING mname_field := l.mname;
      EXPORT STRING phone_field := l.phone;
      EXPORT STRING pname_field := l.prim_name;
      EXPORT STRING postdir_field := l.postdir;
      EXPORT STRING prange_field := l.prim_range;
      EXPORT STRING predir_field := l.predir;
      EXPORT STRING ssn_field := IF(l.ssn<>'' AND l.ssn[9]<>'',l.ssn,l.app_ssn);
      EXPORT STRING state_field := l.st;
      EXPORT STRING suffix_field := l.addr_suffix;
      EXPORT STRING zip_field := l.zip;
    END;
    tempmodi_2 := MODULE(PROJECT(temp_mod_two,AutoStandardI.LIBIN.PenaltyI_Indv.full,OPT))
      EXPORT BOOLEAN allow_wildcard := FALSE;
      EXPORT STRING city_field := l.v_city_name;
      EXPORT STRING city2_field := '';
      EXPORT STRING county_field := '';
      EXPORT STRING did_field := l.did;
      EXPORT STRING dob_field := '';
      EXPORT STRING fname_field := l.fname;
      EXPORT STRING lname_field := l.lname;
      EXPORT STRING mname_field := l.mname;
      EXPORT STRING phone_field := l.phone;
      EXPORT STRING pname_field := l.prim_name;
      EXPORT STRING postdir_field := l.postdir;
      EXPORT STRING prange_field := l.prim_range;
      EXPORT STRING predir_field := l.predir;
      EXPORT STRING ssn_field := IF(l.ssn<>'' AND l.ssn[9]<>'',l.ssn,l.app_ssn);
      EXPORT STRING state_field := l.st;
      EXPORT STRING suffix_field := l.addr_suffix;
      EXPORT STRING zip_field := l.zip;
    END;
    tempmodbn_1 := MODULE(PROJECT(temp_mod_one,AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,OPT))
      EXPORT STRING cname_field := l.cname;
    END;
    tempmodbn_2 := MODULE(PROJECT(temp_mod_two,AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,OPT))
      EXPORT STRING cname_field := l.cname;
    END;
    tempmodf_1 := MODULE(PROJECT(temp_mod_one,AutoStandardI.LIBIN.PenaltyI_FEIN.full,OPT))
      EXPORT STRING fein_field := l.tax_id;
    END;
    tempmodf_2 := MODULE(PROJECT(temp_mod_two,AutoStandardI.LIBIN.PenaltyI_FEIN.full,OPT))
      EXPORT STRING fein_field := l.tax_id;
    END;
    tempmodb_1 := MODULE(PROJECT(temp_mod_one,AutoStandardI.LIBIN.PenaltyI_BDID.full,OPT))
      EXPORT STRING bdid_field := l.bdid;
    END;
    tempmodb_2 := MODULE(PROJECT(temp_mod_two,AutoStandardI.LIBIN.PenaltyI_BDID.full,OPT))
      EXPORT STRING bdid_field := l.bdid;
    END;
    
    penalt_1 := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempmodi_1) +
                AutoStandardI.LIBCALL_PenaltyI_BDID.val(tempmodb_1) +
                AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodbn_1) +
                AutoStandardI.LIBCALL_PenaltyI_FEIN.val(tempmodf_1);
    
    penalt_2 := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempmodi_2) +
                AutoStandardI.LIBCALL_PenaltyI_BDID.val(tempmodb_2) +
                AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodbn_2) +
                AutoStandardI.LIBCALL_PenaltyI_FEIN.val(tempmodf_2);
    penalt := IF(gm.TwoPartySearch, MAX(penalt_1,penalt_2),penalt_1);
                
  RETURN penalt;
END;
