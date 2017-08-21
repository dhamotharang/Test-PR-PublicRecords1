import BIPV2;
export Layout_Whois_Base_BIP := record
	Layout_Whois_Base;
	unsigned8 source_rec_id 	 :=0 ;
	BIPV2.IDlayouts.l_xlink_ids;
end;