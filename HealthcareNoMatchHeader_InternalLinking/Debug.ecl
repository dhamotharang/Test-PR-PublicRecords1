// Various routines to assist in debugging
 
IMPORT SALT311,std;
/*HACK-O-MATIC*/EXPORT Debug(STRING pSrc, STRING pVersion =  (STRING)STD.Date.Today(), DATASET(layout_HEADER) ih, Layout_Specificities.R s, MatchThreshold = Config.MatchThreshold) := MODULE
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
SHARED h := /*HACK-O-MATIC*/match_candidates(pSrc,pVersion,ih).candidates;
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
 
EXPORT Layout_Sample_Matches := RECORD(/*HACK-O-MATIC*/match_candidates(pSrc,pVersion,ih).Layout_Matches)
  TYPEOF(h.LEXID) left_LEXID;
  INTEGER1 LEXID_match_code;
  INTEGER2 LEXID_score;
  INTEGER2 LEXID_score_prop;
  TYPEOF(h.LEXID) right_LEXID;
  TYPEOF(h.MAINNAME) left_MAINNAME;
  INTEGER1 MAINNAME_match_code;
  INTEGER2 MAINNAME_score;
  INTEGER2 MAINNAME_score_prop;
  TYPEOF(h.MAINNAME) right_MAINNAME;
  TYPEOF(h.FULLNAME) left_FULLNAME;
  INTEGER1 FULLNAME_match_code;
  INTEGER2 FULLNAME_score;
  INTEGER2 FULLNAME_score_prop;
  TYPEOF(h.FULLNAME) right_FULLNAME;
  TYPEOF(h.ADDR1) left_ADDR1;
  INTEGER1 ADDR1_match_code;
  INTEGER2 ADDR1_score;
  TYPEOF(h.ADDR1) right_ADDR1;
  TYPEOF(h.ADDRESS) left_ADDRESS;
  INTEGER1 ADDRESS_match_code;
  INTEGER2 ADDRESS_score;
  TYPEOF(h.ADDRESS) right_ADDRESS;
  TYPEOF(h.MNAME) left_MNAME;
  INTEGER1 MNAME_match_code;
  INTEGER2 MNAME_score;
  INTEGER2 MNAME_score_prop;
  TYPEOF(h.MNAME) right_MNAME;
  TYPEOF(h.PRIM_RANGE) left_PRIM_RANGE;
  INTEGER1 PRIM_RANGE_match_code;
  INTEGER2 PRIM_RANGE_score;
  TYPEOF(h.PRIM_RANGE) right_PRIM_RANGE;
  TYPEOF(h.SUFFIX) left_SUFFIX;
  INTEGER1 SUFFIX_match_code;
  INTEGER2 SUFFIX_score;
  INTEGER2 SUFFIX_score_prop;
  TYPEOF(h.SUFFIX) right_SUFFIX;
  TYPEOF(h.LNAME) left_LNAME;
  INTEGER1 LNAME_match_code;
  INTEGER2 LNAME_score;
  INTEGER2 LNAME_score_prop;
  TYPEOF(h.LNAME) right_LNAME;
  TYPEOF(h.PRIM_NAME) left_PRIM_NAME;
  INTEGER1 PRIM_NAME_match_code;
  INTEGER2 PRIM_NAME_score;
  TYPEOF(h.PRIM_NAME) right_PRIM_NAME;
  TYPEOF(h.FNAME) left_FNAME;
  INTEGER1 FNAME_match_code;
  INTEGER2 FNAME_score;
  INTEGER2 FNAME_score_prop;
  BOOLEAN FNAME_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.FNAME) right_FNAME;
  TYPEOF(h.SEC_RANGE) left_SEC_RANGE;
  INTEGER1 SEC_RANGE_match_code;
  INTEGER2 SEC_RANGE_score;
  TYPEOF(h.SEC_RANGE) right_SEC_RANGE;
  TYPEOF(h.CITY_NAME) left_CITY_NAME;
  INTEGER1 CITY_NAME_match_code;
  INTEGER2 CITY_NAME_score;
  TYPEOF(h.CITY_NAME) right_CITY_NAME;
  TYPEOF(h.ZIP) left_ZIP;
  INTEGER1 ZIP_match_code;
  INTEGER2 ZIP_score;
  TYPEOF(h.ZIP) right_ZIP;
  TYPEOF(h.LOCALE) left_LOCALE;
  INTEGER1 LOCALE_match_code;
  INTEGER2 LOCALE_score;
  TYPEOF(h.LOCALE) right_LOCALE;
  TYPEOF(h.GENDER) left_GENDER;
  INTEGER1 GENDER_match_code;
  INTEGER2 GENDER_score;
  TYPEOF(h.GENDER) right_GENDER;
  TYPEOF(h.SRC) left_SRC;
  TYPEOF(h.SRC) right_SRC;
  TYPEOF(h.SSN) left_SSN;
  INTEGER1 SSN_match_code;
  INTEGER2 SSN_score;
  TYPEOF(h.SSN) right_SSN;
  unsigned6 left_DOB;
  INTEGER1 DOB_year_match_code;
  INTEGER1 DOB_month_match_code;
  INTEGER1 DOB_day_match_code;
  INTEGER1 DOB_match_code;
  INTEGER2 DOB_score;
  INTEGER2 DOB_score_prop;
  BOOLEAN DOB_skipped := FALSE; // True if FORCE blocks match
  unsigned6 right_DOB;
  TYPEOF(h.ST) left_ST;
  INTEGER1 ST_match_code;
  INTEGER2 ST_score;
  TYPEOF(h.ST) right_ST;
  TYPEOF(h.DT_FIRST_SEEN) left_DT_FIRST_SEEN;
  TYPEOF(h.DT_FIRST_SEEN) right_DT_FIRST_SEEN;
  TYPEOF(h.DT_LAST_SEEN) left_DT_LAST_SEEN;
  TYPEOF(h.DT_LAST_SEEN) right_DT_LAST_SEEN;
