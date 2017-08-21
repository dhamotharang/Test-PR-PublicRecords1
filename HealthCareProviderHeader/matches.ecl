// Begin code to perform the matching itself
IMPORT SALT29,ut,std;
EXPORT matches(DATASET(layout_HealthProvider) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED2 c,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.LNPID1 := le.LNPID;
  SELF.LNPID2 := ri.LNPID;
  SELF.RID1 := le.RID;
  SELF.RID2 := ri.RID;
  SELF.DateOverlap := SALT29.fn_ComputeDateOverlap(((UNSIGNED)le.DT_FIRST_SEEN)*100,((UNSIGNED)le.DT_LAST_SEEN)*100,((UNSIGNED)ri.DT_FIRST_SEEN)*100,((UNSIGNED)ri.DT_LAST_SEEN)*100);
  INTEGER2 SSN_score := MAP( le.SSN_isnull OR ri.SSN_isnull => 0,
                        le.SSN = ri.SSN  => le.SSN_weight100,
                        SALT29.WithinEditN(le.SSN,ri.SSN,1,0) => SALT29.fn_fuzzy_specificity(le.SSN_weight100,le.SSN_cnt, le.SSN_e1_cnt,ri.SSN_weight100,ri.SSN_cnt,ri.SSN_e1_cnt),
                        le.SSN_Right4 = ri.SSN_Right4 => SALT29.fn_fuzzy_specificity(le.SSN_weight100,le.SSN_cnt, le.SSN_Right4_cnt,ri.SSN_weight100,ri.SSN_cnt,ri.SSN_Right4_cnt),
                        SALT29.Fn_Fail_Scale(le.SSN_weight100,s.SSN_switch));
  INTEGER2 UPIN_score_temp := MAP( le.UPIN_isnull OR ri.UPIN_isnull => 0,
                        le.UPIN = ri.UPIN  => le.UPIN_weight100,
                        SALT29.Fn_Fail_Scale(le.UPIN_weight100,s.UPIN_switch));
  INTEGER2 NPI_NUMBER_score_temp := MAP( le.NPI_NUMBER_isnull OR ri.NPI_NUMBER_isnull => 0,
                        le.NPI_NUMBER = ri.NPI_NUMBER  => le.NPI_NUMBER_weight100,
                        SALT29.Fn_Fail_Scale(le.NPI_NUMBER_weight100,s.NPI_NUMBER_switch));
  INTEGER2 DEA_NUMBER_score := MAP( le.DEA_NUMBER_isnull OR ri.DEA_NUMBER_isnull => 0,
                        le.DEA_NUMBER = ri.DEA_NUMBER  => le.DEA_NUMBER_weight100,
                        0 /* switch0 */);
  INTEGER2 DID_score_temp := MAP( le.DID_isnull OR ri.DID_isnull => 0,
                        le.DID = ri.DID  => le.DID_weight100,
                        0 /* switch0 */);
  INTEGER2 VENDOR_ID_score_temp := MAP( le.VENDOR_ID_isnull OR ri.VENDOR_ID_isnull => 0,
                        le.SRC <> ri.SRC => 0, // Only valid if the context variable is equal
                        le.VENDOR_ID = ri.VENDOR_ID  => le.VENDOR_ID_weight100,
                        0 /* switch0 */);
  INTEGER2 CNSMR_SSN_score_temp := MAP( le.CNSMR_SSN_isnull OR ri.CNSMR_SSN_isnull => 0,
                        le.VENDOR_ID <> ri.VENDOR_ID => 0, // Only valid if the context variable is equal
                        le.CNSMR_SSN = ri.CNSMR_SSN  => le.CNSMR_SSN_weight100,
                        0 /* switch0 */);
  REAL FULLNAME_score_scale := ( le.FULLNAME_weight100 + ri.FULLNAME_weight100 ) / (le.MAINNAME_weight100 + ri.MAINNAME_weight100 + le.SNAME_weight100 + ri.SNAME_weight100); // Scaling factor for this concept
  INTEGER2 FULLNAME_score_pre := MAP( (le.FULLNAME_isnull OR (le.MAINNAME_isnull OR le.FNAME_isnull AND le.MNAME_isnull AND le.LNAME_isnull) AND le.SNAME_isnull) OR (ri.FULLNAME_isnull OR (ri.MAINNAME_isnull OR ri.FNAME_isnull AND ri.MNAME_isnull AND ri.LNAME_isnull) AND ri.SNAME_isnull) OR le.FULLNAME_weight100 = 0 => 0,
                        le.FULLNAME = ri.FULLNAME  => le.FULLNAME_weight100,
                        0);
  INTEGER2 FAX_score_temp := MAP( le.FAX_isnull OR ri.FAX_isnull => 0,
                        le.FNAME <> ri.FNAME => 0, // Only valid if the context variable is equal
                        le.FAX = ri.FAX  => le.FAX_weight100,
                        0 /* switch0 */);
  INTEGER2 C_LIC_NBR_score := MAP( le.C_LIC_NBR_isnull OR ri.C_LIC_NBR_isnull => 0,
                        le.LIC_STATE <> ri.LIC_STATE => 0, // Only valid if the context variable is equal
                        le.C_LIC_NBR = ri.C_LIC_NBR  => le.C_LIC_NBR_weight100,
                        SALT29.WithinEditN(le.C_LIC_NBR,ri.C_LIC_NBR,1,0) => SALT29.fn_fuzzy_specificity(le.C_LIC_NBR_weight100,le.C_LIC_NBR_cnt, le.C_LIC_NBR_e1_cnt,ri.C_LIC_NBR_weight100,ri.C_LIC_NBR_cnt,ri.C_LIC_NBR_e1_cnt),
                        0 /* switch0 */);
  REAL ADDRESS_score_scale := ( le.ADDRESS_weight100 + ri.ADDRESS_weight100 ) / (le.ADDR1_weight100 + ri.ADDR1_weight100 + le.LOCALE_weight100 + ri.LOCALE_weight100); // Scaling factor for this concept
  INTEGER2 ADDRESS_score_pre := MAP( (le.ADDRESS_isnull OR (le.ADDR1_isnull OR le.PRIM_RANGE_isnull AND le.SEC_RANGE_isnull AND le.PRIM_NAME_isnull) AND (le.LOCALE_isnull OR le.V_CITY_NAME_isnull AND le.ST_isnull AND le.ZIP_isnull)) OR (ri.ADDRESS_isnull OR (ri.ADDR1_isnull OR ri.PRIM_RANGE_isnull AND ri.SEC_RANGE_isnull AND ri.PRIM_NAME_isnull) AND (ri.LOCALE_isnull OR ri.V_CITY_NAME_isnull AND ri.ST_isnull AND ri.ZIP_isnull)) => 0,
                        le.ADDRESS = ri.ADDRESS  => le.ADDRESS_weight100,
                        0);
  REAL ADDR1_score_scale := ( le.ADDR1_weight100 + ri.ADDR1_weight100 ) / (le.PRIM_RANGE_weight100 + ri.PRIM_RANGE_weight100 + le.SEC_RANGE_weight100 + ri.SEC_RANGE_weight100 + le.PRIM_NAME_weight100 + ri.PRIM_NAME_weight100); // Scaling factor for this concept
  INTEGER2 ADDR1_score_pre := MAP( (le.ADDR1_isnull OR le.PRIM_RANGE_isnull AND le.SEC_RANGE_isnull AND le.PRIM_NAME_isnull) OR (ri.ADDR1_isnull OR ri.PRIM_RANGE_isnull AND ri.SEC_RANGE_isnull AND ri.PRIM_NAME_isnull) => 0,
                        ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.ADDR1 = ri.ADDR1  => le.ADDR1_weight100,
                        0)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 PHONE_score_temp := MAP( le.PHONE_isnull OR ri.PHONE_isnull => 0,
                        le.FNAME <> ri.FNAME => 0, // Only valid if the context variable is equal
                        le.PHONE = ri.PHONE  => le.PHONE_weight100,
                        0 /* switch0 */);
  INTEGER2 DOB_year       := MAP ( le.DOB_year_isnull or ri.DOB_year_isnull => 0,
                                  le.DOB_year = ri.DOB_year => le.DOB_year_weight100,
                                  SALT29.Fn_YearMatch(le.DOB_year,ri.DOB_year,12) => le.DOB_year_weight100-358, // assumes even year distribution - so 3x less specific
                                  SALT29.fn_fail_scale(le.DOB_year_weight100,s.DOB_year_switch) );
  INTEGER2 DOB_month       := MAP ( le.DOB_month_isnull or ri.DOB_month_isnull => 0,
                                  le.DOB_month = ri.DOB_month => le.DOB_month_weight100,
                                  le.DOB_month = ri.DOB_day AND le.DOB_day = ri.DOB_month => le.DOB_month_weight100-100, // Performing M-D switch
                                  le.DOB_Day <= 1 AND le.DOB_Month = 1 OR ri.DOB_Day <= 1 AND le.DOB_Month = 1 => -200, // Month may be a soft 1 if day is ... 
                                  le.dob_year = ri.dob_year and (le.DOB_Month = 1 OR ri.DOB_Month = 1) => -200, // Month may be a soft 1 if day is ... 																	                                  	                                 																																		
																	SALT29.fn_fail_scale(le.DOB_month_weight100,s.DOB_month_switch) );
  INTEGER2 DOB_day       := MAP ( le.DOB_day_isnull or ri.DOB_day_isnull => 0,
                                  le.DOB_day = ri.DOB_day => le.DOB_day_weight100,
                                  le.DOB_day = ri.DOB_month AND le.DOB_month = ri.DOB_day => le.DOB_day_weight100-100, // Performing M-D switch
                                  le.DOB_Day = 1 OR ri.DOB_Day = 1 => -200, // Treating as a 'soft' 1
                                  SALT29.fn_fail_scale(le.DOB_day_weight100,s.DOB_day_switch) );
  INTEGER2 DOB_score_temp := (DOB_year+DOB_month+DOB_day);
  INTEGER2 DOB_score := MAP( le.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND le.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND le.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) or ri.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND ri.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND ri.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) => 0,
                        DOB_year+DOB_month+DOB_day < 0 or DOB_year+DOB_month+DOB_day<>0 and DOB_year+DOB_month+DOB_day < 300 => SKIP,
                        DOB_year < 0 and ABS(le.DOB_year-ri.DOB_year) > 13 => SKIP, // Do not allow full generation mis-match
                        DOB_score_temp);
  INTEGER2 CNSMR_DOB_year       := MAP ( le.CNSMR_DOB_year_isnull or ri.CNSMR_DOB_year_isnull => 0,
                                  le.CNSMR_DOB_year = ri.CNSMR_DOB_year => le.CNSMR_DOB_year_weight100,
                                  0 ); // Switch0 
  INTEGER2 CNSMR_DOB_month       := MAP ( le.CNSMR_DOB_month_isnull or ri.CNSMR_DOB_month_isnull => 0,
                                  le.CNSMR_DOB_month = ri.CNSMR_DOB_month => le.CNSMR_DOB_month_weight100,
                                  le.CNSMR_DOB_Day <= 1 AND le.CNSMR_DOB_Month = 1 OR ri.CNSMR_DOB_Day <= 1 AND le.CNSMR_DOB_Month = 1 => -200, // Month may be a soft 1 if day is ... 
                                  0 ); // Switch0 
  INTEGER2 CNSMR_DOB_day       := MAP ( le.CNSMR_DOB_day_isnull or ri.CNSMR_DOB_day_isnull => 0,
                                  le.CNSMR_DOB_day = ri.CNSMR_DOB_day => le.CNSMR_DOB_day_weight100,
                                  le.CNSMR_DOB_Day = 1 OR ri.CNSMR_DOB_Day = 1 => -200, // Treating as a 'soft' 1
                                  0 ); // Switch0 
  INTEGER2 CNSMR_DOB_score_temp := (CNSMR_DOB_year+CNSMR_DOB_month+CNSMR_DOB_day);
  INTEGER2 CNSMR_DOB_score_unweighted := MAP( le.CNSMR_DOB_year  IN SET(s.nulls_CNSMR_DOB_year,CNSMR_DOB_year) AND le.CNSMR_DOB_month  IN SET(s.nulls_CNSMR_DOB_month,CNSMR_DOB_month) AND le.CNSMR_DOB_day  IN SET(s.nulls_CNSMR_DOB_day,CNSMR_DOB_day) or ri.CNSMR_DOB_year  IN SET(s.nulls_CNSMR_DOB_year,CNSMR_DOB_year) AND ri.CNSMR_DOB_month  IN SET(s.nulls_CNSMR_DOB_month,CNSMR_DOB_month) AND ri.CNSMR_DOB_day  IN SET(s.nulls_CNSMR_DOB_day,CNSMR_DOB_day) => 0,
                        le.VENDOR_ID <> ri.VENDOR_ID => 0, // Only valid if the context variable is equal
                        CNSMR_DOB_score_temp);
  INTEGER2 CNSMR_DOB_score := CNSMR_DOB_score_unweighted*0.50; 
  INTEGER2 BILLING_TAX_ID_score_temp := MAP( le.BILLING_TAX_ID_isnull OR ri.BILLING_TAX_ID_isnull => 0,
                        le.FNAME <> ri.FNAME => 0, // Only valid if the context variable is equal
                        le.BILLING_TAX_ID = ri.BILLING_TAX_ID  => le.BILLING_TAX_ID_weight100,
                        0 /* switch0 */);
  INTEGER2 BILLING_NPI_NUMBER_score_temp := MAP( le.BILLING_NPI_NUMBER_isnull OR ri.BILLING_NPI_NUMBER_isnull => 0,
                        le.FNAME <> ri.FNAME => 0, // Only valid if the context variable is equal
                        le.BILLING_NPI_NUMBER = ri.BILLING_NPI_NUMBER  => le.BILLING_NPI_NUMBER_weight100,
                        0 /* switch0 */);
  INTEGER2 PRIM_NAME_score := MAP( le.PRIM_NAME_isnull OR ri.PRIM_NAME_isnull => 0,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.PRIM_NAME = ri.PRIM_NAME  => le.PRIM_NAME_weight100,
                        0 /* switch0 */)*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  REAL LOCALE_score_scale := ( le.LOCALE_weight100 + ri.LOCALE_weight100 ) / (le.V_CITY_NAME_weight100 + ri.V_CITY_NAME_weight100 + le.ST_weight100 + ri.ST_weight100 + le.ZIP_weight100 + ri.ZIP_weight100); // Scaling factor for this concept
  INTEGER2 LOCALE_score_pre := MAP( (le.LOCALE_isnull OR le.V_CITY_NAME_isnull AND le.ST_isnull AND le.ZIP_isnull) OR (ri.LOCALE_isnull OR ri.V_CITY_NAME_isnull AND ri.ST_isnull AND ri.ZIP_isnull) => 0,
                        ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.LOCALE = ri.LOCALE  => le.LOCALE_weight100,
                        0)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 PRIM_RANGE_score := MAP( le.PRIM_RANGE_isnull OR ri.PRIM_RANGE_isnull => 0,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.PRIM_RANGE = ri.PRIM_RANGE  => le.PRIM_RANGE_weight100,
                        0 /* switch0 */)*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 V_CITY_NAME_score := MAP( le.V_CITY_NAME_isnull OR ri.V_CITY_NAME_isnull => 0,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.V_CITY_NAME = ri.V_CITY_NAME  => le.V_CITY_NAME_weight100,
                        0 /* switch0 */)*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 LAT_LONG_score_temp := MAP( le.LAT_LONG_isnull OR ri.LAT_LONG_isnull => 0,
                        le.FNAME <> ri.FNAME => 0, // Only valid if the context variable is equal
                        le.LAT_LONG = ri.LAT_LONG  => le.LAT_LONG_weight100,
                        SALT29.Fn_LL_DistanceScore(le.LAT_LONG,le.LAT_LONG_ranges,ri.LAT_LONG,ri.LAT_LONG_ranges,1) > 0 => SALT29.Fn_LL_DistanceScore(le.LAT_LONG,le.LAT_LONG_ranges,ri.LAT_LONG,ri.LAT_LONG_ranges,1),
                        0 /* switch0 */);
  INTEGER2 SNAME_score_temp := MAP( le.SNAME_isnull OR ri.SNAME_isnull => 0,
                        FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.SNAME = ri.SNAME  => le.SNAME_weight100,
                        le.SNAME_NormSuffix = ri.SNAME_NormSuffix => SALT29.fn_fuzzy_specificity(le.SNAME_weight100,le.SNAME_cnt, le.SNAME_NormSuffix_cnt,ri.SNAME_weight100,ri.SNAME_cnt,ri.SNAME_NormSuffix_cnt),
                        SALT29.Fn_Fail_Scale(le.SNAME_weight100,s.SNAME_switch))*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
  INTEGER2 TAXONOMY_score := MAP( le.TAXONOMY_isnull OR ri.TAXONOMY_isnull => 0,
                        le.FNAME <> ri.FNAME => 0, // Only valid if the context variable is equal
                        le.TAXONOMY = ri.TAXONOMY  => le.TAXONOMY_weight100,
                        0 /* switch0 */);
  INTEGER2 SEC_RANGE_score := MAP( le.SEC_RANGE_isnull OR ri.SEC_RANGE_isnull => 0,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.SEC_RANGE = ri.SEC_RANGE OR SALT29.HyphenMatch(le.SEC_RANGE,ri.SEC_RANGE,1)<=2  => MIN(le.SEC_RANGE_weight100,ri.SEC_RANGE_weight100),
                        0 /* switch0 */)*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 LIC_TYPE_score_temp := MAP( le.LIC_TYPE_isnull OR ri.LIC_TYPE_isnull => 0,
                        le.VENDOR_ID <> ri.VENDOR_ID => 0, // Only valid if the context variable is equal
                        le.LIC_TYPE = ri.LIC_TYPE  => le.LIC_TYPE_weight100,
                        SALT29.MatchBagOfWords(le.LIC_TYPE,ri.LIC_TYPE,32019,1));
  INTEGER2 ST_score := MAP( le.ST_isnull OR ri.ST_isnull => 0,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.ST = ri.ST  => le.ST_weight100,
                        0 /* switch0 */)*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 GENDER_score := MAP( le.GENDER_isnull OR ri.GENDER_isnull => 0,
                        le.GENDER = ri.GENDER  => le.GENDER_weight100,
                        SALT29.Fn_Fail_Scale(le.GENDER_weight100,s.GENDER_switch));
  INTEGER2 DERIVED_GENDER_score := MAP( le.DERIVED_GENDER_isnull OR ri.DERIVED_GENDER_isnull => 0,
                        le.DERIVED_GENDER = ri.DERIVED_GENDER  => le.DERIVED_GENDER_weight100,
                         -5000);
  INTEGER2 TAX_ID_score := MAP( le.TAX_ID_isnull OR ri.TAX_ID_isnull => 0,
                        le.FNAME <> ri.FNAME => 0, // Only valid if the context variable is equal
                        le.TAX_ID = ri.TAX_ID  => le.TAX_ID_weight100,
                        0 /* switch0 */);
  INTEGER2 UPIN_score := IF ( UPIN_score_temp >= Config.UPIN_Force * 100, UPIN_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 NPI_NUMBER_score := IF ( NPI_NUMBER_score_temp >= Config.NPI_NUMBER_Force * 100, NPI_NUMBER_score_temp, SKIP ); // Enforce FORCE parameter
	INTEGER2 DID_score := map (le.SRC = '64' and ri.src = '64' and Vendor_ID_Score_temp > 1500 => DID_score_temp, 
														 le.SRC = 'NP' and ri.SRC = 'NP' and Vendor_ID_Score_temp > 1500 => DID_score_temp, 
														 le.SRC = 'DA' and ri.SRC = 'DA' and Vendor_ID_Score_temp > 1500 => DID_score_temp, 
														 DID_score_temp*0.25);
	INTEGER2 VENDOR_ID_score := map (le.SRC = '64' and ri.src = '64' => Vendor_ID_Score_temp,
																	 le.SRC = 'NP' and ri.SRC = 'NP' => VENDOR_ID_score_temp*0.50,
																	 le.SRC = 'DA' and ri.SRC = 'DA' => VENDOR_ID_score_temp*0.50, 															 
																	 VENDOR_ID_score_temp*0.25);
  INTEGER2 CNSMR_SSN_score := CNSMR_SSN_score_temp*0.50; 
  REAL MAINNAME_score_scale := ( le.MAINNAME_weight100 + ri.MAINNAME_weight100 ) / (le.FNAME_weight100 + ri.FNAME_weight100 + le.MNAME_weight100 + ri.MNAME_weight100 + le.LNAME_weight100 + ri.LNAME_weight100); // Scaling factor for this concept
  INTEGER2 MAINNAME_score_pre := MAP( (le.MAINNAME_isnull OR le.FNAME_isnull AND le.MNAME_isnull AND le.LNAME_isnull) OR (ri.MAINNAME_isnull OR ri.FNAME_isnull AND ri.MNAME_isnull AND ri.LNAME_isnull) => 0,
                        FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.MAINNAME = ri.MAINNAME  => le.MAINNAME_weight100,
                        SALT29.fn_concept_wordbag_EditN.Match3((SALT29.StrType)ri.FNAME,ri.FNAME_MAINNAME_weight100,true,0,true,1,(SALT29.StrType)ri.MNAME,ri.MNAME_MAINNAME_weight100,true,0,true,1,(SALT29.StrType)ri.LNAME,ri.LNAME_MAINNAME_weight100,true,0,true,1,(SALT29.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,(SALT29.StrType)le.MNAME,le.MNAME_MAINNAME_weight100,(SALT29.StrType)le.LNAME,le.LNAME_MAINNAME_weight100)*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale))*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
  INTEGER2 FAX_score := FAX_score_temp*0.50; 
  INTEGER2 PHONE_score := PHONE_score_temp*0.50; 
  INTEGER2 BILLING_TAX_ID_score := BILLING_TAX_ID_score_temp*0.50; 
  INTEGER2 BILLING_NPI_NUMBER_score := BILLING_NPI_NUMBER_score_temp*0.50; 
  INTEGER2 ZIP_score := MAP( le.ZIP_isnull OR ri.ZIP_isnull => 0,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.ZIP = ri.ZIP  => le.ZIP_weight100,
                        0 /* switch0 */)*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 LNAME_score := MAP( le.LNAME_isnull OR ri.LNAME_isnull => 0,
                        MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.LNAME = ri.LNAME OR SALT29.HyphenMatch(le.LNAME,ri.LNAME,1)<=2  => MIN(le.LNAME_weight100,ri.LNAME_weight100),
                        SALT29.WithinEditN(le.LNAME,ri.LNAME,1,0) => SALT29.fn_fuzzy_specificity(le.LNAME_weight100,le.LNAME_cnt, le.LNAME_e1_cnt,ri.LNAME_weight100,ri.LNAME_cnt,ri.LNAME_e1_cnt),
                        LENGTH(TRIM(le.LNAME))>0 and le.LNAME = ri.LNAME[1..LENGTH(TRIM(le.LNAME))] => le.LNAME_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.LNAME))>0 and ri.LNAME = le.LNAME[1..LENGTH(TRIM(ri.LNAME))] => ri.LNAME_weight100, // An initial match - take initial specificity
                        SALT29.Fn_Fail_Scale(le.LNAME_weight100,s.LNAME_switch))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
  INTEGER2 LAT_LONG_score := LAT_LONG_score_temp*0.75; 
  INTEGER2 FNAME_score := MAP( le.FNAME_isnull OR ri.FNAME_isnull => 0,
                        MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.FNAME = ri.FNAME  => le.FNAME_weight100,
                        SALT29.WithinEditN(le.FNAME,ri.FNAME,1,0) => SALT29.fn_fuzzy_specificity(le.FNAME_weight100,le.FNAME_cnt, le.FNAME_e1_cnt,ri.FNAME_weight100,ri.FNAME_cnt,ri.FNAME_e1_cnt),
                        LENGTH(TRIM(le.FNAME))>0 and le.FNAME = ri.FNAME[1..LENGTH(TRIM(le.FNAME))] => le.FNAME_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.FNAME))>0 and ri.FNAME = le.FNAME[1..LENGTH(TRIM(ri.FNAME))] => ri.FNAME_weight100, // An initial match - take initial specificity
                        le.FNAME_PreferredName = ri.FNAME_PreferredName => SALT29.fn_fuzzy_specificity(le.FNAME_weight100,le.FNAME_cnt, le.FNAME_PreferredName_cnt,ri.FNAME_weight100,ri.FNAME_cnt,ri.FNAME_PreferredName_cnt),
                        SALT29.Fn_Fail_Scale(le.FNAME_weight100,s.FNAME_switch))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
  INTEGER2 MNAME_score := MAP( le.MNAME_isnull OR ri.MNAME_isnull => 0,
                        MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.MNAME = ri.MNAME  => le.MNAME_weight100,
                        SALT29.WithinEditN(le.MNAME,ri.MNAME,1,0) => SALT29.fn_fuzzy_specificity(le.MNAME_weight100,le.MNAME_cnt, le.MNAME_e1_cnt,ri.MNAME_weight100,ri.MNAME_cnt,ri.MNAME_e1_cnt),
                        LENGTH(TRIM(le.MNAME))>0 and le.MNAME = ri.MNAME[1..LENGTH(TRIM(le.MNAME))] => le.MNAME_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.MNAME))>0 and ri.MNAME = le.MNAME[1..LENGTH(TRIM(ri.MNAME))] => ri.MNAME_weight100, // An initial match - take initial specificity
                        SALT29.Fn_Fail_Scale(le.MNAME_weight100,s.MNAME_switch))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
	INTEGER2 SNAME_score := IF ( SNAME_score_temp >= Config.SNAME_Force * 100, SNAME_score_temp, SKIP ); // Enforce FORCE parameter																								
  INTEGER2 LIC_TYPE_score := LIC_TYPE_score_temp*0.75; 
