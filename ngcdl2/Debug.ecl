// Various routines to assist in debugging
import ngadl,ut;
export Debug(dataset(layout_HEADER) ih, Layout_Specificities s) := module
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
shared h := match_candidates(ih).candidates;
shared MatchThreshold := 47;
shared LowerMatchThreshold := 44; // Keep extra 'borderlines' for debug purposes
export Layout_Sample_Matches := record
  integer2 Conf;
  integer2 Conf_Prop;
  integer2 DateOverlap := 0;
  unsigned6 CDL1;
  unsigned6 CDL2;
  unsigned6 RID1;
  unsigned6 RID2;
  typeof(h.OFFENDER_KEY) left_OFFENDER_KEY;
  integer2 OFFENDER_KEY_score;
  typeof(h.OFFENDER_KEY) right_OFFENDER_KEY;
  typeof(h.DID) left_DID;
  integer2 DID_score;
  typeof(h.DID) right_DID;
  typeof(h.CASE_NUMBER) left_CASE_NUMBER;
  integer2 CASE_NUMBER_score;
  typeof(h.CASE_NUMBER) right_CASE_NUMBER;
  typeof(h.DOC_NUM) left_DOC_NUM;
  integer2 DOC_NUM_score;
  typeof(h.DOC_NUM) right_DOC_NUM;
  typeof(h.DLE_NUM) left_DLE_NUM;
  integer2 DLE_NUM_score;
  typeof(h.DLE_NUM) right_DLE_NUM;
  typeof(h.ID_NUM) left_ID_NUM;
  integer2 ID_NUM_score;
  typeof(h.ID_NUM) right_ID_NUM;
  typeof(h.ORIG_SSN) left_ORIG_SSN;
  integer2 ORIG_SSN_score;
  typeof(h.ORIG_SSN) right_ORIG_SSN;
  typeof(h.FBI_NUM) left_FBI_NUM;
  integer2 FBI_NUM_score;
  typeof(h.FBI_NUM) right_FBI_NUM;
  unsigned6 left_DOB;
  integer2 DOB_score;
  unsigned6 right_DOB;
  typeof(h.PRIM_RANGE) left_PRIM_RANGE;
  integer2 PRIM_RANGE_score;
  typeof(h.PRIM_RANGE) right_PRIM_RANGE;
  typeof(h.LNAME) left_LNAME;
  integer2 LNAME_score;
  typeof(h.LNAME) right_LNAME;
  typeof(h.PRIM_NAME) left_PRIM_NAME;
  integer2 PRIM_NAME_score;
  typeof(h.PRIM_NAME) right_PRIM_NAME;
  typeof(h.DL_NUM) left_DL_NUM;
  integer2 DL_NUM_score;
  typeof(h.DL_NUM) right_DL_NUM;
  typeof(h.FNAME) left_FNAME;
  integer2 FNAME_score;
  typeof(h.FNAME) right_FNAME;
  typeof(h.MNAME) left_MNAME;
  integer2 MNAME_score;
  typeof(h.MNAME) right_MNAME;
  typeof(h.P_CITY_NAME) left_P_CITY_NAME;
  integer2 P_CITY_NAME_score;
  typeof(h.P_CITY_NAME) right_P_CITY_NAME;
  typeof(h.SEC_RANGE) left_SEC_RANGE;
  integer2 SEC_RANGE_score;
  typeof(h.SEC_RANGE) right_SEC_RANGE;
  typeof(h.STATE_ORIGIN) left_STATE_ORIGIN;
  integer2 STATE_ORIGIN_score;
  typeof(h.STATE_ORIGIN) right_STATE_ORIGIN;
  typeof(h.STATE) left_STATE;
  integer2 STATE_score;
  typeof(h.STATE) right_STATE;
  typeof(h.NAME_SUFFIX) left_NAME_SUFFIX;
  integer2 NAME_SUFFIX_score;
  typeof(h.NAME_SUFFIX) right_NAME_SUFFIX;
  typeof(h.TITLE) left_TITLE;
  integer2 TITLE_score;
  typeof(h.TITLE) right_TITLE;
  typeof(h.INS_NUM) left_INS_NUM;
  integer2 INS_NUM_score;
  typeof(h.INS_NUM) right_INS_NUM;
  typeof(h.SOR_NUMBER) left_SOR_NUMBER;
  integer2 SOR_NUMBER_score;
  typeof(h.SOR_NUMBER) right_SOR_NUMBER;
  typeof(h.NCIC_NUMBER) left_NCIC_NUMBER;
  integer2 NCIC_NUMBER_score;
  typeof(h.NCIC_NUMBER) right_NCIC_NUMBER;
  typeof(h.VEH_TAG) left_VEH_TAG;
  integer2 VEH_TAG_score;
  typeof(h.VEH_TAG) right_VEH_TAG;
  typeof(h.VENDOR) left_VENDOR;
  typeof(h.VENDOR) right_VENDOR;
  typeof(h.VEH_STATE) left_VEH_STATE;
  typeof(h.VEH_STATE) right_VEH_STATE;
  typeof(h.DL_STATE) left_DL_STATE;
  typeof(h.DL_STATE) right_DL_STATE;
