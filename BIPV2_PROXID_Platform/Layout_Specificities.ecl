IMPORT SALT30;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_DOT_Base;
export active_duns_number_ChildRec := record
  typeof(l.active_duns_number) active_duns_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export active_enterprise_number_ChildRec := record
  typeof(l.active_enterprise_number) active_enterprise_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export active_domestic_corp_key_ChildRec := record
  typeof(l.active_domestic_corp_key) active_domestic_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export hist_enterprise_number_ChildRec := record
  typeof(l.hist_enterprise_number) hist_enterprise_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export hist_duns_number_ChildRec := record
  typeof(l.hist_duns_number) hist_duns_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export hist_domestic_corp_key_ChildRec := record
  typeof(l.hist_domestic_corp_key) hist_domestic_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export foreign_corp_key_ChildRec := record
  typeof(l.foreign_corp_key) foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export unk_corp_key_ChildRec := record
  typeof(l.unk_corp_key) unk_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export ebr_file_number_ChildRec := record
  typeof(l.ebr_file_number) ebr_file_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export cnp_name_ChildRec := record
  typeof(l.cnp_name) cnp_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export cnp_number_ChildRec := record
  typeof(l.cnp_number) cnp_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export cnp_btype_ChildRec := record
  typeof(l.cnp_btype) cnp_btype;
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
export prim_name_derived_ChildRec := record
  typeof(l.prim_name_derived) prim_name_derived;
  unsigned8 cnt;
  unsigned4 id;
end;
export sec_range_ChildRec := record
  typeof(l.sec_range) sec_range;
  unsigned8 cnt;
  unsigned4 id;
end;
export v_city_name_ChildRec := record
  typeof(l.v_city_name) v_city_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export st_ChildRec := record
  typeof(l.st) st;
  unsigned8 cnt;
  unsigned4 id;
end;
export zip_ChildRec := record
  typeof(l.zip) zip;
  unsigned8 cnt;
  unsigned4 id;
