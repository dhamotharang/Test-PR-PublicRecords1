IMPORT idl_header ; 
EXPORT Layout_Header_Delta := RECORD(idl_header.Layout_Header_Link)

	UNSIGNED1 RecChangeType;
  UNSIGNED  BuildDate;
	
END;