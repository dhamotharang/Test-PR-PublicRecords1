﻿IMPORT SALT311;
EXPORT Scaled_Candidates(DATASET(layout_HealthProvider) le, DATASET(match_candidates(le).layout_candidates) cfk = match_candidates(le).candidates) := FUNCTION
R := RECORD
  {cfk};
  INTEGER2 FNAME_p_Weight100;
  INTEGER2 FNAME_e1_Weight100;
  INTEGER2 FNAME_e1p_Weight100;
  INTEGER2 FNAME_e2_Weight100;
  INTEGER2 FNAME_e2p_Weight100;
  INTEGER2 FNAME_PreferredName_Weight100;
  INTEGER2 MNAME_p_Weight100;
  INTEGER2 MNAME_e1_Weight100;
  INTEGER2 MNAME_e1p_Weight100;
  INTEGER2 MNAME_e2_Weight100;
  INTEGER2 MNAME_e2p_Weight100;
  INTEGER2 LNAME_p_Weight100;
  INTEGER2 LNAME_e1_Weight100;
  INTEGER2 LNAME_e1p_Weight100;
  INTEGER2 LNAME_e2_Weight100;
  INTEGER2 LNAME_e2p_Weight100;
  INTEGER2 SNAME_NormSuffix_Weight100;
