IMPORT SALT33;
EXPORT Scaled_Candidates(DATASET(layout_Classify_PS) le,DATASET(match_candidates(le).layout_candidates) cfk = Match_Candidates(le).candidates ) := FUNCTION
R := RECORD
  cfk;
  UNSIGNED2 FNAME_p_Weight100;
  UNSIGNED2 FNAME_e1_Weight100;
  UNSIGNED2 FNAME_e1p_Weight100;
  UNSIGNED2 FNAME_PreferredName_Weight100;
  UNSIGNED2 MNAME_e2_Weight100;
  UNSIGNED2 LNAME_p_Weight100;
  UNSIGNED2 LNAME_e1_Weight100;
  UNSIGNED2 LNAME_e1p_Weight100;
END;
R ProcessConceptScaling(cfk le) := TRANSFORM
  REAL FULLNAME_score_scale := 1.0; // No scaling required
  REAL MAINNAME_score_scale := 1.0; // No scaling required
  SELF.FNAME_weight100 := SALT33.Min0(le.FNAME_weight100); // Precompute the scale
  SELF.FNAME_p_Weight100 := SALT33.Min0(le.FNAME_weight100 + 100*log(le.FNAME_cnt/le.FNAME_p_cnt)/log(2)); // Precompute phonetic specificity
  SELF.FNAME_e1_Weight100 := SALT33.Min0(le.FNAME_weight100 + 100*log(le.FNAME_cnt/le.FNAME_e1_cnt)/log(2)); // Precompute edit-distance specificity
  SELF.FNAME_e1p_Weight100 := SALT33.Min0(le.FNAME_weight100 + 100*log(le.FNAME_cnt/le.FNAME_e1p_cnt)/log(2)); // Precompute phonetic & edit_distance specificity
  SELF.FNAME_MAINNAME_Weight100 := SALT33.Min0(le.FNAME_MAINNAME_weight100); // Scale CONCEPT-WORDBAG specificity
  SELF.FNAME_initial_char_Weight100 := SALT33.Min0(le.FNAME_initial_char_weight100); // Scale CONCEPT-WORDBAG specificity
  SELF.FNAME_PreferredName_Weight100 := SALT33.Min0(le.FNAME_weight100 + 100*log(le.FNAME_cnt/le.FNAME_PreferredName_cnt)/log(2)); // Precompute PreferredName specificity
  SELF.MNAME_weight100 := SALT33.Min0(le.MNAME_weight100); // Precompute the scale
  SELF.MNAME_e2_Weight100 := SALT33.Min0(le.MNAME_weight100 + 100*log(le.MNAME_cnt/le.MNAME_e2_cnt)/log(2)); // Precompute edit-distance specificity
  SELF.MNAME_MAINNAME_Weight100 := SALT33.Min0(le.MNAME_MAINNAME_weight100); // Scale CONCEPT-WORDBAG specificity
  SELF.MNAME_initial_char_Weight100 := SALT33.Min0(le.MNAME_initial_char_weight100); // Scale CONCEPT-WORDBAG specificity
  SELF.LNAME_weight100 := SALT33.Min0(le.LNAME_weight100); // Precompute the scale
  SELF.LNAME_p_Weight100 := SALT33.Min0(le.LNAME_weight100 + 100*log(le.LNAME_cnt/le.LNAME_p_cnt)/log(2)); // Precompute phonetic specificity
  SELF.LNAME_e1_Weight100 := SALT33.Min0(le.LNAME_weight100 + 100*log(le.LNAME_cnt/le.LNAME_e1_cnt)/log(2)); // Precompute edit-distance specificity
  SELF.LNAME_e1p_Weight100 := SALT33.Min0(le.LNAME_weight100 + 100*log(le.LNAME_cnt/le.LNAME_e1p_cnt)/log(2)); // Precompute phonetic & edit_distance specificity
  SELF.LNAME_MAINNAME_Weight100 := SALT33.Min0(le.LNAME_MAINNAME_weight100); // Scale CONCEPT-WORDBAG specificity
  SELF.NAME_SUFFIX_weight100 := SALT33.Min0(le.NAME_SUFFIX_weight100); // Precompute the scale
  SELF := le;
END;
scaled := project(cfk,ProcessConceptScaling(left));
  RETURN scaled;
END;
