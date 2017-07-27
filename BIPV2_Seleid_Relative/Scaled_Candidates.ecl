IMPORT SALT30;
EXPORT Scaled_Candidates(DATASET(layout_Base) le,DATASET(match_candidates(le).layout_candidates) cfk = Match_Candidates(le).candidates ) := FUNCTION
  RETURN cfk;
END;
