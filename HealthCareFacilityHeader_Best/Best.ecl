// Begin code to BEST data for each basis
import SALT30,ut;
EXPORT Best(DATASET(layout_HealthFacility) ih,layout_specificities.R s = Specificities(ih).specificities[1],BOOLEAN RoxieService=FALSE) := MODULE
  h00 := Cleave(ih,s,RoxieService).input_file;
SHARED h := IF(RoxieService,Specificities(ih).input_file_np,h00);
//Create those fields with BestType: BestNPI
// First step is to get all of the data slimmed and row-reduced
EXPORT BestNPI_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,SRC,NPI_NUMBER,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,SRC,NPI_NUMBER,MERGE),HASH(LNPID)); // Slim and reduce row-count
  Slim := TABLE(BestNPI_tab_(NPI_NUMBER NOT IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER)),{LNPID,SRC,NPI_NUMBER,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestNPI_tab_NPI_NUMBER := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestNPI_tab_NPI_NUMBER,{LNPID,NPI_NUMBER,UNSIGNED Row_Cnt := 100 * fn_Best_NPI_Source_Votes(SRC,Row_Cnt)}); // Use fn_Best_NPI_Source_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestNPI_vote_NPI_NUMBER := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,LOCAL);
//Now actually find the best value
  grp := GROUP( BestNPI_vote_NPI_NUMBER,LNPID,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  SALT30.MAC_Apply_Threshold(srt,200,o);
EXPORT BestNPI_method_NPI_NUMBER := o;
//Create those fields with BestType: BestDEA
// First step is to get all of the data slimmed and row-reduced
EXPORT BestDEA_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,SRC,DEA_NUMBER,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,SRC,DEA_NUMBER,MERGE),HASH(LNPID)); // Slim and reduce row-count
  Slim := TABLE(BestDEA_tab_(DEA_NUMBER NOT IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER)),{LNPID,SRC,DEA_NUMBER,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestDEA_tab_DEA_NUMBER := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestDEA_tab_DEA_NUMBER,{LNPID,DEA_NUMBER,UNSIGNED Row_Cnt := 100 * fn_Best_DEA_Source_Votes(SRC,Row_Cnt)}); // Use fn_Best_DEA_Source_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestDEA_vote_DEA_NUMBER := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,LOCAL);
//Now actually find the best value
  grp := GROUP( BestDEA_vote_DEA_NUMBER,LNPID,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  SALT30.MAC_Apply_Threshold(srt,200,o);
EXPORT BestDEA_method_DEA_NUMBER := o;
//Create those fields with BestType: BestCLIA
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCLIA_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,SRC,CLIA_NUMBER,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,SRC,CLIA_NUMBER,MERGE),HASH(LNPID)); // Slim and reduce row-count
  Slim := TABLE(BestCLIA_tab_(CLIA_NUMBER NOT IN SET(s.nulls_CLIA_NUMBER,CLIA_NUMBER)),{LNPID,SRC,CLIA_NUMBER,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCLIA_tab_CLIA_NUMBER := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestCLIA_tab_CLIA_NUMBER,{LNPID,CLIA_NUMBER,UNSIGNED Row_Cnt := 100 * fn_Best_CLIA_Source_Votes(SRC,Row_Cnt)}); // Use fn_Best_CLIA_Source_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCLIA_vote_CLIA_NUMBER := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,LOCAL);
//Now actually find the best value
  grp := GROUP( BestCLIA_vote_CLIA_NUMBER,LNPID,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  SALT30.MAC_Apply_Threshold(srt,200,o);
EXPORT BestCLIA_method_CLIA_NUMBER := o;
//Create those fields with BestType: BestMedicare
// First step is to get all of the data slimmed and row-reduced
EXPORT BestMedicare_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,SRC,MEDICARE_FACILITY_NUMBER,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,SRC,MEDICARE_FACILITY_NUMBER,MERGE),HASH(LNPID)); // Slim and reduce row-count
  Slim := TABLE(BestMedicare_tab_(MEDICARE_FACILITY_NUMBER NOT IN SET(s.nulls_MEDICARE_FACILITY_NUMBER,MEDICARE_FACILITY_NUMBER)),{LNPID,SRC,MEDICARE_FACILITY_NUMBER,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestMedicare_tab_MEDICARE_FACILITY_NUMBER := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestMedicare_tab_MEDICARE_FACILITY_NUMBER,{LNPID,MEDICARE_FACILITY_NUMBER,UNSIGNED Row_Cnt := 100 * fn_Best_Medicare_Source_Votes(SRC,Row_Cnt)}); // Use fn_Best_Medicare_Source_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestMedicare_vote_MEDICARE_FACILITY_NUMBER := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,LOCAL);
//Now actually find the best value
  grp := GROUP( BestMedicare_vote_MEDICARE_FACILITY_NUMBER,LNPID,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  SALT30.MAC_Apply_Threshold(srt,200,o);
EXPORT BestMedicare_method_MEDICARE_FACILITY_NUMBER := o;
//Create those fields with BestType: BestMedicaid
// First step is to get all of the data slimmed and row-reduced
EXPORT BestMedicaid_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,SRC,MEDICAID_NUMBER,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,SRC,MEDICAID_NUMBER,MERGE),HASH(LNPID)); // Slim and reduce row-count
  Slim := TABLE(BestMedicaid_tab_(MEDICAID_NUMBER NOT IN SET(s.nulls_MEDICAID_NUMBER,MEDICAID_NUMBER)),{LNPID,SRC,MEDICAID_NUMBER,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestMedicaid_tab_MEDICAID_NUMBER := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestMedicaid_tab_MEDICAID_NUMBER,{LNPID,MEDICAID_NUMBER,UNSIGNED Row_Cnt := 100 * fn_Best_Medicaid_Source_Votes(SRC,Row_Cnt)}); // Use fn_Best_Medicaid_Source_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestMedicaid_vote_MEDICAID_NUMBER := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,LOCAL);
//Now actually find the best value
  grp := GROUP( BestMedicaid_vote_MEDICAID_NUMBER,LNPID,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  SALT30.MAC_Apply_Threshold(srt,200,o);
EXPORT BestMedicaid_method_MEDICAID_NUMBER := o;
//Create those fields with BestType: BestNCPDP
// First step is to get all of the data slimmed and row-reduced
EXPORT BestNCPDP_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,SRC,NCPDP_NUMBER,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,SRC,NCPDP_NUMBER,MERGE),HASH(LNPID)); // Slim and reduce row-count
  Slim := TABLE(BestNCPDP_tab_(NCPDP_NUMBER NOT IN SET(s.nulls_NCPDP_NUMBER,NCPDP_NUMBER)),{LNPID,SRC,NCPDP_NUMBER,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestNCPDP_tab_NCPDP_NUMBER := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestNCPDP_tab_NCPDP_NUMBER,{LNPID,NCPDP_NUMBER,UNSIGNED Row_Cnt := 100 * fn_Best_NCPDP_Source_Votes(SRC,Row_Cnt)}); // Use fn_Best_NCPDP_Source_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestNCPDP_vote_NCPDP_NUMBER := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,LOCAL);
//Now actually find the best value
  grp := GROUP( BestNCPDP_vote_NCPDP_NUMBER,LNPID,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  SALT30.MAC_Apply_Threshold(srt,200,o);
EXPORT BestNCPDP_method_NCPDP_NUMBER := o;
//Create those fields with BestType: MostRecent
// First step is to get all of the data slimmed and row-reduced
EXPORT MostRecent_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,NPI_NUMBER,UNSIGNED Early_Date := MIN(GROUP,IF(DT_LAST_SEEN=0,99999999,DT_LAST_SEEN)),UNSIGNED Late_Date := MAX(GROUP,DT_LAST_SEEN),UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,NPI_NUMBER,MERGE),HASH(LNPID)); // Slim and reduce row-count
  Slim := TABLE(MostRecent_tab_(NPI_NUMBER NOT IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER)),{LNPID,NPI_NUMBER,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT MostRecent_tab_NPI_NUMBER := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,Early_Date,Late_Date,LOCAL);
