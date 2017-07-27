import AID, BIPV2;

export Layout_Corporate_Direct_Corp_AID := record
	unsigned8 Source_rec_id							:= 0;	
	Corp2.Layout_Corporate_Direct_Corp_Base;
	AID.Common.xAID	Append_Addr1_RawAID;
	AID.Common.xAID	Append_Addr1_ACEAID;
	string100	corp_prep_addr1_line1;
	string50	corp_prep_addr1_last_line;
	AID.Common.xAID	Append_Addr2_RawAID;	
	AID.Common.xAID	Append_Addr2_ACEAID;
	string100	corp_prep_addr2_line1;
	string50	corp_prep_addr2_last_line;
	AID.Common.xAID	Append_RA_RawAID;
	AID.Common.xAID	Append_RA_ACEAID;
	string100	RA_prep_addr_line1;
	string50	RA_prep_addr_last_line;
	BIPV2.IDlayouts.l_xlink_ids;
end;