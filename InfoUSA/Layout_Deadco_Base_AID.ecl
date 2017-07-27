import AID,bipv2;

export Layout_Deadco_Base_AID := record
  unsigned8	source_rec_id;
	BIPV2.IDlayouts.l_xlink_ids;	
	InfoUSA.Layout_deadco_Base;
	AID.Common.xAID	Append_RawAID;
	AID.Common.xAID	Append_ACEAID;
	string100	prep_addr_line1;
	string50	prep_addr_last_line;	
end;