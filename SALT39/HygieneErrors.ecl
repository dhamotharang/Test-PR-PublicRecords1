#if (UnicodeCfg.UseUnicode)
EXPORT HygieneErrors := MODULE
EXPORT Good := U'GOOD';
EXPORT NotLeft := U'Field not left justified';
EXPORT InQuotes(StrType s) := U'String is quoted using one of:'+s;
EXPORT NotCaps := U'String contains lower case characters';
EXPORT NotInChars(StrType s) := U'Contains characters not in:'+s;
EXPORT CustomFail(StrType s) := U'Failed the function:'+s;
EXPORT NotLength(StrType s) := U'Length was not in:'+s;
EXPORT NotWords(StrType s) := U'Word count was not in:'+s;
EXPORT NotInEnum(StrType s) := U'Value not in:'+s;
EXPORT NotInRange(StrType s) := U'Value not in range:'+s;
EXPORT NotWithinFile(StrType s) := U'Value not within file field values:'+s;
  END;
#else
EXPORT HygieneErrors := MODULE
EXPORT Good := 'GOOD';
EXPORT NotLeft := 'Field not left justified';
EXPORT InQuotes(StrType s) := 'String is quoted using one of:'+s;
EXPORT NotCaps := 'String contains lower case characters';
EXPORT NotInChars(StrType s) := 'Contains characters not in:'+s;
EXPORT CustomFail(StrType s) := 'Failed the function:'+s;
EXPORT NotLength(StrType s) := 'Length was not in:'+s;
EXPORT NotWords(StrType s) := 'Word count was not in:'+s;
EXPORT NotInEnum(StrType s) := 'Value not in:'+s;
EXPORT NotInRange(StrType s) := 'Value not in range:'+s;
EXPORT NotWithinFile(StrType s) := 'Value not within file field values:'+s;
  END;
#end
;			
