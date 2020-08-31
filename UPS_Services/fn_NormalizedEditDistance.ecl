// Compute a normalized score (0..range, 0..100 by default) for two strings,
// s1 and s2. The score is based on the edit distance relative to the
// length of the two strings, as described below. A score of 0 is a poor
// match and a score of 'range' (100) is a perfect match.
//
// Edit distance returns a value between 0 (exact match) and k, where k is
// the length of the longer of the two strings being compared. Normalize
// this value so that it's on a scale of 0..1 (by dividing by the length
// of the longer string), and invert it so that higher values represent
// stronger matches (ie, 1 - n, where n is the normalized edit distance).
// Finally, multiply by 100 to convert the REAL value (0..1) to an integer
// score (0..100), truncating any fractional part left over from the
// division.
IMPORT STD;

EXPORT UNSIGNED2 fn_NormalizedEditDistance(STRING s1_mc, STRING s2_mc, UNSIGNED2 rng = Constants.DEFAULT_RANGE) := FUNCTION
  STRING s1 := STD.STR.ToUpperCase(s1_mc);
  STRING s2 := STD.STR.ToUpperCase(s2_mc);
  REAL edist := STD.STR.EditDistance(s1, s2); // edit distance
  REAL maxlen := MAX(LENGTH(TRIM(s1)), LENGTH(TRIM(s2))); //  max length
  REAL nedist := edist / maxlen; // norm edit dist (0..1)
  REAL score := (1.0 - nedist) * rng; // invert score so that 0 = bad and 1 = good

  RETURN (UNSIGNED2) score;
END;
