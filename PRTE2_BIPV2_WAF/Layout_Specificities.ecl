IMPORT SALT38;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_BizHead;
EXPORT empid_ChildRec := RECORD
  TYPEOF(l.empid) empid;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT powid_ChildRec := RECORD
  TYPEOF(l.powid) powid;
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
EXPORT cnp_name_ChildRec := RECORD
  TYPEOF(l.cnp_name) cnp_name;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT company_phone_ChildRec := RECORD
  TYPEOF(l.company_phone) company_phone;
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
EXPORT p_city_name_ChildRec := RECORD
  TYPEOF(l.p_city_name) p_city_name;
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
EXPORT contact_email_ChildRec := RECORD
  TYPEOF(l.contact_email) contact_email;
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
EXPORT Uber_ChildRec := RECORD
  SALT38.Str30Type word;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT R := RECORD,MAXLENGTH(32000)
 UNSIGNED1 dummy;
  REAL4 empid_specificity;
  REAL4 empid_switch;
  REAL4 empid_maximum;
  DATASET(empid_ChildRec) nulls_empid {MAXCOUNT(100)};
  REAL4 powid_specificity;
  REAL4 powid_switch;
  REAL4 powid_maximum;
  DATASET(powid_ChildRec) nulls_powid {MAXCOUNT(100)};
  REAL4 source_specificity;
  REAL4 source_switch;
  REAL4 source_maximum;
  DATASET(source_ChildRec) nulls_source {MAXCOUNT(100)};
  REAL4 source_record_id_specificity;
  REAL4 source_record_id_switch;
  REAL4 source_record_id_maximum;
  DATASET(source_record_id_ChildRec) nulls_source_record_id {MAXCOUNT(100)};
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
  REAL4 cnp_name_specificity;
  REAL4 cnp_name_switch;
  REAL4 cnp_name_maximum;
  DATASET(cnp_name_ChildRec) nulls_cnp_name {MAXCOUNT(100)};
  REAL4 company_phone_specificity;
  REAL4 company_phone_switch;
  REAL4 company_phone_maximum;
  DATASET(company_phone_ChildRec) nulls_company_phone {MAXCOUNT(100)};
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
  REAL4 p_city_name_specificity;
  REAL4 p_city_name_switch;
  REAL4 p_city_name_maximum;
  DATASET(p_city_name_ChildRec) nulls_p_city_name {MAXCOUNT(100)};
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
  REAL4 title_specificity;
  REAL4 title_switch;
  REAL4 title_maximum;
  DATASET(title_ChildRec) nulls_title {MAXCOUNT(100)};
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
  REAL4 contact_email_specificity;
  REAL4 contact_email_switch;
  REAL4 contact_email_maximum;
  DATASET(contact_email_ChildRec) nulls_contact_email {MAXCOUNT(100)};
  REAL4 CONTACTNAME_specificity;
  REAL4 CONTACTNAME_switch;
  REAL4 CONTACTNAME_maximum;
  DATASET(CONTACTNAME_ChildRec) nulls_CONTACTNAME {MAXCOUNT(100)};
  REAL4 STREETADDRESS_specificity;
  REAL4 STREETADDRESS_switch;
  REAL4 STREETADDRESS_maximum;
  DATASET(STREETADDRESS_ChildRec) nulls_STREETADDRESS {MAXCOUNT(100)};
  REAL4 uber_specificity;
  REAL4 uber_switch;
  REAL4 uber_maximum;
  DATASET(Uber_ChildRec) nulls_uber {MAXCOUNT(100)};
END;
END;
