// Begin code to perform the matching itself
import ngadl,ut;
export matches(dataset(layout_HEADER) ih) := module
shared h := match_candidates(ih).candidates;
shared MatchThreshold := 47;
shared LowerMatchThreshold := 44; // Keep extra 'borderlines' for debug purposes
shared s := global(table(Specificities(ih).Specificities,Layout_Specificities)[1]); // Bug 29550
match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,unsigned2 c) := transform
  self.Rule := c;
  self.CDL1 := le.CDL;
  self.CDL2 := ri.CDL;
  self.RID1 := le.RID;
  self.RID2 := ri.RID;
  integer2 OFFENDER_KEY_score := MAP( le.OFFENDER_KEY  IN SET(s.nulls_OFFENDER_KEY,OFFENDER_KEY) or ri.OFFENDER_KEY  IN SET(s.nulls_OFFENDER_KEY,OFFENDER_KEY) => 0,
                        le.VENDOR <> ri.VENDOR => 0, // Only valid if the context variable is equal
                        le.OFFENDER_KEY = ri.OFFENDER_KEY  => le.OFFENDER_KEY_weight100,
                        ngadl.fail_scale(le.OFFENDER_KEY_weight100,s.OFFENDER_KEY_switch));
  integer2 DID_score := MAP( le.DID  IN SET(s.nulls_DID,DID) or ri.DID  IN SET(s.nulls_DID,DID) => 0,
                        le.DID = ri.DID  => le.DID_weight100,
                        ngadl.fail_scale(le.DID_weight100,s.DID_switch));
  integer2 CASE_NUMBER_score := MAP( le.CASE_NUMBER  IN SET(s.nulls_CASE_NUMBER,CASE_NUMBER) or ri.CASE_NUMBER  IN SET(s.nulls_CASE_NUMBER,CASE_NUMBER) => 0,
                        le.STATE_ORIGIN <> ri.STATE_ORIGIN => 0, // Only valid if the context variable is equal
                        le.CASE_NUMBER = ri.CASE_NUMBER  => le.CASE_NUMBER_weight100,
                        ngadl.fail_scale(le.CASE_NUMBER_weight100,s.CASE_NUMBER_switch));
  integer2 DOC_NUM_score := MAP( le.DOC_NUM  IN SET(s.nulls_DOC_NUM,DOC_NUM) or ri.DOC_NUM  IN SET(s.nulls_DOC_NUM,DOC_NUM) => 0,
                        le.STATE_ORIGIN <> ri.STATE_ORIGIN => 0, // Only valid if the context variable is equal
                        le.DOC_NUM = ri.DOC_NUM  => le.DOC_NUM_weight100,
                        ngadl.fail_scale(le.DOC_NUM_weight100,s.DOC_NUM_switch));
  integer2 DLE_NUM_score := MAP( le.DLE_NUM  IN SET(s.nulls_DLE_NUM,DLE_NUM) or ri.DLE_NUM  IN SET(s.nulls_DLE_NUM,DLE_NUM) => 0,
                        le.STATE_ORIGIN <> ri.STATE_ORIGIN => 0, // Only valid if the context variable is equal
                        le.DLE_NUM = ri.DLE_NUM  => le.DLE_NUM_weight100,
                        ngadl.fail_scale(le.DLE_NUM_weight100,s.DLE_NUM_switch));
  integer2 ID_NUM_score := MAP( le.ID_NUM  IN SET(s.nulls_ID_NUM,ID_NUM) or ri.ID_NUM  IN SET(s.nulls_ID_NUM,ID_NUM) => 0,
                        le.STATE_ORIGIN <> ri.STATE_ORIGIN => 0, // Only valid if the context variable is equal
                        le.ID_NUM = ri.ID_NUM  => le.ID_NUM_weight100,
                        ngadl.fail_scale(le.ID_NUM_weight100,s.ID_NUM_switch));
  integer2 ORIG_SSN_score := MAP( le.ORIG_SSN  IN SET(s.nulls_ORIG_SSN,ORIG_SSN) or ri.ORIG_SSN  IN SET(s.nulls_ORIG_SSN,ORIG_SSN) => 0,
                        le.ORIG_SSN = ri.ORIG_SSN  => le.ORIG_SSN_weight100,
                        ut.stringsimilar(le.ORIG_SSN,ri.ORIG_SSN) <= 1 => ngadl.fuzzy_specificity(le.ORIG_SSN_weight100,le.ORIG_SSN_cnt, le.ORIG_SSN_e1_cnt,ri.ORIG_SSN_weight100,ri.ORIG_SSN_cnt,ri.ORIG_SSN_e1_cnt),
                        ngadl.fail_scale(le.ORIG_SSN_weight100,s.ORIG_SSN_switch));
  integer2 FBI_NUM_score := MAP( le.FBI_NUM  IN SET(s.nulls_FBI_NUM,FBI_NUM) or ri.FBI_NUM  IN SET(s.nulls_FBI_NUM,FBI_NUM) => 0,
                        le.FBI_NUM = ri.FBI_NUM  => le.FBI_NUM_weight100,
                        ngadl.fail_scale(le.FBI_NUM_weight100,s.FBI_NUM_switch));
  integer2 DOB_year       := MAP ( le.DOB_year in SET(s.nulls_DOB_year,DOB_year) or ri.DOB_year in SET(s.nulls_DOB_year,DOB_year) => 0,
                                  le.DOB_year = ri.DOB_year => le.DOB_year_weight100,
                                  ngadl.fail_scale(le.DOB_year_weight100,s.DOB_year_switch) );
  integer2 DOB_month       := MAP ( le.DOB_month in SET(s.nulls_DOB_month,DOB_month) or ri.DOB_month in SET(s.nulls_DOB_month,DOB_month) => 0,
                                  le.DOB_month = ri.DOB_month => le.DOB_month_weight100,
                                  ngadl.fail_scale(le.DOB_month_weight100,s.DOB_month_switch) );
  integer2 DOB_day       := MAP ( le.DOB_day in SET(s.nulls_DOB_day,DOB_day) or ri.DOB_day in SET(s.nulls_DOB_day,DOB_day) => 0,
                                  le.DOB_day = ri.DOB_day => le.DOB_day_weight100,
                                  ngadl.fail_scale(le.DOB_day_weight100,s.DOB_day_switch) );
  integer2 DOB_score := MAP( le.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND le.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND le.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) or ri.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND ri.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND ri.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) => 0,
                        DOB_year+DOB_month+DOB_day < 0 or DOB_year+DOB_month+DOB_day<>0 and DOB_year+DOB_month+DOB_day < 700 => SKIP,
                        DOB_year+DOB_month+DOB_day);
  integer2 PRIM_RANGE_score := MAP( le.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) or ri.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) => 0,
                        le.PRIM_RANGE = ri.PRIM_RANGE  => le.PRIM_RANGE_weight100,
                        ngadl.fail_scale(le.PRIM_RANGE_weight100,s.PRIM_RANGE_switch));
  integer2 LNAME_score := MAP( le.LNAME  IN SET(s.nulls_LNAME,LNAME) or ri.LNAME  IN SET(s.nulls_LNAME,LNAME) or le.LNAME_weight100 = 0 => SKIP,
                        le.LNAME = ri.LNAME  => le.LNAME_weight100,
                        ut.stringsimilar(le.LNAME,ri.LNAME) <= 2 => ngadl.fuzzy_specificity(le.LNAME_weight100,le.LNAME_cnt, le.LNAME_e2_cnt,ri.LNAME_weight100,ri.LNAME_cnt,ri.LNAME_e2_cnt),
                        SKIP);
  integer2 PRIM_NAME_score := MAP( le.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) or ri.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) => 0,
                        le.PRIM_NAME = ri.PRIM_NAME  => le.PRIM_NAME_weight100,
                        ngadl.fail_scale(le.PRIM_NAME_weight100,s.PRIM_NAME_switch));
  integer2 DL_NUM_score := MAP( le.DL_NUM  IN SET(s.nulls_DL_NUM,DL_NUM) or ri.DL_NUM  IN SET(s.nulls_DL_NUM,DL_NUM) => 0,
                        le.DL_STATE <> ri.DL_STATE => 0, // Only valid if the context variable is equal
                        le.DL_NUM = ri.DL_NUM  => le.DL_NUM_weight100,
                        ngadl.fail_scale(le.DL_NUM_weight100,s.DL_NUM_switch));
  integer2 FNAME_score := MAP( le.FNAME  IN SET(s.nulls_FNAME,FNAME) or ri.FNAME  IN SET(s.nulls_FNAME,FNAME) or le.FNAME_weight100 = 0 => SKIP,
                        le.FNAME = ri.FNAME  => le.FNAME_weight100,
                        ut.stringsimilar(le.FNAME,ri.FNAME) <= 2 => ngadl.fuzzy_specificity(le.FNAME_weight100,le.FNAME_cnt, le.FNAME_e2_cnt,ri.FNAME_weight100,ri.FNAME_cnt,ri.FNAME_e2_cnt),
                        length(trim(le.FNAME))>0 and le.FNAME = ri.FNAME[length(trim(le.FNAME))] => le.FNAME_weight100, // An initial match - take initial specificity
                        length(trim(ri.FNAME))>0 and ri.FNAME = le.FNAME[length(trim(ri.FNAME))] => ri.FNAME_weight100,// An initial match - take initial specificity
                        SKIP);
  integer2 MNAME_score := MAP( le.MNAME  IN SET(s.nulls_MNAME,MNAME) or ri.MNAME  IN SET(s.nulls_MNAME,MNAME) => 0,
                        le.MNAME = ri.MNAME  => le.MNAME_weight100,
                        ut.stringsimilar(le.MNAME,ri.MNAME) <= 2 => ngadl.fuzzy_specificity(le.MNAME_weight100,le.MNAME_cnt, le.MNAME_e2_cnt,ri.MNAME_weight100,ri.MNAME_cnt,ri.MNAME_e2_cnt),
                        length(trim(le.MNAME))>0 and le.MNAME = ri.MNAME[length(trim(le.MNAME))] => le.MNAME_weight100, // An initial match - take initial specificity
                        length(trim(ri.MNAME))>0 and ri.MNAME = le.MNAME[length(trim(ri.MNAME))] => ri.MNAME_weight100,// An initial match - take initial specificity
                        ngadl.fail_scale(le.MNAME_weight100,s.MNAME_switch));
  integer2 P_CITY_NAME_score := MAP( le.P_CITY_NAME  IN SET(s.nulls_P_CITY_NAME,P_CITY_NAME) or ri.P_CITY_NAME  IN SET(s.nulls_P_CITY_NAME,P_CITY_NAME) => 0,
                        le.P_CITY_NAME = ri.P_CITY_NAME  => le.P_CITY_NAME_weight100,
                        ngadl.fail_scale(le.P_CITY_NAME_weight100,s.P_CITY_NAME_switch));
  integer2 SEC_RANGE_score := MAP( le.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) or ri.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) => 0,
                        le.SEC_RANGE = ri.SEC_RANGE  => le.SEC_RANGE_weight100,
                        ngadl.fail_scale(le.SEC_RANGE_weight100,s.SEC_RANGE_switch));
  integer2 STATE_ORIGIN_score_temp := MAP( le.STATE_ORIGIN  IN SET(s.nulls_STATE_ORIGIN,STATE_ORIGIN) or ri.STATE_ORIGIN  IN SET(s.nulls_STATE_ORIGIN,STATE_ORIGIN) => 0,
                        le.STATE_ORIGIN = ri.STATE_ORIGIN  => le.STATE_ORIGIN_weight100,
                        SKIP);
  integer2 STATE_ORIGIN_score := IF ( STATE_ORIGIN_score_temp >= 700, STATE_ORIGIN_score_temp, SKIP ); // Enforce FORCE parameter
  integer2 STATE_score := MAP( le.STATE  IN SET(s.nulls_STATE,STATE) or ri.STATE  IN SET(s.nulls_STATE,STATE) => 0,
                        le.STATE = ri.STATE  => le.STATE_weight100,
                        ngadl.fail_scale(le.STATE_weight100,s.STATE_switch));
  integer2 NAME_SUFFIX_score := MAP( le.NAME_SUFFIX  IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX) or ri.NAME_SUFFIX  IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX) => 0,
                        le.NAME_SUFFIX = ri.NAME_SUFFIX  => le.NAME_SUFFIX_weight100,
                        SKIP);
  integer2 TITLE_score := MAP( le.TITLE  IN SET(s.nulls_TITLE,TITLE) or ri.TITLE  IN SET(s.nulls_TITLE,TITLE) => 0,
                        le.TITLE = ri.TITLE  => le.TITLE_weight100,
                        SKIP);
  integer2 INS_NUM_score := MAP( le.INS_NUM  IN SET(s.nulls_INS_NUM,INS_NUM) or ri.INS_NUM  IN SET(s.nulls_INS_NUM,INS_NUM) => 0,
                        le.INS_NUM = ri.INS_NUM  => le.INS_NUM_weight100,
                        ngadl.fail_scale(le.INS_NUM_weight100,s.INS_NUM_switch));
  integer2 SOR_NUMBER_score := MAP( le.SOR_NUMBER  IN SET(s.nulls_SOR_NUMBER,SOR_NUMBER) or ri.SOR_NUMBER  IN SET(s.nulls_SOR_NUMBER,SOR_NUMBER) => 0,
                        le.STATE_ORIGIN <> ri.STATE_ORIGIN => 0, // Only valid if the context variable is equal
                        le.SOR_NUMBER = ri.SOR_NUMBER  => le.SOR_NUMBER_weight100,
                        ngadl.fail_scale(le.SOR_NUMBER_weight100,s.SOR_NUMBER_switch));
  integer2 NCIC_NUMBER_score := MAP( le.NCIC_NUMBER  IN SET(s.nulls_NCIC_NUMBER,NCIC_NUMBER) or ri.NCIC_NUMBER  IN SET(s.nulls_NCIC_NUMBER,NCIC_NUMBER) => 0,
                        le.NCIC_NUMBER = ri.NCIC_NUMBER  => le.NCIC_NUMBER_weight100,
                        ngadl.fail_scale(le.NCIC_NUMBER_weight100,s.NCIC_NUMBER_switch));
  integer2 VEH_TAG_score := MAP( le.VEH_TAG  IN SET(s.nulls_VEH_TAG,VEH_TAG) or ri.VEH_TAG  IN SET(s.nulls_VEH_TAG,VEH_TAG) => 0,
                        le.VEH_STATE <> ri.VEH_STATE => 0, // Only valid if the context variable is equal
                        le.VEH_TAG = ri.VEH_TAG  => le.VEH_TAG_weight100,
                        ngadl.fail_scale(le.VEH_TAG_weight100,s.VEH_TAG_switch));
  self.Conf_Prop := (if(le.DID_prop or ri.DID_prop,DID_score,0) + if(le.DLE_NUM_prop or ri.DLE_NUM_prop,DLE_NUM_score,0) + if(le.ORIG_SSN_prop or ri.ORIG_SSN_prop,ORIG_SSN_score,0) + if(le.FBI_NUM_prop or ri.FBI_NUM_prop,FBI_NUM_score,0) + if(le.DOB_prop or ri.DOB_prop,DOB_score,0) + if(le.FNAME_prop or ri.FNAME_prop,FNAME_score,0) + if(le.MNAME_prop or ri.MNAME_prop,MNAME_score,0) + if(le.INS_NUM_prop or ri.INS_NUM_prop,INS_NUM_score,0) + if(le.NCIC_NUMBER_prop or ri.NCIC_NUMBER_prop,NCIC_NUMBER_score,0)) / 100; // Score based on propogated fields
  iComp := (OFFENDER_KEY_score + DID_score + CASE_NUMBER_score + DOC_NUM_score + DLE_NUM_score + ID_NUM_score + ORIG_SSN_score + FBI_NUM_score + DOB_score + PRIM_RANGE_score + LNAME_score + PRIM_NAME_score + DL_NUM_score + FNAME_score + MNAME_score + P_CITY_NAME_score + SEC_RANGE_score + STATE_ORIGIN_score + STATE_score + NAME_SUFFIX_score + TITLE_score + INS_NUM_score + SOR_NUMBER_score + NCIC_NUMBER_score + VEH_TAG_score) / 100;
  self.Conf := IF( iComp>=LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
end;
//Now execute each of the 41 join conditions
// Join mj0 which has blocking specificity of 27
dn0 := h(OFFENDER_KEY NOT IN SET(s.nulls_OFFENDER_KEY,OFFENDER_KEY));
ngadl.MAC_Remove_WithDups(dn0,(string)OFFENDER_KEY + (string)VENDOR,1000,dn0_deduped)
mj0 := distribute( join( dn0_deduped, dn0_deduped, left.CDL > right.CDL and left.OFFENDER_KEY = right.OFFENDER_KEY and left.VENDOR = right.VENDOR,match_join(left,right,0),atmost(left.OFFENDER_KEY = right.OFFENDER_KEY and left.VENDOR = right.VENDOR,1000),skew(1)),hash(CDL1));
// Join mj1 which has blocking specificity of 23
dn1 := h(DID NOT IN SET(s.nulls_DID,DID));
ngadl.MAC_Remove_WithDups(dn1,(string)DID,1000,dn1_deduped)
mj1 := distribute( join( dn1_deduped, dn1_deduped, left.CDL > right.CDL and left.DID = right.DID,match_join(left,right,1),atmost(left.DID = right.DID,1000),skew(1)),hash(CDL1));
// Join mj2 which has blocking specificity of 22
dn2 := h(CASE_NUMBER NOT IN SET(s.nulls_CASE_NUMBER,CASE_NUMBER));
ngadl.MAC_Remove_WithDups(dn2,(string)CASE_NUMBER + (string)STATE_ORIGIN,1000,dn2_deduped)
mj2 := distribute( join( dn2_deduped, dn2_deduped, left.CDL > right.CDL and left.CASE_NUMBER = right.CASE_NUMBER and left.STATE_ORIGIN = right.STATE_ORIGIN,match_join(left,right,2),atmost(left.CASE_NUMBER = right.CASE_NUMBER and left.STATE_ORIGIN = right.STATE_ORIGIN,1000),skew(1)),hash(CDL1));
// Join mj3 which has blocking specificity of 22
dn3 := h(DOC_NUM NOT IN SET(s.nulls_DOC_NUM,DOC_NUM));
ngadl.MAC_Remove_WithDups(dn3,(string)DOC_NUM + (string)STATE_ORIGIN,1000,dn3_deduped)
mj3 := distribute( join( dn3_deduped, dn3_deduped, left.CDL > right.CDL and left.DOC_NUM = right.DOC_NUM and left.STATE_ORIGIN = right.STATE_ORIGIN,match_join(left,right,3),atmost(left.DOC_NUM = right.DOC_NUM and left.STATE_ORIGIN = right.STATE_ORIGIN,1000),skew(1)),hash(CDL1));
// Join mj4 which has blocking specificity of 21
dn4 := h(DLE_NUM NOT IN SET(s.nulls_DLE_NUM,DLE_NUM));
ngadl.MAC_Remove_WithDups(dn4,(string)DLE_NUM + (string)STATE_ORIGIN,1000,dn4_deduped)
mj4 := distribute( join( dn4_deduped, dn4_deduped, left.CDL > right.CDL and left.DLE_NUM = right.DLE_NUM and left.STATE_ORIGIN = right.STATE_ORIGIN,match_join(left,right,4),atmost(left.DLE_NUM = right.DLE_NUM and left.STATE_ORIGIN = right.STATE_ORIGIN,1000),skew(1)),hash(CDL1));
// Join mj5 which has blocking specificity of 21
dn5 := h(ID_NUM NOT IN SET(s.nulls_ID_NUM,ID_NUM));
ngadl.MAC_Remove_WithDups(dn5,(string)ID_NUM + (string)STATE_ORIGIN,1000,dn5_deduped)
mj5 := distribute( join( dn5_deduped, dn5_deduped, left.CDL > right.CDL and left.ID_NUM = right.ID_NUM and left.STATE_ORIGIN = right.STATE_ORIGIN,match_join(left,right,5),atmost(left.ID_NUM = right.ID_NUM and left.STATE_ORIGIN = right.STATE_ORIGIN,1000),skew(1)),hash(CDL1));
// Join mj6 which has blocking specificity of 38
dn6 := h(ORIG_SSN NOT IN SET(s.nulls_ORIG_SSN,ORIG_SSN) and FBI_NUM NOT IN SET(s.nulls_FBI_NUM,FBI_NUM));
ngadl.MAC_Remove_WithDups(dn6,(string)ORIG_SSN + (string)FBI_NUM,1000,dn6_deduped)
mj6 := distribute( join( dn6_deduped, dn6_deduped, left.CDL > right.CDL and left.ORIG_SSN = right.ORIG_SSN and left.FBI_NUM = right.FBI_NUM,match_join(left,right,6),atmost(left.ORIG_SSN = right.ORIG_SSN and left.FBI_NUM = right.FBI_NUM,1000),skew(1)),hash(CDL1));
// Join mj7 which has blocking specificity of 33
dn7 := h(ORIG_SSN NOT IN SET(s.nulls_ORIG_SSN,ORIG_SSN) and (DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) OR DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) OR DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)));
ngadl.MAC_Remove_WithDups(dn7,(string)ORIG_SSN + (string)DOB_year + (string)DOB_month + (string)DOB_day,1000,dn7_deduped)
mj7 := distribute( join( dn7_deduped, dn7_deduped, left.CDL > right.CDL and left.ORIG_SSN = right.ORIG_SSN and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day,match_join(left,right,7),atmost(left.ORIG_SSN = right.ORIG_SSN and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day,1000),skew(1)),hash(CDL1));
// Join mj8 which has blocking specificity of 30
dn8 := h(ORIG_SSN NOT IN SET(s.nulls_ORIG_SSN,ORIG_SSN) and PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE));
ngadl.MAC_Remove_WithDups(dn8,(string)ORIG_SSN + (string)PRIM_RANGE,1000,dn8_deduped)
mj8 := distribute( join( dn8_deduped, dn8_deduped, left.CDL > right.CDL and left.ORIG_SSN = right.ORIG_SSN and left.PRIM_RANGE = right.PRIM_RANGE,match_join(left,right,8),atmost(left.ORIG_SSN = right.ORIG_SSN and left.PRIM_RANGE = right.PRIM_RANGE,1000),skew(1)),hash(CDL1));
// Join mj9 which has blocking specificity of 29
dn9 := h(ORIG_SSN NOT IN SET(s.nulls_ORIG_SSN,ORIG_SSN) and LNAME NOT IN SET(s.nulls_LNAME,LNAME));
ngadl.MAC_Remove_WithDups(dn9,(string)ORIG_SSN + (string)LNAME,1000,dn9_deduped)
mj9 := distribute( join( dn9_deduped, dn9_deduped, left.CDL > right.CDL and left.ORIG_SSN = right.ORIG_SSN and left.LNAME = right.LNAME,match_join(left,right,9),atmost(left.ORIG_SSN = right.ORIG_SSN and left.LNAME = right.LNAME,1000),skew(1)),hash(CDL1));
// Join mj10 which has blocking specificity of 29
dn10 := h(ORIG_SSN NOT IN SET(s.nulls_ORIG_SSN,ORIG_SSN) and PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME));
ngadl.MAC_Remove_WithDups(dn10,(string)ORIG_SSN + (string)PRIM_NAME,1000,dn10_deduped)
mj10 := distribute( join( dn10_deduped, dn10_deduped, left.CDL > right.CDL and left.ORIG_SSN = right.ORIG_SSN and left.PRIM_NAME = right.PRIM_NAME,match_join(left,right,10),atmost(left.ORIG_SSN = right.ORIG_SSN and left.PRIM_NAME = right.PRIM_NAME,1000),skew(1)),hash(CDL1));
// Join mj11 which has blocking specificity of 29
dn11 := h(ORIG_SSN NOT IN SET(s.nulls_ORIG_SSN,ORIG_SSN) and DL_NUM NOT IN SET(s.nulls_DL_NUM,DL_NUM));
ngadl.MAC_Remove_WithDups(dn11,(string)ORIG_SSN + (string)DL_NUM + (string)DL_STATE,1000,dn11_deduped)
mj11 := distribute( join( dn11_deduped, dn11_deduped, left.CDL > right.CDL and left.ORIG_SSN = right.ORIG_SSN and left.DL_NUM = right.DL_NUM and left.DL_STATE = right.DL_STATE,match_join(left,right,11),atmost(left.ORIG_SSN = right.ORIG_SSN and left.DL_NUM = right.DL_NUM and left.DL_STATE = right.DL_STATE,1000),skew(1)),hash(CDL1));
// Join mj12 which has blocking specificity of 27
dn12 := h(ORIG_SSN NOT IN SET(s.nulls_ORIG_SSN,ORIG_SSN) and FNAME NOT IN SET(s.nulls_FNAME,FNAME));
ngadl.MAC_Remove_WithDups(dn12,(string)ORIG_SSN + (string)FNAME,1000,dn12_deduped)
mj12 := distribute( join( dn12_deduped, dn12_deduped, left.CDL > right.CDL and left.ORIG_SSN = right.ORIG_SSN and left.FNAME = right.FNAME,match_join(left,right,12),atmost(left.ORIG_SSN = right.ORIG_SSN and left.FNAME = right.FNAME,1000),skew(1)),hash(CDL1));
// Join mj13 which has blocking specificity of 27
dn13 := h(ORIG_SSN NOT IN SET(s.nulls_ORIG_SSN,ORIG_SSN) and MNAME NOT IN SET(s.nulls_MNAME,MNAME));
ngadl.MAC_Remove_WithDups(dn13,(string)ORIG_SSN + (string)MNAME,1000,dn13_deduped)
mj13 := distribute( join( dn13_deduped, dn13_deduped, left.CDL > right.CDL and left.ORIG_SSN = right.ORIG_SSN and left.MNAME = right.MNAME,match_join(left,right,13),atmost(left.ORIG_SSN = right.ORIG_SSN and left.MNAME = right.MNAME,1000),skew(1)),hash(CDL1));
mjs0_t :=  mj0+ mj1+ mj2+ mj3+ mj4+ mj5+ mj6+ mj7+ mj8+ mj9+ mj10+ mj11+ mj12+ mj13;
ngadl.mac_select_best_matches(mjs0_t,CDL1,CDL2,Conf,Rule,o0);
mjs0 := o0 : persist('temp::CDL::mj0');
// Join mj14 which has blocking specificity of 33
dn14 := h(FBI_NUM NOT IN SET(s.nulls_FBI_NUM,FBI_NUM) and (DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) OR DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) OR DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)));
ngadl.MAC_Remove_WithDups(dn14,(string)FBI_NUM + (string)DOB_year + (string)DOB_month + (string)DOB_day,1000,dn14_deduped)
mj14 := distribute( join( dn14_deduped, dn14_deduped, left.CDL > right.CDL and left.FBI_NUM = right.FBI_NUM and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day,match_join(left,right,14),atmost(left.FBI_NUM = right.FBI_NUM and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day,1000),skew(1)),hash(CDL1));
// Join mj15 which has blocking specificity of 30
dn15 := h(FBI_NUM NOT IN SET(s.nulls_FBI_NUM,FBI_NUM) and PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE));
ngadl.MAC_Remove_WithDups(dn15,(string)FBI_NUM + (string)PRIM_RANGE,1000,dn15_deduped)
mj15 := distribute( join( dn15_deduped, dn15_deduped, left.CDL > right.CDL and left.FBI_NUM = right.FBI_NUM and left.PRIM_RANGE = right.PRIM_RANGE,match_join(left,right,15),atmost(left.FBI_NUM = right.FBI_NUM and left.PRIM_RANGE = right.PRIM_RANGE,1000),skew(1)),hash(CDL1));
// Join mj16 which has blocking specificity of 29
dn16 := h(FBI_NUM NOT IN SET(s.nulls_FBI_NUM,FBI_NUM) and LNAME NOT IN SET(s.nulls_LNAME,LNAME));
ngadl.MAC_Remove_WithDups(dn16,(string)FBI_NUM + (string)LNAME,1000,dn16_deduped)
mj16 := distribute( join( dn16_deduped, dn16_deduped, left.CDL > right.CDL and left.FBI_NUM = right.FBI_NUM and left.LNAME = right.LNAME,match_join(left,right,16),atmost(left.FBI_NUM = right.FBI_NUM and left.LNAME = right.LNAME,1000),skew(1)),hash(CDL1));
// Join mj17 which has blocking specificity of 29
dn17 := h(FBI_NUM NOT IN SET(s.nulls_FBI_NUM,FBI_NUM) and PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME));
ngadl.MAC_Remove_WithDups(dn17,(string)FBI_NUM + (string)PRIM_NAME,1000,dn17_deduped)
mj17 := distribute( join( dn17_deduped, dn17_deduped, left.CDL > right.CDL and left.FBI_NUM = right.FBI_NUM and left.PRIM_NAME = right.PRIM_NAME,match_join(left,right,17),atmost(left.FBI_NUM = right.FBI_NUM and left.PRIM_NAME = right.PRIM_NAME,1000),skew(1)),hash(CDL1));
// Join mj18 which has blocking specificity of 29
dn18 := h(FBI_NUM NOT IN SET(s.nulls_FBI_NUM,FBI_NUM) and DL_NUM NOT IN SET(s.nulls_DL_NUM,DL_NUM));
ngadl.MAC_Remove_WithDups(dn18,(string)FBI_NUM + (string)DL_NUM + (string)DL_STATE,1000,dn18_deduped)
mj18 := distribute( join( dn18_deduped, dn18_deduped, left.CDL > right.CDL and left.FBI_NUM = right.FBI_NUM and left.DL_NUM = right.DL_NUM and left.DL_STATE = right.DL_STATE,match_join(left,right,18),atmost(left.FBI_NUM = right.FBI_NUM and left.DL_NUM = right.DL_NUM and left.DL_STATE = right.DL_STATE,1000),skew(1)),hash(CDL1));
// Join mj19 which has blocking specificity of 27
dn19 := h(FBI_NUM NOT IN SET(s.nulls_FBI_NUM,FBI_NUM) and FNAME NOT IN SET(s.nulls_FNAME,FNAME));
ngadl.MAC_Remove_WithDups(dn19,(string)FBI_NUM + (string)FNAME,1000,dn19_deduped)
mj19 := distribute( join( dn19_deduped, dn19_deduped, left.CDL > right.CDL and left.FBI_NUM = right.FBI_NUM and left.FNAME = right.FNAME,match_join(left,right,19),atmost(left.FBI_NUM = right.FBI_NUM and left.FNAME = right.FNAME,1000),skew(1)),hash(CDL1));
// Join mj20 which has blocking specificity of 27
dn20 := h(FBI_NUM NOT IN SET(s.nulls_FBI_NUM,FBI_NUM) and MNAME NOT IN SET(s.nulls_MNAME,MNAME));
ngadl.MAC_Remove_WithDups(dn20,(string)FBI_NUM + (string)MNAME,1000,dn20_deduped)
mj20 := distribute( join( dn20_deduped, dn20_deduped, left.CDL > right.CDL and left.FBI_NUM = right.FBI_NUM and left.MNAME = right.MNAME,match_join(left,right,20),atmost(left.FBI_NUM = right.FBI_NUM and left.MNAME = right.MNAME,1000),skew(1)),hash(CDL1));
// Join mj21 which has blocking specificity of 25
dn21 := h((DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) OR DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) OR DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)) and PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE));
ngadl.MAC_Remove_WithDups(dn21,(string)DOB_year + (string)DOB_month + (string)DOB_day + (string)PRIM_RANGE,1000,dn21_deduped)
mj21 := distribute( join( dn21_deduped, dn21_deduped, left.CDL > right.CDL and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.PRIM_RANGE = right.PRIM_RANGE,match_join(left,right,21),atmost(left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.PRIM_RANGE = right.PRIM_RANGE,1000),skew(1)),hash(CDL1));
// Join mj22 which has blocking specificity of 24
dn22 := h((DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) OR DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) OR DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)) and LNAME NOT IN SET(s.nulls_LNAME,LNAME));
ngadl.MAC_Remove_WithDups(dn22,(string)DOB_year + (string)DOB_month + (string)DOB_day + (string)LNAME,1000,dn22_deduped)
mj22 := distribute( join( dn22_deduped, dn22_deduped, left.CDL > right.CDL and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.LNAME = right.LNAME,match_join(left,right,22),atmost(left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.LNAME = right.LNAME,1000),skew(1)),hash(CDL1));
// Join mj23 which has blocking specificity of 24
dn23 := h((DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) OR DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) OR DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)) and PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME));
ngadl.MAC_Remove_WithDups(dn23,(string)DOB_year + (string)DOB_month + (string)DOB_day + (string)PRIM_NAME,1000,dn23_deduped)
mj23 := distribute( join( dn23_deduped, dn23_deduped, left.CDL > right.CDL and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.PRIM_NAME = right.PRIM_NAME,match_join(left,right,23),atmost(left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.PRIM_NAME = right.PRIM_NAME,1000),skew(1)),hash(CDL1));
// Join mj24 which has blocking specificity of 24
dn24 := h((DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) OR DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) OR DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)) and DL_NUM NOT IN SET(s.nulls_DL_NUM,DL_NUM));
ngadl.MAC_Remove_WithDups(dn24,(string)DOB_year + (string)DOB_month + (string)DOB_day + (string)DL_NUM + (string)DL_STATE,1000,dn24_deduped)
mj24 := distribute( join( dn24_deduped, dn24_deduped, left.CDL > right.CDL and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.DL_NUM = right.DL_NUM and left.DL_STATE = right.DL_STATE,match_join(left,right,24),atmost(left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.DL_NUM = right.DL_NUM and left.DL_STATE = right.DL_STATE,1000),skew(1)),hash(CDL1));
// Join mj25 which has blocking specificity of 22
dn25 := h((DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) OR DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) OR DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)) and FNAME NOT IN SET(s.nulls_FNAME,FNAME));
ngadl.MAC_Remove_WithDups(dn25,(string)DOB_year + (string)DOB_month + (string)DOB_day + (string)FNAME,1000,dn25_deduped)
mj25 := distribute( join( dn25_deduped, dn25_deduped, left.CDL > right.CDL and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.FNAME = right.FNAME,match_join(left,right,25),atmost(left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.FNAME = right.FNAME,1000),skew(1)),hash(CDL1));
// Join mj26 which has blocking specificity of 22
dn26 := h((DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) OR DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) OR DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)) and MNAME NOT IN SET(s.nulls_MNAME,MNAME));
ngadl.MAC_Remove_WithDups(dn26,(string)DOB_year + (string)DOB_month + (string)DOB_day + (string)MNAME,1000,dn26_deduped)
mj26 := distribute( join( dn26_deduped, dn26_deduped, left.CDL > right.CDL and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.MNAME = right.MNAME,match_join(left,right,26),atmost(left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.MNAME = right.MNAME,1000),skew(1)),hash(CDL1));
mjs1_t :=  mj14+ mj15+ mj16+ mj17+ mj18+ mj19+ mj20+ mj21+ mj22+ mj23+ mj24+ mj25+ mj26;
ngadl.mac_select_best_matches(mjs1_t,CDL1,CDL2,Conf,Rule,o1);
mjs1 := o1 : persist('temp::CDL::mj1');
// Join mj27 which has blocking specificity of 21
dn27 := h(PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) and LNAME NOT IN SET(s.nulls_LNAME,LNAME));
ngadl.MAC_Remove_WithDups(dn27,(string)PRIM_RANGE + (string)LNAME,1000,dn27_deduped)
mj27 := distribute( join( dn27_deduped, dn27_deduped, left.CDL > right.CDL and left.PRIM_RANGE = right.PRIM_RANGE and left.LNAME = right.LNAME,match_join(left,right,27),atmost(left.PRIM_RANGE = right.PRIM_RANGE and left.LNAME = right.LNAME,1000),skew(1)),hash(CDL1));
// Join mj28 which has blocking specificity of 21
dn28 := h(PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) and PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME));
ngadl.MAC_Remove_WithDups(dn28,(string)PRIM_RANGE + (string)PRIM_NAME,1000,dn28_deduped)
mj28 := distribute( join( dn28_deduped, dn28_deduped, left.CDL > right.CDL and left.PRIM_RANGE = right.PRIM_RANGE and left.PRIM_NAME = right.PRIM_NAME,match_join(left,right,28),atmost(left.PRIM_RANGE = right.PRIM_RANGE and left.PRIM_NAME = right.PRIM_NAME,1000),skew(1)),hash(CDL1));
// Join mj29 which has blocking specificity of 21
dn29 := h(PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) and DL_NUM NOT IN SET(s.nulls_DL_NUM,DL_NUM));
ngadl.MAC_Remove_WithDups(dn29,(string)PRIM_RANGE + (string)DL_NUM + (string)DL_STATE,1000,dn29_deduped)
mj29 := distribute( join( dn29_deduped, dn29_deduped, left.CDL > right.CDL and left.PRIM_RANGE = right.PRIM_RANGE and left.DL_NUM = right.DL_NUM and left.DL_STATE = right.DL_STATE,match_join(left,right,29),atmost(left.PRIM_RANGE = right.PRIM_RANGE and left.DL_NUM = right.DL_NUM and left.DL_STATE = right.DL_STATE,1000),skew(1)),hash(CDL1));
// Join mj30 which has blocking specificity of 27
dn30 := h(PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) and FNAME NOT IN SET(s.nulls_FNAME,FNAME) and MNAME NOT IN SET(s.nulls_MNAME,MNAME));
ngadl.MAC_Remove_WithDups(dn30,(string)PRIM_RANGE + (string)FNAME + (string)MNAME,1000,dn30_deduped)
mj30 := distribute( join( dn30_deduped, dn30_deduped, left.CDL > right.CDL and left.PRIM_RANGE = right.PRIM_RANGE and left.FNAME = right.FNAME and left.MNAME = right.MNAME,match_join(left,right,30),atmost(left.PRIM_RANGE = right.PRIM_RANGE and left.FNAME = right.FNAME and left.MNAME = right.MNAME,1000),skew(1)),hash(CDL1));
// Join mj31 which has blocking specificity of 30
dn31 := h(LNAME NOT IN SET(s.nulls_LNAME,LNAME) and PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME) and DL_NUM NOT IN SET(s.nulls_DL_NUM,DL_NUM));
ngadl.MAC_Remove_WithDups(dn31,(string)LNAME + (string)PRIM_NAME + (string)DL_NUM + (string)DL_STATE,1000,dn31_deduped)
mj31 := distribute( join( dn31_deduped, dn31_deduped, left.CDL > right.CDL and left.LNAME = right.LNAME and left.PRIM_NAME = right.PRIM_NAME and left.DL_NUM = right.DL_NUM and left.DL_STATE = right.DL_STATE,match_join(left,right,31),atmost(left.LNAME = right.LNAME and left.PRIM_NAME = right.PRIM_NAME and left.DL_NUM = right.DL_NUM and left.DL_STATE = right.DL_STATE,1000),skew(1)),hash(CDL1));
// Join mj32 which has blocking specificity of 28
dn32 := h(LNAME NOT IN SET(s.nulls_LNAME,LNAME) and PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME) and FNAME NOT IN SET(s.nulls_FNAME,FNAME));
ngadl.MAC_Remove_WithDups(dn32,(string)LNAME + (string)PRIM_NAME + (string)FNAME,1000,dn32_deduped)
mj32 := distribute( join( dn32_deduped, dn32_deduped, left.CDL > right.CDL and left.LNAME = right.LNAME and left.PRIM_NAME = right.PRIM_NAME and left.FNAME = right.FNAME,match_join(left,right,32),atmost(left.LNAME = right.LNAME and left.PRIM_NAME = right.PRIM_NAME and left.FNAME = right.FNAME,1000),skew(1)),hash(CDL1));
// Join mj33 which has blocking specificity of 28
dn33 := h(LNAME NOT IN SET(s.nulls_LNAME,LNAME) and PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME) and MNAME NOT IN SET(s.nulls_MNAME,MNAME));
ngadl.MAC_Remove_WithDups(dn33,(string)LNAME + (string)PRIM_NAME + (string)MNAME,1000,dn33_deduped)
mj33 := distribute( join( dn33_deduped, dn33_deduped, left.CDL > right.CDL and left.LNAME = right.LNAME and left.PRIM_NAME = right.PRIM_NAME and left.MNAME = right.MNAME,match_join(left,right,33),atmost(left.LNAME = right.LNAME and left.PRIM_NAME = right.PRIM_NAME and left.MNAME = right.MNAME,1000),skew(1)),hash(CDL1));
// Join mj34 which has blocking specificity of 28
dn34 := h(LNAME NOT IN SET(s.nulls_LNAME,LNAME) and DL_NUM NOT IN SET(s.nulls_DL_NUM,DL_NUM) and FNAME NOT IN SET(s.nulls_FNAME,FNAME));
ngadl.MAC_Remove_WithDups(dn34,(string)LNAME + (string)DL_NUM + (string)DL_STATE + (string)FNAME,1000,dn34_deduped)
mj34 := distribute( join( dn34_deduped, dn34_deduped, left.CDL > right.CDL and left.LNAME = right.LNAME and left.DL_NUM = right.DL_NUM and left.DL_STATE = right.DL_STATE and left.FNAME = right.FNAME,match_join(left,right,34),atmost(left.LNAME = right.LNAME and left.DL_NUM = right.DL_NUM and left.DL_STATE = right.DL_STATE and left.FNAME = right.FNAME,1000),skew(1)),hash(CDL1));
// Join mj35 which has blocking specificity of 28
dn35 := h(LNAME NOT IN SET(s.nulls_LNAME,LNAME) and DL_NUM NOT IN SET(s.nulls_DL_NUM,DL_NUM) and MNAME NOT IN SET(s.nulls_MNAME,MNAME));
ngadl.MAC_Remove_WithDups(dn35,(string)LNAME + (string)DL_NUM + (string)DL_STATE + (string)MNAME,1000,dn35_deduped)
mj35 := distribute( join( dn35_deduped, dn35_deduped, left.CDL > right.CDL and left.LNAME = right.LNAME and left.DL_NUM = right.DL_NUM and left.DL_STATE = right.DL_STATE and left.MNAME = right.MNAME,match_join(left,right,35),atmost(left.LNAME = right.LNAME and left.DL_NUM = right.DL_NUM and left.DL_STATE = right.DL_STATE and left.MNAME = right.MNAME,1000),skew(1)),hash(CDL1));
// Join mj36 which has blocking specificity of 26
dn36 := h(LNAME NOT IN SET(s.nulls_LNAME,LNAME) and FNAME NOT IN SET(s.nulls_FNAME,FNAME) and MNAME NOT IN SET(s.nulls_MNAME,MNAME));
ngadl.MAC_Remove_WithDups(dn36,(string)LNAME + (string)FNAME + (string)MNAME,1000,dn36_deduped)
mj36 := distribute( join( dn36_deduped, dn36_deduped, left.CDL > right.CDL and left.LNAME = right.LNAME and left.FNAME = right.FNAME and left.MNAME = right.MNAME,match_join(left,right,36),atmost(left.LNAME = right.LNAME and left.FNAME = right.FNAME and left.MNAME = right.MNAME,1000),skew(1)),hash(CDL1));
mjs2_t :=  mj27+ mj28+ mj29+ mj30+ mj31+ mj32+ mj33+ mj34+ mj35+ mj36;
ngadl.mac_select_best_matches(mjs2_t,CDL1,CDL2,Conf,Rule,o2);
mjs2 := o2 : persist('temp::CDL::mj2');
// Join mj37 which has blocking specificity of 28
dn37 := h(PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME) and DL_NUM NOT IN SET(s.nulls_DL_NUM,DL_NUM) and FNAME NOT IN SET(s.nulls_FNAME,FNAME));
ngadl.MAC_Remove_WithDups(dn37,(string)PRIM_NAME + (string)DL_NUM + (string)DL_STATE + (string)FNAME,1000,dn37_deduped)
mj37 := distribute( join( dn37_deduped, dn37_deduped, left.CDL > right.CDL and left.PRIM_NAME = right.PRIM_NAME and left.DL_NUM = right.DL_NUM and left.DL_STATE = right.DL_STATE and left.FNAME = right.FNAME,match_join(left,right,37),atmost(left.PRIM_NAME = right.PRIM_NAME and left.DL_NUM = right.DL_NUM and left.DL_STATE = right.DL_STATE and left.FNAME = right.FNAME,1000),skew(1)),hash(CDL1));
// Join mj38 which has blocking specificity of 28
dn38 := h(PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME) and DL_NUM NOT IN SET(s.nulls_DL_NUM,DL_NUM) and MNAME NOT IN SET(s.nulls_MNAME,MNAME));
ngadl.MAC_Remove_WithDups(dn38,(string)PRIM_NAME + (string)DL_NUM + (string)DL_STATE + (string)MNAME,1000,dn38_deduped)
mj38 := distribute( join( dn38_deduped, dn38_deduped, left.CDL > right.CDL and left.PRIM_NAME = right.PRIM_NAME and left.DL_NUM = right.DL_NUM and left.DL_STATE = right.DL_STATE and left.MNAME = right.MNAME,match_join(left,right,38),atmost(left.PRIM_NAME = right.PRIM_NAME and left.DL_NUM = right.DL_NUM and left.DL_STATE = right.DL_STATE and left.MNAME = right.MNAME,1000),skew(1)),hash(CDL1));
// Join mj39 which has blocking specificity of 26
dn39 := h(PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME) and FNAME NOT IN SET(s.nulls_FNAME,FNAME) and MNAME NOT IN SET(s.nulls_MNAME,MNAME));
ngadl.MAC_Remove_WithDups(dn39,(string)PRIM_NAME + (string)FNAME + (string)MNAME,1000,dn39_deduped)
mj39 := distribute( join( dn39_deduped, dn39_deduped, left.CDL > right.CDL and left.PRIM_NAME = right.PRIM_NAME and left.FNAME = right.FNAME and left.MNAME = right.MNAME,match_join(left,right,39),atmost(left.PRIM_NAME = right.PRIM_NAME and left.FNAME = right.FNAME and left.MNAME = right.MNAME,1000),skew(1)),hash(CDL1));
// Join mj40 which has blocking specificity of 26
dn40 := h(DL_NUM NOT IN SET(s.nulls_DL_NUM,DL_NUM) and FNAME NOT IN SET(s.nulls_FNAME,FNAME) and MNAME NOT IN SET(s.nulls_MNAME,MNAME));
ngadl.MAC_Remove_WithDups(dn40,(string)DL_NUM + (string)DL_STATE + (string)FNAME + (string)MNAME,1000,dn40_deduped)
mj40 := distribute( join( dn40_deduped, dn40_deduped, left.CDL > right.CDL and left.DL_NUM = right.DL_NUM and left.DL_STATE = right.DL_STATE and left.FNAME = right.FNAME and left.MNAME = right.MNAME,match_join(left,right,40),atmost(left.DL_NUM = right.DL_NUM and left.DL_STATE = right.DL_STATE and left.FNAME = right.FNAME and left.MNAME = right.MNAME,1000),skew(1)),hash(CDL1));
last_mjs_t := mj37+ mj38+ mj39+ mj40;
ngadl.mac_select_best_matches(last_mjs_t,CDL1,CDL2,Conf,Rule,o);
all_mjs :=  mjs0+ mjs1+ mjs2 +o;
export All_Matches := all_mjs;
ngadl.mac_avoid_transitives(All_Matches,CDL1,CDL2,Conf,DateOverlap,Rule,o);
export PossibleMatches := o : persist('temp::NGCDL2_CDL_HEADER_mt');
export Matches := PossibleMatches(Conf>=MatchThreshold);
//Output the attributes to use for match debugging
export MatchSample := enth(Matches,1000);
export BorderlineMatchSample := enth(Matches(Conf=MatchThreshold),1000);
export AlmostMatchSample := enth(PossibleMatches(Conf<MatchThreshold),1000);
r := record
  unsigned2 RuleNumber := Matches.Rule;
  unsigned MatchesFound := count(group);