// Compute the score for the concept ADDR1
  INTEGER2 ADDR1_score_ext := MAX(ADDR1_score_pre,0) + PRIM_RANGE_score + SEC_RANGE_score + PRIM_NAME_score + MAX(ADDRESS_score_pre,0);// Score in surrounding context
  INTEGER2 ADDR1_score_res := MAX(0,ADDR1_score_pre); // At least nothing
  INTEGER2 ADDR1_score := ADDR1_score_res;
// Compute the score for the concept LOCALE
  INTEGER2 LOCALE_score_ext := MAX(LOCALE_score_pre,0) + V_CITY_NAME_score + ST_score + ZIP_score + MAX(ADDRESS_score_pre,0);// Score in surrounding context
  INTEGER2 LOCALE_score_res := MAX(0,LOCALE_score_pre); // At least nothing
  INTEGER2 LOCALE_score := LOCALE_score_res;
// Compute the score for the concept MAINNAME
  INTEGER2 MAINNAME_score_ext := MAX(MAINNAME_score_pre,0) + FNAME_score + MNAME_score + LNAME_score + MAX(FULLNAME_score_pre,0);// Score in surrounding context
  INTEGER2 MAINNAME_score_res := MAX(0,MAINNAME_score_pre); // At least nothing
  INTEGER2 MAINNAME_score := MAINNAME_score_res;
