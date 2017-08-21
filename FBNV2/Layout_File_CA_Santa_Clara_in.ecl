export Layout_File_CA_Santa_Clara_in := module

	// export Sprayed := record
			// string90 field0;
			// string1  DEFENTITYID;
			// string2  crlf;
	// end;
	
	export Sprayed := record
    STRING9      file_number;
    STRING1      filing_type;
    STRING5      document_type;
    STRING100    business_names;
    STRING100    business_address_street;
    STRING30     business_address_city;
    STRING2      business_address_state;
    STRING10     business_address_zip;
    STRING2      business_type;
    STRING10     recording_date;
    STRING10     expiration_date;
    STRING75     registrant_name;
    STRING10     registrant_type;
    STRING100    registrant_address_street;
    STRING30     registrant_address_city;
    STRING2      registrant_address_state;
    STRING10     registrant_address_zip;
	end;
	
	export Cleaned := record
			string1   status:='';
			string8   process_date;
			string10  FILED_DATE:='';	
			string1   FBN_TYPE:='';	
		  string1 	FILING_TYPE:='';      	
			string50  BUSINESS_NAME:='';		
			string2   BUSINESS_TYPE:='';	
			string10  ORIG_FILED_DATE:='';		
			string10  ORIG_FBN_NUM:='';		
			string1   RECORD_CODE1:='';		
			string10  FBN_NUM:='';	 	
			string30  BUSINESS_ADDR1:='';	 	
			string1   RECORD_CODE2:='';	 	
			string30  BUSINESS_ADDR2:='';	 	
			string1   RECORD_CODE3:='';	 	
			string28  BUS_CITY:='';
			string2   BUS_ST:='';
			string10  BUS_ZIP:='';	 	
			string1   RECORD_CODE4:='';		
			string50  ADDTL_BUSINESS:='';		
			string1   RECORD_CODE5:='';
			string50  OWNER_NAME:='';	
			string10  OWNER_TYPE:='';	
			string1   RECORD_CODE6:='';	
      string100 OWNER_ADDR1:='';
			string50  OWNER_CITY:='';
			string10  OWNER_ST:='';
			string10  OWNER_ZIP:='';
			//string73 Clean_name:='';
			string5   Owner_title;
			string20  Owner_fname;
			string20  Owner_mname;
			string20  Owner_lname;
			string5   Owner_name_suffix;
			string3   Owner_name_score;
			string100 prep_addr_line1 :='';
			string50 	prep_addr_line_last :='';
			string100 prep_owner_addr_line1 :='';
			string50 	prep_owner_addr_line_last :='';
	end;
	
	//**** ABinitio cleaned layout to read the old prepprocessed file.
	export Cleaned_old := record
			string1  status:='';
			string8  process_date;
			string10 FILED_DATE:='';	
			string1  FBN_TYPE:='';	
			string50 BUSINESS_NAME:='';		
			string10 ORIG_FILED_DATE:='';		
			string10 ORIG_FBN_NUM:='';		
			string1  RECORD_CODE1:='';		
			string10 FBN_NUM:='';	 	
			string30 BUSINESS_ADDR1:='';	 	
			string1  RECORD_CODE2:='';	 	
			string30 BUSINESS_ADDR2:='';	 	
			string1  RECORD_CODE3:='';	 	
			string28 BUS_CITY:='';
			string2  BUS_ST:='';
			string10 BUS_ZIP:='';	 	
			string1  RECORD_CODE4:='';		
			string50 ADDTL_BUSINESS:='';		
			string1  RECORD_CODE5:='';
			string50 OWNER_NAME:='';	
			string1  RECORD_CODE6:='';	
			string73 Clean_name:='';
			string182 clean_address:='';

	end;
end;