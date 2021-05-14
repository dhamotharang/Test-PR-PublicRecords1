export Layout_File_CA_BusinessDebtor_in := record
	string8    	process_date;
	string14  	initial_filing_number;    //ucc1_num
	string14  	filing_number;            //ucc3_num
	string300  	bd_name;                  //org_name
	string110  	bd_st_address;            //addr1,addr2,addr3
	string64   	bd_city;                  //city
	string32   	bd_state;                 //state
	string15   	bd_zip;                   //postal_code
	string6    	bd_zip_extn;
	string25  	bd_country;
	string100		prep_addr_line1;
	string50		prep_addr_last_line;
end;