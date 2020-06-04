IMPORT SALT30;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_EmpID;
export cname_devanitize_ChildRec := record
  typeof(l.cname_devanitize) cname_devanitize;
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
export zip_ChildRec := record
  typeof(l.zip) zip;
  unsigned8 cnt;
  unsigned4 id;
end;
export fname_ChildRec := record
  typeof(l.fname) fname;
  unsigned8 cnt;
  unsigned4 id;
end;
export lname_ChildRec := record
  typeof(l.lname) lname;
  unsigned8 cnt;
  unsigned4 id;
end;
export contact_phone_ChildRec := record
  typeof(l.contact_phone) contact_phone;
  unsigned8 cnt;
  unsigned4 id;
end;
export contact_did_ChildRec := record
  typeof(l.contact_did) contact_did;
  unsigned8 cnt;
  unsigned4 id;
end;
export contact_ssn_ChildRec := record
  typeof(l.contact_ssn) contact_ssn;
  unsigned8 cnt;
  unsigned4 id;
end;
EXPORT R := RECORD,MAXLENGTH(32000)
 UNSIGNED1 dummy;
  real4 cname_devanitize_specificity;
  real4 cname_devanitize_switch;
  real4 cname_devanitize_max;
  dataset(cname_devanitize_ChildRec) nulls_cname_devanitize {MAXCOUNT(100)};
  real4 prim_range_specificity;
  real4 prim_range_switch;
  real4 prim_range_max;
  dataset(prim_range_ChildRec) nulls_prim_range {MAXCOUNT(100)};
  real4 prim_name_specificity;
  real4 prim_name_switch;
  real4 prim_name_max;
  dataset(prim_name_ChildRec) nulls_prim_name {MAXCOUNT(100)};
  real4 zip_specificity;
  real4 zip_switch;
  real4 zip_max;
  dataset(zip_ChildRec) nulls_zip {MAXCOUNT(100)};
  real4 fname_specificity;
  real4 fname_switch;
  real4 fname_max;
  dataset(fname_ChildRec) nulls_fname {MAXCOUNT(100)};
  real4 lname_specificity;
  real4 lname_switch;
  real4 lname_max;
  dataset(lname_ChildRec) nulls_lname {MAXCOUNT(100)};
  real4 contact_phone_specificity;
  real4 contact_phone_switch;
  real4 contact_phone_max;
  dataset(contact_phone_ChildRec) nulls_contact_phone {MAXCOUNT(100)};
  real4 contact_did_specificity;
  real4 contact_did_switch;
  real4 contact_did_max;
  dataset(contact_did_ChildRec) nulls_contact_did {MAXCOUNT(100)};
  real4 contact_ssn_specificity;
  real4 contact_ssn_switch;
  real4 contact_ssn_max;
  dataset(contact_ssn_ChildRec) nulls_contact_ssn {MAXCOUNT(100)};
END;
END;