end;
export layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri) := transform
  self.CDL1 := le.CDL;
  self.CDL2 := ri.CDL;
  self.RID1 := le.RID;
  self.RID2 := ri.RID;
  self.OFFENDER_KEY_score := MAP( le.OFFENDER_KEY  IN SET(s.nulls_OFFENDER_KEY,OFFENDER_KEY) or ri.OFFENDER_KEY  IN SET(s.nulls_OFFENDER_KEY,OFFENDER_KEY) => 0,
                        le.VENDOR <> ri.VENDOR => 0, // Only valid if the context variable is equal
                        le.OFFENDER_KEY = ri.OFFENDER_KEY  => le.OFFENDER_KEY_weight100,
                        ngadl.fail_scale(le.OFFENDER_KEY_weight100,s.OFFENDER_KEY_switch));
  self.left_OFFENDER_KEY := le.OFFENDER_KEY;
  self.right_OFFENDER_KEY := ri.OFFENDER_KEY;
  self.DID_score := MAP( le.DID  IN SET(s.nulls_DID,DID) or ri.DID  IN SET(s.nulls_DID,DID) => 0,
                        le.DID = ri.DID  => le.DID_weight100,
                        ngadl.fail_scale(le.DID_weight100,s.DID_switch));
  self.left_DID := le.DID;
  self.right_DID := ri.DID;
  self.CASE_NUMBER_score := MAP( le.CASE_NUMBER  IN SET(s.nulls_CASE_NUMBER,CASE_NUMBER) or ri.CASE_NUMBER  IN SET(s.nulls_CASE_NUMBER,CASE_NUMBER) => 0,
                        le.STATE_ORIGIN <> ri.STATE_ORIGIN => 0, // Only valid if the context variable is equal
                        le.CASE_NUMBER = ri.CASE_NUMBER  => le.CASE_NUMBER_weight100,
                        ngadl.fail_scale(le.CASE_NUMBER_weight100,s.CASE_NUMBER_switch));
  self.left_CASE_NUMBER := le.CASE_NUMBER;
  self.right_CASE_NUMBER := ri.CASE_NUMBER;
  self.DOC_NUM_score := MAP( le.DOC_NUM  IN SET(s.nulls_DOC_NUM,DOC_NUM) or ri.DOC_NUM  IN SET(s.nulls_DOC_NUM,DOC_NUM) => 0,
                        le.STATE_ORIGIN <> ri.STATE_ORIGIN => 0, // Only valid if the context variable is equal
                        le.DOC_NUM = ri.DOC_NUM  => le.DOC_NUM_weight100,
                        ngadl.fail_scale(le.DOC_NUM_weight100,s.DOC_NUM_switch));
  self.left_DOC_NUM := le.DOC_NUM;
  self.right_DOC_NUM := ri.DOC_NUM;
  self.DLE_NUM_score := MAP( le.DLE_NUM  IN SET(s.nulls_DLE_NUM,DLE_NUM) or ri.DLE_NUM  IN SET(s.nulls_DLE_NUM,DLE_NUM) => 0,
                        le.STATE_ORIGIN <> ri.STATE_ORIGIN => 0, // Only valid if the context variable is equal
                        le.DLE_NUM = ri.DLE_NUM  => le.DLE_NUM_weight100,
                        ngadl.fail_scale(le.DLE_NUM_weight100,s.DLE_NUM_switch));
  self.left_DLE_NUM := le.DLE_NUM;
  self.right_DLE_NUM := ri.DLE_NUM;
  self.ID_NUM_score := MAP( le.ID_NUM  IN SET(s.nulls_ID_NUM,ID_NUM) or ri.ID_NUM  IN SET(s.nulls_ID_NUM,ID_NUM) => 0,
                        le.STATE_ORIGIN <> ri.STATE_ORIGIN => 0, // Only valid if the context variable is equal
                        le.ID_NUM = ri.ID_NUM  => le.ID_NUM_weight100,
                        ngadl.fail_scale(le.ID_NUM_weight100,s.ID_NUM_switch));
  self.left_ID_NUM := le.ID_NUM;
  self.right_ID_NUM := ri.ID_NUM;
  self.ORIG_SSN_score := MAP( le.ORIG_SSN  IN SET(s.nulls_ORIG_SSN,ORIG_SSN) or ri.ORIG_SSN  IN SET(s.nulls_ORIG_SSN,ORIG_SSN) => 0,
                        le.ORIG_SSN = ri.ORIG_SSN  => le.ORIG_SSN_weight100,
                        ut.stringsimilar(le.ORIG_SSN,ri.ORIG_SSN) <= 1 => ngadl.fuzzy_specificity(le.ORIG_SSN_weight100,le.ORIG_SSN_cnt, le.ORIG_SSN_e1_cnt,ri.ORIG_SSN_weight100,ri.ORIG_SSN_cnt,ri.ORIG_SSN_e1_cnt),
                        ngadl.fail_scale(le.ORIG_SSN_weight100,s.ORIG_SSN_switch));
  self.left_ORIG_SSN := le.ORIG_SSN;
  self.right_ORIG_SSN := ri.ORIG_SSN;
  self.FBI_NUM_score := MAP( le.FBI_NUM  IN SET(s.nulls_FBI_NUM,FBI_NUM) or ri.FBI_NUM  IN SET(s.nulls_FBI_NUM,FBI_NUM) => 0,
                        le.FBI_NUM = ri.FBI_NUM  => le.FBI_NUM_weight100,
                        ngadl.fail_scale(le.FBI_NUM_weight100,s.FBI_NUM_switch));
  self.left_FBI_NUM := le.FBI_NUM;
  self.right_FBI_NUM := ri.FBI_NUM;
  integer2 DOB_year       := MAP ( le.DOB_year in SET(s.nulls_DOB_year,DOB_year) or ri.DOB_year in SET(s.nulls_DOB_year,DOB_year) => 0,
                                  le.DOB_year = ri.DOB_year => le.DOB_year_weight100,
                                  ngadl.fail_scale(le.DOB_year_weight100,s.DOB_year_switch) );
  integer2 DOB_month       := MAP ( le.DOB_month in SET(s.nulls_DOB_month,DOB_month) or ri.DOB_month in SET(s.nulls_DOB_month,DOB_month) => 0,
                                  le.DOB_month = ri.DOB_month => le.DOB_month_weight100,
                                  ngadl.fail_scale(le.DOB_month_weight100,s.DOB_month_switch) );
  integer2 DOB_day       := MAP ( le.DOB_day in SET(s.nulls_DOB_day,DOB_day) or ri.DOB_day in SET(s.nulls_DOB_day,DOB_day) => 0,
                                  le.DOB_day = ri.DOB_day => le.DOB_day_weight100,
                                  ngadl.fail_scale(le.DOB_day_weight100,s.DOB_day_switch) );
  self.DOB_score := MAP( le.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND le.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND le.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) or ri.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND ri.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND ri.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) => 0,
                        DOB_year+DOB_month+DOB_day < 0 or DOB_year+DOB_month+DOB_day<>0 and DOB_year+DOB_month+DOB_day < 700 => SKIP,
                        DOB_year+DOB_month+DOB_day);
  self.left_DOB := (( le.DOB_year * 100 ) + le.DOB_month ) * 100 + le.DOB_day;
  self.right_DOB := (( ri.DOB_year * 100 ) + ri.DOB_month ) * 100 + ri.DOB_day;
  self.PRIM_RANGE_score := MAP( le.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) or ri.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) => 0,
                        le.PRIM_RANGE = ri.PRIM_RANGE  => le.PRIM_RANGE_weight100,
                        ngadl.fail_scale(le.PRIM_RANGE_weight100,s.PRIM_RANGE_switch));
  self.left_PRIM_RANGE := le.PRIM_RANGE;
  self.right_PRIM_RANGE := ri.PRIM_RANGE;
  self.LNAME_score := MAP( le.LNAME  IN SET(s.nulls_LNAME,LNAME) or ri.LNAME  IN SET(s.nulls_LNAME,LNAME) or le.LNAME_weight100 = 0 => SKIP,
                        le.LNAME = ri.LNAME  => le.LNAME_weight100,
                        ut.stringsimilar(le.LNAME,ri.LNAME) <= 2 => ngadl.fuzzy_specificity(le.LNAME_weight100,le.LNAME_cnt, le.LNAME_e2_cnt,ri.LNAME_weight100,ri.LNAME_cnt,ri.LNAME_e2_cnt),
                        SKIP);
  self.left_LNAME := le.LNAME;
  self.right_LNAME := ri.LNAME;
  self.PRIM_NAME_score := MAP( le.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) or ri.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) => 0,
                        le.PRIM_NAME = ri.PRIM_NAME  => le.PRIM_NAME_weight100,
                        ngadl.fail_scale(le.PRIM_NAME_weight100,s.PRIM_NAME_switch));
  self.left_PRIM_NAME := le.PRIM_NAME;
  self.right_PRIM_NAME := ri.PRIM_NAME;
  self.DL_NUM_score := MAP( le.DL_NUM  IN SET(s.nulls_DL_NUM,DL_NUM) or ri.DL_NUM  IN SET(s.nulls_DL_NUM,DL_NUM) => 0,
                        le.DL_STATE <> ri.DL_STATE => 0, // Only valid if the context variable is equal
                        le.DL_NUM = ri.DL_NUM  => le.DL_NUM_weight100,
                        ngadl.fail_scale(le.DL_NUM_weight100,s.DL_NUM_switch));
  self.left_DL_NUM := le.DL_NUM;
  self.right_DL_NUM := ri.DL_NUM;
  self.FNAME_score := MAP( le.FNAME  IN SET(s.nulls_FNAME,FNAME) or ri.FNAME  IN SET(s.nulls_FNAME,FNAME) or le.FNAME_weight100 = 0 => SKIP,
                        le.FNAME = ri.FNAME  => le.FNAME_weight100,
                        ut.stringsimilar(le.FNAME,ri.FNAME) <= 2 => ngadl.fuzzy_specificity(le.FNAME_weight100,le.FNAME_cnt, le.FNAME_e2_cnt,ri.FNAME_weight100,ri.FNAME_cnt,ri.FNAME_e2_cnt),
                        length(trim(le.FNAME))>0 and le.FNAME = ri.FNAME[length(trim(le.FNAME))] => le.FNAME_weight100, // An initial match - take initial specificity
                        length(trim(ri.FNAME))>0 and ri.FNAME = le.FNAME[length(trim(ri.FNAME))] => ri.FNAME_weight100,// An initial match - take initial specificity
                        SKIP);
  self.left_FNAME := le.FNAME;
  self.right_FNAME := ri.FNAME;
  self.MNAME_score := MAP( le.MNAME  IN SET(s.nulls_MNAME,MNAME) or ri.MNAME  IN SET(s.nulls_MNAME,MNAME) => 0,
                        le.MNAME = ri.MNAME  => le.MNAME_weight100,
                        ut.stringsimilar(le.MNAME,ri.MNAME) <= 2 => ngadl.fuzzy_specificity(le.MNAME_weight100,le.MNAME_cnt, le.MNAME_e2_cnt,ri.MNAME_weight100,ri.MNAME_cnt,ri.MNAME_e2_cnt),
                        length(trim(le.MNAME))>0 and le.MNAME = ri.MNAME[length(trim(le.MNAME))] => le.MNAME_weight100, // An initial match - take initial specificity
                        length(trim(ri.MNAME))>0 and ri.MNAME = le.MNAME[length(trim(ri.MNAME))] => ri.MNAME_weight100,// An initial match - take initial specificity
                        ngadl.fail_scale(le.MNAME_weight100,s.MNAME_switch));
  self.left_MNAME := le.MNAME;
  self.right_MNAME := ri.MNAME;
  self.P_CITY_NAME_score := MAP( le.P_CITY_NAME  IN SET(s.nulls_P_CITY_NAME,P_CITY_NAME) or ri.P_CITY_NAME  IN SET(s.nulls_P_CITY_NAME,P_CITY_NAME) => 0,
                        le.P_CITY_NAME = ri.P_CITY_NAME  => le.P_CITY_NAME_weight100,
                        ngadl.fail_scale(le.P_CITY_NAME_weight100,s.P_CITY_NAME_switch));
  self.left_P_CITY_NAME := le.P_CITY_NAME;
  self.right_P_CITY_NAME := ri.P_CITY_NAME;
  self.SEC_RANGE_score := MAP( le.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) or ri.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) => 0,
                        le.SEC_RANGE = ri.SEC_RANGE  => le.SEC_RANGE_weight100,
                        ngadl.fail_scale(le.SEC_RANGE_weight100,s.SEC_RANGE_switch));
  self.left_SEC_RANGE := le.SEC_RANGE;
  self.right_SEC_RANGE := ri.SEC_RANGE;
  integer2 STATE_ORIGIN_score_temp := MAP( le.STATE_ORIGIN  IN SET(s.nulls_STATE_ORIGIN,STATE_ORIGIN) or ri.STATE_ORIGIN  IN SET(s.nulls_STATE_ORIGIN,STATE_ORIGIN) => 0,
                        le.STATE_ORIGIN = ri.STATE_ORIGIN  => le.STATE_ORIGIN_weight100,
                        SKIP);
  self.STATE_ORIGIN_score := IF ( STATE_ORIGIN_score_temp >= 700, STATE_ORIGIN_score_temp, SKIP ); // Enforce FORCE parameter
  self.left_STATE_ORIGIN := le.STATE_ORIGIN;
  self.right_STATE_ORIGIN := ri.STATE_ORIGIN;
  self.STATE_score := MAP( le.STATE  IN SET(s.nulls_STATE,STATE) or ri.STATE  IN SET(s.nulls_STATE,STATE) => 0,
                        le.STATE = ri.STATE  => le.STATE_weight100,
                        ngadl.fail_scale(le.STATE_weight100,s.STATE_switch));
  self.left_STATE := le.STATE;
  self.right_STATE := ri.STATE;
  self.NAME_SUFFIX_score := MAP( le.NAME_SUFFIX  IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX) or ri.NAME_SUFFIX  IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX) => 0,
                        le.NAME_SUFFIX = ri.NAME_SUFFIX  => le.NAME_SUFFIX_weight100,
                        SKIP);
  self.left_NAME_SUFFIX := le.NAME_SUFFIX;
  self.right_NAME_SUFFIX := ri.NAME_SUFFIX;
  self.TITLE_score := MAP( le.TITLE  IN SET(s.nulls_TITLE,TITLE) or ri.TITLE  IN SET(s.nulls_TITLE,TITLE) => 0,
                        le.TITLE = ri.TITLE  => le.TITLE_weight100,
                        SKIP);
  self.left_TITLE := le.TITLE;
  self.right_TITLE := ri.TITLE;
  self.INS_NUM_score := MAP( le.INS_NUM  IN SET(s.nulls_INS_NUM,INS_NUM) or ri.INS_NUM  IN SET(s.nulls_INS_NUM,INS_NUM) => 0,
                        le.INS_NUM = ri.INS_NUM  => le.INS_NUM_weight100,
                        ngadl.fail_scale(le.INS_NUM_weight100,s.INS_NUM_switch));
  self.left_INS_NUM := le.INS_NUM;
  self.right_INS_NUM := ri.INS_NUM;
  self.SOR_NUMBER_score := MAP( le.SOR_NUMBER  IN SET(s.nulls_SOR_NUMBER,SOR_NUMBER) or ri.SOR_NUMBER  IN SET(s.nulls_SOR_NUMBER,SOR_NUMBER) => 0,
                        le.STATE_ORIGIN <> ri.STATE_ORIGIN => 0, // Only valid if the context variable is equal
                        le.SOR_NUMBER = ri.SOR_NUMBER  => le.SOR_NUMBER_weight100,
                        ngadl.fail_scale(le.SOR_NUMBER_weight100,s.SOR_NUMBER_switch));
  self.left_SOR_NUMBER := le.SOR_NUMBER;
  self.right_SOR_NUMBER := ri.SOR_NUMBER;
  self.NCIC_NUMBER_score := MAP( le.NCIC_NUMBER  IN SET(s.nulls_NCIC_NUMBER,NCIC_NUMBER) or ri.NCIC_NUMBER  IN SET(s.nulls_NCIC_NUMBER,NCIC_NUMBER) => 0,
                        le.NCIC_NUMBER = ri.NCIC_NUMBER  => le.NCIC_NUMBER_weight100,
                        ngadl.fail_scale(le.NCIC_NUMBER_weight100,s.NCIC_NUMBER_switch));
  self.left_NCIC_NUMBER := le.NCIC_NUMBER;
  self.right_NCIC_NUMBER := ri.NCIC_NUMBER;
  self.VEH_TAG_score := MAP( le.VEH_TAG  IN SET(s.nulls_VEH_TAG,VEH_TAG) or ri.VEH_TAG  IN SET(s.nulls_VEH_TAG,VEH_TAG) => 0,
                        le.VEH_STATE <> ri.VEH_STATE => 0, // Only valid if the context variable is equal
                        le.VEH_TAG = ri.VEH_TAG  => le.VEH_TAG_weight100,
                        ngadl.fail_scale(le.VEH_TAG_weight100,s.VEH_TAG_switch));
  self.left_VEH_TAG := le.VEH_TAG;
  self.right_VEH_TAG := ri.VEH_TAG;
  self.left_VENDOR := le.VENDOR;
  self.right_VENDOR := ri.VENDOR;
  self.left_VEH_STATE := le.VEH_STATE;
  self.right_VEH_STATE := ri.VEH_STATE;
  self.left_DL_STATE := le.DL_STATE;
  self.right_DL_STATE := ri.DL_STATE;
  self.Conf_Prop := (if(le.DID_prop or ri.DID_prop,self.DID_score,0) + if(le.DLE_NUM_prop or ri.DLE_NUM_prop,self.DLE_NUM_score,0) + if(le.ORIG_SSN_prop or ri.ORIG_SSN_prop,self.ORIG_SSN_score,0) + if(le.FBI_NUM_prop or ri.FBI_NUM_prop,self.FBI_NUM_score,0) + if(le.DOB_prop or ri.DOB_prop,self.DOB_score,0) + if(le.FNAME_prop or ri.FNAME_prop,self.FNAME_score,0) + if(le.MNAME_prop or ri.MNAME_prop,self.MNAME_score,0) + if(le.INS_NUM_prop or ri.INS_NUM_prop,self.INS_NUM_score,0) + if(le.NCIC_NUMBER_prop or ri.NCIC_NUMBER_prop,self.NCIC_NUMBER_score,0)) / 100; // Score based on propogated fields
  self.Conf := (self.OFFENDER_KEY_score + self.DID_score + self.CASE_NUMBER_score + self.DOC_NUM_score + self.DLE_NUM_score + self.ID_NUM_score + self.ORIG_SSN_score + self.FBI_NUM_score + self.DOB_score + self.PRIM_RANGE_score + self.LNAME_score + self.PRIM_NAME_score + self.DL_NUM_score + self.FNAME_score + self.MNAME_score + self.P_CITY_NAME_score + self.SEC_RANGE_score + self.STATE_ORIGIN_score + self.STATE_score + self.NAME_SUFFIX_score + self.TITLE_score + self.INS_NUM_score + self.SOR_NUMBER_score + self.NCIC_NUMBER_score + self.VEH_TAG_score) / 100;
