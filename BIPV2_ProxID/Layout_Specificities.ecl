IMPORT SALT37;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_DOT_Base;
EXPORT active_duns_number_ChildRec := RECORD
  TYPEOF(l.active_duns_number) active_duns_number;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT active_enterprise_number_ChildRec := RECORD
  TYPEOF(l.active_enterprise_number) active_enterprise_number;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT active_domestic_corp_key_ChildRec := RECORD
  TYPEOF(l.active_domestic_corp_key) active_domestic_corp_key;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT hist_enterprise_number_ChildRec := RECORD
  TYPEOF(l.hist_enterprise_number) hist_enterprise_number;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT hist_duns_number_ChildRec := RECORD
  TYPEOF(l.hist_duns_number) hist_duns_number;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT hist_domestic_corp_key_ChildRec := RECORD
  TYPEOF(l.hist_domestic_corp_key) hist_domestic_corp_key;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT foreign_corp_key_ChildRec := RECORD
  TYPEOF(l.foreign_corp_key) foreign_corp_key;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT unk_corp_key_ChildRec := RECORD
  TYPEOF(l.unk_corp_key) unk_corp_key;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT ebr_file_number_ChildRec := RECORD
  TYPEOF(l.ebr_file_number) ebr_file_number;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT company_fein_ChildRec := RECORD
  TYPEOF(l.company_fein) company_fein;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cnp_name_ChildRec := RECORD
  TYPEOF(l.cnp_name) cnp_name;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT company_name_type_derived_ChildRec := RECORD
  TYPEOF(l.company_name_type_derived) company_name_type_derived;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cnp_number_ChildRec := RECORD
  TYPEOF(l.cnp_number) cnp_number;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cnp_btype_ChildRec := RECORD
  TYPEOF(l.cnp_btype) cnp_btype;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT company_phone_ChildRec := RECORD
  TYPEOF(l.company_phone) company_phone;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT prim_name_derived_ChildRec := RECORD
  TYPEOF(l.prim_name_derived) prim_name_derived;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT sec_range_ChildRec := RECORD
  TYPEOF(l.sec_range) sec_range;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT v_city_name_ChildRec := RECORD
  TYPEOF(l.v_city_name) v_city_name;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT st_ChildRec := RECORD
  TYPEOF(l.st) st;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT zip_ChildRec := RECORD
  TYPEOF(l.zip) zip;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT prim_range_derived_ChildRec := RECORD
  TYPEOF(l.prim_range_derived) prim_range_derived;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT company_csz_ChildRec := RECORD
  UNSIGNED4 company_csz;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT company_addr1_ChildRec := RECORD
  UNSIGNED4 company_addr1;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT company_address_ChildRec := RECORD
  UNSIGNED4 company_address;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT dt_first_seen_ChildRec := RECORD
  TYPEOF(l.dt_first_seen) dt_first_seen;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT dt_last_seen_ChildRec := RECORD
  TYPEOF(l.dt_last_seen) dt_last_seen;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT SrcRidVlid_ChildRec := RECORD
  SALT37.StrType Basis;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT ForeignCorpkey_ChildRec := RECORD
  SALT37.StrType Basis;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT RAAddresses_ChildRec := RECORD
  SALT37.StrType Basis;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT FilterPrimNames_ChildRec := RECORD
  SALT37.StrType Basis;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT R := RECORD,MAXLENGTH(32000)
 UNSIGNED1 dummy;
  REAL4 active_duns_number_specificity;
  REAL4 active_duns_number_switch;
  REAL4 active_duns_number_maximum;
  DATASET(active_duns_number_ChildRec) nulls_active_duns_number {MAXCOUNT(100)};
  REAL4 active_enterprise_number_specificity;
  REAL4 active_enterprise_number_switch;
  REAL4 active_enterprise_number_maximum;
  DATASET(active_enterprise_number_ChildRec) nulls_active_enterprise_number {MAXCOUNT(100)};
  REAL4 active_domestic_corp_key_specificity;
  REAL4 active_domestic_corp_key_switch;
  REAL4 active_domestic_corp_key_maximum;
  DATASET(active_domestic_corp_key_ChildRec) nulls_active_domestic_corp_key {MAXCOUNT(100)};
  REAL4 hist_enterprise_number_specificity;
  REAL4 hist_enterprise_number_switch;
  REAL4 hist_enterprise_number_maximum;
  DATASET(hist_enterprise_number_ChildRec) nulls_hist_enterprise_number {MAXCOUNT(100)};
  REAL4 hist_duns_number_specificity;
  REAL4 hist_duns_number_switch;
  REAL4 hist_duns_number_maximum;
  DATASET(hist_duns_number_ChildRec) nulls_hist_duns_number {MAXCOUNT(100)};
  REAL4 hist_domestic_corp_key_specificity;
  REAL4 hist_domestic_corp_key_switch;
  REAL4 hist_domestic_corp_key_maximum;
  DATASET(hist_domestic_corp_key_ChildRec) nulls_hist_domestic_corp_key {MAXCOUNT(100)};
  REAL4 foreign_corp_key_specificity;
  REAL4 foreign_corp_key_switch;
  REAL4 foreign_corp_key_maximum;
  DATASET(foreign_corp_key_ChildRec) nulls_foreign_corp_key {MAXCOUNT(100)};
  REAL4 unk_corp_key_specificity;
  REAL4 unk_corp_key_switch;
  REAL4 unk_corp_key_maximum;
  DATASET(unk_corp_key_ChildRec) nulls_unk_corp_key {MAXCOUNT(100)};
  REAL4 ebr_file_number_specificity;
  REAL4 ebr_file_number_switch;
  REAL4 ebr_file_number_maximum;
  DATASET(ebr_file_number_ChildRec) nulls_ebr_file_number {MAXCOUNT(100)};
  REAL4 company_fein_specificity;
  REAL4 company_fein_switch;
  REAL4 company_fein_maximum;
  DATASET(company_fein_ChildRec) nulls_company_fein {MAXCOUNT(100)};
  REAL4 cnp_name_specificity;
  REAL4 cnp_name_switch;
  REAL4 cnp_name_maximum;
  DATASET(cnp_name_ChildRec) nulls_cnp_name {MAXCOUNT(100)};
  REAL4 company_name_type_derived_specificity;
  REAL4 company_name_type_derived_switch;
  REAL4 company_name_type_derived_maximum;
  DATASET(company_name_type_derived_ChildRec) nulls_company_name_type_derived {MAXCOUNT(100)};
  REAL4 cnp_number_specificity;
  REAL4 cnp_number_switch;
  REAL4 cnp_number_maximum;
  DATASET(cnp_number_ChildRec) nulls_cnp_number {MAXCOUNT(100)};
  REAL4 cnp_btype_specificity;
  REAL4 cnp_btype_switch;
  REAL4 cnp_btype_maximum;
  DATASET(cnp_btype_ChildRec) nulls_cnp_btype {MAXCOUNT(100)};
  REAL4 company_phone_specificity;
  REAL4 company_phone_switch;
  REAL4 company_phone_maximum;
  DATASET(company_phone_ChildRec) nulls_company_phone {MAXCOUNT(100)};
  REAL4 prim_name_derived_specificity;
  REAL4 prim_name_derived_switch;
  REAL4 prim_name_derived_maximum;
  DATASET(prim_name_derived_ChildRec) nulls_prim_name_derived {MAXCOUNT(100)};
  REAL4 sec_range_specificity;
  REAL4 sec_range_switch;
  REAL4 sec_range_maximum;
  DATASET(sec_range_ChildRec) nulls_sec_range {MAXCOUNT(100)};
  REAL4 v_city_name_specificity;
  REAL4 v_city_name_switch;
  REAL4 v_city_name_maximum;
  DATASET(v_city_name_ChildRec) nulls_v_city_name {MAXCOUNT(100)};
  REAL4 st_specificity;
  REAL4 st_switch;
  REAL4 st_maximum;
  DATASET(st_ChildRec) nulls_st {MAXCOUNT(100)};
  REAL4 zip_specificity;
  REAL4 zip_switch;
  REAL4 zip_maximum;
  DATASET(zip_ChildRec) nulls_zip {MAXCOUNT(100)};
  REAL4 prim_range_derived_specificity;
  REAL4 prim_range_derived_switch;
  REAL4 prim_range_derived_maximum;
  DATASET(prim_range_derived_ChildRec) nulls_prim_range_derived {MAXCOUNT(100)};
  REAL4 company_csz_specificity;
  REAL4 company_csz_switch;
  REAL4 company_csz_maximum;
  DATASET(company_csz_ChildRec) nulls_company_csz {MAXCOUNT(100)};
  REAL4 company_addr1_specificity;
  REAL4 company_addr1_switch;
  REAL4 company_addr1_maximum;
  DATASET(company_addr1_ChildRec) nulls_company_addr1 {MAXCOUNT(100)};
  REAL4 company_address_specificity;
  REAL4 company_address_switch;
  REAL4 company_address_maximum;
  DATASET(company_address_ChildRec) nulls_company_address {MAXCOUNT(100)};
  REAL4 dt_first_seen_specificity;
  REAL4 dt_first_seen_switch;
  REAL4 dt_first_seen_maximum;
  DATASET(dt_first_seen_ChildRec) nulls_dt_first_seen {MAXCOUNT(100)};
  REAL4 dt_last_seen_specificity;
  REAL4 dt_last_seen_switch;
  REAL4 dt_last_seen_maximum;
  DATASET(dt_last_seen_ChildRec) nulls_dt_last_seen {MAXCOUNT(100)};
  REAL4 SrcRidVlid_specificity;
  REAL4 SrcRidVlid_switch;
  REAL4 SrcRidVlid_maximum;
  DATASET(SrcRidVlid_ChildRec) nulls_SrcRidVlid {MAXCOUNT(100)};
  REAL4 ForeignCorpkey_specificity;
  REAL4 ForeignCorpkey_switch;
  REAL4 ForeignCorpkey_maximum;
  DATASET(ForeignCorpkey_ChildRec) nulls_ForeignCorpkey {MAXCOUNT(100)};
  REAL4 RAAddresses_specificity;
  REAL4 RAAddresses_switch;
  REAL4 RAAddresses_maximum;
  DATASET(RAAddresses_ChildRec) nulls_RAAddresses {MAXCOUNT(100)};
  REAL4 FilterPrimNames_specificity;
  REAL4 FilterPrimNames_switch;
  REAL4 FilterPrimNames_maximum;
  DATASET(FilterPrimNames_ChildRec) nulls_FilterPrimNames {MAXCOUNT(100)};
END;
END;