//Now actually find the best value enforcing minimum
EXPORT MostRecent_method_NPI_NUMBER := DEDUP( SORT( MostRecent_tab_NPI_NUMBER(Late_Date>0,Early_Date<99999999),LNPID,-Late_Date,-Early_Date,LOCAL)(Row_Cnt >= 2),LNPID,LOCAL);
//Create those fields with BestType: MostRecentLIC
// First step is to get all of the data slimmed and row-reduced
EXPORT MostRecentLIC_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,LIC_STATE,C_LIC_NBR,UNSIGNED Early_Date := MIN(GROUP,IF(DT_LIC_EXPIRATION=0,99999999,DT_LIC_EXPIRATION)),UNSIGNED Late_Date := MAX(GROUP,DT_LIC_EXPIRATION),UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,LIC_STATE,C_LIC_NBR,MERGE),HASH(LNPID)); // Slim and reduce row-count
  Slim := TABLE(MostRecentLIC_tab_(C_LIC_NBR NOT IN SET(s.nulls_C_LIC_NBR,C_LIC_NBR)),{LNPID,LIC_STATE,C_LIC_NBR,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT MostRecentLIC_tab_C_LIC_NBR := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,Early_Date,Late_Date,LOCAL);
// Adjust scores for C_LIC_NBR using defined fuzzy logic 
Fuzzy_layout := RECORD
  MostRecentLIC_tab_C_LIC_NBR.LNPID;
  MostRecentLIC_tab_C_LIC_NBR.LIC_STATE;
  MostRecentLIC_tab_C_LIC_NBR.C_LIC_NBR;
  UNSIGNED Early_Date;
  UNSIGNED Late_Date;
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(MostRecentLIC_tab_C_LIC_NBR le,MostRecentLIC_tab_C_LIC_NBR ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(MostRecentLIC_tab_C_LIC_NBR,MostRecentLIC_tab_C_LIC_NBR, LEFT.LNPID = RIGHT.LNPID  AND ( LEFT.LIC_STATE = (TYPEOF(LEFT.LIC_STATE))'' OR RIGHT.LIC_STATE = (TYPEOF(RIGHT.LIC_STATE))'' OR LEFT.LIC_STATE = RIGHT.LIC_STATE  ) AND ( LEFT.C_LIC_NBR = (TYPEOF(LEFT.C_LIC_NBR))'' OR RIGHT.C_LIC_NBR = (TYPEOF(RIGHT.C_LIC_NBR))'' OR SALT30.WithinEditN(LEFT.C_LIC_NBR,RIGHT.C_LIC_NBR,1, 0)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT MostRecentLIC_fuzz_C_LIC_NBR := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,Early_Date,Late_Date,LOCAL);
//Now actually find the best value
EXPORT MostRecentLIC_method_C_LIC_NBR := DEDUP( SORT( MostRecentLIC_fuzz_C_LIC_NBR(Late_Date>0,Early_Date<99999999),LNPID,-Late_Date,-Early_Date,LOCAL),LNPID,LOCAL);
//Create those fields with BestType: BestLICCommenest
// First step is to get all of the data slimmed and row-reduced
EXPORT BestLICCommenest_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,C_LIC_NBR,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,C_LIC_NBR,MERGE),HASH(LNPID)); // Slim and reduce row-count
  Slim := TABLE(BestLICCommenest_tab_(C_LIC_NBR NOT IN SET(s.nulls_C_LIC_NBR,C_LIC_NBR)),{LNPID,C_LIC_NBR,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestLICCommenest_tab_C_LIC_NBR := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,LOCAL);
// Adjust scores for C_LIC_NBR using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestLICCommenest_tab_C_LIC_NBR.LNPID;
  BestLICCommenest_tab_C_LIC_NBR.C_LIC_NBR;
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestLICCommenest_tab_C_LIC_NBR le,BestLICCommenest_tab_C_LIC_NBR ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestLICCommenest_tab_C_LIC_NBR,BestLICCommenest_tab_C_LIC_NBR, LEFT.LNPID = RIGHT.LNPID  AND ( LEFT.C_LIC_NBR = (TYPEOF(LEFT.C_LIC_NBR))'' OR RIGHT.C_LIC_NBR = (TYPEOF(RIGHT.C_LIC_NBR))'' OR SALT30.WithinEditN(LEFT.C_LIC_NBR,RIGHT.C_LIC_NBR,1, 0)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestLICCommenest_fuzz_C_LIC_NBR := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,LOCAL);
//Now actually find the best value
  grp := GROUP( BestLICCommenest_fuzz_C_LIC_NBR,LNPID,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestLICCommenest_method_C_LIC_NBR := cmn;
//Create those fields with BestType: BestLICLongest
// First step is to get all of the data slimmed and row-reduced
EXPORT BestLICLongest_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,LIC_STATE,C_LIC_NBR,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,LIC_STATE,C_LIC_NBR,MERGE),HASH(LNPID)); // Slim and reduce row-count
  Slim := TABLE(BestLICLongest_tab_(C_LIC_NBR NOT IN SET(s.nulls_C_LIC_NBR,C_LIC_NBR)),{LNPID,LIC_STATE,C_LIC_NBR,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestLICLongest_tab_C_LIC_NBR := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,LOCAL);
// Adjust scores for C_LIC_NBR using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestLICLongest_tab_C_LIC_NBR.LNPID;
  BestLICLongest_tab_C_LIC_NBR.LIC_STATE;
  BestLICLongest_tab_C_LIC_NBR.C_LIC_NBR;
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestLICLongest_tab_C_LIC_NBR le,BestLICLongest_tab_C_LIC_NBR ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestLICLongest_tab_C_LIC_NBR,BestLICLongest_tab_C_LIC_NBR, LEFT.LNPID = RIGHT.LNPID  AND ( LEFT.LIC_STATE = (TYPEOF(LEFT.LIC_STATE))'' OR RIGHT.LIC_STATE = (TYPEOF(RIGHT.LIC_STATE))'' OR LEFT.LIC_STATE = RIGHT.LIC_STATE  ) AND ( LEFT.C_LIC_NBR = (TYPEOF(LEFT.C_LIC_NBR))'' OR RIGHT.C_LIC_NBR = (TYPEOF(RIGHT.C_LIC_NBR))'' OR SALT30.WithinEditN(LEFT.C_LIC_NBR,RIGHT.C_LIC_NBR,1, 0)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestLICLongest_fuzz_C_LIC_NBR := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,LOCAL);
//Now actually find the best value
EXPORT BestLICLongest_method_C_LIC_NBR := DEDUP( SORT( BestLICLongest_fuzz_C_LIC_NBR,LNPID,-LENGTH(TRIM((SALT30.StrType)C_LIC_NBR)),-Row_Cnt,LOCAL),LNPID,LOCAL);
//Create those fields with BestType: MostRecentDEA
// First step is to get all of the data slimmed and row-reduced
EXPORT MostRecentDEA_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,DEA_NUMBER,UNSIGNED Early_Date := MIN(GROUP,IF(DT_DEA_EXPIRATION=0,99999999,DT_DEA_EXPIRATION)),UNSIGNED Late_Date := MAX(GROUP,DT_DEA_EXPIRATION),UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,DEA_NUMBER,MERGE),HASH(LNPID)); // Slim and reduce row-count
  Slim := TABLE(MostRecentDEA_tab_(DEA_NUMBER NOT IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER)),{LNPID,DEA_NUMBER,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT MostRecentDEA_tab_DEA_NUMBER := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,Early_Date,Late_Date,LOCAL);
