IMPORT ut,SALT29;
// @param MultiRec - if set to true then multiple records may have the same Reference and a consolidated result will be produced
// @param ButNot - set of IDs that will NOT be considered as part of the result
EXPORT MEOW_xLNPID(DATASET(Process_xLNPID_Layouts.InputLayout) in, BOOLEAN MultiRec = FALSE,SET OF SALT29.UIDType ButNot=[]) := MODULE
Process_xLNPID_Layouts.OutputLayout GetResults(Process_xLNPID_Layouts.InputLayout le) := TRANSFORM
  SELF.keys_tried := IF (Key_HealthProvider_NAMEL.CanSearch(le),1 << 1,0) + IF (Key_HealthProvider_FNAME.CanSearch(le),1 << 2,0) + IF (Key_HealthProvider_NAMED.CanSearch(le),1 << 3,0) + IF (Key_HealthProvider_LNAME.CanSearch(le),1 << 4,0) + IF (Key_HealthProvider_MNAME.CanSearch(le),1 << 5,0) + IF (Key_HealthProvider_ADDRESS.CanSearch(le),1 << 6,0) + IF (Key_HealthProvider_ZIP_PR.CanSearch(le),1 << 7,0) + IF (Key_HealthProvider_SSN_LP.CanSearch(le),1 << 8,0) + IF (Key_HealthProvider_CNSMR_SSN_LP.CanSearch(le),1 << 9,0) + IF (Key_HealthProvider_DOB_LP.CanSearch(le),1 << 10,0) + IF (Key_HealthProvider_CNSMR_DOB_LP.CanSearch(le),1 << 11,0) + IF (Key_HealthProvider_PHONE_LP.CanSearch(le),1 << 12,0) + IF (Key_HealthProvider_LIC.CanSearch(le),1 << 13,0) + IF (Key_HealthProvider_VEN.CanSearch(le),1 << 14,0) + IF (Key_HealthProvider_TAX.CanSearch(le),1 << 15,0) + IF (Key_HealthProvider_BILLING_TAX.CanSearch(le),1 << 16,0) + IF (Key_HealthProvider_DEA.CanSearch(le),1 << 17,0) + IF (Key_HealthProvider_NPI.CanSearch(le),1 << 18,0) + IF (Key_HealthProvider_BILLING_NPI.CanSearch(le),1 << 19,0) + IF (Key_HealthProvider_UPN.CanSearch(le),1 << 20,0) + IF (Key_HealthProvider_LEXID.CanSearch(le),1 << 21,0) + IF (Key_HealthProvider_BID.CanSearch(le),1 << 22,0) + IF (Key_HealthProvider_SRC_RID.CanSearch(le),1 << 23,0) + IF (Key_HealthProvider_RID.CanSearch(le),1 << 24,0);
  SELF.Results := TOPN(ROLLUP(IF ( Process_xLNPID_Layouts.HardKeyMatch(le) ,
    MERGE(
     SORTED(IF(le.FNAME <> (typeof(le.FNAME))'' AND le.LNAME <> (typeof(le.LNAME))'' AND le.ST <> (typeof(le.ST))'' AND le.C_LIC_NBR <> (typeof(le.C_LIC_NBR))'',Key_HealthProvider_NAMEL.ScoredLNPIDFetch(le.LNAME,le.ST,le.C_LIC_NBR,le.FNAME,le.GENDER,le.SNAME,le.MNAME,le.PRIM_RANGE,le.PRIM_NAME,le.SEC_RANGE,le.V_CITY_NAME,le.ZIP,(UNSIGNED4)le.DOB,le.LIC_STATE,le.NPI_NUMBER,le.BILLING_TAX_ID)),LNPID)
    ,SORTED(IF(~Key_HealthProvider_NAMEL.CanSearch(le),Key_HealthProvider_FNAME.ScoredLNPIDFetch(le.LNAME,le.ST,le.FNAME,le.GENDER,le.SNAME,le.MNAME,le.PRIM_RANGE,le.PRIM_NAME,le.SEC_RANGE,le.V_CITY_NAME,le.ZIP,(UNSIGNED4)le.DOB,le.C_LIC_NBR,le.LIC_STATE,le.NPI_NUMBER,le.BILLING_TAX_ID)),LNPID)
    ,SORTED(IF(~Key_HealthProvider_NAMEL.CanSearch(le),Key_HealthProvider_FNAME.ScoredLNPIDFetch(le.FNAME,le.ST,le.LNAME,le.GENDER,le.SNAME,le.MNAME,le.PRIM_RANGE,le.PRIM_NAME,le.SEC_RANGE,le.V_CITY_NAME,le.ZIP,(UNSIGNED4)le.DOB,le.C_LIC_NBR,le.LIC_STATE,le.NPI_NUMBER,le.BILLING_TAX_ID)),LNPID)		
    ,SORTED(IF(le.LNAME <> (typeof(le.LNAME))'' AND le.FNAME <> (typeof(le.FNAME))'' AND le.ZIP <> (typeof(le.ZIP))'' AND le.C_LIC_NBR <> (typeof(le.C_LIC_NBR))'',Key_HealthProvider_NAMED.ScoredLNPIDFetch(le.LNAME,le.ZIP,le.C_LIC_NBR,le.FNAME,le.GENDER,le.SNAME,le.MNAME,le.PRIM_RANGE,le.PRIM_NAME,le.SEC_RANGE,le.V_CITY_NAME,le.ST,(UNSIGNED4)le.DOB,le.LIC_STATE,le.NPI_NUMBER,le.BILLING_TAX_ID)),LNPID)
    ,SORTED(IF(~Key_HealthProvider_NAMED.CanSearch(le),Key_HealthProvider_LNAME.ScoredLNPIDFetch(le.LNAME,le.ZIP,le.FNAME,le.GENDER,le.SNAME,le.MNAME,le.PRIM_RANGE,le.PRIM_NAME,le.SEC_RANGE,le.V_CITY_NAME,le.ST,(UNSIGNED4)le.DOB,le.C_LIC_NBR,le.LIC_STATE,le.NPI_NUMBER,le.BILLING_TAX_ID)),LNPID)
    ,SORTED(IF(le.LNAME <> (typeof(le.LNAME))'' AND le.MNAME <> (typeof(le.MNAME))'' AND le.ST <> (typeof(le.ST))'',Key_HealthProvider_MNAME.ScoredLNPIDFetch(le.LNAME,le.MNAME,le.ST,le.GENDER,le.SNAME,le.FNAME,le.PRIM_RANGE,le.PRIM_NAME,le.SEC_RANGE,le.V_CITY_NAME,le.ZIP,(UNSIGNED4)le.DOB,le.C_LIC_NBR,le.LIC_STATE,le.NPI_NUMBER,le.BILLING_TAX_ID)),LNPID)
    ,SORTED(IF(le.LNAME <> (typeof(le.LNAME))'' AND le.MNAME <> (typeof(le.MNAME))'' AND le.ST <> (typeof(le.ST))'',Key_HealthProvider_MNAME.ScoredLNPIDFetch(le.LNAME,le.FNAME,le.ST,le.GENDER,le.SNAME,le.MNAME,le.PRIM_RANGE,le.PRIM_NAME,le.SEC_RANGE,le.V_CITY_NAME,le.ZIP,(UNSIGNED4)le.DOB,le.C_LIC_NBR,le.LIC_STATE,le.NPI_NUMBER,le.BILLING_TAX_ID)),LNPID)
    ,SORTED(IF(le.PRIM_RANGE <> (typeof(le.PRIM_RANGE))'' AND le.PRIM_NAME <> (typeof(le.PRIM_NAME))'' AND le.ZIP <> (typeof(le.ZIP))'',Key_HealthProvider_ADDRESS.ScoredLNPIDFetch(le.PRIM_RANGE,le.PRIM_NAME,le.ZIP,le.SEC_RANGE,le.FNAME,le.V_CITY_NAME,le.ST,le.GENDER,le.LNAME,le.MNAME,le.SNAME,(UNSIGNED4)le.DOB,le.C_LIC_NBR,le.LIC_STATE,le.BILLING_TAX_ID)),LNPID)
    ,SORTED(IF(le.PRIM_NAME <> (typeof(le.PRIM_NAME))'' AND le.ZIP <> (typeof(le.ZIP))'',Key_HealthProvider_ZIP_PR.ScoredLNPIDFetch(le.PRIM_NAME,le.ZIP,le.FNAME,le.PRIM_RANGE,le.SEC_RANGE,le.V_CITY_NAME,le.ST,le.GENDER,le.LNAME,le.MNAME,le.SNAME,(UNSIGNED4)le.DOB,le.C_LIC_NBR,le.LIC_STATE,le.BILLING_TAX_ID)),LNPID)
    ,SORTED(IF(le.SSN <> (typeof(le.SSN))'',Key_HealthProvider_SSN_LP.ScoredLNPIDFetch(le.SSN,le.FNAME,le.MNAME,le.LNAME,le.V_CITY_NAME,le.ST,le.GENDER,le.SNAME,(UNSIGNED4)le.DOB,le.C_LIC_NBR,le.LIC_STATE)),LNPID)
    ,SORTED(IF(le.CNSMR_SSN <> (typeof(le.CNSMR_SSN))'',Key_HealthProvider_CNSMR_SSN_LP.ScoredLNPIDFetch(le.CNSMR_SSN,le.FNAME,le.MNAME,le.LNAME,le.V_CITY_NAME,le.ST,le.GENDER,le.SNAME,(UNSIGNED4)le.CNSMR_DOB)),LNPID)
    ,SORTED(IF(le.DOB <> (typeof(le.DOB))'' AND le.FNAME <> (typeof(le.FNAME))'' AND le.LNAME <> (typeof(le.LNAME))'',Key_HealthProvider_DOB_LP.ScoredLNPIDFetch((UNSIGNED4)le.DOB,le.FNAME,le.LNAME,le.MNAME,le.ST,le.V_CITY_NAME,le.SSN,le.GENDER,le.SNAME)),LNPID)
    ,SORTED(IF(le.CNSMR_DOB <> (typeof(le.CNSMR_DOB))'' AND le.FNAME <> (typeof(le.FNAME))'' AND le.LNAME <> (typeof(le.LNAME))'',Key_HealthProvider_CNSMR_DOB_LP.ScoredLNPIDFetch((UNSIGNED4)le.CNSMR_DOB,le.FNAME,le.LNAME,le.MNAME,le.ST,le.V_CITY_NAME,le.CNSMR_SSN,le.GENDER,le.SNAME)),LNPID)
    ,SORTED(IF(le.PHONE <> (typeof(le.PHONE))'',Key_HealthProvider_PHONE_LP.ScoredLNPIDFetch(le.PHONE,le.FNAME,le.LNAME,(UNSIGNED4)le.DOB,le.MNAME,le.SNAME,le.V_CITY_NAME,le.ST,le.SSN)),LNPID)
    ,SORTED(IF(le.C_LIC_NBR <> (typeof(le.C_LIC_NBR))'' AND le.LIC_STATE <> (typeof(le.LIC_STATE))'',Key_HealthProvider_LIC.ScoredLNPIDFetch(le.C_LIC_NBR,le.LIC_STATE,le.FNAME,le.MNAME,le.LNAME,le.SSN,le.GENDER,le.SNAME,(UNSIGNED4)le.DOB)),LNPID)
    ,SORTED(IF(le.VENDOR_ID <> (typeof(le.VENDOR_ID))'' AND le.SRC <> (typeof(le.SRC))'',Key_HealthProvider_VEN.ScoredLNPIDFetch(le.VENDOR_ID,le.SRC,le.FNAME,le.MNAME,le.LNAME,le.SNAME,le.GENDER,(UNSIGNED4)le.DOB)),LNPID)
    ,SORTED(IF(le.TAX_ID <> (typeof(le.TAX_ID))'',Key_HealthProvider_TAX.ScoredLNPIDFetch(le.TAX_ID,le.FNAME,le.MNAME,le.LNAME,le.SNAME,le.GENDER,(UNSIGNED4)le.DOB,le.C_LIC_NBR,le.LIC_STATE)),LNPID)
    ,SORTED(IF(le.BILLING_TAX_ID <> (typeof(le.BILLING_TAX_ID))'',Key_HealthProvider_BILLING_TAX.ScoredLNPIDFetch(le.BILLING_TAX_ID,le.FNAME,le.MNAME,le.LNAME,le.SNAME,le.GENDER,(UNSIGNED4)le.DOB,le.C_LIC_NBR,le.LIC_STATE)),LNPID)
    ,SORTED(IF(le.DEA_NUMBER <> (typeof(le.DEA_NUMBER))'',Key_HealthProvider_DEA.ScoredLNPIDFetch(le.DEA_NUMBER,le.FNAME,le.MNAME,le.LNAME,le.SNAME,le.GENDER,(UNSIGNED4)le.DOB,le.C_LIC_NBR,le.LIC_STATE)),LNPID)
    ,SORTED(IF(le.NPI_NUMBER <> (typeof(le.NPI_NUMBER))'',Key_HealthProvider_NPI.ScoredLNPIDFetch(le.NPI_NUMBER,le.FNAME,le.MNAME,le.LNAME,le.SNAME,le.GENDER,(UNSIGNED4)le.DOB,le.C_LIC_NBR,le.LIC_STATE)),LNPID)
    ,SORTED(IF(le.BILLING_NPI_NUMBER <> (typeof(le.BILLING_NPI_NUMBER))'',Key_HealthProvider_BILLING_NPI.ScoredLNPIDFetch(le.BILLING_NPI_NUMBER,le.FNAME,le.MNAME,le.LNAME,le.SNAME,le.GENDER,(UNSIGNED4)le.DOB)),LNPID)
    ,SORTED(IF(le.UPIN <> (typeof(le.UPIN))'',Key_HealthProvider_UPN.ScoredLNPIDFetch(le.UPIN,le.FNAME,le.MNAME,le.LNAME,le.SNAME,le.GENDER,(UNSIGNED4)le.DOB,le.C_LIC_NBR,le.LIC_STATE)),LNPID)
    ,SORTED(IF(le.DID <> (typeof(le.DID))'',Key_HealthProvider_LEXID.ScoredLNPIDFetch(le.DID,le.FNAME,le.MNAME,le.LNAME,le.SNAME,le.GENDER,(UNSIGNED4)le.DOB,le.C_LIC_NBR,le.LIC_STATE)),LNPID)
    ,SORTED(IF(le.BDID <> (typeof(le.BDID))'',Key_HealthProvider_BID.ScoredLNPIDFetch(le.BDID,le.FNAME,le.MNAME,le.LNAME,le.SNAME,le.GENDER,(UNSIGNED4)le.DOB,le.C_LIC_NBR,le.LIC_STATE)),LNPID)
    ,SORTED(IF(le.SOURCE_RID <> (typeof(le.SOURCE_RID))'',Key_HealthProvider_SRC_RID.ScoredLNPIDFetch(le.SOURCE_RID,le.SRC,le.FNAME,le.LNAME,(UNSIGNED4)le.DOB,le.V_CITY_NAME,le.ST,le.GENDER,le.MNAME,le.SNAME)),LNPID)
    ,SORTED(IF(le.RID <> (typeof(le.RID))'',Key_HealthProvider_RID.ScoredLNPIDFetch(le.RID)),LNPID),SORTED(LNPID)) /* Merged */
    ,SORTED(Key_HealthProvider_.ScoredLNPIDFetch(le.FNAME,le.MNAME,le.LNAME,le.SNAME,le.GENDER,le.PRIM_RANGE,le.PRIM_NAME,le.SEC_RANGE,le.V_CITY_NAME,le.ST,le.ZIP,le.SSN,le.CNSMR_SSN,(UNSIGNED4)le.DOB,(UNSIGNED4)le.CNSMR_DOB,le.PHONE,le.LIC_STATE,le.C_LIC_NBR,le.TAX_ID,le.BILLING_TAX_ID,le.DEA_NUMBER,le.VENDOR_ID,le.NPI_NUMBER,le.BILLING_NPI_NUMBER,le.UPIN,le.DID,le.BDID,le.SRC,le.SOURCE_RID,le.RID,le.MAINNAME,le.FULLNAME,le.ADDR1,le.LOCALE,le.ADDRESS),LNPID)) /* IF */ 
    , RIGHT.LNPID > 0 AND LEFT.LNPID = RIGHT.LNPID, Process_xLNPID_Layouts.Combine_Scores(LEFT,RIGHT))(LNPID NOT IN ButNot),le.MaxIDs,-Weight)(SALT29.DebugMode OR ~ForceFailed OR ButNot<>[]); // Warning - is a fetch to keys etc
  Process_xLNPID_Layouts.MAC_Add_ResolutionFlags()
  SELF := le;
