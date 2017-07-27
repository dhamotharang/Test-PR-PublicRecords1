IMPORT Standard;

EXPORT Layout_Base := RECORD
	STRING30 product;					
		STRING25 transaction_id;			
		UNSIGNED6 transaction_id_key;			
		STRING20 company_id;			
		STRING10 company_id_source;			
		STRING8 version;			
		STRING20 source;			
		STRING20 iidi_type;			
		INTEGER8 batch_job_id;			
		INTEGER8 batch_seq_number;			
		STRING30 orig_fname;			
		STRING30 orig_mname;			
		STRING30 orig_lname;			
		STRING100 fullname;			
		STRING30 maiden_name;			
		STRING1 gender;			
		STRING10 orig_address_number;			
		STRING45 orig_address;			
		STRING15 orig_address_type;			
		STRING50 orig_city;			
		STRING40 orig_state;			
		STRING9 orig_zip;			
		STRING10 orig_dob;			
		STRING9 orig_ssn;			
		string255 street_address1;			
		string255 street_address2;			
		string10 unit_number;			
		string10 building_number;			
		string30 building_name;			
		string10 floor_number;			
		string40 suburb;			
    string40 district;					
    string40 county;					
    string40 country;					
    string15 phone;				 	
    string15 mobile_phone;					
    string15 work_phone;					
   string40 national_id_city_issued;					
string40 national_id_district_issued;					
string40 national_id_county_issued;					
string40 national_id_province_issued;					
string20 dl_number;					
string5 dl_version_number;					
string40 dl_state;					
string22 dl_expire_date;					
string20 passport_number;					
string22 passport_expire_date;					
string40 passport_place_birth;					
string40 passport_country_birth;					
string30 passport_family_name_birth;					
					
/* Standard Fields */
		 BOOLEAN clean_rec := TRUE;
			STRING8 DOB;
			STRING9 SSN;
		 Standard.Name;
			STRING5  title2;
			STRING20 fname2;
			STRING20 mname2;
			STRING20 lname2;
			STRING5  name_suffix2;
		 Standard.Addr;
			string10 prim_range2 ;
			string2  predir2 ;
			string28 prim_name2 ;
			string4  addr_suffix2 ;
			string2  postdir2 ;
			string10 unit_desig2 ;
			string8  sec_range2 ;
			string25 v_city_name2 ;
			string2  st2 ;
			string5  zip52 ;
			string4  zip42 ;
/* */
						
		STRING45 query_id;			
		STRING32 unique_id;			
		STRING20 national_id;			
		STRING12 cvi;			
		STRING12 nas;			
		STRING12 nap;			
		STRING12 ivi;			
		STRING12 compliance_level;			
		STRING12 dob_verified;			
		STRING10 fname_verified;			
		STRING10 lname_verified;			
		STRING10 address_verified;			
		STRING10 city_verified;			
		STRING10 state_verified;			
		STRING10 zip_verified;			
		STRING10 home_phone_verified;			
		STRING10 dob_match_verified;			
		STRING10 ssn_verified;			
		STRING10 dl_verified;			
		STRING22 date_added;			
					
					
				end;	
					
					
					
					
					
					
					
					
					
					
					
					
					
