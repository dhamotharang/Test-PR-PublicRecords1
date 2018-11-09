IMPORT idl_header ; 
EXPORT Layout_Header_Plus := RECORD(idl_header.Layout_Header_Link)

	UNSIGNED1 RecChangeType;

END;