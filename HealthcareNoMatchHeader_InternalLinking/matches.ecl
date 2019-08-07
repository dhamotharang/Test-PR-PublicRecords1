// Begin code to perform the matching itself
 
/*HACK-O-MATIC*/IMPORT SALT311,STD,HealthcareNoMatchHeader_Ingest;
/*HACK-O-MATIC*/EXPORT matches(STRING pSrc, STRING pVersion =  (STRING)STD.Date.Today(), DATASET(layout_HEADER) ih, UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED IntraMatchThreshold := LowerMatchThreshold - Config.SliceDistance;
SHARED h := /*HACK-O-MATIC*/match_candidates(pSrc,pVersion,ih).candidates;
SHARED s := /*HACK-O-MATIC*/Specificities(pSrc,pVersion,ih).Specificities[1];
 
SHARED /*HACK-O-MATIC*/match_candidates(pSrc,pVersion,ih).layout_matches match_join(/*HACK-O-MATIC*/match_candidates(pSrc,pVersion,ih).layout_candidates le,/*HACK-O-MATIC*/match_candidates(pSrc,pVersion,ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.nomatch_id1 := le.nomatch_id;
  SELF.nomatch_id2 := ri.nomatch_id;
  SELF.RID1 := le.RID;
  SELF.RID2 := ri.RID;
  SELF.DateOverlap := SALT311.fn_ComputeDateOverlap(((UNSIGNED)le.DT_FIRST_SEEN)*100,((UNSIGNED)le.DT_LAST_SEEN)*100,((UNSIGNED)ri.DT_FIRST_SEEN)*100,((UNSIGNED)ri.DT_LAST_SEEN)*100);
  INTEGER2 LEXID_score := MAP(
                        le.LEXID_isnull OR ri.LEXID_isnull => 0,
                        le.LEXID = ri.LEXID  => le.LEXID_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.LEXID_weight100,ri.LEXID_weight100),s.LEXID_switch));
  REAL FULLNAME_score_scale := ( le.FULLNAME_weight100 + ri.FULLNAME_weight100 ) / (le.MAINNAME_weight100 + ri.MAINNAME_weight100 + le.SUFFIX_weight100 + ri.SUFFIX_weight100); // Scaling factor for this concept
  INTEGER2 FULLNAME_score_pre := MAP( (le.FULLNAME_isnull OR (le.MAINNAME_isnull OR le.FNAME_isnull AND le.MNAME_isnull AND le.LNAME_isnull) AND le.SUFFIX_isnull) OR (ri.FULLNAME_isnull OR (ri.MAINNAME_isnull OR ri.FNAME_isnull AND ri.MNAME_isnull AND ri.LNAME_isnull) AND ri.SUFFIX_isnull) => 0,
                        le.FULLNAME = ri.FULLNAME  => le.FULLNAME_weight100,
                        0);
  REAL ADDRESS_score_scale := ( le.ADDRESS_weight100 + ri.ADDRESS_weight100 ) / (le.ADDR1_weight100 + ri.ADDR1_weight100 + le.LOCALE_weight100 + ri.LOCALE_weight100); // Scaling factor for this concept
  INTEGER2 ADDRESS_score_pre := MAP( (le.ADDRESS_isnull OR (le.ADDR1_isnull OR le.PRIM_RANGE_isnull AND le.SEC_RANGE_isnull AND le.PRIM_NAME_isnull) AND (le.LOCALE_isnull OR le.CITY_NAME_isnull AND le.ST_isnull AND le.ZIP_isnull)) OR (ri.ADDRESS_isnull OR (ri.ADDR1_isnull OR ri.PRIM_RANGE_isnull AND ri.SEC_RANGE_isnull AND ri.PRIM_NAME_isnull) AND (ri.LOCALE_isnull OR ri.CITY_NAME_isnull AND ri.ST_isnull AND ri.ZIP_isnull)) => 0,
                        le.ADDRESS = ri.ADDRESS  => le.ADDRESS_weight100,
                        0);
  INTEGER2 SUFFIX_score := MAP(
                        le.SUFFIX_isnull OR ri.SUFFIX_isnull => 0,
                        FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.SUFFIX = ri.SUFFIX  => le.SUFFIX_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.SUFFIX_weight100,ri.SUFFIX_weight100),s.SUFFIX_switch))*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
  REAL LOCALE_score_scale := ( le.LOCALE_weight100 + ri.LOCALE_weight100 ) / (le.CITY_NAME_weight100 + ri.CITY_NAME_weight100 + le.ST_weight100 + ri.ST_weight100 + le.ZIP_weight100 + ri.ZIP_weight100); // Scaling factor for this concept
  INTEGER2 LOCALE_score_pre := MAP( (le.LOCALE_isnull OR le.CITY_NAME_isnull AND le.ST_isnull AND le.ZIP_isnull) OR (ri.LOCALE_isnull OR ri.CITY_NAME_isnull AND ri.ST_isnull AND ri.ZIP_isnull) => 0,
                        ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.LOCALE = ri.LOCALE  => le.LOCALE_weight100,
                        0)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 GENDER_score := MAP(
                        le.GENDER_isnull OR ri.GENDER_isnull => 0,
                        le.GENDER = ri.GENDER  => le.GENDER_weight100,
                        /*HACK-O-MATIC*/Config.Mismatch_Score_GENDER);

  INTEGER2 SSN_score := MAP(
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
  INTEGER2 DOB_score := MAP( le.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND le.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND le.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) or ri.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND ri.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND ri.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) => 0,
                        DOB_year_score+DOB_month_score+DOB_day_score < 0 or DOB_year_score+DOB_month_score+DOB_day_score<>0 and DOB_year_score+DOB_month_score+DOB_day_score < 300 => SKIP,
                        Config.DOB_UseGenerationForce AND DOB_year_score < 0 AND ABS(le.DOB_year-ri.DOB_year) > 13 => SKIP, // Do not allow full generation mis-match
                        DOB_score_temp);
 
  INTEGER2 ST_score := MAP(
                        le.ST_isnull OR ri.ST_isnull => 0,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.ST = ri.ST  => le.ST_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.ST_weight100,ri.ST_weight100),s.ST_switch))*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  REAL MAINNAME_score_scale := ( le.MAINNAME_weight100 + ri.MAINNAME_weight100 ) / (le.FNAME_weight100 + ri.FNAME_weight100 + le.MNAME_weight100 + ri.MNAME_weight100 + le.LNAME_weight100 + ri.LNAME_weight100); // Scaling factor for this concept
  
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