//Now actually find the best value
EXPORT MostRecentDEA_method_DEA_NUMBER := DEDUP( SORT( MostRecentDEA_tab_DEA_NUMBER(Late_Date>0,Early_Date<99999999),LNPID,-Late_Date,-Early_Date,LOCAL),LNPID,LOCAL);
//Create those fields with BestType: BestTaxCommonest
// First step is to get all of the data slimmed and row-reduced
EXPORT BestTaxCommonest_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,TAX_ID,FEIN,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,TAX_ID,FEIN,MERGE),HASH(LNPID)); // Slim and reduce row-count
  Slim := TABLE(BestTaxCommonest_tab_(TAX_ID NOT IN SET(s.nulls_TAX_ID,TAX_ID)),{LNPID,TAX_ID,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestTaxCommonest_tab_TAX_ID := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,LOCAL);
  Slim := TABLE(BestTaxCommonest_tab_(FEIN NOT IN SET(s.nulls_FEIN,FEIN)),{LNPID,FEIN,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestTaxCommonest_tab_FEIN := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,LOCAL);
//Now actually find the best value enforcing minimum
  grp := GROUP( BestTaxCommonest_tab_TAX_ID,LNPID,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestTaxCommonest_method_TAX_ID := cmn(Row_Cnt >= 2);
//Now actually find the best value enforcing minimum
  grp := GROUP( BestTaxCommonest_tab_FEIN,LNPID,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestTaxCommonest_method_FEIN := cmn(Row_Cnt >= 2);
//Create those fields with BestType: MostCommonValue
// First step is to get all of the data slimmed and row-reduced
EXPORT MostCommonValue_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,CLIA_NUMBER,MEDICARE_FACILITY_NUMBER,NCPDP_NUMBER,MEDICAID_NUMBER,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,CLIA_NUMBER,MEDICARE_FACILITY_NUMBER,NCPDP_NUMBER,MEDICAID_NUMBER,MERGE),HASH(LNPID)); // Slim and reduce row-count
  Slim := TABLE(MostCommonValue_tab_(CLIA_NUMBER NOT IN SET(s.nulls_CLIA_NUMBER,CLIA_NUMBER)),{LNPID,CLIA_NUMBER,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT MostCommonValue_tab_CLIA_NUMBER := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,LOCAL);
  Slim := TABLE(MostCommonValue_tab_(MEDICARE_FACILITY_NUMBER NOT IN SET(s.nulls_MEDICARE_FACILITY_NUMBER,MEDICARE_FACILITY_NUMBER)),{LNPID,MEDICARE_FACILITY_NUMBER,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT MostCommonValue_tab_MEDICARE_FACILITY_NUMBER := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,LOCAL);
  Slim := TABLE(MostCommonValue_tab_(NCPDP_NUMBER NOT IN SET(s.nulls_NCPDP_NUMBER,NCPDP_NUMBER)),{LNPID,NCPDP_NUMBER,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT MostCommonValue_tab_NCPDP_NUMBER := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,LOCAL);
  Slim := TABLE(MostCommonValue_tab_(MEDICAID_NUMBER NOT IN SET(s.nulls_MEDICAID_NUMBER,MEDICAID_NUMBER)),{LNPID,MEDICAID_NUMBER,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT MostCommonValue_tab_MEDICAID_NUMBER := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,LOCAL);
//Now actually find the best value enforcing minimum
  grp := GROUP( MostCommonValue_tab_CLIA_NUMBER,LNPID,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT MostCommonValue_method_CLIA_NUMBER := cmn(Row_Cnt >= 5);
//Now actually find the best value enforcing minimum
  grp := GROUP( MostCommonValue_tab_MEDICARE_FACILITY_NUMBER,LNPID,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT MostCommonValue_method_MEDICARE_FACILITY_NUMBER := cmn(Row_Cnt >= 5);
//Now actually find the best value enforcing minimum
  grp := GROUP( MostCommonValue_tab_NCPDP_NUMBER,LNPID,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT MostCommonValue_method_NCPDP_NUMBER := cmn(Row_Cnt >= 5);
//Now actually find the best value enforcing minimum
  grp := GROUP( MostCommonValue_tab_MEDICAID_NUMBER,LNPID,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT MostCommonValue_method_MEDICAID_NUMBER := cmn(Row_Cnt >= 5);
//Create those fields with BestType: BestTaxID
// First step is to get all of the data slimmed and row-reduced
EXPORT BestTaxID_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,TAX_ID,FEIN,UNSIGNED Early_Date := MIN(GROUP,IF(DT_LAST_SEEN=0,99999999,DT_LAST_SEEN)),UNSIGNED Late_Date := MAX(GROUP,DT_LAST_SEEN),UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,TAX_ID,FEIN,MERGE),HASH(LNPID)); // Slim and reduce row-count
  Slim := TABLE(BestTaxID_tab_(TAX_ID NOT IN SET(s.nulls_TAX_ID,TAX_ID)),{LNPID,TAX_ID,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestTaxID_tab_TAX_ID := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,Early_Date,Late_Date,LOCAL);
  Slim := TABLE(BestTaxID_tab_(FEIN NOT IN SET(s.nulls_FEIN,FEIN)),{LNPID,FEIN,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestTaxID_tab_FEIN := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,Early_Date,Late_Date,LOCAL);
//Now actually find the best value
EXPORT BestTaxID_method_TAX_ID := DEDUP( SORT( BestTaxID_tab_TAX_ID(Late_Date>0,Early_Date<99999999),LNPID,-Late_Date,-Early_Date,LOCAL),LNPID,LOCAL);
//Now actually find the best value
EXPORT BestTaxID_method_FEIN := DEDUP( SORT( BestTaxID_tab_FEIN(Late_Date>0,Early_Date<99999999),LNPID,-Late_Date,-Early_Date,LOCAL),LNPID,LOCAL);
// Start to gather together all records with basis:LNPID,SRC
// 0 - Gathering type:BestNPI Entries:1
  R0 := RECORD
    typeof(BestNPI_method_NPI_NUMBER.LNPID) LNPID; // Need to copy in basis
    TYPEOF(BestNPI_method_NPI_NUMBER.NPI_NUMBER) BestNPI_NPI_NUMBER;
    UNSIGNED NPI_NUMBER_BestNPI_Row_Cnt;
  END;
  R0 T0(BestNPI_method_NPI_NUMBER ri) := TRANSFORM
    SELF.BestNPI_NPI_NUMBER := ri.NPI_NUMBER;
    SELF.NPI_NUMBER_BestNPI_Row_Cnt := ri.Row_Cnt;
    SELF := ri;
  END;
  J0 := PROJECT(BestNPI_method_NPI_NUMBER,T0(left));
// 1 - Gathering type:BestDEA Entries:1
  R1 := RECORD
    J0; // The data so far
    TYPEOF(BestDEA_method_DEA_NUMBER.DEA_NUMBER) BestDEA_DEA_NUMBER;
    UNSIGNED DEA_NUMBER_BestDEA_Row_Cnt;
  END;
  R1 T1(J0 le,BestDEA_method_DEA_NUMBER ri) := TRANSFORM
    SELF.BestDEA_DEA_NUMBER := ri.DEA_NUMBER;
    SELF.DEA_NUMBER_BestDEA_Row_Cnt := ri.Row_Cnt;
    BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
    SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
    SELF := le;
  END;
  J1 := JOIN(J0,BestDEA_method_DEA_NUMBER,LEFT.LNPID = RIGHT.LNPID,T1(LEFT,RIGHT),FULL OUTER,LOCAL);
// 2 - Gathering type:BestCLIA Entries:1
  R2 := RECORD
    J1; // The data so far
    TYPEOF(BestCLIA_method_CLIA_NUMBER.CLIA_NUMBER) BestCLIA_CLIA_NUMBER;
    UNSIGNED CLIA_NUMBER_BestCLIA_Row_Cnt;
  END;
  R2 T2(J1 le,BestCLIA_method_CLIA_NUMBER ri) := TRANSFORM
    SELF.BestCLIA_CLIA_NUMBER := ri.CLIA_NUMBER;
    SELF.CLIA_NUMBER_BestCLIA_Row_Cnt := ri.Row_Cnt;
    BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
    SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
    SELF := le;
  END;
  J2 := JOIN(J1,BestCLIA_method_CLIA_NUMBER,LEFT.LNPID = RIGHT.LNPID,T2(LEFT,RIGHT),FULL OUTER,LOCAL);
// 3 - Gathering type:BestMedicare Entries:1
  R3 := RECORD
    J2; // The data so far
    TYPEOF(BestMedicare_method_MEDICARE_FACILITY_NUMBER.MEDICARE_FACILITY_NUMBER) BestMedicare_MEDICARE_FACILITY_NUMBER;
    UNSIGNED MEDICARE_FACILITY_NUMBER_BestMedicare_Row_Cnt;
  END;
  R3 T3(J2 le,BestMedicare_method_MEDICARE_FACILITY_NUMBER ri) := TRANSFORM
    SELF.BestMedicare_MEDICARE_FACILITY_NUMBER := ri.MEDICARE_FACILITY_NUMBER;
    SELF.MEDICARE_FACILITY_NUMBER_BestMedicare_Row_Cnt := ri.Row_Cnt;
    BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
    SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
    SELF := le;
  END;
  J3 := JOIN(J2,BestMedicare_method_MEDICARE_FACILITY_NUMBER,LEFT.LNPID = RIGHT.LNPID,T3(LEFT,RIGHT),FULL OUTER,LOCAL);
// 4 - Gathering type:BestMedicaid Entries:1
  R4 := RECORD
    J3; // The data so far
    TYPEOF(BestMedicaid_method_MEDICAID_NUMBER.MEDICAID_NUMBER) BestMedicaid_MEDICAID_NUMBER;
    UNSIGNED MEDICAID_NUMBER_BestMedicaid_Row_Cnt;
  END;
  R4 T4(J3 le,BestMedicaid_method_MEDICAID_NUMBER ri) := TRANSFORM
    SELF.BestMedicaid_MEDICAID_NUMBER := ri.MEDICAID_NUMBER;
    SELF.MEDICAID_NUMBER_BestMedicaid_Row_Cnt := ri.Row_Cnt;
    BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
    SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
    SELF := le;
  END;
  J4 := JOIN(J3,BestMedicaid_method_MEDICAID_NUMBER,LEFT.LNPID = RIGHT.LNPID,T4(LEFT,RIGHT),FULL OUTER,LOCAL);
// 5 - Gathering type:BestNCPDP Entries:1
  R5 := RECORD
    J4; // The data so far
    TYPEOF(BestNCPDP_method_NCPDP_NUMBER.NCPDP_NUMBER) BestNCPDP_NCPDP_NUMBER;
    UNSIGNED NCPDP_NUMBER_BestNCPDP_Row_Cnt;
  END;
  R5 T5(J4 le,BestNCPDP_method_NCPDP_NUMBER ri) := TRANSFORM
    SELF.BestNCPDP_NCPDP_NUMBER := ri.NCPDP_NUMBER;
    SELF.NCPDP_NUMBER_BestNCPDP_Row_Cnt := ri.Row_Cnt;
    BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
    SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
    SELF := le;
  END;
  J5 := JOIN(J4,BestNCPDP_method_NCPDP_NUMBER,LEFT.LNPID = RIGHT.LNPID,T5(LEFT,RIGHT),FULL OUTER,LOCAL);
// 6 - Gathering type:MostRecent Entries:1
  R6 := RECORD
    J5; // The data so far
    TYPEOF(MostRecent_method_NPI_NUMBER.NPI_NUMBER) MostRecent_NPI_NUMBER;
    UNSIGNED NPI_NUMBER_MostRecent_Row_Cnt;
  END;
  R6 T6(J5 le,MostRecent_method_NPI_NUMBER ri) := TRANSFORM
    SELF.MostRecent_NPI_NUMBER := ri.NPI_NUMBER;
    SELF.NPI_NUMBER_MostRecent_Row_Cnt := ri.Row_Cnt;
    BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
    SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
    SELF := le;
  END;
  J6 := JOIN(J5,MostRecent_method_NPI_NUMBER,LEFT.LNPID = RIGHT.LNPID,T6(LEFT,RIGHT),FULL OUTER,LOCAL);
// 7 - Gathering type:BestLICCommenest Entries:1
  R7 := RECORD
    J6; // The data so far
    TYPEOF(BestLICCommenest_method_C_LIC_NBR.C_LIC_NBR) BestLICCommenest_C_LIC_NBR;
    UNSIGNED C_LIC_NBR_BestLICCommenest_Row_Cnt;
    UNSIGNED C_LIC_NBR_BestLICCommenest_Orig_Row_Cnt;
  END;
  R7 T7(J6 le,BestLICCommenest_method_C_LIC_NBR ri) := TRANSFORM
    SELF.BestLICCommenest_C_LIC_NBR := ri.C_LIC_NBR;
    SELF.C_LIC_NBR_BestLICCommenest_Row_Cnt := ri.Row_Cnt;
    SELF.C_LIC_NBR_BestLICCommenest_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
    SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
    SELF := le;
  END;
  J7 := JOIN(J6,BestLICCommenest_method_C_LIC_NBR,LEFT.LNPID = RIGHT.LNPID,T7(LEFT,RIGHT),FULL OUTER,LOCAL);
// 8 - Gathering type:MostRecentDEA Entries:1
  R8 := RECORD
    J7; // The data so far
    TYPEOF(MostRecentDEA_method_DEA_NUMBER.DEA_NUMBER) MostRecentDEA_DEA_NUMBER;
    UNSIGNED DEA_NUMBER_MostRecentDEA_Row_Cnt;
  END;
  R8 T8(J7 le,MostRecentDEA_method_DEA_NUMBER ri) := TRANSFORM
    SELF.MostRecentDEA_DEA_NUMBER := ri.DEA_NUMBER;
    SELF.DEA_NUMBER_MostRecentDEA_Row_Cnt := ri.Row_Cnt;
    BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
    SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
    SELF := le;
  END;
  J8 := JOIN(J7,MostRecentDEA_method_DEA_NUMBER,LEFT.LNPID = RIGHT.LNPID,T8(LEFT,RIGHT),FULL OUTER,LOCAL);
// 9 - Gathering type:BestTaxCommonest Entries:2
  R9 := RECORD
    J8; // The data so far
    TYPEOF(BestTaxCommonest_method_TAX_ID.TAX_ID) BestTaxCommonest_TAX_ID;
    UNSIGNED TAX_ID_BestTaxCommonest_Row_Cnt;
  END;
  R9 T9(J8 le,BestTaxCommonest_method_TAX_ID ri) := TRANSFORM
    SELF.BestTaxCommonest_TAX_ID := ri.TAX_ID;
    SELF.TAX_ID_BestTaxCommonest_Row_Cnt := ri.Row_Cnt;
    BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
    SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
    SELF := le;
  END;
  J9 := JOIN(J8,BestTaxCommonest_method_TAX_ID,LEFT.LNPID = RIGHT.LNPID,T9(LEFT,RIGHT),FULL OUTER,LOCAL);
  R10 := RECORD
    J9; // The data so far
    TYPEOF(BestTaxCommonest_method_FEIN.FEIN) BestTaxCommonest_FEIN;
    UNSIGNED FEIN_BestTaxCommonest_Row_Cnt;
  END;
  R10 T10(J9 le,BestTaxCommonest_method_FEIN ri) := TRANSFORM
    SELF.BestTaxCommonest_FEIN := ri.FEIN;
    SELF.FEIN_BestTaxCommonest_Row_Cnt := ri.Row_Cnt;
    BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
    SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
    SELF := le;
  END;
  J10 := JOIN(J9,BestTaxCommonest_method_FEIN,LEFT.LNPID = RIGHT.LNPID,T10(LEFT,RIGHT),FULL OUTER,LOCAL);
// 11 - Gathering type:MostCommonValue Entries:4
  R11 := RECORD
    J10; // The data so far
    TYPEOF(MostCommonValue_method_CLIA_NUMBER.CLIA_NUMBER) MostCommonValue_CLIA_NUMBER;
    UNSIGNED CLIA_NUMBER_MostCommonValue_Row_Cnt;
  END;
  R11 T11(J10 le,MostCommonValue_method_CLIA_NUMBER ri) := TRANSFORM
    SELF.MostCommonValue_CLIA_NUMBER := ri.CLIA_NUMBER;
    SELF.CLIA_NUMBER_MostCommonValue_Row_Cnt := ri.Row_Cnt;
    BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
    SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
    SELF := le;
  END;
  J11 := JOIN(J10,MostCommonValue_method_CLIA_NUMBER,LEFT.LNPID = RIGHT.LNPID,T11(LEFT,RIGHT),FULL OUTER,LOCAL);
  R12 := RECORD
    J11; // The data so far
    TYPEOF(MostCommonValue_method_MEDICARE_FACILITY_NUMBER.MEDICARE_FACILITY_NUMBER) MostCommonValue_MEDICARE_FACILITY_NUMBER;
    UNSIGNED MEDICARE_FACILITY_NUMBER_MostCommonValue_Row_Cnt;
  END;
  R12 T12(J11 le,MostCommonValue_method_MEDICARE_FACILITY_NUMBER ri) := TRANSFORM
    SELF.MostCommonValue_MEDICARE_FACILITY_NUMBER := ri.MEDICARE_FACILITY_NUMBER;
    SELF.MEDICARE_FACILITY_NUMBER_MostCommonValue_Row_Cnt := ri.Row_Cnt;
    BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
    SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
    SELF := le;
  END;
  J12 := JOIN(J11,MostCommonValue_method_MEDICARE_FACILITY_NUMBER,LEFT.LNPID = RIGHT.LNPID,T12(LEFT,RIGHT),FULL OUTER,LOCAL);
  R13 := RECORD
    J12; // The data so far
    TYPEOF(MostCommonValue_method_NCPDP_NUMBER.NCPDP_NUMBER) MostCommonValue_NCPDP_NUMBER;
    UNSIGNED NCPDP_NUMBER_MostCommonValue_Row_Cnt;
  END;
  R13 T13(J12 le,MostCommonValue_method_NCPDP_NUMBER ri) := TRANSFORM
    SELF.MostCommonValue_NCPDP_NUMBER := ri.NCPDP_NUMBER;
    SELF.NCPDP_NUMBER_MostCommonValue_Row_Cnt := ri.Row_Cnt;
    BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
    SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
    SELF := le;
  END;
  J13 := JOIN(J12,MostCommonValue_method_NCPDP_NUMBER,LEFT.LNPID = RIGHT.LNPID,T13(LEFT,RIGHT),FULL OUTER,LOCAL);
  R14 := RECORD
    J13; // The data so far
    TYPEOF(MostCommonValue_method_MEDICAID_NUMBER.MEDICAID_NUMBER) MostCommonValue_MEDICAID_NUMBER;
    UNSIGNED MEDICAID_NUMBER_MostCommonValue_Row_Cnt;
  END;
  R14 T14(J13 le,MostCommonValue_method_MEDICAID_NUMBER ri) := TRANSFORM
    SELF.MostCommonValue_MEDICAID_NUMBER := ri.MEDICAID_NUMBER;
    SELF.MEDICAID_NUMBER_MostCommonValue_Row_Cnt := ri.Row_Cnt;
    BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
    SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
    SELF := le;
  END;
  J14 := JOIN(J13,MostCommonValue_method_MEDICAID_NUMBER,LEFT.LNPID = RIGHT.LNPID,T14(LEFT,RIGHT),FULL OUTER,LOCAL);
// 15 - Gathering type:BestTaxID Entries:2
  R15 := RECORD
    J14; // The data so far
    TYPEOF(BestTaxID_method_TAX_ID.TAX_ID) BestTaxID_TAX_ID;
    UNSIGNED TAX_ID_BestTaxID_Row_Cnt;
  END;
  R15 T15(J14 le,BestTaxID_method_TAX_ID ri) := TRANSFORM
    SELF.BestTaxID_TAX_ID := ri.TAX_ID;
    SELF.TAX_ID_BestTaxID_Row_Cnt := ri.Row_Cnt;
    BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
    SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
    SELF := le;
  END;
  J15 := JOIN(J14,BestTaxID_method_TAX_ID,LEFT.LNPID = RIGHT.LNPID,T15(LEFT,RIGHT),FULL OUTER,LOCAL);
  R16 := RECORD
    J15; // The data so far
    TYPEOF(BestTaxID_method_FEIN.FEIN) BestTaxID_FEIN;
    UNSIGNED FEIN_BestTaxID_Row_Cnt;
  END;
  R16 T16(J15 le,BestTaxID_method_FEIN ri) := TRANSFORM
    SELF.BestTaxID_FEIN := ri.FEIN;
    SELF.FEIN_BestTaxID_Row_Cnt := ri.Row_Cnt;
    BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
    SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
    SELF := le;
  END;
  J16 := JOIN(J15,BestTaxID_method_FEIN,LEFT.LNPID = RIGHT.LNPID,T16(LEFT,RIGHT),FULL OUTER,LOCAL);
EXPORT BestBy_LNPID_np := J16;
EXPORT BestBy_LNPID := BestBy_LNPID_np : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::best::BestBy_LNPID',EXPIRE(Config.PersistExpire));
// Now gather some statistics to see how we did
  R := RECORD
    NumberOfBasis := COUNT(GROUP);
    REAL8 BestNPI_NPI_NUMBER_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestNPI_NPI_NUMBER=(typeof(BestBy_LNPID.BestNPI_NPI_NUMBER))'',0,100));
    REAL8 BestDEA_DEA_NUMBER_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestDEA_DEA_NUMBER=(typeof(BestBy_LNPID.BestDEA_DEA_NUMBER))'',0,100));
    REAL8 BestCLIA_CLIA_NUMBER_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestCLIA_CLIA_NUMBER=(typeof(BestBy_LNPID.BestCLIA_CLIA_NUMBER))'',0,100));
    REAL8 BestMedicare_MEDICARE_FACILITY_NUMBER_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestMedicare_MEDICARE_FACILITY_NUMBER=(typeof(BestBy_LNPID.BestMedicare_MEDICARE_FACILITY_NUMBER))'',0,100));
    REAL8 BestMedicaid_MEDICAID_NUMBER_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestMedicaid_MEDICAID_NUMBER=(typeof(BestBy_LNPID.BestMedicaid_MEDICAID_NUMBER))'',0,100));
    REAL8 BestNCPDP_NCPDP_NUMBER_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestNCPDP_NCPDP_NUMBER=(typeof(BestBy_LNPID.BestNCPDP_NCPDP_NUMBER))'',0,100));
    REAL8 MostRecent_NPI_NUMBER_pcnt := AVE(GROUP,IF(BestBy_LNPID.MostRecent_NPI_NUMBER=(typeof(BestBy_LNPID.MostRecent_NPI_NUMBER))'',0,100));
    REAL8 BestLICCommenest_C_LIC_NBR_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestLICCommenest_C_LIC_NBR=(typeof(BestBy_LNPID.BestLICCommenest_C_LIC_NBR))'',0,100));
    REAL8 MostRecentDEA_DEA_NUMBER_pcnt := AVE(GROUP,IF(BestBy_LNPID.MostRecentDEA_DEA_NUMBER=(typeof(BestBy_LNPID.MostRecentDEA_DEA_NUMBER))'',0,100));
    REAL8 BestTaxCommonest_TAX_ID_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestTaxCommonest_TAX_ID=(typeof(BestBy_LNPID.BestTaxCommonest_TAX_ID))'',0,100));
    REAL8 BestTaxCommonest_FEIN_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestTaxCommonest_FEIN=(typeof(BestBy_LNPID.BestTaxCommonest_FEIN))'',0,100));
    REAL8 MostCommonValue_CLIA_NUMBER_pcnt := AVE(GROUP,IF(BestBy_LNPID.MostCommonValue_CLIA_NUMBER=(typeof(BestBy_LNPID.MostCommonValue_CLIA_NUMBER))'',0,100));
    REAL8 MostCommonValue_MEDICARE_FACILITY_NUMBER_pcnt := AVE(GROUP,IF(BestBy_LNPID.MostCommonValue_MEDICARE_FACILITY_NUMBER=(typeof(BestBy_LNPID.MostCommonValue_MEDICARE_FACILITY_NUMBER))'',0,100));
    REAL8 MostCommonValue_NCPDP_NUMBER_pcnt := AVE(GROUP,IF(BestBy_LNPID.MostCommonValue_NCPDP_NUMBER=(typeof(BestBy_LNPID.MostCommonValue_NCPDP_NUMBER))'',0,100));
    REAL8 MostCommonValue_MEDICAID_NUMBER_pcnt := AVE(GROUP,IF(BestBy_LNPID.MostCommonValue_MEDICAID_NUMBER=(typeof(BestBy_LNPID.MostCommonValue_MEDICAID_NUMBER))'',0,100));
    REAL8 BestTaxID_TAX_ID_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestTaxID_TAX_ID=(typeof(BestBy_LNPID.BestTaxID_TAX_ID))'',0,100));
    REAL8 BestTaxID_FEIN_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestTaxID_FEIN=(typeof(BestBy_LNPID.BestTaxID_FEIN))'',0,100));
  END;
