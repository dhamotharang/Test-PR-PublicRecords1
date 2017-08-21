import corp2,AID,BIPv2;

EXPORT Layout_Corporate_Direct_Cont_Base_Expanded := record
	Corp2.Layout_Corporate_Direct_Cont_Base;
	unsigned2	 	Cont_Owner_Percentage;
	string50 		Cont_Country;
	string50 		Cont_Country_Mailing;
	string1			Cont_Nondislosure;
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