END;
EXPORT layout_sample_matches sample_match_join(/*HACK-O-MATIC*/match_candidates(pSrc,pVersion,ih).layout_candidates le,/*HACK-O-MATIC*/match_candidates(pSrc,pVersion,ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.nomatch_id1 := le.nomatch_id;
  SELF.nomatch_id2 := ri.nomatch_id;
  SELF.RID1 := le.RID;
  SELF.RID2 := ri.RID;
  SELF.DateOverlap := SALT311.fn_ComputeDateOverlap(((UNSIGNED)le.DT_FIRST_SEEN)*100,((UNSIGNED)le.DT_LAST_SEEN)*100,((UNSIGNED)ri.DT_FIRST_SEEN)*100,((UNSIGNED)ri.DT_LAST_SEEN)*100);
  SELF.left_LEXID := le.LEXID;
  SELF.right_LEXID := ri.LEXID;
  SELF.LEXID_match_code := MAP(
                        le.LEXID_isnull OR ri.LEXID_isnull => SALT311.MatchCode.OneSideNull,
                        /*HACK-O-MATIC*/match_methods(pSrc,pVersion,ih).match_LEXID(le.LEXID,ri.LEXID));
  SELF.LEXID_score := MAP(
                        le.LEXID_isnull OR ri.LEXID_isnull => 0,
                        le.LEXID = ri.LEXID  => le.LEXID_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.LEXID_weight100,ri.LEXID_weight100),s.LEXID_switch));
  REAL FULLNAME_score_scale := ( le.FULLNAME_weight100 + ri.FULLNAME_weight100 ) / (le.MAINNAME_weight100 + ri.MAINNAME_weight100 + le.SUFFIX_weight100 + ri.SUFFIX_weight100); // Scaling factor for this concept
  SELF.FULLNAME_match_code := MAP(
                        (le.FULLNAME_isnull OR (le.MAINNAME_isnull OR le.FNAME_isnull AND le.MNAME_isnull AND le.LNAME_isnull) AND le.SUFFIX_isnull) OR (ri.FULLNAME_isnull OR (ri.MAINNAME_isnull OR ri.FNAME_isnull AND ri.MNAME_isnull AND ri.LNAME_isnull) AND ri.SUFFIX_isnull) => SALT311.MatchCode.OneSideNull,
                        /*HACK-O-MATIC*/match_methods(pSrc,pVersion,ih).match_FULLNAME(le.FULLNAME,ri.FULLNAME,FALSE));
  INTEGER2 FULLNAME_score_pre := MAP( (le.FULLNAME_isnull OR (le.MAINNAME_isnull OR le.FNAME_isnull AND le.MNAME_isnull AND le.LNAME_isnull) AND le.SUFFIX_isnull) OR (ri.FULLNAME_isnull OR (ri.MAINNAME_isnull OR ri.FNAME_isnull AND ri.MNAME_isnull AND ri.LNAME_isnull) AND ri.SUFFIX_isnull) => 0,
                        le.FULLNAME = ri.FULLNAME  => le.FULLNAME_weight100,
                        0);
  SELF.left_FULLNAME := le.FULLNAME;
  SELF.right_FULLNAME := ri.FULLNAME;
  REAL ADDRESS_score_scale := ( le.ADDRESS_weight100 + ri.ADDRESS_weight100 ) / (le.ADDR1_weight100 + ri.ADDR1_weight100 + le.LOCALE_weight100 + ri.LOCALE_weight100); // Scaling factor for this concept
  SELF.ADDRESS_match_code := MAP(
                        (le.ADDRESS_isnull OR (le.ADDR1_isnull OR le.PRIM_RANGE_isnull AND le.SEC_RANGE_isnull AND le.PRIM_NAME_isnull) AND (le.LOCALE_isnull OR le.CITY_NAME_isnull AND le.ST_isnull AND le.ZIP_isnull)) OR (ri.ADDRESS_isnull OR (ri.ADDR1_isnull OR ri.PRIM_RANGE_isnull AND ri.SEC_RANGE_isnull AND ri.PRIM_NAME_isnull) AND (ri.LOCALE_isnull OR ri.CITY_NAME_isnull AND ri.ST_isnull AND ri.ZIP_isnull)) => SALT311.MatchCode.OneSideNull,
                        /*HACK-O-MATIC*/match_methods(pSrc,pVersion,ih).match_ADDRESS(le.ADDRESS,ri.ADDRESS,FALSE));
  INTEGER2 ADDRESS_score_pre := MAP( (le.ADDRESS_isnull OR (le.ADDR1_isnull OR le.PRIM_RANGE_isnull AND le.SEC_RANGE_isnull AND le.PRIM_NAME_isnull) AND (le.LOCALE_isnull OR le.CITY_NAME_isnull AND le.ST_isnull AND le.ZIP_isnull)) OR (ri.ADDRESS_isnull OR (ri.ADDR1_isnull OR ri.PRIM_RANGE_isnull AND ri.SEC_RANGE_isnull AND ri.PRIM_NAME_isnull) AND (ri.LOCALE_isnull OR ri.CITY_NAME_isnull AND ri.ST_isnull AND ri.ZIP_isnull)) => 0,
                        le.ADDRESS = ri.ADDRESS  => le.ADDRESS_weight100,
                        0);
  SELF.left_ADDRESS := le.ADDRESS;
  SELF.right_ADDRESS := ri.ADDRESS;
  SELF.left_SUFFIX := le.SUFFIX;
  SELF.right_SUFFIX := ri.SUFFIX;
  SELF.SUFFIX_match_code := MAP(
                        le.SUFFIX_isnull OR ri.SUFFIX_isnull => SALT311.MatchCode.OneSideNull,
                        FULLNAME_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        /*HACK-O-MATIC*/match_methods(pSrc,pVersion,ih).match_SUFFIX(le.SUFFIX,ri.SUFFIX));
  SELF.SUFFIX_score := MAP(
                        le.SUFFIX_isnull OR ri.SUFFIX_isnull => 0,
                        FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.SUFFIX = ri.SUFFIX  => le.SUFFIX_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.SUFFIX_weight100,ri.SUFFIX_weight100),s.SUFFIX_switch))*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
  REAL LOCALE_score_scale := ( le.LOCALE_weight100 + ri.LOCALE_weight100 ) / (le.CITY_NAME_weight100 + ri.CITY_NAME_weight100 + le.ST_weight100 + ri.ST_weight100 + le.ZIP_weight100 + ri.ZIP_weight100); // Scaling factor for this concept
  SELF.LOCALE_match_code := MAP(
                        (le.LOCALE_isnull OR le.CITY_NAME_isnull AND le.ST_isnull AND le.ZIP_isnull) OR (ri.LOCALE_isnull OR ri.CITY_NAME_isnull AND ri.ST_isnull AND ri.ZIP_isnull) => SALT311.MatchCode.OneSideNull,
                        ADDRESS_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        /*HACK-O-MATIC*/match_methods(pSrc,pVersion,ih).match_LOCALE(le.LOCALE,ri.LOCALE,FALSE));
  INTEGER2 LOCALE_score_pre := MAP( (le.LOCALE_isnull OR le.CITY_NAME_isnull AND le.ST_isnull AND le.ZIP_isnull) OR (ri.LOCALE_isnull OR ri.CITY_NAME_isnull AND ri.ST_isnull AND ri.ZIP_isnull) => 0,
                        ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.LOCALE = ri.LOCALE  => le.LOCALE_weight100,
                        0)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  SELF.left_LOCALE := le.LOCALE;
  SELF.right_LOCALE := ri.LOCALE;
  SELF.left_GENDER := le.GENDER;
  SELF.right_GENDER := ri.GENDER;
  SELF.GENDER_match_code := MAP(
                        le.GENDER_isnull OR ri.GENDER_isnull => SALT311.MatchCode.OneSideNull,
                        /*HACK-O-MATIC*/match_methods(pSrc,pVersion,ih).match_GENDER(le.GENDER,ri.GENDER));
  SELF.GENDER_score := MAP(
                        le.GENDER_isnull OR ri.GENDER_isnull => 0,
                        le.GENDER = ri.GENDER  => le.GENDER_weight100,
                        /*HACK-O-MATIC*/Config.Mismatch_Score_GENDER);

  SELF.left_SRC := le.SRC;
  SELF.right_SRC := ri.SRC;
  SELF.left_SSN := le.SSN;
  SELF.right_SSN := ri.SSN;
  SELF.SSN_match_code := MAP(
                        le.SSN_isnull OR ri.SSN_isnull => SALT311.MatchCode.OneSideNull,
                        /*HACK-O-MATIC*/match_methods(pSrc,pVersion,ih).match_SSN(le.SSN,ri.SSN, le.SSN_len, ri.SSN_len));
  SELF.SSN_score := MAP(
                        le.SSN_isnull OR ri.SSN_isnull => 0,
                        le.SSN = ri.SSN  => le.SSN_weight100,
                        /*HACK-O-MATIC*/Config.WithinEditN(le.SSN,le.SSN_len,ri.SSN,ri.SSN_len,1,0) AND ABS((INTEGER)le.SSN-(INTEGER)ri.SSN)>1 => SALT311.fn_fuzzy_specificity(le.SSN_weight100,le.SSN_cnt, le.SSN_e1_cnt,ri.SSN_weight100,ri.SSN_cnt,ri.SSN_e1_cnt) * 0.5, // hack to use edit1 scoring first if possible (50% penalty)
												/*HACK-O-MATIC*/Config.WithinEditN(le.SSN,le.SSN_len,ri.SSN,ri.SSN_len,2,0) AND ABS((INTEGER)le.SSN-(INTEGER)ri.SSN)>1 => 0, // for edit2, no mismatch penalty
                        SALT311.Fn_Fail_Scale(AVE(le.SSN_weight100,ri.SSN_weight100),s.SSN_switch));
  INTEGER2 DOB_year_score := MAP ( le.DOB_year_isnull or ri.DOB_year_isnull => 0,
                                  le.DOB_year = ri.DOB_year => le.DOB_year_weight100,
                                  SALT311.Fn_YearMatch(le.DOB_year,ri.DOB_year,12) => le.DOB_year_weight100-358, // assumes even year distribution - so 3x less specific
                                  SALT311.fn_fail_scale(AVE(le.DOB_year_weight100,ri.DOB_year_weight100),s.DOB_year_switch) );
  INTEGER2 DOB_month_score := MAP ( le.DOB_month_isnull or ri.DOB_month_isnull => 0,
                                  le.DOB_month = ri.DOB_month => le.DOB_month_weight100,
                                  le.DOB_month = ri.DOB_day AND le.DOB_day = ri.DOB_month => le.DOB_month_weight100-100, // Performing M-D switch
                                  le.DOB_Day <= 1 AND le.DOB_Month = 1 OR ri.DOB_Day <= 1 AND ri.DOB_Month = 1 => -200, // Month may be a soft 1 if day is ... 
                                  SALT311.fn_fail_scale(AVE(le.DOB_month_weight100,ri.DOB_month_weight100),s.DOB_month_switch) );
  INTEGER2 DOB_day_score := MAP ( le.DOB_day_isnull or ri.DOB_day_isnull => 0,
                                  le.DOB_day = ri.DOB_day => le.DOB_day_weight100,
                                  le.DOB_day = ri.DOB_month AND le.DOB_month = ri.DOB_day => le.DOB_day_weight100-100, // Performing M-D switch
                                  le.DOB_Day = 1 OR ri.DOB_Day = 1 => -200, // Treating as a 'soft' 1
                                  SALT311.fn_fail_scale(AVE(le.DOB_day_weight100,ri.DOB_day_weight100),s.DOB_day_switch) );
  INTEGER2 DOB_score_temp := (DOB_year_score+DOB_month_score+DOB_day_score);
  SELF.DOB_year_match_code := MAP(
                        le.DOB_year_isnull OR ri.DOB_year_isnull => SALT311.MatchCode.OneSideNull,
                        DOB_year_score+DOB_month_score+DOB_day_score < 0 OR DOB_year_score+DOB_month_score+DOB_day_score<>0 AND DOB_year_score+DOB_month_score+DOB_day_score < 300 => SALT311.MatchCode.ForcedNoMatch,
                        Config.DOB_UseGenerationForce AND DOB_year_score < 0 AND ABS(le.DOB_year-ri.DOB_year) > 13 => SALT311.MatchCode.ForcedNoMatch, // Do not allow full generation mis-match
                        /*HACK-O-MATIC*/match_methods(pSrc,pVersion,ih).match_DOB_year(le.DOB_year,ri.DOB_year));
  SELF.DOB_month_match_code := MAP(
                        le.DOB_month_isnull OR ri.DOB_month_isnull => SALT311.MatchCode.OneSideNull,
                        DOB_year_score+DOB_month_score+DOB_day_score < 0 OR DOB_year_score+DOB_month_score+DOB_day_score<>0 AND DOB_year_score+DOB_month_score+DOB_day_score < 300 => SALT311.MatchCode.ForcedNoMatch,
                        Config.DOB_UseGenerationForce AND DOB_year_score < 0 AND ABS(le.DOB_year-ri.DOB_year) > 13 => SALT311.MatchCode.ForcedNoMatch, // Do not allow full generation mis-match
                        /*HACK-O-MATIC*/match_methods(pSrc,pVersion,ih).match_DOB_month(le.DOB_month,ri.DOB_month,le.DOB_day,ri.DOB_day));
  SELF.DOB_day_match_code := MAP(
                        le.DOB_day_isnull or ri.DOB_day_isnull => SALT311.MatchCode.OneSideNull,
                        DOB_year_score+DOB_month_score+DOB_day_score < 0 OR DOB_year_score+DOB_month_score+DOB_day_score<>0 AND DOB_year_score+DOB_month_score+DOB_day_score < 300 => SALT311.MatchCode.ForcedNoMatch,
                        Config.DOB_UseGenerationForce AND DOB_year_score < 0 AND ABS(le.DOB_year-ri.DOB_year) > 13 => SALT311.MatchCode.ForcedNoMatch, // Do not allow full generation mis-match
                        /*HACK-O-MATIC*/match_methods(pSrc,pVersion,ih).match_DOB_day(le.DOB_month,ri.DOB_month,le.DOB_day,ri.DOB_day));
  SELF.DOB_match_code := MAP(
                        le.DOB_day_isnull AND le.DOB_month_isnull AND le.DOB_year_isnull OR ri.DOB_day_isnull AND ri.DOB_month_isnull AND ri.DOB_year_isnull => SALT311.MatchCode.OneSideNull,
                        DOB_year_score+DOB_month_score+DOB_day_score < 0 OR DOB_year_score+DOB_month_score+DOB_day_score<>0 AND DOB_year_score+DOB_month_score+DOB_day_score < 300 => SALT311.MatchCode.ForcedNoMatch,
                        Config.DOB_UseGenerationForce AND DOB_year_score < 0 AND ABS(le.DOB_year-ri.DOB_year) > 13 => SALT311.MatchCode.ForcedNoMatch, // Do not allow full generation mis-match
                        DOB_score_temp = DOB_year_score+DOB_month_score+DOB_day_score => SALT311.MatchCode.DateAggregate,
                        SALT311.MatchCode.NoMatch);
  SELF.DOB_score := MAP( le.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND le.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND le.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) or ri.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND ri.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND ri.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) => 0,
                        DOB_year_score+DOB_month_score+DOB_day_score < 0 or DOB_year_score+DOB_month_score+DOB_day_score<>0 and DOB_year_score+DOB_month_score+DOB_day_score < 300 => -9999,
                        Config.DOB_UseGenerationForce AND DOB_year_score < 0 AND ABS(le.DOB_year-ri.DOB_year) > 13 => -9999, // Do not allow full generation mis-match
                        DOB_score_temp);
 
  SELF.DOB_skipped := SELF.DOB_score = -9999;// Enforce FORCE parameter
  SELF.left_DOB := (( le.DOB_year * 100 ) + le.DOB_month ) * 100 + le.DOB_day;
  SELF.right_DOB := (( ri.DOB_year * 100 ) + ri.DOB_month ) * 100 + ri.DOB_day;
  SELF.left_ST := le.ST;
  SELF.right_ST := ri.ST;
  SELF.ST_match_code := MAP(
                        le.ST_isnull OR ri.ST_isnull => SALT311.MatchCode.OneSideNull,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        /*HACK-O-MATIC*/match_methods(pSrc,pVersion,ih).match_ST(le.ST,ri.ST));
  SELF.ST_score := MAP(
                        le.ST_isnull OR ri.ST_isnull => 0,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.ST = ri.ST  => le.ST_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.ST_weight100,ri.ST_weight100),s.ST_switch))*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  SELF.left_DT_FIRST_SEEN := le.DT_FIRST_SEEN;
  SELF.right_DT_FIRST_SEEN := ri.DT_FIRST_SEEN;
  SELF.left_DT_LAST_SEEN := le.DT_LAST_SEEN;
  SELF.right_DT_LAST_SEEN := ri.DT_LAST_SEEN;
  REAL MAINNAME_score_scale := ( le.MAINNAME_weight100 + ri.MAINNAME_weight100 ) / (le.FNAME_weight100 + ri.FNAME_weight100 + le.MNAME_weight100 + ri.MNAME_weight100 + le.LNAME_weight100 + ri.LNAME_weight100); // Scaling factor for this concept
  SELF.MAINNAME_match_code := MAP(
                        (le.MAINNAME_isnull OR le.FNAME_isnull AND le.MNAME_isnull AND le.LNAME_isnull) OR (ri.MAINNAME_isnull OR ri.FNAME_isnull AND ri.MNAME_isnull AND ri.LNAME_isnull) => SALT311.MatchCode.OneSideNull,
                        FULLNAME_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        /*HACK-O-MATIC*/match_methods(pSrc,pVersion,ih).match_MAINNAME(le.MAINNAME,ri.MAINNAME,(SALT311.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,true,Config.FNAME_Force,true,,IF( LENGTH(TRIM((SALT311.StrType)le.FNAME))<8, 1, 2),8,le.FNAME_len,le.FNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)le.MNAME,le.MNAME_MAINNAME_weight100,true,0,true,,IF( LENGTH(TRIM((SALT311.StrType)le.MNAME))<6, 1, 2),6,le.MNAME_len,le.MNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)le.LNAME,le.LNAME_MAINNAME_weight100,true,0,true,,IF( LENGTH(TRIM((SALT311.StrType)le.LNAME))<6, 1, 2),6,le.LNAME_len,le.LNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)ri.FNAME,ri.FNAME_MAINNAME_weight100,ri.FNAME_len,ri.FNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)ri.MNAME,ri.MNAME_MAINNAME_weight100,ri.MNAME_len,ri.MNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)ri.LNAME,ri.LNAME_MAINNAME_weight100,ri.LNAME_len,ri.LNAME_MAINNAME_fuzzy_weight100,FALSE));
  