END;
  RR0 := PROJECT(in(Entered_LNPID=0),GetResults(left),PREFETCH(20,PARALLEL));
  Process_xLNPID_Layouts.OutputLayout rl(RR0 le,RR0 ri) := TRANSFORM
    SELF.keys_tried := le.keys_tried | ri.keys_tried; // If either tried it was tried
    SELF.Results := TOPN(ROLLUP( SORT( le.Results+ri.Results, LNPID )
    , RIGHT.LNPID > 0 AND LEFT.LNPID = RIGHT.LNPID, Process_xLNPID_Layouts.Combine_Scores(LEFT,RIGHT))(LNPID NOT IN ButNot),le.MaxIds,-Weight);
    SELF := le;
  END;
  RR1 := ROLLUP( SORT( RR0, UniqueId ), LEFT.UniqueId=RIGHT.UniqueId, rl(LEFT,RIGHT));
  RR2 := IF ( MultiRec, RR1, RR0 );
  Process_xLNPID_Layouts.OutputLayout PruneByLead(RR0 le) := TRANSFORM // Prune out the weak results if good ones exist
    SELF.Results := le.Results(weight >= MAX(le.Results,weight)-le.LeadThreshold);
    SELF := le;
  END;
  RR3 := RR2(LeadThreshold=0)+PROJECT(RR2(LeadThreshold<>0),PruneByLead(LEFT));
  SALT29.MAC_External_AddPcnt(RR3,Process_xLNPID_Layouts.LayoutScoredFetch,Results,Process_xLNPID_Layouts.OutputLayout,23,RR4);
