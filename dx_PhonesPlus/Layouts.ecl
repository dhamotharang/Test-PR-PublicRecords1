EXPORT layouts := MODULE
//DF-27472 Initial Roxie Release
	EXPORT i_source_level_payload := RECORD 
				data16   	   	cellphoneidkey; 
				string2     	source;	//two-digit code 
				unsigned8 		src_bitmap; //bitmap flag corresponding to two-digit source code
				boolean		  	household_flag;  
				unsigned8 		rules;  //bitmap of rules in rollup up phonesplus_v2 keys
				string10		 	cellphone;
				string3			 	npa;
				string7			 	phone7;
				data16   	   	phone7_did_key;   // hash field of phonel7 and did
				unsigned6		 	pdid;
				unsigned6 	 	did;
				string3	 		 	did_score;
				unsigned3    	DateFirstSeen;
				unsigned3    	DateLastSeen;
				unsigned3    	DateVendorFirstReported;
				unsigned3    	DateVendorLastReported;
				unsigned3    	dt_nonglb_last_seen;
				string1		 	 	glb_dppa_flag;
				string10     	did_type;
				string90 			OrigName;
				string25 			Address1;
				string25 			Address2;
				string20 			OrigCity;
				string2 			OrigState;
				string9 			OrigZip;
				string10 			orig_phone;
				string60 			orig_carrier_name;
				string10     	prim_range;
				string2      	predir;
				string28     	prim_name;
				string4      	addr_suffix;
				string2      	postdir;
				string10     	unit_desig;
				string8      	sec_range;
				string25     	p_city_name;
				string25     	v_city_name;
				string2      	state;
				string5      	zip5;
				string4      	zip4;
				string4      	cart;
				string1      	cr_sort_sz;
				string4      	lot;
				string1      	lot_order;
				string2      	dpbc;
				string1      	chk_digit;
				string2      	rec_type;
				string2      	ace_fips_st;
				string3      	ace_fips_county;
				string10     	geo_lat;
				string11     	geo_long;
				string4      	msa;
				string7      	geo_blk;
				string1      	geo_match;
				string4      	err_stat;
				string5      	title;
				string20     	fname;
				string20     	mname;
				string20     	lname;
				string5      	name_suffix;
				string3      	name_score;
				string8 			dob;				
				Unsigned8			rawAID;
				Unsigned8   	cleanAID;
				boolean     	current_rec;
				unsigned4   	first_build_date;
				unsigned4   	last_build_date;
				unsigned1 		ingest_tpe;
				
				//neustar flags
				string1				verified;
				string1		  	cord_cutter;
				string2				activity_status;
				string1				prepaid;
				
				//ccpa
				unsigned4 		global_sid;
				unsigned8 		record_sid; 
	END;

	EXPORT i_source_level_did  := RECORD 
			unsigned6 	did;		
			unsigned8 	record_sid;
	END;
	
	EXPORT i_source_level_phone  := RECORD 
			string10		cellphone;
			unsigned8 	record_sid;
	END;
	
	EXPORT i_source_level_cellphoneidkey  := RECORD 
			data16   	  cellphoneidkey;
			unsigned8 	record_sid;
	END;

END;
