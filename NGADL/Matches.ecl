// Begin code to perform the matching itself
import ngadl,ut;
export matches(dataset(layout_HEADER) ih) := module
shared h := match_candidates(ih).candidates;
shared MatchThreshold := ngadl.constants.ConfThreshold;
shared LowerMatchThreshold := MatchThreshold - 3; // Keep extra 'borderlines' for debug purposes
shared s := global(table(Specificities(ih).Specificities,Layout_Specificities(ih))[1]); // Bug 29550
match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,unsigned2 c) := transform
  self.Rule := c;
  self.DID1 := le.DID;
  self.DID2 := ri.DID;
  self.RID1 := le.RID;
  self.RID2 := ri.RID;
  integer2 VENDOR_ID_score := MAP( le.VENDOR_ID  IN SET(s.nulls_VENDOR_ID,VENDOR_ID) or ri.VENDOR_ID  IN SET(s.nulls_VENDOR_ID,VENDOR_ID) => 0,
                        le.SRC <> ri.SRC => 0, // Only valid if the context variable is equal
                        le.VENDOR_ID = ri.VENDOR_ID  => le.VENDOR_ID_weight100,
                        ngadl.fail_scale(le.VENDOR_ID_weight100,s.VENDOR_ID_switch));
  integer2 SSN_score := MAP( le.SSN  IN SET(s.nulls_SSN,SSN) or ri.SSN  IN SET(s.nulls_SSN,SSN) => 0,
                        le.SSN = ri.SSN  => le.SSN_weight100,
                        ut.stringsimilar(le.SSN,ri.SSN) <= 1 => ngadl.fuzzy_specificity(le.SSN_weight100,le.SSN_cnt, le.SSN_e1_cnt,ri.SSN_weight100,ri.SSN_cnt,ri.SSN_e1_cnt),
                        ngadl.fail_scale(le.SSN_weight100,s.SSN_switch));
  integer2 FULLNAME_score := MAP( le.FULLNAME  IN SET(s.nulls_FULLNAME,FULLNAME) or ri.FULLNAME  IN SET(s.nulls_FULLNAME,FULLNAME) => 0,
                        le.FULLNAME = ri.FULLNAME  => le.FULLNAME_weight100,
                        0);
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
  integer2 ADDR1_score := MAP( le.ADDR1  IN SET(s.nulls_ADDR1,ADDR1) or ri.ADDR1  IN SET(s.nulls_ADDR1,ADDR1) => 0,
                        le.ADDR1 = ri.ADDR1  => le.ADDR1_weight100,
                        0);
  integer2 LOCALE_score := MAP( le.LOCALE  IN SET(s.nulls_LOCALE,LOCALE) or ri.LOCALE  IN SET(s.nulls_LOCALE,LOCALE) => 0,
                        le.LOCALE = ri.LOCALE  => le.LOCALE_weight100,
                        0);
  integer2 SEC_RANGE_score := MAP( le.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) or ri.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) => 0,
                        le.SEC_RANGE = ri.SEC_RANGE  => le.SEC_RANGE_weight100,
                        ngadl.fail_scale(le.SEC_RANGE_weight100,s.SEC_RANGE_switch));
  integer2 GENDER_score := MAP( le.GENDER  IN SET(s.nulls_GENDER,GENDER) or ri.GENDER  IN SET(s.nulls_GENDER,GENDER) => 0,
                        le.GENDER = ri.GENDER  => le.GENDER_weight100,
                        SKIP);
  integer2 LNAME_score := MAP( le.LNAME  IN SET(s.nulls_LNAME,LNAME) or ri.LNAME  IN SET(s.nulls_LNAME,LNAME) or le.LNAME_weight100 = 0 => SKIP,
                        FULLNAME_score <> 0 => 0, // Parent has value so child keeps quiet
                        le.LNAME = ri.LNAME  => le.LNAME_weight100,
                        ut.stringsimilar(le.LNAME,ri.LNAME) <= 2 => ngadl.fuzzy_specificity(le.LNAME_weight100,le.LNAME_cnt, le.LNAME_e2_cnt,ri.LNAME_weight100,ri.LNAME_cnt,ri.LNAME_e2_cnt),
                        SKIP);
  integer2 PRIM_NAME_score := MAP( le.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) or ri.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) => 0,
                        ADDR1_score <> 0 => 0, // Parent has value so child keeps quiet
                        le.PRIM_NAME = ri.PRIM_NAME  => le.PRIM_NAME_weight100,
                        ngadl.fail_scale(le.PRIM_NAME_weight100,s.PRIM_NAME_switch));
  integer2 PRIM_RANGE_score := MAP( le.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) or ri.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) => 0,
                        ADDR1_score <> 0 => 0, // Parent has value so child keeps quiet
                        le.PRIM_RANGE = ri.PRIM_RANGE  => le.PRIM_RANGE_weight100,
                        ngadl.fail_scale(le.PRIM_RANGE_weight100,s.PRIM_RANGE_switch));
  integer2 CITY_NAME_score := MAP( le.CITY_NAME  IN SET(s.nulls_CITY_NAME,CITY_NAME) or ri.CITY_NAME  IN SET(s.nulls_CITY_NAME,CITY_NAME) => 0,
                        LOCALE_score <> 0 => 0, // Parent has value so child keeps quiet
                        le.CITY_NAME = ri.CITY_NAME  => le.CITY_NAME_weight100,
                        ngadl.fail_scale(le.CITY_NAME_weight100,s.CITY_NAME_switch));
  integer2 FNAME_score := MAP( le.FNAME  IN SET(s.nulls_FNAME,FNAME) or ri.FNAME  IN SET(s.nulls_FNAME,FNAME) or le.FNAME_weight100 = 0 => SKIP,
                        FULLNAME_score <> 0 => 0, // Parent has value so child keeps quiet
                        le.FNAME = ri.FNAME  => le.FNAME_weight100,
                        ut.stringsimilar(le.FNAME,ri.FNAME) <= 2 => ngadl.fuzzy_specificity(le.FNAME_weight100,le.FNAME_cnt, le.FNAME_e2_cnt,ri.FNAME_weight100,ri.FNAME_cnt,ri.FNAME_e2_cnt),
                        length(trim(le.FNAME))>0 and le.FNAME = ri.FNAME[length(trim(le.FNAME))] => le.FNAME_weight100, // An initial match - take initial specificity
                        length(trim(ri.FNAME))>0 and ri.FNAME = le.FNAME[length(trim(ri.FNAME))] => ri.FNAME_weight100,// An initial match - take initial specificity
                        SKIP);
  integer2 MNAME_score := MAP( le.MNAME  IN SET(s.nulls_MNAME,MNAME) or ri.MNAME  IN SET(s.nulls_MNAME,MNAME) => 0,
                        FULLNAME_score <> 0 => 0, // Parent has value so child keeps quiet
                        le.MNAME = ri.MNAME  => le.MNAME_weight100,
                        ut.stringsimilar(le.MNAME,ri.MNAME) <= 2 => ngadl.fuzzy_specificity(le.MNAME_weight100,le.MNAME_cnt, le.MNAME_e2_cnt,ri.MNAME_weight100,ri.MNAME_cnt,ri.MNAME_e2_cnt),
                        length(trim(le.MNAME))>0 and le.MNAME = ri.MNAME[length(trim(le.MNAME))] => le.MNAME_weight100, // An initial match - take initial specificity
                        length(trim(ri.MNAME))>0 and ri.MNAME = le.MNAME[length(trim(ri.MNAME))] => ri.MNAME_weight100,// An initial match - take initial specificity
                        ngadl.fail_scale(le.MNAME_weight100,s.MNAME_switch));
  integer2 ST_score := MAP( le.ST  IN SET(s.nulls_ST,ST) or ri.ST  IN SET(s.nulls_ST,ST) => 0,
                        LOCALE_score <> 0 => 0, // Parent has value so child keeps quiet
                        le.ST = ri.ST  => le.ST_weight100,
                        ngadl.fail_scale(le.ST_weight100,s.ST_switch));
  integer2 NAME_SUFFIX_score := MAP( le.NAME_SUFFIX  IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX) or ri.NAME_SUFFIX  IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX) => 0,
                        FULLNAME_score <> 0 => 0, // Parent has value so child keeps quiet
                        le.NAME_SUFFIX = ri.NAME_SUFFIX  => le.NAME_SUFFIX_weight100,
                        SKIP);
  self.Conf_Prop := (if(le.SSN_prop or ri.SSN_prop,SSN_score,0) + if(le.FULLNAME_prop or ri.FULLNAME_prop,FULLNAME_score,0) + if(le.DOB_prop or ri.DOB_prop,DOB_score,0) + if(le.FNAME_prop or ri.FNAME_prop,FNAME_score,0) + if(le.MNAME_prop or ri.MNAME_prop,MNAME_score,0) + if(le.NAME_SUFFIX_prop or ri.NAME_SUFFIX_prop,NAME_SUFFIX_score,0)) / 100; // Score based on propogated fields
  iComp := (VENDOR_ID_score + SSN_score + FULLNAME_score + DOB_score + ADDR1_score + LNAME_score + PRIM_NAME_score + PRIM_RANGE_score + CITY_NAME_score + LOCALE_score + FNAME_score + SEC_RANGE_score + MNAME_score + ST_score + NAME_SUFFIX_score + GENDER_score) / 100;
  self.Conf := IF( iComp>=LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
end;
//Now execute each of the 74 join conditions
// Join mj0 which has blocking specificity of 49
dn0 := h(VENDOR_ID NOT IN SET(s.nulls_VENDOR_ID,VENDOR_ID) and SSN NOT IN SET(s.nulls_SSN,SSN));
ngadl.MAC_Remove_WithDups(dn0,(string)VENDOR_ID + (string)SRC + (string)SSN,1000,dn0_deduped)
mj0 := distribute( join( dn0_deduped, dn0_deduped, left.DID > right.DID and left.VENDOR_ID = right.VENDOR_ID and left.SRC = right.SRC and left.SSN = right.SSN,match_join(left,right,0),atmost(left.VENDOR_ID = right.VENDOR_ID and left.SRC = right.SRC and left.SSN = right.SSN,1000),skew(1)),hash(DID1));
// Join mj1 which has blocking specificity of 47
dn1 := h(VENDOR_ID NOT IN SET(s.nulls_VENDOR_ID,VENDOR_ID) and FULLNAME NOT IN SET(s.nulls_FULLNAME,FULLNAME));
ngadl.MAC_Remove_WithDups(dn1,(string)VENDOR_ID + (string)SRC + (string)FULLNAME,1000,dn1_deduped)
mj1 := distribute( join( dn1_deduped, dn1_deduped, left.DID > right.DID and left.VENDOR_ID = right.VENDOR_ID and left.SRC = right.SRC and left.FULLNAME = right.FULLNAME,match_join(left,right,1),atmost(left.VENDOR_ID = right.VENDOR_ID and left.SRC = right.SRC and left.FULLNAME = right.FULLNAME,1000),skew(1)),hash(DID1));
// Join mj2 which has blocking specificity of 43
dn2 := h(VENDOR_ID NOT IN SET(s.nulls_VENDOR_ID,VENDOR_ID) and (DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) OR DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) OR DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)));
ngadl.MAC_Remove_WithDups(dn2,(string)VENDOR_ID + (string)SRC + (string)DOB_year + (string)DOB_month + (string)DOB_day,1000,dn2_deduped)
mj2 := distribute( join( dn2_deduped, dn2_deduped, left.DID > right.DID and left.VENDOR_ID = right.VENDOR_ID and left.SRC = right.SRC and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day,match_join(left,right,2),atmost(left.VENDOR_ID = right.VENDOR_ID and left.SRC = right.SRC and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day,1000),skew(1)),hash(DID1));
// Join mj3 which has blocking specificity of 37
dn3 := h(VENDOR_ID NOT IN SET(s.nulls_VENDOR_ID,VENDOR_ID) and ADDR1 NOT IN SET(s.nulls_ADDR1,ADDR1));
ngadl.MAC_Remove_WithDups(dn3,(string)VENDOR_ID + (string)SRC + (string)ADDR1,1000,dn3_deduped)
mj3 := distribute( join( dn3_deduped, dn3_deduped, left.DID > right.DID and left.VENDOR_ID = right.VENDOR_ID and left.SRC = right.SRC and left.ADDR1 = right.ADDR1,match_join(left,right,3),atmost(left.VENDOR_ID = right.VENDOR_ID and left.SRC = right.SRC and left.ADDR1 = right.ADDR1,1000),skew(1)),hash(DID1));
// Join mj4 which has blocking specificity of 36
dn4 := h(VENDOR_ID NOT IN SET(s.nulls_VENDOR_ID,VENDOR_ID) and LNAME NOT IN SET(s.nulls_LNAME,LNAME));
ngadl.MAC_Remove_WithDups(dn4,(string)VENDOR_ID + (string)SRC + (string)LNAME,1000,dn4_deduped)
mj4 := distribute( join( dn4_deduped, dn4_deduped, left.DID > right.DID and left.VENDOR_ID = right.VENDOR_ID and left.SRC = right.SRC and left.LNAME = right.LNAME,match_join(left,right,4),atmost(left.VENDOR_ID = right.VENDOR_ID and left.SRC = right.SRC and left.LNAME = right.LNAME,1000),skew(1)),hash(DID1));
// Join mj5 which has blocking specificity of 36
dn5 := h(VENDOR_ID NOT IN SET(s.nulls_VENDOR_ID,VENDOR_ID) and PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME));
ngadl.MAC_Remove_WithDups(dn5,(string)VENDOR_ID + (string)SRC + (string)PRIM_NAME,1000,dn5_deduped)
mj5 := distribute( join( dn5_deduped, dn5_deduped, left.DID > right.DID and left.VENDOR_ID = right.VENDOR_ID and left.SRC = right.SRC and left.PRIM_NAME = right.PRIM_NAME,match_join(left,right,5),atmost(left.VENDOR_ID = right.VENDOR_ID and left.SRC = right.SRC and left.PRIM_NAME = right.PRIM_NAME,1000),skew(1)),hash(DID1));
// Join mj6 which has blocking specificity of 36
dn6 := h(VENDOR_ID NOT IN SET(s.nulls_VENDOR_ID,VENDOR_ID) and PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE));
ngadl.MAC_Remove_WithDups(dn6,(string)VENDOR_ID + (string)SRC + (string)PRIM_RANGE,1000,dn6_deduped)
mj6 := distribute( join( dn6_deduped, dn6_deduped, left.DID > right.DID and left.VENDOR_ID = right.VENDOR_ID and left.SRC = right.SRC and left.PRIM_RANGE = right.PRIM_RANGE,match_join(left,right,6),atmost(left.VENDOR_ID = right.VENDOR_ID and left.SRC = right.SRC and left.PRIM_RANGE = right.PRIM_RANGE,1000),skew(1)),hash(DID1));
// Join mj7 which has blocking specificity of 35
dn7 := h(VENDOR_ID NOT IN SET(s.nulls_VENDOR_ID,VENDOR_ID) and CITY_NAME NOT IN SET(s.nulls_CITY_NAME,CITY_NAME));
ngadl.MAC_Remove_WithDups(dn7,(string)VENDOR_ID + (string)SRC + (string)CITY_NAME,1000,dn7_deduped)
mj7 := distribute( join( dn7_deduped, dn7_deduped, left.DID > right.DID and left.VENDOR_ID = right.VENDOR_ID and left.SRC = right.SRC and left.CITY_NAME = right.CITY_NAME,match_join(left,right,7),atmost(left.VENDOR_ID = right.VENDOR_ID and left.SRC = right.SRC and left.CITY_NAME = right.CITY_NAME,1000),skew(1)),hash(DID1));
// Join mj8 which has blocking specificity of 35
dn8 := h(VENDOR_ID NOT IN SET(s.nulls_VENDOR_ID,VENDOR_ID) and LOCALE NOT IN SET(s.nulls_LOCALE,LOCALE));
ngadl.MAC_Remove_WithDups(dn8,(string)VENDOR_ID + (string)SRC + (string)LOCALE,1000,dn8_deduped)
mj8 := distribute( join( dn8_deduped, dn8_deduped, left.DID > right.DID and left.VENDOR_ID = right.VENDOR_ID and left.SRC = right.SRC and left.LOCALE = right.LOCALE,match_join(left,right,8),atmost(left.VENDOR_ID = right.VENDOR_ID and left.SRC = right.SRC and left.LOCALE = right.LOCALE,1000),skew(1)),hash(DID1));
// Join mj9 which has blocking specificity of 34
dn9 := h(VENDOR_ID NOT IN SET(s.nulls_VENDOR_ID,VENDOR_ID) and FNAME NOT IN SET(s.nulls_FNAME,FNAME));
ngadl.MAC_Remove_WithDups(dn9,(string)VENDOR_ID + (string)SRC + (string)FNAME,1000,dn9_deduped)
mj9 := distribute( join( dn9_deduped, dn9_deduped, left.DID > right.DID and left.VENDOR_ID = right.VENDOR_ID and left.SRC = right.SRC and left.FNAME = right.FNAME,match_join(left,right,9),atmost(left.VENDOR_ID = right.VENDOR_ID and left.SRC = right.SRC and left.FNAME = right.FNAME,1000),skew(1)),hash(DID1));
// Join mj10 which has blocking specificity of 32
dn10 := h(VENDOR_ID NOT IN SET(s.nulls_VENDOR_ID,VENDOR_ID) and SEC_RANGE NOT IN SET(s.nulls_SEC_RANGE,SEC_RANGE));
ngadl.MAC_Remove_WithDups(dn10,(string)VENDOR_ID + (string)SRC + (string)SEC_RANGE,1000,dn10_deduped)
mj10 := distribute( join( dn10_deduped, dn10_deduped, left.DID > right.DID and left.VENDOR_ID = right.VENDOR_ID and left.SRC = right.SRC and left.SEC_RANGE = right.SEC_RANGE,match_join(left,right,10),atmost(left.VENDOR_ID = right.VENDOR_ID and left.SRC = right.SRC and left.SEC_RANGE = right.SEC_RANGE,1000),skew(1)),hash(DID1));
mjs0_t :=  mj0+ mj1+ mj2+ mj3+ mj4+ mj5+ mj6+ mj7+ mj8+ mj9+ mj10;
ngadl.mac_select_best_matches(mjs0_t,DID1,DID2,Conf,Rule,o0);
mjs0 := o0 : persist('temp::DID::mj0');
// Join mj11 which has blocking specificity of 46
dn11 := h(SSN NOT IN SET(s.nulls_SSN,SSN) and FULLNAME NOT IN SET(s.nulls_FULLNAME,FULLNAME));
ngadl.MAC_Remove_WithDups(dn11,(string)SSN + (string)FULLNAME,1000,dn11_deduped)
mj11 := distribute( join( dn11_deduped, dn11_deduped, left.DID > right.DID and left.SSN = right.SSN and left.FULLNAME = right.FULLNAME,match_join(left,right,11),atmost(left.SSN = right.SSN and left.FULLNAME = right.FULLNAME,1000),skew(1)),hash(DID1));
// Join mj12 which has blocking specificity of 42
dn12 := h(SSN NOT IN SET(s.nulls_SSN,SSN) and (DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) OR DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) OR DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)));
ngadl.MAC_Remove_WithDups(dn12,(string)SSN + (string)DOB_year + (string)DOB_month + (string)DOB_day,1000,dn12_deduped)
mj12 := distribute( join( dn12_deduped, dn12_deduped, left.DID > right.DID and left.SSN = right.SSN and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day,match_join(left,right,12),atmost(left.SSN = right.SSN and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day,1000),skew(1)),hash(DID1));
// Join mj13 which has blocking specificity of 36
dn13 := h(SSN NOT IN SET(s.nulls_SSN,SSN) and ADDR1 NOT IN SET(s.nulls_ADDR1,ADDR1));
ngadl.MAC_Remove_WithDups(dn13,(string)SSN + (string)ADDR1,1000,dn13_deduped)
mj13 := distribute( join( dn13_deduped, dn13_deduped, left.DID > right.DID and left.SSN = right.SSN and left.ADDR1 = right.ADDR1,match_join(left,right,13),atmost(left.SSN = right.SSN and left.ADDR1 = right.ADDR1,1000),skew(1)),hash(DID1));
// Join mj14 which has blocking specificity of 35
dn14 := h(SSN NOT IN SET(s.nulls_SSN,SSN) and LNAME NOT IN SET(s.nulls_LNAME,LNAME));
ngadl.MAC_Remove_WithDups(dn14,(string)SSN + (string)LNAME,1000,dn14_deduped)
mj14 := distribute( join( dn14_deduped, dn14_deduped, left.DID > right.DID and left.SSN = right.SSN and left.LNAME = right.LNAME,match_join(left,right,14),atmost(left.SSN = right.SSN and left.LNAME = right.LNAME,1000),skew(1)),hash(DID1));
// Join mj15 which has blocking specificity of 35
dn15 := h(SSN NOT IN SET(s.nulls_SSN,SSN) and PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME));
ngadl.MAC_Remove_WithDups(dn15,(string)SSN + (string)PRIM_NAME,1000,dn15_deduped)
mj15 := distribute( join( dn15_deduped, dn15_deduped, left.DID > right.DID and left.SSN = right.SSN and left.PRIM_NAME = right.PRIM_NAME,match_join(left,right,15),atmost(left.SSN = right.SSN and left.PRIM_NAME = right.PRIM_NAME,1000),skew(1)),hash(DID1));
// Join mj16 which has blocking specificity of 35
dn16 := h(SSN NOT IN SET(s.nulls_SSN,SSN) and PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE));
ngadl.MAC_Remove_WithDups(dn16,(string)SSN + (string)PRIM_RANGE,1000,dn16_deduped)
mj16 := distribute( join( dn16_deduped, dn16_deduped, left.DID > right.DID and left.SSN = right.SSN and left.PRIM_RANGE = right.PRIM_RANGE,match_join(left,right,16),atmost(left.SSN = right.SSN and left.PRIM_RANGE = right.PRIM_RANGE,1000),skew(1)),hash(DID1));
// Join mj17 which has blocking specificity of 34
dn17 := h(SSN NOT IN SET(s.nulls_SSN,SSN) and CITY_NAME NOT IN SET(s.nulls_CITY_NAME,CITY_NAME));
ngadl.MAC_Remove_WithDups(dn17,(string)SSN + (string)CITY_NAME,1000,dn17_deduped)
mj17 := distribute( join( dn17_deduped, dn17_deduped, left.DID > right.DID and left.SSN = right.SSN and left.CITY_NAME = right.CITY_NAME,match_join(left,right,17),atmost(left.SSN = right.SSN and left.CITY_NAME = right.CITY_NAME,1000),skew(1)),hash(DID1));
// Join mj18 which has blocking specificity of 34
dn18 := h(SSN NOT IN SET(s.nulls_SSN,SSN) and LOCALE NOT IN SET(s.nulls_LOCALE,LOCALE));
ngadl.MAC_Remove_WithDups(dn18,(string)SSN + (string)LOCALE,1000,dn18_deduped)
mj18 := distribute( join( dn18_deduped, dn18_deduped, left.DID > right.DID and left.SSN = right.SSN and left.LOCALE = right.LOCALE,match_join(left,right,18),atmost(left.SSN = right.SSN and left.LOCALE = right.LOCALE,1000),skew(1)),hash(DID1));
// Join mj19 which has blocking specificity of 33
dn19 := h(SSN NOT IN SET(s.nulls_SSN,SSN) and FNAME NOT IN SET(s.nulls_FNAME,FNAME));
ngadl.MAC_Remove_WithDups(dn19,(string)SSN + (string)FNAME,1000,dn19_deduped)
mj19 := distribute( join( dn19_deduped, dn19_deduped, left.DID > right.DID and left.SSN = right.SSN and left.FNAME = right.FNAME,match_join(left,right,19),atmost(left.SSN = right.SSN and left.FNAME = right.FNAME,1000),skew(1)),hash(DID1));
// Join mj20 which has blocking specificity of 31
dn20 := h(SSN NOT IN SET(s.nulls_SSN,SSN) and SEC_RANGE NOT IN SET(s.nulls_SEC_RANGE,SEC_RANGE));
ngadl.MAC_Remove_WithDups(dn20,(string)SSN + (string)SEC_RANGE,1000,dn20_deduped)
mj20 := distribute( join( dn20_deduped, dn20_deduped, left.DID > right.DID and left.SSN = right.SSN and left.SEC_RANGE = right.SEC_RANGE,match_join(left,right,20),atmost(left.SSN = right.SSN and left.SEC_RANGE = right.SEC_RANGE,1000),skew(1)),hash(DID1));
mjs1_t :=  mj11+ mj12+ mj13+ mj14+ mj15+ mj16+ mj17+ mj18+ mj19+ mj20;
ngadl.mac_select_best_matches(mjs1_t,DID1,DID2,Conf,Rule,o1);
mjs1 := o1 : persist('temp::DID::mj1');
// Join mj21 which has blocking specificity of 40
dn21 := h(FULLNAME NOT IN SET(s.nulls_FULLNAME,FULLNAME) and (DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) OR DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) OR DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)));
ngadl.MAC_Remove_WithDups(dn21,(string)FULLNAME + (string)DOB_year + (string)DOB_month + (string)DOB_day,1000,dn21_deduped)
mj21 := distribute( join( dn21_deduped, dn21_deduped, left.DID > right.DID and left.FULLNAME = right.FULLNAME and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day,match_join(left,right,21),atmost(left.FULLNAME = right.FULLNAME and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day,1000),skew(1)),hash(DID1));
// Join mj22 which has blocking specificity of 34
dn22 := h(FULLNAME NOT IN SET(s.nulls_FULLNAME,FULLNAME) and ADDR1 NOT IN SET(s.nulls_ADDR1,ADDR1));
ngadl.MAC_Remove_WithDups(dn22,(string)FULLNAME + (string)ADDR1,1000,dn22_deduped)
mj22 := distribute( join( dn22_deduped, dn22_deduped, left.DID > right.DID and left.FULLNAME = right.FULLNAME and left.ADDR1 = right.ADDR1,match_join(left,right,22),atmost(left.FULLNAME = right.FULLNAME and left.ADDR1 = right.ADDR1,1000),skew(1)),hash(DID1));
// Join mj23 which has blocking specificity of 33
dn23 := h(FULLNAME NOT IN SET(s.nulls_FULLNAME,FULLNAME) and PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME));
ngadl.MAC_Remove_WithDups(dn23,(string)FULLNAME + (string)PRIM_NAME,1000,dn23_deduped)
mj23 := distribute( join( dn23_deduped, dn23_deduped, left.DID > right.DID and left.FULLNAME = right.FULLNAME and left.PRIM_NAME = right.PRIM_NAME,match_join(left,right,23),atmost(left.FULLNAME = right.FULLNAME and left.PRIM_NAME = right.PRIM_NAME,1000),skew(1)),hash(DID1));
// Join mj24 which has blocking specificity of 33
dn24 := h(FULLNAME NOT IN SET(s.nulls_FULLNAME,FULLNAME) and PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE));
ngadl.MAC_Remove_WithDups(dn24,(string)FULLNAME + (string)PRIM_RANGE,1000,dn24_deduped)
mj24 := distribute( join( dn24_deduped, dn24_deduped, left.DID > right.DID and left.FULLNAME = right.FULLNAME and left.PRIM_RANGE = right.PRIM_RANGE,match_join(left,right,24),atmost(left.FULLNAME = right.FULLNAME and left.PRIM_RANGE = right.PRIM_RANGE,1000),skew(1)),hash(DID1));
// Join mj25 which has blocking specificity of 32
dn25 := h(FULLNAME NOT IN SET(s.nulls_FULLNAME,FULLNAME) and CITY_NAME NOT IN SET(s.nulls_CITY_NAME,CITY_NAME));
ngadl.MAC_Remove_WithDups(dn25,(string)FULLNAME + (string)CITY_NAME,1000,dn25_deduped)
mj25 := distribute( join( dn25_deduped, dn25_deduped, left.DID > right.DID and left.FULLNAME = right.FULLNAME and left.CITY_NAME = right.CITY_NAME,match_join(left,right,25),atmost(left.FULLNAME = right.FULLNAME and left.CITY_NAME = right.CITY_NAME,1000),skew(1)),hash(DID1));
// Join mj26 which has blocking specificity of 32
dn26 := h(FULLNAME NOT IN SET(s.nulls_FULLNAME,FULLNAME) and LOCALE NOT IN SET(s.nulls_LOCALE,LOCALE));
ngadl.MAC_Remove_WithDups(dn26,(string)FULLNAME + (string)LOCALE,1000,dn26_deduped)
mj26 := distribute( join( dn26_deduped, dn26_deduped, left.DID > right.DID and left.FULLNAME = right.FULLNAME and left.LOCALE = right.LOCALE,match_join(left,right,26),atmost(left.FULLNAME = right.FULLNAME and left.LOCALE = right.LOCALE,1000),skew(1)),hash(DID1));
// Join mj27 which has blocking specificity of 29
dn27 := h(FULLNAME NOT IN SET(s.nulls_FULLNAME,FULLNAME) and SEC_RANGE NOT IN SET(s.nulls_SEC_RANGE,SEC_RANGE));
ngadl.MAC_Remove_WithDups(dn27,(string)FULLNAME + (string)SEC_RANGE,1000,dn27_deduped)
mj27 := distribute( join( dn27_deduped, dn27_deduped, left.DID > right.DID and left.FULLNAME = right.FULLNAME and left.SEC_RANGE = right.SEC_RANGE,match_join(left,right,27),atmost(left.FULLNAME = right.FULLNAME and left.SEC_RANGE = right.SEC_RANGE,1000),skew(1)),hash(DID1));
// Join mj28 which has blocking specificity of 30
dn28 := h((DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) OR DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) OR DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)) and ADDR1 NOT IN SET(s.nulls_ADDR1,ADDR1));
ngadl.MAC_Remove_WithDups(dn28,(string)DOB_year + (string)DOB_month + (string)DOB_day + (string)ADDR1,1000,dn28_deduped)
mj28 := distribute( join( dn28_deduped, dn28_deduped, left.DID > right.DID and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.ADDR1 = right.ADDR1,match_join(left,right,28),atmost(left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.ADDR1 = right.ADDR1,1000),skew(1)),hash(DID1));
// Join mj29 which has blocking specificity of 29
dn29 := h((DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) OR DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) OR DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)) and LNAME NOT IN SET(s.nulls_LNAME,LNAME));
ngadl.MAC_Remove_WithDups(dn29,(string)DOB_year + (string)DOB_month + (string)DOB_day + (string)LNAME,1000,dn29_deduped)
mj29 := distribute( join( dn29_deduped, dn29_deduped, left.DID > right.DID and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.LNAME = right.LNAME,match_join(left,right,29),atmost(left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.LNAME = right.LNAME,1000),skew(1)),hash(DID1));
// Join mj30 which has blocking specificity of 29
dn30 := h((DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) OR DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) OR DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)) and PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME));
ngadl.MAC_Remove_WithDups(dn30,(string)DOB_year + (string)DOB_month + (string)DOB_day + (string)PRIM_NAME,1000,dn30_deduped)
mj30 := distribute( join( dn30_deduped, dn30_deduped, left.DID > right.DID and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.PRIM_NAME = right.PRIM_NAME,match_join(left,right,30),atmost(left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.PRIM_NAME = right.PRIM_NAME,1000),skew(1)),hash(DID1));
// Join mj31 which has blocking specificity of 29
dn31 := h((DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) OR DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) OR DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)) and PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE));
ngadl.MAC_Remove_WithDups(dn31,(string)DOB_year + (string)DOB_month + (string)DOB_day + (string)PRIM_RANGE,1000,dn31_deduped)
mj31 := distribute( join( dn31_deduped, dn31_deduped, left.DID > right.DID and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.PRIM_RANGE = right.PRIM_RANGE,match_join(left,right,31),atmost(left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.PRIM_RANGE = right.PRIM_RANGE,1000),skew(1)),hash(DID1));
// Join mj32 which has blocking specificity of 28
dn32 := h((DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) OR DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) OR DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)) and CITY_NAME NOT IN SET(s.nulls_CITY_NAME,CITY_NAME));
ngadl.MAC_Remove_WithDups(dn32,(string)DOB_year + (string)DOB_month + (string)DOB_day + (string)CITY_NAME,1000,dn32_deduped)
mj32 := distribute( join( dn32_deduped, dn32_deduped, left.DID > right.DID and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.CITY_NAME = right.CITY_NAME,match_join(left,right,32),atmost(left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.CITY_NAME = right.CITY_NAME,1000),skew(1)),hash(DID1));
// Join mj33 which has blocking specificity of 28
dn33 := h((DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) OR DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) OR DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)) and LOCALE NOT IN SET(s.nulls_LOCALE,LOCALE));
ngadl.MAC_Remove_WithDups(dn33,(string)DOB_year + (string)DOB_month + (string)DOB_day + (string)LOCALE,1000,dn33_deduped)
mj33 := distribute( join( dn33_deduped, dn33_deduped, left.DID > right.DID and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.LOCALE = right.LOCALE,match_join(left,right,33),atmost(left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.LOCALE = right.LOCALE,1000),skew(1)),hash(DID1));
// Join mj34 which has blocking specificity of 27
dn34 := h((DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) OR DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) OR DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)) and FNAME NOT IN SET(s.nulls_FNAME,FNAME));
ngadl.MAC_Remove_WithDups(dn34,(string)DOB_year + (string)DOB_month + (string)DOB_day + (string)FNAME,1000,dn34_deduped)
mj34 := distribute( join( dn34_deduped, dn34_deduped, left.DID > right.DID and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.FNAME = right.FNAME,match_join(left,right,34),atmost(left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.FNAME = right.FNAME,1000),skew(1)),hash(DID1));
mjs2_t :=  mj21+ mj22+ mj23+ mj24+ mj25+ mj26+ mj27+ mj28+ mj29+ mj30+ mj31+ mj32+ mj33+ mj34;
ngadl.mac_select_best_matches(mjs2_t,DID1,DID2,Conf,Rule,o2);
mjs2 := o2 : persist('temp::DID::mj2');
// Join mj35 which has blocking specificity of 33
dn35 := h(ADDR1 NOT IN SET(s.nulls_ADDR1,ADDR1) and LNAME NOT IN SET(s.nulls_LNAME,LNAME) and CITY_NAME NOT IN SET(s.nulls_CITY_NAME,CITY_NAME));
ngadl.MAC_Remove_WithDups(dn35,(string)ADDR1 + (string)LNAME + (string)CITY_NAME,1000,dn35_deduped)
mj35 := distribute( join( dn35_deduped, dn35_deduped, left.DID > right.DID and left.ADDR1 = right.ADDR1 and left.LNAME = right.LNAME and left.CITY_NAME = right.CITY_NAME,match_join(left,right,35),atmost(left.ADDR1 = right.ADDR1 and left.LNAME = right.LNAME and left.CITY_NAME = right.CITY_NAME,1000),skew(1)),hash(DID1));
// Join mj36 which has blocking specificity of 33
dn36 := h(ADDR1 NOT IN SET(s.nulls_ADDR1,ADDR1) and LNAME NOT IN SET(s.nulls_LNAME,LNAME) and LOCALE NOT IN SET(s.nulls_LOCALE,LOCALE));
ngadl.MAC_Remove_WithDups(dn36,(string)ADDR1 + (string)LNAME + (string)LOCALE,1000,dn36_deduped)
mj36 := distribute( join( dn36_deduped, dn36_deduped, left.DID > right.DID and left.ADDR1 = right.ADDR1 and left.LNAME = right.LNAME and left.LOCALE = right.LOCALE,match_join(left,right,36),atmost(left.ADDR1 = right.ADDR1 and left.LNAME = right.LNAME and left.LOCALE = right.LOCALE,1000),skew(1)),hash(DID1));
// Join mj37 which has blocking specificity of 32
dn37 := h(ADDR1 NOT IN SET(s.nulls_ADDR1,ADDR1) and LNAME NOT IN SET(s.nulls_LNAME,LNAME) and FNAME NOT IN SET(s.nulls_FNAME,FNAME));
ngadl.MAC_Remove_WithDups(dn37,(string)ADDR1 + (string)LNAME + (string)FNAME,1000,dn37_deduped)
mj37 := distribute( join( dn37_deduped, dn37_deduped, left.DID > right.DID and left.ADDR1 = right.ADDR1 and left.LNAME = right.LNAME and left.FNAME = right.FNAME,match_join(left,right,37),atmost(left.ADDR1 = right.ADDR1 and left.LNAME = right.LNAME and left.FNAME = right.FNAME,1000),skew(1)),hash(DID1));
// Join mj38 which has blocking specificity of 30
dn38 := h(ADDR1 NOT IN SET(s.nulls_ADDR1,ADDR1) and LNAME NOT IN SET(s.nulls_LNAME,LNAME) and SEC_RANGE NOT IN SET(s.nulls_SEC_RANGE,SEC_RANGE));
ngadl.MAC_Remove_WithDups(dn38,(string)ADDR1 + (string)LNAME + (string)SEC_RANGE,1000,dn38_deduped)
mj38 := distribute( join( dn38_deduped, dn38_deduped, left.DID > right.DID and left.ADDR1 = right.ADDR1 and left.LNAME = right.LNAME and left.SEC_RANGE = right.SEC_RANGE,match_join(left,right,38),atmost(left.ADDR1 = right.ADDR1 and left.LNAME = right.LNAME and left.SEC_RANGE = right.SEC_RANGE,1000),skew(1)),hash(DID1));
// Join mj39 which has blocking specificity of 31
dn39 := h(ADDR1 NOT IN SET(s.nulls_ADDR1,ADDR1) and CITY_NAME NOT IN SET(s.nulls_CITY_NAME,CITY_NAME) and FNAME NOT IN SET(s.nulls_FNAME,FNAME));
ngadl.MAC_Remove_WithDups(dn39,(string)ADDR1 + (string)CITY_NAME + (string)FNAME,1000,dn39_deduped)
mj39 := distribute( join( dn39_deduped, dn39_deduped, left.DID > right.DID and left.ADDR1 = right.ADDR1 and left.CITY_NAME = right.CITY_NAME and left.FNAME = right.FNAME,match_join(left,right,39),atmost(left.ADDR1 = right.ADDR1 and left.CITY_NAME = right.CITY_NAME and left.FNAME = right.FNAME,1000),skew(1)),hash(DID1));
// Join mj40 which has blocking specificity of 29
dn40 := h(ADDR1 NOT IN SET(s.nulls_ADDR1,ADDR1) and CITY_NAME NOT IN SET(s.nulls_CITY_NAME,CITY_NAME) and SEC_RANGE NOT IN SET(s.nulls_SEC_RANGE,SEC_RANGE));
ngadl.MAC_Remove_WithDups(dn40,(string)ADDR1 + (string)CITY_NAME + (string)SEC_RANGE,1000,dn40_deduped)
mj40 := distribute( join( dn40_deduped, dn40_deduped, left.DID > right.DID and left.ADDR1 = right.ADDR1 and left.CITY_NAME = right.CITY_NAME and left.SEC_RANGE = right.SEC_RANGE,match_join(left,right,40),atmost(left.ADDR1 = right.ADDR1 and left.CITY_NAME = right.CITY_NAME and left.SEC_RANGE = right.SEC_RANGE,1000),skew(1)),hash(DID1));
// Join mj41 which has blocking specificity of 31
dn41 := h(ADDR1 NOT IN SET(s.nulls_ADDR1,ADDR1) and LOCALE NOT IN SET(s.nulls_LOCALE,LOCALE) and FNAME NOT IN SET(s.nulls_FNAME,FNAME));
ngadl.MAC_Remove_WithDups(dn41,(string)ADDR1 + (string)LOCALE + (string)FNAME,1000,dn41_deduped)
mj41 := distribute( join( dn41_deduped, dn41_deduped, left.DID > right.DID and left.ADDR1 = right.ADDR1 and left.LOCALE = right.LOCALE and left.FNAME = right.FNAME,match_join(left,right,41),atmost(left.ADDR1 = right.ADDR1 and left.LOCALE = right.LOCALE and left.FNAME = right.FNAME,1000),skew(1)),hash(DID1));
// Join mj42 which has blocking specificity of 29
dn42 := h(ADDR1 NOT IN SET(s.nulls_ADDR1,ADDR1) and LOCALE NOT IN SET(s.nulls_LOCALE,LOCALE) and SEC_RANGE NOT IN SET(s.nulls_SEC_RANGE,SEC_RANGE));
ngadl.MAC_Remove_WithDups(dn42,(string)ADDR1 + (string)LOCALE + (string)SEC_RANGE,1000,dn42_deduped)
mj42 := distribute( join( dn42_deduped, dn42_deduped, left.DID > right.DID and left.ADDR1 = right.ADDR1 and left.LOCALE = right.LOCALE and left.SEC_RANGE = right.SEC_RANGE,match_join(left,right,42),atmost(left.ADDR1 = right.ADDR1 and left.LOCALE = right.LOCALE and left.SEC_RANGE = right.SEC_RANGE,1000),skew(1)),hash(DID1));
// Join mj43 which has blocking specificity of 28
dn43 := h(ADDR1 NOT IN SET(s.nulls_ADDR1,ADDR1) and FNAME NOT IN SET(s.nulls_FNAME,FNAME) and SEC_RANGE NOT IN SET(s.nulls_SEC_RANGE,SEC_RANGE));
ngadl.MAC_Remove_WithDups(dn43,(string)ADDR1 + (string)FNAME + (string)SEC_RANGE,1000,dn43_deduped)
mj43 := distribute( join( dn43_deduped, dn43_deduped, left.DID > right.DID and left.ADDR1 = right.ADDR1 and left.FNAME = right.FNAME and left.SEC_RANGE = right.SEC_RANGE,match_join(left,right,43),atmost(left.ADDR1 = right.ADDR1 and left.FNAME = right.FNAME and left.SEC_RANGE = right.SEC_RANGE,1000),skew(1)),hash(DID1));
// Join mj44 which has blocking specificity of 33
dn44 := h(LNAME NOT IN SET(s.nulls_LNAME,LNAME) and PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME) and PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE));
ngadl.MAC_Remove_WithDups(dn44,(string)LNAME + (string)PRIM_NAME + (string)PRIM_RANGE,1000,dn44_deduped)
mj44 := distribute( join( dn44_deduped, dn44_deduped, left.DID > right.DID and left.LNAME = right.LNAME and left.PRIM_NAME = right.PRIM_NAME and left.PRIM_RANGE = right.PRIM_RANGE,match_join(left,right,44),atmost(left.LNAME = right.LNAME and left.PRIM_NAME = right.PRIM_NAME and left.PRIM_RANGE = right.PRIM_RANGE,1000),skew(1)),hash(DID1));
// Join mj45 which has blocking specificity of 32
dn45 := h(LNAME NOT IN SET(s.nulls_LNAME,LNAME) and PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME) and CITY_NAME NOT IN SET(s.nulls_CITY_NAME,CITY_NAME));
ngadl.MAC_Remove_WithDups(dn45,(string)LNAME + (string)PRIM_NAME + (string)CITY_NAME,1000,dn45_deduped)
mj45 := distribute( join( dn45_deduped, dn45_deduped, left.DID > right.DID and left.LNAME = right.LNAME and left.PRIM_NAME = right.PRIM_NAME and left.CITY_NAME = right.CITY_NAME,match_join(left,right,45),atmost(left.LNAME = right.LNAME and left.PRIM_NAME = right.PRIM_NAME and left.CITY_NAME = right.CITY_NAME,1000),skew(1)),hash(DID1));
// Join mj46 which has blocking specificity of 32
dn46 := h(LNAME NOT IN SET(s.nulls_LNAME,LNAME) and PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME) and LOCALE NOT IN SET(s.nulls_LOCALE,LOCALE));
ngadl.MAC_Remove_WithDups(dn46,(string)LNAME + (string)PRIM_NAME + (string)LOCALE,1000,dn46_deduped)
mj46 := distribute( join( dn46_deduped, dn46_deduped, left.DID > right.DID and left.LNAME = right.LNAME and left.PRIM_NAME = right.PRIM_NAME and left.LOCALE = right.LOCALE,match_join(left,right,46),atmost(left.LNAME = right.LNAME and left.PRIM_NAME = right.PRIM_NAME and left.LOCALE = right.LOCALE,1000),skew(1)),hash(DID1));
// Join mj47 which has blocking specificity of 31
dn47 := h(LNAME NOT IN SET(s.nulls_LNAME,LNAME) and PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME) and FNAME NOT IN SET(s.nulls_FNAME,FNAME));
ngadl.MAC_Remove_WithDups(dn47,(string)LNAME + (string)PRIM_NAME + (string)FNAME,1000,dn47_deduped)
mj47 := distribute( join( dn47_deduped, dn47_deduped, left.DID > right.DID and left.LNAME = right.LNAME and left.PRIM_NAME = right.PRIM_NAME and left.FNAME = right.FNAME,match_join(left,right,47),atmost(left.LNAME = right.LNAME and left.PRIM_NAME = right.PRIM_NAME and left.FNAME = right.FNAME,1000),skew(1)),hash(DID1));
// Join mj48 which has blocking specificity of 29
dn48 := h(LNAME NOT IN SET(s.nulls_LNAME,LNAME) and PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME) and SEC_RANGE NOT IN SET(s.nulls_SEC_RANGE,SEC_RANGE));
ngadl.MAC_Remove_WithDups(dn48,(string)LNAME + (string)PRIM_NAME + (string)SEC_RANGE,1000,dn48_deduped)
mj48 := distribute( join( dn48_deduped, dn48_deduped, left.DID > right.DID and left.LNAME = right.LNAME and left.PRIM_NAME = right.PRIM_NAME and left.SEC_RANGE = right.SEC_RANGE,match_join(left,right,48),atmost(left.LNAME = right.LNAME and left.PRIM_NAME = right.PRIM_NAME and left.SEC_RANGE = right.SEC_RANGE,1000),skew(1)),hash(DID1));
// Join mj49 which has blocking specificity of 32
dn49 := h(LNAME NOT IN SET(s.nulls_LNAME,LNAME) and PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) and CITY_NAME NOT IN SET(s.nulls_CITY_NAME,CITY_NAME));
ngadl.MAC_Remove_WithDups(dn49,(string)LNAME + (string)PRIM_RANGE + (string)CITY_NAME,1000,dn49_deduped)
mj49 := distribute( join( dn49_deduped, dn49_deduped, left.DID > right.DID and left.LNAME = right.LNAME and left.PRIM_RANGE = right.PRIM_RANGE and left.CITY_NAME = right.CITY_NAME,match_join(left,right,49),atmost(left.LNAME = right.LNAME and left.PRIM_RANGE = right.PRIM_RANGE and left.CITY_NAME = right.CITY_NAME,1000),skew(1)),hash(DID1));
// Join mj50 which has blocking specificity of 32
dn50 := h(LNAME NOT IN SET(s.nulls_LNAME,LNAME) and PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) and LOCALE NOT IN SET(s.nulls_LOCALE,LOCALE));
ngadl.MAC_Remove_WithDups(dn50,(string)LNAME + (string)PRIM_RANGE + (string)LOCALE,1000,dn50_deduped)
mj50 := distribute( join( dn50_deduped, dn50_deduped, left.DID > right.DID and left.LNAME = right.LNAME and left.PRIM_RANGE = right.PRIM_RANGE and left.LOCALE = right.LOCALE,match_join(left,right,50),atmost(left.LNAME = right.LNAME and left.PRIM_RANGE = right.PRIM_RANGE and left.LOCALE = right.LOCALE,1000),skew(1)),hash(DID1));
// Join mj51 which has blocking specificity of 31
dn51 := h(LNAME NOT IN SET(s.nulls_LNAME,LNAME) and PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) and FNAME NOT IN SET(s.nulls_FNAME,FNAME));
ngadl.MAC_Remove_WithDups(dn51,(string)LNAME + (string)PRIM_RANGE + (string)FNAME,1000,dn51_deduped)
mj51 := distribute( join( dn51_deduped, dn51_deduped, left.DID > right.DID and left.LNAME = right.LNAME and left.PRIM_RANGE = right.PRIM_RANGE and left.FNAME = right.FNAME,match_join(left,right,51),atmost(left.LNAME = right.LNAME and left.PRIM_RANGE = right.PRIM_RANGE and left.FNAME = right.FNAME,1000),skew(1)),hash(DID1));
// Join mj52 which has blocking specificity of 29
dn52 := h(LNAME NOT IN SET(s.nulls_LNAME,LNAME) and PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) and SEC_RANGE NOT IN SET(s.nulls_SEC_RANGE,SEC_RANGE));
ngadl.MAC_Remove_WithDups(dn52,(string)LNAME + (string)PRIM_RANGE + (string)SEC_RANGE,1000,dn52_deduped)
mj52 := distribute( join( dn52_deduped, dn52_deduped, left.DID > right.DID and left.LNAME = right.LNAME and left.PRIM_RANGE = right.PRIM_RANGE and left.SEC_RANGE = right.SEC_RANGE,match_join(left,right,52),atmost(left.LNAME = right.LNAME and left.PRIM_RANGE = right.PRIM_RANGE and left.SEC_RANGE = right.SEC_RANGE,1000),skew(1)),hash(DID1));
// Join mj53 which has blocking specificity of 30
dn53 := h(LNAME NOT IN SET(s.nulls_LNAME,LNAME) and CITY_NAME NOT IN SET(s.nulls_CITY_NAME,CITY_NAME) and FNAME NOT IN SET(s.nulls_FNAME,FNAME));
ngadl.MAC_Remove_WithDups(dn53,(string)LNAME + (string)CITY_NAME + (string)FNAME,1000,dn53_deduped)
mj53 := distribute( join( dn53_deduped, dn53_deduped, left.DID > right.DID and left.LNAME = right.LNAME and left.CITY_NAME = right.CITY_NAME and left.FNAME = right.FNAME,match_join(left,right,53),atmost(left.LNAME = right.LNAME and left.CITY_NAME = right.CITY_NAME and left.FNAME = right.FNAME,1000),skew(1)),hash(DID1));
// Join mj54 which has blocking specificity of 28
dn54 := h(LNAME NOT IN SET(s.nulls_LNAME,LNAME) and CITY_NAME NOT IN SET(s.nulls_CITY_NAME,CITY_NAME) and SEC_RANGE NOT IN SET(s.nulls_SEC_RANGE,SEC_RANGE));
ngadl.MAC_Remove_WithDups(dn54,(string)LNAME + (string)CITY_NAME + (string)SEC_RANGE,1000,dn54_deduped)
mj54 := distribute( join( dn54_deduped, dn54_deduped, left.DID > right.DID and left.LNAME = right.LNAME and left.CITY_NAME = right.CITY_NAME and left.SEC_RANGE = right.SEC_RANGE,match_join(left,right,54),atmost(left.LNAME = right.LNAME and left.CITY_NAME = right.CITY_NAME and left.SEC_RANGE = right.SEC_RANGE,1000),skew(1)),hash(DID1));
// Join mj55 which has blocking specificity of 30
dn55 := h(LNAME NOT IN SET(s.nulls_LNAME,LNAME) and LOCALE NOT IN SET(s.nulls_LOCALE,LOCALE) and FNAME NOT IN SET(s.nulls_FNAME,FNAME));
ngadl.MAC_Remove_WithDups(dn55,(string)LNAME + (string)LOCALE + (string)FNAME,1000,dn55_deduped)
mj55 := distribute( join( dn55_deduped, dn55_deduped, left.DID > right.DID and left.LNAME = right.LNAME and left.LOCALE = right.LOCALE and left.FNAME = right.FNAME,match_join(left,right,55),atmost(left.LNAME = right.LNAME and left.LOCALE = right.LOCALE and left.FNAME = right.FNAME,1000),skew(1)),hash(DID1));
// Join mj56 which has blocking specificity of 28
dn56 := h(LNAME NOT IN SET(s.nulls_LNAME,LNAME) and LOCALE NOT IN SET(s.nulls_LOCALE,LOCALE) and SEC_RANGE NOT IN SET(s.nulls_SEC_RANGE,SEC_RANGE));
ngadl.MAC_Remove_WithDups(dn56,(string)LNAME + (string)LOCALE + (string)SEC_RANGE,1000,dn56_deduped)
mj56 := distribute( join( dn56_deduped, dn56_deduped, left.DID > right.DID and left.LNAME = right.LNAME and left.LOCALE = right.LOCALE and left.SEC_RANGE = right.SEC_RANGE,match_join(left,right,56),atmost(left.LNAME = right.LNAME and left.LOCALE = right.LOCALE and left.SEC_RANGE = right.SEC_RANGE,1000),skew(1)),hash(DID1));
// Join mj57 which has blocking specificity of 27
dn57 := h(LNAME NOT IN SET(s.nulls_LNAME,LNAME) and FNAME NOT IN SET(s.nulls_FNAME,FNAME) and SEC_RANGE NOT IN SET(s.nulls_SEC_RANGE,SEC_RANGE));
ngadl.MAC_Remove_WithDups(dn57,(string)LNAME + (string)FNAME + (string)SEC_RANGE,1000,dn57_deduped)
mj57 := distribute( join( dn57_deduped, dn57_deduped, left.DID > right.DID and left.LNAME = right.LNAME and left.FNAME = right.FNAME and left.SEC_RANGE = right.SEC_RANGE,match_join(left,right,57),atmost(left.LNAME = right.LNAME and left.FNAME = right.FNAME and left.SEC_RANGE = right.SEC_RANGE,1000),skew(1)),hash(DID1));
mjs3_t :=  mj35+ mj36+ mj37+ mj38+ mj39+ mj40+ mj41+ mj42+ mj43+ mj44+ mj45+ mj46+ mj47+ mj48+ mj49+ mj50+ mj51+ mj52+ mj53+ mj54+ mj55+ mj56+ mj57;
ngadl.mac_select_best_matches(mjs3_t,DID1,DID2,Conf,Rule,o3);
mjs3 := o3 : persist('temp::DID::mj3');
// Join mj58 which has blocking specificity of 32
dn58 := h(PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME) and PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) and CITY_NAME NOT IN SET(s.nulls_CITY_NAME,CITY_NAME));
ngadl.MAC_Remove_WithDups(dn58,(string)PRIM_NAME + (string)PRIM_RANGE + (string)CITY_NAME,1000,dn58_deduped)
mj58 := distribute( join( dn58_deduped, dn58_deduped, left.DID > right.DID and left.PRIM_NAME = right.PRIM_NAME and left.PRIM_RANGE = right.PRIM_RANGE and left.CITY_NAME = right.CITY_NAME,match_join(left,right,58),atmost(left.PRIM_NAME = right.PRIM_NAME and left.PRIM_RANGE = right.PRIM_RANGE and left.CITY_NAME = right.CITY_NAME,1000),skew(1)),hash(DID1));
// Join mj59 which has blocking specificity of 32
dn59 := h(PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME) and PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) and LOCALE NOT IN SET(s.nulls_LOCALE,LOCALE));
ngadl.MAC_Remove_WithDups(dn59,(string)PRIM_NAME + (string)PRIM_RANGE + (string)LOCALE,1000,dn59_deduped)
mj59 := distribute( join( dn59_deduped, dn59_deduped, left.DID > right.DID and left.PRIM_NAME = right.PRIM_NAME and left.PRIM_RANGE = right.PRIM_RANGE and left.LOCALE = right.LOCALE,match_join(left,right,59),atmost(left.PRIM_NAME = right.PRIM_NAME and left.PRIM_RANGE = right.PRIM_RANGE and left.LOCALE = right.LOCALE,1000),skew(1)),hash(DID1));
// Join mj60 which has blocking specificity of 31
dn60 := h(PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME) and PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) and FNAME NOT IN SET(s.nulls_FNAME,FNAME));
ngadl.MAC_Remove_WithDups(dn60,(string)PRIM_NAME + (string)PRIM_RANGE + (string)FNAME,1000,dn60_deduped)
mj60 := distribute( join( dn60_deduped, dn60_deduped, left.DID > right.DID and left.PRIM_NAME = right.PRIM_NAME and left.PRIM_RANGE = right.PRIM_RANGE and left.FNAME = right.FNAME,match_join(left,right,60),atmost(left.PRIM_NAME = right.PRIM_NAME and left.PRIM_RANGE = right.PRIM_RANGE and left.FNAME = right.FNAME,1000),skew(1)),hash(DID1));
// Join mj61 which has blocking specificity of 29
dn61 := h(PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME) and PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) and SEC_RANGE NOT IN SET(s.nulls_SEC_RANGE,SEC_RANGE));
ngadl.MAC_Remove_WithDups(dn61,(string)PRIM_NAME + (string)PRIM_RANGE + (string)SEC_RANGE,1000,dn61_deduped)
mj61 := distribute( join( dn61_deduped, dn61_deduped, left.DID > right.DID and left.PRIM_NAME = right.PRIM_NAME and left.PRIM_RANGE = right.PRIM_RANGE and left.SEC_RANGE = right.SEC_RANGE,match_join(left,right,61),atmost(left.PRIM_NAME = right.PRIM_NAME and left.PRIM_RANGE = right.PRIM_RANGE and left.SEC_RANGE = right.SEC_RANGE,1000),skew(1)),hash(DID1));
// Join mj62 which has blocking specificity of 30
dn62 := h(PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME) and CITY_NAME NOT IN SET(s.nulls_CITY_NAME,CITY_NAME) and FNAME NOT IN SET(s.nulls_FNAME,FNAME));
ngadl.MAC_Remove_WithDups(dn62,(string)PRIM_NAME + (string)CITY_NAME + (string)FNAME,1000,dn62_deduped)
mj62 := distribute( join( dn62_deduped, dn62_deduped, left.DID > right.DID and left.PRIM_NAME = right.PRIM_NAME and left.CITY_NAME = right.CITY_NAME and left.FNAME = right.FNAME,match_join(left,right,62),atmost(left.PRIM_NAME = right.PRIM_NAME and left.CITY_NAME = right.CITY_NAME and left.FNAME = right.FNAME,1000),skew(1)),hash(DID1));
// Join mj63 which has blocking specificity of 28
dn63 := h(PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME) and CITY_NAME NOT IN SET(s.nulls_CITY_NAME,CITY_NAME) and SEC_RANGE NOT IN SET(s.nulls_SEC_RANGE,SEC_RANGE));
ngadl.MAC_Remove_WithDups(dn63,(string)PRIM_NAME + (string)CITY_NAME + (string)SEC_RANGE,1000,dn63_deduped)
mj63 := distribute( join( dn63_deduped, dn63_deduped, left.DID > right.DID and left.PRIM_NAME = right.PRIM_NAME and left.CITY_NAME = right.CITY_NAME and left.SEC_RANGE = right.SEC_RANGE,match_join(left,right,63),atmost(left.PRIM_NAME = right.PRIM_NAME and left.CITY_NAME = right.CITY_NAME and left.SEC_RANGE = right.SEC_RANGE,1000),skew(1)),hash(DID1));
// Join mj64 which has blocking specificity of 30
dn64 := h(PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME) and LOCALE NOT IN SET(s.nulls_LOCALE,LOCALE) and FNAME NOT IN SET(s.nulls_FNAME,FNAME));
ngadl.MAC_Remove_WithDups(dn64,(string)PRIM_NAME + (string)LOCALE + (string)FNAME,1000,dn64_deduped)
mj64 := distribute( join( dn64_deduped, dn64_deduped, left.DID > right.DID and left.PRIM_NAME = right.PRIM_NAME and left.LOCALE = right.LOCALE and left.FNAME = right.FNAME,match_join(left,right,64),atmost(left.PRIM_NAME = right.PRIM_NAME and left.LOCALE = right.LOCALE and left.FNAME = right.FNAME,1000),skew(1)),hash(DID1));
// Join mj65 which has blocking specificity of 28
dn65 := h(PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME) and LOCALE NOT IN SET(s.nulls_LOCALE,LOCALE) and SEC_RANGE NOT IN SET(s.nulls_SEC_RANGE,SEC_RANGE));
ngadl.MAC_Remove_WithDups(dn65,(string)PRIM_NAME + (string)LOCALE + (string)SEC_RANGE,1000,dn65_deduped)
mj65 := distribute( join( dn65_deduped, dn65_deduped, left.DID > right.DID and left.PRIM_NAME = right.PRIM_NAME and left.LOCALE = right.LOCALE and left.SEC_RANGE = right.SEC_RANGE,match_join(left,right,65),atmost(left.PRIM_NAME = right.PRIM_NAME and left.LOCALE = right.LOCALE and left.SEC_RANGE = right.SEC_RANGE,1000),skew(1)),hash(DID1));
// Join mj66 which has blocking specificity of 27
dn66 := h(PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME) and FNAME NOT IN SET(s.nulls_FNAME,FNAME) and SEC_RANGE NOT IN SET(s.nulls_SEC_RANGE,SEC_RANGE));
ngadl.MAC_Remove_WithDups(dn66,(string)PRIM_NAME + (string)FNAME + (string)SEC_RANGE,1000,dn66_deduped)
mj66 := distribute( join( dn66_deduped, dn66_deduped, left.DID > right.DID and left.PRIM_NAME = right.PRIM_NAME and left.FNAME = right.FNAME and left.SEC_RANGE = right.SEC_RANGE,match_join(left,right,66),atmost(left.PRIM_NAME = right.PRIM_NAME and left.FNAME = right.FNAME and left.SEC_RANGE = right.SEC_RANGE,1000),skew(1)),hash(DID1));
// Join mj67 which has blocking specificity of 30
dn67 := h(PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) and CITY_NAME NOT IN SET(s.nulls_CITY_NAME,CITY_NAME) and FNAME NOT IN SET(s.nulls_FNAME,FNAME));
ngadl.MAC_Remove_WithDups(dn67,(string)PRIM_RANGE + (string)CITY_NAME + (string)FNAME,1000,dn67_deduped)
mj67 := distribute( join( dn67_deduped, dn67_deduped, left.DID > right.DID and left.PRIM_RANGE = right.PRIM_RANGE and left.CITY_NAME = right.CITY_NAME and left.FNAME = right.FNAME,match_join(left,right,67),atmost(left.PRIM_RANGE = right.PRIM_RANGE and left.CITY_NAME = right.CITY_NAME and left.FNAME = right.FNAME,1000),skew(1)),hash(DID1));
// Join mj68 which has blocking specificity of 28
dn68 := h(PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) and CITY_NAME NOT IN SET(s.nulls_CITY_NAME,CITY_NAME) and SEC_RANGE NOT IN SET(s.nulls_SEC_RANGE,SEC_RANGE));
ngadl.MAC_Remove_WithDups(dn68,(string)PRIM_RANGE + (string)CITY_NAME + (string)SEC_RANGE,1000,dn68_deduped)
mj68 := distribute( join( dn68_deduped, dn68_deduped, left.DID > right.DID and left.PRIM_RANGE = right.PRIM_RANGE and left.CITY_NAME = right.CITY_NAME and left.SEC_RANGE = right.SEC_RANGE,match_join(left,right,68),atmost(left.PRIM_RANGE = right.PRIM_RANGE and left.CITY_NAME = right.CITY_NAME and left.SEC_RANGE = right.SEC_RANGE,1000),skew(1)),hash(DID1));
// Join mj69 which has blocking specificity of 30
dn69 := h(PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) and LOCALE NOT IN SET(s.nulls_LOCALE,LOCALE) and FNAME NOT IN SET(s.nulls_FNAME,FNAME));
ngadl.MAC_Remove_WithDups(dn69,(string)PRIM_RANGE + (string)LOCALE + (string)FNAME,1000,dn69_deduped)
mj69 := distribute( join( dn69_deduped, dn69_deduped, left.DID > right.DID and left.PRIM_RANGE = right.PRIM_RANGE and left.LOCALE = right.LOCALE and left.FNAME = right.FNAME,match_join(left,right,69),atmost(left.PRIM_RANGE = right.PRIM_RANGE and left.LOCALE = right.LOCALE and left.FNAME = right.FNAME,1000),skew(1)),hash(DID1));
// Join mj70 which has blocking specificity of 28
dn70 := h(PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) and LOCALE NOT IN SET(s.nulls_LOCALE,LOCALE) and SEC_RANGE NOT IN SET(s.nulls_SEC_RANGE,SEC_RANGE));
ngadl.MAC_Remove_WithDups(dn70,(string)PRIM_RANGE + (string)LOCALE + (string)SEC_RANGE,1000,dn70_deduped)
mj70 := distribute( join( dn70_deduped, dn70_deduped, left.DID > right.DID and left.PRIM_RANGE = right.PRIM_RANGE and left.LOCALE = right.LOCALE and left.SEC_RANGE = right.SEC_RANGE,match_join(left,right,70),atmost(left.PRIM_RANGE = right.PRIM_RANGE and left.LOCALE = right.LOCALE and left.SEC_RANGE = right.SEC_RANGE,1000),skew(1)),hash(DID1));
// Join mj71 which has blocking specificity of 27
dn71 := h(PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) and FNAME NOT IN SET(s.nulls_FNAME,FNAME) and SEC_RANGE NOT IN SET(s.nulls_SEC_RANGE,SEC_RANGE));
ngadl.MAC_Remove_WithDups(dn71,(string)PRIM_RANGE + (string)FNAME + (string)SEC_RANGE,1000,dn71_deduped)
mj71 := distribute( join( dn71_deduped, dn71_deduped, left.DID > right.DID and left.PRIM_RANGE = right.PRIM_RANGE and left.FNAME = right.FNAME and left.SEC_RANGE = right.SEC_RANGE,match_join(left,right,71),atmost(left.PRIM_RANGE = right.PRIM_RANGE and left.FNAME = right.FNAME and left.SEC_RANGE = right.SEC_RANGE,1000),skew(1)),hash(DID1));
mjs4_t :=  mj58+ mj59+ mj60+ mj61+ mj62+ mj63+ mj64+ mj65+ mj66+ mj67+ mj68+ mj69+ mj70+ mj71;
ngadl.mac_select_best_matches(mjs4_t,DID1,DID2,Conf,Rule,o4);
mjs4 := o4 : persist('temp::DID::mj4');
// Join mj72 which has blocking specificity of 32
dn72 := h(CITY_NAME NOT IN SET(s.nulls_CITY_NAME,CITY_NAME) and FNAME NOT IN SET(s.nulls_FNAME,FNAME) and SEC_RANGE NOT IN SET(s.nulls_SEC_RANGE,SEC_RANGE) and MNAME NOT IN SET(s.nulls_MNAME,MNAME));
ngadl.MAC_Remove_WithDups(dn72,(string)CITY_NAME + (string)FNAME + (string)SEC_RANGE + (string)MNAME,1000,dn72_deduped)
mj72 := distribute( join( dn72_deduped, dn72_deduped, left.DID > right.DID and left.CITY_NAME = right.CITY_NAME and left.FNAME = right.FNAME and left.SEC_RANGE = right.SEC_RANGE and left.MNAME = right.MNAME,match_join(left,right,72),atmost(left.CITY_NAME = right.CITY_NAME and left.FNAME = right.FNAME and left.SEC_RANGE = right.SEC_RANGE and left.MNAME = right.MNAME,1000),skew(1)),hash(DID1));
// Join mj73 which has blocking specificity of 32
dn73 := h(LOCALE NOT IN SET(s.nulls_LOCALE,LOCALE) and FNAME NOT IN SET(s.nulls_FNAME,FNAME) and SEC_RANGE NOT IN SET(s.nulls_SEC_RANGE,SEC_RANGE) and MNAME NOT IN SET(s.nulls_MNAME,MNAME));
ngadl.MAC_Remove_WithDups(dn73,(string)LOCALE + (string)FNAME + (string)SEC_RANGE + (string)MNAME,1000,dn73_deduped)
mj73 := distribute( join( dn73_deduped, dn73_deduped, left.DID > right.DID and left.LOCALE = right.LOCALE and left.FNAME = right.FNAME and left.SEC_RANGE = right.SEC_RANGE and left.MNAME = right.MNAME,match_join(left,right,73),atmost(left.LOCALE = right.LOCALE and left.FNAME = right.FNAME and left.SEC_RANGE = right.SEC_RANGE and left.MNAME = right.MNAME,1000),skew(1)),hash(DID1));
last_mjs_t := mj72+ mj73;
ngadl.mac_select_best_matches(last_mjs_t,DID1,DID2,Conf,Rule,o);
all_mjs :=  mjs0+ mjs1+ mjs2+ mjs3+ mjs4 +o;
export All_Matches := all_mjs : independent;
ngadl.mac_avoid_transitives(All_Matches,DID1,DID2,Conf,Rule,o);
export PossibleMatches := o : persist('temp::NGADL_DID_HEADER_mt');
export Matches := PossibleMatches(Conf>=MatchThreshold) : independent;
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
export MatchSampleRecords := Debug(ih).AnnotateMatches(Full_Sample_Matches,s);
//Now actually produce the new file
ut.MAC_Patch_Id(ih,DID,Matches,DID1,DID2,o);
export Patched_Infile := o;
//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,DID,Matches,DID1,DID2,o1);
export Patched_Candidates := o1;
//Now perform the safety checks
export PrePatchIdCount := count( dedup( table(ih,{DID}), DID, all ) );
export PostPatchIdCount := count( dedup( table(Patched_Infile,{DID}), DID, all ) );
export MatchesPerformed := count( Matches );
export MatchesPropAssisted := count( Matches(Conf_Prop>0) );
export MatchesPropRequired := count( Matches(Conf-Conf_Prop<MatchThreshold) );
export PatchingError0 := PrePatchIdCount - PostPatchIdCount - MatchesPerformed; // Should be zero
export DuplicateRids0 := count(Patched_Infile) - count(dedup(Patched_Infile,RID,all)); // Should be zero
export DidsNoRid0 := PostPatchIdCount - count(Patched_Infile(DID=RID)); // Should be zero
export DidsAboveRid0 := count(Patched_Infile(DID>RID)); // Should be zero
end;
