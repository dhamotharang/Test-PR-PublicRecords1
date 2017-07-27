// A document segment
EXPORT Layout_Segment := RECORD
	Types.Segment		segment;
	Types.Section		sect := 0;
	STRING					content{MAXLENGTH(2000)};
END;