/*HACK-O-MATIC*/MAINNAME_score_less_strict := MAP( (le.MAINNAME_isnull OR le.FNAME_isnull AND le.MNAME_isnull AND le.LNAME_isnull) OR (ri.MAINNAME_isnull OR ri.FNAME_isnull AND ri.MNAME_isnull AND ri.LNAME_isnull) => 0,
/*HACK-O-MATIC*/				FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
/*HACK-O-MATIC*/				le.MAINNAME = ri.MAINNAME  => le.MAINNAME_weight100,
/*HACK-O-MATIC*/				SALT311.fn_concept_wordbag_EditN.Match3((SALT311.StrType)ri.FNAME,ri.FNAME_MAINNAME_weight100,true,Config.FNAME_Force,false,IF( LENGTH(TRIM((SALT311.StrType)ri.FNAME))<6, 1, 2),6,ri.FNAME_len,ri.FNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)ri.MNAME,ri.MNAME_MAINNAME_weight100,true,0,false,IF( LENGTH(TRIM((SALT311.StrType)ri.MNAME))<6, 1, 2),6,ri.MNAME_len,ri.MNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)ri.LNAME,ri.LNAME_MAINNAME_weight100,true,0,false,IF( LENGTH(TRIM((SALT311.StrType)ri.LNAME))<6, 1, 2),6,ri.LNAME_len,ri.LNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,le.FNAME_len,le.FNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)le.MNAME,le.MNAME_MAINNAME_weight100,le.MNAME_len,le.MNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)le.LNAME,le.LNAME_MAINNAME_weight100,le.LNAME_len,le.LNAME_MAINNAME_fuzzy_weight100,Config.WithinEditN)*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale))*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
/*HACK-O-MATIC*/INTEGER2 MAINNAME_score_strict := MAP( (le.MAINNAME_isnull OR le.FNAME_isnull AND le.MNAME_isnull AND le.LNAME_isnull) OR (ri.MAINNAME_isnull OR ri.FNAME_isnull AND ri.MNAME_isnull AND ri.LNAME_isnull) => 0,
/*HACK-O-MATIC*/				FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
/*HACK-O-MATIC*/				le.MAINNAME = ri.MAINNAME  => le.MAINNAME_weight100,
/*HACK-O-MATIC*/				SALT311.fn_concept_wordbag_EditN.Match3((SALT311.StrType)ri.FNAME,ri.FNAME_MAINNAME_weight100,false,Config.FNAME_Force,false,0,0,ri.FNAME_len,ri.FNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)ri.MNAME,ri.MNAME_MAINNAME_weight100,false,0,false,0,0,ri.MNAME_len,ri.MNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)ri.LNAME,ri.LNAME_MAINNAME_weight100,false,0,false,0,0,ri.LNAME_len,ri.LNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,le.FNAME_len,le.FNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)le.MNAME,le.MNAME_MAINNAME_weight100,le.MNAME_len,le.MNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)le.LNAME,le.LNAME_MAINNAME_weight100,le.LNAME_len,le.LNAME_MAINNAME_fuzzy_weight100,Config.WithinEditN)*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale))*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);

