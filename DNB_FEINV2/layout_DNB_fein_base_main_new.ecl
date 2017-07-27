import dnb_feinv2,BIPV2;

export layout_DNB_fein_base_main_new := 
	record
		DNB_FEINV2.layout_DNB_fein_base_main;
		unsigned8	raw_aid								:=  0;
		unsigned8	ace_aid								:=  0;
		string100 prep_addr_line1				:= '';
		string50	prep_addr_line_last		:= '';
	  unsigned8	source_rec_id 		    :=  0;
		BIPV2.IDlayouts.l_xlink_ids;
end;