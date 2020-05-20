IMPORT Address, AID, BIPV2;
            
//KeyBase includes all fields except for web_address and email. 
//The parsed web_address and email (if present and valid) are included
  EXPORT Layout_Keybase := RECORD
	  string6   source;
		unsigned4 global_sid;              //this is a unique source ID that will be coming from Orbit.
		unsigned8 record_sid;              //this is a source specific unique and persistent record id (from SALT).  
		BIPV2.IDlayouts.l_xlink_ids;
		unsigned6	did;
	  unsigned1	did_score;
  	unsigned4 dt_first_seen;
		unsigned4 dt_last_seen;
		unsigned4 dt_vendor_first_reported;
		unsigned4 dt_vendor_last_reported;
    unsigned4 process_date;																											
 		string1		record_type;
		string100 clean_company_name;
		string3   clean_area_code;
		string10  clean_telephone_num;
		string13  mail_score_desc;
		string9   name_gender_desc;
		string40	title_desc_1;
		string40	title_desc_2; 
		string40	title_desc_3;               
		string40	title_desc_4;
		string50  web_address1;
		string50  web_address2;
		string50  web_address3;
		string75  sic8_desc_1;
		string75  sic8_desc_2;
		string75  sic8_desc_3;
		string75  sic8_desc_4;
		string75  sic6_desc_1;
		string75  sic6_desc_2;
		string75  sic6_desc_3;
		string75  sic6_desc_4;
		string75  sic6_desc_5;
		string50  email1;
		string50  email2;
		string50  email3;
		string30	name;                    //Contact Full Name     
		string50	company;                 //Business Name
		string30	address;                 //Primary Address
		string30	address2;                //Additional Primary Address Info
		string20	city;
		string2	  state;
		string3	  scf;
		string5	  zip_code5;
		string4	  zip_code4;
		string1	  mail_score;
		string3	  area_code;
		string10	telephone_number;
		string1	  name_gender;
		string10	name_prefix;
		string20	name_first;
		string1	  name_middle_initial;
		string20	name_last;
		string10	suffix;
		string4	  title_code_1;
		string4	  title_code_2;
		string4	  title_code_3;
		string4	  title_code_4;
		string8	  sic8_1;
		string8	  sic8_2;
		string8	  sic8_3;
		string8	  sic8_4;
		string6	  sic6_1;
		string6	  sic6_2;
		string6	  sic6_3;
		string6	  sic6_4;
		string6	  sic6_5;
		string6   transaction_date;
		string10	database_site_id;
		string10	database_individual_id;   
		string1	  email_present_flag;
		string1	  site_source1;
		string1	  site_source2;
		string1	  site_source3;
		string1	  site_source4;
		string1	  site_source5;
		string1	  site_source6;
		string1	  site_source7;
		string1	  site_source8;
		string1	  site_source9;
		string1	  site_source10;
		string1	  individual_source1;
		string1	  individual_source2;
		string1	  individual_source3;
		string1	  individual_source4;
		string1	  individual_source5;
		string1	  individual_source6;
		string1	  individual_source7;
		string1	  individual_source8;
		string1	  individual_source9;
		string1	  individual_source10;
		string7	  email_status;
		Address.Layout_Clean_Name; 
		Address.Layout_Clean182_fips; 
		unsigned8	raw_aid;
		unsigned8	ace_aid;
		string100	prep_address_line1;
		string50	prep_address_line_last;
	END;