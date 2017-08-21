// Begin code to append flags to the file
IMPORT SALT30,ut;
EXPORT Flags(DATASET(layout_HealthFacility) ih,layout_specificities.R s = Specificities(ih).specificities[1],BOOLEAN RoxieService=FALSE) := MODULE
  h00 := Cleave(ih,s,RoxieService).input_file;
SHARED h := IF(RoxieService,Specificities(ih).input_file_np,h00);
SHARED b := Best(ih);
// Append flags to the regular file
  TYPEOF(ih) NoteFlags(ih le,b.BestBy_LNPID_Best ri) := TRANSFORM
    SELF.NPI_NUMBER_flag := MAP ( ri.NPI_NUMBER  IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER) => SALT30.Flags.Null,
      le.NPI_NUMBER  IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER) => SALT30.Flags.Missing,
      ri.NPI_NUMBER_owns => SALT30.Flags.Owns,
      le.NPI_NUMBER = ri.NPI_NUMBER => SALT30.Flags.Equal,
      SALT30.Flags.Bad);
    SELF.DEA_NUMBER_flag := MAP ( ri.DEA_NUMBER  IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER) => SALT30.Flags.Null,
      le.DEA_NUMBER  IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER) => SALT30.Flags.Missing,
      ri.DEA_NUMBER_owns => SALT30.Flags.Owns,
      le.DEA_NUMBER = ri.DEA_NUMBER => SALT30.Flags.Equal,
      SALT30.Flags.Bad);
    SELF.CLIA_NUMBER_flag := MAP ( ri.CLIA_NUMBER  IN SET(s.nulls_CLIA_NUMBER,CLIA_NUMBER) => SALT30.Flags.Null,
      le.CLIA_NUMBER  IN SET(s.nulls_CLIA_NUMBER,CLIA_NUMBER) => SALT30.Flags.Missing,
      ri.CLIA_NUMBER_owns => SALT30.Flags.Owns,
      le.CLIA_NUMBER = ri.CLIA_NUMBER => SALT30.Flags.Equal,
      SALT30.Flags.Bad);
    SELF.MEDICARE_FACILITY_NUMBER_flag := MAP ( ri.MEDICARE_FACILITY_NUMBER  IN SET(s.nulls_MEDICARE_FACILITY_NUMBER,MEDICARE_FACILITY_NUMBER) => SALT30.Flags.Null,
      le.MEDICARE_FACILITY_NUMBER  IN SET(s.nulls_MEDICARE_FACILITY_NUMBER,MEDICARE_FACILITY_NUMBER) => SALT30.Flags.Missing,
      ri.MEDICARE_FACILITY_NUMBER_owns => SALT30.Flags.Owns,
      le.MEDICARE_FACILITY_NUMBER = ri.MEDICARE_FACILITY_NUMBER => SALT30.Flags.Equal,
      SALT30.Flags.Bad);
    SELF.NCPDP_NUMBER_flag := MAP ( ri.NCPDP_NUMBER  IN SET(s.nulls_NCPDP_NUMBER,NCPDP_NUMBER) => SALT30.Flags.Null,
      le.NCPDP_NUMBER  IN SET(s.nulls_NCPDP_NUMBER,NCPDP_NUMBER) => SALT30.Flags.Missing,
      ri.NCPDP_NUMBER_owns => SALT30.Flags.Owns,
      le.NCPDP_NUMBER = ri.NCPDP_NUMBER => SALT30.Flags.Equal,
      SALT30.Flags.Bad);
    SELF.TAX_ID_flag := MAP ( ri.TAX_ID  IN SET(s.nulls_TAX_ID,TAX_ID) => SALT30.Flags.Null,
      le.TAX_ID  IN SET(s.nulls_TAX_ID,TAX_ID) => SALT30.Flags.Missing,
      ri.TAX_ID_owns => SALT30.Flags.Owns,
      le.TAX_ID = ri.TAX_ID => SALT30.Flags.Equal,
      SALT30.Flags.Bad);
    SELF.FEIN_flag := MAP ( ri.FEIN  IN SET(s.nulls_FEIN,FEIN) => SALT30.Flags.Null,
      le.FEIN  IN SET(s.nulls_FEIN,FEIN) => SALT30.Flags.Missing,
      ri.FEIN_owns => SALT30.Flags.Owns,
      le.FEIN = ri.FEIN => SALT30.Flags.Equal,
      SALT30.Flags.Bad);
    SELF.C_LIC_NBR_flag := MAP ( ri.C_LIC_NBR  IN SET(s.nulls_C_LIC_NBR,C_LIC_NBR) => SALT30.Flags.Null,
      le.C_LIC_NBR  IN SET(s.nulls_C_LIC_NBR,C_LIC_NBR) => SALT30.Flags.Missing,
      le.C_LIC_NBR = ri.C_LIC_NBR => SALT30.Flags.Equal,
      le.C_LIC_NBR = (TYPEOF(le.C_LIC_NBR))'' OR ri.C_LIC_NBR = (TYPEOF(ri.C_LIC_NBR))'' OR SALT30.WithinEditN(le.C_LIC_NBR,ri.C_LIC_NBR,1, 0)  => SALT30.Flags.Fuzzy,
      SALT30.Flags.Bad);
    SELF.MEDICAID_NUMBER_flag := MAP ( ri.MEDICAID_NUMBER  IN SET(s.nulls_MEDICAID_NUMBER,MEDICAID_NUMBER) => SALT30.Flags.Null,
      le.MEDICAID_NUMBER  IN SET(s.nulls_MEDICAID_NUMBER,MEDICAID_NUMBER) => SALT30.Flags.Missing,
      ri.MEDICAID_NUMBER_owns => SALT30.Flags.Owns,
      le.MEDICAID_NUMBER = ri.MEDICAID_NUMBER => SALT30.Flags.Equal,
      SALT30.Flags.Bad);
    SELF := le;
  END;
  j := JOIN(ih,b.BestBy_LNPID_Best,LEFT.LNPID=RIGHT.LNPID,NoteFlags(LEFT,RIGHT),LEFT OUTER,HASH);
