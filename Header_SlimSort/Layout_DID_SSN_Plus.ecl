export Layout_DID_SSN_Plus := 
RECORD
	unsigned6 did;
	qstring9 ssn;
	QSTRING4 ssn4;
	unsigned2 cnt;
	unsigned2 freq;
    unsigned8 __fpos {virtual(fileposition)};
END;