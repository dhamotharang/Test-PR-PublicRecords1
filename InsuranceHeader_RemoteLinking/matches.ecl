// Begin code to perform the matching itself
 
IMPORT SALT37,std;
EXPORT matches(DATASET(layout_HEADER) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
 
SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.DID1 := le.DID;
  SELF.DID2 := ri.DID;
  SELF.RID1 := le.RID;
  SELF.RID2 := ri.RID;
  SELF.DateOverlap := SALT37.fn_ComputeDateOverlap(((UNSIGNED)le.DT_FIRST_SEEN)*100,((UNSIGNED)le.DT_LAST_SEEN)*100,((UNSIGNED)ri.DT_FIRST_SEEN)*100,((UNSIGNED)ri.DT_LAST_SEEN)*100);
  REAL ADDRESS_score_scale := ( le.ADDRESS_weight100 + ri.ADDRESS_weight100 ) / (le.ADDR1_weight100 + ri.ADDR1_weight100 + le.LOCALE_weight100 + ri.LOCALE_weight100); // Scaling factor for this concept
  INTEGER2 ADDRESS_score_pre := MAP( (le.ADDRESS_isnull OR (le.ADDR1_isnull OR le.PRIM_RANGE_isnull AND le.SEC_RANGE_isnull AND le.PRIM_NAME_isnull) AND (le.LOCALE_isnull OR le.CITY_isnull AND le.ST_isnull AND le.ZIP_isnull)) OR (ri.ADDRESS_isnull OR (ri.ADDR1_isnull OR ri.PRIM_RANGE_isnull AND ri.SEC_RANGE_isnull AND ri.PRIM_NAME_isnull) AND (ri.LOCALE_isnull OR ri.CITY_isnull AND ri.ST_isnull AND ri.ZIP_isnull)) => 0,
                        le.ADDRESS = ri.ADDRESS  => le.ADDRESS_weight100,
                        0);
  INTEGER2 SSN_score := MAP(
                        le.SSN_isnull OR ri.SSN_isnull => 0,
                        le.SSN = ri.SSN  => le.SSN_weight100,
                        Config.WithinEditN(le.SSN,le.SSN_len,ri.SSN,ri.SSN_len,1,0) =>  SALT37.fn_fuzzy_specificity(le.SSN_weight100,le.SSN_cnt, le.SSN_e1_cnt,ri.SSN_weight100,ri.SSN_cnt,ri.SSN_e1_cnt),
                        le.SSN_Right4 = ri.SSN_Right4 => SALT37.fn_fuzzy_specificity(le.SSN_weight100,le.SSN_cnt, le.SSN_Right4_cnt,ri.SSN_weight100,ri.SSN_cnt,ri.SSN_Right4_cnt),
                        SALT37.Fn_Fail_Scale(le.SSN_weight100,s.SSN_switch));
  INTEGER2 POLICY_NUMBER_score := MAP(
                        le.POLICY_NUMBER_isnull OR ri.POLICY_NUMBER_isnull => 0,
                        le.AMBEST = (TYPEOF(le.AMBEST))'' OR ri.AMBEST = (TYPEOF(ri.AMBEST))'' OR le.AMBEST <> ri.AMBEST  => 0, // Only valid if the context variable is equal
                        le.POLICY_NUMBER = ri.POLICY_NUMBER  => le.POLICY_NUMBER_weight100,
                        le.POLICY_NUMBER_TrimLeadingZero = ri.POLICY_NUMBER_TrimLeadingZero => SALT37.fn_fuzzy_specificity(le.POLICY_NUMBER_weight100,le.POLICY_NUMBER_cnt, le.POLICY_NUMBER_TrimLeadingZero_cnt,ri.POLICY_NUMBER_weight100,ri.POLICY_NUMBER_cnt,ri.POLICY_NUMBER_TrimLeadingZero_cnt),
                        SALT37.Fn_Fail_Scale(le.POLICY_NUMBER_weight100,s.POLICY_NUMBER_switch));
  INTEGER2 CLAIM_NUMBER_score := MAP(
                        le.CLAIM_NUMBER_isnull OR ri.CLAIM_NUMBER_isnull => 0,
                        le.AMBEST = (TYPEOF(le.AMBEST))'' OR ri.AMBEST = (TYPEOF(ri.AMBEST))'' OR le.AMBEST <> ri.AMBEST  => 0, // Only valid if the context variable is equal
                        le.CLAIM_NUMBER = ri.CLAIM_NUMBER  => le.CLAIM_NUMBER_weight100,
                        SALT37.Fn_Fail_Scale(le.CLAIM_NUMBER_weight100,s.CLAIM_NUMBER_switch));
  INTEGER2 DL_NBR_score := MAP(
                        le.DL_NBR_isnull OR ri.DL_NBR_isnull => 0,
                        le.DL_STATE = (TYPEOF(le.DL_STATE))'' OR ri.DL_STATE = (TYPEOF(ri.DL_STATE))'' OR le.DL_STATE <> ri.DL_STATE  => 0, // Only valid if the context variable is equal
                        le.DL_NBR = ri.DL_NBR  => le.DL_NBR_weight100,
                        le.DL_NBR_TrimLeadingZero = ri.DL_NBR_TrimLeadingZero => SALT37.fn_fuzzy_specificity(le.DL_NBR_weight100,le.DL_NBR_cnt, le.DL_NBR_TrimLeadingZero_cnt,ri.DL_NBR_weight100,ri.DL_NBR_cnt,ri.DL_NBR_TrimLeadingZero_cnt),
                        SALT37.Fn_Fail_Scale(le.DL_NBR_weight100,s.DL_NBR_switch));
  REAL FULLNAME_score_scale := ( le.FULLNAME_weight100 + ri.FULLNAME_weight100 ) / (le.MAINNAME_weight100 + ri.MAINNAME_weight100 + le.SNAME_weight100 + ri.SNAME_weight100); // Scaling factor for this concept
  INTEGER2 FULLNAME_score_pre := MAP( (le.FULLNAME_isnull OR (le.MAINNAME_isnull OR le.FNAME_isnull AND le.MNAME_isnull AND le.LNAME_isnull) AND le.SNAME_isnull) OR (ri.FULLNAME_isnull OR (ri.MAINNAME_isnull OR ri.FNAME_isnull AND ri.MNAME_isnull AND ri.LNAME_isnull) AND ri.SNAME_isnull) OR le.FULLNAME_weight100 = 0 => 0,
                        le.FULLNAME = ri.FULLNAME  => le.FULLNAME_weight100,
                        0);
  REAL MAINNAME_score_scale := ( le.MAINNAME_weight100 + ri.MAINNAME_weight100 ) / (le.FNAME_weight100 + ri.FNAME_weight100 + le.MNAME_weight100 + ri.MNAME_weight100 + le.LNAME_weight100 + ri.LNAME_weight100); // Scaling factor for this concept
  INTEGER2 MAINNAME_score_pre := MAP( (le.MAINNAME_isnull OR le.FNAME_isnull AND le.MNAME_isnull AND le.LNAME_isnull) OR (ri.MAINNAME_isnull OR ri.FNAME_isnull AND ri.MNAME_isnull AND ri.LNAME_isnull) => 0,
                        FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.MAINNAME = ri.MAINNAME  => le.MAINNAME_weight100,
                        SALT37.fn_concept_wordbag_EditN.Match3((SALT37.StrType)ri.FNAME,ri.FNAME_MAINNAME_weight100,true,Config.FNAME_Force,true,IF( LENGTH(TRIM((SALT37.StrType)ri.FNAME))<6, 1, 2),6,ri.FNAME_len,ri.FNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)ri.MNAME,ri.MNAME_MAINNAME_weight100,true,0,true,IF( LENGTH(TRIM((SALT37.StrType)ri.MNAME))<6, 1, 2),6,ri.MNAME_len,ri.MNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)ri.LNAME,ri.LNAME_MAINNAME_weight100,true,0,true,IF( LENGTH(TRIM((SALT37.StrType)ri.LNAME))<6, 1, 2),6,ri.LNAME_len,ri.LNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,le.FNAME_len,le.FNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)le.MNAME,le.MNAME_MAINNAME_weight100,le.MNAME_len,le.MNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)le.LNAME,le.LNAME_MAINNAME_weight100,le.LNAME_len,le.LNAME_MAINNAME_fuzzy_weight100,InsuranceHeader_RemoteLinking.Config.WithinEditN)*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale))*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
  REAL ADDR1_score_scale := ( le.ADDR1_weight100 + ri.ADDR1_weight100 ) / (le.PRIM_RANGE_weight100 + ri.PRIM_RANGE_weight100 + le.SEC_RANGE_weight100 + ri.SEC_RANGE_weight100 + le.PRIM_NAME_weight100 + ri.PRIM_NAME_weight100); // Scaling factor for this concept
  INTEGER2 ADDR1_score_pre := MAP( (le.ADDR1_isnull OR le.PRIM_RANGE_isnull AND le.SEC_RANGE_isnull AND le.PRIM_NAME_isnull) OR (ri.ADDR1_isnull OR ri.PRIM_RANGE_isnull AND ri.SEC_RANGE_isnull AND ri.PRIM_NAME_isnull) => 0,
                        ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.ADDR1 = ri.ADDR1  => le.ADDR1_weight100,
                        0)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 DOB_year_score := MAP ( le.DOB_year_isnull or ri.DOB_year_isnull => 0,
                                  le.DOB_year = ri.DOB_year => le.DOB_year_weight100,
                                  SALT37.Fn_YearMatch(le.DOB_year,ri.DOB_year,12) => le.DOB_year_weight100-358, // assumes even year distribution - so 3x less specific
                                  SALT37.fn_fail_scale(le.DOB_year_weight100,s.DOB_year_switch) );
  INTEGER2 DOB_month_score := MAP ( le.DOB_month_isnull or ri.DOB_month_isnull => 0,
                                  le.DOB_month = ri.DOB_month => le.DOB_month_weight100,
                                  le.DOB_month = ri.DOB_day AND le.DOB_day = ri.DOB_month => le.DOB_month_weight100-100, // Performing M-D switch
                                  le.DOB_Day <= 1 AND le.DOB_Month = 1 OR ri.DOB_Day <= 1 AND ri.DOB_Month = 1 => -200, // Month may be a soft 1 if day is ... 
                                  SALT37.fn_fail_scale(le.DOB_month_weight100,s.DOB_month_switch) );
  INTEGER2 DOB_day_score := MAP ( le.DOB_day_isnull or ri.DOB_day_isnull => 0,
                                  le.DOB_day = ri.DOB_day => le.DOB_day_weight100,
                                  le.DOB_day = ri.DOB_month AND le.DOB_month = ri.DOB_day => le.DOB_day_weight100-100, // Performing M-D switch
                                  le.DOB_Day = 1 OR ri.DOB_Day = 1 => -200, // Treating as a 'soft' 1
                                  SALT37.fn_fail_scale(le.DOB_day_weight100,s.DOB_day_switch) );
  INTEGER2 DOB_score_temp := (DOB_year_score+DOB_month_score+DOB_day_score);
  INTEGER2 DOB_score := MAP( le.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND le.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND le.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) or ri.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND ri.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND ri.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) => 0,
                        DOB_year_score+DOB_month_score+DOB_day_score < 0 or DOB_year_score+DOB_month_score+DOB_day_score<>0 and DOB_year_score+DOB_month_score+DOB_day_score < 300 => SKIP,
                        DOB_year_score < 0 and ABS(le.DOB_year-ri.DOB_year) > 13 => SKIP, // Do not allow full generation mis-match
                        DOB_score_temp);
 
  REAL LOCALE_score_scale := ( le.LOCALE_weight100 + ri.LOCALE_weight100 ) / (le.CITY_weight100 + ri.CITY_weight100 + le.ST_weight100 + ri.ST_weight100 + le.ZIP_weight100 + ri.ZIP_weight100); // Scaling factor for this concept
  INTEGER2 LOCALE_score_pre := MAP( (le.LOCALE_isnull OR le.CITY_isnull AND le.ST_isnull AND le.ZIP_isnull) OR (ri.LOCALE_isnull OR ri.CITY_isnull AND ri.ST_isnull AND ri.ZIP_isnull) => 0,
                        ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.LOCALE = ri.LOCALE  => le.LOCALE_weight100,
                        0)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 PRIM_NAME_score := MAP(
                        le.PRIM_NAME_isnull OR ri.PRIM_NAME_isnull => 0,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.PRIM_NAME = ri.PRIM_NAME  => le.PRIM_NAME_weight100,
                        SALT37.Fn_Fail_Scale(le.PRIM_NAME_weight100,s.PRIM_NAME_switch))*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 LNAME_score := MAP(
                        le.LNAME_isnull OR ri.LNAME_isnull => 0,
                        MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.LNAME = ri.LNAME OR SALT37.HyphenMatch(le.LNAME,ri.LNAME,1)<=2  => MIN(le.LNAME_weight100,ri.LNAME_weight100),
                        LENGTH(TRIM(le.LNAME))>0 and le.LNAME = ri.LNAME[1..LENGTH(TRIM(le.LNAME))] => le.LNAME_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.LNAME))>0 and ri.LNAME = le.LNAME[1..LENGTH(TRIM(ri.LNAME))] => ri.LNAME_weight100, // An initial match - take initial specificity
                        Config.WithinEditN(le.LNAME,le.LNAME_len,ri.LNAME,ri.LNAME_len,2,6) => MAP((6 > le.LNAME_len) AND (6 > ri.LNAME_len) => SALT37.fn_fuzzy_specificity(le.LNAME_weight100,le.LNAME_cnt, le.LNAME_e1_cnt,ri.LNAME_weight100,ri.LNAME_cnt,ri.LNAME_e1_cnt),SALT37.fn_fuzzy_specificity(le.LNAME_weight100,le.LNAME_cnt, le.LNAME_e2_cnt,ri.LNAME_weight100,ri.LNAME_cnt,ri.LNAME_e2_cnt)),
                        SALT37.Fn_Fail_Scale(le.LNAME_weight100,s.LNAME_switch))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
  INTEGER2 PRIM_RANGE_score := MAP(
                        le.PRIM_RANGE_isnull OR ri.PRIM_RANGE_isnull => 0,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.PRIM_RANGE = ri.PRIM_RANGE  => le.PRIM_RANGE_weight100,
                        SALT37.Fn_Fail_Scale(le.PRIM_RANGE_weight100,s.PRIM_RANGE_switch))*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 CITY_score := MAP(
                        le.CITY_isnull OR ri.CITY_isnull => 0,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.CITY = ri.CITY  => le.CITY_weight100,
                        SALT37.Fn_Fail_Scale(le.CITY_weight100,s.CITY_switch))*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 FNAME_score_temp := MAP(
                        le.FNAME_isnull OR ri.FNAME_isnull => 0,
                        MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.FNAME = ri.FNAME  => le.FNAME_weight100,
                        LENGTH(TRIM(le.FNAME))>0 and le.FNAME = ri.FNAME[1..LENGTH(TRIM(le.FNAME))] => le.FNAME_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.FNAME))>0 and ri.FNAME = le.FNAME[1..LENGTH(TRIM(ri.FNAME))] => ri.FNAME_weight100, // An initial match - take initial specificity
                        Config.WithinEditN(le.FNAME,le.FNAME_len,ri.FNAME,ri.FNAME_len,2,6) => MAP((6 > le.FNAME_len) AND (6 > ri.FNAME_len) => SALT37.fn_fuzzy_specificity(le.FNAME_weight100,le.FNAME_cnt, le.FNAME_e1_cnt,ri.FNAME_weight100,ri.FNAME_cnt,ri.FNAME_e1_cnt),SALT37.fn_fuzzy_specificity(le.FNAME_weight100,le.FNAME_cnt, le.FNAME_e2_cnt,ri.FNAME_weight100,ri.FNAME_cnt,ri.FNAME_e2_cnt)),
                        le.FNAME_PreferredName = ri.FNAME_PreferredName => SALT37.fn_fuzzy_specificity(le.FNAME_weight100,le.FNAME_cnt, le.FNAME_PreferredName_cnt,ri.FNAME_weight100,ri.FNAME_cnt,ri.FNAME_PreferredName_cnt),
                        SALT37.Fn_Fail_Scale(le.FNAME_weight100,s.FNAME_switch))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
  INTEGER2 SEC_RANGE_score := MAP(
                        le.SEC_RANGE_isnull OR ri.SEC_RANGE_isnull => 0,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.SEC_RANGE = ri.SEC_RANGE OR SALT37.HyphenMatch(le.SEC_RANGE,ri.SEC_RANGE,1)<=2  => MIN(le.SEC_RANGE_weight100,ri.SEC_RANGE_weight100),
                        SALT37.Fn_Fail_Scale(le.SEC_RANGE_weight100,s.SEC_RANGE_switch))*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 MNAME_score := MAP(
                        le.MNAME_isnull OR ri.MNAME_isnull => 0,
                        MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.MNAME = ri.MNAME  => le.MNAME_weight100,
                        LENGTH(TRIM(le.MNAME))>0 and le.MNAME = ri.MNAME[1..LENGTH(TRIM(le.MNAME))] => le.MNAME_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.MNAME))>0 and ri.MNAME = le.MNAME[1..LENGTH(TRIM(ri.MNAME))] => ri.MNAME_weight100, // An initial match - take initial specificity
                        Config.WithinEditN(le.MNAME,le.MNAME_len,ri.MNAME,ri.MNAME_len,2,6) => MAP((6 > le.MNAME_len) AND (6 > ri.MNAME_len) => SALT37.fn_fuzzy_specificity(le.MNAME_weight100,le.MNAME_cnt, le.MNAME_e1_cnt,ri.MNAME_weight100,ri.MNAME_cnt,ri.MNAME_e1_cnt),SALT37.fn_fuzzy_specificity(le.MNAME_weight100,le.MNAME_cnt, le.MNAME_e2_cnt,ri.MNAME_weight100,ri.MNAME_cnt,ri.MNAME_e2_cnt)),
                        SALT37.Fn_Fail_Scale(le.MNAME_weight100,s.MNAME_switch))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
  INTEGER2 ST_score := MAP(
                        le.ST_isnull OR ri.ST_isnull => 0,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.ST = ri.ST  => le.ST_weight100,
                        SALT37.Fn_Fail_Scale(le.ST_weight100,s.ST_switch))*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 SNAME_score := MAP(
                        le.SNAME_isnull OR ri.SNAME_isnull => 0,
                        FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.SNAME = ri.SNAME  => le.SNAME_weight100,
                        SALT37.Fn_Fail_Scale(le.SNAME_weight100,s.SNAME_switch))*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
  INTEGER2 GENDER_score := MAP(
                        le.GENDER_isnull OR ri.GENDER_isnull => 0,
                        le.GENDER = ri.GENDER  => le.GENDER_weight100,
                        SALT37.Fn_Fail_Scale(le.GENDER_weight100,s.GENDER_switch));
  INTEGER2 DERIVED_GENDER_score := MAP(
                        le.DERIVED_GENDER_isnull OR ri.DERIVED_GENDER_isnull => 0,
                        le.DERIVED_GENDER = ri.DERIVED_GENDER  => le.DERIVED_GENDER_weight100,
                        SALT37.Fn_Fail_Scale(le.DERIVED_GENDER_weight100,s.DERIVED_GENDER_switch));
  INTEGER2 ZIP_score := MAP(
                        le.ZIP_isnull OR ri.ZIP_isnull => 0,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.ZIP = ri.ZIP  => le.ZIP_weight100,
                        SALT37.Fn_Fail_Scale(le.ZIP_weight100,s.ZIP_switch))*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 FNAME_score := IF ( FNAME_score_temp >= Config.FNAME_Force * 100, FNAME_score_temp, SKIP ); // Enforce FORCE parameter
