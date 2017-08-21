// Begin code to append flags to the file
IMPORT SALT29,ut;
EXPORT Flags(DATASET(layout_HealthProvider) ih,layout_specificities.R s = Specificities(ih).specificities[1],BOOLEAN RoxieService=FALSE) := MODULE
  h00 := BasicMatch(ih).input_file;
SHARED h := IF(RoxieService,Specificities(ih).input_file_np,h00);
SHARED b := Best(ih);
// Append flags to the regular file
  TYPEOF(ih) NoteFlags(ih le,b.BestBy_LNPID_Best ri) := TRANSFORM
    SELF.DOB_flag := MAP ( ri.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND ri.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND ri.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) => SALT29.Flags.Null,
      ((UNSIGNED)le.DOB DIV 10000 )  IN SET(s.nulls_DOB_year,DOB_year) AND ((UNSIGNED)le.DOB DIV 100 % 100 )  IN SET(s.nulls_DOB_month,DOB_month) AND ((UNSIGNED)le.DOB % 100)  IN SET(s.nulls_DOB_day,DOB_day) => SALT29.Flags.Missing,
      ((UNSIGNED)le.DOB DIV 10000 ) = ri.DOB_year AND ((UNSIGNED)le.DOB DIV 100 % 100 ) = ri.DOB_month AND ((UNSIGNED)le.DOB % 100) = ri.DOB_day => SALT29.Flags.Equal,
      SALT29.MOD_DateMatch(((UNSIGNED)le.DOB DIV 10000 ),((UNSIGNED)le.DOB DIV 100 % 100 ),((UNSIGNED)le.DOB % 100),ri.DOB_year,ri.DOB_month,ri.DOB_day,true,true,12,true).NNEQ => SALT29.Flags.Fuzzy,
      SALT29.Flags.Bad);
    SELF.CNSMR_DOB_flag := MAP ( ri.CNSMR_DOB_year  IN SET(s.nulls_CNSMR_DOB_year,CNSMR_DOB_year) AND ri.CNSMR_DOB_month  IN SET(s.nulls_CNSMR_DOB_month,CNSMR_DOB_month) AND ri.CNSMR_DOB_day  IN SET(s.nulls_CNSMR_DOB_day,CNSMR_DOB_day) => SALT29.Flags.Null,
      ((UNSIGNED)le.CNSMR_DOB DIV 10000 )  IN SET(s.nulls_CNSMR_DOB_year,CNSMR_DOB_year) AND ((UNSIGNED)le.CNSMR_DOB DIV 100 % 100 )  IN SET(s.nulls_CNSMR_DOB_month,CNSMR_DOB_month) AND ((UNSIGNED)le.CNSMR_DOB % 100)  IN SET(s.nulls_CNSMR_DOB_day,CNSMR_DOB_day) => SALT29.Flags.Missing,
      ((UNSIGNED)le.CNSMR_DOB DIV 10000 ) = ri.CNSMR_DOB_year AND ((UNSIGNED)le.CNSMR_DOB DIV 100 % 100 ) = ri.CNSMR_DOB_month AND ((UNSIGNED)le.CNSMR_DOB % 100) = ri.CNSMR_DOB_day => SALT29.Flags.Equal,
      SALT29.MOD_DateMatch(((UNSIGNED)le.CNSMR_DOB DIV 10000 ),((UNSIGNED)le.CNSMR_DOB DIV 100 % 100 ),((UNSIGNED)le.CNSMR_DOB % 100),ri.CNSMR_DOB_year,ri.CNSMR_DOB_month,ri.CNSMR_DOB_day,true,true,12,true).NNEQ => SALT29.Flags.Fuzzy,
      SALT29.Flags.Bad);
    SELF.SSN_flag := MAP ( ri.SSN  IN SET(s.nulls_SSN,SSN) => SALT29.Flags.Null,
      le.SSN  IN SET(s.nulls_SSN,SSN) => SALT29.Flags.Missing,
      ri.SSN_owns => SALT29.Flags.Owns,
      le.SSN = ri.SSN => SALT29.Flags.Equal,
      le.SSN = (TYPEOF(le.SSN))'' OR ri.SSN = (TYPEOF(ri.SSN))'' OR SALT29.WithinEditN(le.SSN,ri.SSN,1, 0)  OR fn_Right4(ri.SSN) = fn_Right4(le.SSN)  => SALT29.Flags.Fuzzy,
      SALT29.Flags.Bad);
    SELF.CNSMR_SSN_flag := MAP ( ri.CNSMR_SSN  IN SET(s.nulls_CNSMR_SSN,CNSMR_SSN) => SALT29.Flags.Null,
      le.CNSMR_SSN  IN SET(s.nulls_CNSMR_SSN,CNSMR_SSN) => SALT29.Flags.Missing,
      ri.CNSMR_SSN_owns => SALT29.Flags.Owns,
      le.CNSMR_SSN = ri.CNSMR_SSN => SALT29.Flags.Equal,
      le.CNSMR_SSN = (TYPEOF(le.CNSMR_SSN))'' OR ri.CNSMR_SSN = (TYPEOF(ri.CNSMR_SSN))'' OR SALT29.WithinEditN(le.CNSMR_SSN,ri.CNSMR_SSN,1, 0)  OR fn_Right4(ri.CNSMR_SSN) = fn_Right4(le.CNSMR_SSN)  => SALT29.Flags.Fuzzy,
      SALT29.Flags.Bad);
    SELF.DID_flag := MAP ( ri.DID  IN SET(s.nulls_DID,DID) => SALT29.Flags.Null,
      le.DID  IN SET(s.nulls_DID,DID) => SALT29.Flags.Missing,
      le.DID = ri.DID => SALT29.Flags.Equal,
      SALT29.Flags.Bad);
    SELF.FNAME_flag := MAP ( ri.FNAME  IN SET(s.nulls_FNAME,FNAME) => SALT29.Flags.Null,
      le.FNAME  IN SET(s.nulls_FNAME,FNAME) => SALT29.Flags.Missing,
      le.FNAME = ri.FNAME => SALT29.Flags.Equal,
      le.FNAME[1..LENGTH(TRIM(ri.FNAME))] = ri.FNAME OR ri.FNAME[1..LENGTH(TRIM(le.FNAME))] = le.FNAME OR SALT29.WithinEditN(le.FNAME,ri.FNAME,1, 0)  OR fn_PreferredName(ri.FNAME) = fn_PreferredName(le.FNAME)  => SALT29.Flags.Fuzzy,
      SALT29.Flags.Bad);
    SELF.MNAME_flag := MAP ( ri.MNAME  IN SET(s.nulls_MNAME,MNAME) => SALT29.Flags.Null,
      le.MNAME  IN SET(s.nulls_MNAME,MNAME) => SALT29.Flags.Missing,
      le.MNAME = ri.MNAME => SALT29.Flags.Equal,
      le.MNAME[1..LENGTH(TRIM(ri.MNAME))] = ri.MNAME OR ri.MNAME[1..LENGTH(TRIM(le.MNAME))] = le.MNAME OR SALT29.WithinEditN(le.MNAME,ri.MNAME,2, 0)  => SALT29.Flags.Fuzzy,
      SALT29.Flags.Bad);
    SELF.LNAME_flag := MAP ( ri.LNAME  IN SET(s.nulls_LNAME,LNAME) => SALT29.Flags.Null,
      le.LNAME  IN SET(s.nulls_LNAME,LNAME) => SALT29.Flags.Missing,
      le.LNAME = ri.LNAME => SALT29.Flags.Equal,
      le.LNAME[1..LENGTH(TRIM(ri.LNAME))] = ri.LNAME OR ri.LNAME[1..LENGTH(TRIM(le.LNAME))] = le.LNAME OR SALT29.WithinEditN(le.LNAME,ri.LNAME,2, 0) OR SALT29.HyphenMatch(le.LNAME,ri.LNAME,1)<=2  => SALT29.Flags.Fuzzy,
      SALT29.Flags.Bad);
    SELF.LIC_NBR_flag := MAP ( ri.LIC_NBR  IN SET(s.nulls_LIC_NBR,LIC_NBR) => SALT29.Flags.Null,
      le.LIC_NBR  IN SET(s.nulls_LIC_NBR,LIC_NBR) => SALT29.Flags.Missing,
      le.LIC_NBR = ri.LIC_NBR => SALT29.Flags.Equal,
      le.LIC_NBR = (TYPEOF(le.LIC_NBR))'' OR ri.LIC_NBR = (TYPEOF(ri.LIC_NBR))'' OR SALT29.WithinEditN(le.LIC_NBR,ri.LIC_NBR,1, 0)  => SALT29.Flags.Fuzzy,
      SALT29.Flags.Bad);
    SELF.C_LIC_NBR_flag := MAP ( ri.C_LIC_NBR  IN SET(s.nulls_C_LIC_NBR,C_LIC_NBR) => SALT29.Flags.Null,
      le.C_LIC_NBR  IN SET(s.nulls_C_LIC_NBR,C_LIC_NBR) => SALT29.Flags.Missing,
      le.C_LIC_NBR = ri.C_LIC_NBR => SALT29.Flags.Equal,
      le.C_LIC_NBR = (TYPEOF(le.C_LIC_NBR))'' OR ri.C_LIC_NBR = (TYPEOF(ri.C_LIC_NBR))'' OR SALT29.WithinEditN(le.C_LIC_NBR,ri.C_LIC_NBR,1, 0)  => SALT29.Flags.Fuzzy,
      SALT29.Flags.Bad);
    SELF.TAX_ID_flag := MAP ( ri.TAX_ID  IN SET(s.nulls_TAX_ID,TAX_ID) => SALT29.Flags.Null,
      le.TAX_ID  IN SET(s.nulls_TAX_ID,TAX_ID) => SALT29.Flags.Missing,
      ri.TAX_ID_owns => SALT29.Flags.Owns,
      le.TAX_ID = ri.TAX_ID => SALT29.Flags.Equal,
      SALT29.Flags.Bad);
    SELF.BILLING_TAX_ID_flag := MAP ( ri.BILLING_TAX_ID  IN SET(s.nulls_BILLING_TAX_ID,BILLING_TAX_ID) => SALT29.Flags.Null,
      le.BILLING_TAX_ID  IN SET(s.nulls_BILLING_TAX_ID,BILLING_TAX_ID) => SALT29.Flags.Missing,
      ri.BILLING_TAX_ID_owns => SALT29.Flags.Owns,
      le.BILLING_TAX_ID = ri.BILLING_TAX_ID => SALT29.Flags.Equal,
      SALT29.Flags.Bad);
    SELF.UPIN_flag := MAP ( ri.UPIN  IN SET(s.nulls_UPIN,UPIN) => SALT29.Flags.Null,
      le.UPIN  IN SET(s.nulls_UPIN,UPIN) => SALT29.Flags.Missing,
      ri.UPIN_owns => SALT29.Flags.Owns,
      le.UPIN = ri.UPIN => SALT29.Flags.Equal,
      SALT29.Flags.Bad);
    SELF.NPI_NUMBER_flag := MAP ( ri.NPI_NUMBER  IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER) => SALT29.Flags.Null,
      le.NPI_NUMBER  IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER) => SALT29.Flags.Missing,
      ri.NPI_NUMBER_owns => SALT29.Flags.Owns,
      le.NPI_NUMBER = ri.NPI_NUMBER => SALT29.Flags.Equal,
      SALT29.Flags.Bad);
    SELF.BILLING_NPI_NUMBER_flag := MAP ( ri.BILLING_NPI_NUMBER  IN SET(s.nulls_BILLING_NPI_NUMBER,BILLING_NPI_NUMBER) => SALT29.Flags.Null,
      le.BILLING_NPI_NUMBER  IN SET(s.nulls_BILLING_NPI_NUMBER,BILLING_NPI_NUMBER) => SALT29.Flags.Missing,
      ri.BILLING_NPI_NUMBER_owns => SALT29.Flags.Owns,
      le.BILLING_NPI_NUMBER = ri.BILLING_NPI_NUMBER => SALT29.Flags.Equal,
      SALT29.Flags.Bad);
    SELF.DEA_NUMBER_flag := MAP ( ri.DEA_NUMBER  IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER) => SALT29.Flags.Null,
      le.DEA_NUMBER  IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER) => SALT29.Flags.Missing,
      ri.DEA_NUMBER_owns => SALT29.Flags.Owns,
      le.DEA_NUMBER = ri.DEA_NUMBER => SALT29.Flags.Equal,
      SALT29.Flags.Bad);
    SELF.TAXONOMY_flag := MAP ( ri.TAXONOMY  IN SET(s.nulls_TAXONOMY,TAXONOMY) => SALT29.Flags.Null,
      le.TAXONOMY  IN SET(s.nulls_TAXONOMY,TAXONOMY) => SALT29.Flags.Missing,
      ri.TAXONOMY_owns => SALT29.Flags.Owns,
      le.TAXONOMY = ri.TAXONOMY => SALT29.Flags.Equal,
      SALT29.Flags.Bad);
    SELF := le;
  END;
  j := JOIN(ih,b.BestBy_LNPID_Best,LEFT.LNPID=RIGHT.LNPID,NoteFlags(LEFT,RIGHT),LEFT OUTER,HASH);
  j1 := JOIN (J,b.BestBy_LNPID__LIC_STATE_best,LEFT.LNPID = RIGHT.LNPID AND LEFT.LIC_STATE = RIGHT.LIC_STATE AND LEFT.C_LIC_NBR = RIGHT.C_LIC_NBR,TRANSFORM(RECORDOF(J), SELF.C_LIC_NBR_flag := IF (LEFT.C_LIC_NBR = RIGHT.C_LIC_NBR AND LEFT.LIC_STATE = RIGHT.LIC_STATE AND LEFT.LNPID = RIGHT.LNPID,SALT29.Flags.Equal,LEFT.C_LIC_NBR_flag); SELF := LEFT;),LEFT OUTER, HASH);				
