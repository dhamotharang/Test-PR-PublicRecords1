import BIPV2;
export Layout_FCC_base_bip := record
	FCC.Layout_FCC_base;
	BIPV2.IDlayouts.l_xlink_ids;
	unsigned8 source_rec_id := 0;
end;