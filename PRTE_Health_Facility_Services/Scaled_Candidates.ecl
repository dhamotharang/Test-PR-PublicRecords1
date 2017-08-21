IMPORT SALT29;
EXPORT Scaled_Candidates(DATASET(layout_HealthFacility) le,DATASET(match_candidates(le).layout_candidates) cfk = Match_Candidates(le).candidates ) := FUNCTION
R := RECORD
  cfk;
  UNSIGNED2 PRIM_RANGE_e1_Weight100;
  UNSIGNED2 PRIM_NAME_e1_Weight100;
  UNSIGNED2 V_CITY_NAME_p_Weight100;
  UNSIGNED2 V_CITY_NAME_e2_Weight100;
  UNSIGNED2 V_CITY_NAME_e2p_Weight100;
END;
R ProcessConceptScaling(cfk le) := TRANSFORM
  REAL FAC_NAME_score_scale := le.FAC_NAME_weight100 / (le.CNP_NAME_weight100 + le.CNP_NUMBER_weight100 + le.CNP_STORE_NUMBER_weight100 + le.CNP_BTYPE_weight100 + le.CNP_LOWV_weight100); // Scaling factor for this concept
  SELF.CNP_NAME_weight100 := SALT29.Min0(le.CNP_NAME_weight100*IF(FAC_NAME_score_scale=0,1,FAC_NAME_score_scale)); // Precompute the scale
  SELF.CNP_NUMBER_weight100 := SALT29.Min0(le.CNP_NUMBER_weight100*IF(FAC_NAME_score_scale=0,1,FAC_NAME_score_scale)); // Precompute the scale
  SELF.CNP_NUMBER_FAC_NAME_Weight100 := SALT29.Min0(le.CNP_NUMBER_FAC_NAME_weight100)*IF(FAC_NAME_score_scale=0,1,FAC_NAME_score_scale); // Scale CONCEPT-WORDBAG specificity
  SELF.CNP_STORE_NUMBER_weight100 := SALT29.Min0(le.CNP_STORE_NUMBER_weight100*IF(FAC_NAME_score_scale=0,1,FAC_NAME_score_scale)); // Precompute the scale
  SELF.CNP_STORE_NUMBER_FAC_NAME_Weight100 := SALT29.Min0(le.CNP_STORE_NUMBER_FAC_NAME_weight100)*IF(FAC_NAME_score_scale=0,1,FAC_NAME_score_scale); // Scale CONCEPT-WORDBAG specificity
  SELF.CNP_BTYPE_weight100 := SALT29.Min0(le.CNP_BTYPE_weight100*IF(FAC_NAME_score_scale=0,1,FAC_NAME_score_scale)); // Precompute the scale
  SELF.CNP_BTYPE_FAC_NAME_Weight100 := SALT29.Min0(le.CNP_BTYPE_FAC_NAME_weight100)*IF(FAC_NAME_score_scale=0,1,FAC_NAME_score_scale); // Scale CONCEPT-WORDBAG specificity
  SELF.CNP_LOWV_weight100 := SALT29.Min0(le.CNP_LOWV_weight100*IF(FAC_NAME_score_scale=0,1,FAC_NAME_score_scale)); // Precompute the scale
  SELF.CNP_LOWV_FAC_NAME_Weight100 := SALT29.Min0(le.CNP_LOWV_FAC_NAME_weight100)*IF(FAC_NAME_score_scale=0,1,FAC_NAME_score_scale); // Scale CONCEPT-WORDBAG specificity
  REAL ADDRES_score_scale := le.ADDRES_weight100 / (le.ADDR1_weight100 + le.LOCALE_weight100); // Scaling factor for this concept
  REAL ADDR1_score_scale := le.ADDR1_weight100 / (le.PRIM_RANGE_weight100 + le.SEC_RANGE_weight100 + le.PRIM_NAME_weight100); // Scaling factor for this concept
  SELF.PRIM_RANGE_weight100 := SALT29.Min0(le.PRIM_RANGE_weight100*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRES_score_scale=0,1,ADDRES_score_scale)); // Precompute the scale
  SELF.PRIM_RANGE_e1_Weight100 := SALT29.Min0(le.PRIM_RANGE_weight100 + 100*log(le.PRIM_RANGE_cnt/le.PRIM_RANGE_e1_cnt)/log(2))*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRES_score_scale=0,1,ADDRES_score_scale); // Precompute edit-distance specificity
  SELF.SEC_RANGE_weight100 := SALT29.Min0(le.SEC_RANGE_weight100*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRES_score_scale=0,1,ADDRES_score_scale)); // Precompute the scale
  SELF.PRIM_NAME_weight100 := SALT29.Min0(le.PRIM_NAME_weight100*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRES_score_scale=0,1,ADDRES_score_scale)); // Precompute the scale
  SELF.PRIM_NAME_e1_Weight100 := SALT29.Min0(le.PRIM_NAME_weight100 + 100*log(le.PRIM_NAME_cnt/le.PRIM_NAME_e1_cnt)/log(2))*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRES_score_scale=0,1,ADDRES_score_scale); // Precompute edit-distance specificity
  REAL LOCALE_score_scale := le.LOCALE_weight100 / (le.V_CITY_NAME_weight100 + le.ST_weight100 + le.ZIP_weight100); // Scaling factor for this concept
  SELF.V_CITY_NAME_weight100 := SALT29.Min0(le.V_CITY_NAME_weight100*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRES_score_scale=0,1,ADDRES_score_scale)); // Precompute the scale
  SELF.V_CITY_NAME_p_Weight100 := SALT29.Min0(le.V_CITY_NAME_weight100 + 100*log(le.V_CITY_NAME_cnt/le.V_CITY_NAME_p_cnt)/log(2))*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRES_score_scale=0,1,ADDRES_score_scale); // Precompute phonetic specificity
  SELF.V_CITY_NAME_e2_Weight100 := SALT29.Min0(le.V_CITY_NAME_weight100 + 100*log(le.V_CITY_NAME_cnt/le.V_CITY_NAME_e2_cnt)/log(2))*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRES_score_scale=0,1,ADDRES_score_scale); // Precompute edit-distance specificity
  SELF.V_CITY_NAME_e2p_Weight100 := SALT29.Min0(le.V_CITY_NAME_weight100 + 100*log(le.V_CITY_NAME_cnt/le.V_CITY_NAME_e2p_cnt)/log(2))*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRES_score_scale=0,1,ADDRES_score_scale); // Precompute phonetic & edit_distance specificity
  SELF.ST_weight100 := SALT29.Min0(le.ST_weight100*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRES_score_scale=0,1,ADDRES_score_scale)); // Precompute the scale
  SELF.ZIP_weight100 := SALT29.Min0(le.ZIP_weight100*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRES_score_scale=0,1,ADDRES_score_scale)); // Precompute the scale
  SELF := le;
END;
scaled := project(cfk,ProcessConceptScaling(left));
  RETURN scaled;
END;
