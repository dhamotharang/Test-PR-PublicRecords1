
IMPORT header;

EXPORT layout_header_plus_seq := RECORD
	UNSIGNED6 seq    := 0;
	header.Layout_Header;
END;