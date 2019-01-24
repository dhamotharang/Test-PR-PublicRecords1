IMPORT address,AID;

EXPORT layouts := MODULE

	SHARED max_size := _Dataset().max_record_size;
	
	EXPORT Input := RECORD,MAXLENGTH(max_size)
			string		match_key; //The vendor's internal record identifier.
		  string		customer_name; //Full Name of consumer
		  string		orig_address1; //Address Line 1 of consumer's address.
		  string		orig_address2; //Address Line 2 of consumer's address.
		  string		orig_city; //City Name of consumer's address.
		  string		orig_state_province; //State or Province abbreviation of consumer's address.
		  string		orig_Zip5; //Five-digit postal Zip Code of consumer's address.
		  string		orig_zip4; //Four-digit postal Zip4 extension of consumer's address.
		  string		orig_carrier_route; //USPS carrier route code:"R" = rural delivery carrier route; "C" = city delivery route; "B" = PO box delivery. 
		  string		orig_dpbc; //USPS DPBC code.
		  string		orig_gender; //Code indicating the consumer's gender: (F = female; M = male; U = unknown/unspecified)
		  string		orig_last_name; //Last Name of consumer.
		  string		orig_first_name; //First Name or Initial of consumer.
		  string		orig_check_digit; //USPS check digit.  See the explanation for DPBC code.
		  string		orig_dob; //"Date of Birth (DOB) of consumer.(All values are 8 digits in length.)"
		  string		orig_phone; //"Phone Number of consumer.(There's no indication of phone type.  Numbers vary in length.)"
		  string		orig_email; //"Email Address of consumer.(These are actual email addresses, not codes/flags.)"
		  string		orig_ethnicity; //Code indicating the consumer's ethnicity. See code list below:
																//-9999	Other Racial/Ethnic Group			
																//1	American Indian or Alaskan Native			
																//10	African American or Black			
																//11	Mexican/Mexican American			
																//12	Asian/Asian American or Pacific Islander			
																//13	White			
																//14	Hungarian-American			
																//15	Southeast Asian			
																//16	Japanese-American			
																//17	Korean-American			
																//18	Chinese-American			
																//19	Latin American			
																//2	Hawaiian Native			
																//20	Native American			
																//20000	Cuban-American			
																//20020	Hispanic or Latino			
																//20040	Middle Eastern			
																//21	Puerto Rican			
																//3	Central American			
																//4	South American, Latin American, or Central America			
																//5	Asian			
																//6	Italian-American			
																//7	Latino / Latina			
																//8	Polish-American			
																//9	Pacific Islander			


	END;
	
	EXPORT Base := RECORD

			STRING19	persistent_record_id ;
			STRING2   src;			//				
			UNSIGNED6 Dt_first_seen;
			UNSIGNED6 Dt_last_seen;
			UNSIGNED6 Dt_vendor_first_reported;
			UNSIGNED6 Dt_vendor_last_reported;
			UNSIGNED6 did 			:= 0;
			UNSIGNED1 did_score 			:= 0;
			//Original fields
			string16		match_key;
		  string40		customer_name;
		  string30		orig_address1;
		  string30		orig_address2;
		  string25		orig_city;
		  string2		orig_state_province;
		  string5		orig_Zip5;
		  string4		orig_zip4;
		  string4		orig_carrier_route;
		  string2		orig_dpbc;
		  string1		orig_gender;
		  string20		orig_last_name;
		  string20		orig_first_name;
		  string1		orig_check_digit;
		  string8		orig_dob;
		  string20		orig_phone;
		  string50		orig_email;
		  string5		orig_ethnicity;
					
		  address.Layout_Clean_Name.title;
		  address.Layout_Clean_Name.fname;
		  address.Layout_Clean_Name.mname;
		  address.Layout_Clean_Name.lname;
		  address.Layout_Clean_Name.name_suffix;
			unsigned8 nid;
		  address.Layout_Clean182.prim_range;
		  address.Layout_Clean182.predir;
		  address.Layout_Clean182.prim_name;
		  address.Layout_Clean182.addr_suffix;
		  address.Layout_Clean182.postdir;
		  address.Layout_Clean182.unit_desig;
		  address.Layout_Clean182.sec_range;
		  address.Layout_Clean182.p_city_name;
		  address.Layout_Clean182.v_city_name;
		  address.Layout_Clean182.st;
		  address.Layout_Clean182.zip;
		  address.Layout_Clean182.zip4;
		  address.Layout_Clean182.cart;
		  address.Layout_Clean182.cr_sort_sz;
		  address.Layout_Clean182.lot;
		  address.Layout_Clean182.lot_order;
		  address.Layout_Clean182.dbpc;
		  address.Layout_Clean182.chk_digit;
		  address.Layout_Clean182.rec_type;
		  string2		fips_st:='';
		  string3		fips_county:='';
		  address.Layout_Clean182.geo_lat;
		  address.Layout_Clean182.geo_long;
		  address.Layout_Clean182.msa;
		  address.Layout_Clean182.geo_blk;
		  address.Layout_Clean182.geo_match;
		  address.Layout_Clean182.err_stat;
			AID.Common.xAID		RawAID;		
			AID.Common.xAID   ACEAID;
			string10 clean_Phone;
			string8 clean_DOB;	
	END;

END;

