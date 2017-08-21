import address,AID;
export Layout_BK_AID := record
	string50   	TMSID;
	string8    	process_date;
	string1	file_flag;
	string100 address_line_1;
	string50 address_line_last;
	address.Layout_Clean182 clean_address;
	address.Layout_Clean182 AID_Clean_Address;
	AID.Common.xAID Append_RawAID := 0;
end;