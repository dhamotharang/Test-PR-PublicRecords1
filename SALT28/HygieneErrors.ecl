#if (UseUnicode)
export HygieneErrors := MODULE
export Good := U'GOOD';
export NotLeft := U'Field not left justified';
export InQuotes(StrType s) := U'String is quoted using one of:'+s;
export NotCaps := U'String contains lower case characters';
export NotInChars(StrType s) := U'Contains characters not in:'+s;
export CustomFail(StrType s) := U'Failed the function:'+s;
export NotLength(StrType s) := U'Length was not in:'+s;
export NotWords(StrType s) := U'Word count was not in:'+s;
export NotInEnum(StrType s) := U'Value not in:'+s;
  END;
#else
export HygieneErrors := MODULE
export Good := 'GOOD';
export NotLeft := 'Field not left justified';
export InQuotes(StrType s) := 'String is quoted using one of:'+s;
export NotCaps := 'String contains lower case characters';
export NotInChars(StrType s) := 'Contains characters not in:'+s;
export CustomFail(StrType s) := 'Failed the function:'+s;
export NotLength(StrType s) := 'Length was not in:'+s;
export NotWords(StrType s) := 'Word count was not in:'+s;
export NotInEnum(StrType s) := 'Value not in:'+s;
  END;
#end
;			
