IMPORT address, AID;

EXPORT Layout_VendorSrc := MODULE
		
	EXPORT Bank_Court	:= RECORD
		STRING		court_code;
		STRING		court_name;
		STRING		address1;
		STRING		address2;
		STRING		city;
		STRING		state;
		STRING		zip;
		STRING		phone;
	END;
	
	EXPORT Lien_Court	:= RECORD
		STRING 		court_code;
		STRING		court_name;
		STRING		address1;
		STRING		address2;
		STRING		city;
		STRING		state;
		STRING		zip;
		STRING		phone;
	END;
	
	EXPORT Riskview_FFD	:= RECORD
		STRING		item_id;
		STRING		item_name;
		STRING		item_description;
		STRING		status_name;
		STRING		item_source_code;
		STRING		source_id;
		STRING		source_name;
		STRING		source_address1;
		STRING		source_address2;
		STRING		source_city;
		STRING		source_state;
		STRING		source_zip;
		STRING		source_phone;
		STRING		source_website;
		STRING		market_restrict_flag;
	END;
	
	EXPORT MergedSrc_Base	:= RECORD
																				// Bank/Lien Court Match				// Riskview/FFD
		STRING		item_source;							//  court_code 		(col A)				//	item_source_code			(col H)
		STRING75	source_code;							//	court_code 		(col A)				//	item_source_code			(col H)
		STRING		display_name;							//	court_name 		(col B)				//	item_name							(col C)
		STRING		description;							//	court_name 		(col B)				//	item_description			(col F)
		STRING		status;										//	court_name 		(col B)				//	status_name						(col G)
		STRING		data_notes;								//		<no match>								//		<no match>
		STRING		coverage_1;								//		<no match>								//		<no match>
		STRING		coverage_2;								//		<no match>								//		<no match>
		STRING		orbit_item_name;					//		<no match>								//	item_name							(col C)
		STRING		orbit_source;							//		<no match>								//	item_source_id				(col I)
		STRING		orbit_number;							//		<no match>								//	item_id								(col A)
		STRING		website;									//		<no match>								//	source_website				(col R)
		STRING		notes;										//		<no match>								//		<no match>
		STRING		date_added;								//	<from build_all date>				//	<from build_all date>
		STRING		input_file_id;						//	BANKRUPTCY - or- LIEN 			//	RISKVIEW_FFD			(based on input file name) 		(literal)
		STRING		market_restrict_flag;			//		<no match>								//	market_restrict_flag	(col S)
		STRING10  clean_phone;							//	phone				(col H)					//	source_phone					(col Q)
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

END;