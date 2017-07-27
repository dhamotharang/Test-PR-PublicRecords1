import aid,BIPv2;

Export Layout_IRS5500_AID := RECORD
	IRS5500.Layout_IRS5500_Base;
	UNSIGNED8 source_rec_id	:=  0;  //Added for BIP2V2 project
	BIPV2.IDlayouts.l_xlink_ids;		//Added for BIP2V2 project		
	AID.Common.xAID	Raw_AID;
	AID.Common.xAID	ACE_AID;
	string100	spons_prep_addr_line1;
	string50	spons_prep_addr_line_last;

end;