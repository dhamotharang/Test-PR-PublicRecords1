// Various routines to assist in debugging

IMPORT SALT27,ut,std;
EXPORT Debug(DATASET(layout_HealthProvider) ih, Layout_Specificities.R s, MatchThreshold = 42) := MODULE
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
SHARED h := match_candidates(ih).candidates;
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes

EXPORT Layout_Sample_Matches := RECORD,MAXLENGTH(32000)
INTEGER2 Conf;
INTEGER2 Conf_Prop;
INTEGER2 DateOverlap := 0;
SALT27.UIDType LNPID1;
SALT27.UIDType LNPID2;
SALT27.UIDType RID1;
SALT27.UIDType RID2;
typeof(h.VENDOR_ID) left_VENDOR_ID;
INTEGER2 VENDOR_ID_score;
typeof(h.VENDOR_ID) right_VENDOR_ID;
typeof(h.DID) left_DID;
INTEGER2 DID_score;
typeof(h.DID) right_DID;
typeof(h.NPI_NUMBER) left_NPI_NUMBER;
INTEGER2 NPI_NUMBER_score;
typeof(h.NPI_NUMBER) right_NPI_NUMBER;
typeof(h.DEA_NUMBER) left_DEA_NUMBER;
INTEGER2 DEA_NUMBER_score;
typeof(h.DEA_NUMBER) right_DEA_NUMBER;
typeof(h.MAINNAME) left_MAINNAME;
INTEGER2 MAINNAME_score;
typeof(h.MAINNAME) right_MAINNAME;
typeof(h.FULLNAME) left_FULLNAME;
INTEGER2 FULLNAME_score;
BOOLEAN FULLNAME_skipped := FALSE; // True if FORCE blocks match
typeof(h.FULLNAME) right_FULLNAME;
typeof(h.LIC_NBR) left_LIC_NBR;
INTEGER2 LIC_NBR_score;
typeof(h.LIC_NBR) right_LIC_NBR;
typeof(h.UPIN) left_UPIN;
INTEGER2 UPIN_score;
typeof(h.UPIN) right_UPIN;
typeof(h.ADDR) left_ADDR;
INTEGER2 ADDR_score;
typeof(h.ADDR) right_ADDR;
typeof(h.ADDRESS) left_ADDRESS;
INTEGER2 ADDRESS_score;
typeof(h.ADDRESS) right_ADDRESS;
typeof(h.TAX_ID) left_TAX_ID;
INTEGER2 TAX_ID_score;
typeof(h.TAX_ID) right_TAX_ID;
unsigned6 left_DOB;
INTEGER2 DOB_score;
BOOLEAN DOB_skipped := FALSE; // True if FORCE blocks match
unsigned6 right_DOB;
typeof(h.PRIM_NAME) left_PRIM_NAME;
INTEGER2 PRIM_NAME_score;
typeof(h.PRIM_NAME) right_PRIM_NAME;
typeof(h.ZIP) left_ZIP;
INTEGER2 ZIP_score;
typeof(h.ZIP) right_ZIP;
typeof(h.LOCALE) left_LOCALE;
INTEGER2 LOCALE_score;
typeof(h.LOCALE) right_LOCALE;
typeof(h.PRIM_RANGE) left_PRIM_RANGE;
INTEGER2 PRIM_RANGE_score;
typeof(h.PRIM_RANGE) right_PRIM_RANGE;
typeof(h.LNAME) left_LNAME;
INTEGER2 LNAME_score;
typeof(h.LNAME) right_LNAME;
typeof(h.V_CITY_NAME) left_V_CITY_NAME;
INTEGER2 V_CITY_NAME_score;
typeof(h.V_CITY_NAME) right_V_CITY_NAME;
typeof(h.LAT_LONG) left_LAT_LONG;
INTEGER2 LAT_LONG_score;
typeof(h.LAT_LONG) right_LAT_LONG;
dataset(SALT27.layout_ll_ranges) left_LAT_LONG_ranges; // Lat long ranges
dataset(SALT27.layout_ll_ranges) right_LAT_LONG_ranges; // Lat long ranges
typeof(h.MNAME) left_MNAME;
INTEGER2 MNAME_score;
typeof(h.MNAME) right_MNAME;
typeof(h.FNAME) left_FNAME;
INTEGER2 FNAME_score;
typeof(h.FNAME) right_FNAME;
typeof(h.SEC_RANGE) left_SEC_RANGE;
INTEGER2 SEC_RANGE_score;
typeof(h.SEC_RANGE) right_SEC_RANGE;
typeof(h.SNAME) left_SNAME;
INTEGER2 SNAME_score;
typeof(h.SNAME) right_SNAME;
typeof(h.ST) left_ST;
INTEGER2 ST_score;
typeof(h.ST) right_ST;
typeof(h.GENDER) left_GENDER;
INTEGER2 GENDER_score;
typeof(h.GENDER) right_GENDER;
typeof(h.PHONE) left_PHONE;
typeof(h.PHONE) right_PHONE;
typeof(h.LIC_STATE) left_LIC_STATE;
typeof(h.LIC_STATE) right_LIC_STATE;
typeof(h.ADDRESS_ID) left_ADDRESS_ID;
typeof(h.ADDRESS_ID) right_ADDRESS_ID;
typeof(h.CNAME) left_CNAME;
typeof(h.CNAME) right_CNAME;
typeof(h.SRC) left_SRC;
typeof(h.SRC) right_SRC;
typeof(h.DT_FIRST_SEEN) left_DT_FIRST_SEEN;
typeof(h.DT_FIRST_SEEN) right_DT_FIRST_SEEN;
typeof(h.DT_LAST_SEEN) left_DT_LAST_SEEN;
typeof(h.DT_LAST_SEEN) right_DT_LAST_SEEN;
typeof(h.DT_LIC_EXPIRATION) left_DT_LIC_EXPIRATION;
typeof(h.DT_LIC_EXPIRATION) right_DT_LIC_EXPIRATION;
typeof(h.DT_DEA_EXPIRATION) left_DT_DEA_EXPIRATION;
typeof(h.DT_DEA_EXPIRATION) right_DT_DEA_EXPIRATION;
typeof(h.GEO_LAT) left_GEO_LAT;
typeof(h.GEO_LAT) right_GEO_LAT;
typeof(h.GEO_LONG) left_GEO_LONG;
typeof(h.GEO_LONG) right_GEO_LONG;
END;
EXPORT layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED outside=0) := TRANSFORM
SELF.LNPID1 := le.LNPID;
SELF.LNPID2 := ri.LNPID;
SELF.RID1 := le.RID;
SELF.RID2 := ri.RID;
SELF.DateOverlap := SALT27.fn_ComputeDateOverlap(((UNSIGNED)le.DT_FIRST_SEEN)*100,((UNSIGNED)le.DT_LAST_SEEN)*100,((UNSIGNED)ri.DT_FIRST_SEEN)*100,((UNSIGNED)ri.DT_LAST_SEEN)*100);
SELF.left_VENDOR_ID := le.VENDOR_ID;
SELF.right_VENDOR_ID := ri.VENDOR_ID;
SELF.VENDOR_ID_score := MAP( le.VENDOR_ID_isnull OR ri.VENDOR_ID_isnull => 0,
le.SRC <> ri.SRC => 0, // Only valid if the context variable is equal
le.VENDOR_ID = ri.VENDOR_ID  => le.VENDOR_ID_weight100,
0 /* switch0 */);
SELF.left_DID := le.DID;
SELF.right_DID := ri.DID;
INTEGER2 DID_score_temp := MAP( le.DID_isnull OR ri.DID_isnull => 0,
le.DID = ri.DID  => le.DID_weight100,
0 /* switch0 */);
SELF.left_NPI_NUMBER := le.NPI_NUMBER;
SELF.right_NPI_NUMBER := ri.NPI_NUMBER;
SELF.NPI_NUMBER_score := MAP( le.NPI_NUMBER_isnull OR ri.NPI_NUMBER_isnull => 0,
le.NPI_NUMBER = ri.NPI_NUMBER  => le.NPI_NUMBER_weight100,
SALT27.Fn_Fail_Scale(le.NPI_NUMBER_weight100,s.NPI_NUMBER_switch));
SELF.left_DEA_NUMBER := le.DEA_NUMBER;
SELF.right_DEA_NUMBER := ri.DEA_NUMBER;
SELF.DEA_NUMBER_score := MAP( le.DEA_NUMBER_isnull OR ri.DEA_NUMBER_isnull => 0,
le.DEA_NUMBER = ri.DEA_NUMBER  => le.DEA_NUMBER_weight100,
SALT27.Fn_Fail_Scale(le.DEA_NUMBER_weight100,s.DEA_NUMBER_switch));
REAL FULLNAME_score_scale := ( le.FULLNAME_weight100 + ri.FULLNAME_weight100 ) / (le.MAINNAME_weight100 + ri.MAINNAME_weight100 + le.SNAME_weight100 + ri.SNAME_weight100); // Scaling factor for this concept
INTEGER2 FULLNAME_score_pre := MAP( (le.FULLNAME_isnull OR (le.MAINNAME_isnull OR le.FNAME_isnull AND le.MNAME_isnull AND le.LNAME_isnull) AND le.SNAME_isnull) OR (ri.FULLNAME_isnull OR (ri.MAINNAME_isnull OR ri.FNAME_isnull AND ri.MNAME_isnull AND ri.LNAME_isnull) AND ri.SNAME_isnull) OR le.FULLNAME_weight100 = 0 => 0,
le.FULLNAME = ri.FULLNAME  => le.FULLNAME_weight100,
0);
SELF.left_FULLNAME := le.FULLNAME;
SELF.right_FULLNAME := ri.FULLNAME;
SELF.left_LIC_NBR := le.LIC_NBR;
SELF.right_LIC_NBR := ri.LIC_NBR;
SELF.LIC_NBR_score := MAP( le.LIC_NBR_isnull OR ri.LIC_NBR_isnull => 0,
le.LIC_STATE <> ri.LIC_STATE => 0, // Only valid if the context variable is equal
le.LIC_NBR = ri.LIC_NBR  => le.LIC_NBR_weight100,
le.LIC_NBR_CleanLic = ri.LIC_NBR_CleanLic => SALT27.fn_fuzzy_specificity(le.LIC_NBR_weight100,le.LIC_NBR_cnt, le.LIC_NBR_CleanLic_cnt,ri.LIC_NBR_weight100,ri.LIC_NBR_cnt,ri.LIC_NBR_CleanLic_cnt),
le.LIC_NBR_LicNumeric = ri.LIC_NBR_LicNumeric => SALT27.fn_fuzzy_specificity(le.LIC_NBR_weight100,le.LIC_NBR_cnt, le.LIC_NBR_LicNumeric_cnt,ri.LIC_NBR_weight100,ri.LIC_NBR_cnt,ri.LIC_NBR_LicNumeric_cnt),
0 /* switch0 */);
SELF.left_UPIN := le.UPIN;
SELF.right_UPIN := ri.UPIN;
SELF.UPIN_score := MAP( le.UPIN_isnull OR ri.UPIN_isnull => 0,
le.UPIN = ri.UPIN  => le.UPIN_weight100,
0 /* switch0 */);
REAL ADDRESS_score_scale := ( le.ADDRESS_weight100 + ri.ADDRESS_weight100 ) / (le.ADDR_weight100 + ri.ADDR_weight100 + le.LOCALE_weight100 + ri.LOCALE_weight100); // Scaling factor for this concept
INTEGER2 ADDRESS_score_pre := MAP( (le.ADDRESS_isnull OR (le.ADDR_isnull OR le.PRIM_RANGE_isnull AND le.SEC_RANGE_isnull AND le.PRIM_NAME_isnull) AND (le.LOCALE_isnull OR le.V_CITY_NAME_isnull AND le.ST_isnull AND le.ZIP_isnull)) OR (ri.ADDRESS_isnull OR (ri.ADDR_isnull OR ri.PRIM_RANGE_isnull AND ri.SEC_RANGE_isnull AND ri.PRIM_NAME_isnull) AND (ri.LOCALE_isnull OR ri.V_CITY_NAME_isnull AND ri.ST_isnull AND ri.ZIP_isnull)) => 0,
le.ADDRESS = ri.ADDRESS  => le.ADDRESS_weight100,
0);
SELF.left_ADDRESS := le.ADDRESS;
SELF.right_ADDRESS := ri.ADDRESS;
SELF.left_TAX_ID := le.TAX_ID;
SELF.right_TAX_ID := ri.TAX_ID;
SELF.TAX_ID_score := MAP( le.TAX_ID_isnull OR ri.TAX_ID_isnull => 0,
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
SELF.DOB_score := MAP( le.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND le.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND le.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) or ri.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND ri.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND ri.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) => 0,
DOB_year+DOB_month+DOB_day < 0 or DOB_year+DOB_month+DOB_day<>0 and DOB_year+DOB_month+DOB_day < -300 => -9999,
DOB_year < 0 and ABS(le.DOB_year-ri.DOB_year) > 13 => -9999, // Do not allow full generation mis-match
DOB_score_temp);

