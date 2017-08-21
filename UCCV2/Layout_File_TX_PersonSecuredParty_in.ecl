export Layout_File_TX_PersonSecuredParty_in :=  record
	string8			process_date;
	string1			transaction_code;
	string12		original_filing_number;
	string50		ps_last_name;
	string50		ps_first_name;
	string50		ps_middle_name;
	string6			ps_suffix;
	string110		ps_street_address;
	string64		ps_city;
	string2			ps_state;
	string8			ps_zip;
	string6			ps_zip_ext;
	string3			ps_country_code;
	string100		prep_addr_line1;
	string50		prep_addr_last_line; 					
end;