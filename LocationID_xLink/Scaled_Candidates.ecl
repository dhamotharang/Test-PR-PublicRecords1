IMPORT SALT37;
EXPORT Scaled_Candidates(DATASET(layout_LocationId) le,DATASET(match_candidates(le).layout_candidates) cfk = Match_Candidates(le).candidates ) := FUNCTION
  RETURN cfk;
END;
