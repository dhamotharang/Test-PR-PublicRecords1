export Layout_Specificities := module
shared L := Layout_PersonHeader;
export NAME_SUFFIX_ChildRec := record
  typeof(l.NAME_SUFFIX) NAME_SUFFIX;
  unsigned8 cnt;
  unsigned4 id;
end;
export FNAME_ChildRec := record
  typeof(l.FNAME) FNAME;
  unsigned8 cnt;
  unsigned4 id;
end;
export MNAME_ChildRec := record
  typeof(l.MNAME) MNAME;
  unsigned8 cnt;
  unsigned4 id;
end;
export LNAME_ChildRec := record
  typeof(l.LNAME) LNAME;
  unsigned8 cnt;
  unsigned4 id;
end;
export PRIM_RANGE_ChildRec := record
  typeof(l.PRIM_RANGE) PRIM_RANGE;
  unsigned8 cnt;
  unsigned4 id;
end;
export PRIM_NAME_ChildRec := record
  typeof(l.PRIM_NAME) PRIM_NAME;
  unsigned8 cnt;
  unsigned4 id;
end;
export SEC_RANGE_ChildRec := record
  typeof(l.SEC_RANGE) SEC_RANGE;
  unsigned8 cnt;
  unsigned4 id;
end;
export CITY_ChildRec := record
  typeof(l.CITY) CITY;
  unsigned8 cnt;
  unsigned4 id;
end;
export STATE_ChildRec := record
  typeof(l.STATE) STATE;
  unsigned8 cnt;
  unsigned4 id;
end;
export ZIP_ChildRec := record
  typeof(l.ZIP) ZIP;
  unsigned8 cnt;
  unsigned4 id;
end;
export ZIP4_ChildRec := record
  typeof(l.ZIP4) ZIP4;
  unsigned8 cnt;
  unsigned4 id;
end;
export COUNTY_ChildRec := record
  typeof(l.COUNTY) COUNTY;
  unsigned8 cnt;
  unsigned4 id;
end;
export SSN5_ChildRec := record
  typeof(l.SSN5) SSN5;
  unsigned8 cnt;
  unsigned4 id;
end;
export SSN4_ChildRec := record
  typeof(l.SSN4) SSN4;
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
export PHONE_ChildRec := record
  typeof(l.PHONE) PHONE;
  unsigned8 cnt;
  unsigned4 id;
end;
export MAINNAME_ChildRec := record
  unsigned4 MAINNAME;
  unsigned8 cnt;
  unsigned4 id;
end;
export FULLNAME_ChildRec := record
  unsigned4 FULLNAME;
  unsigned8 cnt;
  unsigned4 id;
end;
export ADDR1_ChildRec := record
  unsigned4 ADDR1;
  unsigned8 cnt;
  unsigned4 id;
end;
export LOCALE_ChildRec := record
  unsigned4 LOCALE;
  unsigned8 cnt;
  unsigned4 id;
end;
export ADDRS_ChildRec := record
  unsigned4 ADDRS;
  unsigned8 cnt;
  unsigned4 id;