end;
export RuleEfficacy := table(Matches,r,Rule,few);
r := record
  unsigned2 Conf := Matches.Conf;
  unsigned MatchesFound := count(group);
end;
export ConfidenceBreakdown := table(Matches,r,Conf,few);
Full_Sample_Matches := MatchSample+BorderlineMatchSample+AlmostMatchSample;
export MatchSampleRecords := Debug(ih,s).AnnotateMatches(Full_Sample_Matches);
//Now actually produce the new file
ut.MAC_Patch_Id(ih,CDL,Matches,CDL1,CDL2,o);
export Patched_Infile := o;
//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,CDL,Matches,CDL1,CDL2,o1);
export Patched_Candidates := o1;
//Now perform the safety checks
export PrePatchIdCount := count( dedup( table(ih,{CDL}), CDL, all ) );
export PostPatchIdCount := count( dedup( table(Patched_Infile,{CDL}), CDL, all ) );
export MatchesPerformed := count( Matches );
export MatchesPropAssisted := count( Matches(Conf_Prop>0) );
export MatchesPropRequired := count( Matches(Conf-Conf_Prop<MatchThreshold) );
export PatchingError0 := PrePatchIdCount - PostPatchIdCount - MatchesPerformed; // Should be zero
export DuplicateRids0 := count(Patched_Infile) - count(dedup(Patched_Infile,RID,all)); // Should be zero
export DidsNoRid0 := PostPatchIdCount - count(Patched_Infile(CDL=RID)); // Should be zero
export DidsAboveRid0 := count(Patched_Infile(CDL>RID)); // Should be zero
end;