EXPORT BestBy_LNPID_population := TABLE(BestBy_LNPID,R);
// Take the wide table and turn it into a child-dataset version
SHARED F_BestBy_LNPID(DATASET({BestBy_LNPID}) d) := FUNCTION
  NPI_NUMBER_case_layout := RECORD
    TYPEOF(h.NPI_NUMBER) NPI_NUMBER;
    UNSIGNED1 NPI_NUMBER_method; // This value could come from multiple BESTTYPE; track which one
    UNSIGNED NPI_NUMBER_own_cnt := 0; // Used for determining who OWNs this value
    BOOLEAN  NPI_NUMBER_owns := false; // Does this cluster own this value?
  END;
  DEA_NUMBER_case_layout := RECORD
    TYPEOF(h.DEA_NUMBER) DEA_NUMBER;
    UNSIGNED1 DEA_NUMBER_method; // This value could come from multiple BESTTYPE; track which one
    UNSIGNED DEA_NUMBER_own_cnt := 0; // Used for determining who OWNs this value
    BOOLEAN  DEA_NUMBER_owns := false; // Does this cluster own this value?
  END;
  CLIA_NUMBER_case_layout := RECORD
    TYPEOF(h.CLIA_NUMBER) CLIA_NUMBER;
    UNSIGNED1 CLIA_NUMBER_method; // This value could come from multiple BESTTYPE; track which one
    UNSIGNED CLIA_NUMBER_own_cnt := 0; // Used for determining who OWNs this value
    BOOLEAN  CLIA_NUMBER_owns := false; // Does this cluster own this value?
  END;
  MEDICARE_FACILITY_NUMBER_case_layout := RECORD
    TYPEOF(h.MEDICARE_FACILITY_NUMBER) MEDICARE_FACILITY_NUMBER;
    UNSIGNED1 MEDICARE_FACILITY_NUMBER_method; // This value could come from multiple BESTTYPE; track which one
    UNSIGNED MEDICARE_FACILITY_NUMBER_own_cnt := 0; // Used for determining who OWNs this value
    BOOLEAN  MEDICARE_FACILITY_NUMBER_owns := false; // Does this cluster own this value?
  END;
  MEDICAID_NUMBER_case_layout := RECORD
    TYPEOF(h.MEDICAID_NUMBER) MEDICAID_NUMBER;
    UNSIGNED1 MEDICAID_NUMBER_method; // This value could come from multiple BESTTYPE; track which one
    UNSIGNED MEDICAID_NUMBER_own_cnt := 0; // Used for determining who OWNs this value
    BOOLEAN  MEDICAID_NUMBER_owns := false; // Does this cluster own this value?
  END;
  NCPDP_NUMBER_case_layout := RECORD
    TYPEOF(h.NCPDP_NUMBER) NCPDP_NUMBER;
    UNSIGNED1 NCPDP_NUMBER_method; // This value could come from multiple BESTTYPE; track which one
    UNSIGNED NCPDP_NUMBER_own_cnt := 0; // Used for determining who OWNs this value
    BOOLEAN  NCPDP_NUMBER_owns := false; // Does this cluster own this value?
  END;
  C_LIC_NBR_case_layout := RECORD
    TYPEOF(h.C_LIC_NBR) C_LIC_NBR;
    UNSIGNED1 C_LIC_NBR_method; // This value could come from multiple BESTTYPE; track which one
  END;
  TAX_ID_case_layout := RECORD
    TYPEOF(h.TAX_ID) TAX_ID;
    UNSIGNED1 TAX_ID_method; // This value could come from multiple BESTTYPE; track which one
    UNSIGNED TAX_ID_own_cnt := 0; // Used for determining who OWNs this value
    BOOLEAN  TAX_ID_owns := false; // Does this cluster own this value?
  END;
  FEIN_case_layout := RECORD
    TYPEOF(h.FEIN) FEIN;
    UNSIGNED1 FEIN_method; // This value could come from multiple BESTTYPE; track which one
    UNSIGNED FEIN_own_cnt := 0; // Used for determining who OWNs this value
    BOOLEAN  FEIN_owns := false; // Does this cluster own this value?
  END;
  R := RECORD
    typeof(h.LNPID) LNPID := 0;
    DATASET(NPI_NUMBER_case_layout) NPI_NUMBER_cases;
    DATASET(DEA_NUMBER_case_layout) DEA_NUMBER_cases;
    DATASET(CLIA_NUMBER_case_layout) CLIA_NUMBER_cases;
    DATASET(MEDICARE_FACILITY_NUMBER_case_layout) MEDICARE_FACILITY_NUMBER_cases;
    DATASET(MEDICAID_NUMBER_case_layout) MEDICAID_NUMBER_cases;
    DATASET(NCPDP_NUMBER_case_layout) NCPDP_NUMBER_cases;
    DATASET(C_LIC_NBR_case_layout) C_LIC_NBR_cases;
    DATASET(TAX_ID_case_layout) TAX_ID_cases;
    DATASET(FEIN_case_layout) FEIN_cases;
  END;
  R T(BestBy_LNPID le) := TRANSFORM
    SELF.NPI_NUMBER_cases := DATASET([
        {le.BestNPI_NPI_NUMBER,1,le.NPI_NUMBER_BestNPI_row_cnt,false},
        {le.MostRecent_NPI_NUMBER,2,le.NPI_NUMBER_MostRecent_row_cnt,false}
          ],NPI_NUMBER_case_layout)(NPI_NUMBER NOT IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER));
    SELF.DEA_NUMBER_cases := DATASET([
        {le.BestDEA_DEA_NUMBER,1,le.DEA_NUMBER_BestDEA_row_cnt,false},
        {le.MostRecentDEA_DEA_NUMBER,2,le.DEA_NUMBER_MostRecentDEA_row_cnt,false}
          ],DEA_NUMBER_case_layout)(DEA_NUMBER NOT IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER));
    SELF.CLIA_NUMBER_cases := DATASET([
        {le.BestCLIA_CLIA_NUMBER,1,le.CLIA_NUMBER_BestCLIA_row_cnt,false},
        {le.MostCommonValue_CLIA_NUMBER,2,le.CLIA_NUMBER_MostCommonValue_row_cnt,false}
          ],CLIA_NUMBER_case_layout)(CLIA_NUMBER NOT IN SET(s.nulls_CLIA_NUMBER,CLIA_NUMBER));
    SELF.MEDICARE_FACILITY_NUMBER_cases := DATASET([
        {le.BestMedicare_MEDICARE_FACILITY_NUMBER,1,le.MEDICARE_FACILITY_NUMBER_BestMedicare_row_cnt,false},
        {le.MostCommonValue_MEDICARE_FACILITY_NUMBER,2,le.MEDICARE_FACILITY_NUMBER_MostCommonValue_row_cnt,false}
          ],MEDICARE_FACILITY_NUMBER_case_layout)(MEDICARE_FACILITY_NUMBER NOT IN SET(s.nulls_MEDICARE_FACILITY_NUMBER,MEDICARE_FACILITY_NUMBER));
    SELF.MEDICAID_NUMBER_cases := DATASET([
        {le.BestMedicaid_MEDICAID_NUMBER,1,le.MEDICAID_NUMBER_BestMedicaid_row_cnt,false},
        {le.MostCommonValue_MEDICAID_NUMBER,2,le.MEDICAID_NUMBER_MostCommonValue_row_cnt,false}
          ],MEDICAID_NUMBER_case_layout)(MEDICAID_NUMBER NOT IN SET(s.nulls_MEDICAID_NUMBER,MEDICAID_NUMBER));
    SELF.NCPDP_NUMBER_cases := DATASET([
        {le.BestNCPDP_NCPDP_NUMBER,1,le.NCPDP_NUMBER_BestNCPDP_row_cnt,false},
        {le.MostCommonValue_NCPDP_NUMBER,2,le.NCPDP_NUMBER_MostCommonValue_row_cnt,false}
          ],NCPDP_NUMBER_case_layout)(NCPDP_NUMBER NOT IN SET(s.nulls_NCPDP_NUMBER,NCPDP_NUMBER));
    SELF.C_LIC_NBR_cases := DATASET([
        {le.BestLICCommenest_C_LIC_NBR,3}
          ],C_LIC_NBR_case_layout)(C_LIC_NBR NOT IN SET(s.nulls_C_LIC_NBR,C_LIC_NBR));
    SELF.TAX_ID_cases := DATASET([
        {le.BestTaxID_TAX_ID,1,le.TAX_ID_BestTaxID_row_cnt,false},
        {le.BestTaxCommonest_TAX_ID,2,le.TAX_ID_BestTaxCommonest_row_cnt,false}
          ],TAX_ID_case_layout)(TAX_ID NOT IN SET(s.nulls_TAX_ID,TAX_ID));
    SELF.FEIN_cases := DATASET([
        {le.BestTaxID_FEIN,1,le.FEIN_BestTaxID_row_cnt,false},
        {le.BestTaxCommonest_FEIN,2,le.FEIN_BestTaxCommonest_row_cnt,false}
          ],FEIN_case_layout)(FEIN NOT IN SET(s.nulls_FEIN,FEIN));
    SELF := le; // Copy BASIS
  END;
  P1 := PROJECT(d,T(LEFT));
  RETURN P1;
