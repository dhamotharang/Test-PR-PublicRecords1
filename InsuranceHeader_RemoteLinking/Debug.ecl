// Various routines to assist in debugging
 
IMPORT SALT37,std;
EXPORT Debug(DATASET(layout_HEADER) ih, Layout_Specificities.R s, MatchThreshold = Config.MatchThreshold) := MODULE
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
SHARED h := match_candidates(ih).candidates;
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
 
/*HACK-O-MATIC*/ EXPORT Layout_Sample_Matches := RECORD,MAXLENGTH(32000)
	TYPEOF(h.RemId) referenceID;
	UNSIGNED2 Rule;
	INTEGER2 Conf;
	INTEGER2 Conf_Prop;
	INTEGER2 DateOverlap := 0;
	SALT37.UIDType DID1;
	SALT37.UIDType DID2;
	SALT37.UIDType RID1;
	SALT37.UIDType RID2;
  TYPEOF(h.ADDRESS) left_ADDRESS;
  INTEGER1 ADDRESS_match_code;
  INTEGER2 ADDRESS_score;
  TYPEOF(h.ADDRESS) right_ADDRESS;
  TYPEOF(h.SSN) left_SSN;
  INTEGER1 SSN_match_code;
  INTEGER2 SSN_score;
// INTEGER2 SSN_score_prop;
  TYPEOF(h.SSN) right_SSN;
  TYPEOF(h.POLICY_NUMBER) left_POLICY_NUMBER;
  INTEGER1 POLICY_NUMBER_match_code;
  INTEGER2 POLICY_NUMBER_score;
  TYPEOF(h.POLICY_NUMBER) right_POLICY_NUMBER;
  TYPEOF(h.CLAIM_NUMBER) left_CLAIM_NUMBER;
  INTEGER1 CLAIM_NUMBER_match_code;
  INTEGER2 CLAIM_NUMBER_score;
  TYPEOF(h.CLAIM_NUMBER) right_CLAIM_NUMBER;
  TYPEOF(h.DL_NBR) left_DL_NBR;
  INTEGER1 DL_NBR_match_code;
  INTEGER2 DL_NBR_score;
  TYPEOF(h.DL_NBR) right_DL_NBR;
  TYPEOF(h.FULLNAME) left_FULLNAME;
  INTEGER1 FULLNAME_match_code;
  INTEGER2 FULLNAME_score;
// INTEGER2 FULLNAME_score_prop;
  BOOLEAN FULLNAME_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.FULLNAME) right_FULLNAME;
  TYPEOF(h.MAINNAME) left_MAINNAME;
  INTEGER1 MAINNAME_match_code;
  INTEGER2 MAINNAME_score;
// INTEGER2 MAINNAME_score_prop;
  TYPEOF(h.MAINNAME) right_MAINNAME;
  TYPEOF(h.ADDR1) left_ADDR1;
  INTEGER1 ADDR1_match_code;
  INTEGER2 ADDR1_score;
  TYPEOF(h.ADDR1) right_ADDR1;
  unsigned6 left_DOB;
  INTEGER1 DOB_year_match_code;
  INTEGER1 DOB_month_match_code;
  INTEGER1 DOB_day_match_code;
  INTEGER1 DOB_match_code;
  INTEGER2 DOB_score;
// INTEGER2 DOB_score_prop;
  BOOLEAN DOB_skipped := FALSE; // True if FORCE blocks match
  unsigned6 right_DOB;
  TYPEOF(h.ZIP) left_ZIP;
  INTEGER1 ZIP_match_code;
  INTEGER2 ZIP_score;
  TYPEOF(h.ZIP) right_ZIP;
  TYPEOF(h.LOCALE) left_LOCALE;
  INTEGER1 LOCALE_match_code;
  INTEGER2 LOCALE_score;
  TYPEOF(h.LOCALE) right_LOCALE;
  TYPEOF(h.PRIM_NAME) left_PRIM_NAME;
  INTEGER1 PRIM_NAME_match_code;
  INTEGER2 PRIM_NAME_score;
  TYPEOF(h.PRIM_NAME) right_PRIM_NAME;
  TYPEOF(h.LNAME) left_LNAME;
  INTEGER1 LNAME_match_code;
  INTEGER2 LNAME_score;
// INTEGER2 LNAME_score_prop;
  TYPEOF(h.LNAME) right_LNAME;
  TYPEOF(h.PRIM_RANGE) left_PRIM_RANGE;
  INTEGER1 PRIM_RANGE_match_code;
  INTEGER2 PRIM_RANGE_score;
  TYPEOF(h.PRIM_RANGE) right_PRIM_RANGE;
  TYPEOF(h.CITY) left_CITY;
  INTEGER1 CITY_match_code;
  INTEGER2 CITY_score;
  TYPEOF(h.CITY) right_CITY;
  TYPEOF(h.FNAME) left_FNAME;
  INTEGER1 FNAME_match_code;
  INTEGER2 FNAME_score;
// INTEGER2 FNAME_score_prop;
  BOOLEAN FNAME_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.FNAME) right_FNAME;
  TYPEOF(h.SEC_RANGE) left_SEC_RANGE;
  INTEGER1 SEC_RANGE_match_code;
  INTEGER2 SEC_RANGE_score;
  TYPEOF(h.SEC_RANGE) right_SEC_RANGE;
  TYPEOF(h.MNAME) left_MNAME;
  INTEGER1 MNAME_match_code;
  INTEGER2 MNAME_score;
// INTEGER2 MNAME_score_prop;
  TYPEOF(h.MNAME) right_MNAME;
  TYPEOF(h.ST) left_ST;
  INTEGER1 ST_match_code;
  INTEGER2 ST_score;
  TYPEOF(h.ST) right_ST;
  TYPEOF(h.SNAME) left_SNAME;
  INTEGER1 SNAME_match_code;
  INTEGER2 SNAME_score;
// INTEGER2 SNAME_score_prop;
  TYPEOF(h.SNAME) right_SNAME;
  TYPEOF(h.GENDER) left_GENDER;
  INTEGER1 GENDER_match_code;
  INTEGER2 GENDER_score;
  TYPEOF(h.GENDER) right_GENDER;
  TYPEOF(h.DERIVED_GENDER) left_DERIVED_GENDER;
  INTEGER1 DERIVED_GENDER_match_code;
  INTEGER2 DERIVED_GENDER_score;
// INTEGER2 DERIVED_GENDER_score_prop;
  TYPEOF(h.DERIVED_GENDER) right_DERIVED_GENDER;
  TYPEOF(h.VENDOR_ID) left_VENDOR_ID;
  TYPEOF(h.VENDOR_ID) right_VENDOR_ID;
  TYPEOF(h.BOCA_DID) left_BOCA_DID;
  TYPEOF(h.BOCA_DID) right_BOCA_DID;
  TYPEOF(h.SRC) left_SRC;
  TYPEOF(h.SRC) right_SRC;
  TYPEOF(h.DT_FIRST_SEEN) left_DT_FIRST_SEEN;
  TYPEOF(h.DT_FIRST_SEEN) right_DT_FIRST_SEEN;
  TYPEOF(h.DT_LAST_SEEN) left_DT_LAST_SEEN;
  TYPEOF(h.DT_LAST_SEEN) right_DT_LAST_SEEN;
  TYPEOF(h.DL_STATE) left_DL_STATE;
  TYPEOF(h.DL_STATE) right_DL_STATE;
  TYPEOF(h.AMBEST) left_AMBEST;
/*HACK-O-MATIC*/ TYPEOF(h.AMBEST) right_AMBEST;
	INTEGER2 SSN_prop_score;
	INTEGER2 DOB_prop_score;
	INTEGER2 FULLNAME_prop_score;
	INTEGER2 MAINNAME_prop_score;
	INTEGER2 FNAME_prop_score;
	INTEGER2 MNAME_prop_score;
	INTEGER2 LNAME_prop_score;
	INTEGER2 SNAME_prop_score;
	INTEGER2 DERIVED_GENDER_prop_score;
