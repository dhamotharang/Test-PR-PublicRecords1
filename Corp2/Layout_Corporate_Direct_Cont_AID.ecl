import AID,bipv2;

export Layout_Corporate_Direct_Cont_AID := record
	Corp2.Layout_Corporate_Direct_Cont_Base;
	AID.Common.xAID	Append_Corp_Addr_RawAID;
	AID.Common.xAID	Append_Corp_Addr_ACEAID;
	string100	corp_prep_addr_line1;
	string50	corp_prep_addr_last_line;
	AID.Common.xAID	Append_Cont_Addr_RawAID;	
	AID.Common.xAID	Append_Cont_Addr_ACEAID;
	string100	cont_prep_addr_line1;
	string50	cont_prep_addr_last_line;
	BIPV2.IDlayouts.l_xlink_ids;	
end;