// Compute the score for the concept FULLNAME
  INTEGER2 FULLNAME_score_ext := MAX(FULLNAME_score_pre,0)+ MAINNAME_score + FNAME_score + MNAME_score + LNAME_score + SNAME_score;// Score in surrounding context
  INTEGER2 FULLNAME_score_res := MAX(0,FULLNAME_score_pre); // At least nothing
  INTEGER2 FULLNAME_score := IF ( FULLNAME_score_ext > -300 OR ( SSN_score > Config.SSN_Force*100 AND  DOB_score > Config.DOB_Force*100 AND  FNAME_score > Config.FNAME_Force*100) OR ( NPI_NUMBER_score > Config.NPI_NUMBER_Force*100 AND  DOB_score > Config.DOB_Force*100 AND  FNAME_score > Config.FNAME_Force*100) OR ( DEA_NUMBER_score > Config.DEA_NUMBER_Force*100 AND  DOB_score > Config.DOB_Force*100 AND  FNAME_score > Config.FNAME_Force*100) OR ( C_LIC_NBR_score > Config.C_LIC_NBR_Force*100 AND  DOB_score > Config.DOB_Force*100 AND  FNAME_score > Config.FNAME_Force*100) OR ( UPIN_score > Config.UPIN_Force*100 AND  DOB_score > Config.DOB_Force*100 AND  FNAME_score > Config.FNAME_Force*100) OR ( C_LIC_NBR_score > Config.C_LIC_NBR_Force*100 AND  LIC_TYPE_score > Config.LIC_TYPE_Force*100 AND  VENDOR_ID_score > Config.VENDOR_ID_Force*100) OR ( NPI_NUMBER_score > Config.NPI_NUMBER_Force*100) OR ( UPIN_score > Config.UPIN_Force*100),FULLNAME_score_res,SKIP);