END;
EXPORT layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
/*HACK-O-MATIC*/ SELF.ReferenceID := le.RemID;
	SELF.Rule := c;
	SELF.DID1 := le.RemLexid;
	SELF.DID2 := ri.RemLexid;
  SELF.RID1 := le.RID;
  SELF.RID2 := ri.RID;
  SELF.DateOverlap := SALT37.fn_ComputeDateOverlap(((UNSIGNED)le.DT_FIRST_SEEN)*100,((UNSIGNED)le.DT_LAST_SEEN)*100,((UNSIGNED)ri.DT_FIRST_SEEN)*100,((UNSIGNED)ri.DT_LAST_SEEN)*100);
  SELF.ADDRESS_match_code := MAP(
                        (le.ADDRESS_isnull OR (le.ADDR1_isnull OR le.PRIM_RANGE_isnull AND le.SEC_RANGE_isnull AND le.PRIM_NAME_isnull) AND (le.LOCALE_isnull OR le.CITY_isnull AND le.ST_isnull AND le.ZIP_isnull)) OR (ri.ADDRESS_isnull OR (ri.ADDR1_isnull OR ri.PRIM_RANGE_isnull AND ri.SEC_RANGE_isnull AND ri.PRIM_NAME_isnull) AND (ri.LOCALE_isnull OR ri.CITY_isnull AND ri.ST_isnull AND ri.ZIP_isnull)) => SALT37.MatchCode.OneSideNull,
                        match_methods(ih).match_ADDRESS(le.ADDRESS,ri.ADDRESS,FALSE));
  REAL ADDRESS_score_scale := ( le.ADDRESS_weight100 + ri.ADDRESS_weight100 ) / (le.ADDR1_weight100 + ri.ADDR1_weight100 + le.LOCALE_weight100 + ri.LOCALE_weight100); // Scaling factor for this concept
  INTEGER2 ADDRESS_score_pre := MAP( (le.ADDRESS_isnull OR (le.ADDR1_isnull OR le.PRIM_RANGE_isnull AND le.SEC_RANGE_isnull AND le.PRIM_NAME_isnull) AND (le.LOCALE_isnull OR le.CITY_isnull AND le.ST_isnull AND le.ZIP_isnull)) OR (ri.ADDRESS_isnull OR (ri.ADDR1_isnull OR ri.PRIM_RANGE_isnull AND ri.SEC_RANGE_isnull AND ri.PRIM_NAME_isnull) AND (ri.LOCALE_isnull OR ri.CITY_isnull AND ri.ST_isnull AND ri.ZIP_isnull)) => 0,
                        le.ADDRESS = ri.ADDRESS  => le.ADDRESS_weight100,
                        0);
  SELF.left_ADDRESS := le.ADDRESS;
  SELF.right_ADDRESS := ri.ADDRESS;
  SELF.left_SSN := le.SSN;
  SELF.right_SSN := ri.SSN;
  SELF.SSN_match_code := MAP(
                        le.SSN_isnull OR ri.SSN_isnull => SALT37.MatchCode.OneSideNull,
                        match_methods(ih).match_SSN(le.SSN,ri.SSN, le.SSN_len, ri.SSN_len));
/*HACK-O-MATIC*/ SSN_score_v1 := MAP(
                        le.SSN_isnull OR ri.SSN_isnull => 0,
                        le.SSN = ri.SSN  => le.SSN_weight100,
                        Config.WithinEditN(le.SSN,le.SSN_len,ri.SSN,ri.SSN_len,1,0) =>  SALT37.fn_fuzzy_specificity(le.SSN_weight100,le.SSN_cnt, le.SSN_e1_cnt,ri.SSN_weight100,ri.SSN_cnt,ri.SSN_e1_cnt),
                        le.SSN_Right4 = ri.SSN_Right4 => SALT37.fn_fuzzy_specificity(le.SSN_weight100,le.SSN_cnt, le.SSN_Right4_cnt,ri.SSN_weight100,ri.SSN_cnt,ri.SSN_Right4_cnt),
                        SALT37.Fn_Fail_Scale(le.SSN_weight100,s.SSN_switch));
/*HACK-O-MATIC*/ SELF.SSN_score := SSN_score_v1;
  SELF.left_POLICY_NUMBER := le.POLICY_NUMBER;
  SELF.right_POLICY_NUMBER := ri.POLICY_NUMBER;
  SELF.POLICY_NUMBER_match_code := MAP(
                        le.POLICY_NUMBER_isnull OR ri.POLICY_NUMBER_isnull => SALT37.MatchCode.OneSideNull,
                        le.AMBEST = (TYPEOF(le.AMBEST))'' OR ri.AMBEST = (TYPEOF(ri.AMBEST))'' OR le.AMBEST <> ri.AMBEST  => SALT37.MatchCode.ContextInvolved, // Only valid if the context variable is equal
                        match_methods(ih).match_POLICY_NUMBER(le.POLICY_NUMBER,ri.POLICY_NUMBER));
  SELF.POLICY_NUMBER_score := MAP(
                        le.POLICY_NUMBER_isnull OR ri.POLICY_NUMBER_isnull => 0,
                        le.AMBEST = (TYPEOF(le.AMBEST))'' OR ri.AMBEST = (TYPEOF(ri.AMBEST))'' OR le.AMBEST <> ri.AMBEST  => 0, // Only valid if the context variable is equal
                        le.POLICY_NUMBER = ri.POLICY_NUMBER  => le.POLICY_NUMBER_weight100,
                        le.POLICY_NUMBER_TrimLeadingZero = ri.POLICY_NUMBER_TrimLeadingZero => SALT37.fn_fuzzy_specificity(le.POLICY_NUMBER_weight100,le.POLICY_NUMBER_cnt, le.POLICY_NUMBER_TrimLeadingZero_cnt,ri.POLICY_NUMBER_weight100,ri.POLICY_NUMBER_cnt,ri.POLICY_NUMBER_TrimLeadingZero_cnt),
                        SALT37.Fn_Fail_Scale(le.POLICY_NUMBER_weight100,s.POLICY_NUMBER_switch));
  SELF.left_CLAIM_NUMBER := le.CLAIM_NUMBER;
  SELF.right_CLAIM_NUMBER := ri.CLAIM_NUMBER;
  SELF.CLAIM_NUMBER_match_code := MAP(
                        le.CLAIM_NUMBER_isnull OR ri.CLAIM_NUMBER_isnull => SALT37.MatchCode.OneSideNull,
                        le.AMBEST = (TYPEOF(le.AMBEST))'' OR ri.AMBEST = (TYPEOF(ri.AMBEST))'' OR le.AMBEST <> ri.AMBEST  => SALT37.MatchCode.ContextInvolved, // Only valid if the context variable is equal
                        match_methods(ih).match_CLAIM_NUMBER(le.CLAIM_NUMBER,ri.CLAIM_NUMBER));
  SELF.CLAIM_NUMBER_score := MAP(
                        le.CLAIM_NUMBER_isnull OR ri.CLAIM_NUMBER_isnull => 0,
                        le.AMBEST = (TYPEOF(le.AMBEST))'' OR ri.AMBEST = (TYPEOF(ri.AMBEST))'' OR le.AMBEST <> ri.AMBEST  => 0, // Only valid if the context variable is equal
                        le.CLAIM_NUMBER = ri.CLAIM_NUMBER  => le.CLAIM_NUMBER_weight100,
                        SALT37.Fn_Fail_Scale(le.CLAIM_NUMBER_weight100,s.CLAIM_NUMBER_switch));
  SELF.left_DL_NBR := le.DL_NBR;
  SELF.right_DL_NBR := ri.DL_NBR;
  SELF.DL_NBR_match_code := MAP(
                        le.DL_NBR_isnull OR ri.DL_NBR_isnull => SALT37.MatchCode.OneSideNull,
                        le.DL_STATE = (TYPEOF(le.DL_STATE))'' OR ri.DL_STATE = (TYPEOF(ri.DL_STATE))'' OR le.DL_STATE <> ri.DL_STATE  => SALT37.MatchCode.ContextInvolved, // Only valid if the context variable is equal
                        match_methods(ih).match_DL_NBR(le.DL_NBR,ri.DL_NBR));
/*HACK-O-MATIC*/ DL_NBR_score_v1 := MAP(
                        le.DL_NBR_isnull OR ri.DL_NBR_isnull => 0,
                        le.DL_STATE = (TYPEOF(le.DL_STATE))'' OR ri.DL_STATE = (TYPEOF(ri.DL_STATE))'' OR le.DL_STATE <> ri.DL_STATE  => 0, // Only valid if the context variable is equal
                        le.DL_NBR = ri.DL_NBR  => le.DL_NBR_weight100,
                        le.DL_NBR_TrimLeadingZero = ri.DL_NBR_TrimLeadingZero => SALT37.fn_fuzzy_specificity(le.DL_NBR_weight100,le.DL_NBR_cnt, le.DL_NBR_TrimLeadingZero_cnt,ri.DL_NBR_weight100,ri.DL_NBR_cnt,ri.DL_NBR_TrimLeadingZero_cnt),
                        SALT37.Fn_Fail_Scale(le.DL_NBR_weight100,s.DL_NBR_switch));