end;
export AnnotateMatchesFromData(dataset(match_candidates(ih).layout_candidates) in_data,dataset(match_candidates(ih).layout_matches)  im) := function
  j1 := join(in_data,im,left.CDL = right.CDL1,hash);
  match_candidates(ih).layout_candidates strim(j1 le) := transform
    self := le;
  end;
  r := join(j1,in_data,left.CDL2 = right.CDL,sample_match_join( project(left,strim(left)),right),hash);
  return dedup( sort( r, CDL1, CDL2, -Conf, local ), CDL1, CDL2, local ); // CDL2 distributed by join
end;
export AnnotateMatchesFromRecordData(dataset(match_candidates(ih).layout_candidates) in_data,dataset(match_candidates(ih).layout_matches)  im) := function//Faster form when RID known
  j1 := join(in_data,im,left.RID = right.RID1,hash);
  match_candidates(ih).layout_candidates strim(j1 le) := transform
    self := le;
  end;
  return join(j1,in_data,left.RID2 = right.RID,sample_match_join( project(left,strim(left)),right),hash);
end;
export AnnotateMatches(dataset(match_candidates(ih).layout_matches)  im) := function
  return AnnotateMatchesFromRecordData(h,im);
end;
shared Layout_FieldValueList := record,maxlength(2096)
  STRING Val;
