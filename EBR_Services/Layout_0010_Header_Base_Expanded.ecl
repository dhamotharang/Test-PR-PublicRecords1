import ebr;

export Layout_0010_Header_Base_Expanded :=
RECORD
	ebr.Layout_0010_Header_Base;
	string4 timezone;
	string18 county_name := '';
END;