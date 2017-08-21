IMPORT SALT27;
EXPORT Scaled_Candidates(DATASET(layout_HealthProvider) le,DATASET(match_candidates(le).layout_candidates) cfk = Match_Candidates(le).candidates ) := FUNCTION
R := RECORD
cfk;
UNSIGNED2 LNAME_e2_Weight100;
UNSIGNED2 MNAME_e2_Weight100;
UNSIGNED2 FNAME_e1_Weight100;
UNSIGNED2 FNAME_PreferredName_Weight100;
UNSIGNED2 SNAME_NormSuffix_Weight100;
END;
R ProcessConceptScaling(cfk le) := TRANSFORM
REAL FULLNAME_score_scale := le.FULLNAME_weight100 / (le.MAINNAME_weight100 + le.SNAME_weight100); // Scaling factor for this concept
REAL MAINNAME_score_scale := le.MAINNAME_weight100 / (le.FNAME_weight100 + le.MNAME_weight100 + le.LNAME_weight100); // Scaling factor for this concept
SELF.FNAME_weight100 := SALT27.Min0(le.FNAME_weight100*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale)); // Precompute the scale
SELF.FNAME_e1_Weight100 := SALT27.Min0(le.FNAME_weight100 + 100*log(le.FNAME_cnt/le.FNAME_e1_cnt)/log(2))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale); // Precompute edit-distance specificity
SELF.FNAME_PreferredName_Weight100 := SALT27.Min0(le.FNAME_weight100 + 100*log(le.FNAME_cnt/le.FNAME_PreferredName_cnt)*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale)/log(2)); // Precompute PreferredName specificity
SELF.MNAME_weight100 := SALT27.Min0(le.MNAME_weight100*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale)); // Precompute the scale
SELF.MNAME_e2_Weight100 := SALT27.Min0(le.MNAME_weight100 + 100*log(le.MNAME_cnt/le.MNAME_e2_cnt)/log(2))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale); // Precompute edit-distance specificity
SELF.LNAME_weight100 := SALT27.Min0(le.LNAME_weight100*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale)); // Precompute the scale
SELF.LNAME_e2_Weight100 := SALT27.Min0(le.LNAME_weight100 + 100*log(le.LNAME_cnt/le.LNAME_e2_cnt)/log(2))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale); // Precompute edit-distance specificity
SELF.SNAME_weight100 := SALT27.Min0(le.SNAME_weight100*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale)); // Precompute the scale
SELF.SNAME_NormSuffix_Weight100 := SALT27.Min0(le.SNAME_weight100 + 100*log(le.SNAME_cnt/le.SNAME_NormSuffix_cnt)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale)/log(2)); // Precompute NormSuffix specificity
REAL ADDRESS_score_scale := le.ADDRESS_weight100 / (le.ADDR_weight100 + le.LOCALE_weight100); // Scaling factor for this concept
REAL ADDR_score_scale := le.ADDR_weight100 / (le.PRIM_RANGE_weight100 + le.SEC_RANGE_weight100 + le.PRIM_NAME_weight100); // Scaling factor for this concept
SELF.PRIM_RANGE_weight100 := SALT27.Min0(le.PRIM_RANGE_weight100*IF(ADDR_score_scale=0,1,ADDR_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale)); // Precompute the scale
SELF.SEC_RANGE_weight100 := SALT27.Min0(le.SEC_RANGE_weight100*IF(ADDR_score_scale=0,1,ADDR_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale)); // Precompute the scale
SELF.PRIM_NAME_weight100 := SALT27.Min0(le.PRIM_NAME_weight100*IF(ADDR_score_scale=0,1,ADDR_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale)); // Precompute the scale
REAL LOCALE_score_scale := le.LOCALE_weight100 / (le.V_CITY_NAME_weight100 + le.ST_weight100 + le.ZIP_weight100); // Scaling factor for this concept
SELF.V_CITY_NAME_weight100 := SALT27.Min0(le.V_CITY_NAME_weight100*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale)); // Precompute the scale
SELF.ST_weight100 := SALT27.Min0(le.ST_weight100*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale)); // Precompute the scale
SELF.ZIP_weight100 := SALT27.Min0(le.ZIP_weight100*IF(LOCALE_score_scale=0,1,LOCALE_score_scale)*IF(ADDRESS_score_scale=0,1,ADDRESS_score_scale)); // Precompute the scale
SELF := le;
END;
scaled := project(cfk,ProcessConceptScaling(left));
RETURN scaled;
END;
