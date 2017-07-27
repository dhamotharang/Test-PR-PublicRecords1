// Begin code to perform the matching itself
import ngadl,ut;
export matches(dataset(layout_HEADER) ih) := module
shared h := match_candidates(ih).candidates;
shared MatchThreshold := 40;
shared LowerMatchThreshold := 37; // Keep extra 'borderlines' for debug purposes
shared s := Specificities(ih).Specificities[1];
match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,unsigned2 c) := transform
  self.Rule := c;
  self.DID1 := le.DID;
  self.DID2 := ri.DID;
  integer2 SSN_score := MAP( le.SSN  IN Specificities(ih).SSN_null_set or ri.SSN  IN Specificities(ih).SSN_null_set => 0,
                        le.SSN = ri.SSN => le.SSN_weight100,
                        ut.stringsimilar(le.SSN,ri.SSN) <= 1 => ngadl.fuzzy_specificity(le.SSN_weight100,le.SSN_cnt, le.SSN_e1_cnt,ri.SSN_weight100,ri.SSN_cnt,ri.SSN_e1_cnt),
                        ngadl.fail_scale(le.SSN_weight100,s.SSN_switch));
  integer2 VENDOR_ID_score := MAP( le.VENDOR_ID  IN Specificities(ih).VENDOR_ID_null_set or ri.VENDOR_ID  IN Specificities(ih).VENDOR_ID_null_set => 0,
                        le.SRC <> ri.SRC => 0, // Only valid if the context variable is equal
                        le.VENDOR_ID = ri.VENDOR_ID => le.VENDOR_ID_weight100,
                        ngadl.fail_scale(le.VENDOR_ID_weight100,s.VENDOR_ID_switch));
  integer2 PHONE_score := MAP( le.PHONE  IN Specificities(ih).PHONE_null_set or ri.PHONE  IN Specificities(ih).PHONE_null_set => 0,
                        le.PHONE = ri.PHONE => le.PHONE_weight100,
                        ngadl.fail_scale(le.PHONE_weight100,s.PHONE_switch));
  integer2 FULLNAME_score := MAP( le.FULLNAME  IN Specificities(ih).FULLNAME_null_set or ri.FULLNAME  IN Specificities(ih).FULLNAME_null_set => 0,
                        le.FULLNAME = ri.FULLNAME => le.FULLNAME_weight100,
                        0);
  integer2 DOB_year       := MAP ( le.DOB_year in Specificities(ih).DOB_year_null_set or ri.DOB_year in Specificities(ih).DOB_year_null_set => 0,
                                  le.DOB_year = ri.DOB_year => le.DOB_year_weight100,
                                  ngadl.fail_scale(le.DOB_year_weight100,s.DOB_year_switch) );
  integer2 DOB_month       := MAP ( le.DOB_month in Specificities(ih).DOB_month_null_set or ri.DOB_month in Specificities(ih).DOB_month_null_set => 0,
                                  le.DOB_month = ri.DOB_month => le.DOB_month_weight100,
                                  ngadl.fail_scale(le.DOB_month_weight100,s.DOB_month_switch) );
  integer2 DOB_day       := MAP ( le.DOB_day in Specificities(ih).DOB_day_null_set or ri.DOB_day in Specificities(ih).DOB_day_null_set => 0,
                                  le.DOB_day = ri.DOB_day => le.DOB_day_weight100,
                                  ngadl.fail_scale(le.DOB_day_weight100,s.DOB_day_switch) );
  integer2 DOB_score := MAP( le.DOB_year  IN Specificities(ih).DOB_year_null_set AND le.DOB_month  IN Specificities(ih).DOB_month_null_set AND le.DOB_day  IN Specificities(ih).DOB_day_null_set or ri.DOB_year  IN Specificities(ih).DOB_year_null_set AND ri.DOB_month  IN Specificities(ih).DOB_month_null_set AND ri.DOB_day  IN Specificities(ih).DOB_day_null_set => 0,
                        DOB_year+DOB_month+DOB_day < 0 or DOB_year+DOB_month+DOB_day<>0 and DOB_year+DOB_month+DOB_day < 700 => SKIP,
                        DOB_year+DOB_month+DOB_day);
  integer2 PRIM_RANGE_score := MAP( le.PRIM_RANGE  IN Specificities(ih).PRIM_RANGE_null_set or ri.PRIM_RANGE  IN Specificities(ih).PRIM_RANGE_null_set => 0,
                        le.PRIM_RANGE = ri.PRIM_RANGE => le.PRIM_RANGE_weight100,
                        ngadl.fail_scale(le.PRIM_RANGE_weight100,s.PRIM_RANGE_switch));
  integer2 SEC_RANGE_score := MAP( le.SEC_RANGE  IN Specificities(ih).SEC_RANGE_null_set or ri.SEC_RANGE  IN Specificities(ih).SEC_RANGE_null_set => 0,
                        le.SEC_RANGE = ri.SEC_RANGE => le.SEC_RANGE_weight100,
                        ngadl.fail_scale(le.SEC_RANGE_weight100,s.SEC_RANGE_switch));
  integer2 PRIM_NAME_score := MAP( le.PRIM_NAME  IN Specificities(ih).PRIM_NAME_null_set or ri.PRIM_NAME  IN Specificities(ih).PRIM_NAME_null_set => 0,
                        le.PRIM_NAME = ri.PRIM_NAME => le.PRIM_NAME_weight100,
                        ngadl.fail_scale(le.PRIM_NAME_weight100,s.PRIM_NAME_switch));
  integer2 LOCALE_score := MAP( le.LOCALE  IN Specificities(ih).LOCALE_null_set or ri.LOCALE  IN Specificities(ih).LOCALE_null_set => 0,
                        le.LOCALE = ri.LOCALE => le.LOCALE_weight100,
                        0);
  integer2 LNAME_score := MAP( le.LNAME  IN Specificities(ih).LNAME_null_set or ri.LNAME  IN Specificities(ih).LNAME_null_set => 0,
                        FULLNAME_score <> 0 => 0, // Parent has value so child keeps quiet
                        le.LNAME = ri.LNAME => le.LNAME_weight100,
                        ut.stringsimilar(le.LNAME,ri.LNAME) <= 2 => ngadl.fuzzy_specificity(le.LNAME_weight100,le.LNAME_cnt, le.LNAME_e2_cnt,ri.LNAME_weight100,ri.LNAME_cnt,ri.LNAME_e2_cnt),
                        ngadl.fail_scale(le.LNAME_weight100,s.LNAME_switch));
  integer2 FNAME_score := MAP( le.FNAME  IN Specificities(ih).FNAME_null_set or ri.FNAME  IN Specificities(ih).FNAME_null_set => SKIP,
                        FULLNAME_score <> 0 => 0, // Parent has value so child keeps quiet
                        le.FNAME = ri.FNAME => le.FNAME_weight100,
                        ut.stringsimilar(le.FNAME,ri.FNAME) <= 2 => ngadl.fuzzy_specificity(le.FNAME_weight100,le.FNAME_cnt, le.FNAME_e2_cnt,ri.FNAME_weight100,ri.FNAME_cnt,ri.FNAME_e2_cnt),
                        length(trim(le.FNAME))>0 and le.FNAME = ri.FNAME[length(trim(le.FNAME))] => le.FNAME_weight100, // An initial match - take initial specificity
                        length(trim(ri.FNAME))>0 and ri.FNAME = le.FNAME[length(trim(ri.FNAME))] => ri.FNAME_weight100,// An initial match - take initial specificity
                        SKIP);
  integer2 CITY_NAME_score := MAP( le.CITY_NAME  IN Specificities(ih).CITY_NAME_null_set or ri.CITY_NAME  IN Specificities(ih).CITY_NAME_null_set => 0,
                        LOCALE_score <> 0 => 0, // Parent has value so child keeps quiet
                        le.CITY_NAME = ri.CITY_NAME => le.CITY_NAME_weight100,
                        ngadl.fail_scale(le.CITY_NAME_weight100,s.CITY_NAME_switch));
  integer2 MNAME_score := MAP( le.MNAME  IN Specificities(ih).MNAME_null_set or ri.MNAME  IN Specificities(ih).MNAME_null_set => 0,
                        FULLNAME_score <> 0 => 0, // Parent has value so child keeps quiet
                        le.MNAME = ri.MNAME => le.MNAME_weight100,
                        ut.stringsimilar(le.MNAME,ri.MNAME) <= 2 => ngadl.fuzzy_specificity(le.MNAME_weight100,le.MNAME_cnt, le.MNAME_e2_cnt,ri.MNAME_weight100,ri.MNAME_cnt,ri.MNAME_e2_cnt),
                        length(trim(le.MNAME))>0 and le.MNAME = ri.MNAME[length(trim(le.MNAME))] => le.MNAME_weight100, // An initial match - take initial specificity
                        length(trim(ri.MNAME))>0 and ri.MNAME = le.MNAME[length(trim(ri.MNAME))] => ri.MNAME_weight100,// An initial match - take initial specificity
                        ngadl.fail_scale(le.MNAME_weight100,s.MNAME_switch));
  integer2 ST_score := MAP( le.ST  IN Specificities(ih).ST_null_set or ri.ST  IN Specificities(ih).ST_null_set => 0,
                        LOCALE_score <> 0 => 0, // Parent has value so child keeps quiet
                        le.ST = ri.ST => le.ST_weight100,
                        ngadl.fail_scale(le.ST_weight100,s.ST_switch));
  self.Conf_Prop := (if(le.SSN_prop or ri.SSN_prop,SSN_score,0) + if(le.PHONE_prop or ri.PHONE_prop,PHONE_score,0) + if(le.FULLNAME_prop or ri.FULLNAME_prop,FULLNAME_score,0) + if(le.DOB_prop or ri.DOB_prop,DOB_score,0) + if(le.FNAME_prop or ri.FNAME_prop,FNAME_score,0) + if(le.MNAME_prop or ri.MNAME_prop,MNAME_score,0)) / 100; // Score based on propogated fields
  self.Conf := (SSN_score + VENDOR_ID_score + PHONE_score + FULLNAME_score + DOB_score + LNAME_score + PRIM_RANGE_score + SEC_RANGE_score + PRIM_NAME_score + FNAME_score + CITY_NAME_score + LOCALE_score + MNAME_score + ST_score) / 100;