SHARED In_Flagged0 := SORT(DISTRIBUTE(j1,HASH(LNPID)),LNPID,LOCAL);
EXPORT In_Flagged := In_Flagged0;
  FlagTots := RECORD
    UNSIGNED Cnt := COUNT(GROUP);
    REAL4 DOB_Null_pcnt := AVE(GROUP,IF(In_Flagged.DOB_Flag = SALT29.Flags.Null,100,0));
    REAL4 DOB_Equal_pcnt := AVE(GROUP,IF(In_Flagged.DOB_Flag = SALT29.Flags.Equal,100,0));
    REAL4 DOB_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.DOB_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 DOB_Bad_pcnt := AVE(GROUP,IF(In_Flagged.DOB_Flag = SALT29.Flags.Bad,100,0));
    REAL4 DOB_Missing_pcnt := AVE(GROUP,IF(In_Flagged.DOB_Flag = SALT29.Flags.Missing,100,0));
    REAL4 DOB_Relative_pcnt := AVE(GROUP,IF(In_Flagged.DOB_Flag = SALT29.Flags.Relative,100,0));
    REAL4 DOB_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.DOB_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 DOB_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.DOB_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 CNSMR_DOB_Null_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_DOB_Flag = SALT29.Flags.Null,100,0));
    REAL4 CNSMR_DOB_Equal_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_DOB_Flag = SALT29.Flags.Equal,100,0));
    REAL4 CNSMR_DOB_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_DOB_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 CNSMR_DOB_Bad_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_DOB_Flag = SALT29.Flags.Bad,100,0));
    REAL4 CNSMR_DOB_Missing_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_DOB_Flag = SALT29.Flags.Missing,100,0));
    REAL4 CNSMR_DOB_Relative_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_DOB_Flag = SALT29.Flags.Relative,100,0));
    REAL4 CNSMR_DOB_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_DOB_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 CNSMR_DOB_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_DOB_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 SSN_Null_pcnt := AVE(GROUP,IF(In_Flagged.SSN_Flag = SALT29.Flags.Null,100,0));
    REAL4 SSN_Equal_pcnt := AVE(GROUP,IF(In_Flagged.SSN_Flag = SALT29.Flags.Equal,100,0));
    REAL4 SSN_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.SSN_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 SSN_Bad_pcnt := AVE(GROUP,IF(In_Flagged.SSN_Flag = SALT29.Flags.Bad,100,0));
    REAL4 SSN_Missing_pcnt := AVE(GROUP,IF(In_Flagged.SSN_Flag = SALT29.Flags.Missing,100,0));
    REAL4 SSN_Relative_pcnt := AVE(GROUP,IF(In_Flagged.SSN_Flag = SALT29.Flags.Relative,100,0));
    REAL4 SSN_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.SSN_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 SSN_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.SSN_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 SSN_Owns_pcnt := AVE(GROUP,IF(In_Flagged.SSN_Flag = SALT29.Flags.Owns,100,0));
    REAL4 CNSMR_SSN_Null_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_SSN_Flag = SALT29.Flags.Null,100,0));
    REAL4 CNSMR_SSN_Equal_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_SSN_Flag = SALT29.Flags.Equal,100,0));
    REAL4 CNSMR_SSN_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_SSN_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 CNSMR_SSN_Bad_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_SSN_Flag = SALT29.Flags.Bad,100,0));
    REAL4 CNSMR_SSN_Missing_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_SSN_Flag = SALT29.Flags.Missing,100,0));
    REAL4 CNSMR_SSN_Relative_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_SSN_Flag = SALT29.Flags.Relative,100,0));
    REAL4 CNSMR_SSN_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_SSN_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 CNSMR_SSN_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_SSN_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 CNSMR_SSN_Owns_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_SSN_Flag = SALT29.Flags.Owns,100,0));
    REAL4 DID_Null_pcnt := AVE(GROUP,IF(In_Flagged.DID_Flag = SALT29.Flags.Null,100,0));
    REAL4 DID_Equal_pcnt := AVE(GROUP,IF(In_Flagged.DID_Flag = SALT29.Flags.Equal,100,0));
    REAL4 DID_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.DID_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 DID_Bad_pcnt := AVE(GROUP,IF(In_Flagged.DID_Flag = SALT29.Flags.Bad,100,0));
    REAL4 DID_Missing_pcnt := AVE(GROUP,IF(In_Flagged.DID_Flag = SALT29.Flags.Missing,100,0));
    REAL4 DID_Relative_pcnt := AVE(GROUP,IF(In_Flagged.DID_Flag = SALT29.Flags.Relative,100,0));
    REAL4 DID_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.DID_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 DID_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.DID_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 FNAME_Null_pcnt := AVE(GROUP,IF(In_Flagged.FNAME_Flag = SALT29.Flags.Null,100,0));
    REAL4 FNAME_Equal_pcnt := AVE(GROUP,IF(In_Flagged.FNAME_Flag = SALT29.Flags.Equal,100,0));
    REAL4 FNAME_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.FNAME_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 FNAME_Bad_pcnt := AVE(GROUP,IF(In_Flagged.FNAME_Flag = SALT29.Flags.Bad,100,0));
    REAL4 FNAME_Missing_pcnt := AVE(GROUP,IF(In_Flagged.FNAME_Flag = SALT29.Flags.Missing,100,0));
    REAL4 FNAME_Relative_pcnt := AVE(GROUP,IF(In_Flagged.FNAME_Flag = SALT29.Flags.Relative,100,0));
    REAL4 FNAME_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.FNAME_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 FNAME_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.FNAME_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 MNAME_Null_pcnt := AVE(GROUP,IF(In_Flagged.MNAME_Flag = SALT29.Flags.Null,100,0));
    REAL4 MNAME_Equal_pcnt := AVE(GROUP,IF(In_Flagged.MNAME_Flag = SALT29.Flags.Equal,100,0));
    REAL4 MNAME_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.MNAME_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 MNAME_Bad_pcnt := AVE(GROUP,IF(In_Flagged.MNAME_Flag = SALT29.Flags.Bad,100,0));
    REAL4 MNAME_Missing_pcnt := AVE(GROUP,IF(In_Flagged.MNAME_Flag = SALT29.Flags.Missing,100,0));
    REAL4 MNAME_Relative_pcnt := AVE(GROUP,IF(In_Flagged.MNAME_Flag = SALT29.Flags.Relative,100,0));
    REAL4 MNAME_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.MNAME_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 MNAME_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.MNAME_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 LNAME_Null_pcnt := AVE(GROUP,IF(In_Flagged.LNAME_Flag = SALT29.Flags.Null,100,0));
    REAL4 LNAME_Equal_pcnt := AVE(GROUP,IF(In_Flagged.LNAME_Flag = SALT29.Flags.Equal,100,0));
    REAL4 LNAME_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.LNAME_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 LNAME_Bad_pcnt := AVE(GROUP,IF(In_Flagged.LNAME_Flag = SALT29.Flags.Bad,100,0));
    REAL4 LNAME_Missing_pcnt := AVE(GROUP,IF(In_Flagged.LNAME_Flag = SALT29.Flags.Missing,100,0));
    REAL4 LNAME_Relative_pcnt := AVE(GROUP,IF(In_Flagged.LNAME_Flag = SALT29.Flags.Relative,100,0));
    REAL4 LNAME_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.LNAME_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 LNAME_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.LNAME_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 LIC_NBR_Null_pcnt := AVE(GROUP,IF(In_Flagged.LIC_NBR_Flag = SALT29.Flags.Null,100,0));
    REAL4 LIC_NBR_Equal_pcnt := AVE(GROUP,IF(In_Flagged.LIC_NBR_Flag = SALT29.Flags.Equal,100,0));
    REAL4 LIC_NBR_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.LIC_NBR_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 LIC_NBR_Bad_pcnt := AVE(GROUP,IF(In_Flagged.LIC_NBR_Flag = SALT29.Flags.Bad,100,0));
    REAL4 LIC_NBR_Missing_pcnt := AVE(GROUP,IF(In_Flagged.LIC_NBR_Flag = SALT29.Flags.Missing,100,0));
    REAL4 LIC_NBR_Relative_pcnt := AVE(GROUP,IF(In_Flagged.LIC_NBR_Flag = SALT29.Flags.Relative,100,0));
    REAL4 LIC_NBR_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.LIC_NBR_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 LIC_NBR_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.LIC_NBR_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 C_LIC_NBR_Null_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT29.Flags.Null,100,0));
    REAL4 C_LIC_NBR_Equal_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT29.Flags.Equal,100,0));
    REAL4 C_LIC_NBR_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 C_LIC_NBR_Bad_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT29.Flags.Bad,100,0));
    REAL4 C_LIC_NBR_Missing_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT29.Flags.Missing,100,0));
    REAL4 C_LIC_NBR_Relative_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT29.Flags.Relative,100,0));
    REAL4 C_LIC_NBR_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 C_LIC_NBR_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 TAX_ID_Null_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT29.Flags.Null,100,0));
    REAL4 TAX_ID_Equal_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT29.Flags.Equal,100,0));
    REAL4 TAX_ID_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 TAX_ID_Bad_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT29.Flags.Bad,100,0));
    REAL4 TAX_ID_Missing_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT29.Flags.Missing,100,0));
    REAL4 TAX_ID_Relative_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT29.Flags.Relative,100,0));
    REAL4 TAX_ID_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 TAX_ID_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 TAX_ID_Owns_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT29.Flags.Owns,100,0));
    REAL4 BILLING_TAX_ID_Null_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_TAX_ID_Flag = SALT29.Flags.Null,100,0));
    REAL4 BILLING_TAX_ID_Equal_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_TAX_ID_Flag = SALT29.Flags.Equal,100,0));
    REAL4 BILLING_TAX_ID_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_TAX_ID_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 BILLING_TAX_ID_Bad_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_TAX_ID_Flag = SALT29.Flags.Bad,100,0));
    REAL4 BILLING_TAX_ID_Missing_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_TAX_ID_Flag = SALT29.Flags.Missing,100,0));
    REAL4 BILLING_TAX_ID_Relative_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_TAX_ID_Flag = SALT29.Flags.Relative,100,0));
    REAL4 BILLING_TAX_ID_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_TAX_ID_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 BILLING_TAX_ID_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_TAX_ID_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 BILLING_TAX_ID_Owns_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_TAX_ID_Flag = SALT29.Flags.Owns,100,0));
    REAL4 UPIN_Null_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT29.Flags.Null,100,0));
    REAL4 UPIN_Equal_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT29.Flags.Equal,100,0));
    REAL4 UPIN_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 UPIN_Bad_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT29.Flags.Bad,100,0));
    REAL4 UPIN_Missing_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT29.Flags.Missing,100,0));
    REAL4 UPIN_Relative_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT29.Flags.Relative,100,0));
    REAL4 UPIN_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 UPIN_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 UPIN_Owns_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT29.Flags.Owns,100,0));
    REAL4 NPI_NUMBER_Null_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT29.Flags.Null,100,0));
    REAL4 NPI_NUMBER_Equal_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT29.Flags.Equal,100,0));
    REAL4 NPI_NUMBER_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 NPI_NUMBER_Bad_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT29.Flags.Bad,100,0));
    REAL4 NPI_NUMBER_Missing_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT29.Flags.Missing,100,0));
    REAL4 NPI_NUMBER_Relative_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT29.Flags.Relative,100,0));
    REAL4 NPI_NUMBER_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 NPI_NUMBER_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 NPI_NUMBER_Owns_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT29.Flags.Owns,100,0));
    REAL4 BILLING_NPI_NUMBER_Null_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_NPI_NUMBER_Flag = SALT29.Flags.Null,100,0));
    REAL4 BILLING_NPI_NUMBER_Equal_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_NPI_NUMBER_Flag = SALT29.Flags.Equal,100,0));
    REAL4 BILLING_NPI_NUMBER_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_NPI_NUMBER_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 BILLING_NPI_NUMBER_Bad_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_NPI_NUMBER_Flag = SALT29.Flags.Bad,100,0));
    REAL4 BILLING_NPI_NUMBER_Missing_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_NPI_NUMBER_Flag = SALT29.Flags.Missing,100,0));
    REAL4 BILLING_NPI_NUMBER_Relative_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_NPI_NUMBER_Flag = SALT29.Flags.Relative,100,0));
    REAL4 BILLING_NPI_NUMBER_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_NPI_NUMBER_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 BILLING_NPI_NUMBER_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_NPI_NUMBER_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 BILLING_NPI_NUMBER_Owns_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_NPI_NUMBER_Flag = SALT29.Flags.Owns,100,0));
    REAL4 DEA_NUMBER_Null_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT29.Flags.Null,100,0));
    REAL4 DEA_NUMBER_Equal_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT29.Flags.Equal,100,0));
    REAL4 DEA_NUMBER_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 DEA_NUMBER_Bad_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT29.Flags.Bad,100,0));
    REAL4 DEA_NUMBER_Missing_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT29.Flags.Missing,100,0));
    REAL4 DEA_NUMBER_Relative_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT29.Flags.Relative,100,0));
    REAL4 DEA_NUMBER_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 DEA_NUMBER_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 DEA_NUMBER_Owns_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT29.Flags.Owns,100,0));
    REAL4 TAXONOMY_Null_pcnt := AVE(GROUP,IF(In_Flagged.TAXONOMY_Flag = SALT29.Flags.Null,100,0));
    REAL4 TAXONOMY_Equal_pcnt := AVE(GROUP,IF(In_Flagged.TAXONOMY_Flag = SALT29.Flags.Equal,100,0));
    REAL4 TAXONOMY_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.TAXONOMY_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 TAXONOMY_Bad_pcnt := AVE(GROUP,IF(In_Flagged.TAXONOMY_Flag = SALT29.Flags.Bad,100,0));
    REAL4 TAXONOMY_Missing_pcnt := AVE(GROUP,IF(In_Flagged.TAXONOMY_Flag = SALT29.Flags.Missing,100,0));
    REAL4 TAXONOMY_Relative_pcnt := AVE(GROUP,IF(In_Flagged.TAXONOMY_Flag = SALT29.Flags.Relative,100,0));
    REAL4 TAXONOMY_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.TAXONOMY_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 TAXONOMY_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.TAXONOMY_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 TAXONOMY_Owns_pcnt := AVE(GROUP,IF(In_Flagged.TAXONOMY_Flag = SALT29.Flags.Owns,100,0));
  END;
