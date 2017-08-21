export Layout_File_TX_PersonDebtor_in	:=	record
	string8     process_date;
	string1     transaction_code;
	string12    original_filing_number;
	string50    pd_last_name;
	string50    pd_first_name;
	string50    pd_middle_name;
	string6     pd_suffix;
	string110   pd_street_address;
	string64    pd_city;
	string2     pd_state;
	string8     pd_zip;
	string6     pd_zip_ext;
	string3     pd_country_code;
	string100		prep_addr_line1;
	string50		prep_addr_last_line; 		
end;