SHARED In_Flagged0 := SORT(DISTRIBUTE(j,HASH(LNPID)),LNPID,LOCAL);
EXPORT In_Flagged := In_Flagged0;
  FlagTots := RECORD
    UNSIGNED Cnt := COUNT(GROUP);
    REAL4 NPI_NUMBER_Null_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT30.Flags.Null,100,0));
    REAL4 NPI_NUMBER_Equal_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT30.Flags.Equal,100,0));
    REAL4 NPI_NUMBER_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 NPI_NUMBER_Bad_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT30.Flags.Bad,100,0));
    REAL4 NPI_NUMBER_Missing_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT30.Flags.Missing,100,0));
    REAL4 NPI_NUMBER_Relative_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT30.Flags.Relative,100,0));
    REAL4 NPI_NUMBER_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 NPI_NUMBER_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 NPI_NUMBER_Owns_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT30.Flags.Owns,100,0));
    REAL4 DEA_NUMBER_Null_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT30.Flags.Null,100,0));
    REAL4 DEA_NUMBER_Equal_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT30.Flags.Equal,100,0));
    REAL4 DEA_NUMBER_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 DEA_NUMBER_Bad_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT30.Flags.Bad,100,0));
    REAL4 DEA_NUMBER_Missing_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT30.Flags.Missing,100,0));
    REAL4 DEA_NUMBER_Relative_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT30.Flags.Relative,100,0));
    REAL4 DEA_NUMBER_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 DEA_NUMBER_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 DEA_NUMBER_Owns_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT30.Flags.Owns,100,0));
    REAL4 CLIA_NUMBER_Null_pcnt := AVE(GROUP,IF(In_Flagged.CLIA_NUMBER_Flag = SALT30.Flags.Null,100,0));
    REAL4 CLIA_NUMBER_Equal_pcnt := AVE(GROUP,IF(In_Flagged.CLIA_NUMBER_Flag = SALT30.Flags.Equal,100,0));
    REAL4 CLIA_NUMBER_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.CLIA_NUMBER_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 CLIA_NUMBER_Bad_pcnt := AVE(GROUP,IF(In_Flagged.CLIA_NUMBER_Flag = SALT30.Flags.Bad,100,0));
    REAL4 CLIA_NUMBER_Missing_pcnt := AVE(GROUP,IF(In_Flagged.CLIA_NUMBER_Flag = SALT30.Flags.Missing,100,0));
    REAL4 CLIA_NUMBER_Relative_pcnt := AVE(GROUP,IF(In_Flagged.CLIA_NUMBER_Flag = SALT30.Flags.Relative,100,0));
    REAL4 CLIA_NUMBER_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.CLIA_NUMBER_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 CLIA_NUMBER_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.CLIA_NUMBER_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 CLIA_NUMBER_Owns_pcnt := AVE(GROUP,IF(In_Flagged.CLIA_NUMBER_Flag = SALT30.Flags.Owns,100,0));
    REAL4 MEDICARE_FACILITY_NUMBER_Null_pcnt := AVE(GROUP,IF(In_Flagged.MEDICARE_FACILITY_NUMBER_Flag = SALT30.Flags.Null,100,0));
    REAL4 MEDICARE_FACILITY_NUMBER_Equal_pcnt := AVE(GROUP,IF(In_Flagged.MEDICARE_FACILITY_NUMBER_Flag = SALT30.Flags.Equal,100,0));
    REAL4 MEDICARE_FACILITY_NUMBER_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.MEDICARE_FACILITY_NUMBER_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 MEDICARE_FACILITY_NUMBER_Bad_pcnt := AVE(GROUP,IF(In_Flagged.MEDICARE_FACILITY_NUMBER_Flag = SALT30.Flags.Bad,100,0));
    REAL4 MEDICARE_FACILITY_NUMBER_Missing_pcnt := AVE(GROUP,IF(In_Flagged.MEDICARE_FACILITY_NUMBER_Flag = SALT30.Flags.Missing,100,0));
    REAL4 MEDICARE_FACILITY_NUMBER_Relative_pcnt := AVE(GROUP,IF(In_Flagged.MEDICARE_FACILITY_NUMBER_Flag = SALT30.Flags.Relative,100,0));
    REAL4 MEDICARE_FACILITY_NUMBER_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.MEDICARE_FACILITY_NUMBER_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 MEDICARE_FACILITY_NUMBER_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.MEDICARE_FACILITY_NUMBER_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 MEDICARE_FACILITY_NUMBER_Owns_pcnt := AVE(GROUP,IF(In_Flagged.MEDICARE_FACILITY_NUMBER_Flag = SALT30.Flags.Owns,100,0));
    REAL4 NCPDP_NUMBER_Null_pcnt := AVE(GROUP,IF(In_Flagged.NCPDP_NUMBER_Flag = SALT30.Flags.Null,100,0));
    REAL4 NCPDP_NUMBER_Equal_pcnt := AVE(GROUP,IF(In_Flagged.NCPDP_NUMBER_Flag = SALT30.Flags.Equal,100,0));
    REAL4 NCPDP_NUMBER_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.NCPDP_NUMBER_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 NCPDP_NUMBER_Bad_pcnt := AVE(GROUP,IF(In_Flagged.NCPDP_NUMBER_Flag = SALT30.Flags.Bad,100,0));
    REAL4 NCPDP_NUMBER_Missing_pcnt := AVE(GROUP,IF(In_Flagged.NCPDP_NUMBER_Flag = SALT30.Flags.Missing,100,0));
    REAL4 NCPDP_NUMBER_Relative_pcnt := AVE(GROUP,IF(In_Flagged.NCPDP_NUMBER_Flag = SALT30.Flags.Relative,100,0));
    REAL4 NCPDP_NUMBER_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.NCPDP_NUMBER_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 NCPDP_NUMBER_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.NCPDP_NUMBER_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 NCPDP_NUMBER_Owns_pcnt := AVE(GROUP,IF(In_Flagged.NCPDP_NUMBER_Flag = SALT30.Flags.Owns,100,0));
    REAL4 TAX_ID_Null_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT30.Flags.Null,100,0));
    REAL4 TAX_ID_Equal_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT30.Flags.Equal,100,0));
    REAL4 TAX_ID_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 TAX_ID_Bad_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT30.Flags.Bad,100,0));
    REAL4 TAX_ID_Missing_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT30.Flags.Missing,100,0));
    REAL4 TAX_ID_Relative_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT30.Flags.Relative,100,0));
    REAL4 TAX_ID_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 TAX_ID_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 TAX_ID_Owns_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT30.Flags.Owns,100,0));
    REAL4 FEIN_Null_pcnt := AVE(GROUP,IF(In_Flagged.FEIN_Flag = SALT30.Flags.Null,100,0));
    REAL4 FEIN_Equal_pcnt := AVE(GROUP,IF(In_Flagged.FEIN_Flag = SALT30.Flags.Equal,100,0));
    REAL4 FEIN_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.FEIN_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 FEIN_Bad_pcnt := AVE(GROUP,IF(In_Flagged.FEIN_Flag = SALT30.Flags.Bad,100,0));
    REAL4 FEIN_Missing_pcnt := AVE(GROUP,IF(In_Flagged.FEIN_Flag = SALT30.Flags.Missing,100,0));
    REAL4 FEIN_Relative_pcnt := AVE(GROUP,IF(In_Flagged.FEIN_Flag = SALT30.Flags.Relative,100,0));
    REAL4 FEIN_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.FEIN_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 FEIN_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.FEIN_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 FEIN_Owns_pcnt := AVE(GROUP,IF(In_Flagged.FEIN_Flag = SALT30.Flags.Owns,100,0));
    REAL4 C_LIC_NBR_Null_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT30.Flags.Null,100,0));
    REAL4 C_LIC_NBR_Equal_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT30.Flags.Equal,100,0));
    REAL4 C_LIC_NBR_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 C_LIC_NBR_Bad_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT30.Flags.Bad,100,0));
    REAL4 C_LIC_NBR_Missing_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT30.Flags.Missing,100,0));
    REAL4 C_LIC_NBR_Relative_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT30.Flags.Relative,100,0));
    REAL4 C_LIC_NBR_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 C_LIC_NBR_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 MEDICAID_NUMBER_Null_pcnt := AVE(GROUP,IF(In_Flagged.MEDICAID_NUMBER_Flag = SALT30.Flags.Null,100,0));
    REAL4 MEDICAID_NUMBER_Equal_pcnt := AVE(GROUP,IF(In_Flagged.MEDICAID_NUMBER_Flag = SALT30.Flags.Equal,100,0));
    REAL4 MEDICAID_NUMBER_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.MEDICAID_NUMBER_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 MEDICAID_NUMBER_Bad_pcnt := AVE(GROUP,IF(In_Flagged.MEDICAID_NUMBER_Flag = SALT30.Flags.Bad,100,0));
    REAL4 MEDICAID_NUMBER_Missing_pcnt := AVE(GROUP,IF(In_Flagged.MEDICAID_NUMBER_Flag = SALT30.Flags.Missing,100,0));
    REAL4 MEDICAID_NUMBER_Relative_pcnt := AVE(GROUP,IF(In_Flagged.MEDICAID_NUMBER_Flag = SALT30.Flags.Relative,100,0));
    REAL4 MEDICAID_NUMBER_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.MEDICAID_NUMBER_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 MEDICAID_NUMBER_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.MEDICAID_NUMBER_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 MEDICAID_NUMBER_Owns_pcnt := AVE(GROUP,IF(In_Flagged.MEDICAID_NUMBER_Flag = SALT30.Flags.Owns,100,0));
  END;
