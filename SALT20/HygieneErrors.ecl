export HygieneErrors := MODULE
export Good := 'GOOD';
export NotLeft := 'Field not left justified';
export InQuotes(StrType s) := 'String is quoted using one of:'+s;
export NotCaps := 'String contains lower case characters';
export NotInChars(StrType s) := 'Contains characters not in:'+s;
export CustomFail(StrType s) := 'Failed the function:'+s;
export NotLength(StrType s) := 'Length was not in:'+s;
  END;