/*HACK-O-MATIC*/INTEGER2 MAINNAME_score_pre_v1 := MAP( (le.MAINNAME_isnull OR le.FNAME_isnull AND le.MNAME_isnull AND le.LNAME_isnull) OR (ri.MAINNAME_isnull OR ri.FNAME_isnull AND ri.MNAME_isnull AND ri.LNAME_isnull) => 0,
                        FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.MAINNAME = ri.MAINNAME  => le.MAINNAME_weight100,
                        SALT311.fn_concept_wordbag_EditN.Match3((SALT311.StrType)ri.FNAME,ri.FNAME_MAINNAME_weight100,true,Config.FNAME_Force,true,IF( LENGTH(TRIM((SALT311.StrType)ri.FNAME))<8, 1, 2),8,ri.FNAME_len,ri.FNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)ri.MNAME,ri.MNAME_MAINNAME_weight100,true,0,true,IF( LENGTH(TRIM((SALT311.StrType)ri.MNAME))<6, 1, 2),6,ri.MNAME_len,ri.MNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)ri.LNAME,ri.LNAME_MAINNAME_weight100,true,0,true,IF( LENGTH(TRIM((SALT311.StrType)ri.LNAME))<6, 1, 2),6,ri.LNAME_len,ri.LNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,le.FNAME_len,le.FNAME_MAINNAME_fuzzy_weight100,/*HACK-O-MATIC*/(SALT311.StrType)le.MNAME,le.MNAME_MAINNAME_weight100,le.MNAME_len,le.MNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)le.LNAME,le.LNAME_MAINNAME_weight100,le.LNAME_len,le.LNAME_MAINNAME_fuzzy_weight100,HealthcareNoMatchHeader_InternalLinking.Config.WithinEditN)*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale))*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);