/*HACK-O-MATIC*/INTEGER2 MAINNAME_score_pre := if (((ssn_score > Config.SSN_Score_Min_MAINNAME OR dob_score > Config.DOB_Score_Min_MAINNAME) AND MAINNAME_score_less_strict > 0)
/*HACK-O-MATIC*/OR MAINNAME_score_strict > 0,
/*HACK-O-MATIC*/MAINNAME_score_pre_v1, 0);

  REAL ADDR1_score_scale := ( le.ADDR1_weight100 + ri.ADDR1_weight100 ) / (le.PRIM_RANGE_weight100 + ri.PRIM_RANGE_weight100 + le.SEC_RANGE_weight100 + ri.SEC_RANGE_weight100 + le.PRIM_NAME_weight100 + ri.PRIM_NAME_weight100); // Scaling factor for this concept
  INTEGER2 ADDR1_score_pre := MAP( (le.ADDR1_isnull OR le.PRIM_RANGE_isnull AND le.SEC_RANGE_isnull AND le.PRIM_NAME_isnull) OR (ri.ADDR1_isnull OR ri.PRIM_RANGE_isnull AND ri.SEC_RANGE_isnull AND ri.PRIM_NAME_isnull) => 0,
                        ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.ADDR1 = ri.ADDR1  => le.ADDR1_weight100,
                        0)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 MNAME_score := MAP(
                        le.MNAME_isnull OR ri.MNAME_isnull => 0,
                        MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.MNAME = ri.MNAME  => le.MNAME_weight100,
                        LENGTH(TRIM(le.MNAME))>0 and le.MNAME = ri.MNAME[1..LENGTH(TRIM(le.MNAME))] => le.MNAME_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.MNAME))>0 and ri.MNAME = le.MNAME[1..LENGTH(TRIM(ri.MNAME))] => ri.MNAME_weight100, // An initial match - take initial specificity
                        Config.WithinEditN(le.MNAME,le.MNAME_len,ri.MNAME,ri.MNAME_len,2,6) => MAP((6 > le.MNAME_len) OR (6 > ri.MNAME_len) => SALT311.fn_fuzzy_specificity(le.MNAME_weight100,le.MNAME_cnt, le.MNAME_e1_cnt,ri.MNAME_weight100,ri.MNAME_cnt,ri.MNAME_e1_cnt),SALT311.fn_fuzzy_specificity(le.MNAME_weight100,le.MNAME_cnt, le.MNAME_e2_cnt,ri.MNAME_weight100,ri.MNAME_cnt,ri.MNAME_e2_cnt)),
                        SALT311.Fn_Fail_Scale(AVE(le.MNAME_weight100,ri.MNAME_weight100),s.MNAME_switch))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
  INTEGER2 PRIM_RANGE_score := MAP(
                        le.PRIM_RANGE_isnull OR ri.PRIM_RANGE_isnull => 0,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.PRIM_RANGE = ri.PRIM_RANGE  => le.PRIM_RANGE_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.PRIM_RANGE_weight100,ri.PRIM_RANGE_weight100),s.PRIM_RANGE_switch))*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 LNAME_score := MAP(
                        le.LNAME_isnull OR ri.LNAME_isnull => 0,
                        MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.LNAME = ri.LNAME OR SALT311.HyphenMatch(le.LNAME,ri.LNAME,1)<=2  => MIN(le.LNAME_weight100,ri.LNAME_weight100),
                        LENGTH(TRIM(le.LNAME))>0 and le.LNAME = ri.LNAME[1..LENGTH(TRIM(le.LNAME))] => le.LNAME_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.LNAME))>0 and ri.LNAME = le.LNAME[1..LENGTH(TRIM(ri.LNAME))] => ri.LNAME_weight100, // An initial match - take initial specificity
                        Config.WithinEditN(le.LNAME,le.LNAME_len,ri.LNAME,ri.LNAME_len,2,6) => MAP((6 > le.LNAME_len) OR (6 > ri.LNAME_len) => SALT311.fn_fuzzy_specificity(le.LNAME_weight100,le.LNAME_cnt, le.LNAME_e1_cnt,ri.LNAME_weight100,ri.LNAME_cnt,ri.LNAME_e1_cnt),SALT311.fn_fuzzy_specificity(le.LNAME_weight100,le.LNAME_cnt, le.LNAME_e2_cnt,ri.LNAME_weight100,ri.LNAME_cnt,ri.LNAME_e2_cnt)),
                        SALT311.Fn_Fail_Scale(AVE(le.LNAME_weight100,ri.LNAME_weight100),s.LNAME_switch))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
  INTEGER2 PRIM_NAME_score := MAP(
                        le.PRIM_NAME_isnull OR ri.PRIM_NAME_isnull => 0,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.PRIM_NAME = ri.PRIM_NAME  => le.PRIM_NAME_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.PRIM_NAME_weight100,ri.PRIM_NAME_weight100),s.PRIM_NAME_switch))*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 FNAME_score_temp := MAP(
                        le.FNAME_isnull OR ri.FNAME_isnull => 0,
                        MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.FNAME = ri.FNAME  => le.FNAME_weight100,
                        LENGTH(TRIM(le.FNAME))>0 and le.FNAME = ri.FNAME[1..LENGTH(TRIM(le.FNAME))] => le.FNAME_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.FNAME))>0 and ri.FNAME = le.FNAME[1..LENGTH(TRIM(ri.FNAME))] => ri.FNAME_weight100, // An initial match - take initial specificity
                        Config.WithinEditN(le.FNAME,le.FNAME_len,ri.FNAME,ri.FNAME_len,2,8) => MAP((8 > le.FNAME_len) OR (8 > ri.FNAME_len) => SALT311.fn_fuzzy_specificity(le.FNAME_weight100,le.FNAME_cnt, le.FNAME_e1_cnt,ri.FNAME_weight100,ri.FNAME_cnt,ri.FNAME_e1_cnt),SALT311.fn_fuzzy_specificity(le.FNAME_weight100,le.FNAME_cnt, le.FNAME_e2_cnt,ri.FNAME_weight100,ri.FNAME_cnt,ri.FNAME_e2_cnt)),
                        le.FNAME_PreferredName = ri.FNAME_PreferredName => SALT311.fn_fuzzy_specificity(le.FNAME_weight100,le.FNAME_cnt, le.FNAME_PreferredName_cnt,ri.FNAME_weight100,ri.FNAME_cnt,ri.FNAME_PreferredName_cnt),
                        SALT311.Fn_Fail_Scale(AVE(le.FNAME_weight100,ri.FNAME_weight100),s.FNAME_switch))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
  INTEGER2 SEC_RANGE_score := MAP(
                        le.SEC_RANGE_isnull OR ri.SEC_RANGE_isnull => 0,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.SEC_RANGE = ri.SEC_RANGE OR SALT311.HyphenMatch(le.SEC_RANGE,ri.SEC_RANGE,1)<=2  => MIN(le.SEC_RANGE_weight100,ri.SEC_RANGE_weight100),
                        SALT311.Fn_Fail_Scale(AVE(le.SEC_RANGE_weight100,ri.SEC_RANGE_weight100),s.SEC_RANGE_switch))*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 CITY_NAME_score := MAP(
                        le.CITY_NAME_isnull OR ri.CITY_NAME_isnull => 0,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.CITY_NAME = ri.CITY_NAME  => le.CITY_NAME_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.CITY_NAME_weight100,ri.CITY_NAME_weight100),s.CITY_NAME_switch))*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 ZIP_score := MAP(
                        le.ZIP_isnull OR ri.ZIP_isnull => 0,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.ZIP = ri.ZIP  => le.ZIP_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.ZIP_weight100,ri.ZIP_weight100),s.ZIP_switch))*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 FNAME_score := IF ( FNAME_score_temp >= Config.FNAME_Force * 100, FNAME_score_temp, SKIP ); // Enforce FORCE parameter
