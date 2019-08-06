IMPORT SALT32;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_DOT;
EXPORT cnp_name_ChildRec := RECORD
  TYPEOF(l.cnp_name) cnp_name;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_legal_name_ChildRec := RECORD
  TYPEOF(l.corp_legal_name) corp_legal_name;
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
EXPORT company_fein_ChildRec := RECORD
  TYPEOF(l.company_fein) company_fein;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
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
EXPORT prim_range_ChildRec := RECORD
  TYPEOF(l.prim_range) prim_range;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT prim_name_ChildRec := RECORD
  TYPEOF(l.prim_name) prim_name;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT sec_range_ChildRec := RECORD
  TYPEOF(l.sec_range) sec_range;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT st_ChildRec := RECORD
  TYPEOF(l.st) st;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT v_city_name_ChildRec := RECORD
  TYPEOF(l.v_city_name) v_city_name;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT zip_ChildRec := RECORD
  TYPEOF(l.zip) zip;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT csz_ChildRec := RECORD
  UNSIGNED4 csz;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT addr1_ChildRec := RECORD
  UNSIGNED4 addr1;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT address_ChildRec := RECORD
  UNSIGNED4 address;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT isContact_ChildRec := RECORD
  TYPEOF(l.isContact) isContact;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT fname_ChildRec := RECORD
  TYPEOF(l.fname) fname;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT mname_ChildRec := RECORD
  TYPEOF(l.mname) mname;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT lname_ChildRec := RECORD
  TYPEOF(l.lname) lname;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT name_suffix_ChildRec := RECORD
  TYPEOF(l.name_suffix) name_suffix;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT contact_ssn_ChildRec := RECORD
  TYPEOF(l.contact_ssn) contact_ssn;
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
EXPORT ForeignCorpkey_ChildRec := RECORD
  SALT32.StrType Basis;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT R := RECORD,MAXLENGTH(32000)
 UNSIGNED1 dummy;
  REAL4 cnp_name_specificity;
  REAL4 cnp_name_switch;
  REAL4 cnp_name_maximum;
  DATASET(cnp_name_ChildRec) nulls_cnp_name {MAXCOUNT(100)};
  REAL4 corp_legal_name_specificity;
  REAL4 corp_legal_name_switch;
  REAL4 corp_legal_name_maximum;
  DATASET(corp_legal_name_ChildRec) nulls_corp_legal_name {MAXCOUNT(100)};
  REAL4 cnp_number_specificity;
  REAL4 cnp_number_switch;
  REAL4 cnp_number_maximum;
  DATASET(cnp_number_ChildRec) nulls_cnp_number {MAXCOUNT(100)};
  REAL4 cnp_btype_specificity;
  REAL4 cnp_btype_switch;
  REAL4 cnp_btype_maximum;
  DATASET(cnp_btype_ChildRec) nulls_cnp_btype {MAXCOUNT(100)};
  REAL4 company_fein_specificity;
  REAL4 company_fein_switch;
  REAL4 company_fein_maximum;
  DATASET(company_fein_ChildRec) nulls_company_fein {MAXCOUNT(100)};
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
  REAL4 prim_range_specificity;
  REAL4 prim_range_switch;
  REAL4 prim_range_maximum;
  DATASET(prim_range_ChildRec) nulls_prim_range {MAXCOUNT(100)};
  REAL4 prim_name_specificity;
  REAL4 prim_name_switch;
  REAL4 prim_name_maximum;
  DATASET(prim_name_ChildRec) nulls_prim_name {MAXCOUNT(100)};
  REAL4 sec_range_specificity;
  REAL4 sec_range_switch;
  REAL4 sec_range_maximum;
  DATASET(sec_range_ChildRec) nulls_sec_range {MAXCOUNT(100)};
  REAL4 st_specificity;
  REAL4 st_switch;
  REAL4 st_maximum;
  DATASET(st_ChildRec) nulls_st {MAXCOUNT(100)};
  REAL4 v_city_name_specificity;
  REAL4 v_city_name_switch;
  REAL4 v_city_name_maximum;
  DATASET(v_city_name_ChildRec) nulls_v_city_name {MAXCOUNT(100)};
  REAL4 zip_specificity;
  REAL4 zip_switch;
  REAL4 zip_maximum;
  DATASET(zip_ChildRec) nulls_zip {MAXCOUNT(100)};
  REAL4 csz_specificity;
  REAL4 csz_switch;
  REAL4 csz_maximum;
  DATASET(csz_ChildRec) nulls_csz {MAXCOUNT(100)};
  REAL4 addr1_specificity;
  REAL4 addr1_switch;
  REAL4 addr1_maximum;
  DATASET(addr1_ChildRec) nulls_addr1 {MAXCOUNT(100)};
  REAL4 address_specificity;
  REAL4 address_switch;
  REAL4 address_maximum;
  DATASET(address_ChildRec) nulls_address {MAXCOUNT(100)};
  REAL4 isContact_specificity;
  REAL4 isContact_switch;
  REAL4 isContact_maximum;
  DATASET(isContact_ChildRec) nulls_isContact {MAXCOUNT(100)};
  REAL4 fname_specificity;
  REAL4 fname_switch;
  REAL4 fname_maximum;
  DATASET(fname_ChildRec) nulls_fname {MAXCOUNT(100)};
  REAL4 mname_specificity;
  REAL4 mname_switch;
  REAL4 mname_maximum;
  DATASET(mname_ChildRec) nulls_mname {MAXCOUNT(100)};
  REAL4 lname_specificity;
  REAL4 lname_switch;
  REAL4 lname_maximum;
  DATASET(lname_ChildRec) nulls_lname {MAXCOUNT(100)};
  REAL4 name_suffix_specificity;
  REAL4 name_suffix_switch;
  REAL4 name_suffix_maximum;
  DATASET(name_suffix_ChildRec) nulls_name_suffix {MAXCOUNT(100)};
  REAL4 contact_ssn_specificity;
  REAL4 contact_ssn_switch;
  REAL4 contact_ssn_maximum;
  DATASET(contact_ssn_ChildRec) nulls_contact_ssn {MAXCOUNT(100)};
  REAL4 dt_first_seen_specificity;
  REAL4 dt_first_seen_switch;
  REAL4 dt_first_seen_maximum;
  DATASET(dt_first_seen_ChildRec) nulls_dt_first_seen {MAXCOUNT(100)};
  REAL4 dt_last_seen_specificity;
  REAL4 dt_last_seen_switch;
  REAL4 dt_last_seen_maximum;
  DATASET(dt_last_seen_ChildRec) nulls_dt_last_seen {MAXCOUNT(100)};
  REAL4 ForeignCorpkey_specificity;
  REAL4 ForeignCorpkey_switch;
  REAL4 ForeignCorpkey_max;
  DATASET(ForeignCorpkey_ChildRec) nulls_ForeignCorpkey {MAXCOUNT(100)};
END;
END;
