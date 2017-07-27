IMPORT SALT32;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_EmpID;
EXPORT cname_devanitize_ChildRec := RECORD
  TYPEOF(l.cname_devanitize) cname_devanitize;
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
EXPORT zip_ChildRec := RECORD
  TYPEOF(l.zip) zip;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT fname_ChildRec := RECORD
  TYPEOF(l.fname) fname;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT lname_ChildRec := RECORD
  TYPEOF(l.lname) lname;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT contact_phone_ChildRec := RECORD
  TYPEOF(l.contact_phone) contact_phone;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT contact_did_ChildRec := RECORD
  TYPEOF(l.contact_did) contact_did;
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
EXPORT R := RECORD,MAXLENGTH(32000)
 UNSIGNED1 dummy;
  REAL4 cname_devanitize_specificity;
  REAL4 cname_devanitize_switch;
  REAL4 cname_devanitize_maximum;
  DATASET(cname_devanitize_ChildRec) nulls_cname_devanitize {MAXCOUNT(100)};
  REAL4 prim_range_specificity;
  REAL4 prim_range_switch;
  REAL4 prim_range_maximum;
  DATASET(prim_range_ChildRec) nulls_prim_range {MAXCOUNT(100)};
  REAL4 prim_name_specificity;
  REAL4 prim_name_switch;
  REAL4 prim_name_maximum;
  DATASET(prim_name_ChildRec) nulls_prim_name {MAXCOUNT(100)};
  REAL4 zip_specificity;
  REAL4 zip_switch;
  REAL4 zip_maximum;
  DATASET(zip_ChildRec) nulls_zip {MAXCOUNT(100)};
  REAL4 fname_specificity;
  REAL4 fname_switch;
  REAL4 fname_maximum;
  DATASET(fname_ChildRec) nulls_fname {MAXCOUNT(100)};
  REAL4 lname_specificity;
  REAL4 lname_switch;
  REAL4 lname_maximum;
  DATASET(lname_ChildRec) nulls_lname {MAXCOUNT(100)};
  REAL4 contact_phone_specificity;
  REAL4 contact_phone_switch;
  REAL4 contact_phone_maximum;
  DATASET(contact_phone_ChildRec) nulls_contact_phone {MAXCOUNT(100)};
  REAL4 contact_did_specificity;
  REAL4 contact_did_switch;
  REAL4 contact_did_maximum;
  DATASET(contact_did_ChildRec) nulls_contact_did {MAXCOUNT(100)};
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
END;
END;