// Compute the score for the concept MAINNAME
  INTEGER2 MAINNAME_score_ext := SALT37.ClipScore(MAX(MAINNAME_score_pre,0) + FNAME_score + MNAME_score + LNAME_score + MAX(FULLNAME_score_pre,0));// Score in surrounding context
  INTEGER2 MAINNAME_score_res := MAX(0,MAINNAME_score_pre); // At least nothing
  INTEGER2 MAINNAME_score := MAINNAME_score_res;
// Compute the score for the concept ADDR1
  INTEGER2 ADDR1_score_ext := SALT37.ClipScore(MAX(ADDR1_score_pre,0) + PRIM_RANGE_score + SEC_RANGE_score + PRIM_NAME_score + MAX(ADDRESS_score_pre,0));// Score in surrounding context
  INTEGER2 ADDR1_score_res := MAX(0,ADDR1_score_pre); // At least nothing
  INTEGER2 ADDR1_score := ADDR1_score_res;
// Compute the score for the concept LOCALE
  INTEGER2 LOCALE_score_ext := SALT37.ClipScore(MAX(LOCALE_score_pre,0) + CITY_score + ST_score + ZIP_score + MAX(ADDRESS_score_pre,0));// Score in surrounding context
  INTEGER2 LOCALE_score_res := MAX(0,LOCALE_score_pre); // At least nothing
  INTEGER2 LOCALE_score := LOCALE_score_res;
