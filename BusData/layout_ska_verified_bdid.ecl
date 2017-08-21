import BIPV2;
export layout_ska_verified_bdid := record
	unsigned6	bdid;
	layout_ska_verified_in;
	BIPV2.IDlayouts.l_xlink_ids;
	unsigned8 source_rec_id := 0;	
end;
