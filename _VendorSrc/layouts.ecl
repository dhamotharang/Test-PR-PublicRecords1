IMPORT Address, BIPV2, AID;

EXPORT layouts := MODULE

	EXPORT Master_List_input	:= RECORD
		STRING LNfileCategory;
		STRING LNsourcetCode;
		STRING vendorName;
		STRING Address1;
		STRING Address2;
		STRING City;
		STRING State;
		STRING ZipCode;
		STRING Phone;
	END;
	
	EXPORT Bank_Court_input	:= RECORD
		STRING		court_code;
		STRING		court_name;
		STRING		address1;
		STRING		address2;
		STRING		city;
		STRING		state;
		STRING		zip;
		STRING		phone;
	END;
	
	EXPORT Lien_Court_input	:= RECORD
		STRING 		court_code;
		STRING		court_name;
		STRING		address1;
		STRING		address2;
		STRING		city;
		STRING		state;
		STRING		zip;
		STRING		phone;
	END;
	
	EXPORT Court_Locations_input	:= RECORD
		string5		FipsCode;
		string2		StateFIPS;
		string3		CountyFips;
		STRING 		CourtID;
		STRING		ConsolidatedCourtID;
		string		MasterID;
		string		StateOfService;
		string		CountyOfService;
		STRING		CourtName;
		string		Phone;
		STRING		Address1;
		STRING		Address2;
		STRING		city;
		STRING		state;
		STRING5		ZipCode;
		string4		Zip4;
		STRING		MailAddress1;
		STRING		MailAddress2;
		STRING		MailCity;
		STRING		MailCtate;
		STRING5		MailZipCode;
		string4		MailZip4;
	END;	
	
	EXPORT Riskview_FFD_input	:= RECORD
		STRING		item_id;												// column A
		STRING		item_name;											// column B
		STRING		item_description;								// column C
		STRING		status_name;										// column D
		STRING		item_source_code;								// column E
		STRING		source_id;											// column F
		STRING		source_name;										// column G
		STRING		source_address1;								// column H
		STRING		source_address2;								// column I 
		STRING		source_city;										// column J
		STRING		source_state;										// column K
		STRING		source_zip;											// column L
		STRING		source_phone;										// column M
		STRING		source_website;									// column N
		STRING		unused_source_sourceCodes;			// column O
		STRING		unused_fcra;										// column P
		STRING		unused_fcra_comments;						// column Q
		STRING		market_restrict_flag;						// column R
		STRING		unused_market_comments;					// column S
		STRING		unused_contact_category_name;		// column T
		STRING		unused_contact_name;						// column U
		STRING		unused_contact_phone;						// column V
		STRING		unused_contact_email;						// column W
	END;
	

//Was named MergedSrc_Base
	EXPORT base_data_input	:= RECORD
																				// Bank/Lien Court Match				// Riskview/FFD
		STRING		item_source;							//  court_code 		(col A)				//	item_source_code			
		STRING75	source_code;							//	court_code 		(col A)				//	item_source_code			
		STRING		display_name;							//	court_name 		(col B)				//	source_name							
		STRING		description;							//	court_name 		(col B)				//	item_description			
		STRING		status;										//	court_name 		(col B)				//	status_name						
		STRING		data_notes;								//		<no match>								//		<no match>
		STRING		coverage_1;								//		<no match>								//		<no match>
		STRING		coverage_2;								//		<no match>								//		<no match>
		STRING		orbit_item_name;					//		<no match>								//	item_name							
		STRING		orbit_source;							//		<no match>								//	item_source_id				
		STRING		orbit_number;							//		<no match>								//	item_id								
		STRING		website;									//		<no match>								//	source_website				
		STRING		notes;										//		<no match>								//		<no match>
		STRING		date_added;								//	<from build_all date>				//	<from build_all date>
		STRING		input_file_id;						//	BANKRUPTCY - or- LIEN 			//	(left blank for now)
		STRING		market_restrict_flag;			//		<no match>								//	market_restrict_flag	
		STRING10  clean_phone;							//	phone				(col H)					//	source_phone					
		STRING10	clean_fax;								//		<no match>								//
		STRING65  Prepped_addr1;						//	address cleaner fields 			//	(based on source address fields)
		STRING35  Prepped_addr2;
		STRING28  v_prim_name;
		STRING5   v_zip;
		STRING4   v_zip4;
		STRING		prim_range;
		STRING		predir;
		STRING		prim_name;
		STRING		addr_suffix;
		STRING		postdir;
		STRING		unit_desig;
		STRING		sec_range;
		STRING		p_city_name;
		STRING		v_city_name;
		STRING		st;
		STRING		zip;
		STRING		zip4;
		STRING		cart;
		STRING		cr_sort_sz;
		STRING		lot;
		STRING		lot_order;
		STRING		dbpc;
		STRING		chk_digit;
		STRING		rec_type;
		STRING		county;
		STRING		geo_lat;
		STRING		geo_long;
		STRING		msa;
		STRING		geo_blk;
		STRING		geo_match;
		STRING		err_stat;
	END;
	
		EXPORT Base	:= RECORD
		base_data_input - [market_restrict_flag];
	END;

	
END;