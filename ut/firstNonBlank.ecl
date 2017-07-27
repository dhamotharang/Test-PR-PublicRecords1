EXPORT STRING firstNonBlank(STRING s1, STRING s2, STRING s3='', STRING s4='', STRING s5='', STRING s6='', STRING s7='', STRING s8='', STRING s9='') := FUNCTION
	RETURN MAP(
		s1<>'' => s1
		, s2<>'' => s2
		, s3<>'' => s3
		, s4<>'' => s4
		, s5<>'' => s5
		, s6<>'' => s6
		, s7<>'' => s7
		, s8<>'' => s8
		, s9<>'' => s9
		, ''
	);
END;