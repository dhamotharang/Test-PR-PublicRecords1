export Layout_Specificities := module
shared L := Layout_HEADER;
export SSN_ChildRec := record
  typeof(l.SSN) SSN;
  unsigned8 cnt;
  unsigned4 id;
end;
export VENDOR_ID_ChildRec := record
  typeof(l.VENDOR_ID) VENDOR_ID;
  unsigned8 cnt;
  unsigned4 id;
end;
export PHONE_ChildRec := record
  typeof(l.PHONE) PHONE;
  unsigned8 cnt;
  unsigned4 id;
end;
export LNAME_ChildRec := record
  typeof(l.LNAME) LNAME;
  unsigned8 cnt;
  unsigned4 id;
end;
export PRIM_NAME_ChildRec := record
  typeof(l.PRIM_NAME) PRIM_NAME;
  unsigned8 cnt;
  unsigned4 id;
end;
export DOB_year_ChildRec := record
  unsigned2 DOB_year;
  unsigned8 cnt;
  unsigned4 id;
end;
export DOB_month_ChildRec := record
  unsigned2 DOB_month;
  unsigned8 cnt;
  unsigned4 id;
end;
export DOB_day_ChildRec := record
  unsigned2 DOB_day;
  unsigned8 cnt;
  unsigned4 id;
end;
export PRIM_RANGE_ChildRec := record
  typeof(l.PRIM_RANGE) PRIM_RANGE;
  unsigned8 cnt;
  unsigned4 id;
end;
export SEC_RANGE_ChildRec := record
  typeof(l.SEC_RANGE) SEC_RANGE;
  unsigned8 cnt;
  unsigned4 id;
end;
export FNAME_ChildRec := record
  typeof(l.FNAME) FNAME;
  unsigned8 cnt;
  unsigned4 id;
end;
export CITY_NAME_ChildRec := record
  typeof(l.CITY_NAME) CITY_NAME;
  unsigned8 cnt;
  unsigned4 id;
end;
export MNAME_ChildRec := record
  typeof(l.MNAME) MNAME;
  unsigned8 cnt;
  unsigned4 id;
end;
export NAME_SUFFIX_ChildRec := record
  typeof(l.NAME_SUFFIX) NAME_SUFFIX;
  unsigned8 cnt;
  unsigned4 id;
end;
export ST_ChildRec := record
  typeof(l.ST) ST;
  unsigned8 cnt;
  unsigned4 id;
end;
export GENDER_ChildRec := record
  typeof(l.GENDER) GENDER;
  unsigned8 cnt;
  unsigned4 id;
end;
export FULLNAME_ChildRec := record
  unsigned4 FULLNAME;
  unsigned8 cnt;
  unsigned4 id;
end;
export LOCALE_ChildRec := record
  unsigned4 LOCALE;
  unsigned8 cnt;
  unsigned4 id;
end;
export ADDR1_ChildRec := record
  unsigned4 ADDR1;
  unsigned8 cnt;
  unsigned4 id;
end;
export R := RECORD,MAXLENGTH(32000)
 unsigned1 dummy;
  real4 SSN_specificity;
  real4 SSN_switch;
  dataset(SSN_ChildRec) nulls_SSN;
  real4 VENDOR_ID_specificity;
  real4 VENDOR_ID_switch;
  dataset(VENDOR_ID_ChildRec) nulls_VENDOR_ID;
  real4 PHONE_specificity;
  real4 PHONE_switch;
  dataset(PHONE_ChildRec) nulls_PHONE;
  real4 LNAME_specificity;
  real4 LNAME_switch;
  dataset(LNAME_ChildRec) nulls_LNAME;
  real4 PRIM_NAME_specificity;
  real4 PRIM_NAME_switch;
  dataset(PRIM_NAME_ChildRec) nulls_PRIM_NAME;
  real4 DOB_year_specificity;
  real4 DOB_year_switch;
  dataset(DOB_year_ChildRec) nulls_DOB_year;
  real4 DOB_month_specificity;
  real4 DOB_month_switch;
  dataset(DOB_month_ChildRec) nulls_DOB_month;
  real4 DOB_day_specificity;
  real4 DOB_day_switch;
  dataset(DOB_day_ChildRec) nulls_DOB_day;
  real4 PRIM_RANGE_specificity;
  real4 PRIM_RANGE_switch;
  dataset(PRIM_RANGE_ChildRec) nulls_PRIM_RANGE;
  real4 SEC_RANGE_specificity;
  real4 SEC_RANGE_switch;
  dataset(SEC_RANGE_ChildRec) nulls_SEC_RANGE;
  real4 FNAME_specificity;
  real4 FNAME_switch;
  dataset(FNAME_ChildRec) nulls_FNAME;
  real4 CITY_NAME_specificity;
  real4 CITY_NAME_switch;
  dataset(CITY_NAME_ChildRec) nulls_CITY_NAME;
  real4 MNAME_specificity;
  real4 MNAME_switch;
  dataset(MNAME_ChildRec) nulls_MNAME;
  real4 NAME_SUFFIX_specificity;
  real4 NAME_SUFFIX_switch;
  dataset(NAME_SUFFIX_ChildRec) nulls_NAME_SUFFIX;
  real4 ST_specificity;
  real4 ST_switch;
  dataset(ST_ChildRec) nulls_ST;
  real4 GENDER_specificity;
  real4 GENDER_switch;
  dataset(GENDER_ChildRec) nulls_GENDER;
  real4 FULLNAME_specificity;
  real4 FULLNAME_switch;
  dataset(FULLNAME_ChildRec) nulls_FULLNAME;
  real4 LOCALE_specificity;
  real4 LOCALE_switch;
  dataset(LOCALE_ChildRec) nulls_LOCALE;
  real4 ADDR1_specificity;
  real4 ADDR1_switch;
  dataset(ADDR1_ChildRec) nulls_ADDR1;
end;
end;
