export Layout_File_TX_BusinessSecuredParty_in := record
	string8			process_date;
	string1			transaction_code;
	string12		original_filing_number;
	string300 	bs_name;
	string110 	bs_street_address;
	string64		bs_city;
	string2			bs_state;
	string8			bs_zip;
	string6			bs_zip_ext;
	string3			bs_country_code;
	string100		prep_addr_line1;
	string50		prep_addr_last_line; 					
end;