/*HACK-O-MATIC*/INTEGER2 MAINNAME_score_pre := if (((SELF.ssn_score > Config.SSN_Score_Min_MAINNAME OR SELF.dob_score > Config.DOB_Score_Min_MAINNAME) AND MAINNAME_score_less_strict > 0)
/*HACK-O-MATIC*/OR MAINNAME_score_strict > 0,
/*HACK-O-MATIC*/MAINNAME_score_pre_v1, 0);

  SELF.left_MAINNAME := le.MAINNAME;
  SELF.right_MAINNAME := ri.MAINNAME;
  REAL ADDR1_score_scale := ( le.ADDR1_weight100 + ri.ADDR1_weight100 ) / (le.PRIM_RANGE_weight100 + ri.PRIM_RANGE_weight100 + le.SEC_RANGE_weight100 + ri.SEC_RANGE_weight100 + le.PRIM_NAME_weight100 + ri.PRIM_NAME_weight100); // Scaling factor for this concept
  SELF.ADDR1_match_code := MAP(
                        (le.ADDR1_isnull OR le.PRIM_RANGE_isnull AND le.SEC_RANGE_isnull AND le.PRIM_NAME_isnull) OR (ri.ADDR1_isnull OR ri.PRIM_RANGE_isnull AND ri.SEC_RANGE_isnull AND ri.PRIM_NAME_isnull) => SALT311.MatchCode.OneSideNull,
                        ADDRESS_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        /*HACK-O-MATIC*/match_methods(pSrc,pVersion,ih).match_ADDR1(le.ADDR1,ri.ADDR1,FALSE));
  INTEGER2 ADDR1_score_pre := MAP( (le.ADDR1_isnull OR le.PRIM_RANGE_isnull AND le.SEC_RANGE_isnull AND le.PRIM_NAME_isnull) OR (ri.ADDR1_isnull OR ri.PRIM_RANGE_isnull AND ri.SEC_RANGE_isnull AND ri.PRIM_NAME_isnull) => 0,
                        ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.ADDR1 = ri.ADDR1  => le.ADDR1_weight100,
                        0)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  SELF.left_ADDR1 := le.ADDR1;
  SELF.right_ADDR1 := ri.ADDR1;
  SELF.left_MNAME := le.MNAME;
  SELF.right_MNAME := ri.MNAME;
  SELF.MNAME_match_code := MAP(
                        le.MNAME_isnull OR ri.MNAME_isnull => SALT311.MatchCode.OneSideNull,
                        MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        /*HACK-O-MATIC*/match_methods(pSrc,pVersion,ih).match_MNAME(le.MNAME,ri.MNAME, le.MNAME_len, ri.MNAME_len));
  SELF.MNAME_score := MAP(
                        le.MNAME_isnull OR ri.MNAME_isnull => 0,
                        MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.MNAME = ri.MNAME  => le.MNAME_weight100,
                        LENGTH(TRIM(le.MNAME))>0 and le.MNAME = ri.MNAME[1..LENGTH(TRIM(le.MNAME))] => le.MNAME_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.MNAME))>0 and ri.MNAME = le.MNAME[1..LENGTH(TRIM(ri.MNAME))] => ri.MNAME_weight100, // An initial match - take initial specificity
                        Config.WithinEditN(le.MNAME,le.MNAME_len,ri.MNAME,ri.MNAME_len,2,6) => MAP((6 > le.MNAME_len) OR (6 > ri.MNAME_len) => SALT311.fn_fuzzy_specificity(le.MNAME_weight100,le.MNAME_cnt, le.MNAME_e1_cnt,ri.MNAME_weight100,ri.MNAME_cnt,ri.MNAME_e1_cnt),SALT311.fn_fuzzy_specificity(le.MNAME_weight100,le.MNAME_cnt, le.MNAME_e2_cnt,ri.MNAME_weight100,ri.MNAME_cnt,ri.MNAME_e2_cnt)),
                        SALT311.Fn_Fail_Scale(AVE(le.MNAME_weight100,ri.MNAME_weight100),s.MNAME_switch))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
  SELF.left_PRIM_RANGE := le.PRIM_RANGE;
  SELF.right_PRIM_RANGE := ri.PRIM_RANGE;
  SELF.PRIM_RANGE_match_code := MAP(
                        le.PRIM_RANGE_isnull OR ri.PRIM_RANGE_isnull => SALT311.MatchCode.OneSideNull,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        /*HACK-O-MATIC*/match_methods(pSrc,pVersion,ih).match_PRIM_RANGE(le.PRIM_RANGE,ri.PRIM_RANGE));
  SELF.PRIM_RANGE_score := MAP(
                        le.PRIM_RANGE_isnull OR ri.PRIM_RANGE_isnull => 0,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.PRIM_RANGE = ri.PRIM_RANGE  => le.PRIM_RANGE_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.PRIM_RANGE_weight100,ri.PRIM_RANGE_weight100),s.PRIM_RANGE_switch))*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  SELF.left_LNAME := le.LNAME;
  SELF.right_LNAME := ri.LNAME;
  SELF.LNAME_match_code := MAP(
                        le.LNAME_isnull OR ri.LNAME_isnull => SALT311.MatchCode.OneSideNull,
                        MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        /*HACK-O-MATIC*/match_methods(pSrc,pVersion,ih).match_LNAME(le.LNAME,ri.LNAME, le.LNAME_len, ri.LNAME_len));
  SELF.LNAME_score := MAP(
                        le.LNAME_isnull OR ri.LNAME_isnull => 0,
                        MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.LNAME = ri.LNAME OR SALT311.HyphenMatch(le.LNAME,ri.LNAME,1)<=2  => MIN(le.LNAME_weight100,ri.LNAME_weight100),
                        LENGTH(TRIM(le.LNAME))>0 and le.LNAME = ri.LNAME[1..LENGTH(TRIM(le.LNAME))] => le.LNAME_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.LNAME))>0 and ri.LNAME = le.LNAME[1..LENGTH(TRIM(ri.LNAME))] => ri.LNAME_weight100, // An initial match - take initial specificity
                        Config.WithinEditN(le.LNAME,le.LNAME_len,ri.LNAME,ri.LNAME_len,2,6) => MAP((6 > le.LNAME_len) OR (6 > ri.LNAME_len) => SALT311.fn_fuzzy_specificity(le.LNAME_weight100,le.LNAME_cnt, le.LNAME_e1_cnt,ri.LNAME_weight100,ri.LNAME_cnt,ri.LNAME_e1_cnt),SALT311.fn_fuzzy_specificity(le.LNAME_weight100,le.LNAME_cnt, le.LNAME_e2_cnt,ri.LNAME_weight100,ri.LNAME_cnt,ri.LNAME_e2_cnt)),
                        SALT311.Fn_Fail_Scale(AVE(le.LNAME_weight100,ri.LNAME_weight100),s.LNAME_switch))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
  SELF.left_PRIM_NAME := le.PRIM_NAME;
  SELF.right_PRIM_NAME := ri.PRIM_NAME;
  SELF.PRIM_NAME_match_code := MAP(
                        le.PRIM_NAME_isnull OR ri.PRIM_NAME_isnull => SALT311.MatchCode.OneSideNull,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        /*HACK-O-MATIC*/match_methods(pSrc,pVersion,ih).match_PRIM_NAME(le.PRIM_NAME,ri.PRIM_NAME));
  SELF.PRIM_NAME_score := MAP(
                        le.PRIM_NAME_isnull OR ri.PRIM_NAME_isnull => 0,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.PRIM_NAME = ri.PRIM_NAME  => le.PRIM_NAME_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.PRIM_NAME_weight100,ri.PRIM_NAME_weight100),s.PRIM_NAME_switch))*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  SELF.left_FNAME := le.FNAME;
  SELF.right_FNAME := ri.FNAME;
  SELF.FNAME_match_code := MAP(
                        le.FNAME_isnull OR ri.FNAME_isnull => SALT311.MatchCode.OneSideNull,
                        MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        /*HACK-O-MATIC*/match_methods(pSrc,pVersion,ih).match_FNAME(le.FNAME,ri.FNAME, le.FNAME_len, ri.FNAME_len));
  INTEGER2 FNAME_score_temp := MAP(
                        le.FNAME_isnull OR ri.FNAME_isnull => 0,
                        MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.FNAME = ri.FNAME  => le.FNAME_weight100,
                        LENGTH(TRIM(le.FNAME))>0 and le.FNAME = ri.FNAME[1..LENGTH(TRIM(le.FNAME))] => le.FNAME_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.FNAME))>0 and ri.FNAME = le.FNAME[1..LENGTH(TRIM(ri.FNAME))] => ri.FNAME_weight100, // An initial match - take initial specificity
                        Config.WithinEditN(le.FNAME,le.FNAME_len,ri.FNAME,ri.FNAME_len,2,8) => MAP((8 > le.FNAME_len) OR (8 > ri.FNAME_len) => SALT311.fn_fuzzy_specificity(le.FNAME_weight100,le.FNAME_cnt, le.FNAME_e1_cnt,ri.FNAME_weight100,ri.FNAME_cnt,ri.FNAME_e1_cnt),SALT311.fn_fuzzy_specificity(le.FNAME_weight100,le.FNAME_cnt, le.FNAME_e2_cnt,ri.FNAME_weight100,ri.FNAME_cnt,ri.FNAME_e2_cnt)),
                        le.FNAME_PreferredName = ri.FNAME_PreferredName => SALT311.fn_fuzzy_specificity(le.FNAME_weight100,le.FNAME_cnt, le.FNAME_PreferredName_cnt,ri.FNAME_weight100,ri.FNAME_cnt,ri.FNAME_PreferredName_cnt),
                        SALT311.Fn_Fail_Scale(AVE(le.FNAME_weight100,ri.FNAME_weight100),s.FNAME_switch))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
  SELF.left_SEC_RANGE := le.SEC_RANGE;
  SELF.right_SEC_RANGE := ri.SEC_RANGE;
  SELF.SEC_RANGE_match_code := MAP(
                        le.SEC_RANGE_isnull OR ri.SEC_RANGE_isnull => SALT311.MatchCode.OneSideNull,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        /*HACK-O-MATIC*/match_methods(pSrc,pVersion,ih).match_SEC_RANGE(le.SEC_RANGE,ri.SEC_RANGE));
  SELF.SEC_RANGE_score := MAP(
                        le.SEC_RANGE_isnull OR ri.SEC_RANGE_isnull => 0,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.SEC_RANGE = ri.SEC_RANGE OR SALT311.HyphenMatch(le.SEC_RANGE,ri.SEC_RANGE,1)<=2  => MIN(le.SEC_RANGE_weight100,ri.SEC_RANGE_weight100),
                        SALT311.Fn_Fail_Scale(AVE(le.SEC_RANGE_weight100,ri.SEC_RANGE_weight100),s.SEC_RANGE_switch))*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  SELF.left_CITY_NAME := le.CITY_NAME;
  SELF.right_CITY_NAME := ri.CITY_NAME;
  SELF.CITY_NAME_match_code := MAP(
                        le.CITY_NAME_isnull OR ri.CITY_NAME_isnull => SALT311.MatchCode.OneSideNull,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        /*HACK-O-MATIC*/match_methods(pSrc,pVersion,ih).match_CITY_NAME(le.CITY_NAME,ri.CITY_NAME));
  SELF.CITY_NAME_score := MAP(
                        le.CITY_NAME_isnull OR ri.CITY_NAME_isnull => 0,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.CITY_NAME = ri.CITY_NAME  => le.CITY_NAME_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.CITY_NAME_weight100,ri.CITY_NAME_weight100),s.CITY_NAME_switch))*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  SELF.left_ZIP := le.ZIP;
  SELF.right_ZIP := ri.ZIP;
  SELF.ZIP_match_code := MAP(
                        le.ZIP_isnull OR ri.ZIP_isnull => SALT311.MatchCode.OneSideNull,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => SALT311.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        /*HACK-O-MATIC*/match_methods(pSrc,pVersion,ih).match_ZIP(le.ZIP,ri.ZIP));
  SELF.ZIP_score := MAP(
                        le.ZIP_isnull OR ri.ZIP_isnull => 0,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.ZIP = ri.ZIP  => le.ZIP_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.ZIP_weight100,ri.ZIP_weight100),s.ZIP_switch))*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  SELF.FNAME_score := IF ( FNAME_score_temp >= Config.FNAME_Force * 100, FNAME_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.FNAME_skipped := SELF.FNAME_score < -5000;// Enforce FORCE parameter
// Compute the score for the concept LOCALE
  INTEGER2 LOCALE_score_ext := SALT311.ClipScore(MAX(LOCALE_score_pre,0) + self.CITY_NAME_score + self.ST_score + self.ZIP_score + MAX(ADDRESS_score_pre,0));// Score in surrounding context
  INTEGER2 LOCALE_score_res := MAX(0,LOCALE_score_pre); // At least nothing
  SELF.LOCALE_score := LOCALE_score_res;
// Compute the score for the concept MAINNAME
  INTEGER2 MAINNAME_score_ext := SALT311.ClipScore(MAX(MAINNAME_score_pre,0) + self.FNAME_score + self.MNAME_score + self.LNAME_score + MAX(FULLNAME_score_pre,0));// Score in surrounding context
  INTEGER2 MAINNAME_score_res := MAX(0,MAINNAME_score_pre); // At least nothing
  SELF.MAINNAME_score := MAINNAME_score_res;
// Compute the score for the concept FULLNAME
  INTEGER2 FULLNAME_score_ext := SALT311.ClipScore(MAX(FULLNAME_score_pre,0)+ SELF.MAINNAME_score + self.FNAME_score + self.MNAME_score + self.LNAME_score + self.SUFFIX_score);// Score in surrounding context
  INTEGER2 FULLNAME_score_res := MAX(0,FULLNAME_score_pre); // At least nothing
  SELF.FULLNAME_score := FULLNAME_score_res;
// Compute the score for the concept ADDR1
  INTEGER2 ADDR1_score_ext := SALT311.ClipScore(MAX(ADDR1_score_pre,0) + self.PRIM_RANGE_score + self.SEC_RANGE_score + self.PRIM_NAME_score + MAX(ADDRESS_score_pre,0));// Score in surrounding context
  INTEGER2 ADDR1_score_res := MAX(0,ADDR1_score_pre); // At least nothing
  SELF.ADDR1_score := ADDR1_score_res;
// Compute the score for the concept ADDRESS
  INTEGER2 ADDRESS_score_ext := SALT311.ClipScore(MAX(ADDRESS_score_pre,0)+ SELF.ADDR1_score + self.PRIM_RANGE_score + self.SEC_RANGE_score + self.PRIM_NAME_score+ SELF.LOCALE_score + self.CITY_NAME_score + self.ST_score + self.ZIP_score);// Score in surrounding context
  INTEGER2 ADDRESS_score_res := MAX(0,ADDRESS_score_pre); // At least nothing
  SELF.ADDRESS_score := ADDRESS_score_res;
  // Get propagation scores for individual propagated fields
  SELF.LEXID_score_prop := MAX(le.LEXID_prop,ri.LEXID_prop)*SELF.LEXID_score; // Score if either field propogated
  SELF.MAINNAME_score_prop := IF(le.MAINNAME_prop+ri.MAINNAME_prop>0,SELF.MAINNAME_score*(0+IF(le.FNAME_prop+ri.FNAME_prop>0,s.FNAME_specificity,0)+IF(le.MNAME_prop+ri.MNAME_prop>0,s.MNAME_specificity,0)+IF(le.LNAME_prop+ri.LNAME_prop>0,s.LNAME_specificity,0))/( s.FNAME_specificity+ s.MNAME_specificity+ s.LNAME_specificity),0);
  SELF.FULLNAME_score_prop := IF(le.FULLNAME_prop+ri.FULLNAME_prop>0,SELF.FULLNAME_score*(0+IF(le.MAINNAME_prop+ri.MAINNAME_prop>0,s.MAINNAME_specificity,0)+IF(le.SUFFIX_prop+ri.SUFFIX_prop>0,s.SUFFIX_specificity,0))/( s.MAINNAME_specificity+ s.SUFFIX_specificity),0);
  SELF.MNAME_score_prop := (MAX(le.MNAME_prop,ri.MNAME_prop)/MAX(LENGTH(TRIM(le.MNAME)),LENGTH(TRIM(ri.MNAME))))*SELF.MNAME_score; // Proportion of longest string propogated
  SELF.SUFFIX_score_prop := MAX(le.SUFFIX_prop,ri.SUFFIX_prop)*SELF.SUFFIX_score; // Score if either field propogated
  SELF.LNAME_score_prop := (MAX(le.LNAME_prop,ri.LNAME_prop)/MAX(LENGTH(TRIM(le.LNAME)),LENGTH(TRIM(ri.LNAME))))*SELF.LNAME_score; // Proportion of longest string propogated
  SELF.FNAME_score_prop := (MAX(le.FNAME_prop,ri.FNAME_prop)/MAX(LENGTH(TRIM(le.FNAME)),LENGTH(TRIM(ri.FNAME))))*SELF.FNAME_score; // Proportion of longest string propogated
  SELF.DOB_score_prop:= SELF.DOB_score*(IF( (le.DOB_prop|ri.DOB_prop)&4>0,6,0 )+IF( (le.DOB_prop|ri.DOB_prop)&2>0,4,0 )+IF( (le.DOB_prop|ri.DOB_prop)&1>0,5,0 ))/15; // Compute weight of year/month/day propagation independently
  SELF.Conf_Prop := (0 + SELF.LEXID_score_prop + SELF.MAINNAME_score_prop + SELF.FULLNAME_score_prop + SELF.MNAME_score_prop + SELF.SUFFIX_score_prop + SELF.LNAME_score_prop + SELF.FNAME_score_prop + SELF.DOB_score_prop) / 100; // Score based on propogated fields
  SELF.Conf := (SELF.LEXID_score + IF(SELF.FULLNAME_score>0,MAX(SELF.FULLNAME_score,IF(SELF.MAINNAME_score>0,MAX(SELF.MAINNAME_score,SELF.FNAME_score + SELF.MNAME_score + SELF.LNAME_score),SELF.FNAME_score + SELF.MNAME_score + SELF.LNAME_score) + SELF.SUFFIX_score),IF(SELF.MAINNAME_score>0,MAX(SELF.MAINNAME_score,SELF.FNAME_score + SELF.MNAME_score + SELF.LNAME_score),SELF.FNAME_score + SELF.MNAME_score + SELF.LNAME_score) + SELF.SUFFIX_score) + IF(SELF.ADDRESS_score>0,MAX(SELF.ADDRESS_score,IF(SELF.ADDR1_score>0,MAX(SELF.ADDR1_score,SELF.PRIM_RANGE_score + SELF.SEC_RANGE_score + SELF.PRIM_NAME_score),SELF.PRIM_RANGE_score + SELF.SEC_RANGE_score + SELF.PRIM_NAME_score) + IF(SELF.LOCALE_score>0,MAX(SELF.LOCALE_score,SELF.CITY_NAME_score + SELF.ST_score + SELF.ZIP_score),SELF.CITY_NAME_score + SELF.ST_score + SELF.ZIP_score)),IF(SELF.ADDR1_score>0,MAX(SELF.ADDR1_score,SELF.PRIM_RANGE_score + SELF.SEC_RANGE_score + SELF.PRIM_NAME_score),SELF.PRIM_RANGE_score + SELF.SEC_RANGE_score + SELF.PRIM_NAME_score) + IF(SELF.LOCALE_score>0,MAX(SELF.LOCALE_score,SELF.CITY_NAME_score + SELF.ST_score + SELF.ZIP_score),SELF.CITY_NAME_score + SELF.ST_score + SELF.ZIP_score)) + SELF.GENDER_score + SELF.SSN_score + SELF.DOB_score) / 100 + outside;
END;
 
EXPORT AnnotateMatchesFromData(DATASET(/*HACK-O-MATIC*/match_candidates(pSrc,pVersion,ih).layout_candidates) in_data,DATASET(/*HACK-O-MATIC*/match_candidates(pSrc,pVersion,ih).layout_matches)  im) := FUNCTION
  j1 := JOIN(in_data,im,LEFT.nomatch_id = RIGHT.nomatch_id1,HASH);
  /*HACK-O-MATIC*/match_candidates(pSrc,pVersion,ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  r := JOIN(j1,in_data,LEFT.nomatch_id2 = RIGHT.nomatch_id,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
  d := DEDUP( r(RID1 <> RID2), ALL, WHOLE RECORD ); // keep all matches and allow downstream processes to filter
  RETURN d;
END;
 
EXPORT AnnotateMatchesFromRecordData(DATASET(/*HACK-O-MATIC*/match_candidates(pSrc,pVersion,ih).layout_candidates) in_data,DATASET(/*HACK-O-MATIC*/match_candidates(pSrc,pVersion,ih).layout_matches)  im) := FUNCTION//Faster form when RID known
  j1 := JOIN(in_data,im,LEFT.RID = RIGHT.RID1,HASH);
  /*HACK-O-MATIC*/match_candidates(pSrc,pVersion,ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(j1,in_data,LEFT.RID2 = RIGHT.RID,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
END;
 
EXPORT AnnotateClusterMatches(DATASET(/*HACK-O-MATIC*/match_candidates(pSrc,pVersion,ih).layout_candidates) in_data,SALT311.UIDType BaseRecord) := FUNCTION//Faster form when RID known
  j1 := in_data(RID = BaseRecord);
  /*HACK-O-MATIC*/match_candidates(pSrc,pVersion,ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(in_data(RID<>BaseRecord),j1,TRUE,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),ALL);
END;
 
EXPORT AnnotateMatches(DATASET(/*HACK-O-MATIC*/match_candidates(pSrc,pVersion,ih).layout_matches) im) := FUNCTION
  am := AnnotateMatchesFromRecordData(h,im);
  am restoreRule(am le,im ri) := TRANSFORM
    SELF.rule := ri.rule;
    SELF := le;
  END;
  annotated_matches := JOIN(am,im,LEFT.RID1=RIGHT.RID1 AND LEFT.RID2=RIGHT.RID2,restoreRule(LEFT,RIGHT),HASH);
  RETURN annotated_matches;
END;
EXPORT Layout_RolledEntity := RECORD,MAXLENGTH(63000)
  SALT311.UIDType nomatch_id;
  DATASET(SALT311.Layout_FieldValueList) LEXID_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) FULLNAME_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) ADDRESS_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) GENDER_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) SRC_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) SSN_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) DOB_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) DT_FIRST_SEEN_Values := DATASET([],SALT311.Layout_FieldValueList);
  DATASET(SALT311.Layout_FieldValueList) DT_LAST_SEEN_Values := DATASET([],SALT311.Layout_FieldValueList);
