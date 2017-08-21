// Various routines to assist in debugging
import ngadl,ut;
export Debug(dataset(layout_HEADER) ih, Layout_Specificities.R s, MatchThreshold = 5) := module
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
shared h := match_candidates(ih).candidates;
shared LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
export Layout_Sample_Matches := record,maxlength(32000)
  integer2 Conf;
  integer2 Conf_Prop;
  integer2 DateOverlap := 0;
  unsigned6 DID1;
  unsigned6 DID2;
  unsigned6 RID1;
  unsigned6 RID2;
  typeof(h.VENDOR_ID) left_VENDOR_ID;
  integer2 VENDOR_ID_score;
  typeof(h.VENDOR_ID) right_VENDOR_ID;
  typeof(h.SSN) left_SSN;
  integer2 SSN_score;
  typeof(h.SSN) right_SSN;
  typeof(h.FULLNAME) left_FULLNAME;
  integer2 FULLNAME_score;
  typeof(h.FULLNAME) right_FULLNAME;
  typeof(h.PHONE) left_PHONE;
  integer2 PHONE_score;
  typeof(h.PHONE) right_PHONE;
  unsigned6 left_DOB;
  integer2 DOB_score;
  unsigned6 right_DOB;
  typeof(h.ADDR1) left_ADDR1;
  integer2 ADDR1_score;
  typeof(h.ADDR1) right_ADDR1;
  typeof(h.LNAME) left_LNAME;
  integer2 LNAME_score;
  typeof(h.LNAME) right_LNAME;
  typeof(h.PRIM_NAME) left_PRIM_NAME;
  integer2 PRIM_NAME_score;
  typeof(h.PRIM_NAME) right_PRIM_NAME;
  typeof(h.PRIM_RANGE) left_PRIM_RANGE;
  integer2 PRIM_RANGE_score;
  typeof(h.PRIM_RANGE) right_PRIM_RANGE;
  typeof(h.CITY_NAME) left_CITY_NAME;
  integer2 CITY_NAME_score;
  typeof(h.CITY_NAME) right_CITY_NAME;
  typeof(h.LOCALE) left_LOCALE;
  integer2 LOCALE_score;
  typeof(h.LOCALE) right_LOCALE;
  typeof(h.FNAME) left_FNAME;
  integer2 FNAME_score;
  typeof(h.FNAME) right_FNAME;
  typeof(h.SEC_RANGE) left_SEC_RANGE;
  integer2 SEC_RANGE_score;
  typeof(h.SEC_RANGE) right_SEC_RANGE;
  typeof(h.MNAME) left_MNAME;
  integer2 MNAME_score;
  typeof(h.MNAME) right_MNAME;
  typeof(h.ST) left_ST;
  integer2 ST_score;
  typeof(h.ST) right_ST;
  typeof(h.NAME_SUFFIX) left_NAME_SUFFIX;
  integer2 NAME_SUFFIX_score;
  typeof(h.NAME_SUFFIX) right_NAME_SUFFIX;
  typeof(h.GENDER) left_GENDER;
  integer2 GENDER_score;
  typeof(h.GENDER) right_GENDER;
  typeof(h.SRC) left_SRC;
  typeof(h.SRC) right_SRC;
