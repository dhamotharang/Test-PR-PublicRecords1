export Layout_ClassifyResponse := RECORD,maxlength(16000)
  string Input;
	string CleanedInput;
	unsigned1 WordCount;
	unsigned1 IsCity := 0;
	unsigned1 IsCompany := 0;
	unsigned1 IsPerson := 0;
  string ParseTokens := '';
	unsigned2 ParsePlace := 0;
	unsigned1 ParseScore := 0;
	boolean PartialCompany := FALSE;
	boolean VerifiedCompany := FALSE;
	boolean VerifiedPerson := FALSE;
  END;