// Compute the score for the concept ADDRESS
  INTEGER2 ADDRESS_score_ext := SALT37.ClipScore(MAX(ADDRESS_score_pre,0)+ ADDR1_score + PRIM_RANGE_score + SEC_RANGE_score + PRIM_NAME_score+ LOCALE_score + CITY_score + ST_score + ZIP_score);// Score in surrounding context
  INTEGER2 ADDRESS_score_res := MAX(0,ADDRESS_score_pre); // At least nothing
  INTEGER2 ADDRESS_score := ADDRESS_score_res;
// Compute the score for the concept FULLNAME
  INTEGER2 FULLNAME_score_ext := SALT37.ClipScore(MAX(FULLNAME_score_pre,0)+ MAINNAME_score + FNAME_score + MNAME_score + LNAME_score + SNAME_score);// Score in surrounding context
  INTEGER2 FULLNAME_score_res := MAX(0,FULLNAME_score_pre); // At least nothing
  INTEGER2 FULLNAME_score := IF ( FULLNAME_score_ext > -300 OR (SSN_score > Config.FULLNAME_OR1_SSN_Force*100 AND DOB_score > Config.FULLNAME_OR1_DOB_Force*100 AND FNAME_score > Config.FULLNAME_OR1_FNAME_Force*100) OR (ADDRESS_score > Config.FULLNAME_OR2_ADDRESS_Force*100 AND DOB_score > Config.FULLNAME_OR2_DOB_Force*100 AND FNAME_score > Config.FULLNAME_OR2_FNAME_Force*100),FULLNAME_score_res,SKIP);
  iComp := (IF(ADDRESS_score>0,MAX(ADDRESS_score,IF(ADDR1_score>0,MAX(ADDR1_score,PRIM_RANGE_score + SEC_RANGE_score + PRIM_NAME_score),PRIM_RANGE_score + SEC_RANGE_score + PRIM_NAME_score) + IF(LOCALE_score>0,MAX(LOCALE_score,CITY_score + ST_score + ZIP_score),CITY_score + ST_score + ZIP_score)),IF(ADDR1_score>0,MAX(ADDR1_score,PRIM_RANGE_score + SEC_RANGE_score + PRIM_NAME_score),PRIM_RANGE_score + SEC_RANGE_score + PRIM_NAME_score) + IF(LOCALE_score>0,MAX(LOCALE_score,CITY_score + ST_score + ZIP_score),CITY_score + ST_score + ZIP_score)) + SSN_score + POLICY_NUMBER_score + CLAIM_NUMBER_score + DL_NBR_score + IF(FULLNAME_score>0,MAX(FULLNAME_score,IF(MAINNAME_score>0,MAX(MAINNAME_score,FNAME_score + MNAME_score + LNAME_score),FNAME_score + MNAME_score + LNAME_score) + SNAME_score),IF(MAINNAME_score>0,MAX(MAINNAME_score,FNAME_score + MNAME_score + LNAME_score),FNAME_score + MNAME_score + LNAME_score) + SNAME_score) + DOB_score + GENDER_score + DERIVED_GENDER_score) / 100 + outside;
  SELF.Conf := IF( iComp>=LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
EXPORT RuleText(UNSIGNED n) :=  MAP (
  n = 0 => ':SSN',
  n = 1 => ':POLICY_NUMBER',
  n = 2 => ':CLAIM_NUMBER',
  n = 3 => ':DL_NBR:*',
  n = 11 => ':DOB:ZIP',
  n = 12 => ':DOB:PRIM_NAME',
  n = 13 => ':DOB:LNAME:*',
  n = 17 => ':DOB:PRIM_RANGE:*',
  n = 20 => ':DOB:CITY:*',
  n = 22 => ':DOB:FNAME:SEC_RANGE',
  n = 23 => ':ZIP:PRIM_NAME:*',
  n = 28 => ':ZIP:LNAME:*',
  n = 32 => ':ZIP:PRIM_RANGE:*',
  n = 35 => ':ZIP:CITY:*',
  n = 37 => ':ZIP:FNAME:SEC_RANGE',
  n = 38 => ':PRIM_NAME:LNAME:*',
  n = 42 => ':PRIM_NAME:PRIM_RANGE:*',
  n = 45 => ':PRIM_NAME:CITY:FNAME',
  n = 46 => ':LNAME:PRIM_RANGE:*',
  n = 48 => ':LNAME:CITY:FNAME',
  n = 49 => ':PRIM_RANGE:CITY:FNAME','AttributeFile:'+(STRING)(n-10000));
//Now execute each of the 50 join conditions of which 29 have been optimized into preceding conditions
EXPORT MAC_DoJoins(hfile,trans) := FUNCTIONMACRO
 
//Fixed fields ->:SSN(28)
 
dn0 := hfile(~SSN_isnull);
dn0_deduped := dn0(SSN_weight100>=2700); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.DID > RIGHT.DID
    AND LEFT.SSN = RIGHT.SSN
    AND SALT37.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    ,trans(LEFT,RIGHT,0),UNORDERED,
    ATMOST(LEFT.SSN = RIGHT.SSN,10000),HASH);
 
