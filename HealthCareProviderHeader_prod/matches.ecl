// Begin code to perform the matching itself

IMPORT SALT27,ut,std;
EXPORT matches(DATASET(layout_HealthProvider) ih,UNSIGNED MatchThreshold = 42) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];

SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED2 c,UNSIGNED outside=0) := TRANSFORM
SELF.Rule := c;
SELF.LNPID1 := le.LNPID;
SELF.LNPID2 := ri.LNPID;
SELF.RID1 := le.RID;
SELF.RID2 := ri.RID;
SELF.DateOverlap := SALT27.fn_ComputeDateOverlap(((UNSIGNED)le.DT_FIRST_SEEN)*100,((UNSIGNED)le.DT_LAST_SEEN)*100,((UNSIGNED)ri.DT_FIRST_SEEN)*100,((UNSIGNED)ri.DT_LAST_SEEN)*100);
INTEGER2 VENDOR_ID_score := MAP( le.VENDOR_ID_isnull OR ri.VENDOR_ID_isnull => 0,
le.SRC <> ri.SRC => 0, // Only valid if the context variable is equal
le.VENDOR_ID = ri.VENDOR_ID  => le.VENDOR_ID_weight100,
0 /* switch0 */);
INTEGER2 DID_score_temp := MAP( le.DID_isnull OR ri.DID_isnull => 0,
le.DID = ri.DID  => le.DID_weight100,
0 /* switch0 */);
INTEGER2 NPI_NUMBER_score := MAP( le.NPI_NUMBER_isnull OR ri.NPI_NUMBER_isnull => 0,
le.NPI_NUMBER = ri.NPI_NUMBER  => le.NPI_NUMBER_weight100,
SALT27.Fn_Fail_Scale(le.NPI_NUMBER_weight100,s.NPI_NUMBER_switch));
INTEGER2 DEA_NUMBER_score := MAP( le.DEA_NUMBER_isnull OR ri.DEA_NUMBER_isnull => 0,
le.DEA_NUMBER = ri.DEA_NUMBER  => le.DEA_NUMBER_weight100,
SALT27.Fn_Fail_Scale(le.DEA_NUMBER_weight100,s.DEA_NUMBER_switch));
REAL FULLNAME_score_scale := ( le.FULLNAME_weight100 + ri.FULLNAME_weight100 ) / (le.MAINNAME_weight100 + ri.MAINNAME_weight100 + le.SNAME_weight100 + ri.SNAME_weight100); // Scaling factor for this concept
INTEGER2 FULLNAME_score_pre := MAP( (le.FULLNAME_isnull OR (le.MAINNAME_isnull OR le.FNAME_isnull AND le.MNAME_isnull AND le.LNAME_isnull) AND le.SNAME_isnull) OR (ri.FULLNAME_isnull OR (ri.MAINNAME_isnull OR ri.FNAME_isnull AND ri.MNAME_isnull AND ri.LNAME_isnull) AND ri.SNAME_isnull) OR le.FULLNAME_weight100 = 0 => 0,
le.FULLNAME = ri.FULLNAME  => le.FULLNAME_weight100,
0);
INTEGER2 LIC_NBR_score := MAP( le.LIC_NBR_isnull OR ri.LIC_NBR_isnull => 0,
le.LIC_STATE <> ri.LIC_STATE => 0, // Only valid if the context variable is equal
le.LIC_NBR = ri.LIC_NBR  => le.LIC_NBR_weight100,
le.LIC_NBR_CleanLic = ri.LIC_NBR_CleanLic => SALT27.fn_fuzzy_specificity(le.LIC_NBR_weight100,le.LIC_NBR_cnt, le.LIC_NBR_CleanLic_cnt,ri.LIC_NBR_weight100,ri.LIC_NBR_cnt,ri.LIC_NBR_CleanLic_cnt),
le.LIC_NBR_LicNumeric = ri.LIC_NBR_LicNumeric => SALT27.fn_fuzzy_specificity(le.LIC_NBR_weight100,le.LIC_NBR_cnt, le.LIC_NBR_LicNumeric_cnt,ri.LIC_NBR_weight100,ri.LIC_NBR_cnt,ri.LIC_NBR_LicNumeric_cnt),
0 /* switch0 */);
INTEGER2 UPIN_score := MAP( le.UPIN_isnull OR ri.UPIN_isnull => 0,
le.UPIN = ri.UPIN  => le.UPIN_weight100,
0 /* switch0 */);
REAL ADDRESS_score_scale := ( le.ADDRESS_weight100 + ri.ADDRESS_weight100 ) / (le.ADDR_weight100 + ri.ADDR_weight100 + le.LOCALE_weight100 + ri.LOCALE_weight100); // Scaling factor for this concept
INTEGER2 ADDRESS_score_pre := MAP( (le.ADDRESS_isnull OR (le.ADDR_isnull OR le.PRIM_RANGE_isnull AND le.SEC_RANGE_isnull AND le.PRIM_NAME_isnull) AND (le.LOCALE_isnull OR le.V_CITY_NAME_isnull AND le.ST_isnull AND le.ZIP_isnull)) OR (ri.ADDRESS_isnull OR (ri.ADDR_isnull OR ri.PRIM_RANGE_isnull AND ri.SEC_RANGE_isnull AND ri.PRIM_NAME_isnull) AND (ri.LOCALE_isnull OR ri.V_CITY_NAME_isnull AND ri.ST_isnull AND ri.ZIP_isnull)) => 0,
le.ADDRESS = ri.ADDRESS  => le.ADDRESS_weight100,
0);
INTEGER2 TAX_ID_score := MAP( le.TAX_ID_isnull OR ri.TAX_ID_isnull => 0,
le.TAX_ID = ri.TAX_ID  => le.TAX_ID_weight100,
0 /* switch0 */);
INTEGER2 DOB_year       := MAP ( le.DOB_year_isnull or ri.DOB_year_isnull => 0,
le.DOB_year = ri.DOB_year => le.DOB_year_weight100,
SALT27.Fn_YearMatch(le.DOB_year,ri.DOB_year,12) => le.DOB_year_weight100-358, // assumes even year distribution - so 3x less specific
SALT27.fn_fail_scale(le.DOB_year_weight100,s.DOB_year_switch) );
INTEGER2 DOB_month       := MAP ( le.DOB_month_isnull or ri.DOB_month_isnull => 0,
le.DOB_month = ri.DOB_month => le.DOB_month_weight100,
le.DOB_month = ri.DOB_day AND le.DOB_day = ri.DOB_month => le.DOB_month_weight100-100, // Performing M-D switch
le.DOB_Day <= 1 AND le.DOB_Month = 1 OR ri.DOB_Day <= 1 AND le.DOB_Month = 1 => -200, // Month may be a soft 1 if day is ...
SALT27.fn_fail_scale(le.DOB_month_weight100,s.DOB_month_switch) );
INTEGER2 DOB_day       := MAP ( le.DOB_day_isnull or ri.DOB_day_isnull => 0,
le.DOB_day = ri.DOB_day => le.DOB_day_weight100,
le.DOB_day = ri.DOB_month AND le.DOB_month = ri.DOB_day => le.DOB_day_weight100-100, // Performing M-D switch
le.DOB_Day = 1 OR ri.DOB_Day = 1 => -200, // Treating as a 'soft' 1
SALT27.fn_fail_scale(le.DOB_day_weight100,s.DOB_day_switch) );
INTEGER2 DOB_score_temp := (DOB_year+DOB_month+DOB_day);
INTEGER2 DOB_score := MAP( le.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND le.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND le.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) or ri.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND ri.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND ri.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) => 0,
DOB_year+DOB_month+DOB_day < 0 or DOB_year+DOB_month+DOB_day<>0 and DOB_year+DOB_month+DOB_day < -300 => SKIP,
DOB_year < 0 and ABS(le.DOB_year-ri.DOB_year) > 13 => SKIP, // Do not allow full generation mis-match
DOB_score_temp);