/*HACK-O-MATIC*/ SELF.DL_NBR_score := DL_NBR_score_v1;
  SELF.FULLNAME_match_code := MAP(
                        (le.FULLNAME_isnull OR (le.MAINNAME_isnull OR le.FNAME_isnull AND le.MNAME_isnull AND le.LNAME_isnull) AND le.SNAME_isnull) OR (ri.FULLNAME_isnull OR (ri.MAINNAME_isnull OR ri.FNAME_isnull AND ri.MNAME_isnull AND ri.LNAME_isnull) AND ri.SNAME_isnull) OR le.FULLNAME_weight100 = 0 => SALT37.MatchCode.OneSideNull,
                        match_methods(ih).match_FULLNAME(le.FULLNAME,ri.FULLNAME,FALSE));
  REAL FULLNAME_score_scale := ( le.FULLNAME_weight100 + ri.FULLNAME_weight100 ) / (le.MAINNAME_weight100 + ri.MAINNAME_weight100 + le.SNAME_weight100 + ri.SNAME_weight100); // Scaling factor for this concept
  INTEGER2 FULLNAME_score_pre := MAP( (le.FULLNAME_isnull OR (le.MAINNAME_isnull OR le.FNAME_isnull AND le.MNAME_isnull AND le.LNAME_isnull) AND le.SNAME_isnull) OR (ri.FULLNAME_isnull OR (ri.MAINNAME_isnull OR ri.FNAME_isnull AND ri.MNAME_isnull AND ri.LNAME_isnull) AND ri.SNAME_isnull) OR le.FULLNAME_weight100 = 0 => 0,
                        le.FULLNAME = ri.FULLNAME  => le.FULLNAME_weight100,
                        0);
  SELF.left_FULLNAME := le.FULLNAME;
  SELF.right_FULLNAME := ri.FULLNAME;
  SELF.MAINNAME_match_code := MAP(
                        (le.MAINNAME_isnull OR le.FNAME_isnull AND le.MNAME_isnull AND le.LNAME_isnull) OR (ri.MAINNAME_isnull OR ri.FNAME_isnull AND ri.MNAME_isnull AND ri.LNAME_isnull) => SALT37.MatchCode.OneSideNull,
                        FULLNAME_score_pre > 0 => SALT37.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_MAINNAME(le.MAINNAME,ri.MAINNAME,(SALT37.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,true,Config.FNAME_Force,true,,IF( LENGTH(TRIM((SALT37.StrType)le.FNAME))<6, 1, 2),6,le.FNAME_len,le.FNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)le.MNAME,le.MNAME_MAINNAME_weight100,true,0,true,,IF( LENGTH(TRIM((SALT37.StrType)le.MNAME))<6, 1, 2),6,le.MNAME_len,le.MNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)le.LNAME,le.LNAME_MAINNAME_weight100,true,0,true,,IF( LENGTH(TRIM((SALT37.StrType)le.LNAME))<6, 1, 2),6,le.LNAME_len,le.LNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)ri.FNAME,ri.FNAME_MAINNAME_weight100,ri.FNAME_len,ri.FNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)ri.MNAME,ri.MNAME_MAINNAME_weight100,ri.MNAME_len,ri.MNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)ri.LNAME,ri.LNAME_MAINNAME_weight100,ri.LNAME_len,ri.LNAME_MAINNAME_fuzzy_weight100,FALSE));
  REAL MAINNAME_score_scale := ( le.MAINNAME_weight100 + ri.MAINNAME_weight100 ) / (le.FNAME_weight100 + ri.FNAME_weight100 + le.MNAME_weight100 + ri.MNAME_weight100 + le.LNAME_weight100 + ri.LNAME_weight100); // Scaling factor for this concept
/*HACK-O-MATIC*/ INTEGER2 MAINNAME_score_pre_v1 := MAP( (le.MAINNAME_isnull OR le.FNAME_isnull AND le.MNAME_isnull AND le.LNAME_isnull) OR (ri.MAINNAME_isnull OR ri.FNAME_isnull AND ri.MNAME_isnull AND ri.LNAME_isnull) => 0,
                        FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.MAINNAME = ri.MAINNAME  => le.MAINNAME_weight100,
                        SALT37.fn_concept_wordbag_EditN.Match3((SALT37.StrType)ri.FNAME,ri.FNAME_MAINNAME_weight100,true,Config.FNAME_Force,true,IF( LENGTH(TRIM((SALT37.StrType)ri.FNAME))<6, 1, 2),6,ri.FNAME_len,ri.FNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)ri.MNAME,ri.MNAME_MAINNAME_weight100,true,0,true,IF( LENGTH(TRIM((SALT37.StrType)ri.MNAME))<6, 1, 2),6,ri.MNAME_len,ri.MNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)ri.LNAME,ri.LNAME_MAINNAME_weight100,true,0,true,IF( LENGTH(TRIM((SALT37.StrType)ri.LNAME))<6, 1, 2),6,ri.LNAME_len,ri.LNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,le.FNAME_len,le.FNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)le.MNAME,le.MNAME_MAINNAME_weight100,le.MNAME_len,le.MNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)le.LNAME,le.LNAME_MAINNAME_weight100,le.LNAME_len,le.LNAME_MAINNAME_fuzzy_weight100,InsuranceHeader_RemoteLinking.Config.WithinEditN)*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale))*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
/*HACK-O-MATIC*/ INTEGER2 MAINNAME_score_strict := MAP( (le.MAINNAME_isnull OR le.FNAME_isnull AND le.MNAME_isnull AND le.LNAME_isnull) OR (ri.MAINNAME_isnull OR ri.FNAME_isnull AND ri.MNAME_isnull AND ri.LNAME_isnull) => 0,
/*HACK-O-MATIC*/ FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
/*HACK-O-MATIC*/ le.MAINNAME = ri.MAINNAME  => le.MAINNAME_weight100,
/*HACK-O-MATIC*/ SALT37.fn_concept_wordbag_EditN.Match3((SALT37.StrType)ri.FNAME,ri.FNAME_MAINNAME_weight100,false,Config.FNAME_Force,false,0,0,ri.FNAME_len,ri.FNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)ri.MNAME,ri.MNAME_MAINNAME_weight100,false,0,false,0,0,ri.MNAME_len,ri.MNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)ri.LNAME,ri.LNAME_MAINNAME_weight100,false,0,false,0,0,ri.LNAME_len,ri.LNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,le.FNAME_len,le.FNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)le.MNAME,le.MNAME_MAINNAME_weight100,le.MNAME_len,le.MNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)le.LNAME,le.LNAME_MAINNAME_weight100,le.LNAME_len,le.LNAME_MAINNAME_fuzzy_weight100,InsuranceHeader_RemoteLinking.Config.WithinEditN)*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale))*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
SELF.left_MAINNAME := le.MAINNAME;
  SELF.right_MAINNAME := ri.MAINNAME;
  SELF.ADDR1_match_code := MAP(
                        (le.ADDR1_isnull OR le.PRIM_RANGE_isnull AND le.SEC_RANGE_isnull AND le.PRIM_NAME_isnull) OR (ri.ADDR1_isnull OR ri.PRIM_RANGE_isnull AND ri.SEC_RANGE_isnull AND ri.PRIM_NAME_isnull) => SALT37.MatchCode.OneSideNull,
                        ADDRESS_score_pre > 0 => SALT37.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_ADDR1(le.ADDR1,ri.ADDR1,FALSE));
  REAL ADDR1_score_scale := ( le.ADDR1_weight100 + ri.ADDR1_weight100 ) / (le.PRIM_RANGE_weight100 + ri.PRIM_RANGE_weight100 + le.SEC_RANGE_weight100 + ri.SEC_RANGE_weight100 + le.PRIM_NAME_weight100 + ri.PRIM_NAME_weight100); // Scaling factor for this concept
  INTEGER2 ADDR1_score_pre := MAP( (le.ADDR1_isnull OR le.PRIM_RANGE_isnull AND le.SEC_RANGE_isnull AND le.PRIM_NAME_isnull) OR (ri.ADDR1_isnull OR ri.PRIM_RANGE_isnull AND ri.SEC_RANGE_isnull AND ri.PRIM_NAME_isnull) => 0,
                        ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.ADDR1 = ri.ADDR1  => le.ADDR1_weight100,
                        0)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  SELF.left_ADDR1 := le.ADDR1;
  SELF.right_ADDR1 := ri.ADDR1;
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
  SELF.DOB_year_match_code := MAP(
                        le.DOB_year_isnull OR ri.DOB_year_isnull => SALT37.MatchCode.OneSideNull,
                        DOB_year_score+DOB_month_score+DOB_day_score < 0 OR DOB_year_score+DOB_month_score+DOB_day_score<>0 AND DOB_year_score+DOB_month_score+DOB_day_score < 300 => SALT37.MatchCode.ForcedNoMatch,
                        DOB_year_score < 0 AND ABS(le.DOB_year-ri.DOB_year) > 13 => SALT37.MatchCode.ForcedNoMatch, // Do not allow full generation mis-match
                        match_methods(ih).match_DOB_year(le.DOB_year,ri.DOB_year));
  SELF.DOB_month_match_code := MAP(
                        le.DOB_month_isnull OR ri.DOB_month_isnull => SALT37.MatchCode.OneSideNull,
                        DOB_year_score+DOB_month_score+DOB_day_score < 0 OR DOB_year_score+DOB_month_score+DOB_day_score<>0 AND DOB_year_score+DOB_month_score+DOB_day_score < 300 => SALT37.MatchCode.ForcedNoMatch,
                        DOB_year_score < 0 AND ABS(le.DOB_year-ri.DOB_year) > 13 => SALT37.MatchCode.ForcedNoMatch, // Do not allow full generation mis-match
                        match_methods(ih).match_DOB_month(le.DOB_month,ri.DOB_month,le.DOB_day,ri.DOB_day));
  SELF.DOB_day_match_code := MAP(
                        le.DOB_day_isnull or ri.DOB_day_isnull => SALT37.MatchCode.OneSideNull,
                        DOB_year_score+DOB_month_score+DOB_day_score < 0 OR DOB_year_score+DOB_month_score+DOB_day_score<>0 AND DOB_year_score+DOB_month_score+DOB_day_score < 300 => SALT37.MatchCode.ForcedNoMatch,
                        DOB_year_score < 0 AND ABS(le.DOB_year-ri.DOB_year) > 13 => SALT37.MatchCode.ForcedNoMatch, // Do not allow full generation mis-match
                        match_methods(ih).match_DOB_day(le.DOB_month,ri.DOB_month,le.DOB_day,ri.DOB_day));
  SELF.DOB_match_code := MAP(
                        le.DOB_day_isnull AND le.DOB_month_isnull AND le.DOB_year_isnull OR ri.DOB_day_isnull AND ri.DOB_month_isnull AND ri.DOB_year_isnull => SALT37.MatchCode.OneSideNull,
                        DOB_year_score+DOB_month_score+DOB_day_score < 0 OR DOB_year_score+DOB_month_score+DOB_day_score<>0 AND DOB_year_score+DOB_month_score+DOB_day_score < 300 => SALT37.MatchCode.ForcedNoMatch,
                        DOB_year_score < 0 AND ABS(le.DOB_year-ri.DOB_year) > 13 => SALT37.MatchCode.ForcedNoMatch, // Do not allow full generation mis-match
                        DOB_score_temp = DOB_year_score+DOB_month_score+DOB_day_score => SALT37.MatchCode.DateAggregate,
                        SALT37.MatchCode.NoMatch);
