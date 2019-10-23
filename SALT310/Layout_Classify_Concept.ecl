export Layout_Classify_Concept := RECORD
  UNSIGNED4 ConceptHash; // The HASH32 of the concept in question
	UNSIGNED2 TokenType; // Really the field number from the spc file
	UNSIGNED1 Spc; // The specificity (without the x100)
	UNSIGNED1 Pos := 1; // In the case of a multi-token string the position. Thus 'Alan' in 'David Alan Bayliss' would be 2
	UNSIGNED1 TokenCount := 1; // Number of tokens in the original donor string
  END;
