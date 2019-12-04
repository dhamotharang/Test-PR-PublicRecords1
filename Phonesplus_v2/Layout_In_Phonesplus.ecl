export Layout_In_Phonesplus := module
//Additional fields
export layout_additional := record
	boolean		   in_flag:= false;
	unsigned     ConfidenceScore := 0;
	//Main rules why a record is included or not in Phonesplus
	unsigned8		 rules := 0;  
	string3			 npa;
	string7			 phone7;
	string10		 CellPhone := '';
	// hash field of phonel7, address and name
	data16   	   CellPhoneIDKey := (data)0; //data16   	   phone7_rec_key := (data)0;
  // hash field of phonel7 and did
	data16   	   phone7_did_key := (data)0;
	// set to 0 for records with a did, and > 0 when did is temp
	unsigned6		 pdid := 0;
	unsigned6 	 did := 0;
	string3	 		 did_score := '0';
	unsigned3    DateFirstSeen;
	unsigned3    DateLastSeen;
	unsigned3    DateVendorLastReported;
	unsigned3    DateVendorFirstReported;
	unsigned3    dt_nonglb_last_seen:= 0;
	string1		 	 glb_dppa_flag:= '';
	string5		 	 glb_dppa_all:= '';
					//bit map field indicating source
	string2      vendor := '';
	string2      src := '';
	unsigned8    src_all;
	unsigned1    src_cnt := 1;
	unsigned8    src_rule := 0;
	unsigned1    append_avg_source_conf := 0;
	unsigned1    append_max_source_conf := 0;
	unsigned1    append_min_source_conf := 0;
	unsigned1    append_total_source_conf := 0;
	unsigned3    orig_dt_last_seen;
	string10     did_type := '';
end;

//Orig fields
export layout_orig := record
	string90 		OrigName;
	string25 		Address1;
	string25 		Address2;
	string25 		Address3 := '';
	string20 		OrigCity;
	string2 		OrigState;
	string9 		OrigZip;
	string10 		orig_phone;
	string8 		Dob := '';
  string10 		AgeGroup := '';
  string8 		Gender := '';
  string50 		Email := '';
	string5	 		orig_listing_type:= '';
				/*isting_type
				R - Residential	
				B - Business	
				P - Payphone	
				U - Unknown	
				G - Government*/
	string2 ListingType := '';
	string2	 		orig_publish_code:= '';
				/*publish_code
				N - Non-Published
				''- Unknown*/
	string6			orig_phone_type:= '';
				/*phone_type
				L - Land Line including directory assistance			
				V - VOIP			
				W - Wireless			
				O - Other	
				P - Pager
				T - TTY*/		
	string13		orig_phone_usage:= '';	
				/* phone_type
				P - Primary
				A - Answering Machine
				D - Data Line
				G - Pager
				M - Mobile
				R - Identified Explicitly As Residence
				W - Work
				S - Secondary
				C - Child's
				F - Facsimile
				H - Home
				O - Office
				T - TTY*/
	string80 		Company := '';
	unsigned3		orig_phone_reg_dt:= 0;
	string20 		orig_carrier_code:= '';
	string60 		orig_carrier_name:= '';
	string10		orig_conf_score:= '';
				/* conf_score
				1 - Highest Confidence - Directory Assistance			
				2 - Highest Confidence - Private Numbers			
				3 - High Confidence - Private Numbers			
				4 - Good Confidence - Private Numbers			
				5 - Low Confidence - Possible Disconnect*/
	unsigned1	   orig_rec_type:= 0;
				/* rec_type:
				1 - Individual 1			
				2 - Individual 2*/
end;

