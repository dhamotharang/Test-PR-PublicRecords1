export Layouts_DL_TN_In := module
  
	export Layout_TN_Raw := record
	  string line;
	end;
	
	//Original TN DL
	export Layout_TN_Update := record
		string20 orig_LAST_NAME;
		string12 orig_FIRST_NAME;
		string12 orig_MIDDLE_NAME; 
		string3	 orig_NAME_SUFFIX;
		string40 orig_STREET_ADDRESS_1;
		string27 orig_STREET_ADDRESS_2;
		string29 orig_CITY;
		string2	 orig_STATE;
		string5	 orig_ZIP_CODE;
		string9	 orig_DL_NUMBER;
		string2	 orig_LICENSE_TYPE;
		string1	 orig_SEX;
		string3	 orig_HEIGHT;
		string3	 orig_WEIGHT;
		string2	 orig_EYE_COLOR;
		string2	 orig_HAIR_COLOR;
		string10 orig_RESTRICTIONS;
		string10 orig_ENDORSEMENTS;
		string8	 orig_DOB;
		string8	 orig_ISSUE_DATE;
		string8	 orig_EXPIRE_DATE;
		string1	 orig_NON_CDL_STATUS;
		string1	 orig_CDL_STATUS;
		string1	 orig_CRLF;
	end;
	
	export Layout_TN_With_ProcessDte := record
	  string8 Process_date;
		Layout_TN_Update;
	end;
	
	// *********The New TN DL record layout has extended, modified and field(s) 
	export Layout_TN_Update2 := record
		string20 orig_LAST_NAME;
		string12 orig_FIRST_NAME;
		string12 orig_MIDDLE_NAME; 
		string3	 orig_NAME_SUFFIX;
		string40 orig_STREET_ADDRESS1;  
		string27 orig_STREET_ADDRESS2;  
		string29 orig_CITY;
		string2	 orig_STATE;
		string5	 orig_ZIP_CODE;
		string9	 orig_DL_NUMBER;
		string6	 orig_LICENSE_TYPE;   //length chged from 2 to 6
		string1	 orig_SEX;
		string1	 orig_HEIGHT_FT;
		string2	 orig_HEIGHT_IN;
		string3	 orig_WEIGHT;
		string2	 orig_EYE_COLOR;
		string2	 orig_HAIR_COLOR;
		string2  orig_RESTRICTIONS1;
		string2  orig_RESTRICTIONS2;
		string2  orig_RESTRICTIONS3;
		string2  orig_RESTRICTIONS4;
		string2  orig_RESTRICTIONS5;
		string2  orig_ENDORSEMENTS1;
		string2  orig_ENDORSEMENTS2;
		string2  orig_ENDORSEMENTS3;
		string2  orig_ENDORSEMENTS4;
		string2  orig_ENDORSEMENTS5;
		string8	 orig_DOB;
		string8	 orig_ISSUE_DATE;
		string8	 orig_EXPIRE_DATE;
		string12 orig_NON_CDL_STATUS;  // length chged from 1 to 12
		string12 orig_CDL_STATUS;      // length chged from 1 to 12
		string6  orig_RACE;                 // race appended to end
	  string3	 orig_CRLF;
	end;
	
	export Layout_TN_Update2_Cleaned := record
	  string8 Process_date;
		Layout_TN_Update2;
		string5	  clean_name_prefix;
   	string20  clean_name_first;
   	string20  clean_name_middle;
   	string20  clean_name_last;
   	string5	  clean_name_suffix;
		string10  prim_range;
		string2   predir;
		string28  prim_name;
		string4   addr_suffix;
		string2   postdir;
		string10  unit_desig;
		string8   sec_range;
		string25  p_city_name;
		string25  v_city_name;
		string2   st;
		string5   cln_zip5;
		string4   cln_zip4;
		string4   cart;
		string1   cr_sort_sz;
		string4   lot;
		string1   lot_order;
		string2   dpbc;
		string1   chk_digit;
		string2   rec_type;
		string2   ace_fips_st;
		string3   county;
		string10  geo_lat;
		string11  geo_long;
		string4   msa;
		string7   geo_blk;
		string1   geo_match;
		string4   err_stat;
	end;
	
	/*  As Per Michael Gould's Email Note: The TN Convictions and Withdrawal files lengths are inconsistent from month to month from vendor, 
			even though they are supposed to be 69 (68+terminator) or 63 (62+terminator), But for some reason vendor has been inconsistent 
			with the file lengths,Michael is planning on converting the files by padding the extra spaces towards the end of the records using DOS to Unix script. 
			As he requested, extending the record lengths to 200 bytes by adding a filler fields, so the file lengths be consistent from update to update.  
  */
  
	// **********TN DL CONVICTIONS record layout
  export Layout_TN_CP := record
	  string9    dl_number;
		string8    birthdate;
		string3    action_code;
		string8    event_date;
		string8    post_date;	
		string29   last_name;
		string2    county_code;
		string131  filler:=''; //Padded values as per above comments
		string2    crlf;
  end;
	
	export Layout_TN_CP_With_ProcessDte := record
	  string8 process_date;
	  Layout_TN_CP -crlf;
	end;
 
	export Layout_TN_CP_All_Cleaned := record
		Layout_TN_CP_With_ProcessDte;
  end;
	
	// *************TN DL WITHDRAWALS/SUSPENSIONS record layout
	export Layout_TN_WDL := record
		string9    dl_number;
		string3    action_code;
		string8    event_date;
		string20   last_name;	
		string8    birthdate;	
		string8    post_date;	
		string2    county_code;
		string3	   action_type;	
		string137  filler:=''; //Padded values as per above comments
		string2    crlf;
	end;
	
	export Layout_TN_WDL_With_ProcessDte := record
		string8 process_date;
		Layout_TN_WDL -crlf;
	end;
	
  export Layout_TN_WDL_All_Cleaned := record
		Layout_TN_WDL_With_ProcessDte;
  end;
	 
end;