EXPORT In_Flagged_Summary := TABLE(In_Flagged,FlagTots); // Global summary
  FlagTots := RECORD
    In_Flagged.SRC; // Group by sourcefield    UNSIGNED Cnt := COUNT(GROUP);
    REAL4 NPI_NUMBER_Null_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT30.Flags.Null,100,0));
    REAL4 NPI_NUMBER_Equal_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT30.Flags.Equal,100,0));
    REAL4 NPI_NUMBER_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 NPI_NUMBER_Bad_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT30.Flags.Bad,100,0));
    REAL4 NPI_NUMBER_Missing_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT30.Flags.Missing,100,0));
    REAL4 NPI_NUMBER_Relative_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT30.Flags.Relative,100,0));
    REAL4 NPI_NUMBER_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 NPI_NUMBER_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 NPI_NUMBER_Owns_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT30.Flags.Owns,100,0));
    REAL4 DEA_NUMBER_Null_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT30.Flags.Null,100,0));
    REAL4 DEA_NUMBER_Equal_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT30.Flags.Equal,100,0));
    REAL4 DEA_NUMBER_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 DEA_NUMBER_Bad_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT30.Flags.Bad,100,0));
    REAL4 DEA_NUMBER_Missing_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT30.Flags.Missing,100,0));
    REAL4 DEA_NUMBER_Relative_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT30.Flags.Relative,100,0));
    REAL4 DEA_NUMBER_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 DEA_NUMBER_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 DEA_NUMBER_Owns_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT30.Flags.Owns,100,0));
    REAL4 CLIA_NUMBER_Null_pcnt := AVE(GROUP,IF(In_Flagged.CLIA_NUMBER_Flag = SALT30.Flags.Null,100,0));
    REAL4 CLIA_NUMBER_Equal_pcnt := AVE(GROUP,IF(In_Flagged.CLIA_NUMBER_Flag = SALT30.Flags.Equal,100,0));
    REAL4 CLIA_NUMBER_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.CLIA_NUMBER_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 CLIA_NUMBER_Bad_pcnt := AVE(GROUP,IF(In_Flagged.CLIA_NUMBER_Flag = SALT30.Flags.Bad,100,0));
    REAL4 CLIA_NUMBER_Missing_pcnt := AVE(GROUP,IF(In_Flagged.CLIA_NUMBER_Flag = SALT30.Flags.Missing,100,0));
    REAL4 CLIA_NUMBER_Relative_pcnt := AVE(GROUP,IF(In_Flagged.CLIA_NUMBER_Flag = SALT30.Flags.Relative,100,0));
    REAL4 CLIA_NUMBER_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.CLIA_NUMBER_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 CLIA_NUMBER_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.CLIA_NUMBER_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 CLIA_NUMBER_Owns_pcnt := AVE(GROUP,IF(In_Flagged.CLIA_NUMBER_Flag = SALT30.Flags.Owns,100,0));
    REAL4 MEDICARE_FACILITY_NUMBER_Null_pcnt := AVE(GROUP,IF(In_Flagged.MEDICARE_FACILITY_NUMBER_Flag = SALT30.Flags.Null,100,0));
    REAL4 MEDICARE_FACILITY_NUMBER_Equal_pcnt := AVE(GROUP,IF(In_Flagged.MEDICARE_FACILITY_NUMBER_Flag = SALT30.Flags.Equal,100,0));
    REAL4 MEDICARE_FACILITY_NUMBER_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.MEDICARE_FACILITY_NUMBER_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 MEDICARE_FACILITY_NUMBER_Bad_pcnt := AVE(GROUP,IF(In_Flagged.MEDICARE_FACILITY_NUMBER_Flag = SALT30.Flags.Bad,100,0));
    REAL4 MEDICARE_FACILITY_NUMBER_Missing_pcnt := AVE(GROUP,IF(In_Flagged.MEDICARE_FACILITY_NUMBER_Flag = SALT30.Flags.Missing,100,0));
    REAL4 MEDICARE_FACILITY_NUMBER_Relative_pcnt := AVE(GROUP,IF(In_Flagged.MEDICARE_FACILITY_NUMBER_Flag = SALT30.Flags.Relative,100,0));
    REAL4 MEDICARE_FACILITY_NUMBER_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.MEDICARE_FACILITY_NUMBER_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 MEDICARE_FACILITY_NUMBER_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.MEDICARE_FACILITY_NUMBER_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 MEDICARE_FACILITY_NUMBER_Owns_pcnt := AVE(GROUP,IF(In_Flagged.MEDICARE_FACILITY_NUMBER_Flag = SALT30.Flags.Owns,100,0));
    REAL4 NCPDP_NUMBER_Null_pcnt := AVE(GROUP,IF(In_Flagged.NCPDP_NUMBER_Flag = SALT30.Flags.Null,100,0));
    REAL4 NCPDP_NUMBER_Equal_pcnt := AVE(GROUP,IF(In_Flagged.NCPDP_NUMBER_Flag = SALT30.Flags.Equal,100,0));
    REAL4 NCPDP_NUMBER_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.NCPDP_NUMBER_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 NCPDP_NUMBER_Bad_pcnt := AVE(GROUP,IF(In_Flagged.NCPDP_NUMBER_Flag = SALT30.Flags.Bad,100,0));
    REAL4 NCPDP_NUMBER_Missing_pcnt := AVE(GROUP,IF(In_Flagged.NCPDP_NUMBER_Flag = SALT30.Flags.Missing,100,0));
    REAL4 NCPDP_NUMBER_Relative_pcnt := AVE(GROUP,IF(In_Flagged.NCPDP_NUMBER_Flag = SALT30.Flags.Relative,100,0));
    REAL4 NCPDP_NUMBER_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.NCPDP_NUMBER_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 NCPDP_NUMBER_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.NCPDP_NUMBER_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 NCPDP_NUMBER_Owns_pcnt := AVE(GROUP,IF(In_Flagged.NCPDP_NUMBER_Flag = SALT30.Flags.Owns,100,0));
    REAL4 TAX_ID_Null_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT30.Flags.Null,100,0));
    REAL4 TAX_ID_Equal_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT30.Flags.Equal,100,0));
    REAL4 TAX_ID_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 TAX_ID_Bad_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT30.Flags.Bad,100,0));
    REAL4 TAX_ID_Missing_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT30.Flags.Missing,100,0));
    REAL4 TAX_ID_Relative_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT30.Flags.Relative,100,0));
    REAL4 TAX_ID_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 TAX_ID_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 TAX_ID_Owns_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT30.Flags.Owns,100,0));
    REAL4 FEIN_Null_pcnt := AVE(GROUP,IF(In_Flagged.FEIN_Flag = SALT30.Flags.Null,100,0));
    REAL4 FEIN_Equal_pcnt := AVE(GROUP,IF(In_Flagged.FEIN_Flag = SALT30.Flags.Equal,100,0));
    REAL4 FEIN_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.FEIN_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 FEIN_Bad_pcnt := AVE(GROUP,IF(In_Flagged.FEIN_Flag = SALT30.Flags.Bad,100,0));
    REAL4 FEIN_Missing_pcnt := AVE(GROUP,IF(In_Flagged.FEIN_Flag = SALT30.Flags.Missing,100,0));
    REAL4 FEIN_Relative_pcnt := AVE(GROUP,IF(In_Flagged.FEIN_Flag = SALT30.Flags.Relative,100,0));
    REAL4 FEIN_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.FEIN_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 FEIN_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.FEIN_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 FEIN_Owns_pcnt := AVE(GROUP,IF(In_Flagged.FEIN_Flag = SALT30.Flags.Owns,100,0));
    REAL4 C_LIC_NBR_Null_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT30.Flags.Null,100,0));
    REAL4 C_LIC_NBR_Equal_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT30.Flags.Equal,100,0));
    REAL4 C_LIC_NBR_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 C_LIC_NBR_Bad_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT30.Flags.Bad,100,0));
    REAL4 C_LIC_NBR_Missing_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT30.Flags.Missing,100,0));
    REAL4 C_LIC_NBR_Relative_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT30.Flags.Relative,100,0));
    REAL4 C_LIC_NBR_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 C_LIC_NBR_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 MEDICAID_NUMBER_Null_pcnt := AVE(GROUP,IF(In_Flagged.MEDICAID_NUMBER_Flag = SALT30.Flags.Null,100,0));
    REAL4 MEDICAID_NUMBER_Equal_pcnt := AVE(GROUP,IF(In_Flagged.MEDICAID_NUMBER_Flag = SALT30.Flags.Equal,100,0));
    REAL4 MEDICAID_NUMBER_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.MEDICAID_NUMBER_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 MEDICAID_NUMBER_Bad_pcnt := AVE(GROUP,IF(In_Flagged.MEDICAID_NUMBER_Flag = SALT30.Flags.Bad,100,0));
    REAL4 MEDICAID_NUMBER_Missing_pcnt := AVE(GROUP,IF(In_Flagged.MEDICAID_NUMBER_Flag = SALT30.Flags.Missing,100,0));
    REAL4 MEDICAID_NUMBER_Relative_pcnt := AVE(GROUP,IF(In_Flagged.MEDICAID_NUMBER_Flag = SALT30.Flags.Relative,100,0));
    REAL4 MEDICAID_NUMBER_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.MEDICAID_NUMBER_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 MEDICAID_NUMBER_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.MEDICAID_NUMBER_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 MEDICAID_NUMBER_Owns_pcnt := AVE(GROUP,IF(In_Flagged.MEDICAID_NUMBER_Flag = SALT30.Flags.Owns,100,0));
  END;
