EXPORT Layout_Header_Word_Index := RECORD
	STRING120 word;
	STRING2   state;
	UNSIGNED1 seq;
	UNSIGNED8 bh_filepos;
	UNSIGNED6 bdid;
END;