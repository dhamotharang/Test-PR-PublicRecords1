// Various routines to assist in debugging
IMPORT SALT30,ut,std;
EXPORT Debug(DATASET(layout_HealthFacility) ih, Layout_Specificities.R s, MatchThreshold = Config.MatchThreshold) := MODULE
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
SHARED h := match_candidates(ih).candidates;
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
EXPORT Layout_Sample_Matches := RECORD(match_candidates(ih).Layout_Matches)
  typeof(h.ST) left_ST;
  INTEGER1 ST_match_code;
  INTEGER2 ST_score;
  BOOLEAN ST_skipped := FALSE; // True if FORCE blocks match
  typeof(h.ST) right_ST;
  typeof(h.NPI_NUMBER) left_NPI_NUMBER;
  INTEGER1 NPI_NUMBER_match_code;
  INTEGER2 NPI_NUMBER_score;
  BOOLEAN NPI_NUMBER_skipped := FALSE; // True if FORCE blocks match
  typeof(h.NPI_NUMBER) right_NPI_NUMBER;
  typeof(h.CLIA_NUMBER) left_CLIA_NUMBER;
  INTEGER1 CLIA_NUMBER_match_code;
  INTEGER2 CLIA_NUMBER_score;
  BOOLEAN CLIA_NUMBER_skipped := FALSE; // True if FORCE blocks match
  typeof(h.CLIA_NUMBER) right_CLIA_NUMBER;
  typeof(h.NCPDP_NUMBER) left_NCPDP_NUMBER;
  INTEGER1 NCPDP_NUMBER_match_code;
  INTEGER2 NCPDP_NUMBER_score;
  BOOLEAN NCPDP_NUMBER_skipped := FALSE; // True if FORCE blocks match
  typeof(h.NCPDP_NUMBER) right_NCPDP_NUMBER;
  typeof(h.MEDICAID_NUMBER) left_MEDICAID_NUMBER;
  INTEGER1 MEDICAID_NUMBER_match_code;
  INTEGER2 MEDICAID_NUMBER_score;
  typeof(h.MEDICAID_NUMBER) right_MEDICAID_NUMBER;
  typeof(h.DEA_NUMBER) left_DEA_NUMBER;
  INTEGER1 DEA_NUMBER_match_code;
  INTEGER2 DEA_NUMBER_score;
  BOOLEAN DEA_NUMBER_skipped := FALSE; // True if FORCE blocks match
  typeof(h.DEA_NUMBER) right_DEA_NUMBER;
  typeof(h.MEDICARE_FACILITY_NUMBER) left_MEDICARE_FACILITY_NUMBER;
  INTEGER1 MEDICARE_FACILITY_NUMBER_match_code;
  INTEGER2 MEDICARE_FACILITY_NUMBER_score;
  typeof(h.MEDICARE_FACILITY_NUMBER) right_MEDICARE_FACILITY_NUMBER;
  typeof(h.TAX_ID) left_TAX_ID;
  INTEGER1 TAX_ID_match_code;
  INTEGER2 TAX_ID_score;
  typeof(h.TAX_ID) right_TAX_ID;
  typeof(h.VENDOR_ID) left_VENDOR_ID;
  INTEGER1 VENDOR_ID_match_code;
  INTEGER2 VENDOR_ID_score;
  typeof(h.VENDOR_ID) right_VENDOR_ID;
  typeof(h.CNP_STORE_NUMBER) left_CNP_STORE_NUMBER;
  INTEGER1 CNP_STORE_NUMBER_match_code;
  INTEGER2 CNP_STORE_NUMBER_score;
  BOOLEAN CNP_STORE_NUMBER_skipped := FALSE; // True if FORCE blocks match
  typeof(h.CNP_STORE_NUMBER) right_CNP_STORE_NUMBER;
  typeof(h.PHONE) left_PHONE;
  INTEGER1 PHONE_match_code;
  INTEGER2 PHONE_score;
  typeof(h.PHONE) right_PHONE;
  typeof(h.FAX) left_FAX;
  INTEGER1 FAX_match_code;
  INTEGER2 FAX_score;
  typeof(h.FAX) right_FAX;
  typeof(h.FAC_NAME) left_FAC_NAME;
  INTEGER1 FAC_NAME_match_code;
  INTEGER2 FAC_NAME_score;
  typeof(h.FAC_NAME) right_FAC_NAME;
  typeof(h.ADDR1) left_ADDR1;
  INTEGER1 ADDR1_match_code;
  INTEGER2 ADDR1_score;
  typeof(h.ADDR1) right_ADDR1;
  typeof(h.ADDRESS) left_ADDRESS;
  INTEGER1 ADDRESS_match_code;
  INTEGER2 ADDRESS_score;
  BOOLEAN ADDRESS_skipped := FALSE; // True if FORCE blocks match
  typeof(h.ADDRESS) right_ADDRESS;
  typeof(h.C_LIC_NBR) left_C_LIC_NBR;
  INTEGER1 C_LIC_NBR_match_code;
  INTEGER2 C_LIC_NBR_score;
  typeof(h.C_LIC_NBR) right_C_LIC_NBR;
  typeof(h.FEIN) left_FEIN;
  INTEGER1 FEIN_match_code;
  INTEGER2 FEIN_score;
  BOOLEAN FEIN_skipped := FALSE; // True if FORCE blocks match
  typeof(h.FEIN) right_FEIN;
  typeof(h.CNP_NAME) left_CNP_NAME;
  INTEGER1 CNP_NAME_match_code;
  INTEGER2 CNP_NAME_score;
  BOOLEAN CNP_NAME_skipped := FALSE; // True if FORCE blocks match
  typeof(h.CNP_NAME) right_CNP_NAME;
  typeof(h.CNP_NUMBER) left_CNP_NUMBER;
  INTEGER1 CNP_NUMBER_match_code;
  INTEGER2 CNP_NUMBER_score;
  BOOLEAN CNP_NUMBER_skipped := FALSE; // True if FORCE blocks match
  typeof(h.CNP_NUMBER) right_CNP_NUMBER;
  typeof(h.PRIM_NAME) left_PRIM_NAME;
  INTEGER1 PRIM_NAME_match_code;
  INTEGER2 PRIM_NAME_score;
  BOOLEAN PRIM_NAME_skipped := FALSE; // True if FORCE blocks match
  typeof(h.PRIM_NAME) right_PRIM_NAME;
  typeof(h.ZIP) left_ZIP;
  INTEGER1 ZIP_match_code;
  INTEGER2 ZIP_score;
  typeof(h.ZIP) right_ZIP;
  typeof(h.LOCALE) left_LOCALE;
  INTEGER1 LOCALE_match_code;
  INTEGER2 LOCALE_score;
  BOOLEAN LOCALE_skipped := FALSE; // True if FORCE blocks match
  typeof(h.LOCALE) right_LOCALE;
  typeof(h.PRIM_RANGE) left_PRIM_RANGE;
  INTEGER1 PRIM_RANGE_match_code;
  INTEGER2 PRIM_RANGE_score;
  BOOLEAN PRIM_RANGE_skipped := FALSE; // True if FORCE blocks match
  typeof(h.PRIM_RANGE) right_PRIM_RANGE;
  typeof(h.V_CITY_NAME) left_V_CITY_NAME;
  INTEGER1 V_CITY_NAME_match_code;
  INTEGER2 V_CITY_NAME_score;
  typeof(h.V_CITY_NAME) right_V_CITY_NAME;
  typeof(h.SEC_RANGE) left_SEC_RANGE;
  INTEGER1 SEC_RANGE_match_code;
  INTEGER2 SEC_RANGE_score;
  BOOLEAN SEC_RANGE_skipped := FALSE; // True if FORCE blocks match
  typeof(h.SEC_RANGE) right_SEC_RANGE;
  typeof(h.TAXONOMY) left_TAXONOMY;
  INTEGER1 TAXONOMY_match_code;
  INTEGER2 TAXONOMY_score;
  typeof(h.TAXONOMY) right_TAXONOMY;
  typeof(h.CNP_BTYPE) left_CNP_BTYPE;
  INTEGER1 CNP_BTYPE_match_code;
  INTEGER2 CNP_BTYPE_score;
  BOOLEAN CNP_BTYPE_skipped := FALSE; // True if FORCE blocks match
  typeof(h.CNP_BTYPE) right_CNP_BTYPE;
  typeof(h.TAXONOMY_CODE) left_TAXONOMY_CODE;
  INTEGER1 TAXONOMY_CODE_match_code;
  INTEGER2 TAXONOMY_CODE_score;
  BOOLEAN TAXONOMY_CODE_skipped := FALSE; // True if FORCE blocks match
  typeof(h.TAXONOMY_CODE) right_TAXONOMY_CODE;
  typeof(h.SRC) left_SRC;
  typeof(h.SRC) right_SRC;
  typeof(h.CNAME) left_CNAME;
  typeof(h.CNAME) right_CNAME;
  typeof(h.CNP_LOWV) left_CNP_LOWV;
  typeof(h.CNP_LOWV) right_CNP_LOWV;
  typeof(h.CNP_TRANSLATED) left_CNP_TRANSLATED;
  typeof(h.CNP_TRANSLATED) right_CNP_TRANSLATED;
  typeof(h.CNP_CLASSID) left_CNP_CLASSID;
  typeof(h.CNP_CLASSID) right_CNP_CLASSID;
  typeof(h.ADDRESS_ID) left_ADDRESS_ID;
  typeof(h.ADDRESS_ID) right_ADDRESS_ID;
  typeof(h.ADDRESS_CLASSIFICATION) left_ADDRESS_CLASSIFICATION;
  typeof(h.ADDRESS_CLASSIFICATION) right_ADDRESS_CLASSIFICATION;
  typeof(h.UPIN) left_UPIN;
  typeof(h.UPIN) right_UPIN;
  typeof(h.LIC_STATE) left_LIC_STATE;
  typeof(h.LIC_STATE) right_LIC_STATE;