// Compute the score for the concept LOCALE
  INTEGER2 LOCALE_score_ext := SALT311.ClipScore(MAX(LOCALE_score_pre,0) + CITY_NAME_score + ST_score + ZIP_score + MAX(ADDRESS_score_pre,0));// Score in surrounding context
  INTEGER2 LOCALE_score_res := MAX(0,LOCALE_score_pre); // At least nothing
  INTEGER2 LOCALE_score := LOCALE_score_res;
// Compute the score for the concept MAINNAME
  INTEGER2 MAINNAME_score_ext := SALT311.ClipScore(MAX(MAINNAME_score_pre,0) + FNAME_score + MNAME_score + LNAME_score + MAX(FULLNAME_score_pre,0));// Score in surrounding context
  INTEGER2 MAINNAME_score_res := MAX(0,MAINNAME_score_pre); // At least nothing
  INTEGER2 MAINNAME_score := MAINNAME_score_res;
// Compute the score for the concept FULLNAME
  INTEGER2 FULLNAME_score_ext := SALT311.ClipScore(MAX(FULLNAME_score_pre,0)+ MAINNAME_score + FNAME_score + MNAME_score + LNAME_score + SUFFIX_score);// Score in surrounding context
  INTEGER2 FULLNAME_score_res := MAX(0,FULLNAME_score_pre); // At least nothing
  INTEGER2 FULLNAME_score := FULLNAME_score_res;
