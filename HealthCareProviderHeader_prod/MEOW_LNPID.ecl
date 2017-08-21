
EXPORT MEOW_LNPID(DATASET(Process_LNPID_Layouts.InputLayout) in) := MODULE
IMPORT ut,SALT27;
Process_LNPID_Layouts.OutputLayout GetResults(Process_LNPID_Layouts.InputLayout le) := TRANSFORM
SELF.keys_tried := ;
SELF.Results := TOPN(ROLLUP(
SORTED(Key_HealthProvider_.ScoredLNPIDFetch(le.VENDOR_ID,le.DID,le.NPI_NUMBER,le.DEA_NUMBER,le.MAINNAME,le.FULLNAME,le.LIC_NBR,le.UPIN,le.ADDR,le.ADDRESS,le.TAX_ID,(UNSIGNED4)le.DOB,le.PRIM_NAME,le.ZIP,le.LOCALE,le.PRIM_RANGE,le.LNAME,le.V_CITY_NAME,le.MNAME,le.FNAME,le.SEC_RANGE,le.SNAME,le.ST,le.GENDER,le.PHONE,le.LIC_STATE,le.ADDRESS_ID,le.CNAME,le.SRC,le.DT_LIC_EXPIRATION,le.DT_DEA_EXPIRATION,le.GEO_LAT,le.GEO_LONG),LNPID)
, RIGHT.LNPID > 0 AND LEFT.LNPID = RIGHT.LNPID, Process_LNPID_Layouts.Combine_Scores(LEFT,RIGHT)),le.MaxIDs,-Weight)(SALT27.DebugMode OR ~ForceFailed); // Warning - is a fetch to keys etc
Process_LNPID_Layouts.MAC_Add_ResolutionFlags()
SELF := le;
END;
RR0 := PROJECT(in(Entered_LNPID=0),GetResults(left),PREFETCH(20,PARALLEL));
SALT27.MAC_External_AddPcnt(RR0,Process_LNPID_Layouts.LayoutScoredFetch,Process_LNPID_Layouts.OutputLayout,27,RR1);
EXPORT Raw_Results := IF(EXISTS(RR0),RR1);
// Pass-thru any records which already had the LNPID on them
process_LNPID_layouts.id_stream_layout ptt(in le) := TRANSFORM
SELF.UniqueId := le.UniqueId;
SELF.Weight := 42; // Assume at least 'threshold' met
SELF.LNPID := le.Entered_LNPID;
END;
pass_thru := PROJECT(in(~(Entered_LNPID=0)),ptt(LEFT));
// Transform to process 'real' results
process_LNPID_layouts.id_stream_layout n(Raw_Results le,UNSIGNED c) := TRANSFORM
SELF.UniqueId := le.UniqueId;
SELF.KeysUsed := le.Results[c].keys_used;
SELF.KeysFailed := le.Results[c].keys_failed;
SELF := le.Results[c];
END;
EXPORT Uid_Results := NORMALIZE(Raw_Results,COUNT(LEFT.Results),n(LEFT,COUNTER))+pass_thru;
k := Process_LNPID_Layouts.Key;
DLayout := RECORD
process_LNPID_layouts.id_stream_layout;
RECORDOF(k) AND NOT process_LNPID_layouts.id_stream_layout; // No HEADERSEARCH specified
END;
DLayout tr(Uid_Results le, k ri) := TRANSFORM
SELF := le;
SELF := ri;
END;
EXPORT Raw_Data := JOIN( Uid_Results,k,(LEFT.LNPID = RIGHT.LNPID),tr(LEFT,RIGHT), LEFT OUTER);
Layout_Matched_Data := RECORD
Raw_Data;
BOOLEAN FullMatch_Required; // If the input enquiry is insisting upon full record match
BOOLEAN Has_Fullmatch; // This UID has a fully matching record
BOOLEAN RecordsOnly; // If the input enquiry only wants matching records returned
BOOLEAN Is_Fullmatch; // This record matches completely
INTEGER2 Record_Score; // Score for this particular record
INTEGER2 Match_VENDOR_ID;
INTEGER2 Match_DID;
INTEGER2 Match_NPI_NUMBER;
INTEGER2 Match_DEA_NUMBER;
INTEGER2 Match_MAINNAME;
INTEGER2 Match_FULLNAME;
INTEGER2 Match_LIC_NBR;
INTEGER2 Match_UPIN;
INTEGER2 Match_ADDR;
INTEGER2 Match_ADDRESS;
INTEGER2 Match_TAX_ID;
INTEGER2 Match_DOB;
INTEGER2 Match_PRIM_NAME;
INTEGER2 Match_ZIP;
INTEGER2 Match_LOCALE;
INTEGER2 Match_PRIM_RANGE;
INTEGER2 Match_LNAME;
INTEGER2 Match_V_CITY_NAME;
INTEGER2 Match_MNAME;
INTEGER2 Match_FNAME;
INTEGER2 Match_SEC_RANGE;
INTEGER2 Match_SNAME;
INTEGER2 Match_ST;
INTEGER2 Match_GENDER;
INTEGER2 Match_PHONE;
INTEGER2 Match_LIC_STATE;
INTEGER2 Match_ADDRESS_ID;
INTEGER2 Match_CNAME;
INTEGER2 Match_SRC;
INTEGER2 Match_DT_FIRST_SEEN;
INTEGER2 Match_DT_LAST_SEEN;
INTEGER2 Match_DT_LIC_EXPIRATION;
INTEGER2 Match_DT_DEA_EXPIRATION;
INTEGER2 Match_GEO_LAT;
INTEGER2 Match_GEO_LONG;
END;
Layout_Matched_Data score_fields(Raw_Data le,In ri) := TRANSFORM
SELF.Match_VENDOR_ID := MAP ( ri.VENDOR_ID = (typeof(ri.VENDOR_ID))'' => 0, le.VENDOR_ID = (typeof(ri.VENDOR_ID))'' => -1, ri.VENDOR_ID = le.VENDOR_ID => 2,-2);
SELF.Match_DID := MAP ( ri.DID = (typeof(ri.DID))'' => 0, le.DID = (typeof(ri.DID))'' => -1, ri.DID = le.DID => 2,-2);
SELF.Match_NPI_NUMBER := MAP ( ri.NPI_NUMBER = (typeof(ri.NPI_NUMBER))'' => 0, le.NPI_NUMBER = (typeof(ri.NPI_NUMBER))'' => -1, ri.NPI_NUMBER = le.NPI_NUMBER => 2,-2);
SELF.Match_DEA_NUMBER := MAP ( ri.DEA_NUMBER = (typeof(ri.DEA_NUMBER))'' => 0, le.DEA_NUMBER = (typeof(ri.DEA_NUMBER))'' => -1, ri.DEA_NUMBER = le.DEA_NUMBER => 2,-2);
ri_MAINNAME := SALT27.Fn_WordBag_AppendSpecs_Fake((SALT27.StrType)ri.MAINNAME);//For later scoring
le_MAINNAME := SALT27.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT27.StrType)le.FNAME) + ' ' + TRIM((SALT27.StrType)le.MNAME) + ' ' + TRIM((SALT27.StrType)le.LNAME));//For later scoring
SELF.Match_MAINNAME := MAP ( ri.MAINNAME = (typeof(ri.MAINNAME))'' => 0, le_MAINNAME = (typeof(ri.MAINNAME))'' => -1, ri_MAINNAME = le_MAINNAME => 2,SALT27.MatchBagOfWords(le_MAINNAME,ri_MAINNAME,0,1,0,0,0) > 0 => 1, -2);
ri_FULLNAME := SALT27.Fn_WordBag_AppendSpecs_Fake((SALT27.StrType)ri.FULLNAME);//For later scoring
le_FULLNAME := SALT27.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT27.StrType)le.FNAME) + ' ' + TRIM((SALT27.StrType)le.MNAME) + ' ' + TRIM((SALT27.StrType)le.LNAME) + ' ' + TRIM((SALT27.StrType)le.SNAME));//For later scoring
SELF.Match_FULLNAME := MAP ( ri.FULLNAME = (typeof(ri.FULLNAME))'' => 0, le_FULLNAME = (typeof(ri.FULLNAME))'' => -1, ri_FULLNAME = le_FULLNAME => 2,SALT27.MatchBagOfWords(le_FULLNAME,ri_FULLNAME,0,1,0,0,0) > -600 => 1, -2);
SELF.Match_LIC_NBR := MAP ( ri.LIC_NBR = (typeof(ri.LIC_NBR))'' => 0, le.LIC_NBR = (typeof(ri.LIC_NBR))'' => -1, ri.LIC_NBR = le.LIC_NBR => 2,-2);
SELF.Match_UPIN := MAP ( ri.UPIN = (typeof(ri.UPIN))'' => 0, le.UPIN = (typeof(ri.UPIN))'' => -1, ri.UPIN = le.UPIN => 2,-2);
ri_ADDR := SALT27.Fn_WordBag_AppendSpecs_Fake((SALT27.StrType)ri.ADDR);//For later scoring
le_ADDR := SALT27.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT27.StrType)le.PRIM_RANGE) + ' ' + TRIM((SALT27.StrType)le.SEC_RANGE) + ' ' + TRIM((SALT27.StrType)le.PRIM_NAME));//For later scoring
SELF.Match_ADDR := MAP ( ri.ADDR = (typeof(ri.ADDR))'' => 0, le_ADDR = (typeof(ri.ADDR))'' => -1, ri_ADDR = le_ADDR => 2,SALT27.MatchBagOfWords(le_ADDR,ri_ADDR,0,1,0,0,0) > 0 => 1, -2);
ri_ADDRESS := SALT27.Fn_WordBag_AppendSpecs_Fake((SALT27.StrType)ri.ADDRESS);//For later scoring
le_ADDRESS := SALT27.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT27.StrType)le.PRIM_RANGE) + ' ' + TRIM((SALT27.StrType)le.SEC_RANGE) + ' ' + TRIM((SALT27.StrType)le.PRIM_NAME) + ' ' + TRIM((SALT27.StrType)le.V_CITY_NAME) + ' ' + TRIM((SALT27.StrType)le.ST) + ' ' + TRIM((SALT27.StrType)le.ZIP));//For later scoring
SELF.Match_ADDRESS := MAP ( ri.ADDRESS = (typeof(ri.ADDRESS))'' => 0, le_ADDRESS = (typeof(ri.ADDRESS))'' => -1, ri_ADDRESS = le_ADDRESS => 2,SALT27.MatchBagOfWords(le_ADDRESS,ri_ADDRESS,0,1,0,0,0) > 0 => 1, -2);
SELF.Match_TAX_ID := MAP ( ri.TAX_ID = (typeof(ri.TAX_ID))'' => 0, le.TAX_ID = (typeof(ri.TAX_ID))'' => -1, ri.TAX_ID = le.TAX_ID => 2,-2);
SELF.Match_DOB := SALT27.Fn_DobMatch_FuzzyScore((UNSIGNED)le.DOB,(UNSIGNED)ri.DOB);
SELF.Match_PRIM_NAME := MAP ( ri.PRIM_NAME = (typeof(ri.PRIM_NAME))'' => 0, le.PRIM_NAME = (typeof(ri.PRIM_NAME))'' => -1, ri.PRIM_NAME = le.PRIM_NAME => 2,-2);
SELF.Match_ZIP := MAP ( ri.ZIP = (typeof(ri.ZIP))'' => 0, le.ZIP = (typeof(ri.ZIP))'' => -1, ri.ZIP = le.ZIP => 2,-2);
ri_LOCALE := SALT27.Fn_WordBag_AppendSpecs_Fake((SALT27.StrType)ri.LOCALE);//For later scoring
le_LOCALE := SALT27.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT27.StrType)le.V_CITY_NAME) + ' ' + TRIM((SALT27.StrType)le.ST) + ' ' + TRIM((SALT27.StrType)le.ZIP));//For later scoring
SELF.Match_LOCALE := MAP ( ri.LOCALE = (typeof(ri.LOCALE))'' => 0, le_LOCALE = (typeof(ri.LOCALE))'' => -1, ri_LOCALE = le_LOCALE => 2,SALT27.MatchBagOfWords(le_LOCALE,ri_LOCALE,0,1,0,0,0) > 0 => 1, -2);
SELF.Match_PRIM_RANGE := MAP ( ri.PRIM_RANGE = (typeof(ri.PRIM_RANGE))'' => 0, le.PRIM_RANGE = (typeof(ri.PRIM_RANGE))'' => -1, ri.PRIM_RANGE = le.PRIM_RANGE => 2,-2);
SELF.Match_LNAME := MAP ( ri.LNAME = (typeof(ri.LNAME))'' => 0, le.LNAME = (typeof(ri.LNAME))'' => -1, ri.LNAME = le.LNAME => 2, SALT27.WithinEditN(le.LNAME,ri.LNAME,2) => 1,le.LNAME = ri.LNAME[length(trim(le.LNAME))] or ri.LNAME = le.LNAME[length(trim(ri.LNAME))] => 1,-2);
SELF.Match_V_CITY_NAME := MAP ( ri.V_CITY_NAME = (typeof(ri.V_CITY_NAME))'' => 0, le.V_CITY_NAME = (typeof(ri.V_CITY_NAME))'' => -1, ri.V_CITY_NAME = le.V_CITY_NAME => 2,-2);
SELF.Match_MNAME := MAP ( ri.MNAME = (typeof(ri.MNAME))'' => 0, le.MNAME = (typeof(ri.MNAME))'' => -1, ri.MNAME = le.MNAME => 2, SALT27.WithinEditN(le.MNAME,ri.MNAME,2) => 1,le.MNAME = ri.MNAME[length(trim(le.MNAME))] or ri.MNAME = le.MNAME[length(trim(ri.MNAME))] => 1,-2);
SELF.Match_FNAME := MAP ( ri.FNAME = (typeof(ri.FNAME))'' => 0, le.FNAME = (typeof(ri.FNAME))'' => -1, ri.FNAME = le.FNAME => 2, SALT27.WithinEditN(le.FNAME,ri.FNAME,1) => 1,le.FNAME = ri.FNAME[length(trim(le.FNAME))] or ri.FNAME = le.FNAME[length(trim(ri.FNAME))] => 1,-2);
SELF.Match_SEC_RANGE := MAP ( ri.SEC_RANGE = (typeof(ri.SEC_RANGE))'' => 0, le.SEC_RANGE = (typeof(ri.SEC_RANGE))'' => -1, ri.SEC_RANGE = le.SEC_RANGE => 2,-2);
SELF.Match_SNAME := MAP ( ri.SNAME = (typeof(ri.SNAME))'' => 0, le.SNAME = (typeof(ri.SNAME))'' => -1, ri.SNAME = le.SNAME => 2,-2);
SELF.Match_ST := MAP ( ri.ST = (typeof(ri.ST))'' => 0, le.ST = (typeof(ri.ST))'' => -1, ri.ST = le.ST => 2,-2);
SELF.Match_GENDER := MAP ( ri.GENDER = (typeof(ri.GENDER))'' => 0, le.GENDER = (typeof(ri.GENDER))'' => -1, ri.GENDER = le.GENDER => 2,-2);
SELF.Match_PHONE := MAP ( ri.PHONE = (typeof(ri.PHONE))'' => 0, le.PHONE = (typeof(ri.PHONE))'' => -1, ri.PHONE = le.PHONE => 2,-2);
SELF.Match_LIC_STATE := MAP ( ri.LIC_STATE = (typeof(ri.LIC_STATE))'' => 0, le.LIC_STATE = (typeof(ri.LIC_STATE))'' => -1, ri.LIC_STATE = le.LIC_STATE => 2,-2);
SELF.Match_ADDRESS_ID := MAP ( ri.ADDRESS_ID = (typeof(ri.ADDRESS_ID))'' => 0, le.ADDRESS_ID = (typeof(ri.ADDRESS_ID))'' => -1, ri.ADDRESS_ID = le.ADDRESS_ID => 2,-2);
SELF.Match_CNAME := MAP ( ri.CNAME = (typeof(ri.CNAME))'' => 0, le.CNAME = (typeof(ri.CNAME))'' => -1, ri.CNAME = le.CNAME => 2,-2);
SELF.Match_SRC := MAP ( ri.SRC = (typeof(ri.SRC))'' => 0, le.SRC = (typeof(ri.SRC))'' => -1, ri.SRC = le.SRC => 2,-2);
SELF.Match_DT_FIRST_SEEN := MAP ( ri.DT_FIRST_SEEN = (typeof(ri.DT_FIRST_SEEN))'' => 0, le.DT_FIRST_SEEN = (typeof(ri.DT_FIRST_SEEN))'' => -1, ri.DT_FIRST_SEEN = le.DT_FIRST_SEEN => 2,-2);
SELF.Match_DT_LAST_SEEN := MAP ( ri.DT_LAST_SEEN = (typeof(ri.DT_LAST_SEEN))'' => 0, le.DT_LAST_SEEN = (typeof(ri.DT_LAST_SEEN))'' => -1, ri.DT_LAST_SEEN = le.DT_LAST_SEEN => 2,-2);
SELF.Match_DT_LIC_EXPIRATION := MAP ( ri.DT_LIC_EXPIRATION = (typeof(ri.DT_LIC_EXPIRATION))'' => 0, le.DT_LIC_EXPIRATION = (typeof(ri.DT_LIC_EXPIRATION))'' => -1, ri.DT_LIC_EXPIRATION = le.DT_LIC_EXPIRATION => 2,-2);
SELF.Match_DT_DEA_EXPIRATION := MAP ( ri.DT_DEA_EXPIRATION = (typeof(ri.DT_DEA_EXPIRATION))'' => 0, le.DT_DEA_EXPIRATION = (typeof(ri.DT_DEA_EXPIRATION))'' => -1, ri.DT_DEA_EXPIRATION = le.DT_DEA_EXPIRATION => 2,-2);
SELF.Match_GEO_LAT := MAP ( ri.GEO_LAT = (typeof(ri.GEO_LAT))'' => 0, le.GEO_LAT = (typeof(ri.GEO_LAT))'' => -1, ri.GEO_LAT = le.GEO_LAT => 2,-2);
SELF.Match_GEO_LONG := MAP ( ri.GEO_LONG = (typeof(ri.GEO_LONG))'' => 0, le.GEO_LONG = (typeof(ri.GEO_LONG))'' => -1, ri.GEO_LONG = le.GEO_LONG => 2,-2);
SELF.Record_Score := SELF.Match_VENDOR_ID + SELF.Match_DID + SELF.Match_NPI_NUMBER + SELF.Match_DEA_NUMBER + SELF.Match_MAINNAME + SELF.Match_FULLNAME + SELF.Match_LIC_NBR + SELF.Match_UPIN + SELF.Match_ADDR + SELF.Match_ADDRESS + SELF.Match_TAX_ID + SELF.Match_DOB + SELF.Match_PRIM_NAME + SELF.Match_ZIP + SELF.Match_LOCALE + SELF.Match_PRIM_RANGE + SELF.Match_LNAME + SELF.Match_V_CITY_NAME + SELF.Match_MNAME + SELF.Match_FNAME + SELF.Match_SEC_RANGE + SELF.Match_SNAME + SELF.Match_ST + SELF.Match_GENDER + SELF.Match_PHONE + SELF.Match_LIC_STATE + SELF.Match_ADDRESS_ID + SELF.Match_CNAME + SELF.Match_SRC + SELF.Match_DT_FIRST_SEEN + SELF.Match_DT_LAST_SEEN + SELF.Match_DT_LIC_EXPIRATION + SELF.Match_DT_DEA_EXPIRATION + SELF.Match_GEO_LAT + SELF.Match_GEO_LONG;
SELF.Is_FullMatch := SELF.Match_VENDOR_ID>=0 AND SELF.Match_DID>=0 AND SELF.Match_NPI_NUMBER>=0 AND SELF.Match_DEA_NUMBER>=0 AND SELF.Match_MAINNAME>=0 AND SELF.Match_FULLNAME>=0 AND SELF.Match_LIC_NBR>=0 AND SELF.Match_UPIN>=0 AND SELF.Match_ADDR>=0 AND SELF.Match_ADDRESS>=0 AND SELF.Match_TAX_ID>=0 AND SELF.Match_DOB>=0 AND SELF.Match_PRIM_NAME>=0 AND SELF.Match_ZIP>=0 AND SELF.Match_LOCALE>=0 AND SELF.Match_PRIM_RANGE>=0 AND SELF.Match_LNAME>=0 AND SELF.Match_V_CITY_NAME>=0 AND SELF.Match_MNAME>=0 AND SELF.Match_FNAME>=0 AND SELF.Match_SEC_RANGE>=0 AND SELF.Match_SNAME>=0 AND SELF.Match_ST>=0 AND SELF.Match_GENDER>=0 AND SELF.Match_PHONE>=0 AND SELF.Match_LIC_STATE>=0 AND SELF.Match_ADDRESS_ID>=0 AND SELF.Match_CNAME>=0 AND SELF.Match_SRC>=0 AND SELF.Match_DT_FIRST_SEEN>=0 AND SELF.Match_DT_LAST_SEEN>=0 AND SELF.Match_DT_LIC_EXPIRATION>=0 AND SELF.Match_DT_DEA_EXPIRATION>=0 AND SELF.Match_GEO_LAT>=0 AND SELF.Match_GEO_LONG>=0;
SELF.Has_FullMatch := SELF.Is_FullMatch; // Filled in later using iterate
SELF.FullMatch_Required := ri.FullMatch;
SELF.RecordsOnly := ri.MatchRecords;
SELF := le;
END;
ScoredData := JOIN(Raw_Data,In,LEFT.UniqueId=RIGHT.UniqueId,score_fields(LEFT,RIGHT));
Layout_Matched_Data prop_full(ScoredData le,ScoredData ri) := transform
SELF.Has_FullMatch := ri.Has_FullMatch OR le.Has_FullMatch AND le.LNPID=ri.LNPID AND le.UniqueId=ri.UniqueId;
SELF := ri;
END;
i := ITERATE( SORT( ScoredData,UniqueId,-Has_FullMatch ),prop_full(LEFT,RIGHT) );
// Now narrow down to the required records - note this is switchable per UniqueId
i1 := i(Has_FullMatch OR ~FullMatch_Required,~RecordsOnly OR Is_FullMatch OR ~FullMatch_Required AND Record_Score>0);
W1 := IF ( i1.RecordsOnly,i1.Record_Score,i1.Weight );
EXPORT Data_ := DEDUP(SORT(i1,UniqueId,-W1,LNPID,-(Record_Score+Weight-W1)),WHOLE RECORD);
END;

