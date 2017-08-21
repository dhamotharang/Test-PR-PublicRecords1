IMPORT SALT30;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_HealthFacility;
export PHONE_ChildRec := record
  typeof(l.PHONE) PHONE;
  unsigned8 cnt;
  unsigned4 id;
end;
export FAX_ChildRec := record
  typeof(l.FAX) FAX;
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
export CLIA_NUMBER_ChildRec := record
  typeof(l.CLIA_NUMBER) CLIA_NUMBER;
  unsigned8 cnt;
  unsigned4 id;
end;
export MEDICARE_FACILITY_NUMBER_ChildRec := record
  typeof(l.MEDICARE_FACILITY_NUMBER) MEDICARE_FACILITY_NUMBER;
  unsigned8 cnt;
  unsigned4 id;
end;
export NCPDP_NUMBER_ChildRec := record
  typeof(l.NCPDP_NUMBER) NCPDP_NUMBER;
  unsigned8 cnt;
  unsigned4 id;
end;
export TAX_ID_ChildRec := record
  typeof(l.TAX_ID) TAX_ID;
  unsigned8 cnt;
  unsigned4 id;
end;
export FEIN_ChildRec := record
  typeof(l.FEIN) FEIN;
  unsigned8 cnt;
  unsigned4 id;
end;
export C_LIC_NBR_ChildRec := record
  typeof(l.C_LIC_NBR) C_LIC_NBR;
  unsigned8 cnt;
  unsigned4 id;
end;
export CNP_NAME_ChildRec := record
  typeof(l.CNP_NAME) CNP_NAME;
  unsigned8 cnt;
  unsigned4 id;
end;
export CNP_NUMBER_ChildRec := record
  typeof(l.CNP_NUMBER) CNP_NUMBER;
  unsigned8 cnt;
  unsigned4 id;
end;
export CNP_STORE_NUMBER_ChildRec := record
  typeof(l.CNP_STORE_NUMBER) CNP_STORE_NUMBER;
  unsigned8 cnt;
  unsigned4 id;
end;
export CNP_BTYPE_ChildRec := record
  typeof(l.CNP_BTYPE) CNP_BTYPE;
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
export ST_ChildRec := record
  typeof(l.ST) ST;
  unsigned8 cnt;
  unsigned4 id;
end;
export V_CITY_NAME_ChildRec := record
  typeof(l.V_CITY_NAME) V_CITY_NAME;
  unsigned8 cnt;
  unsigned4 id;
end;
export ZIP_ChildRec := record
  typeof(l.ZIP) ZIP;
  unsigned8 cnt;
  unsigned4 id;
end;
export TAXONOMY_ChildRec := record
  typeof(l.TAXONOMY) TAXONOMY;
  unsigned8 cnt;
  unsigned4 id;
end;
export TAXONOMY_CODE_ChildRec := record
  typeof(l.TAXONOMY_CODE) TAXONOMY_CODE;
  unsigned8 cnt;
  unsigned4 id;
end;
export MEDICAID_NUMBER_ChildRec := record
  typeof(l.MEDICAID_NUMBER) MEDICAID_NUMBER;
  unsigned8 cnt;
  unsigned4 id;
end;
export VENDOR_ID_ChildRec := record
  typeof(l.VENDOR_ID) VENDOR_ID;
  unsigned8 cnt;
  unsigned4 id;
end;
export FAC_NAME_ChildRec := record
  UNSIGNED4 FAC_NAME;
  unsigned8 cnt;
  unsigned4 id;
