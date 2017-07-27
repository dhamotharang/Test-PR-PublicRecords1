import ebr, BIPV2;

export Layout_EBR_Search :=
RECORD
	unsigned penalt;
	unsigned6 bdid;
	BIPV2.IDlayouts.l_header_ids;
	EBR.Layout_0010_Header_In;
	string4 timezone;
END;