//Fixed fields ->:POLICY_NUMBER(28)
 
dn1 := hfile(~POLICY_NUMBER_isnull);
dn1_deduped := dn1(POLICY_NUMBER_weight100>=2700); // Use specificity to flag high-dup counts
mj1 := JOIN( dn1_deduped, dn1_deduped, LEFT.DID > RIGHT.DID
    AND LEFT.POLICY_NUMBER = RIGHT.POLICY_NUMBER AND LEFT.AMBEST = RIGHT.AMBEST
    AND SALT37.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    ,trans(LEFT,RIGHT,1),UNORDERED,
    ATMOST(LEFT.POLICY_NUMBER = RIGHT.POLICY_NUMBER AND LEFT.AMBEST = RIGHT.AMBEST,10000),HASH);
 
//Fixed fields ->:CLAIM_NUMBER(28)
 
dn2 := hfile(~CLAIM_NUMBER_isnull);
dn2_deduped := dn2(CLAIM_NUMBER_weight100>=2700); // Use specificity to flag high-dup counts
mj2 := JOIN( dn2_deduped, dn2_deduped, LEFT.DID > RIGHT.DID
    AND LEFT.CLAIM_NUMBER = RIGHT.CLAIM_NUMBER AND LEFT.AMBEST = RIGHT.AMBEST
    AND SALT37.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    ,trans(LEFT,RIGHT,2),UNORDERED,
    ATMOST(LEFT.CLAIM_NUMBER = RIGHT.CLAIM_NUMBER AND LEFT.AMBEST = RIGHT.AMBEST,10000),HASH);
 
//First 1 fields shared with following 7 joins - optimization performed
//Fixed fields ->:DL_NBR(26):DOB(15) also :DL_NBR(26):ZIP(14) also :DL_NBR(26):PRIM_NAME(12) also :DL_NBR(26):LNAME(11) also :DL_NBR(26):PRIM_RANGE(11) also :DL_NBR(26):CITY(10) also :DL_NBR(26):FNAME(9) also :DL_NBR(26):SEC_RANGE(8)
 
dn3 := hfile(~DL_NBR_isnull);
dn3_deduped := dn3(DL_NBR_weight100>=2300); // Use specificity to flag high-dup counts
mj3 := JOIN( dn3_deduped, dn3_deduped, LEFT.DID > RIGHT.DID
    AND LEFT.DL_NBR = RIGHT.DL_NBR AND LEFT.DL_STATE = RIGHT.DL_STATE
    AND SALT37.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    AND (
          LEFT.DOB_year = RIGHT.DOB_year AND LEFT.DOB_month = RIGHT.DOB_month AND LEFT.DOB_day = RIGHT.DOB_day AND (~LEFT.DOB_year_isnull OR ~LEFT.DOB_month_isnull OR ~LEFT.DOB_day_isnull)
    OR    LEFT.ZIP = RIGHT.ZIP AND ~LEFT.ZIP_isnull
    OR    LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND ~LEFT.PRIM_NAME_isnull
    OR    LEFT.LNAME = RIGHT.LNAME AND ~LEFT.LNAME_isnull
    OR    LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE AND ~LEFT.PRIM_RANGE_isnull
    OR    LEFT.CITY = RIGHT.CITY AND ~LEFT.CITY_isnull
    OR    LEFT.FNAME = RIGHT.FNAME AND ~LEFT.FNAME_isnull
    OR    LEFT.SEC_RANGE = RIGHT.SEC_RANGE AND ~LEFT.SEC_RANGE_isnull
        )
    ,trans(LEFT,RIGHT,3),UNORDERED,
    ATMOST(LEFT.DL_NBR = RIGHT.DL_NBR AND LEFT.DL_STATE = RIGHT.DL_STATE,10000),HASH);