end;
export ADDR1_ChildRec := record
  UNSIGNED4 ADDR1;
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
  real4 PHONE_specificity;
  real4 PHONE_switch;
  real4 PHONE_max;
  dataset(PHONE_ChildRec) nulls_PHONE {MAXCOUNT(100)};
  real4 FAX_specificity;
  real4 FAX_switch;
  real4 FAX_max;
  dataset(FAX_ChildRec) nulls_FAX {MAXCOUNT(100)};
  real4 NPI_NUMBER_specificity;
  real4 NPI_NUMBER_switch;
  real4 NPI_NUMBER_max;
  dataset(NPI_NUMBER_ChildRec) nulls_NPI_NUMBER {MAXCOUNT(100)};
  real4 DEA_NUMBER_specificity;
  real4 DEA_NUMBER_switch;
  real4 DEA_NUMBER_max;
  dataset(DEA_NUMBER_ChildRec) nulls_DEA_NUMBER {MAXCOUNT(100)};
  real4 CLIA_NUMBER_specificity;
  real4 CLIA_NUMBER_switch;
  real4 CLIA_NUMBER_max;
  dataset(CLIA_NUMBER_ChildRec) nulls_CLIA_NUMBER {MAXCOUNT(100)};
  real4 MEDICARE_FACILITY_NUMBER_specificity;
  real4 MEDICARE_FACILITY_NUMBER_switch;
  real4 MEDICARE_FACILITY_NUMBER_max;
  dataset(MEDICARE_FACILITY_NUMBER_ChildRec) nulls_MEDICARE_FACILITY_NUMBER {MAXCOUNT(100)};
  real4 NCPDP_NUMBER_specificity;
  real4 NCPDP_NUMBER_switch;
  real4 NCPDP_NUMBER_max;
  dataset(NCPDP_NUMBER_ChildRec) nulls_NCPDP_NUMBER {MAXCOUNT(100)};
  real4 TAX_ID_specificity;
  real4 TAX_ID_switch;
  real4 TAX_ID_max;
  dataset(TAX_ID_ChildRec) nulls_TAX_ID {MAXCOUNT(100)};
  real4 FEIN_specificity;
  real4 FEIN_switch;
  real4 FEIN_max;
  dataset(FEIN_ChildRec) nulls_FEIN {MAXCOUNT(100)};
  real4 C_LIC_NBR_specificity;
  real4 C_LIC_NBR_switch;
  real4 C_LIC_NBR_max;
  dataset(C_LIC_NBR_ChildRec) nulls_C_LIC_NBR {MAXCOUNT(100)};
  real4 CNP_NAME_specificity;
  real4 CNP_NAME_switch;
  real4 CNP_NAME_max;
  dataset(CNP_NAME_ChildRec) nulls_CNP_NAME {MAXCOUNT(100)};
  real4 CNP_NUMBER_specificity;
  real4 CNP_NUMBER_switch;
  real4 CNP_NUMBER_max;
  dataset(CNP_NUMBER_ChildRec) nulls_CNP_NUMBER {MAXCOUNT(100)};
  real4 CNP_STORE_NUMBER_specificity;
  real4 CNP_STORE_NUMBER_switch;
  real4 CNP_STORE_NUMBER_max;
  dataset(CNP_STORE_NUMBER_ChildRec) nulls_CNP_STORE_NUMBER {MAXCOUNT(100)};
  real4 CNP_BTYPE_specificity;
  real4 CNP_BTYPE_switch;
  real4 CNP_BTYPE_max;
  dataset(CNP_BTYPE_ChildRec) nulls_CNP_BTYPE {MAXCOUNT(100)};
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
  real4 ST_specificity;
  real4 ST_switch;
  real4 ST_max;
  dataset(ST_ChildRec) nulls_ST {MAXCOUNT(100)};
  real4 V_CITY_NAME_specificity;
  real4 V_CITY_NAME_switch;
  real4 V_CITY_NAME_max;
  dataset(V_CITY_NAME_ChildRec) nulls_V_CITY_NAME {MAXCOUNT(100)};
  real4 ZIP_specificity;
  real4 ZIP_switch;
  real4 ZIP_max;
  dataset(ZIP_ChildRec) nulls_ZIP {MAXCOUNT(100)};
  real4 TAXONOMY_specificity;
  real4 TAXONOMY_switch;
  real4 TAXONOMY_max;
  dataset(TAXONOMY_ChildRec) nulls_TAXONOMY {MAXCOUNT(100)};
  real4 TAXONOMY_CODE_specificity;
  real4 TAXONOMY_CODE_switch;
  real4 TAXONOMY_CODE_max;
  dataset(TAXONOMY_CODE_ChildRec) nulls_TAXONOMY_CODE {MAXCOUNT(100)};
  real4 MEDICAID_NUMBER_specificity;
  real4 MEDICAID_NUMBER_switch;
  real4 MEDICAID_NUMBER_max;
  dataset(MEDICAID_NUMBER_ChildRec) nulls_MEDICAID_NUMBER {MAXCOUNT(100)};
  real4 VENDOR_ID_specificity;
  real4 VENDOR_ID_switch;
  real4 VENDOR_ID_max;
  dataset(VENDOR_ID_ChildRec) nulls_VENDOR_ID {MAXCOUNT(100)};
  real4 FAC_NAME_specificity;
  real4 FAC_NAME_switch;
  real4 FAC_NAME_max;
  dataset(FAC_NAME_ChildRec) nulls_FAC_NAME {MAXCOUNT(100)};
  real4 ADDR1_specificity;
  real4 ADDR1_switch;
  real4 ADDR1_max;
  dataset(ADDR1_ChildRec) nulls_ADDR1 {MAXCOUNT(100)};
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
