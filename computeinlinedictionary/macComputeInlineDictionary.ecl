EXPORT macComputeInlineDictionary(keyValueString, pairSeparator, keyValueSeparator) := FUNCTIONMACRO
	IMPORT STD;
	
	strData := if((string)keyValueString <> '',
		'[{\'' + REGEXREPLACE('<>', STD.str.FindReplace(REGEXREPLACE((string)pairSeparator, (string)keyValueString, '<>'), (string)keyValueSeparator ,'\',\''), '\'},{\'') + '\'}' + ']',
		'[]');
		
	dKeyValue := #EXPAND('DATASET(' + strData +', {STRING code, STRING description})');
		
	RETURN dKeyValue;
ENDMACRO;