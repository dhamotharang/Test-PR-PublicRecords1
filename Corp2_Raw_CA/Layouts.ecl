EXPORT Layouts := module
	
  EXPORT MastLayoutIN := RECORD
    STRING5 	Transaction_Julian_Date;
    STRING8 	Corp_Number;
    STRING8 	Incorp_Date;
    STRING1 	Corp_Status;
    STRING4 	Corp_Type;
    STRING1 	Corp_Tax_base;
    STRING2 	Corp_Classification;
    STRING11 	Filler;
    STRING8 	Term_Expiration_Date;
    STRING1 	FTB_Suspen_Status_Code;
    STRING8 	FTB_Suspen_Date;
    STRING7 	Statement_of_Officers_File_Num;
    STRING6 	Statement_of_File_Date;
    STRING350 Corp_Name;
    STRING50 	Care_of_Name;
		STRING40 	Mail_Address1;
    STRING40 	Mail_Address2;
    STRING24 	Mail_Address_City;
    STRING15 	Mail_Address_State;
    STRING10 	Mail_Address_ZipCode;
    STRING50 	President_Name;
    STRING40 	President_Address1;
    STRING40 	President_Address2;
    STRING24 	President_Address_City;
    STRING15 	President_Address_State;
    STRING10 	President_Address_ZipCode;
    STRING350 Agent_Name;
    STRING40 	Agent_Address1;
    STRING40 	Agent_Address2;
    STRING24 	Agent_Address_City;
    STRING15 	Agent_Address_State;
    STRING10 	Agent_Address_ZipCode;
    STRING24 	State_Foreign_Country;
		String1   filler1;
  END;
 
 	EXPORT MastLayoutBASE := RECORD
		 string1		action_flag;
		 unsigned4	dt_first_received;
		 unsigned4	dt_last_received;		
		 MastLayoutIN;
	END;	
 
  EXPORT HistLayoutIN:= RECORD
    STRING5 	Transaction_Julian_Date;
    STRING8 	Corp_Number;
    STRING4 	Transaction_Code;
    STRING8 	Transaction_Date;
    STRING2 	Amendment_Page_Count;
    STRING30 	Comment;
    STRING8 	Document_Number;
    STRING8 	Name_Corp_Number;
    STRING350 Old_Corp_Name;
		String1   filler;
  END; 
 
  EXPORT HistLayoutBASE := RECORD
		 string1		action_flag;
		 unsigned4	dt_first_received;
		 unsigned4	dt_last_received;		
		 HistLayoutIN;
	END;

 EXPORT LPLayoutIN:= RECORD
    STRING12 	file_number;
    STRING8 	file_date;
    STRING1 	status;
    STRING1 	filing_type;
    STRING220 name;
    STRING40 	mailing_address;  
    STRING24 	mailing_city;
    STRING2 	mailing_state;
    STRING10 	mailing_zip;
    STRING40 	calif_address;   
    STRING22 	calif_city;
    STRING2 	calif_state;
    STRING10 	calif_zip;
    STRING20 	original_file_number;
    STRING8 	original_file_date;
    STRING2 	original_jurisdiction;
    STRING65 	agent_name;
    STRING40 	agent_address1;   
    STRING40 	agent_address2;
    STRING24 	agent_city;
    STRING2 	agent_state;
    STRING10 	agent_zip;
    STRING20 	term;
    STRING2 	number_gp_amend;
    STRING3 	number_amendments;
    STRING5 	total_pages;
    STRING2 	addl_gp;
    STRING140 gpmm1_name;
    STRING40 	gpmm1_address;
    STRING24 	gpmm1_city;
    STRING2 	gpmm1_state;
    STRING10 	gpmm1_zip;
    STRING140 gpmm2_name;
    STRING40 	gpmm2_address;
    STRING24 	gpmm2_city;
    STRING2 	gpmm2_state;
    STRING10 	gpmm2_zip;
    STRING2 	llc_jurisdiction;
    STRING1 	llc_mgmt_code;
    STRING40 	llc_business_type;
	  STRING345	filler;
  END;
	
  EXPORT LPLayoutBASE := RECORD
		 string1		action_flag;
		 unsigned4	dt_first_received;
		 unsigned4	dt_last_received;		
		 LPLayoutIN;
	END;
	
	
// Layouts for Normalizing
	
	EXPORT normContactLayout := RECORD
		 LPLayoutIn;
		 string140 norm_name;
		 string40  norm_address;
		 string24  norm_city;
		 string2 	 norm_state;
		 string10  norm_zip;
	END;	
	
	EXPORT normEventLayout := RECORD
		 MastLayoutIn;
		 string norm_event_cd;
  	 string norm_event_date;
		 string norm_event_ref;
		 string norm_type;
		 string norm_keep;
	END;					

END;
