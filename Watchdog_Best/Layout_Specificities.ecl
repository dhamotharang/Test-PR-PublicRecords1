IMPORT SALT311;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_Hdr;
EXPORT pflag1_ChildRec := RECORD
  TYPEOF(l.pflag1) pflag1;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT pflag2_ChildRec := RECORD
  TYPEOF(l.pflag2) pflag2;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT pflag3_ChildRec := RECORD
  TYPEOF(l.pflag3) pflag3;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT src_ChildRec := RECORD
  TYPEOF(l.src) src;
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
EXPORT dt_vendor_last_reported_ChildRec := RECORD
  TYPEOF(l.dt_vendor_last_reported) dt_vendor_last_reported;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT dt_vendor_first_reported_ChildRec := RECORD
  TYPEOF(l.dt_vendor_first_reported) dt_vendor_first_reported;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT dt_nonglb_last_seen_ChildRec := RECORD
  TYPEOF(l.dt_nonglb_last_seen) dt_nonglb_last_seen;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT rec_type_ChildRec := RECORD
  TYPEOF(l.rec_type) rec_type;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT phone_ChildRec := RECORD
  TYPEOF(l.phone) phone;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT ssn_ChildRec := RECORD
  TYPEOF(l.ssn) ssn;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT dob_ChildRec := RECORD
  TYPEOF(l.dob) dob;
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
EXPORT prim_range_ChildRec := RECORD
  TYPEOF(l.prim_range) prim_range;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT predir_ChildRec := RECORD
  TYPEOF(l.predir) predir;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT prim_name_ChildRec := RECORD
  TYPEOF(l.prim_name) prim_name;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT suffix_ChildRec := RECORD
  TYPEOF(l.suffix) suffix;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT postdir_ChildRec := RECORD
  TYPEOF(l.postdir) postdir;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT unit_desig_ChildRec := RECORD
  TYPEOF(l.unit_desig) unit_desig;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT sec_range_ChildRec := RECORD
  TYPEOF(l.sec_range) sec_range;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT city_name_ChildRec := RECORD
  TYPEOF(l.city_name) city_name;
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
EXPORT zip4_ChildRec := RECORD
  TYPEOF(l.zip4) zip4;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT tnt_ChildRec := RECORD
  TYPEOF(l.tnt) tnt;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT valid_ssn_ChildRec := RECORD
  TYPEOF(l.valid_ssn) valid_ssn;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT jflag1_ChildRec := RECORD
  TYPEOF(l.jflag1) jflag1;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT jflag2_ChildRec := RECORD
  TYPEOF(l.jflag2) jflag2;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT jflag3_ChildRec := RECORD
  TYPEOF(l.jflag3) jflag3;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT rawaid_ChildRec := RECORD
  TYPEOF(l.rawaid) rawaid;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT dodgy_tracking_ChildRec := RECORD
  TYPEOF(l.dodgy_tracking) dodgy_tracking;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT address_ind_ChildRec := RECORD
  TYPEOF(l.address_ind) address_ind;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT name_ind_ChildRec := RECORD
  TYPEOF(l.name_ind) name_ind;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT persistent_record_id_ChildRec := RECORD
  TYPEOF(l.persistent_record_id) persistent_record_id;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT ssnum_ChildRec := RECORD
  UNSIGNED4 ssnum;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT address_ChildRec := RECORD
  UNSIGNED4 address;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT Uber_ChildRec := RECORD
  SALT311.Str30Type word;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT R := RECORD,MAXLENGTH(32000)
 UNSIGNED1 dummy;
  REAL4 pflag1_specificity;
  REAL4 pflag1_switch;
  REAL4 pflag1_maximum;
  DATASET(pflag1_ChildRec) nulls_pflag1 {MAXCOUNT(100)};
  REAL4 pflag2_specificity;
  REAL4 pflag2_switch;
  REAL4 pflag2_maximum;
  DATASET(pflag2_ChildRec) nulls_pflag2 {MAXCOUNT(100)};
  REAL4 pflag3_specificity;
  REAL4 pflag3_switch;
  REAL4 pflag3_maximum;
  DATASET(pflag3_ChildRec) nulls_pflag3 {MAXCOUNT(100)};
  REAL4 src_specificity;
  REAL4 src_switch;
  REAL4 src_maximum;
  DATASET(src_ChildRec) nulls_src {MAXCOUNT(100)};
  REAL4 dt_first_seen_specificity;
  REAL4 dt_first_seen_switch;
  REAL4 dt_first_seen_maximum;
  DATASET(dt_first_seen_ChildRec) nulls_dt_first_seen {MAXCOUNT(100)};
  REAL4 dt_last_seen_specificity;
  REAL4 dt_last_seen_switch;
  REAL4 dt_last_seen_maximum;
  DATASET(dt_last_seen_ChildRec) nulls_dt_last_seen {MAXCOUNT(100)};
  REAL4 dt_vendor_last_reported_specificity;
  REAL4 dt_vendor_last_reported_switch;
  REAL4 dt_vendor_last_reported_maximum;
  DATASET(dt_vendor_last_reported_ChildRec) nulls_dt_vendor_last_reported {MAXCOUNT(100)};
  REAL4 dt_vendor_first_reported_specificity;
  REAL4 dt_vendor_first_reported_switch;
  REAL4 dt_vendor_first_reported_maximum;
  DATASET(dt_vendor_first_reported_ChildRec) nulls_dt_vendor_first_reported {MAXCOUNT(100)};
  REAL4 dt_nonglb_last_seen_specificity;
  REAL4 dt_nonglb_last_seen_switch;
  REAL4 dt_nonglb_last_seen_maximum;
  DATASET(dt_nonglb_last_seen_ChildRec) nulls_dt_nonglb_last_seen {MAXCOUNT(100)};
  REAL4 rec_type_specificity;
  REAL4 rec_type_switch;
  REAL4 rec_type_maximum;
  DATASET(rec_type_ChildRec) nulls_rec_type {MAXCOUNT(100)};
  REAL4 phone_specificity;
  REAL4 phone_switch;
  REAL4 phone_maximum;
  DATASET(phone_ChildRec) nulls_phone {MAXCOUNT(100)};
  REAL4 ssn_specificity;
  REAL4 ssn_switch;
  REAL4 ssn_maximum;
  DATASET(ssn_ChildRec) nulls_ssn {MAXCOUNT(100)};
  REAL4 dob_specificity;
  REAL4 dob_switch;
  REAL4 dob_maximum;
  DATASET(dob_ChildRec) nulls_dob {MAXCOUNT(100)};
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
  REAL4 prim_range_specificity;
  REAL4 prim_range_switch;
  REAL4 prim_range_maximum;
  DATASET(prim_range_ChildRec) nulls_prim_range {MAXCOUNT(100)};
  REAL4 predir_specificity;
  REAL4 predir_switch;
  REAL4 predir_maximum;
  DATASET(predir_ChildRec) nulls_predir {MAXCOUNT(100)};
  REAL4 prim_name_specificity;
  REAL4 prim_name_switch;
  REAL4 prim_name_maximum;
  DATASET(prim_name_ChildRec) nulls_prim_name {MAXCOUNT(100)};
  REAL4 suffix_specificity;
  REAL4 suffix_switch;
  REAL4 suffix_maximum;
  DATASET(suffix_ChildRec) nulls_suffix {MAXCOUNT(100)};
  REAL4 postdir_specificity;
  REAL4 postdir_switch;
  REAL4 postdir_maximum;
  DATASET(postdir_ChildRec) nulls_postdir {MAXCOUNT(100)};
  REAL4 unit_desig_specificity;
  REAL4 unit_desig_switch;
  REAL4 unit_desig_maximum;
  DATASET(unit_desig_ChildRec) nulls_unit_desig {MAXCOUNT(100)};
  REAL4 sec_range_specificity;
  REAL4 sec_range_switch;
  REAL4 sec_range_maximum;
  DATASET(sec_range_ChildRec) nulls_sec_range {MAXCOUNT(100)};
  REAL4 city_name_specificity;
  REAL4 city_name_switch;
  REAL4 city_name_maximum;
  DATASET(city_name_ChildRec) nulls_city_name {MAXCOUNT(100)};
  REAL4 st_specificity;
  REAL4 st_switch;
  REAL4 st_maximum;
  DATASET(st_ChildRec) nulls_st {MAXCOUNT(100)};
  REAL4 zip_specificity;
  REAL4 zip_switch;
  REAL4 zip_maximum;
  DATASET(zip_ChildRec) nulls_zip {MAXCOUNT(100)};
  REAL4 zip4_specificity;
  REAL4 zip4_switch;
  REAL4 zip4_maximum;
  DATASET(zip4_ChildRec) nulls_zip4 {MAXCOUNT(100)};
  REAL4 tnt_specificity;
  REAL4 tnt_switch;
  REAL4 tnt_maximum;
  DATASET(tnt_ChildRec) nulls_tnt {MAXCOUNT(100)};
  REAL4 valid_ssn_specificity;
  REAL4 valid_ssn_switch;
  REAL4 valid_ssn_maximum;
  DATASET(valid_ssn_ChildRec) nulls_valid_ssn {MAXCOUNT(100)};
  REAL4 jflag1_specificity;
  REAL4 jflag1_switch;
  REAL4 jflag1_maximum;
  DATASET(jflag1_ChildRec) nulls_jflag1 {MAXCOUNT(100)};
  REAL4 jflag2_specificity;
  REAL4 jflag2_switch;
  REAL4 jflag2_maximum;
  DATASET(jflag2_ChildRec) nulls_jflag2 {MAXCOUNT(100)};
  REAL4 jflag3_specificity;
  REAL4 jflag3_switch;
  REAL4 jflag3_maximum;
  DATASET(jflag3_ChildRec) nulls_jflag3 {MAXCOUNT(100)};
  REAL4 rawaid_specificity;
  REAL4 rawaid_switch;
  REAL4 rawaid_maximum;
  DATASET(rawaid_ChildRec) nulls_rawaid {MAXCOUNT(100)};
  REAL4 dodgy_tracking_specificity;
  REAL4 dodgy_tracking_switch;
  REAL4 dodgy_tracking_maximum;
  DATASET(dodgy_tracking_ChildRec) nulls_dodgy_tracking {MAXCOUNT(100)};
  REAL4 address_ind_specificity;
  REAL4 address_ind_switch;
  REAL4 address_ind_maximum;
  DATASET(address_ind_ChildRec) nulls_address_ind {MAXCOUNT(100)};
  REAL4 name_ind_specificity;
  REAL4 name_ind_switch;
  REAL4 name_ind_maximum;
  DATASET(name_ind_ChildRec) nulls_name_ind {MAXCOUNT(100)};
  REAL4 persistent_record_id_specificity;
  REAL4 persistent_record_id_switch;
  REAL4 persistent_record_id_maximum;
  DATASET(persistent_record_id_ChildRec) nulls_persistent_record_id {MAXCOUNT(100)};
  REAL4 ssnum_specificity;
  REAL4 ssnum_switch;
  REAL4 ssnum_maximum;
  DATASET(ssnum_ChildRec) nulls_ssnum {MAXCOUNT(100)};
  REAL4 address_specificity;
  REAL4 address_switch;
  REAL4 address_maximum;
  DATASET(address_ChildRec) nulls_address {MAXCOUNT(100)};
  REAL4 uber_specificity;
  REAL4 uber_switch;
  REAL4 uber_maximum;
  DATASET(Uber_ChildRec) nulls_uber {MAXCOUNT(100)};
END;
END;
