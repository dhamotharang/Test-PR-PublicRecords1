import standard, dx_InquiryHistory;

EXPORT Layouts := Module


// Input file layout  
EXPORT Input := RECORD 

		STRING30 lex_id;
		STRING30 product_id;
		STRING22 inquiry_date;
		STRING20 transaction_id;
		STRING22 date_added;
		STRING5  customer_number;
		STRING9  customer_account;
		STRING9  ssn;
		STRING25 drivers_license_number;
		STRING2  drivers_license_state;
		STRING20 name_first;
		STRING20 name_last;
		STRING20 name_middle;
		STRING20 name_suffix;
		STRING90 addr_street;
		STRING25 addr_city;
		STRING2  addr_state;
		STRING5  addr_zip5;
		STRING4  addr_zip4;
		STRING22  dob;
		STRING20 transaction_location;
		STRING3  ppc;
		STRING1  internal_identifier;
		STRING5  eu1_customer_number;
		STRING9  eu1_customer_account;
		STRING5  eu2_customer_number;
		STRING9  eu2_customer_account;
		STRING   email_addr;
		STRING   ip_address; 
		STRING   state_id_number;
		STRING   state_id_state;
		STRING120 eu_company_name;
		STRING90  eu_addr_street;
		STRING25  eu_addr_city;
		STRING2   eu_addr_state;
		STRING5   eu_addr_zip5;
		STRING10  eu_phone_nbr;
		STRING30  product_code;
		STRING1   transaction_type;
		STRING30  function_name;
		STRING20  customer_id;
		STRING20  company_id;
		STRING20  global_company_id;
		STRING    phone_nbr;
		STRING    report_options:='';
    string    filename{VIRTUAL(logicalfilename)};
	
END; 

// cleaned, formatted and appended fields layout
EXPORT Input_Formatted := record
			
			Input;
			
			STRING22	formatted_date_added;

			STRING9	  formatted_ssn;
			STRING    formatted_full_name;
			STRING    clean_name;
			STRING    formatted_addr_street;			
			STRING    formatted_addr_lastline;
			STRING22  formatted_dob;
			STRING 		formatted_phone_nbr;
			STRING10  formatted_eu_phone_nbr;
			
			STANDARD.NAME;				
		
		  STANDARD.ADDR;
			
			UNSIGNED6	appendadl 	:= 0;
			STRING		appendssn 	:= '';
			string    datetime    := ''; 
			string9 	version     := '';
		  unsigned4 filedate  	:= 0;
			

end;


// archive file layout 
EXPORT Input_History := record

		Input;
		unsigned4 first_filedate := 0;
		unsigned4 last_filedate  := 0;

END;

// Base layout 
EXPORT Base    := record

		Input - filename;

		STANDARD.NAME;				
  	STANDARD.ADDR;

		string    perm_purp_inq_type;

		string    datetime ; 
		UNSIGNED6	appended_did 	:= 0;
		STRING		appended_ssn 	:= '';

		string9 	version     	:= '';
		unsigned4 filedate  		:= 0;
		
end;

export ppc_mapping := record
	string FCRA_Product;
	string Legacy_FCRA_Purpose_Code;
	string Sunset;
	string FCRA_Permissible_Purpose_Current_Name;
	string Logging_Type;
	string New_Code;
	string FCRA_Permissible_Purpose_New_Name;
	string Disclosure_Period;
	boolean isAny:=false;
	boolean isEquifax:=false;
	boolean isGov:=false;
	boolean isCollection:=false;
	boolean isRiskview:=false;
end;

export Input_PPC_Xlated :=record
		Input_Formatted;
		string  newppc      		:= 'No xlated PPC Found';
		boolean isNewCode				:= false;
		boolean isAny    				:= false;
		boolean isEquifax				:= false;
		boolean isGov    				:= false;
		boolean isCollection		:= false;
		boolean isRiskview			:= false;
end;



end;