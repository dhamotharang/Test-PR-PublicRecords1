import BIPV2;

export layout_DEA_Out_BaseV2 := record
	layout_DEA_In_modified;
	string18		county_name := '';
	unsigned8		nid;
	unsigned8		rawaid;
	string12		did;
	string3			score;
	integer2		xadl2_weight 				:= 0;
	unsigned2		xadl2_score	 				:= 0;
	integer1		xadl2_distance			:= 0;
	unsigned4		xadl2_keys_used			:= 0;
	string			xadl2_keys_desc			:= '';
	string60		xadl2_matches				:= '';
	string			xadl2_matches_desc	:= '';	
	string9			best_ssn;
	string12		bdid;
	BIPV2.IDlayouts.l_xlink_ids;		//Added for BIP project
  unsigned8 	source_rec_id := 0;  	//Added for BIP project
	unsigned8 	lnpid;
end;