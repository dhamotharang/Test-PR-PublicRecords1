IMPORT lib_StringLib, STD;
EXPORT CleanData := MODULE
  EXPORT Name  := '\\||@|#|\\$|%|\\&|\\*|\\(|\\)|\\+|_|=|"|:|;|!|\\{|\\}|,|\\.|/|\\?|~|`|\\\\|<|>|0x00|0xFF|\\[|\\]|0|1|2|3|4|5|6|7|8|9|^';
  EXPORT DL_No := '-|@|#|\\$|%|\\&|\\*|\\(|\\)|_|\\+|=|:|;|!|\\}|\\{|,|\\.|/|\\?|\\||\\\\|<|>|"|`|\'|~|0x00|0xFF|0xBA|0xBB|0x5B|0x5D';
	EXPORT STRING	fReplaceUnprintable(STRING pStringIn)	:=	regexreplace('[^[:print:]]', pStringIn, ' ');
	EXPORT STRING	fUpperCleanSpaces(STRING pStringIn)	:=	lib_StringLib.StringLib.StringToUpperCase(lib_StringLib.StringLib.StringCleanSpaces(pStringIn));
	SHARED sRegexPattern 	:= '^[^a-zA-Z]+';
	SHARED sDashPattern 	:= '^[\\-]+$';
	EXPORT ALPHA_NUMERIC  := '^[a-zA-Z0-9]+$';
	EXPORT STRING RemoveLeadingSpecialChar 	(STRING pStringIn)	:=  REGEXREPLACE(sRegexPattern,STD.Str.CleanSpaces(pStringIn),'',NOCASE);
	EXPORT STRING RemoveTrailingSpecialChar (STRING pStringIn)	:=	STD.Str.Reverse(REGEXREPLACE(sRegexPattern,STD.Str.CleanSpaces(STD.Str.Reverse(pStringIn)),'',NOCASE));
	EXPORT STRING	fRemoveLeadingTrailingSpecialChar (STRING pStringIn)	:=	RemoveTrailingSpecialChar(RemoveLeadingSpecialChar (pStringIn));
	EXPORT STRING	fRemoveALLDash (STRING pStringIn)	:=	REGEXREPLACE(sDashPattern,STD.Str.CleanSpaces(pStringIn),'',NOCASE);
END;