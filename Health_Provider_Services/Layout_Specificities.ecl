﻿IMPORT SALT311;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_HealthProvider;
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
EXPORT SNAME_ChildRec := RECORD
  TYPEOF(l.SNAME) SNAME;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT GENDER_ChildRec := RECORD
  TYPEOF(l.GENDER) GENDER;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT PRIM_RANGE_ChildRec := RECORD
  TYPEOF(l.PRIM_RANGE) PRIM_RANGE;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT PRIM_NAME_ChildRec := RECORD
  TYPEOF(l.PRIM_NAME) PRIM_NAME;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT SEC_RANGE_ChildRec := RECORD
  TYPEOF(l.SEC_RANGE) SEC_RANGE;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT V_CITY_NAME_ChildRec := RECORD
  TYPEOF(l.V_CITY_NAME) V_CITY_NAME;
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
EXPORT SSN_ChildRec := RECORD
  TYPEOF(l.SSN) SSN;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT CNSMR_SSN_ChildRec := RECORD
  TYPEOF(l.CNSMR_SSN) CNSMR_SSN;
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
EXPORT CNSMR_DOB_year_ChildRec := RECORD
  UNSIGNED2 CNSMR_DOB_year;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT CNSMR_DOB_month_ChildRec := RECORD
  UNSIGNED2 CNSMR_DOB_month;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT CNSMR_DOB_day_ChildRec := RECORD
  UNSIGNED2 CNSMR_DOB_day;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT PHONE_ChildRec := RECORD
  TYPEOF(l.PHONE) PHONE;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT LIC_STATE_ChildRec := RECORD
  TYPEOF(l.LIC_STATE) LIC_STATE;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT C_LIC_NBR_ChildRec := RECORD
  TYPEOF(l.C_LIC_NBR) C_LIC_NBR;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT TAX_ID_ChildRec := RECORD
  TYPEOF(l.TAX_ID) TAX_ID;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT BILLING_TAX_ID_ChildRec := RECORD
  TYPEOF(l.BILLING_TAX_ID) BILLING_TAX_ID;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT DEA_NUMBER_ChildRec := RECORD
  TYPEOF(l.DEA_NUMBER) DEA_NUMBER;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT VENDOR_ID_ChildRec := RECORD
  TYPEOF(l.VENDOR_ID) VENDOR_ID;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT NPI_NUMBER_ChildRec := RECORD
  TYPEOF(l.NPI_NUMBER) NPI_NUMBER;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT BILLING_NPI_NUMBER_ChildRec := RECORD
  TYPEOF(l.BILLING_NPI_NUMBER) BILLING_NPI_NUMBER;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT UPIN_ChildRec := RECORD
  TYPEOF(l.UPIN) UPIN;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT DID_ChildRec := RECORD
  TYPEOF(l.DID) DID;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT BDID_ChildRec := RECORD
  TYPEOF(l.BDID) BDID;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT SRC_ChildRec := RECORD
  TYPEOF(l.SRC) SRC;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT SOURCE_RID_ChildRec := RECORD
  TYPEOF(l.SOURCE_RID) SOURCE_RID;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT RID_ChildRec := RECORD
  TYPEOF(l.RID) RID;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT MAINNAME_ChildRec := RECORD
  UNSIGNED4 MAINNAME;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT FULLNAME_ChildRec := RECORD
  UNSIGNED4 FULLNAME;
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
EXPORT Uber_ChildRec := RECORD
  SALT311.Str30Type word;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT R := RECORD,MAXLENGTH(32000)
 UNSIGNED1 dummy;
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
  REAL4 SNAME_specificity;
  REAL4 SNAME_switch;
  REAL4 SNAME_maximum;
  DATASET(SNAME_ChildRec) nulls_SNAME {MAXCOUNT(100)};
  REAL4 GENDER_specificity;
  REAL4 GENDER_switch;
  REAL4 GENDER_maximum;
  DATASET(GENDER_ChildRec) nulls_GENDER {MAXCOUNT(100)};
  REAL4 PRIM_RANGE_specificity;
  REAL4 PRIM_RANGE_switch;
  REAL4 PRIM_RANGE_maximum;
  DATASET(PRIM_RANGE_ChildRec) nulls_PRIM_RANGE {MAXCOUNT(100)};
  REAL4 PRIM_NAME_specificity;
  REAL4 PRIM_NAME_switch;
  REAL4 PRIM_NAME_maximum;
  DATASET(PRIM_NAME_ChildRec) nulls_PRIM_NAME {MAXCOUNT(100)};
  REAL4 SEC_RANGE_specificity;
  REAL4 SEC_RANGE_switch;
  REAL4 SEC_RANGE_maximum;
  DATASET(SEC_RANGE_ChildRec) nulls_SEC_RANGE {MAXCOUNT(100)};
  REAL4 V_CITY_NAME_specificity;
  REAL4 V_CITY_NAME_switch;
  REAL4 V_CITY_NAME_maximum;
  DATASET(V_CITY_NAME_ChildRec) nulls_V_CITY_NAME {MAXCOUNT(100)};
  REAL4 ST_specificity;
  REAL4 ST_switch;
  REAL4 ST_maximum;
  DATASET(ST_ChildRec) nulls_ST {MAXCOUNT(100)};
  REAL4 ZIP_specificity;
  REAL4 ZIP_switch;
  REAL4 ZIP_maximum;
  DATASET(ZIP_ChildRec) nulls_ZIP {MAXCOUNT(100)};
  REAL4 SSN_specificity;
  REAL4 SSN_switch;
  REAL4 SSN_maximum;
  DATASET(SSN_ChildRec) nulls_SSN {MAXCOUNT(100)};
  REAL4 CNSMR_SSN_specificity;
  REAL4 CNSMR_SSN_switch;
  REAL4 CNSMR_SSN_maximum;
  DATASET(CNSMR_SSN_ChildRec) nulls_CNSMR_SSN {MAXCOUNT(100)};
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
  REAL4 CNSMR_DOB_year_specificity;
  REAL4 CNSMR_DOB_year_switch;
  REAL4 CNSMR_DOB_year_maximum;
  DATASET(CNSMR_DOB_year_ChildRec) nulls_CNSMR_DOB_year {MAXCOUNT(100)};
  REAL4 CNSMR_DOB_month_specificity;
  REAL4 CNSMR_DOB_month_switch;
  REAL4 CNSMR_DOB_month_maximum;
  DATASET(CNSMR_DOB_month_ChildRec) nulls_CNSMR_DOB_month {MAXCOUNT(100)};
  REAL4 CNSMR_DOB_day_specificity;
  REAL4 CNSMR_DOB_day_switch;
  REAL4 CNSMR_DOB_day_maximum;
  DATASET(CNSMR_DOB_day_ChildRec) nulls_CNSMR_DOB_day {MAXCOUNT(100)};
  REAL4 PHONE_specificity;
  REAL4 PHONE_switch;
  REAL4 PHONE_maximum;
  DATASET(PHONE_ChildRec) nulls_PHONE {MAXCOUNT(100)};
  REAL4 LIC_STATE_specificity;
  REAL4 LIC_STATE_switch;
  REAL4 LIC_STATE_maximum;
  DATASET(LIC_STATE_ChildRec) nulls_LIC_STATE {MAXCOUNT(100)};
  REAL4 C_LIC_NBR_specificity;
  REAL4 C_LIC_NBR_switch;
  REAL4 C_LIC_NBR_maximum;
  DATASET(C_LIC_NBR_ChildRec) nulls_C_LIC_NBR {MAXCOUNT(100)};
  REAL4 TAX_ID_specificity;
  REAL4 TAX_ID_switch;
  REAL4 TAX_ID_maximum;
  DATASET(TAX_ID_ChildRec) nulls_TAX_ID {MAXCOUNT(100)};
  REAL4 BILLING_TAX_ID_specificity;
  REAL4 BILLING_TAX_ID_switch;
  REAL4 BILLING_TAX_ID_maximum;
  DATASET(BILLING_TAX_ID_ChildRec) nulls_BILLING_TAX_ID {MAXCOUNT(100)};
  REAL4 DEA_NUMBER_specificity;
  REAL4 DEA_NUMBER_switch;
  REAL4 DEA_NUMBER_maximum;
  DATASET(DEA_NUMBER_ChildRec) nulls_DEA_NUMBER {MAXCOUNT(100)};
  REAL4 VENDOR_ID_specificity;
  REAL4 VENDOR_ID_switch;
  REAL4 VENDOR_ID_maximum;
  DATASET(VENDOR_ID_ChildRec) nulls_VENDOR_ID {MAXCOUNT(100)};
  REAL4 NPI_NUMBER_specificity;
  REAL4 NPI_NUMBER_switch;
  REAL4 NPI_NUMBER_maximum;
  DATASET(NPI_NUMBER_ChildRec) nulls_NPI_NUMBER {MAXCOUNT(100)};
  REAL4 BILLING_NPI_NUMBER_specificity;
  REAL4 BILLING_NPI_NUMBER_switch;
  REAL4 BILLING_NPI_NUMBER_maximum;
  DATASET(BILLING_NPI_NUMBER_ChildRec) nulls_BILLING_NPI_NUMBER {MAXCOUNT(100)};
  REAL4 UPIN_specificity;
  REAL4 UPIN_switch;
  REAL4 UPIN_maximum;
  DATASET(UPIN_ChildRec) nulls_UPIN {MAXCOUNT(100)};
  REAL4 DID_specificity;
  REAL4 DID_switch;
  REAL4 DID_maximum;
  DATASET(DID_ChildRec) nulls_DID {MAXCOUNT(100)};
  REAL4 BDID_specificity;
  REAL4 BDID_switch;
  REAL4 BDID_maximum;
  DATASET(BDID_ChildRec) nulls_BDID {MAXCOUNT(100)};
  REAL4 SRC_specificity;
  REAL4 SRC_switch;
  REAL4 SRC_maximum;
  DATASET(SRC_ChildRec) nulls_SRC {MAXCOUNT(100)};
  REAL4 SOURCE_RID_specificity;
  REAL4 SOURCE_RID_switch;
  REAL4 SOURCE_RID_maximum;
  DATASET(SOURCE_RID_ChildRec) nulls_SOURCE_RID {MAXCOUNT(100)};
  REAL4 RID_specificity;
  REAL4 RID_switch;
  REAL4 RID_maximum;
  DATASET(RID_ChildRec) nulls_RID {MAXCOUNT(100)};
  REAL4 MAINNAME_specificity;
  REAL4 MAINNAME_switch;
  REAL4 MAINNAME_maximum;
  DATASET(MAINNAME_ChildRec) nulls_MAINNAME {MAXCOUNT(100)};
  REAL4 FULLNAME_specificity;
  REAL4 FULLNAME_switch;
  REAL4 FULLNAME_maximum;
  DATASET(FULLNAME_ChildRec) nulls_FULLNAME {MAXCOUNT(100)};
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
  REAL4 uber_specificity;
  REAL4 uber_switch;
  REAL4 uber_maximum;
  DATASET(Uber_ChildRec) nulls_uber {MAXCOUNT(100)};
END;
END;
