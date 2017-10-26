EXPORT Layout_College_Major_Mapping_In := RECORD

	STRING		MAJOR;					// major defined in OKC student list
	STRING1		MAJOR_CODE;			// 1 BYTE MAJOR CODE DEFINED IN ASL
	STRING4		NEW_MAJOR_CODE;	// 4 BYTE NEW MAJOR CODE DEFINED IN ASL
	UNSIGNED8	MAJOR_COUNT;		// Not used. # of students major in this field

END;