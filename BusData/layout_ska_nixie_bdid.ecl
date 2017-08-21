import BIPV2;
export layout_ska_nixie_bdid := record
	unsigned6	bdid;
	busdata.layout_ska_nixie_in;
	BIPV2.IDlayouts.l_xlink_ids;
	unsigned8 source_rec_id := 0;
end;
