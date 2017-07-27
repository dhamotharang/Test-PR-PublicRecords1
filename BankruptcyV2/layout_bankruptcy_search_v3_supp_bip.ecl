import bipv2;
export layout_bankruptcy_search_v3_supp_bip := record
	bankruptcyv2.layout_bankruptcy_search_v3_supp;
	bipv2.IDlayouts.l_xlink_ids;	 //Added for BIP project
  unsigned8 source_rec_id := 0;  //Added for BIP project
	unsigned8  ScrubsBits1 := 0 ; 
end;