/*HACK-O-MATIC*/ DOB_score_v1 := MAP( le.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND le.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND le.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) or ri.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND ri.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND ri.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) => 0,
                        DOB_year_score+DOB_month_score+DOB_day_score < 0 or DOB_year_score+DOB_month_score+DOB_day_score<>0 and DOB_year_score+DOB_month_score+DOB_day_score < 300 => -9999,
                        DOB_year_score < 0 and ABS(le.DOB_year-ri.DOB_year) > 13 => -9999, // Do not allow full generation mis-match
                        DOB_score_temp);
/*HACK-O-MATIC*/ SELF.DOB_score := DOB_score_v1;
 
  DOB_skipped := SELF.DOB_score = -9999;// Enforce FORCE parameter
  SELF.left_DOB := (( le.DOB_year * 100 ) + le.DOB_month ) * 100 + le.DOB_day;
  SELF.right_DOB := (( ri.DOB_year * 100 ) + ri.DOB_month ) * 100 + ri.DOB_day;
/*HACK-O-MATIC*/ integer2 MAINNAME_score_pre := if ((ssn_score_v1 > Config.SSN_Score_Min_MAINNAME AND dob_score_v1 > Config.DOB_Score_Min_MAINNAME)
 OR MAINNAME_score_strict > 0,
 MAINNAME_score_pre_v1, 0);

  SELF.LOCALE_match_code := MAP(
                        (le.LOCALE_isnull OR le.CITY_isnull AND le.ST_isnull AND le.ZIP_isnull) OR (ri.LOCALE_isnull OR ri.CITY_isnull AND ri.ST_isnull AND ri.ZIP_isnull) => SALT37.MatchCode.OneSideNull,
                        ADDRESS_score_pre > 0 => SALT37.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_LOCALE(le.LOCALE,ri.LOCALE,FALSE));
  REAL LOCALE_score_scale := ( le.LOCALE_weight100 + ri.LOCALE_weight100 ) / (le.CITY_weight100 + ri.CITY_weight100 + le.ST_weight100 + ri.ST_weight100 + le.ZIP_weight100 + ri.ZIP_weight100); // Scaling factor for this concept
  INTEGER2 LOCALE_score_pre := MAP( (le.LOCALE_isnull OR le.CITY_isnull AND le.ST_isnull AND le.ZIP_isnull) OR (ri.LOCALE_isnull OR ri.CITY_isnull AND ri.ST_isnull AND ri.ZIP_isnull) => 0,
                        ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.LOCALE = ri.LOCALE  => le.LOCALE_weight100,
                        0)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  SELF.left_LOCALE := le.LOCALE;
  SELF.right_LOCALE := ri.LOCALE;
  SELF.left_PRIM_NAME := le.PRIM_NAME;
  SELF.right_PRIM_NAME := ri.PRIM_NAME;
  SELF.PRIM_NAME_match_code := MAP(
                        le.PRIM_NAME_isnull OR ri.PRIM_NAME_isnull => SALT37.MatchCode.OneSideNull,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => SALT37.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_PRIM_NAME(le.PRIM_NAME,ri.PRIM_NAME));
  SELF.PRIM_NAME_score := MAP(
                        le.PRIM_NAME_isnull OR ri.PRIM_NAME_isnull => 0,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.PRIM_NAME = ri.PRIM_NAME  => le.PRIM_NAME_weight100,
                        SALT37.Fn_Fail_Scale(le.PRIM_NAME_weight100,s.PRIM_NAME_switch))*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  SELF.left_LNAME := le.LNAME;
  SELF.right_LNAME := ri.LNAME;
  SELF.LNAME_match_code := MAP(
                        le.LNAME_isnull OR ri.LNAME_isnull => SALT37.MatchCode.OneSideNull,
                        MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => SALT37.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_LNAME(le.LNAME,ri.LNAME, le.LNAME_len, ri.LNAME_len));
/*HACK-O-MATIC*/  		/*------------------added cfouts----------------------*/
		INTEGER2 lname_score_noancestor := MAP( le.LNAME_isnull OR ri.LNAME_isnull => 0,
					le.LNAME = ri.LNAME OR SALT37.HyphenMatch(le.LNAME,ri.LNAME,1)<=2  => MIN(le.LNAME_weight100,ri.LNAME_weight100),
					LENGTH(TRIM(le.LNAME))>0 and le.LNAME = ri.LNAME[1..LENGTH(TRIM(le.LNAME))] => le.LNAME_weight100, // An initial match - take initial specificity
					LENGTH(TRIM(ri.LNAME))>0 and ri.LNAME = le.LNAME[1..LENGTH(TRIM(ri.LNAME))] => ri.LNAME_weight100, // An initial match - take initial specificity
					InsuranceHeader_RemoteLinking.Config.WithinEditN(le.LNAME,le.LNAME_len,ri.LNAME,ri.LNAME_len,1,0) => SALT37.fn_fuzzy_specificity(le.LNAME_weight100,le.LNAME_cnt, le.LNAME_e1_cnt,ri.LNAME_weight100,ri.LNAME_cnt,ri.LNAME_e1_cnt),
					InsuranceHeader_RemoteLinking.Config.WithinEditN(le.LNAME,le.LNAME_len,ri.LNAME,ri.LNAME_len,2,6) => SALT37.fn_fuzzy_specificity(le.LNAME_weight100,le.LNAME_cnt, le.LNAME_e2_cnt,ri.LNAME_weight100,ri.LNAME_cnt,ri.LNAME_e2_cnt),
					SALT37.Fn_Fail_Scale(le.LNAME_weight100,s.LNAME_switch))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);

	SELF.LNAME_score := MAP(le.LNAME_isnull OR ri.LNAME_isnull => 0,
					MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => 0,
					lname_score_noancestor);