// Compute the score for the concept ADDR1
  INTEGER2 ADDR1_score_ext := SALT311.ClipScore(MAX(ADDR1_score_pre,0) + PRIM_RANGE_score + SEC_RANGE_score + PRIM_NAME_score + MAX(ADDRESS_score_pre,0));// Score in surrounding context
  INTEGER2 ADDR1_score_res := MAX(0,ADDR1_score_pre); // At least nothing
  INTEGER2 ADDR1_score := ADDR1_score_res;
// Compute the score for the concept ADDRESS
  INTEGER2 ADDRESS_score_ext := SALT311.ClipScore(MAX(ADDRESS_score_pre,0)+ ADDR1_score + PRIM_RANGE_score + SEC_RANGE_score + PRIM_NAME_score+ LOCALE_score + CITY_NAME_score + ST_score + ZIP_score);// Score in surrounding context
  INTEGER2 ADDRESS_score_res := MAX(0,ADDRESS_score_pre); // At least nothing
  INTEGER2 ADDRESS_score := ADDRESS_score_res;
  // Get propagation scores for individual propagated fields
  INTEGER2 LEXID_score_prop := MAX(le.LEXID_prop,ri.LEXID_prop)*LEXID_score; // Score if either field propogated
  INTEGER2 MAINNAME_score_prop := IF(le.MAINNAME_prop+ri.MAINNAME_prop>0,MAINNAME_score*(0+IF(le.FNAME_prop+ri.FNAME_prop>0,s.FNAME_specificity,0)+IF(le.MNAME_prop+ri.MNAME_prop>0,s.MNAME_specificity,0)+IF(le.LNAME_prop+ri.LNAME_prop>0,s.LNAME_specificity,0))/( s.FNAME_specificity+ s.MNAME_specificity+ s.LNAME_specificity),0);
  INTEGER2 FULLNAME_score_prop := IF(le.FULLNAME_prop+ri.FULLNAME_prop>0,FULLNAME_score*(0+IF(le.MAINNAME_prop+ri.MAINNAME_prop>0,s.MAINNAME_specificity,0)+IF(le.SUFFIX_prop+ri.SUFFIX_prop>0,s.SUFFIX_specificity,0))/( s.MAINNAME_specificity+ s.SUFFIX_specificity),0);
  INTEGER2 MNAME_score_prop := (MAX(le.MNAME_prop,ri.MNAME_prop)/MAX(LENGTH(TRIM(le.MNAME)),LENGTH(TRIM(ri.MNAME))))*MNAME_score; // Proportion of longest string propogated
  INTEGER2 SUFFIX_score_prop := MAX(le.SUFFIX_prop,ri.SUFFIX_prop)*SUFFIX_score; // Score if either field propogated
  INTEGER2 LNAME_score_prop := (MAX(le.LNAME_prop,ri.LNAME_prop)/MAX(LENGTH(TRIM(le.LNAME)),LENGTH(TRIM(ri.LNAME))))*LNAME_score; // Proportion of longest string propogated
  INTEGER2 FNAME_score_prop := (MAX(le.FNAME_prop,ri.FNAME_prop)/MAX(LENGTH(TRIM(le.FNAME)),LENGTH(TRIM(ri.FNAME))))*FNAME_score; // Proportion of longest string propogated
  INTEGER2 DOB_score_prop:= DOB_score*(IF( (le.DOB_prop|ri.DOB_prop)&4>0,6,0 )+IF( (le.DOB_prop|ri.DOB_prop)&2>0,4,0 )+IF( (le.DOB_prop|ri.DOB_prop)&1>0,5,0 ))/15; // Compute weight of year/month/day propagation independently
  SELF.Conf_Prop := (0 + LEXID_score_prop + MAINNAME_score_prop + FULLNAME_score_prop + MNAME_score_prop + SUFFIX_score_prop + LNAME_score_prop + FNAME_score_prop + DOB_score_prop) / 100; // Score based on propogated fields
  iComp := (LEXID_score + IF(FULLNAME_score>0,MAX(FULLNAME_score,IF(MAINNAME_score>0,MAX(MAINNAME_score,FNAME_score + MNAME_score + LNAME_score),FNAME_score + MNAME_score + LNAME_score) + SUFFIX_score),IF(MAINNAME_score>0,MAX(MAINNAME_score,FNAME_score + MNAME_score + LNAME_score),FNAME_score + MNAME_score + LNAME_score) + SUFFIX_score) + IF(ADDRESS_score>0,MAX(ADDRESS_score,IF(ADDR1_score>0,MAX(ADDR1_score,PRIM_RANGE_score + SEC_RANGE_score + PRIM_NAME_score),PRIM_RANGE_score + SEC_RANGE_score + PRIM_NAME_score) + IF(LOCALE_score>0,MAX(LOCALE_score,CITY_NAME_score + ST_score + ZIP_score),CITY_NAME_score + ST_score + ZIP_score)),IF(ADDR1_score>0,MAX(ADDR1_score,PRIM_RANGE_score + SEC_RANGE_score + PRIM_NAME_score),PRIM_RANGE_score + SEC_RANGE_score + PRIM_NAME_score) + IF(LOCALE_score>0,MAX(LOCALE_score,CITY_NAME_score + ST_score + ZIP_score),CITY_NAME_score + ST_score + ZIP_score)) + GENDER_score + SSN_score + DOB_score) / 100 + outside;
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-SELF.Conf_Prop >= LowerMatchThreshold OR (le.nomatch_id = ri.nomatch_id AND (iComp >= IntraMatchThreshold OR iComp-SELF.Conf_Prop >= IntraMatchThreshold)),iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
EXPORT RuleText(UNSIGNED n) :=  MAP (
  n = 0 => ':LEXID',
  n = 1 => ':MNAME',
  n = 2 => ':PRIM_RANGE',
  n = 3 => ':SUFFIX:*',
  n = 6 => ':LNAME:*',
  n = 8 => ':PRIM_NAME:FNAME','AttributeFile:'+(STRING)(n-10000));
