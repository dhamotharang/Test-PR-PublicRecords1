// Various routines to assist in debugging
import ngadl,ut;
export Debug(dataset(layout_HEADER) ih) := module
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
shared h := match_candidates(ih).candidates;
shared MatchThreshold := 40;
shared LowerMatchThreshold := 37; // Keep extra 'borderlines' for debug purposes
shared s := Specificities(ih).Specificities[1];
export Layout_Sample_Matches := record
  integer2 Conf;
  integer2 Conf_Prop;
  unsigned6 DID1;
  unsigned6 DID2;
  typeof(h.SSN) left_SSN;
  integer2 SSN_score;
  typeof(h.SSN) right_SSN;
  typeof(h.VENDOR_ID) left_VENDOR_ID;
  integer2 VENDOR_ID_score;
  typeof(h.VENDOR_ID) right_VENDOR_ID;
  typeof(h.PHONE) left_PHONE;
  integer2 PHONE_score;
  typeof(h.PHONE) right_PHONE;
  typeof(h.FULLNAME) left_FULLNAME;
  integer2 FULLNAME_score;
  typeof(h.FULLNAME) right_FULLNAME;
  unsigned6 left_DOB;
  integer2 DOB_score;
  unsigned6 right_DOB;
  typeof(h.LNAME) left_LNAME;
  integer2 LNAME_score;
  typeof(h.LNAME) right_LNAME;
  typeof(h.PRIM_RANGE) left_PRIM_RANGE;
  integer2 PRIM_RANGE_score;
  typeof(h.PRIM_RANGE) right_PRIM_RANGE;
  typeof(h.SEC_RANGE) left_SEC_RANGE;
  integer2 SEC_RANGE_score;
  typeof(h.SEC_RANGE) right_SEC_RANGE;
  typeof(h.PRIM_NAME) left_PRIM_NAME;
  integer2 PRIM_NAME_score;
  typeof(h.PRIM_NAME) right_PRIM_NAME;
  typeof(h.FNAME) left_FNAME;
  integer2 FNAME_score;
  typeof(h.FNAME) right_FNAME;
  typeof(h.CITY_NAME) left_CITY_NAME;
  integer2 CITY_NAME_score;
  typeof(h.CITY_NAME) right_CITY_NAME;
  typeof(h.LOCALE) left_LOCALE;
  integer2 LOCALE_score;
  typeof(h.LOCALE) right_LOCALE;
  typeof(h.MNAME) left_MNAME;
  integer2 MNAME_score;
  typeof(h.MNAME) right_MNAME;
  typeof(h.ST) left_ST;
  integer2 ST_score;
  typeof(h.ST) right_ST;
  typeof(h.SRC) left_SRC;
  typeof(h.SRC) right_SRC;