end;
//Now execute each of the 38 join conditions
// Join mj0 which has blocking specificity of 32
dn0 := h(SSN NOT IN Specificities(ih).SSN_null_set);
mj0 := join( dn0, dn0, left.DID > right.DID and left.SSN = right.SSN,match_join(left,right,0),atmost(left.SSN = right.SSN,1000),skew(1))( Conf >= LowerMatchThreshold );
// Join mj1 which has blocking specificity of 27
dn1 := h(VENDOR_ID NOT IN Specificities(ih).VENDOR_ID_null_set);
mj1 := join( dn1, dn1, left.DID > right.DID and left.VENDOR_ID = right.VENDOR_ID and left.SRC = right.SRC,match_join(left,right,1),atmost(left.VENDOR_ID = right.VENDOR_ID and left.SRC = right.SRC,1000),skew(1))( Conf >= LowerMatchThreshold );
// Join mj2 which has blocking specificity of 27
dn2 := h(PHONE NOT IN Specificities(ih).PHONE_null_set);
mj2 := join( dn2, dn2, left.DID > right.DID and left.PHONE = right.PHONE,match_join(left,right,2),atmost(left.PHONE = right.PHONE,1000),skew(1))( Conf >= LowerMatchThreshold );
t3 := distribute( h(FULLNAME NOT IN Specificities(ih).FULLNAME_null_set),hash(FULLNAME) ); // Save moving for each subsequent step
// Join mj3 which has blocking specificity of 43
dn3 := t3((DOB_year NOT IN Specificities(ih).DOB_year_null_set OR DOB_month NOT IN Specificities(ih).DOB_month_null_set OR DOB_day NOT IN Specificities(ih).DOB_day_null_set));
mj3 := join( dn3, dn3, left.DID > right.DID and left.FULLNAME = right.FULLNAME and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day,match_join(left,right,3),atmost(left.FULLNAME = right.FULLNAME and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day,1000),local)( Conf >= LowerMatchThreshold );
// Join mj4 which has blocking specificity of 39
dn4 := t3(PRIM_RANGE NOT IN Specificities(ih).PRIM_RANGE_null_set);
mj4 := join( dn4, dn4, left.DID > right.DID and left.FULLNAME = right.FULLNAME and left.PRIM_RANGE = right.PRIM_RANGE,match_join(left,right,4),atmost(left.FULLNAME = right.FULLNAME and left.PRIM_RANGE = right.PRIM_RANGE,1000),local)( Conf >= LowerMatchThreshold );
// Join mj5 which has blocking specificity of 39
dn5 := t3(SEC_RANGE NOT IN Specificities(ih).SEC_RANGE_null_set);
mj5 := join( dn5, dn5, left.DID > right.DID and left.FULLNAME = right.FULLNAME and left.SEC_RANGE = right.SEC_RANGE,match_join(left,right,5),atmost(left.FULLNAME = right.FULLNAME and left.SEC_RANGE = right.SEC_RANGE,1000),local)( Conf >= LowerMatchThreshold );
// Join mj6 which has blocking specificity of 38
dn6 := t3(PRIM_NAME NOT IN Specificities(ih).PRIM_NAME_null_set);
mj6 := join( dn6, dn6, left.DID > right.DID and left.FULLNAME = right.FULLNAME and left.PRIM_NAME = right.PRIM_NAME,match_join(left,right,6),atmost(left.FULLNAME = right.FULLNAME and left.PRIM_NAME = right.PRIM_NAME,1000),local)( Conf >= LowerMatchThreshold );
// Join mj7 which has blocking specificity of 38
dn7 := t3(CITY_NAME NOT IN Specificities(ih).CITY_NAME_null_set);
mj7 := join( dn7, dn7, left.DID > right.DID and left.FULLNAME = right.FULLNAME and left.CITY_NAME = right.CITY_NAME,match_join(left,right,7),atmost(left.FULLNAME = right.FULLNAME and left.CITY_NAME = right.CITY_NAME,1000),local)( Conf >= LowerMatchThreshold );
// Join mj8 which has blocking specificity of 38
dn8 := t3(LOCALE NOT IN Specificities(ih).LOCALE_null_set);
mj8 := join( dn8, dn8, left.DID > right.DID and left.FULLNAME = right.FULLNAME and left.LOCALE = right.LOCALE,match_join(left,right,8),atmost(left.FULLNAME = right.FULLNAME and left.LOCALE = right.LOCALE,1000),local)( Conf >= LowerMatchThreshold );
mjs0 :=  mj0+ mj1+ mj2+ mj3+ mj4+ mj5+ mj6+ mj7+ mj8 : persist('temp::DID::mj0');
t9 := distribute( h((DOB_year NOT IN Specificities(ih).DOB_year_null_set OR DOB_month NOT IN Specificities(ih).DOB_month_null_set OR DOB_day NOT IN Specificities(ih).DOB_day_null_set)),hash(DOB_year,DOB_month,DOB_day) ); // Save moving for each subsequent step
// Join mj9 which has blocking specificity of 33
dn9 := t9(LNAME NOT IN Specificities(ih).LNAME_null_set);
mj9 := join( dn9, dn9, left.DID > right.DID and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.LNAME = right.LNAME,match_join(left,right,9),atmost(left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.LNAME = right.LNAME,1000),local)( Conf >= LowerMatchThreshold );
// Join mj10 which has blocking specificity of 32
dn10 := t9(PRIM_RANGE NOT IN Specificities(ih).PRIM_RANGE_null_set);
mj10 := join( dn10, dn10, left.DID > right.DID and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.PRIM_RANGE = right.PRIM_RANGE,match_join(left,right,10),atmost(left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.PRIM_RANGE = right.PRIM_RANGE,1000),local)( Conf >= LowerMatchThreshold );
// Join mj11 which has blocking specificity of 32
dn11 := t9(SEC_RANGE NOT IN Specificities(ih).SEC_RANGE_null_set);
mj11 := join( dn11, dn11, left.DID > right.DID and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.SEC_RANGE = right.SEC_RANGE,match_join(left,right,11),atmost(left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.SEC_RANGE = right.SEC_RANGE,1000),local)( Conf >= LowerMatchThreshold );
// Join mj12 which has blocking specificity of 31
dn12 := t9(PRIM_NAME NOT IN Specificities(ih).PRIM_NAME_null_set);
mj12 := join( dn12, dn12, left.DID > right.DID and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.PRIM_NAME = right.PRIM_NAME,match_join(left,right,12),atmost(left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.PRIM_NAME = right.PRIM_NAME,1000),local)( Conf >= LowerMatchThreshold );
// Join mj13 which has blocking specificity of 31
dn13 := t9(FNAME NOT IN Specificities(ih).FNAME_null_set);
mj13 := join( dn13, dn13, left.DID > right.DID and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.FNAME = right.FNAME,match_join(left,right,13),atmost(left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.FNAME = right.FNAME,1000),local)( Conf >= LowerMatchThreshold );
// Join mj14 which has blocking specificity of 31
dn14 := t9(CITY_NAME NOT IN Specificities(ih).CITY_NAME_null_set);
mj14 := join( dn14, dn14, left.DID > right.DID and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.CITY_NAME = right.CITY_NAME,match_join(left,right,14),atmost(left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.CITY_NAME = right.CITY_NAME,1000),local)( Conf >= LowerMatchThreshold );
// Join mj15 which has blocking specificity of 31
dn15 := t9(LOCALE NOT IN Specificities(ih).LOCALE_null_set);
mj15 := join( dn15, dn15, left.DID > right.DID and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.LOCALE = right.LOCALE,match_join(left,right,15),atmost(left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day and left.LOCALE = right.LOCALE,1000),local)( Conf >= LowerMatchThreshold );
t16 := distribute( h(LNAME NOT IN Specificities(ih).LNAME_null_set),hash(LNAME) ); // Save moving for each subsequent step
// Join mj16 which has blocking specificity of 29
dn16 := t16(PRIM_RANGE NOT IN Specificities(ih).PRIM_RANGE_null_set);
mj16 := join( dn16, dn16, left.DID > right.DID and left.LNAME = right.LNAME and left.PRIM_RANGE = right.PRIM_RANGE,match_join(left,right,16),atmost(left.LNAME = right.LNAME and left.PRIM_RANGE = right.PRIM_RANGE,1000),local)( Conf >= LowerMatchThreshold );
// Join mj17 which has blocking specificity of 29
dn17 := t16(SEC_RANGE NOT IN Specificities(ih).SEC_RANGE_null_set);
mj17 := join( dn17, dn17, left.DID > right.DID and left.LNAME = right.LNAME and left.SEC_RANGE = right.SEC_RANGE,match_join(left,right,17),atmost(left.LNAME = right.LNAME and left.SEC_RANGE = right.SEC_RANGE,1000),local)( Conf >= LowerMatchThreshold );
// Join mj18 which has blocking specificity of 28
dn18 := t16(PRIM_NAME NOT IN Specificities(ih).PRIM_NAME_null_set);
mj18 := join( dn18, dn18, left.DID > right.DID and left.LNAME = right.LNAME and left.PRIM_NAME = right.PRIM_NAME,match_join(left,right,18),atmost(left.LNAME = right.LNAME and left.PRIM_NAME = right.PRIM_NAME,1000),local)( Conf >= LowerMatchThreshold );
// Join mj19 which has blocking specificity of 28
dn19 := t16(FNAME NOT IN Specificities(ih).FNAME_null_set);
mj19 := join( dn19, dn19, left.DID > right.DID and left.LNAME = right.LNAME and left.FNAME = right.FNAME,match_join(left,right,19),atmost(left.LNAME = right.LNAME and left.FNAME = right.FNAME,1000),local)( Conf >= LowerMatchThreshold );
// Join mj20 which has blocking specificity of 28
dn20 := t16(CITY_NAME NOT IN Specificities(ih).CITY_NAME_null_set);
mj20 := join( dn20, dn20, left.DID > right.DID and left.LNAME = right.LNAME and left.CITY_NAME = right.CITY_NAME,match_join(left,right,20),atmost(left.LNAME = right.LNAME and left.CITY_NAME = right.CITY_NAME,1000),local)( Conf >= LowerMatchThreshold );
// Join mj21 which has blocking specificity of 28
dn21 := t16(LOCALE NOT IN Specificities(ih).LOCALE_null_set);
mj21 := join( dn21, dn21, left.DID > right.DID and left.LNAME = right.LNAME and left.LOCALE = right.LOCALE,match_join(left,right,21),atmost(left.LNAME = right.LNAME and left.LOCALE = right.LOCALE,1000),local)( Conf >= LowerMatchThreshold );
mjs1 :=  mj9+ mj10+ mj11+ mj12+ mj13+ mj14+ mj15+ mj16+ mj17+ mj18+ mj19+ mj20+ mj21 : persist('temp::DID::mj1');
t22 := distribute( h(PRIM_RANGE NOT IN Specificities(ih).PRIM_RANGE_null_set),hash(PRIM_RANGE) ); // Save moving for each subsequent step
// Join mj22 which has blocking specificity of 28
dn22 := t22(SEC_RANGE NOT IN Specificities(ih).SEC_RANGE_null_set);
mj22 := join( dn22, dn22, left.DID > right.DID and left.PRIM_RANGE = right.PRIM_RANGE and left.SEC_RANGE = right.SEC_RANGE,match_join(left,right,22),atmost(left.PRIM_RANGE = right.PRIM_RANGE and left.SEC_RANGE = right.SEC_RANGE,1000),local)( Conf >= LowerMatchThreshold );
// Join mj23 which has blocking specificity of 27
dn23 := t22(PRIM_NAME NOT IN Specificities(ih).PRIM_NAME_null_set);
mj23 := join( dn23, dn23, left.DID > right.DID and left.PRIM_RANGE = right.PRIM_RANGE and left.PRIM_NAME = right.PRIM_NAME,match_join(left,right,23),atmost(left.PRIM_RANGE = right.PRIM_RANGE and left.PRIM_NAME = right.PRIM_NAME,1000),local)( Conf >= LowerMatchThreshold );
// Join mj24 which has blocking specificity of 27
dn24 := t22(FNAME NOT IN Specificities(ih).FNAME_null_set);
mj24 := join( dn24, dn24, left.DID > right.DID and left.PRIM_RANGE = right.PRIM_RANGE and left.FNAME = right.FNAME,match_join(left,right,24),atmost(left.PRIM_RANGE = right.PRIM_RANGE and left.FNAME = right.FNAME,1000),local)( Conf >= LowerMatchThreshold );
// Join mj25 which has blocking specificity of 27
dn25 := t22(CITY_NAME NOT IN Specificities(ih).CITY_NAME_null_set);
mj25 := join( dn25, dn25, left.DID > right.DID and left.PRIM_RANGE = right.PRIM_RANGE and left.CITY_NAME = right.CITY_NAME,match_join(left,right,25),atmost(left.PRIM_RANGE = right.PRIM_RANGE and left.CITY_NAME = right.CITY_NAME,1000),local)( Conf >= LowerMatchThreshold );
// Join mj26 which has blocking specificity of 27
dn26 := t22(LOCALE NOT IN Specificities(ih).LOCALE_null_set);
mj26 := join( dn26, dn26, left.DID > right.DID and left.PRIM_RANGE = right.PRIM_RANGE and left.LOCALE = right.LOCALE,match_join(left,right,26),atmost(left.PRIM_RANGE = right.PRIM_RANGE and left.LOCALE = right.LOCALE,1000),local)( Conf >= LowerMatchThreshold );
t27 := distribute( h(SEC_RANGE NOT IN Specificities(ih).SEC_RANGE_null_set),hash(SEC_RANGE) ); // Save moving for each subsequent step
// Join mj27 which has blocking specificity of 27
dn27 := t27(PRIM_NAME NOT IN Specificities(ih).PRIM_NAME_null_set);
mj27 := join( dn27, dn27, left.DID > right.DID and left.SEC_RANGE = right.SEC_RANGE and left.PRIM_NAME = right.PRIM_NAME,match_join(left,right,27),atmost(left.SEC_RANGE = right.SEC_RANGE and left.PRIM_NAME = right.PRIM_NAME,1000),local)( Conf >= LowerMatchThreshold );
// Join mj28 which has blocking specificity of 27
dn28 := t27(FNAME NOT IN Specificities(ih).FNAME_null_set);
mj28 := join( dn28, dn28, left.DID > right.DID and left.SEC_RANGE = right.SEC_RANGE and left.FNAME = right.FNAME,match_join(left,right,28),atmost(left.SEC_RANGE = right.SEC_RANGE and left.FNAME = right.FNAME,1000),local)( Conf >= LowerMatchThreshold );
// Join mj29 which has blocking specificity of 27
dn29 := t27(CITY_NAME NOT IN Specificities(ih).CITY_NAME_null_set);
mj29 := join( dn29, dn29, left.DID > right.DID and left.SEC_RANGE = right.SEC_RANGE and left.CITY_NAME = right.CITY_NAME,match_join(left,right,29),atmost(left.SEC_RANGE = right.SEC_RANGE and left.CITY_NAME = right.CITY_NAME,1000),local)( Conf >= LowerMatchThreshold );
// Join mj30 which has blocking specificity of 27
dn30 := t27(LOCALE NOT IN Specificities(ih).LOCALE_null_set);
mj30 := join( dn30, dn30, left.DID > right.DID and left.SEC_RANGE = right.SEC_RANGE and left.LOCALE = right.LOCALE,match_join(left,right,30),atmost(left.SEC_RANGE = right.SEC_RANGE and left.LOCALE = right.LOCALE,1000),local)( Conf >= LowerMatchThreshold );
mjs2 :=  mj22+ mj23+ mj24+ mj25+ mj26+ mj27+ mj28+ mj29+ mj30 : persist('temp::DID::mj2');
// Join mj31 which has blocking specificity of 39
dn31 := h(PRIM_NAME NOT IN Specificities(ih).PRIM_NAME_null_set and FNAME NOT IN Specificities(ih).FNAME_null_set and CITY_NAME NOT IN Specificities(ih).CITY_NAME_null_set);
mj31 := join( dn31, dn31, left.DID > right.DID and left.PRIM_NAME = right.PRIM_NAME and left.FNAME = right.FNAME and left.CITY_NAME = right.CITY_NAME,match_join(left,right,31),atmost(left.PRIM_NAME = right.PRIM_NAME and left.FNAME = right.FNAME and left.CITY_NAME = right.CITY_NAME,1000),skew(1))( Conf >= LowerMatchThreshold );
// Join mj32 which has blocking specificity of 39
dn32 := h(PRIM_NAME NOT IN Specificities(ih).PRIM_NAME_null_set and FNAME NOT IN Specificities(ih).FNAME_null_set and LOCALE NOT IN Specificities(ih).LOCALE_null_set);
mj32 := join( dn32, dn32, left.DID > right.DID and left.PRIM_NAME = right.PRIM_NAME and left.FNAME = right.FNAME and left.LOCALE = right.LOCALE,match_join(left,right,32),atmost(left.PRIM_NAME = right.PRIM_NAME and left.FNAME = right.FNAME and left.LOCALE = right.LOCALE,1000),skew(1))( Conf >= LowerMatchThreshold );
// Join mj33 which has blocking specificity of 36
dn33 := h(PRIM_NAME NOT IN Specificities(ih).PRIM_NAME_null_set and FNAME NOT IN Specificities(ih).FNAME_null_set and MNAME NOT IN Specificities(ih).MNAME_null_set);
mj33 := join( dn33, dn33, left.DID > right.DID and left.PRIM_NAME = right.PRIM_NAME and left.FNAME = right.FNAME and left.MNAME = right.MNAME,match_join(left,right,33),atmost(left.PRIM_NAME = right.PRIM_NAME and left.FNAME = right.FNAME and left.MNAME = right.MNAME,1000),skew(1))( Conf >= LowerMatchThreshold );
// Join mj34 which has blocking specificity of 36
dn34 := h(PRIM_NAME NOT IN Specificities(ih).PRIM_NAME_null_set and CITY_NAME NOT IN Specificities(ih).CITY_NAME_null_set and MNAME NOT IN Specificities(ih).MNAME_null_set);
mj34 := join( dn34, dn34, left.DID > right.DID and left.PRIM_NAME = right.PRIM_NAME and left.CITY_NAME = right.CITY_NAME and left.MNAME = right.MNAME,match_join(left,right,34),atmost(left.PRIM_NAME = right.PRIM_NAME and left.CITY_NAME = right.CITY_NAME and left.MNAME = right.MNAME,1000),skew(1))( Conf >= LowerMatchThreshold );
// Join mj35 which has blocking specificity of 36
dn35 := h(PRIM_NAME NOT IN Specificities(ih).PRIM_NAME_null_set and LOCALE NOT IN Specificities(ih).LOCALE_null_set and MNAME NOT IN Specificities(ih).MNAME_null_set);
mj35 := join( dn35, dn35, left.DID > right.DID and left.PRIM_NAME = right.PRIM_NAME and left.LOCALE = right.LOCALE and left.MNAME = right.MNAME,match_join(left,right,35),atmost(left.PRIM_NAME = right.PRIM_NAME and left.LOCALE = right.LOCALE and left.MNAME = right.MNAME,1000),skew(1))( Conf >= LowerMatchThreshold );
// Join mj36 which has blocking specificity of 36
dn36 := h(FNAME NOT IN Specificities(ih).FNAME_null_set and CITY_NAME NOT IN Specificities(ih).CITY_NAME_null_set and MNAME NOT IN Specificities(ih).MNAME_null_set);
mj36 := join( dn36, dn36, left.DID > right.DID and left.FNAME = right.FNAME and left.CITY_NAME = right.CITY_NAME and left.MNAME = right.MNAME,match_join(left,right,36),atmost(left.FNAME = right.FNAME and left.CITY_NAME = right.CITY_NAME and left.MNAME = right.MNAME,1000),skew(1))( Conf >= LowerMatchThreshold );
// Join mj37 which has blocking specificity of 36
dn37 := h(FNAME NOT IN Specificities(ih).FNAME_null_set and LOCALE NOT IN Specificities(ih).LOCALE_null_set and MNAME NOT IN Specificities(ih).MNAME_null_set);
mj37 := join( dn37, dn37, left.DID > right.DID and left.FNAME = right.FNAME and left.LOCALE = right.LOCALE and left.MNAME = right.MNAME,match_join(left,right,37),atmost(left.FNAME = right.FNAME and left.LOCALE = right.LOCALE and left.MNAME = right.MNAME,1000),skew(1))( Conf >= LowerMatchThreshold );
all_mjs :=  mjs0+ mjs1+ mjs2 + mj31+ mj32+ mj33+ mj34+ mj35+ mj36+ mj37;
export All_Matches := all_mjs;
ngadl.mac_avoid_transitives(All_Matches,DID1,DID2,Conf,Rule,o);
export PossibleMatches := o : persist('temp::DID_HEADER_mt');
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
export MatchSampleRecords := Debug(ih).AnnotateMatches(Full_Sample_Matches);
//Now actually produce the new file
ut.MAC_Patch_Id(ih,DID,Matches,DID1,DID2,o);
export Patched_Infile := o;
//Now perform the safety checks
export PrePatchIdCount := count( dedup( table(ih,{DID}), DID, all ) );
export PostPatchIdCount := count( dedup( table(Patched_Infile,{DID}), DID, all ) );
export MatchesPerformed := count( Matches );
export MatchesPropAssisted := count( Matches(Conf_Prop>0) );
export MatchesPropRequired := count( Matches(Conf-Conf_Prop<MatchThreshold) );
export PatchingError0 := PrePatchIdCount - PostPatchIdCount - MatchesPerformed; // Should be zero
export DidsNoRid0 := PostPatchIdCount - count(Patched_Infile(DID=RID)); // Should be zero
export DidsAboveRid0 := count(Patched_Infile(DID>RID)); // Should be zero
end;