/*------------------added cfouts----------------------*/
  SELF.left_PRIM_RANGE := le.PRIM_RANGE;
  SELF.right_PRIM_RANGE := ri.PRIM_RANGE;
  SELF.PRIM_RANGE_match_code := MAP(
                        le.PRIM_RANGE_isnull OR ri.PRIM_RANGE_isnull => SALT37.MatchCode.OneSideNull,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => SALT37.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_PRIM_RANGE(le.PRIM_RANGE,ri.PRIM_RANGE));
  SELF.PRIM_RANGE_score := MAP(
                        le.PRIM_RANGE_isnull OR ri.PRIM_RANGE_isnull => 0,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.PRIM_RANGE = ri.PRIM_RANGE  => le.PRIM_RANGE_weight100,
                        SALT37.Fn_Fail_Scale(le.PRIM_RANGE_weight100,s.PRIM_RANGE_switch))*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  SELF.left_CITY := le.CITY;
  SELF.right_CITY := ri.CITY;
  SELF.CITY_match_code := MAP(
                        le.CITY_isnull OR ri.CITY_isnull => SALT37.MatchCode.OneSideNull,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => SALT37.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_CITY(le.CITY,ri.CITY));
  SELF.CITY_score := MAP(
                        le.CITY_isnull OR ri.CITY_isnull => 0,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.CITY = ri.CITY  => le.CITY_weight100,
                        SALT37.Fn_Fail_Scale(le.CITY_weight100,s.CITY_switch))*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  SELF.left_FNAME := le.FNAME;
  SELF.right_FNAME := ri.FNAME;
  SELF.FNAME_match_code := MAP(
                        le.FNAME_isnull OR ri.FNAME_isnull => SALT37.MatchCode.OneSideNull,
                        MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => SALT37.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_FNAME(le.FNAME,ri.FNAME, le.FNAME_len, ri.FNAME_len));
/*HACK-O-MATIC*/ INTEGER2 FNAME_score_temp_noancestor := MAP(
						le.FNAME_isnull OR ri.FNAME_isnull => 0,
						//MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.FNAME = ri.FNAME  => le.FNAME_weight100,
                        LENGTH(TRIM(le.FNAME))>0 and le.FNAME = ri.FNAME[1..LENGTH(TRIM(le.FNAME))] => le.FNAME_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.FNAME))>0 and ri.FNAME = le.FNAME[1..LENGTH(TRIM(ri.FNAME))] => ri.FNAME_weight100, // An initial match - take initial specificity
                        Config.WithinEditN(le.FNAME,le.FNAME_len,ri.FNAME,ri.FNAME_len,1,0) => SALT37.fn_fuzzy_specificity(le.FNAME_weight100,le.FNAME_cnt, le.FNAME_e1_cnt,ri.FNAME_weight100,ri.FNAME_cnt,ri.FNAME_e1_cnt),
												Config.WithinEditN(le.FNAME,le.FNAME_len,ri.FNAME,ri.FNAME_len,2,6) => SALT37.fn_fuzzy_specificity(le.FNAME_weight100,le.FNAME_cnt, le.FNAME_e2_cnt,ri.FNAME_weight100,ri.FNAME_cnt,ri.FNAME_e2_cnt),
                        le.FNAME_PreferredName = ri.FNAME_PreferredName => SALT37.fn_fuzzy_specificity(le.FNAME_weight100,le.FNAME_cnt, le.FNAME_PreferredName_cnt,ri.FNAME_weight100,ri.FNAME_cnt,ri.FNAME_PreferredName_cnt),
                        SALT37.Fn_Fail_Scale(le.FNAME_weight100,s.FNAME_switch))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
	/*------------------added cfouts----------------------*/
	INTEGER2 FNAME_score_temp := MAP(le.FNAME_isnull OR ri.FNAME_isnull => 0,
						MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => 0,
						FNAME_score_temp_noancestor);
	/*------------------added cfouts----------------------*/

	SELF.left_SEC_RANGE := le.SEC_RANGE;
  SELF.right_SEC_RANGE := ri.SEC_RANGE;
  SELF.SEC_RANGE_match_code := MAP(
                        le.SEC_RANGE_isnull OR ri.SEC_RANGE_isnull => SALT37.MatchCode.OneSideNull,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => SALT37.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_SEC_RANGE(le.SEC_RANGE,ri.SEC_RANGE));
  SELF.SEC_RANGE_score := MAP(
                        le.SEC_RANGE_isnull OR ri.SEC_RANGE_isnull => 0,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.SEC_RANGE = ri.SEC_RANGE OR SALT37.HyphenMatch(le.SEC_RANGE,ri.SEC_RANGE,1)<=2  => MIN(le.SEC_RANGE_weight100,ri.SEC_RANGE_weight100),
                        SALT37.Fn_Fail_Scale(le.SEC_RANGE_weight100,s.SEC_RANGE_switch))*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  SELF.left_MNAME := le.MNAME;
  SELF.right_MNAME := ri.MNAME;
  SELF.MNAME_match_code := MAP(
                        le.MNAME_isnull OR ri.MNAME_isnull => SALT37.MatchCode.OneSideNull,
                        MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => SALT37.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_MNAME(le.MNAME,ri.MNAME, le.MNAME_len, ri.MNAME_len));
/*HACK-O-MATIC*/ INTEGER2 MNAME_score_noancestor := MAP(
                        le.MNAME_isnull OR ri.MNAME_isnull => 0,
                        le.MNAME = ri.MNAME  => le.MNAME_weight100,
                        LENGTH(TRIM(le.MNAME))>0 and le.MNAME = ri.MNAME[1..LENGTH(TRIM(le.MNAME))] => le.MNAME_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.MNAME))>0 and ri.MNAME = le.MNAME[1..LENGTH(TRIM(ri.MNAME))] => ri.MNAME_weight100, // An initial match - take initial specificity
                        Config.WithinEditN(le.MNAME,le.MNAME_len,ri.MNAME,ri.MNAME_len,1,0) => SALT37.fn_fuzzy_specificity(le.MNAME_weight100,le.MNAME_cnt, le.MNAME_e1_cnt,ri.MNAME_weight100,ri.MNAME_cnt,ri.MNAME_e1_cnt),
												Config.WithinEditN(le.MNAME,le.MNAME_len,ri.MNAME,ri.MNAME_len,2,6) => SALT37.fn_fuzzy_specificity(le.MNAME_weight100,le.MNAME_cnt, le.MNAME_e2_cnt,ri.MNAME_weight100,ri.MNAME_cnt,ri.MNAME_e2_cnt),
                        SALT37.Fn_Fail_Scale(le.MNAME_weight100,s.MNAME_switch))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
/*------------------added cfouts----------------------*/
	SELF.MNAME_score := MAP(le.MNAME_isnull OR ri.MNAME_isnull => 0,
					MAINNAME_score_pre > 0 OR FULLNAME_score_pre > 0 => 0,
					MNAME_score_noancestor);
	/*------------------added cfouts----------------------*/
	SELF.left_ST := le.ST;
  SELF.right_ST := ri.ST;
  SELF.ST_match_code := MAP(
                        le.ST_isnull OR ri.ST_isnull => SALT37.MatchCode.OneSideNull,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => SALT37.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_ST(le.ST,ri.ST));
  SELF.ST_score := MAP(
                        le.ST_isnull OR ri.ST_isnull => 0,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.ST = ri.ST  => le.ST_weight100,
                        SALT37.Fn_Fail_Scale(le.ST_weight100,s.ST_switch))*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  SELF.left_SNAME := le.SNAME;
  SELF.right_SNAME := ri.SNAME;
  SELF.SNAME_match_code := MAP(
                        le.SNAME_isnull OR ri.SNAME_isnull => SALT37.MatchCode.OneSideNull,
                        FULLNAME_score_pre > 0 => SALT37.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_SNAME(le.SNAME,ri.SNAME));
	/*------------------added cfouts----------------------*/
INTEGER2 sname_score_noancestor := MAP( le.SNAME_isnull OR ri.SNAME_isnull => 0,
		le.SNAME = ri.SNAME  => le.SNAME_weight100,
		ssn_score_v1 > Config.SSN_Score_Min_SNAME and dob_score_v1 > Config.DOB_Score_Min_SNAME => Config.Threshold_Score_SNAME,
		-9999)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale);
SELF.SNAME_score := MAP(le.SNAME_isnull OR ri.SNAME_isnull => 0,
		FULLNAME_score_pre > 0 => 0,
		sname_score_noancestor);
