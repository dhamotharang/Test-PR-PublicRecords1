IMPORT SALT37;
EXPORT Scaled_Candidates(DATASET(layout_Classify_PS) le,DATASET(match_candidates(le).layout_candidates) cfk = Match_Candidates(le).candidates ) := FUNCTION
R := RECORD
  {cfk};
  UNSIGNED2 FNAME_p_Weight100;
  UNSIGNED2 FNAME_e1_Weight100;
  UNSIGNED2 FNAME_e1p_Weight100;
  UNSIGNED2 FNAME_PreferredName_Weight100;
  UNSIGNED2 MNAME_e2_Weight100;
END;
R ProcessConceptScaling(cfk le) := TRANSFORM
  REAL FULLNAME_score_scale := le.FULLNAME_weight100 / (le.MAINNAME_weight100 + le.NAME_SUFFIX_weight100); // Scaling factor for this concept
  REAL MAINNAME_score_scale := le.MAINNAME_weight100 / (le.FNAME_weight100 + le.MNAME_weight100 + le.LNAME_weight100); // Scaling factor for this concept
  SELF.FNAME_weight100 := SALT37.Min0(le.FNAME_weight100*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale)); // Precompute the scale
  SELF.FNAME_p_Weight100 := SALT37.Min0(le.FNAME_weight100 + 100*log(le.FNAME_cnt/le.FNAME_p_cnt)/log(2))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale); // Precompute phonetic specificity
  SELF.FNAME_e1_Weight100 := SALT37.Min0(le.FNAME_weight100 + 100*log(le.FNAME_cnt/le.FNAME_e1_cnt)/log(2))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale); // Precompute edit-distance specificity
  SELF.FNAME_e1p_Weight100 := SALT37.Min0(le.FNAME_weight100 + 100*log(le.FNAME_cnt/le.FNAME_e1p_cnt)/log(2))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale); // Precompute phonetic & edit_distance specificity
  SELF.FNAME_PreferredName_Weight100 := SALT37.Min0(le.FNAME_weight100 + 100*log(le.FNAME_cnt/le.FNAME_PreferredName_cnt)*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale)/log(2)); // Precompute PreferredName specificity
  SELF.MNAME_weight100 := SALT37.Min0(le.MNAME_weight100*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale)); // Precompute the scale
  SELF.MNAME_e2_Weight100 := SALT37.Min0(le.MNAME_weight100 + 100*log(le.MNAME_cnt/le.MNAME_e2_cnt)/log(2))*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale); // Precompute edit-distance specificity
  SELF.LNAME_weight100 := SALT37.Min0(le.LNAME_weight100*IF(MAINNAME_score_scale=0,1,MAINNAME_score_scale)*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale)); // Precompute the scale
  SELF.NAME_SUFFIX_weight100 := SALT37.Min0(le.NAME_SUFFIX_weight100*IF(FULLNAME_score_scale=0,1,FULLNAME_score_scale)); // Precompute the scale
  SELF := le;
END;
scaled := PROJECT(cfk,ProcessConceptScaling(left));
  RETURN scaled;
END;
