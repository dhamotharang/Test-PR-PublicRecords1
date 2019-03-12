Import BIPV2;

Export layout_DEA_Out_Base := record
	layout_DEA_In_modified - Activity;
	String18		county_name := '';
	String12		did;
	String3			score;
	integer2		xadl2_weight 				:= 0;
	unsigned2		xadl2_score	 				:= 0;
	integer1		xadl2_distance			:= 0;
	unsigned4		xadl2_keys_used			:= 0;
	string			xadl2_keys_desc			:= '';
	string60		xadl2_matches				:= '';
	string			xadl2_matches_desc	:= '';	
	String9			best_ssn;
	String12		bdid;
	BIPV2.IDlayouts.l_xlink_ids;		//Added for BIP project
	Unsigned8 	source_rec_id := 0;  	//Added for BIP project
End;