EXPORT In_Flagged_Summary_BySrc := TABLE(In_Flagged,FlagTots,SRC,FEW);
// Append flags to the input file
  TYPEOF(h) NoteFlags(h le,b.BestBy_LNPID_Best ri) := TRANSFORM
    SELF.NPI_NUMBER_flag := MAP ( ri.NPI_NUMBER  IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER) => SALT30.Flags.Null,
      le.NPI_NUMBER  IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER) => SALT30.Flags.Missing,
      ri.NPI_NUMBER_owns => SALT30.Flags.Owns,
      le.NPI_NUMBER = ri.NPI_NUMBER => SALT30.Flags.Equal,
      SALT30.Flags.Bad);
    SELF.DEA_NUMBER_flag := MAP ( ri.DEA_NUMBER  IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER) => SALT30.Flags.Null,
      le.DEA_NUMBER  IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER) => SALT30.Flags.Missing,
      ri.DEA_NUMBER_owns => SALT30.Flags.Owns,
      le.DEA_NUMBER = ri.DEA_NUMBER => SALT30.Flags.Equal,
      SALT30.Flags.Bad);
    SELF.CLIA_NUMBER_flag := MAP ( ri.CLIA_NUMBER  IN SET(s.nulls_CLIA_NUMBER,CLIA_NUMBER) => SALT30.Flags.Null,
      le.CLIA_NUMBER  IN SET(s.nulls_CLIA_NUMBER,CLIA_NUMBER) => SALT30.Flags.Missing,
      ri.CLIA_NUMBER_owns => SALT30.Flags.Owns,
      le.CLIA_NUMBER = ri.CLIA_NUMBER => SALT30.Flags.Equal,
      SALT30.Flags.Bad);
    SELF.MEDICARE_FACILITY_NUMBER_flag := MAP ( ri.MEDICARE_FACILITY_NUMBER  IN SET(s.nulls_MEDICARE_FACILITY_NUMBER,MEDICARE_FACILITY_NUMBER) => SALT30.Flags.Null,
      le.MEDICARE_FACILITY_NUMBER  IN SET(s.nulls_MEDICARE_FACILITY_NUMBER,MEDICARE_FACILITY_NUMBER) => SALT30.Flags.Missing,
      ri.MEDICARE_FACILITY_NUMBER_owns => SALT30.Flags.Owns,
      le.MEDICARE_FACILITY_NUMBER = ri.MEDICARE_FACILITY_NUMBER => SALT30.Flags.Equal,
      SALT30.Flags.Bad);
    SELF.NCPDP_NUMBER_flag := MAP ( ri.NCPDP_NUMBER  IN SET(s.nulls_NCPDP_NUMBER,NCPDP_NUMBER) => SALT30.Flags.Null,
      le.NCPDP_NUMBER  IN SET(s.nulls_NCPDP_NUMBER,NCPDP_NUMBER) => SALT30.Flags.Missing,
      ri.NCPDP_NUMBER_owns => SALT30.Flags.Owns,
      le.NCPDP_NUMBER = ri.NCPDP_NUMBER => SALT30.Flags.Equal,
      SALT30.Flags.Bad);
    SELF.TAX_ID_flag := MAP ( ri.TAX_ID  IN SET(s.nulls_TAX_ID,TAX_ID) => SALT30.Flags.Null,
      le.TAX_ID  IN SET(s.nulls_TAX_ID,TAX_ID) => SALT30.Flags.Missing,
      ri.TAX_ID_owns => SALT30.Flags.Owns,
      le.TAX_ID = ri.TAX_ID => SALT30.Flags.Equal,
      SALT30.Flags.Bad);
    SELF.FEIN_flag := MAP ( ri.FEIN  IN SET(s.nulls_FEIN,FEIN) => SALT30.Flags.Null,
      le.FEIN  IN SET(s.nulls_FEIN,FEIN) => SALT30.Flags.Missing,
      ri.FEIN_owns => SALT30.Flags.Owns,
      le.FEIN = ri.FEIN => SALT30.Flags.Equal,
      SALT30.Flags.Bad);
    SELF.C_LIC_NBR_flag := MAP ( ri.C_LIC_NBR  IN SET(s.nulls_C_LIC_NBR,C_LIC_NBR) => SALT30.Flags.Null,
      le.C_LIC_NBR  IN SET(s.nulls_C_LIC_NBR,C_LIC_NBR) => SALT30.Flags.Missing,
      le.C_LIC_NBR = ri.C_LIC_NBR => SALT30.Flags.Equal,
      le.C_LIC_NBR = (TYPEOF(le.C_LIC_NBR))'' OR ri.C_LIC_NBR = (TYPEOF(ri.C_LIC_NBR))'' OR SALT30.WithinEditN(le.C_LIC_NBR,ri.C_LIC_NBR,1, 0)  => SALT30.Flags.Fuzzy,
      SALT30.Flags.Bad);
    SELF.MEDICAID_NUMBER_flag := MAP ( ri.MEDICAID_NUMBER  IN SET(s.nulls_MEDICAID_NUMBER,MEDICAID_NUMBER) => SALT30.Flags.Null,
      le.MEDICAID_NUMBER  IN SET(s.nulls_MEDICAID_NUMBER,MEDICAID_NUMBER) => SALT30.Flags.Missing,
      ri.MEDICAID_NUMBER_owns => SALT30.Flags.Owns,
      le.MEDICAID_NUMBER = ri.MEDICAID_NUMBER => SALT30.Flags.Equal,
      SALT30.Flags.Bad);
    SELF := le;
  END;
  j := JOIN(h,b.BestBy_LNPID_Best,LEFT.LNPID=RIGHT.LNPID,NoteFlags(LEFT,RIGHT),LEFT OUTER,HASH);
SHARED Input_Flagged0 := SORT(DISTRIBUTE(j,HASH(LNPID)),LNPID,LOCAL);
EXPORT Input_Flagged := Input_Flagged0;
END;
