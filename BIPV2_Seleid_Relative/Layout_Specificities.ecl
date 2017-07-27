IMPORT SALT31;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_Base;
EXPORT cnp_name_ChildRec := RECORD
  TYPEOF(l.cnp_name) cnp_name;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT company_inc_state_ChildRec := RECORD
  TYPEOF(l.company_inc_state) company_inc_state;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT company_charter_number_ChildRec := RECORD
  TYPEOF(l.company_charter_number) company_charter_number;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT company_fein_ChildRec := RECORD
  TYPEOF(l.company_fein) company_fein;
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
EXPORT postdir_ChildRec := RECORD
  TYPEOF(l.postdir) postdir;
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
EXPORT contact_ssn_ChildRec := RECORD
  TYPEOF(l.contact_ssn) contact_ssn;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT contact_phone_ChildRec := RECORD
  TYPEOF(l.contact_phone) contact_phone;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT contact_email_username_ChildRec := RECORD
  TYPEOF(l.contact_email_username) contact_email_username;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT R := RECORD,MAXLENGTH(32000)
 UNSIGNED1 dummy;
  REAL4 cnp_name_specificity;
  REAL4 cnp_name_switch;
  REAL4 cnp_name_maximum;
  DATASET(cnp_name_ChildRec) nulls_cnp_name {MAXCOUNT(100)};
  REAL4 company_inc_state_specificity;
  REAL4 company_inc_state_switch;
  REAL4 company_inc_state_maximum;
  DATASET(company_inc_state_ChildRec) nulls_company_inc_state {MAXCOUNT(100)};
  REAL4 company_charter_number_specificity;
  REAL4 company_charter_number_switch;
  REAL4 company_charter_number_maximum;
  DATASET(company_charter_number_ChildRec) nulls_company_charter_number {MAXCOUNT(100)};
  REAL4 company_fein_specificity;
  REAL4 company_fein_switch;
  REAL4 company_fein_maximum;
  DATASET(company_fein_ChildRec) nulls_company_fein {MAXCOUNT(100)};
  REAL4 prim_range_specificity;
  REAL4 prim_range_switch;
  REAL4 prim_range_maximum;
  DATASET(prim_range_ChildRec) nulls_prim_range {MAXCOUNT(100)};
  REAL4 prim_name_specificity;
  REAL4 prim_name_switch;
  REAL4 prim_name_maximum;
  DATASET(prim_name_ChildRec) nulls_prim_name {MAXCOUNT(100)};
  REAL4 postdir_specificity;
  REAL4 postdir_switch;
  REAL4 postdir_maximum;
  DATASET(postdir_ChildRec) nulls_postdir {MAXCOUNT(100)};
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
  REAL4 active_duns_number_specificity;
  REAL4 active_duns_number_switch;
  REAL4 active_duns_number_maximum;
  DATASET(active_duns_number_ChildRec) nulls_active_duns_number {MAXCOUNT(100)};
  REAL4 active_enterprise_number_specificity;
  REAL4 active_enterprise_number_switch;
  REAL4 active_enterprise_number_maximum;
  DATASET(active_enterprise_number_ChildRec) nulls_active_enterprise_number {MAXCOUNT(100)};
  REAL4 source_specificity;
  REAL4 source_switch;
  REAL4 source_maximum;
  DATASET(source_ChildRec) nulls_source {MAXCOUNT(100)};
  REAL4 source_record_id_specificity;
  REAL4 source_record_id_switch;
  REAL4 source_record_id_maximum;
  DATASET(source_record_id_ChildRec) nulls_source_record_id {MAXCOUNT(100)};
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
  REAL4 contact_ssn_specificity;
  REAL4 contact_ssn_switch;
  REAL4 contact_ssn_maximum;
  DATASET(contact_ssn_ChildRec) nulls_contact_ssn {MAXCOUNT(100)};
  REAL4 contact_phone_specificity;
  REAL4 contact_phone_switch;
  REAL4 contact_phone_maximum;
  DATASET(contact_phone_ChildRec) nulls_contact_phone {MAXCOUNT(100)};
  REAL4 contact_email_username_specificity;
  REAL4 contact_email_username_switch;
  REAL4 contact_email_username_maximum;
  DATASET(contact_email_username_ChildRec) nulls_contact_email_username {MAXCOUNT(100)};
END;
END;
