// Begin code to BEST data for each basis
import SALT27,ut;
EXPORT Best(DATASET(layout_HealthProvider) ih,layout_specificities.R s = Specificities(ih).specificities[1],BOOLEAN RoxieService=FALSE) := MODULE
h00 := BasicMatch(ih).input_file;
SHARED h := IF(RoxieService,Specificities(ih).input_file_np,h00);

//Create those fields with BestType: BestDIDBYDOB
// First step is to get all of the data slimmed and row-reduced
EXPORT BestDIDBYDOB_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0 AND ValidDOB(TRIM((STRING)DOB_month)+'/'+TRIM((STRING)DOB_day)+'/'+TRIM((STRING)DOB_year),SRC)),{LNPID,DOB_year,DOB_month,DOB_day,data_permits,DID,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,DOB_year,DOB_month,DOB_day,data_permits,DID,MERGE),HASH(LNPID)); // Slim and reduce row-count

Slim := TABLE(BestDIDBYDOB_tab_(DID NOT IN SET(s.nulls_DID,DID)),{LNPID,DOB_year,DOB_month,DOB_day,data_permits,DID,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT BestDIDBYDOB_tab_DID := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
grp := GROUP( BestDIDBYDOB_tab_DID,LNPID,ALL,LOCAL);
srt := SORT( grp,-Row_Cnt);
cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestDIDBYDOB_method_DID := cmn;

//Create those fields with BestType: BestDIDBYADDRESS
// First step is to get all of the data slimmed and row-reduced
EXPORT BestDIDBYADDRESS_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,ADDRESS_ID,data_permits,DID,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,ADDRESS_ID,data_permits,DID,MERGE),HASH(LNPID)); // Slim and reduce row-count
Slim_T := TABLE(BestDIDBYADDRESS_tab_(DID NOT IN SET(s.nulls_DID,DID)),{LNPID,ADDRESS_ID,data_permits,DID,Row_Cnt});
Slim   := TABLE(Slim_T(DID NOT IN SET(s.nulls_DID,DID)),{LNPID,ADDRESS_ID,data_permits,DID,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,DID,MERGE);
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT BestDIDBYADDRESS_tab_DID := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
grp := GROUP( BestDIDBYADDRESS_tab_DID,LNPID,ALL,LOCAL);
srt := SORT( grp,-Row_Cnt);
cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestDIDBYADDRESS_method_DID := cmn;

//Create those fields with BestType: BestDIDCommonest
// First step is to get all of the data slimmed and row-reduced
EXPORT BestDIDCommonest_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,data_permits,DID,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,data_permits,DID,MERGE),HASH(LNPID)); // Slim and reduce row-count
Slim := TABLE(BestDIDCommonest_tab_(DID NOT IN SET(s.nulls_DID,DID)),{LNPID,data_permits,DID,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT BestDIDCommonest_tab_DID := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
grp := GROUP( BestDIDCommonest_tab_DID,LNPID,ALL,LOCAL);
srt := SORT( grp,-Row_Cnt);
cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestDIDCommonest_method_DID := cmn;

//Create those fields with BestType: BestDOB
// First step is to get all of the data slimmed and row-reduced
EXPORT BestDOB_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,SRC,data_permits,DOB_year,DOB_month,DOB_day,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,SRC,data_permits,DOB_year,DOB_month,DOB_day,MERGE),HASH(LNPID)); // Slim and reduce row-count
Slim := TABLE(BestDOB_tab_((DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) OR DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) OR DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)),ValidDOB(TRIM((STRING)DOB_month)+'/'+TRIM((STRING)DOB_day)+'/'+TRIM((STRING)DOB_year),SRC)),{LNPID,SRC,data_permits,DOB_year,DOB_month,DOB_day,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT BestDOB_tab_DOB := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
Voted := TABLE( BestDOB_tab_DOB,{LNPID,data_permits,DOB_year,DOB_month,DOB_day,UNSIGNED Row_Cnt := 100 * fn_Best_DOB_Source_Votes(SRC,Row_Cnt)}); // Use fn_Best_DOB_Source_Votes to vote
Voted TR(Voted le, Voted ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT BestDOB_vote_DOB := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
grp := GROUP( BestDOB_vote_DOB,LNPID,ALL,LOCAL);
srt := SORT( grp,-Row_Cnt);
SALT27.MAC_Apply_Threshold(srt,200,o);
EXPORT BestDOB_method_DOB := o;

//Create those fields with BestType: BestDOBLongest
// First step is to get all of the data slimmed and row-reduced
EXPORT BestDOBLongest_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,data_permits,DOB_year,DOB_month,DOB_day,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,data_permits,DOB_year,DOB_month,DOB_day,MERGE),HASH(LNPID)); // Slim and reduce row-count
Slim := TABLE(BestDOBLongest_tab_((DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) OR DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) OR DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day))),{LNPID,data_permits,DOB_year,DOB_month,DOB_day,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT BestDOBLongest_tab_DOB := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
EXPORT BestDOBLongest_method_DOB := DEDUP( SORT( BestDOBLongest_tab_DOB,LNPID,-(IF(DOB_day=0,0,11) + IF(DOB_month=0,0,10) + IF(DOB_year=0,0,15)),-Row_Cnt,LOCAL),LNPID,LOCAL);

//Create those fields with BestType: BestDOBCommonest
// First step is to get all of the data slimmed and row-reduced
EXPORT BestDOBCommonest_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,data_permits,DOB_year,DOB_month,DOB_day,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,data_permits,DOB_year,DOB_month,DOB_day,MERGE),HASH(LNPID)); // Slim and reduce row-count
Slim := TABLE(BestDOBCommonest_tab_((DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) OR DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) OR DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day))),{LNPID,data_permits,DOB_year,DOB_month,DOB_day,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT BestDOBCommonest_tab_DOB := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Adjust scores for DOB using defined fuzzy logic
Fuzzy_layout := RECORD
BestDOBCommonest_tab_DOB.LNPID;
BestDOBCommonest_tab_DOB.DOB_year;
BestDOBCommonest_tab_DOB.DOB_month;
BestDOBCommonest_tab_DOB.DOB_day;
UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
UNSIGNED Row_Cnt;
UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestDOBCommonest_tab_DOB le,BestDOBCommonest_tab_DOB ri) := TRANSFORM
SELF.Row_Cnt := ri.Row_Cnt;
SELF.Orig_Row_Cnt := le.Row_Cnt;
SELF := le;
END;
Supports := JOIN(BestDOBCommonest_tab_DOB,BestDOBCommonest_tab_DOB, LEFT.LNPID = RIGHT.LNPID  AND SALT27.MOD_DateMatch(LEFT.DOB_year,LEFT.DOB_month,LEFT.DOB_day,RIGHT.DOB_year,RIGHT.DOB_month,RIGHT.DOB_day,true,true,12,true).NNEQ,NoteSupport(LEFT,RIGHT),LOCAL);
Supports TR(Supports le, Supports ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT BestDOBCommonest_fuzz_DOB := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value enforcing minimum
grp := GROUP( BestDOBCommonest_fuzz_DOB,LNPID,ALL,LOCAL);
srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestDOBCommonest_method_DOB := cmn(Row_Cnt >= 2);

//Create those fields with BestType: BestNPI
// First step is to get all of the data slimmed and row-reduced
EXPORT BestNPI_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,SRC,data_permits,NPI_NUMBER,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,SRC,data_permits,NPI_NUMBER,MERGE),HASH(LNPID)); // Slim and reduce row-count
Slim := TABLE(BestNPI_tab_(NPI_NUMBER NOT IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER)),{LNPID,SRC,data_permits,NPI_NUMBER,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT BestNPI_tab_NPI_NUMBER := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
Voted := TABLE( BestNPI_tab_NPI_NUMBER,{LNPID,data_permits,NPI_NUMBER,UNSIGNED Row_Cnt := 100 * fn_Best_NPI_Source_Votes(SRC,Row_Cnt)}); // Use fn_Best_NPI_Source_Votes to vote
Voted TR(Voted le, Voted ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT BestNPI_vote_NPI_NUMBER := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
grp := GROUP( BestNPI_vote_NPI_NUMBER,LNPID,ALL,LOCAL);
srt := SORT( grp,-Row_Cnt);
SALT27.MAC_Apply_Threshold(srt,200,o);
EXPORT BestNPI_method_NPI_NUMBER := o;

//Create those fields with BestType: MostRecent
// First step is to get all of the data slimmed and row-reduced
EXPORT MostRecent_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,data_permits,NPI_NUMBER,UPIN,UNSIGNED Early_Date := MIN(GROUP,IF(DT_LAST_SEEN=0,99999999,DT_LAST_SEEN)),UNSIGNED Late_Date := MAX(GROUP,DT_LAST_SEEN),UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,data_permits,NPI_NUMBER,UPIN,MERGE),HASH(LNPID)); // Slim and reduce row-count
Slim := TABLE(MostRecent_tab_(NPI_NUMBER NOT IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER)),{LNPID,data_permits,NPI_NUMBER,Early_Date,Late_Date,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT MostRecent_tab_NPI_NUMBER := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
Slim := TABLE(MostRecent_tab_(UPIN NOT IN SET(s.nulls_UPIN,UPIN)),{LNPID,data_permits,UPIN,Early_Date,Late_Date,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT MostRecent_tab_UPIN := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value enforcing minimum
EXPORT MostRecent_method_NPI_NUMBER := DEDUP( SORT( MostRecent_tab_NPI_NUMBER(Late_Date>0,Early_Date<99999999),LNPID,-Late_Date,-Early_Date,LOCAL)(Row_Cnt >= 2),LNPID,LOCAL);
//Now actually find the best value enforcing minimum
EXPORT MostRecent_method_UPIN := DEDUP( SORT( MostRecent_tab_UPIN(Late_Date>0,Early_Date<99999999),LNPID,-Late_Date,-Early_Date,LOCAL)(Row_Cnt >= 2),LNPID,LOCAL);

//Create those fields with BestType: MostRecentAddr
// First step is to get all of the data slimmed and row-reduced
EXPORT MostRecentAddr_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0,ST NOT IN SET(s.nulls_ST,ST)),{LNPID,ST,data_permits,PRIM_RANGE,SEC_RANGE,PRIM_NAME,UNSIGNED Early_Date := MIN(GROUP,IF(DT_LAST_SEEN=0,99999999,DT_LAST_SEEN)),UNSIGNED Late_Date := MAX(GROUP,DT_LAST_SEEN),UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,ST,data_permits,PRIM_RANGE,SEC_RANGE,PRIM_NAME,MERGE),HASH(LNPID,ST)); // Slim and reduce row-count
Slim := TABLE(MostRecentAddr_tab_(~(PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) AND SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) AND PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME))),{LNPID,ST,data_permits,PRIM_RANGE,SEC_RANGE,PRIM_NAME,Early_Date,Late_Date,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT MostRecentAddr_tab_ADDR := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value enforcing minimum
// EXPORT MostRecentAddr_method_ADDR := DEDUP( SORT( MostRecentAddr_tab_ADDR(Late_Date>0,Early_Date<99999999),LNPID,ST,-Late_Date,-Early_Date,LOCAL)(Row_Cnt >= 2),LNPID,ST,LOCAL);
EXPORT MostRecentAddr_method_ADDR := DEDUP( SORT( MostRecentAddr_tab_ADDR(Late_Date>0,Early_Date<99999999),LNPID,ST,ST,-Late_Date,-Early_Date,LOCAL)(Row_Cnt >= 2),LNPID,ST,ST,LOCAL);

//Create those fields with BestType: BestAddressCommonest
// First step is to get all of the data slimmed and row-reduced
EXPORT BestAddressCommonest_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,data_permits,PRIM_RANGE,SEC_RANGE,PRIM_NAME,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,data_permits,PRIM_RANGE,SEC_RANGE,PRIM_NAME,MERGE),HASH(LNPID)); // Slim and reduce row-count
Slim := TABLE(BestAddressCommonest_tab_(~(PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) AND SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) AND PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME))),{LNPID,data_permits,PRIM_RANGE,SEC_RANGE,PRIM_NAME,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT BestAddressCommonest_tab_ADDR := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Adjust scores for ADDR using defined fuzzy logic
Fuzzy_layout := RECORD
BestAddressCommonest_tab_ADDR.LNPID;
BestAddressCommonest_tab_ADDR.PRIM_RANGE;
BestAddressCommonest_tab_ADDR.SEC_RANGE;
BestAddressCommonest_tab_ADDR.PRIM_NAME;
UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
UNSIGNED Row_Cnt;
UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestAddressCommonest_tab_ADDR le,BestAddressCommonest_tab_ADDR ri) := TRANSFORM
SELF.Row_Cnt := ri.Row_Cnt;
SELF.Orig_Row_Cnt := le.Row_Cnt;
SELF := le;
END;
Supports := JOIN(BestAddressCommonest_tab_ADDR,BestAddressCommonest_tab_ADDR, LEFT.LNPID = RIGHT.LNPID  AND ( (LEFT.PRIM_RANGE = (TYPEOF(LEFT.PRIM_RANGE))'' OR RIGHT.PRIM_RANGE = (TYPEOF(RIGHT.PRIM_RANGE))'' OR LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE ) AND (LEFT.SEC_RANGE = (TYPEOF(LEFT.SEC_RANGE))'' OR RIGHT.SEC_RANGE = (TYPEOF(RIGHT.SEC_RANGE))'' ) AND (LEFT.PRIM_NAME = (TYPEOF(LEFT.PRIM_NAME))'' OR RIGHT.PRIM_NAME = (TYPEOF(RIGHT.PRIM_NAME))'' OR LEFT.PRIM_NAME = RIGHT.PRIM_NAME ) ),NoteSupport(LEFT,RIGHT),LOCAL);
Supports TR(Supports le, Supports ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT BestAddressCommonest_fuzz_ADDR := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
grp := GROUP( BestAddressCommonest_fuzz_ADDR,LNPID,ALL,LOCAL);
srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestAddressCommonest_method_ADDR := cmn;

//Create those fields with BestType: MostRecentLIC
// First step is to get all of the data slimmed and row-reduced
EXPORT MostRecentLIC_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,LIC_STATE,data_permits,LIC_NBR,UNSIGNED Early_Date := MIN(GROUP,IF(DT_LIC_EXPIRATION=0,99999999,DT_LIC_EXPIRATION)),UNSIGNED Late_Date := MAX(GROUP,DT_LIC_EXPIRATION),UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,LIC_STATE,data_permits,LIC_NBR,MERGE),HASH(LNPID)); // Slim and reduce row-count
Slim := TABLE(MostRecentLIC_tab_(LIC_NBR NOT IN SET(s.nulls_LIC_NBR,LIC_NBR)),{LNPID,LIC_STATE,data_permits,LIC_NBR,Early_Date,Late_Date,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT MostRecentLIC_tab_LIC_NBR := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value
EXPORT MostRecentLIC_method_LIC_NBR := DEDUP( SORT( MostRecentLIC_tab_LIC_NBR(Late_Date>0,Early_Date<99999999),LNPID,LIC_STATE,-Late_Date,-Early_Date,LOCAL),LNPID,LIC_STATE,LOCAL);

//Create those fields with BestType: BestLICCommenest
// First step is to get all of the data slimmed and row-reduced
EXPORT BestLICCommenest_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,data_permits,LIC_NBR,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,data_permits,LIC_NBR,MERGE),HASH(LNPID)); // Slim and reduce row-count
Slim := TABLE(BestLICCommenest_tab_(LIC_NBR NOT IN SET(s.nulls_LIC_NBR,LIC_NBR)),{LNPID,data_permits,LIC_NBR,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT BestLICCommenest_tab_LIC_NBR := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
grp := GROUP( BestLICCommenest_tab_LIC_NBR,LNPID,ALL,LOCAL);
srt := SORT( grp,-Row_Cnt);
cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestLICCommenest_method_LIC_NBR := cmn;

//Create those fields with BestType: BestLICLongest
// First step is to get all of the data slimmed and row-reduced
EXPORT BestLICLongest_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,LIC_STATE,data_permits,LIC_NBR,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,LIC_STATE,data_permits,LIC_NBR,MERGE),HASH(LNPID)); // Slim and reduce row-count
Slim := TABLE(BestLICLongest_tab_(LIC_NBR NOT IN SET(s.nulls_LIC_NBR,LIC_NBR)),{LNPID,LIC_STATE,data_permits,LIC_NBR,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT BestLICLongest_tab_LIC_NBR := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
EXPORT BestLICLongest_method_LIC_NBR := DEDUP( SORT( BestLICLongest_tab_LIC_NBR,LNPID,LIC_STATE,-LENGTH(TRIM((SALT27.StrType)LIC_NBR)),-Row_Cnt,LOCAL),LNPID,LIC_STATE,LOCAL);

//Create those fields with BestType: MostRecentDEA
// First step is to get all of the data slimmed and row-reduced
EXPORT MostRecentDEA_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,data_permits,DEA_NUMBER,UNSIGNED Early_Date := MIN(GROUP,IF(DT_DEA_EXPIRATION=0,99999999,DT_DEA_EXPIRATION)),UNSIGNED Late_Date := MAX(GROUP,DT_DEA_EXPIRATION),UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,data_permits,DEA_NUMBER,MERGE),HASH(LNPID)); // Slim and reduce row-count
Slim := TABLE(MostRecentDEA_tab_(DEA_NUMBER NOT IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER)),{LNPID,data_permits,DEA_NUMBER,Early_Date,Late_Date,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT MostRecentDEA_tab_DEA_NUMBER := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value
EXPORT MostRecentDEA_method_DEA_NUMBER := DEDUP( SORT( MostRecentDEA_tab_DEA_NUMBER(Late_Date>0,Early_Date<99999999),LNPID,-Late_Date,-Early_Date,LOCAL),LNPID,LOCAL);

//Create those fields with BestType: BestFirstName
// First step is to get all of the data slimmed and row-reduced
EXPORT BestFirstName_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,data_permits,FNAME,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,data_permits,FNAME,MERGE),HASH(LNPID)); // Slim and reduce row-count
Slim := TABLE(BestFirstName_tab_(FNAME NOT IN SET(s.nulls_FNAME,FNAME)),{LNPID,data_permits,FNAME,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT BestFirstName_tab_FNAME := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Adjust scores for FNAME using defined fuzzy logic
Fuzzy_layout := RECORD
BestFirstName_tab_FNAME.LNPID;
BestFirstName_tab_FNAME.FNAME;
UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
UNSIGNED Row_Cnt;
UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestFirstName_tab_FNAME le,BestFirstName_tab_FNAME ri) := TRANSFORM
SELF.Row_Cnt := ri.Row_Cnt;
SELF.Orig_Row_Cnt := le.Row_Cnt;
SELF := le;
END;
Supports := JOIN(BestFirstName_tab_FNAME,BestFirstName_tab_FNAME, LEFT.LNPID = RIGHT.LNPID  AND ( LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME OR RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME OR SALT27.WithinEditN(LEFT.FNAME,RIGHT.FNAME,1)  OR fn_PreferredName(RIGHT.FNAME) = fn_PreferredName(LEFT.FNAME)  ),NoteSupport(LEFT,RIGHT),LOCAL);
Supports TR(Supports le, Supports ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT BestFirstName_fuzz_FNAME := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
grp := GROUP( BestFirstName_fuzz_FNAME,LNPID,ALL,LOCAL);
srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestFirstName_method_FNAME := cmn;

//Create those fields with BestType: CommonFirstName
// First step is to get all of the data slimmed and row-reduced
EXPORT CommonFirstName_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,data_permits,FNAME,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,data_permits,FNAME,MERGE),HASH(LNPID)); // Slim and reduce row-count
Slim := TABLE(CommonFirstName_tab_(FNAME NOT IN SET(s.nulls_FNAME,FNAME)),{LNPID,data_permits,FNAME,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT CommonFirstName_tab_FNAME := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
grp := GROUP( CommonFirstName_tab_FNAME,LNPID,ALL,LOCAL);
srt := SORT( grp,-Row_Cnt);
cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT CommonFirstName_method_FNAME := cmn;

//Create those fields with BestType: BestTaxCommonest
// First step is to get all of the data slimmed and row-reduced
EXPORT BestTaxCommonest_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,data_permits,TAX_ID,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,data_permits,TAX_ID,MERGE),HASH(LNPID)); // Slim and reduce row-count
Slim := TABLE(BestTaxCommonest_tab_(TAX_ID NOT IN SET(s.nulls_TAX_ID,TAX_ID)),{LNPID,data_permits,TAX_ID,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT BestTaxCommonest_tab_TAX_ID := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value enforcing minimum
grp := GROUP( BestTaxCommonest_tab_TAX_ID,LNPID,ALL,LOCAL);
srt := SORT( grp,-Row_Cnt);
cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestTaxCommonest_method_TAX_ID := cmn(Row_Cnt >= 2);

//Create those fields with BestType: UniqueSingleValue
// First step is to get all of the data slimmed and row-reduced
EXPORT UniqueSingleValue_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,data_permits,GENDER,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,data_permits,GENDER,MERGE),HASH(LNPID)); // Slim and reduce row-count
Slim := TABLE(UniqueSingleValue_tab_(GENDER NOT IN SET(s.nulls_GENDER,GENDER)),{LNPID,data_permits,GENDER,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT UniqueSingleValue_tab_GENDER := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
grp := GROUP( UniqueSingleValue_tab_GENDER,LNPID,ALL,LOCAL);
srt := SORT( grp,-Row_Cnt);
cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
// A best solution is unique if its Row_Cnt is the same as the sum of the row_cnts.
Totals := TABLE(grp,{LNPID,Tot := SUM(GROUP,Row_Cnt)},LNPID);
export UniqueSingleValue_method_GENDER := JOIN( cmn,Totals,left.LNPID = right.LNPID AND LEFT.Row_Cnt = RIGHT.Tot,TRANSFORM(LEFT),LOCAL);

//Create those fields with BestType: ExtendedCommonValue
// First step is to get all of the data slimmed and row-reduced
EXPORT ExtendedCommonValue_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,data_permits,SNAME,MNAME,NPI_NUMBER,DEA_NUMBER,UPIN,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,data_permits,SNAME,MNAME,NPI_NUMBER,DEA_NUMBER,UPIN,MERGE),HASH(LNPID)); // Slim and reduce row-count
Slim := TABLE(ExtendedCommonValue_tab_(SNAME NOT IN SET(s.nulls_SNAME,SNAME)),{LNPID,data_permits,SNAME,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT ExtendedCommonValue_tab_SNAME := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
Slim := TABLE(ExtendedCommonValue_tab_(MNAME NOT IN SET(s.nulls_MNAME,MNAME)),{LNPID,data_permits,MNAME,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT ExtendedCommonValue_tab_MNAME := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
Slim := TABLE(ExtendedCommonValue_tab_(NPI_NUMBER NOT IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER)),{LNPID,data_permits,NPI_NUMBER,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT ExtendedCommonValue_tab_NPI_NUMBER := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
Slim := TABLE(ExtendedCommonValue_tab_(DEA_NUMBER NOT IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER)),{LNPID,data_permits,DEA_NUMBER,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT ExtendedCommonValue_tab_DEA_NUMBER := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
Slim := TABLE(ExtendedCommonValue_tab_(UPIN NOT IN SET(s.nulls_UPIN,UPIN)),{LNPID,data_permits,UPIN,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT ExtendedCommonValue_tab_UPIN := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value enforcing minimum
grp := GROUP( ExtendedCommonValue_tab_SNAME,LNPID,ALL,LOCAL);
srt := SORT( grp,-Row_Cnt);
cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT ExtendedCommonValue_method_SNAME := cmn(Row_Cnt >= 2);
//Now actually find the best value enforcing minimum
grp := GROUP( ExtendedCommonValue_tab_MNAME,LNPID,ALL,LOCAL);
srt := SORT( grp,-Row_Cnt);
cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT ExtendedCommonValue_method_MNAME := cmn(Row_Cnt >= 2);
//Now actually find the best value enforcing minimum
grp := GROUP( ExtendedCommonValue_tab_NPI_NUMBER,LNPID,ALL,LOCAL);
srt := SORT( grp,-Row_Cnt);
cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT ExtendedCommonValue_method_NPI_NUMBER := cmn(Row_Cnt >= 2);
//Now actually find the best value enforcing minimum
grp := GROUP( ExtendedCommonValue_tab_DEA_NUMBER,LNPID,ALL,LOCAL);
srt := SORT( grp,-Row_Cnt);
cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT ExtendedCommonValue_method_DEA_NUMBER := cmn(Row_Cnt >= 2);
//Now actually find the best value enforcing minimum
grp := GROUP( ExtendedCommonValue_tab_UPIN,LNPID,ALL,LOCAL);
srt := SORT( grp,-Row_Cnt);
cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT ExtendedCommonValue_method_UPIN := cmn(Row_Cnt >= 2);

//Create those fields with BestType: LongestValue
// First step is to get all of the data slimmed and row-reduced
EXPORT LongestValue_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,data_permits,SNAME,MNAME,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,data_permits,SNAME,MNAME,MERGE),HASH(LNPID)); // Slim and reduce row-count
Slim := TABLE(LongestValue_tab_(SNAME NOT IN SET(s.nulls_SNAME,SNAME)),{LNPID,data_permits,SNAME,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT LongestValue_tab_SNAME := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
Slim := TABLE(LongestValue_tab_(MNAME NOT IN SET(s.nulls_MNAME,MNAME)),{LNPID,data_permits,MNAME,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT LongestValue_tab_MNAME := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
EXPORT LongestValue_method_SNAME := DEDUP( SORT( LongestValue_tab_SNAME,LNPID,-LENGTH(TRIM((SALT27.StrType)SNAME)),-Row_Cnt,LOCAL),LNPID,LOCAL);
//Now actually find the best value
EXPORT LongestValue_method_MNAME := DEDUP( SORT( LongestValue_tab_MNAME,LNPID,-LENGTH(TRIM((SALT27.StrType)MNAME)),-Row_Cnt,LOCAL),LNPID,LOCAL);

//Create those fields with BestType: CurrentLastName
// First step is to get all of the data slimmed and row-reduced
EXPORT CurrentLastName_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,data_permits,LNAME,UNSIGNED Early_Date := MIN(GROUP,IF(DT_LAST_SEEN=0,99999999,DT_LAST_SEEN)),UNSIGNED Late_Date := MAX(GROUP,DT_LAST_SEEN),UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,data_permits,LNAME,MERGE),HASH(LNPID)); // Slim and reduce row-count
Slim := TABLE(CurrentLastName_tab_(LNAME NOT IN SET(s.nulls_LNAME,LNAME)),{LNPID,data_permits,LNAME,Early_Date,Late_Date,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT CurrentLastName_tab_LNAME := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value
EXPORT CurrentLastName_method_LNAME := DEDUP( SORT( CurrentLastName_tab_LNAME(Late_Date>0,Early_Date<99999999),LNPID,-Late_Date,-Early_Date,LOCAL),LNPID,LOCAL);

//Create those fields with BestType: BestLastName
// First step is to get all of the data slimmed and row-reduced
EXPORT BestLastName_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,data_permits,LNAME,UNSIGNED Early_Date := MIN(GROUP,IF(DT_LAST_SEEN=0,99999999,DT_LAST_SEEN)),UNSIGNED Late_Date := MAX(GROUP,DT_LAST_SEEN),UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,data_permits,LNAME,MERGE),HASH(LNPID)); // Slim and reduce row-count
Slim := TABLE(BestLastName_tab_(LNAME NOT IN SET(s.nulls_LNAME,LNAME)),{LNPID,data_permits,LNAME,Early_Date,Late_Date,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT BestLastName_tab_LNAME := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
// Adjust scores for LNAME using defined fuzzy logic
Fuzzy_layout := RECORD
BestLastName_tab_LNAME.LNPID;
BestLastName_tab_LNAME.LNAME;
UNSIGNED Early_Date;
UNSIGNED Late_Date;
UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
UNSIGNED Row_Cnt;
UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestLastName_tab_LNAME le,BestLastName_tab_LNAME ri) := TRANSFORM
SELF.Row_Cnt := ri.Row_Cnt;
SELF.Orig_Row_Cnt := le.Row_Cnt;
SELF := le;
END;
Supports := JOIN(BestLastName_tab_LNAME,BestLastName_tab_LNAME, LEFT.LNPID = RIGHT.LNPID  AND ( LEFT.LNAME[1..LENGTH(TRIM(RIGHT.LNAME))] = RIGHT.LNAME OR RIGHT.LNAME[1..LENGTH(TRIM(LEFT.LNAME))] = LEFT.LNAME OR SALT27.WithinEditN(LEFT.LNAME,RIGHT.LNAME,2)  ),NoteSupport(LEFT,RIGHT),LOCAL);
Supports TR(Supports le, Supports ri) := TRANSFORM
SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT BestLastName_fuzz_LNAME := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value enforcing minimum
EXPORT BestLastName_method_LNAME := DEDUP( SORT( BestLastName_fuzz_LNAME(Late_Date>0,Early_Date<99999999),LNPID,-Late_Date,-Early_Date,LOCAL)(Row_Cnt >= 2),LNPID,LOCAL);

//Create those fields with BestType: BestSecRange
// First step is to get all of the data slimmed and row-reduced
EXPORT BestSecRange_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0,PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE),PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME),ZIP NOT IN SET(s.nulls_ZIP,ZIP)),{LNPID,PRIM_RANGE,PRIM_NAME,ZIP,data_permits,SEC_RANGE,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,PRIM_RANGE,PRIM_NAME,ZIP,data_permits,SEC_RANGE,MERGE),HASH(LNPID,PRIM_RANGE,PRIM_NAME,ZIP)); // Slim and reduce row-count
Slim := TABLE(BestSecRange_tab_(SEC_RANGE NOT IN SET(s.nulls_SEC_RANGE,SEC_RANGE)),{LNPID,PRIM_RANGE,PRIM_NAME,ZIP,data_permits,SEC_RANGE,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT BestSecRange_tab_SEC_RANGE := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Adjust scores for SEC_RANGE using defined fuzzy logic
Fuzzy_layout := RECORD
BestSecRange_tab_SEC_RANGE.LNPID;
BestSecRange_tab_SEC_RANGE.PRIM_RANGE;
BestSecRange_tab_SEC_RANGE.PRIM_NAME;
BestSecRange_tab_SEC_RANGE.ZIP;
BestSecRange_tab_SEC_RANGE.SEC_RANGE;
UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
UNSIGNED Row_Cnt;
UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestSecRange_tab_SEC_RANGE le,BestSecRange_tab_SEC_RANGE ri) := TRANSFORM
SELF.Row_Cnt := ri.Row_Cnt;
SELF.Orig_Row_Cnt := le.Row_Cnt;
SELF := le;
END;
Supports := JOIN(BestSecRange_tab_SEC_RANGE,BestSecRange_tab_SEC_RANGE, LEFT.LNPID = RIGHT.LNPID  AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND LEFT.ZIP = RIGHT.ZIP AND ( LEFT.SEC_RANGE = (TYPEOF(LEFT.SEC_RANGE))'' OR RIGHT.SEC_RANGE = (TYPEOF(RIGHT.SEC_RANGE))''  ),NoteSupport(LEFT,RIGHT),LOCAL);
Supports TR(Supports le, Supports ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT BestSecRange_fuzz_SEC_RANGE := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
grp := GROUP( BestSecRange_fuzz_SEC_RANGE,LNPID,PRIM_RANGE,PRIM_NAME,ZIP,ALL,LOCAL);
srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestSecRange_method_SEC_RANGE := cmn;

//Create those fields with BestType: BestCity
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCity_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0,ZIP NOT IN SET(s.nulls_ZIP,ZIP)),{LNPID,ZIP,data_permits,V_CITY_NAME,ST,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,ZIP,data_permits,V_CITY_NAME,ST,MERGE),HASH(LNPID,ZIP)); // Slim and reduce row-count
Slim := TABLE(BestCity_tab_(V_CITY_NAME NOT IN SET(s.nulls_V_CITY_NAME,V_CITY_NAME)),{LNPID,ZIP,data_permits,V_CITY_NAME,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT BestCity_tab_V_CITY_NAME := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
Slim := TABLE(BestCity_tab_(ST NOT IN SET(s.nulls_ST,ST)),{LNPID,ZIP,data_permits,ST,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT BestCity_tab_ST := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
grp := GROUP( BestCity_tab_V_CITY_NAME,LNPID,ZIP,ALL,LOCAL);
srt := SORT( grp,-Row_Cnt);
cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestCity_method_V_CITY_NAME := cmn;
//Now actually find the best value
grp := GROUP( BestCity_tab_ST,LNPID,ZIP,ALL,LOCAL);
srt := SORT( grp,-Row_Cnt);
cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestCity_method_ST := cmn;

//Create those fields with BestType: BestTaxID
// First step is to get all of the data slimmed and row-reduced
EXPORT BestTaxID_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,data_permits,TAX_ID,UNSIGNED Early_Date := MIN(GROUP,IF(DT_LAST_SEEN=0,99999999,DT_LAST_SEEN)),UNSIGNED Late_Date := MAX(GROUP,DT_LAST_SEEN),UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,data_permits,TAX_ID,MERGE),HASH(LNPID)); // Slim and reduce row-count
Slim := TABLE(BestTaxID_tab_(TAX_ID NOT IN SET(s.nulls_TAX_ID,TAX_ID)),{LNPID,data_permits,TAX_ID,Early_Date,Late_Date,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT BestTaxID_tab_TAX_ID := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value
EXPORT BestTaxID_method_TAX_ID := DEDUP( SORT( BestTaxID_tab_TAX_ID(Late_Date>0,Early_Date<99999999),LNPID,-Late_Date,-Early_Date,LOCAL),LNPID,LOCAL);

//Create those fields with BestType: BestPhoneCommonest
// First step is to get all of the data slimmed and row-reduced
EXPORT BestPhoneCommonest_tab_ := DISTRIBUTE(TABLE(h(LNPID <> 0),{LNPID,data_permits,PHONE,UNSIGNED Row_Cnt := COUNT(GROUP)},LNPID,data_permits,PHONE,MERGE),HASH(LNPID)); // Slim and reduce row-count
Slim := TABLE(BestPhoneCommonest_tab_(PHONE <> (TYPEOF(PHONE))''),{LNPID,data_permits,PHONE,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.data_permits := le.data_permits|ri.data_permits;
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT BestPhoneCommonest_tab_PHONE := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value enforcing minimum
grp := GROUP( BestPhoneCommonest_tab_PHONE,LNPID,ALL,LOCAL);
srt := SORT( grp,-Row_Cnt);
cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestPhoneCommonest_method_PHONE := cmn(Row_Cnt >= 2);
// Start to gather together all records with basis:LNPID,DOB_year,DOB_month,DOB_day,data_permits
// 0 - Gathering type:BestDIDBYDOB Entries:1
R0 := RECORD
typeof(BestDIDBYDOB_method_DID.LNPID) LNPID; // Need to copy in basis
TYPEOF(BestDIDBYDOB_method_DID.DOB_year) DOB_year;
TYPEOF(BestDIDBYDOB_method_DID.DOB_month) DOB_month;
TYPEOF(BestDIDBYDOB_method_DID.DOB_day) DOB_day;
TYPEOF(BestDIDBYDOB_method_DID.DID) BestDIDBYDOB_DID;
UNSIGNED DID_BestDIDBYDOB_Row_Cnt;
UNSIGNED1 DID_BestDIDBYDOB_data_permits;
END;
R0 T0(BestDIDBYDOB_method_DID ri) := TRANSFORM
SELF.BestDIDBYDOB_DID := ri.DID;
SELF.DID_BestDIDBYDOB_Row_Cnt := ri.Row_Cnt;
SELF.DID_BestDIDBYDOB_data_permits := ri.data_permits;
SELF := ri;
END;
J0 := PROJECT(BestDIDBYDOB_method_DID,T0(left));
EXPORT BestBy_LNPID__DOB_np := J0;
EXPORT BestBy_LNPID__DOB := BestBy_LNPID__DOB_np  : PERSIST('~temp::LNPID::HealthCareProviderHeader_prod::BestBy_LNPID__DOB::best');
// Now gather some statistics to see how we did
R := RECORD
NumberOfBasis := COUNT(GROUP);
REAL8 BestDIDBYDOB_DID_pcnt := AVE(GROUP,IF(BestBy_LNPID__DOB.BestDIDBYDOB_DID=(typeof(BestBy_LNPID__DOB.BestDIDBYDOB_DID))'',0,100));
UNSIGNED BestDIDBYDOB_DID_permit1_cnt := COUNT(GROUP,BestBy_LNPID__DOB.DID_BestDIDBYDOB_data_permits&1<>0);
UNSIGNED BestDIDBYDOB_DID_permit2_cnt := COUNT(GROUP,BestBy_LNPID__DOB.DID_BestDIDBYDOB_data_permits&2<>0);
UNSIGNED BestDIDBYDOB_DID_permit3_cnt := COUNT(GROUP,BestBy_LNPID__DOB.DID_BestDIDBYDOB_data_permits&4<>0);
UNSIGNED BestDIDBYDOB_DID_permit4_cnt := COUNT(GROUP,BestBy_LNPID__DOB.DID_BestDIDBYDOB_data_permits&8<>0);
UNSIGNED BestDIDBYDOB_DID_permit5_cnt := COUNT(GROUP,BestBy_LNPID__DOB.DID_BestDIDBYDOB_data_permits&16<>0);
END;
EXPORT BestBy_LNPID__DOB_population := TABLE(BestBy_LNPID__DOB,R);
// Take the wide table and turn it into a child-dataset version
SHARED F_BestBy_LNPID__DOB(DATASET({BestBy_LNPID__DOB}) d) := FUNCTION
DID_case_layout := RECORD
TYPEOF(h.DID) DID;
UNSIGNED1 DID_data_permits;
UNSIGNED1 DID_method; // This value could come from multiple BESTTYPE; track which one
END;
R := RECORD
typeof(h.LNPID) LNPID := 0;
TYPEOF(h.DOB_year) DOB_year;
TYPEOF(h.DOB_month) DOB_month;
TYPEOF(h.DOB_day) DOB_day;
DATASET(DID_case_layout) DID_cases;
END;
R T(BestBy_LNPID__DOB le) := TRANSFORM
SELF.DID_cases := DATASET([
{le.BestDIDBYDOB_DID,le.DID_BestDIDBYDOB_data_permits,1}
],DID_case_layout)(DID NOT IN SET(s.nulls_DID,DID));
SELF := le; // Copy BASIS
END;
P1 := PROJECT(d,T(LEFT));
RETURN P1;
END;
EXPORT BestBy_LNPID__DOB_child := F_BestBy_LNPID__DOB(BestBy_LNPID__DOB);
EXPORT BestBy_LNPID__DOB_child_np := F_BestBy_LNPID__DOB(BestBy_LNPID__DOB_np);
// Now to produce the slimmed down 'best propagation we can do for this basis'
SHARED Flatten_BestBy_LNPID__DOB(DATASET({BestBy_LNPID__DOB_child}) d) := FUNCTION
R := RECORD
TYPEOF(h.LNPID) LNPID := 0;
TYPEOF(h.DOB_year) DOB_year;
TYPEOF(h.DOB_month) DOB_month;
TYPEOF(h.DOB_day) DOB_day;
TYPEOF(h.DID) DID;
UNSIGNED1 DID_data_permits;
UNSIGNED1 DID_method; // This value could come from multiple BESTTYPE; track which one
END;
R T(BestBy_LNPID__DOB_child le) := TRANSFORM
SELF := le.DID_cases[1];
SELF := le; // Copy all non-multi fields
END;
P1 := PROJECT(d,T(LEFT));
RETURN P1;
END;
EXPORT BestBy_LNPID__DOB_best := Flatten_BestBy_LNPID__DOB(BestBy_LNPID__DOB_child);
EXPORT BestBy_LNPID__DOB_best_np := Flatten_BestBy_LNPID__DOB(BestBy_LNPID__DOB_child_np);
// Start to gather together all records with basis:LNPID,ADDRESS_ID,data_permits
// 0 - Gathering type:BestDIDBYADDRESS Entries:1
R0 := RECORD
typeof(BestDIDBYADDRESS_method_DID.LNPID) LNPID; // Need to copy in basis
TYPEOF(BestDIDBYADDRESS_method_DID.ADDRESS_ID) ADDRESS_ID;
TYPEOF(BestDIDBYADDRESS_method_DID.DID) BestDIDBYADDRESS_DID;
UNSIGNED DID_BestDIDBYADDRESS_Row_Cnt;
UNSIGNED1 DID_BestDIDBYADDRESS_data_permits;
END;
R0 T0(BestDIDBYADDRESS_method_DID ri) := TRANSFORM
SELF.BestDIDBYADDRESS_DID := ri.DID;
SELF.DID_BestDIDBYADDRESS_Row_Cnt := ri.Row_Cnt;
SELF.DID_BestDIDBYADDRESS_data_permits := ri.data_permits;
SELF := ri;
END;
J0 := PROJECT(BestDIDBYADDRESS_method_DID,T0(left));
EXPORT BestBy_LNPID__ADDRESS_ID_np := J0;
EXPORT BestBy_LNPID__ADDRESS_ID := BestBy_LNPID__ADDRESS_ID_np  : PERSIST('~temp::LNPID::HealthCareProviderHeader_prod::BestBy_LNPID__ADDRESS_ID::best');
// Now gather some statistics to see how we did
R := RECORD
NumberOfBasis := COUNT(GROUP);
REAL8 BestDIDBYADDRESS_DID_pcnt := AVE(GROUP,IF(BestBy_LNPID__ADDRESS_ID.BestDIDBYADDRESS_DID=(typeof(BestBy_LNPID__ADDRESS_ID.BestDIDBYADDRESS_DID))'',0,100));
UNSIGNED BestDIDBYADDRESS_DID_permit1_cnt := COUNT(GROUP,BestBy_LNPID__ADDRESS_ID.DID_BestDIDBYADDRESS_data_permits&1<>0);
UNSIGNED BestDIDBYADDRESS_DID_permit2_cnt := COUNT(GROUP,BestBy_LNPID__ADDRESS_ID.DID_BestDIDBYADDRESS_data_permits&2<>0);
UNSIGNED BestDIDBYADDRESS_DID_permit3_cnt := COUNT(GROUP,BestBy_LNPID__ADDRESS_ID.DID_BestDIDBYADDRESS_data_permits&4<>0);
UNSIGNED BestDIDBYADDRESS_DID_permit4_cnt := COUNT(GROUP,BestBy_LNPID__ADDRESS_ID.DID_BestDIDBYADDRESS_data_permits&8<>0);
UNSIGNED BestDIDBYADDRESS_DID_permit5_cnt := COUNT(GROUP,BestBy_LNPID__ADDRESS_ID.DID_BestDIDBYADDRESS_data_permits&16<>0);
END;
EXPORT BestBy_LNPID__ADDRESS_ID_population := TABLE(BestBy_LNPID__ADDRESS_ID,R);
// Take the wide table and turn it into a child-dataset version
SHARED F_BestBy_LNPID__ADDRESS_ID(DATASET({BestBy_LNPID__ADDRESS_ID}) d) := FUNCTION
DID_case_layout := RECORD
TYPEOF(h.DID) DID;
UNSIGNED1 DID_data_permits;
UNSIGNED1 DID_method; // This value could come from multiple BESTTYPE; track which one
END;
R := RECORD
typeof(h.LNPID) LNPID := 0;
TYPEOF(h.ADDRESS_ID) ADDRESS_ID;
DATASET(DID_case_layout) DID_cases;
END;
R T(BestBy_LNPID__ADDRESS_ID le) := TRANSFORM
SELF.DID_cases := DATASET([
{le.BestDIDBYADDRESS_DID,le.DID_BestDIDBYADDRESS_data_permits,2}
],DID_case_layout)(DID NOT IN SET(s.nulls_DID,DID));
SELF := le; // Copy BASIS
END;
P1 := PROJECT(d,T(LEFT));
RETURN P1;
END;
EXPORT BestBy_LNPID__ADDRESS_ID_child := F_BestBy_LNPID__ADDRESS_ID(BestBy_LNPID__ADDRESS_ID);
EXPORT BestBy_LNPID__ADDRESS_ID_child_np := F_BestBy_LNPID__ADDRESS_ID(BestBy_LNPID__ADDRESS_ID_np);
// Now to produce the slimmed down 'best propagation we can do for this basis'
SHARED Flatten_BestBy_LNPID__ADDRESS_ID(DATASET({BestBy_LNPID__ADDRESS_ID_child}) d) := FUNCTION
R := RECORD
TYPEOF(h.LNPID) LNPID := 0;
TYPEOF(h.ADDRESS_ID) ADDRESS_ID;
TYPEOF(h.DID) DID;
UNSIGNED1 DID_data_permits;
UNSIGNED1 DID_method; // This value could come from multiple BESTTYPE; track which one
END;
R T(BestBy_LNPID__ADDRESS_ID_child le) := TRANSFORM
SELF := le.DID_cases[1];
SELF := le; // Copy all non-multi fields
END;
P1 := PROJECT(d,T(LEFT));
RETURN P1;
END;
EXPORT BestBy_LNPID__ADDRESS_ID_best := Flatten_BestBy_LNPID__ADDRESS_ID(BestBy_LNPID__ADDRESS_ID_child);
EXPORT BestBy_LNPID__ADDRESS_ID_best_np := Flatten_BestBy_LNPID__ADDRESS_ID(BestBy_LNPID__ADDRESS_ID_child_np);
// Start to gather together all records with basis:LNPID,data_permits
// 0 - Gathering type:BestDIDCommonest Entries:1
R0 := RECORD
typeof(BestDIDCommonest_method_DID.LNPID) LNPID; // Need to copy in basis
TYPEOF(BestDIDCommonest_method_DID.DID) BestDIDCommonest_DID;
UNSIGNED DID_BestDIDCommonest_Row_Cnt;
UNSIGNED1 DID_BestDIDCommonest_data_permits;
END;
R0 T0(BestDIDCommonest_method_DID ri) := TRANSFORM
SELF.BestDIDCommonest_DID := ri.DID;
SELF.DID_BestDIDCommonest_Row_Cnt := ri.Row_Cnt;
SELF.DID_BestDIDCommonest_data_permits := ri.data_permits;
SELF := ri;
END;
J0 := PROJECT(BestDIDCommonest_method_DID,T0(left));
// 1 - Gathering type:BestDOB Entries:1
R1 := RECORD
J0; // The data so far
TYPEOF(BestDOB_method_DOB.DOB_year) BestDOB_DOB_year;
TYPEOF(BestDOB_method_DOB.DOB_month) BestDOB_DOB_month;
TYPEOF(BestDOB_method_DOB.DOB_day) BestDOB_DOB_day;
UNSIGNED DOB_BestDOB_Row_Cnt;
UNSIGNED1 DOB_BestDOB_data_permits;
END;
R1 T1(J0 le,BestDOB_method_DOB ri) := TRANSFORM
SELF.BestDOB_DOB_year := ri.DOB_year;
SELF.BestDOB_DOB_month := ri.DOB_month;
SELF.BestDOB_DOB_day := ri.DOB_day;
SELF.DOB_BestDOB_Row_Cnt := ri.Row_Cnt;
SELF.DOB_BestDOB_data_permits := ri.data_permits;
BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
SELF := le;
END;
J1 := JOIN(J0,BestDOB_method_DOB,LEFT.LNPID = RIGHT.LNPID,T1(LEFT,RIGHT),FULL OUTER,LOCAL);
// 2 - Gathering type:BestDOBLongest Entries:1
R2 := RECORD
J1; // The data so far
TYPEOF(BestDOBLongest_method_DOB.DOB_year) BestDOBLongest_DOB_year;
TYPEOF(BestDOBLongest_method_DOB.DOB_month) BestDOBLongest_DOB_month;
TYPEOF(BestDOBLongest_method_DOB.DOB_day) BestDOBLongest_DOB_day;
UNSIGNED DOB_BestDOBLongest_Row_Cnt;
UNSIGNED1 DOB_BestDOBLongest_data_permits;
END;
R2 T2(J1 le,BestDOBLongest_method_DOB ri) := TRANSFORM
SELF.BestDOBLongest_DOB_year := ri.DOB_year;
SELF.BestDOBLongest_DOB_month := ri.DOB_month;
SELF.BestDOBLongest_DOB_day := ri.DOB_day;
SELF.DOB_BestDOBLongest_Row_Cnt := ri.Row_Cnt;
SELF.DOB_BestDOBLongest_data_permits := ri.data_permits;
BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
SELF := le;
END;
J2 := JOIN(J1,BestDOBLongest_method_DOB,LEFT.LNPID = RIGHT.LNPID,T2(LEFT,RIGHT),FULL OUTER,LOCAL);
// 3 - Gathering type:BestDOBCommonest Entries:1
R3 := RECORD
J2; // The data so far
TYPEOF(BestDOBCommonest_method_DOB.DOB_year) BestDOBCommonest_DOB_year;
TYPEOF(BestDOBCommonest_method_DOB.DOB_month) BestDOBCommonest_DOB_month;
TYPEOF(BestDOBCommonest_method_DOB.DOB_day) BestDOBCommonest_DOB_day;
UNSIGNED DOB_BestDOBCommonest_Row_Cnt;
UNSIGNED DOB_BestDOBCommonest_Orig_Row_Cnt;
UNSIGNED1 DOB_BestDOBCommonest_data_permits;
END;
R3 T3(J2 le,BestDOBCommonest_method_DOB ri) := TRANSFORM
SELF.BestDOBCommonest_DOB_year := ri.DOB_year;
SELF.BestDOBCommonest_DOB_month := ri.DOB_month;
SELF.BestDOBCommonest_DOB_day := ri.DOB_day;
SELF.DOB_BestDOBCommonest_Row_Cnt := ri.Row_Cnt;
SELF.DOB_BestDOBCommonest_Orig_Row_Cnt := ri.Orig_Row_Cnt;
SELF.DOB_BestDOBCommonest_data_permits := ri.data_permits;
BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
SELF := le;
END;
J3 := JOIN(J2,BestDOBCommonest_method_DOB,LEFT.LNPID = RIGHT.LNPID,T3(LEFT,RIGHT),FULL OUTER,LOCAL);
// 4 - Gathering type:BestNPI Entries:1
R4 := RECORD
J3; // The data so far
TYPEOF(BestNPI_method_NPI_NUMBER.NPI_NUMBER) BestNPI_NPI_NUMBER;
UNSIGNED NPI_NUMBER_BestNPI_Row_Cnt;
UNSIGNED1 NPI_NUMBER_BestNPI_data_permits;
END;
R4 T4(J3 le,BestNPI_method_NPI_NUMBER ri) := TRANSFORM
SELF.BestNPI_NPI_NUMBER := ri.NPI_NUMBER;
SELF.NPI_NUMBER_BestNPI_Row_Cnt := ri.Row_Cnt;
SELF.NPI_NUMBER_BestNPI_data_permits := ri.data_permits;
BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
SELF := le;
END;
J4 := JOIN(J3,BestNPI_method_NPI_NUMBER,LEFT.LNPID = RIGHT.LNPID,T4(LEFT,RIGHT),FULL OUTER,LOCAL);
// 5 - Gathering type:MostRecent Entries:2
R5 := RECORD
J4; // The data so far
TYPEOF(MostRecent_method_NPI_NUMBER.NPI_NUMBER) MostRecent_NPI_NUMBER;
UNSIGNED NPI_NUMBER_MostRecent_Row_Cnt;
UNSIGNED1 NPI_NUMBER_MostRecent_data_permits;
END;
R5 T5(J4 le,MostRecent_method_NPI_NUMBER ri) := TRANSFORM
SELF.MostRecent_NPI_NUMBER := ri.NPI_NUMBER;
SELF.NPI_NUMBER_MostRecent_Row_Cnt := ri.Row_Cnt;
SELF.NPI_NUMBER_MostRecent_data_permits := ri.data_permits;
BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
SELF := le;
END;
J5 := JOIN(J4,MostRecent_method_NPI_NUMBER,LEFT.LNPID = RIGHT.LNPID,T5(LEFT,RIGHT),FULL OUTER,LOCAL);
R6 := RECORD
J5; // The data so far
TYPEOF(MostRecent_method_UPIN.UPIN) MostRecent_UPIN;
UNSIGNED UPIN_MostRecent_Row_Cnt;
UNSIGNED1 UPIN_MostRecent_data_permits;
END;
R6 T6(J5 le,MostRecent_method_UPIN ri) := TRANSFORM
SELF.MostRecent_UPIN := ri.UPIN;
SELF.UPIN_MostRecent_Row_Cnt := ri.Row_Cnt;
SELF.UPIN_MostRecent_data_permits := ri.data_permits;
BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
SELF := le;
END;
J6 := JOIN(J5,MostRecent_method_UPIN,LEFT.LNPID = RIGHT.LNPID,T6(LEFT,RIGHT),FULL OUTER,LOCAL);
// 7 - Gathering type:BestAddressCommonest Entries:1
R7 := RECORD
J6; // The data so far
TYPEOF(BestAddressCommonest_method_ADDR.PRIM_RANGE) BestAddressCommonest_ADDR_PRIM_RANGE;
TYPEOF(BestAddressCommonest_method_ADDR.SEC_RANGE) BestAddressCommonest_ADDR_SEC_RANGE;
TYPEOF(BestAddressCommonest_method_ADDR.PRIM_NAME) BestAddressCommonest_ADDR_PRIM_NAME;
UNSIGNED ADDR_BestAddressCommonest_Row_Cnt;
UNSIGNED ADDR_BestAddressCommonest_Orig_Row_Cnt;
UNSIGNED1 ADDR_BestAddressCommonest_data_permits;
END;
R7 T7(J6 le,BestAddressCommonest_method_ADDR ri) := TRANSFORM
SELF.BestAddressCommonest_ADDR_PRIM_RANGE := ri.PRIM_RANGE;
SELF.BestAddressCommonest_ADDR_SEC_RANGE := ri.SEC_RANGE;
SELF.BestAddressCommonest_ADDR_PRIM_NAME := ri.PRIM_NAME;
SELF.ADDR_BestAddressCommonest_Row_Cnt := ri.Row_Cnt;
SELF.ADDR_BestAddressCommonest_Orig_Row_Cnt := ri.Orig_Row_Cnt;
SELF.ADDR_BestAddressCommonest_data_permits := ri.data_permits;
BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
SELF := le;
END;
J7 := JOIN(J6,BestAddressCommonest_method_ADDR,LEFT.LNPID = RIGHT.LNPID,T7(LEFT,RIGHT),FULL OUTER,LOCAL);
// 8 - Gathering type:BestLICCommenest Entries:1
R8 := RECORD
J7; // The data so far
TYPEOF(BestLICCommenest_method_LIC_NBR.LIC_NBR) BestLICCommenest_LIC_NBR;
UNSIGNED LIC_NBR_BestLICCommenest_Row_Cnt;
UNSIGNED1 LIC_NBR_BestLICCommenest_data_permits;
END;
R8 T8(J7 le,BestLICCommenest_method_LIC_NBR ri) := TRANSFORM
SELF.BestLICCommenest_LIC_NBR := ri.LIC_NBR;
SELF.LIC_NBR_BestLICCommenest_Row_Cnt := ri.Row_Cnt;
SELF.LIC_NBR_BestLICCommenest_data_permits := ri.data_permits;
BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
SELF := le;
END;
J8 := JOIN(J7,BestLICCommenest_method_LIC_NBR,LEFT.LNPID = RIGHT.LNPID,T8(LEFT,RIGHT),FULL OUTER,LOCAL);
// 9 - Gathering type:MostRecentDEA Entries:1
R9 := RECORD
J8; // The data so far
TYPEOF(MostRecentDEA_method_DEA_NUMBER.DEA_NUMBER) MostRecentDEA_DEA_NUMBER;
UNSIGNED DEA_NUMBER_MostRecentDEA_Row_Cnt;
UNSIGNED1 DEA_NUMBER_MostRecentDEA_data_permits;
END;
R9 T9(J8 le,MostRecentDEA_method_DEA_NUMBER ri) := TRANSFORM
SELF.MostRecentDEA_DEA_NUMBER := ri.DEA_NUMBER;
SELF.DEA_NUMBER_MostRecentDEA_Row_Cnt := ri.Row_Cnt;
SELF.DEA_NUMBER_MostRecentDEA_data_permits := ri.data_permits;
BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
SELF := le;
END;
J9 := JOIN(J8,MostRecentDEA_method_DEA_NUMBER,LEFT.LNPID = RIGHT.LNPID,T9(LEFT,RIGHT),FULL OUTER,LOCAL);
// 10 - Gathering type:BestFirstName Entries:1
R10 := RECORD
J9; // The data so far
TYPEOF(BestFirstName_method_FNAME.FNAME) BestFirstName_FNAME;
UNSIGNED FNAME_BestFirstName_Row_Cnt;
UNSIGNED FNAME_BestFirstName_Orig_Row_Cnt;
UNSIGNED1 FNAME_BestFirstName_data_permits;
END;
R10 T10(J9 le,BestFirstName_method_FNAME ri) := TRANSFORM
SELF.BestFirstName_FNAME := ri.FNAME;
SELF.FNAME_BestFirstName_Row_Cnt := ri.Row_Cnt;
SELF.FNAME_BestFirstName_Orig_Row_Cnt := ri.Orig_Row_Cnt;
SELF.FNAME_BestFirstName_data_permits := ri.data_permits;
BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
SELF := le;
END;
J10 := JOIN(J9,BestFirstName_method_FNAME,LEFT.LNPID = RIGHT.LNPID,T10(LEFT,RIGHT),FULL OUTER,LOCAL);
// 11 - Gathering type:CommonFirstName Entries:1
R11 := RECORD
J10; // The data so far
TYPEOF(CommonFirstName_method_FNAME.FNAME) CommonFirstName_FNAME;
UNSIGNED FNAME_CommonFirstName_Row_Cnt;
UNSIGNED1 FNAME_CommonFirstName_data_permits;
END;
R11 T11(J10 le,CommonFirstName_method_FNAME ri) := TRANSFORM
SELF.CommonFirstName_FNAME := ri.FNAME;
SELF.FNAME_CommonFirstName_Row_Cnt := ri.Row_Cnt;
SELF.FNAME_CommonFirstName_data_permits := ri.data_permits;
BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
SELF := le;
END;
J11 := JOIN(J10,CommonFirstName_method_FNAME,LEFT.LNPID = RIGHT.LNPID,T11(LEFT,RIGHT),FULL OUTER,LOCAL);
// 12 - Gathering type:BestTaxCommonest Entries:1
R12 := RECORD
J11; // The data so far
TYPEOF(BestTaxCommonest_method_TAX_ID.TAX_ID) BestTaxCommonest_TAX_ID;
UNSIGNED TAX_ID_BestTaxCommonest_Row_Cnt;
UNSIGNED1 TAX_ID_BestTaxCommonest_data_permits;
END;
R12 T12(J11 le,BestTaxCommonest_method_TAX_ID ri) := TRANSFORM
SELF.BestTaxCommonest_TAX_ID := ri.TAX_ID;
SELF.TAX_ID_BestTaxCommonest_Row_Cnt := ri.Row_Cnt;
SELF.TAX_ID_BestTaxCommonest_data_permits := ri.data_permits;
BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
SELF := le;
END;
J12 := JOIN(J11,BestTaxCommonest_method_TAX_ID,LEFT.LNPID = RIGHT.LNPID,T12(LEFT,RIGHT),FULL OUTER,LOCAL);
// 13 - Gathering type:UniqueSingleValue Entries:1
R13 := RECORD
J12; // The data so far
TYPEOF(UniqueSingleValue_method_GENDER.GENDER) UniqueSingleValue_GENDER;
UNSIGNED GENDER_UniqueSingleValue_Row_Cnt;
UNSIGNED1 GENDER_UniqueSingleValue_data_permits;
END;
R13 T13(J12 le,UniqueSingleValue_method_GENDER ri) := TRANSFORM
SELF.UniqueSingleValue_GENDER := ri.GENDER;
SELF.GENDER_UniqueSingleValue_Row_Cnt := ri.Row_Cnt;
SELF.GENDER_UniqueSingleValue_data_permits := ri.data_permits;
BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
SELF := le;
END;
J13 := JOIN(J12,UniqueSingleValue_method_GENDER,LEFT.LNPID = RIGHT.LNPID,T13(LEFT,RIGHT),FULL OUTER,LOCAL);
// 14 - Gathering type:ExtendedCommonValue Entries:5
R14 := RECORD
J13; // The data so far
TYPEOF(ExtendedCommonValue_method_SNAME.SNAME) ExtendedCommonValue_SNAME;
UNSIGNED SNAME_ExtendedCommonValue_Row_Cnt;
UNSIGNED1 SNAME_ExtendedCommonValue_data_permits;
END;
R14 T14(J13 le,ExtendedCommonValue_method_SNAME ri) := TRANSFORM
SELF.ExtendedCommonValue_SNAME := ri.SNAME;
SELF.SNAME_ExtendedCommonValue_Row_Cnt := ri.Row_Cnt;
SELF.SNAME_ExtendedCommonValue_data_permits := ri.data_permits;
BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
SELF := le;
END;
J14 := JOIN(J13,ExtendedCommonValue_method_SNAME,LEFT.LNPID = RIGHT.LNPID,T14(LEFT,RIGHT),FULL OUTER,LOCAL);
R15 := RECORD
J14; // The data so far
TYPEOF(ExtendedCommonValue_method_MNAME.MNAME) ExtendedCommonValue_MNAME;
UNSIGNED MNAME_ExtendedCommonValue_Row_Cnt;
UNSIGNED1 MNAME_ExtendedCommonValue_data_permits;
END;
R15 T15(J14 le,ExtendedCommonValue_method_MNAME ri) := TRANSFORM
SELF.ExtendedCommonValue_MNAME := ri.MNAME;
SELF.MNAME_ExtendedCommonValue_Row_Cnt := ri.Row_Cnt;
SELF.MNAME_ExtendedCommonValue_data_permits := ri.data_permits;
BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
SELF := le;
END;
J15 := JOIN(J14,ExtendedCommonValue_method_MNAME,LEFT.LNPID = RIGHT.LNPID,T15(LEFT,RIGHT),FULL OUTER,LOCAL);
R16 := RECORD
J15; // The data so far
TYPEOF(ExtendedCommonValue_method_NPI_NUMBER.NPI_NUMBER) ExtendedCommonValue_NPI_NUMBER;
UNSIGNED NPI_NUMBER_ExtendedCommonValue_Row_Cnt;
UNSIGNED1 NPI_NUMBER_ExtendedCommonValue_data_permits;
END;
R16 T16(J15 le,ExtendedCommonValue_method_NPI_NUMBER ri) := TRANSFORM
SELF.ExtendedCommonValue_NPI_NUMBER := ri.NPI_NUMBER;
SELF.NPI_NUMBER_ExtendedCommonValue_Row_Cnt := ri.Row_Cnt;
SELF.NPI_NUMBER_ExtendedCommonValue_data_permits := ri.data_permits;
BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
SELF := le;
END;
J16 := JOIN(J15,ExtendedCommonValue_method_NPI_NUMBER,LEFT.LNPID = RIGHT.LNPID,T16(LEFT,RIGHT),FULL OUTER,LOCAL);
R17 := RECORD
J16; // The data so far
TYPEOF(ExtendedCommonValue_method_DEA_NUMBER.DEA_NUMBER) ExtendedCommonValue_DEA_NUMBER;
UNSIGNED DEA_NUMBER_ExtendedCommonValue_Row_Cnt;
UNSIGNED1 DEA_NUMBER_ExtendedCommonValue_data_permits;
END;
R17 T17(J16 le,ExtendedCommonValue_method_DEA_NUMBER ri) := TRANSFORM
SELF.ExtendedCommonValue_DEA_NUMBER := ri.DEA_NUMBER;
SELF.DEA_NUMBER_ExtendedCommonValue_Row_Cnt := ri.Row_Cnt;
SELF.DEA_NUMBER_ExtendedCommonValue_data_permits := ri.data_permits;
BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
SELF := le;
END;
J17 := JOIN(J16,ExtendedCommonValue_method_DEA_NUMBER,LEFT.LNPID = RIGHT.LNPID,T17(LEFT,RIGHT),FULL OUTER,LOCAL);
R18 := RECORD
J17; // The data so far
TYPEOF(ExtendedCommonValue_method_UPIN.UPIN) ExtendedCommonValue_UPIN;
UNSIGNED UPIN_ExtendedCommonValue_Row_Cnt;
UNSIGNED1 UPIN_ExtendedCommonValue_data_permits;
END;
R18 T18(J17 le,ExtendedCommonValue_method_UPIN ri) := TRANSFORM
SELF.ExtendedCommonValue_UPIN := ri.UPIN;
SELF.UPIN_ExtendedCommonValue_Row_Cnt := ri.Row_Cnt;
SELF.UPIN_ExtendedCommonValue_data_permits := ri.data_permits;
BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
SELF := le;
END;
J18 := JOIN(J17,ExtendedCommonValue_method_UPIN,LEFT.LNPID = RIGHT.LNPID,T18(LEFT,RIGHT),FULL OUTER,LOCAL);
// 19 - Gathering type:LongestValue Entries:2
R19 := RECORD
J18; // The data so far
TYPEOF(LongestValue_method_SNAME.SNAME) LongestValue_SNAME;
UNSIGNED SNAME_LongestValue_Row_Cnt;
UNSIGNED1 SNAME_LongestValue_data_permits;
END;
R19 T19(J18 le,LongestValue_method_SNAME ri) := TRANSFORM
SELF.LongestValue_SNAME := ri.SNAME;
SELF.SNAME_LongestValue_Row_Cnt := ri.Row_Cnt;
SELF.SNAME_LongestValue_data_permits := ri.data_permits;
BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
SELF := le;
END;
J19 := JOIN(J18,LongestValue_method_SNAME,LEFT.LNPID = RIGHT.LNPID,T19(LEFT,RIGHT),FULL OUTER,LOCAL);
R20 := RECORD
J19; // The data so far
TYPEOF(LongestValue_method_MNAME.MNAME) LongestValue_MNAME;
UNSIGNED MNAME_LongestValue_Row_Cnt;
UNSIGNED1 MNAME_LongestValue_data_permits;
END;
R20 T20(J19 le,LongestValue_method_MNAME ri) := TRANSFORM
SELF.LongestValue_MNAME := ri.MNAME;
SELF.MNAME_LongestValue_Row_Cnt := ri.Row_Cnt;
SELF.MNAME_LongestValue_data_permits := ri.data_permits;
BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
SELF := le;
END;
J20 := JOIN(J19,LongestValue_method_MNAME,LEFT.LNPID = RIGHT.LNPID,T20(LEFT,RIGHT),FULL OUTER,LOCAL);
// 21 - Gathering type:CurrentLastName Entries:1
R21 := RECORD
J20; // The data so far
TYPEOF(CurrentLastName_method_LNAME.LNAME) CurrentLastName_LNAME;
UNSIGNED LNAME_CurrentLastName_Row_Cnt;
UNSIGNED1 LNAME_CurrentLastName_data_permits;
END;
R21 T21(J20 le,CurrentLastName_method_LNAME ri) := TRANSFORM
SELF.CurrentLastName_LNAME := ri.LNAME;
SELF.LNAME_CurrentLastName_Row_Cnt := ri.Row_Cnt;
SELF.LNAME_CurrentLastName_data_permits := ri.data_permits;
BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
SELF := le;
END;
J21 := JOIN(J20,CurrentLastName_method_LNAME,LEFT.LNPID = RIGHT.LNPID,T21(LEFT,RIGHT),FULL OUTER,LOCAL);
// 22 - Gathering type:BestLastName Entries:1
R22 := RECORD
J21; // The data so far
TYPEOF(BestLastName_method_LNAME.LNAME) BestLastName_LNAME;
UNSIGNED LNAME_BestLastName_Row_Cnt;
UNSIGNED LNAME_BestLastName_Orig_Row_Cnt;
UNSIGNED1 LNAME_BestLastName_data_permits;
END;
R22 T22(J21 le,BestLastName_method_LNAME ri) := TRANSFORM
SELF.BestLastName_LNAME := ri.LNAME;
SELF.LNAME_BestLastName_Row_Cnt := ri.Row_Cnt;
SELF.LNAME_BestLastName_Orig_Row_Cnt := ri.Orig_Row_Cnt;
SELF.LNAME_BestLastName_data_permits := ri.data_permits;
BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
SELF := le;
END;
J22 := JOIN(J21,BestLastName_method_LNAME,LEFT.LNPID = RIGHT.LNPID,T22(LEFT,RIGHT),FULL OUTER,LOCAL);
// 23 - Gathering type:BestTaxID Entries:1
R23 := RECORD
J22; // The data so far
TYPEOF(BestTaxID_method_TAX_ID.TAX_ID) BestTaxID_TAX_ID;
UNSIGNED TAX_ID_BestTaxID_Row_Cnt;
UNSIGNED1 TAX_ID_BestTaxID_data_permits;
END;
R23 T23(J22 le,BestTaxID_method_TAX_ID ri) := TRANSFORM
SELF.BestTaxID_TAX_ID := ri.TAX_ID;
SELF.TAX_ID_BestTaxID_Row_Cnt := ri.Row_Cnt;
SELF.TAX_ID_BestTaxID_data_permits := ri.data_permits;
BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
SELF := le;
END;
J23 := JOIN(J22,BestTaxID_method_TAX_ID,LEFT.LNPID = RIGHT.LNPID,T23(LEFT,RIGHT),FULL OUTER,LOCAL);
// 24 - Gathering type:BestPhoneCommonest Entries:1
R24 := RECORD
J23; // The data so far
TYPEOF(BestPhoneCommonest_method_PHONE.PHONE) BestPhoneCommonest_PHONE;
UNSIGNED PHONE_BestPhoneCommonest_Row_Cnt;
UNSIGNED1 PHONE_BestPhoneCommonest_data_permits;
END;
R24 T24(J23 le,BestPhoneCommonest_method_PHONE ri) := TRANSFORM
SELF.BestPhoneCommonest_PHONE := ri.PHONE;
SELF.PHONE_BestPhoneCommonest_Row_Cnt := ri.Row_Cnt;
SELF.PHONE_BestPhoneCommonest_data_permits := ri.data_permits;
BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))''; // See if LHS is null
SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
SELF := le;
END;
J24 := JOIN(J23,BestPhoneCommonest_method_PHONE,LEFT.LNPID = RIGHT.LNPID,T24(LEFT,RIGHT),FULL OUTER,LOCAL);
EXPORT BestBy_LNPID_np := J24;
EXPORT BestBy_LNPID := BestBy_LNPID_np  : PERSIST('~temp::LNPID::HealthCareProviderHeader_prod::BestBy_LNPID::best');
// Now gather some statistics to see how we did
R := RECORD
NumberOfBasis := COUNT(GROUP);
REAL8 BestDIDCommonest_DID_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestDIDCommonest_DID=(typeof(BestBy_LNPID.BestDIDCommonest_DID))'',0,100));
UNSIGNED BestDIDCommonest_DID_permit1_cnt := COUNT(GROUP,BestBy_LNPID.DID_BestDIDCommonest_data_permits&1<>0);
UNSIGNED BestDIDCommonest_DID_permit2_cnt := COUNT(GROUP,BestBy_LNPID.DID_BestDIDCommonest_data_permits&2<>0);
UNSIGNED BestDIDCommonest_DID_permit3_cnt := COUNT(GROUP,BestBy_LNPID.DID_BestDIDCommonest_data_permits&4<>0);
UNSIGNED BestDIDCommonest_DID_permit4_cnt := COUNT(GROUP,BestBy_LNPID.DID_BestDIDCommonest_data_permits&8<>0);
UNSIGNED BestDIDCommonest_DID_permit5_cnt := COUNT(GROUP,BestBy_LNPID.DID_BestDIDCommonest_data_permits&16<>0);
REAL8 BestDOB_DOB_year_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestDOB_DOB_year=(typeof(BestBy_LNPID.BestDOB_DOB_year))'',0,100));
REAL8 BestDOB_DOB_month_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestDOB_DOB_month=(typeof(BestBy_LNPID.BestDOB_DOB_month))'',0,100));
REAL8 BestDOB_DOB_day_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestDOB_DOB_day=(typeof(BestBy_LNPID.BestDOB_DOB_day))'',0,100));
UNSIGNED BestDOB_DOB_permit1_cnt := COUNT(GROUP,BestBy_LNPID.DOB_BestDOB_data_permits&1<>0);
UNSIGNED BestDOB_DOB_permit2_cnt := COUNT(GROUP,BestBy_LNPID.DOB_BestDOB_data_permits&2<>0);
UNSIGNED BestDOB_DOB_permit3_cnt := COUNT(GROUP,BestBy_LNPID.DOB_BestDOB_data_permits&4<>0);
UNSIGNED BestDOB_DOB_permit4_cnt := COUNT(GROUP,BestBy_LNPID.DOB_BestDOB_data_permits&8<>0);
UNSIGNED BestDOB_DOB_permit5_cnt := COUNT(GROUP,BestBy_LNPID.DOB_BestDOB_data_permits&16<>0);
REAL8 BestDOBLongest_DOB_year_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestDOBLongest_DOB_year=(typeof(BestBy_LNPID.BestDOBLongest_DOB_year))'',0,100));
REAL8 BestDOBLongest_DOB_month_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestDOBLongest_DOB_month=(typeof(BestBy_LNPID.BestDOBLongest_DOB_month))'',0,100));
REAL8 BestDOBLongest_DOB_day_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestDOBLongest_DOB_day=(typeof(BestBy_LNPID.BestDOBLongest_DOB_day))'',0,100));
UNSIGNED BestDOBLongest_DOB_permit1_cnt := COUNT(GROUP,BestBy_LNPID.DOB_BestDOBLongest_data_permits&1<>0);
UNSIGNED BestDOBLongest_DOB_permit2_cnt := COUNT(GROUP,BestBy_LNPID.DOB_BestDOBLongest_data_permits&2<>0);
UNSIGNED BestDOBLongest_DOB_permit3_cnt := COUNT(GROUP,BestBy_LNPID.DOB_BestDOBLongest_data_permits&4<>0);
UNSIGNED BestDOBLongest_DOB_permit4_cnt := COUNT(GROUP,BestBy_LNPID.DOB_BestDOBLongest_data_permits&8<>0);
UNSIGNED BestDOBLongest_DOB_permit5_cnt := COUNT(GROUP,BestBy_LNPID.DOB_BestDOBLongest_data_permits&16<>0);
REAL8 BestDOBCommonest_DOB_year_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestDOBCommonest_DOB_year=(typeof(BestBy_LNPID.BestDOBCommonest_DOB_year))'',0,100));
REAL8 BestDOBCommonest_DOB_month_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestDOBCommonest_DOB_month=(typeof(BestBy_LNPID.BestDOBCommonest_DOB_month))'',0,100));
REAL8 BestDOBCommonest_DOB_day_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestDOBCommonest_DOB_day=(typeof(BestBy_LNPID.BestDOBCommonest_DOB_day))'',0,100));
UNSIGNED BestDOBCommonest_DOB_permit1_cnt := COUNT(GROUP,BestBy_LNPID.DOB_BestDOBCommonest_data_permits&1<>0);
UNSIGNED BestDOBCommonest_DOB_permit2_cnt := COUNT(GROUP,BestBy_LNPID.DOB_BestDOBCommonest_data_permits&2<>0);
UNSIGNED BestDOBCommonest_DOB_permit3_cnt := COUNT(GROUP,BestBy_LNPID.DOB_BestDOBCommonest_data_permits&4<>0);
UNSIGNED BestDOBCommonest_DOB_permit4_cnt := COUNT(GROUP,BestBy_LNPID.DOB_BestDOBCommonest_data_permits&8<>0);
UNSIGNED BestDOBCommonest_DOB_permit5_cnt := COUNT(GROUP,BestBy_LNPID.DOB_BestDOBCommonest_data_permits&16<>0);
REAL8 BestNPI_NPI_NUMBER_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestNPI_NPI_NUMBER=(typeof(BestBy_LNPID.BestNPI_NPI_NUMBER))'',0,100));
UNSIGNED BestNPI_NPI_NUMBER_permit1_cnt := COUNT(GROUP,BestBy_LNPID.NPI_NUMBER_BestNPI_data_permits&1<>0);
UNSIGNED BestNPI_NPI_NUMBER_permit2_cnt := COUNT(GROUP,BestBy_LNPID.NPI_NUMBER_BestNPI_data_permits&2<>0);
UNSIGNED BestNPI_NPI_NUMBER_permit3_cnt := COUNT(GROUP,BestBy_LNPID.NPI_NUMBER_BestNPI_data_permits&4<>0);
UNSIGNED BestNPI_NPI_NUMBER_permit4_cnt := COUNT(GROUP,BestBy_LNPID.NPI_NUMBER_BestNPI_data_permits&8<>0);
UNSIGNED BestNPI_NPI_NUMBER_permit5_cnt := COUNT(GROUP,BestBy_LNPID.NPI_NUMBER_BestNPI_data_permits&16<>0);
REAL8 MostRecent_NPI_NUMBER_pcnt := AVE(GROUP,IF(BestBy_LNPID.MostRecent_NPI_NUMBER=(typeof(BestBy_LNPID.MostRecent_NPI_NUMBER))'',0,100));
UNSIGNED MostRecent_NPI_NUMBER_permit1_cnt := COUNT(GROUP,BestBy_LNPID.NPI_NUMBER_MostRecent_data_permits&1<>0);
UNSIGNED MostRecent_NPI_NUMBER_permit2_cnt := COUNT(GROUP,BestBy_LNPID.NPI_NUMBER_MostRecent_data_permits&2<>0);
UNSIGNED MostRecent_NPI_NUMBER_permit3_cnt := COUNT(GROUP,BestBy_LNPID.NPI_NUMBER_MostRecent_data_permits&4<>0);
UNSIGNED MostRecent_NPI_NUMBER_permit4_cnt := COUNT(GROUP,BestBy_LNPID.NPI_NUMBER_MostRecent_data_permits&8<>0);
UNSIGNED MostRecent_NPI_NUMBER_permit5_cnt := COUNT(GROUP,BestBy_LNPID.NPI_NUMBER_MostRecent_data_permits&16<>0);
REAL8 MostRecent_UPIN_pcnt := AVE(GROUP,IF(BestBy_LNPID.MostRecent_UPIN=(typeof(BestBy_LNPID.MostRecent_UPIN))'',0,100));
UNSIGNED MostRecent_UPIN_permit1_cnt := COUNT(GROUP,BestBy_LNPID.UPIN_MostRecent_data_permits&1<>0);
UNSIGNED MostRecent_UPIN_permit2_cnt := COUNT(GROUP,BestBy_LNPID.UPIN_MostRecent_data_permits&2<>0);
UNSIGNED MostRecent_UPIN_permit3_cnt := COUNT(GROUP,BestBy_LNPID.UPIN_MostRecent_data_permits&4<>0);
UNSIGNED MostRecent_UPIN_permit4_cnt := COUNT(GROUP,BestBy_LNPID.UPIN_MostRecent_data_permits&8<>0);
UNSIGNED MostRecent_UPIN_permit5_cnt := COUNT(GROUP,BestBy_LNPID.UPIN_MostRecent_data_permits&16<>0);
REAL8 BestAddressCommonest_ADDR_PRIM_RANGE_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestAddressCommonest_ADDR_PRIM_RANGE=(typeof(BestBy_LNPID.BestAddressCommonest_ADDR_PRIM_RANGE))'',0,100));
REAL8 BestAddressCommonest_ADDR_SEC_RANGE_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestAddressCommonest_ADDR_SEC_RANGE=(typeof(BestBy_LNPID.BestAddressCommonest_ADDR_SEC_RANGE))'',0,100));
REAL8 BestAddressCommonest_ADDR_PRIM_NAME_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestAddressCommonest_ADDR_PRIM_NAME=(typeof(BestBy_LNPID.BestAddressCommonest_ADDR_PRIM_NAME))'',0,100));
UNSIGNED BestAddressCommonest_ADDR_permit1_cnt := COUNT(GROUP,BestBy_LNPID.ADDR_BestAddressCommonest_data_permits&1<>0);
UNSIGNED BestAddressCommonest_ADDR_permit2_cnt := COUNT(GROUP,BestBy_LNPID.ADDR_BestAddressCommonest_data_permits&2<>0);
UNSIGNED BestAddressCommonest_ADDR_permit3_cnt := COUNT(GROUP,BestBy_LNPID.ADDR_BestAddressCommonest_data_permits&4<>0);
UNSIGNED BestAddressCommonest_ADDR_permit4_cnt := COUNT(GROUP,BestBy_LNPID.ADDR_BestAddressCommonest_data_permits&8<>0);
UNSIGNED BestAddressCommonest_ADDR_permit5_cnt := COUNT(GROUP,BestBy_LNPID.ADDR_BestAddressCommonest_data_permits&16<>0);
REAL8 BestLICCommenest_LIC_NBR_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestLICCommenest_LIC_NBR=(typeof(BestBy_LNPID.BestLICCommenest_LIC_NBR))'',0,100));
UNSIGNED BestLICCommenest_LIC_NBR_permit1_cnt := COUNT(GROUP,BestBy_LNPID.LIC_NBR_BestLICCommenest_data_permits&1<>0);
UNSIGNED BestLICCommenest_LIC_NBR_permit2_cnt := COUNT(GROUP,BestBy_LNPID.LIC_NBR_BestLICCommenest_data_permits&2<>0);
UNSIGNED BestLICCommenest_LIC_NBR_permit3_cnt := COUNT(GROUP,BestBy_LNPID.LIC_NBR_BestLICCommenest_data_permits&4<>0);
UNSIGNED BestLICCommenest_LIC_NBR_permit4_cnt := COUNT(GROUP,BestBy_LNPID.LIC_NBR_BestLICCommenest_data_permits&8<>0);
UNSIGNED BestLICCommenest_LIC_NBR_permit5_cnt := COUNT(GROUP,BestBy_LNPID.LIC_NBR_BestLICCommenest_data_permits&16<>0);
REAL8 MostRecentDEA_DEA_NUMBER_pcnt := AVE(GROUP,IF(BestBy_LNPID.MostRecentDEA_DEA_NUMBER=(typeof(BestBy_LNPID.MostRecentDEA_DEA_NUMBER))'',0,100));
UNSIGNED MostRecentDEA_DEA_NUMBER_permit1_cnt := COUNT(GROUP,BestBy_LNPID.DEA_NUMBER_MostRecentDEA_data_permits&1<>0);
UNSIGNED MostRecentDEA_DEA_NUMBER_permit2_cnt := COUNT(GROUP,BestBy_LNPID.DEA_NUMBER_MostRecentDEA_data_permits&2<>0);
UNSIGNED MostRecentDEA_DEA_NUMBER_permit3_cnt := COUNT(GROUP,BestBy_LNPID.DEA_NUMBER_MostRecentDEA_data_permits&4<>0);
UNSIGNED MostRecentDEA_DEA_NUMBER_permit4_cnt := COUNT(GROUP,BestBy_LNPID.DEA_NUMBER_MostRecentDEA_data_permits&8<>0);
UNSIGNED MostRecentDEA_DEA_NUMBER_permit5_cnt := COUNT(GROUP,BestBy_LNPID.DEA_NUMBER_MostRecentDEA_data_permits&16<>0);
REAL8 BestFirstName_FNAME_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestFirstName_FNAME=(typeof(BestBy_LNPID.BestFirstName_FNAME))'',0,100));
UNSIGNED BestFirstName_FNAME_permit1_cnt := COUNT(GROUP,BestBy_LNPID.FNAME_BestFirstName_data_permits&1<>0);
UNSIGNED BestFirstName_FNAME_permit2_cnt := COUNT(GROUP,BestBy_LNPID.FNAME_BestFirstName_data_permits&2<>0);
UNSIGNED BestFirstName_FNAME_permit3_cnt := COUNT(GROUP,BestBy_LNPID.FNAME_BestFirstName_data_permits&4<>0);
UNSIGNED BestFirstName_FNAME_permit4_cnt := COUNT(GROUP,BestBy_LNPID.FNAME_BestFirstName_data_permits&8<>0);
UNSIGNED BestFirstName_FNAME_permit5_cnt := COUNT(GROUP,BestBy_LNPID.FNAME_BestFirstName_data_permits&16<>0);
REAL8 CommonFirstName_FNAME_pcnt := AVE(GROUP,IF(BestBy_LNPID.CommonFirstName_FNAME=(typeof(BestBy_LNPID.CommonFirstName_FNAME))'',0,100));
UNSIGNED CommonFirstName_FNAME_permit1_cnt := COUNT(GROUP,BestBy_LNPID.FNAME_CommonFirstName_data_permits&1<>0);
UNSIGNED CommonFirstName_FNAME_permit2_cnt := COUNT(GROUP,BestBy_LNPID.FNAME_CommonFirstName_data_permits&2<>0);
UNSIGNED CommonFirstName_FNAME_permit3_cnt := COUNT(GROUP,BestBy_LNPID.FNAME_CommonFirstName_data_permits&4<>0);
UNSIGNED CommonFirstName_FNAME_permit4_cnt := COUNT(GROUP,BestBy_LNPID.FNAME_CommonFirstName_data_permits&8<>0);
UNSIGNED CommonFirstName_FNAME_permit5_cnt := COUNT(GROUP,BestBy_LNPID.FNAME_CommonFirstName_data_permits&16<>0);
REAL8 BestTaxCommonest_TAX_ID_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestTaxCommonest_TAX_ID=(typeof(BestBy_LNPID.BestTaxCommonest_TAX_ID))'',0,100));
UNSIGNED BestTaxCommonest_TAX_ID_permit1_cnt := COUNT(GROUP,BestBy_LNPID.TAX_ID_BestTaxCommonest_data_permits&1<>0);
UNSIGNED BestTaxCommonest_TAX_ID_permit2_cnt := COUNT(GROUP,BestBy_LNPID.TAX_ID_BestTaxCommonest_data_permits&2<>0);
UNSIGNED BestTaxCommonest_TAX_ID_permit3_cnt := COUNT(GROUP,BestBy_LNPID.TAX_ID_BestTaxCommonest_data_permits&4<>0);
UNSIGNED BestTaxCommonest_TAX_ID_permit4_cnt := COUNT(GROUP,BestBy_LNPID.TAX_ID_BestTaxCommonest_data_permits&8<>0);
UNSIGNED BestTaxCommonest_TAX_ID_permit5_cnt := COUNT(GROUP,BestBy_LNPID.TAX_ID_BestTaxCommonest_data_permits&16<>0);
REAL8 UniqueSingleValue_GENDER_pcnt := AVE(GROUP,IF(BestBy_LNPID.UniqueSingleValue_GENDER=(typeof(BestBy_LNPID.UniqueSingleValue_GENDER))'',0,100));
UNSIGNED UniqueSingleValue_GENDER_permit1_cnt := COUNT(GROUP,BestBy_LNPID.GENDER_UniqueSingleValue_data_permits&1<>0);
UNSIGNED UniqueSingleValue_GENDER_permit2_cnt := COUNT(GROUP,BestBy_LNPID.GENDER_UniqueSingleValue_data_permits&2<>0);
UNSIGNED UniqueSingleValue_GENDER_permit3_cnt := COUNT(GROUP,BestBy_LNPID.GENDER_UniqueSingleValue_data_permits&4<>0);
UNSIGNED UniqueSingleValue_GENDER_permit4_cnt := COUNT(GROUP,BestBy_LNPID.GENDER_UniqueSingleValue_data_permits&8<>0);
UNSIGNED UniqueSingleValue_GENDER_permit5_cnt := COUNT(GROUP,BestBy_LNPID.GENDER_UniqueSingleValue_data_permits&16<>0);
REAL8 ExtendedCommonValue_SNAME_pcnt := AVE(GROUP,IF(BestBy_LNPID.ExtendedCommonValue_SNAME=(typeof(BestBy_LNPID.ExtendedCommonValue_SNAME))'',0,100));
UNSIGNED ExtendedCommonValue_SNAME_permit1_cnt := COUNT(GROUP,BestBy_LNPID.SNAME_ExtendedCommonValue_data_permits&1<>0);
UNSIGNED ExtendedCommonValue_SNAME_permit2_cnt := COUNT(GROUP,BestBy_LNPID.SNAME_ExtendedCommonValue_data_permits&2<>0);
UNSIGNED ExtendedCommonValue_SNAME_permit3_cnt := COUNT(GROUP,BestBy_LNPID.SNAME_ExtendedCommonValue_data_permits&4<>0);
UNSIGNED ExtendedCommonValue_SNAME_permit4_cnt := COUNT(GROUP,BestBy_LNPID.SNAME_ExtendedCommonValue_data_permits&8<>0);
UNSIGNED ExtendedCommonValue_SNAME_permit5_cnt := COUNT(GROUP,BestBy_LNPID.SNAME_ExtendedCommonValue_data_permits&16<>0);
REAL8 ExtendedCommonValue_MNAME_pcnt := AVE(GROUP,IF(BestBy_LNPID.ExtendedCommonValue_MNAME=(typeof(BestBy_LNPID.ExtendedCommonValue_MNAME))'',0,100));
UNSIGNED ExtendedCommonValue_MNAME_permit1_cnt := COUNT(GROUP,BestBy_LNPID.MNAME_ExtendedCommonValue_data_permits&1<>0);
UNSIGNED ExtendedCommonValue_MNAME_permit2_cnt := COUNT(GROUP,BestBy_LNPID.MNAME_ExtendedCommonValue_data_permits&2<>0);
UNSIGNED ExtendedCommonValue_MNAME_permit3_cnt := COUNT(GROUP,BestBy_LNPID.MNAME_ExtendedCommonValue_data_permits&4<>0);
UNSIGNED ExtendedCommonValue_MNAME_permit4_cnt := COUNT(GROUP,BestBy_LNPID.MNAME_ExtendedCommonValue_data_permits&8<>0);
UNSIGNED ExtendedCommonValue_MNAME_permit5_cnt := COUNT(GROUP,BestBy_LNPID.MNAME_ExtendedCommonValue_data_permits&16<>0);
REAL8 ExtendedCommonValue_NPI_NUMBER_pcnt := AVE(GROUP,IF(BestBy_LNPID.ExtendedCommonValue_NPI_NUMBER=(typeof(BestBy_LNPID.ExtendedCommonValue_NPI_NUMBER))'',0,100));
UNSIGNED ExtendedCommonValue_NPI_NUMBER_permit1_cnt := COUNT(GROUP,BestBy_LNPID.NPI_NUMBER_ExtendedCommonValue_data_permits&1<>0);
UNSIGNED ExtendedCommonValue_NPI_NUMBER_permit2_cnt := COUNT(GROUP,BestBy_LNPID.NPI_NUMBER_ExtendedCommonValue_data_permits&2<>0);
UNSIGNED ExtendedCommonValue_NPI_NUMBER_permit3_cnt := COUNT(GROUP,BestBy_LNPID.NPI_NUMBER_ExtendedCommonValue_data_permits&4<>0);
UNSIGNED ExtendedCommonValue_NPI_NUMBER_permit4_cnt := COUNT(GROUP,BestBy_LNPID.NPI_NUMBER_ExtendedCommonValue_data_permits&8<>0);
UNSIGNED ExtendedCommonValue_NPI_NUMBER_permit5_cnt := COUNT(GROUP,BestBy_LNPID.NPI_NUMBER_ExtendedCommonValue_data_permits&16<>0);
REAL8 ExtendedCommonValue_DEA_NUMBER_pcnt := AVE(GROUP,IF(BestBy_LNPID.ExtendedCommonValue_DEA_NUMBER=(typeof(BestBy_LNPID.ExtendedCommonValue_DEA_NUMBER))'',0,100));
UNSIGNED ExtendedCommonValue_DEA_NUMBER_permit1_cnt := COUNT(GROUP,BestBy_LNPID.DEA_NUMBER_ExtendedCommonValue_data_permits&1<>0);
UNSIGNED ExtendedCommonValue_DEA_NUMBER_permit2_cnt := COUNT(GROUP,BestBy_LNPID.DEA_NUMBER_ExtendedCommonValue_data_permits&2<>0);
UNSIGNED ExtendedCommonValue_DEA_NUMBER_permit3_cnt := COUNT(GROUP,BestBy_LNPID.DEA_NUMBER_ExtendedCommonValue_data_permits&4<>0);
UNSIGNED ExtendedCommonValue_DEA_NUMBER_permit4_cnt := COUNT(GROUP,BestBy_LNPID.DEA_NUMBER_ExtendedCommonValue_data_permits&8<>0);
UNSIGNED ExtendedCommonValue_DEA_NUMBER_permit5_cnt := COUNT(GROUP,BestBy_LNPID.DEA_NUMBER_ExtendedCommonValue_data_permits&16<>0);
REAL8 ExtendedCommonValue_UPIN_pcnt := AVE(GROUP,IF(BestBy_LNPID.ExtendedCommonValue_UPIN=(typeof(BestBy_LNPID.ExtendedCommonValue_UPIN))'',0,100));
UNSIGNED ExtendedCommonValue_UPIN_permit1_cnt := COUNT(GROUP,BestBy_LNPID.UPIN_ExtendedCommonValue_data_permits&1<>0);
UNSIGNED ExtendedCommonValue_UPIN_permit2_cnt := COUNT(GROUP,BestBy_LNPID.UPIN_ExtendedCommonValue_data_permits&2<>0);
UNSIGNED ExtendedCommonValue_UPIN_permit3_cnt := COUNT(GROUP,BestBy_LNPID.UPIN_ExtendedCommonValue_data_permits&4<>0);
UNSIGNED ExtendedCommonValue_UPIN_permit4_cnt := COUNT(GROUP,BestBy_LNPID.UPIN_ExtendedCommonValue_data_permits&8<>0);
UNSIGNED ExtendedCommonValue_UPIN_permit5_cnt := COUNT(GROUP,BestBy_LNPID.UPIN_ExtendedCommonValue_data_permits&16<>0);
REAL8 LongestValue_SNAME_pcnt := AVE(GROUP,IF(BestBy_LNPID.LongestValue_SNAME=(typeof(BestBy_LNPID.LongestValue_SNAME))'',0,100));
UNSIGNED LongestValue_SNAME_permit1_cnt := COUNT(GROUP,BestBy_LNPID.SNAME_LongestValue_data_permits&1<>0);
UNSIGNED LongestValue_SNAME_permit2_cnt := COUNT(GROUP,BestBy_LNPID.SNAME_LongestValue_data_permits&2<>0);
UNSIGNED LongestValue_SNAME_permit3_cnt := COUNT(GROUP,BestBy_LNPID.SNAME_LongestValue_data_permits&4<>0);
UNSIGNED LongestValue_SNAME_permit4_cnt := COUNT(GROUP,BestBy_LNPID.SNAME_LongestValue_data_permits&8<>0);
UNSIGNED LongestValue_SNAME_permit5_cnt := COUNT(GROUP,BestBy_LNPID.SNAME_LongestValue_data_permits&16<>0);
REAL8 LongestValue_MNAME_pcnt := AVE(GROUP,IF(BestBy_LNPID.LongestValue_MNAME=(typeof(BestBy_LNPID.LongestValue_MNAME))'',0,100));
UNSIGNED LongestValue_MNAME_permit1_cnt := COUNT(GROUP,BestBy_LNPID.MNAME_LongestValue_data_permits&1<>0);
UNSIGNED LongestValue_MNAME_permit2_cnt := COUNT(GROUP,BestBy_LNPID.MNAME_LongestValue_data_permits&2<>0);
UNSIGNED LongestValue_MNAME_permit3_cnt := COUNT(GROUP,BestBy_LNPID.MNAME_LongestValue_data_permits&4<>0);
UNSIGNED LongestValue_MNAME_permit4_cnt := COUNT(GROUP,BestBy_LNPID.MNAME_LongestValue_data_permits&8<>0);
UNSIGNED LongestValue_MNAME_permit5_cnt := COUNT(GROUP,BestBy_LNPID.MNAME_LongestValue_data_permits&16<>0);
REAL8 CurrentLastName_LNAME_pcnt := AVE(GROUP,IF(BestBy_LNPID.CurrentLastName_LNAME=(typeof(BestBy_LNPID.CurrentLastName_LNAME))'',0,100));
UNSIGNED CurrentLastName_LNAME_permit1_cnt := COUNT(GROUP,BestBy_LNPID.LNAME_CurrentLastName_data_permits&1<>0);
UNSIGNED CurrentLastName_LNAME_permit2_cnt := COUNT(GROUP,BestBy_LNPID.LNAME_CurrentLastName_data_permits&2<>0);
UNSIGNED CurrentLastName_LNAME_permit3_cnt := COUNT(GROUP,BestBy_LNPID.LNAME_CurrentLastName_data_permits&4<>0);
UNSIGNED CurrentLastName_LNAME_permit4_cnt := COUNT(GROUP,BestBy_LNPID.LNAME_CurrentLastName_data_permits&8<>0);
UNSIGNED CurrentLastName_LNAME_permit5_cnt := COUNT(GROUP,BestBy_LNPID.LNAME_CurrentLastName_data_permits&16<>0);
REAL8 BestLastName_LNAME_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestLastName_LNAME=(typeof(BestBy_LNPID.BestLastName_LNAME))'',0,100));
UNSIGNED BestLastName_LNAME_permit1_cnt := COUNT(GROUP,BestBy_LNPID.LNAME_BestLastName_data_permits&1<>0);
UNSIGNED BestLastName_LNAME_permit2_cnt := COUNT(GROUP,BestBy_LNPID.LNAME_BestLastName_data_permits&2<>0);
UNSIGNED BestLastName_LNAME_permit3_cnt := COUNT(GROUP,BestBy_LNPID.LNAME_BestLastName_data_permits&4<>0);
UNSIGNED BestLastName_LNAME_permit4_cnt := COUNT(GROUP,BestBy_LNPID.LNAME_BestLastName_data_permits&8<>0);
UNSIGNED BestLastName_LNAME_permit5_cnt := COUNT(GROUP,BestBy_LNPID.LNAME_BestLastName_data_permits&16<>0);
REAL8 BestTaxID_TAX_ID_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestTaxID_TAX_ID=(typeof(BestBy_LNPID.BestTaxID_TAX_ID))'',0,100));
UNSIGNED BestTaxID_TAX_ID_permit1_cnt := COUNT(GROUP,BestBy_LNPID.TAX_ID_BestTaxID_data_permits&1<>0);
UNSIGNED BestTaxID_TAX_ID_permit2_cnt := COUNT(GROUP,BestBy_LNPID.TAX_ID_BestTaxID_data_permits&2<>0);
UNSIGNED BestTaxID_TAX_ID_permit3_cnt := COUNT(GROUP,BestBy_LNPID.TAX_ID_BestTaxID_data_permits&4<>0);
UNSIGNED BestTaxID_TAX_ID_permit4_cnt := COUNT(GROUP,BestBy_LNPID.TAX_ID_BestTaxID_data_permits&8<>0);
UNSIGNED BestTaxID_TAX_ID_permit5_cnt := COUNT(GROUP,BestBy_LNPID.TAX_ID_BestTaxID_data_permits&16<>0);
REAL8 BestPhoneCommonest_PHONE_pcnt := AVE(GROUP,IF(BestBy_LNPID.BestPhoneCommonest_PHONE=(typeof(BestBy_LNPID.BestPhoneCommonest_PHONE))'',0,100));
UNSIGNED BestPhoneCommonest_PHONE_permit1_cnt := COUNT(GROUP,BestBy_LNPID.PHONE_BestPhoneCommonest_data_permits&1<>0);
UNSIGNED BestPhoneCommonest_PHONE_permit2_cnt := COUNT(GROUP,BestBy_LNPID.PHONE_BestPhoneCommonest_data_permits&2<>0);
UNSIGNED BestPhoneCommonest_PHONE_permit3_cnt := COUNT(GROUP,BestBy_LNPID.PHONE_BestPhoneCommonest_data_permits&4<>0);
UNSIGNED BestPhoneCommonest_PHONE_permit4_cnt := COUNT(GROUP,BestBy_LNPID.PHONE_BestPhoneCommonest_data_permits&8<>0);
UNSIGNED BestPhoneCommonest_PHONE_permit5_cnt := COUNT(GROUP,BestBy_LNPID.PHONE_BestPhoneCommonest_data_permits&16<>0);
END;
EXPORT BestBy_LNPID_population := TABLE(BestBy_LNPID,R);
// Take the wide table and turn it into a child-dataset version
SHARED F_BestBy_LNPID(DATASET({BestBy_LNPID}) d) := FUNCTION
DID_case_layout := RECORD
TYPEOF(h.DID) DID;
UNSIGNED1 DID_data_permits;
UNSIGNED1 DID_method; // This value could come from multiple BESTTYPE; track which one
END;
DOB_case_layout := RECORD
TYPEOF(h.DOB_year) DOB_year;
TYPEOF(h.DOB_month) DOB_month;
TYPEOF(h.DOB_day) DOB_day;
UNSIGNED1 DOB_data_permits;
UNSIGNED1 DOB_method; // This value could come from multiple BESTTYPE; track which one
END;
NPI_NUMBER_case_layout := RECORD
TYPEOF(h.NPI_NUMBER) NPI_NUMBER;
UNSIGNED1 NPI_NUMBER_data_permits;
UNSIGNED1 NPI_NUMBER_method; // This value could come from multiple BESTTYPE; track which one
UNSIGNED NPI_NUMBER_own_cnt := 0; // Used for determining who OWNs this value
BOOLEAN  NPI_NUMBER_owns := false; // Does this cluster own this value?
END;
UPIN_case_layout := RECORD
TYPEOF(h.UPIN) UPIN;
UNSIGNED1 UPIN_data_permits;
UNSIGNED1 UPIN_method; // This value could come from multiple BESTTYPE; track which one
UNSIGNED UPIN_own_cnt := 0; // Used for determining who OWNs this value
BOOLEAN  UPIN_owns := false; // Does this cluster own this value?
END;
ADDR_case_layout := RECORD
TYPEOF(h.PRIM_RANGE) ADDR_PRIM_RANGE;
TYPEOF(h.SEC_RANGE) ADDR_SEC_RANGE;
TYPEOF(h.PRIM_NAME) ADDR_PRIM_NAME;
UNSIGNED1 ADDR_data_permits;
UNSIGNED1 ADDR_method; // This value could come from multiple BESTTYPE; track which one
END;
LIC_NBR_case_layout := RECORD
TYPEOF(h.LIC_NBR) LIC_NBR;
UNSIGNED1 LIC_NBR_data_permits;
UNSIGNED1 LIC_NBR_method; // This value could come from multiple BESTTYPE; track which one
END;
DEA_NUMBER_case_layout := RECORD
TYPEOF(h.DEA_NUMBER) DEA_NUMBER;
UNSIGNED1 DEA_NUMBER_data_permits;
UNSIGNED1 DEA_NUMBER_method; // This value could come from multiple BESTTYPE; track which one
UNSIGNED DEA_NUMBER_own_cnt := 0; // Used for determining who OWNs this value
BOOLEAN  DEA_NUMBER_owns := false; // Does this cluster own this value?
END;
FNAME_case_layout := RECORD
TYPEOF(h.FNAME) FNAME;
UNSIGNED1 FNAME_data_permits;
UNSIGNED1 FNAME_method; // This value could come from multiple BESTTYPE; track which one
END;
TAX_ID_case_layout := RECORD
TYPEOF(h.TAX_ID) TAX_ID;
UNSIGNED1 TAX_ID_data_permits;
UNSIGNED1 TAX_ID_method; // This value could come from multiple BESTTYPE; track which one
UNSIGNED TAX_ID_own_cnt := 0; // Used for determining who OWNs this value
BOOLEAN  TAX_ID_owns := false; // Does this cluster own this value?
END;
SNAME_case_layout := RECORD
TYPEOF(h.SNAME) SNAME;
UNSIGNED1 SNAME_data_permits;
UNSIGNED1 SNAME_method; // This value could come from multiple BESTTYPE; track which one
END;
MNAME_case_layout := RECORD
TYPEOF(h.MNAME) MNAME;
UNSIGNED1 MNAME_data_permits;
UNSIGNED1 MNAME_method; // This value could come from multiple BESTTYPE; track which one
END;
LNAME_case_layout := RECORD
TYPEOF(h.LNAME) LNAME;
UNSIGNED1 LNAME_data_permits;
UNSIGNED1 LNAME_method; // This value could come from multiple BESTTYPE; track which one
END;
R := RECORD
typeof(h.LNPID) LNPID := 0;
DATASET(DID_case_layout) DID_cases;
DATASET(DOB_case_layout) DOB_cases;
DATASET(NPI_NUMBER_case_layout) NPI_NUMBER_cases;
DATASET(UPIN_case_layout) UPIN_cases;
DATASET(ADDR_case_layout) ADDR_cases;
DATASET(LIC_NBR_case_layout) LIC_NBR_cases;
DATASET(DEA_NUMBER_case_layout) DEA_NUMBER_cases;
DATASET(FNAME_case_layout) FNAME_cases;
DATASET(TAX_ID_case_layout) TAX_ID_cases;
TYPEOF(h.GENDER) GENDER;
UNSIGNED1 GENDER_data_permits;
DATASET(SNAME_case_layout) SNAME_cases;
DATASET(MNAME_case_layout) MNAME_cases;
DATASET(LNAME_case_layout) LNAME_cases;
TYPEOF(h.PHONE) PHONE;
UNSIGNED1 PHONE_data_permits;
END;
R T(BestBy_LNPID le) := TRANSFORM
SELF.DID_cases := DATASET([
{le.BestDIDCommonest_DID,le.DID_BestDIDCommonest_data_permits,3}
],DID_case_layout)(DID NOT IN SET(s.nulls_DID,DID));
SELF.DOB_cases := DATASET([
{le.BestDOB_DOB_year,le.BestDOB_DOB_month,le.BestDOB_DOB_day,le.DOB_BestDOB_data_permits,1},
{le.BestDOBLongest_DOB_year,le.BestDOBLongest_DOB_month,le.BestDOBLongest_DOB_day,le.DOB_BestDOBLongest_data_permits,2},
{le.BestDOBCommonest_DOB_year,le.BestDOBCommonest_DOB_month,le.BestDOBCommonest_DOB_day,le.DOB_BestDOBCommonest_data_permits,3}
],DOB_case_layout)((DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) OR DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) OR DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)));
SELF.NPI_NUMBER_cases := DATASET([
{le.BestNPI_NPI_NUMBER,le.NPI_NUMBER_BestNPI_data_permits,1,le.NPI_NUMBER_BestNPI_row_cnt,false},
{le.ExtendedCommonValue_NPI_NUMBER,le.NPI_NUMBER_ExtendedCommonValue_data_permits,2,le.NPI_NUMBER_ExtendedCommonValue_row_cnt,false},
{le.MostRecent_NPI_NUMBER,le.NPI_NUMBER_MostRecent_data_permits,3,le.NPI_NUMBER_MostRecent_row_cnt,false}
],NPI_NUMBER_case_layout)(NPI_NUMBER NOT IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER));
SELF.UPIN_cases := DATASET([
{le.ExtendedCommonValue_UPIN,le.UPIN_ExtendedCommonValue_data_permits,1,le.UPIN_ExtendedCommonValue_row_cnt,false},
{le.MostRecent_UPIN,le.UPIN_MostRecent_data_permits,2,le.UPIN_MostRecent_row_cnt,false}
],UPIN_case_layout)(UPIN NOT IN SET(s.nulls_UPIN,UPIN));
SELF.ADDR_cases := DATASET([
{le.BestAddressCommonest_ADDR_PRIM_RANGE,le.BestAddressCommonest_ADDR_SEC_RANGE,le.BestAddressCommonest_ADDR_PRIM_NAME,le.ADDR_BestAddressCommonest_data_permits,2}
],ADDR_case_layout)(ADDR_PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR ADDR_SEC_RANGE NOT IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR ADDR_PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME));
SELF.LIC_NBR_cases := DATASET([
{le.BestLICCommenest_LIC_NBR,le.LIC_NBR_BestLICCommenest_data_permits,3}
],LIC_NBR_case_layout)(LIC_NBR NOT IN SET(s.nulls_LIC_NBR,LIC_NBR));
SELF.DEA_NUMBER_cases := DATASET([
{le.MostRecentDEA_DEA_NUMBER,le.DEA_NUMBER_MostRecentDEA_data_permits,1,le.DEA_NUMBER_MostRecentDEA_row_cnt,false},
{le.ExtendedCommonValue_DEA_NUMBER,le.DEA_NUMBER_ExtendedCommonValue_data_permits,2,le.DEA_NUMBER_ExtendedCommonValue_row_cnt,false}
],DEA_NUMBER_case_layout)(DEA_NUMBER NOT IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER));
SELF.FNAME_cases := DATASET([
{le.BestFirstName_FNAME,le.FNAME_BestFirstName_data_permits,1},
{le.CommonFirstName_FNAME,le.FNAME_CommonFirstName_data_permits,2}
],FNAME_case_layout)(FNAME NOT IN SET(s.nulls_FNAME,FNAME));
SELF.TAX_ID_cases := DATASET([
{le.BestTaxID_TAX_ID,le.TAX_ID_BestTaxID_data_permits,1,le.TAX_ID_BestTaxID_row_cnt,false},
{le.BestTaxCommonest_TAX_ID,le.TAX_ID_BestTaxCommonest_data_permits,2,le.TAX_ID_BestTaxCommonest_row_cnt,false}
],TAX_ID_case_layout)(TAX_ID NOT IN SET(s.nulls_TAX_ID,TAX_ID));
SELF.GENDER := le.UniqueSingleValue_GENDER;
SELF.GENDER_data_permits := le.GENDER_UniqueSingleValue_data_permits;
SELF.SNAME_cases := DATASET([
{le.ExtendedCommonValue_SNAME,le.SNAME_ExtendedCommonValue_data_permits,1},
{le.LongestValue_SNAME,le.SNAME_LongestValue_data_permits,2}
],SNAME_case_layout)(SNAME NOT IN SET(s.nulls_SNAME,SNAME));
SELF.MNAME_cases := DATASET([
{le.ExtendedCommonValue_MNAME,le.MNAME_ExtendedCommonValue_data_permits,1},
{le.LongestValue_MNAME,le.MNAME_LongestValue_data_permits,2}
],MNAME_case_layout)(MNAME NOT IN SET(s.nulls_MNAME,MNAME));
SELF.LNAME_cases := DATASET([
{le.BestLastName_LNAME,le.LNAME_BestLastName_data_permits,1},
{le.CurrentLastName_LNAME,le.LNAME_CurrentLastName_data_permits,2}
],LNAME_case_layout)(LNAME NOT IN SET(s.nulls_LNAME,LNAME));
SELF.PHONE := le.BestPhoneCommonest_PHONE;
SELF.PHONE_data_permits := le.PHONE_BestPhoneCommonest_data_permits;
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
TYPEOF(h.DID) DID;
UNSIGNED1 DID_data_permits;
UNSIGNED1 DID_method; // This value could come from multiple BESTTYPE; track which one
TYPEOF(h.DOB_year) DOB_year;
TYPEOF(h.DOB_month) DOB_month;
TYPEOF(h.DOB_day) DOB_day;
UNSIGNED1 DOB_data_permits;
UNSIGNED1 DOB_method; // This value could come from multiple BESTTYPE; track which one
TYPEOF(h.NPI_NUMBER) NPI_NUMBER;
UNSIGNED1 NPI_NUMBER_data_permits;
UNSIGNED1 NPI_NUMBER_method; // This value could come from multiple BESTTYPE; track which one
UNSIGNED NPI_NUMBER_own_cnt := 0; // Used for determining who OWNs this value
BOOLEAN  NPI_NUMBER_owns := false; // Does this cluster own this value?
TYPEOF(h.UPIN) UPIN;
UNSIGNED1 UPIN_data_permits;
UNSIGNED1 UPIN_method; // This value could come from multiple BESTTYPE; track which one
UNSIGNED UPIN_own_cnt := 0; // Used for determining who OWNs this value
BOOLEAN  UPIN_owns := false; // Does this cluster own this value?
TYPEOF(h.PRIM_RANGE) ADDR_PRIM_RANGE;
TYPEOF(h.SEC_RANGE) ADDR_SEC_RANGE;
TYPEOF(h.PRIM_NAME) ADDR_PRIM_NAME;
UNSIGNED1 ADDR_data_permits;
UNSIGNED1 ADDR_method; // This value could come from multiple BESTTYPE; track which one
TYPEOF(h.LIC_NBR) LIC_NBR;
UNSIGNED1 LIC_NBR_data_permits;
UNSIGNED1 LIC_NBR_method; // This value could come from multiple BESTTYPE; track which one
TYPEOF(h.DEA_NUMBER) DEA_NUMBER;
UNSIGNED1 DEA_NUMBER_data_permits;
UNSIGNED1 DEA_NUMBER_method; // This value could come from multiple BESTTYPE; track which one
UNSIGNED DEA_NUMBER_own_cnt := 0; // Used for determining who OWNs this value
BOOLEAN  DEA_NUMBER_owns := false; // Does this cluster own this value?
TYPEOF(h.FNAME) FNAME;
UNSIGNED1 FNAME_data_permits;
UNSIGNED1 FNAME_method; // This value could come from multiple BESTTYPE; track which one
TYPEOF(h.TAX_ID) TAX_ID;
UNSIGNED1 TAX_ID_data_permits;
UNSIGNED1 TAX_ID_method; // This value could come from multiple BESTTYPE; track which one
UNSIGNED TAX_ID_own_cnt := 0; // Used for determining who OWNs this value
BOOLEAN  TAX_ID_owns := false; // Does this cluster own this value?
TYPEOF(h.GENDER) GENDER;
UNSIGNED1 GENDER_data_permits;
TYPEOF(h.SNAME) SNAME;
UNSIGNED1 SNAME_data_permits;
UNSIGNED1 SNAME_method; // This value could come from multiple BESTTYPE; track which one
TYPEOF(h.MNAME) MNAME;
UNSIGNED1 MNAME_data_permits;
UNSIGNED1 MNAME_method; // This value could come from multiple BESTTYPE; track which one
TYPEOF(h.LNAME) LNAME;
UNSIGNED1 LNAME_data_permits;
UNSIGNED1 LNAME_method; // This value could come from multiple BESTTYPE; track which one
TYPEOF(h.PHONE) PHONE;
UNSIGNED1 PHONE_data_permits;
END;
R T(BestBy_LNPID_child le) := TRANSFORM
SELF := le.DID_cases[1];
SELF := le.DOB_cases[1];
SELF := le.NPI_NUMBER_cases[1];
SELF := le.UPIN_cases[1];
SELF := le.ADDR_cases[1];
SELF := le.LIC_NBR_cases[1];
SELF := le.DEA_NUMBER_cases[1];
SELF := le.FNAME_cases[1];
SELF := le.TAX_ID_cases[1];
SELF := le.SNAME_cases[1];
SELF := le.MNAME_cases[1];
SELF := le.LNAME_cases[1];
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
OwnCands_UPIN := SORT( DISTRIBUTE(P1_After_NPI_NUMBER(UPIN_own_cnt>0),HASH(UPIN)), UPIN, -UPIN_own_cnt, LNPID,LOCAL);
PassThru_UPIN := P1_After_NPI_NUMBER(UPIN_own_cnt=0);
TYPEOF(P1_After_NPI_NUMBER) AddOwn_UPIN(P1_After_NPI_NUMBER le,P1_After_NPI_NUMBER ri) := TRANSFORM
SELF.UPIN_owns := le.UPIN <> ri.UPIN; // The first in line with this value
SELF := ri;
END;
P1_After_UPIN := ITERATE(OwnCands_UPIN,AddOwn_UPIN(LEFT,RIGHT),LOCAL) + PassThru_UPIN;
OwnCands_DEA_NUMBER := SORT( DISTRIBUTE(P1_After_UPIN(DEA_NUMBER_own_cnt>0),HASH(DEA_NUMBER)), DEA_NUMBER, -DEA_NUMBER_own_cnt, LNPID,LOCAL);
PassThru_DEA_NUMBER := P1_After_UPIN(DEA_NUMBER_own_cnt=0);
TYPEOF(P1_After_UPIN) AddOwn_DEA_NUMBER(P1_After_UPIN le,P1_After_UPIN ri) := TRANSFORM
SELF.DEA_NUMBER_owns := le.DEA_NUMBER <> ri.DEA_NUMBER; // The first in line with this value
SELF := ri;
END;
P1_After_DEA_NUMBER := ITERATE(OwnCands_DEA_NUMBER,AddOwn_DEA_NUMBER(LEFT,RIGHT),LOCAL) + PassThru_DEA_NUMBER;
OwnCands_TAX_ID := SORT( DISTRIBUTE(P1_After_DEA_NUMBER(TAX_ID_own_cnt>0),HASH(TAX_ID)), TAX_ID, -TAX_ID_own_cnt, LNPID,LOCAL);
PassThru_TAX_ID := P1_After_DEA_NUMBER(TAX_ID_own_cnt=0);
TYPEOF(P1_After_DEA_NUMBER) AddOwn_TAX_ID(P1_After_DEA_NUMBER le,P1_After_DEA_NUMBER ri) := TRANSFORM
SELF.TAX_ID_owns := le.TAX_ID <> ri.TAX_ID; // The first in line with this value
SELF := ri;
END;
P1_After_TAX_ID := ITERATE(OwnCands_TAX_ID,AddOwn_TAX_ID(LEFT,RIGHT),LOCAL) + PassThru_TAX_ID;
RETURN P1_After_TAX_ID;
END;
EXPORT BestBy_LNPID_best := Flatten_BestBy_LNPID(BestBy_LNPID_child);
EXPORT BestBy_LNPID_best_np := Flatten_BestBy_LNPID(BestBy_LNPID_child_np);
// Start to gather together all records with basis:LNPID,ST,data_permits
// 0 - Gathering type:MostRecentAddr Entries:1
R0 := RECORD
typeof(MostRecentAddr_method_ADDR.LNPID) LNPID; // Need to copy in basis
TYPEOF(MostRecentAddr_method_ADDR.ST) ST;
TYPEOF(MostRecentAddr_method_ADDR.PRIM_RANGE) MostRecentAddr_ADDR_PRIM_RANGE;
TYPEOF(MostRecentAddr_method_ADDR.SEC_RANGE) MostRecentAddr_ADDR_SEC_RANGE;
TYPEOF(MostRecentAddr_method_ADDR.PRIM_NAME) MostRecentAddr_ADDR_PRIM_NAME;
UNSIGNED ADDR_MostRecentAddr_Row_Cnt;
UNSIGNED1 ADDR_MostRecentAddr_data_permits;
END;
R0 T0(MostRecentAddr_method_ADDR ri) := TRANSFORM
SELF.MostRecentAddr_ADDR_PRIM_RANGE := ri.PRIM_RANGE;
SELF.MostRecentAddr_ADDR_SEC_RANGE := ri.SEC_RANGE;
SELF.MostRecentAddr_ADDR_PRIM_NAME := ri.PRIM_NAME;
SELF.ADDR_MostRecentAddr_Row_Cnt := ri.Row_Cnt;
SELF.ADDR_MostRecentAddr_data_permits := ri.data_permits;
SELF := ri;
END;
J0 := PROJECT(MostRecentAddr_method_ADDR,T0(left));
EXPORT BestBy_LNPID_ST_np := J0;
EXPORT BestBy_LNPID_ST := BestBy_LNPID_ST_np  : PERSIST('~temp::LNPID::HealthCareProviderHeader_prod::BestBy_LNPID_ST::best');
// Now gather some statistics to see how we did
R := RECORD
NumberOfBasis := COUNT(GROUP);
REAL8 MostRecentAddr_ADDR_PRIM_RANGE_pcnt := AVE(GROUP,IF(BestBy_LNPID_ST.MostRecentAddr_ADDR_PRIM_RANGE=(typeof(BestBy_LNPID_ST.MostRecentAddr_ADDR_PRIM_RANGE))'',0,100));
REAL8 MostRecentAddr_ADDR_SEC_RANGE_pcnt := AVE(GROUP,IF(BestBy_LNPID_ST.MostRecentAddr_ADDR_SEC_RANGE=(typeof(BestBy_LNPID_ST.MostRecentAddr_ADDR_SEC_RANGE))'',0,100));
REAL8 MostRecentAddr_ADDR_PRIM_NAME_pcnt := AVE(GROUP,IF(BestBy_LNPID_ST.MostRecentAddr_ADDR_PRIM_NAME=(typeof(BestBy_LNPID_ST.MostRecentAddr_ADDR_PRIM_NAME))'',0,100));
UNSIGNED MostRecentAddr_ADDR_permit1_cnt := COUNT(GROUP,BestBy_LNPID_ST.ADDR_MostRecentAddr_data_permits&1<>0);
UNSIGNED MostRecentAddr_ADDR_permit2_cnt := COUNT(GROUP,BestBy_LNPID_ST.ADDR_MostRecentAddr_data_permits&2<>0);
UNSIGNED MostRecentAddr_ADDR_permit3_cnt := COUNT(GROUP,BestBy_LNPID_ST.ADDR_MostRecentAddr_data_permits&4<>0);
UNSIGNED MostRecentAddr_ADDR_permit4_cnt := COUNT(GROUP,BestBy_LNPID_ST.ADDR_MostRecentAddr_data_permits&8<>0);
UNSIGNED MostRecentAddr_ADDR_permit5_cnt := COUNT(GROUP,BestBy_LNPID_ST.ADDR_MostRecentAddr_data_permits&16<>0);
END;
EXPORT BestBy_LNPID_ST_population := TABLE(BestBy_LNPID_ST,R);
// Take the wide table and turn it into a child-dataset version
SHARED F_BestBy_LNPID_ST(DATASET({BestBy_LNPID_ST}) d) := FUNCTION
ADDR_case_layout := RECORD
TYPEOF(h.PRIM_RANGE) ADDR_PRIM_RANGE;
TYPEOF(h.SEC_RANGE) ADDR_SEC_RANGE;
TYPEOF(h.PRIM_NAME) ADDR_PRIM_NAME;
UNSIGNED1 ADDR_data_permits;
UNSIGNED1 ADDR_method; // This value could come from multiple BESTTYPE; track which one
END;
R := RECORD
typeof(h.LNPID) LNPID := 0;
TYPEOF(h.ST) ST;
DATASET(ADDR_case_layout) ADDR_cases;
END;
R T(BestBy_LNPID_ST le) := TRANSFORM
SELF.ADDR_cases := DATASET([
{le.MostRecentAddr_ADDR_PRIM_RANGE,le.MostRecentAddr_ADDR_SEC_RANGE,le.MostRecentAddr_ADDR_PRIM_NAME,le.ADDR_MostRecentAddr_data_permits,1}
],ADDR_case_layout)(ADDR_PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR ADDR_SEC_RANGE NOT IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR ADDR_PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME));
SELF := le; // Copy BASIS
END;
P1 := PROJECT(d,T(LEFT));
RETURN P1;
END;
EXPORT BestBy_LNPID_ST_child := F_BestBy_LNPID_ST(BestBy_LNPID_ST);
EXPORT BestBy_LNPID_ST_child_np := F_BestBy_LNPID_ST(BestBy_LNPID_ST_np);
// Now to produce the slimmed down 'best propagation we can do for this basis'
SHARED Flatten_BestBy_LNPID_ST(DATASET({BestBy_LNPID_ST_child}) d) := FUNCTION
R := RECORD
TYPEOF(h.LNPID) LNPID := 0;
TYPEOF(h.ST) ST;
TYPEOF(h.PRIM_RANGE) ADDR_PRIM_RANGE;
TYPEOF(h.SEC_RANGE) ADDR_SEC_RANGE;
TYPEOF(h.PRIM_NAME) ADDR_PRIM_NAME;
UNSIGNED1 ADDR_data_permits;
UNSIGNED1 ADDR_method; // This value could come from multiple BESTTYPE; track which one
END;
R T(BestBy_LNPID_ST_child le) := TRANSFORM
SELF := le.ADDR_cases[1];
SELF := le; // Copy all non-multi fields
END;
P1 := PROJECT(d,T(LEFT));
RETURN P1;
END;
EXPORT BestBy_LNPID_ST_best := Flatten_BestBy_LNPID_ST(BestBy_LNPID_ST_child);
EXPORT BestBy_LNPID_ST_best_np := Flatten_BestBy_LNPID_ST(BestBy_LNPID_ST_child_np);
// Start to gather together all records with basis:LNPID,LIC_STATE,data_permits
// 0 - Gathering type:MostRecentLIC Entries:1
R0 := RECORD
typeof(MostRecentLIC_method_LIC_NBR.LNPID) LNPID; // Need to copy in basis
TYPEOF(MostRecentLIC_method_LIC_NBR.LIC_STATE) LIC_STATE;
TYPEOF(MostRecentLIC_method_LIC_NBR.LIC_NBR) MostRecentLIC_LIC_NBR;
UNSIGNED LIC_NBR_MostRecentLIC_Row_Cnt;
UNSIGNED1 LIC_NBR_MostRecentLIC_data_permits;
END;
R0 T0(MostRecentLIC_method_LIC_NBR ri) := TRANSFORM
SELF.MostRecentLIC_LIC_NBR := ri.LIC_NBR;
SELF.LIC_NBR_MostRecentLIC_Row_Cnt := ri.Row_Cnt;
SELF.LIC_NBR_MostRecentLIC_data_permits := ri.data_permits;
SELF := ri;
END;
J0 := PROJECT(MostRecentLIC_method_LIC_NBR,T0(left));
// 1 - Gathering type:BestLICLongest Entries:1
R1 := RECORD
J0; // The data so far
TYPEOF(BestLICLongest_method_LIC_NBR.LIC_NBR) BestLICLongest_LIC_NBR;
UNSIGNED LIC_NBR_BestLICLongest_Row_Cnt;
UNSIGNED1 LIC_NBR_BestLICLongest_data_permits;
END;
R1 T1(J0 le,BestLICLongest_method_LIC_NBR ri) := TRANSFORM
SELF.BestLICLongest_LIC_NBR := ri.LIC_NBR;
SELF.LIC_NBR_BestLICLongest_Row_Cnt := ri.Row_Cnt;
SELF.LIC_NBR_BestLICLongest_data_permits := ri.data_permits;
BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))'' OR (SALT27.StrType)le.LIC_STATE != ''; // See if LHS is null
SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
SELF.LIC_STATE := IF( has_left, le.LIC_STATE, ri.LIC_STATE );
SELF := le;
END;
J1 := JOIN(J0,BestLICLongest_method_LIC_NBR,LEFT.LNPID = RIGHT.LNPID AND LEFT.LIC_STATE = RIGHT.LIC_STATE,T1(LEFT,RIGHT),FULL OUTER,LOCAL);
EXPORT BestBy_LNPID__LIC_STATE_np := J1;
EXPORT BestBy_LNPID__LIC_STATE := BestBy_LNPID__LIC_STATE_np  : PERSIST('~temp::LNPID::HealthCareProviderHeader_prod::BestBy_LNPID__LIC_STATE::best');
// Now gather some statistics to see how we did
R := RECORD
NumberOfBasis := COUNT(GROUP);
REAL8 MostRecentLIC_LIC_NBR_pcnt := AVE(GROUP,IF(BestBy_LNPID__LIC_STATE.MostRecentLIC_LIC_NBR=(typeof(BestBy_LNPID__LIC_STATE.MostRecentLIC_LIC_NBR))'',0,100));
UNSIGNED MostRecentLIC_LIC_NBR_permit1_cnt := COUNT(GROUP,BestBy_LNPID__LIC_STATE.LIC_NBR_MostRecentLIC_data_permits&1<>0);
UNSIGNED MostRecentLIC_LIC_NBR_permit2_cnt := COUNT(GROUP,BestBy_LNPID__LIC_STATE.LIC_NBR_MostRecentLIC_data_permits&2<>0);
UNSIGNED MostRecentLIC_LIC_NBR_permit3_cnt := COUNT(GROUP,BestBy_LNPID__LIC_STATE.LIC_NBR_MostRecentLIC_data_permits&4<>0);
UNSIGNED MostRecentLIC_LIC_NBR_permit4_cnt := COUNT(GROUP,BestBy_LNPID__LIC_STATE.LIC_NBR_MostRecentLIC_data_permits&8<>0);
UNSIGNED MostRecentLIC_LIC_NBR_permit5_cnt := COUNT(GROUP,BestBy_LNPID__LIC_STATE.LIC_NBR_MostRecentLIC_data_permits&16<>0);
REAL8 BestLICLongest_LIC_NBR_pcnt := AVE(GROUP,IF(BestBy_LNPID__LIC_STATE.BestLICLongest_LIC_NBR=(typeof(BestBy_LNPID__LIC_STATE.BestLICLongest_LIC_NBR))'',0,100));
UNSIGNED BestLICLongest_LIC_NBR_permit1_cnt := COUNT(GROUP,BestBy_LNPID__LIC_STATE.LIC_NBR_BestLICLongest_data_permits&1<>0);
UNSIGNED BestLICLongest_LIC_NBR_permit2_cnt := COUNT(GROUP,BestBy_LNPID__LIC_STATE.LIC_NBR_BestLICLongest_data_permits&2<>0);
UNSIGNED BestLICLongest_LIC_NBR_permit3_cnt := COUNT(GROUP,BestBy_LNPID__LIC_STATE.LIC_NBR_BestLICLongest_data_permits&4<>0);
UNSIGNED BestLICLongest_LIC_NBR_permit4_cnt := COUNT(GROUP,BestBy_LNPID__LIC_STATE.LIC_NBR_BestLICLongest_data_permits&8<>0);
UNSIGNED BestLICLongest_LIC_NBR_permit5_cnt := COUNT(GROUP,BestBy_LNPID__LIC_STATE.LIC_NBR_BestLICLongest_data_permits&16<>0);
END;
EXPORT BestBy_LNPID__LIC_STATE_population := TABLE(BestBy_LNPID__LIC_STATE,R);
// Take the wide table and turn it into a child-dataset version
SHARED F_BestBy_LNPID__LIC_STATE(DATASET({BestBy_LNPID__LIC_STATE}) d) := FUNCTION
LIC_NBR_case_layout := RECORD
TYPEOF(h.LIC_NBR) LIC_NBR;
UNSIGNED1 LIC_NBR_data_permits;
UNSIGNED1 LIC_NBR_method; // This value could come from multiple BESTTYPE; track which one
END;
R := RECORD
typeof(h.LNPID) LNPID := 0;
TYPEOF(h.LIC_STATE) LIC_STATE;
DATASET(LIC_NBR_case_layout) LIC_NBR_cases;
END;
R T(BestBy_LNPID__LIC_STATE le) := TRANSFORM
SELF.LIC_NBR_cases := DATASET([
{le.MostRecentLIC_LIC_NBR,le.LIC_NBR_MostRecentLIC_data_permits,1},
{le.BestLICLongest_LIC_NBR,le.LIC_NBR_BestLICLongest_data_permits,2}
],LIC_NBR_case_layout)(LIC_NBR NOT IN SET(s.nulls_LIC_NBR,LIC_NBR));
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
TYPEOF(h.LIC_NBR) LIC_NBR;
UNSIGNED1 LIC_NBR_data_permits;
UNSIGNED1 LIC_NBR_method; // This value could come from multiple BESTTYPE; track which one
END;
R T(BestBy_LNPID__LIC_STATE_child le) := TRANSFORM
SELF := le.LIC_NBR_cases[1];
SELF := le; // Copy all non-multi fields
END;
P1 := PROJECT(d,T(LEFT));
RETURN P1;
END;
EXPORT BestBy_LNPID__LIC_STATE_best := Flatten_BestBy_LNPID__LIC_STATE(BestBy_LNPID__LIC_STATE_child);
EXPORT BestBy_LNPID__LIC_STATE_best_np := Flatten_BestBy_LNPID__LIC_STATE(BestBy_LNPID__LIC_STATE_child_np);
// Start to gather together all records with basis:LNPID,PRIM_RANGE,PRIM_NAME,ZIP,data_permits
// 0 - Gathering type:BestSecRange Entries:1
R0 := RECORD
typeof(BestSecRange_method_SEC_RANGE.LNPID) LNPID; // Need to copy in basis
TYPEOF(BestSecRange_method_SEC_RANGE.PRIM_RANGE) PRIM_RANGE;
TYPEOF(BestSecRange_method_SEC_RANGE.PRIM_NAME) PRIM_NAME;
TYPEOF(BestSecRange_method_SEC_RANGE.ZIP) ZIP;
TYPEOF(BestSecRange_method_SEC_RANGE.SEC_RANGE) BestSecRange_SEC_RANGE;
UNSIGNED SEC_RANGE_BestSecRange_Row_Cnt;
UNSIGNED SEC_RANGE_BestSecRange_Orig_Row_Cnt;
UNSIGNED1 SEC_RANGE_BestSecRange_data_permits;
END;
R0 T0(BestSecRange_method_SEC_RANGE ri) := TRANSFORM
SELF.BestSecRange_SEC_RANGE := ri.SEC_RANGE;
SELF.SEC_RANGE_BestSecRange_Row_Cnt := ri.Row_Cnt;
SELF.SEC_RANGE_BestSecRange_Orig_Row_Cnt := ri.Orig_Row_Cnt;
SELF.SEC_RANGE_BestSecRange_data_permits := ri.data_permits;
SELF := ri;
END;
J0 := PROJECT(BestSecRange_method_SEC_RANGE,T0(left));
EXPORT BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP_np := J0;
EXPORT BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP := BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP_np  : PERSIST('~temp::LNPID::HealthCareProviderHeader_prod::BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP::best');
// Now gather some statistics to see how we did
R := RECORD
NumberOfBasis := COUNT(GROUP);
REAL8 BestSecRange_SEC_RANGE_pcnt := AVE(GROUP,IF(BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP.BestSecRange_SEC_RANGE=(typeof(BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP.BestSecRange_SEC_RANGE))'',0,100));
UNSIGNED BestSecRange_SEC_RANGE_permit1_cnt := COUNT(GROUP,BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP.SEC_RANGE_BestSecRange_data_permits&1<>0);
UNSIGNED BestSecRange_SEC_RANGE_permit2_cnt := COUNT(GROUP,BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP.SEC_RANGE_BestSecRange_data_permits&2<>0);
UNSIGNED BestSecRange_SEC_RANGE_permit3_cnt := COUNT(GROUP,BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP.SEC_RANGE_BestSecRange_data_permits&4<>0);
UNSIGNED BestSecRange_SEC_RANGE_permit4_cnt := COUNT(GROUP,BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP.SEC_RANGE_BestSecRange_data_permits&8<>0);
UNSIGNED BestSecRange_SEC_RANGE_permit5_cnt := COUNT(GROUP,BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP.SEC_RANGE_BestSecRange_data_permits&16<>0);
END;
EXPORT BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP_population := TABLE(BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP,R);
// Take the wide table and turn it into a child-dataset version
SHARED F_BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP(DATASET({BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP}) d) := FUNCTION
R := RECORD
typeof(h.LNPID) LNPID := 0;
TYPEOF(h.PRIM_RANGE) PRIM_RANGE;
TYPEOF(h.PRIM_NAME) PRIM_NAME;
TYPEOF(h.ZIP) ZIP;
TYPEOF(h.SEC_RANGE) SEC_RANGE;
UNSIGNED1 SEC_RANGE_data_permits;
END;
R T(BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP le) := TRANSFORM
SELF.SEC_RANGE := le.BestSecRange_SEC_RANGE;
SELF.SEC_RANGE_data_permits := le.SEC_RANGE_BestSecRange_data_permits;
SELF := le; // Copy BASIS
END;
P1 := PROJECT(d,T(LEFT));
RETURN P1;
END;
EXPORT BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP_child := F_BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP(BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP);
EXPORT BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP_child_np := F_BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP(BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP_np);
// Now to produce the slimmed down 'best propagation we can do for this basis'
SHARED Flatten_BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP(DATASET({BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP_child}) d) := FUNCTION
R := RECORD
TYPEOF(h.LNPID) LNPID := 0;
TYPEOF(h.PRIM_RANGE) PRIM_RANGE;
TYPEOF(h.PRIM_NAME) PRIM_NAME;
TYPEOF(h.ZIP) ZIP;
TYPEOF(h.SEC_RANGE) SEC_RANGE;
UNSIGNED1 SEC_RANGE_data_permits;
END;
R T(BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP_child le) := TRANSFORM
SELF := le; // Copy all non-multi fields
END;
P1 := PROJECT(d,T(LEFT));
RETURN P1;
END;
EXPORT BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP_best := Flatten_BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP(BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP_child);
EXPORT BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP_best_np := Flatten_BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP(BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP_child_np);
// Start to gather together all records with basis:LNPID,ZIP,data_permits
// 0 - Gathering type:BestCity Entries:2
R0 := RECORD
typeof(BestCity_method_V_CITY_NAME.LNPID) LNPID; // Need to copy in basis
TYPEOF(BestCity_method_V_CITY_NAME.ZIP) ZIP;
TYPEOF(BestCity_method_V_CITY_NAME.V_CITY_NAME) BestCity_V_CITY_NAME;
UNSIGNED V_CITY_NAME_BestCity_Row_Cnt;
UNSIGNED1 V_CITY_NAME_BestCity_data_permits;
END;
R0 T0(BestCity_method_V_CITY_NAME ri) := TRANSFORM
SELF.BestCity_V_CITY_NAME := ri.V_CITY_NAME;
SELF.V_CITY_NAME_BestCity_Row_Cnt := ri.Row_Cnt;
SELF.V_CITY_NAME_BestCity_data_permits := ri.data_permits;
SELF := ri;
END;
J0 := PROJECT(BestCity_method_V_CITY_NAME,T0(left));
R1 := RECORD
J0; // The data so far
TYPEOF(BestCity_method_ST.ST) BestCity_ST;
UNSIGNED ST_BestCity_Row_Cnt;
UNSIGNED1 ST_BestCity_data_permits;
END;
R1 T1(J0 le,BestCity_method_ST ri) := TRANSFORM
SELF.BestCity_ST := ri.ST;
SELF.ST_BestCity_Row_Cnt := ri.Row_Cnt;
SELF.ST_BestCity_data_permits := ri.data_permits;
BOOLEAN has_left := le.LNPID <> (TYPEOF(le.LNPID))'' OR (SALT27.StrType)le.ZIP != ''; // See if LHS is null
SELF.LNPID := IF( has_left, le.LNPID, ri.LNPID );
SELF.ZIP := IF( has_left, le.ZIP, ri.ZIP );
SELF := le;
END;
J1 := JOIN(J0,BestCity_method_ST,LEFT.LNPID = RIGHT.LNPID AND LEFT.ZIP = RIGHT.ZIP,T1(LEFT,RIGHT),FULL OUTER,LOCAL);
EXPORT BestBy_LNPID_ZIP_np := J1;
EXPORT BestBy_LNPID_ZIP := BestBy_LNPID_ZIP_np  : PERSIST('~temp::LNPID::HealthCareProviderHeader_prod::BestBy_LNPID_ZIP::best');
// Now gather some statistics to see how we did
R := RECORD
NumberOfBasis := COUNT(GROUP);
REAL8 BestCity_V_CITY_NAME_pcnt := AVE(GROUP,IF(BestBy_LNPID_ZIP.BestCity_V_CITY_NAME=(typeof(BestBy_LNPID_ZIP.BestCity_V_CITY_NAME))'',0,100));
UNSIGNED BestCity_V_CITY_NAME_permit1_cnt := COUNT(GROUP,BestBy_LNPID_ZIP.V_CITY_NAME_BestCity_data_permits&1<>0);
UNSIGNED BestCity_V_CITY_NAME_permit2_cnt := COUNT(GROUP,BestBy_LNPID_ZIP.V_CITY_NAME_BestCity_data_permits&2<>0);
UNSIGNED BestCity_V_CITY_NAME_permit3_cnt := COUNT(GROUP,BestBy_LNPID_ZIP.V_CITY_NAME_BestCity_data_permits&4<>0);
UNSIGNED BestCity_V_CITY_NAME_permit4_cnt := COUNT(GROUP,BestBy_LNPID_ZIP.V_CITY_NAME_BestCity_data_permits&8<>0);
UNSIGNED BestCity_V_CITY_NAME_permit5_cnt := COUNT(GROUP,BestBy_LNPID_ZIP.V_CITY_NAME_BestCity_data_permits&16<>0);
REAL8 BestCity_ST_pcnt := AVE(GROUP,IF(BestBy_LNPID_ZIP.BestCity_ST=(typeof(BestBy_LNPID_ZIP.BestCity_ST))'',0,100));
UNSIGNED BestCity_ST_permit1_cnt := COUNT(GROUP,BestBy_LNPID_ZIP.ST_BestCity_data_permits&1<>0);
UNSIGNED BestCity_ST_permit2_cnt := COUNT(GROUP,BestBy_LNPID_ZIP.ST_BestCity_data_permits&2<>0);
UNSIGNED BestCity_ST_permit3_cnt := COUNT(GROUP,BestBy_LNPID_ZIP.ST_BestCity_data_permits&4<>0);
UNSIGNED BestCity_ST_permit4_cnt := COUNT(GROUP,BestBy_LNPID_ZIP.ST_BestCity_data_permits&8<>0);
UNSIGNED BestCity_ST_permit5_cnt := COUNT(GROUP,BestBy_LNPID_ZIP.ST_BestCity_data_permits&16<>0);
END;
EXPORT BestBy_LNPID_ZIP_population := TABLE(BestBy_LNPID_ZIP,R);
// Take the wide table and turn it into a child-dataset version
SHARED F_BestBy_LNPID_ZIP(DATASET({BestBy_LNPID_ZIP}) d) := FUNCTION
R := RECORD
typeof(h.LNPID) LNPID := 0;
TYPEOF(h.ZIP) ZIP;
TYPEOF(h.V_CITY_NAME) V_CITY_NAME;
UNSIGNED1 V_CITY_NAME_data_permits;
TYPEOF(h.ST) ST;
UNSIGNED1 ST_data_permits;
END;
R T(BestBy_LNPID_ZIP le) := TRANSFORM
SELF.V_CITY_NAME := le.BestCity_V_CITY_NAME;
SELF.V_CITY_NAME_data_permits := le.V_CITY_NAME_BestCity_data_permits;
SELF.ST := le.BestCity_ST;
SELF.ST_data_permits := le.ST_BestCity_data_permits;
SELF := le; // Copy BASIS
END;
P1 := PROJECT(d,T(LEFT));
RETURN P1;
END;
EXPORT BestBy_LNPID_ZIP_child := F_BestBy_LNPID_ZIP(BestBy_LNPID_ZIP);
EXPORT BestBy_LNPID_ZIP_child_np := F_BestBy_LNPID_ZIP(BestBy_LNPID_ZIP_np);
// Now to produce the slimmed down 'best propagation we can do for this basis'
SHARED Flatten_BestBy_LNPID_ZIP(DATASET({BestBy_LNPID_ZIP_child}) d) := FUNCTION
R := RECORD
TYPEOF(h.LNPID) LNPID := 0;
TYPEOF(h.ZIP) ZIP;
TYPEOF(h.V_CITY_NAME) V_CITY_NAME;
UNSIGNED1 V_CITY_NAME_data_permits;
TYPEOF(h.ST) ST;
UNSIGNED1 ST_data_permits;
END;
R T(BestBy_LNPID_ZIP_child le) := TRANSFORM
SELF := le; // Copy all non-multi fields
END;
P1 := PROJECT(d,T(LEFT));
RETURN P1;
END;
EXPORT BestBy_LNPID_ZIP_best := Flatten_BestBy_LNPID_ZIP(BestBy_LNPID_ZIP_child);
EXPORT BestBy_LNPID_ZIP_best_np := Flatten_BestBy_LNPID_ZIP(BestBy_LNPID_ZIP_child_np);
EXPORT Stats := PARALLEL(OUTPUT(BestBy_LNPID__DOB_population,NAMED('BestBy_LNPID__DOB_Population')),OUTPUT(BestBy_LNPID__ADDRESS_ID_population,NAMED('BestBy_LNPID__ADDRESS_ID_Population')),OUTPUT(BestBy_LNPID_population,NAMED('BestBy_LNPID_Population')),OUTPUT(BestBy_LNPID_ST_population,NAMED('BestBy_LNPID_ST_Population')),OUTPUT(BestBy_LNPID__LIC_STATE_population,NAMED('BestBy_LNPID__LIC_STATE_Population')),OUTPUT(BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP_population,NAMED('BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP_Population')),OUTPUT(BestBy_LNPID_ZIP_population,NAMED('BestBy_LNPID_ZIP_Population')));
// Append flags to the regular file
TYPEOF(ih) NoteFlags(ih le,BestBy_LNPID_Best ri) := TRANSFORM
SELF.DOB_flag := MAP ( ri.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND ri.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND ri.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) => SALT27.Flags.Null,
((UNSIGNED)le.DOB DIV 10000 )  IN SET(s.nulls_DOB_year,DOB_year) AND ((UNSIGNED)le.DOB DIV 100 % 100 )  IN SET(s.nulls_DOB_month,DOB_month) AND ((UNSIGNED)le.DOB % 100)  IN SET(s.nulls_DOB_day,DOB_day) => SALT27.Flags.Missing,
((UNSIGNED)le.DOB DIV 10000 ) = ri.DOB_year AND ((UNSIGNED)le.DOB DIV 100 % 100 ) = ri.DOB_month AND ((UNSIGNED)le.DOB % 100) = ri.DOB_day => SALT27.Flags.Equal,
SALT27.MOD_DateMatch(((UNSIGNED)le.DOB DIV 10000 ),((UNSIGNED)le.DOB DIV 100 % 100 ),((UNSIGNED)le.DOB % 100),ri.DOB_year,ri.DOB_month,ri.DOB_day,true,true,12,true).NNEQ => SALT27.Flags.Fuzzy,
SALT27.Flags.Bad);
SELF.PHONE_flag := MAP ( ri.PHONE = (TYPEOF(ri.PHONE))'' => SALT27.Flags.Null,
le.PHONE = (TYPEOF(le.PHONE))'' => SALT27.Flags.Missing,
le.PHONE = ri.PHONE => SALT27.Flags.Equal,
SALT27.Flags.Bad);
SELF.FNAME_flag := MAP ( ri.FNAME  IN SET(s.nulls_FNAME,FNAME) => SALT27.Flags.Null,
le.FNAME  IN SET(s.nulls_FNAME,FNAME) => SALT27.Flags.Missing,
le.FNAME = ri.FNAME => SALT27.Flags.Equal,
le.FNAME[1..LENGTH(TRIM(ri.FNAME))] = ri.FNAME OR ri.FNAME[1..LENGTH(TRIM(le.FNAME))] = le.FNAME OR SALT27.WithinEditN(le.FNAME,ri.FNAME,1)  OR fn_PreferredName(ri.FNAME) = fn_PreferredName(le.FNAME)  => SALT27.Flags.Fuzzy,
SALT27.Flags.Bad);
SELF.MNAME_flag := MAP ( ri.MNAME  IN SET(s.nulls_MNAME,MNAME) => SALT27.Flags.Null,
le.MNAME  IN SET(s.nulls_MNAME,MNAME) => SALT27.Flags.Missing,
le.MNAME = ri.MNAME => SALT27.Flags.Equal,
le.MNAME[1..LENGTH(TRIM(ri.MNAME))] = ri.MNAME OR ri.MNAME[1..LENGTH(TRIM(le.MNAME))] = le.MNAME OR SALT27.WithinEditN(le.MNAME,ri.MNAME,2)  => SALT27.Flags.Fuzzy,
SALT27.Flags.Bad);
SELF.LNAME_flag := MAP ( ri.LNAME  IN SET(s.nulls_LNAME,LNAME) => SALT27.Flags.Null,
le.LNAME  IN SET(s.nulls_LNAME,LNAME) => SALT27.Flags.Missing,
le.LNAME = ri.LNAME => SALT27.Flags.Equal,
le.LNAME[1..LENGTH(TRIM(ri.LNAME))] = ri.LNAME OR ri.LNAME[1..LENGTH(TRIM(le.LNAME))] = le.LNAME OR SALT27.WithinEditN(le.LNAME,ri.LNAME,2)  => SALT27.Flags.Fuzzy,
SALT27.Flags.Bad);
SELF.LIC_NBR_flag := MAP ( ri.LIC_NBR  IN SET(s.nulls_LIC_NBR,LIC_NBR) => SALT27.Flags.Null,
le.LIC_NBR  IN SET(s.nulls_LIC_NBR,LIC_NBR) => SALT27.Flags.Missing,
le.LIC_NBR = ri.LIC_NBR => SALT27.Flags.Equal,
SALT27.Flags.Bad);
SELF.NPI_NUMBER_flag := MAP ( ri.NPI_NUMBER  IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER) => SALT27.Flags.Null,
le.NPI_NUMBER  IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER) => SALT27.Flags.Missing,
ri.NPI_NUMBER_owns => SALT27.Flags.Owns,
le.NPI_NUMBER = ri.NPI_NUMBER => SALT27.Flags.Equal,
SALT27.Flags.Bad);
SELF.DEA_NUMBER_flag := MAP ( ri.DEA_NUMBER  IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER) => SALT27.Flags.Null,
le.DEA_NUMBER  IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER) => SALT27.Flags.Missing,
ri.DEA_NUMBER_owns => SALT27.Flags.Owns,
le.DEA_NUMBER = ri.DEA_NUMBER => SALT27.Flags.Equal,
SALT27.Flags.Bad);
SELF.TAX_ID_flag := MAP ( ri.TAX_ID  IN SET(s.nulls_TAX_ID,TAX_ID) => SALT27.Flags.Null,
le.TAX_ID  IN SET(s.nulls_TAX_ID,TAX_ID) => SALT27.Flags.Missing,
ri.TAX_ID_owns => SALT27.Flags.Owns,
le.TAX_ID = ri.TAX_ID => SALT27.Flags.Equal,
SALT27.Flags.Bad);
SELF.DID_flag := MAP ( ri.DID  IN SET(s.nulls_DID,DID) => SALT27.Flags.Null,
le.DID  IN SET(s.nulls_DID,DID) => SALT27.Flags.Missing,
le.DID = ri.DID => SALT27.Flags.Equal,
SALT27.Flags.Bad);
SELF.UPIN_flag := MAP ( ri.UPIN  IN SET(s.nulls_UPIN,UPIN) => SALT27.Flags.Null,
le.UPIN  IN SET(s.nulls_UPIN,UPIN) => SALT27.Flags.Missing,
ri.UPIN_owns => SALT27.Flags.Owns,
le.UPIN = ri.UPIN => SALT27.Flags.Equal,
SALT27.Flags.Bad);
SELF.ADDR_flag := MAP ( (ri.ADDR_PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) AND ri.ADDR_SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) AND ri.ADDR_PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME)) => SALT27.Flags.Null,
(le.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) AND le.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) AND le.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME)) => SALT27.Flags.Missing,
(le.PRIM_RANGE = ri.ADDR_PRIM_RANGE) AND (le.SEC_RANGE = ri.ADDR_SEC_RANGE) AND (le.PRIM_NAME = ri.ADDR_PRIM_NAME) => SALT27.Flags.Equal,
(le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR ri.ADDR_PRIM_RANGE = (TYPEOF(ri.ADDR_PRIM_RANGE))'' OR le.PRIM_RANGE = ri.ADDR_PRIM_RANGE ) AND (le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR ri.ADDR_SEC_RANGE = (TYPEOF(ri.ADDR_SEC_RANGE))'' ) AND (le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR ri.ADDR_PRIM_NAME = (TYPEOF(ri.ADDR_PRIM_NAME))'' OR le.PRIM_NAME = ri.ADDR_PRIM_NAME ) => SALT27.Flags.Fuzzy,
SALT27.Flags.Bad);
SELF := le;
END;
j := JOIN(ih,BestBy_LNPID_Best,LEFT.LNPID=RIGHT.LNPID,NoteFlags(LEFT,RIGHT),LEFT OUTER,HASH);
j1 := JOIN (J,BestBy_LNPID__LIC_STATE_best,LEFT.LNPID = RIGHT.LNPID AND LEFT.LIC_STATE = RIGHT.LIC_STATE AND LEFT.LIC_NBR = RIGHT.LIC_NBR,TRANSFORM(RECORDOF(J), SELF.LIC_NBR_flag := IF (LEFT.LIC_NBR = RIGHT.LIC_NBR AND LEFT.LIC_STATE = RIGHT.LIC_STATE AND LEFT.LNPID = RIGHT.LNPID ,SALT27.Flags.Equal,LEFT.LIC_NBR_flag); SELF := LEFT;),LEFT OUTER, HASH);
EXPORT In_Flagged := j1;
FlagTots := RECORD
UNSIGNED Cnt := COUNT(GROUP);
REAL4 DOB_Null_pcnt := AVE(GROUP,IF(In_Flagged.DOB_Flag = SALT27.Flags.Null,100,0));
REAL4 DOB_Equal_pcnt := AVE(GROUP,IF(In_Flagged.DOB_Flag = SALT27.Flags.Equal,100,0));
REAL4 DOB_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.DOB_Flag = SALT27.Flags.Fuzzy,100,0));
REAL4 DOB_Bad_pcnt := AVE(GROUP,IF(In_Flagged.DOB_Flag = SALT27.Flags.Bad,100,0));
REAL4 DOB_Missing_pcnt := AVE(GROUP,IF(In_Flagged.DOB_Flag = SALT27.Flags.Missing,100,0));
REAL4 PHONE_Null_pcnt := AVE(GROUP,IF(In_Flagged.PHONE_Flag = SALT27.Flags.Null,100,0));
REAL4 PHONE_Equal_pcnt := AVE(GROUP,IF(In_Flagged.PHONE_Flag = SALT27.Flags.Equal,100,0));
REAL4 PHONE_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.PHONE_Flag = SALT27.Flags.Fuzzy,100,0));
REAL4 PHONE_Bad_pcnt := AVE(GROUP,IF(In_Flagged.PHONE_Flag = SALT27.Flags.Bad,100,0));
REAL4 PHONE_Missing_pcnt := AVE(GROUP,IF(In_Flagged.PHONE_Flag = SALT27.Flags.Missing,100,0));
REAL4 FNAME_Null_pcnt := AVE(GROUP,IF(In_Flagged.FNAME_Flag = SALT27.Flags.Null,100,0));
REAL4 FNAME_Equal_pcnt := AVE(GROUP,IF(In_Flagged.FNAME_Flag = SALT27.Flags.Equal,100,0));
REAL4 FNAME_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.FNAME_Flag = SALT27.Flags.Fuzzy,100,0));
REAL4 FNAME_Bad_pcnt := AVE(GROUP,IF(In_Flagged.FNAME_Flag = SALT27.Flags.Bad,100,0));
REAL4 FNAME_Missing_pcnt := AVE(GROUP,IF(In_Flagged.FNAME_Flag = SALT27.Flags.Missing,100,0));
REAL4 MNAME_Null_pcnt := AVE(GROUP,IF(In_Flagged.MNAME_Flag = SALT27.Flags.Null,100,0));
REAL4 MNAME_Equal_pcnt := AVE(GROUP,IF(In_Flagged.MNAME_Flag = SALT27.Flags.Equal,100,0));
REAL4 MNAME_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.MNAME_Flag = SALT27.Flags.Fuzzy,100,0));
REAL4 MNAME_Bad_pcnt := AVE(GROUP,IF(In_Flagged.MNAME_Flag = SALT27.Flags.Bad,100,0));
REAL4 MNAME_Missing_pcnt := AVE(GROUP,IF(In_Flagged.MNAME_Flag = SALT27.Flags.Missing,100,0));
REAL4 LNAME_Null_pcnt := AVE(GROUP,IF(In_Flagged.LNAME_Flag = SALT27.Flags.Null,100,0));
REAL4 LNAME_Equal_pcnt := AVE(GROUP,IF(In_Flagged.LNAME_Flag = SALT27.Flags.Equal,100,0));
REAL4 LNAME_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.LNAME_Flag = SALT27.Flags.Fuzzy,100,0));
REAL4 LNAME_Bad_pcnt := AVE(GROUP,IF(In_Flagged.LNAME_Flag = SALT27.Flags.Bad,100,0));
REAL4 LNAME_Missing_pcnt := AVE(GROUP,IF(In_Flagged.LNAME_Flag = SALT27.Flags.Missing,100,0));
REAL4 LIC_NBR_Null_pcnt := AVE(GROUP,IF(In_Flagged.LIC_NBR_Flag = SALT27.Flags.Null,100,0));
REAL4 LIC_NBR_Equal_pcnt := AVE(GROUP,IF(In_Flagged.LIC_NBR_Flag = SALT27.Flags.Equal,100,0));
REAL4 LIC_NBR_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.LIC_NBR_Flag = SALT27.Flags.Fuzzy,100,0));
REAL4 LIC_NBR_Bad_pcnt := AVE(GROUP,IF(In_Flagged.LIC_NBR_Flag = SALT27.Flags.Bad,100,0));
REAL4 LIC_NBR_Missing_pcnt := AVE(GROUP,IF(In_Flagged.LIC_NBR_Flag = SALT27.Flags.Missing,100,0));
REAL4 NPI_NUMBER_Null_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT27.Flags.Null,100,0));
REAL4 NPI_NUMBER_Equal_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT27.Flags.Equal,100,0));
REAL4 NPI_NUMBER_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT27.Flags.Fuzzy,100,0));
REAL4 NPI_NUMBER_Bad_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT27.Flags.Bad,100,0));
REAL4 NPI_NUMBER_Missing_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT27.Flags.Missing,100,0));
REAL4 NPI_NUMBER_Owns_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT27.Flags.Owns,100,0));
REAL4 DEA_NUMBER_Null_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT27.Flags.Null,100,0));
REAL4 DEA_NUMBER_Equal_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT27.Flags.Equal,100,0));
REAL4 DEA_NUMBER_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT27.Flags.Fuzzy,100,0));
REAL4 DEA_NUMBER_Bad_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT27.Flags.Bad,100,0));
REAL4 DEA_NUMBER_Missing_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT27.Flags.Missing,100,0));
REAL4 DEA_NUMBER_Owns_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT27.Flags.Owns,100,0));
REAL4 TAX_ID_Null_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT27.Flags.Null,100,0));
REAL4 TAX_ID_Equal_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT27.Flags.Equal,100,0));
REAL4 TAX_ID_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT27.Flags.Fuzzy,100,0));
REAL4 TAX_ID_Bad_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT27.Flags.Bad,100,0));
REAL4 TAX_ID_Missing_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT27.Flags.Missing,100,0));
REAL4 TAX_ID_Owns_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT27.Flags.Owns,100,0));
REAL4 DID_Null_pcnt := AVE(GROUP,IF(In_Flagged.DID_Flag = SALT27.Flags.Null,100,0));
REAL4 DID_Equal_pcnt := AVE(GROUP,IF(In_Flagged.DID_Flag = SALT27.Flags.Equal,100,0));
REAL4 DID_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.DID_Flag = SALT27.Flags.Fuzzy,100,0));
REAL4 DID_Bad_pcnt := AVE(GROUP,IF(In_Flagged.DID_Flag = SALT27.Flags.Bad,100,0));
REAL4 DID_Missing_pcnt := AVE(GROUP,IF(In_Flagged.DID_Flag = SALT27.Flags.Missing,100,0));
REAL4 UPIN_Null_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT27.Flags.Null,100,0));
REAL4 UPIN_Equal_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT27.Flags.Equal,100,0));
REAL4 UPIN_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT27.Flags.Fuzzy,100,0));
REAL4 UPIN_Bad_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT27.Flags.Bad,100,0));
REAL4 UPIN_Missing_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT27.Flags.Missing,100,0));
REAL4 UPIN_Owns_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT27.Flags.Owns,100,0));
REAL4 ADDR_Null_pcnt := AVE(GROUP,IF(In_Flagged.ADDR_Flag = SALT27.Flags.Null,100,0));
REAL4 ADDR_Equal_pcnt := AVE(GROUP,IF(In_Flagged.ADDR_Flag = SALT27.Flags.Equal,100,0));
REAL4 ADDR_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.ADDR_Flag = SALT27.Flags.Fuzzy,100,0));
REAL4 ADDR_Bad_pcnt := AVE(GROUP,IF(In_Flagged.ADDR_Flag = SALT27.Flags.Bad,100,0));
REAL4 ADDR_Missing_pcnt := AVE(GROUP,IF(In_Flagged.ADDR_Flag = SALT27.Flags.Missing,100,0));
END;
EXPORT In_Flagged_Summary := TABLE(In_Flagged,FlagTots); // Global summary
FlagTots := RECORD
In_Flagged.SRC; // Group by sourcefield    UNSIGNED Cnt := COUNT(GROUP);
REAL4 DOB_Null_pcnt := AVE(GROUP,IF(In_Flagged.DOB_Flag = SALT27.Flags.Null,100,0));
REAL4 DOB_Equal_pcnt := AVE(GROUP,IF(In_Flagged.DOB_Flag = SALT27.Flags.Equal,100,0));
REAL4 DOB_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.DOB_Flag = SALT27.Flags.Fuzzy,100,0));
REAL4 DOB_Bad_pcnt := AVE(GROUP,IF(In_Flagged.DOB_Flag = SALT27.Flags.Bad,100,0));
REAL4 DOB_Missing_pcnt := AVE(GROUP,IF(In_Flagged.DOB_Flag = SALT27.Flags.Missing,100,0));
REAL4 PHONE_Null_pcnt := AVE(GROUP,IF(In_Flagged.PHONE_Flag = SALT27.Flags.Null,100,0));
REAL4 PHONE_Equal_pcnt := AVE(GROUP,IF(In_Flagged.PHONE_Flag = SALT27.Flags.Equal,100,0));
REAL4 PHONE_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.PHONE_Flag = SALT27.Flags.Fuzzy,100,0));
REAL4 PHONE_Bad_pcnt := AVE(GROUP,IF(In_Flagged.PHONE_Flag = SALT27.Flags.Bad,100,0));
REAL4 PHONE_Missing_pcnt := AVE(GROUP,IF(In_Flagged.PHONE_Flag = SALT27.Flags.Missing,100,0));
REAL4 FNAME_Null_pcnt := AVE(GROUP,IF(In_Flagged.FNAME_Flag = SALT27.Flags.Null,100,0));
REAL4 FNAME_Equal_pcnt := AVE(GROUP,IF(In_Flagged.FNAME_Flag = SALT27.Flags.Equal,100,0));
REAL4 FNAME_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.FNAME_Flag = SALT27.Flags.Fuzzy,100,0));
REAL4 FNAME_Bad_pcnt := AVE(GROUP,IF(In_Flagged.FNAME_Flag = SALT27.Flags.Bad,100,0));
REAL4 FNAME_Missing_pcnt := AVE(GROUP,IF(In_Flagged.FNAME_Flag = SALT27.Flags.Missing,100,0));
REAL4 MNAME_Null_pcnt := AVE(GROUP,IF(In_Flagged.MNAME_Flag = SALT27.Flags.Null,100,0));
REAL4 MNAME_Equal_pcnt := AVE(GROUP,IF(In_Flagged.MNAME_Flag = SALT27.Flags.Equal,100,0));
REAL4 MNAME_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.MNAME_Flag = SALT27.Flags.Fuzzy,100,0));
REAL4 MNAME_Bad_pcnt := AVE(GROUP,IF(In_Flagged.MNAME_Flag = SALT27.Flags.Bad,100,0));
REAL4 MNAME_Missing_pcnt := AVE(GROUP,IF(In_Flagged.MNAME_Flag = SALT27.Flags.Missing,100,0));
REAL4 LNAME_Null_pcnt := AVE(GROUP,IF(In_Flagged.LNAME_Flag = SALT27.Flags.Null,100,0));
REAL4 LNAME_Equal_pcnt := AVE(GROUP,IF(In_Flagged.LNAME_Flag = SALT27.Flags.Equal,100,0));
REAL4 LNAME_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.LNAME_Flag = SALT27.Flags.Fuzzy,100,0));
REAL4 LNAME_Bad_pcnt := AVE(GROUP,IF(In_Flagged.LNAME_Flag = SALT27.Flags.Bad,100,0));
REAL4 LNAME_Missing_pcnt := AVE(GROUP,IF(In_Flagged.LNAME_Flag = SALT27.Flags.Missing,100,0));
REAL4 LIC_NBR_Null_pcnt := AVE(GROUP,IF(In_Flagged.LIC_NBR_Flag = SALT27.Flags.Null,100,0));
REAL4 LIC_NBR_Equal_pcnt := AVE(GROUP,IF(In_Flagged.LIC_NBR_Flag = SALT27.Flags.Equal,100,0));
REAL4 LIC_NBR_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.LIC_NBR_Flag = SALT27.Flags.Fuzzy,100,0));
REAL4 LIC_NBR_Bad_pcnt := AVE(GROUP,IF(In_Flagged.LIC_NBR_Flag = SALT27.Flags.Bad,100,0));
REAL4 LIC_NBR_Missing_pcnt := AVE(GROUP,IF(In_Flagged.LIC_NBR_Flag = SALT27.Flags.Missing,100,0));
REAL4 NPI_NUMBER_Null_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT27.Flags.Null,100,0));
REAL4 NPI_NUMBER_Equal_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT27.Flags.Equal,100,0));
REAL4 NPI_NUMBER_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT27.Flags.Fuzzy,100,0));
REAL4 NPI_NUMBER_Bad_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT27.Flags.Bad,100,0));
REAL4 NPI_NUMBER_Missing_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT27.Flags.Missing,100,0));
REAL4 NPI_NUMBER_Owns_pcnt := AVE(GROUP,IF(In_Flagged.NPI_NUMBER_Flag = SALT27.Flags.Owns,100,0));
REAL4 DEA_NUMBER_Null_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT27.Flags.Null,100,0));
REAL4 DEA_NUMBER_Equal_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT27.Flags.Equal,100,0));
REAL4 DEA_NUMBER_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT27.Flags.Fuzzy,100,0));
REAL4 DEA_NUMBER_Bad_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT27.Flags.Bad,100,0));
REAL4 DEA_NUMBER_Missing_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT27.Flags.Missing,100,0));
REAL4 DEA_NUMBER_Owns_pcnt := AVE(GROUP,IF(In_Flagged.DEA_NUMBER_Flag = SALT27.Flags.Owns,100,0));
REAL4 TAX_ID_Null_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT27.Flags.Null,100,0));
REAL4 TAX_ID_Equal_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT27.Flags.Equal,100,0));
REAL4 TAX_ID_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT27.Flags.Fuzzy,100,0));
REAL4 TAX_ID_Bad_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT27.Flags.Bad,100,0));
REAL4 TAX_ID_Missing_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT27.Flags.Missing,100,0));
REAL4 TAX_ID_Owns_pcnt := AVE(GROUP,IF(In_Flagged.TAX_ID_Flag = SALT27.Flags.Owns,100,0));
REAL4 DID_Null_pcnt := AVE(GROUP,IF(In_Flagged.DID_Flag = SALT27.Flags.Null,100,0));
REAL4 DID_Equal_pcnt := AVE(GROUP,IF(In_Flagged.DID_Flag = SALT27.Flags.Equal,100,0));
REAL4 DID_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.DID_Flag = SALT27.Flags.Fuzzy,100,0));
REAL4 DID_Bad_pcnt := AVE(GROUP,IF(In_Flagged.DID_Flag = SALT27.Flags.Bad,100,0));
REAL4 DID_Missing_pcnt := AVE(GROUP,IF(In_Flagged.DID_Flag = SALT27.Flags.Missing,100,0));
REAL4 UPIN_Null_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT27.Flags.Null,100,0));
REAL4 UPIN_Equal_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT27.Flags.Equal,100,0));
REAL4 UPIN_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT27.Flags.Fuzzy,100,0));
REAL4 UPIN_Bad_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT27.Flags.Bad,100,0));
REAL4 UPIN_Missing_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT27.Flags.Missing,100,0));
REAL4 UPIN_Owns_pcnt := AVE(GROUP,IF(In_Flagged.UPIN_Flag = SALT27.Flags.Owns,100,0));
REAL4 ADDR_Null_pcnt := AVE(GROUP,IF(In_Flagged.ADDR_Flag = SALT27.Flags.Null,100,0));
REAL4 ADDR_Equal_pcnt := AVE(GROUP,IF(In_Flagged.ADDR_Flag = SALT27.Flags.Equal,100,0));
REAL4 ADDR_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.ADDR_Flag = SALT27.Flags.Fuzzy,100,0));
REAL4 ADDR_Bad_pcnt := AVE(GROUP,IF(In_Flagged.ADDR_Flag = SALT27.Flags.Bad,100,0));
REAL4 ADDR_Missing_pcnt := AVE(GROUP,IF(In_Flagged.ADDR_Flag = SALT27.Flags.Missing,100,0));
END;
EXPORT In_Flagged_Summary_BySrc := TABLE(In_Flagged,FlagTots,SRC,FEW);
// Append flags to the input file
TYPEOF(h) NoteFlags(h le,BestBy_LNPID_Best ri) := TRANSFORM
SELF.DOB_flag := MAP ( ri.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND ri.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND ri.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) => SALT27.Flags.Null,
le.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND le.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND le.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) => SALT27.Flags.Missing,
le.DOB_year = ri.DOB_year AND le.DOB_month = ri.DOB_month AND le.DOB_day = ri.DOB_day => SALT27.Flags.Equal,
SALT27.MOD_DateMatch(le.DOB_year,le.DOB_month,le.DOB_day,ri.DOB_year,ri.DOB_month,ri.DOB_day,true,true,12,true).NNEQ => SALT27.Flags.Fuzzy,
SALT27.Flags.Bad);
SELF.PHONE_flag := MAP ( ri.PHONE = (TYPEOF(ri.PHONE))'' => SALT27.Flags.Null,
le.PHONE = (TYPEOF(le.PHONE))'' => SALT27.Flags.Missing,
le.PHONE = ri.PHONE => SALT27.Flags.Equal,
SALT27.Flags.Bad);
SELF.FNAME_flag := MAP ( ri.FNAME  IN SET(s.nulls_FNAME,FNAME) => SALT27.Flags.Null,
le.FNAME  IN SET(s.nulls_FNAME,FNAME) => SALT27.Flags.Missing,
le.FNAME = ri.FNAME => SALT27.Flags.Equal,
le.FNAME[1..LENGTH(TRIM(ri.FNAME))] = ri.FNAME OR ri.FNAME[1..LENGTH(TRIM(le.FNAME))] = le.FNAME OR SALT27.WithinEditN(le.FNAME,ri.FNAME,1)  OR fn_PreferredName(ri.FNAME) = fn_PreferredName(le.FNAME)  => SALT27.Flags.Fuzzy,
SALT27.Flags.Bad);
SELF.MNAME_flag := MAP ( ri.MNAME  IN SET(s.nulls_MNAME,MNAME) => SALT27.Flags.Null,
le.MNAME  IN SET(s.nulls_MNAME,MNAME) => SALT27.Flags.Missing,
le.MNAME = ri.MNAME => SALT27.Flags.Equal,
le.MNAME[1..LENGTH(TRIM(ri.MNAME))] = ri.MNAME OR ri.MNAME[1..LENGTH(TRIM(le.MNAME))] = le.MNAME OR SALT27.WithinEditN(le.MNAME,ri.MNAME,2)  => SALT27.Flags.Fuzzy,
SALT27.Flags.Bad);
SELF.LNAME_flag := MAP ( ri.LNAME  IN SET(s.nulls_LNAME,LNAME) => SALT27.Flags.Null,
le.LNAME  IN SET(s.nulls_LNAME,LNAME) => SALT27.Flags.Missing,
le.LNAME = ri.LNAME => SALT27.Flags.Equal,
le.LNAME[1..LENGTH(TRIM(ri.LNAME))] = ri.LNAME OR ri.LNAME[1..LENGTH(TRIM(le.LNAME))] = le.LNAME OR SALT27.WithinEditN(le.LNAME,ri.LNAME,2)  => SALT27.Flags.Fuzzy,
SALT27.Flags.Bad);
SELF.LIC_NBR_flag := MAP ( ri.LIC_NBR  IN SET(s.nulls_LIC_NBR,LIC_NBR) => SALT27.Flags.Null,
le.LIC_NBR  IN SET(s.nulls_LIC_NBR,LIC_NBR) => SALT27.Flags.Missing,
le.LIC_NBR = ri.LIC_NBR => SALT27.Flags.Equal,
SALT27.Flags.Bad);
SELF.NPI_NUMBER_flag := MAP ( ri.NPI_NUMBER  IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER) => SALT27.Flags.Null,
le.NPI_NUMBER  IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER) => SALT27.Flags.Missing,
ri.NPI_NUMBER_owns => SALT27.Flags.Owns,
le.NPI_NUMBER = ri.NPI_NUMBER => SALT27.Flags.Equal,
SALT27.Flags.Bad);
SELF.DEA_NUMBER_flag := MAP ( ri.DEA_NUMBER  IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER) => SALT27.Flags.Null,
le.DEA_NUMBER  IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER) => SALT27.Flags.Missing,
ri.DEA_NUMBER_owns => SALT27.Flags.Owns,
le.DEA_NUMBER = ri.DEA_NUMBER => SALT27.Flags.Equal,
SALT27.Flags.Bad);
SELF.TAX_ID_flag := MAP ( ri.TAX_ID  IN SET(s.nulls_TAX_ID,TAX_ID) => SALT27.Flags.Null,
le.TAX_ID  IN SET(s.nulls_TAX_ID,TAX_ID) => SALT27.Flags.Missing,
ri.TAX_ID_owns => SALT27.Flags.Owns,
le.TAX_ID = ri.TAX_ID => SALT27.Flags.Equal,
SALT27.Flags.Bad);
SELF.DID_flag := MAP ( ri.DID  IN SET(s.nulls_DID,DID) => SALT27.Flags.Null,
le.DID  IN SET(s.nulls_DID,DID) => SALT27.Flags.Missing,
le.DID = ri.DID => SALT27.Flags.Equal,
SALT27.Flags.Bad);
SELF.UPIN_flag := MAP ( ri.UPIN  IN SET(s.nulls_UPIN,UPIN) => SALT27.Flags.Null,
le.UPIN  IN SET(s.nulls_UPIN,UPIN) => SALT27.Flags.Missing,
ri.UPIN_owns => SALT27.Flags.Owns,
le.UPIN = ri.UPIN => SALT27.Flags.Equal,
SALT27.Flags.Bad);
SELF.ADDR_flag := MAP ( (ri.ADDR_PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) AND ri.ADDR_SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) AND ri.ADDR_PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME)) => SALT27.Flags.Null,
(le.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) AND le.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) AND le.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME)) => SALT27.Flags.Missing,
(le.PRIM_RANGE = ri.ADDR_PRIM_RANGE) AND (le.SEC_RANGE = ri.ADDR_SEC_RANGE) AND (le.PRIM_NAME = ri.ADDR_PRIM_NAME) => SALT27.Flags.Equal,
(le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR ri.ADDR_PRIM_RANGE = (TYPEOF(ri.ADDR_PRIM_RANGE))'' OR le.PRIM_RANGE = ri.ADDR_PRIM_RANGE ) AND (le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR ri.ADDR_SEC_RANGE = (TYPEOF(ri.ADDR_SEC_RANGE))'' ) AND (le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR ri.ADDR_PRIM_NAME = (TYPEOF(ri.ADDR_PRIM_NAME))'' OR le.PRIM_NAME = ri.ADDR_PRIM_NAME ) => SALT27.Flags.Fuzzy,
SALT27.Flags.Bad);
SELF := le;
END;
j := JOIN(h,BestBy_LNPID_Best,LEFT.LNPID=RIGHT.LNPID,NoteFlags(LEFT,RIGHT),LEFT OUTER,HASH);
j1 := JOIN (J,BestBy_LNPID__LIC_STATE_best,LEFT.LNPID = RIGHT.LNPID AND LEFT.LIC_STATE = RIGHT.LIC_STATE AND LEFT.LIC_NBR = RIGHT.LIC_NBR,TRANSFORM(RECORDOF(J), SELF.LIC_NBR_flag := IF (LEFT.LIC_NBR = RIGHT.LIC_NBR AND LEFT.LIC_STATE = RIGHT.LIC_STATE AND LEFT.LNPID = RIGHT.LNPID,SALT27.Flags.Equal,LEFT.LIC_NBR_flag); SELF := LEFT;),LEFT OUTER, HASH);
EXPORT Input_Flagged := j1;
END;