end;
export Layout_RolledEntity := record,maxlength(63000)
  unsigned6 CDL;
  dataset(Layout_FieldValueList) OFFENDER_KEY_Values;
  dataset(Layout_FieldValueList) DID_Values;
  dataset(Layout_FieldValueList) CASE_NUMBER_Values;
  dataset(Layout_FieldValueList) DOC_NUM_Values;
  dataset(Layout_FieldValueList) DLE_NUM_Values;
  dataset(Layout_FieldValueList) ID_NUM_Values;
  dataset(Layout_FieldValueList) ORIG_SSN_Values;
  dataset(Layout_FieldValueList) FBI_NUM_Values;
  dataset(Layout_FieldValueList) DOB_Values;
  dataset(Layout_FieldValueList) PRIM_RANGE_Values;
  dataset(Layout_FieldValueList) LNAME_Values;
  dataset(Layout_FieldValueList) PRIM_NAME_Values;
  dataset(Layout_FieldValueList) DL_NUM_Values;
  dataset(Layout_FieldValueList) FNAME_Values;
  dataset(Layout_FieldValueList) MNAME_Values;
  dataset(Layout_FieldValueList) P_CITY_NAME_Values;
  dataset(Layout_FieldValueList) SEC_RANGE_Values;
  dataset(Layout_FieldValueList) STATE_ORIGIN_Values;
  dataset(Layout_FieldValueList) STATE_Values;
  dataset(Layout_FieldValueList) NAME_SUFFIX_Values;
  dataset(Layout_FieldValueList) TITLE_Values;
  dataset(Layout_FieldValueList) INS_NUM_Values;
  dataset(Layout_FieldValueList) SOR_NUMBER_Values;
  dataset(Layout_FieldValueList) NCIC_NUMBER_Values;
  dataset(Layout_FieldValueList) VEH_TAG_Values;
  dataset(Layout_FieldValueList) VENDOR_Values;
  dataset(Layout_FieldValueList) VEH_STATE_Values;
  dataset(Layout_FieldValueList) DL_STATE_Values;
