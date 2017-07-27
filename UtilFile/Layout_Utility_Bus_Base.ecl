import bipv2;

export Layout_Utility_Bus_Base := record
   UtilFile.Layout_Utility_In;
	 string100	company_name := '';
	 string12   bdid := '';
	 unsigned1	bdid_score := 0;   //Added for BIP project
	 string2		source := '';
	 bipv2.IDlayouts.l_xlink_ids;	 //Added for BIP project
	 unsigned8 source_rec_id := 0; //Added for BIP project	
end;