EXPORT Raw_Results := IF(EXISTS(RR0),RR4);
// Pass-thru any records which already had the LNPID on them
  process_xLNPID_layouts.id_stream_layout ptt(in le) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.Weight := Config.MatchThreshold; // Assume at least 'threshold' met
    SELF.LNPID := le.Entered_LNPID;
  END;
  pass_thru := PROJECT(in(~(Entered_LNPID=0)),ptt(LEFT));
// Transform to process 'real' results
  process_xLNPID_layouts.id_stream_layout n(Raw_Results le,UNSIGNED c) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.KeysUsed := le.Results[c].keys_used;
    SELF.KeysFailed := le.Results[c].keys_failed;
    SELF := le.Results[c];
  END;
  EXPORT Uid_Results := NORMALIZE(Raw_Results,COUNT(LEFT.Results),n(LEFT,COUNTER))+pass_thru;
  EXPORT Fetch_Stream(DATASET(process_xLNPID_layouts.id_stream_layout) d) := FUNCTION
    k := Process_xLNPID_Layouts.Key;
    DLayout := RECORD
      process_xLNPID_layouts.id_stream_layout;
      BOOLEAN did_fetch;
      RECORDOF(k) AND NOT process_xLNPID_layouts.id_stream_layout; // No HEADERSEARCH specified 
    END;
    DLayout tr(Uid_Results le, k ri) := TRANSFORM
      SELF.did_fetch := ri.LNPID<>0;
      SELF.LNPID := IF ( SELF.did_fetch, ri.LNPID, le.LNPID ); // Copy from 'real data' if it exists
      SELF := ri;
      SELF := le;
    END;
    	RETURN JOIN( d,k,(LEFT.LNPID = RIGHT.LNPID),tr(LEFT,RIGHT), LEFT OUTER, KEEP(10000)); // Ignore excess records without erroring    
			END;
  EXPORT Raw_Data := Fetch_Stream(Uid_Results);
  // This macro can be used to score any data with field names matching the header standard to the input criteria
  EXPORT ScoreData(RD,Inv) := FUNCTIONMACRO
    Layout_Matched_Data := RECORD
      RD;
      BOOLEAN FullMatch_Required; // If the input enquiry is insisting upon full record match
      BOOLEAN Has_Fullmatch; // This UID has a fully matching record
      BOOLEAN RecordsOnly; // If the input enquiry only wants matching records returned
      BOOLEAN Is_Fullmatch; // This record matches completely
      INTEGER2 Record_Score; // Score for this particular record
      INTEGER2 Match_FNAME;
      INTEGER2 Match_MNAME;
      INTEGER2 Match_LNAME;
      INTEGER2 Match_SNAME;
      INTEGER2 Match_GENDER;
      INTEGER2 Match_PRIM_RANGE;
      INTEGER2 Match_PRIM_NAME;
      INTEGER2 Match_SEC_RANGE;
      INTEGER2 Match_V_CITY_NAME;
      INTEGER2 Match_ST;
      INTEGER2 Match_ZIP;
      INTEGER2 Match_SSN;
      INTEGER2 Match_CNSMR_SSN;
      INTEGER2 Match_DOB;
      INTEGER2 Match_CNSMR_DOB;
      INTEGER2 Match_PHONE;
      INTEGER2 Match_LIC_STATE;
      INTEGER2 Match_C_LIC_NBR;
      INTEGER2 Match_TAX_ID;
      INTEGER2 Match_BILLING_TAX_ID;
      INTEGER2 Match_DEA_NUMBER;
      INTEGER2 Match_VENDOR_ID;
      INTEGER2 Match_NPI_NUMBER;
      INTEGER2 Match_BILLING_NPI_NUMBER;
      INTEGER2 Match_UPIN;
      INTEGER2 Match_DID;
      INTEGER2 Match_BDID;
      INTEGER2 Match_SRC;
      INTEGER2 Match_SOURCE_RID;
      INTEGER2 Match_RID;
      INTEGER2 Match_MAINNAME;
      INTEGER2 Match_FULLNAME;
      INTEGER2 Match_ADDR1;
      INTEGER2 Match_LOCALE;
      INTEGER2 Match_ADDRESS;
    END;
    Layout_Matched_Data score_fields(RD le,Inv ri) := TRANSFORM
    SELF.Match_FNAME := MAP ( ri.FNAME = (typeof(ri.FNAME))'' => 0, le.FNAME = (typeof(ri.FNAME))'' => -1, ri.FNAME = le.FNAME => 2, SALT29.WithinEditN(le.FNAME,ri.FNAME,1, 0) => 1,metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(ri.FNAME) => 1,le.FNAME = ri.FNAME[length(trim(le.FNAME))] or ri.FNAME = le.FNAME[length(trim(ri.FNAME))] => 1,-2);
    SELF.Match_MNAME := MAP ( ri.MNAME = (typeof(ri.MNAME))'' => 0, le.MNAME = (typeof(ri.MNAME))'' => -1, ri.MNAME = le.MNAME => 2, SALT29.WithinEditN(le.MNAME,ri.MNAME,2, 0) => 1,le.MNAME = ri.MNAME[length(trim(le.MNAME))] or ri.MNAME = le.MNAME[length(trim(ri.MNAME))] => 1,-2);
    SELF.Match_LNAME := MAP ( ri.LNAME = (typeof(ri.LNAME))'' => 0, le.LNAME = (typeof(ri.LNAME))'' => -1, ri.LNAME = le.LNAME => 2, SALT29.WithinEditN(le.LNAME,ri.LNAME,1, 0) => 1,metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(ri.LNAME) => 1,-2);
    SELF.Match_SNAME := MAP ( ri.SNAME = (typeof(ri.SNAME))'' => 0, le.SNAME = (typeof(ri.SNAME))'' => -1, ri.SNAME = le.SNAME => 2,-2);
    SELF.Match_GENDER := MAP ( ri.GENDER = (typeof(ri.GENDER))'' => 0, le.GENDER = (typeof(ri.GENDER))'' => -1, ri.GENDER = le.GENDER => 2,-2);
    SELF.Match_PRIM_RANGE := MAP ( ri.PRIM_RANGE = (typeof(ri.PRIM_RANGE))'' => 0, le.PRIM_RANGE = (typeof(ri.PRIM_RANGE))'' => -1, ri.PRIM_RANGE = le.PRIM_RANGE => 2,-2);
    SELF.Match_PRIM_NAME := MAP ( ri.PRIM_NAME = (typeof(ri.PRIM_NAME))'' => 0, le.PRIM_NAME = (typeof(ri.PRIM_NAME))'' => -1, ri.PRIM_NAME = le.PRIM_NAME => 2,-2);
    SELF.Match_SEC_RANGE := MAP ( ri.SEC_RANGE = (typeof(ri.SEC_RANGE))'' => 0, le.SEC_RANGE = (typeof(ri.SEC_RANGE))'' => -1, ri.SEC_RANGE = le.SEC_RANGE => 2,-2);
    SELF.Match_V_CITY_NAME := MAP ( ri.V_CITY_NAME = (typeof(ri.V_CITY_NAME))'' => 0, le.V_CITY_NAME = (typeof(ri.V_CITY_NAME))'' => -1, ri.V_CITY_NAME = le.V_CITY_NAME => 2,-2);
    SELF.Match_ST := MAP ( ri.ST = (typeof(ri.ST))'' => 0, le.ST = (typeof(ri.ST))'' => -1, ri.ST = le.ST => 2,-2);
    SELF.Match_ZIP := MAP ( ri.ZIP = (typeof(ri.ZIP))'' => 0, le.ZIP = (typeof(ri.ZIP))'' => -1, ri.ZIP = le.ZIP => 2,-2);
    SELF.Match_SSN := MAP ( ri.SSN = (typeof(ri.SSN))'' => 0, le.SSN = (typeof(ri.SSN))'' => -1, ri.SSN = le.SSN => 2, SALT29.WithinEditN(le.SSN,ri.SSN,1, 0) => 1,-2);
    SELF.Match_CNSMR_SSN := MAP ( ri.CNSMR_SSN = (typeof(ri.CNSMR_SSN))'' => 0, le.CNSMR_SSN = (typeof(ri.CNSMR_SSN))'' => -1, ri.CNSMR_SSN = le.CNSMR_SSN => 2, SALT29.WithinEditN(le.CNSMR_SSN,ri.CNSMR_SSN,1, 0) => 1,-2);
    SELF.Match_DOB := SALT29.Fn_DobMatch_FuzzyScore((UNSIGNED)le.DOB,(UNSIGNED)ri.DOB);
    SELF.Match_CNSMR_DOB := SALT29.Fn_DobMatch_FuzzyScore((UNSIGNED)le.CNSMR_DOB,(UNSIGNED)ri.CNSMR_DOB);
    SELF.Match_PHONE := MAP ( ri.PHONE = (typeof(ri.PHONE))'' => 0, le.PHONE = (typeof(ri.PHONE))'' => -1, ri.PHONE = le.PHONE => 2,-2);
    SELF.Match_LIC_STATE := MAP ( ri.LIC_STATE = (typeof(ri.LIC_STATE))'' => 0, le.LIC_STATE = (typeof(ri.LIC_STATE))'' => -1, ri.LIC_STATE = le.LIC_STATE => 2,-2);
    SELF.Match_C_LIC_NBR := MAP ( ri.C_LIC_NBR = (typeof(ri.C_LIC_NBR))'' => 0, le.C_LIC_NBR = (typeof(ri.C_LIC_NBR))'' => -1, ri.C_LIC_NBR = le.C_LIC_NBR => 2, SALT29.WithinEditN(le.C_LIC_NBR,ri.C_LIC_NBR,1, 0) => 1,-2);
    SELF.Match_TAX_ID := MAP ( ri.TAX_ID = (typeof(ri.TAX_ID))'' => 0, le.TAX_ID = (typeof(ri.TAX_ID))'' => -1, ri.TAX_ID = le.TAX_ID => 2,-2);
    SELF.Match_BILLING_TAX_ID := MAP ( ri.BILLING_TAX_ID = (typeof(ri.BILLING_TAX_ID))'' => 0, le.BILLING_TAX_ID = (typeof(ri.BILLING_TAX_ID))'' => -1, ri.BILLING_TAX_ID = le.BILLING_TAX_ID => 2,-2);
    SELF.Match_DEA_NUMBER := MAP ( ri.DEA_NUMBER = (typeof(ri.DEA_NUMBER))'' => 0, le.DEA_NUMBER = (typeof(ri.DEA_NUMBER))'' => -1, ri.DEA_NUMBER = le.DEA_NUMBER => 2,-2);
    SELF.Match_VENDOR_ID := MAP ( ri.VENDOR_ID = (typeof(ri.VENDOR_ID))'' => 0, le.VENDOR_ID = (typeof(ri.VENDOR_ID))'' => -1, ri.VENDOR_ID = le.VENDOR_ID => 2,-2);
    SELF.Match_NPI_NUMBER := MAP ( ri.NPI_NUMBER = (typeof(ri.NPI_NUMBER))'' => 0, le.NPI_NUMBER = (typeof(ri.NPI_NUMBER))'' => -1, ri.NPI_NUMBER = le.NPI_NUMBER => 2,-2);
    SELF.Match_BILLING_NPI_NUMBER := MAP ( ri.BILLING_NPI_NUMBER = (typeof(ri.BILLING_NPI_NUMBER))'' => 0, le.BILLING_NPI_NUMBER = (typeof(ri.BILLING_NPI_NUMBER))'' => -1, ri.BILLING_NPI_NUMBER = le.BILLING_NPI_NUMBER => 2,-2);
    SELF.Match_UPIN := MAP ( ri.UPIN = (typeof(ri.UPIN))'' => 0, le.UPIN = (typeof(ri.UPIN))'' => -1, ri.UPIN = le.UPIN => 2,-2);
    SELF.Match_DID := MAP ( ri.DID = (typeof(ri.DID))'' => 0, le.DID = (typeof(ri.DID))'' => -1, ri.DID = le.DID => 2,-2);
    SELF.Match_BDID := MAP ( ri.BDID = (typeof(ri.BDID))'' => 0, le.BDID = (typeof(ri.BDID))'' => -1, ri.BDID = le.BDID => 2,-2);
    SELF.Match_SRC := MAP ( ri.SRC = (typeof(ri.SRC))'' => 0, le.SRC = (typeof(ri.SRC))'' => -1, ri.SRC = le.SRC => 2,-2);
    SELF.Match_SOURCE_RID := MAP ( ri.SOURCE_RID = (typeof(ri.SOURCE_RID))'' => 0, le.SOURCE_RID = (typeof(ri.SOURCE_RID))'' => -1, ri.SOURCE_RID = le.SOURCE_RID => 2,-2);
    SELF.Match_RID := MAP ( ri.RID = (typeof(ri.RID))'' => 0, le.RID = (typeof(ri.RID))'' => -1, ri.RID = le.RID => 2,-2);
    ri_MAINNAME := SALT29.Fn_WordBag_AppendSpecs_Fake((SALT29.StrType)ri.MAINNAME);//For later scoring
    le_MAINNAME := SALT29.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT29.StrType)le.FNAME) + ' ' + TRIM((SALT29.StrType)le.MNAME) + ' ' + TRIM((SALT29.StrType)le.LNAME));//For later scoring
    SELF.Match_MAINNAME := MAP ( ri.MAINNAME = (typeof(ri.MAINNAME))'' => 0, le_MAINNAME = (typeof(ri.MAINNAME))'' => -1, ri_MAINNAME = le_MAINNAME => 2,SALT29.MatchBagOfWords(le_MAINNAME,ri_MAINNAME,31744,1) > Config.MAINNAME_Force * 100 => 1, -2);
    ri_FULLNAME := SALT29.Fn_WordBag_AppendSpecs_Fake((SALT29.StrType)ri.FULLNAME);//For later scoring
    le_FULLNAME := SALT29.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT29.StrType)le.FNAME) + ' ' + TRIM((SALT29.StrType)le.MNAME) + ' ' + TRIM((SALT29.StrType)le.LNAME) + ' ' + TRIM((SALT29.StrType)le.SNAME));//For later scoring
    SELF.Match_FULLNAME := MAP ( ri.FULLNAME = (typeof(ri.FULLNAME))'' => 0, le_FULLNAME = (typeof(ri.FULLNAME))'' => -1, ri_FULLNAME = le_FULLNAME => 2, -2);
    ri_ADDR1 := SALT29.Fn_WordBag_AppendSpecs_Fake((SALT29.StrType)ri.ADDR1);//For later scoring
    le_ADDR1 := SALT29.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT29.StrType)le.PRIM_NAME) + ' ' + TRIM((SALT29.StrType)le.PRIM_RANGE) + ' ' + TRIM((SALT29.StrType)le.SEC_RANGE));//For later scoring
    SELF.Match_ADDR1 := MAP ( ri.ADDR1 = (typeof(ri.ADDR1))'' => 0, le_ADDR1 = (typeof(ri.ADDR1))'' => -1, ri_ADDR1 = le_ADDR1 => 2, -2);
    ri_LOCALE := SALT29.Fn_WordBag_AppendSpecs_Fake((SALT29.StrType)ri.LOCALE);//For later scoring
    le_LOCALE := SALT29.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT29.StrType)le.V_CITY_NAME) + ' ' + TRIM((SALT29.StrType)le.ST) + ' ' + TRIM((SALT29.StrType)le.ZIP));//For later scoring
    SELF.Match_LOCALE := MAP ( ri.LOCALE = (typeof(ri.LOCALE))'' => 0, le_LOCALE = (typeof(ri.LOCALE))'' => -1, ri_LOCALE = le_LOCALE => 2, -2);
    ri_ADDRESS := SALT29.Fn_WordBag_AppendSpecs_Fake((SALT29.StrType)ri.ADDRESS);//For later scoring
    le_ADDRESS := SALT29.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT29.StrType)le.PRIM_NAME) + ' ' + TRIM((SALT29.StrType)le.PRIM_RANGE) + ' ' + TRIM((SALT29.StrType)le.SEC_RANGE) + ' ' + TRIM((SALT29.StrType)le.V_CITY_NAME) + ' ' + TRIM((SALT29.StrType)le.ST) + ' ' + TRIM((SALT29.StrType)le.ZIP));//For later scoring
    SELF.Match_ADDRESS := MAP ( ri.ADDRESS = (typeof(ri.ADDRESS))'' => 0, le_ADDRESS = (typeof(ri.ADDRESS))'' => -1, ri_ADDRESS = le_ADDRESS => 2, -2);
      SELF.Record_Score := SELF.Match_FNAME + SELF.Match_MNAME + SELF.Match_LNAME + SELF.Match_SNAME + SELF.Match_GENDER + SELF.Match_PRIM_RANGE + SELF.Match_PRIM_NAME + SELF.Match_SEC_RANGE + SELF.Match_V_CITY_NAME + SELF.Match_ST + SELF.Match_ZIP + SELF.Match_SSN + SELF.Match_CNSMR_SSN + SELF.Match_DOB + SELF.Match_CNSMR_DOB + SELF.Match_PHONE + SELF.Match_LIC_STATE + SELF.Match_C_LIC_NBR + SELF.Match_TAX_ID + SELF.Match_BILLING_TAX_ID + SELF.Match_DEA_NUMBER + SELF.Match_VENDOR_ID + SELF.Match_NPI_NUMBER + SELF.Match_BILLING_NPI_NUMBER + SELF.Match_UPIN + SELF.Match_DID + SELF.Match_BDID + SELF.Match_SRC + SELF.Match_SOURCE_RID + SELF.Match_RID + SELF.Match_MAINNAME + SELF.Match_FULLNAME + SELF.Match_ADDR1 + SELF.Match_LOCALE + SELF.Match_ADDRESS;
      SELF.Is_FullMatch := SELF.Match_FNAME>=0 AND SELF.Match_MNAME>=0 AND SELF.Match_LNAME>=0 AND SELF.Match_SNAME>=0 AND SELF.Match_GENDER>=0 AND SELF.Match_PRIM_RANGE>=0 AND SELF.Match_PRIM_NAME>=0 AND SELF.Match_SEC_RANGE>=0 AND SELF.Match_V_CITY_NAME>=0 AND SELF.Match_ST>=0 AND SELF.Match_ZIP>=0 AND SELF.Match_SSN>=0 AND SELF.Match_CNSMR_SSN>=0 AND SELF.Match_DOB>=0 AND SELF.Match_CNSMR_DOB>=0 AND SELF.Match_PHONE>=0 AND SELF.Match_LIC_STATE>=0 AND SELF.Match_C_LIC_NBR>=0 AND SELF.Match_TAX_ID>=0 AND SELF.Match_BILLING_TAX_ID>=0 AND SELF.Match_DEA_NUMBER>=0 AND SELF.Match_VENDOR_ID>=0 AND SELF.Match_NPI_NUMBER>=0 AND SELF.Match_BILLING_NPI_NUMBER>=0 AND SELF.Match_UPIN>=0 AND SELF.Match_DID>=0 AND SELF.Match_BDID>=0 AND SELF.Match_SRC>=0 AND SELF.Match_SOURCE_RID>=0 AND SELF.Match_RID>=0 AND SELF.Match_MAINNAME>=0 AND SELF.Match_FULLNAME>=0 AND SELF.Match_ADDR1>=0 AND SELF.Match_LOCALE>=0 AND SELF.Match_ADDRESS>=0;
      SELF.Has_FullMatch := SELF.Is_FullMatch; // Filled in later using iterate
      SELF.FullMatch_Required := ri.FullMatch;
      SELF.RecordsOnly := ri.MatchRecords;
      SELF := le;
    END;
    ScoredData := JOIN(RD,Inv,LEFT.UniqueId=RIGHT.UniqueId,score_fields(LEFT,RIGHT));
    Layout_Matched_Data prop_full(ScoredData le,ScoredData ri) := TRANSFORM
  	  SELF.Has_FullMatch := ri.Has_FullMatch OR le.Has_FullMatch AND le.LNPID=ri.LNPID AND le.UniqueId=ri.UniqueId;
      SELF := ri;
    END;
    RETURN ITERATE( SORT( ScoredData,UniqueId,-Has_FullMatch ),prop_full(LEFT,RIGHT) );
  ENDMACRO;
  i := ScoreData(Raw_Data,In);
  // Now narrow down to the required records - note this can be switched per UniqueId
  i1 := i(Has_FullMatch OR ~FullMatch_Required,~RecordsOnly OR Is_FullMatch OR ~FullMatch_Required AND Record_Score>0);
  W1 := IF ( i1.RecordsOnly,i1.Record_Score,i1.Weight );
  EXPORT Data_ := DEDUP(SORT(i1,UniqueId,-W1,LNPID,-(Record_Score+Weight-W1)),WHOLE RECORD);
  // Now create 'data bombs' suitable for a remote deep dive search
  // We might want to reduce the number of results 'cleverly' over time - for now slap it all in there
  Process_xLNPID_Layouts.InputLayout tr(Raw_Data le) := TRANSFORM
    SELF.Entered_LNPID := 0; // Blank out the specific IDs
    SELF := le;
    SELF.LeadThreshold := 0;
    SELF.MaxIds := 50;
    SELF := []
