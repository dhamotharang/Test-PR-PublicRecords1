import BIPV2;

export Layout_CA_Sales_Tax := record
	govdata.Layout_CA_Sales_Tax_IN;
	unsigned6	bdid;
	BIPV2.IDlayouts.l_xlink_ids;
	unsigned8 source_rec_id := 0;
end;