mjs0_t := mj0+mj1+mj2+mj3;
SALT37.mac_select_best_matches(mjs0_t,RID1,RID2,o0);
mjs0 := o0 : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::mj::0',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
//Fixed fields ->:DOB(15):ZIP(14)
 
dn11 := hfile((~DOB_year_isnull OR ~DOB_month_isnull OR ~DOB_day_isnull) AND ~ZIP_isnull);
dn11_deduped := dn11(DOB_year_weight100 + DOB_month_weight100 + DOB_day_weight100 + ZIP_weight100>=2700); // Use specificity to flag high-dup counts
mj11 := JOIN( dn11_deduped, dn11_deduped, LEFT.DID > RIGHT.DID
    AND LEFT.DOB_year = RIGHT.DOB_year AND LEFT.DOB_month = RIGHT.DOB_month AND LEFT.DOB_day = RIGHT.DOB_day
    AND LEFT.ZIP = RIGHT.ZIP
    AND SALT37.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    ,trans(LEFT,RIGHT,11),UNORDERED,
    ATMOST(LEFT.DOB_year = RIGHT.DOB_year AND LEFT.DOB_month = RIGHT.DOB_month AND LEFT.DOB_day = RIGHT.DOB_day
      AND LEFT.ZIP = RIGHT.ZIP,10000),HASH);
 
//Fixed fields ->:DOB(15):PRIM_NAME(12)
 
dn12 := hfile((~DOB_year_isnull OR ~DOB_month_isnull OR ~DOB_day_isnull) AND ~PRIM_NAME_isnull);
dn12_deduped := dn12(DOB_year_weight100 + DOB_month_weight100 + DOB_day_weight100 + PRIM_NAME_weight100>=2700); // Use specificity to flag high-dup counts
mj12 := JOIN( dn12_deduped, dn12_deduped, LEFT.DID > RIGHT.DID
    AND LEFT.DOB_year = RIGHT.DOB_year AND LEFT.DOB_month = RIGHT.DOB_month AND LEFT.DOB_day = RIGHT.DOB_day
    AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME
    AND SALT37.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    ,trans(LEFT,RIGHT,12),UNORDERED,
    ATMOST(LEFT.DOB_year = RIGHT.DOB_year AND LEFT.DOB_month = RIGHT.DOB_month AND LEFT.DOB_day = RIGHT.DOB_day
      AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME,10000),HASH);
 
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:DOB(15):LNAME(11):PRIM_RANGE(11) also :DOB(15):LNAME(11):CITY(10) also :DOB(15):LNAME(11):FNAME(9) also :DOB(15):LNAME(11):SEC_RANGE(8)
 
dn13 := hfile((~DOB_year_isnull OR ~DOB_month_isnull OR ~DOB_day_isnull) AND ~LNAME_isnull);
dn13_deduped := dn13(DOB_year_weight100 + DOB_month_weight100 + DOB_day_weight100 + LNAME_weight100>=2300); // Use specificity to flag high-dup counts
mj13 := JOIN( dn13_deduped, dn13_deduped, LEFT.DID > RIGHT.DID
    AND LEFT.DOB_year = RIGHT.DOB_year AND LEFT.DOB_month = RIGHT.DOB_month AND LEFT.DOB_day = RIGHT.DOB_day
    AND LEFT.LNAME = RIGHT.LNAME
    AND SALT37.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    AND (
          LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE AND ~LEFT.PRIM_RANGE_isnull
    OR    LEFT.CITY = RIGHT.CITY AND ~LEFT.CITY_isnull
    OR    LEFT.FNAME = RIGHT.FNAME AND ~LEFT.FNAME_isnull
    OR    LEFT.SEC_RANGE = RIGHT.SEC_RANGE AND ~LEFT.SEC_RANGE_isnull
        )
    ,trans(LEFT,RIGHT,13),UNORDERED,
    ATMOST(LEFT.DOB_year = RIGHT.DOB_year AND LEFT.DOB_month = RIGHT.DOB_month AND LEFT.DOB_day = RIGHT.DOB_day
      AND LEFT.LNAME = RIGHT.LNAME,10000),HASH);
mjs1_t := mj11+mj12+mj13;
SALT37.mac_select_best_matches(mjs1_t,RID1,RID2,o1);
mjs1 := o1 : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::mj::1',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:DOB(15):PRIM_RANGE(11):CITY(10) also :DOB(15):PRIM_RANGE(11):FNAME(9) also :DOB(15):PRIM_RANGE(11):SEC_RANGE(8)
 
dn17 := hfile((~DOB_year_isnull OR ~DOB_month_isnull OR ~DOB_day_isnull) AND ~PRIM_RANGE_isnull);
dn17_deduped := dn17(DOB_year_weight100 + DOB_month_weight100 + DOB_day_weight100 + PRIM_RANGE_weight100>=2300); // Use specificity to flag high-dup counts
mj17 := JOIN( dn17_deduped, dn17_deduped, LEFT.DID > RIGHT.DID
    AND LEFT.DOB_year = RIGHT.DOB_year AND LEFT.DOB_month = RIGHT.DOB_month AND LEFT.DOB_day = RIGHT.DOB_day
    AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE
    AND SALT37.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    AND (
          LEFT.CITY = RIGHT.CITY AND ~LEFT.CITY_isnull
    OR    LEFT.FNAME = RIGHT.FNAME AND ~LEFT.FNAME_isnull
    OR    LEFT.SEC_RANGE = RIGHT.SEC_RANGE AND ~LEFT.SEC_RANGE_isnull
        )
    ,trans(LEFT,RIGHT,17),UNORDERED,
    ATMOST(LEFT.DOB_year = RIGHT.DOB_year AND LEFT.DOB_month = RIGHT.DOB_month AND LEFT.DOB_day = RIGHT.DOB_day
      AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE,10000),HASH);
 
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:DOB(15):CITY(10):FNAME(9) also :DOB(15):CITY(10):SEC_RANGE(8)
 
dn20 := hfile((~DOB_year_isnull OR ~DOB_month_isnull OR ~DOB_day_isnull) AND ~CITY_isnull);
dn20_deduped := dn20(DOB_year_weight100 + DOB_month_weight100 + DOB_day_weight100 + CITY_weight100>=2300); // Use specificity to flag high-dup counts
mj20 := JOIN( dn20_deduped, dn20_deduped, LEFT.DID > RIGHT.DID
    AND LEFT.DOB_year = RIGHT.DOB_year AND LEFT.DOB_month = RIGHT.DOB_month AND LEFT.DOB_day = RIGHT.DOB_day
    AND LEFT.CITY = RIGHT.CITY
    AND SALT37.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    AND (
          LEFT.FNAME = RIGHT.FNAME AND ~LEFT.FNAME_isnull
    OR    LEFT.SEC_RANGE = RIGHT.SEC_RANGE AND ~LEFT.SEC_RANGE_isnull
        )
    ,trans(LEFT,RIGHT,20),UNORDERED,
    ATMOST(LEFT.DOB_year = RIGHT.DOB_year AND LEFT.DOB_month = RIGHT.DOB_month AND LEFT.DOB_day = RIGHT.DOB_day
      AND LEFT.CITY = RIGHT.CITY,10000),HASH);
mjs2_t := mj17+mj20;
SALT37.mac_select_best_matches(mjs2_t,RID1,RID2,o2);
mjs2 := o2 : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::mj::2',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
//Fixed fields ->:DOB(15):FNAME(9):SEC_RANGE(8)
 