end;
export layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,unsigned outside=0) := transform
  self.DID1 := le.DID;
  self.DID2 := ri.DID;
  self.RID1 := le.RID;
  self.RID2 := ri.RID;
  self.VENDOR_ID_score := MAP( le.VENDOR_ID  IN SET(s.nulls_VENDOR_ID,VENDOR_ID) or ri.VENDOR_ID  IN SET(s.nulls_VENDOR_ID,VENDOR_ID) => 0,
                        le.SRC <> ri.SRC => 0, // Only valid if the context variable is equal
                        le.VENDOR_ID = ri.VENDOR_ID  => le.VENDOR_ID_weight100,
                        Gordon.fail_scale(le.VENDOR_ID_weight100,s.VENDOR_ID_switch));
  self.left_VENDOR_ID := le.VENDOR_ID;
  self.right_VENDOR_ID := ri.VENDOR_ID;
  self.SSN_score := MAP( le.SSN  IN SET(s.nulls_SSN,SSN) or ri.SSN  IN SET(s.nulls_SSN,SSN) => 0,
                        le.SSN = ri.SSN  => le.SSN_weight100,
                        ut.stringsimilar(le.SSN,ri.SSN) <= 1 => Gordon.fuzzy_specificity(le.SSN_weight100,le.SSN_cnt, le.SSN_e1_cnt,ri.SSN_weight100,ri.SSN_cnt,ri.SSN_e1_cnt),
                        Gordon.fail_scale(le.SSN_weight100,s.SSN_switch));
  self.left_SSN := le.SSN;
  self.right_SSN := ri.SSN;
  integer2 FULLNAME_score_pre := MAP( le.FULLNAME  IN SET(s.nulls_FULLNAME,FULLNAME) or ri.FULLNAME  IN SET(s.nulls_FULLNAME,FULLNAME) => 0,
                        le.FULLNAME = ri.FULLNAME  => le.FULLNAME_weight100,
                        0);
  self.left_FULLNAME := le.FULLNAME;
  self.right_FULLNAME := ri.FULLNAME;
  self.PHONE_score := MAP( le.PHONE  IN SET(s.nulls_PHONE,PHONE) or ri.PHONE  IN SET(s.nulls_PHONE,PHONE) => 0,
                        le.PHONE = ri.PHONE  => le.PHONE_weight100,
                        Gordon.fail_scale(le.PHONE_weight100,s.PHONE_switch));
  self.left_PHONE := le.PHONE;
  self.right_PHONE := ri.PHONE;
  integer2 DOB_year       := MAP ( le.DOB_year in SET(s.nulls_DOB_year,DOB_year) or ri.DOB_year in SET(s.nulls_DOB_year,DOB_year) => 0,
                                  le.DOB_year = ri.DOB_year => le.DOB_year_weight100,
                                  Gordon.fail_scale(le.DOB_year_weight100,s.DOB_year_switch) );
  integer2 DOB_month       := MAP ( le.DOB_month in SET(s.nulls_DOB_month,DOB_month) or ri.DOB_month in SET(s.nulls_DOB_month,DOB_month) => 0,
                                  le.DOB_month = ri.DOB_month => le.DOB_month_weight100,
                                  Gordon.fail_scale(le.DOB_month_weight100,s.DOB_month_switch) );
  integer2 DOB_day       := MAP ( le.DOB_day in SET(s.nulls_DOB_day,DOB_day) or ri.DOB_day in SET(s.nulls_DOB_day,DOB_day) => 0,
                                  le.DOB_day = ri.DOB_day => le.DOB_day_weight100,
                                  Gordon.fail_scale(le.DOB_day_weight100,s.DOB_day_switch) );
  self.DOB_score := MAP( le.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND le.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND le.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) or ri.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND ri.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND ri.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) => 0,
                        DOB_year+DOB_month+DOB_day < 0 or DOB_year+DOB_month+DOB_day<>0 and DOB_year+DOB_month+DOB_day < 700 => SKIP,
                        DOB_year+DOB_month+DOB_day);
  self.left_DOB := (( le.DOB_year * 100 ) + le.DOB_month ) * 100 + le.DOB_day;
  self.right_DOB := (( ri.DOB_year * 100 ) + ri.DOB_month ) * 100 + ri.DOB_day;
  integer2 ADDR1_score_pre := MAP( le.ADDR1  IN SET(s.nulls_ADDR1,ADDR1) or ri.ADDR1  IN SET(s.nulls_ADDR1,ADDR1) => 0,
                        le.ADDR1 = ri.ADDR1  => le.ADDR1_weight100,
                        0);
  self.left_ADDR1 := le.ADDR1;
  self.right_ADDR1 := ri.ADDR1;
  self.LNAME_score := MAP( le.LNAME  IN SET(s.nulls_LNAME,LNAME) or ri.LNAME  IN SET(s.nulls_LNAME,LNAME) => 0,
                        FULLNAME_score_pre <> 0 => 0, // Parent has value so child keeps quiet
                        le.LNAME = ri.LNAME  => le.LNAME_weight100,
                        ut.stringsimilar(le.LNAME,ri.LNAME) <= 2 => Gordon.fuzzy_specificity(le.LNAME_weight100,le.LNAME_cnt, le.LNAME_e2_cnt,ri.LNAME_weight100,ri.LNAME_cnt,ri.LNAME_e2_cnt),
                        Gordon.fail_scale(le.LNAME_weight100,s.LNAME_switch));
  self.left_LNAME := le.LNAME;
  self.right_LNAME := ri.LNAME;
  self.PRIM_NAME_score := MAP( le.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) or ri.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) => 0,
                        ADDR1_score_pre <> 0 => 0, // Parent has value so child keeps quiet
                        le.PRIM_NAME = ri.PRIM_NAME  => le.PRIM_NAME_weight100,
                        Gordon.fail_scale(le.PRIM_NAME_weight100,s.PRIM_NAME_switch));
  self.left_PRIM_NAME := le.PRIM_NAME;
  self.right_PRIM_NAME := ri.PRIM_NAME;
  self.PRIM_RANGE_score := MAP( le.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) or ri.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) => 0,
                        ADDR1_score_pre <> 0 => 0, // Parent has value so child keeps quiet
                        le.PRIM_RANGE = ri.PRIM_RANGE  => le.PRIM_RANGE_weight100,
                        Gordon.fail_scale(le.PRIM_RANGE_weight100,s.PRIM_RANGE_switch));
  self.left_PRIM_RANGE := le.PRIM_RANGE;
  self.right_PRIM_RANGE := ri.PRIM_RANGE;
  integer2 LOCALE_score_pre := MAP( le.LOCALE  IN SET(s.nulls_LOCALE,LOCALE) or ri.LOCALE  IN SET(s.nulls_LOCALE,LOCALE) => 0,
                        le.LOCALE = ri.LOCALE  => le.LOCALE_weight100,
                        0);
  self.left_LOCALE := le.LOCALE;
  self.right_LOCALE := ri.LOCALE;
  self.FNAME_score := MAP( le.FNAME  IN SET(s.nulls_FNAME,FNAME) or ri.FNAME  IN SET(s.nulls_FNAME,FNAME) => 0,
                        FULLNAME_score_pre <> 0 => 0, // Parent has value so child keeps quiet
                        le.FNAME = ri.FNAME  => le.FNAME_weight100,
                        ut.stringsimilar(le.FNAME,ri.FNAME) <= 2 => Gordon.fuzzy_specificity(le.FNAME_weight100,le.FNAME_cnt, le.FNAME_e2_cnt,ri.FNAME_weight100,ri.FNAME_cnt,ri.FNAME_e2_cnt),
                        length(trim(le.FNAME))>0 and le.FNAME = ri.FNAME[length(trim(le.FNAME))] => le.FNAME_weight100, // An initial match - take initial specificity
                        length(trim(ri.FNAME))>0 and ri.FNAME = le.FNAME[length(trim(ri.FNAME))] => ri.FNAME_weight100,// An initial match - take initial specificity
                        Gordon.fail_scale(le.FNAME_weight100,s.FNAME_switch));
  self.left_FNAME := le.FNAME;
  self.right_FNAME := ri.FNAME;
  self.SEC_RANGE_score := MAP( le.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) or ri.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) => 0,
                        le.SEC_RANGE = ri.SEC_RANGE  => le.SEC_RANGE_weight100,
                        Gordon.fail_scale(le.SEC_RANGE_weight100,s.SEC_RANGE_switch));
  self.left_SEC_RANGE := le.SEC_RANGE;
  self.right_SEC_RANGE := ri.SEC_RANGE;
  self.MNAME_score := MAP( le.MNAME  IN SET(s.nulls_MNAME,MNAME) or ri.MNAME  IN SET(s.nulls_MNAME,MNAME) => 0,
                        FULLNAME_score_pre <> 0 => 0, // Parent has value so child keeps quiet
                        le.MNAME = ri.MNAME  => le.MNAME_weight100,
                        ut.stringsimilar(le.MNAME,ri.MNAME) <= 2 => Gordon.fuzzy_specificity(le.MNAME_weight100,le.MNAME_cnt, le.MNAME_e2_cnt,ri.MNAME_weight100,ri.MNAME_cnt,ri.MNAME_e2_cnt),
                        length(trim(le.MNAME))>0 and le.MNAME = ri.MNAME[length(trim(le.MNAME))] => le.MNAME_weight100, // An initial match - take initial specificity
                        length(trim(ri.MNAME))>0 and ri.MNAME = le.MNAME[length(trim(ri.MNAME))] => ri.MNAME_weight100,// An initial match - take initial specificity
                        Gordon.fail_scale(le.MNAME_weight100,s.MNAME_switch));
  self.left_MNAME := le.MNAME;
  self.right_MNAME := ri.MNAME;
  self.ST_score := MAP( le.ST  IN SET(s.nulls_ST,ST) or ri.ST  IN SET(s.nulls_ST,ST) => 0,
                        LOCALE_score_pre <> 0 => 0, // Parent has value so child keeps quiet
                        le.ST = ri.ST  => le.ST_weight100,
                        Gordon.fail_scale(le.ST_weight100,s.ST_switch));
  self.left_ST := le.ST;
  self.right_ST := ri.ST;
  self.NAME_SUFFIX_score := MAP( le.NAME_SUFFIX  IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX) or ri.NAME_SUFFIX  IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX) => 0,
                        FULLNAME_score_pre <> 0 => 0, // Parent has value so child keeps quiet
                        le.NAME_SUFFIX = ri.NAME_SUFFIX  => le.NAME_SUFFIX_weight100,
                        SKIP);
  self.left_NAME_SUFFIX := le.NAME_SUFFIX;
  self.right_NAME_SUFFIX := ri.NAME_SUFFIX;
  self.GENDER_score := MAP( le.GENDER  IN SET(s.nulls_GENDER,GENDER) or ri.GENDER  IN SET(s.nulls_GENDER,GENDER) => 0,
                        le.GENDER = ri.GENDER  => le.GENDER_weight100,
                        SKIP);
  self.left_GENDER := le.GENDER;
  self.right_GENDER := ri.GENDER;
  self.left_SRC := le.SRC;
  self.right_SRC := ri.SRC;
  self.FULLNAME_score := FULLNAME_score_pre;
  self.ADDR1_score := ADDR1_score_pre;
  self.CITY_NAME_score := MAP( le.CITY_NAME  IN SET(s.nulls_CITY_NAME,CITY_NAME) or ri.CITY_NAME  IN SET(s.nulls_CITY_NAME,CITY_NAME) => 0,
                        LOCALE_score_pre <> 0 => 0, // Parent has value so child keeps quiet
                        le.CITY_NAME = ri.CITY_NAME  => le.CITY_NAME_weight100,
                        Gordon.fail_scale(le.CITY_NAME_weight100,s.CITY_NAME_switch));
  self.left_CITY_NAME := le.CITY_NAME;
  self.right_CITY_NAME := ri.CITY_NAME;
  self.LOCALE_score := LOCALE_score_pre;
  self.Conf_Prop := (if(le.SSN_prop or ri.SSN_prop,self.SSN_score,0) + if(le.FULLNAME_prop or ri.FULLNAME_prop,self.FULLNAME_score,0) + if(le.PHONE_prop or ri.PHONE_prop,self.PHONE_score,0) + if(le.DOB_prop or ri.DOB_prop,self.DOB_score,0) + if(le.FNAME_prop or ri.FNAME_prop,self.FNAME_score,0) + if(le.MNAME_prop or ri.MNAME_prop,self.MNAME_score,0) + if(le.NAME_SUFFIX_prop or ri.NAME_SUFFIX_prop,self.NAME_SUFFIX_score,0)) / 100; // Score based on propogated fields
  self.Conf := (self.VENDOR_ID_score + self.SSN_score + self.FULLNAME_score + self.PHONE_score + self.DOB_score + self.ADDR1_score + self.LNAME_score + self.PRIM_NAME_score + self.PRIM_RANGE_score + self.CITY_NAME_score + self.LOCALE_score + self.FNAME_score + self.SEC_RANGE_score + self.MNAME_score + self.ST_score + self.NAME_SUFFIX_score + self.GENDER_score) / 100 + outside;