END;
EXPORT layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.LNPID1 := le.LNPID;
  SELF.LNPID2 := ri.LNPID;
  SELF.RID1 := le.RID;
  SELF.RID2 := ri.RID;
  SELF.left_NPI_NUMBER := le.NPI_NUMBER;
  SELF.right_NPI_NUMBER := ri.NPI_NUMBER;
  SELF.NPI_NUMBER_match_code := MAP(
		le.NPI_NUMBER_isnull OR ri.NPI_NUMBER_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_NPI_NUMBER(le.NPI_NUMBER,ri.NPI_NUMBER));
  INTEGER2 NPI_NUMBER_score_temp := MAP(
                        le.NPI_NUMBER_isnull OR ri.NPI_NUMBER_isnull => 0,
                        le.NPI_NUMBER = ri.NPI_NUMBER  => le.NPI_NUMBER_weight100,
                        SALT30.Fn_Fail_Scale(le.NPI_NUMBER_weight100,s.NPI_NUMBER_switch));
  SELF.left_CLIA_NUMBER := le.CLIA_NUMBER;
  SELF.right_CLIA_NUMBER := ri.CLIA_NUMBER;
  SELF.CLIA_NUMBER_match_code := MAP(
		le.CLIA_NUMBER_isnull OR ri.CLIA_NUMBER_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_CLIA_NUMBER(le.CLIA_NUMBER,ri.CLIA_NUMBER));
  INTEGER2 CLIA_NUMBER_score_temp := MAP(
                        le.CLIA_NUMBER_isnull OR ri.CLIA_NUMBER_isnull => 0,
                        le.CLIA_NUMBER = ri.CLIA_NUMBER  => le.CLIA_NUMBER_weight100,
                        SALT30.Fn_Fail_Scale(le.CLIA_NUMBER_weight100,s.CLIA_NUMBER_switch));
  SELF.left_NCPDP_NUMBER := le.NCPDP_NUMBER;
  SELF.right_NCPDP_NUMBER := ri.NCPDP_NUMBER;
  SELF.NCPDP_NUMBER_match_code := MAP(
		le.NCPDP_NUMBER_isnull OR ri.NCPDP_NUMBER_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_NCPDP_NUMBER(le.NCPDP_NUMBER,ri.NCPDP_NUMBER));
  INTEGER2 NCPDP_NUMBER_score_temp := MAP(
                        le.NCPDP_NUMBER_isnull OR ri.NCPDP_NUMBER_isnull => 0,
                        le.NCPDP_NUMBER = ri.NCPDP_NUMBER  => le.NCPDP_NUMBER_weight100,
                        SALT30.Fn_Fail_Scale(le.NCPDP_NUMBER_weight100,s.NCPDP_NUMBER_switch));
  SELF.left_MEDICAID_NUMBER := le.MEDICAID_NUMBER;
  SELF.right_MEDICAID_NUMBER := ri.MEDICAID_NUMBER;
  SELF.MEDICAID_NUMBER_match_code := MAP(
		le.MEDICAID_NUMBER_isnull OR ri.MEDICAID_NUMBER_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_MEDICAID_NUMBER(le.MEDICAID_NUMBER,ri.MEDICAID_NUMBER));
  SELF.MEDICAID_NUMBER_score := MAP(
                        le.MEDICAID_NUMBER_isnull OR ri.MEDICAID_NUMBER_isnull => 0,
                        le.MEDICAID_NUMBER = ri.MEDICAID_NUMBER  => le.MEDICAID_NUMBER_weight100,
                        SALT30.Fn_Fail_Scale(le.MEDICAID_NUMBER_weight100,s.MEDICAID_NUMBER_switch));
  SELF.left_DEA_NUMBER := le.DEA_NUMBER;
  SELF.right_DEA_NUMBER := ri.DEA_NUMBER;
  SELF.DEA_NUMBER_match_code := MAP(
		le.DEA_NUMBER_isnull OR ri.DEA_NUMBER_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_DEA_NUMBER(le.DEA_NUMBER,ri.DEA_NUMBER));
  INTEGER2 DEA_NUMBER_score_temp := MAP(
                        le.DEA_NUMBER_isnull OR ri.DEA_NUMBER_isnull => 0,
                        le.DEA_NUMBER = ri.DEA_NUMBER  => le.DEA_NUMBER_weight100,
                        SALT30.Fn_Fail_Scale(le.DEA_NUMBER_weight100,s.DEA_NUMBER_switch));
  SELF.left_MEDICARE_FACILITY_NUMBER := le.MEDICARE_FACILITY_NUMBER;
  SELF.right_MEDICARE_FACILITY_NUMBER := ri.MEDICARE_FACILITY_NUMBER;
  SELF.MEDICARE_FACILITY_NUMBER_match_code := MAP(
		le.MEDICARE_FACILITY_NUMBER_isnull OR ri.MEDICARE_FACILITY_NUMBER_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_MEDICARE_FACILITY_NUMBER(le.MEDICARE_FACILITY_NUMBER,ri.MEDICARE_FACILITY_NUMBER));
  SELF.MEDICARE_FACILITY_NUMBER_score := MAP(
                        le.MEDICARE_FACILITY_NUMBER_isnull OR ri.MEDICARE_FACILITY_NUMBER_isnull => 0,
                        le.MEDICARE_FACILITY_NUMBER = ri.MEDICARE_FACILITY_NUMBER  => le.MEDICARE_FACILITY_NUMBER_weight100,
                        SALT30.Fn_Fail_Scale(le.MEDICARE_FACILITY_NUMBER_weight100,s.MEDICARE_FACILITY_NUMBER_switch));
  SELF.left_TAX_ID := le.TAX_ID;
  SELF.right_TAX_ID := ri.TAX_ID;
  SELF.TAX_ID_match_code := MAP(
		le.TAX_ID_isnull OR ri.TAX_ID_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_TAX_ID(le.TAX_ID,ri.TAX_ID));
  INTEGER2 TAX_ID_score_temp := MAP(
                        le.TAX_ID_isnull OR ri.TAX_ID_isnull => 0,
                        le.TAX_ID = ri.TAX_ID  => le.TAX_ID_weight100,
                        SALT30.Fn_Fail_Scale(le.TAX_ID_weight100,s.TAX_ID_switch));
  SELF.left_VENDOR_ID := le.VENDOR_ID;
  SELF.right_VENDOR_ID := ri.VENDOR_ID;
  SELF.VENDOR_ID_match_code := MAP(
		le.VENDOR_ID_isnull OR ri.VENDOR_ID_isnull => SALT30.MatchCode.OneSideNull,
		le.SRC <> ri.SRC => SALT30.MatchCode.ContextInvolved, // Only valid if the context variable is equal
		match_methods(ih).match_VENDOR_ID(le.VENDOR_ID,ri.VENDOR_ID));
  INTEGER2 VENDOR_ID_score_temp := MAP(
                        le.VENDOR_ID_isnull OR ri.VENDOR_ID_isnull => 0,
                        le.SRC <> ri.SRC => 0, // Only valid if the context variable is equal
                        le.VENDOR_ID = ri.VENDOR_ID  => le.VENDOR_ID_weight100,
                        0 /* switch0 */);
  SELF.left_PHONE := le.PHONE;
  SELF.right_PHONE := ri.PHONE;
  SELF.PHONE_match_code := MAP(
		le.PHONE_isnull OR ri.PHONE_isnull => SALT30.MatchCode.OneSideNull,
		le.CNP_NAME <> ri.CNP_NAME => SALT30.MatchCode.ContextInvolved, // Only valid if the context variable is equal
		match_methods(ih).match_PHONE(le.PHONE,ri.PHONE));
  SELF.PHONE_score := MAP(
                        le.PHONE_isnull OR ri.PHONE_isnull => 0,
                        le.CNP_NAME <> ri.CNP_NAME => 0, // Only valid if the context variable is equal
                        le.PHONE = ri.PHONE  => le.PHONE_weight100,
                        0 /* switch0 */);
  SELF.left_FAX := le.FAX;
  SELF.right_FAX := ri.FAX;
  SELF.FAX_match_code := MAP(
		le.FAX_isnull OR ri.FAX_isnull => SALT30.MatchCode.OneSideNull,
		le.CNP_NAME <> ri.CNP_NAME => SALT30.MatchCode.ContextInvolved, // Only valid if the context variable is equal
		match_methods(ih).match_FAX(le.FAX,ri.FAX));
  SELF.FAX_score := MAP(
                        le.FAX_isnull OR ri.FAX_isnull => 0,
                        le.CNP_NAME <> ri.CNP_NAME => 0, // Only valid if the context variable is equal
                        le.FAX = ri.FAX  => le.FAX_weight100,
                        0 /* switch0 */);
  SELF.FAC_NAME_match_code := MAP(
		(le.FAC_NAME_isnull OR le.CNP_NAME_isnull AND le.CNP_NUMBER_isnull AND le.CNP_STORE_NUMBER_isnull AND le.CNP_BTYPE_isnull) OR (ri.FAC_NAME_isnull OR ri.CNP_NAME_isnull AND ri.CNP_NUMBER_isnull AND ri.CNP_STORE_NUMBER_isnull AND ri.CNP_BTYPE_isnull) => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_FAC_NAME(le.FAC_NAME,ri.FAC_NAME,(SALT30.StrType)le.CNP_NAME,le.CNP_NAME_FAC_NAME_weight100,true,Config.CNP_NAME_Force,true,1,(SALT30.StrType)le.CNP_NUMBER,le.CNP_NUMBER_FAC_NAME_weight100,true,Config.CNP_NUMBER_Force,false,0,(SALT30.StrType)le.CNP_STORE_NUMBER,le.CNP_STORE_NUMBER_FAC_NAME_weight100,true,Config.CNP_STORE_NUMBER_Force,false,0,(SALT30.StrType)le.CNP_BTYPE,le.CNP_BTYPE_FAC_NAME_weight100,true,Config.CNP_BTYPE_Force,false,0,(SALT30.StrType)ri.CNP_NAME,ri.CNP_NAME_FAC_NAME_weight100,(SALT30.StrType)ri.CNP_NUMBER,ri.CNP_NUMBER_FAC_NAME_weight100,(SALT30.StrType)ri.CNP_STORE_NUMBER,ri.CNP_STORE_NUMBER_FAC_NAME_weight100,(SALT30.StrType)ri.CNP_BTYPE,ri.CNP_BTYPE_FAC_NAME_weight100));
  REAL FAC_NAME_score_scale := ( le.FAC_NAME_weight100 + ri.FAC_NAME_weight100 ) / (le.CNP_NAME_weight100 + ri.CNP_NAME_weight100 + le.CNP_NUMBER_weight100 + ri.CNP_NUMBER_weight100 + le.CNP_STORE_NUMBER_weight100 + ri.CNP_STORE_NUMBER_weight100 + le.CNP_BTYPE_weight100 + ri.CNP_BTYPE_weight100); // Scaling factor for this concept
  INTEGER2 FAC_NAME_score_pre := MAP( (le.FAC_NAME_isnull OR le.CNP_NAME_isnull AND le.CNP_NUMBER_isnull AND le.CNP_STORE_NUMBER_isnull AND le.CNP_BTYPE_isnull) OR (ri.FAC_NAME_isnull OR ri.CNP_NAME_isnull AND ri.CNP_NUMBER_isnull AND ri.CNP_STORE_NUMBER_isnull AND ri.CNP_BTYPE_isnull) => 0,
                        le.FAC_NAME = ri.FAC_NAME  => le.FAC_NAME_weight100,
                        SALT30.fn_concept_wordbag_EditN.Match4((SALT30.StrType)ri.CNP_NAME,ri.CNP_NAME_FAC_NAME_weight100,true,Config.CNP_NAME_Force,true,1,(SALT30.StrType)ri.CNP_NUMBER,ri.CNP_NUMBER_FAC_NAME_weight100,true,Config.CNP_NUMBER_Force,false,0,(SALT30.StrType)ri.CNP_STORE_NUMBER,ri.CNP_STORE_NUMBER_FAC_NAME_weight100,true,Config.CNP_STORE_NUMBER_Force,false,0,(SALT30.StrType)ri.CNP_BTYPE,ri.CNP_BTYPE_FAC_NAME_weight100,true,Config.CNP_BTYPE_Force,false,0,(SALT30.StrType)le.CNP_NAME,le.CNP_NAME_FAC_NAME_weight100,(SALT30.StrType)le.CNP_NUMBER,le.CNP_NUMBER_FAC_NAME_weight100,(SALT30.StrType)le.CNP_STORE_NUMBER,le.CNP_STORE_NUMBER_FAC_NAME_weight100,(SALT30.StrType)le.CNP_BTYPE,le.CNP_BTYPE_FAC_NAME_weight100)*IF(FAC_NAME_score_scale=0,1,FAC_NAME_score_scale));
  SELF.left_FAC_NAME := le.FAC_NAME;
  SELF.right_FAC_NAME := ri.FAC_NAME;
  SELF.ADDRESS_match_code := MAP(
		(le.ADDRESS_isnull OR (le.ADDR1_isnull OR le.PRIM_RANGE_isnull AND le.PRIM_NAME_isnull AND le.SEC_RANGE_isnull) AND (le.LOCALE_isnull OR le.V_CITY_NAME_isnull AND le.ST_isnull AND le.ZIP_isnull)) OR (ri.ADDRESS_isnull OR (ri.ADDR1_isnull OR ri.PRIM_RANGE_isnull AND ri.PRIM_NAME_isnull AND ri.SEC_RANGE_isnull) AND (ri.LOCALE_isnull OR ri.V_CITY_NAME_isnull AND ri.ST_isnull AND ri.ZIP_isnull)) OR le.ADDRESS_weight100 = 0 => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_ADDRESS(le.ADDRESS,ri.ADDRESS));
  REAL ADDRESS_score_scale := ( le.ADDRESS_weight100 + ri.ADDRESS_weight100 ) / (le.ADDR1_weight100 + ri.ADDR1_weight100 + le.LOCALE_weight100 + ri.LOCALE_weight100); // Scaling factor for this concept
  INTEGER2 ADDRESS_score_pre := MAP( (le.ADDRESS_isnull OR (le.ADDR1_isnull OR le.PRIM_RANGE_isnull AND le.PRIM_NAME_isnull AND le.SEC_RANGE_isnull) AND (le.LOCALE_isnull OR le.V_CITY_NAME_isnull AND le.ST_isnull AND le.ZIP_isnull)) OR (ri.ADDRESS_isnull OR (ri.ADDR1_isnull OR ri.PRIM_RANGE_isnull AND ri.PRIM_NAME_isnull AND ri.SEC_RANGE_isnull) AND (ri.LOCALE_isnull OR ri.V_CITY_NAME_isnull AND ri.ST_isnull AND ri.ZIP_isnull)) OR le.ADDRESS_weight100 = 0 => 0,
                        le.ADDRESS = ri.ADDRESS  => le.ADDRESS_weight100,
                        0);
  SELF.left_ADDRESS := le.ADDRESS;
  SELF.right_ADDRESS := ri.ADDRESS;
  SELF.left_C_LIC_NBR := le.C_LIC_NBR;
  SELF.right_C_LIC_NBR := ri.C_LIC_NBR;
  SELF.C_LIC_NBR_match_code := MAP(
		le.C_LIC_NBR_isnull OR ri.C_LIC_NBR_isnull => SALT30.MatchCode.OneSideNull,
		le.LIC_STATE <> ri.LIC_STATE => SALT30.MatchCode.ContextInvolved, // Only valid if the context variable is equal
		match_methods(ih).match_C_LIC_NBR(le.C_LIC_NBR,ri.C_LIC_NBR));
  SELF.C_LIC_NBR_score := MAP(
                        le.C_LIC_NBR_isnull OR ri.C_LIC_NBR_isnull => 0,
                        le.LIC_STATE <> ri.LIC_STATE => 0, // Only valid if the context variable is equal
                        le.C_LIC_NBR = ri.C_LIC_NBR  => le.C_LIC_NBR_weight100,
                        SALT30.WithinEditN(le.C_LIC_NBR,ri.C_LIC_NBR,1,0) => SALT30.fn_fuzzy_specificity(le.C_LIC_NBR_weight100,le.C_LIC_NBR_cnt, le.C_LIC_NBR_e1_cnt,ri.C_LIC_NBR_weight100,ri.C_LIC_NBR_cnt,ri.C_LIC_NBR_e1_cnt),
                        SALT30.Fn_Fail_Scale(le.C_LIC_NBR_weight100,s.C_LIC_NBR_switch));
  SELF.left_FEIN := le.FEIN;
  SELF.right_FEIN := ri.FEIN;
  SELF.FEIN_match_code := MAP(
		le.FEIN_isnull OR ri.FEIN_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_FEIN(le.FEIN,ri.FEIN));
  INTEGER2 FEIN_score_temp := MAP(
                        le.FEIN_isnull OR ri.FEIN_isnull => 0,
                        le.FEIN = ri.FEIN  => le.FEIN_weight100,
                        SALT30.Fn_Fail_Scale(le.FEIN_weight100,s.FEIN_switch));
  SELF.left_CNP_NAME := le.CNP_NAME;
  SELF.right_CNP_NAME := ri.CNP_NAME;
  SELF.CNP_NAME_match_code := MAP(
		le.CNP_NAME_isnull OR ri.CNP_NAME_isnull => SALT30.MatchCode.OneSideNull,
		FAC_NAME_score_pre > 0 => SALT30.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_CNP_NAME(le.CNP_NAME,ri.CNP_NAME));
  INTEGER2 CNP_NAME_score_temp := MAP(
                        le.CNP_NAME_isnull OR ri.CNP_NAME_isnull OR le.CNP_NAME_weight100 = 0 => 0,
                        FAC_NAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.CNP_NAME = ri.CNP_NAME OR SALT30.HyphenMatch(le.CNP_NAME,ri.CNP_NAME,1)<=1  => MIN(le.CNP_NAME_weight100,ri.CNP_NAME_weight100),
                        SALT30.MatchBagOfWords(le.CNP_NAME,ri.CNP_NAME,3407383,0))*IF(FAC_NAME_score_scale=0,1,FAC_NAME_score_scale);
  SELF.left_CNP_NUMBER := le.CNP_NUMBER;
  SELF.right_CNP_NUMBER := ri.CNP_NUMBER;
  SELF.CNP_NUMBER_match_code := MAP(
		le.CNP_NUMBER_isnull OR ri.CNP_NUMBER_isnull => SALT30.MatchCode.OneSideNull,
		FAC_NAME_score_pre > 0 => SALT30.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_CNP_NUMBER(le.CNP_NUMBER,ri.CNP_NUMBER));
  INTEGER2 CNP_NUMBER_score_temp := MAP(
                        le.CNP_NUMBER_isnull OR ri.CNP_NUMBER_isnull => 0,
                        FAC_NAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.CNP_NUMBER = ri.CNP_NUMBER  => le.CNP_NUMBER_weight100,
                        SALT30.Fn_Fail_Scale(le.CNP_NUMBER_weight100,s.CNP_NUMBER_switch))*IF(FAC_NAME_score_scale=0,1,FAC_NAME_score_scale);
  SELF.LOCALE_match_code := MAP(
		(le.LOCALE_isnull OR le.V_CITY_NAME_isnull AND le.ST_isnull AND le.ZIP_isnull) OR (ri.LOCALE_isnull OR ri.V_CITY_NAME_isnull AND ri.ST_isnull AND ri.ZIP_isnull) OR le.LOCALE_weight100 = 0 => SALT30.MatchCode.OneSideNull,
		ADDRESS_score_pre > 0 => SALT30.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_LOCALE(le.LOCALE,ri.LOCALE));
  REAL LOCALE_score_scale := ( le.LOCALE_weight100 + ri.LOCALE_weight100 ) / (le.V_CITY_NAME_weight100 + ri.V_CITY_NAME_weight100 + le.ST_weight100 + ri.ST_weight100 + le.ZIP_weight100 + ri.ZIP_weight100); // Scaling factor for this concept
  INTEGER2 LOCALE_score_pre := MAP( (le.LOCALE_isnull OR le.V_CITY_NAME_isnull AND le.ST_isnull AND le.ZIP_isnull) OR (ri.LOCALE_isnull OR ri.V_CITY_NAME_isnull AND ri.ST_isnull AND ri.ZIP_isnull) OR le.LOCALE_weight100 = 0 => 0,
                        ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.LOCALE = ri.LOCALE  => le.LOCALE_weight100,
                        0)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  SELF.left_LOCALE := le.LOCALE;
  SELF.right_LOCALE := ri.LOCALE;
  SELF.left_V_CITY_NAME := le.V_CITY_NAME;
  SELF.right_V_CITY_NAME := ri.V_CITY_NAME;
  SELF.V_CITY_NAME_match_code := MAP(
		le.V_CITY_NAME_isnull OR ri.V_CITY_NAME_isnull => SALT30.MatchCode.OneSideNull,
		LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => SALT30.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		le.ST <> ri.ST => SALT30.MatchCode.ContextInvolved, // Only valid if the context variable is equal
		match_methods(ih).match_V_CITY_NAME(le.V_CITY_NAME,ri.V_CITY_NAME));
  SELF.V_CITY_NAME_score := MAP(
                        le.V_CITY_NAME_isnull OR ri.V_CITY_NAME_isnull => 0,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.ST <> ri.ST => 0, // Only valid if the context variable is equal
                        le.V_CITY_NAME = ri.V_CITY_NAME  => le.V_CITY_NAME_weight100,
                        0 /* switch0 */)*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  SELF.left_TAXONOMY := le.TAXONOMY;
  SELF.right_TAXONOMY := ri.TAXONOMY;
  SELF.TAXONOMY_match_code := MAP(
		le.TAXONOMY_isnull OR ri.TAXONOMY_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_TAXONOMY(le.TAXONOMY,ri.TAXONOMY));
  SELF.TAXONOMY_score := MAP(
                        le.TAXONOMY_isnull OR ri.TAXONOMY_isnull => 0,
                        le.TAXONOMY = ri.TAXONOMY  => le.TAXONOMY_weight100,
                        0 /* switch0 */);
  SELF.left_CNP_BTYPE := le.CNP_BTYPE;
  SELF.right_CNP_BTYPE := ri.CNP_BTYPE;
  SELF.CNP_BTYPE_match_code := MAP(
		le.CNP_BTYPE_isnull OR ri.CNP_BTYPE_isnull => SALT30.MatchCode.OneSideNull,
		FAC_NAME_score_pre > 0 => SALT30.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_CNP_BTYPE(le.CNP_BTYPE,ri.CNP_BTYPE));
  INTEGER2 CNP_BTYPE_score_temp := MAP(
                        le.CNP_BTYPE_isnull OR ri.CNP_BTYPE_isnull => 0,
                        FAC_NAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.CNP_BTYPE = ri.CNP_BTYPE  => le.CNP_BTYPE_weight100,
                        SALT30.Fn_Fail_Scale(le.CNP_BTYPE_weight100,s.CNP_BTYPE_switch))*IF(FAC_NAME_score_scale=0,1,FAC_NAME_score_scale);
  SELF.left_TAXONOMY_CODE := le.TAXONOMY_CODE;
  SELF.right_TAXONOMY_CODE := ri.TAXONOMY_CODE;
  SELF.TAXONOMY_CODE_match_code := MAP(
		le.TAXONOMY_CODE_isnull OR ri.TAXONOMY_CODE_isnull => SALT30.MatchCode.OneSideNull,
		match_methods(ih).match_TAXONOMY_CODE(le.TAXONOMY_CODE,ri.TAXONOMY_CODE));
  INTEGER2 TAXONOMY_CODE_score_temp := MAP(
                        le.TAXONOMY_CODE_isnull OR ri.TAXONOMY_CODE_isnull => 0,
                        le.TAXONOMY_CODE = ri.TAXONOMY_CODE  => le.TAXONOMY_CODE_weight100,
                        SALT30.Fn_Fail_Scale(le.TAXONOMY_CODE_weight100,s.TAXONOMY_CODE_switch));
  SELF.left_SRC := le.SRC;
  SELF.right_SRC := ri.SRC;
  SELF.left_CNAME := le.CNAME;
  SELF.right_CNAME := ri.CNAME;
  SELF.left_CNP_LOWV := le.CNP_LOWV;
  SELF.right_CNP_LOWV := ri.CNP_LOWV;
  SELF.left_CNP_TRANSLATED := le.CNP_TRANSLATED;
  SELF.right_CNP_TRANSLATED := ri.CNP_TRANSLATED;
  SELF.left_CNP_CLASSID := le.CNP_CLASSID;
  SELF.right_CNP_CLASSID := ri.CNP_CLASSID;
  SELF.left_ADDRESS_ID := le.ADDRESS_ID;
  SELF.right_ADDRESS_ID := ri.ADDRESS_ID;
  SELF.left_ADDRESS_CLASSIFICATION := le.ADDRESS_CLASSIFICATION;
  SELF.right_ADDRESS_CLASSIFICATION := ri.ADDRESS_CLASSIFICATION;
  SELF.left_UPIN := le.UPIN;
  SELF.right_UPIN := ri.UPIN;
  SELF.left_LIC_STATE := le.LIC_STATE;
  SELF.right_LIC_STATE := ri.LIC_STATE;
  SELF.left_ST := le.ST;
  SELF.right_ST := ri.ST;
  SELF.ST_match_code := MAP(
		le.ST_isnull OR ri.ST_isnull => SALT30.MatchCode.OneSideNull,
		LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => SALT30.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_ST(le.ST,ri.ST));
  INTEGER2 ST_score_temp := MAP(
                        le.ST_isnull OR ri.ST_isnull OR le.ST_weight100 = 0 => 0,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.ST = ri.ST  => le.ST_weight100,
                        0 /* switch0 */)*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  SELF.NPI_NUMBER_score := IF ( NPI_NUMBER_score_temp >= Config.NPI_NUMBER_Force * 100, NPI_NUMBER_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.NPI_NUMBER_skipped := SELF.NPI_NUMBER_score < -5000;// Enforce FORCE parameter
  SELF.CLIA_NUMBER_score := IF ( CLIA_NUMBER_score_temp >= Config.CLIA_NUMBER_Force * 100, CLIA_NUMBER_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.CLIA_NUMBER_skipped := SELF.CLIA_NUMBER_score < -5000;// Enforce FORCE parameter
  SELF.NCPDP_NUMBER_score := IF ( NCPDP_NUMBER_score_temp >= Config.NCPDP_NUMBER_Force * 100, NCPDP_NUMBER_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.NCPDP_NUMBER_skipped := SELF.NCPDP_NUMBER_score < -5000;// Enforce FORCE parameter
  SELF.DEA_NUMBER_score := IF ( DEA_NUMBER_score_temp >= Config.DEA_NUMBER_Force * 100, DEA_NUMBER_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.DEA_NUMBER_skipped := SELF.DEA_NUMBER_score < -5000;// Enforce FORCE parameter
  SELF.TAX_ID_score := TAX_ID_score_temp*0.25; 
  SELF.VENDOR_ID_score := VENDOR_ID_score_temp*0.10; 
  SELF.left_CNP_STORE_NUMBER := le.CNP_STORE_NUMBER;
  SELF.right_CNP_STORE_NUMBER := ri.CNP_STORE_NUMBER;
  SELF.CNP_STORE_NUMBER_match_code := MAP(
		le.CNP_STORE_NUMBER_isnull OR ri.CNP_STORE_NUMBER_isnull => SALT30.MatchCode.OneSideNull,
		FAC_NAME_score_pre > 0 => SALT30.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_CNP_STORE_NUMBER(le.CNP_STORE_NUMBER,ri.CNP_STORE_NUMBER));
  INTEGER2 CNP_STORE_NUMBER_score_temp := MAP(
                        le.CNP_STORE_NUMBER_isnull OR ri.CNP_STORE_NUMBER_isnull => 0,
                        FAC_NAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.CNP_STORE_NUMBER = ri.CNP_STORE_NUMBER  => le.CNP_STORE_NUMBER_weight100,
                        SALT30.Fn_Fail_Scale(le.CNP_STORE_NUMBER_weight100,s.CNP_STORE_NUMBER_switch))*IF(FAC_NAME_score_scale=0,1,FAC_NAME_score_scale);
  SELF.ADDR1_match_code := MAP(
		(le.ADDR1_isnull OR le.PRIM_RANGE_isnull AND le.PRIM_NAME_isnull AND le.SEC_RANGE_isnull) OR (ri.ADDR1_isnull OR ri.PRIM_RANGE_isnull AND ri.PRIM_NAME_isnull AND ri.SEC_RANGE_isnull) => SALT30.MatchCode.OneSideNull,
		ADDRESS_score_pre > 0 => SALT30.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_ADDR1(le.ADDR1,ri.ADDR1,(SALT30.StrType)le.PRIM_RANGE,le.PRIM_RANGE_ADDR1_weight100,true,Config.PRIM_RANGE_Force,false,1,(SALT30.StrType)le.PRIM_NAME,le.PRIM_NAME_ADDR1_weight100,true,Config.PRIM_NAME_Force,true,1,(SALT30.StrType)le.SEC_RANGE,le.SEC_RANGE_ADDR1_weight100,true,Config.SEC_RANGE_Force,false,0,(SALT30.StrType)ri.PRIM_RANGE,ri.PRIM_RANGE_ADDR1_weight100,(SALT30.StrType)ri.PRIM_NAME,ri.PRIM_NAME_ADDR1_weight100,(SALT30.StrType)ri.SEC_RANGE,ri.SEC_RANGE_ADDR1_weight100));
  REAL ADDR1_score_scale := ( le.ADDR1_weight100 + ri.ADDR1_weight100 ) / (le.PRIM_RANGE_weight100 + ri.PRIM_RANGE_weight100 + le.PRIM_NAME_weight100 + ri.PRIM_NAME_weight100 + le.SEC_RANGE_weight100 + ri.SEC_RANGE_weight100); // Scaling factor for this concept
  INTEGER2 ADDR1_score_pre := MAP( (le.ADDR1_isnull OR le.PRIM_RANGE_isnull AND le.PRIM_NAME_isnull AND le.SEC_RANGE_isnull) OR (ri.ADDR1_isnull OR ri.PRIM_RANGE_isnull AND ri.PRIM_NAME_isnull AND ri.SEC_RANGE_isnull) => 0,
                        ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.ADDR1 = ri.ADDR1  => le.ADDR1_weight100,
                        SALT30.fn_concept_wordbag_EditN.Match3((SALT30.StrType)ri.PRIM_RANGE,ri.PRIM_RANGE_ADDR1_weight100,true,Config.PRIM_RANGE_Force,false,1,(SALT30.StrType)ri.PRIM_NAME,ri.PRIM_NAME_ADDR1_weight100,true,Config.PRIM_NAME_Force,true,1,(SALT30.StrType)ri.SEC_RANGE,ri.SEC_RANGE_ADDR1_weight100,true,Config.SEC_RANGE_Force,false,0,(SALT30.StrType)le.PRIM_RANGE,le.PRIM_RANGE_ADDR1_weight100,(SALT30.StrType)le.PRIM_NAME,le.PRIM_NAME_ADDR1_weight100,(SALT30.StrType)le.SEC_RANGE,le.SEC_RANGE_ADDR1_weight100)*IF(ADDR1_score_scale=0,1,ADDR1_score_scale))*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  SELF.left_ADDR1 := le.ADDR1;
  SELF.right_ADDR1 := ri.ADDR1;
  SELF.FEIN_score := IF ( FEIN_score_temp >= Config.FEIN_Force * 100 OR (SELF.NPI_NUMBER_score > Config.FEIN_OR1_NPI_NUMBER_Force*100), FEIN_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.FEIN_skipped := SELF.FEIN_score < -5000;// Enforce FORCE parameter
  SELF.CNP_NAME_score := IF ( CNP_NAME_score_temp > Config.CNP_NAME_Force * 100 OR (SELF.FEIN_score > Config.CNP_NAME_OR1_FEIN_Force*100) OR (SELF.NPI_NUMBER_score > Config.CNP_NAME_OR2_NPI_NUMBER_Force*100) OR (SELF.C_LIC_NBR_score > Config.CNP_NAME_OR3_C_LIC_NBR_Force*100) OR (SELF.CLIA_NUMBER_score > Config.CNP_NAME_OR4_CLIA_NUMBER_Force*100) OR (SELF.MEDICARE_FACILITY_NUMBER_score > Config.CNP_NAME_OR5_MEDICARE_FACILITY_NUMBER_Force*100) OR (SELF.NCPDP_NUMBER_score > Config.CNP_NAME_OR6_NCPDP_NUMBER_Force*100) OR (SELF.DEA_NUMBER_score > Config.CNP_NAME_OR7_DEA_NUMBER_Force*100) OR FAC_NAME_score_pre > 0, CNP_NAME_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.CNP_NAME_skipped := SELF.CNP_NAME_score < -5000;// Enforce FORCE parameter
  SELF.CNP_NUMBER_score := IF ( CNP_NUMBER_score_temp >= Config.CNP_NUMBER_Force * 100 OR (SELF.FEIN_score > Config.CNP_NUMBER_OR1_FEIN_Force*100) OR (SELF.NPI_NUMBER_score > Config.CNP_NUMBER_OR2_NPI_NUMBER_Force*100) OR (SELF.CLIA_NUMBER_score > Config.CNP_NUMBER_OR3_CLIA_NUMBER_Force*100) OR (SELF.C_LIC_NBR_score > Config.CNP_NUMBER_OR4_C_LIC_NBR_Force*100) OR (SELF.MEDICARE_FACILITY_NUMBER_score > Config.CNP_NUMBER_OR5_MEDICARE_FACILITY_NUMBER_Force*100) OR (SELF.NCPDP_NUMBER_score > Config.CNP_NUMBER_OR6_NCPDP_NUMBER_Force*100) OR (SELF.DEA_NUMBER_score > Config.CNP_NUMBER_OR7_DEA_NUMBER_Force*100), CNP_NUMBER_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.CNP_NUMBER_skipped := SELF.CNP_NUMBER_score < -5000;// Enforce FORCE parameter
  SELF.left_PRIM_NAME := le.PRIM_NAME;
  SELF.right_PRIM_NAME := ri.PRIM_NAME;
  SELF.PRIM_NAME_match_code := MAP(
		le.PRIM_NAME_isnull OR ri.PRIM_NAME_isnull => SALT30.MatchCode.OneSideNull,
		ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => SALT30.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_PRIM_NAME(le.PRIM_NAME,ri.PRIM_NAME));
  INTEGER2 PRIM_NAME_score_temp := MAP(
                        le.PRIM_NAME_isnull OR ri.PRIM_NAME_isnull OR le.PRIM_NAME_weight100 = 0 => 0,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.PRIM_NAME = ri.PRIM_NAME  => le.PRIM_NAME_weight100,
                        SALT30.MatchBagOfWords(le.PRIM_NAME,ri.PRIM_NAME,32019,1))*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  SELF.left_ZIP := le.ZIP;
  SELF.right_ZIP := ri.ZIP;
  SELF.ZIP_match_code := MAP(
		le.ZIP_isnull OR ri.ZIP_isnull => SALT30.MatchCode.OneSideNull,
		LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => SALT30.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_ZIP(le.ZIP,ri.ZIP));
  SELF.ZIP_score := MAP(
                        le.ZIP_isnull OR ri.ZIP_isnull => 0,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.ZIP = ri.ZIP  => le.ZIP_weight100,
                        0 /* switch0 */)*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  SELF.left_PRIM_RANGE := le.PRIM_RANGE;
  SELF.right_PRIM_RANGE := ri.PRIM_RANGE;
  SELF.PRIM_RANGE_match_code := MAP(
		le.PRIM_RANGE_isnull OR ri.PRIM_RANGE_isnull => SALT30.MatchCode.OneSideNull,
		ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => SALT30.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_PRIM_RANGE(le.PRIM_RANGE,ri.PRIM_RANGE));
  INTEGER2 PRIM_RANGE_score_temp := MAP(
                        le.PRIM_RANGE_isnull OR ri.PRIM_RANGE_isnull OR le.PRIM_RANGE_weight100 = 0 => 0,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.PRIM_RANGE = ri.PRIM_RANGE  => le.PRIM_RANGE_weight100,
                        SALT30.WithinEditN(le.PRIM_RANGE,ri.PRIM_RANGE,1,0) => SALT30.fn_fuzzy_specificity(le.PRIM_RANGE_weight100,le.PRIM_RANGE_cnt, le.PRIM_RANGE_e1_cnt,ri.PRIM_RANGE_weight100,ri.PRIM_RANGE_cnt,ri.PRIM_RANGE_e1_cnt),
                        0 /* switch0 */)*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  SELF.left_SEC_RANGE := le.SEC_RANGE;
  SELF.right_SEC_RANGE := ri.SEC_RANGE;
  SELF.SEC_RANGE_match_code := MAP(
		le.SEC_RANGE_isnull OR ri.SEC_RANGE_isnull => SALT30.MatchCode.OneSideNull,
		ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => SALT30.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_SEC_RANGE(le.SEC_RANGE,ri.SEC_RANGE));
  INTEGER2 SEC_RANGE_score_temp := MAP(
                        le.SEC_RANGE_isnull OR ri.SEC_RANGE_isnull => 0,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.SEC_RANGE = ri.SEC_RANGE OR SALT30.HyphenMatch(le.SEC_RANGE,ri.SEC_RANGE,1)<=2  => MIN(le.SEC_RANGE_weight100,ri.SEC_RANGE_weight100),
                        0 /* switch0 */)*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  SELF.CNP_BTYPE_score := IF ( CNP_BTYPE_score_temp >= Config.CNP_BTYPE_Force * 100 OR (SELF.FEIN_score > Config.CNP_BTYPE_OR1_FEIN_Force*100) OR (SELF.NPI_NUMBER_score > Config.CNP_BTYPE_OR2_NPI_NUMBER_Force*100) OR (SELF.C_LIC_NBR_score > Config.CNP_BTYPE_OR3_C_LIC_NBR_Force*100) OR (SELF.CLIA_NUMBER_score > Config.CNP_BTYPE_OR4_CLIA_NUMBER_Force*100) OR (SELF.MEDICARE_FACILITY_NUMBER_score > Config.CNP_BTYPE_OR5_MEDICARE_FACILITY_NUMBER_Force*100) OR (SELF.NCPDP_NUMBER_score > Config.CNP_BTYPE_OR6_NCPDP_NUMBER_Force*100) OR (SELF.DEA_NUMBER_score > Config.CNP_BTYPE_OR7_DEA_NUMBER_Force*100), CNP_BTYPE_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.CNP_BTYPE_skipped := SELF.CNP_BTYPE_score < -5000;// Enforce FORCE parameter
  INTEGER2 TAXONOMY_CODE_score_unweighted := IF ( TAXONOMY_CODE_score_temp >= Config.TAXONOMY_CODE_Force * 100, TAXONOMY_CODE_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.TAXONOMY_CODE_skipped := TAXONOMY_CODE_score_unweighted < -5000;// Enforce FORCE parameter
  SELF.TAXONOMY_CODE_score := TAXONOMY_CODE_score_unweighted*0.25; 
  SELF.ST_score := IF ( ST_score_temp > Config.ST_Force * 100 OR (SELF.NPI_NUMBER_score > Config.ST_OR1_NPI_NUMBER_Force*100) OR LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0, ST_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.ST_skipped := SELF.ST_score < -5000;// Enforce FORCE parameter
  SELF.CNP_STORE_NUMBER_score := IF ( CNP_STORE_NUMBER_score_temp >= Config.CNP_STORE_NUMBER_Force * 100 OR (SELF.FEIN_score > Config.CNP_STORE_NUMBER_OR1_FEIN_Force*100) OR (SELF.NPI_NUMBER_score > Config.CNP_STORE_NUMBER_OR2_NPI_NUMBER_Force*100) OR (SELF.C_LIC_NBR_score > Config.CNP_STORE_NUMBER_OR3_C_LIC_NBR_Force*100) OR (SELF.CLIA_NUMBER_score > Config.CNP_STORE_NUMBER_OR4_CLIA_NUMBER_Force*100) OR (SELF.MEDICARE_FACILITY_NUMBER_score > Config.CNP_STORE_NUMBER_OR5_MEDICARE_FACILITY_NUMBER_Force*100) OR (SELF.NCPDP_NUMBER_score > Config.CNP_STORE_NUMBER_OR6_NCPDP_NUMBER_Force*100) OR (SELF.DEA_NUMBER_score > Config.CNP_STORE_NUMBER_OR7_DEA_NUMBER_Force*100), CNP_STORE_NUMBER_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.CNP_STORE_NUMBER_skipped := SELF.CNP_STORE_NUMBER_score < -5000;// Enforce FORCE parameter
// Compute the score for the concept FAC_NAME
  INTEGER2 FAC_NAME_score_ext := SALT30.ClipScore(MAX(FAC_NAME_score_pre,0) + self.CNP_NAME_score + self.CNP_NUMBER_score + self.CNP_STORE_NUMBER_score + self.CNP_BTYPE_score);// Score in surrounding context
  INTEGER2 FAC_NAME_score_res := MAX(0,FAC_NAME_score_pre); // At least nothing
  SELF.FAC_NAME_score := FAC_NAME_score_res;
  SELF.PRIM_NAME_score := IF ( PRIM_NAME_score_temp > Config.PRIM_NAME_Force * 100 OR (SELF.NPI_NUMBER_score > Config.PRIM_NAME_OR1_NPI_NUMBER_Force*100) OR ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0, PRIM_NAME_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.PRIM_NAME_skipped := SELF.PRIM_NAME_score < -5000;// Enforce FORCE parameter
// Compute the score for the concept LOCALE
  INTEGER2 LOCALE_score_ext := SALT30.ClipScore(MAX(LOCALE_score_pre,0) + self.V_CITY_NAME_score + self.ST_score + self.ZIP_score + MAX(ADDRESS_score_pre,0));// Score in surrounding context
  INTEGER2 LOCALE_score_res := MAX(0,LOCALE_score_pre); // At least nothing
  SELF.LOCALE_score := IF ( LOCALE_score_ext > -200 OR (SELF.NPI_NUMBER_score > Config.LOCALE_OR1_NPI_NUMBER_Force*100),LOCALE_score_res,-9999);
  SELF.LOCALE_skipped := SELF.LOCALE_score < -5000;// Enforce FORCE parameter
  SELF.PRIM_RANGE_score := IF ( PRIM_RANGE_score_temp > Config.PRIM_RANGE_Force * 100 OR (SELF.NPI_NUMBER_score > Config.PRIM_RANGE_OR1_NPI_NUMBER_Force*100) OR ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0, PRIM_RANGE_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.PRIM_RANGE_skipped := SELF.PRIM_RANGE_score < -5000;// Enforce FORCE parameter
  SELF.SEC_RANGE_score := IF ( SEC_RANGE_score_temp >= Config.SEC_RANGE_Force * 100 OR (SELF.NPI_NUMBER_score > Config.SEC_RANGE_OR1_NPI_NUMBER_Force*100), SEC_RANGE_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.SEC_RANGE_skipped := SELF.SEC_RANGE_score < -5000;// Enforce FORCE parameter
// Compute the score for the concept ADDR1
  INTEGER2 ADDR1_score_ext := SALT30.ClipScore(MAX(ADDR1_score_pre,0) + self.PRIM_RANGE_score + self.PRIM_NAME_score + self.SEC_RANGE_score + MAX(ADDRESS_score_pre,0));// Score in surrounding context
  INTEGER2 ADDR1_score_res := MAX(0,ADDR1_score_pre); // At least nothing
  SELF.ADDR1_score := ADDR1_score_res;
// Compute the score for the concept ADDRESS
  INTEGER2 ADDRESS_score_ext := SALT30.ClipScore(MAX(ADDRESS_score_pre,0)+ SELF.ADDR1_score + self.PRIM_RANGE_score + self.PRIM_NAME_score + self.SEC_RANGE_score+ SELF.LOCALE_score + self.V_CITY_NAME_score + self.ST_score + self.ZIP_score);// Score in surrounding context
  INTEGER2 ADDRESS_score_res := MAX(0,ADDRESS_score_pre); // At least nothing
  SELF.ADDRESS_score := IF ( ADDRESS_score_ext > 0 OR (SELF.NPI_NUMBER_score > Config.ADDRESS_OR1_NPI_NUMBER_Force*100),ADDRESS_score_res,-9999);
  SELF.ADDRESS_skipped := SELF.ADDRESS_score < -5000;// Enforce FORCE parameter
  SELF.Conf_Prop := (0
    +MAX(le.NPI_NUMBER_prop,ri.NPI_NUMBER_prop)*SELF.NPI_NUMBER_score // Score if either field propogated
    +MAX(le.CLIA_NUMBER_prop,ri.CLIA_NUMBER_prop)*SELF.CLIA_NUMBER_score // Score if either field propogated
    +MAX(le.NCPDP_NUMBER_prop,ri.NCPDP_NUMBER_prop)*SELF.NCPDP_NUMBER_score // Score if either field propogated
    +MAX(le.MEDICAID_NUMBER_prop,ri.MEDICAID_NUMBER_prop)*SELF.MEDICAID_NUMBER_score // Score if either field propogated
    +MAX(le.DEA_NUMBER_prop,ri.DEA_NUMBER_prop)*SELF.DEA_NUMBER_score // Score if either field propogated
    +MAX(le.CNP_STORE_NUMBER_prop,ri.CNP_STORE_NUMBER_prop)*SELF.CNP_STORE_NUMBER_score // Score if either field propogated
    +if(le.FAC_NAME_prop+ri.FAC_NAME_prop>0,self.FAC_NAME_score*(0+if(le.CNP_NUMBER_prop+ri.CNP_NUMBER_prop>0,1,0)+if(le.CNP_STORE_NUMBER_prop+ri.CNP_STORE_NUMBER_prop>0,1,0)+if(le.CNP_BTYPE_prop+ri.CNP_BTYPE_prop>0,1,0))/4,0)
    +if(le.ADDR1_prop+ri.ADDR1_prop>0,self.ADDR1_score*(0+if(le.PRIM_RANGE_prop+ri.PRIM_RANGE_prop>0,1,0)+if(le.PRIM_NAME_prop+ri.PRIM_NAME_prop>0,1,0)+if(le.SEC_RANGE_prop+ri.SEC_RANGE_prop>0,1,0))/3,0)
    +if(le.ADDRESS_prop+ri.ADDRESS_prop>0,self.ADDRESS_score*(0+if(le.ADDR1_prop+ri.ADDR1_prop>0,1,0))/2,0)
    +MAX(le.FEIN_prop,ri.FEIN_prop)*SELF.FEIN_score // Score if either field propogated
    +MAX(le.CNP_NUMBER_prop,ri.CNP_NUMBER_prop)*SELF.CNP_NUMBER_score // Score if either field propogated
    +(MAX(le.PRIM_NAME_prop,ri.PRIM_NAME_prop)/MAX(LENGTH(TRIM(le.PRIM_NAME)),LENGTH(TRIM(ri.PRIM_NAME))))*self.PRIM_NAME_score // Proportion of longest string propogated
    +MAX(le.PRIM_RANGE_prop,ri.PRIM_RANGE_prop)*SELF.PRIM_RANGE_score // Score if either field propogated
    +MAX(le.SEC_RANGE_prop,ri.SEC_RANGE_prop)*SELF.SEC_RANGE_score // Score if either field propogated
    +MAX(le.TAXONOMY_prop,ri.TAXONOMY_prop)*SELF.TAXONOMY_score // Score if either field propogated
    +MAX(le.CNP_BTYPE_prop,ri.CNP_BTYPE_prop)*SELF.CNP_BTYPE_score // Score if either field propogated
    +MAX(le.TAXONOMY_CODE_prop,ri.TAXONOMY_CODE_prop)*SELF.TAXONOMY_CODE_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  SELF.Conf := (SELF.NPI_NUMBER_score + SELF.CLIA_NUMBER_score + SELF.NCPDP_NUMBER_score + SELF.MEDICAID_NUMBER_score + SELF.DEA_NUMBER_score + SELF.MEDICARE_FACILITY_NUMBER_score + SELF.TAX_ID_score + SELF.VENDOR_ID_score + SELF.PHONE_score + SELF.FAX_score + IF(SELF.FAC_NAME_score>0,MAX(SELF.FAC_NAME_score,SELF.CNP_NAME_score + SELF.CNP_NUMBER_score + SELF.CNP_STORE_NUMBER_score + SELF.CNP_BTYPE_score),SELF.CNP_NAME_score + SELF.CNP_NUMBER_score + SELF.CNP_STORE_NUMBER_score + SELF.CNP_BTYPE_score) + IF(SELF.ADDRESS_score>0,MAX(SELF.ADDRESS_score,IF(SELF.ADDR1_score>0,MAX(SELF.ADDR1_score,SELF.PRIM_RANGE_score + SELF.PRIM_NAME_score + SELF.SEC_RANGE_score),SELF.PRIM_RANGE_score + SELF.PRIM_NAME_score + SELF.SEC_RANGE_score) + IF(SELF.LOCALE_score>0,MAX(SELF.LOCALE_score,SELF.V_CITY_NAME_score + SELF.ST_score + SELF.ZIP_score),SELF.V_CITY_NAME_score + SELF.ST_score + SELF.ZIP_score)),IF(SELF.ADDR1_score>0,MAX(SELF.ADDR1_score,SELF.PRIM_RANGE_score + SELF.PRIM_NAME_score + SELF.SEC_RANGE_score),SELF.PRIM_RANGE_score + SELF.PRIM_NAME_score + SELF.SEC_RANGE_score) + IF(SELF.LOCALE_score>0,MAX(SELF.LOCALE_score,SELF.V_CITY_NAME_score + SELF.ST_score + SELF.ZIP_score),SELF.V_CITY_NAME_score + SELF.ST_score + SELF.ZIP_score)) + SELF.C_LIC_NBR_score + SELF.FEIN_score + SELF.TAXONOMY_score + SELF.TAXONOMY_CODE_score) / 100 + outside;
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
EXPORT AnnotateClusterMatches(DATASET(match_candidates(ih).layout_candidates) in_data,SALT30.UIDType BaseRecord) := FUNCTION//Faster form when RID known
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
  SALT30.UIDType LNPID;
  DATASET(SALT30.Layout_FieldValueList) NPI_NUMBER_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) CLIA_NUMBER_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) NCPDP_NUMBER_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) MEDICAID_NUMBER_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) DEA_NUMBER_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) MEDICARE_FACILITY_NUMBER_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) TAX_ID_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) VENDOR_ID_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) PHONE_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) FAX_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) FAC_NAME_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) ADDRESS_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) C_LIC_NBR_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) FEIN_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) TAXONOMY_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) TAXONOMY_CODE_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) SRC_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) CNAME_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) CNP_LOWV_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) CNP_TRANSLATED_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) CNP_CLASSID_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) ADDRESS_ID_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) ADDRESS_CLASSIFICATION_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) UPIN_Values := DATASET([],SALT30.Layout_FieldValueList);
  DATASET(SALT30.Layout_FieldValueList) LIC_STATE_Values := DATASET([],SALT30.Layout_FieldValueList);
