Import BIPV2;

Export layout_DEA_Out_Base := record
	layout_DEA_In_modified - Activity;
	String18	county_name := '';
	String12	did;
	String3	score;
	String9	best_ssn;
	String12	bdid;
	BIPV2.IDlayouts.l_xlink_ids;		//Added for BIP project
	Unsigned8 source_rec_id := 0;  	//Added for BIP project
End;