end;
export prim_range_derived_ChildRec := record
  typeof(l.prim_range_derived) prim_range_derived;
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
EXPORT SrcRidVlid_ChildRec := RECORD
  SALT30.StrType Basis;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT ForeignCorpkey_ChildRec := RECORD
  SALT30.StrType Basis;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT RAAddresses_ChildRec := RECORD
  SALT30.StrType Basis;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT FilterPrimNames_ChildRec := RECORD
  SALT30.StrType Basis;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT R := RECORD,MAXLENGTH(32000)
 UNSIGNED1 dummy;
  real4 active_duns_number_specificity;
  real4 active_duns_number_switch;
  real4 active_duns_number_max;
  dataset(active_duns_number_ChildRec) nulls_active_duns_number {MAXCOUNT(100)};
  real4 active_enterprise_number_specificity;
  real4 active_enterprise_number_switch;
  real4 active_enterprise_number_max;
  dataset(active_enterprise_number_ChildRec) nulls_active_enterprise_number {MAXCOUNT(100)};
  real4 active_domestic_corp_key_specificity;
  real4 active_domestic_corp_key_switch;
  real4 active_domestic_corp_key_max;
  dataset(active_domestic_corp_key_ChildRec) nulls_active_domestic_corp_key {MAXCOUNT(100)};
  real4 hist_enterprise_number_specificity;
  real4 hist_enterprise_number_switch;
  real4 hist_enterprise_number_max;
  dataset(hist_enterprise_number_ChildRec) nulls_hist_enterprise_number {MAXCOUNT(100)};
  real4 hist_duns_number_specificity;
  real4 hist_duns_number_switch;
  real4 hist_duns_number_max;
  dataset(hist_duns_number_ChildRec) nulls_hist_duns_number {MAXCOUNT(100)};
  real4 hist_domestic_corp_key_specificity;
  real4 hist_domestic_corp_key_switch;
  real4 hist_domestic_corp_key_max;
  dataset(hist_domestic_corp_key_ChildRec) nulls_hist_domestic_corp_key {MAXCOUNT(100)};
  real4 foreign_corp_key_specificity;
  real4 foreign_corp_key_switch;
  real4 foreign_corp_key_max;
  dataset(foreign_corp_key_ChildRec) nulls_foreign_corp_key {MAXCOUNT(100)};
  real4 unk_corp_key_specificity;
  real4 unk_corp_key_switch;
  real4 unk_corp_key_max;
  dataset(unk_corp_key_ChildRec) nulls_unk_corp_key {MAXCOUNT(100)};
  real4 ebr_file_number_specificity;
  real4 ebr_file_number_switch;
  real4 ebr_file_number_max;
  dataset(ebr_file_number_ChildRec) nulls_ebr_file_number {MAXCOUNT(100)};
  real4 cnp_name_specificity;
  real4 cnp_name_switch;
  real4 cnp_name_max;
  dataset(cnp_name_ChildRec) nulls_cnp_name {MAXCOUNT(100)};
  real4 cnp_number_specificity;
  real4 cnp_number_switch;
  real4 cnp_number_max;
  dataset(cnp_number_ChildRec) nulls_cnp_number {MAXCOUNT(100)};
  real4 cnp_btype_specificity;
  real4 cnp_btype_switch;
  real4 cnp_btype_max;
  dataset(cnp_btype_ChildRec) nulls_cnp_btype {MAXCOUNT(100)};
  real4 company_fein_specificity;
  real4 company_fein_switch;
  real4 company_fein_max;
  dataset(company_fein_ChildRec) nulls_company_fein {MAXCOUNT(100)};
  real4 company_phone_specificity;
  real4 company_phone_switch;
  real4 company_phone_max;
  dataset(company_phone_ChildRec) nulls_company_phone {MAXCOUNT(100)};
  real4 prim_name_derived_specificity;
  real4 prim_name_derived_switch;
  real4 prim_name_derived_max;
  dataset(prim_name_derived_ChildRec) nulls_prim_name_derived {MAXCOUNT(100)};
  real4 sec_range_specificity;
  real4 sec_range_switch;
  real4 sec_range_max;
  dataset(sec_range_ChildRec) nulls_sec_range {MAXCOUNT(100)};
  real4 v_city_name_specificity;
  real4 v_city_name_switch;
  real4 v_city_name_max;
  dataset(v_city_name_ChildRec) nulls_v_city_name {MAXCOUNT(100)};
  real4 st_specificity;
  real4 st_switch;
  real4 st_max;
  dataset(st_ChildRec) nulls_st {MAXCOUNT(100)};
  real4 zip_specificity;
  real4 zip_switch;
  real4 zip_max;
  dataset(zip_ChildRec) nulls_zip {MAXCOUNT(100)};
  real4 prim_range_derived_specificity;
  real4 prim_range_derived_switch;
  real4 prim_range_derived_max;
  dataset(prim_range_derived_ChildRec) nulls_prim_range_derived {MAXCOUNT(100)};
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
  REAL4 SrcRidVlid_specificity;
  REAL4 SrcRidVlid_switch;
  REAL4 SrcRidVlid_max;
  DATASET(SrcRidVlid_ChildRec) nulls_SrcRidVlid {MAXCOUNT(100)};
  REAL4 ForeignCorpkey_specificity;
  REAL4 ForeignCorpkey_switch;
  REAL4 ForeignCorpkey_max;
  DATASET(ForeignCorpkey_ChildRec) nulls_ForeignCorpkey {MAXCOUNT(100)};
  REAL4 RAAddresses_specificity;
  REAL4 RAAddresses_switch;
  REAL4 RAAddresses_max;
  DATASET(RAAddresses_ChildRec) nulls_RAAddresses {MAXCOUNT(100)};
  REAL4 FilterPrimNames_specificity;
  REAL4 FilterPrimNames_switch;
  REAL4 FilterPrimNames_max;
  DATASET(FilterPrimNames_ChildRec) nulls_FilterPrimNames {MAXCOUNT(100)};
END;
END;