END;
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.LNPID := le.LNPID;
  SELF.NPI_NUMBER_values := SALT30.fn_combine_fieldvaluelist(le.NPI_NUMBER_values,ri.NPI_NUMBER_values);
  SELF.CLIA_NUMBER_values := SALT30.fn_combine_fieldvaluelist(le.CLIA_NUMBER_values,ri.CLIA_NUMBER_values);
  SELF.NCPDP_NUMBER_values := SALT30.fn_combine_fieldvaluelist(le.NCPDP_NUMBER_values,ri.NCPDP_NUMBER_values);
  SELF.MEDICAID_NUMBER_values := SALT30.fn_combine_fieldvaluelist(le.MEDICAID_NUMBER_values,ri.MEDICAID_NUMBER_values);
  SELF.DEA_NUMBER_values := SALT30.fn_combine_fieldvaluelist(le.DEA_NUMBER_values,ri.DEA_NUMBER_values);
  SELF.MEDICARE_FACILITY_NUMBER_values := SALT30.fn_combine_fieldvaluelist(le.MEDICARE_FACILITY_NUMBER_values,ri.MEDICARE_FACILITY_NUMBER_values);
  SELF.TAX_ID_values := SALT30.fn_combine_fieldvaluelist(le.TAX_ID_values,ri.TAX_ID_values);
  SELF.VENDOR_ID_values := SALT30.fn_combine_fieldvaluelist(le.VENDOR_ID_values,ri.VENDOR_ID_values);
  SELF.PHONE_values := SALT30.fn_combine_fieldvaluelist(le.PHONE_values,ri.PHONE_values);
  SELF.FAX_values := SALT30.fn_combine_fieldvaluelist(le.FAX_values,ri.FAX_values);
  SELF.FAC_NAME_values := SALT30.fn_combine_fieldvaluelist(le.FAC_NAME_values,ri.FAC_NAME_values);
  SELF.ADDRESS_values := SALT30.fn_combine_fieldvaluelist(le.ADDRESS_values,ri.ADDRESS_values);
  SELF.C_LIC_NBR_values := SALT30.fn_combine_fieldvaluelist(le.C_LIC_NBR_values,ri.C_LIC_NBR_values);
  SELF.FEIN_values := SALT30.fn_combine_fieldvaluelist(le.FEIN_values,ri.FEIN_values);
  SELF.TAXONOMY_values := SALT30.fn_combine_fieldvaluelist(le.TAXONOMY_values,ri.TAXONOMY_values);
  SELF.TAXONOMY_CODE_values := SALT30.fn_combine_fieldvaluelist(le.TAXONOMY_CODE_values,ri.TAXONOMY_CODE_values);
  SELF.SRC_values := SALT30.fn_combine_fieldvaluelist(le.SRC_values,ri.SRC_values);
  SELF.CNAME_values := SALT30.fn_combine_fieldvaluelist(le.CNAME_values,ri.CNAME_values);
  SELF.CNP_LOWV_values := SALT30.fn_combine_fieldvaluelist(le.CNP_LOWV_values,ri.CNP_LOWV_values);
  SELF.CNP_TRANSLATED_values := SALT30.fn_combine_fieldvaluelist(le.CNP_TRANSLATED_values,ri.CNP_TRANSLATED_values);
  SELF.CNP_CLASSID_values := SALT30.fn_combine_fieldvaluelist(le.CNP_CLASSID_values,ri.CNP_CLASSID_values);
  SELF.ADDRESS_ID_values := SALT30.fn_combine_fieldvaluelist(le.ADDRESS_ID_values,ri.ADDRESS_ID_values);
  SELF.ADDRESS_CLASSIFICATION_values := SALT30.fn_combine_fieldvaluelist(le.ADDRESS_CLASSIFICATION_values,ri.ADDRESS_CLASSIFICATION_values);
  SELF.UPIN_values := SALT30.fn_combine_fieldvaluelist(le.UPIN_values,ri.UPIN_values);
  SELF.LIC_STATE_values := SALT30.fn_combine_fieldvaluelist(le.LIC_STATE_values,ri.LIC_STATE_values);
