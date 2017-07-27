IMPORT SALT25;
EXPORT Scaled_Candidates(DATASET(layout_DOT_Base) le,DATASET(match_candidates(le).layout_candidates) cfk = Match_Candidates(le).candidates ) := FUNCTION
R := RECORD
  cfk;
END;
R ProcessConceptScaling(cfk le) := TRANSFORM
  REAL company_address_score_scale := le.company_address_weight100 / (le.company_addr1_weight100 + le.company_csz_weight100); // Scaling factor for this concept
  REAL company_addr1_score_scale := le.company_addr1_weight100 / (le.prim_range_weight100 + le.prim_name_weight100 + le.sec_range_weight100); // Scaling factor for this concept
  SELF.prim_range_weight100 := SALT25.Min0(le.prim_range_weight100* company_addr1_score_scale* company_address_score_scale); // Precompute the scale
  SELF.prim_name_weight100 := SALT25.Min0(le.prim_name_weight100* company_addr1_score_scale* company_address_score_scale); // Precompute the scale
  SELF.sec_range_weight100 := SALT25.Min0(le.sec_range_weight100* company_addr1_score_scale* company_address_score_scale); // Precompute the scale
  REAL company_csz_score_scale := le.company_csz_weight100 / (le.v_city_name_weight100 + le.st_weight100 + le.zip_weight100); // Scaling factor for this concept
  SELF.v_city_name_weight100 := SALT25.Min0(le.v_city_name_weight100* company_csz_score_scale* company_address_score_scale); // Precompute the scale
  SELF.st_weight100 := SALT25.Min0(le.st_weight100* company_csz_score_scale* company_address_score_scale); // Precompute the scale
  SELF.zip_weight100 := SALT25.Min0(le.zip_weight100* company_csz_score_scale* company_address_score_scale); // Precompute the scale
  SELF := le;
END;
scaled := project(cfk,ProcessConceptScaling(left));
  RETURN scaled;
END;
