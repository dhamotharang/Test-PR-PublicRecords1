export Scaled_Candidates(dataset(layout_PersonHeader) le) := FUNCTION
cfk := Match_Candidates(le).candidates; //The input file - distributed by PersonHeader
R := RECORD
  cfk;
  unsigned2 NAME_SUFFIX_e2_Weight100;
  unsigned2 FNAME_p_Weight100;
  unsigned2 FNAME_e2_Weight100;
  unsigned2 FNAME_e2p_Weight100;
  unsigned2 FNAME_PreferredName_Weight100;
  unsigned2 MNAME_e2_Weight100;
  unsigned2 LNAME_p_Weight100;
  unsigned2 LNAME_e2_Weight100;
  unsigned2 LNAME_e2p_Weight100;
  unsigned2 PRIM_RANGE_e1_Weight100;
  unsigned2 PRIM_NAME_e1_Weight100;
END;
R ProcessConceptScaling(cfk le) := transform
  real FULLNAME_score_scale := 1.0; // No scaling required
  real MAINNAME_score_scale := 1.0; // No scaling required
  self.FNAME_weight100 := le.FNAME_weight100; // Precompute the scale
  SELF.FNAME_p_Weight100 := le.FNAME_weight100 + 100*log(le.FNAME_cnt/le.FNAME_p_cnt)/log(2); // Precompute phonetic specificity
  SELF.FNAME_e2_Weight100 := le.FNAME_weight100 + 100*log(le.FNAME_cnt/le.FNAME_e2_cnt)/log(2); // Precompute edit-distance specificity
  SELF.FNAME_e2p_Weight100 := le.FNAME_weight100 + 100*log(le.FNAME_cnt/le.FNAME_e2p_cnt)/log(2); // Precompute phonetic & edit_distance specificity
  SELF.FNAME_PreferredName_Weight100 := le.FNAME_weight100 + 100*log(le.FNAME_cnt/le.FNAME_PreferredName_cnt)/log(2); // Precompute PreferredName specificity
  self.MNAME_weight100 := le.MNAME_weight100; // Precompute the scale
  SELF.MNAME_e2_Weight100 := le.MNAME_weight100 + 100*log(le.MNAME_cnt/le.MNAME_e2_cnt)/log(2); // Precompute edit-distance specificity
  self.LNAME_weight100 := le.LNAME_weight100; // Precompute the scale
  SELF.LNAME_p_Weight100 := le.LNAME_weight100 + 100*log(le.LNAME_cnt/le.LNAME_p_cnt)/log(2); // Precompute phonetic specificity
  SELF.LNAME_e2_Weight100 := le.LNAME_weight100 + 100*log(le.LNAME_cnt/le.LNAME_e2_cnt)/log(2); // Precompute edit-distance specificity
  SELF.LNAME_e2p_Weight100 := le.LNAME_weight100 + 100*log(le.LNAME_cnt/le.LNAME_e2p_cnt)/log(2); // Precompute phonetic & edit_distance specificity
  self.NAME_SUFFIX_weight100 := le.NAME_SUFFIX_weight100; // Precompute the scale
  SELF.NAME_SUFFIX_e2_Weight100 := le.NAME_SUFFIX_weight100 + 100*log(le.NAME_SUFFIX_cnt/le.NAME_SUFFIX_e2_cnt)/log(2); // Precompute edit-distance specificity
  real ADDRS_score_scale := 1.0; // No scaling required
  real ADDR1_score_scale := 1.0; // No scaling required
  self.PRIM_RANGE_weight100 := le.PRIM_RANGE_weight100; // Precompute the scale
  SELF.PRIM_RANGE_e1_Weight100 := le.PRIM_RANGE_weight100 + 100*log(le.PRIM_RANGE_cnt/le.PRIM_RANGE_e1_cnt)/log(2); // Precompute edit-distance specificity
  self.PRIM_NAME_weight100 := le.PRIM_NAME_weight100; // Precompute the scale
  SELF.PRIM_NAME_e1_Weight100 := le.PRIM_NAME_weight100 + 100*log(le.PRIM_NAME_cnt/le.PRIM_NAME_e1_cnt)/log(2); // Precompute edit-distance specificity
  self.SEC_RANGE_weight100 := le.SEC_RANGE_weight100; // Precompute the scale
  self.ZIP4_weight100 := le.ZIP4_weight100; // Precompute the scale
  real LOCALE_score_scale := 1.0; // No scaling required
  self.COUNTY_weight100 := le.COUNTY_weight100; // Precompute the scale
  self.CITY_weight100 := le.CITY_weight100; // Precompute the scale
  self.STATE_weight100 := le.STATE_weight100; // Precompute the scale
  self.ZIP_weight100 := le.ZIP_weight100; // Precompute the scale
  SELF := le;
END;
scaled := project(cfk,ProcessConceptScaling(left));
  RETURN scaled;
END;