END;
EXPORT BestBy_LNPID_child := F_BestBy_LNPID(BestBy_LNPID);
EXPORT BestBy_LNPID_child_np := F_BestBy_LNPID(BestBy_LNPID_np);
// Now to produce the slimmed down 'best propagation we can do for this basis'
// Additionally apply OWN processing
SHARED Flatten_BestBy_LNPID(DATASET({BestBy_LNPID_child}) d) := FUNCTION
  R := RECORD
    TYPEOF(h.LNPID) LNPID := 0;
    TYPEOF(h.NPI_NUMBER) NPI_NUMBER;
    UNSIGNED1 NPI_NUMBER_method; // This value could come from multiple BESTTYPE; track which one
    UNSIGNED NPI_NUMBER_own_cnt := 0; // Used for determining who OWNs this value
    BOOLEAN  NPI_NUMBER_owns := false; // Does this cluster own this value?
    TYPEOF(h.DEA_NUMBER) DEA_NUMBER;
    UNSIGNED1 DEA_NUMBER_method; // This value could come from multiple BESTTYPE; track which one
    UNSIGNED DEA_NUMBER_own_cnt := 0; // Used for determining who OWNs this value
    BOOLEAN  DEA_NUMBER_owns := false; // Does this cluster own this value?
    TYPEOF(h.CLIA_NUMBER) CLIA_NUMBER;
    UNSIGNED1 CLIA_NUMBER_method; // This value could come from multiple BESTTYPE; track which one
    UNSIGNED CLIA_NUMBER_own_cnt := 0; // Used for determining who OWNs this value
    BOOLEAN  CLIA_NUMBER_owns := false; // Does this cluster own this value?
    TYPEOF(h.MEDICARE_FACILITY_NUMBER) MEDICARE_FACILITY_NUMBER;
    UNSIGNED1 MEDICARE_FACILITY_NUMBER_method; // This value could come from multiple BESTTYPE; track which one
    UNSIGNED MEDICARE_FACILITY_NUMBER_own_cnt := 0; // Used for determining who OWNs this value
    BOOLEAN  MEDICARE_FACILITY_NUMBER_owns := false; // Does this cluster own this value?
    TYPEOF(h.MEDICAID_NUMBER) MEDICAID_NUMBER;
    UNSIGNED1 MEDICAID_NUMBER_method; // This value could come from multiple BESTTYPE; track which one
    UNSIGNED MEDICAID_NUMBER_own_cnt := 0; // Used for determining who OWNs this value
    BOOLEAN  MEDICAID_NUMBER_owns := false; // Does this cluster own this value?
    TYPEOF(h.NCPDP_NUMBER) NCPDP_NUMBER;
    UNSIGNED1 NCPDP_NUMBER_method; // This value could come from multiple BESTTYPE; track which one
    UNSIGNED NCPDP_NUMBER_own_cnt := 0; // Used for determining who OWNs this value
    BOOLEAN  NCPDP_NUMBER_owns := false; // Does this cluster own this value?
    TYPEOF(h.C_LIC_NBR) C_LIC_NBR;
    UNSIGNED1 C_LIC_NBR_method; // This value could come from multiple BESTTYPE; track which one
    TYPEOF(h.TAX_ID) TAX_ID;
    UNSIGNED1 TAX_ID_method; // This value could come from multiple BESTTYPE; track which one
    UNSIGNED TAX_ID_own_cnt := 0; // Used for determining who OWNs this value
    BOOLEAN  TAX_ID_owns := false; // Does this cluster own this value?
    TYPEOF(h.FEIN) FEIN;
    UNSIGNED1 FEIN_method; // This value could come from multiple BESTTYPE; track which one
    UNSIGNED FEIN_own_cnt := 0; // Used for determining who OWNs this value
    BOOLEAN  FEIN_owns := false; // Does this cluster own this value?
  END;
  R T(BestBy_LNPID_child le) := TRANSFORM
    SELF := le.NPI_NUMBER_cases[1];
    SELF := le.DEA_NUMBER_cases[1];
    SELF := le.CLIA_NUMBER_cases[1];
    SELF := le.MEDICARE_FACILITY_NUMBER_cases[1];
    SELF := le.MEDICAID_NUMBER_cases[1];
    SELF := le.NCPDP_NUMBER_cases[1];
    SELF := le.C_LIC_NBR_cases[1];
    SELF := le.TAX_ID_cases[1];
    SELF := le.FEIN_cases[1];
    SELF := le; // Copy all non-multi fields
  END;
  P1 := PROJECT(d,T(LEFT));
  OwnCands_NPI_NUMBER := SORT( DISTRIBUTE(P1(NPI_NUMBER_own_cnt>0),HASH(NPI_NUMBER)), NPI_NUMBER, -NPI_NUMBER_own_cnt, LNPID,LOCAL);
  PassThru_NPI_NUMBER := P1(NPI_NUMBER_own_cnt=0);
  TYPEOF(P1) AddOwn_NPI_NUMBER(P1 le,P1 ri) := TRANSFORM
    SELF.NPI_NUMBER_owns := le.NPI_NUMBER <> ri.NPI_NUMBER; // The first in line with this value
    SELF := ri;
  END;
  P1_After_NPI_NUMBER := ITERATE(OwnCands_NPI_NUMBER,AddOwn_NPI_NUMBER(LEFT,RIGHT),LOCAL) + PassThru_NPI_NUMBER;
  OwnCands_DEA_NUMBER := SORT( DISTRIBUTE(P1_After_NPI_NUMBER(DEA_NUMBER_own_cnt>0),HASH(DEA_NUMBER)), DEA_NUMBER, -DEA_NUMBER_own_cnt, LNPID,LOCAL);
  PassThru_DEA_NUMBER := P1_After_NPI_NUMBER(DEA_NUMBER_own_cnt=0);
  TYPEOF(P1_After_NPI_NUMBER) AddOwn_DEA_NUMBER(P1_After_NPI_NUMBER le,P1_After_NPI_NUMBER ri) := TRANSFORM
    SELF.DEA_NUMBER_owns := le.DEA_NUMBER <> ri.DEA_NUMBER; // The first in line with this value
    SELF := ri;
  END;
  P1_After_DEA_NUMBER := ITERATE(OwnCands_DEA_NUMBER,AddOwn_DEA_NUMBER(LEFT,RIGHT),LOCAL) + PassThru_DEA_NUMBER;
  OwnCands_CLIA_NUMBER := SORT( DISTRIBUTE(P1_After_DEA_NUMBER(CLIA_NUMBER_own_cnt>0),HASH(CLIA_NUMBER)), CLIA_NUMBER, -CLIA_NUMBER_own_cnt, LNPID,LOCAL);
  PassThru_CLIA_NUMBER := P1_After_DEA_NUMBER(CLIA_NUMBER_own_cnt=0);
  TYPEOF(P1_After_DEA_NUMBER) AddOwn_CLIA_NUMBER(P1_After_DEA_NUMBER le,P1_After_DEA_NUMBER ri) := TRANSFORM
    SELF.CLIA_NUMBER_owns := le.CLIA_NUMBER <> ri.CLIA_NUMBER; // The first in line with this value
    SELF := ri;
  END;
  P1_After_CLIA_NUMBER := ITERATE(OwnCands_CLIA_NUMBER,AddOwn_CLIA_NUMBER(LEFT,RIGHT),LOCAL) + PassThru_CLIA_NUMBER;
  OwnCands_MEDICARE_FACILITY_NUMBER := SORT( DISTRIBUTE(P1_After_CLIA_NUMBER(MEDICARE_FACILITY_NUMBER_own_cnt>0),HASH(MEDICARE_FACILITY_NUMBER)), MEDICARE_FACILITY_NUMBER, -MEDICARE_FACILITY_NUMBER_own_cnt, LNPID,LOCAL);
  PassThru_MEDICARE_FACILITY_NUMBER := P1_After_CLIA_NUMBER(MEDICARE_FACILITY_NUMBER_own_cnt=0);
  TYPEOF(P1_After_CLIA_NUMBER) AddOwn_MEDICARE_FACILITY_NUMBER(P1_After_CLIA_NUMBER le,P1_After_CLIA_NUMBER ri) := TRANSFORM
    SELF.MEDICARE_FACILITY_NUMBER_owns := le.MEDICARE_FACILITY_NUMBER <> ri.MEDICARE_FACILITY_NUMBER; // The first in line with this value
    SELF := ri;
  END;
  P1_After_MEDICARE_FACILITY_NUMBER := ITERATE(OwnCands_MEDICARE_FACILITY_NUMBER,AddOwn_MEDICARE_FACILITY_NUMBER(LEFT,RIGHT),LOCAL) + PassThru_MEDICARE_FACILITY_NUMBER;
  OwnCands_MEDICAID_NUMBER := SORT( DISTRIBUTE(P1_After_MEDICARE_FACILITY_NUMBER(MEDICAID_NUMBER_own_cnt>0),HASH(MEDICAID_NUMBER)), MEDICAID_NUMBER, -MEDICAID_NUMBER_own_cnt, LNPID,LOCAL);
  PassThru_MEDICAID_NUMBER := P1_After_MEDICARE_FACILITY_NUMBER(MEDICAID_NUMBER_own_cnt=0);
  TYPEOF(P1_After_MEDICARE_FACILITY_NUMBER) AddOwn_MEDICAID_NUMBER(P1_After_MEDICARE_FACILITY_NUMBER le,P1_After_MEDICARE_FACILITY_NUMBER ri) := TRANSFORM
    SELF.MEDICAID_NUMBER_owns := le.MEDICAID_NUMBER <> ri.MEDICAID_NUMBER; // The first in line with this value
    SELF := ri;
  END;
  P1_After_MEDICAID_NUMBER := ITERATE(OwnCands_MEDICAID_NUMBER,AddOwn_MEDICAID_NUMBER(LEFT,RIGHT),LOCAL) + PassThru_MEDICAID_NUMBER;
  OwnCands_NCPDP_NUMBER := SORT( DISTRIBUTE(P1_After_MEDICAID_NUMBER(NCPDP_NUMBER_own_cnt>0),HASH(NCPDP_NUMBER)), NCPDP_NUMBER, -NCPDP_NUMBER_own_cnt, LNPID,LOCAL);
  PassThru_NCPDP_NUMBER := P1_After_MEDICAID_NUMBER(NCPDP_NUMBER_own_cnt=0);
  TYPEOF(P1_After_MEDICAID_NUMBER) AddOwn_NCPDP_NUMBER(P1_After_MEDICAID_NUMBER le,P1_After_MEDICAID_NUMBER ri) := TRANSFORM
    SELF.NCPDP_NUMBER_owns := le.NCPDP_NUMBER <> ri.NCPDP_NUMBER; // The first in line with this value
    SELF := ri;
  END;
  P1_After_NCPDP_NUMBER := ITERATE(OwnCands_NCPDP_NUMBER,AddOwn_NCPDP_NUMBER(LEFT,RIGHT),LOCAL) + PassThru_NCPDP_NUMBER;
  OwnCands_TAX_ID := SORT( DISTRIBUTE(P1_After_NCPDP_NUMBER(TAX_ID_own_cnt>0),HASH(TAX_ID)), TAX_ID, -TAX_ID_own_cnt, LNPID,LOCAL);
  PassThru_TAX_ID := P1_After_NCPDP_NUMBER(TAX_ID_own_cnt=0);
  TYPEOF(P1_After_NCPDP_NUMBER) AddOwn_TAX_ID(P1_After_NCPDP_NUMBER le,P1_After_NCPDP_NUMBER ri) := TRANSFORM
    SELF.TAX_ID_owns := le.TAX_ID <> ri.TAX_ID; // The first in line with this value
    SELF := ri;
  END;
  P1_After_TAX_ID := ITERATE(OwnCands_TAX_ID,AddOwn_TAX_ID(LEFT,RIGHT),LOCAL) + PassThru_TAX_ID;
  OwnCands_FEIN := SORT( DISTRIBUTE(P1_After_TAX_ID(FEIN_own_cnt>0),HASH(FEIN)), FEIN, -FEIN_own_cnt, LNPID,LOCAL);
  PassThru_FEIN := P1_After_TAX_ID(FEIN_own_cnt=0);
  TYPEOF(P1_After_TAX_ID) AddOwn_FEIN(P1_After_TAX_ID le,P1_After_TAX_ID ri) := TRANSFORM
    SELF.FEIN_owns := le.FEIN <> ri.FEIN; // The first in line with this value
    SELF := ri;
  END;
  P1_After_FEIN := ITERATE(OwnCands_FEIN,AddOwn_FEIN(LEFT,RIGHT),LOCAL) + PassThru_FEIN;
  RETURN P1_After_FEIN;
