IMPORT SALT32;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_EmpID;
EXPORT orgid_ChildRec := RECORD
  TYPEOF(l.orgid) orgid;
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
  REAL4 orgid_specificity;
  REAL4 orgid_switch;
  REAL4 orgid_maximum;
  DATASET(orgid_ChildRec) nulls_orgid {MAXCOUNT(100)};
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
