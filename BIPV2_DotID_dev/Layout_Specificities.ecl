IMPORT SALT30;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_DOT;
export cnp_name_ChildRec := record
  typeof(l.cnp_name) cnp_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export corp_legal_name_ChildRec := record
  typeof(l.corp_legal_name) corp_legal_name;
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
export prim_range_ChildRec := record
  typeof(l.prim_range) prim_range;
  unsigned8 cnt;
  unsigned4 id;
end;
export prim_name_ChildRec := record
  typeof(l.prim_name) prim_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export sec_range_ChildRec := record
  typeof(l.sec_range) sec_range;
  unsigned8 cnt;
  unsigned4 id;
end;
export st_ChildRec := record
  typeof(l.st) st;
  unsigned8 cnt;
  unsigned4 id;
end;
export v_city_name_ChildRec := record
  typeof(l.v_city_name) v_city_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export zip_ChildRec := record
  typeof(l.zip) zip;
  unsigned8 cnt;
  unsigned4 id;
end;
export csz_ChildRec := record
  UNSIGNED4 csz;
  unsigned8 cnt;
  unsigned4 id;
end;
export addr1_ChildRec := record
  UNSIGNED4 addr1;
  unsigned8 cnt;
  unsigned4 id;
end;
export address_ChildRec := record
  UNSIGNED4 address;
  unsigned8 cnt;
  unsigned4 id;
end;
export isContact_ChildRec := record
  typeof(l.isContact) isContact;
  unsigned8 cnt;
  unsigned4 id;
end;
export fname_ChildRec := record
  typeof(l.fname) fname;
  unsigned8 cnt;
  unsigned4 id;
end;
export mname_ChildRec := record
  typeof(l.mname) mname;
  unsigned8 cnt;
  unsigned4 id;
end;
export lname_ChildRec := record
  typeof(l.lname) lname;
  unsigned8 cnt;
  unsigned4 id;
end;
export name_suffix_ChildRec := record
  typeof(l.name_suffix) name_suffix;
  unsigned8 cnt;
  unsigned4 id;
end;
export contact_ssn_ChildRec := record
  typeof(l.contact_ssn) contact_ssn;
  unsigned8 cnt;
  unsigned4 id;
end;
EXPORT ForeignCorpkey_ChildRec := RECORD
  SALT30.StrType Basis;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT R := RECORD,MAXLENGTH(32000)
 UNSIGNED1 dummy;
  real4 cnp_name_specificity;
  real4 cnp_name_switch;
  real4 cnp_name_max;
  dataset(cnp_name_ChildRec) nulls_cnp_name {MAXCOUNT(100)};
  real4 corp_legal_name_specificity;
  real4 corp_legal_name_switch;
  real4 corp_legal_name_max;
  dataset(corp_legal_name_ChildRec) nulls_corp_legal_name {MAXCOUNT(100)};
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
  real4 prim_range_specificity;
  real4 prim_range_switch;
  real4 prim_range_max;
  dataset(prim_range_ChildRec) nulls_prim_range {MAXCOUNT(100)};
  real4 prim_name_specificity;
  real4 prim_name_switch;
  real4 prim_name_max;
  dataset(prim_name_ChildRec) nulls_prim_name {MAXCOUNT(100)};
  real4 sec_range_specificity;
  real4 sec_range_switch;
  real4 sec_range_max;
  dataset(sec_range_ChildRec) nulls_sec_range {MAXCOUNT(100)};
  real4 st_specificity;
  real4 st_switch;
  real4 st_max;
  dataset(st_ChildRec) nulls_st {MAXCOUNT(100)};
  real4 v_city_name_specificity;
  real4 v_city_name_switch;
  real4 v_city_name_max;
  dataset(v_city_name_ChildRec) nulls_v_city_name {MAXCOUNT(100)};
  real4 zip_specificity;
  real4 zip_switch;
  real4 zip_max;
  dataset(zip_ChildRec) nulls_zip {MAXCOUNT(100)};
  real4 csz_specificity;
  real4 csz_switch;
  real4 csz_max;
  dataset(csz_ChildRec) nulls_csz {MAXCOUNT(100)};
  real4 addr1_specificity;
  real4 addr1_switch;
  real4 addr1_max;
  dataset(addr1_ChildRec) nulls_addr1 {MAXCOUNT(100)};
  real4 address_specificity;
  real4 address_switch;
  real4 address_max;
  dataset(address_ChildRec) nulls_address {MAXCOUNT(100)};
  real4 isContact_specificity;
  real4 isContact_switch;
  real4 isContact_max;
  dataset(isContact_ChildRec) nulls_isContact {MAXCOUNT(100)};
  real4 fname_specificity;
  real4 fname_switch;
  real4 fname_max;
  dataset(fname_ChildRec) nulls_fname {MAXCOUNT(100)};
  real4 mname_specificity;
  real4 mname_switch;
  real4 mname_max;
  dataset(mname_ChildRec) nulls_mname {MAXCOUNT(100)};
  real4 lname_specificity;
  real4 lname_switch;
  real4 lname_max;
  dataset(lname_ChildRec) nulls_lname {MAXCOUNT(100)};
  real4 name_suffix_specificity;
  real4 name_suffix_switch;
  real4 name_suffix_max;
  dataset(name_suffix_ChildRec) nulls_name_suffix {MAXCOUNT(100)};
  real4 contact_ssn_specificity;
  real4 contact_ssn_switch;
  real4 contact_ssn_max;
  dataset(contact_ssn_ChildRec) nulls_contact_ssn {MAXCOUNT(100)};
  REAL4 ForeignCorpkey_specificity;
  REAL4 ForeignCorpkey_switch;
  REAL4 ForeignCorpkey_max;
  DATASET(ForeignCorpkey_ChildRec) nulls_ForeignCorpkey {MAXCOUNT(100)};
END;
END;
