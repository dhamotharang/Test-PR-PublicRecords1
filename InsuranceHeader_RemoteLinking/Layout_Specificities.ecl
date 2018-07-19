﻿IMPORT SALT37;
EXPORT Layout_Specificities := MODULE
  SHARED L := Layout_HEADER;
  EXPORT SSN_ChildRec := RECORD
    TYPEOF(l.SSN) SSN;
    UNSIGNED8 cnt;
    UNSIGNED4 id;
  END;
  EXPORT DOB_year_ChildRec := RECORD
    UNSIGNED2 DOB_year;
    UNSIGNED8 cnt;
    UNSIGNED4 id;
  END;
  EXPORT DOB_month_ChildRec := RECORD
    UNSIGNED2 DOB_month;
    UNSIGNED8 cnt;
    UNSIGNED4 id;
  END;
  EXPORT DOB_day_ChildRec := RECORD
    UNSIGNED2 DOB_day;
    UNSIGNED8 cnt;
    UNSIGNED4 id;
  END;
  EXPORT DL_NBR_ChildRec := RECORD
    TYPEOF(l.DL_NBR) DL_NBR;
    UNSIGNED8 cnt;
    UNSIGNED4 id;
  END;
  EXPORT SNAME_ChildRec := RECORD
    TYPEOF(l.SNAME) SNAME;
    UNSIGNED8 cnt;
    UNSIGNED4 id;
  END;
  EXPORT FNAME_ChildRec := RECORD
    TYPEOF(l.FNAME) FNAME;
    UNSIGNED8 cnt;
    UNSIGNED4 id;
  END;
  EXPORT MNAME_ChildRec := RECORD
    TYPEOF(l.MNAME) MNAME;
    UNSIGNED8 cnt;
    UNSIGNED4 id;
  END;
  EXPORT LNAME_ChildRec := RECORD
    TYPEOF(l.LNAME) LNAME;
    UNSIGNED8 cnt;
    UNSIGNED4 id;
  END;
  EXPORT GENDER_ChildRec := RECORD
    TYPEOF(l.GENDER) GENDER;
    UNSIGNED8 cnt;
    UNSIGNED4 id;
  END;
  EXPORT DERIVED_GENDER_ChildRec := RECORD
    TYPEOF(l.DERIVED_GENDER) DERIVED_GENDER;
    UNSIGNED8 cnt;
    UNSIGNED4 id;
  END;
  EXPORT PRIM_NAME_ChildRec := RECORD
    TYPEOF(l.PRIM_NAME) PRIM_NAME;
    UNSIGNED8 cnt;
    UNSIGNED4 id;
  END;
  EXPORT PRIM_RANGE_ChildRec := RECORD
    TYPEOF(l.PRIM_RANGE) PRIM_RANGE;
    UNSIGNED8 cnt;
    UNSIGNED4 id;
  END;
  EXPORT SEC_RANGE_ChildRec := RECORD
    TYPEOF(l.SEC_RANGE) SEC_RANGE;
    UNSIGNED8 cnt;
    UNSIGNED4 id;
  END;
  EXPORT CITY_ChildRec := RECORD
    TYPEOF(l.CITY) CITY;
    UNSIGNED8 cnt;
    UNSIGNED4 id;
  END;
  EXPORT ST_ChildRec := RECORD
    TYPEOF(l.ST) ST;
    UNSIGNED8 cnt;
    UNSIGNED4 id;
  END;
  EXPORT ZIP_ChildRec := RECORD
    TYPEOF(l.ZIP) ZIP;
    UNSIGNED8 cnt;
    UNSIGNED4 id;
  END;
  EXPORT POLICY_NUMBER_ChildRec := RECORD
    TYPEOF(l.POLICY_NUMBER) POLICY_NUMBER;
    UNSIGNED8 cnt;
    UNSIGNED4 id;
  END;
  EXPORT CLAIM_NUMBER_ChildRec := RECORD
    TYPEOF(l.CLAIM_NUMBER) CLAIM_NUMBER;
    UNSIGNED8 cnt;
    UNSIGNED4 id;
  END;
  EXPORT DT_FIRST_SEEN_ChildRec := RECORD
    TYPEOF(l.DT_FIRST_SEEN) DT_FIRST_SEEN;
    UNSIGNED8 cnt;
    UNSIGNED4 id;
  END;
  EXPORT DT_LAST_SEEN_ChildRec := RECORD
    TYPEOF(l.DT_LAST_SEEN) DT_LAST_SEEN;
    UNSIGNED8 cnt;
    UNSIGNED4 id;
  END;
  EXPORT MAINNAME_ChildRec := RECORD
    UNSIGNED4 MAINNAME;
    UNSIGNED8 cnt;
    UNSIGNED4 id;
  END;
  EXPORT ADDR1_ChildRec := RECORD
    UNSIGNED4 ADDR1;
    UNSIGNED8 cnt;
    UNSIGNED4 id;
  END;
  EXPORT LOCALE_ChildRec := RECORD
    UNSIGNED4 LOCALE;
    UNSIGNED8 cnt;
    UNSIGNED4 id;
  END;
  EXPORT ADDRESS_ChildRec := RECORD
    UNSIGNED4 ADDRESS;
    UNSIGNED8 cnt;
    UNSIGNED4 id;
  END;
  EXPORT FULLNAME_ChildRec := RECORD
    UNSIGNED4 FULLNAME;
    UNSIGNED8 cnt;
    UNSIGNED4 id;
  END;
  EXPORT R := RECORD,MAXLENGTH(32000)
   UNSIGNED1 dummy;
    REAL4 SSN_specificity;
    REAL4 SSN_switch;
    REAL4 SSN_maximum;
    DATASET(SSN_ChildRec) nulls_SSN {MAXCOUNT(100)};
    REAL4 DOB_year_specificity;
    REAL4 DOB_year_switch;
    REAL4 DOB_year_maximum;
    DATASET(DOB_year_ChildRec) nulls_DOB_year {MAXCOUNT(100)};
    REAL4 DOB_month_specificity;
    REAL4 DOB_month_switch;
    REAL4 DOB_month_maximum;
    DATASET(DOB_month_ChildRec) nulls_DOB_month {MAXCOUNT(100)};
    REAL4 DOB_day_specificity;
    REAL4 DOB_day_switch;
    REAL4 DOB_day_maximum;
    DATASET(DOB_day_ChildRec) nulls_DOB_day {MAXCOUNT(100)};
    REAL4 DL_NBR_specificity;
    REAL4 DL_NBR_switch;
    REAL4 DL_NBR_maximum;
    DATASET(DL_NBR_ChildRec) nulls_DL_NBR {MAXCOUNT(100)};
    REAL4 SNAME_specificity;
    REAL4 SNAME_switch;
    REAL4 SNAME_maximum;
    DATASET(SNAME_ChildRec) nulls_SNAME {MAXCOUNT(100)};
    REAL4 FNAME_specificity;
    REAL4 FNAME_switch;
    REAL4 FNAME_maximum;
    DATASET(FNAME_ChildRec) nulls_FNAME {MAXCOUNT(100)};
    REAL4 MNAME_specificity;
    REAL4 MNAME_switch;
    REAL4 MNAME_maximum;
    DATASET(MNAME_ChildRec) nulls_MNAME {MAXCOUNT(100)};
    REAL4 LNAME_specificity;
    REAL4 LNAME_switch;
    REAL4 LNAME_maximum;
    DATASET(LNAME_ChildRec) nulls_LNAME {MAXCOUNT(100)};
    REAL4 GENDER_specificity;
    REAL4 GENDER_switch;
    REAL4 GENDER_maximum;
    DATASET(GENDER_ChildRec) nulls_GENDER {MAXCOUNT(100)};
    REAL4 DERIVED_GENDER_specificity;
    REAL4 DERIVED_GENDER_switch;
    REAL4 DERIVED_GENDER_maximum;
    DATASET(DERIVED_GENDER_ChildRec) nulls_DERIVED_GENDER {MAXCOUNT(100)};
    REAL4 PRIM_NAME_specificity;
    REAL4 PRIM_NAME_switch;
    REAL4 PRIM_NAME_maximum;
    DATASET(PRIM_NAME_ChildRec) nulls_PRIM_NAME {MAXCOUNT(100)};
    REAL4 PRIM_RANGE_specificity;
    REAL4 PRIM_RANGE_switch;
    REAL4 PRIM_RANGE_maximum;
    DATASET(PRIM_RANGE_ChildRec) nulls_PRIM_RANGE {MAXCOUNT(100)};
    REAL4 SEC_RANGE_specificity;
    REAL4 SEC_RANGE_switch;
    REAL4 SEC_RANGE_maximum;
    DATASET(SEC_RANGE_ChildRec) nulls_SEC_RANGE {MAXCOUNT(100)};
    REAL4 CITY_specificity;
    REAL4 CITY_switch;
    REAL4 CITY_maximum;
    DATASET(CITY_ChildRec) nulls_CITY {MAXCOUNT(100)};
    REAL4 ST_specificity;
    REAL4 ST_switch;
    REAL4 ST_maximum;
    DATASET(ST_ChildRec) nulls_ST {MAXCOUNT(100)};
    REAL4 ZIP_specificity;
    REAL4 ZIP_switch;
    REAL4 ZIP_maximum;
    DATASET(ZIP_ChildRec) nulls_ZIP {MAXCOUNT(100)};
    REAL4 POLICY_NUMBER_specificity;
    REAL4 POLICY_NUMBER_switch;
    REAL4 POLICY_NUMBER_maximum;
    DATASET(POLICY_NUMBER_ChildRec) nulls_POLICY_NUMBER {MAXCOUNT(100)};
    REAL4 CLAIM_NUMBER_specificity;
    REAL4 CLAIM_NUMBER_switch;
    REAL4 CLAIM_NUMBER_maximum;
    DATASET(CLAIM_NUMBER_ChildRec) nulls_CLAIM_NUMBER {MAXCOUNT(100)};
    REAL4 DT_FIRST_SEEN_specificity;
    REAL4 DT_FIRST_SEEN_switch;
    REAL4 DT_FIRST_SEEN_maximum;
    DATASET(DT_FIRST_SEEN_ChildRec) nulls_DT_FIRST_SEEN {MAXCOUNT(100)};
    REAL4 DT_LAST_SEEN_specificity;
    REAL4 DT_LAST_SEEN_switch;
    REAL4 DT_LAST_SEEN_maximum;
    DATASET(DT_LAST_SEEN_ChildRec) nulls_DT_LAST_SEEN {MAXCOUNT(100)};
    REAL4 MAINNAME_specificity;
    REAL4 MAINNAME_switch;
    REAL4 MAINNAME_maximum;
    DATASET(MAINNAME_ChildRec) nulls_MAINNAME {MAXCOUNT(100)};
    REAL4 ADDR1_specificity;
    REAL4 ADDR1_switch;
    REAL4 ADDR1_maximum;
    DATASET(ADDR1_ChildRec) nulls_ADDR1 {MAXCOUNT(100)};
    REAL4 LOCALE_specificity;
    REAL4 LOCALE_switch;
    REAL4 LOCALE_maximum;
    DATASET(LOCALE_ChildRec) nulls_LOCALE {MAXCOUNT(100)};
    REAL4 ADDRESS_specificity;
    REAL4 ADDRESS_switch;
    REAL4 ADDRESS_maximum;
    DATASET(ADDRESS_ChildRec) nulls_ADDRESS {MAXCOUNT(100)};
    REAL4 FULLNAME_specificity;
    REAL4 FULLNAME_switch;
    REAL4 FULLNAME_maximum;
    DATASET(FULLNAME_ChildRec) nulls_FULLNAME {MAXCOUNT(100)};
  END;
END;
