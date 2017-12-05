IMPORT SALT37;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_BizHead;
EXPORT parent_proxid_ChildRec := RECORD
  TYPEOF(l.parent_proxid) parent_proxid;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT sele_proxid_ChildRec := RECORD
  TYPEOF(l.sele_proxid) sele_proxid;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT org_proxid_ChildRec := RECORD
  TYPEOF(l.org_proxid) org_proxid;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT ultimate_proxid_ChildRec := RECORD
  TYPEOF(l.ultimate_proxid) ultimate_proxid;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT source_ChildRec := RECORD
  TYPEOF(l.source) source;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT source_record_id_ChildRec := RECORD
  TYPEOF(l.source_record_id) source_record_id;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT company_name_ChildRec := RECORD
  TYPEOF(l.company_name) company_name;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT company_name_prefix_ChildRec := RECORD
  TYPEOF(l.company_name_prefix) company_name_prefix;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cnp_name_ChildRec := RECORD
  TYPEOF(l.cnp_name) cnp_name;
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
EXPORT cnp_lowv_ChildRec := RECORD
  TYPEOF(l.cnp_lowv) cnp_lowv;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT company_phone_3_ChildRec := RECORD
  TYPEOF(l.company_phone_3) company_phone_3;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT company_phone_3_ex_ChildRec := RECORD
  TYPEOF(l.company_phone_3_ex) company_phone_3_ex;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT company_phone_7_ChildRec := RECORD
  TYPEOF(l.company_phone_7) company_phone_7;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT company_fein_ChildRec := RECORD
  TYPEOF(l.company_fein) company_fein;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT company_sic_code1_ChildRec := RECORD
  TYPEOF(l.company_sic_code1) company_sic_code1;
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
EXPORT city_ChildRec := RECORD
  TYPEOF(l.city) city;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT city_clean_ChildRec := RECORD
  TYPEOF(l.city_clean) city_clean;
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
EXPORT company_url_ChildRec := RECORD
  TYPEOF(l.company_url) company_url;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT isContact_ChildRec := RECORD
  TYPEOF(l.isContact) isContact;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT contact_did_ChildRec := RECORD
  TYPEOF(l.contact_did) contact_did;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT title_ChildRec := RECORD
  TYPEOF(l.title) title;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT fname_ChildRec := RECORD
  TYPEOF(l.fname) fname;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT fname_preferred_ChildRec := RECORD
  TYPEOF(l.fname_preferred) fname_preferred;
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
EXPORT contact_email_ChildRec := RECORD
  TYPEOF(l.contact_email) contact_email;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT sele_flag_ChildRec := RECORD
  TYPEOF(l.sele_flag) sele_flag;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT org_flag_ChildRec := RECORD
  TYPEOF(l.org_flag) org_flag;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT ult_flag_ChildRec := RECORD
  TYPEOF(l.ult_flag) ult_flag;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT fallback_value_ChildRec := RECORD
  TYPEOF(l.fallback_value) fallback_value;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT CONTACTNAME_ChildRec := RECORD
  UNSIGNED4 CONTACTNAME;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT STREETADDRESS_ChildRec := RECORD
  UNSIGNED4 STREETADDRESS;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT R := RECORD,MAXLENGTH(32000)
 UNSIGNED1 dummy;
  REAL4 parent_proxid_specificity;
  REAL4 parent_proxid_switch;
  REAL4 parent_proxid_maximum;
  DATASET(parent_proxid_ChildRec) nulls_parent_proxid {MAXCOUNT(100)};
  REAL4 sele_proxid_specificity;
  REAL4 sele_proxid_switch;
  REAL4 sele_proxid_maximum;
  DATASET(sele_proxid_ChildRec) nulls_sele_proxid {MAXCOUNT(100)};
  REAL4 org_proxid_specificity;
  REAL4 org_proxid_switch;
  REAL4 org_proxid_maximum;
  DATASET(org_proxid_ChildRec) nulls_org_proxid {MAXCOUNT(100)};
  REAL4 ultimate_proxid_specificity;
  REAL4 ultimate_proxid_switch;
  REAL4 ultimate_proxid_maximum;
  DATASET(ultimate_proxid_ChildRec) nulls_ultimate_proxid {MAXCOUNT(100)};
  REAL4 source_specificity;
  REAL4 source_switch;
  REAL4 source_maximum;
  DATASET(source_ChildRec) nulls_source {MAXCOUNT(100)};
  REAL4 source_record_id_specificity;
  REAL4 source_record_id_switch;
  REAL4 source_record_id_maximum;
  DATASET(source_record_id_ChildRec) nulls_source_record_id {MAXCOUNT(100)};
  REAL4 company_name_specificity;
  REAL4 company_name_switch;
  REAL4 company_name_maximum;
  DATASET(company_name_ChildRec) nulls_company_name {MAXCOUNT(100)};
  REAL4 company_name_prefix_specificity;
  REAL4 company_name_prefix_switch;
  REAL4 company_name_prefix_maximum;
  DATASET(company_name_prefix_ChildRec) nulls_company_name_prefix {MAXCOUNT(100)};
  REAL4 cnp_name_specificity;
  REAL4 cnp_name_switch;
  REAL4 cnp_name_maximum;
  DATASET(cnp_name_ChildRec) nulls_cnp_name {MAXCOUNT(100)};
  REAL4 cnp_number_specificity;
  REAL4 cnp_number_switch;
  REAL4 cnp_number_maximum;
  DATASET(cnp_number_ChildRec) nulls_cnp_number {MAXCOUNT(100)};
  REAL4 cnp_btype_specificity;
  REAL4 cnp_btype_switch;
  REAL4 cnp_btype_maximum;
  DATASET(cnp_btype_ChildRec) nulls_cnp_btype {MAXCOUNT(100)};
  REAL4 cnp_lowv_specificity;
  REAL4 cnp_lowv_switch;
  REAL4 cnp_lowv_maximum;
  DATASET(cnp_lowv_ChildRec) nulls_cnp_lowv {MAXCOUNT(100)};
  REAL4 company_phone_3_specificity;
  REAL4 company_phone_3_switch;
  REAL4 company_phone_3_maximum;
  DATASET(company_phone_3_ChildRec) nulls_company_phone_3 {MAXCOUNT(100)};
  REAL4 company_phone_3_ex_specificity;
  REAL4 company_phone_3_ex_switch;
  REAL4 company_phone_3_ex_maximum;
  DATASET(company_phone_3_ex_ChildRec) nulls_company_phone_3_ex {MAXCOUNT(100)};
  REAL4 company_phone_7_specificity;
  REAL4 company_phone_7_switch;
  REAL4 company_phone_7_maximum;
  DATASET(company_phone_7_ChildRec) nulls_company_phone_7 {MAXCOUNT(100)};
  REAL4 company_fein_specificity;
  REAL4 company_fein_switch;
  REAL4 company_fein_maximum;
  DATASET(company_fein_ChildRec) nulls_company_fein {MAXCOUNT(100)};
  REAL4 company_sic_code1_specificity;
  REAL4 company_sic_code1_switch;
  REAL4 company_sic_code1_maximum;
  DATASET(company_sic_code1_ChildRec) nulls_company_sic_code1 {MAXCOUNT(100)};
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
  REAL4 city_specificity;
  REAL4 city_switch;
  REAL4 city_maximum;
  DATASET(city_ChildRec) nulls_city {MAXCOUNT(100)};
  REAL4 city_clean_specificity;
  REAL4 city_clean_switch;
  REAL4 city_clean_maximum;
  DATASET(city_clean_ChildRec) nulls_city_clean {MAXCOUNT(100)};
  REAL4 st_specificity;
  REAL4 st_switch;
  REAL4 st_maximum;
  DATASET(st_ChildRec) nulls_st {MAXCOUNT(100)};
  REAL4 zip_specificity;
  REAL4 zip_switch;
  REAL4 zip_maximum;
  DATASET(zip_ChildRec) nulls_zip {MAXCOUNT(100)};
  REAL4 company_url_specificity;
  REAL4 company_url_switch;
  REAL4 company_url_maximum;
  DATASET(company_url_ChildRec) nulls_company_url {MAXCOUNT(100)};
  REAL4 isContact_specificity;
  REAL4 isContact_switch;
  REAL4 isContact_maximum;
  DATASET(isContact_ChildRec) nulls_isContact {MAXCOUNT(100)};
  REAL4 contact_did_specificity;
  REAL4 contact_did_switch;
  REAL4 contact_did_maximum;
  DATASET(contact_did_ChildRec) nulls_contact_did {MAXCOUNT(100)};
  REAL4 title_specificity;
  REAL4 title_switch;
  REAL4 title_maximum;
  DATASET(title_ChildRec) nulls_title {MAXCOUNT(100)};
  REAL4 fname_specificity;
  REAL4 fname_switch;
  REAL4 fname_maximum;
  DATASET(fname_ChildRec) nulls_fname {MAXCOUNT(100)};
  REAL4 fname_preferred_specificity;
  REAL4 fname_preferred_switch;
  REAL4 fname_preferred_maximum;
  DATASET(fname_preferred_ChildRec) nulls_fname_preferred {MAXCOUNT(100)};
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
  REAL4 contact_email_specificity;
  REAL4 contact_email_switch;
  REAL4 contact_email_maximum;
  DATASET(contact_email_ChildRec) nulls_contact_email {MAXCOUNT(100)};
  REAL4 sele_flag_specificity;
  REAL4 sele_flag_switch;
  REAL4 sele_flag_maximum;
  DATASET(sele_flag_ChildRec) nulls_sele_flag {MAXCOUNT(100)};
  REAL4 org_flag_specificity;
  REAL4 org_flag_switch;
  REAL4 org_flag_maximum;
  DATASET(org_flag_ChildRec) nulls_org_flag {MAXCOUNT(100)};
  REAL4 ult_flag_specificity;
  REAL4 ult_flag_switch;
  REAL4 ult_flag_maximum;
  DATASET(ult_flag_ChildRec) nulls_ult_flag {MAXCOUNT(100)};
  REAL4 fallback_value_specificity;
  REAL4 fallback_value_switch;
  REAL4 fallback_value_maximum;
  DATASET(fallback_value_ChildRec) nulls_fallback_value {MAXCOUNT(100)};
  REAL4 CONTACTNAME_specificity;
  REAL4 CONTACTNAME_switch;
  REAL4 CONTACTNAME_maximum;
  DATASET(CONTACTNAME_ChildRec) nulls_CONTACTNAME {MAXCOUNT(100)};
  REAL4 STREETADDRESS_specificity;
  REAL4 STREETADDRESS_switch;
  REAL4 STREETADDRESS_maximum;
  DATASET(STREETADDRESS_ChildRec) nulls_STREETADDRESS {MAXCOUNT(100)};
END;
END;