END;
  RETURN ROLLUP( SORT( DISTRIBUTE( infile, HASH(LNPID) ), LNPID, LOCAL ), LEFT.LNPID = RIGHT.LNPID, RollValues(LEFT,RIGHT),LOCAL);
END;
EXPORT RolledEntities(DATASET(match_candidates(ih).layout_candidates) in_data) := FUNCTION
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.LNPID := le.LNPID;
  SELF.NPI_NUMBER_Values := IF ( le.NPI_NUMBER  IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.NPI_NUMBER)}],SALT30.Layout_FieldValueList));
  SELF.CLIA_NUMBER_Values := IF ( le.CLIA_NUMBER  IN SET(s.nulls_CLIA_NUMBER,CLIA_NUMBER),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.CLIA_NUMBER)}],SALT30.Layout_FieldValueList));
  SELF.NCPDP_NUMBER_Values := IF ( le.NCPDP_NUMBER  IN SET(s.nulls_NCPDP_NUMBER,NCPDP_NUMBER),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.NCPDP_NUMBER)}],SALT30.Layout_FieldValueList));
  SELF.MEDICAID_NUMBER_Values := IF ( le.MEDICAID_NUMBER  IN SET(s.nulls_MEDICAID_NUMBER,MEDICAID_NUMBER),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.MEDICAID_NUMBER)}],SALT30.Layout_FieldValueList));
  SELF.DEA_NUMBER_Values := IF ( le.DEA_NUMBER  IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.DEA_NUMBER)}],SALT30.Layout_FieldValueList));
  SELF.MEDICARE_FACILITY_NUMBER_Values := IF ( le.MEDICARE_FACILITY_NUMBER  IN SET(s.nulls_MEDICARE_FACILITY_NUMBER,MEDICARE_FACILITY_NUMBER),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.MEDICARE_FACILITY_NUMBER)}],SALT30.Layout_FieldValueList));
  SELF.TAX_ID_Values := IF ( le.TAX_ID  IN SET(s.nulls_TAX_ID,TAX_ID),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.TAX_ID)}],SALT30.Layout_FieldValueList));
  SELF.VENDOR_ID_Values := IF ( le.VENDOR_ID  IN SET(s.nulls_VENDOR_ID,VENDOR_ID),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.VENDOR_ID)}],SALT30.Layout_FieldValueList));
  SELF.PHONE_Values := IF ( le.PHONE  IN SET(s.nulls_PHONE,PHONE),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.PHONE)}],SALT30.Layout_FieldValueList));
  SELF.FAX_Values := IF ( le.FAX  IN SET(s.nulls_FAX,FAX),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.FAX)}],SALT30.Layout_FieldValueList));
  self.FAC_NAME_Values := IF ( le.CNP_NAME  IN SET(s.nulls_CNP_NAME,CNP_NAME) AND le.CNP_NUMBER  IN SET(s.nulls_CNP_NUMBER,CNP_NUMBER) AND le.CNP_STORE_NUMBER  IN SET(s.nulls_CNP_STORE_NUMBER,CNP_STORE_NUMBER) AND le.CNP_BTYPE  IN SET(s.nulls_CNP_BTYPE,CNP_BTYPE),dataset([],SALT30.Layout_FieldValueList),dataset([{TRIM((SALT30.StrType)le.CNP_NAME) + ' ' + TRIM((SALT30.StrType)le.CNP_NUMBER) + ' ' + TRIM((SALT30.StrType)le.CNP_STORE_NUMBER) + ' ' + TRIM((SALT30.StrType)le.CNP_BTYPE)}],SALT30.Layout_FieldValueList));
  self.ADDRESS_Values := IF ( le.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) AND le.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) AND le.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) AND le.V_CITY_NAME  IN SET(s.nulls_V_CITY_NAME,V_CITY_NAME) AND le.ST  IN SET(s.nulls_ST,ST) AND le.ZIP  IN SET(s.nulls_ZIP,ZIP),dataset([],SALT30.Layout_FieldValueList),dataset([{TRIM((SALT30.StrType)le.PRIM_RANGE) + ' ' + TRIM((SALT30.StrType)le.PRIM_NAME) + ' ' + TRIM((SALT30.StrType)le.SEC_RANGE) + ' ' + TRIM((SALT30.StrType)le.V_CITY_NAME) + ' ' + TRIM((SALT30.StrType)le.ST) + ' ' + TRIM((SALT30.StrType)le.ZIP)}],SALT30.Layout_FieldValueList));
  SELF.C_LIC_NBR_Values := IF ( le.C_LIC_NBR  IN SET(s.nulls_C_LIC_NBR,C_LIC_NBR),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.C_LIC_NBR)}],SALT30.Layout_FieldValueList));
  SELF.FEIN_Values := IF ( le.FEIN  IN SET(s.nulls_FEIN,FEIN),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.FEIN)}],SALT30.Layout_FieldValueList));
  SELF.TAXONOMY_Values := IF ( le.TAXONOMY  IN SET(s.nulls_TAXONOMY,TAXONOMY),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.TAXONOMY)}],SALT30.Layout_FieldValueList));
  SELF.TAXONOMY_CODE_Values := IF ( le.TAXONOMY_CODE  IN SET(s.nulls_TAXONOMY_CODE,TAXONOMY_CODE),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.TAXONOMY_CODE)}],SALT30.Layout_FieldValueList));
  SELF.SRC_Values := DATASET([{TRIM((SALT30.StrType)le.SRC)}],SALT30.Layout_FieldValueList);
  SELF.CNAME_Values := DATASET([{TRIM((SALT30.StrType)le.CNAME)}],SALT30.Layout_FieldValueList);
  SELF.CNP_LOWV_Values := DATASET([{TRIM((SALT30.StrType)le.CNP_LOWV)}],SALT30.Layout_FieldValueList);
  SELF.CNP_TRANSLATED_Values := DATASET([{TRIM((SALT30.StrType)le.CNP_TRANSLATED)}],SALT30.Layout_FieldValueList);
  SELF.CNP_CLASSID_Values := DATASET([{TRIM((SALT30.StrType)le.CNP_CLASSID)}],SALT30.Layout_FieldValueList);
  SELF.ADDRESS_ID_Values := DATASET([{TRIM((SALT30.StrType)le.ADDRESS_ID)}],SALT30.Layout_FieldValueList);
  SELF.ADDRESS_CLASSIFICATION_Values := DATASET([{TRIM((SALT30.StrType)le.ADDRESS_CLASSIFICATION)}],SALT30.Layout_FieldValueList);
  SELF.UPIN_Values := DATASET([{TRIM((SALT30.StrType)le.UPIN)}],SALT30.Layout_FieldValueList);
  SELF.LIC_STATE_Values := DATASET([{TRIM((SALT30.StrType)le.LIC_STATE)}],SALT30.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
Layout_RolledEntity into(ih le) := TRANSFORM
  SELF.LNPID := le.LNPID;
  SELF.NPI_NUMBER_Values := IF ( le.NPI_NUMBER  IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.NPI_NUMBER)}],SALT30.Layout_FieldValueList));
  SELF.CLIA_NUMBER_Values := IF ( le.CLIA_NUMBER  IN SET(s.nulls_CLIA_NUMBER,CLIA_NUMBER),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.CLIA_NUMBER)}],SALT30.Layout_FieldValueList));
  SELF.NCPDP_NUMBER_Values := IF ( le.NCPDP_NUMBER  IN SET(s.nulls_NCPDP_NUMBER,NCPDP_NUMBER),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.NCPDP_NUMBER)}],SALT30.Layout_FieldValueList));
  SELF.MEDICAID_NUMBER_Values := IF ( le.MEDICAID_NUMBER  IN SET(s.nulls_MEDICAID_NUMBER,MEDICAID_NUMBER),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.MEDICAID_NUMBER)}],SALT30.Layout_FieldValueList));
  SELF.DEA_NUMBER_Values := IF ( le.DEA_NUMBER  IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.DEA_NUMBER)}],SALT30.Layout_FieldValueList));
  SELF.MEDICARE_FACILITY_NUMBER_Values := IF ( le.MEDICARE_FACILITY_NUMBER  IN SET(s.nulls_MEDICARE_FACILITY_NUMBER,MEDICARE_FACILITY_NUMBER),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.MEDICARE_FACILITY_NUMBER)}],SALT30.Layout_FieldValueList));
  SELF.TAX_ID_Values := IF ( le.TAX_ID  IN SET(s.nulls_TAX_ID,TAX_ID),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.TAX_ID)}],SALT30.Layout_FieldValueList));
  SELF.VENDOR_ID_Values := IF ( le.VENDOR_ID  IN SET(s.nulls_VENDOR_ID,VENDOR_ID),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.VENDOR_ID)}],SALT30.Layout_FieldValueList));
  SELF.PHONE_Values := IF ( le.PHONE  IN SET(s.nulls_PHONE,PHONE),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.PHONE)}],SALT30.Layout_FieldValueList));
  SELF.FAX_Values := IF ( le.FAX  IN SET(s.nulls_FAX,FAX),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.FAX)}],SALT30.Layout_FieldValueList));
  self.FAC_NAME_Values := IF ( le.CNP_NAME  IN SET(s.nulls_CNP_NAME,CNP_NAME) AND le.CNP_NUMBER  IN SET(s.nulls_CNP_NUMBER,CNP_NUMBER) AND le.CNP_STORE_NUMBER  IN SET(s.nulls_CNP_STORE_NUMBER,CNP_STORE_NUMBER) AND le.CNP_BTYPE  IN SET(s.nulls_CNP_BTYPE,CNP_BTYPE),dataset([],SALT30.Layout_FieldValueList),dataset([{TRIM((SALT30.StrType)le.CNP_NAME) + ' ' + TRIM((SALT30.StrType)le.CNP_NUMBER) + ' ' + TRIM((SALT30.StrType)le.CNP_STORE_NUMBER) + ' ' + TRIM((SALT30.StrType)le.CNP_BTYPE)}],SALT30.Layout_FieldValueList));
  self.ADDRESS_Values := IF ( le.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) AND le.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) AND le.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) AND le.V_CITY_NAME  IN SET(s.nulls_V_CITY_NAME,V_CITY_NAME) AND le.ST  IN SET(s.nulls_ST,ST) AND le.ZIP  IN SET(s.nulls_ZIP,ZIP),dataset([],SALT30.Layout_FieldValueList),dataset([{TRIM((SALT30.StrType)le.PRIM_RANGE) + ' ' + TRIM((SALT30.StrType)le.PRIM_NAME) + ' ' + TRIM((SALT30.StrType)le.SEC_RANGE) + ' ' + TRIM((SALT30.StrType)le.V_CITY_NAME) + ' ' + TRIM((SALT30.StrType)le.ST) + ' ' + TRIM((SALT30.StrType)le.ZIP)}],SALT30.Layout_FieldValueList));
  SELF.C_LIC_NBR_Values := IF ( le.C_LIC_NBR  IN SET(s.nulls_C_LIC_NBR,C_LIC_NBR),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.C_LIC_NBR)}],SALT30.Layout_FieldValueList));
  SELF.FEIN_Values := IF ( le.FEIN  IN SET(s.nulls_FEIN,FEIN),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.FEIN)}],SALT30.Layout_FieldValueList));
  SELF.TAXONOMY_Values := IF ( le.TAXONOMY  IN SET(s.nulls_TAXONOMY,TAXONOMY),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.TAXONOMY)}],SALT30.Layout_FieldValueList));
  SELF.TAXONOMY_CODE_Values := IF ( le.TAXONOMY_CODE  IN SET(s.nulls_TAXONOMY_CODE,TAXONOMY_CODE),DATASET([],SALT30.Layout_FieldValueList),DATASET([{TRIM((SALT30.StrType)le.TAXONOMY_CODE)}],SALT30.Layout_FieldValueList));
  SELF.SRC_Values := DATASET([{TRIM((SALT30.StrType)le.SRC)}],SALT30.Layout_FieldValueList);
  SELF.CNAME_Values := DATASET([{TRIM((SALT30.StrType)le.CNAME)}],SALT30.Layout_FieldValueList);
  SELF.CNP_LOWV_Values := DATASET([{TRIM((SALT30.StrType)le.CNP_LOWV)}],SALT30.Layout_FieldValueList);
  SELF.CNP_TRANSLATED_Values := DATASET([{TRIM((SALT30.StrType)le.CNP_TRANSLATED)}],SALT30.Layout_FieldValueList);
  SELF.CNP_CLASSID_Values := DATASET([{TRIM((SALT30.StrType)le.CNP_CLASSID)}],SALT30.Layout_FieldValueList);
  SELF.ADDRESS_ID_Values := DATASET([{TRIM((SALT30.StrType)le.ADDRESS_ID)}],SALT30.Layout_FieldValueList);
  SELF.ADDRESS_CLASSIFICATION_Values := DATASET([{TRIM((SALT30.StrType)le.ADDRESS_CLASSIFICATION)}],SALT30.Layout_FieldValueList);
  SELF.UPIN_Values := DATASET([{TRIM((SALT30.StrType)le.UPIN)}],SALT30.Layout_FieldValueList);
  SELF.LIC_STATE_Values := DATASET([{TRIM((SALT30.StrType)le.LIC_STATE)}],SALT30.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(ih,into(left));
EXPORT InFile_Rolled := RollEntities(AsFieldValues);
EXPORT RemoveProps(DATASET(match_candidates(ih).layout_candidates) im) := FUNCTION
  im rem(im le) := TRANSFORM
    self.NPI_NUMBER := if ( le.NPI_NUMBER_prop>0, (TYPEOF(le.NPI_NUMBER))'', le.NPI_NUMBER ); // Blank if propogated
    self.NPI_NUMBER_isnull := le.NPI_NUMBER_prop>0 OR le.NPI_NUMBER_isnull;
    self.NPI_NUMBER_prop := 0; // Avoid reducing score later
    self.CLIA_NUMBER := if ( le.CLIA_NUMBER_prop>0, (TYPEOF(le.CLIA_NUMBER))'', le.CLIA_NUMBER ); // Blank if propogated
    self.CLIA_NUMBER_isnull := le.CLIA_NUMBER_prop>0 OR le.CLIA_NUMBER_isnull;
    self.CLIA_NUMBER_prop := 0; // Avoid reducing score later
    self.NCPDP_NUMBER := if ( le.NCPDP_NUMBER_prop>0, (TYPEOF(le.NCPDP_NUMBER))'', le.NCPDP_NUMBER ); // Blank if propogated
    self.NCPDP_NUMBER_isnull := le.NCPDP_NUMBER_prop>0 OR le.NCPDP_NUMBER_isnull;
    self.NCPDP_NUMBER_prop := 0; // Avoid reducing score later
    self.MEDICAID_NUMBER := if ( le.MEDICAID_NUMBER_prop>0, (TYPEOF(le.MEDICAID_NUMBER))'', le.MEDICAID_NUMBER ); // Blank if propogated
    self.MEDICAID_NUMBER_isnull := le.MEDICAID_NUMBER_prop>0 OR le.MEDICAID_NUMBER_isnull;
    self.MEDICAID_NUMBER_prop := 0; // Avoid reducing score later
    self.DEA_NUMBER := if ( le.DEA_NUMBER_prop>0, (TYPEOF(le.DEA_NUMBER))'', le.DEA_NUMBER ); // Blank if propogated
    self.DEA_NUMBER_isnull := le.DEA_NUMBER_prop>0 OR le.DEA_NUMBER_isnull;
    self.DEA_NUMBER_prop := 0; // Avoid reducing score later
    self.CNP_STORE_NUMBER := if ( le.CNP_STORE_NUMBER_prop>0, (TYPEOF(le.CNP_STORE_NUMBER))'', le.CNP_STORE_NUMBER ); // Blank if propogated
    self.CNP_STORE_NUMBER_isnull := le.CNP_STORE_NUMBER_prop>0 OR le.CNP_STORE_NUMBER_isnull;
    self.CNP_STORE_NUMBER_prop := 0; // Avoid reducing score later
    self.FAC_NAME := if ( le.FAC_NAME_prop>0, 0, le.FAC_NAME ); // Blank if propogated
    self.FAC_NAME_isnull := true; // Flag as null to scoring
    self.FAC_NAME_prop := 0; // Avoid reducing score later
    self.ADDR1 := if ( le.ADDR1_prop>0, 0, le.ADDR1 ); // Blank if propogated
    self.ADDR1_isnull := true; // Flag as null to scoring
    self.ADDR1_prop := 0; // Avoid reducing score later
    self.ADDRESS := if ( le.ADDRESS_prop>0, 0, le.ADDRESS ); // Blank if propogated
    self.ADDRESS_isnull := true; // Flag as null to scoring
    self.ADDRESS_prop := 0; // Avoid reducing score later
    self.FEIN := if ( le.FEIN_prop>0, (TYPEOF(le.FEIN))'', le.FEIN ); // Blank if propogated
    self.FEIN_isnull := le.FEIN_prop>0 OR le.FEIN_isnull;
    self.FEIN_prop := 0; // Avoid reducing score later
    self.CNP_NUMBER := if ( le.CNP_NUMBER_prop>0, (TYPEOF(le.CNP_NUMBER))'', le.CNP_NUMBER ); // Blank if propogated
    self.CNP_NUMBER_isnull := le.CNP_NUMBER_prop>0 OR le.CNP_NUMBER_isnull;
    self.CNP_NUMBER_prop := 0; // Avoid reducing score later
    self.PRIM_NAME := le.PRIM_NAME[1..LENGTH(TRIM(le.PRIM_NAME))-le.PRIM_NAME_prop]; // Clip propogated chars
    self.PRIM_NAME_isnull := self.PRIM_NAME='' OR le.PRIM_NAME_isnull;
    self.PRIM_NAME_prop := 0; // Avoid reducing score later
    self.PRIM_RANGE := if ( le.PRIM_RANGE_prop>0, (TYPEOF(le.PRIM_RANGE))'', le.PRIM_RANGE ); // Blank if propogated
    self.PRIM_RANGE_isnull := le.PRIM_RANGE_prop>0 OR le.PRIM_RANGE_isnull;
    self.PRIM_RANGE_prop := 0; // Avoid reducing score later
    self.SEC_RANGE := if ( le.SEC_RANGE_prop>0, (TYPEOF(le.SEC_RANGE))'', le.SEC_RANGE ); // Blank if propogated
    self.SEC_RANGE_isnull := le.SEC_RANGE_prop>0 OR le.SEC_RANGE_isnull;
    self.SEC_RANGE_prop := 0; // Avoid reducing score later
    self.TAXONOMY := if ( le.TAXONOMY_prop>0, (TYPEOF(le.TAXONOMY))'', le.TAXONOMY ); // Blank if propogated
    self.TAXONOMY_isnull := le.TAXONOMY_prop>0 OR le.TAXONOMY_isnull;
    self.TAXONOMY_prop := 0; // Avoid reducing score later
    self.CNP_BTYPE := if ( le.CNP_BTYPE_prop>0, (TYPEOF(le.CNP_BTYPE))'', le.CNP_BTYPE ); // Blank if propogated
    self.CNP_BTYPE_isnull := le.CNP_BTYPE_prop>0 OR le.CNP_BTYPE_isnull;
    self.CNP_BTYPE_prop := 0; // Avoid reducing score later
    self.TAXONOMY_CODE := if ( le.TAXONOMY_CODE_prop>0, (TYPEOF(le.TAXONOMY_CODE))'', le.TAXONOMY_CODE ); // Blank if propogated
    self.TAXONOMY_CODE_isnull := le.TAXONOMY_CODE_prop>0 OR le.TAXONOMY_CODE_isnull;
    self.TAXONOMY_CODE_prop := 0; // Avoid reducing score later
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
  UNSIGNED1 NPI_NUMBER_size := 0;
  UNSIGNED1 CLIA_NUMBER_size := 0;
  UNSIGNED1 NCPDP_NUMBER_size := 0;
  UNSIGNED1 MEDICAID_NUMBER_size := 0;
  UNSIGNED1 DEA_NUMBER_size := 0;
  UNSIGNED1 MEDICARE_FACILITY_NUMBER_size := 0;
  UNSIGNED1 TAX_ID_size := 0;
  UNSIGNED1 VENDOR_ID_size := 0;
  UNSIGNED1 PHONE_size := 0;
  UNSIGNED1 FAX_size := 0;
  UNSIGNED1 FAC_NAME_size := 0;
  UNSIGNED1 ADDRESS_size := 0;
  UNSIGNED1 C_LIC_NBR_size := 0;
  UNSIGNED1 FEIN_size := 0;
  UNSIGNED1 TAXONOMY_size := 0;
  UNSIGNED1 TAXONOMY_CODE_size := 0;
END;
t0 := TABLE(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := TRANSFORM
  SELF.NPI_NUMBER_size := SALT30.Fn_SwitchSpec(s.NPI_NUMBER_switch,count(le.NPI_NUMBER_values));
  SELF.CLIA_NUMBER_size := SALT30.Fn_SwitchSpec(s.CLIA_NUMBER_switch,count(le.CLIA_NUMBER_values));
  SELF.NCPDP_NUMBER_size := SALT30.Fn_SwitchSpec(s.NCPDP_NUMBER_switch,count(le.NCPDP_NUMBER_values));
  SELF.MEDICAID_NUMBER_size := SALT30.Fn_SwitchSpec(s.MEDICAID_NUMBER_switch,count(le.MEDICAID_NUMBER_values));
  SELF.DEA_NUMBER_size := SALT30.Fn_SwitchSpec(s.DEA_NUMBER_switch,count(le.DEA_NUMBER_values));
  SELF.MEDICARE_FACILITY_NUMBER_size := SALT30.Fn_SwitchSpec(s.MEDICARE_FACILITY_NUMBER_switch,count(le.MEDICARE_FACILITY_NUMBER_values));
  SELF.TAX_ID_size := SALT30.Fn_SwitchSpec(s.TAX_ID_switch,count(le.TAX_ID_values));
  SELF.VENDOR_ID_size := SALT30.Fn_SwitchSpec(s.VENDOR_ID_switch,count(le.VENDOR_ID_values));
  SELF.PHONE_size := SALT30.Fn_SwitchSpec(s.PHONE_switch,count(le.PHONE_values));
  SELF.FAX_size := SALT30.Fn_SwitchSpec(s.FAX_switch,count(le.FAX_values));
  SELF.FAC_NAME_size := SALT30.Fn_SwitchSpec(s.FAC_NAME_switch,count(le.FAC_NAME_values));
  SELF.ADDRESS_size := SALT30.Fn_SwitchSpec(s.ADDRESS_switch,count(le.ADDRESS_values));
  SELF.C_LIC_NBR_size := SALT30.Fn_SwitchSpec(s.C_LIC_NBR_switch,count(le.C_LIC_NBR_values));
  SELF.FEIN_size := SALT30.Fn_SwitchSpec(s.FEIN_switch,count(le.FEIN_values));
  SELF.TAXONOMY_size := SALT30.Fn_SwitchSpec(s.TAXONOMY_switch,count(le.TAXONOMY_values));
  SELF.TAXONOMY_CODE_size := SALT30.Fn_SwitchSpec(s.TAXONOMY_CODE_switch,count(le.TAXONOMY_CODE_values));
  SELF := le;
END;  t := PROJECT(t0,NoteSize(LEFT));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  UNSIGNED2 Size := t.NPI_NUMBER_size+t.CLIA_NUMBER_size+t.NCPDP_NUMBER_size+t.MEDICAID_NUMBER_size+t.DEA_NUMBER_size+t.MEDICARE_FACILITY_NUMBER_size+t.TAX_ID_size+t.VENDOR_ID_size+t.PHONE_size+t.FAX_size+t.FAC_NAME_size+t.ADDRESS_size+t.C_LIC_NBR_size+t.FEIN_size+t.TAXONOMY_size+t.TAXONOMY_CODE_size;
END;
EXPORT Chubbies := TABLE(t,Layout_Chubbies);
END;

