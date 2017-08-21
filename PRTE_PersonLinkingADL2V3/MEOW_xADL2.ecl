export MEOW_xADL2(dataset(Process_xADL2_Layouts.InputLayout) in) := MODULE
import ut,SALT20;
Process_xADL2_Layouts.OutputLayout GetResults(Process_xADL2_Layouts.InputLayout le) := transform
  self.Results := topn(rollup(
    merge(
    sorted(Key_PersonHeader_FLST.ScoredDIDFetch(le.FNAME,le.LNAME,le.STATE,le.MNAME,(unsigned4)le.DOB,le.CITY),DID),
    sorted(Key_PersonHeader_LFZ.ScoredDIDFetch(le.LNAME,le.FNAME,le.ZIP,le.CITY,le.PRIM_RANGE,le.PRIM_NAME,le.SSN5,le.SSN4,le.MNAME,le.SEC_RANGE,le.NAME_SUFFIX,(unsigned4)le.DOB),DID),
    sorted(Key_PersonHeader_ADDRESS3.ScoredDIDFetch(le.PRIM_RANGE,le.PRIM_NAME,le.ZIP,le.FNAME,le.MNAME,le.LNAME,(unsigned4)le.DOB,le.SEC_RANGE),DID),
    sorted(Key_PersonHeader_S.ScoredDIDFetch(le.SSN5,le.SSN4,le.FNAME,le.MNAME,le.LNAME,(unsigned4)le.DOB,le.CITY,le.STATE),DID),
    sorted(Key_PersonHeader_SSN4.ScoredDIDFetch(le.SSN4,le.FNAME,le.LNAME,(unsigned4)le.DOB,le.SSN5),DID),
    sorted(Key_PersonHeader_DO.ScoredDIDFetch((unsigned4)le.DOB,le.LNAME,le.FNAME,le.STATE,le.CITY,le.SSN5,le.SSN4,le.MNAME),DID),
    sorted(Key_PersonHeader_PH.ScoredDIDFetch(le.PHONE,le.FNAME,le.MNAME,le.LNAME,(unsigned4)le.DOB,le.CITY,le.STATE,le.SSN5,le.SSN4),DID),
    sorted(Key_PersonHeader_ZPRF.ScoredDIDFetch(le.ZIP,le.PRIM_RANGE,le.FNAME,le.LNAME,le.PRIM_NAME,le.SEC_RANGE,(unsigned4)le.DOB),DID))
    ,left.DID=right.DID, Process_xADL2_Layouts.Combine_Scores(left,right)),50,-Weight); // Warning - is a fetch to keys etc
  Process_xADL2_Layouts.MAC_Add_ResolutionFlags()
  self := le;
end;
  RR0 := PROJECT(in(Entered_DID=0),GetResults(left),PREFETCH(20,PARALLEL));
  SALT20.MAC_External_AddPcnt(RR0,Process_xADL2_Layouts.LayoutScoredFetch,Process_xADL2_Layouts.OutputLayout,28,RR1);
EXPORT Raw_Results := RR1;
  id_stream_layout := record
    unsigned4 UniqueId;
    INTEGER2 Weight;
    unsigned4 KeysUsed := 0;
    typeof(Raw_Results.Results[1].DID) DID;
  end;
// Pass-thru any records which already had the 4660384 on them
  id_stream_layout ptt(in le) := transform
    self.UniqueId := le.UniqueId;
    self.Weight := 39; // Assume at least 'threshold' met
    self.DID := le.Entered_DID;
  end;
  pass_thru := project(in(Entered_DID<>0),ptt(left));
