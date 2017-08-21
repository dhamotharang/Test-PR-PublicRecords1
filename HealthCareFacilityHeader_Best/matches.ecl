// Begin code to perform the matching itself
IMPORT SALT30,ut,std;
EXPORT matches(DATASET(layout_HealthFacility) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.LNPID1 := le.LNPID;
  SELF.LNPID2 := ri.LNPID;
  SELF.RID1 := le.RID;
  SELF.RID2 := ri.RID;
  SELF.DateOverlap := SALT30.fn_ComputeDateOverlap(((UNSIGNED)le.DT_FIRST_SEEN)*100,((UNSIGNED)le.DT_LAST_SEEN)*100,((UNSIGNED)ri.DT_FIRST_SEEN)*100,((UNSIGNED)ri.DT_LAST_SEEN)*100);
  INTEGER2 NPI_NUMBER_score_temp := MAP(
                        le.NPI_NUMBER_isnull OR ri.NPI_NUMBER_isnull => 0,
                        le.NPI_NUMBER = ri.NPI_NUMBER  => le.NPI_NUMBER_weight100,
                        SALT30.Fn_Fail_Scale(le.NPI_NUMBER_weight100,s.NPI_NUMBER_switch));
  INTEGER2 CLIA_NUMBER_score_temp := MAP(
                        le.CLIA_NUMBER_isnull OR ri.CLIA_NUMBER_isnull => 0,
                        le.CLIA_NUMBER = ri.CLIA_NUMBER  => le.CLIA_NUMBER_weight100,
                        SALT30.Fn_Fail_Scale(le.CLIA_NUMBER_weight100,s.CLIA_NUMBER_switch));
  INTEGER2 NCPDP_NUMBER_score_temp := MAP(
                        le.NCPDP_NUMBER_isnull OR ri.NCPDP_NUMBER_isnull => 0,
                        le.NCPDP_NUMBER = ri.NCPDP_NUMBER  => le.NCPDP_NUMBER_weight100,
                        SALT30.Fn_Fail_Scale(le.NCPDP_NUMBER_weight100,s.NCPDP_NUMBER_switch));
  INTEGER2 MEDICAID_NUMBER_score := MAP(
                        le.MEDICAID_NUMBER_isnull OR ri.MEDICAID_NUMBER_isnull => 0,
                        le.MEDICAID_NUMBER = ri.MEDICAID_NUMBER  => le.MEDICAID_NUMBER_weight100,
                        SALT30.Fn_Fail_Scale(le.MEDICAID_NUMBER_weight100,s.MEDICAID_NUMBER_switch));
  INTEGER2 DEA_NUMBER_score_temp := MAP(
                        le.DEA_NUMBER_isnull OR ri.DEA_NUMBER_isnull => 0,
                        le.DEA_NUMBER = ri.DEA_NUMBER  => le.DEA_NUMBER_weight100,
                        SALT30.Fn_Fail_Scale(le.DEA_NUMBER_weight100,s.DEA_NUMBER_switch));
  INTEGER2 MEDICARE_FACILITY_NUMBER_score := MAP(
                        le.MEDICARE_FACILITY_NUMBER_isnull OR ri.MEDICARE_FACILITY_NUMBER_isnull => 0,
                        le.MEDICARE_FACILITY_NUMBER = ri.MEDICARE_FACILITY_NUMBER  => le.MEDICARE_FACILITY_NUMBER_weight100,
                        SALT30.Fn_Fail_Scale(le.MEDICARE_FACILITY_NUMBER_weight100,s.MEDICARE_FACILITY_NUMBER_switch));
  INTEGER2 TAX_ID_score_temp := MAP(
                        le.TAX_ID_isnull OR ri.TAX_ID_isnull => 0,
                        le.TAX_ID = ri.TAX_ID  => le.TAX_ID_weight100,
                        SALT30.Fn_Fail_Scale(le.TAX_ID_weight100,s.TAX_ID_switch));
  INTEGER2 VENDOR_ID_score_temp := MAP(
                        le.VENDOR_ID_isnull OR ri.VENDOR_ID_isnull => 0,
                        le.SRC <> ri.SRC => 0, // Only valid if the context variable is equal
                        le.VENDOR_ID = ri.VENDOR_ID  => le.VENDOR_ID_weight100,
                        0 /* switch0 */);
  INTEGER2 FAX_score := MAP(
                        le.FAX_isnull OR ri.FAX_isnull => 0,
                        le.FAX = ri.FAX  => le.FAX_weight100,
                        0 /* switch0 */);
  INTEGER2 PHONE_score := MAP(
                        le.PHONE_isnull OR ri.PHONE_isnull => 0,
                        le.PHONE = ri.PHONE  => le.PHONE_weight100,
                        0 /* switch0 */);
  REAL FAC_NAME_score_scale := ( le.FAC_NAME_weight100 + ri.FAC_NAME_weight100 ) / (le.CNP_NAME_weight100 + ri.CNP_NAME_weight100 + le.CNP_NUMBER_weight100 + ri.CNP_NUMBER_weight100 + le.CNP_STORE_NUMBER_weight100 + ri.CNP_STORE_NUMBER_weight100 + le.CNP_BTYPE_weight100 + ri.CNP_BTYPE_weight100); // Scaling factor for this concept
  INTEGER2 FAC_NAME_score_pre := MAP( (le.FAC_NAME_isnull OR le.CNP_NAME_isnull AND le.CNP_NUMBER_isnull AND le.CNP_STORE_NUMBER_isnull AND le.CNP_BTYPE_isnull) OR (ri.FAC_NAME_isnull OR ri.CNP_NAME_isnull AND ri.CNP_NUMBER_isnull AND ri.CNP_STORE_NUMBER_isnull AND ri.CNP_BTYPE_isnull) => 0,
                        le.FAC_NAME = ri.FAC_NAME  => le.FAC_NAME_weight100,
                        SALT30.fn_concept_wordbag_EditN.Match4((SALT30.StrType)ri.CNP_NAME,ri.CNP_NAME_FAC_NAME_weight100,true,Config.CNP_NAME_Force,true,1,(SALT30.StrType)ri.CNP_NUMBER,ri.CNP_NUMBER_FAC_NAME_weight100,true,Config.CNP_NUMBER_Force,false,0,(SALT30.StrType)ri.CNP_STORE_NUMBER,ri.CNP_STORE_NUMBER_FAC_NAME_weight100,true,Config.CNP_STORE_NUMBER_Force,false,0,(SALT30.StrType)ri.CNP_BTYPE,ri.CNP_BTYPE_FAC_NAME_weight100,true,Config.CNP_BTYPE_Force,false,0,(SALT30.StrType)le.CNP_NAME,le.CNP_NAME_FAC_NAME_weight100,(SALT30.StrType)le.CNP_NUMBER,le.CNP_NUMBER_FAC_NAME_weight100,(SALT30.StrType)le.CNP_STORE_NUMBER,le.CNP_STORE_NUMBER_FAC_NAME_weight100,(SALT30.StrType)le.CNP_BTYPE,le.CNP_BTYPE_FAC_NAME_weight100)*IF(FAC_NAME_score_scale=0,1,FAC_NAME_score_scale));
  REAL ADDRESS_score_scale := ( le.ADDRESS_weight100 + ri.ADDRESS_weight100 ) / (le.ADDR1_weight100 + ri.ADDR1_weight100 + le.LOCALE_weight100 + ri.LOCALE_weight100); // Scaling factor for this concept
  INTEGER2 ADDRESS_score_pre := MAP( (le.ADDRESS_isnull OR (le.ADDR1_isnull OR le.PRIM_RANGE_isnull AND le.PRIM_NAME_isnull AND le.SEC_RANGE_isnull) AND (le.LOCALE_isnull OR le.V_CITY_NAME_isnull AND le.ST_isnull AND le.ZIP_isnull)) OR (ri.ADDRESS_isnull OR (ri.ADDR1_isnull OR ri.PRIM_RANGE_isnull AND ri.PRIM_NAME_isnull AND ri.SEC_RANGE_isnull) AND (ri.LOCALE_isnull OR ri.V_CITY_NAME_isnull AND ri.ST_isnull AND ri.ZIP_isnull)) OR le.ADDRESS_weight100 = 0 => 0,
                        le.ADDRESS = ri.ADDRESS  => le.ADDRESS_weight100,
                        0);
  INTEGER2 C_LIC_NBR_score_temp := MAP(
                        le.C_LIC_NBR_isnull OR ri.C_LIC_NBR_isnull => 0,
                        le.LIC_STATE <> ri.LIC_STATE => 0, // Only valid if the context variable is equal
                        le.C_LIC_NBR = ri.C_LIC_NBR  => le.C_LIC_NBR_weight100,
                        SALT30.WithinEditN(le.C_LIC_NBR,ri.C_LIC_NBR,1,0) => SALT30.fn_fuzzy_specificity(le.C_LIC_NBR_weight100,le.C_LIC_NBR_cnt, le.C_LIC_NBR_e1_cnt,ri.C_LIC_NBR_weight100,ri.C_LIC_NBR_cnt,ri.C_LIC_NBR_e1_cnt),
                        SALT30.Fn_Fail_Scale(le.C_LIC_NBR_weight100,s.C_LIC_NBR_switch));
  INTEGER2 FEIN_score_temp := MAP(
                        le.FEIN_isnull OR ri.FEIN_isnull => 0,
                        le.FEIN = ri.FEIN  => le.FEIN_weight100,
                        SALT30.Fn_Fail_Scale(le.FEIN_weight100,s.FEIN_switch));
  INTEGER2 CNP_NAME_score_temp := MAP(
                        le.CNP_NAME_isnull OR ri.CNP_NAME_isnull OR le.CNP_NAME_weight100 = 0 => 0,
                        FAC_NAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.CNP_NAME = ri.CNP_NAME OR SALT30.HyphenMatch(le.CNP_NAME,ri.CNP_NAME,1)<=1  => MIN(le.CNP_NAME_weight100,ri.CNP_NAME_weight100),
                        SALT30.MatchBagOfWords(le.CNP_NAME,ri.CNP_NAME,3407383,0))*IF(FAC_NAME_score_scale=0,1,FAC_NAME_score_scale);
  INTEGER2 CNP_NUMBER_score_temp := MAP(
                        le.CNP_NUMBER_isnull OR ri.CNP_NUMBER_isnull => 0,
                        FAC_NAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.CNP_NUMBER = ri.CNP_NUMBER  => le.CNP_NUMBER_weight100,
                        SALT30.Fn_Fail_Scale(le.CNP_NUMBER_weight100,s.CNP_NUMBER_switch))*IF(FAC_NAME_score_scale=0,1,FAC_NAME_score_scale);
  REAL LOCALE_score_scale := ( le.LOCALE_weight100 + ri.LOCALE_weight100 ) / (le.V_CITY_NAME_weight100 + ri.V_CITY_NAME_weight100 + le.ST_weight100 + ri.ST_weight100 + le.ZIP_weight100 + ri.ZIP_weight100); // Scaling factor for this concept
  INTEGER2 LOCALE_score_pre := MAP( (le.LOCALE_isnull OR le.V_CITY_NAME_isnull AND le.ST_isnull AND le.ZIP_isnull) OR (ri.LOCALE_isnull OR ri.V_CITY_NAME_isnull AND ri.ST_isnull AND ri.ZIP_isnull) OR le.LOCALE_weight100 = 0 => 0,
                        ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.LOCALE = ri.LOCALE  => le.LOCALE_weight100,
                        0)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 V_CITY_NAME_score := MAP(
                        le.V_CITY_NAME_isnull OR ri.V_CITY_NAME_isnull => 0,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.ST <> ri.ST => 0, // Only valid if the context variable is equal
                        le.V_CITY_NAME = ri.V_CITY_NAME  => le.V_CITY_NAME_weight100,
                        0 /* switch0 */)*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 TAXONOMY_score := MAP(
                        le.TAXONOMY_isnull OR ri.TAXONOMY_isnull => 0,
                        le.TAXONOMY = ri.TAXONOMY  => le.TAXONOMY_weight100,
                        0 /* switch0 */);
  INTEGER2 CNP_BTYPE_score_temp := MAP(
                        le.CNP_BTYPE_isnull OR ri.CNP_BTYPE_isnull => 0,
                        FAC_NAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.CNP_BTYPE = ri.CNP_BTYPE  => le.CNP_BTYPE_weight100,
                        SALT30.Fn_Fail_Scale(le.CNP_BTYPE_weight100,s.CNP_BTYPE_switch))*IF(FAC_NAME_score_scale=0,1,FAC_NAME_score_scale);
  INTEGER2 TAXONOMY_CODE_score_temp := MAP(
                        le.TAXONOMY_CODE_isnull OR ri.TAXONOMY_CODE_isnull => 0,
                        le.TAXONOMY_CODE = ri.TAXONOMY_CODE  => le.TAXONOMY_CODE_weight100,
                        SALT30.Fn_Fail_Scale(le.TAXONOMY_CODE_weight100,s.TAXONOMY_CODE_switch));
  INTEGER2 ST_score_temp := MAP(
                        le.ST_isnull OR ri.ST_isnull OR le.ST_weight100 = 0 => 0,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.ST = ri.ST  => le.ST_weight100,
                        0 /* switch0 */)*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 NPI_NUMBER_score := IF ( NPI_NUMBER_score_temp >= Config.NPI_NUMBER_Force * 100, NPI_NUMBER_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 CLIA_NUMBER_score := IF ( CLIA_NUMBER_score_temp >= Config.CLIA_NUMBER_Force * 100, CLIA_NUMBER_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 NCPDP_NUMBER_score := IF ( NCPDP_NUMBER_score_temp >= Config.NCPDP_NUMBER_Force * 100, NCPDP_NUMBER_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 DEA_NUMBER_score := IF ( DEA_NUMBER_score_temp >= Config.DEA_NUMBER_Force * 100, DEA_NUMBER_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 TAX_ID_score := TAX_ID_score_temp*0.25; 
  INTEGER2 VENDOR_ID_score := VENDOR_ID_score_temp*0.10; 
  INTEGER2 CNP_STORE_NUMBER_score_temp := MAP(
                        le.CNP_STORE_NUMBER_isnull OR ri.CNP_STORE_NUMBER_isnull => 0,
                        FAC_NAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.CNP_STORE_NUMBER = ri.CNP_STORE_NUMBER  => le.CNP_STORE_NUMBER_weight100,
                        SALT30.Fn_Fail_Scale(le.CNP_STORE_NUMBER_weight100,s.CNP_STORE_NUMBER_switch))*IF(FAC_NAME_score_scale=0,1,FAC_NAME_score_scale);
  REAL ADDR1_score_scale := ( le.ADDR1_weight100 + ri.ADDR1_weight100 ) / (le.PRIM_RANGE_weight100 + ri.PRIM_RANGE_weight100 + le.PRIM_NAME_weight100 + ri.PRIM_NAME_weight100 + le.SEC_RANGE_weight100 + ri.SEC_RANGE_weight100); // Scaling factor for this concept
  INTEGER2 ADDR1_score_pre := MAP( (le.ADDR1_isnull OR le.PRIM_RANGE_isnull AND le.PRIM_NAME_isnull AND le.SEC_RANGE_isnull) OR (ri.ADDR1_isnull OR ri.PRIM_RANGE_isnull AND ri.PRIM_NAME_isnull AND ri.SEC_RANGE_isnull) => 0,
                        ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.ADDR1 = ri.ADDR1  => le.ADDR1_weight100,
                        SALT30.fn_concept_wordbag_EditN.Match3((SALT30.StrType)ri.PRIM_RANGE,ri.PRIM_RANGE_ADDR1_weight100,true,Config.PRIM_RANGE_Force,false,1,(SALT30.StrType)ri.PRIM_NAME,ri.PRIM_NAME_ADDR1_weight100,true,Config.PRIM_NAME_Force,true,1,(SALT30.StrType)ri.SEC_RANGE,ri.SEC_RANGE_ADDR1_weight100,true,Config.SEC_RANGE_Force,false,1,(SALT30.StrType)le.PRIM_RANGE,le.PRIM_RANGE_ADDR1_weight100,(SALT30.StrType)le.PRIM_NAME,le.PRIM_NAME_ADDR1_weight100,(SALT30.StrType)le.SEC_RANGE,le.SEC_RANGE_ADDR1_weight100)*IF(ADDR1_score_scale=0,1,ADDR1_score_scale))*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 C_LIC_NBR_score := C_LIC_NBR_score_temp*0.75; 
  INTEGER2 FEIN_score := IF ( FEIN_score_temp >= Config.FEIN_Force * 100 OR ( NPI_NUMBER_score > Config.FEIN_OR1_NPI_NUMBER_Force*100), FEIN_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 CNP_NAME_score := IF ( CNP_NAME_score_temp > Config.CNP_NAME_Force * 100 OR ( FEIN_score > Config.CNP_NAME_OR1_FEIN_Force*100) OR ( NPI_NUMBER_score > Config.CNP_NAME_OR2_NPI_NUMBER_Force*100) OR ( C_LIC_NBR_score > Config.CNP_NAME_OR3_C_LIC_NBR_Force*100) OR ( CLIA_NUMBER_score > Config.CNP_NAME_OR4_CLIA_NUMBER_Force*100) OR ( MEDICARE_FACILITY_NUMBER_score > Config.CNP_NAME_OR5_MEDICARE_FACILITY_NUMBER_Force*100) OR ( NCPDP_NUMBER_score > Config.CNP_NAME_OR6_NCPDP_NUMBER_Force*100) OR FAC_NAME_score_pre > 0, CNP_NAME_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 CNP_NUMBER_score := IF ( CNP_NUMBER_score_temp >= Config.CNP_NUMBER_Force * 100 OR ( FEIN_score > Config.CNP_NUMBER_OR1_FEIN_Force*100) OR ( NPI_NUMBER_score > Config.CNP_NUMBER_OR2_NPI_NUMBER_Force*100) OR ( CLIA_NUMBER_score > Config.CNP_NUMBER_OR3_CLIA_NUMBER_Force*100) OR ( C_LIC_NBR_score > Config.CNP_NUMBER_OR4_C_LIC_NBR_Force*100) OR ( MEDICARE_FACILITY_NUMBER_score > Config.CNP_NUMBER_OR5_MEDICARE_FACILITY_NUMBER_Force*100) OR ( NCPDP_NUMBER_score > Config.CNP_NUMBER_OR6_NCPDP_NUMBER_Force*100), CNP_NUMBER_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 PRIM_NAME_score_temp := MAP(
                        le.PRIM_NAME_isnull OR ri.PRIM_NAME_isnull OR le.PRIM_NAME_weight100 = 0 => 0,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.PRIM_NAME = ri.PRIM_NAME  => le.PRIM_NAME_weight100,
                        SALT30.MatchBagOfWords(le.PRIM_NAME,ri.PRIM_NAME,32019,1))*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 ZIP_score := MAP(
                        le.ZIP_isnull OR ri.ZIP_isnull => 0,
                        LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.ZIP = ri.ZIP  => le.ZIP_weight100,
                        0 /* switch0 */)*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 PRIM_RANGE_score_temp := MAP(
                        le.PRIM_RANGE_isnull OR ri.PRIM_RANGE_isnull OR le.PRIM_RANGE_weight100 = 0 => 0,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.PRIM_RANGE = ri.PRIM_RANGE  => le.PRIM_RANGE_weight100,
                        SALT30.WithinEditN(le.PRIM_RANGE,ri.PRIM_RANGE,1,0) => SALT30.fn_fuzzy_specificity(le.PRIM_RANGE_weight100,le.PRIM_RANGE_cnt, le.PRIM_RANGE_e1_cnt,ri.PRIM_RANGE_weight100,ri.PRIM_RANGE_cnt,ri.PRIM_RANGE_e1_cnt),
                        0 /* switch0 */)*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 SEC_RANGE_score_temp := MAP(
                        le.SEC_RANGE_isnull OR ri.SEC_RANGE_isnull => 0,
                        ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.SEC_RANGE = ri.SEC_RANGE OR SALT30.HyphenMatch(le.SEC_RANGE,ri.SEC_RANGE,1)<=2  => MIN(le.SEC_RANGE_weight100,ri.SEC_RANGE_weight100),
                        SALT30.WithinEditN(le.SEC_RANGE,ri.SEC_RANGE,1,0) => SALT30.fn_fuzzy_specificity(le.SEC_RANGE_weight100,le.SEC_RANGE_cnt, le.SEC_RANGE_e1_cnt,ri.SEC_RANGE_weight100,ri.SEC_RANGE_cnt,ri.SEC_RANGE_e1_cnt),
                        0 /* switch0 */)*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale);
  INTEGER2 CNP_BTYPE_score := IF ( CNP_BTYPE_score_temp >= Config.CNP_BTYPE_Force * 100 OR ( FEIN_score > Config.CNP_BTYPE_OR1_FEIN_Force*100) OR ( NPI_NUMBER_score > Config.CNP_BTYPE_OR2_NPI_NUMBER_Force*100) OR ( C_LIC_NBR_score > Config.CNP_BTYPE_OR3_C_LIC_NBR_Force*100) OR ( CLIA_NUMBER_score > Config.CNP_BTYPE_OR4_CLIA_NUMBER_Force*100) OR ( MEDICARE_FACILITY_NUMBER_score > Config.CNP_BTYPE_OR5_MEDICARE_FACILITY_NUMBER_Force*100) OR ( NCPDP_NUMBER_score > Config.CNP_BTYPE_OR6_NCPDP_NUMBER_Force*100), CNP_BTYPE_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 TAXONOMY_CODE_score_unweighted := IF ( TAXONOMY_CODE_score_temp >= Config.TAXONOMY_CODE_Force * 100 OR ( NPI_NUMBER_score > Config.TAXONOMY_CODE_OR1_NPI_NUMBER_Force*100), TAXONOMY_CODE_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 TAXONOMY_CODE_score := TAXONOMY_CODE_score_unweighted*0.25; 
  INTEGER2 ST_score := IF ( ST_score_temp > Config.ST_Force * 100 OR ( NPI_NUMBER_score > Config.ST_OR1_NPI_NUMBER_Force*100) OR ( NCPDP_NUMBER_score > Config.ST_OR2_NCPDP_NUMBER_Force*100) OR LOCALE_score_pre > 0 OR ADDRESS_score_pre > 0, ST_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 CNP_STORE_NUMBER_score := IF ( CNP_STORE_NUMBER_score_temp >= Config.CNP_STORE_NUMBER_Force * 100 OR ( FEIN_score > Config.CNP_STORE_NUMBER_OR1_FEIN_Force*100) OR ( NPI_NUMBER_score > Config.CNP_STORE_NUMBER_OR2_NPI_NUMBER_Force*100) OR ( C_LIC_NBR_score > Config.CNP_STORE_NUMBER_OR3_C_LIC_NBR_Force*100) OR ( CLIA_NUMBER_score > Config.CNP_STORE_NUMBER_OR4_CLIA_NUMBER_Force*100) OR ( MEDICARE_FACILITY_NUMBER_score > Config.CNP_STORE_NUMBER_OR5_MEDICARE_FACILITY_NUMBER_Force*100) OR ( NCPDP_NUMBER_score > Config.CNP_STORE_NUMBER_OR6_NCPDP_NUMBER_Force*100), CNP_STORE_NUMBER_score_temp, SKIP ); // Enforce FORCE parameter
// Compute the score for the concept FAC_NAME
  INTEGER2 FAC_NAME_score_ext := SALT30.ClipScore(MAX(FAC_NAME_score_pre,0) + CNP_NAME_score + CNP_NUMBER_score + CNP_STORE_NUMBER_score + CNP_BTYPE_score);// Score in surrounding context
  INTEGER2 FAC_NAME_score_res := MAX(0,FAC_NAME_score_pre); // At least nothing
  INTEGER2 FAC_NAME_score := FAC_NAME_score_res;
  INTEGER2 PRIM_NAME_score := IF ( PRIM_NAME_score_temp > Config.PRIM_NAME_Force * 100 OR ( NPI_NUMBER_score > Config.PRIM_NAME_OR1_NPI_NUMBER_Force*100) OR ( NCPDP_NUMBER_score > Config.PRIM_NAME_OR2_NCPDP_NUMBER_Force*100) OR ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0, PRIM_NAME_score_temp, SKIP ); // Enforce FORCE parameter
// Compute the score for the concept LOCALE
  INTEGER2 LOCALE_score_ext := SALT30.ClipScore(MAX(LOCALE_score_pre,0) + V_CITY_NAME_score + ST_score + ZIP_score + MAX(ADDRESS_score_pre,0));// Score in surrounding context
  INTEGER2 LOCALE_score_res := MAX(0,LOCALE_score_pre); // At least nothing
  INTEGER2 LOCALE_score := IF ( LOCALE_score_ext > -200 OR ( NPI_NUMBER_score > Config.LOCALE_OR1_NPI_NUMBER_Force*100),LOCALE_score_res,SKIP);
  INTEGER2 PRIM_RANGE_score := IF ( PRIM_RANGE_score_temp > Config.PRIM_RANGE_Force * 100 OR ( NPI_NUMBER_score > Config.PRIM_RANGE_OR1_NPI_NUMBER_Force*100) OR ( NCPDP_NUMBER_score > Config.PRIM_RANGE_OR2_NCPDP_NUMBER_Force*100) OR ADDR1_score_pre > 0 OR ADDRESS_score_pre > 0, PRIM_RANGE_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 SEC_RANGE_score := IF ( SEC_RANGE_score_temp >= Config.SEC_RANGE_Force * 100 OR ( NPI_NUMBER_score > Config.SEC_RANGE_OR1_NPI_NUMBER_Force*100) OR ( NCPDP_NUMBER_score > Config.SEC_RANGE_OR2_NCPDP_NUMBER_Force*100), SEC_RANGE_score_temp, SKIP ); // Enforce FORCE parameter
// Compute the score for the concept ADDR1
  INTEGER2 ADDR1_score_ext := SALT30.ClipScore(MAX(ADDR1_score_pre,0) + PRIM_RANGE_score + PRIM_NAME_score + SEC_RANGE_score + MAX(ADDRESS_score_pre,0));// Score in surrounding context
  INTEGER2 ADDR1_score_res := MAX(0,ADDR1_score_pre); // At least nothing
  INTEGER2 ADDR1_score := ADDR1_score_res;
// Compute the score for the concept ADDRESS
  INTEGER2 ADDRESS_score_ext := SALT30.ClipScore(MAX(ADDRESS_score_pre,0)+ ADDR1_score + PRIM_RANGE_score + PRIM_NAME_score + SEC_RANGE_score+ LOCALE_score + V_CITY_NAME_score + ST_score + ZIP_score);// Score in surrounding context
  INTEGER2 ADDRESS_score_res := MAX(0,ADDRESS_score_pre); // At least nothing
  INTEGER2 ADDRESS_score := IF ( ADDRESS_score_ext > 0 OR ( NPI_NUMBER_score > Config.ADDRESS_OR1_NPI_NUMBER_Force*100),ADDRESS_score_res,SKIP);
  SELF.Conf_Prop := (0
    +MAX(le.NPI_NUMBER_prop,ri.NPI_NUMBER_prop)*NPI_NUMBER_score // Score if either field propogated
    +MAX(le.CLIA_NUMBER_prop,ri.CLIA_NUMBER_prop)*CLIA_NUMBER_score // Score if either field propogated
    +MAX(le.NCPDP_NUMBER_prop,ri.NCPDP_NUMBER_prop)*NCPDP_NUMBER_score // Score if either field propogated
    +MAX(le.MEDICAID_NUMBER_prop,ri.MEDICAID_NUMBER_prop)*MEDICAID_NUMBER_score // Score if either field propogated
    +MAX(le.DEA_NUMBER_prop,ri.DEA_NUMBER_prop)*DEA_NUMBER_score // Score if either field propogated
    +MAX(le.MEDICARE_FACILITY_NUMBER_prop,ri.MEDICARE_FACILITY_NUMBER_prop)*MEDICARE_FACILITY_NUMBER_score // Score if either field propogated
    +MAX(le.CNP_STORE_NUMBER_prop,ri.CNP_STORE_NUMBER_prop)*CNP_STORE_NUMBER_score // Score if either field propogated
    +if(le.FAC_NAME_prop+ri.FAC_NAME_prop>0,FAC_NAME_score*(0+if(le.CNP_NUMBER_prop+ri.CNP_NUMBER_prop>0,1,0)+if(le.CNP_STORE_NUMBER_prop+ri.CNP_STORE_NUMBER_prop>0,1,0)+if(le.CNP_BTYPE_prop+ri.CNP_BTYPE_prop>0,1,0))/4,0)
    +if(le.ADDR1_prop+ri.ADDR1_prop>0,ADDR1_score*(0+if(le.PRIM_RANGE_prop+ri.PRIM_RANGE_prop>0,1,0)+if(le.PRIM_NAME_prop+ri.PRIM_NAME_prop>0,1,0)+if(le.SEC_RANGE_prop+ri.SEC_RANGE_prop>0,1,0))/3,0)
    +if(le.ADDRESS_prop+ri.ADDRESS_prop>0,ADDRESS_score*(0+if(le.ADDR1_prop+ri.ADDR1_prop>0,1,0))/2,0)
    +MAX(le.C_LIC_NBR_prop,ri.C_LIC_NBR_prop)*C_LIC_NBR_score // Score if either field propogated
    +MAX(le.CNP_NUMBER_prop,ri.CNP_NUMBER_prop)*CNP_NUMBER_score // Score if either field propogated
    +(MAX(le.PRIM_NAME_prop,ri.PRIM_NAME_prop)/MAX(LENGTH(TRIM(le.PRIM_NAME)),LENGTH(TRIM(ri.PRIM_NAME))))*PRIM_NAME_score // Proportion of longest string propogated
    +MAX(le.PRIM_RANGE_prop,ri.PRIM_RANGE_prop)*PRIM_RANGE_score // Score if either field propogated
    +MAX(le.SEC_RANGE_prop,ri.SEC_RANGE_prop)*SEC_RANGE_score // Score if either field propogated
    +MAX(le.TAXONOMY_prop,ri.TAXONOMY_prop)*TAXONOMY_score // Score if either field propogated
    +MAX(le.CNP_BTYPE_prop,ri.CNP_BTYPE_prop)*CNP_BTYPE_score // Score if either field propogated
    +MAX(le.TAXONOMY_CODE_prop,ri.TAXONOMY_CODE_prop)*TAXONOMY_CODE_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  iComp := (NPI_NUMBER_score + CLIA_NUMBER_score + NCPDP_NUMBER_score + MEDICAID_NUMBER_score + DEA_NUMBER_score + MEDICARE_FACILITY_NUMBER_score + TAX_ID_score + VENDOR_ID_score + FAX_score + PHONE_score + IF(FAC_NAME_score>0,MAX(FAC_NAME_score,CNP_NAME_score + CNP_NUMBER_score + CNP_STORE_NUMBER_score + CNP_BTYPE_score),CNP_NAME_score + CNP_NUMBER_score + CNP_STORE_NUMBER_score + CNP_BTYPE_score) + IF(ADDRESS_score>0,MAX(ADDRESS_score,IF(ADDR1_score>0,MAX(ADDR1_score,PRIM_RANGE_score + PRIM_NAME_score + SEC_RANGE_score),PRIM_RANGE_score + PRIM_NAME_score + SEC_RANGE_score) + IF(LOCALE_score>0,MAX(LOCALE_score,V_CITY_NAME_score + ST_score + ZIP_score),V_CITY_NAME_score + ST_score + ZIP_score)),IF(ADDR1_score>0,MAX(ADDR1_score,PRIM_RANGE_score + PRIM_NAME_score + SEC_RANGE_score),PRIM_RANGE_score + PRIM_NAME_score + SEC_RANGE_score) + IF(LOCALE_score>0,MAX(LOCALE_score,V_CITY_NAME_score + ST_score + ZIP_score),V_CITY_NAME_score + ST_score + ZIP_score)) + C_LIC_NBR_score + FEIN_score + TAXONOMY_score + TAXONOMY_CODE_score) / 100 + outside;
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
EXPORT RuleText(UNSIGNED n) :=  MAP (
  n = 0 => ':ST:NPI_NUMBER',
  n = 1 => ':ST:CLIA_NUMBER',
  n = 2 => ':ST:NCPDP_NUMBER',
  n = 3 => ':ST:MEDICAID_NUMBER',
  n = 4 => ':ST:DEA_NUMBER',
  n = 5 => ':ST:MEDICARE_FACILITY_NUMBER',
  n = 6 => ':ST:TAX_ID',
  n = 7 => ':ST:VENDOR_ID',
  n = 8 => ':ST:FAX',
  n = 9 => ':ST:CNP_STORE_NUMBER',
  n = 10 => ':ST:PHONE',
  n = 11 => ':ST:C_LIC_NBR',
  n = 12 => ':ST:FEIN',
  n = 13 => ':ST:CNP_NAME',
  n = 14 => ':ST:CNP_NUMBER',
  n = 15 => ':ST:PRIM_NAME',
  n = 16 => ':ST:ZIP',
  n = 17 => ':ST:PRIM_RANGE','AttributeFile:'+(STRING)(n-10000));
//Now execute each of the 18 join conditions of which 0 have been optimized into preceding conditions
EXPORT MAC_DoJoins(hfile,trans) := FUNCTIONMACRO
//Fixed fields ->:ST(5):NPI_NUMBER(22)
dn0 := hfile(~ST_isnull AND ~NPI_NUMBER_isnull);
dn0_deduped := dn0(ST_weight100 + NPI_NUMBER_weight100>=1700); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.ST = RIGHT.ST AND LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER AND ( ~left.ST_isnull AND ~right.ST_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND ( left.CLIA_NUMBER = right.CLIA_NUMBER OR left.CLIA_NUMBER_isnull OR right.CLIA_NUMBER_isnull ) AND ( left.NCPDP_NUMBER = right.NCPDP_NUMBER OR left.NCPDP_NUMBER_isnull OR right.NCPDP_NUMBER_isnull ) AND ( left.DEA_NUMBER = right.DEA_NUMBER OR left.DEA_NUMBER_isnull OR right.DEA_NUMBER_isnull ) AND ( left.CNP_STORE_NUMBER = right.CNP_STORE_NUMBER OR left.CNP_STORE_NUMBER_isnull OR right.CNP_STORE_NUMBER_isnull ) AND ( ~left.ADDRESS_isnull AND ~right.ADDRESS_isnull ) AND ( left.FEIN = right.FEIN OR left.FEIN_isnull OR right.FEIN_isnull ) AND (( ~left.CNP_NAME_isnull AND ~right.CNP_NAME_isnull ) OR ( ~left.C_LIC_NBR_isnull AND ~right.C_LIC_NBR_isnull ) OR ( ~left.MEDICARE_FACILITY_NUMBER_isnull AND ~right.MEDICARE_FACILITY_NUMBER_isnull )) AND ( left.CNP_NUMBER = right.CNP_NUMBER OR left.CNP_NUMBER_isnull OR right.CNP_NUMBER_isnull ) AND ( ~left.PRIM_NAME_isnull AND ~right.PRIM_NAME_isnull ) AND ( ~left.PRIM_RANGE_isnull AND ~right.PRIM_RANGE_isnull ) AND ( left.CNP_BTYPE = right.CNP_BTYPE OR left.CNP_BTYPE_isnull OR right.CNP_BTYPE_isnull ) AND ( left.TAXONOMY_CODE = right.TAXONOMY_CODE OR left.TAXONOMY_CODE_isnull OR right.TAXONOMY_CODE_isnull ),trans(LEFT,RIGHT,0),HINT(unsorted_output),ATMOST(LEFT.ST = RIGHT.ST AND LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER,10000),HASH);
//Fixed fields ->:ST(5):CLIA_NUMBER(22)
dn1 := hfile(~ST_isnull AND ~CLIA_NUMBER_isnull);
dn1_deduped := dn1(ST_weight100 + CLIA_NUMBER_weight100>=1700); // Use specificity to flag high-dup counts
mj1 := JOIN( dn1_deduped, dn1_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.ST = RIGHT.ST AND LEFT.CLIA_NUMBER = RIGHT.CLIA_NUMBER AND ( ~left.ST_isnull AND ~right.ST_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND ( left.CLIA_NUMBER = right.CLIA_NUMBER OR left.CLIA_NUMBER_isnull OR right.CLIA_NUMBER_isnull ) AND ( left.NCPDP_NUMBER = right.NCPDP_NUMBER OR left.NCPDP_NUMBER_isnull OR right.NCPDP_NUMBER_isnull ) AND ( left.DEA_NUMBER = right.DEA_NUMBER OR left.DEA_NUMBER_isnull OR right.DEA_NUMBER_isnull ) AND ( left.CNP_STORE_NUMBER = right.CNP_STORE_NUMBER OR left.CNP_STORE_NUMBER_isnull OR right.CNP_STORE_NUMBER_isnull ) AND ( ~left.ADDRESS_isnull AND ~right.ADDRESS_isnull ) AND ( left.FEIN = right.FEIN OR left.FEIN_isnull OR right.FEIN_isnull ) AND (( ~left.CNP_NAME_isnull AND ~right.CNP_NAME_isnull ) OR ( ~left.C_LIC_NBR_isnull AND ~right.C_LIC_NBR_isnull ) OR ( ~left.MEDICARE_FACILITY_NUMBER_isnull AND ~right.MEDICARE_FACILITY_NUMBER_isnull )) AND ( left.CNP_NUMBER = right.CNP_NUMBER OR left.CNP_NUMBER_isnull OR right.CNP_NUMBER_isnull ) AND ( ~left.PRIM_NAME_isnull AND ~right.PRIM_NAME_isnull ) AND ( ~left.PRIM_RANGE_isnull AND ~right.PRIM_RANGE_isnull ) AND ( left.CNP_BTYPE = right.CNP_BTYPE OR left.CNP_BTYPE_isnull OR right.CNP_BTYPE_isnull ) AND ( left.TAXONOMY_CODE = right.TAXONOMY_CODE OR left.TAXONOMY_CODE_isnull OR right.TAXONOMY_CODE_isnull ),trans(LEFT,RIGHT,1),HINT(unsorted_output),ATMOST(LEFT.ST = RIGHT.ST AND LEFT.CLIA_NUMBER = RIGHT.CLIA_NUMBER,10000),HASH);
//Fixed fields ->:ST(5):NCPDP_NUMBER(22)
dn2 := hfile(~ST_isnull AND ~NCPDP_NUMBER_isnull);
dn2_deduped := dn2(ST_weight100 + NCPDP_NUMBER_weight100>=1700); // Use specificity to flag high-dup counts
mj2 := JOIN( dn2_deduped, dn2_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.ST = RIGHT.ST AND LEFT.NCPDP_NUMBER = RIGHT.NCPDP_NUMBER AND ( ~left.ST_isnull AND ~right.ST_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND ( left.CLIA_NUMBER = right.CLIA_NUMBER OR left.CLIA_NUMBER_isnull OR right.CLIA_NUMBER_isnull ) AND ( left.NCPDP_NUMBER = right.NCPDP_NUMBER OR left.NCPDP_NUMBER_isnull OR right.NCPDP_NUMBER_isnull ) AND ( left.DEA_NUMBER = right.DEA_NUMBER OR left.DEA_NUMBER_isnull OR right.DEA_NUMBER_isnull ) AND ( left.CNP_STORE_NUMBER = right.CNP_STORE_NUMBER OR left.CNP_STORE_NUMBER_isnull OR right.CNP_STORE_NUMBER_isnull ) AND ( ~left.ADDRESS_isnull AND ~right.ADDRESS_isnull ) AND ( left.FEIN = right.FEIN OR left.FEIN_isnull OR right.FEIN_isnull ) AND (( ~left.CNP_NAME_isnull AND ~right.CNP_NAME_isnull ) OR ( ~left.C_LIC_NBR_isnull AND ~right.C_LIC_NBR_isnull ) OR ( ~left.MEDICARE_FACILITY_NUMBER_isnull AND ~right.MEDICARE_FACILITY_NUMBER_isnull )) AND ( left.CNP_NUMBER = right.CNP_NUMBER OR left.CNP_NUMBER_isnull OR right.CNP_NUMBER_isnull ) AND ( ~left.PRIM_NAME_isnull AND ~right.PRIM_NAME_isnull ) AND ( ~left.PRIM_RANGE_isnull AND ~right.PRIM_RANGE_isnull ) AND ( left.CNP_BTYPE = right.CNP_BTYPE OR left.CNP_BTYPE_isnull OR right.CNP_BTYPE_isnull ) AND ( left.TAXONOMY_CODE = right.TAXONOMY_CODE OR left.TAXONOMY_CODE_isnull OR right.TAXONOMY_CODE_isnull ),trans(LEFT,RIGHT,2),HINT(unsorted_output),ATMOST(LEFT.ST = RIGHT.ST AND LEFT.NCPDP_NUMBER = RIGHT.NCPDP_NUMBER,10000),HASH);
//Fixed fields ->:ST(5):MEDICAID_NUMBER(22)
dn3 := hfile(~ST_isnull AND ~MEDICAID_NUMBER_isnull);
dn3_deduped := dn3(ST_weight100 + MEDICAID_NUMBER_weight100>=1700); // Use specificity to flag high-dup counts
mj3 := JOIN( dn3_deduped, dn3_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.ST = RIGHT.ST AND LEFT.MEDICAID_NUMBER = RIGHT.MEDICAID_NUMBER AND ( ~left.ST_isnull AND ~right.ST_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND ( left.CLIA_NUMBER = right.CLIA_NUMBER OR left.CLIA_NUMBER_isnull OR right.CLIA_NUMBER_isnull ) AND ( left.NCPDP_NUMBER = right.NCPDP_NUMBER OR left.NCPDP_NUMBER_isnull OR right.NCPDP_NUMBER_isnull ) AND ( left.DEA_NUMBER = right.DEA_NUMBER OR left.DEA_NUMBER_isnull OR right.DEA_NUMBER_isnull ) AND ( left.CNP_STORE_NUMBER = right.CNP_STORE_NUMBER OR left.CNP_STORE_NUMBER_isnull OR right.CNP_STORE_NUMBER_isnull ) AND ( ~left.ADDRESS_isnull AND ~right.ADDRESS_isnull ) AND ( left.FEIN = right.FEIN OR left.FEIN_isnull OR right.FEIN_isnull ) AND (( ~left.CNP_NAME_isnull AND ~right.CNP_NAME_isnull ) OR ( ~left.C_LIC_NBR_isnull AND ~right.C_LIC_NBR_isnull ) OR ( ~left.MEDICARE_FACILITY_NUMBER_isnull AND ~right.MEDICARE_FACILITY_NUMBER_isnull )) AND ( left.CNP_NUMBER = right.CNP_NUMBER OR left.CNP_NUMBER_isnull OR right.CNP_NUMBER_isnull ) AND ( ~left.PRIM_NAME_isnull AND ~right.PRIM_NAME_isnull ) AND ( ~left.PRIM_RANGE_isnull AND ~right.PRIM_RANGE_isnull ) AND ( left.CNP_BTYPE = right.CNP_BTYPE OR left.CNP_BTYPE_isnull OR right.CNP_BTYPE_isnull ) AND ( left.TAXONOMY_CODE = right.TAXONOMY_CODE OR left.TAXONOMY_CODE_isnull OR right.TAXONOMY_CODE_isnull ),trans(LEFT,RIGHT,3),HINT(unsorted_output),ATMOST(LEFT.ST = RIGHT.ST AND LEFT.MEDICAID_NUMBER = RIGHT.MEDICAID_NUMBER,10000),HASH);
//Fixed fields ->:ST(5):DEA_NUMBER(21)
dn4 := hfile(~ST_isnull AND ~DEA_NUMBER_isnull);
dn4_deduped := dn4(ST_weight100 + DEA_NUMBER_weight100>=1700); // Use specificity to flag high-dup counts
mj4 := JOIN( dn4_deduped, dn4_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.ST = RIGHT.ST AND LEFT.DEA_NUMBER = RIGHT.DEA_NUMBER AND ( ~left.ST_isnull AND ~right.ST_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND ( left.CLIA_NUMBER = right.CLIA_NUMBER OR left.CLIA_NUMBER_isnull OR right.CLIA_NUMBER_isnull ) AND ( left.NCPDP_NUMBER = right.NCPDP_NUMBER OR left.NCPDP_NUMBER_isnull OR right.NCPDP_NUMBER_isnull ) AND ( left.DEA_NUMBER = right.DEA_NUMBER OR left.DEA_NUMBER_isnull OR right.DEA_NUMBER_isnull ) AND ( left.CNP_STORE_NUMBER = right.CNP_STORE_NUMBER OR left.CNP_STORE_NUMBER_isnull OR right.CNP_STORE_NUMBER_isnull ) AND ( ~left.ADDRESS_isnull AND ~right.ADDRESS_isnull ) AND ( left.FEIN = right.FEIN OR left.FEIN_isnull OR right.FEIN_isnull ) AND (( ~left.CNP_NAME_isnull AND ~right.CNP_NAME_isnull ) OR ( ~left.C_LIC_NBR_isnull AND ~right.C_LIC_NBR_isnull ) OR ( ~left.MEDICARE_FACILITY_NUMBER_isnull AND ~right.MEDICARE_FACILITY_NUMBER_isnull )) AND ( left.CNP_NUMBER = right.CNP_NUMBER OR left.CNP_NUMBER_isnull OR right.CNP_NUMBER_isnull ) AND ( ~left.PRIM_NAME_isnull AND ~right.PRIM_NAME_isnull ) AND ( ~left.PRIM_RANGE_isnull AND ~right.PRIM_RANGE_isnull ) AND ( left.CNP_BTYPE = right.CNP_BTYPE OR left.CNP_BTYPE_isnull OR right.CNP_BTYPE_isnull ) AND ( left.TAXONOMY_CODE = right.TAXONOMY_CODE OR left.TAXONOMY_CODE_isnull OR right.TAXONOMY_CODE_isnull ),trans(LEFT,RIGHT,4),HINT(unsorted_output),ATMOST(LEFT.ST = RIGHT.ST AND LEFT.DEA_NUMBER = RIGHT.DEA_NUMBER,10000),HASH);
mjs0_t := mj0+mj1+mj2+mj3+mj4;
SALT30.mac_select_best_matches(mjs0_t,RID1,RID2,o0);
mjs0 := o0 : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::mj::0',EXPIRE(Config.PersistExpire));
//Fixed fields ->:ST(5):MEDICARE_FACILITY_NUMBER(21)
dn5 := hfile(~ST_isnull AND ~MEDICARE_FACILITY_NUMBER_isnull);
dn5_deduped := dn5(ST_weight100 + MEDICARE_FACILITY_NUMBER_weight100>=1700); // Use specificity to flag high-dup counts
mj5 := JOIN( dn5_deduped, dn5_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.ST = RIGHT.ST AND LEFT.MEDICARE_FACILITY_NUMBER = RIGHT.MEDICARE_FACILITY_NUMBER AND ( ~left.ST_isnull AND ~right.ST_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND ( left.CLIA_NUMBER = right.CLIA_NUMBER OR left.CLIA_NUMBER_isnull OR right.CLIA_NUMBER_isnull ) AND ( left.NCPDP_NUMBER = right.NCPDP_NUMBER OR left.NCPDP_NUMBER_isnull OR right.NCPDP_NUMBER_isnull ) AND ( left.DEA_NUMBER = right.DEA_NUMBER OR left.DEA_NUMBER_isnull OR right.DEA_NUMBER_isnull ) AND ( left.CNP_STORE_NUMBER = right.CNP_STORE_NUMBER OR left.CNP_STORE_NUMBER_isnull OR right.CNP_STORE_NUMBER_isnull ) AND ( ~left.ADDRESS_isnull AND ~right.ADDRESS_isnull ) AND ( left.FEIN = right.FEIN OR left.FEIN_isnull OR right.FEIN_isnull ) AND (( ~left.CNP_NAME_isnull AND ~right.CNP_NAME_isnull ) OR ( ~left.C_LIC_NBR_isnull AND ~right.C_LIC_NBR_isnull ) OR ( ~left.MEDICARE_FACILITY_NUMBER_isnull AND ~right.MEDICARE_FACILITY_NUMBER_isnull )) AND ( left.CNP_NUMBER = right.CNP_NUMBER OR left.CNP_NUMBER_isnull OR right.CNP_NUMBER_isnull ) AND ( ~left.PRIM_NAME_isnull AND ~right.PRIM_NAME_isnull ) AND ( ~left.PRIM_RANGE_isnull AND ~right.PRIM_RANGE_isnull ) AND ( left.CNP_BTYPE = right.CNP_BTYPE OR left.CNP_BTYPE_isnull OR right.CNP_BTYPE_isnull ) AND ( left.TAXONOMY_CODE = right.TAXONOMY_CODE OR left.TAXONOMY_CODE_isnull OR right.TAXONOMY_CODE_isnull ),trans(LEFT,RIGHT,5),HINT(unsorted_output),ATMOST(LEFT.ST = RIGHT.ST AND LEFT.MEDICARE_FACILITY_NUMBER = RIGHT.MEDICARE_FACILITY_NUMBER,10000),HASH);
//Fixed fields ->:ST(5):TAX_ID(21)
dn6 := hfile(~ST_isnull AND ~TAX_ID_isnull);
dn6_deduped := dn6(ST_weight100 + TAX_ID_weight100>=1700); // Use specificity to flag high-dup counts
mj6 := JOIN( dn6_deduped, dn6_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.ST = RIGHT.ST AND LEFT.TAX_ID = RIGHT.TAX_ID AND ( ~left.ST_isnull AND ~right.ST_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND ( left.CLIA_NUMBER = right.CLIA_NUMBER OR left.CLIA_NUMBER_isnull OR right.CLIA_NUMBER_isnull ) AND ( left.NCPDP_NUMBER = right.NCPDP_NUMBER OR left.NCPDP_NUMBER_isnull OR right.NCPDP_NUMBER_isnull ) AND ( left.DEA_NUMBER = right.DEA_NUMBER OR left.DEA_NUMBER_isnull OR right.DEA_NUMBER_isnull ) AND ( left.CNP_STORE_NUMBER = right.CNP_STORE_NUMBER OR left.CNP_STORE_NUMBER_isnull OR right.CNP_STORE_NUMBER_isnull ) AND ( ~left.ADDRESS_isnull AND ~right.ADDRESS_isnull ) AND ( left.FEIN = right.FEIN OR left.FEIN_isnull OR right.FEIN_isnull ) AND (( ~left.CNP_NAME_isnull AND ~right.CNP_NAME_isnull ) OR ( ~left.C_LIC_NBR_isnull AND ~right.C_LIC_NBR_isnull ) OR ( ~left.MEDICARE_FACILITY_NUMBER_isnull AND ~right.MEDICARE_FACILITY_NUMBER_isnull )) AND ( left.CNP_NUMBER = right.CNP_NUMBER OR left.CNP_NUMBER_isnull OR right.CNP_NUMBER_isnull ) AND ( ~left.PRIM_NAME_isnull AND ~right.PRIM_NAME_isnull ) AND ( ~left.PRIM_RANGE_isnull AND ~right.PRIM_RANGE_isnull ) AND ( left.CNP_BTYPE = right.CNP_BTYPE OR left.CNP_BTYPE_isnull OR right.CNP_BTYPE_isnull ) AND ( left.TAXONOMY_CODE = right.TAXONOMY_CODE OR left.TAXONOMY_CODE_isnull OR right.TAXONOMY_CODE_isnull ),trans(LEFT,RIGHT,6),HINT(unsorted_output),ATMOST(LEFT.ST = RIGHT.ST AND LEFT.TAX_ID = RIGHT.TAX_ID,10000),HASH);
//Fixed fields ->:ST(5):VENDOR_ID(21)
dn7 := hfile(~ST_isnull AND ~VENDOR_ID_isnull);
dn7_deduped := dn7(ST_weight100 + VENDOR_ID_weight100>=1700); // Use specificity to flag high-dup counts
mj7 := JOIN( dn7_deduped, dn7_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.ST = RIGHT.ST AND LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC AND ( ~left.ST_isnull AND ~right.ST_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND ( left.CLIA_NUMBER = right.CLIA_NUMBER OR left.CLIA_NUMBER_isnull OR right.CLIA_NUMBER_isnull ) AND ( left.NCPDP_NUMBER = right.NCPDP_NUMBER OR left.NCPDP_NUMBER_isnull OR right.NCPDP_NUMBER_isnull ) AND ( left.DEA_NUMBER = right.DEA_NUMBER OR left.DEA_NUMBER_isnull OR right.DEA_NUMBER_isnull ) AND ( left.CNP_STORE_NUMBER = right.CNP_STORE_NUMBER OR left.CNP_STORE_NUMBER_isnull OR right.CNP_STORE_NUMBER_isnull ) AND ( ~left.ADDRESS_isnull AND ~right.ADDRESS_isnull ) AND ( left.FEIN = right.FEIN OR left.FEIN_isnull OR right.FEIN_isnull ) AND (( ~left.CNP_NAME_isnull AND ~right.CNP_NAME_isnull ) OR ( ~left.C_LIC_NBR_isnull AND ~right.C_LIC_NBR_isnull ) OR ( ~left.MEDICARE_FACILITY_NUMBER_isnull AND ~right.MEDICARE_FACILITY_NUMBER_isnull )) AND ( left.CNP_NUMBER = right.CNP_NUMBER OR left.CNP_NUMBER_isnull OR right.CNP_NUMBER_isnull ) AND ( ~left.PRIM_NAME_isnull AND ~right.PRIM_NAME_isnull ) AND ( ~left.PRIM_RANGE_isnull AND ~right.PRIM_RANGE_isnull ) AND ( left.CNP_BTYPE = right.CNP_BTYPE OR left.CNP_BTYPE_isnull OR right.CNP_BTYPE_isnull ) AND ( left.TAXONOMY_CODE = right.TAXONOMY_CODE OR left.TAXONOMY_CODE_isnull OR right.TAXONOMY_CODE_isnull ),trans(LEFT,RIGHT,7),HINT(unsorted_output),ATMOST(LEFT.ST = RIGHT.ST AND LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC,10000),HASH);
//Fixed fields ->:ST(5):FAX(20)
dn8 := hfile(~ST_isnull AND ~FAX_isnull);
dn8_deduped := dn8(ST_weight100 + FAX_weight100>=1700); // Use specificity to flag high-dup counts
mj8 := JOIN( dn8_deduped, dn8_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.ST = RIGHT.ST AND LEFT.FAX = RIGHT.FAX AND ( ~left.ST_isnull AND ~right.ST_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND ( left.CLIA_NUMBER = right.CLIA_NUMBER OR left.CLIA_NUMBER_isnull OR right.CLIA_NUMBER_isnull ) AND ( left.NCPDP_NUMBER = right.NCPDP_NUMBER OR left.NCPDP_NUMBER_isnull OR right.NCPDP_NUMBER_isnull ) AND ( left.DEA_NUMBER = right.DEA_NUMBER OR left.DEA_NUMBER_isnull OR right.DEA_NUMBER_isnull ) AND ( left.CNP_STORE_NUMBER = right.CNP_STORE_NUMBER OR left.CNP_STORE_NUMBER_isnull OR right.CNP_STORE_NUMBER_isnull ) AND ( ~left.ADDRESS_isnull AND ~right.ADDRESS_isnull ) AND ( left.FEIN = right.FEIN OR left.FEIN_isnull OR right.FEIN_isnull ) AND (( ~left.CNP_NAME_isnull AND ~right.CNP_NAME_isnull ) OR ( ~left.C_LIC_NBR_isnull AND ~right.C_LIC_NBR_isnull ) OR ( ~left.MEDICARE_FACILITY_NUMBER_isnull AND ~right.MEDICARE_FACILITY_NUMBER_isnull )) AND ( left.CNP_NUMBER = right.CNP_NUMBER OR left.CNP_NUMBER_isnull OR right.CNP_NUMBER_isnull ) AND ( ~left.PRIM_NAME_isnull AND ~right.PRIM_NAME_isnull ) AND ( ~left.PRIM_RANGE_isnull AND ~right.PRIM_RANGE_isnull ) AND ( left.CNP_BTYPE = right.CNP_BTYPE OR left.CNP_BTYPE_isnull OR right.CNP_BTYPE_isnull ) AND ( left.TAXONOMY_CODE = right.TAXONOMY_CODE OR left.TAXONOMY_CODE_isnull OR right.TAXONOMY_CODE_isnull ),trans(LEFT,RIGHT,8),HINT(unsorted_output),ATMOST(LEFT.ST = RIGHT.ST AND LEFT.FAX = RIGHT.FAX,10000),HASH);
//Fixed fields ->:ST(5):CNP_STORE_NUMBER(20)
dn9 := hfile(~ST_isnull AND (~CNP_STORE_NUMBER_isnull OR ~C_LIC_NBR_isnull OR ~MEDICARE_FACILITY_NUMBER_isnull));
dn9_deduped := dn9(ST_weight100 + CNP_STORE_NUMBER_weight100>=1700); // Use specificity to flag high-dup counts
mj9 := JOIN( dn9_deduped, dn9_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.ST = RIGHT.ST AND LEFT.CNP_STORE_NUMBER = RIGHT.CNP_STORE_NUMBER AND ( ~left.ST_isnull AND ~right.ST_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND ( left.CLIA_NUMBER = right.CLIA_NUMBER OR left.CLIA_NUMBER_isnull OR right.CLIA_NUMBER_isnull ) AND ( left.NCPDP_NUMBER = right.NCPDP_NUMBER OR left.NCPDP_NUMBER_isnull OR right.NCPDP_NUMBER_isnull ) AND ( left.DEA_NUMBER = right.DEA_NUMBER OR left.DEA_NUMBER_isnull OR right.DEA_NUMBER_isnull ) AND ( left.CNP_STORE_NUMBER = right.CNP_STORE_NUMBER OR left.CNP_STORE_NUMBER_isnull OR right.CNP_STORE_NUMBER_isnull ) AND ( ~left.ADDRESS_isnull AND ~right.ADDRESS_isnull ) AND ( left.FEIN = right.FEIN OR left.FEIN_isnull OR right.FEIN_isnull ) AND (( ~left.CNP_NAME_isnull AND ~right.CNP_NAME_isnull ) OR ( ~left.C_LIC_NBR_isnull AND ~right.C_LIC_NBR_isnull ) OR ( ~left.MEDICARE_FACILITY_NUMBER_isnull AND ~right.MEDICARE_FACILITY_NUMBER_isnull )) AND ( left.CNP_NUMBER = right.CNP_NUMBER OR left.CNP_NUMBER_isnull OR right.CNP_NUMBER_isnull ) AND ( ~left.PRIM_NAME_isnull AND ~right.PRIM_NAME_isnull ) AND ( ~left.PRIM_RANGE_isnull AND ~right.PRIM_RANGE_isnull ) AND ( left.CNP_BTYPE = right.CNP_BTYPE OR left.CNP_BTYPE_isnull OR right.CNP_BTYPE_isnull ) AND ( left.TAXONOMY_CODE = right.TAXONOMY_CODE OR left.TAXONOMY_CODE_isnull OR right.TAXONOMY_CODE_isnull ),trans(LEFT,RIGHT,9),HINT(unsorted_output),ATMOST(LEFT.ST = RIGHT.ST AND LEFT.CNP_STORE_NUMBER = RIGHT.CNP_STORE_NUMBER,10000),HASH);
mjs1_t := mj5+mj6+mj7+mj8+mj9;
SALT30.mac_select_best_matches(mjs1_t,RID1,RID2,o1);
mjs1 := o1 : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::mj::1',EXPIRE(Config.PersistExpire));
//Fixed fields ->:ST(5):PHONE(20)
dn10 := hfile(~ST_isnull AND ~PHONE_isnull);
dn10_deduped := dn10(ST_weight100 + PHONE_weight100>=1700); // Use specificity to flag high-dup counts
mj10 := JOIN( dn10_deduped, dn10_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.ST = RIGHT.ST AND LEFT.PHONE = RIGHT.PHONE AND ( ~left.ST_isnull AND ~right.ST_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND ( left.CLIA_NUMBER = right.CLIA_NUMBER OR left.CLIA_NUMBER_isnull OR right.CLIA_NUMBER_isnull ) AND ( left.NCPDP_NUMBER = right.NCPDP_NUMBER OR left.NCPDP_NUMBER_isnull OR right.NCPDP_NUMBER_isnull ) AND ( left.DEA_NUMBER = right.DEA_NUMBER OR left.DEA_NUMBER_isnull OR right.DEA_NUMBER_isnull ) AND ( left.CNP_STORE_NUMBER = right.CNP_STORE_NUMBER OR left.CNP_STORE_NUMBER_isnull OR right.CNP_STORE_NUMBER_isnull ) AND ( ~left.ADDRESS_isnull AND ~right.ADDRESS_isnull ) AND ( left.FEIN = right.FEIN OR left.FEIN_isnull OR right.FEIN_isnull ) AND (( ~left.CNP_NAME_isnull AND ~right.CNP_NAME_isnull ) OR ( ~left.C_LIC_NBR_isnull AND ~right.C_LIC_NBR_isnull ) OR ( ~left.MEDICARE_FACILITY_NUMBER_isnull AND ~right.MEDICARE_FACILITY_NUMBER_isnull )) AND ( left.CNP_NUMBER = right.CNP_NUMBER OR left.CNP_NUMBER_isnull OR right.CNP_NUMBER_isnull ) AND ( ~left.PRIM_NAME_isnull AND ~right.PRIM_NAME_isnull ) AND ( ~left.PRIM_RANGE_isnull AND ~right.PRIM_RANGE_isnull ) AND ( left.CNP_BTYPE = right.CNP_BTYPE OR left.CNP_BTYPE_isnull OR right.CNP_BTYPE_isnull ) AND ( left.TAXONOMY_CODE = right.TAXONOMY_CODE OR left.TAXONOMY_CODE_isnull OR right.TAXONOMY_CODE_isnull ),trans(LEFT,RIGHT,10),HINT(unsorted_output),ATMOST(LEFT.ST = RIGHT.ST AND LEFT.PHONE = RIGHT.PHONE,10000),HASH);
//Fixed fields ->:ST(5):C_LIC_NBR(19)
dn11 := hfile(~ST_isnull AND ~C_LIC_NBR_isnull);
dn11_deduped := dn11(ST_weight100 + C_LIC_NBR_weight100>=1700); // Use specificity to flag high-dup counts
mj11 := JOIN( dn11_deduped, dn11_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.ST = RIGHT.ST AND LEFT.C_LIC_NBR = RIGHT.C_LIC_NBR AND LEFT.LIC_STATE = RIGHT.LIC_STATE AND ( ~left.ST_isnull AND ~right.ST_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND ( left.CLIA_NUMBER = right.CLIA_NUMBER OR left.CLIA_NUMBER_isnull OR right.CLIA_NUMBER_isnull ) AND ( left.NCPDP_NUMBER = right.NCPDP_NUMBER OR left.NCPDP_NUMBER_isnull OR right.NCPDP_NUMBER_isnull ) AND ( left.DEA_NUMBER = right.DEA_NUMBER OR left.DEA_NUMBER_isnull OR right.DEA_NUMBER_isnull ) AND ( left.CNP_STORE_NUMBER = right.CNP_STORE_NUMBER OR left.CNP_STORE_NUMBER_isnull OR right.CNP_STORE_NUMBER_isnull ) AND ( ~left.ADDRESS_isnull AND ~right.ADDRESS_isnull ) AND ( left.FEIN = right.FEIN OR left.FEIN_isnull OR right.FEIN_isnull ) AND (( ~left.CNP_NAME_isnull AND ~right.CNP_NAME_isnull ) OR ( ~left.C_LIC_NBR_isnull AND ~right.C_LIC_NBR_isnull ) OR ( ~left.MEDICARE_FACILITY_NUMBER_isnull AND ~right.MEDICARE_FACILITY_NUMBER_isnull )) AND ( left.CNP_NUMBER = right.CNP_NUMBER OR left.CNP_NUMBER_isnull OR right.CNP_NUMBER_isnull ) AND ( ~left.PRIM_NAME_isnull AND ~right.PRIM_NAME_isnull ) AND ( ~left.PRIM_RANGE_isnull AND ~right.PRIM_RANGE_isnull ) AND ( left.CNP_BTYPE = right.CNP_BTYPE OR left.CNP_BTYPE_isnull OR right.CNP_BTYPE_isnull ) AND ( left.TAXONOMY_CODE = right.TAXONOMY_CODE OR left.TAXONOMY_CODE_isnull OR right.TAXONOMY_CODE_isnull ),trans(LEFT,RIGHT,11),HINT(unsorted_output),ATMOST(LEFT.ST = RIGHT.ST AND LEFT.C_LIC_NBR = RIGHT.C_LIC_NBR AND LEFT.LIC_STATE = RIGHT.LIC_STATE,10000),HASH);
//Fixed fields ->:ST(5):FEIN(17)
dn12 := hfile(~ST_isnull AND ~FEIN_isnull);
dn12_deduped := dn12(ST_weight100 + FEIN_weight100>=1700); // Use specificity to flag high-dup counts
mj12 := JOIN( dn12_deduped, dn12_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.ST = RIGHT.ST AND LEFT.FEIN = RIGHT.FEIN AND ( ~left.ST_isnull AND ~right.ST_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND ( left.CLIA_NUMBER = right.CLIA_NUMBER OR left.CLIA_NUMBER_isnull OR right.CLIA_NUMBER_isnull ) AND ( left.NCPDP_NUMBER = right.NCPDP_NUMBER OR left.NCPDP_NUMBER_isnull OR right.NCPDP_NUMBER_isnull ) AND ( left.DEA_NUMBER = right.DEA_NUMBER OR left.DEA_NUMBER_isnull OR right.DEA_NUMBER_isnull ) AND ( left.CNP_STORE_NUMBER = right.CNP_STORE_NUMBER OR left.CNP_STORE_NUMBER_isnull OR right.CNP_STORE_NUMBER_isnull ) AND ( ~left.ADDRESS_isnull AND ~right.ADDRESS_isnull ) AND ( left.FEIN = right.FEIN OR left.FEIN_isnull OR right.FEIN_isnull ) AND (( ~left.CNP_NAME_isnull AND ~right.CNP_NAME_isnull ) OR ( ~left.C_LIC_NBR_isnull AND ~right.C_LIC_NBR_isnull ) OR ( ~left.MEDICARE_FACILITY_NUMBER_isnull AND ~right.MEDICARE_FACILITY_NUMBER_isnull )) AND ( left.CNP_NUMBER = right.CNP_NUMBER OR left.CNP_NUMBER_isnull OR right.CNP_NUMBER_isnull ) AND ( ~left.PRIM_NAME_isnull AND ~right.PRIM_NAME_isnull ) AND ( ~left.PRIM_RANGE_isnull AND ~right.PRIM_RANGE_isnull ) AND ( left.CNP_BTYPE = right.CNP_BTYPE OR left.CNP_BTYPE_isnull OR right.CNP_BTYPE_isnull ) AND ( left.TAXONOMY_CODE = right.TAXONOMY_CODE OR left.TAXONOMY_CODE_isnull OR right.TAXONOMY_CODE_isnull ),trans(LEFT,RIGHT,12),HINT(unsorted_output),ATMOST(LEFT.ST = RIGHT.ST AND LEFT.FEIN = RIGHT.FEIN,10000),HASH);
//Fixed fields ->:ST(5):CNP_NAME(13)
dn13 := hfile(~ST_isnull AND (~CNP_NAME_isnull OR ~C_LIC_NBR_isnull OR ~MEDICARE_FACILITY_NUMBER_isnull));
dn13_deduped := dn13(ST_weight100 + CNP_NAME_weight100>=1700); // Use specificity to flag high-dup counts
mj13 := JOIN( dn13_deduped, dn13_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.ST = RIGHT.ST AND LEFT.CNP_NAME = RIGHT.CNP_NAME AND ( ~left.ST_isnull AND ~right.ST_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND ( left.CLIA_NUMBER = right.CLIA_NUMBER OR left.CLIA_NUMBER_isnull OR right.CLIA_NUMBER_isnull ) AND ( left.NCPDP_NUMBER = right.NCPDP_NUMBER OR left.NCPDP_NUMBER_isnull OR right.NCPDP_NUMBER_isnull ) AND ( left.DEA_NUMBER = right.DEA_NUMBER OR left.DEA_NUMBER_isnull OR right.DEA_NUMBER_isnull ) AND ( left.CNP_STORE_NUMBER = right.CNP_STORE_NUMBER OR left.CNP_STORE_NUMBER_isnull OR right.CNP_STORE_NUMBER_isnull ) AND ( ~left.ADDRESS_isnull AND ~right.ADDRESS_isnull ) AND ( left.FEIN = right.FEIN OR left.FEIN_isnull OR right.FEIN_isnull ) AND (( ~left.CNP_NAME_isnull AND ~right.CNP_NAME_isnull ) OR ( ~left.C_LIC_NBR_isnull AND ~right.C_LIC_NBR_isnull ) OR ( ~left.MEDICARE_FACILITY_NUMBER_isnull AND ~right.MEDICARE_FACILITY_NUMBER_isnull )) AND ( left.CNP_NUMBER = right.CNP_NUMBER OR left.CNP_NUMBER_isnull OR right.CNP_NUMBER_isnull ) AND ( ~left.PRIM_NAME_isnull AND ~right.PRIM_NAME_isnull ) AND ( ~left.PRIM_RANGE_isnull AND ~right.PRIM_RANGE_isnull ) AND ( left.CNP_BTYPE = right.CNP_BTYPE OR left.CNP_BTYPE_isnull OR right.CNP_BTYPE_isnull ) AND ( left.TAXONOMY_CODE = right.TAXONOMY_CODE OR left.TAXONOMY_CODE_isnull OR right.TAXONOMY_CODE_isnull ),trans(LEFT,RIGHT,13),HINT(unsorted_output),ATMOST(LEFT.ST = RIGHT.ST AND LEFT.CNP_NAME = RIGHT.CNP_NAME,10000),HASH);
//Fixed fields ->:ST(5):CNP_NUMBER(13)
dn14 := hfile(~ST_isnull AND (~CNP_NUMBER_isnull OR ~C_LIC_NBR_isnull OR ~MEDICARE_FACILITY_NUMBER_isnull));
dn14_deduped := dn14(ST_weight100 + CNP_NUMBER_weight100>=1700); // Use specificity to flag high-dup counts
mj14 := JOIN( dn14_deduped, dn14_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.ST = RIGHT.ST AND LEFT.CNP_NUMBER = RIGHT.CNP_NUMBER AND ( ~left.ST_isnull AND ~right.ST_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND ( left.CLIA_NUMBER = right.CLIA_NUMBER OR left.CLIA_NUMBER_isnull OR right.CLIA_NUMBER_isnull ) AND ( left.NCPDP_NUMBER = right.NCPDP_NUMBER OR left.NCPDP_NUMBER_isnull OR right.NCPDP_NUMBER_isnull ) AND ( left.DEA_NUMBER = right.DEA_NUMBER OR left.DEA_NUMBER_isnull OR right.DEA_NUMBER_isnull ) AND ( left.CNP_STORE_NUMBER = right.CNP_STORE_NUMBER OR left.CNP_STORE_NUMBER_isnull OR right.CNP_STORE_NUMBER_isnull ) AND ( ~left.ADDRESS_isnull AND ~right.ADDRESS_isnull ) AND ( left.FEIN = right.FEIN OR left.FEIN_isnull OR right.FEIN_isnull ) AND (( ~left.CNP_NAME_isnull AND ~right.CNP_NAME_isnull ) OR ( ~left.C_LIC_NBR_isnull AND ~right.C_LIC_NBR_isnull ) OR ( ~left.MEDICARE_FACILITY_NUMBER_isnull AND ~right.MEDICARE_FACILITY_NUMBER_isnull )) AND ( left.CNP_NUMBER = right.CNP_NUMBER OR left.CNP_NUMBER_isnull OR right.CNP_NUMBER_isnull ) AND ( ~left.PRIM_NAME_isnull AND ~right.PRIM_NAME_isnull ) AND ( ~left.PRIM_RANGE_isnull AND ~right.PRIM_RANGE_isnull ) AND ( left.CNP_BTYPE = right.CNP_BTYPE OR left.CNP_BTYPE_isnull OR right.CNP_BTYPE_isnull ) AND ( left.TAXONOMY_CODE = right.TAXONOMY_CODE OR left.TAXONOMY_CODE_isnull OR right.TAXONOMY_CODE_isnull ),trans(LEFT,RIGHT,14),HINT(unsorted_output),ATMOST(LEFT.ST = RIGHT.ST AND LEFT.CNP_NUMBER = RIGHT.CNP_NUMBER,10000),HASH);
mjs2_t := mj10+mj11+mj12+mj13+mj14;
SALT30.mac_select_best_matches(mjs2_t,RID1,RID2,o2);
mjs2 := o2 : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::mj::2',EXPIRE(Config.PersistExpire));
//Fixed fields ->:ST(5):PRIM_NAME(13)
dn15 := hfile(~ST_isnull AND ~PRIM_NAME_isnull);
dn15_deduped := dn15(ST_weight100 + PRIM_NAME_weight100>=1700); // Use specificity to flag high-dup counts
mj15 := JOIN( dn15_deduped, dn15_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.ST = RIGHT.ST AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND ( ~left.ST_isnull AND ~right.ST_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND ( left.CLIA_NUMBER = right.CLIA_NUMBER OR left.CLIA_NUMBER_isnull OR right.CLIA_NUMBER_isnull ) AND ( left.NCPDP_NUMBER = right.NCPDP_NUMBER OR left.NCPDP_NUMBER_isnull OR right.NCPDP_NUMBER_isnull ) AND ( left.DEA_NUMBER = right.DEA_NUMBER OR left.DEA_NUMBER_isnull OR right.DEA_NUMBER_isnull ) AND ( left.CNP_STORE_NUMBER = right.CNP_STORE_NUMBER OR left.CNP_STORE_NUMBER_isnull OR right.CNP_STORE_NUMBER_isnull ) AND ( ~left.ADDRESS_isnull AND ~right.ADDRESS_isnull ) AND ( left.FEIN = right.FEIN OR left.FEIN_isnull OR right.FEIN_isnull ) AND (( ~left.CNP_NAME_isnull AND ~right.CNP_NAME_isnull ) OR ( ~left.C_LIC_NBR_isnull AND ~right.C_LIC_NBR_isnull ) OR ( ~left.MEDICARE_FACILITY_NUMBER_isnull AND ~right.MEDICARE_FACILITY_NUMBER_isnull )) AND ( left.CNP_NUMBER = right.CNP_NUMBER OR left.CNP_NUMBER_isnull OR right.CNP_NUMBER_isnull ) AND ( ~left.PRIM_NAME_isnull AND ~right.PRIM_NAME_isnull ) AND ( ~left.PRIM_RANGE_isnull AND ~right.PRIM_RANGE_isnull ) AND ( left.CNP_BTYPE = right.CNP_BTYPE OR left.CNP_BTYPE_isnull OR right.CNP_BTYPE_isnull ) AND ( left.TAXONOMY_CODE = right.TAXONOMY_CODE OR left.TAXONOMY_CODE_isnull OR right.TAXONOMY_CODE_isnull ),trans(LEFT,RIGHT,15),HINT(unsorted_output),ATMOST(LEFT.ST = RIGHT.ST AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME,10000),HASH);
//Fixed fields ->:ST(5):ZIP(13)
dn16 := hfile(~ST_isnull AND ~ZIP_isnull);
dn16_deduped := dn16(ST_weight100 + ZIP_weight100>=1700); // Use specificity to flag high-dup counts
mj16 := JOIN( dn16_deduped, dn16_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.ST = RIGHT.ST AND LEFT.ZIP = RIGHT.ZIP AND ( ~left.ST_isnull AND ~right.ST_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND ( left.CLIA_NUMBER = right.CLIA_NUMBER OR left.CLIA_NUMBER_isnull OR right.CLIA_NUMBER_isnull ) AND ( left.NCPDP_NUMBER = right.NCPDP_NUMBER OR left.NCPDP_NUMBER_isnull OR right.NCPDP_NUMBER_isnull ) AND ( left.DEA_NUMBER = right.DEA_NUMBER OR left.DEA_NUMBER_isnull OR right.DEA_NUMBER_isnull ) AND ( left.CNP_STORE_NUMBER = right.CNP_STORE_NUMBER OR left.CNP_STORE_NUMBER_isnull OR right.CNP_STORE_NUMBER_isnull ) AND ( ~left.ADDRESS_isnull AND ~right.ADDRESS_isnull ) AND ( left.FEIN = right.FEIN OR left.FEIN_isnull OR right.FEIN_isnull ) AND (( ~left.CNP_NAME_isnull AND ~right.CNP_NAME_isnull ) OR ( ~left.C_LIC_NBR_isnull AND ~right.C_LIC_NBR_isnull ) OR ( ~left.MEDICARE_FACILITY_NUMBER_isnull AND ~right.MEDICARE_FACILITY_NUMBER_isnull )) AND ( left.CNP_NUMBER = right.CNP_NUMBER OR left.CNP_NUMBER_isnull OR right.CNP_NUMBER_isnull ) AND ( ~left.PRIM_NAME_isnull AND ~right.PRIM_NAME_isnull ) AND ( ~left.PRIM_RANGE_isnull AND ~right.PRIM_RANGE_isnull ) AND ( left.CNP_BTYPE = right.CNP_BTYPE OR left.CNP_BTYPE_isnull OR right.CNP_BTYPE_isnull ) AND ( left.TAXONOMY_CODE = right.TAXONOMY_CODE OR left.TAXONOMY_CODE_isnull OR right.TAXONOMY_CODE_isnull ),trans(LEFT,RIGHT,16),HINT(unsorted_output),ATMOST(LEFT.ST = RIGHT.ST AND LEFT.ZIP = RIGHT.ZIP,10000),HASH);
//Fixed fields ->:ST(5):PRIM_RANGE(12)
dn17 := hfile(~ST_isnull AND ~PRIM_RANGE_isnull);
dn17_deduped := dn17(ST_weight100 + PRIM_RANGE_weight100>=1700); // Use specificity to flag high-dup counts
mj17 := JOIN( dn17_deduped, dn17_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.ST = RIGHT.ST AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE AND ( ~left.ST_isnull AND ~right.ST_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND ( left.CLIA_NUMBER = right.CLIA_NUMBER OR left.CLIA_NUMBER_isnull OR right.CLIA_NUMBER_isnull ) AND ( left.NCPDP_NUMBER = right.NCPDP_NUMBER OR left.NCPDP_NUMBER_isnull OR right.NCPDP_NUMBER_isnull ) AND ( left.DEA_NUMBER = right.DEA_NUMBER OR left.DEA_NUMBER_isnull OR right.DEA_NUMBER_isnull ) AND ( left.CNP_STORE_NUMBER = right.CNP_STORE_NUMBER OR left.CNP_STORE_NUMBER_isnull OR right.CNP_STORE_NUMBER_isnull ) AND ( ~left.ADDRESS_isnull AND ~right.ADDRESS_isnull ) AND ( left.FEIN = right.FEIN OR left.FEIN_isnull OR right.FEIN_isnull ) AND (( ~left.CNP_NAME_isnull AND ~right.CNP_NAME_isnull ) OR ( ~left.C_LIC_NBR_isnull AND ~right.C_LIC_NBR_isnull ) OR ( ~left.MEDICARE_FACILITY_NUMBER_isnull AND ~right.MEDICARE_FACILITY_NUMBER_isnull )) AND ( left.CNP_NUMBER = right.CNP_NUMBER OR left.CNP_NUMBER_isnull OR right.CNP_NUMBER_isnull ) AND ( ~left.PRIM_NAME_isnull AND ~right.PRIM_NAME_isnull ) AND ( ~left.PRIM_RANGE_isnull AND ~right.PRIM_RANGE_isnull ) AND ( left.CNP_BTYPE = right.CNP_BTYPE OR left.CNP_BTYPE_isnull OR right.CNP_BTYPE_isnull ) AND ( left.TAXONOMY_CODE = right.TAXONOMY_CODE OR left.TAXONOMY_CODE_isnull OR right.TAXONOMY_CODE_isnull ),trans(LEFT,RIGHT,17),HINT(unsorted_output),ATMOST(LEFT.ST = RIGHT.ST AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE,10000),HASH);
last_mjs_t :=Custom_JOIN(hfile,trans) + mj15+mj16+mj17;
SALT30.mac_select_best_matches(last_mjs_t,RID1,RID2,o);
RETURN  mjs0+ mjs1+ mjs2 +o;
ENDMACRO;
SHARED all_mjs := MAC_DoJoins(h,match_join);
EXPORT All_Matches := all_mjs : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::all_m',EXPIRE(Config.PersistExpire)); // To by used by RID and LNPID
SALT30.mac_avoid_transitives(All_Matches,LNPID1,LNPID2,Conf,DateOverlap,Rule,o);
EXPORT PossibleMatches := o : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::mt',EXPIRE(Config.PersistExpire));
SALT30.mac_get_BestPerRecord( All_Matches,RID1,LNPID1,RID2,LNPID2,o );
EXPORT BestPerRecord := o : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::mr',EXPIRE(Config.PersistExpire));
//Now lets see if any slice-outs are needed
too_big := TABLE(h,{LNPID, InCluster := COUNT(GROUP)},LNPID,MERGE)(InCluster>1000); // LNPID that are too big for sliceout
h_ok := JOIN(h,too_big,LEFT.LNPID=RIGHT.LNPID,TRANSFORM(LEFT),LOOKUP,LEFT ONLY);
SHARED in_matches := JOIN(h_ok,h_ok,LEFT.LNPID=RIGHT.LNPID AND (>STRING6<)LEFT.RID<>(>STRING6<)RIGHT.RID,match_join(LEFT,RIGHT,9999),LOCAL,HINT(unsorted_output));
SALT30.mac_cluster_breadth(in_matches,RID1,RID2,LNPID1,o);
o1 := JOIN(o,Specificities(ih).ClusterSizes,LEFT.LNPID1=RIGHT.LNPID,LOCAL);
EXPORT ClusterLinkages := o1 : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::clu',EXPIRE(Config.PersistExpire));
EXPORT ClusterOutcasts := ClusterLinkages(InCluster>1,Closest<MatchThreshold);
//Now find those outcasts that are liked elsewhere ...
Pref_Layout := RECORD
  SALT30.UIDType RID;  //Outcast
  SALT30.UIDType LNPID;  // Outcase within
  INTEGER2 Closest; // Best present link
  SALT30.UIDType Pref_RID; // Prefers this record
  SALT30.UIDType Pref_LNPID; // Prefers this cluster
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
EXPORT ToSlice := IF ( Config.DoSliceouts, DEDUP(SORT(DISTRIBUTE(BetterElsewhere(Pref_Margin>10),HASH(LNPID)),LNPID,-Pref_Margin,LOCAL),LNPID,LOCAL)) : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::Matches::ToSlice',EXPIRE(Config.PersistExpire));
// 1024x better in new place
  SALT30.MAC_Avoid_SliceOuts(PossibleMatches,LNPID1,LNPID2,LNPID,Pref_LNPID,ToSlice,m); // If LNPID is slice target - don't use in match
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
SALT30.MAC_Reassign_UID(ihbp,Cleave(ih).patch_file,LNPID,RID,ih1); // Perform cleaves
SALT30.MAC_SliceOut_ByRID(ih1,RID,LNPID,ToSlice,RID,sliced0); // Execute Sliceouts
  sliced := IF( Config.DoSliceouts, sliced0, ih1); // Compile time ability to remove sliceout cost
ut.MAC_Patch_Id(sliced,LNPID,Matches,LNPID1,LNPID2,o); // Join Clusters
  bf := Flags(ih).In_Flagged; // Input values flagged
  TYPEOF(o) AppendFlags(o le,bf ri) := TRANSFORM
    SELF.NPI_NUMBER_flag := ri.NPI_NUMBER_flag; // Either value - or null if no-match
    SELF.CLIA_NUMBER_flag := ri.CLIA_NUMBER_flag; // Either value - or null if no-match
    SELF.NCPDP_NUMBER_flag := ri.NCPDP_NUMBER_flag; // Either value - or null if no-match
    SELF.MEDICAID_NUMBER_flag := ri.MEDICAID_NUMBER_flag; // Either value - or null if no-match
    SELF.DEA_NUMBER_flag := ri.DEA_NUMBER_flag; // Either value - or null if no-match
    SELF.MEDICARE_FACILITY_NUMBER_flag := ri.MEDICARE_FACILITY_NUMBER_flag; // Either value - or null if no-match
    SELF.TAX_ID_flag := ri.TAX_ID_flag; // Either value - or null if no-match
    SELF.C_LIC_NBR_flag := ri.C_LIC_NBR_flag; // Either value - or null if no-match
    SELF.FEIN_flag := ri.FEIN_flag; // Either value - or null if no-match
    SELF := le;
  END;
	/* Senthil change*/
  j := JOIN(ih,bf,LEFT.LNPID = RIGHT.LNPID AND LEFT.RID = RIGHT.RID,AppendFlags(LEFT,RIGHT),LEFT OUTER); // Only take if cluster id unchanged for record
EXPORT Patched_Infile := j;
//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,LNPID,Matches,LNPID1,LNPID2,o1);
EXPORT Patched_Candidates := o1;
// Now compute a file to show which identifiers have changed from input to output
EXPORT id_shift_r := RECORD
    SALT30.UIDType RID;
    SALT30.UIDType LNPID_before;
    SALT30.UIDType LNPID_after;
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
EXPORT PreIDs := HealthCareFacilityHeader_Best.Fields.UIDConsistency(ih); // Export whole consistency module
EXPORT PostIDs := HealthCareFacilityHeader_Best.Fields.UIDConsistency(Patched_Infile); // Export whole consistency module
EXPORT PatchingError0 := PreIDs.IdCounts[1].LNPID_count - PostIDs.IdCounts[1].LNPID_count - MatchesPerformed - COUNT(BasicMatch(ih).patch_file) + SlicesPerformed + Cleave(ih).patch_count; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile) - PostIDs.IdCounts[1].RID_Count; // Should be zero
END;
