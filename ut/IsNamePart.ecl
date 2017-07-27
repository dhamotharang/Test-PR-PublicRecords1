// Identifies whether a word is a part of a phrase.

// Name is a part of compound name, if it exists in the target string and has delimeter(s)
// on either left or right sides or both.

// I don't won't to do trimming and case casting inside, since it can be very inefficient,
// so it's a caller responsibility (and hence no default).

EXPORT IsNamePart (string target, string lname, boolean CaseSensitive) := FUNCTION
  //ptrn := '[ \\-,&\'\\t;/()]';
  // won't delimiters set as a stand along string to minimize string concatenations.

  // check for the characters which can break regexp:
  str_clean := stringlib.StringFilterOut (lname, '()/;+');
  IsInvalidName := length (str_clean) < length (lname);

  reg_exp := '(^' + lname + '[ \\-,&\'\\t;/()])|(' + '[ \\-,&\'\\t;/()]' + lname + '$)|([ \\-,&\'\\t;/()]' + lname + '[ \\-,&\'\\t;/()])';
  // i.e. '(^SMITH[ \\-,&\'\\t;/()])|(' + '[ \\-,&\'\\t;/()]SMITH$)|([ \\-,&\'\\t;/()]SMITH[ \\-,&\'\\t;/()])';

  res := if (CaseSensitive, regexfind (reg_exp, target), regexfind (reg_exp, target, nocase));
  return if (IsInvalidName, false, res);
END;