END;
 
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
  Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.nomatch_id := le.nomatch_id;
    SELF.LEXID_values := SALT311.fn_combine_fieldvaluelist(le.LEXID_values,ri.LEXID_values);
    SELF.FULLNAME_values := SALT311.fn_combine_fieldvaluelist(le.FULLNAME_values,ri.FULLNAME_values);
    SELF.ADDRESS_values := SALT311.fn_combine_fieldvaluelist(le.ADDRESS_values,ri.ADDRESS_values);
    SELF.GENDER_values := SALT311.fn_combine_fieldvaluelist(le.GENDER_values,ri.GENDER_values);
    SELF.SRC_values := SALT311.fn_combine_fieldvaluelist(le.SRC_values,ri.SRC_values);
    SELF.SSN_values := SALT311.fn_combine_fieldvaluelist(le.SSN_values,ri.SSN_values);
    SELF.DOB_values := SALT311.fn_combine_fieldvaluelist(le.DOB_values,ri.DOB_values);
    SELF.DT_FIRST_SEEN_values := SALT311.fn_combine_fieldvaluelist(le.DT_FIRST_SEEN_values,ri.DT_FIRST_SEEN_values);
    SELF.DT_LAST_SEEN_values := SALT311.fn_combine_fieldvaluelist(le.DT_LAST_SEEN_values,ri.DT_LAST_SEEN_values);
  END;
  ds_roll := ROLLUP( SORT( DISTRIBUTE( infile, HASH(nomatch_id) ), nomatch_id, LOCAL ), LEFT.nomatch_id = RIGHT.nomatch_id, RollValues(LEFT,RIGHT),LOCAL);
  Layout_RolledEntity SortValues(Layout_RolledEntity le) := TRANSFORM
    SELF.nomatch_id := le.nomatch_id;
    SELF.LEXID_values := SORT(le.LEXID_values, -cnt, val, LOCAL);
    SELF.FULLNAME_values := SORT(le.FULLNAME_values, -cnt, val, LOCAL);
    SELF.ADDRESS_values := SORT(le.ADDRESS_values, -cnt, val, LOCAL);
    SELF.GENDER_values := SORT(le.GENDER_values, -cnt, val, LOCAL);
    SELF.SRC_values := SORT(le.SRC_values, -cnt, val, LOCAL);
    SELF.SSN_values := SORT(le.SSN_values, -cnt, val, LOCAL);
    SELF.DOB_values := SORT(le.DOB_values, -cnt, val, LOCAL);
    SELF.DT_FIRST_SEEN_values := SORT(le.DT_FIRST_SEEN_values, -cnt, val, LOCAL);
    SELF.DT_LAST_SEEN_values := SORT(le.DT_LAST_SEEN_values, -cnt, val, LOCAL);
  END;
  ds_sort := PROJECT(ds_roll, SortValues(LEFT));
  RETURN ds_sort;
