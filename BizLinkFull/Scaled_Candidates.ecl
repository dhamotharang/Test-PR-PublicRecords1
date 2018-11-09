IMPORT SALT37;
EXPORT Scaled_Candidates(DATASET(layout_BizHead) le,DATASET(match_candidates(le).layout_candidates) cfk = Match_Candidates(le).candidates ) := FUNCTION
R := RECORD
  {cfk};
  UNSIGNED2 prim_range_e1_Weight100;
  UNSIGNED2 prim_name_e1_Weight100;
  UNSIGNED2 sec_range_e1_Weight100;
  UNSIGNED2 fname_e1_Weight100;
  UNSIGNED2 mname_e2_Weight100;
  UNSIGNED2 lname_e2_Weight100;
END;
R ProcessConceptScaling(cfk le) := TRANSFORM
  REAL CONTACTNAME_score_scale := 1.0; // No scaling required
  SELF.fname_weight100 := SALT37.Min0(le.fname_weight100); // Precompute the scale
  SELF.fname_e1_Weight100 := SALT37.Min0(le.fname_weight100 + 100*log(le.fname_cnt/le.fname_e1_cnt)/log(2)); // Precompute edit-distance specificity
  SELF.mname_weight100 := SALT37.Min0(le.mname_weight100); // Precompute the scale
  SELF.mname_e2_Weight100 := SALT37.Min0(le.mname_weight100 + 100*log(le.mname_cnt/le.mname_e2_cnt)/log(2)); // Precompute edit-distance specificity
  SELF.lname_weight100 := SALT37.Min0(le.lname_weight100); // Precompute the scale
  SELF.lname_e2_Weight100 := SALT37.Min0(le.lname_weight100 + 100*log(le.lname_cnt/le.lname_e2_cnt)/log(2)); // Precompute edit-distance specificity
  REAL STREETADDRESS_score_scale := 1.0; // No scaling required
  SELF.prim_range_weight100 := SALT37.Min0(le.prim_range_weight100); // Precompute the scale
  SELF.prim_range_e1_Weight100 := SALT37.Min0(le.prim_range_weight100 + 100*log(le.prim_range_cnt/le.prim_range_e1_cnt)/log(2)); // Precompute edit-distance specificity
  SELF.prim_name_weight100 := SALT37.Min0(le.prim_name_weight100); // Precompute the scale
  SELF.prim_name_e1_Weight100 := SALT37.Min0(le.prim_name_weight100 + 100*log(le.prim_name_cnt/le.prim_name_e1_cnt)/log(2)); // Precompute edit-distance specificity
  SELF.sec_range_weight100 := SALT37.Min0(le.sec_range_weight100); // Precompute the scale
  SELF.sec_range_e1_Weight100 := SALT37.Min0(le.sec_range_weight100 + 100*log(le.sec_range_cnt/le.sec_range_e1_cnt)/log(2)); // Precompute edit-distance specificity
  SELF := le;
END;
scaled := PROJECT(cfk,ProcessConceptScaling(left));
  RETURN scaled;
END;
