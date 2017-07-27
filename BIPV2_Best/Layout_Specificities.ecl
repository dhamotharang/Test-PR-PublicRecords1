IMPORT SALT24;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_Base;
export company_name_ChildRec := record
  typeof(l.company_name) company_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_fein_ChildRec := record
  typeof(l.company_fein) company_fein;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_phone_ChildRec := record
  typeof(l.company_phone) company_phone;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_url_ChildRec := record
  typeof(l.company_url) company_url;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_prim_range_ChildRec := record
  typeof(l.company_prim_range) company_prim_range;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_predir_ChildRec := record
  typeof(l.company_predir) company_predir;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_prim_name_ChildRec := record
  typeof(l.company_prim_name) company_prim_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_addr_suffix_ChildRec := record
  typeof(l.company_addr_suffix) company_addr_suffix;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_postdir_ChildRec := record
  typeof(l.company_postdir) company_postdir;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_unit_desig_ChildRec := record
  typeof(l.company_unit_desig) company_unit_desig;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_sec_range_ChildRec := record
  typeof(l.company_sec_range) company_sec_range;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_p_city_name_ChildRec := record
  typeof(l.company_p_city_name) company_p_city_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_v_city_name_ChildRec := record
  typeof(l.company_v_city_name) company_v_city_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_st_ChildRec := record
  typeof(l.company_st) company_st;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_zip5_ChildRec := record
  typeof(l.company_zip5) company_zip5;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_zip4_ChildRec := record
  typeof(l.company_zip4) company_zip4;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_csz_ChildRec := record
  UNSIGNED4 company_csz;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_addr1_ChildRec := record
  UNSIGNED4 company_addr1;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_address_ChildRec := record
  UNSIGNED4 company_address;
  unsigned8 cnt;
  unsigned4 id;
end;
EXPORT R := RECORD,MAXLENGTH(32000)
 UNSIGNED1 dummy;
  real4 company_name_specificity;
  real4 company_name_switch;
  real4 company_name_max;
  dataset(company_name_ChildRec) nulls_company_name {MAXCOUNT(100)};
  real4 company_fein_specificity;
  real4 company_fein_switch;
  real4 company_fein_max;
  dataset(company_fein_ChildRec) nulls_company_fein {MAXCOUNT(100)};
  real4 company_phone_specificity;
  real4 company_phone_switch;
  real4 company_phone_max;
  dataset(company_phone_ChildRec) nulls_company_phone {MAXCOUNT(100)};
  real4 company_url_specificity;
  real4 company_url_switch;
  real4 company_url_max;
  dataset(company_url_ChildRec) nulls_company_url {MAXCOUNT(100)};
  real4 company_prim_range_specificity;
  real4 company_prim_range_switch;
  real4 company_prim_range_max;
  dataset(company_prim_range_ChildRec) nulls_company_prim_range {MAXCOUNT(100)};
  real4 company_predir_specificity;
  real4 company_predir_switch;
  real4 company_predir_max;
  dataset(company_predir_ChildRec) nulls_company_predir {MAXCOUNT(100)};
  real4 company_prim_name_specificity;
  real4 company_prim_name_switch;
  real4 company_prim_name_max;
  dataset(company_prim_name_ChildRec) nulls_company_prim_name {MAXCOUNT(100)};
  real4 company_addr_suffix_specificity;
  real4 company_addr_suffix_switch;
  real4 company_addr_suffix_max;
  dataset(company_addr_suffix_ChildRec) nulls_company_addr_suffix {MAXCOUNT(100)};
  real4 company_postdir_specificity;
  real4 company_postdir_switch;
  real4 company_postdir_max;
  dataset(company_postdir_ChildRec) nulls_company_postdir {MAXCOUNT(100)};
  real4 company_unit_desig_specificity;
  real4 company_unit_desig_switch;
  real4 company_unit_desig_max;
  dataset(company_unit_desig_ChildRec) nulls_company_unit_desig {MAXCOUNT(100)};
  real4 company_sec_range_specificity;
  real4 company_sec_range_switch;
  real4 company_sec_range_max;
  dataset(company_sec_range_ChildRec) nulls_company_sec_range {MAXCOUNT(100)};
  real4 company_p_city_name_specificity;
  real4 company_p_city_name_switch;
  real4 company_p_city_name_max;
  dataset(company_p_city_name_ChildRec) nulls_company_p_city_name {MAXCOUNT(100)};
  real4 company_v_city_name_specificity;
  real4 company_v_city_name_switch;
  real4 company_v_city_name_max;
  dataset(company_v_city_name_ChildRec) nulls_company_v_city_name {MAXCOUNT(100)};
  real4 company_st_specificity;
  real4 company_st_switch;
  real4 company_st_max;
  dataset(company_st_ChildRec) nulls_company_st {MAXCOUNT(100)};
  real4 company_zip5_specificity;
  real4 company_zip5_switch;
  real4 company_zip5_max;
  dataset(company_zip5_ChildRec) nulls_company_zip5 {MAXCOUNT(100)};
  real4 company_zip4_specificity;
  real4 company_zip4_switch;
  real4 company_zip4_max;
  dataset(company_zip4_ChildRec) nulls_company_zip4 {MAXCOUNT(100)};
  real4 company_csz_specificity;
  real4 company_csz_switch;
  real4 company_csz_max;
  dataset(company_csz_ChildRec) nulls_company_csz {MAXCOUNT(100)};
  real4 company_addr1_specificity;
  real4 company_addr1_switch;
  real4 company_addr1_max;
  dataset(company_addr1_ChildRec) nulls_company_addr1 {MAXCOUNT(100)};
  real4 company_address_specificity;
  real4 company_address_switch;
  real4 company_address_max;
  dataset(company_address_ChildRec) nulls_company_address {MAXCOUNT(100)};
END;
END;
