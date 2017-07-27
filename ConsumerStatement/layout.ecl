EXPORT layout := module
	export nonfcra := module
		export consumer := record, maxlength(10000)
			integer statement_id := 0;
			string30	orig_fname := '';
			string30	orig_lname := '';
			string30	orig_mname := '';
			string100 orig_cname := ''; // populate this for company
			string100	orig_address := '';
			string30 orig_city := '';
			string2 orig_st := '';
			string5 orig_zip := '';
			string4 orig_zip4 := '';
			string10 phone := '';
			
			// clean name fields
			string5  title					 := '';
			string20 fname					 := '';
			string20 mname					 := '';
			string20 lname					 := '';
			string5  name_suffix		 := '';
			string3  name_score			 := '';
			// clean address fields
			string10        prim_range := ''; 	// [1..10]
			string2         predir := '';		// [11..12]
			string28        prim_name := '';	// [13..40]
			string4         addr_suffix := '';  // [41..44]
			string2         postdir := '';		// [45..46]
			string10        unit_desig := '';	// [47..56]
			string8         sec_range := '';	// [57..64]
			string25        p_city_name := '';	// [65..89]
			string25        v_city_name := '';  // [90..114]
			string2         st := '';			// [115..116]
			string5         zip := '';		// [117..121]
			string4         zip4 := '';		// [122..125]
			string4         cart := '';		// [126..129]
			string1         cr_sort_sz := '';	// [130]
			string4         lot := '';		// [131..134]
			string1         lot_order := '';	// [135]
			string2         dbpc := '';		// [136..137]
			string1         chk_digit := '';	// [138]
			string2         rec_type := '';	// [139..140]
			string5         county := '';		// [141..145]
			string10        geo_lat := '';		// [146..155]
			string11        geo_long := '';	// [156..166]
			string4         msa := '';		// [167..170]
			string7         geo_blk := '';		// [171..177]
			string1         geo_match := '';	// [178]
			string4         err_stat := '';	// [179..182]
			string20 date_submitted := ''; // date when user updated the information
			string20 date_created := ''; // date when the first time user created it
			unsigned6 did := 0;
			string consumer_text := '';
			integer	override_flag := 0;

		end;
	end;
	export fcra := module
		export consumer := record
			unsigned8 LexID;
			string9 SSN;
			string20 fname;
			string20 lname;
			varstring cs_text;
			string20 datecreated;
		end;
	end;
end;