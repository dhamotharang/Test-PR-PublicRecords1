IMPORT SALT29;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_BizHead;
export empid_ChildRec := record
  typeof(l.empid) empid;
  unsigned8 cnt;
  unsigned4 id;
end;
export powid_ChildRec := record
  typeof(l.powid) powid;
  unsigned8 cnt;
  unsigned4 id;
end;
export source_ChildRec := record
  typeof(l.source) source;
  unsigned8 cnt;
  unsigned4 id;
end;
export source_record_id_ChildRec := record
  typeof(l.source_record_id) source_record_id;
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
export cnp_lowv_ChildRec := record
  typeof(l.cnp_lowv) cnp_lowv;
  unsigned8 cnt;
  unsigned4 id;
end;
export cnp_name_ChildRec := record
  typeof(l.cnp_name) cnp_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_phone_ChildRec := record
  typeof(l.company_phone) company_phone;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_fein_ChildRec := record
  typeof(l.company_fein) company_fein;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_sic_code1_ChildRec := record
  typeof(l.company_sic_code1) company_sic_code1;
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
export p_city_name_ChildRec := record
  typeof(l.p_city_name) p_city_name;
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
export company_url_ChildRec := record
  typeof(l.company_url) company_url;
  unsigned8 cnt;
  unsigned4 id;
end;
export isContact_ChildRec := record
  typeof(l.isContact) isContact;
  unsigned8 cnt;
  unsigned4 id;
end;
export title_ChildRec := record
  typeof(l.title) title;
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
export contact_email_ChildRec := record
  typeof(l.contact_email) contact_email;
  unsigned8 cnt;
  unsigned4 id;
end;
export CONTACTNAME_ChildRec := record
  UNSIGNED4 CONTACTNAME;
  unsigned8 cnt;
  unsigned4 id;
end;
export STREETADDRESS_ChildRec := record
  UNSIGNED4 STREETADDRESS;
  unsigned8 cnt;
  unsigned4 id;
end;
EXPORT R := RECORD,MAXLENGTH(32000)
 UNSIGNED1 dummy;
  real4 empid_specificity;
  real4 empid_switch;
  real4 empid_max;
  dataset(empid_ChildRec) nulls_empid {MAXCOUNT(100)};
  real4 powid_specificity;
  real4 powid_switch;
  real4 powid_max;
  dataset(powid_ChildRec) nulls_powid {MAXCOUNT(100)};
  real4 source_specificity;
  real4 source_switch;
  real4 source_max;
  dataset(source_ChildRec) nulls_source {MAXCOUNT(100)};
  real4 source_record_id_specificity;
  real4 source_record_id_switch;
  real4 source_record_id_max;
  dataset(source_record_id_ChildRec) nulls_source_record_id {MAXCOUNT(100)};
  real4 cnp_number_specificity;
  real4 cnp_number_switch;
  real4 cnp_number_max;
  dataset(cnp_number_ChildRec) nulls_cnp_number {MAXCOUNT(100)};
  real4 cnp_btype_specificity;
  real4 cnp_btype_switch;
  real4 cnp_btype_max;
  dataset(cnp_btype_ChildRec) nulls_cnp_btype {MAXCOUNT(100)};
  real4 cnp_lowv_specificity;
  real4 cnp_lowv_switch;
  real4 cnp_lowv_max;
  dataset(cnp_lowv_ChildRec) nulls_cnp_lowv {MAXCOUNT(100)};
  real4 cnp_name_specificity;
  real4 cnp_name_switch;
  real4 cnp_name_max;
  dataset(cnp_name_ChildRec) nulls_cnp_name {MAXCOUNT(100)};
  real4 company_phone_specificity;
  real4 company_phone_switch;
  real4 company_phone_max;
  dataset(company_phone_ChildRec) nulls_company_phone {MAXCOUNT(100)};
  real4 company_fein_specificity;
  real4 company_fein_switch;
  real4 company_fein_max;
  dataset(company_fein_ChildRec) nulls_company_fein {MAXCOUNT(100)};
  real4 company_sic_code1_specificity;
  real4 company_sic_code1_switch;
  real4 company_sic_code1_max;
  dataset(company_sic_code1_ChildRec) nulls_company_sic_code1 {MAXCOUNT(100)};
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
  real4 p_city_name_specificity;
  real4 p_city_name_switch;
  real4 p_city_name_max;
  dataset(p_city_name_ChildRec) nulls_p_city_name {MAXCOUNT(100)};
  real4 st_specificity;
  real4 st_switch;
  real4 st_max;
  dataset(st_ChildRec) nulls_st {MAXCOUNT(100)};
  real4 zip_specificity;
  real4 zip_switch;
  real4 zip_max;
  dataset(zip_ChildRec) nulls_zip {MAXCOUNT(100)};
  real4 company_url_specificity;
  real4 company_url_switch;
  real4 company_url_max;
  dataset(company_url_ChildRec) nulls_company_url {MAXCOUNT(100)};
  real4 isContact_specificity;
  real4 isContact_switch;
  real4 isContact_max;
  dataset(isContact_ChildRec) nulls_isContact {MAXCOUNT(100)};
  real4 title_specificity;
  real4 title_switch;
  real4 title_max;
  dataset(title_ChildRec) nulls_title {MAXCOUNT(100)};
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
  real4 contact_email_specificity;
  real4 contact_email_switch;
  real4 contact_email_max;
  dataset(contact_email_ChildRec) nulls_contact_email {MAXCOUNT(100)};
  real4 CONTACTNAME_specificity;
  real4 CONTACTNAME_switch;
  real4 CONTACTNAME_max;
  dataset(CONTACTNAME_ChildRec) nulls_CONTACTNAME {MAXCOUNT(100)};
  real4 STREETADDRESS_specificity;
  real4 STREETADDRESS_switch;
  real4 STREETADDRESS_max;
  dataset(STREETADDRESS_ChildRec) nulls_STREETADDRESS {MAXCOUNT(100)};
END;
END;