REAL LOCALE_score_scale := ( le.LOCALE_weight100 + ri.LOCALE_weight100 ) / (le.V_CITY_NAME_weight100 + ri.V_CITY_NAME_weight100 + le.ST_weight100 + ri.ST_weight100 + le.ZIP_weight100 + ri.ZIP_weight100); // Scaling factor for this concept
INTEGER2 LOCALE_score_pre := MAP( (le.LOCALE_isnull OR le.V_CITY_NAME_isnull AND le.ST_isnull AND le.ZIP_isnull) OR (ri.LOCALE_isnull OR ri.V_CITY_NAME_isnull AND ri.ST_isnull AND ri.ZIP_isnull) => 0,
ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.LOCALE = ri.LOCALE  => le.LOCALE_weight100,
0)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
INTEGER2 V_CITY_NAME_score_temp := MAP( le.V_CITY_NAME_isnull OR ri.V_CITY_NAME_isnull => 0,
LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.V_CITY_NAME = ri.V_CITY_NAME  => le.V_CITY_NAME_weight100,
SALT27.Fn_Fail_Scale(le.V_CITY_NAME_weight100,s.V_CITY_NAME_switch))*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
INTEGER2 LAT_LONG_score_temp := MAP( le.LAT_LONG_isnull OR ri.LAT_LONG_isnull => 0,
le.LAT_LONG = ri.LAT_LONG  => le.LAT_LONG_weight100,
SALT27.Fn_LL_DistanceScore(le.LAT_LONG,le.LAT_LONG_ranges,ri.LAT_LONG,ri.LAT_LONG_ranges,1) > 0 => SALT27.Fn_LL_DistanceScore(le.LAT_LONG,le.LAT_LONG_ranges,ri.LAT_LONG,ri.LAT_LONG_ranges,1),
SALT27.Fn_Fail_Scale(le.LAT_LONG_weight100,s.LAT_LONG_switch));
INTEGER2 SNAME_score := MAP( le.SNAME_isnull OR ri.SNAME_isnull => 0,
FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.SNAME = ri.SNAME  => le.SNAME_weight100,
le.SNAME_NormSuffix = ri.SNAME_NormSuffix => SALT27.fn_fuzzy_specificity(le.SNAME_weight100,le.SNAME_cnt, le.SNAME_NormSuffix_cnt,ri.SNAME_weight100,ri.SNAME_cnt,ri.SNAME_NormSuffix_cnt),
SALT27.Fn_Fail_Scale(le.SNAME_weight100,s.SNAME_switch))*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
INTEGER2 ST_score_temp := MAP( le.ST_isnull OR ri.ST_isnull => 0,
LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.ST = ri.ST  => le.ST_weight100,
SALT27.Fn_Fail_Scale(le.ST_weight100,s.ST_switch))*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
INTEGER2 GENDER_score := MAP( le.GENDER_isnull OR ri.GENDER_isnull => 0,
le.GENDER = ri.GENDER  => le.GENDER_weight100,
SALT27.Fn_Fail_Scale(le.GENDER_weight100,s.GENDER_switch));
INTEGER2 DID_score := DID_score_temp*0.33;
REAL MAINNAME_score_scale := ( le.MAINNAME_weight100 + ri.MAINNAME_weight100 ) / (le.FNAME_weight100 + ri.FNAME_weight100 + le.MNAME_weight100 + ri.MNAME_weight100 + le.LNAME_weight100 + ri.LNAME_weight100); // Scaling factor for this concept
INTEGER2 MAINNAME_score_pre := MAP( (le.MAINNAME_isnull OR le.FNAME_isnull AND le.MNAME_isnull AND le.LNAME_isnull) OR (ri.MAINNAME_isnull OR ri.FNAME_isnull AND ri.MNAME_isnull AND ri.LNAME_isnull) => 0,
FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.MAINNAME = ri.MAINNAME  => le.MAINNAME_weight100,
SALT27.fn_concept_wordbag_EditN.Match3((SALT27.StrType)ri.FNAME,ri.FNAME_weight100,true,0,true,1,(SALT27.StrType)ri.MNAME,ri.MNAME_weight100,true,0,true,2,(SALT27.StrType)ri.LNAME,ri.LNAME_weight100,true,0,true,2,(SALT27.StrType)le.FNAME,le.FNAME_weight100,(SALT27.StrType)le.MNAME,le.MNAME_weight100,(SALT27.StrType)le.LNAME,le.LNAME_weight100)*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale))*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
REAL ADDR_score_scale := ( le.ADDR_weight100 + ri.ADDR_weight100 ) / (le.PRIM_RANGE_weight100 + ri.PRIM_RANGE_weight100 + le.SEC_RANGE_weight100 + ri.SEC_RANGE_weight100 + le.PRIM_NAME_weight100 + ri.PRIM_NAME_weight100); // Scaling factor for this concept
INTEGER2 ADDR_score_pre := MAP( (le.ADDR_isnull OR le.PRIM_RANGE_isnull AND le.SEC_RANGE_isnull AND le.PRIM_NAME_isnull) OR (ri.ADDR_isnull OR ri.PRIM_RANGE_isnull AND ri.SEC_RANGE_isnull AND ri.PRIM_NAME_isnull) => 0,
ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.ADDR = ri.ADDR  => le.ADDR_weight100,
0)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
INTEGER2 PRIM_NAME_score_temp := MAP( le.PRIM_NAME_isnull OR ri.PRIM_NAME_isnull => 0,
ADDR_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.PRIM_NAME = ri.PRIM_NAME  => le.PRIM_NAME_weight100,
0 /* switch0 */)*IF(ADDR_score_scale=0,1,ADDR_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
INTEGER2 ZIP_score_temp := MAP( le.ZIP_isnull OR ri.ZIP_isnull => 0,
LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.ZIP = ri.ZIP  => le.ZIP_weight100,
SALT27.Fn_Fail_Scale(le.ZIP_weight100,s.ZIP_switch))*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
INTEGER2 PRIM_RANGE_score_temp := MAP( le.PRIM_RANGE_isnull OR ri.PRIM_RANGE_isnull => 0,
ADDR_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.PRIM_RANGE = ri.PRIM_RANGE  => le.PRIM_RANGE_weight100,
0 /* switch0 */)*IF(ADDR_score_scale=0,1,ADDR_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
INTEGER2 LNAME_score := MAP( le.LNAME_isnull OR ri.LNAME_isnull => 0,
MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.LNAME = ri.LNAME OR SALT27.fn_hyphen_match(le.LNAME,ri.LNAME,1)<=2  => MIN(le.LNAME_weight100,ri.LNAME_weight100),
SALT27.WithinEditN(le.LNAME,ri.LNAME,2) => SALT27.fn_fuzzy_specificity(le.LNAME_weight100,le.LNAME_cnt, le.LNAME_e2_cnt,ri.LNAME_weight100,ri.LNAME_cnt,ri.LNAME_e2_cnt),
LENGTH(TRIM(le.LNAME))>0 and le.LNAME = ri.LNAME[1..LENGTH(TRIM(le.LNAME))] => le.LNAME_weight100, // An initial match - take initial specificity
LENGTH(TRIM(ri.LNAME))>0 and ri.LNAME = le.LNAME[1..LENGTH(TRIM(ri.LNAME))] => ri.LNAME_weight100, // An initial match - take initial specificity
SALT27.Fn_Fail_Scale(le.LNAME_weight100,s.LNAME_switch))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
INTEGER2 V_CITY_NAME_score := V_CITY_NAME_score_temp*0.50;
INTEGER2 LAT_LONG_score := LAT_LONG_score_temp*0.75;
INTEGER2 MNAME_score := MAP( le.MNAME_isnull OR ri.MNAME_isnull => 0,
MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.MNAME = ri.MNAME  => le.MNAME_weight100,
SALT27.WithinEditN(le.MNAME,ri.MNAME,2) => SALT27.fn_fuzzy_specificity(le.MNAME_weight100,le.MNAME_cnt, le.MNAME_e2_cnt,ri.MNAME_weight100,ri.MNAME_cnt,ri.MNAME_e2_cnt),
LENGTH(TRIM(le.MNAME))>0 and le.MNAME = ri.MNAME[1..LENGTH(TRIM(le.MNAME))] => le.MNAME_weight100, // An initial match - take initial specificity
LENGTH(TRIM(ri.MNAME))>0 and ri.MNAME = le.MNAME[1..LENGTH(TRIM(ri.MNAME))] => ri.MNAME_weight100, // An initial match - take initial specificity
SALT27.Fn_Fail_Scale(le.MNAME_weight100,s.MNAME_switch))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
INTEGER2 FNAME_score := MAP( le.FNAME_isnull OR ri.FNAME_isnull => 0,
MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.FNAME = ri.FNAME  => le.FNAME_weight100,
SALT27.WithinEditN(le.FNAME,ri.FNAME,1) => SALT27.fn_fuzzy_specificity(le.FNAME_weight100,le.FNAME_cnt, le.FNAME_e1_cnt,ri.FNAME_weight100,ri.FNAME_cnt,ri.FNAME_e1_cnt),
LENGTH(TRIM(le.FNAME))>0 and le.FNAME = ri.FNAME[1..LENGTH(TRIM(le.FNAME))] => le.FNAME_weight100, // An initial match - take initial specificity
LENGTH(TRIM(ri.FNAME))>0 and ri.FNAME = le.FNAME[1..LENGTH(TRIM(ri.FNAME))] => ri.FNAME_weight100, // An initial match - take initial specificity
le.FNAME_PreferredName = ri.FNAME_PreferredName => SALT27.fn_fuzzy_specificity(le.FNAME_weight100,le.FNAME_cnt, le.FNAME_PreferredName_cnt,ri.FNAME_weight100,ri.FNAME_cnt,ri.FNAME_PreferredName_cnt),
SALT27.Fn_Fail_Scale(le.FNAME_weight100,s.FNAME_switch))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
INTEGER2 SEC_RANGE_score_temp := MAP( le.SEC_RANGE_isnull OR ri.SEC_RANGE_isnull => 0,
ADDR_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.SEC_RANGE = ri.SEC_RANGE OR SALT27.fn_hyphen_match(le.SEC_RANGE,ri.SEC_RANGE,1)<=2  => MIN(le.SEC_RANGE_weight100,ri.SEC_RANGE_weight100),
0 /* switch0 */)*IF(ADDR_score_scale=0,1,ADDR_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
INTEGER2 ST_score := ST_score_temp*0.50;
INTEGER2 PRIM_NAME_score := PRIM_NAME_score_temp*0.50;
INTEGER2 ZIP_score := ZIP_score_temp*0.50;
// Compute the score for the concept LOCALE
INTEGER2 LOCALE_score_ext := MAX(LOCALE_score_pre,0) + V_CITY_NAME_score + ST_score + ZIP_score + MAX(ADDRESS_score_pre,0);// Score in surrounding context
INTEGER2 LOCALE_score_res := MAX(0,LOCALE_score_pre); // At least nothing
INTEGER2 LOCALE_score_unweighted := LOCALE_score_res;
INTEGER2 LOCALE_score := LOCALE_score_unweighted*0.50;
INTEGER2 PRIM_RANGE_score := PRIM_RANGE_score_temp*0.50;
INTEGER2 SEC_RANGE_score := SEC_RANGE_score_temp*0.50;
// Compute the score for the concept MAINNAME
INTEGER2 MAINNAME_score_ext := MAX(MAINNAME_score_pre,0) + FNAME_score + MNAME_score + LNAME_score + MAX(FULLNAME_score_pre,0);// Score in surrounding context
INTEGER2 MAINNAME_score_res := MAX(0,MAINNAME_score_pre); // At least nothing
INTEGER2 MAINNAME_score := MAINNAME_score_res;
// Compute the score for the concept FULLNAME
INTEGER2 FULLNAME_score_ext := MAX(FULLNAME_score_pre,0)+ MAINNAME_score + FNAME_score + MNAME_score + LNAME_score + SNAME_score;// Score in surrounding context
INTEGER2 FULLNAME_score_res := MAX(0,FULLNAME_score_pre); // At least nothing
INTEGER2 FULLNAME_score := IF ( FULLNAME_score_ext > -600,FULLNAME_score_res,SKIP);
// Compute the score for the concept ADDR
INTEGER2 ADDR_score_ext := MAX(ADDR_score_pre,0) + PRIM_RANGE_score + SEC_RANGE_score + PRIM_NAME_score + MAX(ADDRESS_score_pre,0);// Score in surrounding context
INTEGER2 ADDR_score_res := MAX(0,ADDR_score_pre); // At least nothing
INTEGER2 ADDR_score_unweighted := ADDR_score_res;
INTEGER2 ADDR_score := ADDR_score_unweighted*0.50;
// Compute the score for the concept ADDRESS
INTEGER2 ADDRESS_score_ext := MAX(ADDRESS_score_pre,0)+ ADDR_score + PRIM_RANGE_score + SEC_RANGE_score + PRIM_NAME_score+ LOCALE_score + V_CITY_NAME_score + ST_score + ZIP_score;// Score in surrounding context
INTEGER2 ADDRESS_score_res := MAX(0,ADDRESS_score_pre); // At least nothing
INTEGER2 ADDRESS_score_unweighted := ADDRESS_score_res;
INTEGER2 ADDRESS_score := ADDRESS_score_unweighted*0.50;
SELF.Conf_Prop := (0
+MAX(le.NPI_NUMBER_prop,ri.NPI_NUMBER_prop)*NPI_NUMBER_score // Score if either field propogated
+MAX(le.DEA_NUMBER_prop,ri.DEA_NUMBER_prop)*DEA_NUMBER_score // Score if either field propogated
+if(le.MAINNAME_prop+ri.MAINNAME_prop>0,MAINNAME_score*(0+if(le.FNAME_prop+ri.FNAME_prop>0,1,0)+if(le.MNAME_prop+ri.MNAME_prop>0,1,0)+if(le.LNAME_prop+ri.LNAME_prop>0,1,0))/3,0)
+if(le.FULLNAME_prop+ri.FULLNAME_prop>0,FULLNAME_score*(0+if(le.MAINNAME_prop+ri.MAINNAME_prop>0,1,0)+if(le.SNAME_prop+ri.SNAME_prop>0,1,0))/2,0)
+MAX(le.LIC_NBR_prop,ri.LIC_NBR_prop)*LIC_NBR_score // Score if either field propogated
+MAX(le.UPIN_prop,ri.UPIN_prop)*UPIN_score // Score if either field propogated
+if(le.ADDR_prop+ri.ADDR_prop>0,ADDR_score*(0+if(le.SEC_RANGE_prop+ri.SEC_RANGE_prop>0,1,0))/3,0)
+if(le.ADDRESS_prop+ri.ADDRESS_prop>0,ADDRESS_score*(0+if(le.ADDR_prop+ri.ADDR_prop>0,1,0)+if(le.LOCALE_prop+ri.LOCALE_prop>0,1,0))/2,0)
+DOB_score*(IF( (le.DOB_prop|ri.DOB_prop)&4>0,6,0 )+IF( (le.DOB_prop|ri.DOB_prop)&2>0,4,0 )+IF( (le.DOB_prop|ri.DOB_prop)&1>0,5,0 ))/15 // Compute weight of year/month/day propogation independantly
+if(le.LOCALE_prop+ri.LOCALE_prop>0,LOCALE_score*(0+if(le.V_CITY_NAME_prop+ri.V_CITY_NAME_prop>0,1,0)+if(le.ST_prop+ri.ST_prop>0,1,0))/3,0)
+(MAX(le.LNAME_prop,ri.LNAME_prop)/MAX(LENGTH(TRIM(le.LNAME)),LENGTH(TRIM(ri.LNAME))))*LNAME_score // Proportion of longest string propogated
+MAX(le.V_CITY_NAME_prop,ri.V_CITY_NAME_prop)*V_CITY_NAME_score // Score if either field propogated
+(MAX(le.MNAME_prop,ri.MNAME_prop)/MAX(LENGTH(TRIM(le.MNAME)),LENGTH(TRIM(ri.MNAME))))*MNAME_score // Proportion of longest string propogated
+(MAX(le.FNAME_prop,ri.FNAME_prop)/MAX(LENGTH(TRIM(le.FNAME)),LENGTH(TRIM(ri.FNAME))))*FNAME_score // Proportion of longest string propogated
+MAX(le.SEC_RANGE_prop,ri.SEC_RANGE_prop)*SEC_RANGE_score // Score if either field propogated
+MAX(le.SNAME_prop,ri.SNAME_prop)*SNAME_score // Score if either field propogated
+MAX(le.ST_prop,ri.ST_prop)*ST_score // Score if either field propogated
+MAX(le.GENDER_prop,ri.GENDER_prop)*GENDER_score // Score if either field propogated
) / 100; // Score based on propogated fields
iComp := (VENDOR_ID_score + DID_score + NPI_NUMBER_score + DEA_NUMBER_score + MAX(FULLNAME_score,MAX(MAINNAME_score,FNAME_score + MNAME_score + LNAME_score) + SNAME_score) + LIC_NBR_score + UPIN_score + MAX(ADDRESS_score,MAX(ADDR_score,PRIM_RANGE_score + SEC_RANGE_score + PRIM_NAME_score) + MAX(LOCALE_score,V_CITY_NAME_score + ST_score + ZIP_score)) + TAX_ID_score + DOB_score + LAT_LONG_score + GENDER_score) / 100 + outside;
SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
SHARED RuleText(UNSIGNED n) :=  MAP (
n = 0 => ':VENDOR_ID',
n = 1 => ':DID',
n = 2 => ':NPI_NUMBER',
n = 3 => ':DEA_NUMBER',
n = 4 => ':LIC_NBR:*',
n = 15 => ':UPIN:*',
n = 25 => ':TAX_ID:*',
n = 34 => ':DOB:PRIM_NAME',
n = 35 => ':DOB:ZIP',
n = 36 => ':DOB:PRIM_RANGE',
n = 37 => ':DOB:LNAME',
n = 38 => ':DOB:V_CITY_NAME',
n = 39 => ':DOB:LAT_LONG',
n = 40 => ':DOB:MNAME',
n = 41 => ':DOB:FNAME',
n = 42 => ':PRIM_NAME:ZIP',
n = 43 => ':PRIM_NAME:PRIM_RANGE',
n = 44 => ':PRIM_NAME:LNAME',
n = 45 => ':PRIM_NAME:V_CITY_NAME',
n = 46 => ':PRIM_NAME:LAT_LONG',
n = 47 => ':PRIM_NAME:MNAME',
n = 48 => ':ZIP:PRIM_RANGE',
n = 49 => ':ZIP:LNAME',
n = 50 => ':ZIP:V_CITY_NAME',
n = 51 => ':ZIP:LAT_LONG',
n = 52 => ':ZIP:MNAME',
n = 53 => ':PRIM_RANGE:LNAME',
n = 54 => ':PRIM_RANGE:V_CITY_NAME',
n = 55 => ':PRIM_RANGE:LAT_LONG',
n = 56 => ':PRIM_RANGE:MNAME:FNAME',
n = 57 => ':LNAME:V_CITY_NAME',
n = 58 => ':LNAME:LAT_LONG:*',
n = 60 => ':LNAME:MNAME:FNAME',
n = 61 => ':V_CITY_NAME:LAT_LONG:*',
n = 63 => ':V_CITY_NAME:MNAME:FNAME',
n = 64 => ':LAT_LONG:MNAME:FNAME','AttributeFile:'+(STRING)(n-10000));
//Unable to match efficacy line :	rulenumber	rule	matchesfound

//Unable to match efficacy line :3	2	:LIC_NBR	202986

//Unable to match efficacy line :8	24	:DOB:*	85041

// Read 30 efficacy lines; matched 27 of them
// Rules explicitely suppressed:9
//Now execute each of the 65 join conditions of which 29 have been optimized into preceding conditions

//Fixed fields ->:VENDOR_ID(24)

dn0 := h(~VENDOR_ID_isnull);
dn0_deduped1 := dn0(VENDOR_ID_weight100>=2200); // Use specificity to flag high-dup counts
dn0_deduped2 := DISTRIBUTE(dn0_deduped1, HASH32(VENDOR_ID, SRC));
SHARED dn0_deduped3 := SORT(dn0_deduped2, VENDOR_ID, SRC, HASH64(Constants.iteration_seedval, 0, RID), LOCAL);
dn0_deduped4 := GROUP(dn0_deduped3, VENDOR_ID, SRC, LOCAL);
dn0_deduped5 := TOPN(dn0_deduped4, 2000, HASH64(Constants.iteration_seedval, 0, RID));
SHARED dn0_deduped6 := UNGROUP(dn0_deduped5);   // selected sources for lhs (lossy)

SHARED dn0_deduped  := dn0_deduped3;   // all targets for rhs (lossless)
SHARED mj0 := JOIN( dn0_deduped6, dn0_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC,match_join(LEFT,RIGHT,0),HINT(Parallel_Match),KEEP(2000),HASH);

//Fixed fields ->:DID(23)

dn1 := h(~DID_isnull);
dn1_deduped1 := dn1(DID_weight100>=2200); // Use specificity to flag high-dup counts
dn1_deduped2 := DISTRIBUTE(dn1_deduped1, HASH32(DID));
SHARED dn1_deduped3 := SORT(dn1_deduped2, DID, HASH64(Constants.iteration_seedval, 1, RID), LOCAL);
dn1_deduped4 := GROUP(dn1_deduped3, DID, LOCAL);
dn1_deduped5 := TOPN(dn1_deduped4, 2000, HASH64(Constants.iteration_seedval, 1, RID));
SHARED dn1_deduped6 := UNGROUP(dn1_deduped5);   // selected sources for lhs (lossy)

SHARED dn1_deduped  := dn1_deduped3;   // all targets for rhs (lossless)
SHARED mj1 := JOIN( dn1_deduped6, dn1_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.DID = RIGHT.DID,match_join(LEFT,RIGHT,1),HINT(Parallel_Match),KEEP(2000),HASH);

//Fixed fields ->:NPI_NUMBER(22)

dn2 := h(~NPI_NUMBER_isnull);
dn2_deduped1 := dn2(NPI_NUMBER_weight100>=2200); // Use specificity to flag high-dup counts
dn2_deduped2 := DISTRIBUTE(dn2_deduped1, HASH32(NPI_NUMBER));
SHARED dn2_deduped3 := SORT(dn2_deduped2, NPI_NUMBER, HASH64(Constants.iteration_seedval, 2, RID), LOCAL);
dn2_deduped4 := GROUP(dn2_deduped3, NPI_NUMBER, LOCAL);
dn2_deduped5 := TOPN(dn2_deduped4, 10000, HASH64(Constants.iteration_seedval, 2, RID));
SHARED dn2_deduped6 := UNGROUP(dn2_deduped5);   // selected sources for lhs (lossy)

SHARED dn2_deduped  := dn2_deduped3;   // all targets for rhs (lossless)
SHARED mj2 := JOIN( dn2_deduped6, dn2_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER,match_join(LEFT,RIGHT,2),HINT(Parallel_Match),KEEP(2000),HASH);

//Fixed fields ->:DEA_NUMBER(22)

dn3 := h(~DEA_NUMBER_isnull);
dn3_deduped1 := dn3(DEA_NUMBER_weight100>=2200); // Use specificity to flag high-dup counts
dn3_deduped2 := DISTRIBUTE(dn3_deduped1, HASH32(DEA_NUMBER));
SHARED dn3_deduped3 := SORT(dn3_deduped2, DEA_NUMBER, HASH64(Constants.iteration_seedval, 3, RID), LOCAL);
dn3_deduped4 := GROUP(dn3_deduped3, DEA_NUMBER, LOCAL);
dn3_deduped5 := TOPN(dn3_deduped4, 10000, HASH64(Constants.iteration_seedval, 3, RID));
SHARED dn3_deduped6 := UNGROUP(dn3_deduped5);   // selected sources for lhs (lossy)

SHARED dn3_deduped  := dn3_deduped3;   // all targets for rhs (lossless)
SHARED mj3 := JOIN( dn3_deduped6, dn3_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.DEA_NUMBER = RIGHT.DEA_NUMBER,match_join(LEFT,RIGHT,3),HINT(Parallel_Match),KEEP(2000),HASH);

//First 1 fields shared with following 10 joins - optimization performed
//Fixed fields ->:LIC_NBR(21):UPIN(20) also :LIC_NBR(21):TAX_ID(18) also :LIC_NBR(21):DOB(16) also :LIC_NBR(21):PRIM_NAME(13) also :LIC_NBR(21):ZIP(13) also :LIC_NBR(21):PRIM_RANGE(12) also :LIC_NBR(21):LNAME(11) also :LIC_NBR(21):V_CITY_NAME(11) also :LIC_NBR(21):LAT_LONG(10) also :LIC_NBR(21):MNAME(9) also :LIC_NBR(21):FNAME(8)

dn4 := h(~LIC_NBR_isnull);
dn4_deduped1 := dn4(LIC_NBR_weight100>=1800); // Use specificity to flag high-dup counts
dn4_deduped2 := DISTRIBUTE(dn4_deduped1, HASH32(LIC_NBR, LIC_STATE));
SHARED dn4_deduped3 := SORT(dn4_deduped2, LIC_NBR, LIC_STATE, HASH64(Constants.iteration_seedval, 4, RID), LOCAL);
dn4_deduped4 := GROUP(dn4_deduped3, LIC_NBR, LIC_STATE, LOCAL);
dn4_deduped5 := TOPN(dn4_deduped4, 2000, HASH64(Constants.iteration_seedval, 4, RID));
SHARED dn4_deduped6 := UNGROUP(dn4_deduped5);   // selected sources for lhs (lossy)

SHARED dn4_deduped  := dn4_deduped3;   // all targets for rhs (lossless)
SHARED mj4 := JOIN( dn4_deduped6, dn4_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.LIC_NBR = RIGHT.LIC_NBR AND LEFT.LIC_STATE = RIGHT.LIC_STATE
AND (
LEFT.UPIN = RIGHT.UPIN AND ~LEFT.UPIN_isnull
OR    LEFT.TAX_ID = RIGHT.TAX_ID AND ~LEFT.TAX_ID_isnull
OR    LEFT.DOB_year = RIGHT.DOB_year and LEFT.DOB_month = RIGHT.DOB_month and LEFT.DOB_day = RIGHT.DOB_day AND (~LEFT.DOB_year_isnull OR ~LEFT.DOB_month_isnull OR ~LEFT.DOB_day_isnull)
OR    LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND ~LEFT.PRIM_NAME_isnull
OR    LEFT.ZIP = RIGHT.ZIP AND ~LEFT.ZIP_isnull
OR    LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE AND ~LEFT.PRIM_RANGE_isnull
OR    LEFT.LNAME = RIGHT.LNAME AND ~LEFT.LNAME_isnull
OR    LEFT.V_CITY_NAME = RIGHT.V_CITY_NAME AND ~LEFT.V_CITY_NAME_isnull
OR    LEFT.LAT_LONG = RIGHT.LAT_LONG AND ~LEFT.LAT_LONG_isnull
OR    LEFT.MNAME = RIGHT.MNAME AND ~LEFT.MNAME_isnull
OR    LEFT.FNAME = RIGHT.FNAME AND ~LEFT.FNAME_isnull
),match_join(LEFT,RIGHT,4),HINT(Parallel_Match),KEEP(2000),HASH);
mjs0_t := mj0+mj1+mj2+mj3+mj4;
SALT27.mac_select_best_matches(mjs0_t,RID1,RID2,o0);
SHARED mjs0 := o0 : PERSIST('~temp::HealthCareProviderHeader_prod::LNPID::mj0');

//First 1 fields shared with following 9 joins - optimization performed
//Fixed fields ->:UPIN(20):TAX_ID(18) also :UPIN(20):DOB(16) also :UPIN(20):PRIM_NAME(13) also :UPIN(20):ZIP(13) also :UPIN(20):PRIM_RANGE(12) also :UPIN(20):LNAME(11) also :UPIN(20):V_CITY_NAME(11) also :UPIN(20):LAT_LONG(10) also :UPIN(20):MNAME(9) also :UPIN(20):FNAME(8)

dn15 := h(~UPIN_isnull);
dn15_deduped1 := dn15(UPIN_weight100>=1800); // Use specificity to flag high-dup counts
dn15_deduped2 := DISTRIBUTE(dn15_deduped1, HASH32(UPIN));
SHARED dn15_deduped3 := SORT(dn15_deduped2, UPIN, HASH64(Constants.iteration_seedval, 15, RID), LOCAL);
dn15_deduped4 := GROUP(dn15_deduped3, UPIN, LOCAL);
dn15_deduped5 := TOPN(dn15_deduped4, 2000, HASH64(Constants.iteration_seedval, 15, RID));
SHARED dn15_deduped6 := UNGROUP(dn15_deduped5);   // selected sources for lhs (lossy)

SHARED dn15_deduped  := dn15_deduped3;   // all targets for rhs (lossless)
SHARED mj15 := JOIN( dn15_deduped6, dn15_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.UPIN = RIGHT.UPIN
AND (
LEFT.TAX_ID = RIGHT.TAX_ID AND ~LEFT.TAX_ID_isnull
OR    LEFT.DOB_year = RIGHT.DOB_year and LEFT.DOB_month = RIGHT.DOB_month and LEFT.DOB_day = RIGHT.DOB_day AND (~LEFT.DOB_year_isnull OR ~LEFT.DOB_month_isnull OR ~LEFT.DOB_day_isnull)
OR    LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND ~LEFT.PRIM_NAME_isnull
OR    LEFT.ZIP = RIGHT.ZIP AND ~LEFT.ZIP_isnull
OR    LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE AND ~LEFT.PRIM_RANGE_isnull
OR    LEFT.LNAME = RIGHT.LNAME AND ~LEFT.LNAME_isnull
OR    LEFT.V_CITY_NAME = RIGHT.V_CITY_NAME AND ~LEFT.V_CITY_NAME_isnull
OR    LEFT.LAT_LONG = RIGHT.LAT_LONG AND ~LEFT.LAT_LONG_isnull
OR    LEFT.MNAME = RIGHT.MNAME AND ~LEFT.MNAME_isnull
OR    LEFT.FNAME = RIGHT.FNAME AND ~LEFT.FNAME_isnull
),match_join(LEFT,RIGHT,15),HINT(Parallel_Match),KEEP(2000),HASH);
mjs1_t := mj15;
SALT27.mac_select_best_matches(mjs1_t,RID1,RID2,o1);
SHARED mjs1 := o1 : PERSIST('~temp::HealthCareProviderHeader_prod::LNPID::mj1');

//First 1 fields shared with following 8 joins - optimization performed
//Fixed fields ->:TAX_ID(18):DOB(16) also :TAX_ID(18):PRIM_NAME(13) also :TAX_ID(18):ZIP(13) also :TAX_ID(18):PRIM_RANGE(12) also :TAX_ID(18):LNAME(11) also :TAX_ID(18):V_CITY_NAME(11) also :TAX_ID(18):LAT_LONG(10) also :TAX_ID(18):MNAME(9) also :TAX_ID(18):FNAME(8)

dn25 := h(~TAX_ID_isnull);
dn25_deduped1 := dn25(TAX_ID_weight100>=1800); // Use specificity to flag high-dup counts
dn25_deduped2 := DISTRIBUTE(dn25_deduped1, HASH32(TAX_ID));
SHARED dn25_deduped3 := SORT(dn25_deduped2, TAX_ID, HASH64(Constants.iteration_seedval, 25, RID), LOCAL);
dn25_deduped4 := GROUP(dn25_deduped3, TAX_ID, LOCAL);
dn25_deduped5 := TOPN(dn25_deduped4, 2000, HASH64(Constants.iteration_seedval, 25, RID));
SHARED dn25_deduped6 := UNGROUP(dn25_deduped5);   // selected sources for lhs (lossy)

SHARED dn25_deduped  := dn25_deduped3;   // all targets for rhs (lossless)
SHARED mj25 := JOIN( dn25_deduped6, dn25_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.TAX_ID = RIGHT.TAX_ID
AND (
LEFT.DOB_year = RIGHT.DOB_year and LEFT.DOB_month = RIGHT.DOB_month and LEFT.DOB_day = RIGHT.DOB_day AND (~LEFT.DOB_year_isnull OR ~LEFT.DOB_month_isnull OR ~LEFT.DOB_day_isnull)
OR    LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND ~LEFT.PRIM_NAME_isnull
OR    LEFT.ZIP = RIGHT.ZIP AND ~LEFT.ZIP_isnull
OR    LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE AND ~LEFT.PRIM_RANGE_isnull
OR    LEFT.LNAME = RIGHT.LNAME AND ~LEFT.LNAME_isnull
OR    LEFT.V_CITY_NAME = RIGHT.V_CITY_NAME AND ~LEFT.V_CITY_NAME_isnull
OR    LEFT.LAT_LONG = RIGHT.LAT_LONG AND ~LEFT.LAT_LONG_isnull
OR    LEFT.MNAME = RIGHT.MNAME AND ~LEFT.MNAME_isnull
OR    LEFT.FNAME = RIGHT.FNAME AND ~LEFT.FNAME_isnull
),match_join(LEFT,RIGHT,25),HINT(Parallel_Match),KEEP(2000),HASH);
mjs2_t := mj25;
SALT27.mac_select_best_matches(mjs2_t,RID1,RID2,o2);
SHARED mjs2 := o2 : PERSIST('~temp::HealthCareProviderHeader_prod::LNPID::mj2');

//Fixed fields ->:DOB(16):PRIM_NAME(13)

dn34 := h((~DOB_year_isnull OR ~DOB_month_isnull OR ~DOB_day_isnull) AND ~PRIM_NAME_isnull);
dn34_deduped1 := dn34(DOB_year_weight100 + DOB_month_weight100 + DOB_day_weight100 + PRIM_NAME_weight100>=2200); // Use specificity to flag high-dup counts
dn34_deduped2 := DISTRIBUTE(dn34_deduped1, HASH32(DOB_year, DOB_month, DOB_day, PRIM_NAME));
SHARED dn34_deduped3 := SORT(dn34_deduped2, DOB_year, DOB_month, DOB_day, PRIM_NAME, HASH64(Constants.iteration_seedval, 34, RID), LOCAL);
dn34_deduped4 := GROUP(dn34_deduped3, DOB_year, DOB_month, DOB_day, PRIM_NAME, LOCAL);
dn34_deduped5 := TOPN(dn34_deduped4, 10000, HASH64(Constants.iteration_seedval, 34, RID));
SHARED dn34_deduped6 := UNGROUP(dn34_deduped5);   // selected sources for lhs (lossy)

SHARED dn34_deduped  := dn34_deduped3;   // all targets for rhs (lossless)
SHARED mj34 := JOIN( dn34_deduped6, dn34_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.DOB_year = RIGHT.DOB_year and LEFT.DOB_month = RIGHT.DOB_month and LEFT.DOB_day = RIGHT.DOB_day AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME,match_join(LEFT,RIGHT,34),HINT(Parallel_Match),KEEP(2000),HASH);

//Fixed fields ->:DOB(16):ZIP(13)

dn35 := h((~DOB_year_isnull OR ~DOB_month_isnull OR ~DOB_day_isnull) AND ~ZIP_isnull);
dn35_deduped1 := dn35(DOB_year_weight100 + DOB_month_weight100 + DOB_day_weight100 + ZIP_weight100>=2200); // Use specificity to flag high-dup counts
dn35_deduped2 := DISTRIBUTE(dn35_deduped1, HASH32(DOB_year, DOB_month, DOB_day, ZIP));
SHARED dn35_deduped3 := SORT(dn35_deduped2, DOB_year, DOB_month, DOB_day, ZIP, HASH64(Constants.iteration_seedval, 35, RID), LOCAL);
dn35_deduped4 := GROUP(dn35_deduped3, DOB_year, DOB_month, DOB_day, ZIP, LOCAL);
dn35_deduped5 := TOPN(dn35_deduped4, 10000, HASH64(Constants.iteration_seedval, 35, RID));
SHARED dn35_deduped6 := UNGROUP(dn35_deduped5);   // selected sources for lhs (lossy)

SHARED dn35_deduped  := dn35_deduped3;   // all targets for rhs (lossless)
SHARED mj35 := JOIN( dn35_deduped6, dn35_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.DOB_year = RIGHT.DOB_year and LEFT.DOB_month = RIGHT.DOB_month and LEFT.DOB_day = RIGHT.DOB_day AND LEFT.ZIP = RIGHT.ZIP,match_join(LEFT,RIGHT,35),HINT(Parallel_Match),KEEP(2000),HASH);

//Fixed fields ->:DOB(16):PRIM_RANGE(12)

dn36 := h((~DOB_year_isnull OR ~DOB_month_isnull OR ~DOB_day_isnull) AND ~PRIM_RANGE_isnull);
dn36_deduped1 := dn36(DOB_year_weight100 + DOB_month_weight100 + DOB_day_weight100 + PRIM_RANGE_weight100>=2200); // Use specificity to flag high-dup counts
dn36_deduped2 := DISTRIBUTE(dn36_deduped1, HASH32(DOB_year, DOB_month, DOB_day, PRIM_RANGE));
SHARED dn36_deduped3 := SORT(dn36_deduped2, DOB_year, DOB_month, DOB_day, PRIM_RANGE, HASH64(Constants.iteration_seedval, 36, RID), LOCAL);
dn36_deduped4 := GROUP(dn36_deduped3, DOB_year, DOB_month, DOB_day, PRIM_RANGE, LOCAL);
dn36_deduped5 := TOPN(dn36_deduped4, 10000, HASH64(Constants.iteration_seedval, 36, RID));
SHARED dn36_deduped6 := UNGROUP(dn36_deduped5);   // selected sources for lhs (lossy)

SHARED dn36_deduped  := dn36_deduped3;   // all targets for rhs (lossless)
SHARED mj36 := JOIN( dn36_deduped6, dn36_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.DOB_year = RIGHT.DOB_year and LEFT.DOB_month = RIGHT.DOB_month and LEFT.DOB_day = RIGHT.DOB_day AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE,match_join(LEFT,RIGHT,36),HINT(Parallel_Match),KEEP(2000),HASH);

//Fixed fields ->:DOB(16):LNAME(11)

dn37 := h((~DOB_year_isnull OR ~DOB_month_isnull OR ~DOB_day_isnull) AND ~LNAME_isnull);
dn37_deduped1 := dn37(DOB_year_weight100 + DOB_month_weight100 + DOB_day_weight100 + LNAME_weight100>=2200); // Use specificity to flag high-dup counts
dn37_deduped2 := DISTRIBUTE(dn37_deduped1, HASH32(DOB_year, DOB_month, DOB_day, LNAME));
SHARED dn37_deduped3 := SORT(dn37_deduped2, DOB_year, DOB_month, DOB_day, LNAME, HASH64(Constants.iteration_seedval, 37, RID), LOCAL);
dn37_deduped4 := GROUP(dn37_deduped3, DOB_year, DOB_month, DOB_day, LNAME, LOCAL);
dn37_deduped5 := TOPN(dn37_deduped4, 10000, HASH64(Constants.iteration_seedval, 37, RID));
SHARED dn37_deduped6 := UNGROUP(dn37_deduped5);   // selected sources for lhs (lossy)

SHARED dn37_deduped  := dn37_deduped3;   // all targets for rhs (lossless)
SHARED mj37 := JOIN( dn37_deduped6, dn37_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.DOB_year = RIGHT.DOB_year and LEFT.DOB_month = RIGHT.DOB_month and LEFT.DOB_day = RIGHT.DOB_day AND LEFT.LNAME = RIGHT.LNAME,match_join(LEFT,RIGHT,37),HINT(Parallel_Match),KEEP(2000),HASH);

//Fixed fields ->:DOB(16):V_CITY_NAME(11)

dn38 := h((~DOB_year_isnull OR ~DOB_month_isnull OR ~DOB_day_isnull) AND ~V_CITY_NAME_isnull);
dn38_deduped1 := dn38(DOB_year_weight100 + DOB_month_weight100 + DOB_day_weight100 + V_CITY_NAME_weight100>=2200); // Use specificity to flag high-dup counts
dn38_deduped2 := DISTRIBUTE(dn38_deduped1, HASH32(DOB_year, DOB_month, DOB_day, V_CITY_NAME));
SHARED dn38_deduped3 := SORT(dn38_deduped2, DOB_year, DOB_month, DOB_day, V_CITY_NAME, HASH64(Constants.iteration_seedval, 38, RID), LOCAL);
dn38_deduped4 := GROUP(dn38_deduped3, DOB_year, DOB_month, DOB_day, V_CITY_NAME, LOCAL);
dn38_deduped5 := TOPN(dn38_deduped4, 10000, HASH64(Constants.iteration_seedval, 38, RID));
SHARED dn38_deduped6 := UNGROUP(dn38_deduped5);   // selected sources for lhs (lossy)

SHARED dn38_deduped  := dn38_deduped3;   // all targets for rhs (lossless)
SHARED mj38 := JOIN( dn38_deduped6, dn38_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.DOB_year = RIGHT.DOB_year and LEFT.DOB_month = RIGHT.DOB_month and LEFT.DOB_day = RIGHT.DOB_day AND LEFT.V_CITY_NAME = RIGHT.V_CITY_NAME,match_join(LEFT,RIGHT,38),HINT(Parallel_Match),KEEP(2000),HASH);
mjs3_t := mj34+mj35+mj36+mj37+mj38;
SALT27.mac_select_best_matches(mjs3_t,RID1,RID2,o3);
SHARED mjs3 := o3 : PERSIST('~temp::HealthCareProviderHeader_prod::LNPID::mj3');

//Fixed fields ->:DOB(16):LAT_LONG(10)

dn39 := h((~DOB_year_isnull OR ~DOB_month_isnull OR ~DOB_day_isnull) AND ~LAT_LONG_isnull);
dn39_deduped1 := dn39(DOB_year_weight100 + DOB_month_weight100 + DOB_day_weight100 + LAT_LONG_weight100>=2200); // Use specificity to flag high-dup counts
dn39_deduped2 := DISTRIBUTE(dn39_deduped1, HASH32(DOB_year, DOB_month, DOB_day, LAT_LONG));
SHARED dn39_deduped3 := SORT(dn39_deduped2, DOB_year, DOB_month, DOB_day, LAT_LONG, HASH64(Constants.iteration_seedval, 39, RID), LOCAL);
dn39_deduped4 := GROUP(dn39_deduped3, DOB_year, DOB_month, DOB_day, LAT_LONG, LOCAL);
dn39_deduped5 := TOPN(dn39_deduped4, 10000, HASH64(Constants.iteration_seedval, 39, RID));
SHARED dn39_deduped6 := UNGROUP(dn39_deduped5);   // selected sources for lhs (lossy)

SHARED dn39_deduped  := dn39_deduped3;   // all targets for rhs (lossless)
SHARED mj39 := JOIN( dn39_deduped6, dn39_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.DOB_year = RIGHT.DOB_year and LEFT.DOB_month = RIGHT.DOB_month and LEFT.DOB_day = RIGHT.DOB_day AND LEFT.LAT_LONG = RIGHT.LAT_LONG,match_join(LEFT,RIGHT,39),HINT(Parallel_Match),KEEP(2000),HASH);

//Fixed fields ->:DOB(16):MNAME(9)

dn40 := h((~DOB_year_isnull OR ~DOB_month_isnull OR ~DOB_day_isnull) AND ~MNAME_isnull);
dn40_deduped1 := dn40(DOB_year_weight100 + DOB_month_weight100 + DOB_day_weight100 + MNAME_weight100>=2200); // Use specificity to flag high-dup counts
dn40_deduped2 := DISTRIBUTE(dn40_deduped1, HASH32(DOB_year, DOB_month, DOB_day, MNAME));
SHARED dn40_deduped3 := SORT(dn40_deduped2, DOB_year, DOB_month, DOB_day, MNAME, HASH64(Constants.iteration_seedval, 40, RID), LOCAL);
dn40_deduped4 := GROUP(dn40_deduped3, DOB_year, DOB_month, DOB_day, MNAME, LOCAL);
dn40_deduped5 := TOPN(dn40_deduped4, 10000, HASH64(Constants.iteration_seedval, 40, RID));
SHARED dn40_deduped6 := UNGROUP(dn40_deduped5);   // selected sources for lhs (lossy)

SHARED dn40_deduped  := dn40_deduped3;   // all targets for rhs (lossless)
SHARED mj40 := JOIN( dn40_deduped6, dn40_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.DOB_year = RIGHT.DOB_year and LEFT.DOB_month = RIGHT.DOB_month and LEFT.DOB_day = RIGHT.DOB_day AND LEFT.MNAME = RIGHT.MNAME,match_join(LEFT,RIGHT,40),HINT(Parallel_Match),KEEP(2000),HASH);

//Fixed fields ->:DOB(16):FNAME(8)

dn41 := h((~DOB_year_isnull OR ~DOB_month_isnull OR ~DOB_day_isnull) AND ~FNAME_isnull);
dn41_deduped1 := dn41(DOB_year_weight100 + DOB_month_weight100 + DOB_day_weight100 + FNAME_weight100>=2200); // Use specificity to flag high-dup counts
dn41_deduped2 := DISTRIBUTE(dn41_deduped1, HASH32(DOB_year, DOB_month, DOB_day, FNAME));
SHARED dn41_deduped3 := SORT(dn41_deduped2, DOB_year, DOB_month, DOB_day, FNAME, HASH64(Constants.iteration_seedval, 41, RID), LOCAL);
dn41_deduped4 := GROUP(dn41_deduped3, DOB_year, DOB_month, DOB_day, FNAME, LOCAL);
dn41_deduped5 := TOPN(dn41_deduped4, 10000, HASH64(Constants.iteration_seedval, 41, RID));
SHARED dn41_deduped6 := UNGROUP(dn41_deduped5);   // selected sources for lhs (lossy)

SHARED dn41_deduped  := dn41_deduped3;   // all targets for rhs (lossless)
SHARED mj41 := JOIN( dn41_deduped6, dn41_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.DOB_year = RIGHT.DOB_year and LEFT.DOB_month = RIGHT.DOB_month and LEFT.DOB_day = RIGHT.DOB_day AND LEFT.FNAME = RIGHT.FNAME,match_join(LEFT,RIGHT,41),HINT(Parallel_Match),KEEP(2000),HASH);
mjs4_t := mj39+mj40+mj41;
SALT27.mac_select_best_matches(mjs4_t,RID1,RID2,o4);
SHARED mjs4 := o4 : PERSIST('~temp::HealthCareProviderHeader_prod::LNPID::mj4');

//Fixed fields ->:PRIM_NAME(13):LNAME(11)

dn44 := h(~PRIM_NAME_isnull AND ~LNAME_isnull);
dn44_deduped1 := dn44(PRIM_NAME_weight100 + LNAME_weight100>=2200); // Use specificity to flag high-dup counts
dn44_deduped2 := DISTRIBUTE(dn44_deduped1, HASH32(PRIM_NAME, LNAME));
SHARED dn44_deduped3 := SORT(dn44_deduped2, PRIM_NAME, LNAME, HASH64(Constants.iteration_seedval, 44, RID), LOCAL);
dn44_deduped4 := GROUP(dn44_deduped3, PRIM_NAME, LNAME, LOCAL);
dn44_deduped5 := TOPN(dn44_deduped4, 2000, HASH64(Constants.iteration_seedval, 44, RID));
SHARED dn44_deduped6 := UNGROUP(dn44_deduped5);   // selected sources for lhs (lossy)

SHARED dn44_deduped  := dn44_deduped3;   // all targets for rhs (lossless)
SHARED mj44 := JOIN( dn44_deduped6, dn44_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND LEFT.LNAME = RIGHT.LNAME,match_join(LEFT,RIGHT,44),HINT(Parallel_Match),KEEP(2000),HASH);

//Fixed fields ->:PRIM_NAME(13):MNAME(9)

dn47 := h(~PRIM_NAME_isnull AND ~MNAME_isnull);
dn47_deduped1 := dn47(PRIM_NAME_weight100 + MNAME_weight100>=2200); // Use specificity to flag high-dup counts
dn47_deduped2 := DISTRIBUTE(dn47_deduped1, HASH32(PRIM_NAME, MNAME));
SHARED dn47_deduped3 := SORT(dn47_deduped2, PRIM_NAME, MNAME, HASH64(Constants.iteration_seedval, 47, RID), LOCAL);
dn47_deduped4 := GROUP(dn47_deduped3, PRIM_NAME, MNAME, LOCAL);
dn47_deduped5 := TOPN(dn47_deduped4, 2000, HASH64(Constants.iteration_seedval, 47, RID));
SHARED dn47_deduped6 := UNGROUP(dn47_deduped5);   // selected sources for lhs (lossy)

SHARED dn47_deduped  := dn47_deduped3;   // all targets for rhs (lossless)
SHARED mj47 := JOIN( dn47_deduped6, dn47_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND LEFT.MNAME = RIGHT.MNAME,match_join(LEFT,RIGHT,47),HINT(Parallel_Match),KEEP(2000),HASH);

//Fixed fields ->:ZIP(13):PRIM_RANGE(12)

dn48 := h(~ZIP_isnull AND ~PRIM_RANGE_isnull);
dn48_deduped1 := dn48(ZIP_weight100 + PRIM_RANGE_weight100>=2200); // Use specificity to flag high-dup counts
dn48_deduped2 := DISTRIBUTE(dn48_deduped1, HASH32(ZIP, PRIM_RANGE));
SHARED dn48_deduped3 := SORT(dn48_deduped2, ZIP, PRIM_RANGE, HASH64(Constants.iteration_seedval, 48, RID), LOCAL);
dn48_deduped4 := GROUP(dn48_deduped3, ZIP, PRIM_RANGE, LOCAL);
dn48_deduped5 := TOPN(dn48_deduped4, 2000, HASH64(Constants.iteration_seedval, 48, RID));
SHARED dn48_deduped6 := UNGROUP(dn48_deduped5);   // selected sources for lhs (lossy)

SHARED dn48_deduped  := dn48_deduped3;   // all targets for rhs (lossless)
SHARED mj48 := JOIN( dn48_deduped6, dn48_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.ZIP = RIGHT.ZIP AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE,match_join(LEFT,RIGHT,48),HINT(Parallel_Match),KEEP(2000),HASH);
mjs5_t := mj44+mj47+mj48;
SALT27.mac_select_best_matches(mjs5_t,RID1,RID2,o5);
SHARED mjs5 := o5 : PERSIST('~temp::HealthCareProviderHeader_prod::LNPID::mj5');

//Fixed fields ->:ZIP(13):LNAME(11)

dn49 := h(~ZIP_isnull AND ~LNAME_isnull);
dn49_deduped1 := dn49(ZIP_weight100 + LNAME_weight100>=2200); // Use specificity to flag high-dup counts
dn49_deduped2 := DISTRIBUTE(dn49_deduped1, HASH32(ZIP, LNAME));
SHARED dn49_deduped3 := SORT(dn49_deduped2, ZIP, LNAME, HASH64(Constants.iteration_seedval, 49, RID), LOCAL);
dn49_deduped4 := GROUP(dn49_deduped3, ZIP, LNAME, LOCAL);
dn49_deduped5 := TOPN(dn49_deduped4, 2000, HASH64(Constants.iteration_seedval, 49, RID));
SHARED dn49_deduped6 := UNGROUP(dn49_deduped5);   // selected sources for lhs (lossy)

SHARED dn49_deduped  := dn49_deduped3;   // all targets for rhs (lossless)
SHARED mj49 := JOIN( dn49_deduped6, dn49_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.ZIP = RIGHT.ZIP AND LEFT.LNAME = RIGHT.LNAME,match_join(LEFT,RIGHT,49),HINT(Parallel_Match),KEEP(2000),HASH);

//Fixed fields ->:ZIP(13):MNAME(9)

dn52 := h(~ZIP_isnull AND ~MNAME_isnull);
dn52_deduped1 := dn52(ZIP_weight100 + MNAME_weight100>=2200); // Use specificity to flag high-dup counts
dn52_deduped2 := DISTRIBUTE(dn52_deduped1, HASH32(ZIP, MNAME));
SHARED dn52_deduped3 := SORT(dn52_deduped2, ZIP, MNAME, HASH64(Constants.iteration_seedval, 52, RID), LOCAL);
dn52_deduped4 := GROUP(dn52_deduped3, ZIP, MNAME, LOCAL);
dn52_deduped5 := TOPN(dn52_deduped4, 2000, HASH64(Constants.iteration_seedval, 52, RID));
SHARED dn52_deduped6 := UNGROUP(dn52_deduped5);   // selected sources for lhs (lossy)

SHARED dn52_deduped  := dn52_deduped3;   // all targets for rhs (lossless)
SHARED mj52 := JOIN( dn52_deduped6, dn52_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.ZIP = RIGHT.ZIP AND LEFT.MNAME = RIGHT.MNAME,match_join(LEFT,RIGHT,52),HINT(Parallel_Match),KEEP(2000),HASH);

//Fixed fields ->:PRIM_RANGE(12):LNAME(11)

dn53 := h(~PRIM_RANGE_isnull AND ~LNAME_isnull);
dn53_deduped1 := dn53(PRIM_RANGE_weight100 + LNAME_weight100>=2200); // Use specificity to flag high-dup counts
dn53_deduped2 := DISTRIBUTE(dn53_deduped1, HASH32(PRIM_RANGE, LNAME));
SHARED dn53_deduped3 := SORT(dn53_deduped2, PRIM_RANGE, LNAME, HASH64(Constants.iteration_seedval, 53, RID), LOCAL);
dn53_deduped4 := GROUP(dn53_deduped3, PRIM_RANGE, LNAME, LOCAL);
dn53_deduped5 := TOPN(dn53_deduped4, 2000, HASH64(Constants.iteration_seedval, 53, RID));
SHARED dn53_deduped6 := UNGROUP(dn53_deduped5);   // selected sources for lhs (lossy)

SHARED dn53_deduped  := dn53_deduped3;   // all targets for rhs (lossless)
SHARED mj53 := JOIN( dn53_deduped6, dn53_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE AND LEFT.LNAME = RIGHT.LNAME,match_join(LEFT,RIGHT,53),HINT(Parallel_Match),KEEP(2000),HASH);
mjs6_t := mj49+mj52+mj53;
SALT27.mac_select_best_matches(mjs6_t,RID1,RID2,o6);
SHARED mjs6 := o6 : PERSIST('~temp::HealthCareProviderHeader_prod::LNPID::mj6');

//Fixed fields ->:PRIM_RANGE(12):MNAME(9):FNAME(8)

dn56 := h(~PRIM_RANGE_isnull AND ~MNAME_isnull AND ~FNAME_isnull);
dn56_deduped1 := dn56(PRIM_RANGE_weight100 + MNAME_weight100 + FNAME_weight100>=2200); // Use specificity to flag high-dup counts
dn56_deduped2 := DISTRIBUTE(dn56_deduped1, HASH32(PRIM_RANGE, MNAME, FNAME));
SHARED dn56_deduped3 := SORT(dn56_deduped2, PRIM_RANGE, MNAME, FNAME, HASH64(Constants.iteration_seedval, 56, RID), LOCAL);
dn56_deduped4 := GROUP(dn56_deduped3, PRIM_RANGE, MNAME, FNAME, LOCAL);
dn56_deduped5 := TOPN(dn56_deduped4, 2000, HASH64(Constants.iteration_seedval, 56, RID));
SHARED dn56_deduped6 := UNGROUP(dn56_deduped5);   // selected sources for lhs (lossy)

SHARED dn56_deduped  := dn56_deduped3;   // all targets for rhs (lossless)
SHARED mj56 := JOIN( dn56_deduped6, dn56_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE AND LEFT.MNAME = RIGHT.MNAME AND LEFT.FNAME = RIGHT.FNAME,match_join(LEFT,RIGHT,56),HINT(Parallel_Match),KEEP(2000),HASH);

//Fixed fields ->:LNAME(11):V_CITY_NAME(11)

dn57 := h(~LNAME_isnull AND ~V_CITY_NAME_isnull);
dn57_deduped1 := dn57(LNAME_weight100 + V_CITY_NAME_weight100>=2200); // Use specificity to flag high-dup counts
dn57_deduped2 := DISTRIBUTE(dn57_deduped1, HASH32(LNAME, V_CITY_NAME));
SHARED dn57_deduped3 := SORT(dn57_deduped2, LNAME, V_CITY_NAME, HASH64(Constants.iteration_seedval, 57, RID), LOCAL);
dn57_deduped4 := GROUP(dn57_deduped3, LNAME, V_CITY_NAME, LOCAL);
dn57_deduped5 := TOPN(dn57_deduped4, 2000, HASH64(Constants.iteration_seedval, 57, RID));
SHARED dn57_deduped6 := UNGROUP(dn57_deduped5);   // selected sources for lhs (lossy)

SHARED dn57_deduped  := dn57_deduped3;   // all targets for rhs (lossless)
SHARED mj57 := JOIN( dn57_deduped6, dn57_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.LNAME = RIGHT.LNAME AND LEFT.V_CITY_NAME = RIGHT.V_CITY_NAME,match_join(LEFT,RIGHT,57),HINT(Parallel_Match),KEEP(2000),HASH);

//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:LNAME(11):LAT_LONG(10):MNAME(9) also :LNAME(11):LAT_LONG(10):FNAME(8)

dn58 := h(~LNAME_isnull AND ~LAT_LONG_isnull);
dn58_deduped1 := dn58(LNAME_weight100 + LAT_LONG_weight100>=1800); // Use specificity to flag high-dup counts
dn58_deduped2 := DISTRIBUTE(dn58_deduped1, HASH32(LNAME, LAT_LONG));
SHARED dn58_deduped3 := SORT(dn58_deduped2, LNAME, LAT_LONG, HASH64(Constants.iteration_seedval, 58, RID), LOCAL);
dn58_deduped4 := GROUP(dn58_deduped3, LNAME, LAT_LONG, LOCAL);
dn58_deduped5 := TOPN(dn58_deduped4, 2000, HASH64(Constants.iteration_seedval, 58, RID));
SHARED dn58_deduped6 := UNGROUP(dn58_deduped5);   // selected sources for lhs (lossy)

SHARED dn58_deduped  := dn58_deduped3;   // all targets for rhs (lossless)
SHARED mj58 := JOIN( dn58_deduped6, dn58_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.LNAME = RIGHT.LNAME AND LEFT.LAT_LONG = RIGHT.LAT_LONG
AND (
LEFT.MNAME = RIGHT.MNAME AND ~LEFT.MNAME_isnull
OR    LEFT.FNAME = RIGHT.FNAME AND ~LEFT.FNAME_isnull
),match_join(LEFT,RIGHT,58),HINT(Parallel_Match),KEEP(2000),HASH);

//Fixed fields ->:LNAME(11):MNAME(9):FNAME(8)

dn60 := h(~LNAME_isnull AND ~MNAME_isnull AND ~FNAME_isnull);
dn60_deduped1 := dn60(LNAME_weight100 + MNAME_weight100 + FNAME_weight100>=2200); // Use specificity to flag high-dup counts
dn60_deduped2 := DISTRIBUTE(dn60_deduped1, HASH32(LNAME, MNAME, FNAME));
SHARED dn60_deduped3 := SORT(dn60_deduped2, LNAME, MNAME, FNAME, HASH64(Constants.iteration_seedval, 60, RID), LOCAL);
dn60_deduped4 := GROUP(dn60_deduped3, LNAME, MNAME, FNAME, LOCAL);
dn60_deduped5 := TOPN(dn60_deduped4, 2000, HASH64(Constants.iteration_seedval, 60, RID));
SHARED dn60_deduped6 := UNGROUP(dn60_deduped5);   // selected sources for lhs (lossy)

SHARED dn60_deduped  := dn60_deduped3;   // all targets for rhs (lossless)
SHARED mj60 := JOIN( dn60_deduped6, dn60_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.LNAME = RIGHT.LNAME AND LEFT.MNAME = RIGHT.MNAME AND LEFT.FNAME = RIGHT.FNAME,match_join(LEFT,RIGHT,60),HINT(Parallel_Match),KEEP(2000),HASH);
mjs7_t := mj56+mj57+mj58+mj60;
SALT27.mac_select_best_matches(mjs7_t,RID1,RID2,o7);
SHARED mjs7 := o7 : PERSIST('~temp::HealthCareProviderHeader_prod::LNPID::mj7');

//Fixed fields ->:V_CITY_NAME(11):MNAME(9):FNAME(8)

dn63 := h(~V_CITY_NAME_isnull AND ~MNAME_isnull AND ~FNAME_isnull);
dn63_deduped1 := dn63(V_CITY_NAME_weight100 + MNAME_weight100 + FNAME_weight100>=2200); // Use specificity to flag high-dup counts
dn63_deduped2 := DISTRIBUTE(dn63_deduped1, HASH32(V_CITY_NAME, MNAME, FNAME));
SHARED dn63_deduped3 := SORT(dn63_deduped2, V_CITY_NAME, MNAME, FNAME, HASH64(Constants.iteration_seedval, 63, RID), LOCAL);
dn63_deduped4 := GROUP(dn63_deduped3, V_CITY_NAME, MNAME, FNAME, LOCAL);
dn63_deduped5 := TOPN(dn63_deduped4, 2000, HASH64(Constants.iteration_seedval, 63, RID));
SHARED dn63_deduped6 := UNGROUP(dn63_deduped5);   // selected sources for lhs (lossy)

SHARED dn63_deduped  := dn63_deduped3;   // all targets for rhs (lossless)
SHARED mj63 := JOIN( dn63_deduped6, dn63_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.V_CITY_NAME = RIGHT.V_CITY_NAME AND LEFT.MNAME = RIGHT.MNAME AND LEFT.FNAME = RIGHT.FNAME,match_join(LEFT,RIGHT,63),HINT(Parallel_Match),KEEP(2000),HASH);

//Fixed fields ->:LAT_LONG(10):MNAME(9):FNAME(8)

dn64 := h(~LAT_LONG_isnull AND ~MNAME_isnull AND ~FNAME_isnull);
dn64_deduped1 := dn64(LAT_LONG_weight100 + MNAME_weight100 + FNAME_weight100>=2200); // Use specificity to flag high-dup counts
dn64_deduped2 := DISTRIBUTE(dn64_deduped1, HASH32(LAT_LONG, MNAME, FNAME));
SHARED dn64_deduped3 := SORT(dn64_deduped2, LAT_LONG, MNAME, FNAME, HASH64(Constants.iteration_seedval, 64, RID), LOCAL);
dn64_deduped4 := GROUP(dn64_deduped3, LAT_LONG, MNAME, FNAME, LOCAL);
dn64_deduped5 := TOPN(dn64_deduped4, 2000, HASH64(Constants.iteration_seedval, 64, RID));
SHARED dn64_deduped6 := UNGROUP(dn64_deduped5);   // selected sources for lhs (lossy)

SHARED dn64_deduped  := dn64_deduped3;   // all targets for rhs (lossless)
SHARED mj64 := JOIN( dn64_deduped6, dn64_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.LAT_LONG = RIGHT.LAT_LONG AND LEFT.MNAME = RIGHT.MNAME AND LEFT.FNAME = RIGHT.FNAME,match_join(LEFT,RIGHT,64),HINT(Parallel_Match),KEEP(2000),HASH);
last_mjs_t :=mj63+mj64;
SALT27.mac_select_best_matches(last_mjs_t,RID1,RID2,o);
SHARED all_mjs :=  mjs0+ mjs1+ mjs2+ mjs3+ mjs4+ mjs5+ mjs6+ mjs7 +o;
export All_Matches := all_mjs : PERSIST('~temp::HealthCareProviderHeader_prod_LNPID_HealthProvider_all_m'); // To by used by RID and LNPID
SALT27.mac_avoid_transitives(All_Matches,LNPID1,LNPID2,Conf,DateOverlap,Rule,o);
export PossibleMatches := o : PERSIST('~temp::HealthCareProviderHeader_prod_LNPID_HealthProvider_mt');
SALT27.mac_get_BestPerRecord( All_Matches,RID1,LNPID1,RID2,LNPID2,o );
EXPORT BestPerRecord := o : PERSIST('~temp::HealthCareProviderHeader_prod_LNPID_HealthProvider_mr');
//Now lets see if any slice-outs are needed
too_big := Specificities(ih).ClusterSizes(InCluster>1000); // LNPID that are too big for sliceout
h_ok := JOIN(h,too_big,LEFT.LNPID=RIGHT.LNPID,TRANSFORM(LEFT),LOOKUP,LEFT ONLY);
in_matches := JOIN(h_ok,h_ok,LEFT.LNPID=RIGHT.LNPID AND (>STRING6<)LEFT.RID<>(>STRING6<)RIGHT.RID,match_join(LEFT,RIGHT,9999),LOCAL,HINT(Parallel_Match));
SALT27.mac_cluster_breadth(in_matches,RID1,RID2,LNPID1,o);
o1 := JOIN(o,Specificities(ih).ClusterSizes,LEFT.LNPID1=RIGHT.LNPID,LOCAL);
EXPORT ClusterLinkages := o1 : PERSIST('~temp::HealthCareProviderHeader_prod_LNPID_HealthProvider_clu');
EXPORT ClusterOutcasts := ClusterLinkages(InCluster>1,Closest<MatchThreshold);
//Now find those outcasts that are liked elsewhere ...
Pref_Layout := RECORD
SALT27.UIDType RID;  //Outcast
SALT27.UIDType LNPID;  // Outcase within
INTEGER2 Closest; // Best present link
SALT27.UIDType Pref_RID; // Prefers this record
SALT27.UIDType Pref_LNPID; // Prefers this cluster
INTEGER2 Conf; // Score of new link
integer2 Conf_Prop; // Prop of new link
UNSIGNED2 Pref_Margin; // Extent to which pref is preferred
END;
Pref_Layout note_better(ClusterOutcasts le, BestPerRecord ri) := TRANSFORM
self.RID := le.RID1;
self.LNPID := le.LNPID1;
self.Closest := le.Closest;
self.Pref_RID := ri.RID2;
self.Pref_LNPID := ri.LNPID2;
self.Pref_Margin := ri.Conf-ri.Conf_Prop-le.Closest; // Compute winning margin
SELF := ri;
END;
// Find those records happier in another cluster
CurrentJumpers := JOIN(BestPerRecord,ClusterOutcasts,LEFT.RID1=RIGHT.RID1 AND RIGHT.closest<LEFT.conf-LEFT.conf_prop,note_better(RIGHT,LEFT),HASH);
// No need for record to jump ship if clusters are joinable
WillJoin1 := JOIN(CurrentJumpers,All_Matches(Conf>=MatchThreshold),LEFT.LNPID=RIGHT.LNPID1 AND LEFT.Pref_LNPID=RIGHT.LNPID2,TRANSFORM(LEFT),LEFT ONLY,HASH);
WillJoin2 := JOIN(WillJoin1,All_Matches(Conf>=MatchThreshold),LEFT.LNPID=RIGHT.LNPID2 AND LEFT.Pref_LNPID=RIGHT.LNPID1,TRANSFORM(LEFT),LEFT ONLY,HASH);
EXPORT BetterElsewhere := WillJoin2;
EXPORT ToSlice := DEDUP(SORT(DISTRIBUTE(BetterElsewhere(Pref_Margin>10),HASH(LNPID)),LNPID,-Pref_Margin,LOCAL),LNPID,LOCAL); // 1024x better in new place
SALT27.MAC_Avoid_SliceOuts(PossibleMatches,LNPID1,LNPID2,LNPID,Pref_LNPID,ToSlice,m); // If LNPID is slice target - don't use in match
EXPORT Matches := m(Conf>=MatchThreshold);

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
ut.MAC_Patch_Id(ih,LNPID,BasicMatch(ih).patch_file,LNPID1,LNPID2,ihbp); // Perform basic matches
SALT27.MAC_SliceOut_ByRID(ihbp,RID,LNPID,ToSlice,RID,sliced); // Execute Sliceouts
ut.MAC_Patch_Id(sliced,LNPID,Matches,LNPID1,LNPID2,o); // Join Clusters
bf := Best(ih).In_Flagged; // Input values flagged
TYPEOF(o) AppendFlags(o le,bf ri) := TRANSFORM
SELF.DID_flag := ri.DID_flag; // Either value - or null if no-match
SELF.NPI_NUMBER_flag := ri.NPI_NUMBER_flag; // Either value - or null if no-match
SELF.DEA_NUMBER_flag := ri.DEA_NUMBER_flag; // Either value - or null if no-match
SELF.LIC_NBR_flag := ri.LIC_NBR_flag; // Either value - or null if no-match
SELF.UPIN_flag := ri.UPIN_flag; // Either value - or null if no-match
SELF.ADDR_flag := ri.ADDR_flag; // Either value - or null if no-match
SELF.TAX_ID_flag := ri.TAX_ID_flag; // Either value - or null if no-match
SELF.DOB_flag := ri.DOB_flag; // Either value - or null if no-match
SELF.LNAME_flag := ri.LNAME_flag; // Either value - or null if no-match
SELF.MNAME_flag := ri.MNAME_flag; // Either value - or null if no-match
SELF.FNAME_flag := ri.FNAME_flag; // Either value - or null if no-match
SELF.PHONE_flag := ri.PHONE_flag; // Either value - or null if no-match
SELF := le;
END;
j := JOIN(o,bf,LEFT.LNPID = RIGHT.LNPID AND LEFT.RID = RIGHT.RID,AppendFlags(LEFT,RIGHT),LEFT OUTER); // Only take if cluster id unchanged for record
EXPORT Patched_Infile := j;

//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,LNPID,Matches,LNPID1,LNPID2,o1);
EXPORT Patched_Candidates := o1;

// Now compute a file to show which identifiers have changed from input to output
id_shift_r := RECORD
SALT27.UIDType RID;
SALT27.UIDType LNPID_before;
SALT27.UIDType LNPID_after;
UNSIGNED4 change_date;
END;
id_shift_r note_change(ih le,patched_infile ri) := TRANSFORM
SELF.RID := le.RID;
SELF.LNPID_before := le.LNPID;
SELF.LNPID_after := ri.LNPID;
SELF.change_date := (UNSIGNED4)stringlib.GetDateYYYYMMDD();
END;
EXPORT IdChanges := JOIN(ih,patched_infile,LEFT.RID = RIGHT.RID AND (LEFT.LNPID<>RIGHT.LNPID),note_change(LEFT,RIGHT));
//Now perform the safety checks
EXPORT MatchesPerformed := COUNT( Matches );
EXPORT SlicesPerformed := COUNT( ToSlice );
EXPORT MatchesPropAssisted := COUNT( Matches(Conf_Prop>0) );
EXPORT MatchesPropRequired := COUNT( Matches(Conf-Conf_Prop<MatchThreshold) );
EXPORT PreClusters := hygiene(ih).ClusterCounts;
EXPORT PostClusters := hygiene(Patched_Infile).ClusterCounts;
EXPORT PrePatchIdCount := SUM( PreClusters, NumberOfClusters );
EXPORT PostPatchIdCount := SUM( PostClusters, NumberOfClusters );
EXPORT PatchingError0 := PrePatchIdCount - PostPatchIdCount - MatchesPerformed - COUNT(BasicMatch(ih).patch_file) + SlicesPerformed; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile) - COUNT(DEDUP(Patched_Infile,RID,ALL)); // Should be zero
EXPORT DidsNoRid0 := PostPatchIdCount - COUNT(Patched_Infile(LNPID=RID)); // Should be zero
EXPORT DidsAboveRid0 := COUNT(Patched_Infile(LNPID>RID)); // Should be zero

EXPORT mjInfoRs := DATASET(
  [
      {0, RuleText(0), COUNT(dn0_deduped6), COUNT(dn0_deduped), COUNT(mj0)},
      {1, RuleText(1), COUNT(dn1_deduped6), COUNT(dn1_deduped), COUNT(mj1)},
      {2, RuleText(2), COUNT(dn2_deduped6), COUNT(dn2_deduped), COUNT(mj2)},
      {3, RuleText(3), COUNT(dn3_deduped6), COUNT(dn3_deduped), COUNT(mj3)},
      {4, RuleText(4), COUNT(dn4_deduped6), COUNT(dn4_deduped), COUNT(mj4)},
      {15, RuleText(15), COUNT(dn15_deduped6), COUNT(dn15_deduped), COUNT(mj15)},
      {25, RuleText(25), COUNT(dn25_deduped6), COUNT(dn25_deduped), COUNT(mj25)},
      {34, RuleText(34), COUNT(dn34_deduped6), COUNT(dn34_deduped), COUNT(mj34)},
      {35, RuleText(35), COUNT(dn35_deduped6), COUNT(dn35_deduped), COUNT(mj35)},
      {36, RuleText(36), COUNT(dn36_deduped6), COUNT(dn36_deduped), COUNT(mj36)},
      {37, RuleText(37), COUNT(dn37_deduped6), COUNT(dn37_deduped), COUNT(mj37)},
      {38, RuleText(38), COUNT(dn38_deduped6), COUNT(dn38_deduped), COUNT(mj38)},
      {39, RuleText(39), COUNT(dn39_deduped6), COUNT(dn39_deduped), COUNT(mj39)},
      {40, RuleText(40), COUNT(dn40_deduped6), COUNT(dn40_deduped), COUNT(mj40)},
      {41, RuleText(41), COUNT(dn41_deduped6), COUNT(dn41_deduped), COUNT(mj41)},
      {44, RuleText(44), COUNT(dn44_deduped6), COUNT(dn44_deduped), COUNT(mj44)},
      {47, RuleText(47), COUNT(dn47_deduped6), COUNT(dn47_deduped), COUNT(mj47)},
      {48, RuleText(48), COUNT(dn48_deduped6), COUNT(dn48_deduped), COUNT(mj48)},
      {49, RuleText(49), COUNT(dn49_deduped6), COUNT(dn49_deduped), COUNT(mj49)},
      {52, RuleText(52), COUNT(dn52_deduped6), COUNT(dn52_deduped), COUNT(mj52)},
      {53, RuleText(53), COUNT(dn53_deduped6), COUNT(dn53_deduped), COUNT(mj53)},
      {56, RuleText(56), COUNT(dn56_deduped6), COUNT(dn56_deduped), COUNT(mj56)},
      {57, RuleText(57), COUNT(dn57_deduped6), COUNT(dn57_deduped), COUNT(mj57)},
      {58, RuleText(58), COUNT(dn58_deduped6), COUNT(dn58_deduped), COUNT(mj58)},
      {60, RuleText(60), COUNT(dn60_deduped6), COUNT(dn60_deduped), COUNT(mj60)},
      {63, RuleText(63), COUNT(dn63_deduped6), COUNT(dn63_deduped), COUNT(mj63)},
      {64, RuleText(64), COUNT(dn64_deduped6), COUNT(dn64_deduped), COUNT(mj64)}
  ],
  {
      unsigned  ruleid,
      string    rule_desc,
      unsigned8 source_cnt,
      unsigned8 target_cnt,
      unsigned8 join_cnt
  });
END;