//Now execute each of the 9 join conditions of which 3 have been optimized into preceding conditions
EXPORT MAC_DoJoins(hfile,trans) := FUNCTIONMACRO
 
//Fixed fields ->:LEXID(18)
 
dn0 := hfile(~LEXID_isnull);
dn0_deduped := dn0(LEXID_weight100>=1200); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.nomatch_id > RIGHT.nomatch_id
    AND LEFT.LEXID = RIGHT.LEXID
    AND SALT311.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    ,trans(LEFT,RIGHT,0),UNORDERED,
    ATMOST(LEFT.LEXID = RIGHT.LEXID,10000),HASH);
 
//Fixed fields ->:MNAME(14)
 
dn1 := hfile(~MNAME_isnull);
dn1_deduped := dn1(MNAME_weight100>=1200); // Use specificity to flag high-dup counts
mj1 := JOIN( dn1_deduped, dn1_deduped, LEFT.nomatch_id > RIGHT.nomatch_id
    AND LEFT.MNAME = RIGHT.MNAME
    AND SALT311.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    ,trans(LEFT,RIGHT,1),UNORDERED,
    ATMOST(LEFT.MNAME = RIGHT.MNAME,10000),HASH);
 
//Fixed fields ->:PRIM_RANGE(13)
 
dn2 := hfile(~PRIM_RANGE_isnull);
dn2_deduped := dn2(PRIM_RANGE_weight100>=1200); // Use specificity to flag high-dup counts
mj2 := JOIN( dn2_deduped, dn2_deduped, LEFT.nomatch_id > RIGHT.nomatch_id
    AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE
    AND SALT311.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    ,trans(LEFT,RIGHT,2),UNORDERED,
    ATMOST(LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE,10000),HASH);
 
//First 1 fields shared with following 2 joins - optimization performed
//Fixed fields ->:SUFFIX(10):LNAME(10) also :SUFFIX(10):PRIM_NAME(10) also :SUFFIX(10):FNAME(8)
 
dn3 := hfile(~SUFFIX_isnull);
dn3_deduped := dn3(SUFFIX_weight100>=800); // Use specificity to flag high-dup counts
mj3 := JOIN( dn3_deduped, dn3_deduped, LEFT.nomatch_id > RIGHT.nomatch_id
    AND LEFT.SUFFIX = RIGHT.SUFFIX
    AND SALT311.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    AND (
          LEFT.LNAME = RIGHT.LNAME AND ~LEFT.LNAME_isnull
    OR    LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND ~LEFT.PRIM_NAME_isnull
    OR    LEFT.FNAME = RIGHT.FNAME AND ~LEFT.FNAME_isnull
        )
    ,trans(LEFT,RIGHT,3),UNORDERED,
    ATMOST(LEFT.SUFFIX = RIGHT.SUFFIX,10000),HASH);