;  END;
// If there are any simple prop fields; they can be applied here
  DSAfter_MNAME := SALT29.MAC_Field_Prop_Do(Raw_Data,MNAME,LNPID);
  DSAfter_SNAME := SALT29.MAC_Field_Prop_Do(DSAfter_MNAME,SNAME,LNPID);
  DSAfter_SSN := SALT29.MAC_Field_Prop_Do(DSAfter_SNAME,SSN,LNPID);
  DSAfter_CNSMR_SSN := SALT29.MAC_Field_Prop_Do(DSAfter_SSN,CNSMR_SSN,LNPID);
  DSAfter_DOB := SALT29.MAC_Field_Prop_Do(DSAfter_CNSMR_SSN,DOB,LNPID);
  DSAfter_CNSMR_DOB := SALT29.MAC_Field_Prop_Do(DSAfter_DOB,CNSMR_DOB,LNPID);
  DSAfter_C_LIC_NBR := SALT29.MAC_Field_Prop_Do(DSAfter_CNSMR_DOB,C_LIC_NBR,LNPID);
  DSAfter_BILLING_TAX_ID := SALT29.MAC_Field_Prop_Do(DSAfter_C_LIC_NBR,BILLING_TAX_ID,LNPID);
  DSAfter_DEA_NUMBER := SALT29.MAC_Field_Prop_Do(DSAfter_BILLING_TAX_ID,DEA_NUMBER,LNPID);
  DSAfter_NPI_NUMBER := SALT29.MAC_Field_Prop_Do(DSAfter_DEA_NUMBER,NPI_NUMBER,LNPID);
  DSAfter_UPIN := SALT29.MAC_Field_Prop_Do(DSAfter_NPI_NUMBER,UPIN,LNPID);
  DSAfter_SRC := SALT29.MAC_Field_Prop_Do(DSAfter_UPIN,SRC,LNPID);
  ds := PROJECT(DSAfter_SRC,tr(LEFT));
  EXPORT DataToSearch := DEDUP(ds,WHOLE RECORD,ALL);
END;
