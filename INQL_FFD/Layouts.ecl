import standard, dx_InquiryHistory, iesp;

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
		unsigned8 group_rid     := 0;
		
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

export Input_Encrypted :=record
		string transaction_id;
    string key_version;
    string text_1;
    string text_2;
    string key_encrypted;
    string time_stamp;
    string key_group;
end;

export Comomn_Input_Encrypted :=record
		string transaction_id;
    string key_version;
    string text;
    string key_encrypted;
    string time_stamp;
    string key_group;
end;

EXPORT Decrypted_Keys := RECORD
    string key_group;
    string key_version;
    string key_encrypted;
    string key_decrypted;
  END;

// EXPORT Decrypted_Text := RECORD(Comomn_Input_Encrypted)
EXPORT Decrypted_Text := RECORD
    Comomn_Input_Encrypted;
		string key_decrypted;
    string2048 text_decrypted;
END;

EXPORT Decrypted_Data := RECORD
		string transaction_id{xpath('transaction_id')};	
		string lex_id{xpath('lex_id')};
		string	ssn{xpath('ssn')};
		string	drivers_license_number{xpath('drivers_license_number')};
		string	drivers_license_state{xpath('drivers_license_state')};
		string	name_first{xpath('name_first')};
		string	name_last{xpath('name_last')};
		string	name_middle{xpath('name_middle')};
		string	name_suffix{xpath('name_suffix')};
		string	addr_street{xpath('addr_street')};
		string	addr_city{xpath('addr_city')};
		string	addr_state{xpath('addr_state')};
		string	addr_zip5{xpath('addr_zip5')};
		string	addr_zip4{xpath('addr_zip4')};
		string	dob{xpath('dob')};
		string	email_address{xpath('email_address')};
		string	state_id_number{xpath('state_id_number')};
		string	state_id_state{xpath('state_id_state')};
		string	eu_company_name{xpath('eu_company_name')};
		string	eu_address_street{xpath('eu_address_street')};
		string	eu_address_city{xpath('eu_address_city')};
		string	eu_address_state{xpath('eu_address_state')};
		string	eu_address_zip5{xpath('eu_address_zip5')};
		string	eu_address_phone{xpath('eu_address_phone')};
		string	phone{xpath('phone')};
END;

EXPORT Input_Decrypted := record
		Comomn_Input_Encrypted;
		string key_decrypted;
		unsigned appended_did;
		string	ssn;
		string	drivers_license_number;
		string	drivers_license_state;
		string	name_first;
		string	name_last;
		string	name_middle;
		string	name_suffix;
		string	addr_street;
		string	addr_city;
		string	addr_state;
		string	addr_zip5;
		string	addr_zip4;
		string	dob;
		string	email_address;
		string	state_id_number;
		string	state_id_state;
		string	eu_company_name;
		string	eu_address_street;
		string	eu_address_city;
		string	eu_address_state;
		string	eu_address_zip5;
		string	eu_address_phone;
		string	phone;
end;

export Base_Encrypted :=record
		string transaction_id;
    string key_version;
    string text;
    string key_encrypted;
    string time_stamp;
    string key_group;
		string key_decrypted;
		string version;
		unsigned8 filedate;
		UNSIGNED8 group_rid;
end;

EXPORT Input_Encrypted_History := record

		Input_Encrypted;
		string raw_filename;
		unsigned8 filedate;

END;


  //ESP layouts
  EXPORT t_Key := RECORD
    string KeyVersion {xpath('KeyVersion')}; //integer?
    string EncryptionKey {xpath('EncryptionKey')};
    string KeyGroup {xpath('KeyGroup')};
  END;

  EXPORT t_RsaKey := RECORD (t_Key)
    string RSAProtectedKey {xpath('RSAProtectedKey')};
  END;

  EXPORT t_KeyDecryptionRequest := RECORD (iesp.share.t_BaseRequest)
    string RSAPublicKeyPEM {xpath('RSAPublicKeyPEM')};
    DATASET(t_Key) keys {xpath('Keys/Key')};
  END;

  EXPORT t_KeyDecryptionResponse := record
    iesp.share.t_ResponseHeader _Header {xpath('Header')};
    DATASET(t_RsaKey) keys {xpath('Keys/Key')};
  END;

  EXPORT t_KeyDecryptionResponseEx := record
    t_KeyDecryptionResponse response {xpath('response')};
  END;

  EXPORT decrypted := RECORD (t_KeyDecryptionResponseEx)
    string soap_message {maxlength (8000)} := '';
  END;

END;
