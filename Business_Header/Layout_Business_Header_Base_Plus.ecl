import Business_Header;
EXPORT Layout_Business_Header_Base_Plus := RECORD
	Business_Header.Layout_Business_Header_Base;
	UNSIGNED8 __filepos { virtual(fileposition) };
END;