mjs0_t := mj0+mj1+mj2+mj3;
SALT311.mac_select_best_matches(mjs0_t,RID1,RID2,o0);
mjs0 := o0 : /*HACK-O-MATIC*/PERSIST(HealthcareNoMatchHeader_Ingest.Filenames(pSrc).lPersistTemplate+pVersion+'::'+'mj::0',EXPIRE(HealthcareNoMatchHeader_InternalLinking.Config.PersistExpire));
 
//First 1 fields shared with following 1 joins - optimization performed
//Fixed fields ->:LNAME(10):PRIM_NAME(10) also :LNAME(10):FNAME(8)
 
dn6 := hfile(~LNAME_isnull);
dn6_deduped := dn6(LNAME_weight100>=800); // Use specificity to flag high-dup counts
mj6 := JOIN( dn6_deduped, dn6_deduped, LEFT.nomatch_id > RIGHT.nomatch_id
    AND LEFT.LNAME = RIGHT.LNAME
    AND SALT311.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    AND (
          LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND ~LEFT.PRIM_NAME_isnull
    OR    LEFT.FNAME = RIGHT.FNAME AND ~LEFT.FNAME_isnull
        )
    ,trans(LEFT,RIGHT,6),UNORDERED,
    ATMOST(LEFT.LNAME = RIGHT.LNAME,10000),HASH);
 
//Fixed fields ->:PRIM_NAME(10):FNAME(8)
 
dn8 := hfile(~PRIM_NAME_isnull AND ~FNAME_isnull);
dn8_deduped := dn8(PRIM_NAME_weight100 + FNAME_weight100>=1200); // Use specificity to flag high-dup counts
mj8 := JOIN( dn8_deduped, dn8_deduped, LEFT.nomatch_id > RIGHT.nomatch_id
    AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME
    AND LEFT.FNAME = RIGHT.FNAME
    AND SALT311.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    ,trans(LEFT,RIGHT,8),UNORDERED,
    ATMOST(LEFT.PRIM_NAME = RIGHT.PRIM_NAME
      AND LEFT.FNAME = RIGHT.FNAME,10000),HASH);
last_mjs_t :=mj6+mj8;
SALT311.mac_select_best_matches(last_mjs_t,RID1,RID2,o);
mjs1 := o : /*HACK-O-MATIC*/PERSIST(HealthcareNoMatchHeader_Ingest.Filenames(pSrc).lPersistTemplate+pVersion+'::'+'mj::1',EXPIRE(HealthcareNoMatchHeader_InternalLinking.Config.PersistExpire));
 
