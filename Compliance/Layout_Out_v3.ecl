
IMPORT Header, doxie, ut;

EXPORT Layout_Out_v3 := 
				RECORD
					Compliance.Layout_orig_out;										
					
//Header.layout_header_v2, except for: April 2015 - changed valuetype for "src" from string2 to string
					unsigned6    did := 0;
					unsigned6    rid := 0;
					string1 	   pflag1 := '';
					string1		 	 pflag2 := '';
					string1		 	 pflag3 := '';
//					string2      src := '';
					string	     src := '';		//want to include non-PHeader source codes
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

//New fields (not in P Header; coming from Vehicles/Drivers/Crims)
					string	tag_num := '';		//April 2014
					string	vin_num := '';		//April 2014
					string	veh_reg_num := '';		//April 2014
					
					string	DL_state := '';		//April 2015
					string	DL_num := '';		//April 2015
					
					string	DOC_num := '';		//April 2015
					
					
					
				END;	
				