import AID, BIPV2;

export Layout_ABIUS_Company_Base_AID := record,maxlength(409600) 
      BIPV2.IDlayouts.l_xlink_ids;	//Added for BIP project	
			unsigned8 source_rec_id := 0; //Added for BIP project	
			InfoUSA.Layout_ABIUS_Company_Base;
			AID.Common.xAID	Append_RawAID;
			AID.Common.xAID	Append_ACEAID;
			string100	prep_addr_line1;
			string50	prep_addr_last_line;	
end;
