import standard, dx_InquiryHistory;

EXPORT Layouts := Module

EXPORT Input := RECORD 

			STRING30	lex_id;
			STRING30	product_id;
			STRING8	  inquiry_date;
			STRING20	transaction_id;
			STRING22	date_added;
			STRING5	  customer_number;
			STRING9	  customer_account;
			STRING9	  ssn;
			STRING25	drivers_license_number;
			STRING2	  drivers_license_state;
			STRING20	name_first;
			STRING20	name_last;
			STRING20	name_middle;
			STRING20	name_suffix;
			STRING90	addr_street;
			STRING25	addr_city;
			STRING2	  addr_state;
			STRING5	  addr_zip5;
			STRING4	  addr_zip4;
			STRING8	  dob;
			STRING20	transaction_location;
			STRING3	ppc;
			STRING1	internal_identifier;
			STRING5	eu1_customer_number;
			STRING9	eu1_customer_account;
			STRING5	eu2_customer_number;
			STRING9	eu2_customer_account;
			
	END; 

EXPORT	Input_Extended :=   RECORD

			STRING state_id_number;
			STRING state_id_state;
			STRING phone_nbr;
			STRING email_addr;
			STRING ip_address; 
			STRING perm_purp_inq_type; 
			
			STRING120 eu_company_name;
			STRING90  eu_addr_street;
			STRING25  eu_addr_city;
			STRING2   eu_addr_state;
			STRING5   eu_addr_zip5;
			STRING10  eu_phone_nbr;
			
			STRING30 product_code;
	    STRING1  transaction_type;
	    STRING30 function_name;
	    STRING20 customer_id;
	    STRING20 company_id;
	    STRING20 global_company_id;

			unsigned4 filedate;

	END;

EXPORT Base    := record

    Input;
		Input_extended - filedate;

		STANDARD.NAME;				
		
		STANDARD.ADDR;
		
		string    datetime ; 
		UNSIGNED6	appended_did := 0;
		STRING		appended_ssn := '';

		string9 version     := '';
		unsigned4 filedate  := 0;
		
end;

end;