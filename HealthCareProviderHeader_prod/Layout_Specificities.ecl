IMPORT SALT27;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_HealthProvider;
export DOB_year_ChildRec := record
UNSIGNED2 DOB_year;
unsigned8 cnt;
unsigned4 id;
end;
export DOB_month_ChildRec := record
UNSIGNED2 DOB_month;
unsigned8 cnt;
unsigned4 id;
end;
export DOB_day_ChildRec := record
UNSIGNED2 DOB_day;
unsigned8 cnt;
unsigned4 id;
end;
export SNAME_ChildRec := record
typeof(l.SNAME) SNAME;
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
export GENDER_ChildRec := record
typeof(l.GENDER) GENDER;
unsigned8 cnt;
unsigned4 id;
end;
export LIC_NBR_ChildRec := record
typeof(l.LIC_NBR) LIC_NBR;
unsigned8 cnt;
unsigned4 id;
end;
export PRIM_NAME_ChildRec := record
typeof(l.PRIM_NAME) PRIM_NAME;
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
export V_CITY_NAME_ChildRec := record
typeof(l.V_CITY_NAME) V_CITY_NAME;
unsigned8 cnt;
unsigned4 id;
end;
export ST_ChildRec := record
typeof(l.ST) ST;
unsigned8 cnt;
unsigned4 id;
end;
export ZIP_ChildRec := record
typeof(l.ZIP) ZIP;
unsigned8 cnt;
unsigned4 id;
end;
export NPI_NUMBER_ChildRec := record
typeof(l.NPI_NUMBER) NPI_NUMBER;
unsigned8 cnt;
unsigned4 id;
end;
export DEA_NUMBER_ChildRec := record
typeof(l.DEA_NUMBER) DEA_NUMBER;
unsigned8 cnt;
unsigned4 id;
end;
export VENDOR_ID_ChildRec := record
typeof(l.VENDOR_ID) VENDOR_ID;
unsigned8 cnt;
unsigned4 id;
end;
export TAX_ID_ChildRec := record
typeof(l.TAX_ID) TAX_ID;
unsigned8 cnt;
unsigned4 id;
end;
export DID_ChildRec := record
typeof(l.DID) DID;
unsigned8 cnt;
unsigned4 id;
end;
export UPIN_ChildRec := record
typeof(l.UPIN) UPIN;
unsigned8 cnt;
unsigned4 id;
end;
export MAINNAME_ChildRec := record
UNSIGNED4 MAINNAME;
unsigned8 cnt;
unsigned4 id;
end;
export FULLNAME_ChildRec := record
UNSIGNED4 FULLNAME;
unsigned8 cnt;
unsigned4 id;
end;
export LAT_LONG_ChildRec := record
STRING20 LAT_LONG;
unsigned8 cnt;
unsigned4 id;
end;
export ADDR_ChildRec := record
UNSIGNED4 ADDR;
unsigned8 cnt;
unsigned4 id;
end;
export LOCALE_ChildRec := record
UNSIGNED4 LOCALE;
unsigned8 cnt;
unsigned4 id;
end;
export ADDRESS_ChildRec := record
UNSIGNED4 ADDRESS;
unsigned8 cnt;
unsigned4 id;
end;
EXPORT R := RECORD,MAXLENGTH(32000)
UNSIGNED1 dummy;
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
real4 SNAME_specificity;
real4 SNAME_switch;
real4 SNAME_max;
dataset(SNAME_ChildRec) nulls_SNAME {MAXCOUNT(100)};
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
real4 GENDER_specificity;
real4 GENDER_switch;
real4 GENDER_max;
dataset(GENDER_ChildRec) nulls_GENDER {MAXCOUNT(100)};
real4 LIC_NBR_specificity;
real4 LIC_NBR_switch;
real4 LIC_NBR_max;
dataset(LIC_NBR_ChildRec) nulls_LIC_NBR {MAXCOUNT(100)};
real4 PRIM_NAME_specificity;
real4 PRIM_NAME_switch;
real4 PRIM_NAME_max;
dataset(PRIM_NAME_ChildRec) nulls_PRIM_NAME {MAXCOUNT(100)};
real4 PRIM_RANGE_specificity;
real4 PRIM_RANGE_switch;
real4 PRIM_RANGE_max;
dataset(PRIM_RANGE_ChildRec) nulls_PRIM_RANGE {MAXCOUNT(100)};
real4 SEC_RANGE_specificity;
real4 SEC_RANGE_switch;
real4 SEC_RANGE_max;
dataset(SEC_RANGE_ChildRec) nulls_SEC_RANGE {MAXCOUNT(100)};
real4 V_CITY_NAME_specificity;
real4 V_CITY_NAME_switch;
real4 V_CITY_NAME_max;
dataset(V_CITY_NAME_ChildRec) nulls_V_CITY_NAME {MAXCOUNT(100)};
real4 ST_specificity;
real4 ST_switch;
real4 ST_max;
dataset(ST_ChildRec) nulls_ST {MAXCOUNT(100)};
real4 ZIP_specificity;
real4 ZIP_switch;
real4 ZIP_max;
dataset(ZIP_ChildRec) nulls_ZIP {MAXCOUNT(100)};
real4 NPI_NUMBER_specificity;
real4 NPI_NUMBER_switch;
real4 NPI_NUMBER_max;
dataset(NPI_NUMBER_ChildRec) nulls_NPI_NUMBER {MAXCOUNT(100)};
real4 DEA_NUMBER_specificity;
real4 DEA_NUMBER_switch;
real4 DEA_NUMBER_max;
dataset(DEA_NUMBER_ChildRec) nulls_DEA_NUMBER {MAXCOUNT(100)};
real4 VENDOR_ID_specificity;
real4 VENDOR_ID_switch;
real4 VENDOR_ID_max;
dataset(VENDOR_ID_ChildRec) nulls_VENDOR_ID {MAXCOUNT(100)};
real4 TAX_ID_specificity;
real4 TAX_ID_switch;
real4 TAX_ID_max;
dataset(TAX_ID_ChildRec) nulls_TAX_ID {MAXCOUNT(100)};
real4 DID_specificity;
real4 DID_switch;
real4 DID_max;
dataset(DID_ChildRec) nulls_DID {MAXCOUNT(100)};
real4 UPIN_specificity;
real4 UPIN_switch;
real4 UPIN_max;
dataset(UPIN_ChildRec) nulls_UPIN {MAXCOUNT(100)};
real4 MAINNAME_specificity;
real4 MAINNAME_switch;
real4 MAINNAME_max;
dataset(MAINNAME_ChildRec) nulls_MAINNAME {MAXCOUNT(100)};
real4 FULLNAME_specificity;
real4 FULLNAME_switch;
real4 FULLNAME_max;
dataset(FULLNAME_ChildRec) nulls_FULLNAME {MAXCOUNT(100)};
real4 LAT_LONG_specificity;
real4 LAT_LONG_switch;
real4 LAT_LONG_max;
dataset(LAT_LONG_ChildRec) nulls_LAT_LONG {MAXCOUNT(100)};
real4 ADDR_specificity;
real4 ADDR_switch;
real4 ADDR_max;
dataset(ADDR_ChildRec) nulls_ADDR {MAXCOUNT(100)};
real4 LOCALE_specificity;
real4 LOCALE_switch;
real4 LOCALE_max;
dataset(LOCALE_ChildRec) nulls_LOCALE {MAXCOUNT(100)};
real4 ADDRESS_specificity;
real4 ADDRESS_switch;
real4 ADDRESS_max;
dataset(ADDRESS_ChildRec) nulls_ADDRESS {MAXCOUNT(100)};
END;
END;