END;
 
EXPORT RolledEntities(DATASET(/*HACK-O-MATIC*/match_candidates(pSrc,pVersion,ih).layout_candidates) in_data) := FUNCTION
 
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.nomatch_id := le.nomatch_id;
  SELF.LEXID_Values := IF ( (le.LEXID  IN SET(s.nulls_LEXID,LEXID) OR le.LEXID = (TYPEOF(le.LEXID))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.LEXID)}],SALT311.Layout_FieldValueList));
  SELF.FULLNAME_Values := IF ( (le.FNAME  IN SET(s.nulls_FNAME,FNAME) OR le.FNAME = (TYPEOF(le.FNAME))'') AND (le.MNAME  IN SET(s.nulls_MNAME,MNAME) OR le.MNAME = (TYPEOF(le.MNAME))'') AND (le.LNAME  IN SET(s.nulls_LNAME,LNAME) OR le.LNAME = (TYPEOF(le.LNAME))'') AND (le.SUFFIX  IN SET(s.nulls_SUFFIX,SUFFIX) OR le.SUFFIX = (TYPEOF(le.SUFFIX))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.FNAME) + ' ' + TRIM((SALT311.StrType)le.MNAME) + ' ' + TRIM((SALT311.StrType)le.LNAME) + ' ' + TRIM((SALT311.StrType)le.SUFFIX)}],SALT311.Layout_FieldValueList));
  SELF.ADDRESS_Values := IF ( (le.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'') AND (le.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'') AND (le.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'') AND (le.CITY_NAME  IN SET(s.nulls_CITY_NAME,CITY_NAME) OR le.CITY_NAME = (TYPEOF(le.CITY_NAME))'') AND (le.ST  IN SET(s.nulls_ST,ST) OR le.ST = (TYPEOF(le.ST))'') AND (le.ZIP  IN SET(s.nulls_ZIP,ZIP) OR le.ZIP = (TYPEOF(le.ZIP))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.PRIM_RANGE) + ' ' + TRIM((SALT311.StrType)le.SEC_RANGE) + ' ' + TRIM((SALT311.StrType)le.PRIM_NAME) + ' ' + TRIM((SALT311.StrType)le.CITY_NAME) + ' ' + TRIM((SALT311.StrType)le.ST) + ' ' + TRIM((SALT311.StrType)le.ZIP)}],SALT311.Layout_FieldValueList));
  SELF.GENDER_Values := IF ( (le.GENDER  IN SET(s.nulls_GENDER,GENDER) OR le.GENDER = (TYPEOF(le.GENDER))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.GENDER)}],SALT311.Layout_FieldValueList));
  SELF.SRC_Values := DATASET([{TRIM((SALT311.StrType)le.SRC)}],SALT311.Layout_FieldValueList);
  SELF.SSN_Values := IF ( (le.SSN  IN SET(s.nulls_SSN,SSN) OR le.SSN = (TYPEOF(le.SSN))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.SSN)}],SALT311.Layout_FieldValueList));
  self.DOB_Values := IF ( le.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND le.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND le.DOB_day  IN SET(s.nulls_DOB_day,DOB_day),dataset([],SALT311.Layout_FieldValueList),dataset([{TRIM((STRING)le.DOB_month)+'/'+TRIM((STRING)le.DOB_day)+'/'+TRIM((STRING)le.DOB_year)}],SALT311.Layout_FieldValueList));
  SELF.DT_FIRST_SEEN_Values := DATASET([{TRIM((SALT311.StrType)le.DT_FIRST_SEEN)}],SALT311.Layout_FieldValueList);
  SELF.DT_LAST_SEEN_Values := DATASET([{TRIM((SALT311.StrType)le.DT_LAST_SEEN)}],SALT311.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
 
Layout_RolledEntity into(ih le) := TRANSFORM
  SELF.nomatch_id := le.nomatch_id;
  SELF.LEXID_Values := IF ( (le.LEXID  IN SET(s.nulls_LEXID,LEXID) OR le.LEXID = (TYPEOF(le.LEXID))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.LEXID)}],SALT311.Layout_FieldValueList));
  SELF.FULLNAME_Values := IF ( (le.FNAME  IN SET(s.nulls_FNAME,FNAME) OR le.FNAME = (TYPEOF(le.FNAME))'') AND (le.MNAME  IN SET(s.nulls_MNAME,MNAME) OR le.MNAME = (TYPEOF(le.MNAME))'') AND (le.LNAME  IN SET(s.nulls_LNAME,LNAME) OR le.LNAME = (TYPEOF(le.LNAME))'') AND (le.SUFFIX  IN SET(s.nulls_SUFFIX,SUFFIX) OR le.SUFFIX = (TYPEOF(le.SUFFIX))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.FNAME) + ' ' + TRIM((SALT311.StrType)le.MNAME) + ' ' + TRIM((SALT311.StrType)le.LNAME) + ' ' + TRIM((SALT311.StrType)le.SUFFIX)}],SALT311.Layout_FieldValueList));
  SELF.ADDRESS_Values := IF ( (le.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'') AND (le.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'') AND (le.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'') AND (le.CITY_NAME  IN SET(s.nulls_CITY_NAME,CITY_NAME) OR le.CITY_NAME = (TYPEOF(le.CITY_NAME))'') AND (le.ST  IN SET(s.nulls_ST,ST) OR le.ST = (TYPEOF(le.ST))'') AND (le.ZIP  IN SET(s.nulls_ZIP,ZIP) OR le.ZIP = (TYPEOF(le.ZIP))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.PRIM_RANGE) + ' ' + TRIM((SALT311.StrType)le.SEC_RANGE) + ' ' + TRIM((SALT311.StrType)le.PRIM_NAME) + ' ' + TRIM((SALT311.StrType)le.CITY_NAME) + ' ' + TRIM((SALT311.StrType)le.ST) + ' ' + TRIM((SALT311.StrType)le.ZIP)}],SALT311.Layout_FieldValueList));
  SELF.GENDER_Values := IF ( (le.GENDER  IN SET(s.nulls_GENDER,GENDER) OR le.GENDER = (TYPEOF(le.GENDER))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.GENDER)}],SALT311.Layout_FieldValueList));
  SELF.SRC_Values := DATASET([{TRIM((SALT311.StrType)le.SRC)}],SALT311.Layout_FieldValueList);
  SELF.SSN_Values := IF ( (le.SSN  IN SET(s.nulls_SSN,SSN) OR le.SSN = (TYPEOF(le.SSN))''),DATASET([],SALT311.Layout_FieldValueList),DATASET([{TRIM((SALT311.StrType)le.SSN)}],SALT311.Layout_FieldValueList));
  self.DOB_Values := IF ( (unsigned)le.DOB = 0,dataset([],SALT311.Layout_FieldValueList),dataset([{(SALT311.StrType)le.DOB}],SALT311.Layout_FieldValueList));
  SELF.DT_FIRST_SEEN_Values := DATASET([{TRIM((SALT311.StrType)le.DT_FIRST_SEEN)}],SALT311.Layout_FieldValueList);
  SELF.DT_LAST_SEEN_Values := DATASET([{TRIM((SALT311.StrType)le.DT_LAST_SEEN)}],SALT311.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(ih,into(left));
EXPORT InFile_Rolled := RollEntities(AsFieldValues);
EXPORT RemoveProps(DATASET(/*HACK-O-MATIC*/match_candidates(pSrc,pVersion,ih).layout_candidates) im) := FUNCTION
 
  im rem(im le) := TRANSFORM
    self.LEXID := if ( le.LEXID_prop>0, (TYPEOF(le.LEXID))'', le.LEXID ); // Blank if propogated
    self.LEXID_isnull := le.LEXID_prop>0 OR le.LEXID_isnull;
    self.LEXID_prop := 0; // Avoid reducing score later
    self.MAINNAME := if ( le.MAINNAME_prop>0, 0, le.MAINNAME ); // Blank if propogated
    self.MAINNAME_isnull := true; // Flag as null to scoring
    self.MAINNAME_prop := 0; // Avoid reducing score later
    self.FULLNAME := if ( le.FULLNAME_prop>0, 0, le.FULLNAME ); // Blank if propogated
    self.FULLNAME_isnull := true; // Flag as null to scoring
    self.FULLNAME_prop := 0; // Avoid reducing score later
    self.MNAME := le.MNAME[1..LENGTH(TRIM(le.MNAME))-le.MNAME_prop]; // Clip propogated chars
    self.MNAME_isnull := self.MNAME='' OR le.MNAME_isnull;
    self.MNAME_prop := 0; // Avoid reducing score later
    self.SUFFIX := if ( le.SUFFIX_prop>0, (TYPEOF(le.SUFFIX))'', le.SUFFIX ); // Blank if propogated
    self.SUFFIX_isnull := le.SUFFIX_prop>0 OR le.SUFFIX_isnull;
    self.SUFFIX_prop := 0; // Avoid reducing score later
    self.LNAME := le.LNAME[1..LENGTH(TRIM(le.LNAME))-le.LNAME_prop]; // Clip propogated chars
    self.LNAME_isnull := self.LNAME='' OR le.LNAME_isnull;
    self.LNAME_prop := 0; // Avoid reducing score later
    self.FNAME := le.FNAME[1..LENGTH(TRIM(le.FNAME))-le.FNAME_prop]; // Clip propogated chars
    self.FNAME_isnull := self.FNAME='' OR le.FNAME_isnull;
    self.FNAME_prop := 0; // Avoid reducing score later
    self.DOB_year := if ( le.DOB_prop&4>0, 0, le.DOB_year ); // Kill year if propogated
    self.DOB_year_isnull := self.DOB_year = 0;
    self.DOB_month := if ( le.DOB_prop&2>0, 0, le.DOB_month ); // Kill month if propogated
    self.DOB_month_isnull := self.DOB_month = 0;
    self.DOB_day := if ( le.DOB_prop&1>0, 0, le.DOB_day ); // Kill day if propogated
    self.DOB_day_isnull := self.DOB_day = 0;
    self.DOB_prop := 0; // Avoid reducing score later
    SELF := le;
  END;
  RETURN PROJECT(im,rem(LEFT));
END;
// Now to compute the chubbies; those clusters which are really rather larger than one would expect
// this is presently defined in terms of number of field values * the improbability of that occuring by chance
// this could be used as poor mans dodgy-dids; but it does not allow for value planing (co-occurrence)
AllRolled := InFile_Rolled;
Layout_Chubbies0 := RECORD,MAXLENGTH(63000)
  AllRolled;
  UNSIGNED1 LEXID_size := 0;
  UNSIGNED1 FULLNAME_size := 0;
  UNSIGNED1 ADDRESS_size := 0;
  UNSIGNED1 GENDER_size := 0;
  UNSIGNED1 SSN_size := 0;
  UNSIGNED1 DOB_size := 0;
END;
t0 := TABLE(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := TRANSFORM
  SELF.LEXID_size := SALT311.Fn_SwitchSpec(s.LEXID_switch,count(le.LEXID_values));
  SELF.FULLNAME_size := SALT311.Fn_SwitchSpec(s.FULLNAME_switch,count(le.FULLNAME_values));
  SELF.ADDRESS_size := SALT311.Fn_SwitchSpec(s.ADDRESS_switch,count(le.ADDRESS_values));
  SELF.GENDER_size := SALT311.Fn_SwitchSpec(s.GENDER_switch,count(le.GENDER_values));
  SELF.SSN_size := SALT311.Fn_SwitchSpec(s.SSN_switch,count(le.SSN_values));
  SELF.DOB_size := SALT311.Fn_SwitchSpec(MAX(s.DOB_day_switch,s.DOB_month_switch,s.DOB_year_switch),count(le.DOB_values));
  SELF := le;
END;  t := PROJECT(t0,NoteSize(LEFT));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  UNSIGNED2 Size := t.LEXID_size+t.FULLNAME_size+t.ADDRESS_size+t.GENDER_size+t.SSN_size+t.DOB_size;
END;
EXPORT Chubbies := TABLE(t,Layout_Chubbies);
END;
