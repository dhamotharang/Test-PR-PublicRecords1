IMPORT AID;

EXPORT Layouts :=
	MODULE
		EXPORT Layout_in := 
					RECORD
						string5   school_act_code;
						string1   tuition_code;
						string1   public_private_code;
						string1   school_size_code;
						string20  student_last_name;
						string20  student_first_name;
						string1   gender_code;
						string1   competitive_code;
						string1   intl_exchange_student_code;
						string1   address_sequence_code;
						string30  school_name;
						string30  school_address_2_secondary;
						string5   filler_1;
						string30  school_address_1_primary;
						string5   filler_2;
						string20  school_city;
						string2   school_state;
						string5   school_zip5;
						string4   school_zip4;
						string10  school_phone_number;
						string1   school_housing_code;
						string5   filler_3;
						string30  home_address_1_secondary;
						string5   filler_4;
						string30  home_address_2_primary;
						string5   filler_5;
						string20  home_city;
						string2   home_state;
						string5   home_zip5;
						string4   home_zip4;
						string10  home_phone_number;
						string1   home_housing_code;
						string1   class_rank;
						string3   major_code;
						string1   school_info_time_zone;
						string2   filler_6;
						string4   filler_7;
						string1   home_info_time_zone;
						string2   filler_8;
						string4   filler_9;
						string1   address_type;
						string1   address_info_code;
						string7   sequence_number;
						string2   filler_10;
						string50  filler_11;
						string15  key_code;
						string1   carriage_return;
						string1   line_feed;
					END;
					
			EXPORT Layout_base := 
					RECORD
						Layout_in;
						
						//Indicates C = College, Y = Young Adults
						string1 file_type;
						
						//LN created fields
						string50	ln_college_name;
						string1		tier;
						
						//DID fields
						unsigned8 DID;
						unsigned8 DID_Score;

						//Clean name fields
						string5		clean_title;
						string20	clean_fname;
						string20	clean_mname;
						string20	clean_lname;
						string5		clean_name_suffix;
						string3		clean_name_score;
						
						//AID Fields
						string1		clean_addr_code;
						AID.Common.xAID	RawAID;
						string77	Append_Prep_Address;
						string54	Append_Prep_Address_Last;
						
						//Clean phone number
						string10	clean_phone_number;
						
						//Clean address fields
						string10  			clean_prim_range;
						string2   			clean_predir;
						string28  			clean_prim_name;
						string4   			clean_addr_suffix;
						string2   			clean_postdir;
						string10  			clean_unit_desig;
						string8   			clean_sec_range;
						string25  			clean_p_city_name;
						string25  			clean_v_city_name;
						string2   			clean_st;
						string5   			clean_zip5;
						string4   			clean_zip4;
						string4   			clean_cart;
						string1   			clean_cr_sort_sz;
						string4   			clean_lot;
						string1   			clean_lot_order;
						string2   			clean_dbpc;
						string1   			clean_chk_digit;
						string2   			clean_rec_type;
						string5 				clean_county;
						string2   			clean_ace_fips_st;
						string3					clean_fips_county;
						string10  			clean_geo_lat;
						string11  			clean_geo_long;
						string4   			clean_msa;
						string7   			clean_geo_blk;
						string1   			clean_geo_match;
						string4   			clean_err_stat;
						
						// Instance tracking fields
						string8		process_date;
						string8		date_first_seen;
						string8		date_last_seen;
						string8		date_vendor_first_reported;
						string8		date_vendor_last_reported;
						//Added for Shell 5.0 project 6/3/13
						STRING5		tier2;
						STRING2   source := '';

						//CCPA-107 Add 2 new fields to base file, and 2 keys
						UNSIGNED4 global_sid;
						UNSIGNED8 record_sid;
						
					END;
					
					EXPORT layout_KeyExclusions_tier2 := RECORD
						string5     tier2;
					END;
END;