end;
export layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri) := transform
  self.DID1 := le.DID;
  self.DID2 := ri.DID;
  self.SSN_score := MAP( le.SSN  IN Specificities(ih).SSN_null_set or ri.SSN  IN Specificities(ih).SSN_null_set => 0,
                        le.SSN = ri.SSN => le.SSN_weight100,
                        ut.stringsimilar(le.SSN,ri.SSN) <= 1 => ngadl.fuzzy_specificity(le.SSN_weight100,le.SSN_cnt, le.SSN_e1_cnt,ri.SSN_weight100,ri.SSN_cnt,ri.SSN_e1_cnt),
                        ngadl.fail_scale(le.SSN_weight100,s.SSN_switch));
  self.left_SSN := le.SSN;
  self.right_SSN := ri.SSN;
  self.VENDOR_ID_score := MAP( le.VENDOR_ID  IN Specificities(ih).VENDOR_ID_null_set or ri.VENDOR_ID  IN Specificities(ih).VENDOR_ID_null_set => 0,
                        le.SRC <> ri.SRC => 0, // Only valid if the context variable is equal
                        le.VENDOR_ID = ri.VENDOR_ID => le.VENDOR_ID_weight100,
                        ngadl.fail_scale(le.VENDOR_ID_weight100,s.VENDOR_ID_switch));
  self.left_VENDOR_ID := le.VENDOR_ID;
  self.right_VENDOR_ID := ri.VENDOR_ID;
  self.PHONE_score := MAP( le.PHONE  IN Specificities(ih).PHONE_null_set or ri.PHONE  IN Specificities(ih).PHONE_null_set => 0,
                        le.PHONE = ri.PHONE => le.PHONE_weight100,
                        ngadl.fail_scale(le.PHONE_weight100,s.PHONE_switch));
  self.left_PHONE := le.PHONE;
  self.right_PHONE := ri.PHONE;
  self.FULLNAME_score := MAP( le.FULLNAME  IN Specificities(ih).FULLNAME_null_set or ri.FULLNAME  IN Specificities(ih).FULLNAME_null_set => 0,
                        le.FULLNAME = ri.FULLNAME => le.FULLNAME_weight100,
                        0);
  self.left_FULLNAME := le.FULLNAME;
  self.right_FULLNAME := ri.FULLNAME;
  integer2 DOB_year       := MAP ( le.DOB_year in Specificities(ih).DOB_year_null_set or ri.DOB_year in Specificities(ih).DOB_year_null_set => 0,
                                  le.DOB_year = ri.DOB_year => le.DOB_year_weight100,
                                  ngadl.fail_scale(le.DOB_year_weight100,s.DOB_year_switch) );
  integer2 DOB_month       := MAP ( le.DOB_month in Specificities(ih).DOB_month_null_set or ri.DOB_month in Specificities(ih).DOB_month_null_set => 0,
                                  le.DOB_month = ri.DOB_month => le.DOB_month_weight100,
                                  ngadl.fail_scale(le.DOB_month_weight100,s.DOB_month_switch) );
  integer2 DOB_day       := MAP ( le.DOB_day in Specificities(ih).DOB_day_null_set or ri.DOB_day in Specificities(ih).DOB_day_null_set => 0,
                                  le.DOB_day = ri.DOB_day => le.DOB_day_weight100,
                                  ngadl.fail_scale(le.DOB_day_weight100,s.DOB_day_switch) );
  self.DOB_score := MAP( le.DOB_year  IN Specificities(ih).DOB_year_null_set AND le.DOB_month  IN Specificities(ih).DOB_month_null_set AND le.DOB_day  IN Specificities(ih).DOB_day_null_set or ri.DOB_year  IN Specificities(ih).DOB_year_null_set AND ri.DOB_month  IN Specificities(ih).DOB_month_null_set AND ri.DOB_day  IN Specificities(ih).DOB_day_null_set => 0,
                        DOB_year+DOB_month+DOB_day < 0 or DOB_year+DOB_month+DOB_day<>0 and DOB_year+DOB_month+DOB_day < 700 => SKIP,
                        DOB_year+DOB_month+DOB_day);
  self.left_DOB := (( le.DOB_year * 100 ) + le.DOB_month ) * 100 + le.DOB_day;
  self.right_DOB := (( ri.DOB_year * 100 ) + ri.DOB_month ) * 100 + ri.DOB_day;
  self.PRIM_RANGE_score := MAP( le.PRIM_RANGE  IN Specificities(ih).PRIM_RANGE_null_set or ri.PRIM_RANGE  IN Specificities(ih).PRIM_RANGE_null_set => 0,
                        le.PRIM_RANGE = ri.PRIM_RANGE => le.PRIM_RANGE_weight100,
                        ngadl.fail_scale(le.PRIM_RANGE_weight100,s.PRIM_RANGE_switch));
  self.left_PRIM_RANGE := le.PRIM_RANGE;
  self.right_PRIM_RANGE := ri.PRIM_RANGE;
  self.SEC_RANGE_score := MAP( le.SEC_RANGE  IN Specificities(ih).SEC_RANGE_null_set or ri.SEC_RANGE  IN Specificities(ih).SEC_RANGE_null_set => 0,
                        le.SEC_RANGE = ri.SEC_RANGE => le.SEC_RANGE_weight100,
                        ngadl.fail_scale(le.SEC_RANGE_weight100,s.SEC_RANGE_switch));
  self.left_SEC_RANGE := le.SEC_RANGE;
  self.right_SEC_RANGE := ri.SEC_RANGE;
  self.PRIM_NAME_score := MAP( le.PRIM_NAME  IN Specificities(ih).PRIM_NAME_null_set or ri.PRIM_NAME  IN Specificities(ih).PRIM_NAME_null_set => 0,
                        le.PRIM_NAME = ri.PRIM_NAME => le.PRIM_NAME_weight100,
                        ngadl.fail_scale(le.PRIM_NAME_weight100,s.PRIM_NAME_switch));
  self.left_PRIM_NAME := le.PRIM_NAME;
  self.right_PRIM_NAME := ri.PRIM_NAME;
  self.LOCALE_score := MAP( le.LOCALE  IN Specificities(ih).LOCALE_null_set or ri.LOCALE  IN Specificities(ih).LOCALE_null_set => 0,
                        le.LOCALE = ri.LOCALE => le.LOCALE_weight100,
                        0);
  self.left_LOCALE := le.LOCALE;
  self.right_LOCALE := ri.LOCALE;
  self.left_SRC := le.SRC;
  self.right_SRC := ri.SRC;
  self.LNAME_score := MAP( le.LNAME  IN Specificities(ih).LNAME_null_set or ri.LNAME  IN Specificities(ih).LNAME_null_set => 0,
                        self.FULLNAME_score <> 0 => 0, // Parent has value so child keeps quiet
                        le.LNAME = ri.LNAME => le.LNAME_weight100,
                        ut.stringsimilar(le.LNAME,ri.LNAME) <= 2 => ngadl.fuzzy_specificity(le.LNAME_weight100,le.LNAME_cnt, le.LNAME_e2_cnt,ri.LNAME_weight100,ri.LNAME_cnt,ri.LNAME_e2_cnt),
                        ngadl.fail_scale(le.LNAME_weight100,s.LNAME_switch));
  self.left_LNAME := le.LNAME;
  self.right_LNAME := ri.LNAME;
  self.FNAME_score := MAP( le.FNAME  IN Specificities(ih).FNAME_null_set or ri.FNAME  IN Specificities(ih).FNAME_null_set => SKIP,
                        self.FULLNAME_score <> 0 => 0, // Parent has value so child keeps quiet
                        le.FNAME = ri.FNAME => le.FNAME_weight100,
                        ut.stringsimilar(le.FNAME,ri.FNAME) <= 2 => ngadl.fuzzy_specificity(le.FNAME_weight100,le.FNAME_cnt, le.FNAME_e2_cnt,ri.FNAME_weight100,ri.FNAME_cnt,ri.FNAME_e2_cnt),
                        length(trim(le.FNAME))>0 and le.FNAME = ri.FNAME[length(trim(le.FNAME))] => le.FNAME_weight100, // An initial match - take initial specificity
                        length(trim(ri.FNAME))>0 and ri.FNAME = le.FNAME[length(trim(ri.FNAME))] => ri.FNAME_weight100,// An initial match - take initial specificity
                        SKIP);
  self.left_FNAME := le.FNAME;
  self.right_FNAME := ri.FNAME;
  self.CITY_NAME_score := MAP( le.CITY_NAME  IN Specificities(ih).CITY_NAME_null_set or ri.CITY_NAME  IN Specificities(ih).CITY_NAME_null_set => 0,
                        self.LOCALE_score <> 0 => 0, // Parent has value so child keeps quiet
                        le.CITY_NAME = ri.CITY_NAME => le.CITY_NAME_weight100,
                        ngadl.fail_scale(le.CITY_NAME_weight100,s.CITY_NAME_switch));
  self.left_CITY_NAME := le.CITY_NAME;
  self.right_CITY_NAME := ri.CITY_NAME;
  self.MNAME_score := MAP( le.MNAME  IN Specificities(ih).MNAME_null_set or ri.MNAME  IN Specificities(ih).MNAME_null_set => 0,
                        self.FULLNAME_score <> 0 => 0, // Parent has value so child keeps quiet
                        le.MNAME = ri.MNAME => le.MNAME_weight100,
                        ut.stringsimilar(le.MNAME,ri.MNAME) <= 2 => ngadl.fuzzy_specificity(le.MNAME_weight100,le.MNAME_cnt, le.MNAME_e2_cnt,ri.MNAME_weight100,ri.MNAME_cnt,ri.MNAME_e2_cnt),
                        length(trim(le.MNAME))>0 and le.MNAME = ri.MNAME[length(trim(le.MNAME))] => le.MNAME_weight100, // An initial match - take initial specificity
                        length(trim(ri.MNAME))>0 and ri.MNAME = le.MNAME[length(trim(ri.MNAME))] => ri.MNAME_weight100,// An initial match - take initial specificity
                        ngadl.fail_scale(le.MNAME_weight100,s.MNAME_switch));
  self.left_MNAME := le.MNAME;
  self.right_MNAME := ri.MNAME;
  self.ST_score := MAP( le.ST  IN Specificities(ih).ST_null_set or ri.ST  IN Specificities(ih).ST_null_set => 0,
                        self.LOCALE_score <> 0 => 0, // Parent has value so child keeps quiet
                        le.ST = ri.ST => le.ST_weight100,
                        ngadl.fail_scale(le.ST_weight100,s.ST_switch));
  self.left_ST := le.ST;
  self.right_ST := ri.ST;
  self.Conf_Prop := (if(le.SSN_prop or ri.SSN_prop,self.SSN_score,0) + if(le.PHONE_prop or ri.PHONE_prop,self.PHONE_score,0) + if(le.FULLNAME_prop or ri.FULLNAME_prop,self.FULLNAME_score,0) + if(le.DOB_prop or ri.DOB_prop,self.DOB_score,0) + if(le.FNAME_prop or ri.FNAME_prop,self.FNAME_score,0) + if(le.MNAME_prop or ri.MNAME_prop,self.MNAME_score,0)) / 100; // Score based on propogated fields
  self.Conf := (self.SSN_score + self.VENDOR_ID_score + self.PHONE_score + self.FULLNAME_score + self.DOB_score + self.LNAME_score + self.PRIM_RANGE_score + self.SEC_RANGE_score + self.PRIM_NAME_score + self.FNAME_score + self.CITY_NAME_score + self.LOCALE_score + self.MNAME_score + self.ST_score) / 100;
end;
export AnnotateMatchesFromData(dataset(match_candidates(ih).layout_candidates) in_data,dataset(match_candidates(ih).layout_matches)  im) := function
j1 := join(in_data,im,left.DID = right.DID1,hash);
match_candidates(ih).layout_candidates strim(j1 le) := transform
    self := le;
  end;
  r := join(j1,in_data,left.DID2 = right.DID,sample_match_join( project(left,strim(left)),right),hash);
  return dedup( sort( r, DID1, DID2, -Conf, local ), DID1, DID2, local ); // DID2 distributed by join
end;
export AnnotateMatches(dataset(match_candidates(ih).layout_matches)  im) := function
  return AnnotateMatchesFromData(h,im);
end;
end;