END;
EXPORT BestBy_LNPID_best := Flatten_BestBy_LNPID(BestBy_LNPID_child);
EXPORT BestBy_LNPID_best_np := Flatten_BestBy_LNPID(BestBy_LNPID_child_np);
// Start to gather together all records with basis:LNPID,LIC_STATE
// 0 - Gathering type:MostRecentLIC Entries:1
  R0 := RECORD
    typeof(MostRecentLIC_method_C_LIC_NBR.LNPID) LNPID; // Need to copy in basis
    TYPEOF(MostRecentLIC_method_C_LIC_NBR.LIC_STATE) LIC_STATE;
    TYPEOF(MostRecentLIC_method_C_LIC_NBR.C_LIC_NBR) MostRecentLIC_C_LIC_NBR;
    UNSIGNED C_LIC_NBR_MostRecentLIC_Row_Cnt;
    UNSIGNED C_LIC_NBR_MostRecentLIC_Orig_Row_Cnt;
  END;
  R0 T0(MostRecentLIC_method_C_LIC_NBR ri) := TRANSFORM
    SELF.MostRecentLIC_C_LIC_NBR := ri.C_LIC_NBR;
    SELF.C_LIC_NBR_MostRecentLIC_Row_Cnt := ri.Row_Cnt;
    SELF.C_LIC_NBR_MostRecentLIC_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF := ri;
  END;
  J0 := PROJECT(MostRecentLIC_method_C_LIC_NBR,T0(left));