dn22 := hfile((~DOB_year_isnull OR ~DOB_month_isnull OR ~DOB_day_isnull) AND ~FNAME_isnull AND ~SEC_RANGE_isnull);
dn22_deduped := dn22(DOB_year_weight100 + DOB_month_weight100 + DOB_day_weight100 + FNAME_weight100 + SEC_RANGE_weight100>=2700); // Use specificity to flag high-dup counts
mj22 := JOIN( dn22_deduped, dn22_deduped, LEFT.DID > RIGHT.DID
    AND LEFT.DOB_year = RIGHT.DOB_year AND LEFT.DOB_month = RIGHT.DOB_month AND LEFT.DOB_day = RIGHT.DOB_day
    AND LEFT.FNAME = RIGHT.FNAME
    AND LEFT.SEC_RANGE = RIGHT.SEC_RANGE
    AND SALT37.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    ,trans(LEFT,RIGHT,22),UNORDERED,
    ATMOST(LEFT.DOB_year = RIGHT.DOB_year AND LEFT.DOB_month = RIGHT.DOB_month AND LEFT.DOB_day = RIGHT.DOB_day
      AND LEFT.FNAME = RIGHT.FNAME
      AND LEFT.SEC_RANGE = RIGHT.SEC_RANGE,10000),HASH);
 
//First 2 fields shared with following 4 joins - optimization performed
//Fixed fields ->:ZIP(14):PRIM_NAME(12):LNAME(11) also :ZIP(14):PRIM_NAME(12):PRIM_RANGE(11) also :ZIP(14):PRIM_NAME(12):CITY(10) also :ZIP(14):PRIM_NAME(12):FNAME(9) also :ZIP(14):PRIM_NAME(12):SEC_RANGE(8)
 
dn23 := hfile(~ZIP_isnull AND ~PRIM_NAME_isnull);
dn23_deduped := dn23(ZIP_weight100 + PRIM_NAME_weight100>=2300); // Use specificity to flag high-dup counts
mj23 := JOIN( dn23_deduped, dn23_deduped, LEFT.DID > RIGHT.DID
    AND LEFT.ZIP = RIGHT.ZIP
    AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME
    AND SALT37.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    AND (
          LEFT.LNAME = RIGHT.LNAME AND ~LEFT.LNAME_isnull
    OR    LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE AND ~LEFT.PRIM_RANGE_isnull
    OR    LEFT.CITY = RIGHT.CITY AND ~LEFT.CITY_isnull
    OR    LEFT.FNAME = RIGHT.FNAME AND ~LEFT.FNAME_isnull
    OR    LEFT.SEC_RANGE = RIGHT.SEC_RANGE AND ~LEFT.SEC_RANGE_isnull
        )
    ,trans(LEFT,RIGHT,23),UNORDERED,
    ATMOST(LEFT.ZIP = RIGHT.ZIP
      AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME,10000),HASH);
mjs3_t := mj22+mj23;
SALT37.mac_select_best_matches(mjs3_t,RID1,RID2,o3);
mjs3 := o3 : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::mj::3',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:ZIP(14):LNAME(11):PRIM_RANGE(11) also :ZIP(14):LNAME(11):CITY(10) also :ZIP(14):LNAME(11):FNAME(9) also :ZIP(14):LNAME(11):SEC_RANGE(8)
 
dn28 := hfile(~ZIP_isnull AND ~LNAME_isnull);
dn28_deduped := dn28(ZIP_weight100 + LNAME_weight100>=2300); // Use specificity to flag high-dup counts
mj28 := JOIN( dn28_deduped, dn28_deduped, LEFT.DID > RIGHT.DID
    AND LEFT.ZIP = RIGHT.ZIP
    AND LEFT.LNAME = RIGHT.LNAME
    AND SALT37.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    AND (
          LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE AND ~LEFT.PRIM_RANGE_isnull
    OR    LEFT.CITY = RIGHT.CITY AND ~LEFT.CITY_isnull
    OR    LEFT.FNAME = RIGHT.FNAME AND ~LEFT.FNAME_isnull
    OR    LEFT.SEC_RANGE = RIGHT.SEC_RANGE AND ~LEFT.SEC_RANGE_isnull
        )
    ,trans(LEFT,RIGHT,28),UNORDERED,
    ATMOST(LEFT.ZIP = RIGHT.ZIP
      AND LEFT.LNAME = RIGHT.LNAME,10000),HASH);
 
//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:ZIP(14):PRIM_RANGE(11):CITY(10) also :ZIP(14):PRIM_RANGE(11):FNAME(9) also :ZIP(14):PRIM_RANGE(11):SEC_RANGE(8)
 
dn32 := hfile(~ZIP_isnull AND ~PRIM_RANGE_isnull);
dn32_deduped := dn32(ZIP_weight100 + PRIM_RANGE_weight100>=2300); // Use specificity to flag high-dup counts
mj32 := JOIN( dn32_deduped, dn32_deduped, LEFT.DID > RIGHT.DID
    AND LEFT.ZIP = RIGHT.ZIP
    AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE
    AND SALT37.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    AND (
          LEFT.CITY = RIGHT.CITY AND ~LEFT.CITY_isnull
    OR    LEFT.FNAME = RIGHT.FNAME AND ~LEFT.FNAME_isnull
    OR    LEFT.SEC_RANGE = RIGHT.SEC_RANGE AND ~LEFT.SEC_RANGE_isnull
        )
    ,trans(LEFT,RIGHT,32),UNORDERED,
    ATMOST(LEFT.ZIP = RIGHT.ZIP
      AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE,10000),HASH);
mjs4_t := mj28+mj32;
SALT37.mac_select_best_matches(mjs4_t,RID1,RID2,o4);
mjs4 := o4 : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::mj::4',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:ZIP(14):CITY(10):FNAME(9) also :ZIP(14):CITY(10):SEC_RANGE(8)
 
dn35 := hfile(~ZIP_isnull AND ~CITY_isnull);
dn35_deduped := dn35(ZIP_weight100 + CITY_weight100>=2300); // Use specificity to flag high-dup counts
mj35 := JOIN( dn35_deduped, dn35_deduped, LEFT.DID > RIGHT.DID
    AND LEFT.ZIP = RIGHT.ZIP
    AND LEFT.CITY = RIGHT.CITY
    AND SALT37.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    AND (
          LEFT.FNAME = RIGHT.FNAME AND ~LEFT.FNAME_isnull
    OR    LEFT.SEC_RANGE = RIGHT.SEC_RANGE AND ~LEFT.SEC_RANGE_isnull
        )
    ,trans(LEFT,RIGHT,35),UNORDERED,
    ATMOST(LEFT.ZIP = RIGHT.ZIP
      AND LEFT.CITY = RIGHT.CITY,10000),HASH);
 
//Fixed fields ->:ZIP(14):FNAME(9):SEC_RANGE(8)
 
dn37 := hfile(~ZIP_isnull AND ~FNAME_isnull AND ~SEC_RANGE_isnull);
dn37_deduped := dn37(ZIP_weight100 + FNAME_weight100 + SEC_RANGE_weight100>=2700); // Use specificity to flag high-dup counts
mj37 := JOIN( dn37_deduped, dn37_deduped, LEFT.DID > RIGHT.DID
    AND LEFT.ZIP = RIGHT.ZIP
    AND LEFT.FNAME = RIGHT.FNAME
    AND LEFT.SEC_RANGE = RIGHT.SEC_RANGE
    AND SALT37.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    ,trans(LEFT,RIGHT,37),UNORDERED,
    ATMOST(LEFT.ZIP = RIGHT.ZIP
      AND LEFT.FNAME = RIGHT.FNAME
      AND LEFT.SEC_RANGE = RIGHT.SEC_RANGE,10000),HASH);
 
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:PRIM_NAME(12):LNAME(11):PRIM_RANGE(11) also :PRIM_NAME(12):LNAME(11):CITY(10) also :PRIM_NAME(12):LNAME(11):FNAME(9) also :PRIM_NAME(12):LNAME(11):SEC_RANGE(8)
 
