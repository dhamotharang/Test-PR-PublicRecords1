EXPORT Layout_OprndRec := RECORD
	STRING							word{MAXLENGTH(255)};
	Types.WordType			typ;
	STRING							segName{MAXLENGTH(255)};
	Types.NominalFilter	filterType;
	Types.DateRangeType	rangeType;
	BOOLEAN							sprsEqv := FALSE;
	BOOLEAN							drctExp := FALSE;
END;