/*------------------added cfouts----------------------*/
  SELF.left_GENDER := le.GENDER;
  SELF.right_GENDER := ri.GENDER;
  SELF.GENDER_match_code := MAP(
                        le.GENDER_isnull OR ri.GENDER_isnull => SALT37.MatchCode.OneSideNull,
                        match_methods(ih).match_GENDER(le.GENDER,ri.GENDER));
  SELF.GENDER_score := MAP(
                        le.GENDER_isnull OR ri.GENDER_isnull => 0,
                        le.GENDER = ri.GENDER  => le.GENDER_weight100,
                        SALT37.Fn_Fail_Scale(le.GENDER_weight100,s.GENDER_switch));
  SELF.left_DERIVED_GENDER := le.DERIVED_GENDER;
  SELF.right_DERIVED_GENDER := ri.DERIVED_GENDER;
  SELF.DERIVED_GENDER_match_code := MAP(
                        le.DERIVED_GENDER_isnull OR ri.DERIVED_GENDER_isnull => SALT37.MatchCode.OneSideNull,
                        match_methods(ih).match_DERIVED_GENDER(le.DERIVED_GENDER,ri.DERIVED_GENDER));
  SELF.DERIVED_GENDER_score := MAP(
                        le.DERIVED_GENDER_isnull OR ri.DERIVED_GENDER_isnull => 0,
                        le.DERIVED_GENDER = ri.DERIVED_GENDER  => le.DERIVED_GENDER_weight100,
/*HACK-O-MATIC*/ Config.Mismatch_Score_DERIVED_GENDER);
  SELF.left_VENDOR_ID := le.VENDOR_ID;
  SELF.right_VENDOR_ID := ri.VENDOR_ID;
  SELF.left_BOCA_DID := le.BOCA_DID;
  SELF.right_BOCA_DID := ri.BOCA_DID;
  SELF.left_SRC := le.SRC;
  SELF.right_SRC := ri.SRC;
  SELF.left_DT_FIRST_SEEN := le.DT_FIRST_SEEN;
  SELF.right_DT_FIRST_SEEN := ri.DT_FIRST_SEEN;
  SELF.left_DT_LAST_SEEN := le.DT_LAST_SEEN;
  SELF.right_DT_LAST_SEEN := ri.DT_LAST_SEEN;
  SELF.left_DL_STATE := le.DL_STATE;
  SELF.right_DL_STATE := ri.DL_STATE;
  SELF.left_AMBEST := le.AMBEST;
  SELF.right_AMBEST := ri.AMBEST;
  SELF.left_ZIP := le.ZIP;
  SELF.right_ZIP := ri.ZIP;
  SELF.ZIP_match_code := MAP(
                        le.ZIP_isnull OR ri.ZIP_isnull => SALT37.MatchCode.OneSideNull,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => SALT37.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_ZIP(le.ZIP,ri.ZIP));
  SELF.ZIP_score := MAP(
                        le.ZIP_isnull OR ri.ZIP_isnull => 0,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.ZIP = ri.ZIP  => le.ZIP_weight100,
                        SALT37.Fn_Fail_Scale(le.ZIP_weight100,s.ZIP_switch))*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  SELF.FNAME_score := IF ( FNAME_score_temp >= Config.FNAME_Force * 100, FNAME_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.FNAME_skipped := SELF.FNAME_score < -5000;// Enforce FORCE parameter
// Compute the score for the concept MAINNAME
  INTEGER2 MAINNAME_score_ext := SALT37.ClipScore(MAX(MAINNAME_score_pre,0) + self.FNAME_score + self.MNAME_score + self.LNAME_score + MAX(FULLNAME_score_pre,0));// Score in surrounding context
  INTEGER2 MAINNAME_score_res := MAX(0,MAINNAME_score_pre); // At least nothing
  SELF.MAINNAME_score := MAINNAME_score_res;
// Compute the score for the concept ADDR1
  INTEGER2 ADDR1_score_ext := SALT37.ClipScore(MAX(ADDR1_score_pre,0) + self.PRIM_RANGE_score + self.SEC_RANGE_score + self.PRIM_NAME_score + MAX(ADDRESS_score_pre,0));// Score in surrounding context
  INTEGER2 ADDR1_score_res := MAX(0,ADDR1_score_pre); // At least nothing
  SELF.ADDR1_score := ADDR1_score_res;
// Compute the score for the concept LOCALE
  INTEGER2 LOCALE_score_ext := SALT37.ClipScore(MAX(LOCALE_score_pre,0) + self.CITY_score + self.ST_score + self.ZIP_score + MAX(ADDRESS_score_pre,0));// Score in surrounding context
  INTEGER2 LOCALE_score_res := MAX(0,LOCALE_score_pre); // At least nothing
  SELF.LOCALE_score := LOCALE_score_res;
// Compute the score for the concept ADDRESS
  INTEGER2 ADDRESS_score_ext := SALT37.ClipScore(MAX(ADDRESS_score_pre,0)+ SELF.ADDR1_score + self.PRIM_RANGE_score + self.SEC_RANGE_score + self.PRIM_NAME_score+ SELF.LOCALE_score + self.CITY_score + self.ST_score + self.ZIP_score);// Score in surrounding context
  INTEGER2 ADDRESS_score_res := MAX(0,ADDRESS_score_pre); // At least nothing
  SELF.ADDRESS_score := ADDRESS_score_res;
// Compute the score for the concept FULLNAME
  INTEGER2 FULLNAME_score_ext := SALT37.ClipScore(MAX(FULLNAME_score_pre,0)+ SELF.MAINNAME_score + self.FNAME_score + self.MNAME_score + self.LNAME_score + self.SNAME_score);// Score in surrounding context
  INTEGER2 FULLNAME_score_res := MAX(0,FULLNAME_score_pre); // At least nothing
/*HACK-O-MATIC*/ SELF.FULLNAME_score := IF ( FULLNAME_score_ext > -300
/*HACK-O-MATIC*/ OR (SELF.SSN_score > Config.SSN_Score_Min_FULLNAME AND SELF.DOB_score > Config.DOB_Score_Min_FULLNAME AND SELF.FNAME_score > 0)
/*HACK-O-MATIC*/ OR (SELF.ADDRESS_score > Config.Addr_Score_Min_FULLNAME AND SELF.DOB_score > Config.DOB_Score_Min_FULLNAME AND SELF.FNAME_score > 0),
/*HACK-O-MATIC*/ FULLNAME_score_res,-9999);
  SELF.FULLNAME_skipped := SELF.FULLNAME_score < -5000;// Enforce FORCE parameter
/*HACK-O-MATIC*/ SELF.Conf :=(SELF.ADDRESS_score + SELF.SSN_score + SELF.POLICY_NUMBER_score + SELF.CLAIM_NUMBER_score + SELF.DL_NBR_score + SELF.FULLNAME_score + SELF.MAINNAME_score + SELF.ADDR1_score + SELF.DOB_score + SELF.ZIP_score + SELF.LOCALE_score + SELF.PRIM_NAME_score + SELF.LNAME_score + SELF.PRIM_RANGE_score + SELF.CITY_score + SELF.FNAME_score + SELF.SEC_RANGE_score + SELF.MNAME_score + SELF.ST_score + SELF.SNAME_score + SELF.GENDER_score + SELF.DERIVED_GENDER_score) / 100 + outside;
	SELF:=[]
END;
 
EXPORT AnnotateMatchesFromData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION
  j1 := JOIN(in_data,im,LEFT.DID = RIGHT.DID1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  r := JOIN(j1,in_data,LEFT.DID2 = RIGHT.DID,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
  d := DEDUP( r(RID1 <> RID2), ALL, WHOLE RECORD ); // keep all matches and allow downstream processes to filter
  RETURN d;
END;
 
EXPORT AnnotateMatchesFromRecordData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION//Faster form when RID known
  j1 := JOIN(in_data,im,LEFT.RID = RIGHT.RID1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(j1,in_data,LEFT.RID2 = RIGHT.RID,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
END;
 
EXPORT AnnotateClusterMatches(DATASET(match_candidates(ih).layout_candidates) in_data,SALT37.UIDType BaseRecord) := FUNCTION//Faster form when RID known
  j1 := in_data(RID = BaseRecord);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(in_data(RID<>BaseRecord),j1,TRUE,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),ALL);
END;
 
EXPORT AnnotateMatches(DATASET(match_candidates(ih).layout_matches) im) := FUNCTION
  am := AnnotateMatchesFromRecordData(h,im);
  am restoreRule(am le,im ri) := TRANSFORM
    SELF.rule := ri.rule;
    SELF := le;
  END;
  annotated_matches := JOIN(am,im,LEFT.RID1=RIGHT.RID1 AND LEFT.RID2=RIGHT.RID2,restoreRule(LEFT,RIGHT),HASH);
  RETURN annotated_matches;
END;
EXPORT Layout_RolledEntity := RECORD,MAXLENGTH(63000)
  SALT37.UIDType DID;
  DATASET(SALT37.Layout_FieldValueList) ADDRESS_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) SSN_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) POLICY_NUMBER_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) CLAIM_NUMBER_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) DL_NBR_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) FULLNAME_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) DOB_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) GENDER_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) DERIVED_GENDER_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) VENDOR_ID_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) BOCA_DID_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) SRC_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) DT_FIRST_SEEN_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) DT_LAST_SEEN_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) DL_STATE_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) AMBEST_Values := DATASET([],SALT37.Layout_FieldValueList);
