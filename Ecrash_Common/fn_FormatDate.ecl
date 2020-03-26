IMPORT STD;
EXPORT STRING8 fn_FormatDate (STRING19 StrDate) := FUNCTION
	UNSIGNED4 uDate := (UNSIGNED4) STD.Str.FilterOut(StrDate[1..10],'-');
	STRING8 FormattedDate := IF(uDate != 0, STD.Str.FilterOut(StrDate[1..10],'-'), '');
	RETURN FormattedDate;
END;