end;
export RolledEntities(dataset(match_candidates(ih).layout_candidates) in_data) := function
Layout_RolledEntity into(in_data le) := transform
  self.CDL := le.CDL;
  self.OFFENDER_KEY_Values := IF ( le.OFFENDER_KEY IN SET(s.nulls_OFFENDER_KEY,OFFENDER_KEY),dataset([],Layout_FieldValueList),dataset([{trim((string)le.OFFENDER_KEY)}],Layout_FieldValueList));
  self.DID_Values := IF ( le.DID IN SET(s.nulls_DID,DID),dataset([],Layout_FieldValueList),dataset([{trim((string)le.DID)}],Layout_FieldValueList));
  self.CASE_NUMBER_Values := IF ( le.CASE_NUMBER IN SET(s.nulls_CASE_NUMBER,CASE_NUMBER),dataset([],Layout_FieldValueList),dataset([{trim((string)le.CASE_NUMBER)}],Layout_FieldValueList));
  self.DOC_NUM_Values := IF ( le.DOC_NUM IN SET(s.nulls_DOC_NUM,DOC_NUM),dataset([],Layout_FieldValueList),dataset([{trim((string)le.DOC_NUM)}],Layout_FieldValueList));
  self.DLE_NUM_Values := IF ( le.DLE_NUM IN SET(s.nulls_DLE_NUM,DLE_NUM),dataset([],Layout_FieldValueList),dataset([{trim((string)le.DLE_NUM)}],Layout_FieldValueList));
  self.ID_NUM_Values := IF ( le.ID_NUM IN SET(s.nulls_ID_NUM,ID_NUM),dataset([],Layout_FieldValueList),dataset([{trim((string)le.ID_NUM)}],Layout_FieldValueList));
  self.ORIG_SSN_Values := IF ( le.ORIG_SSN IN SET(s.nulls_ORIG_SSN,ORIG_SSN),dataset([],Layout_FieldValueList),dataset([{trim((string)le.ORIG_SSN)}],Layout_FieldValueList));
  self.FBI_NUM_Values := IF ( le.FBI_NUM IN SET(s.nulls_FBI_NUM,FBI_NUM),dataset([],Layout_FieldValueList),dataset([{trim((string)le.FBI_NUM)}],Layout_FieldValueList));
  self.DOB_Values := IF ( le.DOB_year IN SET(s.nulls_DOB_year,DOB_year) and le.DOB_month IN SET(s.nulls_DOB_month,DOB_month) and le.DOB_day IN SET(s.nulls_DOB_day,DOB_day),dataset([],Layout_FieldValueList),dataset([{trim((string)le.DOB_month)+'/'+trim((string)le.DOB_day)+'/'+trim((string)le.DOB_year)}],Layout_FieldValueList));
  self.PRIM_RANGE_Values := IF ( le.PRIM_RANGE IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE),dataset([],Layout_FieldValueList),dataset([{trim((string)le.PRIM_RANGE)}],Layout_FieldValueList));
  self.LNAME_Values := IF ( le.LNAME IN SET(s.nulls_LNAME,LNAME),dataset([],Layout_FieldValueList),dataset([{trim((string)le.LNAME)}],Layout_FieldValueList));
  self.PRIM_NAME_Values := IF ( le.PRIM_NAME IN SET(s.nulls_PRIM_NAME,PRIM_NAME),dataset([],Layout_FieldValueList),dataset([{trim((string)le.PRIM_NAME)}],Layout_FieldValueList));
  self.DL_NUM_Values := IF ( le.DL_NUM IN SET(s.nulls_DL_NUM,DL_NUM),dataset([],Layout_FieldValueList),dataset([{trim((string)le.DL_NUM)}],Layout_FieldValueList));
  self.FNAME_Values := IF ( le.FNAME IN SET(s.nulls_FNAME,FNAME),dataset([],Layout_FieldValueList),dataset([{trim((string)le.FNAME)}],Layout_FieldValueList));
  self.MNAME_Values := IF ( le.MNAME IN SET(s.nulls_MNAME,MNAME),dataset([],Layout_FieldValueList),dataset([{trim((string)le.MNAME)}],Layout_FieldValueList));
  self.P_CITY_NAME_Values := IF ( le.P_CITY_NAME IN SET(s.nulls_P_CITY_NAME,P_CITY_NAME),dataset([],Layout_FieldValueList),dataset([{trim((string)le.P_CITY_NAME)}],Layout_FieldValueList));
  self.SEC_RANGE_Values := IF ( le.SEC_RANGE IN SET(s.nulls_SEC_RANGE,SEC_RANGE),dataset([],Layout_FieldValueList),dataset([{trim((string)le.SEC_RANGE)}],Layout_FieldValueList));
  self.STATE_ORIGIN_Values := IF ( le.STATE_ORIGIN IN SET(s.nulls_STATE_ORIGIN,STATE_ORIGIN),dataset([],Layout_FieldValueList),dataset([{trim((string)le.STATE_ORIGIN)}],Layout_FieldValueList));
  self.STATE_Values := IF ( le.STATE IN SET(s.nulls_STATE,STATE),dataset([],Layout_FieldValueList),dataset([{trim((string)le.STATE)}],Layout_FieldValueList));
  self.NAME_SUFFIX_Values := IF ( le.NAME_SUFFIX IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX),dataset([],Layout_FieldValueList),dataset([{trim((string)le.NAME_SUFFIX)}],Layout_FieldValueList));
  self.TITLE_Values := IF ( le.TITLE IN SET(s.nulls_TITLE,TITLE),dataset([],Layout_FieldValueList),dataset([{trim((string)le.TITLE)}],Layout_FieldValueList));
  self.INS_NUM_Values := IF ( le.INS_NUM IN SET(s.nulls_INS_NUM,INS_NUM),dataset([],Layout_FieldValueList),dataset([{trim((string)le.INS_NUM)}],Layout_FieldValueList));
  self.SOR_NUMBER_Values := IF ( le.SOR_NUMBER IN SET(s.nulls_SOR_NUMBER,SOR_NUMBER),dataset([],Layout_FieldValueList),dataset([{trim((string)le.SOR_NUMBER)}],Layout_FieldValueList));
  self.NCIC_NUMBER_Values := IF ( le.NCIC_NUMBER IN SET(s.nulls_NCIC_NUMBER,NCIC_NUMBER),dataset([],Layout_FieldValueList),dataset([{trim((string)le.NCIC_NUMBER)}],Layout_FieldValueList));
  self.VEH_TAG_Values := IF ( le.VEH_TAG IN SET(s.nulls_VEH_TAG,VEH_TAG),dataset([],Layout_FieldValueList),dataset([{trim((string)le.VEH_TAG)}],Layout_FieldValueList));
  self.VENDOR_Values := dataset([{trim((string)le.VENDOR)}],Layout_FieldValueList);
  self.VEH_STATE_Values := dataset([{trim((string)le.VEH_STATE)}],Layout_FieldValueList);
  self.DL_STATE_Values := dataset([{trim((string)le.DL_STATE)}],Layout_FieldValueList);