// Transform to process 'real' results
  id_stream_layout n(Raw_Results le,unsigned c) := transform
    self.UniqueId := le.UniqueId;
    self.KeysUsed := le.Results[c].keys_used;
    self := le.Results[c];
  end;
  export Uid_Results := normalize(Raw_Results,count(left.Results),n(left,counter))+pass_thru;
  export Raw_Data := join( Uid_Results,Process_xADL2_Layouts.Key,left.DID=right.DID );
  Layout_Matched_Data := RECORD
    Raw_Data;
    boolean FullMatch_Required; // If the input enquiry is insisting upon full record match
    boolean Has_Fullmatch; // This UID has a fully matching record
    boolean RecordsOnly; // If the input enquiry only wants matching records returned
    boolean Is_Fullmatch; // This record matches completely
    integer2 Record_Score; // Score for this particular record
    integer2 Match_NAME_SUFFIX;
    integer2 Match_FNAME;
    integer2 Match_MNAME;
    integer2 Match_LNAME;
    integer2 Match_PRIM_RANGE;
    integer2 Match_PRIM_NAME;
    integer2 Match_SEC_RANGE;
    integer2 Match_CITY;
    integer2 Match_STATE;
    integer2 Match_ZIP;
    integer2 Match_ZIP4;
    integer2 Match_COUNTY;
    integer2 Match_SSN5;
    integer2 Match_SSN4;
    integer2 Match_DOB;
    integer2 Match_PHONE;
    integer2 Match_MAINNAME;
    integer2 Match_FULLNAME;
    integer2 Match_ADDR1;
    integer2 Match_LOCALE;
    integer2 Match_ADDRS;
  END;
  Layout_Matched_Data score_fields(Raw_Data le,In ri) := transform
    SELF.Match_NAME_SUFFIX := MAP ( ri.NAME_SUFFIX = (typeof(ri.NAME_SUFFIX))'' => 0, le.NAME_SUFFIX = (typeof(ri.NAME_SUFFIX))'' => -1, ri.NAME_SUFFIX = le.NAME_SUFFIX => 2, ut.WithinEditN(le.NAME_SUFFIX,ri.NAME_SUFFIX,2) => 1,-2);
    SELF.Match_FNAME := MAP ( ri.FNAME = (typeof(ri.FNAME))'' => 0, le.FNAME = (typeof(ri.FNAME))'' => -1, ri.FNAME = le.FNAME => 2, ut.WithinEditN(le.FNAME,ri.FNAME,2) => 1,metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(ri.FNAME) => 1,le.FNAME = ri.FNAME[length(trim(le.FNAME))] or ri.FNAME = le.FNAME[length(trim(ri.FNAME))] => 1,-2);
    SELF.Match_MNAME := MAP ( ri.MNAME = (typeof(ri.MNAME))'' => 0, le.MNAME = (typeof(ri.MNAME))'' => -1, ri.MNAME = le.MNAME => 2, ut.WithinEditN(le.MNAME,ri.MNAME,2) => 1,le.MNAME = ri.MNAME[length(trim(le.MNAME))] or ri.MNAME = le.MNAME[length(trim(ri.MNAME))] => 1,-2);
    SELF.Match_LNAME := MAP ( ri.LNAME = (typeof(ri.LNAME))'' => 0, le.LNAME = (typeof(ri.LNAME))'' => -1, ri.LNAME = le.LNAME => 2, ut.WithinEditN(le.LNAME,ri.LNAME,2) => 1,metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(ri.LNAME) => 1,-2);
    SELF.Match_PRIM_RANGE := MAP ( ri.PRIM_RANGE = (typeof(ri.PRIM_RANGE))'' => 0, le.PRIM_RANGE = (typeof(ri.PRIM_RANGE))'' => -1, ri.PRIM_RANGE = le.PRIM_RANGE => 2, ut.WithinEditN(le.PRIM_RANGE,ri.PRIM_RANGE,1) => 1,-2);
    SELF.Match_PRIM_NAME := MAP ( ri.PRIM_NAME = (typeof(ri.PRIM_NAME))'' => 0, le.PRIM_NAME = (typeof(ri.PRIM_NAME))'' => -1, ri.PRIM_NAME = le.PRIM_NAME => 2, ut.WithinEditN(le.PRIM_NAME,ri.PRIM_NAME,1) => 1,-2);
    SELF.Match_SEC_RANGE := MAP ( ri.SEC_RANGE = (typeof(ri.SEC_RANGE))'' => 0, le.SEC_RANGE = (typeof(ri.SEC_RANGE))'' => -1, ri.SEC_RANGE = le.SEC_RANGE => 2,-2);
    SELF.Match_CITY := MAP ( ri.CITY = (typeof(ri.CITY))'' => 0, le.CITY = (typeof(ri.CITY))'' => -1, ri.CITY = le.CITY => 2,-2);
    SELF.Match_STATE := MAP ( ri.STATE = (typeof(ri.STATE))'' => 0, le.STATE = (typeof(ri.STATE))'' => -1, ri.STATE = le.STATE => 2,-2);
    SELF.Match_ZIP := MAP ( ri.ZIP = (typeof(ri.ZIP))'' => 0, le.ZIP = (typeof(ri.ZIP))'' => -1, ri.ZIP = le.ZIP => 2,-2);
    SELF.Match_ZIP4 := MAP ( ri.ZIP4 = (typeof(ri.ZIP4))'' => 0, le.ZIP4 = (typeof(ri.ZIP4))'' => -1, ri.ZIP4 = le.ZIP4 => 2,-2);
    SELF.Match_COUNTY := MAP ( ri.COUNTY = (typeof(ri.COUNTY))'' => 0, le.COUNTY = (typeof(ri.COUNTY))'' => -1, ri.COUNTY = le.COUNTY => 2,-2);
    SELF.Match_SSN5 := MAP ( ri.SSN5 = (typeof(ri.SSN5))'' => 0, le.SSN5 = (typeof(ri.SSN5))'' => -1, ri.SSN5 = le.SSN5 => 2, ut.WithinEditN(le.SSN5,ri.SSN5,1) => 1,-2);
    SELF.Match_SSN4 := MAP ( ri.SSN4 = (typeof(ri.SSN4))'' => 0, le.SSN4 = (typeof(ri.SSN4))'' => -1, ri.SSN4 = le.SSN4 => 2, ut.WithinEditN(le.SSN4,ri.SSN4,1) => 1,-2);
    SELF.Match_DOB := SALT20.Fn_DobMatch_FuzzyScore((unsigned)le.DOB,(unsigned)ri.DOB);
    SELF.Match_PHONE := MAP ( ri.PHONE = (typeof(ri.PHONE))'' => 0, le.PHONE = (typeof(ri.PHONE))'' => -1, ri.PHONE = le.PHONE => 2,-2);
    ri_MAINNAME := SALT20.Fn_WordBag_AppendSpecs_Fake((string)ri.MAINNAME);//For later scoring
    le_MAINNAME := SALT20.Fn_WordBag_AppendSpecs_Fake(trim((string)le.FNAME) + ' ' + trim((string)le.MNAME) + ' ' + trim((string)le.LNAME));//For later scoring
    SELF.Match_MAINNAME := MAP ( ri.MAINNAME = (typeof(ri.MAINNAME))'' => 0, le_MAINNAME = (typeof(ri.MAINNAME))'' => -1, ri_MAINNAME = le_MAINNAME => 2,SALT20.fn_match_bagofwords(le_MAINNAME,ri_MAINNAME,0,1) > 0 => 1, -2);
    ri_FULLNAME := SALT20.Fn_WordBag_AppendSpecs_Fake((string)ri.FULLNAME);//For later scoring
    le_FULLNAME := SALT20.Fn_WordBag_AppendSpecs_Fake(trim((string)le.FNAME) + ' ' + trim((string)le.MNAME) + ' ' + trim((string)le.LNAME) + ' ' + trim((string)le.NAME_SUFFIX));//For later scoring
    SELF.Match_FULLNAME := MAP ( ri.FULLNAME = (typeof(ri.FULLNAME))'' => 0, le_FULLNAME = (typeof(ri.FULLNAME))'' => -1, ri_FULLNAME = le_FULLNAME => 2,SALT20.fn_match_bagofwords(le_FULLNAME,ri_FULLNAME,0,1) > -300 => 1, -2);
    ri_ADDR1 := SALT20.Fn_WordBag_AppendSpecs_Fake((string)ri.ADDR1);//For later scoring
    le_ADDR1 := SALT20.Fn_WordBag_AppendSpecs_Fake(trim((string)le.PRIM_RANGE) + ' ' + trim((string)le.PRIM_NAME) + ' ' + trim((string)le.SEC_RANGE) + ' ' + trim((string)le.ZIP4));//For later scoring
    SELF.Match_ADDR1 := MAP ( ri.ADDR1 = (typeof(ri.ADDR1))'' => 0, le_ADDR1 = (typeof(ri.ADDR1))'' => -1, ri_ADDR1 = le_ADDR1 => 2,SALT20.fn_match_bagofwords(le_ADDR1,ri_ADDR1,0,1) > 0 => 1, -2);
    ri_LOCALE := SALT20.Fn_WordBag_AppendSpecs_Fake((string)ri.LOCALE);//For later scoring
    le_LOCALE := SALT20.Fn_WordBag_AppendSpecs_Fake(trim((string)le.COUNTY) + ' ' + trim((string)le.CITY) + ' ' + trim((string)le.STATE) + ' ' + trim((string)le.ZIP));//For later scoring
    SELF.Match_LOCALE := MAP ( ri.LOCALE = (typeof(ri.LOCALE))'' => 0, le_LOCALE = (typeof(ri.LOCALE))'' => -1, ri_LOCALE = le_LOCALE => 2,SALT20.fn_match_bagofwords(le_LOCALE,ri_LOCALE,0,1) > 0 => 1, -2);
    ri_ADDRS := SALT20.Fn_WordBag_AppendSpecs_Fake((string)ri.ADDRS);//For later scoring
    le_ADDRS := SALT20.Fn_WordBag_AppendSpecs_Fake(trim((string)le.PRIM_RANGE) + ' ' + trim((string)le.PRIM_NAME) + ' ' + trim((string)le.SEC_RANGE) + ' ' + trim((string)le.ZIP4) + ' ' + trim((string)le.COUNTY) + ' ' + trim((string)le.CITY) + ' ' + trim((string)le.STATE) + ' ' + trim((string)le.ZIP));//For later scoring
    SELF.Match_ADDRS := MAP ( ri.ADDRS = (typeof(ri.ADDRS))'' => 0, le_ADDRS = (typeof(ri.ADDRS))'' => -1, ri_ADDRS = le_ADDRS => 2,SALT20.fn_match_bagofwords(le_ADDRS,ri_ADDRS,0,1) > 0 => 1, -2);
    SELF.Record_Score := self.Match_NAME_SUFFIX + self.Match_FNAME + self.Match_MNAME + self.Match_LNAME + self.Match_PRIM_RANGE + self.Match_PRIM_NAME + self.Match_SEC_RANGE + self.Match_CITY + self.Match_STATE + self.Match_ZIP + self.Match_ZIP4 + self.Match_COUNTY + self.Match_SSN5 + self.Match_SSN4 + self.Match_DOB + self.Match_PHONE + self.Match_MAINNAME + self.Match_FULLNAME + self.Match_ADDR1 + self.Match_LOCALE + self.Match_ADDRS;
    SELF.Is_FullMatch := self.Match_NAME_SUFFIX>=0 AND self.Match_FNAME>=0 AND self.Match_MNAME>=0 AND self.Match_LNAME>=0 AND self.Match_PRIM_RANGE>=0 AND self.Match_PRIM_NAME>=0 AND self.Match_SEC_RANGE>=0 AND self.Match_CITY>=0 AND self.Match_STATE>=0 AND self.Match_ZIP>=0 AND self.Match_ZIP4>=0 AND self.Match_COUNTY>=0 AND self.Match_SSN5>=0 AND self.Match_SSN4>=0 AND self.Match_DOB>=0 AND self.Match_PHONE>=0 AND self.Match_MAINNAME>=0 AND self.Match_FULLNAME>=0 AND self.Match_ADDR1>=0 AND self.Match_LOCALE>=0 AND self.Match_ADDRS>=0;
    SELF.Has_FullMatch := SELF.Is_FullMatch; // Filled in later using iterate
    SELF.FullMatch_Required := ri.FullMatch;
    SELF.RecordsOnly := ri.MatchRecords;
    SELF := le;
  END;
  ScoredData := join(Raw_Data,In,left.UniqueId=Right.UniqueId,score_fields(left,right));
  Layout_Matched_Data prop_full(ScoredData le,ScoredData ri) := transform
	SELF.Has_FullMatch := ri.Has_FullMatch OR le.Has_FullMatch AND le.DID=ri.DID AND le.UniqueId=ri.UniqueId;
    SELF := ri;
  end;
  i := iterate( sort( ScoredData,UniqueId,-Has_FullMatch ),prop_full(left,right) );
  // Now narrow down to the required records - note this is switchable per UniqueId
  i1 := i(Has_FullMatch OR ~FullMatch_Required,~RecordsOnly OR Is_FullMatch OR ~FullMatch_Required AND Record_Score>0);
  W1 := IF ( i1.RecordsOnly,i1.Record_Score,i1.Weight );
  export Data_ := dedup(sort(i1,UniqueId,-W1,DID,-(Record_Score+Weight-W1)),whole record);
end;
