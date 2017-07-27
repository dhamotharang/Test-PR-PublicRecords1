EXPORT Layouts := MODULE

	EXPORT ModelRisk := RECORD
		STRING25 transaction_id;
		STRING30 score_id; //new
		STRING4 risk_code; //removed
		STRING150 description; //removed
		STRING22 date_added;
	END;
	
	EXPORT Model := RECORD
		STRING25 transaction_id;
		STRING20 name;
		STRING30 score_id; //new
		STRING30 score; //new
		STRING30 score_type;
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
		STRING40 risk_code;
		STRING150 description;
		STRING22 date_added;
	END;

	EXPORT ModelIndex := RECORD
		STRING25 transaction_id;
		STRING30 score_id; //new
		STRING32 name;
		STRING128 ivalue;
		STRING22 date_added;
	END;

	EXPORT Report := RECORD, MAXLENGTH(196000)
		STRING25 transaction_id;
		STRING22 date_added;
		STRING request_data;
		STRING response_data ;
	END;

// key length limit of 32767 

	EXPORT ReportK := RECORD, MAXLENGTH(28000)
		STRING30 product;
		STRING25 transaction_id;
		STRING22 date_added;
		STRING request_data {BLOB, MAXLENGTH(5200)};
		STRING response_data {BLOB, MAXLENGTH(22500)};
	END;
	
	/*EXPORT ReportK_ext := RECORD, MAXLENGTH(22100)
		STRING30 product;
		STRING25 transaction_id;
		STRING22 date_added;
		STRING request_data {MAXLENGTH(4000)};
		STRING response_data {MAXLENGTH(18000)};
	END;
	*/
	
	EXPORT Verification := RECORD
		STRING25 transaction_id;
		STRING30 name;
		STRING5 is_verified;
		STRING22 date_added;
		UNSIGNED8 source_count;
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
		STRING12 dob;
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
    INTEGER2 company_id_source;
    STRING8 version;
    STRING20 source;
    STRING20 iidi_type;
    INTEGER8 batch_job_id;
    INTEGER8 batch_seq_number;
    STRING30 fname;
    STRING30 mname;
    STRING30 lname;
    STRING100 full_name;
    STRING30 maiden_name;
    STRING1 gender;
    STRING255 street_address1;
    STRING255 street_address2;
    STRING10 unit_number;
    STRING10 building_number;
    STRING30 building_name;
    STRING10 floor_number;
    STRING40 suburb;
    STRING10 address_number;
    STRING28 address;
    STRING15 address_type;
    STRING40 city;
    STRING40 district;
    STRING40 county;
    STRING40 state;
    STRING9 zip;
    STRING40 country;
    STRING15 phone;
    STRING15 mobile_phone;
    STRING15 work_phone;
    STRING12 dob;
    STRING20 national_id;
    STRING40 national_id_city_issued;
    STRING40 national_id_district_issued;
    STRING40 national_id_county_issued;
    STRING40 national_id_province_issued;
    STRING20 dl_number;
    STRING5 dl_version_number;
    STRING40 dl_state;
    STRING22 dl_expire_date;
    STRING20 passport_number;
    STRING22 passport_expire_date;
    STRING40 passport_place_birth;
    STRING40 passport_country_birth;
    STRING30 passport_family_name_birth;
    STRING45 query_id;
    STRING32 unique_id;
    INTEGER3 ivi;
    STRING20 compliance_level;
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
		STRING12 dob;
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