// Compute the score for the concept ADDRESS
  INTEGER2 ADDRESS_score_ext := MAX(ADDRESS_score_pre,0)+ ADDR1_score + PRIM_RANGE_score + SEC_RANGE_score + PRIM_NAME_score+ LOCALE_score + V_CITY_NAME_score + ST_score + ZIP_score;// Score in surrounding context
  INTEGER2 ADDRESS_score_res := MAX(0,ADDRESS_score_pre); // At least nothing
  INTEGER2 ADDRESS_score := ADDRESS_score_res;
  SELF.Conf_Prop := (0
    +MAX(le.SSN_prop,ri.SSN_prop)*SSN_score // Score if either field propogated
    +MAX(le.UPIN_prop,ri.UPIN_prop)*UPIN_score // Score if either field propogated
    +MAX(le.NPI_NUMBER_prop,ri.NPI_NUMBER_prop)*NPI_NUMBER_score // Score if either field propogated
    +MAX(le.DEA_NUMBER_prop,ri.DEA_NUMBER_prop)*DEA_NUMBER_score // Score if either field propogated
    +if(le.FULLNAME_prop+ri.FULLNAME_prop>0,FULLNAME_score*(0+if(le.SNAME_prop+ri.SNAME_prop>0,1,0))/2,0)
    +DOB_score*(IF( (le.DOB_prop|ri.DOB_prop)&4>0,6,0 )+IF( (le.DOB_prop|ri.DOB_prop)&2>0,4,0 )+IF( (le.DOB_prop|ri.DOB_prop)&1>0,5,0 ))/15 // Compute weight of year/month/day propogation independantly
    +MAX(le.BILLING_TAX_ID_prop,ri.BILLING_TAX_ID_prop)*BILLING_TAX_ID_score // Score if either field propogated
    +MAX(le.BILLING_NPI_NUMBER_prop,ri.BILLING_NPI_NUMBER_prop)*BILLING_NPI_NUMBER_score // Score if either field propogated
    +MAX(le.SNAME_prop,ri.SNAME_prop)*SNAME_score // Score if either field propogated
    +MAX(le.DERIVED_GENDER_prop,ri.DERIVED_GENDER_prop)*DERIVED_GENDER_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  iComp := (SSN_score + UPIN_score + NPI_NUMBER_score + DEA_NUMBER_score + DID_score + VENDOR_ID_score + CNSMR_SSN_score + MAX(FULLNAME_score,MAX(MAINNAME_score,FNAME_score + MNAME_score + LNAME_score) + SNAME_score) + FAX_score + C_LIC_NBR_score + MAX(ADDRESS_score,MAX(ADDR1_score,PRIM_RANGE_score + SEC_RANGE_score + PRIM_NAME_score) + MAX(LOCALE_score,V_CITY_NAME_score + ST_score + ZIP_score)) + PHONE_score + DOB_score + CNSMR_DOB_score + BILLING_TAX_ID_score + BILLING_NPI_NUMBER_score + LAT_LONG_score + TAXONOMY_score + LIC_TYPE_score + GENDER_score + DERIVED_GENDER_score + TAX_ID_score) / 100 + outside;
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
SHARED RuleText(UNSIGNED n) :=  MAP (
  n = 0 => ':SSN',
  n = 1 => ':UPIN',
  n = 2 => ':NPI_NUMBER',
  n = 3 => ':DEA_NUMBER',
  n = 4 => ':DID',
  n = 5 => ':VENDOR_ID',
  n = 6 => ':CNSMR_SSN',
  n = 7 => ':FAX',
  n = 8 => ':C_LIC_NBR:*',
  n = 23 => ':PHONE:*',
  n = 37 => ':DOB:*',
  n = 50 => ':CNSMR_DOB:*',
  n = 62 => ':BILLING_TAX_ID:*',
  n = 73 => ':BILLING_NPI_NUMBER:*',
  n = 83 => ':PRIM_NAME:ZIP',
  n = 84 => ':PRIM_NAME:LNAME',
  n = 85 => ':PRIM_NAME:PRIM_RANGE',
  n = 86 => ':PRIM_NAME:V_CITY_NAME',
  n = 87 => ':PRIM_NAME:LAT_LONG',
  n = 88 => ':PRIM_NAME:SNAME',
  n = 89 => ':PRIM_NAME:FNAME',
  n = 90 => ':PRIM_NAME:MNAME',
  n = 91 => ':ZIP:LNAME',
  n = 92 => ':ZIP:PRIM_RANGE',
  n = 93 => ':ZIP:V_CITY_NAME',
  n = 94 => ':ZIP:LAT_LONG',
  n = 95 => ':ZIP:SNAME:*',
  n = 98 => ':ZIP:FNAME:*',
  n = 100 => ':ZIP:MNAME:TAXONOMY',
  n = 101 => ':LNAME:PRIM_RANGE',
  n = 102 => ':LNAME:V_CITY_NAME',
  n = 103 => ':LNAME:LAT_LONG',
  n = 104 => ':LNAME:SNAME:*',
  n = 107 => ':LNAME:FNAME:*',
  n = 109 => ':LNAME:MNAME:TAXONOMY',
  n = 110 => ':PRIM_RANGE:V_CITY_NAME',
  n = 111 => ':PRIM_RANGE:LAT_LONG',
  n = 112 => ':PRIM_RANGE:SNAME:*',
  n = 115 => ':PRIM_RANGE:FNAME:*',
  n = 117 => ':PRIM_RANGE:MNAME:TAXONOMY',
  n = 118 => ':V_CITY_NAME:LAT_LONG:*',
  n = 122 => ':V_CITY_NAME:SNAME:*',
  n = 125 => ':V_CITY_NAME:FNAME:*',
  n = 127 => ':V_CITY_NAME:MNAME:TAXONOMY',
  n = 128 => ':LAT_LONG:SNAME:*',
  n = 131 => ':LAT_LONG:FNAME:*',
  n = 133 => ':LAT_LONG:MNAME:TAXONOMY',
  n = 134 => ':SNAME:FNAME:*',
  n = 136 => ':SNAME:MNAME:TAXONOMY',
  n = 137 => ':FNAME:MNAME:TAXONOMY','AttributeFile:'+(STRING)(n-10000));
//Unable to match efficacy line :6 :PHONE  122412 
//Unable to match efficacy line :8 :C_LIC_NBR  179778 
//Unable to match efficacy line :25 :PRIM_NAME:TAXONOMY  201 
//Unable to match efficacy line :30 :ZIP:FNAME  1774 
//Unable to match efficacy line :31 :ZIP:MNAME  1960 
//Unable to match efficacy line :32 :ZIP:TAXONOMY  370 
//Unable to match efficacy line :33 :ZIP:SNAME  1 
//Unable to match efficacy line :36 :PRIM_RANGE:FNAME  341 
//Unable to match efficacy line :37 :PRIM_RANGE:MNAME  56 
//Unable to match efficacy line :39 :PRIM_RANGE:SNAME:LNAME  324 
//Unable to match efficacy line :40 :V_CITY_NAME:LAT_LONG  2902 
//Unable to match efficacy line :45 :V_CITY_NAME:MNAME:*  3185 
//Unable to match efficacy line :48 :V_CITY_NAME:TAXONOMY:*  105 
//Unable to match efficacy line :50 :V_CITY_NAME:SNAME:LNAME 28 
//Unable to match efficacy line :55 :LAT_LONG:MNAME:*  1462 
//Unable to match efficacy line :58 :LAT_LONG:TAXONOMY:*  197 
//Unable to match efficacy line :60 :LAT_LONG:SNAME:LNAME  4 
//Unable to match efficacy line :61 :FNAME:MNAME:*  5987 
//Unable to match efficacy line :64 :FNAME:TAXONOMY:*  308 
//Unable to match efficacy line :66 :MNAME:TAXONOMY:*  37 
// Read 42 efficacy lines; matched 22 of them
// Rules explicitely suppressed:4
// Some rules may not be included because INCLUDE was used on the EFFICACY line
//Now execute each of the 138 join conditions of which 88 have been optimized into preceding conditions
//Fixed fields ->:SSN(24)
dn0 := h(~SSN_isnull);
dn0_deduped := dn0(SSN_weight100>=2100); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.SSN = RIGHT.SSN AND ( left.UPIN = right.UPIN OR left.UPIN_isnull OR right.UPIN_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND SALT29.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0,match_join(LEFT,RIGHT,0),HINT(unsorted_output),ATMOST(LEFT.SSN = RIGHT.SSN,10000),HASH);
//Fixed fields ->:UPIN(24)
dn1 := h(~UPIN_isnull);
dn1_deduped := dn1(UPIN_weight100>=2100); // Use specificity to flag high-dup counts
mj1 := JOIN( dn1_deduped, dn1_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.UPIN = RIGHT.UPIN AND ( left.UPIN = right.UPIN OR left.UPIN_isnull OR right.UPIN_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND SALT29.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0,match_join(LEFT,RIGHT,1),HINT(unsorted_output),ATMOST(LEFT.UPIN = RIGHT.UPIN,10000),HASH);
//Fixed fields ->:NPI_NUMBER(24)
dn2 := h(~NPI_NUMBER_isnull);
dn2_deduped := dn2(NPI_NUMBER_weight100>=2100); // Use specificity to flag high-dup counts
mj2 := JOIN( dn2_deduped, dn2_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER AND ( left.UPIN = right.UPIN OR left.UPIN_isnull OR right.UPIN_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND SALT29.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0,match_join(LEFT,RIGHT,2),HINT(unsorted_output),ATMOST(LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER,10000),HASH);
//Fixed fields ->:DEA_NUMBER(24)
dn3 := h(~DEA_NUMBER_isnull);
dn3_deduped := dn3(DEA_NUMBER_weight100>=2100); // Use specificity to flag high-dup counts
mj3 := JOIN( dn3_deduped, dn3_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.DEA_NUMBER = RIGHT.DEA_NUMBER AND ( left.UPIN = right.UPIN OR left.UPIN_isnull OR right.UPIN_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND SALT29.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0,match_join(LEFT,RIGHT,3),HINT(unsorted_output),ATMOST(LEFT.DEA_NUMBER = RIGHT.DEA_NUMBER,10000),HASH);
//Fixed fields ->:DID(23)
dn4 := h(~DID_isnull);
dn4_deduped := dn4(DID_weight100>=2100); // Use specificity to flag high-dup counts
mj4 := JOIN( dn4_deduped, dn4_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.DID = RIGHT.DID AND ( left.UPIN = right.UPIN OR left.UPIN_isnull OR right.UPIN_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND SALT29.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0,match_join(LEFT,RIGHT,4),HINT(unsorted_output),ATMOST(LEFT.DID = RIGHT.DID,10000),HASH);
mjs0_t := mj0+mj1+mj2+mj3+mj4;
SALT29.mac_select_best_matches(mjs0_t,RID1,RID2,o0);
mjs0 := o0 : PERSIST('~temp::LNPID::HealthCareProviderHeader::mj::0',EXPIRE(30));
//Fixed fields ->:VENDOR_ID(23)
dn5 := h(~VENDOR_ID_isnull);
dn5_deduped := dn5(VENDOR_ID_weight100>=2100); // Use specificity to flag high-dup counts
mj5 := JOIN( dn5_deduped, dn5_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC AND ( left.UPIN = right.UPIN OR left.UPIN_isnull OR right.UPIN_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND SALT29.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0,match_join(LEFT,RIGHT,5),HINT(unsorted_output),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC,10000),HASH);
//Fixed fields ->:FAX(21)
dn7 := h(~FAX_isnull);
dn7_deduped := dn7(FAX_weight100>=2100); // Use specificity to flag high-dup counts
mj7 := JOIN( dn7_deduped, dn7_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.FAX = RIGHT.FAX AND LEFT.FNAME = RIGHT.FNAME AND ( left.UPIN = right.UPIN OR left.UPIN_isnull OR right.UPIN_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND SALT29.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0,match_join(LEFT,RIGHT,7),HINT(unsorted_output),ATMOST(LEFT.FAX = RIGHT.FAX AND LEFT.FNAME = RIGHT.FNAME,10000),HASH);
mjs1_t := mj5+mj7;
SALT29.mac_select_best_matches(mjs1_t,RID1,RID2,o1);
mjs1 := o1 : PERSIST('~temp::LNPID::HealthCareProviderHeader::mj::1',EXPIRE(30));
//First 1 fields shared with following 12 joins - optimization performed
//Fixed fields ->:DOB(17):CNSMR_DOB(17) also :DOB(17):BILLING_TAX_ID(16) also :DOB(17):BILLING_NPI_NUMBER(16) also :DOB(17):PRIM_NAME(13) also :DOB(17):ZIP(12) also :DOB(17):LNAME(11) also :DOB(17):PRIM_RANGE(11) also :DOB(17):V_CITY_NAME(10) also :DOB(17):LAT_LONG(10) also :DOB(17):SNAME(8) also :DOB(17):FNAME(8) also :DOB(17):MNAME(8) also :DOB(17):TAXONOMY(8)
dn37 := h((~DOB_year_isnull OR ~DOB_month_isnull OR ~DOB_day_isnull));
dn37_deduped := dn37(DOB_year_weight100 + DOB_month_weight100 + DOB_day_weight100>=1700); // Use specificity to flag high-dup counts
mj37 := JOIN( dn37_deduped, dn37_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.DOB_year = RIGHT.DOB_year AND LEFT.DOB_month = RIGHT.DOB_month AND LEFT.DOB_day = RIGHT.DOB_day AND ( left.UPIN = right.UPIN OR left.UPIN_isnull OR right.UPIN_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND SALT29.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    AND (
          LEFT.CNSMR_DOB_year = RIGHT.CNSMR_DOB_year AND LEFT.CNSMR_DOB_month = RIGHT.CNSMR_DOB_month AND LEFT.CNSMR_DOB_day = RIGHT.CNSMR_DOB_day AND LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND (~LEFT.CNSMR_DOB_year_isnull OR ~LEFT.CNSMR_DOB_month_isnull OR ~LEFT.CNSMR_DOB_day_isnull)
    OR    LEFT.BILLING_TAX_ID = RIGHT.BILLING_TAX_ID AND LEFT.FNAME = RIGHT.FNAME AND ~LEFT.BILLING_TAX_ID_isnull
    OR    LEFT.BILLING_NPI_NUMBER = RIGHT.BILLING_NPI_NUMBER AND LEFT.FNAME = RIGHT.FNAME AND ~LEFT.BILLING_NPI_NUMBER_isnull
    OR    LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND ~LEFT.PRIM_NAME_isnull
    OR    LEFT.ZIP = RIGHT.ZIP AND ~LEFT.ZIP_isnull
    OR    LEFT.LNAME = RIGHT.LNAME AND ~LEFT.LNAME_isnull
    OR    LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE AND ~LEFT.PRIM_RANGE_isnull
    OR    LEFT.V_CITY_NAME = RIGHT.V_CITY_NAME AND ~LEFT.V_CITY_NAME_isnull
    OR    LEFT.LAT_LONG = RIGHT.LAT_LONG AND LEFT.FNAME = RIGHT.FNAME AND ~LEFT.LAT_LONG_isnull
    OR    LEFT.SNAME = RIGHT.SNAME AND ~LEFT.SNAME_isnull
    OR    LEFT.FNAME = RIGHT.FNAME AND ~LEFT.FNAME_isnull
    OR    LEFT.MNAME = RIGHT.MNAME AND ~LEFT.MNAME_isnull
    OR    LEFT.TAXONOMY = RIGHT.TAXONOMY AND LEFT.FNAME = RIGHT.FNAME AND ~LEFT.TAXONOMY_isnull
        ),match_join(LEFT,RIGHT,37),HINT(unsorted_output),ATMOST(LEFT.DOB_year = RIGHT.DOB_year AND LEFT.DOB_month = RIGHT.DOB_month AND LEFT.DOB_day = RIGHT.DOB_day,10000),HASH);
mjs2_t := mj37;
SALT29.mac_select_best_matches(mjs2_t,RID1,RID2,o2);
mjs2 := o2 : PERSIST('~temp::LNPID::HealthCareProviderHeader::mj::2',EXPIRE(30));
//Fixed fields ->:PRIM_NAME(13):ZIP(12)
dn83 := h(~PRIM_NAME_isnull AND ~ZIP_isnull);
dn83_deduped := dn83(PRIM_NAME_weight100 + ZIP_weight100>=2100); // Use specificity to flag high-dup counts
mj83 := JOIN( dn83_deduped, dn83_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND LEFT.ZIP = RIGHT.ZIP AND ( left.UPIN = right.UPIN OR left.UPIN_isnull OR right.UPIN_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND SALT29.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0,match_join(LEFT,RIGHT,83),HINT(unsorted_output),ATMOST(LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND LEFT.ZIP = RIGHT.ZIP,10000),HASH);
//Fixed fields ->:PRIM_NAME(13):PRIM_RANGE(11)
dn85 := h(~PRIM_NAME_isnull AND ~PRIM_RANGE_isnull);
dn85_deduped := dn85(PRIM_NAME_weight100 + PRIM_RANGE_weight100>=2100); // Use specificity to flag high-dup counts
mj85 := JOIN( dn85_deduped, dn85_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE AND ( left.UPIN = right.UPIN OR left.UPIN_isnull OR right.UPIN_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND SALT29.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0,match_join(LEFT,RIGHT,85),HINT(unsorted_output),ATMOST(LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE,10000),HASH);
//Fixed fields ->:PRIM_NAME(13):LAT_LONG(10)
dn87 := h(~PRIM_NAME_isnull AND ~LAT_LONG_isnull);
dn87_deduped := dn87(PRIM_NAME_weight100 + LAT_LONG_weight100>=2100); // Use specificity to flag high-dup counts
mj87 := JOIN( dn87_deduped, dn87_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND LEFT.LAT_LONG = RIGHT.LAT_LONG AND LEFT.FNAME = RIGHT.FNAME AND ( left.UPIN = right.UPIN OR left.UPIN_isnull OR right.UPIN_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND SALT29.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0,match_join(LEFT,RIGHT,87),HINT(unsorted_output),ATMOST(LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND LEFT.LAT_LONG = RIGHT.LAT_LONG AND LEFT.FNAME = RIGHT.FNAME,10000),HASH);
mjs3_t := mj83+mj85+mj87;
SALT29.mac_select_best_matches(mjs3_t,RID1,RID2,o3);
mjs3 := o3 : PERSIST('~temp::LNPID::HealthCareProviderHeader::mj::3',EXPIRE(30));
//Fixed fields ->:PRIM_NAME(13):FNAME(8)
dn89 := h(~PRIM_NAME_isnull AND ~FNAME_isnull);
dn89_deduped := dn89(PRIM_NAME_weight100 + FNAME_weight100>=2100); // Use specificity to flag high-dup counts
mj89 := JOIN( dn89_deduped, dn89_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND LEFT.FNAME = RIGHT.FNAME AND ( left.UPIN = right.UPIN OR left.UPIN_isnull OR right.UPIN_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND SALT29.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0,match_join(LEFT,RIGHT,89),HINT(unsorted_output),ATMOST(LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND LEFT.FNAME = RIGHT.FNAME,10000),HASH);
//Fixed fields ->:PRIM_NAME(13):MNAME(8)
dn90 := h(~PRIM_NAME_isnull AND ~MNAME_isnull);
dn90_deduped := dn90(PRIM_NAME_weight100 + MNAME_weight100>=2100); // Use specificity to flag high-dup counts
mj90 := JOIN( dn90_deduped, dn90_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND LEFT.MNAME = RIGHT.MNAME AND ( left.UPIN = right.UPIN OR left.UPIN_isnull OR right.UPIN_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND SALT29.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0,match_join(LEFT,RIGHT,90),HINT(unsorted_output),ATMOST(LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND LEFT.MNAME = RIGHT.MNAME,10000),HASH);
//Fixed fields ->:ZIP(12):PRIM_RANGE(11)
dn92 := h(~ZIP_isnull AND ~PRIM_RANGE_isnull);
dn92_deduped := dn92(ZIP_weight100 + PRIM_RANGE_weight100>=2100); // Use specificity to flag high-dup counts
mj92 := JOIN( dn92_deduped, dn92_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.ZIP = RIGHT.ZIP AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE AND ( left.UPIN = right.UPIN OR left.UPIN_isnull OR right.UPIN_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND SALT29.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0,match_join(LEFT,RIGHT,92),HINT(unsorted_output),ATMOST(LEFT.ZIP = RIGHT.ZIP AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE,10000),HASH);
//Fixed fields ->:ZIP(12):V_CITY_NAME(10)
dn93 := h(~ZIP_isnull AND ~V_CITY_NAME_isnull);
dn93_deduped := dn93(ZIP_weight100 + V_CITY_NAME_weight100>=2100); // Use specificity to flag high-dup counts
mj93 := JOIN( dn93_deduped, dn93_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.ZIP = RIGHT.ZIP AND LEFT.V_CITY_NAME = RIGHT.V_CITY_NAME AND ( left.UPIN = right.UPIN OR left.UPIN_isnull OR right.UPIN_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND SALT29.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0,match_join(LEFT,RIGHT,93),HINT(unsorted_output),ATMOST(LEFT.ZIP = RIGHT.ZIP AND LEFT.V_CITY_NAME = RIGHT.V_CITY_NAME,10000),HASH);
mjs4_t := mj89+mj90+mj92+mj93;
SALT29.mac_select_best_matches(mjs4_t,RID1,RID2,o4);
mjs4 := o4 : PERSIST('~temp::LNPID::HealthCareProviderHeader::mj::4',EXPIRE(30));
//Fixed fields ->:ZIP(12):LAT_LONG(10)
dn94 := h(~ZIP_isnull AND ~LAT_LONG_isnull);
dn94_deduped := dn94(ZIP_weight100 + LAT_LONG_weight100>=2100); // Use specificity to flag high-dup counts
mj94 := JOIN( dn94_deduped, dn94_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.ZIP = RIGHT.ZIP AND LEFT.LAT_LONG = RIGHT.LAT_LONG AND LEFT.FNAME = RIGHT.FNAME AND ( left.UPIN = right.UPIN OR left.UPIN_isnull OR right.UPIN_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND SALT29.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0,match_join(LEFT,RIGHT,94),HINT(unsorted_output),ATMOST(LEFT.ZIP = RIGHT.ZIP AND LEFT.LAT_LONG = RIGHT.LAT_LONG AND LEFT.FNAME = RIGHT.FNAME,10000),HASH);
mjs5_t := mj94;
SALT29.mac_select_best_matches(mjs5_t,RID1,RID2,o5);
mjs5 := o5 : PERSIST('~temp::LNPID::HealthCareProviderHeader::mj::5',EXPIRE(30));
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:V_CITY_NAME(10):FNAME(8):MNAME(8) also :V_CITY_NAME(10):FNAME(8):TAXONOMY(8)
dn125 := h(~V_CITY_NAME_isnull AND ~FNAME_isnull);
dn125_deduped := dn125(V_CITY_NAME_weight100 + FNAME_weight100>=1700); // Use specificity to flag high-dup counts
mj125 := JOIN( dn125_deduped, dn125_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.V_CITY_NAME = RIGHT.V_CITY_NAME AND LEFT.FNAME = RIGHT.FNAME AND ( left.UPIN = right.UPIN OR left.UPIN_isnull OR right.UPIN_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND SALT29.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    AND (
          LEFT.MNAME = RIGHT.MNAME AND ~LEFT.MNAME_isnull
    OR    LEFT.TAXONOMY = RIGHT.TAXONOMY AND LEFT.FNAME = RIGHT.FNAME AND ~LEFT.TAXONOMY_isnull
        ),match_join(LEFT,RIGHT,125),HINT(unsorted_output),ATMOST(LEFT.V_CITY_NAME = RIGHT.V_CITY_NAME AND LEFT.FNAME = RIGHT.FNAME,10000),HASH);
mjs6_t := mj125;
SALT29.mac_select_best_matches(mjs6_t,RID1,RID2,o6);
mjs6 := o6 : PERSIST('~temp::LNPID::HealthCareProviderHeader::mj::6',EXPIRE(30));
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:LAT_LONG(10):FNAME(8):MNAME(8) also :LAT_LONG(10):FNAME(8):TAXONOMY(8)
dn131 := h(~LAT_LONG_isnull AND ~FNAME_isnull);
dn131_deduped := dn131(LAT_LONG_weight100 + FNAME_weight100>=1700); // Use specificity to flag high-dup counts
mj131 := JOIN( dn131_deduped, dn131_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.LAT_LONG = RIGHT.LAT_LONG AND LEFT.FNAME = RIGHT.FNAME AND LEFT.FNAME = RIGHT.FNAME AND ( left.UPIN = right.UPIN OR left.UPIN_isnull OR right.UPIN_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND SALT29.MOD_DateMatch(left.DOB_year,left.DOB_month,left.DOB_day,right.DOB_year,right.DOB_month,right.DOB_day,true,true,12,true).NLT0
    AND (
          LEFT.MNAME = RIGHT.MNAME AND ~LEFT.MNAME_isnull
    OR    LEFT.TAXONOMY = RIGHT.TAXONOMY AND LEFT.FNAME = RIGHT.FNAME AND ~LEFT.TAXONOMY_isnull
        ),match_join(LEFT,RIGHT,131),HINT(unsorted_output),ATMOST(LEFT.LAT_LONG = RIGHT.LAT_LONG AND LEFT.FNAME = RIGHT.FNAME AND LEFT.FNAME = RIGHT.FNAME,10000),HASH);
custom_join_ds := Custom_JOIN(h,match_join) : PERSIST('~temp::LNPID::HealthCareProviderHeader::cj',EXPIRE(30));
last_mjs_t :=custom_join_ds + mj131;
SALT29.mac_select_best_matches(last_mjs_t,RID1,RID2,o);
SHARED all_mjs :=  mjs0+ mjs1+ mjs2+ mjs3+ mjs4+ mjs5+ mjs6 +o;
EXPORT All_Matches := all_mjs : PERSIST('~temp::LNPID::HealthCareProviderHeader::all_m',EXPIRE(30)); // To by used by RID and LNPID
SALT29.mac_avoid_transitives(All_Matches,LNPID1,LNPID2,Conf,DateOverlap,Rule,o);
EXPORT PossibleMatches := o : PERSIST('~temp::LNPID::HealthCareProviderHeader::mt',EXPIRE(30));
SALT29.mac_get_BestPerRecord( All_Matches,RID1,LNPID1,RID2,LNPID2,o );
EXPORT BestPerRecord := o : PERSIST('~temp::LNPID::HealthCareProviderHeader::mr',EXPIRE(30));
//Now lets see if any slice-outs are needed
too_big := Specificities(ih).ClusterSizes(InCluster>1000); // LNPID that are too big for sliceout
h_ok := JOIN(h,too_big,LEFT.LNPID=RIGHT.LNPID,TRANSFORM(LEFT),LOOKUP,LEFT ONLY);
in_matches := JOIN(h_ok,h_ok,LEFT.LNPID=RIGHT.LNPID AND (>STRING6<)LEFT.RID<>(>STRING6<)RIGHT.RID,match_join(LEFT,RIGHT,9999),LOCAL,HINT(unsorted_output));
SALT29.mac_cluster_breadth(in_matches,RID1,RID2,LNPID1,o);
o1 := JOIN(o,Specificities(ih).ClusterSizes,LEFT.LNPID1=RIGHT.LNPID,LOCAL);
EXPORT ClusterLinkages := o1 : PERSIST('~temp::LNPID::HealthCareProviderHeader::clu',EXPIRE(30));
EXPORT ClusterOutcasts := ClusterLinkages(InCluster>1,Closest<MatchThreshold);
//Now find those outcasts that are liked elsewhere ...
Pref_Layout := RECORD
  SALT29.UIDType RID;  //Outcast
  SALT29.UIDType LNPID;  // Outcase within
  INTEGER2 Closest; // Best present link
  SALT29.UIDType Pref_RID; // Prefers this record
  SALT29.UIDType Pref_LNPID; // Prefers this cluster
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
EXPORT ToSlice := IF ( Config.DoSliceouts, DEDUP(SORT(DISTRIBUTE(BetterElsewhere(Pref_Margin>10),HASH(LNPID)),LNPID,-Pref_Margin,LOCAL),LNPID,LOCAL)); // 1024x better in new place
  SALT29.MAC_Avoid_SliceOuts(PossibleMatches,LNPID1,LNPID2,LNPID,Pref_LNPID,ToSlice,m); // If LNPID is slice target - don't use in match
  m1 := IF( Config.DoSliceouts,m,PossibleMatches );
EXPORT Matches := m1(Conf>=MatchThreshold);
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
SALT29.MAC_Reassign_UID(ihbp,Cleave(ih).patch_file,LNPID,RID,ih1); // Perform cleaves
SALT29.MAC_SliceOut_ByRID(ih1,RID,LNPID,ToSlice,RID,sliced0); // Execute Sliceouts
  sliced := IF( Config.DoSliceouts, sliced0, ih1); // Compile time ability to remove sliceout cost
ut.MAC_Patch_Id(sliced,LNPID,Matches,LNPID1,LNPID2,o); // Join Clusters
EXPORT Patched_Infile := o;
//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,LNPID,Matches,LNPID1,LNPID2,o1);
EXPORT Patched_Candidates := o1;
// Now compute a file to show which identifiers have changed from input to output
EXPORT id_shift_r := RECORD
    SALT29.UIDType RID;
    SALT29.UIDType LNPID_before;
    SALT29.UIDType LNPID_after;
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
EXPORT PreIDs := HealthCareProviderHeader.Fields.UIDConsistency(ih); // Export whole consistency module
EXPORT PostIDs := HealthCareProviderHeader.Fields.UIDConsistency(Patched_Infile); // Export whole consistency module
EXPORT PatchingError0 := PreIDs.IdCounts[1].LNPID_count - PostIDs.IdCounts[1].LNPID_count - MatchesPerformed - COUNT(BasicMatch(ih).patch_file) + SlicesPerformed + Cleave(ih).patch_count; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile) - PostIDs.IdCounts[1].RID_Count; // Should be zero
END;
