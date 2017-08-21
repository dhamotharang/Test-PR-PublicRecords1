IMPORT ut,SALT29;
// @param MultiRec - if set to true then multiple records may have the same Reference and a consolidated result will be produced
// @param ButNot - set of IDs that will NOT be considered as part of the result
EXPORT MEOW_xLNPID(DATASET(Process_xLNPID_Layouts.InputLayout) in, BOOLEAN MultiRec = FALSE,SET OF SALT29.UIDType ButNot=[]) := MODULE
Process_xLNPID_Layouts.OutputLayout GetResults(Process_xLNPID_Layouts.InputLayout le) := TRANSFORM
// Need to annotate wordbags with specificities
  SALT29.mac_wordbag_appendspecs_rx(le.CNP_NAME,Specificities(File_HealthFacility).CNP_NAME_values_key,CNP_NAME,CNP_NAME_spec)
  FAC_NAME_spec := le.FAC_NAME; //Concept wordbags not in regular linkpaths yet
  ADDR1_spec := le.ADDR1; //Concept wordbags not in regular linkpaths yet
  LOCALE_spec := le.LOCALE; //Concept wordbags not in regular linkpaths yet
  ADDRES_spec := le.ADDRES; //Concept wordbags not in regular linkpaths yet
  SELF.keys_tried := IF (Key_HealthFacility_ZBNAME.CanSearch(le),1 << 1,0) + IF (Key_HealthFacility_BNAME.CanSearch(le),1 << 2,0) + IF (Key_HealthFacility_SBNAME.CanSearch(le),1 << 3,0) + IF (Key_HealthFacility_ADDRESS.CanSearch(le),1 << 4,0) + IF (Key_HealthFacility_ZIP_LP.CanSearch(le),1 << 5,0) + IF (Key_HealthFacility_CITY_LP.CanSearch(le),1 << 6,0) + IF (Key_HealthFacility_PHONE_LP.CanSearch(le),1 << 7,0) + IF (Key_HealthFacility_FAX_LP.CanSearch(le),1 << 8,0) + IF (Key_HealthFacility_LIC.CanSearch(le),1 << 9,0) + IF (Key_HealthFacility_VEN.CanSearch(le),1 << 10,0) + IF (Key_HealthFacility_TAX.CanSearch(le),1 << 11,0) + IF (Key_HealthFacility_FEN.CanSearch(le),1 << 12,0) + IF (Key_HealthFacility_DEA.CanSearch(le),1 << 13,0) + IF (Key_HealthFacility_NPI.CanSearch(le),1 << 14,0) + IF (Key_HealthFacility_ADDR_NPI.CanSearch(le),1 << 15,0) + IF (Key_HealthFacility_CLIA.CanSearch(le),1 << 16,0) + IF (Key_HealthFacility_MEDICARE.CanSearch(le),1 << 17,0) + IF (Key_HealthFacility_MEDICAID.CanSearch(le),1 << 18,0) + IF (Key_HealthFacility_NCPDP.CanSearch(le),1 << 19,0) + IF (Key_HealthFacility_BID.CanSearch(le),1 << 20,0);
  SELF.Results := TOPN(ROLLUP(IF ( Process_xLNPID_Layouts.HardKeyMatch(le) ,
    MERGE(
    SORTED(Key_HealthFacility_ZBNAME.ScoredLNPIDFetch(CNP_NAME_spec,le.ZIP,le.PRIM_NAME,le.ST,le.V_CITY_NAME,le.CNP_NUMBER,le.CNP_STORE_NUMBER,le.CNP_BTYPE,le.CNP_LOWV,le.PRIM_RANGE,le.SEC_RANGE,le.TAXONOMY,le.TAXONOMY_CODE),LNPID)
    ,SORTED(IF(~Key_HealthFacility_ZBNAME.CanSearch(le),Key_HealthFacility_BNAME.ScoredLNPIDFetch(CNP_NAME_spec,le.PRIM_NAME,le.ST,le.V_CITY_NAME,le.CNP_NUMBER,le.CNP_STORE_NUMBER,le.CNP_BTYPE,le.CNP_LOWV,le.PRIM_RANGE,le.SEC_RANGE,le.ZIP,le.TAXONOMY,le.TAXONOMY_CODE)),LNPID)
    ,SORTED(Key_HealthFacility_SBNAME.ScoredLNPIDFetch(CNP_NAME_spec,le.ST,le.PRIM_NAME,le.ZIP,le.V_CITY_NAME,le.CNP_NUMBER,le.CNP_STORE_NUMBER,le.CNP_BTYPE,le.CNP_LOWV,le.PRIM_RANGE,le.SEC_RANGE,le.TAXONOMY,le.TAXONOMY_CODE),LNPID)
    ,SORTED(Key_HealthFacility_ADDRESS.ScoredLNPIDFetch(le.PRIM_NAME,le.PRIM_RANGE,le.ZIP,le.V_CITY_NAME,le.ST,le.SEC_RANGE,CNP_NAME_spec,le.CNP_NUMBER,le.CNP_STORE_NUMBER,le.CNP_BTYPE,le.CNP_LOWV,le.TAXONOMY,le.TAXONOMY_CODE),LNPID)
    ,SORTED(Key_HealthFacility_ZIP_LP.ScoredLNPIDFetch(le.PRIM_NAME,le.ZIP,le.PRIM_RANGE,le.ST,le.SEC_RANGE,le.V_CITY_NAME,CNP_NAME_spec,le.CNP_NUMBER,le.CNP_STORE_NUMBER,le.CNP_BTYPE,le.CNP_LOWV,le.TAXONOMY,le.TAXONOMY_CODE),LNPID)
    ,SORTED(Key_HealthFacility_CITY_LP.ScoredLNPIDFetch(le.PRIM_NAME,le.V_CITY_NAME,le.ST,le.PRIM_RANGE,le.ZIP,le.SEC_RANGE,CNP_NAME_spec,le.CNP_NUMBER,le.CNP_STORE_NUMBER,le.CNP_BTYPE,le.CNP_LOWV,le.TAXONOMY,le.TAXONOMY_CODE),LNPID)
    ,SORTED(Key_HealthFacility_PHONE_LP.ScoredLNPIDFetch(le.PHONE,CNP_NAME_spec,le.CNP_NUMBER,le.CNP_STORE_NUMBER,le.CNP_BTYPE,le.CNP_LOWV,le.PRIM_RANGE,le.SEC_RANGE,le.PRIM_NAME,le.V_CITY_NAME,le.ST,le.ZIP,le.TAXONOMY,le.TAXONOMY_CODE),LNPID)
    ,SORTED(Key_HealthFacility_FAX_LP.ScoredLNPIDFetch(le.FAX,CNP_NAME_spec,le.CNP_NUMBER,le.CNP_STORE_NUMBER,le.CNP_BTYPE,le.CNP_LOWV,le.PRIM_RANGE,le.SEC_RANGE,le.PRIM_NAME,le.V_CITY_NAME,le.ST,le.ZIP,le.TAXONOMY,le.TAXONOMY_CODE),LNPID)
    ,SORTED(Key_HealthFacility_LIC.ScoredLNPIDFetch(le.C_LIC_NBR,le.LIC_STATE,CNP_NAME_spec,le.CNP_NUMBER,le.CNP_STORE_NUMBER,le.CNP_BTYPE,le.CNP_LOWV,le.PRIM_RANGE,le.SEC_RANGE,le.PRIM_NAME,le.V_CITY_NAME,le.ST,le.ZIP,le.TAXONOMY,le.TAXONOMY_CODE),LNPID)
    ,SORTED(Key_HealthFacility_VEN.ScoredLNPIDFetch(le.VENDOR_ID,le.SRC,CNP_NAME_spec,le.CNP_NUMBER,le.CNP_STORE_NUMBER,le.CNP_BTYPE,le.CNP_LOWV,le.PRIM_RANGE,le.SEC_RANGE,le.PRIM_NAME,le.V_CITY_NAME,le.ST,le.ZIP,le.TAXONOMY,le.TAXONOMY_CODE),LNPID)
    ,SORTED(Key_HealthFacility_TAX.ScoredLNPIDFetch(le.TAX_ID,CNP_NAME_spec,le.CNP_NUMBER,le.CNP_STORE_NUMBER,le.CNP_BTYPE,le.CNP_LOWV,le.PRIM_RANGE,le.SEC_RANGE,le.PRIM_NAME,le.V_CITY_NAME,le.ST,le.ZIP,le.TAXONOMY,le.TAXONOMY_CODE),LNPID)
    ,SORTED(Key_HealthFacility_FEN.ScoredLNPIDFetch(le.FEIN,CNP_NAME_spec,le.CNP_NUMBER,le.CNP_STORE_NUMBER,le.CNP_BTYPE,le.CNP_LOWV,le.PRIM_RANGE,le.SEC_RANGE,le.PRIM_NAME,le.V_CITY_NAME,le.ST,le.ZIP,le.TAXONOMY,le.TAXONOMY_CODE),LNPID)
    ,SORTED(Key_HealthFacility_DEA.ScoredLNPIDFetch(le.DEA_NUMBER,CNP_NAME_spec,le.CNP_NUMBER,le.CNP_STORE_NUMBER,le.CNP_BTYPE,le.CNP_LOWV,le.PRIM_RANGE,le.SEC_RANGE,le.PRIM_NAME,le.V_CITY_NAME,le.ST,le.ZIP,le.TAXONOMY,le.TAXONOMY_CODE),LNPID)
    ,SORTED(Key_HealthFacility_NPI.ScoredLNPIDFetch(le.NPI_NUMBER,CNP_NAME_spec,le.CNP_NUMBER,le.CNP_STORE_NUMBER,le.CNP_BTYPE,le.CNP_LOWV,le.PRIM_RANGE,le.SEC_RANGE,le.PRIM_NAME,le.V_CITY_NAME,le.ST,le.ZIP,le.TAXONOMY,le.TAXONOMY_CODE),LNPID)
    ,SORTED(Key_HealthFacility_ADDR_NPI.ScoredLNPIDFetch(le.NPI_NUMBER,le.ST,le.PRIM_RANGE,le.SEC_RANGE,le.PRIM_NAME,le.ZIP,le.V_CITY_NAME,CNP_NAME_spec,le.CNP_NUMBER,le.CNP_STORE_NUMBER,le.CNP_BTYPE,le.CNP_LOWV,le.TAXONOMY,le.TAXONOMY_CODE),LNPID)
    ,SORTED(Key_HealthFacility_CLIA.ScoredLNPIDFetch(le.CLIA_NUMBER,CNP_NAME_spec,le.CNP_NUMBER,le.CNP_STORE_NUMBER,le.CNP_BTYPE,le.CNP_LOWV,le.PRIM_RANGE,le.SEC_RANGE,le.PRIM_NAME,le.V_CITY_NAME,le.ST,le.ZIP,le.TAXONOMY,le.TAXONOMY_CODE),LNPID)
    ,SORTED(Key_HealthFacility_MEDICARE.ScoredLNPIDFetch(le.MEDICARE_FACILITY_NUMBER,CNP_NAME_spec,le.CNP_NUMBER,le.CNP_STORE_NUMBER,le.CNP_BTYPE,le.CNP_LOWV,le.PRIM_RANGE,le.SEC_RANGE,le.PRIM_NAME,le.V_CITY_NAME,le.ST,le.ZIP,le.TAXONOMY,le.TAXONOMY_CODE),LNPID)
    ,SORTED(Key_HealthFacility_MEDICAID.ScoredLNPIDFetch(le.MEDICAID_NUMBER,CNP_NAME_spec,le.CNP_NUMBER,le.CNP_STORE_NUMBER,le.CNP_BTYPE,le.CNP_LOWV,le.PRIM_RANGE,le.SEC_RANGE,le.PRIM_NAME,le.V_CITY_NAME,le.ST,le.ZIP,le.TAXONOMY,le.TAXONOMY_CODE),LNPID)
    ,SORTED(Key_HealthFacility_NCPDP.ScoredLNPIDFetch(le.NCPDP_NUMBER,CNP_NAME_spec,le.CNP_NUMBER,le.CNP_STORE_NUMBER,le.CNP_BTYPE,le.CNP_LOWV,le.PRIM_RANGE,le.SEC_RANGE,le.PRIM_NAME,le.V_CITY_NAME,le.ST,le.ZIP,le.TAXONOMY,le.TAXONOMY_CODE),LNPID)
    ,SORTED(Key_HealthFacility_BID.ScoredLNPIDFetch(le.BDID,CNP_NAME_spec,le.CNP_NUMBER,le.CNP_STORE_NUMBER,le.CNP_BTYPE,le.CNP_LOWV,le.PRIM_RANGE,le.SEC_RANGE,le.PRIM_NAME,le.V_CITY_NAME,le.ST,le.ZIP,le.TAXONOMY,le.TAXONOMY_CODE),LNPID),SORTED(LNPID)) /* Merged */
    ,SORTED(Key_HealthFacility_.ScoredLNPIDFetch(le.CNAME,CNP_NAME_spec,le.CNP_NUMBER,le.CNP_STORE_NUMBER,le.CNP_BTYPE,le.CNP_LOWV,le.PRIM_RANGE,le.PRIM_NAME,le.SEC_RANGE,le.V_CITY_NAME,le.ST,le.ZIP,le.TAX_ID,le.FEIN,le.PHONE,le.FAX,le.LIC_STATE,le.C_LIC_NBR,le.DEA_NUMBER,le.VENDOR_ID,le.NPI_NUMBER,le.CLIA_NUMBER,le.MEDICARE_FACILITY_NUMBER,le.MEDICAID_NUMBER,le.NCPDP_NUMBER,le.TAXONOMY,le.TAXONOMY_CODE,le.BDID,le.SRC,le.SOURCE_RID,le.FAC_NAME,le.ADDR1,le.LOCALE,le.ADDRES),LNPID)) /* IF */ 
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
  SALT29.MAC_External_AddPcnt(RR3,Process_xLNPID_Layouts.LayoutScoredFetch,Results,Process_xLNPID_Layouts.OutputLayout,20,RR4);
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
      INTEGER2 Match_CNAME;
      INTEGER2 Match_CNP_NAME;
      INTEGER2 Match_CNP_NUMBER;
      INTEGER2 Match_CNP_STORE_NUMBER;
      INTEGER2 Match_CNP_BTYPE;
      INTEGER2 Match_CNP_LOWV;
      INTEGER2 Match_PRIM_RANGE;
      INTEGER2 Match_PRIM_NAME;
      INTEGER2 Match_SEC_RANGE;
      INTEGER2 Match_V_CITY_NAME;
      INTEGER2 Match_ST;
      INTEGER2 Match_ZIP;
      INTEGER2 Match_TAX_ID;
      INTEGER2 Match_FEIN;
      INTEGER2 Match_PHONE;
      INTEGER2 Match_FAX;
      INTEGER2 Match_LIC_STATE;
      INTEGER2 Match_C_LIC_NBR;
      INTEGER2 Match_DEA_NUMBER;
      INTEGER2 Match_VENDOR_ID;
      INTEGER2 Match_NPI_NUMBER;
      INTEGER2 Match_CLIA_NUMBER;
      INTEGER2 Match_MEDICARE_FACILITY_NUMBER;
      INTEGER2 Match_MEDICAID_NUMBER;
      INTEGER2 Match_NCPDP_NUMBER;
      INTEGER2 Match_TAXONOMY;
      INTEGER2 Match_TAXONOMY_CODE;
      INTEGER2 Match_BDID;
      INTEGER2 Match_SRC;
      INTEGER2 Match_SOURCE_RID;
      INTEGER2 Match_FAC_NAME;
      INTEGER2 Match_ADDR1;
      INTEGER2 Match_LOCALE;
      INTEGER2 Match_ADDRES;
    END;
    Layout_Matched_Data score_fields(RD le,Inv ri) := TRANSFORM
    SELF.Match_CNAME := MAP ( ri.CNAME = (typeof(ri.CNAME))'' => 0, le.CNAME = (typeof(ri.CNAME))'' => -1, ri.CNAME = le.CNAME => 2,-2);
    le_CNP_NAME := SALT29.Fn_WordBag_AppendSpecs_Fake((SALT29.StrType)le.CNP_NAME);//For later scoring
    ri_CNP_NAME := SALT29.Fn_WordBag_AppendSpecs_Fake((SALT29.StrType)ri.CNP_NAME);//For later scoring
    SELF.Match_CNP_NAME := MAP ( ri.CNP_NAME = (typeof(ri.CNP_NAME))'' => 0, le.CNP_NAME = (typeof(ri.CNP_NAME))'' => -1, ri.CNP_NAME = le.CNP_NAME => 2,SALT29.MatchBagOfWords(le_CNP_NAME,ri_CNP_NAME,3407639,0) > Config.CNP_NAME_Force * 100 => 1,-2);
    SELF.Match_CNP_NUMBER := MAP ( ri.CNP_NUMBER = (typeof(ri.CNP_NUMBER))'' => 0, le.CNP_NUMBER = (typeof(ri.CNP_NUMBER))'' => -1, ri.CNP_NUMBER = le.CNP_NUMBER => 2,-2);
    SELF.Match_CNP_STORE_NUMBER := MAP ( ri.CNP_STORE_NUMBER = (typeof(ri.CNP_STORE_NUMBER))'' => 0, le.CNP_STORE_NUMBER = (typeof(ri.CNP_STORE_NUMBER))'' => -1, ri.CNP_STORE_NUMBER = le.CNP_STORE_NUMBER => 2,-2);
    SELF.Match_CNP_BTYPE := MAP ( ri.CNP_BTYPE = (typeof(ri.CNP_BTYPE))'' => 0, le.CNP_BTYPE = (typeof(ri.CNP_BTYPE))'' => -1, ri.CNP_BTYPE = le.CNP_BTYPE => 2,-2);
    SELF.Match_CNP_LOWV := MAP ( ri.CNP_LOWV = (typeof(ri.CNP_LOWV))'' => 0, le.CNP_LOWV = (typeof(ri.CNP_LOWV))'' => -1, ri.CNP_LOWV = le.CNP_LOWV => 2,-2);
    SELF.Match_PRIM_RANGE := MAP ( ri.PRIM_RANGE = (typeof(ri.PRIM_RANGE))'' => 0, le.PRIM_RANGE = (typeof(ri.PRIM_RANGE))'' => -1, ri.PRIM_RANGE = le.PRIM_RANGE => 2, SALT29.WithinEditN(le.PRIM_RANGE,ri.PRIM_RANGE,1, 0) => 1,-2);
    SELF.Match_PRIM_NAME := MAP ( ri.PRIM_NAME = (typeof(ri.PRIM_NAME))'' => 0, le.PRIM_NAME = (typeof(ri.PRIM_NAME))'' => -1, ri.PRIM_NAME = le.PRIM_NAME => 2, SALT29.WithinEditN(le.PRIM_NAME,ri.PRIM_NAME,1, 0) => 1,-2);
    SELF.Match_SEC_RANGE := MAP ( ri.SEC_RANGE = (typeof(ri.SEC_RANGE))'' => 0, le.SEC_RANGE = (typeof(ri.SEC_RANGE))'' => -1, ri.SEC_RANGE = le.SEC_RANGE => 2,-2);
    SELF.Match_V_CITY_NAME := MAP ( ri.V_CITY_NAME = (typeof(ri.V_CITY_NAME))'' => 0, le.V_CITY_NAME = (typeof(ri.V_CITY_NAME))'' => -1, ri.V_CITY_NAME = le.V_CITY_NAME => 2, SALT29.WithinEditN(le.V_CITY_NAME,ri.V_CITY_NAME,2, 0) => 1,metaphonelib.DMetaPhone1(le.V_CITY_NAME)=metaphonelib.DMetaPhone1(ri.V_CITY_NAME) => 1,-2);
    SELF.Match_ST := MAP ( ri.ST = (typeof(ri.ST))'' => 0, le.ST = (typeof(ri.ST))'' => -1, ri.ST = le.ST => 2,-2);
    SELF.Match_ZIP := MAP ( ri.ZIP = (typeof(ri.ZIP))'' => 0, le.ZIP = (typeof(ri.ZIP))'' => -1, ri.ZIP = le.ZIP => 2,-2);
    SELF.Match_TAX_ID := MAP ( ri.TAX_ID = (typeof(ri.TAX_ID))'' => 0, le.TAX_ID = (typeof(ri.TAX_ID))'' => -1, ri.TAX_ID = le.TAX_ID => 2,-2);
    SELF.Match_FEIN := MAP ( ri.FEIN = (typeof(ri.FEIN))'' => 0, le.FEIN = (typeof(ri.FEIN))'' => -1, ri.FEIN = le.FEIN => 2,-2);
    SELF.Match_PHONE := MAP ( ri.PHONE = (typeof(ri.PHONE))'' => 0, le.PHONE = (typeof(ri.PHONE))'' => -1, ri.PHONE = le.PHONE => 2,-2);
    SELF.Match_FAX := MAP ( ri.FAX = (typeof(ri.FAX))'' => 0, le.FAX = (typeof(ri.FAX))'' => -1, ri.FAX = le.FAX => 2,-2);
    SELF.Match_LIC_STATE := MAP ( ri.LIC_STATE = (typeof(ri.LIC_STATE))'' => 0, le.LIC_STATE = (typeof(ri.LIC_STATE))'' => -1, ri.LIC_STATE = le.LIC_STATE => 2,-2);
    SELF.Match_C_LIC_NBR := MAP ( ri.C_LIC_NBR = (typeof(ri.C_LIC_NBR))'' => 0, le.C_LIC_NBR = (typeof(ri.C_LIC_NBR))'' => -1, ri.C_LIC_NBR = le.C_LIC_NBR => 2, SALT29.WithinEditN(le.C_LIC_NBR,ri.C_LIC_NBR,2, 0) => 1,le.C_LIC_NBR = ri.C_LIC_NBR[length(trim(le.C_LIC_NBR))] or ri.C_LIC_NBR = le.C_LIC_NBR[length(trim(ri.C_LIC_NBR))] => 1,-2);
    SELF.Match_DEA_NUMBER := MAP ( ri.DEA_NUMBER = (typeof(ri.DEA_NUMBER))'' => 0, le.DEA_NUMBER = (typeof(ri.DEA_NUMBER))'' => -1, ri.DEA_NUMBER = le.DEA_NUMBER => 2,-2);
    SELF.Match_VENDOR_ID := MAP ( ri.VENDOR_ID = (typeof(ri.VENDOR_ID))'' => 0, le.VENDOR_ID = (typeof(ri.VENDOR_ID))'' => -1, ri.VENDOR_ID = le.VENDOR_ID => 2,-2);
    SELF.Match_NPI_NUMBER := MAP ( ri.NPI_NUMBER = (typeof(ri.NPI_NUMBER))'' => 0, le.NPI_NUMBER = (typeof(ri.NPI_NUMBER))'' => -1, ri.NPI_NUMBER = le.NPI_NUMBER => 2,-2);
    SELF.Match_CLIA_NUMBER := MAP ( ri.CLIA_NUMBER = (typeof(ri.CLIA_NUMBER))'' => 0, le.CLIA_NUMBER = (typeof(ri.CLIA_NUMBER))'' => -1, ri.CLIA_NUMBER = le.CLIA_NUMBER => 2,-2);
    SELF.Match_MEDICARE_FACILITY_NUMBER := MAP ( ri.MEDICARE_FACILITY_NUMBER = (typeof(ri.MEDICARE_FACILITY_NUMBER))'' => 0, le.MEDICARE_FACILITY_NUMBER = (typeof(ri.MEDICARE_FACILITY_NUMBER))'' => -1, ri.MEDICARE_FACILITY_NUMBER = le.MEDICARE_FACILITY_NUMBER => 2,-2);
    SELF.Match_MEDICAID_NUMBER := MAP ( ri.MEDICAID_NUMBER = (typeof(ri.MEDICAID_NUMBER))'' => 0, le.MEDICAID_NUMBER = (typeof(ri.MEDICAID_NUMBER))'' => -1, ri.MEDICAID_NUMBER = le.MEDICAID_NUMBER => 2,-2);
    SELF.Match_NCPDP_NUMBER := MAP ( ri.NCPDP_NUMBER = (typeof(ri.NCPDP_NUMBER))'' => 0, le.NCPDP_NUMBER = (typeof(ri.NCPDP_NUMBER))'' => -1, ri.NCPDP_NUMBER = le.NCPDP_NUMBER => 2,-2);
    SELF.Match_TAXONOMY := MAP ( ri.TAXONOMY = (typeof(ri.TAXONOMY))'' => 0, le.TAXONOMY = (typeof(ri.TAXONOMY))'' => -1, ri.TAXONOMY = le.TAXONOMY => 2,-2);
    SELF.Match_TAXONOMY_CODE := MAP ( ri.TAXONOMY_CODE = (typeof(ri.TAXONOMY_CODE))'' => 0, le.TAXONOMY_CODE = (typeof(ri.TAXONOMY_CODE))'' => -1, ri.TAXONOMY_CODE = le.TAXONOMY_CODE => 2,-2);
    SELF.Match_BDID := MAP ( ri.BDID = (typeof(ri.BDID))'' => 0, le.BDID = (typeof(ri.BDID))'' => -1, ri.BDID = le.BDID => 2,-2);
    SELF.Match_SRC := MAP ( ri.SRC = (typeof(ri.SRC))'' => 0, le.SRC = (typeof(ri.SRC))'' => -1, ri.SRC = le.SRC => 2,-2);
    SELF.Match_SOURCE_RID := MAP ( ri.SOURCE_RID = (typeof(ri.SOURCE_RID))'' => 0, le.SOURCE_RID = (typeof(ri.SOURCE_RID))'' => -1, ri.SOURCE_RID = le.SOURCE_RID => 2,-2);
    ri_FAC_NAME := SALT29.Fn_WordBag_AppendSpecs_Fake((SALT29.StrType)ri.FAC_NAME);//For later scoring
    le_FAC_NAME := SALT29.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT29.StrType)le.CNP_NAME) + ' ' + TRIM((SALT29.StrType)le.CNP_NUMBER) + ' ' + TRIM((SALT29.StrType)le.CNP_STORE_NUMBER) + ' ' + TRIM((SALT29.StrType)le.CNP_BTYPE) + ' ' + TRIM((SALT29.StrType)le.CNP_LOWV));//For later scoring
    SELF.Match_FAC_NAME := MAP ( ri.FAC_NAME = (typeof(ri.FAC_NAME))'' => 0, le_FAC_NAME = (typeof(ri.FAC_NAME))'' => -1, ri_FAC_NAME = le_FAC_NAME => 2,SALT29.MatchBagOfWords(le_FAC_NAME,ri_FAC_NAME,31744,1) > Config.FAC_NAME_Force * 100 => 1, -2);
    ri_ADDR1 := SALT29.Fn_WordBag_AppendSpecs_Fake((SALT29.StrType)ri.ADDR1);//For later scoring
    le_ADDR1 := SALT29.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT29.StrType)le.PRIM_RANGE) + ' ' + TRIM((SALT29.StrType)le.SEC_RANGE) + ' ' + TRIM((SALT29.StrType)le.PRIM_NAME));//For later scoring
    SELF.Match_ADDR1 := MAP ( ri.ADDR1 = (typeof(ri.ADDR1))'' => 0, le_ADDR1 = (typeof(ri.ADDR1))'' => -1, ri_ADDR1 = le_ADDR1 => 2, -2);
    ri_LOCALE := SALT29.Fn_WordBag_AppendSpecs_Fake((SALT29.StrType)ri.LOCALE);//For later scoring
    le_LOCALE := SALT29.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT29.StrType)le.V_CITY_NAME) + ' ' + TRIM((SALT29.StrType)le.ST) + ' ' + TRIM((SALT29.StrType)le.ZIP));//For later scoring
    SELF.Match_LOCALE := MAP ( ri.LOCALE = (typeof(ri.LOCALE))'' => 0, le_LOCALE = (typeof(ri.LOCALE))'' => -1, ri_LOCALE = le_LOCALE => 2, -2);
    ri_ADDRES := SALT29.Fn_WordBag_AppendSpecs_Fake((SALT29.StrType)ri.ADDRES);//For later scoring
    le_ADDRES := SALT29.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT29.StrType)le.PRIM_RANGE) + ' ' + TRIM((SALT29.StrType)le.SEC_RANGE) + ' ' + TRIM((SALT29.StrType)le.PRIM_NAME) + ' ' + TRIM((SALT29.StrType)le.V_CITY_NAME) + ' ' + TRIM((SALT29.StrType)le.ST) + ' ' + TRIM((SALT29.StrType)le.ZIP));//For later scoring
    SELF.Match_ADDRES := MAP ( ri.ADDRES = (typeof(ri.ADDRES))'' => 0, le_ADDRES = (typeof(ri.ADDRES))'' => -1, ri_ADDRES = le_ADDRES => 2, -2);
      SELF.Record_Score := SELF.Match_CNAME + SELF.Match_CNP_NAME + SELF.Match_CNP_NUMBER + SELF.Match_CNP_STORE_NUMBER + SELF.Match_CNP_BTYPE + SELF.Match_CNP_LOWV + SELF.Match_PRIM_RANGE + SELF.Match_PRIM_NAME + SELF.Match_SEC_RANGE + SELF.Match_V_CITY_NAME + SELF.Match_ST + SELF.Match_ZIP + SELF.Match_TAX_ID + SELF.Match_FEIN + SELF.Match_PHONE + SELF.Match_FAX + SELF.Match_LIC_STATE + SELF.Match_C_LIC_NBR + SELF.Match_DEA_NUMBER + SELF.Match_VENDOR_ID + SELF.Match_NPI_NUMBER + SELF.Match_CLIA_NUMBER + SELF.Match_MEDICARE_FACILITY_NUMBER + SELF.Match_MEDICAID_NUMBER + SELF.Match_NCPDP_NUMBER + SELF.Match_TAXONOMY + SELF.Match_TAXONOMY_CODE + SELF.Match_BDID + SELF.Match_SRC + SELF.Match_SOURCE_RID + SELF.Match_FAC_NAME + SELF.Match_ADDR1 + SELF.Match_LOCALE + SELF.Match_ADDRES;
      SELF.Is_FullMatch := SELF.Match_CNAME>=0 AND SELF.Match_CNP_NAME>=0 AND SELF.Match_CNP_NUMBER>=0 AND SELF.Match_CNP_STORE_NUMBER>=0 AND SELF.Match_CNP_BTYPE>=0 AND SELF.Match_CNP_LOWV>=0 AND SELF.Match_PRIM_RANGE>=0 AND SELF.Match_PRIM_NAME>=0 AND SELF.Match_SEC_RANGE>=0 AND SELF.Match_V_CITY_NAME>=0 AND SELF.Match_ST>=0 AND SELF.Match_ZIP>=0 AND SELF.Match_TAX_ID>=0 AND SELF.Match_FEIN>=0 AND SELF.Match_PHONE>=0 AND SELF.Match_FAX>=0 AND SELF.Match_LIC_STATE>=0 AND SELF.Match_C_LIC_NBR>=0 AND SELF.Match_DEA_NUMBER>=0 AND SELF.Match_VENDOR_ID>=0 AND SELF.Match_NPI_NUMBER>=0 AND SELF.Match_CLIA_NUMBER>=0 AND SELF.Match_MEDICARE_FACILITY_NUMBER>=0 AND SELF.Match_MEDICAID_NUMBER>=0 AND SELF.Match_NCPDP_NUMBER>=0 AND SELF.Match_TAXONOMY>=0 AND SELF.Match_TAXONOMY_CODE>=0 AND SELF.Match_BDID>=0 AND SELF.Match_SRC>=0 AND SELF.Match_SOURCE_RID>=0 AND SELF.Match_FAC_NAME>=0 AND SELF.Match_ADDR1>=0 AND SELF.Match_LOCALE>=0 AND SELF.Match_ADDRES>=0;
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
  DSAfter_CNP_BTYPE := SALT29.MAC_Field_Prop_Do(Raw_Data,CNP_BTYPE,LNPID);
  DSAfter_TAX_ID := SALT29.MAC_Field_Prop_Do(DSAfter_CNP_BTYPE,TAX_ID,LNPID);
  DSAfter_FEIN := SALT29.MAC_Field_Prop_Do(DSAfter_TAX_ID,FEIN,LNPID);
  ds := PROJECT(DSAfter_FEIN,tr(LEFT));
  EXPORT DataToSearch := DEDUP(ds,WHOLE RECORD,ALL);
END;