//Cleaned fields
export layout_clean := record	
	string100		clean_company:= '';
	string10     prim_range;
	string2      predir;
	string28     prim_name;
	string4      addr_suffix;
	string2      postdir;
	string10     unit_desig;
	string8      sec_range;
	string25     p_city_name;
	string25     v_city_name;
	string2      state;
	string5      zip5;
	string4      zip4;
	string4      cart := '';
	string1      cr_sort_sz := '';
	string4      lot := '';
	string1      lot_order := '';
	string2      dpbc := '';
	string1      chk_digit := '';
	string2      rec_type := '';
	string2      ace_fips_st := '';
	string3      ace_fips_county := '';
	string10     geo_lat := '';
	string11     geo_long := '';
	string4      msa := '';
	string7      geo_blk := '';
	string1      geo_match := '';
	string4      err_stat:= '';
	string5      title ;
	string20     fname;
	string20     mname;
	string20     lname;
	string5      name_suffix;
	string3      name_score := '0';
	unsigned6		 bdid:= 0;
	unsigned1		 bdid_score := 0;
end;

export layout_appended := record
	unsigned4   append_npa_effective_dt:= 0;
	unsigned4   append_npa_last_change_dt:= 0;
	string1     append_dialable_ind:= '';
	string30 		append_place_name:= '';
	string1 		append_portability_indicator:= '';
	string20	  append_prior_area_code:= '';
	unsigned 		append_nonpublished_match:= 0;
	string30    append_ocn := '';
	string1     append_time_zone := '';
	string2 	  append_nxx_type :='';
	string3     append_COCType:='';
  string4     append_SCC:='';
	string25	  append_phone_type:= '';
	string1     append_company_type := '';
	string25    append_phone_use := '';
//aggregated fields
	string5			agreg_listing_type:= '';
	unsigned1		max_orig_conf_score := 0;
	unsigned1		min_orig_conf_score := 0;
	unsigned1		cur_orig_conf_score := 0;
//eda
  string1    ActiveFlag := '';
	boolean		 	eda_active_flag := 0;
	unsigned4		eda_match:= 0;
	unsigned4		eda_phone_dt:= 0;
	unsigned4		eda_did_dt:= 0;
	unsigned4		eda_nm_addr_dt:= 0;
//eda hist
	unsigned4		eda_hist_match:= 0;
	unsigned4		eda_hist_phone_dt:= 0;
	unsigned4		eda_hist_did_dt:= 0;
	unsigned4		eda_hist_nm_addr_dt:= 0;
//append feedback
		/* Feeback values
		 1 - Right Party Contact
		 2 - Relative Or Associate Contact
		 3 - Wrong Party Claim
		 4 - Phone Disconnected
		 7 - Alternate Phone entered
		 8 - Other info entered*/
	string1			append_feedback_phone:= '';
	unsigned4		append_feedback_phone_dt := 0;
	string1			append_feedback_phone7_did:= '';
	unsigned4		append_feedback_phone7_did_dt := 0;	
	string1		  append_feedback_phone7_nm_addr:= '';
	unsigned4		append_feedback_phone7_nm_addr_dt := 0;	
	
//Other
	unsigned4		append_ported_match := 0;
	boolean			append_seen_once_ind:= 0;
	unsigned1		append_indiv_phone_cnt := 0;
	boolean     append_indiv_has_active_eda_phone_flag := 0;
	boolean			append_latest_phone_owner_flag := 0;

	
//append household
	unsigned6		hhid:= 0;
	unsigned1 	hhid_score := 0;
	data16   	 	phone7_hhid_key := (data)0;

//appended best
	boolean 		append_best_addr_match_flag:= false;
	boolean 		append_best_nm_match_flag:= false;
end;


export layout_unrolled := record //DF-25784 Unrolling of Data - V3
	string2     source := '';
	boolean	    household_flag := false;  
	//nuestar flags
	string2	    activity_status := '';
	string1	    prepaid := '';
	string1	    verified := '';
	string1     cord_cutter:= '';
end;

//Combined Layout
export layout_in_common := record
	layout_additional;
	layout_orig;
	layout_clean;
	layout_appended;
	Unsigned8		rawAID := 0;
	Unsigned8   cleanAID := 0;
	boolean     current_rec := 0;
	unsigned4   first_build_date := 0;
	unsigned4   last_build_date := 0;
	//CCPA-718 - new fields for CCPA opt out
	UNSIGNED4 global_sid := 0;
	UNSIGNED8 record_sid := 0;
	layout_unrolled //DF-25784 Unrolling of Data - V3
end;
end;