EXPORT In_Flagged_Summary := TABLE(In_Flagged,FlagTots); // Global summary
  FlagTots := RECORD
    In_Flagged.SRC; // Group by sourcefield    UNSIGNED Cnt := COUNT(GROUP);
    REAL4 DOB_Null_pcnt := AVE(GROUP,IF(In_Flagged.DOB_Flag = SALT29.Flags.Null,100,0));
    REAL4 DOB_Equal_pcnt := AVE(GROUP,IF(In_Flagged.DOB_Flag = SALT29.Flags.Equal,100,0));
    REAL4 DOB_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.DOB_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 DOB_Bad_pcnt := AVE(GROUP,IF(In_Flagged.DOB_Flag = SALT29.Flags.Bad,100,0));
    REAL4 DOB_Missing_pcnt := AVE(GROUP,IF(In_Flagged.DOB_Flag = SALT29.Flags.Missing,100,0));
    REAL4 DOB_Relative_pcnt := AVE(GROUP,IF(In_Flagged.DOB_Flag = SALT29.Flags.Relative,100,0));
    REAL4 DOB_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.DOB_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 DOB_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.DOB_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 CNSMR_DOB_Null_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_DOB_Flag = SALT29.Flags.Null,100,0));
    REAL4 CNSMR_DOB_Equal_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_DOB_Flag = SALT29.Flags.Equal,100,0));
    REAL4 CNSMR_DOB_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_DOB_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 CNSMR_DOB_Bad_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_DOB_Flag = SALT29.Flags.Bad,100,0));
    REAL4 CNSMR_DOB_Missing_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_DOB_Flag = SALT29.Flags.Missing,100,0));
    REAL4 CNSMR_DOB_Relative_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_DOB_Flag = SALT29.Flags.Relative,100,0));
    REAL4 CNSMR_DOB_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_DOB_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 CNSMR_DOB_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_DOB_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 SSN_Null_pcnt := AVE(GROUP,IF(In_Flagged.SSN_Flag = SALT29.Flags.Null,100,0));
    REAL4 SSN_Equal_pcnt := AVE(GROUP,IF(In_Flagged.SSN_Flag = SALT29.Flags.Equal,100,0));
    REAL4 SSN_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.SSN_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 SSN_Bad_pcnt := AVE(GROUP,IF(In_Flagged.SSN_Flag = SALT29.Flags.Bad,100,0));
    REAL4 SSN_Missing_pcnt := AVE(GROUP,IF(In_Flagged.SSN_Flag = SALT29.Flags.Missing,100,0));
    REAL4 SSN_Relative_pcnt := AVE(GROUP,IF(In_Flagged.SSN_Flag = SALT29.Flags.Relative,100,0));
    REAL4 SSN_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.SSN_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 SSN_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.SSN_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 SSN_Owns_pcnt := AVE(GROUP,IF(In_Flagged.SSN_Flag = SALT29.Flags.Owns,100,0));
    REAL4 CNSMR_SSN_Null_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_SSN_Flag = SALT29.Flags.Null,100,0));
    REAL4 CNSMR_SSN_Equal_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_SSN_Flag = SALT29.Flags.Equal,100,0));
    REAL4 CNSMR_SSN_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_SSN_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 CNSMR_SSN_Bad_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_SSN_Flag = SALT29.Flags.Bad,100,0));
    REAL4 CNSMR_SSN_Missing_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_SSN_Flag = SALT29.Flags.Missing,100,0));
    REAL4 CNSMR_SSN_Relative_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_SSN_Flag = SALT29.Flags.Relative,100,0));
    REAL4 CNSMR_SSN_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_SSN_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 CNSMR_SSN_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_SSN_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 CNSMR_SSN_Owns_pcnt := AVE(GROUP,IF(In_Flagged.CNSMR_SSN_Flag = SALT29.Flags.Owns,100,0));
    REAL4 DID_Null_pcnt := AVE(GROUP,IF(In_Flagged.DID_Flag = SALT29.Flags.Null,100,0));
    REAL4 DID_Equal_pcnt := AVE(GROUP,IF(In_Flagged.DID_Flag = SALT29.Flags.Equal,100,0));
    REAL4 DID_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.DID_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 DID_Bad_pcnt := AVE(GROUP,IF(In_Flagged.DID_Flag = SALT29.Flags.Bad,100,0));
    REAL4 DID_Missing_pcnt := AVE(GROUP,IF(In_Flagged.DID_Flag = SALT29.Flags.Missing,100,0));
    REAL4 DID_Relative_pcnt := AVE(GROUP,IF(In_Flagged.DID_Flag = SALT29.Flags.Relative,100,0));
    REAL4 DID_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.DID_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 DID_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.DID_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 FNAME_Null_pcnt := AVE(GROUP,IF(In_Flagged.FNAME_Flag = SALT29.Flags.Null,100,0));
    REAL4 FNAME_Equal_pcnt := AVE(GROUP,IF(In_Flagged.FNAME_Flag = SALT29.Flags.Equal,100,0));
    REAL4 FNAME_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.FNAME_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 FNAME_Bad_pcnt := AVE(GROUP,IF(In_Flagged.FNAME_Flag = SALT29.Flags.Bad,100,0));
    REAL4 FNAME_Missing_pcnt := AVE(GROUP,IF(In_Flagged.FNAME_Flag = SALT29.Flags.Missing,100,0));
    REAL4 FNAME_Relative_pcnt := AVE(GROUP,IF(In_Flagged.FNAME_Flag = SALT29.Flags.Relative,100,0));
    REAL4 FNAME_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.FNAME_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 FNAME_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.FNAME_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 MNAME_Null_pcnt := AVE(GROUP,IF(In_Flagged.MNAME_Flag = SALT29.Flags.Null,100,0));
    REAL4 MNAME_Equal_pcnt := AVE(GROUP,IF(In_Flagged.MNAME_Flag = SALT29.Flags.Equal,100,0));
    REAL4 MNAME_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.MNAME_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 MNAME_Bad_pcnt := AVE(GROUP,IF(In_Flagged.MNAME_Flag = SALT29.Flags.Bad,100,0));
    REAL4 MNAME_Missing_pcnt := AVE(GROUP,IF(In_Flagged.MNAME_Flag = SALT29.Flags.Missing,100,0));
    REAL4 MNAME_Relative_pcnt := AVE(GROUP,IF(In_Flagged.MNAME_Flag = SALT29.Flags.Relative,100,0));
    REAL4 MNAME_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.MNAME_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 MNAME_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.MNAME_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 LNAME_Null_pcnt := AVE(GROUP,IF(In_Flagged.LNAME_Flag = SALT29.Flags.Null,100,0));
    REAL4 LNAME_Equal_pcnt := AVE(GROUP,IF(In_Flagged.LNAME_Flag = SALT29.Flags.Equal,100,0));
    REAL4 LNAME_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.LNAME_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 LNAME_Bad_pcnt := AVE(GROUP,IF(In_Flagged.LNAME_Flag = SALT29.Flags.Bad,100,0));
    REAL4 LNAME_Missing_pcnt := AVE(GROUP,IF(In_Flagged.LNAME_Flag = SALT29.Flags.Missing,100,0));
    REAL4 LNAME_Relative_pcnt := AVE(GROUP,IF(In_Flagged.LNAME_Flag = SALT29.Flags.Relative,100,0));
    REAL4 LNAME_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.LNAME_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 LNAME_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.LNAME_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 LIC_NBR_Null_pcnt := AVE(GROUP,IF(In_Flagged.LIC_NBR_Flag = SALT29.Flags.Null,100,0));
    REAL4 LIC_NBR_Equal_pcnt := AVE(GROUP,IF(In_Flagged.LIC_NBR_Flag = SALT29.Flags.Equal,100,0));
    REAL4 LIC_NBR_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.LIC_NBR_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 LIC_NBR_Bad_pcnt := AVE(GROUP,IF(In_Flagged.LIC_NBR_Flag = SALT29.Flags.Bad,100,0));
    REAL4 LIC_NBR_Missing_pcnt := AVE(GROUP,IF(In_Flagged.LIC_NBR_Flag = SALT29.Flags.Missing,100,0));
    REAL4 LIC_NBR_Relative_pcnt := AVE(GROUP,IF(In_Flagged.LIC_NBR_Flag = SALT29.Flags.Relative,100,0));
    REAL4 LIC_NBR_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.LIC_NBR_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 LIC_NBR_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.LIC_NBR_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 C_LIC_NBR_Null_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT29.Flags.Null,100,0));
    REAL4 C_LIC_NBR_Equal_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT29.Flags.Equal,100,0));
    REAL4 C_LIC_NBR_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 C_LIC_NBR_Bad_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT29.Flags.Bad,100,0));
    REAL4 C_LIC_NBR_Missing_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT29.Flags.Missing,100,0));
    REAL4 C_LIC_NBR_Relative_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT29.Flags.Relative,100,0));
    REAL4 C_LIC_NBR_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 C_LIC_NBR_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.C_LIC_NBR_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 TAX_ID_Null_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT29.Flags.Null,100,0));
    REAL4 TAX_ID_Equal_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT29.Flags.Equal,100,0));
    REAL4 TAX_ID_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 TAX_ID_Bad_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT29.Flags.Bad,100,0));
    REAL4 TAX_ID_Missing_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT29.Flags.Missing,100,0));
    REAL4 TAX_ID_Relative_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT29.Flags.Relative,100,0));
    REAL4 TAX_ID_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 TAX_ID_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 TAX_ID_Owns_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT29.Flags.Owns,100,0));
    REAL4 BILLING_TAX_ID_Null_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_TAX_ID_Flag = SALT29.Flags.Null,100,0));
    REAL4 BILLING_TAX_ID_Equal_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_TAX_ID_Flag = SALT29.Flags.Equal,100,0));
    REAL4 BILLING_TAX_ID_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_TAX_ID_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 BILLING_TAX_ID_Bad_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_TAX_ID_Flag = SALT29.Flags.Bad,100,0));
    REAL4 BILLING_TAX_ID_Missing_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_TAX_ID_Flag = SALT29.Flags.Missing,100,0));
    REAL4 BILLING_TAX_ID_Relative_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_TAX_ID_Flag = SALT29.Flags.Relative,100,0));
    REAL4 BILLING_TAX_ID_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_TAX_ID_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 BILLING_TAX_ID_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_TAX_ID_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 BILLING_TAX_ID_Owns_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_TAX_ID_Flag = SALT29.Flags.Owns,100,0));
    REAL4 UPIN_Null_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT29.Flags.Null,100,0));
    REAL4 UPIN_Equal_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT29.Flags.Equal,100,0));
    REAL4 UPIN_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 UPIN_Bad_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT29.Flags.Bad,100,0));
    REAL4 UPIN_Missing_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT29.Flags.Missing,100,0));
    REAL4 UPIN_Relative_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT29.Flags.Relative,100,0));
    REAL4 UPIN_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 UPIN_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 UPIN_Owns_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT29.Flags.Owns,100,0));
    REAL4 NPI_NUMBER_Null_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT29.Flags.Null,100,0));
    REAL4 NPI_NUMBER_Equal_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT29.Flags.Equal,100,0));
    REAL4 NPI_NUMBER_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 NPI_NUMBER_Bad_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT29.Flags.Bad,100,0));
    REAL4 NPI_NUMBER_Missing_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT29.Flags.Missing,100,0));
    REAL4 NPI_NUMBER_Relative_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT29.Flags.Relative,100,0));
    REAL4 NPI_NUMBER_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 NPI_NUMBER_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 NPI_NUMBER_Owns_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT29.Flags.Owns,100,0));
    REAL4 BILLING_NPI_NUMBER_Null_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_NPI_NUMBER_Flag = SALT29.Flags.Null,100,0));
    REAL4 BILLING_NPI_NUMBER_Equal_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_NPI_NUMBER_Flag = SALT29.Flags.Equal,100,0));
    REAL4 BILLING_NPI_NUMBER_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_NPI_NUMBER_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 BILLING_NPI_NUMBER_Bad_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_NPI_NUMBER_Flag = SALT29.Flags.Bad,100,0));
    REAL4 BILLING_NPI_NUMBER_Missing_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_NPI_NUMBER_Flag = SALT29.Flags.Missing,100,0));
    REAL4 BILLING_NPI_NUMBER_Relative_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_NPI_NUMBER_Flag = SALT29.Flags.Relative,100,0));
    REAL4 BILLING_NPI_NUMBER_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_NPI_NUMBER_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 BILLING_NPI_NUMBER_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_NPI_NUMBER_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 BILLING_NPI_NUMBER_Owns_pcnt := AVE(GROUP,IF(In_Flagged.BILLING_NPI_NUMBER_Flag = SALT29.Flags.Owns,100,0));
    REAL4 DEA_NUMBER_Null_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT29.Flags.Null,100,0));
    REAL4 DEA_NUMBER_Equal_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT29.Flags.Equal,100,0));
    REAL4 DEA_NUMBER_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 DEA_NUMBER_Bad_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT29.Flags.Bad,100,0));
    REAL4 DEA_NUMBER_Missing_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT29.Flags.Missing,100,0));
    REAL4 DEA_NUMBER_Relative_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT29.Flags.Relative,100,0));
    REAL4 DEA_NUMBER_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 DEA_NUMBER_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 DEA_NUMBER_Owns_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT29.Flags.Owns,100,0));
    REAL4 TAXONOMY_Null_pcnt := AVE(GROUP,IF(In_Flagged.TAXONOMY_Flag = SALT29.Flags.Null,100,0));
    REAL4 TAXONOMY_Equal_pcnt := AVE(GROUP,IF(In_Flagged.TAXONOMY_Flag = SALT29.Flags.Equal,100,0));
    REAL4 TAXONOMY_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.TAXONOMY_Flag = SALT29.Flags.Fuzzy,100,0));
    REAL4 TAXONOMY_Bad_pcnt := AVE(GROUP,IF(In_Flagged.TAXONOMY_Flag = SALT29.Flags.Bad,100,0));
    REAL4 TAXONOMY_Missing_pcnt := AVE(GROUP,IF(In_Flagged.TAXONOMY_Flag = SALT29.Flags.Missing,100,0));
    REAL4 TAXONOMY_Relative_pcnt := AVE(GROUP,IF(In_Flagged.TAXONOMY_Flag = SALT29.Flags.Relative,100,0));
    REAL4 TAXONOMY_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.TAXONOMY_Flag = SALT29.Flags.Relative_Possible,100,0));
    REAL4 TAXONOMY_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.TAXONOMY_Flag = SALT29.Flags.Relative_Fuzzy,100,0));
    REAL4 TAXONOMY_Owns_pcnt := AVE(GROUP,IF(In_Flagged.TAXONOMY_Flag = SALT29.Flags.Owns,100,0));
  END;