RETURN  mjs0+ mjs1;
ENDMACRO;
SHARED all_mjs := MAC_DoJoins(h,match_join);
EXPORT All_Matches := all_mjs : /*HACK-O-MATIC*/PERSIST(HealthcareNoMatchHeader_Ingest.Filenames(pSrc).lPersistTemplate+pVersion+'::'+'all_m',EXPIRE(HealthcareNoMatchHeader_InternalLinking.Config.PersistExpire)); // To by used by RID and nomatch_id
SALT311.mac_avoid_transitives(All_Matches,nomatch_id1,nomatch_id2,Conf,DateOverlap,Rule,o);
EXPORT PossibleMatches := o : /*HACK-O-MATIC*/PERSIST(HealthcareNoMatchHeader_Ingest.Filenames(pSrc).lPersistTemplate+pVersion+'::'+'mt',EXPIRE(HealthcareNoMatchHeader_InternalLinking.Config.PersistExpire));
SALT311.mac_get_BestPerRecord( All_Matches,RID1,nomatch_id1,RID2,nomatch_id2,o );
EXPORT BestPerRecord := o : /*HACK-O-MATIC*/PERSIST(HealthcareNoMatchHeader_Ingest.Filenames(pSrc).lPersistTemplate+pVersion+'::'+'mr',EXPIRE(HealthcareNoMatchHeader_InternalLinking.Config.PersistExpire));
//Now lets see if any slice-outs are needed
SHARED too_big := TABLE(/*HACK-O-MATIC*/match_candidates(pSrc,pVersion,ih).Candidates_ForSlice,{nomatch_id, InCluster := COUNT(GROUP)},nomatch_id,LOCAL)(InCluster>1000); // nomatch_id that are too big for sliceout
SHARED h_ok := JOIN(/*HACK-O-MATIC*/match_candidates(pSrc,pVersion,ih).Candidates_ForSlice,too_big,LEFT.nomatch_id=RIGHT.nomatch_id,TRANSFORM(LEFT),LOCAL,LEFT ONLY);
SHARED in_matches := JOIN(h_ok,h_ok,LEFT.nomatch_id=RIGHT.nomatch_id AND (>STRING6<)LEFT.RID<>(>STRING6<)RIGHT.RID,match_join(LEFT,RIGHT,9999),LOCAL,UNORDERED);
SALT311.mac_cluster_breadth(in_matches,RID1,RID2,nomatch_id1,o);
SHARED in_matches1 := o;
missed_linkages0 := JOIN(h_ok, in_matches1, LEFT.RID = RIGHT.RID1, TRANSFORM(RECORDOF(in_matches1), SELF.nomatch_id1 := LEFT.nomatch_id, SELF.RID1 := LEFT.RID, SELF := []), LEFT ONLY, LOCAL); // get back the records with no close matches
missed_linkages := JOIN(missed_linkages0,/*HACK-O-MATIC*/Specificities(pSrc,pVersion,ih).ClusterSizes(InCluster>1),LEFT.nomatch_id1=RIGHT.nomatch_id,LOCAL); // remove singletons
o1 := JOIN(in_matches1,/*HACK-O-MATIC*/Specificities(pSrc,pVersion,ih).ClusterSizes,LEFT.nomatch_id1=RIGHT.nomatch_id,LOCAL);
EXPORT ClusterLinkages := o1 + missed_linkages : /*HACK-O-MATIC*/PERSIST(HealthcareNoMatchHeader_Ingest.Filenames(pSrc).lPersistTemplate+pVersion+'::'+'clu',EXPIRE(HealthcareNoMatchHeader_InternalLinking.Config.PersistExpire));
EXPORT ClusterOutcasts := ClusterLinkages(InCluster>1,Closest<MatchThreshold);
//Now find those outcasts that are liked elsewhere ...
Pref_Layout := RECORD
  SALT311.UIDType RID;  //Outcast
  SALT311.UIDType nomatch_id;  // Outcase within
  INTEGER2 Closest; // Best present link
  SALT311.UIDType Pref_RID; // Prefers this record
  SALT311.UIDType Pref_nomatch_id; // Prefers this cluster
  INTEGER2 Conf; // Score of new link
  integer2 Conf_Prop; // Prop of new link
  UNSIGNED2 Pref_Margin; // Extent to which pref is preferred
END;
Pref_Layout note_better(ClusterOutcasts le, BestPerRecord ri) := TRANSFORM
  self.RID := le.RID1;
  self.nomatch_id := le.nomatch_id1;
  self.Closest := le.Closest;
  self.Pref_RID := ri.RID2;
  self.Pref_nomatch_id := ri.nomatch_id2;
  self.Pref_Margin := ri.Conf-ri.Conf_Prop-le.Closest; // Compute winning margin
  SELF := ri;
END;
// Find those records happier in another cluster
CurrentJumpers := JOIN(BestPerRecord,ClusterOutcasts,LEFT.RID1=RIGHT.RID1 AND RIGHT.closest<LEFT.conf-LEFT.conf_prop,note_better(RIGHT,LEFT),HASH);
// No need for record to jump ship if clusters are joinable
WillJoin1 := JOIN(CurrentJumpers,All_Matches(Conf>=MatchThreshold),LEFT.nomatch_id=RIGHT.nomatch_id1 AND LEFT.Pref_nomatch_id=RIGHT.nomatch_id2,TRANSFORM(LEFT),LEFT ONLY,HASH);
WillJoin2 := JOIN(WillJoin1,All_Matches(Conf>=MatchThreshold),LEFT.nomatch_id=RIGHT.nomatch_id2 AND LEFT.Pref_nomatch_id=RIGHT.nomatch_id1,TRANSFORM(LEFT),LEFT ONLY,HASH);
WillJoin3 := JOIN(WillJoin2,/*HACK-O-MATIC*/match_candidates(pSrc,pVersion,ih).hasbuddies,LEFT.RID=RIGHT.RID,TRANSFORM(LEFT),LEFT ONLY,HASH); // Duplicated records cannot be sliced
EXPORT BetterElsewhere := WillJoin3;
EXPORT ToSlice := IF ( Config.DoSliceouts, DEDUP(SORT(DISTRIBUTE(BetterElsewhere(Pref_Margin>Config.SliceDistance),HASH(nomatch_id)),nomatch_id,-Pref_Margin,RID,pref_nomatch_id,pref_RID,LOCAL),nomatch_id,LOCAL)) : /*HACK-O-MATIC*/PERSIST(HealthcareNoMatchHeader_Ingest.Filenames(pSrc).lPersistTemplate+pVersion+'::'+'Matches::ToSlice',EXPIRE(HealthcareNoMatchHeader_InternalLinking.Config.PersistExpire));
// 1024x better in new place
  SALT311.MAC_Avoid_SliceOuts(PossibleMatches,nomatch_id1,nomatch_id2,nomatch_id,Pref_nomatch_id,ToSlice,m); // If nomatch_id is slice target - don't use in match
  m1 := IF( Config.DoSliceouts,m,PossibleMatches );