// 1 - Gathering type:BestLICLongest Entries:1
  R1 := RECORD
    J0; // The data so far
    TYPEOF(BestLICLongest_method_C_LIC_NBR.C_LIC_NBR) BestLICLongest_C_LIC_NBR;
    UNSIGNED C_LIC_NBR_BestLICLongest_Row_Cnt;
    UNSIGNED C_LIC_NBR_BestLICLongest_Orig_Row_Cnt;
  END;
  R1 T1(J0 le,BestLICLongest_method_C_LIC_NBR ri) := TRANSFORM
    SELF.BestLICLongest_C_LIC_NBR := ri.C_LIC_NBR;
    SELF.C_LIC_NBR_BestLICLongest_Row_Cnt := ri.Row_Cnt;
    SELF.C_LIC_NBR_BestLICLongest_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))'' OR (SALT30.StrType)le.LIC_STATE != ''; // See if LHS is null
    SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
    SELF.LIC_STATE := IF( has_left, le.LIC_STATE, ri.LIC_STATE );
    SELF := le;
  END;
  J1 := JOIN(J0,BestLICLongest_method_C_LIC_NBR,LEFT.LNPID = RIGHT.LNPID AND LEFT.LIC_STATE = RIGHT.LIC_STATE,T1(LEFT,RIGHT),FULL OUTER,LOCAL);
