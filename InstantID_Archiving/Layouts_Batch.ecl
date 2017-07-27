EXPORT Layouts_batch := MODULE

	EXPORT Model := RECORD
		STRING25 transaction_id;
		STRING20 name;
		STRING4 score_id;
		STRING4 score;
		STRING30 score_type;
		STRING22 date_added;
	END;
	
	EXPORT Modelriskindicator := RECORD
		STRING25 transaction_id;
		STRING4 score_id;
		STRING4 risk_code;
	  STRING150 description;
		STRING22 date_added;
	END;
	
	EXPORT Modelriskindex := RECORD
		STRING25 transaction_id;
		STRING4 score_id;
		STRING32 name;
	  STRING128 ivalue;
		STRING22 date_added;
	END;
	
	EXPORT Redflags := RECORD
		STRING25 transaction_id;
		STRING20 rec_version;
		STRING30 name;
		STRING4 risk_code;
		STRING150 description;
		STRING22 date_added;
	END;

	EXPORT Risk := RECORD
		STRING25 transaction_id;
		STRING4 risk_code;
		STRING150 description;
		STRING22 date_added;
	END;

	EXPORT Report := RECORD, MAXLENGTH(60000)
		STRING25 transaction_id;
		STRING22 date_added;
		STRING request_data;
		STRING response_data ;
	END;

// key length limit of 32767 

	EXPORT ReportK := RECORD, MAXLENGTH(12500)
		STRING22 product;
		STRING25 transaction_id;
		STRING22 date_added;
		STRING request_data {MAXLENGTH(4000)};
		STRING response_data {MAXLENGTH(8400)};
	END;
	
	EXPORT Verification := RECORD
		STRING25 transaction_id;
		STRING30 name;
		STRING5 is_verified;
		STRING22 date_added;
	END;

	EXPORT Key_InstantID := RECORD
		STRING25 transaction_id;
		STRING20 company_id;
		STRING10 company_id_source;
		STRING8 version;
		STRING20 source;
		STRING30 fname;
		STRING30 lname;
		STRING45 address;
		STRING50 city;
		STRING17 state;
		STRING9 zip;
		STRING10 dob;
		STRING9 ssn;
		STRING45 query_id;
		STRING32 unique_id;
		STRING12 cvi;
		STRING12 nas;
		STRING12 nap;
		STRING12 dob_verified;
		STRING22 date_added;
	END;

	EXPORT Key_InstantIDi := RECORD
		STRING25 transaction_id;
		STRING20 company_id;
		STRING10 company_id_source;
		STRING8 version;
		STRING20 source;
		STRING30 fname;
		STRING30 lname;
		STRING10 address_number;
		STRING45 address;
		STRING15 address_type;
		STRING50 city;
		STRING17 state;
		STRING9 zip;
		STRING10 dob;
		STRING20 national_id;
		STRING45 query_id;
		STRING32 unique_id;
		STRING12 ivi;
		STRING12 compliance_level;
		STRING22 date_added;
	END;
	
	EXPORT Key_FlexID := RECORD
		STRING25 transaction_id;
		STRING20 company_id;
		STRING10 company_id_source;
		STRING8 version;
		STRING20 source;
		STRING30 fname;
		STRING30 lname;
		STRING45 address;
		STRING50 city;
		STRING17 state;
		STRING9 zip;
		STRING10 dob;
		STRING9 ssn;
		STRING45 query_id;
		STRING32 unique_id;
		STRING12 cvi;
		STRING12 nas;
		STRING12 nap;
		STRING10 fname_verified;
		STRING10 lname_verified;
		STRING10 address_verified;
		STRING10 city_verified;
		STRING10 state_verified;
		STRING10 zip_verified;
		STRING10 home_phone_verified;
		STRING10 dob_verified;
		STRING10 dob_match_verified;
		STRING10 ssn_verified;
		STRING10 dl_verified;
		STRING22 date_added;
	END;
	
END;