dn38 := hfile(~PRIM_NAME_isnull AND ~LNAME_isnull);
dn38_deduped := dn38(PRIM_NAME_weight100 + LNAME_weight100>=2300); // Use specificity to flag high-dup counts
mj38 := JOIN( dn38_deduped, dn38_deduped, LEFT.DID > RIGHT.DID
    AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME
    AND LEFT.LNAME = RIGHT.LNAME
    AND SALT37.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    AND (
          LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE AND ~LEFT.PRIM_RANGE_isnull
    OR    LEFT.CITY = RIGHT.CITY AND ~LEFT.CITY_isnull
    OR    LEFT.FNAME = RIGHT.FNAME AND ~LEFT.FNAME_isnull
    OR    LEFT.SEC_RANGE = RIGHT.SEC_RANGE AND ~LEFT.SEC_RANGE_isnull
        )
    ,trans(LEFT,RIGHT,38),UNORDERED,
    ATMOST(LEFT.PRIM_NAME = RIGHT.PRIM_NAME
      AND LEFT.LNAME = RIGHT.LNAME,10000),HASH);
mjs5_t := mj35+mj37+mj38;
SALT37.mac_select_best_matches(mjs5_t,RID1,RID2,o5);
mjs5 := o5 : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::mj::5',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:PRIM_NAME(12):PRIM_RANGE(11):CITY(10) also :PRIM_NAME(12):PRIM_RANGE(11):FNAME(9) also :PRIM_NAME(12):PRIM_RANGE(11):SEC_RANGE(8)
 
dn42 := hfile(~PRIM_NAME_isnull AND ~PRIM_RANGE_isnull);
dn42_deduped := dn42(PRIM_NAME_weight100 + PRIM_RANGE_weight100>=2300); // Use specificity to flag high-dup counts
mj42 := JOIN( dn42_deduped, dn42_deduped, LEFT.DID > RIGHT.DID
    AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME
    AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE
    AND SALT37.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    AND (
          LEFT.CITY = RIGHT.CITY AND ~LEFT.CITY_isnull
    OR    LEFT.FNAME = RIGHT.FNAME AND ~LEFT.FNAME_isnull
    OR    LEFT.SEC_RANGE = RIGHT.SEC_RANGE AND ~LEFT.SEC_RANGE_isnull
        )
    ,trans(LEFT,RIGHT,42),UNORDERED,
    ATMOST(LEFT.PRIM_NAME = RIGHT.PRIM_NAME
      AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE,10000),HASH);
 
//Fixed fields ->:PRIM_NAME(12):CITY(10):FNAME(9)
 
dn45 := hfile(~PRIM_NAME_isnull AND ~CITY_isnull AND ~FNAME_isnull);
dn45_deduped := dn45(PRIM_NAME_weight100 + CITY_weight100 + FNAME_weight100>=2700); // Use specificity to flag high-dup counts
mj45 := JOIN( dn45_deduped, dn45_deduped, LEFT.DID > RIGHT.DID
    AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME
    AND LEFT.CITY = RIGHT.CITY
    AND LEFT.FNAME = RIGHT.FNAME
    AND SALT37.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    ,trans(LEFT,RIGHT,45),UNORDERED,
    ATMOST(LEFT.PRIM_NAME = RIGHT.PRIM_NAME
      AND LEFT.CITY = RIGHT.CITY
      AND LEFT.FNAME = RIGHT.FNAME,10000),HASH);
 
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:LNAME(11):PRIM_RANGE(11):CITY(10) also :LNAME(11):PRIM_RANGE(11):FNAME(9)
 
dn46 := hfile(~LNAME_isnull AND ~PRIM_RANGE_isnull);
dn46_deduped := dn46(LNAME_weight100 + PRIM_RANGE_weight100>=2300); // Use specificity to flag high-dup counts
mj46 := JOIN( dn46_deduped, dn46_deduped, LEFT.DID > RIGHT.DID
    AND LEFT.LNAME = RIGHT.LNAME
    AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE
    AND SALT37.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    AND (
          LEFT.CITY = RIGHT.CITY AND ~LEFT.CITY_isnull
    OR    LEFT.FNAME = RIGHT.FNAME AND ~LEFT.FNAME_isnull
        )
    ,trans(LEFT,RIGHT,46),UNORDERED,
    ATMOST(LEFT.LNAME = RIGHT.LNAME
      AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE,10000),HASH);
mjs6_t := mj42+mj45+mj46;
SALT37.mac_select_best_matches(mjs6_t,RID1,RID2,o6);
mjs6 := o6 : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::mj::6',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
//Fixed fields ->:LNAME(11):CITY(10):FNAME(9)
 
dn48 := hfile(~LNAME_isnull AND ~CITY_isnull AND ~FNAME_isnull);
dn48_deduped := dn48(LNAME_weight100 + CITY_weight100 + FNAME_weight100>=2700); // Use specificity to flag high-dup counts
mj48 := JOIN( dn48_deduped, dn48_deduped, LEFT.DID > RIGHT.DID
    AND LEFT.LNAME = RIGHT.LNAME
    AND LEFT.CITY = RIGHT.CITY
    AND LEFT.FNAME = RIGHT.FNAME
    AND SALT37.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    ,trans(LEFT,RIGHT,48),UNORDERED,
    ATMOST(LEFT.LNAME = RIGHT.LNAME
      AND LEFT.CITY = RIGHT.CITY
      AND LEFT.FNAME = RIGHT.FNAME,10000),HASH);
 
//Fixed fields ->:PRIM_RANGE(11):CITY(10):FNAME(9)
 
dn49 := hfile(~PRIM_RANGE_isnull AND ~CITY_isnull AND ~FNAME_isnull);
dn49_deduped := dn49(PRIM_RANGE_weight100 + CITY_weight100 + FNAME_weight100>=2700); // Use specificity to flag high-dup counts
mj49 := JOIN( dn49_deduped, dn49_deduped, LEFT.DID > RIGHT.DID
    AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE
    AND LEFT.CITY = RIGHT.CITY
    AND LEFT.FNAME = RIGHT.FNAME
    AND SALT37.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    ,trans(LEFT,RIGHT,49),UNORDERED,
    ATMOST(LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE
      AND LEFT.CITY = RIGHT.CITY
      AND LEFT.FNAME = RIGHT.FNAME,10000),HASH);