END;
 
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
  Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.DID := le.DID;
    SELF.ADDRESS_values := SALT37.fn_combine_fieldvaluelist(le.ADDRESS_values,ri.ADDRESS_values);
    SELF.SSN_values := SALT37.fn_combine_fieldvaluelist(le.SSN_values,ri.SSN_values);
    SELF.POLICY_NUMBER_values := SALT37.fn_combine_fieldvaluelist(le.POLICY_NUMBER_values,ri.POLICY_NUMBER_values);
    SELF.CLAIM_NUMBER_values := SALT37.fn_combine_fieldvaluelist(le.CLAIM_NUMBER_values,ri.CLAIM_NUMBER_values);
    SELF.DL_NBR_values := SALT37.fn_combine_fieldvaluelist(le.DL_NBR_values,ri.DL_NBR_values);
    SELF.FULLNAME_values := SALT37.fn_combine_fieldvaluelist(le.FULLNAME_values,ri.FULLNAME_values);
    SELF.DOB_values := SALT37.fn_combine_fieldvaluelist(le.DOB_values,ri.DOB_values);
    SELF.GENDER_values := SALT37.fn_combine_fieldvaluelist(le.GENDER_values,ri.GENDER_values);
    SELF.DERIVED_GENDER_values := SALT37.fn_combine_fieldvaluelist(le.DERIVED_GENDER_values,ri.DERIVED_GENDER_values);
    SELF.VENDOR_ID_values := SALT37.fn_combine_fieldvaluelist(le.VENDOR_ID_values,ri.VENDOR_ID_values);
    SELF.BOCA_DID_values := SALT37.fn_combine_fieldvaluelist(le.BOCA_DID_values,ri.BOCA_DID_values);
    SELF.SRC_values := SALT37.fn_combine_fieldvaluelist(le.SRC_values,ri.SRC_values);
    SELF.DT_FIRST_SEEN_values := SALT37.fn_combine_fieldvaluelist(le.DT_FIRST_SEEN_values,ri.DT_FIRST_SEEN_values);
    SELF.DT_LAST_SEEN_values := SALT37.fn_combine_fieldvaluelist(le.DT_LAST_SEEN_values,ri.DT_LAST_SEEN_values);
    SELF.DL_STATE_values := SALT37.fn_combine_fieldvaluelist(le.DL_STATE_values,ri.DL_STATE_values);
    SELF.AMBEST_values := SALT37.fn_combine_fieldvaluelist(le.AMBEST_values,ri.AMBEST_values);
  END;
  ds_roll := ROLLUP( SORT( DISTRIBUTE( infile, HASH(DID) ), DID, LOCAL ), LEFT.DID = RIGHT.DID, RollValues(LEFT,RIGHT),LOCAL);
  Layout_RolledEntity SortValues(Layout_RolledEntity le) := TRANSFORM
    SELF.DID := le.DID;
    SELF.ADDRESS_values := SORT(le.ADDRESS_values, -cnt, val, LOCAL);
    SELF.SSN_values := SORT(le.SSN_values, -cnt, val, LOCAL);
    SELF.POLICY_NUMBER_values := SORT(le.POLICY_NUMBER_values, -cnt, val, LOCAL);
    SELF.CLAIM_NUMBER_values := SORT(le.CLAIM_NUMBER_values, -cnt, val, LOCAL);
    SELF.DL_NBR_values := SORT(le.DL_NBR_values, -cnt, val, LOCAL);
    SELF.FULLNAME_values := SORT(le.FULLNAME_values, -cnt, val, LOCAL);
    SELF.DOB_values := SORT(le.DOB_values, -cnt, val, LOCAL);
    SELF.GENDER_values := SORT(le.GENDER_values, -cnt, val, LOCAL);
    SELF.DERIVED_GENDER_values := SORT(le.DERIVED_GENDER_values, -cnt, val, LOCAL);
    SELF.VENDOR_ID_values := SORT(le.VENDOR_ID_values, -cnt, val, LOCAL);
    SELF.BOCA_DID_values := SORT(le.BOCA_DID_values, -cnt, val, LOCAL);
    SELF.SRC_values := SORT(le.SRC_values, -cnt, val, LOCAL);
    SELF.DT_FIRST_SEEN_values := SORT(le.DT_FIRST_SEEN_values, -cnt, val, LOCAL);
    SELF.DT_LAST_SEEN_values := SORT(le.DT_LAST_SEEN_values, -cnt, val, LOCAL);
    SELF.DL_STATE_values := SORT(le.DL_STATE_values, -cnt, val, LOCAL);
    SELF.AMBEST_values := SORT(le.AMBEST_values, -cnt, val, LOCAL);
  END;
  ds_sort := PROJECT(ds_roll, SortValues(LEFT));
  RETURN ds_sort;
END;
 