end;
export R := RECORD,MAXLENGTH(32000)
 unsigned1 dummy;
  real4 NAME_SUFFIX_specificity;
  real4 NAME_SUFFIX_switch;
  real4 NAME_SUFFIX_max;
  dataset(NAME_SUFFIX_ChildRec) nulls_NAME_SUFFIX {MAXCOUNT(100)};
  real4 FNAME_specificity;
  real4 FNAME_switch;
  real4 FNAME_max;
  dataset(FNAME_ChildRec) nulls_FNAME {MAXCOUNT(100)};
  real4 MNAME_specificity;
  real4 MNAME_switch;
  real4 MNAME_max;
  dataset(MNAME_ChildRec) nulls_MNAME {MAXCOUNT(100)};
  real4 LNAME_specificity;
  real4 LNAME_switch;
  real4 LNAME_max;
  dataset(LNAME_ChildRec) nulls_LNAME {MAXCOUNT(100)};
  real4 PRIM_RANGE_specificity;
  real4 PRIM_RANGE_switch;
  real4 PRIM_RANGE_max;
  dataset(PRIM_RANGE_ChildRec) nulls_PRIM_RANGE {MAXCOUNT(100)};
  real4 PRIM_NAME_specificity;
  real4 PRIM_NAME_switch;
  real4 PRIM_NAME_max;
  dataset(PRIM_NAME_ChildRec) nulls_PRIM_NAME {MAXCOUNT(100)};
  real4 SEC_RANGE_specificity;
  real4 SEC_RANGE_switch;
  real4 SEC_RANGE_max;
  dataset(SEC_RANGE_ChildRec) nulls_SEC_RANGE {MAXCOUNT(100)};
  real4 CITY_specificity;
  real4 CITY_switch;
  real4 CITY_max;
  dataset(CITY_ChildRec) nulls_CITY {MAXCOUNT(100)};
  real4 STATE_specificity;
  real4 STATE_switch;
  real4 STATE_max;
  dataset(STATE_ChildRec) nulls_STATE {MAXCOUNT(100)};
  real4 ZIP_specificity;
  real4 ZIP_switch;
  real4 ZIP_max;
  dataset(ZIP_ChildRec) nulls_ZIP {MAXCOUNT(100)};
  real4 ZIP4_specificity;
  real4 ZIP4_switch;
  real4 ZIP4_max;
  dataset(ZIP4_ChildRec) nulls_ZIP4 {MAXCOUNT(100)};
  real4 COUNTY_specificity;
  real4 COUNTY_switch;
  real4 COUNTY_max;
  dataset(COUNTY_ChildRec) nulls_COUNTY {MAXCOUNT(100)};
  real4 SSN5_specificity;
  real4 SSN5_switch;
  real4 SSN5_max;
  dataset(SSN5_ChildRec) nulls_SSN5 {MAXCOUNT(100)};
  real4 SSN4_specificity;
  real4 SSN4_switch;
  real4 SSN4_max;
  dataset(SSN4_ChildRec) nulls_SSN4 {MAXCOUNT(100)};
  real4 DOB_year_specificity;
  real4 DOB_year_switch;
  real4 DOB_year_max;
  dataset(DOB_year_ChildRec) nulls_DOB_year {MAXCOUNT(100)};
  real4 DOB_month_specificity;
  real4 DOB_month_switch;
  real4 DOB_month_max;
  dataset(DOB_month_ChildRec) nulls_DOB_month {MAXCOUNT(100)};
  real4 DOB_day_specificity;
  real4 DOB_day_switch;
  real4 DOB_day_max;
  dataset(DOB_day_ChildRec) nulls_DOB_day {MAXCOUNT(100)};
  real4 PHONE_specificity;
  real4 PHONE_switch;
  real4 PHONE_max;
  dataset(PHONE_ChildRec) nulls_PHONE {MAXCOUNT(100)};
  real4 MAINNAME_specificity;
  real4 MAINNAME_switch;
  real4 MAINNAME_max;
  dataset(MAINNAME_ChildRec) nulls_MAINNAME {MAXCOUNT(100)};
  real4 FULLNAME_specificity;
  real4 FULLNAME_switch;
  real4 FULLNAME_max;
  dataset(FULLNAME_ChildRec) nulls_FULLNAME {MAXCOUNT(100)};
  real4 ADDR1_specificity;
  real4 ADDR1_switch;
  real4 ADDR1_max;
  dataset(ADDR1_ChildRec) nulls_ADDR1 {MAXCOUNT(100)};
  real4 LOCALE_specificity;
  real4 LOCALE_switch;
  real4 LOCALE_max;
  dataset(LOCALE_ChildRec) nulls_LOCALE {MAXCOUNT(100)};
  real4 ADDRS_specificity;
  real4 ADDRS_switch;
  real4 ADDRS_max;
  dataset(ADDRS_ChildRec) nulls_ADDRS {MAXCOUNT(100)};
end;
end;