EXPORT Matches := m1(Conf>=MatchThreshold) : /*HACK-O-MATIC*/PERSIST(HealthcareNoMatchHeader_Ingest.Filenames(pSrc).lPersistTemplate+pVersion+'::'+'Matches::Matches',EXPIRE(HealthcareNoMatchHeader_InternalLinking.Config.PersistExpire));
 
//Output the attributes to use for match debugging
EXPORT MatchSample := ENTH(Matches,1000);
EXPORT BorderlineMatchSample := ENTH(Matches(Conf=MatchThreshold),1000);
EXPORT AlmostMatchSample := ENTH(PossibleMatches(Conf<MatchThreshold,Conf>=LowerMatchThreshold),1000);
r := RECORD
  UNSIGNED2 RuleNumber := Matches.Rule;
  STRING Rule := RuleText(Matches.Rule);
  UNSIGNED MatchesFound := COUNT(GROUP);
END;
EXPORT RuleEfficacy := TABLE(Matches,r,Rule,FEW);
r := RECORD
  UNSIGNED2 Conf := Matches.Conf;
  UNSIGNED MatchesFound := COUNT(GROUp);
END;
export ConfidenceBreakdown := table(Matches,r,Conf,few);
Full_Sample_Matches := MatchSample+BorderlineMatchSample+AlmostMatchSample;
export MatchSampleRecords := /*HACK-O-MATIC*/Debug(pSrc,pVersion,ih, s, MatchThreshold).AnnotateMatches(Full_Sample_Matches);
 
//Now actually produce the new file
SHARED ih_init := /*HACK-O-MATIC*/Specificities(pSrc,pVersion,ih).ih_init;
SHARED ih_thin := TABLE(ih_init,{RID,nomatch_id});
  SALT311.utMAC_Patch_Id(ih_thin,nomatch_id,/*HACK-O-MATIC*/BasicMatch(pSrc,pVersion,ih).patch_file,nomatch_id1,nomatch_id2,ihbp); // Perform basic matches
  SALT311.MAC_SliceOut_ByRID(ihbp,RID,nomatch_id,ToSlice,RID,sliced0); // Execute Sliceouts
  sliced := IF( Config.DoSliceouts, sliced0, ihbp); // Config-based ability to remove sliceout
  SALT311.utMAC_Patch_Id(sliced,nomatch_id,Matches,nomatch_id1,nomatch_id2,o); // Join Clusters
SHARED Patched_Infile_thin := o : INDEPENDENT;
  pi1 := JOIN(ih, Patched_Infile_thin, LEFT.RID=RIGHT.RID, TRANSFORM(RECORDOF(ih),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
 
EXPORT Patched_Infile := pi1;
 
//Produced a patched version of match_candidates to get External ADL2 for free.
SALT311.utMAC_Patch_Id(h,nomatch_id,Matches,nomatch_id1,nomatch_id2,o1);
EXPORT Patched_Candidates := o1;
 
// Now compute a file to show which identifiers have changed from input to output
  /*HACK-O-MATIC*/MatchHistory(pSrc,pVersion).id_shift_r note_change(ih_thin le,patched_infile_thin ri) := TRANSFORM
    SELF.RID := le.RID;
    SELF.nomatch_id_before := le.nomatch_id;
    SELF.nomatch_id_after := ri.nomatch_id;
    SELF.change_date := (UNSIGNED6)(STD.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE), '%Y%m%d%H%M%S'));
  END;
EXPORT IdChanges := JOIN(ih_thin,patched_infile_thin,LEFT.RID = RIGHT.RID AND (LEFT.nomatch_id<>RIGHT.nomatch_id),note_change(LEFT,RIGHT));
//Now perform the safety checks
EXPORT MatchesPerformed := COUNT( Matches );
EXPORT SlicesPerformed := COUNT( ToSlice );
EXPORT MatchesPropAssisted := COUNT( Matches(Conf_Prop>0) );
EXPORT MatchesPropRequired := COUNT( Matches(Conf-Conf_Prop<MatchThreshold) );
EXPORT PreIDs := HealthcareNoMatchHeader_InternalLinking.Fields.UIDConsistency(ih_thin); // Export whole consistency module
EXPORT PostIDs := HealthcareNoMatchHeader_InternalLinking.Fields.UIDConsistency(Patched_Infile_thin); // Export whole consistency module
EXPORT PatchingError0 := PreIDs.IdCounts[2].cnt - PostIDs.IdCounts[2].cnt - MatchesPerformed - COUNT(/*HACK-O-MATIC*/BasicMatch(pSrc,pVersion,ih).patch_file)  + SlicesPerformed; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile_thin) - PostIDs.IdCounts[1].Cnt; // Should be zero
END;
