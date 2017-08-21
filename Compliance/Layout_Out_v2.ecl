IMPORT Header, doxie, ut;

EXPORT Layout_Out_v2 := 
				RECORD
					Compliance.Layout_In;
					
					string		srch_criteria := '';
					string20	srch_fname := '';
					string20	srch_mname := '';
					string20	srch_lname := '';
					string		srch_fullname := '';		//new
					string		srch_busname := '';			//new
					string64	srch_address := '';
					string28	srch_city := '';
					string2		srch_state := '';
					string5		srch_zip := '';
					string10	srch_ssn := '';
					integer4	srch_dob := 0;
					string10	srch_phone := '';
					unsigned6	srch_uid := 0;
					string	srch_tag := '';		//new
					string	srch_vin := '';		//new
					
					string		name_clnr_string := '';	//April 2014
					string		addr_clnr_string := '';	//April 2014
					
					integer4	age_lower := 0;		//December 2014; for "Age Range(nn to nn)"
					integer4	age_upper := 0;		//December 2014; for "Age Range(nn to nn)"
					
					string10	srch_class := '';			//input criteria combination
										
//Header.layout_header_v2:
					unsigned6    did := 0;
					//unsigned6    PreGLB_did := 0;
					unsigned6    rid := 0;
					string1 	   pflag1 := '';
					string1		 	 pflag2 := '';
					string1		 	 pflag3 := '';
					string2      src := '';
					unsigned3    dt_first_seen := 0;
					unsigned3    dt_last_seen := 0;
					unsigned3    dt_vendor_last_reported := 0;
					unsigned3    dt_vendor_first_reported := 0;
					unsigned3    dt_nonglb_last_seen := 0;
					string1      rec_type := '';
					qstring18    vendor_id := '';
					qstring10    phone := '';
					qstring9     ssn := '';
					integer4     dob := 0;
					qstring5     title := '';
					qstring20    fname := '';
					qstring20    mname := '';
					qstring20    lname := '';
					qstring5     name_suffix := '';
					qstring10    prim_range := '';
					string2      predir := '';
					qstring28    prim_name := '';
					qstring4     suffix := '';
					string2      postdir := '';
					qstring10    unit_desig := '';
					qstring8     sec_range := '';
					qstring25    city_name := '';
					string2      st := '';
					qstring5     zip := '';
					qstring4     zip4 := '';
					string3      county := '';
					qstring7	   geo_blk := '';
					qstring5     cbsa := '';
					string1      tnt := ' ';
					string1	   	 valid_SSN := '';
					string1	     jflag1 := '';
					string1      jflag2 := '';
					string1	     jflag3 := ''; 
					unsigned8    RawAID := 0; 
					string5      Dodgy_tracking:= '';  
					unsigned8    NID:=0;  
					unsigned2    address_ind:=0;  
					unsigned2    name_ind:=0;  
					unsigned8    persistent_record_ID := 0;
//Hdr Key additional fields:					
					string1 	   valid_dob := '';
					unsigned6    hhid := 0;
					string18     county_name := '';
					string120    listed_name := '';
					string10     listed_phone := '';
					unsigned4    dod := 0;
					string1      death_code := '';
					unsigned4    lookup_did := 0;

//New fields (not in P Header; coming from Vehicles)
					string	tag_num := '';		//new
					string	vin_num := '';		//new
					
				END;	
				