EXPORT RolledEntities(DATASET(match_candidates(ih).layout_candidates) in_data) := FUNCTION
 
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.DID := le.DID;
  SELF.ADDRESS_Values := IF ( (le.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'') AND (le.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'') AND (le.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'') AND (le.CITY  IN SET(s.nulls_CITY,CITY) OR le.CITY = (TYPEOF(le.CITY))'') AND (le.ST  IN SET(s.nulls_ST,ST) OR le.ST = (TYPEOF(le.ST))'') AND (le.ZIP  IN SET(s.nulls_ZIP,ZIP) OR le.ZIP = (TYPEOF(le.ZIP))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.PRIM_RANGE) + ' ' + TRIM((SALT37.StrType)le.SEC_RANGE) + ' ' + TRIM((SALT37.StrType)le.PRIM_NAME) + ' ' + TRIM((SALT37.StrType)le.CITY) + ' ' + TRIM((SALT37.StrType)le.ST) + ' ' + TRIM((SALT37.StrType)le.ZIP)}],SALT37.Layout_FieldValueList));
  SELF.SSN_Values := IF ( (le.SSN  IN SET(s.nulls_SSN,SSN) OR le.SSN = (TYPEOF(le.SSN))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.SSN)}],SALT37.Layout_FieldValueList));
  SELF.POLICY_NUMBER_Values := IF ( (le.POLICY_NUMBER  IN SET(s.nulls_POLICY_NUMBER,POLICY_NUMBER) OR le.POLICY_NUMBER = (TYPEOF(le.POLICY_NUMBER))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.POLICY_NUMBER)}],SALT37.Layout_FieldValueList));
  SELF.CLAIM_NUMBER_Values := IF ( (le.CLAIM_NUMBER  IN SET(s.nulls_CLAIM_NUMBER,CLAIM_NUMBER) OR le.CLAIM_NUMBER = (TYPEOF(le.CLAIM_NUMBER))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.CLAIM_NUMBER)}],SALT37.Layout_FieldValueList));
  SELF.DL_NBR_Values := IF ( (le.DL_NBR  IN SET(s.nulls_DL_NBR,DL_NBR) OR le.DL_NBR = (TYPEOF(le.DL_NBR))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.DL_NBR)}],SALT37.Layout_FieldValueList));
  SELF.FULLNAME_Values := IF ( (le.FNAME  IN SET(s.nulls_FNAME,FNAME) OR le.FNAME = (TYPEOF(le.FNAME))'') AND (le.MNAME  IN SET(s.nulls_MNAME,MNAME) OR le.MNAME = (TYPEOF(le.MNAME))'') AND (le.LNAME  IN SET(s.nulls_LNAME,LNAME) OR le.LNAME = (TYPEOF(le.LNAME))'') AND (le.SNAME  IN SET(s.nulls_SNAME,SNAME) OR le.SNAME = (TYPEOF(le.SNAME))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.FNAME) + ' ' + TRIM((SALT37.StrType)le.MNAME) + ' ' + TRIM((SALT37.StrType)le.LNAME) + ' ' + TRIM((SALT37.StrType)le.SNAME)}],SALT37.Layout_FieldValueList));
  self.DOB_Values := IF ( le.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND le.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND le.DOB_day  IN SET(s.nulls_DOB_day,DOB_day),dataset([],SALT37.Layout_FieldValueList),dataset([{TRIM((STRING)le.DOB_month)+'/'+TRIM((STRING)le.DOB_day)+'/'+TRIM((STRING)le.DOB_year)}],SALT37.Layout_FieldValueList));
  SELF.GENDER_Values := IF ( (le.GENDER  IN SET(s.nulls_GENDER,GENDER) OR le.GENDER = (TYPEOF(le.GENDER))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.GENDER)}],SALT37.Layout_FieldValueList));
  SELF.DERIVED_GENDER_Values := IF ( (le.DERIVED_GENDER  IN SET(s.nulls_DERIVED_GENDER,DERIVED_GENDER) OR le.DERIVED_GENDER = (TYPEOF(le.DERIVED_GENDER))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.DERIVED_GENDER)}],SALT37.Layout_FieldValueList));
  SELF.VENDOR_ID_Values := DATASET([{TRIM((SALT37.StrType)le.VENDOR_ID)}],SALT37.Layout_FieldValueList);
  SELF.BOCA_DID_Values := DATASET([{TRIM((SALT37.StrType)le.BOCA_DID)}],SALT37.Layout_FieldValueList);
  SELF.SRC_Values := DATASET([{TRIM((SALT37.StrType)le.SRC)}],SALT37.Layout_FieldValueList);
  SELF.DT_FIRST_SEEN_Values := DATASET([{TRIM((SALT37.StrType)le.DT_FIRST_SEEN)}],SALT37.Layout_FieldValueList);
  SELF.DT_LAST_SEEN_Values := DATASET([{TRIM((SALT37.StrType)le.DT_LAST_SEEN)}],SALT37.Layout_FieldValueList);
  SELF.DL_STATE_Values := DATASET([{TRIM((SALT37.StrType)le.DL_STATE)}],SALT37.Layout_FieldValueList);
  SELF.AMBEST_Values := DATASET([{TRIM((SALT37.StrType)le.AMBEST)}],SALT37.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
 
Layout_RolledEntity into(ih le) := TRANSFORM
  SELF.DID := le.DID;
  SELF.ADDRESS_Values := IF ( (le.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'') AND (le.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'') AND (le.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'') AND (le.CITY  IN SET(s.nulls_CITY,CITY) OR le.CITY = (TYPEOF(le.CITY))'') AND (le.ST  IN SET(s.nulls_ST,ST) OR le.ST = (TYPEOF(le.ST))'') AND (le.ZIP  IN SET(s.nulls_ZIP,ZIP) OR le.ZIP = (TYPEOF(le.ZIP))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.PRIM_RANGE) + ' ' + TRIM((SALT37.StrType)le.SEC_RANGE) + ' ' + TRIM((SALT37.StrType)le.PRIM_NAME) + ' ' + TRIM((SALT37.StrType)le.CITY) + ' ' + TRIM((SALT37.StrType)le.ST) + ' ' + TRIM((SALT37.StrType)le.ZIP)}],SALT37.Layout_FieldValueList));
  SELF.SSN_Values := IF ( (le.SSN  IN SET(s.nulls_SSN,SSN) OR le.SSN = (TYPEOF(le.SSN))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.SSN)}],SALT37.Layout_FieldValueList));
  SELF.POLICY_NUMBER_Values := IF ( (le.POLICY_NUMBER  IN SET(s.nulls_POLICY_NUMBER,POLICY_NUMBER) OR le.POLICY_NUMBER = (TYPEOF(le.POLICY_NUMBER))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.POLICY_NUMBER)}],SALT37.Layout_FieldValueList));
  SELF.CLAIM_NUMBER_Values := IF ( (le.CLAIM_NUMBER  IN SET(s.nulls_CLAIM_NUMBER,CLAIM_NUMBER) OR le.CLAIM_NUMBER = (TYPEOF(le.CLAIM_NUMBER))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.CLAIM_NUMBER)}],SALT37.Layout_FieldValueList));
  SELF.DL_NBR_Values := IF ( (le.DL_NBR  IN SET(s.nulls_DL_NBR,DL_NBR) OR le.DL_NBR = (TYPEOF(le.DL_NBR))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.DL_NBR)}],SALT37.Layout_FieldValueList));
  SELF.FULLNAME_Values := IF ( (le.FNAME  IN SET(s.nulls_FNAME,FNAME) OR le.FNAME = (TYPEOF(le.FNAME))'') AND (le.MNAME  IN SET(s.nulls_MNAME,MNAME) OR le.MNAME = (TYPEOF(le.MNAME))'') AND (le.LNAME  IN SET(s.nulls_LNAME,LNAME) OR le.LNAME = (TYPEOF(le.LNAME))'') AND (le.SNAME  IN SET(s.nulls_SNAME,SNAME) OR le.SNAME = (TYPEOF(le.SNAME))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.FNAME) + ' ' + TRIM((SALT37.StrType)le.MNAME) + ' ' + TRIM((SALT37.StrType)le.LNAME) + ' ' + TRIM((SALT37.StrType)le.SNAME)}],SALT37.Layout_FieldValueList));
  self.DOB_Values := IF ( (unsigned)le.DOB = 0,dataset([],SALT37.Layout_FieldValueList),dataset([{(SALT37.StrType)le.DOB}],SALT37.Layout_FieldValueList));
  SELF.GENDER_Values := IF ( (le.GENDER  IN SET(s.nulls_GENDER,GENDER) OR le.GENDER = (TYPEOF(le.GENDER))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.GENDER)}],SALT37.Layout_FieldValueList));
  SELF.DERIVED_GENDER_Values := IF ( (le.DERIVED_GENDER  IN SET(s.nulls_DERIVED_GENDER,DERIVED_GENDER) OR le.DERIVED_GENDER = (TYPEOF(le.DERIVED_GENDER))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.DERIVED_GENDER)}],SALT37.Layout_FieldValueList));
  SELF.VENDOR_ID_Values := DATASET([{TRIM((SALT37.StrType)le.VENDOR_ID)}],SALT37.Layout_FieldValueList);
  SELF.BOCA_DID_Values := DATASET([{TRIM((SALT37.StrType)le.BOCA_DID)}],SALT37.Layout_FieldValueList);
  SELF.SRC_Values := DATASET([{TRIM((SALT37.StrType)le.SRC)}],SALT37.Layout_FieldValueList);
  SELF.DT_FIRST_SEEN_Values := DATASET([{TRIM((SALT37.StrType)le.DT_FIRST_SEEN)}],SALT37.Layout_FieldValueList);
  SELF.DT_LAST_SEEN_Values := DATASET([{TRIM((SALT37.StrType)le.DT_LAST_SEEN)}],SALT37.Layout_FieldValueList);
  SELF.DL_STATE_Values := DATASET([{TRIM((SALT37.StrType)le.DL_STATE)}],SALT37.Layout_FieldValueList);
  SELF.AMBEST_Values := DATASET([{TRIM((SALT37.StrType)le.AMBEST)}],SALT37.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(ih,into(left));
EXPORT InFile_Rolled := RollEntities(AsFieldValues);
// Now to compute the chubbies; those clusters which are really rather larger than one would expect
// this is presently defined in terms of number of field values * the improbability of that occuring by chance
// this could be used as poor mans dodgy-dids; but it does not allow for value planing (co-occurrence)
AllRolled := InFile_Rolled;
Layout_Chubbies0 := RECORD,MAXLENGTH(63000)
  AllRolled;
  UNSIGNED1 ADDRESS_size := 0;
  UNSIGNED1 SSN_size := 0;
  UNSIGNED1 POLICY_NUMBER_size := 0;
  UNSIGNED1 CLAIM_NUMBER_size := 0;
  UNSIGNED1 DL_NBR_size := 0;
  UNSIGNED1 FULLNAME_size := 0;
  UNSIGNED1 DOB_size := 0;
  UNSIGNED1 GENDER_size := 0;
  UNSIGNED1 DERIVED_GENDER_size := 0;
END;
t0 := TABLE(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := TRANSFORM
  SELF.ADDRESS_size := SALT37.Fn_SwitchSpec(s.ADDRESS_switch,count(le.ADDRESS_values));
  SELF.SSN_size := SALT37.Fn_SwitchSpec(s.SSN_switch,count(le.SSN_values));
  SELF.POLICY_NUMBER_size := SALT37.Fn_SwitchSpec(s.POLICY_NUMBER_switch,count(le.POLICY_NUMBER_values));
  SELF.CLAIM_NUMBER_size := SALT37.Fn_SwitchSpec(s.CLAIM_NUMBER_switch,count(le.CLAIM_NUMBER_values));
  SELF.DL_NBR_size := SALT37.Fn_SwitchSpec(s.DL_NBR_switch,count(le.DL_NBR_values));
  SELF.FULLNAME_size := SALT37.Fn_SwitchSpec(s.FULLNAME_switch,count(le.FULLNAME_values));
  SELF.DOB_size := SALT37.Fn_SwitchSpec(MAX(s.DOB_day_switch,s.DOB_month_switch,s.DOB_year_switch),count(le.DOB_values));
  SELF.GENDER_size := SALT37.Fn_SwitchSpec(s.GENDER_switch,count(le.GENDER_values));
  SELF.DERIVED_GENDER_size := SALT37.Fn_SwitchSpec(s.DERIVED_GENDER_switch,count(le.DERIVED_GENDER_values));
  SELF := le;
END;  t := PROJECT(t0,NoteSize(LEFT));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  UNSIGNED2 Size := t.ADDRESS_size+t.SSN_size+t.POLICY_NUMBER_size+t.CLAIM_NUMBER_size+t.DL_NBR_size+t.FULLNAME_size+t.DOB_size+t.GENDER_size+t.DERIVED_GENDER_size;
END;
EXPORT Chubbies := TABLE(t,Layout_Chubbies);
END;
