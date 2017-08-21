//
// This attribute does not play a role in computing the PageRank. It was used to to get another view of the 
// data so the problem could be understood better.
//
export GenerateInlinks(DATASET(Mod_Data.Layout_Scores) initialdata) := FUNCTION
	RETURN SORT(
							PROJECT(initialdata, TRANSFORM(Mod_Data.Layout_Scores, SELF.FROM := LEFT.To; SELF.To := LEFT.From; SELF := LEFT)),
							from,to);
END;