EXPORT In_Flagged_Summary_BySrc := TABLE(In_Flagged,FlagTots,SRC,FEW);
// Append flags to the input file
  TYPEOF(h) NoteFlags(h le,b.BestBy_LNPID_Best ri) := TRANSFORM
    SELF.DOB_flag := MAP ( ri.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND ri.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND ri.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) => SALT29.Flags.Null,
      le.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND le.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND le.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) => SALT29.Flags.Missing,
      le.DOB_year = ri.DOB_year AND le.DOB_month = ri.DOB_month AND le.DOB_day = ri.DOB_day => SALT29.Flags.Equal,
      SALT29.MOD_DateMatch(le.DOB_year,le.DOB_month,le.DOB_day,ri.DOB_year,ri.DOB_month,ri.DOB_day,true,true,12,true).NNEQ => SALT29.Flags.Fuzzy,
      SALT29.Flags.Bad);
    SELF.CNSMR_DOB_flag := MAP ( ri.CNSMR_DOB_year  IN SET(s.nulls_CNSMR_DOB_year,CNSMR_DOB_year) AND ri.CNSMR_DOB_month  IN SET(s.nulls_CNSMR_DOB_month,CNSMR_DOB_month) AND ri.CNSMR_DOB_day  IN SET(s.nulls_CNSMR_DOB_day,CNSMR_DOB_day) => SALT29.Flags.Null,
      le.CNSMR_DOB_year  IN SET(s.nulls_CNSMR_DOB_year,CNSMR_DOB_year) AND le.CNSMR_DOB_month  IN SET(s.nulls_CNSMR_DOB_month,CNSMR_DOB_month) AND le.CNSMR_DOB_day  IN SET(s.nulls_CNSMR_DOB_day,CNSMR_DOB_day) => SALT29.Flags.Missing,
      le.CNSMR_DOB_year = ri.CNSMR_DOB_year AND le.CNSMR_DOB_month = ri.CNSMR_DOB_month AND le.CNSMR_DOB_day = ri.CNSMR_DOB_day => SALT29.Flags.Equal,
      SALT29.MOD_DateMatch(le.CNSMR_DOB_year,le.CNSMR_DOB_month,le.CNSMR_DOB_day,ri.CNSMR_DOB_year,ri.CNSMR_DOB_month,ri.CNSMR_DOB_day,true,true,12,true).NNEQ => SALT29.Flags.Fuzzy,
      SALT29.Flags.Bad);
    SELF.SSN_flag := MAP ( ri.SSN  IN SET(s.nulls_SSN,SSN) => SALT29.Flags.Null,
      le.SSN  IN SET(s.nulls_SSN,SSN) => SALT29.Flags.Missing,
      ri.SSN_owns => SALT29.Flags.Owns,
      le.SSN = ri.SSN => SALT29.Flags.Equal,
      le.SSN = (TYPEOF(le.SSN))'' OR ri.SSN = (TYPEOF(ri.SSN))'' OR SALT29.WithinEditN(le.SSN,ri.SSN,1, 0)  OR fn_Right4(ri.SSN) = fn_Right4(le.SSN)  => SALT29.Flags.Fuzzy,
      SALT29.Flags.Bad);
    SELF.CNSMR_SSN_flag := MAP ( ri.CNSMR_SSN  IN SET(s.nulls_CNSMR_SSN,CNSMR_SSN) => SALT29.Flags.Null,
      le.CNSMR_SSN  IN SET(s.nulls_CNSMR_SSN,CNSMR_SSN) => SALT29.Flags.Missing,
      ri.CNSMR_SSN_owns => SALT29.Flags.Owns,
      le.CNSMR_SSN = ri.CNSMR_SSN => SALT29.Flags.Equal,
      le.CNSMR_SSN = (TYPEOF(le.CNSMR_SSN))'' OR ri.CNSMR_SSN = (TYPEOF(ri.CNSMR_SSN))'' OR SALT29.WithinEditN(le.CNSMR_SSN,ri.CNSMR_SSN,1, 0)  OR fn_Right4(ri.CNSMR_SSN) = fn_Right4(le.CNSMR_SSN)  => SALT29.Flags.Fuzzy,
      SALT29.Flags.Bad);
    SELF.DID_flag := MAP ( ri.DID  IN SET(s.nulls_DID,DID) => SALT29.Flags.Null,
      le.DID  IN SET(s.nulls_DID,DID) => SALT29.Flags.Missing,
      le.DID = ri.DID => SALT29.Flags.Equal,
      SALT29.Flags.Bad);
    SELF.FNAME_flag := MAP ( ri.FNAME  IN SET(s.nulls_FNAME,FNAME) => SALT29.Flags.Null,
      le.FNAME  IN SET(s.nulls_FNAME,FNAME) => SALT29.Flags.Missing,
      le.FNAME = ri.FNAME => SALT29.Flags.Equal,
      le.FNAME[1..LENGTH(TRIM(ri.FNAME))] = ri.FNAME OR ri.FNAME[1..LENGTH(TRIM(le.FNAME))] = le.FNAME OR SALT29.WithinEditN(le.FNAME,ri.FNAME,1, 0)  OR fn_PreferredName(ri.FNAME) = fn_PreferredName(le.FNAME)  => SALT29.Flags.Fuzzy,
      SALT29.Flags.Bad);
    SELF.MNAME_flag := MAP ( ri.MNAME  IN SET(s.nulls_MNAME,MNAME) => SALT29.Flags.Null,
      le.MNAME  IN SET(s.nulls_MNAME,MNAME) => SALT29.Flags.Missing,
      le.MNAME = ri.MNAME => SALT29.Flags.Equal,
      le.MNAME[1..LENGTH(TRIM(ri.MNAME))] = ri.MNAME OR ri.MNAME[1..LENGTH(TRIM(le.MNAME))] = le.MNAME OR SALT29.WithinEditN(le.MNAME,ri.MNAME,2, 0)  => SALT29.Flags.Fuzzy,
      SALT29.Flags.Bad);
    SELF.LNAME_flag := MAP ( ri.LNAME  IN SET(s.nulls_LNAME,LNAME) => SALT29.Flags.Null,
      le.LNAME  IN SET(s.nulls_LNAME,LNAME) => SALT29.Flags.Missing,
      le.LNAME = ri.LNAME => SALT29.Flags.Equal,
      le.LNAME[1..LENGTH(TRIM(ri.LNAME))] = ri.LNAME OR ri.LNAME[1..LENGTH(TRIM(le.LNAME))] = le.LNAME OR SALT29.WithinEditN(le.LNAME,ri.LNAME,2, 0) OR SALT29.HyphenMatch(le.LNAME,ri.LNAME,1)<=2  => SALT29.Flags.Fuzzy,
      SALT29.Flags.Bad);
    SELF.LIC_NBR_flag := MAP ( ri.LIC_NBR  IN SET(s.nulls_LIC_NBR,LIC_NBR) => SALT29.Flags.Null,
      le.LIC_NBR  IN SET(s.nulls_LIC_NBR,LIC_NBR) => SALT29.Flags.Missing,
      le.LIC_NBR = ri.LIC_NBR => SALT29.Flags.Equal,
      le.LIC_NBR = (TYPEOF(le.LIC_NBR))'' OR ri.LIC_NBR = (TYPEOF(ri.LIC_NBR))'' OR SALT29.WithinEditN(le.LIC_NBR,ri.LIC_NBR,1, 0)  => SALT29.Flags.Fuzzy,
      SALT29.Flags.Bad);
    SELF.C_LIC_NBR_flag := MAP ( ri.C_LIC_NBR  IN SET(s.nulls_C_LIC_NBR,C_LIC_NBR) => SALT29.Flags.Null,
      le.C_LIC_NBR  IN SET(s.nulls_C_LIC_NBR,C_LIC_NBR) => SALT29.Flags.Missing,
      le.C_LIC_NBR = ri.C_LIC_NBR => SALT29.Flags.Equal,
      le.C_LIC_NBR = (TYPEOF(le.C_LIC_NBR))'' OR ri.C_LIC_NBR = (TYPEOF(ri.C_LIC_NBR))'' OR SALT29.WithinEditN(le.C_LIC_NBR,ri.C_LIC_NBR,1, 0)  => SALT29.Flags.Fuzzy,
      SALT29.Flags.Bad);
    SELF.TAX_ID_flag := MAP ( ri.TAX_ID  IN SET(s.nulls_TAX_ID,TAX_ID) => SALT29.Flags.Null,
      le.TAX_ID  IN SET(s.nulls_TAX_ID,TAX_ID) => SALT29.Flags.Missing,
      ri.TAX_ID_owns => SALT29.Flags.Owns,
      le.TAX_ID = ri.TAX_ID => SALT29.Flags.Equal,
      SALT29.Flags.Bad);
    SELF.BILLING_TAX_ID_flag := MAP ( ri.BILLING_TAX_ID  IN SET(s.nulls_BILLING_TAX_ID,BILLING_TAX_ID) => SALT29.Flags.Null,
      le.BILLING_TAX_ID  IN SET(s.nulls_BILLING_TAX_ID,BILLING_TAX_ID) => SALT29.Flags.Missing,
      ri.BILLING_TAX_ID_owns => SALT29.Flags.Owns,
      le.BILLING_TAX_ID = ri.BILLING_TAX_ID => SALT29.Flags.Equal,
      SALT29.Flags.Bad);
    SELF.UPIN_flag := MAP ( ri.UPIN  IN SET(s.nulls_UPIN,UPIN) => SALT29.Flags.Null,
      le.UPIN  IN SET(s.nulls_UPIN,UPIN) => SALT29.Flags.Missing,
      ri.UPIN_owns => SALT29.Flags.Owns,
      le.UPIN = ri.UPIN => SALT29.Flags.Equal,
      SALT29.Flags.Bad);
    SELF.NPI_NUMBER_flag := MAP ( ri.NPI_NUMBER  IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER) => SALT29.Flags.Null,
      le.NPI_NUMBER  IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER) => SALT29.Flags.Missing,
      ri.NPI_NUMBER_owns => SALT29.Flags.Owns,
      le.NPI_NUMBER = ri.NPI_NUMBER => SALT29.Flags.Equal,
      SALT29.Flags.Bad);
    SELF.BILLING_NPI_NUMBER_flag := MAP ( ri.BILLING_NPI_NUMBER  IN SET(s.nulls_BILLING_NPI_NUMBER,BILLING_NPI_NUMBER) => SALT29.Flags.Null,
      le.BILLING_NPI_NUMBER  IN SET(s.nulls_BILLING_NPI_NUMBER,BILLING_NPI_NUMBER) => SALT29.Flags.Missing,
      ri.BILLING_NPI_NUMBER_owns => SALT29.Flags.Owns,
      le.BILLING_NPI_NUMBER = ri.BILLING_NPI_NUMBER => SALT29.Flags.Equal,
      SALT29.Flags.Bad);
    SELF.DEA_NUMBER_flag := MAP ( ri.DEA_NUMBER  IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER) => SALT29.Flags.Null,
      le.DEA_NUMBER  IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER) => SALT29.Flags.Missing,
      ri.DEA_NUMBER_owns => SALT29.Flags.Owns,
      le.DEA_NUMBER = ri.DEA_NUMBER => SALT29.Flags.Equal,
      SALT29.Flags.Bad);
    SELF.TAXONOMY_flag := MAP ( ri.TAXONOMY  IN SET(s.nulls_TAXONOMY,TAXONOMY) => SALT29.Flags.Null,
      le.TAXONOMY  IN SET(s.nulls_TAXONOMY,TAXONOMY) => SALT29.Flags.Missing,
      ri.TAXONOMY_owns => SALT29.Flags.Owns,
      le.TAXONOMY = ri.TAXONOMY => SALT29.Flags.Equal,
      SALT29.Flags.Bad);
    SELF := le;
  END;
  j := JOIN(h,b.BestBy_LNPID_Best,LEFT.LNPID=RIGHT.LNPID,NoteFlags(LEFT,RIGHT),LEFT OUTER,HASH);
	j1 := JOIN (J,b.BestBy_LNPID__LIC_STATE_best,LEFT.LNPID = RIGHT.LNPID AND LEFT.LIC_STATE = RIGHT.LIC_STATE AND LEFT.C_LIC_NBR = RIGHT.C_LIC_NBR,TRANSFORM(RECORDOF(J), SELF.C_LIC_NBR_flag := IF (LEFT.C_LIC_NBR = RIGHT.C_LIC_NBR AND LEFT.LIC_STATE = RIGHT.LIC_STATE AND LEFT.LNPID = RIGHT.LNPID,SALT29.Flags.Equal,LEFT.C_LIC_NBR_flag); SELF := LEFT;),LEFT OUTER, HASH);				
SHARED Input_Flagged0 := SORT(DISTRIBUTE(j1,HASH(LNPID)),LNPID,LOCAL);
EXPORT Input_Flagged := Input_Flagged0;
END;