end;
export AnnotateMatchesFromData(dataset(match_candidates(ih).layout_candidates) in_data,dataset(match_candidates(ih).layout_matches)  im) := function
  j1 := join(in_data,im,left.DID = right.DID1,hash);
  match_candidates(ih).layout_candidates strim(j1 le) := transform
    self := le;
  end;
  r := join(j1,in_data,left.DID2 = right.DID,sample_match_join( project(left,strim(left)),right),hash);
  d := dedup( sort( r, DID1, DID2, -Conf, local ), DID1, DID2, local ); // DID2 distributed by join
  return d;
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
  unsigned6 DID;
  dataset(Layout_FieldValueList) VENDOR_ID_Values;
  dataset(Layout_FieldValueList) SSN_Values;
  dataset(Layout_FieldValueList) FULLNAME_Values;
  dataset(Layout_FieldValueList) PHONE_Values;
  dataset(Layout_FieldValueList) DOB_Values;
  dataset(Layout_FieldValueList) ADDR1_Values;
  dataset(Layout_FieldValueList) LOCALE_Values;
  dataset(Layout_FieldValueList) SEC_RANGE_Values;
  dataset(Layout_FieldValueList) GENDER_Values;
  dataset(Layout_FieldValueList) SRC_Values;
end;
export RolledEntities(dataset(match_candidates(ih).layout_candidates) in_data) := function
Layout_RolledEntity into(in_data le) := transform
  self.DID := le.DID;
  self.VENDOR_ID_Values := IF ( le.VENDOR_ID IN SET(s.nulls_VENDOR_ID,VENDOR_ID),dataset([],Layout_FieldValueList),dataset([{trim((string)le.VENDOR_ID)}],Layout_FieldValueList));
  self.SSN_Values := IF ( le.SSN IN SET(s.nulls_SSN,SSN),dataset([],Layout_FieldValueList),dataset([{trim((string)le.SSN)}],Layout_FieldValueList));
  self.FULLNAME_Values := IF ( le.FNAME IN SET(s.nulls_FNAME,FNAME) AND le.MNAME IN SET(s.nulls_MNAME,MNAME) AND le.LNAME IN SET(s.nulls_LNAME,LNAME) AND le.NAME_SUFFIX IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX),dataset([],Layout_FieldValueList),dataset([{trim((string)le.FNAME) + ' ' + trim((string)le.MNAME) + ' ' + trim((string)le.LNAME) + ' ' + trim((string)le.NAME_SUFFIX)}],Layout_FieldValueList));
  self.PHONE_Values := IF ( le.PHONE IN SET(s.nulls_PHONE,PHONE),dataset([],Layout_FieldValueList),dataset([{trim((string)le.PHONE)}],Layout_FieldValueList));
  self.DOB_Values := IF ( le.DOB_year IN SET(s.nulls_DOB_year,DOB_year) and le.DOB_month IN SET(s.nulls_DOB_month,DOB_month) and le.DOB_day IN SET(s.nulls_DOB_day,DOB_day),dataset([],Layout_FieldValueList),dataset([{trim((string)le.DOB_month)+'/'+trim((string)le.DOB_day)+'/'+trim((string)le.DOB_year)}],Layout_FieldValueList));
  self.ADDR1_Values := IF ( le.PRIM_RANGE IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) AND le.PRIM_NAME IN SET(s.nulls_PRIM_NAME,PRIM_NAME),dataset([],Layout_FieldValueList),dataset([{trim((string)le.PRIM_RANGE) + ' ' + trim((string)le.PRIM_NAME)}],Layout_FieldValueList));
  self.LOCALE_Values := IF ( le.CITY_NAME IN SET(s.nulls_CITY_NAME,CITY_NAME) AND le.ST IN SET(s.nulls_ST,ST),dataset([],Layout_FieldValueList),dataset([{trim((string)le.CITY_NAME) + ' ' + trim((string)le.ST)}],Layout_FieldValueList));
  self.SEC_RANGE_Values := IF ( le.SEC_RANGE IN SET(s.nulls_SEC_RANGE,SEC_RANGE),dataset([],Layout_FieldValueList),dataset([{trim((string)le.SEC_RANGE)}],Layout_FieldValueList));
  self.GENDER_Values := IF ( le.GENDER IN SET(s.nulls_GENDER,GENDER),dataset([],Layout_FieldValueList),dataset([{trim((string)le.GENDER)}],Layout_FieldValueList));
  self.SRC_Values := dataset([{trim((string)le.SRC)}],Layout_FieldValueList);
