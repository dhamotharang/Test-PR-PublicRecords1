//6 is the length of the field in the key, so that is why we limit to 6 chars (see bug 23233)
export phoneticLnameMatch(STRING6 lname_rec, STRING lname_in) := FUNCTION //the former is the value in the key.  the latter is the user input
	p := (string6)(metaphonelib.DMetaPhone1(lname_in));
	RETURN p <> '' and lname_rec = p;
END;