END;
R ProcessConceptScaling(cfk le) := TRANSFORM
  REAL FULLNAME_score_scale := 1.0; // No scaling required
  REAL MAINNAME_score_scale := 1.0; // No scaling required
  SELF.FNAME_weight100 := SALT311.Min0(le.FNAME_weight100); // Precompute the scale
  SELF.FNAME_p_Weight100 := SALT311.Min0(le.FNAME_weight100 + 100*log(le.FNAME_cnt/le.FNAME_p_cnt)/log(2)); // Precompute phonetic specificity
  SELF.FNAME_e1_Weight100 := SALT311.Min0(le.FNAME_weight100 + 100*log(le.FNAME_cnt/le.FNAME_e1_cnt)/log(2)); // Precompute edit-distance specificity
  SELF.FNAME_e1p_Weight100 := SALT311.Min0(le.FNAME_weight100 + 100*log(le.FNAME_cnt/le.FNAME_e1p_cnt)/log(2)); // Precompute phonetic & edit_distance specificity
  SELF.FNAME_e2_Weight100 := SALT311.Min0(le.FNAME_weight100 + 100*log(le.FNAME_cnt/le.FNAME_e2_cnt)/log(2)); // Precompute edit-distance specificity
  SELF.FNAME_e2p_Weight100 := SALT311.Min0(le.FNAME_weight100 + 100*log(le.FNAME_cnt/le.FNAME_e2p_cnt)/log(2)); // Precompute phonetic & edit_distance specificity
  SELF.FNAME_MAINNAME_Weight100 := SALT311.Min0(le.FNAME_MAINNAME_weight100); // Scale CONCEPT-WORDBAG specificity
  SELF.FNAME_initial_char_Weight100 := SALT311.Min0(le.FNAME_initial_char_weight100); // Scale CONCEPT-WORDBAG specificity
  SELF.FNAME_PreferredName_Weight100 := SALT311.Min0(le.FNAME_weight100 + 100*log(le.FNAME_cnt/le.FNAME_PreferredName_cnt)/log(2)); // Precompute PreferredName specificity
  SELF.MNAME_weight100 := SALT311.Min0(le.MNAME_weight100); // Precompute the scale
  SELF.MNAME_p_Weight100 := SALT311.Min0(le.MNAME_weight100 + 100*log(le.MNAME_cnt/le.MNAME_p_cnt)/log(2)); // Precompute phonetic specificity
  SELF.MNAME_e1_Weight100 := SALT311.Min0(le.MNAME_weight100 + 100*log(le.MNAME_cnt/le.MNAME_e1_cnt)/log(2)); // Precompute edit-distance specificity
  SELF.MNAME_e1p_Weight100 := SALT311.Min0(le.MNAME_weight100 + 100*log(le.MNAME_cnt/le.MNAME_e1p_cnt)/log(2)); // Precompute phonetic & edit_distance specificity
  SELF.MNAME_e2_Weight100 := SALT311.Min0(le.MNAME_weight100 + 100*log(le.MNAME_cnt/le.MNAME_e2_cnt)/log(2)); // Precompute edit-distance specificity
  SELF.MNAME_e2p_Weight100 := SALT311.Min0(le.MNAME_weight100 + 100*log(le.MNAME_cnt/le.MNAME_e2p_cnt)/log(2)); // Precompute phonetic & edit_distance specificity
  SELF.MNAME_MAINNAME_Weight100 := SALT311.Min0(le.MNAME_MAINNAME_weight100); // Scale CONCEPT-WORDBAG specificity
  SELF.MNAME_initial_char_Weight100 := SALT311.Min0(le.MNAME_initial_char_weight100); // Scale CONCEPT-WORDBAG specificity
  SELF.LNAME_weight100 := SALT311.Min0(le.LNAME_weight100); // Precompute the scale
  SELF.LNAME_p_Weight100 := SALT311.Min0(le.LNAME_weight100 + 100*log(le.LNAME_cnt/le.LNAME_p_cnt)/log(2)); // Precompute phonetic specificity
  SELF.LNAME_e1_Weight100 := SALT311.Min0(le.LNAME_weight100 + 100*log(le.LNAME_cnt/le.LNAME_e1_cnt)/log(2)); // Precompute edit-distance specificity
  SELF.LNAME_e1p_Weight100 := SALT311.Min0(le.LNAME_weight100 + 100*log(le.LNAME_cnt/le.LNAME_e1p_cnt)/log(2)); // Precompute phonetic & edit_distance specificity
  SELF.LNAME_e2_Weight100 := SALT311.Min0(le.LNAME_weight100 + 100*log(le.LNAME_cnt/le.LNAME_e2_cnt)/log(2)); // Precompute edit-distance specificity
  SELF.LNAME_e2p_Weight100 := SALT311.Min0(le.LNAME_weight100 + 100*log(le.LNAME_cnt/le.LNAME_e2p_cnt)/log(2)); // Precompute phonetic & edit_distance specificity
  SELF.LNAME_MAINNAME_Weight100 := SALT311.Min0(le.LNAME_MAINNAME_weight100); // Scale CONCEPT-WORDBAG specificity
  SELF.LNAME_initial_char_Weight100 := SALT311.Min0(le.LNAME_initial_char_weight100); // Scale CONCEPT-WORDBAG specificity
  SELF.SNAME_weight100 := SALT311.Min0(le.SNAME_weight100); // Precompute the scale
  SELF.SNAME_NormSuffix_Weight100 := SALT311.Min0(le.SNAME_weight100 + 100*log(le.SNAME_cnt/le.SNAME_NormSuffix_cnt)/log(2)); // Precompute NormSuffix specificity
  REAL ADDRESS_score_scale := le.ADDRESS_weight100 / (le.ADDR1_weight100 + le.LOCALE_weight100); // Scaling factor for this concept
  REAL ADDR1_score_scale := le.ADDR1_weight100 / (le.PRIM_NAME_weight100 + le.PRIM_RANGE_weight100 + le.SEC_RANGE_weight100); // Scaling factor for this concept
  SELF.PRIM_NAME_weight100 := SALT311.Min0(le.PRIM_NAME_weight100*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale)); // Precompute the scale
  SELF.PRIM_RANGE_weight100 := SALT311.Min0(le.PRIM_RANGE_weight100*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale)); // Precompute the scale
  SELF.SEC_RANGE_weight100 := SALT311.Min0(le.SEC_RANGE_weight100*IF(ADDR1_score_scale=0,1,ADDR1_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale)); // Precompute the scale
  REAL LOCALE_score_scale := le.LOCALE_weight100 / (le.V_CITY_NAME_weight100 + le.ST_weight100 + le.ZIP_weight100); // Scaling factor for this concept
  SELF.V_CITY_NAME_weight100 := SALT311.Min0(le.V_CITY_NAME_weight100*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale)); // Precompute the scale
  SELF.ST_weight100 := SALT311.Min0(le.ST_weight100*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale)); // Precompute the scale
  SELF.ZIP_weight100 := SALT311.Min0(le.ZIP_weight100*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale)); // Precompute the scale
  SELF := le;
END;
scaled := PROJECT(cfk,ProcessConceptScaling(left));
  RETURN scaled;
END;