DOB_skipped := SELF.DOB_score = -9999;// Enforce FORCE parameter
SELF.left_DOB := (( le.DOB_year * 100 ) + le.DOB_month ) * 100 + le.DOB_day;
SELF.right_DOB := (( ri.DOB_year * 100 ) + ri.DOB_month ) * 100 + ri.DOB_day;
REAL LOCALE_score_scale := ( le.LOCALE_weight100 + ri.LOCALE_weight100 ) / (le.V_CITY_NAME_weight100 + ri.V_CITY_NAME_weight100 + le.ST_weight100 + ri.ST_weight100 + le.ZIP_weight100 + ri.ZIP_weight100); // Scaling factor for this concept
INTEGER2 LOCALE_score_pre := MAP( (le.LOCALE_isnull OR le.V_CITY_NAME_isnull AND le.ST_isnull AND le.ZIP_isnull) OR (ri.LOCALE_isnull OR ri.V_CITY_NAME_isnull AND ri.ST_isnull AND ri.ZIP_isnull) => 0,
ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.LOCALE = ri.LOCALE  => le.LOCALE_weight100,
0)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
SELF.left_LOCALE := le.LOCALE;
SELF.right_LOCALE := ri.LOCALE;
SELF.left_V_CITY_NAME := le.V_CITY_NAME;
SELF.right_V_CITY_NAME := ri.V_CITY_NAME;
INTEGER2 V_CITY_NAME_score_temp := MAP( le.V_CITY_NAME_isnull OR ri.V_CITY_NAME_isnull => 0,
LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.V_CITY_NAME = ri.V_CITY_NAME  => le.V_CITY_NAME_weight100,
SALT27.Fn_Fail_Scale(le.V_CITY_NAME_weight100,s.V_CITY_NAME_switch))*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
SELF.left_LAT_LONG := le.LAT_LONG;
SELF.right_LAT_LONG := ri.LAT_LONG;
self.left_LAT_LONG_ranges := le.LAT_LONG_ranges;
self.right_LAT_LONG_ranges := ri.LAT_LONG_ranges;
INTEGER2 LAT_LONG_score_temp := MAP( le.LAT_LONG_isnull OR ri.LAT_LONG_isnull => 0,
le.LAT_LONG = ri.LAT_LONG  => le.LAT_LONG_weight100,
SALT27.Fn_LL_DistanceScore(le.LAT_LONG,le.LAT_LONG_ranges,ri.LAT_LONG,ri.LAT_LONG_ranges,1) > 0 => SALT27.Fn_LL_DistanceScore(le.LAT_LONG,le.LAT_LONG_ranges,ri.LAT_LONG,ri.LAT_LONG_ranges,1),
SALT27.Fn_Fail_Scale(le.LAT_LONG_weight100,s.LAT_LONG_switch));
SELF.left_SNAME := le.SNAME;
SELF.right_SNAME := ri.SNAME;
SELF.SNAME_score := MAP( le.SNAME_isnull OR ri.SNAME_isnull => 0,
FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.SNAME = ri.SNAME  => le.SNAME_weight100,
le.SNAME_NormSuffix = ri.SNAME_NormSuffix => SALT27.fn_fuzzy_specificity(le.SNAME_weight100,le.SNAME_cnt, le.SNAME_NormSuffix_cnt,ri.SNAME_weight100,ri.SNAME_cnt,ri.SNAME_NormSuffix_cnt),
SALT27.Fn_Fail_Scale(le.SNAME_weight100,s.SNAME_switch))*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
SELF.left_ST := le.ST;
SELF.right_ST := ri.ST;
INTEGER2 ST_score_temp := MAP( le.ST_isnull OR ri.ST_isnull => 0,
LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.ST = ri.ST  => le.ST_weight100,
SALT27.Fn_Fail_Scale(le.ST_weight100,s.ST_switch))*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
SELF.left_GENDER := le.GENDER;
SELF.right_GENDER := ri.GENDER;
SELF.GENDER_score := MAP( le.GENDER_isnull OR ri.GENDER_isnull => 0,
le.GENDER = ri.GENDER  => le.GENDER_weight100,
SALT27.Fn_Fail_Scale(le.GENDER_weight100,s.GENDER_switch));
SELF.left_PHONE := le.PHONE;
SELF.right_PHONE := ri.PHONE;
SELF.left_LIC_STATE := le.LIC_STATE;
SELF.right_LIC_STATE := ri.LIC_STATE;
SELF.left_ADDRESS_ID := le.ADDRESS_ID;
SELF.right_ADDRESS_ID := ri.ADDRESS_ID;
SELF.left_CNAME := le.CNAME;
SELF.right_CNAME := ri.CNAME;
SELF.left_SRC := le.SRC;
SELF.right_SRC := ri.SRC;
SELF.left_DT_FIRST_SEEN := le.DT_FIRST_SEEN;
SELF.right_DT_FIRST_SEEN := ri.DT_FIRST_SEEN;
SELF.left_DT_LAST_SEEN := le.DT_LAST_SEEN;
SELF.right_DT_LAST_SEEN := ri.DT_LAST_SEEN;
SELF.left_DT_LIC_EXPIRATION := le.DT_LIC_EXPIRATION;
SELF.right_DT_LIC_EXPIRATION := ri.DT_LIC_EXPIRATION;
SELF.left_DT_DEA_EXPIRATION := le.DT_DEA_EXPIRATION;
SELF.right_DT_DEA_EXPIRATION := ri.DT_DEA_EXPIRATION;
SELF.left_GEO_LAT := le.GEO_LAT;
SELF.right_GEO_LAT := ri.GEO_LAT;
SELF.left_GEO_LONG := le.GEO_LONG;
SELF.right_GEO_LONG := ri.GEO_LONG;
SELF.DID_score := DID_score_temp*0.33;
REAL MAINNAME_score_scale := ( le.MAINNAME_weight100 + ri.MAINNAME_weight100 ) / (le.FNAME_weight100 + ri.FNAME_weight100 + le.MNAME_weight100 + ri.MNAME_weight100 + le.LNAME_weight100 + ri.LNAME_weight100); // Scaling factor for this concept
INTEGER2 MAINNAME_score_pre := MAP( (le.MAINNAME_isnull OR le.FNAME_isnull AND le.MNAME_isnull AND le.LNAME_isnull) OR (ri.MAINNAME_isnull OR ri.FNAME_isnull AND ri.MNAME_isnull AND ri.LNAME_isnull) => 0,
FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.MAINNAME = ri.MAINNAME  => le.MAINNAME_weight100,
SALT27.fn_concept_wordbag_EditN.Match3((SALT27.StrType)ri.FNAME,ri.FNAME_weight100,true,0,true,1,(SALT27.StrType)ri.MNAME,ri.MNAME_weight100,true,0,true,2,(SALT27.StrType)ri.LNAME,ri.LNAME_weight100,true,0,true,2,(SALT27.StrType)le.FNAME,le.FNAME_weight100,(SALT27.StrType)le.MNAME,le.MNAME_weight100,(SALT27.StrType)le.LNAME,le.LNAME_weight100)*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale))*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
SELF.left_MAINNAME := le.MAINNAME;
SELF.right_MAINNAME := ri.MAINNAME;
REAL ADDR_score_scale := ( le.ADDR_weight100 + ri.ADDR_weight100 ) / (le.PRIM_RANGE_weight100 + ri.PRIM_RANGE_weight100 + le.SEC_RANGE_weight100 + ri.SEC_RANGE_weight100 + le.PRIM_NAME_weight100 + ri.PRIM_NAME_weight100); // Scaling factor for this concept
INTEGER2 ADDR_score_pre := MAP( (le.ADDR_isnull OR le.PRIM_RANGE_isnull AND le.SEC_RANGE_isnull AND le.PRIM_NAME_isnull) OR (ri.ADDR_isnull OR ri.PRIM_RANGE_isnull AND ri.SEC_RANGE_isnull AND ri.PRIM_NAME_isnull) => 0,
ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.ADDR = ri.ADDR  => le.ADDR_weight100,
0)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
SELF.left_ADDR := le.ADDR;
SELF.right_ADDR := ri.ADDR;
SELF.left_PRIM_NAME := le.PRIM_NAME;
SELF.right_PRIM_NAME := ri.PRIM_NAME;
INTEGER2 PRIM_NAME_score_temp := MAP( le.PRIM_NAME_isnull OR ri.PRIM_NAME_isnull => 0,
ADDR_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.PRIM_NAME = ri.PRIM_NAME  => le.PRIM_NAME_weight100,
0 /* switch0 */)*IF(ADDR_score_scale=0,1,ADDR_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
SELF.left_ZIP := le.ZIP;
SELF.right_ZIP := ri.ZIP;
INTEGER2 ZIP_score_temp := MAP( le.ZIP_isnull OR ri.ZIP_isnull => 0,
LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.ZIP = ri.ZIP  => le.ZIP_weight100,
SALT27.Fn_Fail_Scale(le.ZIP_weight100,s.ZIP_switch))*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
SELF.left_PRIM_RANGE := le.PRIM_RANGE;
SELF.right_PRIM_RANGE := ri.PRIM_RANGE;
INTEGER2 PRIM_RANGE_score_temp := MAP( le.PRIM_RANGE_isnull OR ri.PRIM_RANGE_isnull => 0,
ADDR_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.PRIM_RANGE = ri.PRIM_RANGE  => le.PRIM_RANGE_weight100,
0 /* switch0 */)*IF(ADDR_score_scale=0,1,ADDR_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
SELF.left_LNAME := le.LNAME;
SELF.right_LNAME := ri.LNAME;
SELF.LNAME_score := MAP( le.LNAME_isnull OR ri.LNAME_isnull => 0,
MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.LNAME = ri.LNAME OR SALT27.fn_hyphen_match(le.LNAME,ri.LNAME,1)<=2  => MIN(le.LNAME_weight100,ri.LNAME_weight100),
SALT27.WithinEditN(le.LNAME,ri.LNAME,2) => SALT27.fn_fuzzy_specificity(le.LNAME_weight100,le.LNAME_cnt, le.LNAME_e2_cnt,ri.LNAME_weight100,ri.LNAME_cnt,ri.LNAME_e2_cnt),
LENGTH(TRIM(le.LNAME))>0 and le.LNAME = ri.LNAME[1..LENGTH(TRIM(le.LNAME))] => le.LNAME_weight100, // An initial match - take initial specificity
LENGTH(TRIM(ri.LNAME))>0 and ri.LNAME = le.LNAME[1..LENGTH(TRIM(ri.LNAME))] => ri.LNAME_weight100, // An initial match - take initial specificity
SALT27.Fn_Fail_Scale(le.LNAME_weight100,s.LNAME_switch))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
SELF.V_CITY_NAME_score := V_CITY_NAME_score_temp*0.50;
SELF.LAT_LONG_score := LAT_LONG_score_temp*0.75;
SELF.left_MNAME := le.MNAME;
SELF.right_MNAME := ri.MNAME;
SELF.MNAME_score := MAP( le.MNAME_isnull OR ri.MNAME_isnull => 0,
MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.MNAME = ri.MNAME  => le.MNAME_weight100,
SALT27.WithinEditN(le.MNAME,ri.MNAME,2) => SALT27.fn_fuzzy_specificity(le.MNAME_weight100,le.MNAME_cnt, le.MNAME_e2_cnt,ri.MNAME_weight100,ri.MNAME_cnt,ri.MNAME_e2_cnt),
LENGTH(TRIM(le.MNAME))>0 and le.MNAME = ri.MNAME[1..LENGTH(TRIM(le.MNAME))] => le.MNAME_weight100, // An initial match - take initial specificity
LENGTH(TRIM(ri.MNAME))>0 and ri.MNAME = le.MNAME[1..LENGTH(TRIM(ri.MNAME))] => ri.MNAME_weight100, // An initial match - take initial specificity
SALT27.Fn_Fail_Scale(le.MNAME_weight100,s.MNAME_switch))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
SELF.left_FNAME := le.FNAME;
SELF.right_FNAME := ri.FNAME;
SELF.FNAME_score := MAP( le.FNAME_isnull OR ri.FNAME_isnull => 0,
MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.FNAME = ri.FNAME  => le.FNAME_weight100,
SALT27.WithinEditN(le.FNAME,ri.FNAME,1) => SALT27.fn_fuzzy_specificity(le.FNAME_weight100,le.FNAME_cnt, le.FNAME_e1_cnt,ri.FNAME_weight100,ri.FNAME_cnt,ri.FNAME_e1_cnt),
LENGTH(TRIM(le.FNAME))>0 and le.FNAME = ri.FNAME[1..LENGTH(TRIM(le.FNAME))] => le.FNAME_weight100, // An initial match - take initial specificity
LENGTH(TRIM(ri.FNAME))>0 and ri.FNAME = le.FNAME[1..LENGTH(TRIM(ri.FNAME))] => ri.FNAME_weight100, // An initial match - take initial specificity
le.FNAME_PreferredName = ri.FNAME_PreferredName => SALT27.fn_fuzzy_specificity(le.FNAME_weight100,le.FNAME_cnt, le.FNAME_PreferredName_cnt,ri.FNAME_weight100,ri.FNAME_cnt,ri.FNAME_PreferredName_cnt),
SALT27.Fn_Fail_Scale(le.FNAME_weight100,s.FNAME_switch))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
SELF.left_SEC_RANGE := le.SEC_RANGE;
SELF.right_SEC_RANGE := ri.SEC_RANGE;
INTEGER2 SEC_RANGE_score_temp := MAP( le.SEC_RANGE_isnull OR ri.SEC_RANGE_isnull => 0,
ADDR_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.SEC_RANGE = ri.SEC_RANGE OR SALT27.fn_hyphen_match(le.SEC_RANGE,ri.SEC_RANGE,1)<=2  => MIN(le.SEC_RANGE_weight100,ri.SEC_RANGE_weight100),
0 /* switch0 */)*IF(ADDR_score_scale=0,1,ADDR_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
SELF.ST_score := ST_score_temp*0.50;
SELF.PRIM_NAME_score := PRIM_NAME_score_temp*0.50;
SELF.ZIP_score := ZIP_score_temp*0.50;
// Compute the score for the concept LOCALE
INTEGER2 LOCALE_score_ext := MAX(LOCALE_score_pre,0) + self.V_CITY_NAME_score + self.ST_score + self.ZIP_score + MAX(ADDRESS_score_pre,0);// Score in surrounding context
INTEGER2 LOCALE_score_res := MAX(0,LOCALE_score_pre); // At least nothing
INTEGER2 LOCALE_score_unweighted := LOCALE_score_res;
SELF.LOCALE_score := LOCALE_score_unweighted*0.50;
SELF.PRIM_RANGE_score := PRIM_RANGE_score_temp*0.50;
SELF.SEC_RANGE_score := SEC_RANGE_score_temp*0.50;
// Compute the score for the concept MAINNAME
INTEGER2 MAINNAME_score_ext := MAX(MAINNAME_score_pre,0) + self.FNAME_score + self.MNAME_score + self.LNAME_score + MAX(FULLNAME_score_pre,0);// Score in surrounding context
INTEGER2 MAINNAME_score_res := MAX(0,MAINNAME_score_pre); // At least nothing
SELF.MAINNAME_score := MAINNAME_score_res;
// Compute the score for the concept FULLNAME
INTEGER2 FULLNAME_score_ext := MAX(FULLNAME_score_pre,0)+ SELF.MAINNAME_score + self.FNAME_score + self.MNAME_score + self.LNAME_score + self.SNAME_score;// Score in surrounding context
INTEGER2 FULLNAME_score_res := MAX(0,FULLNAME_score_pre); // At least nothing
SELF.FULLNAME_score := IF ( FULLNAME_score_ext > -600,FULLNAME_score_res,-9999);
SELF.FULLNAME_skipped := SELF.FULLNAME_score < -5000;// Enforce FORCE parameter
// Compute the score for the concept ADDR
INTEGER2 ADDR_score_ext := MAX(ADDR_score_pre,0) + self.PRIM_RANGE_score + self.SEC_RANGE_score + self.PRIM_NAME_score + MAX(ADDRESS_score_pre,0);// Score in surrounding context
INTEGER2 ADDR_score_res := MAX(0,ADDR_score_pre); // At least nothing
INTEGER2 ADDR_score_unweighted := ADDR_score_res;
SELF.ADDR_score := ADDR_score_unweighted*0.50;
// Compute the score for the concept ADDRESS
INTEGER2 ADDRESS_score_ext := MAX(ADDRESS_score_pre,0)+ SELF.ADDR_score + self.PRIM_RANGE_score + self.SEC_RANGE_score + self.PRIM_NAME_score+ SELF.LOCALE_score + self.V_CITY_NAME_score + self.ST_score + self.ZIP_score;// Score in surrounding context
INTEGER2 ADDRESS_score_res := MAX(0,ADDRESS_score_pre); // At least nothing
INTEGER2 ADDRESS_score_unweighted := ADDRESS_score_res;
SELF.ADDRESS_score := ADDRESS_score_unweighted*0.50;
SELF.Conf_Prop := (0
+MAX(le.NPI_NUMBER_prop,ri.NPI_NUMBER_prop)*SELF.NPI_NUMBER_score // Score if either field propogated
+MAX(le.DEA_NUMBER_prop,ri.DEA_NUMBER_prop)*SELF.DEA_NUMBER_score // Score if either field propogated
+if(le.MAINNAME_prop+ri.MAINNAME_prop>0,self.MAINNAME_score*(0+if(le.FNAME_prop+ri.FNAME_prop>0,1,0)+if(le.MNAME_prop+ri.MNAME_prop>0,1,0)+if(le.LNAME_prop+ri.LNAME_prop>0,1,0))/3,0)
+if(le.FULLNAME_prop+ri.FULLNAME_prop>0,self.FULLNAME_score*(0+if(le.MAINNAME_prop+ri.MAINNAME_prop>0,1,0)+if(le.SNAME_prop+ri.SNAME_prop>0,1,0))/2,0)
+MAX(le.LIC_NBR_prop,ri.LIC_NBR_prop)*SELF.LIC_NBR_score // Score if either field propogated
+MAX(le.UPIN_prop,ri.UPIN_prop)*SELF.UPIN_score // Score if either field propogated
+if(le.ADDR_prop+ri.ADDR_prop>0,self.ADDR_score*(0+if(le.SEC_RANGE_prop+ri.SEC_RANGE_prop>0,1,0))/3,0)
+if(le.ADDRESS_prop+ri.ADDRESS_prop>0,self.ADDRESS_score*(0+if(le.ADDR_prop+ri.ADDR_prop>0,1,0)+if(le.LOCALE_prop+ri.LOCALE_prop>0,1,0))/2,0)
+self.DOB_score*(IF( (le.DOB_prop|ri.DOB_prop)&4>0,6,0 )+IF( (le.DOB_prop|ri.DOB_prop)&2>0,4,0 )+IF( (le.DOB_prop|ri.DOB_prop)&1>0,5,0 ))/15 // Compute weight of year/month/day propogation independantly
+if(le.LOCALE_prop+ri.LOCALE_prop>0,self.LOCALE_score*(0+if(le.V_CITY_NAME_prop+ri.V_CITY_NAME_prop>0,1,0)+if(le.ST_prop+ri.ST_prop>0,1,0))/3,0)
+(MAX(le.LNAME_prop,ri.LNAME_prop)/MAX(LENGTH(TRIM(le.LNAME)),LENGTH(TRIM(ri.LNAME))))*self.LNAME_score // Proportion of longest string propogated
+MAX(le.V_CITY_NAME_prop,ri.V_CITY_NAME_prop)*SELF.V_CITY_NAME_score // Score if either field propogated
+(MAX(le.MNAME_prop,ri.MNAME_prop)/MAX(LENGTH(TRIM(le.MNAME)),LENGTH(TRIM(ri.MNAME))))*self.MNAME_score // Proportion of longest string propogated
+(MAX(le.FNAME_prop,ri.FNAME_prop)/MAX(LENGTH(TRIM(le.FNAME)),LENGTH(TRIM(ri.FNAME))))*self.FNAME_score // Proportion of longest string propogated
+MAX(le.SEC_RANGE_prop,ri.SEC_RANGE_prop)*SELF.SEC_RANGE_score // Score if either field propogated
+MAX(le.SNAME_prop,ri.SNAME_prop)*SELF.SNAME_score // Score if either field propogated
+MAX(le.ST_prop,ri.ST_prop)*SELF.ST_score // Score if either field propogated
+MAX(le.GENDER_prop,ri.GENDER_prop)*SELF.GENDER_score // Score if either field propogated
) / 100; // Score based on propogated fields
SELF.Conf := (SELF.VENDOR_ID_score + SELF.DID_score + SELF.NPI_NUMBER_score + SELF.DEA_NUMBER_score + MAX(SELF.FULLNAME_score,MAX(SELF.MAINNAME_score,SELF.FNAME_score + SELF.MNAME_score + SELF.LNAME_score) + SELF.SNAME_score) + SELF.LIC_NBR_score + SELF.UPIN_score + MAX(SELF.ADDRESS_score,MAX(SELF.ADDR_score,SELF.PRIM_RANGE_score + SELF.SEC_RANGE_score + SELF.PRIM_NAME_score) + MAX(SELF.LOCALE_score,SELF.V_CITY_NAME_score + SELF.ST_score + SELF.ZIP_score)) + SELF.TAX_ID_score + SELF.DOB_score + SELF.LAT_LONG_score + SELF.GENDER_score) / 100 + outside;
END;

EXPORT AnnotateMatchesFromData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION
j1 := JOIN(in_data,im,LEFT.LNPID = RIGHT.LNPID1,HASH);
match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
SELF := le;
END;
r := JOIN(j1,in_data,LEFT.LNPID2 = RIGHT.LNPID,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
d := DEDUP( SORT( r, LNPID1, LNPID2, -Conf, LOCAL ), LNPID1, LNPID2, LOCAL ); // LNPID2 distributed by join
RETURN d;
END;

EXPORT AnnotateMatchesFromRecordData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION//Faster form when RID known
j1 := JOIN(in_data,im,LEFT.RID = RIGHT.RID1,HASH);
match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
SELF := le;
END;
RETURN JOIN(j1,in_data,LEFT.RID2 = RIGHT.RID,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
END;

EXPORT AnnotateClusterMatches(DATASET(match_candidates(ih).layout_candidates) in_data,SALT27.UIDType BaseRecord) := FUNCTION//Faster form when RID known
j1 := in_data(RID = BaseRecord);
match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
SELF := le;
END;
RETURN JOIN(in_data(RID<>BaseRecord),j1,TRUE,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),ALL);
END;

EXPORT AnnotateMatches(DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION
RETURN AnnotateMatchesFromRecordData(h,im);
END;
EXPORT Layout_RolledEntity := RECORD,MAXLENGTH(63000)
SALT27.UIDType LNPID;
DATASET(SALT27.Layout_FieldValueList) VENDOR_ID_Values := DATASET([],SALT27.Layout_FieldValueList);
DATASET(SALT27.Layout_FieldValueList) DID_Values := DATASET([],SALT27.Layout_FieldValueList);
DATASET(SALT27.Layout_FieldValueList) NPI_NUMBER_Values := DATASET([],SALT27.Layout_FieldValueList);
DATASET(SALT27.Layout_FieldValueList) DEA_NUMBER_Values := DATASET([],SALT27.Layout_FieldValueList);
DATASET(SALT27.Layout_FieldValueList) FULLNAME_Values := DATASET([],SALT27.Layout_FieldValueList);
DATASET(SALT27.Layout_FieldValueList) LIC_NBR_Values := DATASET([],SALT27.Layout_FieldValueList);
DATASET(SALT27.Layout_FieldValueList) UPIN_Values := DATASET([],SALT27.Layout_FieldValueList);
DATASET(SALT27.Layout_FieldValueList) ADDRESS_Values := DATASET([],SALT27.Layout_FieldValueList);
DATASET(SALT27.Layout_FieldValueList) TAX_ID_Values := DATASET([],SALT27.Layout_FieldValueList);
DATASET(SALT27.Layout_FieldValueList) DOB_Values := DATASET([],SALT27.Layout_FieldValueList);
DATASET(SALT27.Layout_FieldValueList) LAT_LONG_Values := DATASET([],SALT27.Layout_FieldValueList);
DATASET(SALT27.Layout_FieldValueList) GENDER_Values := DATASET([],SALT27.Layout_FieldValueList);
DATASET(SALT27.Layout_FieldValueList) PHONE_Values := DATASET([],SALT27.Layout_FieldValueList);
DATASET(SALT27.Layout_FieldValueList) LIC_STATE_Values := DATASET([],SALT27.Layout_FieldValueList);
DATASET(SALT27.Layout_FieldValueList) ADDRESS_ID_Values := DATASET([],SALT27.Layout_FieldValueList);
DATASET(SALT27.Layout_FieldValueList) CNAME_Values := DATASET([],SALT27.Layout_FieldValueList);
DATASET(SALT27.Layout_FieldValueList) SRC_Values := DATASET([],SALT27.Layout_FieldValueList);
DATASET(SALT27.Layout_FieldValueList) DT_FIRST_SEEN_Values := DATASET([],SALT27.Layout_FieldValueList);
DATASET(SALT27.Layout_FieldValueList) DT_LAST_SEEN_Values := DATASET([],SALT27.Layout_FieldValueList);
DATASET(SALT27.Layout_FieldValueList) DT_LIC_EXPIRATION_Values := DATASET([],SALT27.Layout_FieldValueList);
DATASET(SALT27.Layout_FieldValueList) DT_DEA_EXPIRATION_Values := DATASET([],SALT27.Layout_FieldValueList);
DATASET(SALT27.Layout_FieldValueList) GEO_LAT_Values := DATASET([],SALT27.Layout_FieldValueList);
DATASET(SALT27.Layout_FieldValueList) GEO_LONG_Values := DATASET([],SALT27.Layout_FieldValueList);
END;
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION

Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
SELF.LNPID := le.LNPID;
SELF.VENDOR_ID_values := SALT27.fn_combine_fieldvaluelist(le.VENDOR_ID_values,ri.VENDOR_ID_values);
SELF.DID_values := SALT27.fn_combine_fieldvaluelist(le.DID_values,ri.DID_values);
SELF.NPI_NUMBER_values := SALT27.fn_combine_fieldvaluelist(le.NPI_NUMBER_values,ri.NPI_NUMBER_values);
SELF.DEA_NUMBER_values := SALT27.fn_combine_fieldvaluelist(le.DEA_NUMBER_values,ri.DEA_NUMBER_values);
SELF.FULLNAME_values := SALT27.fn_combine_fieldvaluelist(le.FULLNAME_values,ri.FULLNAME_values);
SELF.LIC_NBR_values := SALT27.fn_combine_fieldvaluelist(le.LIC_NBR_values,ri.LIC_NBR_values);
SELF.UPIN_values := SALT27.fn_combine_fieldvaluelist(le.UPIN_values,ri.UPIN_values);
SELF.ADDRESS_values := SALT27.fn_combine_fieldvaluelist(le.ADDRESS_values,ri.ADDRESS_values);
SELF.TAX_ID_values := SALT27.fn_combine_fieldvaluelist(le.TAX_ID_values,ri.TAX_ID_values);
SELF.DOB_values := SALT27.fn_combine_fieldvaluelist(le.DOB_values,ri.DOB_values);
SELF.LAT_LONG_values := SALT27.fn_combine_fieldvaluelist(le.LAT_LONG_values,ri.LAT_LONG_values);
SELF.GENDER_values := SALT27.fn_combine_fieldvaluelist(le.GENDER_values,ri.GENDER_values);
SELF.PHONE_values := SALT27.fn_combine_fieldvaluelist(le.PHONE_values,ri.PHONE_values);
SELF.LIC_STATE_values := SALT27.fn_combine_fieldvaluelist(le.LIC_STATE_values,ri.LIC_STATE_values);
SELF.ADDRESS_ID_values := SALT27.fn_combine_fieldvaluelist(le.ADDRESS_ID_values,ri.ADDRESS_ID_values);
SELF.CNAME_values := SALT27.fn_combine_fieldvaluelist(le.CNAME_values,ri.CNAME_values);
SELF.SRC_values := SALT27.fn_combine_fieldvaluelist(le.SRC_values,ri.SRC_values);
SELF.DT_FIRST_SEEN_values := SALT27.fn_combine_fieldvaluelist(le.DT_FIRST_SEEN_values,ri.DT_FIRST_SEEN_values);
SELF.DT_LAST_SEEN_values := SALT27.fn_combine_fieldvaluelist(le.DT_LAST_SEEN_values,ri.DT_LAST_SEEN_values);
SELF.DT_LIC_EXPIRATION_values := SALT27.fn_combine_fieldvaluelist(le.DT_LIC_EXPIRATION_values,ri.DT_LIC_EXPIRATION_values);
SELF.DT_DEA_EXPIRATION_values := SALT27.fn_combine_fieldvaluelist(le.DT_DEA_EXPIRATION_values,ri.DT_DEA_EXPIRATION_values);
SELF.GEO_LAT_values := SALT27.fn_combine_fieldvaluelist(le.GEO_LAT_values,ri.GEO_LAT_values);
SELF.GEO_LONG_values := SALT27.fn_combine_fieldvaluelist(le.GEO_LONG_values,ri.GEO_LONG_values);
END;
RETURN ROLLUP( SORT( DISTRIBUTE( infile, HASH(LNPID) ), LNPID, LOCAL ), LEFT.LNPID = RIGHT.LNPID, RollValues(LEFT,RIGHT),LOCAL);
END;

EXPORT RolledEntities(DATASET(match_candidates(ih).layout_candidates) in_data) := FUNCTION

Layout_RolledEntity into(in_data le) := TRANSFORM
SELF.LNPID := le.LNPID;
SELF.VENDOR_ID_Values := IF ( le.VENDOR_ID  IN SET(s.nulls_VENDOR_ID,VENDOR_ID),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.VENDOR_ID)}],SALT27.Layout_FieldValueList));
SELF.DID_Values := IF ( le.DID  IN SET(s.nulls_DID,DID),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.DID)}],SALT27.Layout_FieldValueList));
SELF.NPI_NUMBER_Values := IF ( le.NPI_NUMBER  IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.NPI_NUMBER)}],SALT27.Layout_FieldValueList));
SELF.DEA_NUMBER_Values := IF ( le.DEA_NUMBER  IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.DEA_NUMBER)}],SALT27.Layout_FieldValueList));
self.FULLNAME_Values := IF ( le.FNAME  IN SET(s.nulls_FNAME,FNAME) AND le.MNAME  IN SET(s.nulls_MNAME,MNAME) AND le.LNAME  IN SET(s.nulls_LNAME,LNAME) AND le.SNAME  IN SET(s.nulls_SNAME,SNAME),dataset([],SALT27.Layout_FieldValueList),dataset([{TRIM((SALT27.StrType)le.FNAME) + ' ' + TRIM((SALT27.StrType)le.MNAME) + ' ' + TRIM((SALT27.StrType)le.LNAME) + ' ' + TRIM((SALT27.StrType)le.SNAME)}],SALT27.Layout_FieldValueList));
SELF.LIC_NBR_Values := IF ( le.LIC_NBR  IN SET(s.nulls_LIC_NBR,LIC_NBR),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.LIC_NBR)}],SALT27.Layout_FieldValueList));
SELF.UPIN_Values := IF ( le.UPIN  IN SET(s.nulls_UPIN,UPIN),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.UPIN)}],SALT27.Layout_FieldValueList));
self.ADDRESS_Values := IF ( le.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) AND le.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) AND le.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) AND le.V_CITY_NAME  IN SET(s.nulls_V_CITY_NAME,V_CITY_NAME) AND le.ST  IN SET(s.nulls_ST,ST) AND le.ZIP  IN SET(s.nulls_ZIP,ZIP),dataset([],SALT27.Layout_FieldValueList),dataset([{TRIM((SALT27.StrType)le.PRIM_RANGE) + ' ' + TRIM((SALT27.StrType)le.SEC_RANGE) + ' ' + TRIM((SALT27.StrType)le.PRIM_NAME) + ' ' + TRIM((SALT27.StrType)le.V_CITY_NAME) + ' ' + TRIM((SALT27.StrType)le.ST) + ' ' + TRIM((SALT27.StrType)le.ZIP)}],SALT27.Layout_FieldValueList));
SELF.TAX_ID_Values := IF ( le.TAX_ID  IN SET(s.nulls_TAX_ID,TAX_ID),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.TAX_ID)}],SALT27.Layout_FieldValueList));
self.DOB_Values := IF ( le.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND le.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND le.DOB_day  IN SET(s.nulls_DOB_day,DOB_day),dataset([],SALT27.Layout_FieldValueList),dataset([{TRIM((STRING)le.DOB_month)+'/'+TRIM((STRING)le.DOB_day)+'/'+TRIM((STRING)le.DOB_year)}],SALT27.Layout_FieldValueList));
SELF.LAT_LONG_Values := IF ( le.LAT_LONG  IN SET(s.nulls_LAT_LONG,LAT_LONG),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.LAT_LONG)}],SALT27.Layout_FieldValueList));
SELF.GENDER_Values := IF ( le.GENDER  IN SET(s.nulls_GENDER,GENDER),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.GENDER)}],SALT27.Layout_FieldValueList));
SELF.PHONE_Values := DATASET([{TRIM((SALT27.StrType)le.PHONE)}],SALT27.Layout_FieldValueList);
SELF.LIC_STATE_Values := DATASET([{TRIM((SALT27.StrType)le.LIC_STATE)}],SALT27.Layout_FieldValueList);
SELF.ADDRESS_ID_Values := DATASET([{TRIM((SALT27.StrType)le.ADDRESS_ID)}],SALT27.Layout_FieldValueList);
SELF.CNAME_Values := DATASET([{TRIM((SALT27.StrType)le.CNAME)}],SALT27.Layout_FieldValueList);
SELF.SRC_Values := DATASET([{TRIM((SALT27.StrType)le.SRC)}],SALT27.Layout_FieldValueList);
SELF.DT_FIRST_SEEN_Values := DATASET([{TRIM((SALT27.StrType)le.DT_FIRST_SEEN)}],SALT27.Layout_FieldValueList);
SELF.DT_LAST_SEEN_Values := DATASET([{TRIM((SALT27.StrType)le.DT_LAST_SEEN)}],SALT27.Layout_FieldValueList);
SELF.DT_LIC_EXPIRATION_Values := DATASET([{TRIM((SALT27.StrType)le.DT_LIC_EXPIRATION)}],SALT27.Layout_FieldValueList);
SELF.DT_DEA_EXPIRATION_Values := DATASET([{TRIM((SALT27.StrType)le.DT_DEA_EXPIRATION)}],SALT27.Layout_FieldValueList);
SELF.GEO_LAT_Values := DATASET([{TRIM((SALT27.StrType)le.GEO_LAT)}],SALT27.Layout_FieldValueList);
SELF.GEO_LONG_Values := DATASET([{TRIM((SALT27.StrType)le.GEO_LONG)}],SALT27.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
RETURN RollEntities(AsFieldValues);
END;

Layout_RolledEntity into(ih le) := TRANSFORM
SELF.LNPID := le.LNPID;
SELF.VENDOR_ID_Values := IF ( le.VENDOR_ID  IN SET(s.nulls_VENDOR_ID,VENDOR_ID),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.VENDOR_ID)}],SALT27.Layout_FieldValueList));
SELF.DID_Values := IF ( le.DID  IN SET(s.nulls_DID,DID),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.DID)}],SALT27.Layout_FieldValueList));
SELF.NPI_NUMBER_Values := IF ( le.NPI_NUMBER  IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.NPI_NUMBER)}],SALT27.Layout_FieldValueList));
SELF.DEA_NUMBER_Values := IF ( le.DEA_NUMBER  IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.DEA_NUMBER)}],SALT27.Layout_FieldValueList));
self.FULLNAME_Values := IF ( le.FNAME  IN SET(s.nulls_FNAME,FNAME) AND le.MNAME  IN SET(s.nulls_MNAME,MNAME) AND le.LNAME  IN SET(s.nulls_LNAME,LNAME) AND le.SNAME  IN SET(s.nulls_SNAME,SNAME),dataset([],SALT27.Layout_FieldValueList),dataset([{TRIM((SALT27.StrType)le.FNAME) + ' ' + TRIM((SALT27.StrType)le.MNAME) + ' ' + TRIM((SALT27.StrType)le.LNAME) + ' ' + TRIM((SALT27.StrType)le.SNAME)}],SALT27.Layout_FieldValueList));
SELF.LIC_NBR_Values := IF ( le.LIC_NBR  IN SET(s.nulls_LIC_NBR,LIC_NBR),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.LIC_NBR)}],SALT27.Layout_FieldValueList));
SELF.UPIN_Values := IF ( le.UPIN  IN SET(s.nulls_UPIN,UPIN),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.UPIN)}],SALT27.Layout_FieldValueList));
self.ADDRESS_Values := IF ( le.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) AND le.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) AND le.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) AND le.V_CITY_NAME  IN SET(s.nulls_V_CITY_NAME,V_CITY_NAME) AND le.ST  IN SET(s.nulls_ST,ST) AND le.ZIP  IN SET(s.nulls_ZIP,ZIP),dataset([],SALT27.Layout_FieldValueList),dataset([{TRIM((SALT27.StrType)le.PRIM_RANGE) + ' ' + TRIM((SALT27.StrType)le.SEC_RANGE) + ' ' + TRIM((SALT27.StrType)le.PRIM_NAME) + ' ' + TRIM((SALT27.StrType)le.V_CITY_NAME) + ' ' + TRIM((SALT27.StrType)le.ST) + ' ' + TRIM((SALT27.StrType)le.ZIP)}],SALT27.Layout_FieldValueList));
SELF.TAX_ID_Values := IF ( le.TAX_ID  IN SET(s.nulls_TAX_ID,TAX_ID),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.TAX_ID)}],SALT27.Layout_FieldValueList));
self.DOB_Values := IF ( (unsigned)le.DOB = 0,dataset([],SALT27.Layout_FieldValueList),dataset([{(SALT27.StrType)le.DOB}],SALT27.Layout_FieldValueList));
SELF.GENDER_Values := IF ( le.GENDER  IN SET(s.nulls_GENDER,GENDER),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.GENDER)}],SALT27.Layout_FieldValueList));
SELF.PHONE_Values := DATASET([{TRIM((SALT27.StrType)le.PHONE)}],SALT27.Layout_FieldValueList);
SELF.LIC_STATE_Values := DATASET([{TRIM((SALT27.StrType)le.LIC_STATE)}],SALT27.Layout_FieldValueList);
SELF.ADDRESS_ID_Values := DATASET([{TRIM((SALT27.StrType)le.ADDRESS_ID)}],SALT27.Layout_FieldValueList);
SELF.CNAME_Values := DATASET([{TRIM((SALT27.StrType)le.CNAME)}],SALT27.Layout_FieldValueList);
SELF.SRC_Values := DATASET([{TRIM((SALT27.StrType)le.SRC)}],SALT27.Layout_FieldValueList);
SELF.DT_FIRST_SEEN_Values := DATASET([{TRIM((SALT27.StrType)le.DT_FIRST_SEEN)}],SALT27.Layout_FieldValueList);
SELF.DT_LAST_SEEN_Values := DATASET([{TRIM((SALT27.StrType)le.DT_LAST_SEEN)}],SALT27.Layout_FieldValueList);
SELF.DT_LIC_EXPIRATION_Values := DATASET([{TRIM((SALT27.StrType)le.DT_LIC_EXPIRATION)}],SALT27.Layout_FieldValueList);
SELF.DT_DEA_EXPIRATION_Values := DATASET([{TRIM((SALT27.StrType)le.DT_DEA_EXPIRATION)}],SALT27.Layout_FieldValueList);
SELF.GEO_LAT_Values := DATASET([{TRIM((SALT27.StrType)le.GEO_LAT)}],SALT27.Layout_FieldValueList);
SELF.GEO_LONG_Values := DATASET([{TRIM((SALT27.StrType)le.GEO_LONG)}],SALT27.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(ih,into(left));
EXPORT InFile_Rolled := RollEntities(AsFieldValues);
EXPORT RemoveProps(DATASET(match_candidates(ih).layout_candidates) im) := FUNCTION

im rem(im le) := TRANSFORM
self.NPI_NUMBER := if ( le.NPI_NUMBER_prop>0, (TYPEOF(le.NPI_NUMBER))'', le.NPI_NUMBER ); // Blank if propogated
self.NPI_NUMBER_isnull := le.NPI_NUMBER_prop>0 OR le.NPI_NUMBER_isnull;
self.NPI_NUMBER_prop := 0; // Avoid reducing score later
self.DEA_NUMBER := if ( le.DEA_NUMBER_prop>0, (TYPEOF(le.DEA_NUMBER))'', le.DEA_NUMBER ); // Blank if propogated
self.DEA_NUMBER_isnull := le.DEA_NUMBER_prop>0 OR le.DEA_NUMBER_isnull;
self.DEA_NUMBER_prop := 0; // Avoid reducing score later
self.MAINNAME := if ( le.MAINNAME_prop>0, 0, le.MAINNAME ); // Blank if propogated
self.MAINNAME_isnull := true; // Flag as null to scoring
self.MAINNAME_prop := 0; // Avoid reducing score later
self.FULLNAME := if ( le.FULLNAME_prop>0, 0, le.FULLNAME ); // Blank if propogated
self.FULLNAME_isnull := true; // Flag as null to scoring
self.FULLNAME_prop := 0; // Avoid reducing score later
self.LIC_NBR := if ( le.LIC_NBR_prop>0, (TYPEOF(le.LIC_NBR))'', le.LIC_NBR ); // Blank if propogated
self.LIC_NBR_isnull := le.LIC_NBR_prop>0 OR le.LIC_NBR_isnull;
self.LIC_NBR_prop := 0; // Avoid reducing score later
self.UPIN := if ( le.UPIN_prop>0, (TYPEOF(le.UPIN))'', le.UPIN ); // Blank if propogated
self.UPIN_isnull := le.UPIN_prop>0 OR le.UPIN_isnull;
self.UPIN_prop := 0; // Avoid reducing score later
self.ADDR := if ( le.ADDR_prop>0, 0, le.ADDR ); // Blank if propogated
self.ADDR_isnull := true; // Flag as null to scoring
self.ADDR_prop := 0; // Avoid reducing score later
self.ADDRESS := if ( le.ADDRESS_prop>0, 0, le.ADDRESS ); // Blank if propogated
self.ADDRESS_isnull := true; // Flag as null to scoring
self.ADDRESS_prop := 0; // Avoid reducing score later
self.DOB_year := if ( le.DOB_prop&4>0, 0, le.DOB_year ); // Kill year if propogated
self.DOB_year_isnull := self.DOB_year = 0;
self.DOB_month := if ( le.DOB_prop&2>0, 0, le.DOB_month ); // Kill month if propogated
self.DOB_month_isnull := self.DOB_month = 0;
self.DOB_day := if ( le.DOB_prop&1>0, 0, le.DOB_day ); // Kill day if propogated
self.DOB_day_isnull := self.DOB_day = 0;
self.DOB_prop := 0; // Avoid reducing score later
self.LOCALE := if ( le.LOCALE_prop>0, 0, le.LOCALE ); // Blank if propogated
self.LOCALE_isnull := true; // Flag as null to scoring
self.LOCALE_prop := 0; // Avoid reducing score later
self.LNAME := le.LNAME[1..LENGTH(TRIM(le.LNAME))-le.LNAME_prop]; // Clip propogated chars
self.LNAME_isnull := self.LNAME='' OR le.LNAME_isnull;
self.LNAME_prop := 0; // Avoid reducing score later
self.V_CITY_NAME := if ( le.V_CITY_NAME_prop>0, (TYPEOF(le.V_CITY_NAME))'', le.V_CITY_NAME ); // Blank if propogated
self.V_CITY_NAME_isnull := le.V_CITY_NAME_prop>0 OR le.V_CITY_NAME_isnull;
self.V_CITY_NAME_prop := 0; // Avoid reducing score later
self.MNAME := le.MNAME[1..LENGTH(TRIM(le.MNAME))-le.MNAME_prop]; // Clip propogated chars
self.MNAME_isnull := self.MNAME='' OR le.MNAME_isnull;
self.MNAME_prop := 0; // Avoid reducing score later
self.FNAME := le.FNAME[1..LENGTH(TRIM(le.FNAME))-le.FNAME_prop]; // Clip propogated chars
self.FNAME_isnull := self.FNAME='' OR le.FNAME_isnull;
self.FNAME_prop := 0; // Avoid reducing score later
self.SEC_RANGE := if ( le.SEC_RANGE_prop>0, (TYPEOF(le.SEC_RANGE))'', le.SEC_RANGE ); // Blank if propogated
self.SEC_RANGE_isnull := le.SEC_RANGE_prop>0 OR le.SEC_RANGE_isnull;
self.SEC_RANGE_prop := 0; // Avoid reducing score later
self.SNAME := if ( le.SNAME_prop>0, (TYPEOF(le.SNAME))'', le.SNAME ); // Blank if propogated
self.SNAME_isnull := le.SNAME_prop>0 OR le.SNAME_isnull;
self.SNAME_prop := 0; // Avoid reducing score later
self.ST := if ( le.ST_prop>0, (TYPEOF(le.ST))'', le.ST ); // Blank if propogated
self.ST_isnull := le.ST_prop>0 OR le.ST_isnull;
self.ST_prop := 0; // Avoid reducing score later
self.GENDER := if ( le.GENDER_prop>0, (TYPEOF(le.GENDER))'', le.GENDER ); // Blank if propogated
self.GENDER_isnull := le.GENDER_prop>0 OR le.GENDER_isnull;
self.GENDER_prop := 0; // Avoid reducing score later
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
UNSIGNED1 VENDOR_ID_size := 0;
UNSIGNED1 DID_size := 0;
UNSIGNED1 NPI_NUMBER_size := 0;
UNSIGNED1 DEA_NUMBER_size := 0;
UNSIGNED1 FULLNAME_size := 0;
UNSIGNED1 LIC_NBR_size := 0;
UNSIGNED1 UPIN_size := 0;
UNSIGNED1 ADDRESS_size := 0;
UNSIGNED1 TAX_ID_size := 0;
UNSIGNED1 DOB_size := 0;
UNSIGNED1 LAT_LONG_size := 0;
UNSIGNED1 GENDER_size := 0;
END;
t0 := TABLE(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := TRANSFORM
SELF.VENDOR_ID_size := SALT27.Fn_SwitchSpec(s.VENDOR_ID_switch,count(le.VENDOR_ID_values));
SELF.DID_size := SALT27.Fn_SwitchSpec(s.DID_switch,count(le.DID_values));
SELF.NPI_NUMBER_size := SALT27.Fn_SwitchSpec(s.NPI_NUMBER_switch,count(le.NPI_NUMBER_values));
SELF.DEA_NUMBER_size := SALT27.Fn_SwitchSpec(s.DEA_NUMBER_switch,count(le.DEA_NUMBER_values));
SELF.FULLNAME_size := SALT27.Fn_SwitchSpec(s.FULLNAME_switch,count(le.FULLNAME_values));
SELF.LIC_NBR_size := SALT27.Fn_SwitchSpec(s.LIC_NBR_switch,count(le.LIC_NBR_values));
SELF.UPIN_size := SALT27.Fn_SwitchSpec(s.UPIN_switch,count(le.UPIN_values));
SELF.ADDRESS_size := SALT27.Fn_SwitchSpec(s.ADDRESS_switch,count(le.ADDRESS_values));
SELF.TAX_ID_size := SALT27.Fn_SwitchSpec(s.TAX_ID_switch,count(le.TAX_ID_values));
SELF.DOB_size := SALT27.Fn_SwitchSpec(MAX(s.DOB_day_switch,s.DOB_month_switch,s.DOB_year_switch),count(le.DOB_values));
SELF.LAT_LONG_size := SALT27.Fn_SwitchSpec(s.LAT_LONG_switch,count(le.LAT_LONG_values));
SELF.GENDER_size := SALT27.Fn_SwitchSpec(s.GENDER_switch,count(le.GENDER_values));
SELF := le;
END;  t := PROJECT(t0,NoteSize(LEFT));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
t;
UNSIGNED2 Size := t.VENDOR_ID_size+t.DID_size+t.NPI_NUMBER_size+t.DEA_NUMBER_size+t.FULLNAME_size+t.LIC_NBR_size+t.UPIN_size+t.ADDRESS_size+t.TAX_ID_size+t.DOB_size+t.LAT_LONG_size+t.GENDER_size;
END;
EXPORT Chubbies := TABLE(t,Layout_Chubbies);
END;