end;
AsFieldValues := project(in_data,into(left));
Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := transform
  self.CDL := le.CDL;
  self.OFFENDER_KEY_values := if ( count(le.OFFENDER_KEY_values)>=100 or exists(le.OFFENDER_KEY_values(Val=ri.OFFENDER_KEY_values[1].Val)), le.OFFENDER_KEY_values, le.OFFENDER_KEY_values+ri.OFFENDER_KEY_values);
  self.DID_values := if ( count(le.DID_values)>=100 or exists(le.DID_values(Val=ri.DID_values[1].Val)), le.DID_values, le.DID_values+ri.DID_values);
  self.CASE_NUMBER_values := if ( count(le.CASE_NUMBER_values)>=100 or exists(le.CASE_NUMBER_values(Val=ri.CASE_NUMBER_values[1].Val)), le.CASE_NUMBER_values, le.CASE_NUMBER_values+ri.CASE_NUMBER_values);
  self.DOC_NUM_values := if ( count(le.DOC_NUM_values)>=100 or exists(le.DOC_NUM_values(Val=ri.DOC_NUM_values[1].Val)), le.DOC_NUM_values, le.DOC_NUM_values+ri.DOC_NUM_values);
  self.DLE_NUM_values := if ( count(le.DLE_NUM_values)>=100 or exists(le.DLE_NUM_values(Val=ri.DLE_NUM_values[1].Val)), le.DLE_NUM_values, le.DLE_NUM_values+ri.DLE_NUM_values);
  self.ID_NUM_values := if ( count(le.ID_NUM_values)>=100 or exists(le.ID_NUM_values(Val=ri.ID_NUM_values[1].Val)), le.ID_NUM_values, le.ID_NUM_values+ri.ID_NUM_values);
  self.ORIG_SSN_values := if ( count(le.ORIG_SSN_values)>=100 or exists(le.ORIG_SSN_values(Val=ri.ORIG_SSN_values[1].Val)), le.ORIG_SSN_values, le.ORIG_SSN_values+ri.ORIG_SSN_values);
  self.FBI_NUM_values := if ( count(le.FBI_NUM_values)>=100 or exists(le.FBI_NUM_values(Val=ri.FBI_NUM_values[1].Val)), le.FBI_NUM_values, le.FBI_NUM_values+ri.FBI_NUM_values);
  self.DOB_values := if ( count(le.DOB_values)>=100 or exists(le.DOB_values(Val=ri.DOB_values[1].Val)), le.DOB_values, le.DOB_values+ri.DOB_values);
  self.PRIM_RANGE_values := if ( count(le.PRIM_RANGE_values)>=100 or exists(le.PRIM_RANGE_values(Val=ri.PRIM_RANGE_values[1].Val)), le.PRIM_RANGE_values, le.PRIM_RANGE_values+ri.PRIM_RANGE_values);
  self.LNAME_values := if ( count(le.LNAME_values)>=100 or exists(le.LNAME_values(Val=ri.LNAME_values[1].Val)), le.LNAME_values, le.LNAME_values+ri.LNAME_values);
  self.PRIM_NAME_values := if ( count(le.PRIM_NAME_values)>=100 or exists(le.PRIM_NAME_values(Val=ri.PRIM_NAME_values[1].Val)), le.PRIM_NAME_values, le.PRIM_NAME_values+ri.PRIM_NAME_values);
  self.DL_NUM_values := if ( count(le.DL_NUM_values)>=100 or exists(le.DL_NUM_values(Val=ri.DL_NUM_values[1].Val)), le.DL_NUM_values, le.DL_NUM_values+ri.DL_NUM_values);
  self.FNAME_values := if ( count(le.FNAME_values)>=100 or exists(le.FNAME_values(Val=ri.FNAME_values[1].Val)), le.FNAME_values, le.FNAME_values+ri.FNAME_values);
  self.MNAME_values := if ( count(le.MNAME_values)>=100 or exists(le.MNAME_values(Val=ri.MNAME_values[1].Val)), le.MNAME_values, le.MNAME_values+ri.MNAME_values);
  self.P_CITY_NAME_values := if ( count(le.P_CITY_NAME_values)>=100 or exists(le.P_CITY_NAME_values(Val=ri.P_CITY_NAME_values[1].Val)), le.P_CITY_NAME_values, le.P_CITY_NAME_values+ri.P_CITY_NAME_values);
  self.SEC_RANGE_values := if ( count(le.SEC_RANGE_values)>=100 or exists(le.SEC_RANGE_values(Val=ri.SEC_RANGE_values[1].Val)), le.SEC_RANGE_values, le.SEC_RANGE_values+ri.SEC_RANGE_values);
  self.STATE_ORIGIN_values := if ( count(le.STATE_ORIGIN_values)>=100 or exists(le.STATE_ORIGIN_values(Val=ri.STATE_ORIGIN_values[1].Val)), le.STATE_ORIGIN_values, le.STATE_ORIGIN_values+ri.STATE_ORIGIN_values);
  self.STATE_values := if ( count(le.STATE_values)>=100 or exists(le.STATE_values(Val=ri.STATE_values[1].Val)), le.STATE_values, le.STATE_values+ri.STATE_values);
  self.NAME_SUFFIX_values := if ( count(le.NAME_SUFFIX_values)>=100 or exists(le.NAME_SUFFIX_values(Val=ri.NAME_SUFFIX_values[1].Val)), le.NAME_SUFFIX_values, le.NAME_SUFFIX_values+ri.NAME_SUFFIX_values);
  self.TITLE_values := if ( count(le.TITLE_values)>=100 or exists(le.TITLE_values(Val=ri.TITLE_values[1].Val)), le.TITLE_values, le.TITLE_values+ri.TITLE_values);
  self.INS_NUM_values := if ( count(le.INS_NUM_values)>=100 or exists(le.INS_NUM_values(Val=ri.INS_NUM_values[1].Val)), le.INS_NUM_values, le.INS_NUM_values+ri.INS_NUM_values);
  self.SOR_NUMBER_values := if ( count(le.SOR_NUMBER_values)>=100 or exists(le.SOR_NUMBER_values(Val=ri.SOR_NUMBER_values[1].Val)), le.SOR_NUMBER_values, le.SOR_NUMBER_values+ri.SOR_NUMBER_values);
  self.NCIC_NUMBER_values := if ( count(le.NCIC_NUMBER_values)>=100 or exists(le.NCIC_NUMBER_values(Val=ri.NCIC_NUMBER_values[1].Val)), le.NCIC_NUMBER_values, le.NCIC_NUMBER_values+ri.NCIC_NUMBER_values);
  self.VEH_TAG_values := if ( count(le.VEH_TAG_values)>=100 or exists(le.VEH_TAG_values(Val=ri.VEH_TAG_values[1].Val)), le.VEH_TAG_values, le.VEH_TAG_values+ri.VEH_TAG_values);
  self.VENDOR_values := if ( count(le.VENDOR_values)>=100 or exists(le.VENDOR_values(Val=ri.VENDOR_values[1].Val)), le.VENDOR_values, le.VENDOR_values+ri.VENDOR_values);
  self.VEH_STATE_values := if ( count(le.VEH_STATE_values)>=100 or exists(le.VEH_STATE_values(Val=ri.VEH_STATE_values[1].Val)), le.VEH_STATE_values, le.VEH_STATE_values+ri.VEH_STATE_values);
  self.DL_STATE_values := if ( count(le.DL_STATE_values)>=100 or exists(le.DL_STATE_values(Val=ri.DL_STATE_values[1].Val)), le.DL_STATE_values, le.DL_STATE_values+ri.DL_STATE_values);
end;
  return rollup( sort( distribute( AsFieldValues, CDL ), CDL, local ), left.CDL = right.CDL, RollValues(left,right),local);
end;
end;
