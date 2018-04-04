import	Address;
// intermediate layout for cleaning
EXPORT Layout_Temp := RECORD
		Layout_in;
		string70			prepped_addr1;
		string40			prepped_addr2;
		string64			prepped_name;
		address.Layout_Clean_Name.title
		,address.Layout_Clean_Name.fname
		,address.Layout_Clean_Name.mname
		,address.Layout_Clean_Name.lname
		,address.Layout_Clean_Name.name_suffix;
		// name
		string20			Best_First_Name;
		string20			Best_Middle_Name;
		string20			Best_Last_Name;
		string5				Best_Name_Suffix;
		string6				Best_Birth_YearMonth;
		
		address.Layout_Clean182.prim_range
		,address.Layout_Clean182.predir
		,address.Layout_Clean182.prim_name
		,address.Layout_Clean182.addr_suffix
		,address.Layout_Clean182.postdir
		,address.Layout_Clean182.unit_desig
		,address.Layout_Clean182.sec_range
		,address.Layout_Clean182.p_city_name
		,address.Layout_Clean182.v_city_name
		,address.Layout_Clean182.st
		,address.Layout_Clean182.zip
		,address.Layout_Clean182.zip4
		,address.Layout_Clean182.cart
		,address.Layout_Clean182.cr_sort_sz
		,address.Layout_Clean182.lot
		,address.Layout_Clean182.lot_order
		,address.Layout_Clean182.dbpc
		,address.Layout_Clean182.chk_digit
		,address.Layout_Clean182.rec_type
		,address.Layout_Clean182.county
		,address.Layout_Clean182.geo_lat
		,address.Layout_Clean182.geo_long
		,address.Layout_Clean182.msa
		,address.Layout_Clean182.geo_blk
		,address.Layout_Clean182.geo_match
		,address.Layout_Clean182.err_stat;

		unsigned2		score := 0;
		unsigned6		LexId := 0;
		unsigned8		nid := 0;
		unsigned8		rawaid := 0;
		string1			nametype := '';
		string3			Lexid_score := '';
		unsigned3 dt_first_seen;
		unsigned3 dt_last_seen;
		boolean		deceased := false;
		unsigned8			address_id;
		unsigned8			hhid;
		string1				address_source;
		string1				current_address_flag;
		string1				confirmed_address_flag;
		string1				better_address_flag;

		string1				judgments := '';
		string1				civilCourtRecords := '';
		string1				crimCourtRecords := '';
		string1				curr_incar_flag := '';
		string1				foreclosures := '';
		string1				bankruptcy := '';
		
END;