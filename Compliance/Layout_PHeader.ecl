EXPORT Layout_PHeader := 
					RECORD
//Header.layout_header_v2. All result records, from all searcheds are mapped into this layout
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
						
					END;	