EXPORT BestBy_LNPID__LIC_STATE_np := J1;
EXPORT BestBy_LNPID__LIC_STATE := BestBy_LNPID__LIC_STATE_np : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::best::BestBy_LNPID__LIC_STATE',EXPIRE(Config.PersistExpire));
// Now gather some statistics to see how we did
  R := RECORD
    NumberOfBasis := COUNT(GROUP);
    REAL8 MostRecentLIC_C_LIC_NBR_pcnt := AVE(GROUP,IF(BestBy_LNPID__LIC_STATE.MostRecentLIC_C_LIC_NBR=(typeof(BestBy_LNPID__LIC_STATE.MostRecentLIC_C_LIC_NBR))'',0,100));
    REAL8 BestLICLongest_C_LIC_NBR_pcnt := AVE(GROUP,IF(BestBy_LNPID__LIC_STATE.BestLICLongest_C_LIC_NBR=(typeof(BestBy_LNPID__LIC_STATE.BestLICLongest_C_LIC_NBR))'',0,100));
  END;
EXPORT BestBy_LNPID__LIC_STATE_population := TABLE(BestBy_LNPID__LIC_STATE,R);
// Take the wide table and turn it into a child-dataset version
SHARED F_BestBy_LNPID__LIC_STATE(DATASET({BestBy_LNPID__LIC_STATE}) d) := FUNCTION
  C_LIC_NBR_case_layout := RECORD
    TYPEOF(h.C_LIC_NBR) C_LIC_NBR;
    UNSIGNED1 C_LIC_NBR_method; // This value could come from multiple BESTTYPE; track which one
  END;
  R := RECORD
    typeof(h.LNPID) LNPID := 0;
    TYPEOF(h.LIC_STATE) LIC_STATE;
    DATASET(C_LIC_NBR_case_layout) C_LIC_NBR_cases;
  END;
  R T(BestBy_LNPID__LIC_STATE le) := TRANSFORM
    SELF.C_LIC_NBR_cases := DATASET([
        {le.MostRecentLIC_C_LIC_NBR,1},
        {le.BestLICLongest_C_LIC_NBR,2}
          ],C_LIC_NBR_case_layout)(C_LIC_NBR NOT IN SET(s.nulls_C_LIC_NBR,C_LIC_NBR));
    SELF := le; // Copy BASIS
  END;
  P1 := PROJECT(d,T(LEFT));
  RETURN P1;
END;
EXPORT BestBy_LNPID__LIC_STATE_child := F_BestBy_LNPID__LIC_STATE(BestBy_LNPID__LIC_STATE);
EXPORT BestBy_LNPID__LIC_STATE_child_np := F_BestBy_LNPID__LIC_STATE(BestBy_LNPID__LIC_STATE_np);
// Now to produce the slimmed down 'best propagation we can do for this basis'
SHARED Flatten_BestBy_LNPID__LIC_STATE(DATASET({BestBy_LNPID__LIC_STATE_child}) d) := FUNCTION
  R := RECORD
    TYPEOF(h.LNPID) LNPID := 0;
    TYPEOF(h.LIC_STATE) LIC_STATE;
    TYPEOF(h.C_LIC_NBR) C_LIC_NBR;
    UNSIGNED1 C_LIC_NBR_method; // This value could come from multiple BESTTYPE; track which one
  END;
  R T(BestBy_LNPID__LIC_STATE_child le) := TRANSFORM
    SELF := le.C_LIC_NBR_cases[1];
    SELF := le; // Copy all non-multi fields
  END;
  P1 := PROJECT(d,T(LEFT));
  RETURN P1;
END;
EXPORT BestBy_LNPID__LIC_STATE_best := Flatten_BestBy_LNPID__LIC_STATE(BestBy_LNPID__LIC_STATE_child);
EXPORT BestBy_LNPID__LIC_STATE_best_np := Flatten_BestBy_LNPID__LIC_STATE(BestBy_LNPID__LIC_STATE_child_np);
EXPORT Stats := PARALLEL(OUTPUT(BestBy_LNPID_population,NAMED('BestBy_LNPID_Population')),OUTPUT(BestBy_LNPID__LIC_STATE_population,NAMED('BestBy_LNPID__LIC_STATE_Population')));
END;
