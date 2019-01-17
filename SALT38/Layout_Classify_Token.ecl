export Layout_Classify_Token := RECORD
  StrType TokenValue; // The field value - such as 'David'
	UNSIGNED2 TokenType; // Really the field number from the spc file
	UNSIGNED1 Spc; // The specificity (without the x100)
	UNSIGNED1 Pos := 1; // In the case of a multi-token string the position. Thus 'Alan' in 'David Alan Bayliss' would be 2
	UNSIGNED1 TokenCount := 1; // Number of tokens in the original donor string
	BOOLEAN FullMatch := FALSE; // Does this token match mirror the entire parse token
	BOOLEAN Verified := FALSE; // Does this token (or token group) represent a KNOWN multi-token entity
  END;