last_mjs_t :=mj48+mj49;
SALT37.mac_select_best_matches(last_mjs_t,RID1,RID2,o);
mjs7 := o : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::mj::7',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
RETURN  mjs0+ mjs1+ mjs2+ mjs3+ mjs4+ mjs5+ mjs6+ mjs7;
ENDMACRO;
SHARED all_mjs := MAC_DoJoins(h,match_join);
EXPORT All_Matches := all_mjs : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::all_m',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire)); // To by used by RID and DID
SALT37.mac_avoid_transitives(All_Matches,DID1,DID2,Conf,DateOverlap,Rule,o);
EXPORT PossibleMatches := o : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::mt',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
SALT37.mac_get_BestPerRecord( All_Matches,RID1,DID1,RID2,DID2,o );
EXPORT BestPerRecord := o : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::mr',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
//Now lets see if any slice-outs are needed
too_big := TABLE(h,{DID, InCluster := COUNT(GROUP)},DID,LOCAL)(InCluster>1000); // DID that are too big for sliceout
h_ok := JOIN(h,too_big,LEFT.DID=RIGHT.DID,TRANSFORM(LEFT),LOCAL,LEFT ONLY);
SHARED in_matches := JOIN(h_ok,h_ok,LEFT.DID=RIGHT.DID AND (>STRING6<)LEFT.RID<>(>STRING6<)RIGHT.RID,match_join(LEFT,RIGHT,9999),LOCAL,UNORDERED);
SALT37.mac_cluster_breadth(in_matches,RID1,RID2,DID1,o);
SHARED in_matches1 := o;
missed_linkages := JOIN(in_matches1,Specificities(ih).ClusterSizes(InCluster>1),LEFT.DID1=RIGHT.DID,RIGHT ONLY,LOCAL);
missed_linkages1 := JOIN(h,missed_linkages,LEFT.DID=RIGHT.DID,TRANSFORM(RECORDOF(missed_linkages),SELF.DID1:=RIGHT.DID,SELF.RID1:=LEFT.RID,SELF:=RIGHT),LOCAL);
o1 := JOIN(in_matches1,Specificities(ih).ClusterSizes,LEFT.DID1=RIGHT.DID,LOCAL);
EXPORT ClusterLinkages := o1 + missed_linkages1 : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::clu',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
EXPORT ClusterOutcasts := ClusterLinkages(InCluster>1,Closest<MatchThreshold);
//Now find those outcasts that are liked elsewhere ...
Pref_Layout := RECORD
  SALT37.UIDType RID;  //Outcast
  SALT37.UIDType DID;  // Outcase within
  INTEGER2 Closest; // Best present link
  SALT37.UIDType Pref_RID; // Prefers this record
  SALT37.UIDType Pref_DID; // Prefers this cluster
  INTEGER2 Conf; // Score of new link
  integer2 Conf_Prop; // Prop of new link
  UNSIGNED2 Pref_Margin; // Extent to which pref is preferred
END;
Pref_Layout note_better(ClusterOutcasts le, BestPerRecord ri) := TRANSFORM
  self.RID := le.RID1;
  self.DID := le.DID1;
  self.Closest := le.Closest;
  self.Pref_RID := ri.RID2;
  self.Pref_DID := ri.DID2;
  self.Pref_Margin := ri.Conf-ri.Conf_Prop-le.Closest; // Compute winning margin
  SELF := ri;
END;
// Find those records happier in another cluster
CurrentJumpers := JOIN(BestPerRecord,ClusterOutcasts,LEFT.RID1=RIGHT.RID1 AND RIGHT.closest<LEFT.conf-LEFT.conf_prop,note_better(RIGHT,LEFT),HASH);
// No need for record to jump ship if clusters are joinable
WillJoin1 := JOIN(CurrentJumpers,All_Matches(Conf>=MatchThreshold),LEFT.DID=RIGHT.DID1 AND LEFT.Pref_DID=RIGHT.DID2,TRANSFORM(LEFT),LEFT ONLY,HASH);
WillJoin2 := JOIN(WillJoin1,All_Matches(Conf>=MatchThreshold),LEFT.DID=RIGHT.DID2 AND LEFT.Pref_DID=RIGHT.DID1,TRANSFORM(LEFT),LEFT ONLY,HASH);
WillJoin3 := JOIN(WillJoin2,match_candidates(ih).hasbuddies,LEFT.RID=RIGHT.RID,TRANSFORM(LEFT),LEFT ONLY,HASH); // Duplicated records cannot be sliced
EXPORT BetterElsewhere := WillJoin3;
EXPORT ToSlice := IF ( Config.DoSliceouts, DEDUP(SORT(DISTRIBUTE(BetterElsewhere(Pref_Margin>18),HASH(DID)),DID,-Pref_Margin,LOCAL),DID,LOCAL)) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::Matches::ToSlice',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
// 262144x better in new place
  SALT37.MAC_Avoid_SliceOuts(PossibleMatches,DID1,DID2,DID,Pref_DID,ToSlice,m); // If DID is slice target - don't use in match
  m1 := IF( Config.DoSliceouts,m,PossibleMatches );
EXPORT Matches := m1(Conf>=MatchThreshold) : PERSIST('~temp::DID::InsuranceHeader_RemoteLinking::Matches::Matches',EXPIRE(InsuranceHeader_RemoteLinking.Config.PersistExpire));
 
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
export MatchSampleRecords := Debug(ih,s,MatchThreshold).AnnotateMatches(Full_Sample_Matches);
 
//Now actually produce the new file
SHARED ih_init := Specificities(ih).ih_init;
SHARED ih_thin := TABLE(ih_init,{RID,DID});
  SALT37.utMAC_Patch_Id(ih_thin,DID,BasicMatch(ih).patch_file,DID1,DID2,ihbp); // Perform basic matches
  SALT37.MAC_SliceOut_ByRID(ihbp,RID,DID,ToSlice,RID,sliced0); // Execute Sliceouts
  sliced := IF( Config.DoSliceouts, sliced0, ihbp); // Config-based ability to remove sliceout
  SALT37.utMAC_Patch_Id(sliced,DID,Matches,DID1,DID2,o); // Join Clusters
SHARED Patched_Infile_thin := o : INDEPENDENT;
  pi1 := JOIN(ih, Patched_Infile_thin, LEFT.RID=RIGHT.RID, TRANSFORM(RECORDOF(ih),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
 
EXPORT Patched_Infile := pi1;
 
//Produced a patched version of match_candidates to get External ADL2 for free.
SALT37.utMAC_Patch_Id(h,DID,Matches,DID1,DID2,o1);
EXPORT Patched_Candidates := o1;
 
// Now compute a file to show which identifiers have changed from input to output
  MatchHistory.id_shift_r note_change(ih_thin le,patched_infile_thin ri) := TRANSFORM
    SELF.RID := le.RID;
    SELF.DID_before := le.DID;
    SELF.DID_after := ri.DID;
    SELF.change_date := (UNSIGNED6)(STD.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE), '%Y%m%d%H%M%S'));
  END;
EXPORT IdChanges := JOIN(ih_thin,patched_infile_thin,LEFT.RID = RIGHT.RID AND (LEFT.DID<>RIGHT.DID),note_change(LEFT,RIGHT));
//Now perform the safety checks
EXPORT MatchesPerformed := COUNT( Matches );
EXPORT SlicesPerformed := COUNT( ToSlice );
EXPORT MatchesPropAssisted := COUNT( Matches(Conf_Prop>0) );
EXPORT MatchesPropRequired := COUNT( Matches(Conf-Conf_Prop<MatchThreshold) );
EXPORT PreIDs := InsuranceHeader_RemoteLinking.Fields.UIDConsistency(ih_thin); // Export whole consistency module
EXPORT PostIDs := InsuranceHeader_RemoteLinking.Fields.UIDConsistency(Patched_Infile_thin); // Export whole consistency module
EXPORT PatchingError0 := PreIDs.IdCounts[2].cnt - PostIDs.IdCounts[2].cnt - MatchesPerformed - COUNT(BasicMatch(ih).patch_file)  + SlicesPerformed; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile_thin) - PostIDs.IdCounts[1].Cnt; // Should be zero
END;
