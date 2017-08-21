/*
	This function takes in a 'delimted' string, splits it by delimter and returns the split strings as a dataset.
		@p1 - delimited string to parse
		@p2 - delimiter. default is comma
	
		RETURN: Dataset of "OutString"s
						LAYOUT: "Layout_ParseOut := RECORD STRING outString; END;"
*/
IMPORT lib_stringlib;

EXPORT getDelimitedStrings(STRING pDelimtedStr, STRING pDelimiter=',') := FUNCTION
	Layout_ParseIn := RECORD
		STRING line;
	END;

	Layout_ParseOut := RECORD
		STRING outString;
	END; 
	Delimiter := TRIM(pDelimiter, LEFT, RIGHT);
	DelimtedStr := IF(Delimiter = ',', pDelimtedStr, lib_stringlib.stringlib.StringFindReplace(pDelimtedStr, Delimiter, ','));

	ParseStr(DATASET(Layout_ParseIn) dsIn) := FUNCTION
	 Layout_ParseOut xOut(dsIn L, INTEGER cnt) := TRANSFORM
		SELF.outString := lib_stringlib.stringlib.StringExtract(L.line, cnt);
	 END;
	 dsOut := NORMALIZE(dsIn, lib_stringlib.stringlib.StringFindCount(LEFT.line, ',') + 1, xOut(LEFT, COUNTER));
	 RETURN dsOut;
	END; //ParseStr
	Items 	:= ParseStr(DATASET([DelimtedStr], Layout_ParseIn));
	
	RETURN Items;
END;