end;
AsFieldValues := project(in_data,into(left));
Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := transform
  self.DID := le.DID;
  self.VENDOR_ID_values := if ( count(le.VENDOR_ID_values)>=100 or exists(le.VENDOR_ID_values(Val=ri.VENDOR_ID_values[1].Val)), le.VENDOR_ID_values, le.VENDOR_ID_values+ri.VENDOR_ID_values);
  self.SSN_values := if ( count(le.SSN_values)>=100 or exists(le.SSN_values(Val=ri.SSN_values[1].Val)), le.SSN_values, le.SSN_values+ri.SSN_values);
  self.FULLNAME_values := if ( count(le.FULLNAME_values)>=100 or exists(le.FULLNAME_values(Val=ri.FULLNAME_values[1].Val)), le.FULLNAME_values, le.FULLNAME_values+ri.FULLNAME_values);
  self.PHONE_values := if ( count(le.PHONE_values)>=100 or exists(le.PHONE_values(Val=ri.PHONE_values[1].Val)), le.PHONE_values, le.PHONE_values+ri.PHONE_values);
  self.DOB_values := if ( count(le.DOB_values)>=100 or exists(le.DOB_values(Val=ri.DOB_values[1].Val)), le.DOB_values, le.DOB_values+ri.DOB_values);
  self.ADDR1_values := if ( count(le.ADDR1_values)>=100 or exists(le.ADDR1_values(Val=ri.ADDR1_values[1].Val)), le.ADDR1_values, le.ADDR1_values+ri.ADDR1_values);
  self.LOCALE_values := if ( count(le.LOCALE_values)>=100 or exists(le.LOCALE_values(Val=ri.LOCALE_values[1].Val)), le.LOCALE_values, le.LOCALE_values+ri.LOCALE_values);
  self.SEC_RANGE_values := if ( count(le.SEC_RANGE_values)>=100 or exists(le.SEC_RANGE_values(Val=ri.SEC_RANGE_values[1].Val)), le.SEC_RANGE_values, le.SEC_RANGE_values+ri.SEC_RANGE_values);
  self.GENDER_values := if ( count(le.GENDER_values)>=100 or exists(le.GENDER_values(Val=ri.GENDER_values[1].Val)), le.GENDER_values, le.GENDER_values+ri.GENDER_values);
  self.SRC_values := if ( count(le.SRC_values)>=100 or exists(le.SRC_values(Val=ri.SRC_values[1].Val)), le.SRC_values, le.SRC_values+ri.SRC_values);
end;
  return rollup( sort( distribute( AsFieldValues, DID ), DID, local ), left.DID = right.DID, RollValues(left,right),local);
end;
end;
