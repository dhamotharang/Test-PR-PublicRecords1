import globalwatchlists;

EXPORT Layout_Watchlist := MODULE

	export layout_aliases := RECORD,maxlength(15000)
		string id{xpath('@ID')};
		string type{xpath('Type')};
		string category{xpath('Category')};
		unicode title{xpath('Title')};
		unicode first_name{xpath('First_Name')};
		unicode middle_name{xpath('Middle_Name')};
		unicode last_name{xpath('Last_Name')};
		unicode generation{xpath('Generation')};
		unicode full_name{xpath('Full_Name')};
		unicode comments{xpath('Comments')};
	END;

	export aka_rollup := RECORD,maxlength(15000)
		DATASET(Layout_Aliases) aka{xpath('AKA')};
	END;

	export layout_addresses := RECORD,maxlength(25000)
		string id{xpath('@ID')};
		string type{xpath('Type')};
		unicode street_1{xpath('Street_1')};
		unicode street_2{xpath('Street_2')};
		unicode city{xpath('City')};
		unicode state{xpath('State')};
		unicode postal_code{xpath('Postal_Code')};
		unicode country{xpath('Country')};
		unicode comments{xpath('Comments')};
	END;

	export addr_rollup := RECORD,maxlength(15000)
		DATASET(Layout_Addresses) address{xpath('Address')};
	END;

	export layout_addlinfo := RECORD,maxlength(25000)
		string id{xpath('@ID')};
		string type{xpath('Type')};
		unicode information{xpath('Information')};
		unicode parsed{xpath('Parsed')};
		unicode comments{xpath('Comments')};
	END;

	export addlinfo_rollup := RECORD,maxlength(15000)
		DATASET(Layout_AddlInfo) additionalinfo{xpath('AdditionalInfo')};
	END;

	export layout_sp := RECORD,maxlength(15000)
		string id{xpath('@ID')};
		string type{xpath('Type')};
		unicode label{xpath('Label')};
		unicode number{xpath('Number')};
		unicode issued_by{xpath('Issued_By')};
		string date_issued{xpath('Date_Issued')};
		string date_expires{xpath('Date_Expires')};
		unicode comments{xpath('Comments')};
	END;

	export id_rollup := RECORD,maxlength(15000)
		DATASET(Layout_SP) identification{xpath('Identification')};
	END;

	export layout_phones := RECORD,maxlength(15000)
		string type{xpath('Type')};
		string address_id{xpath('Address_id')};
		unicode number{xpath('Number')};
		unicode comments{xpath('Comments')};
	END;

	export phones_rollup := RECORD,maxlength(15000)
		DATASET(Layout_Phones) phones{xpath('Phone_Number')};
	END;

	// incoming Global Watchlist format
	export rWatchList := RECORD,maxlength(64000)
		string WatchListName{xpath('@Watch_List_Name')};
		string id{xpath('@ID')};
		string WatchListDate{xpath('@Watch_List_Date')};
		string WatchListType{xpath('@Type')};
		string type{xpath('Type')};
		string Entity_Unique_ID {xpath('Entity_Unique_ID')};
		unicode title{xpath('Title')};
		unicode first_name{xpath('First_Name')};
		unicode middle_name{xpath('Middle_Name')};
		unicode last_name{xpath('Last_Name')};
		unicode generation{xpath('Generation')};
		unicode full_name{xpath('Full_Name')};
		string gender{xpath('Gender')};
		string listed_date{xpath('Listed_Date')};
		string modified_date {xpath('Modified_Date')};
		string entity_added_by{xpath('Entity_Added_By')};
		string reason_listed{xpath('Reason_Listed')};
		string reference_id{xpath('Reference_ID')};
		unicode comments{xpath('Comments')};
		unicode search_criteria{xpath('Search_Criteria')};
		dataset(AKA_rollup) aka_list{xpath('AKA_List')};
		dataset(Addr_rollup) address_list{xpath('Address_List')};
		dataset(AddlInfo_rollup) additional_info_list{xpath('Additional_Info_List')};
		dataset(ID_rollup) identification_list{xpath('Identification_List')};
		dataset(phones_rollup) phone_number_list{xpath('Phone_Number_List')};
	END;
	
	////////////////////////////////////////////////////////////////////////////////
	
	export entityLayout := record
		string20 pty_key;
		string60 source;
		string350 orig_pty_name;
		string350 orig_vessel_name;
		string10 name_type;
		string20 entity_type;
		string350 cname;
		string5 title;
		string20 fname;
		string20 mname;
		string20 lname;
		string5 suffix;
		string3 a_score;
		string10 date_first_seen;
		string10 date_last_seen;
		string10 date_vendor_first_reported;
		string10 date_vendor_last_reported;
		string20 entity_id;
		string100 first_name;
		string150 last_name;
		string150 title_1;
		string150 title_2;
		string150 title_3;
		string150 title_4;
		string150 title_5;
		string150 title_6;
		string150 title_7;
		string150 title_8;
		string150 title_9;
		string150 title_10;
		string10 aka_id;
		string15 aka_type;
		string10 aka_category;
		string1 giv_designator;
		string20 date_added_to_list;
		string1 gender;
		string75 remarks_1;
		string75 remarks_2;
		string75 remarks_3;
		string75 remarks_4;
		string75 remarks_5;
		string75 remarks_6;
		string75 remarks_7;
		string75 remarks_8;
		string75 remarks_9;
		string75 remarks_10;
		string75 remarks_11;
		string75 remarks_12;
		string75 remarks_13;
		string75 remarks_14;
		string75 remarks_15;
		string75 remarks_16;
		string75 remarks_17;
		string75 remarks_18;
		string75 remarks_19;
		string75 remarks_20;
		string75 remarks_21;
		string75 remarks_22;
		string75 remarks_23;
		string75 remarks_24;
		string75 remarks_25;
		string75 remarks_26;
		string75 remarks_27;
		string75 remarks_28;
		string75 remarks_29;
		string75 remarks_30;
		string50 linked_with_1;
		string50 linked_with_2;
		string50 linked_with_3;
		string50 linked_with_4;
		string50 linked_with_5;
		string50 linked_with_6;
		string50 linked_with_7;
		string50 linked_with_8;
		string50 linked_with_9;
		string50 linked_with_10;
		string30 linked_with_id_1;
		string30 linked_with_id_2;
		string30 linked_with_id_3;
		string30 linked_with_id_4;
		string30 linked_with_id_5;
		string30 linked_with_id_6;
		string30 linked_with_id_7;
		string30 linked_with_id_8;
		string30 linked_with_id_9;
		string30 linked_with_id_10;
	end;
	
	////////////////////////////////////////////////////////////////////////////////
	
	export stAddrLayout := record
		entityLayout;
		string100 country;
		string50 	addr_1;
		string50 	addr_2;
		string50 	addr_3;
		string50 	addr_4;
		string50 	addr_5;
		string50 	addr_6;
		string50 	addr_7;
		string50 	addr_8;
		string50 	addr_9;
		string50 	addr_10;
		string10 	address_id;
		string150 address_line_1;
		string150 address_line_2;
		string150 address_line_3;
		string75 	address_city;
		string25 	address_state_province;
		string20 	address_postal_code;
		string60 	address_country;
		string10 	prim_range;
		string2 	predir;
		string28 	prim_name;
		string4 	addr_suffix;
		string2 	postdir;
		string10 	unit_desig;
		string8 	sec_range;
		string25 	p_city_name;
		string25 	v_city_name;
		string2 	st;
		string5 	zip;
		string4 	zip4;
		string4 	cart;
		string1 	cr_sort_sz;
		string4 	lot;
		string1 	lot_order;
		string2 	dpbc;
		string1 	chk_digit;
		string2 	record_type;
		string2 	ace_fips_st;
		string3 	county;
		string10 	geo_lat;
		string11 	geo_long;
		string4 	msa;
		string7 	geo_blk;
		string1 	geo_match;
		string4 	err_stat;
	end;
	
	////////////////////////////////////////////////////////////////////////////////
	export addLayout := record
		stAddrLayout;
		integer numrows 	:= 0;
		string10 dob_id_1;
		string10 dob_id_2;
		string10 dob_id_3;
		string10 dob_id_4;
		string10 dob_id_5;
		string10 dob_id_6;
		string10 dob_id_7;
		string10 dob_id_8;
		string10 dob_id_9;
		string10 dob_id_10;
		string20 dob_1;
		string20 dob_2;
		string20 dob_3;
		string20 dob_4;
		string20 dob_5;
		string20 dob_6;
		string20 dob_7;
		string20 dob_8;
		string20 dob_9;
		string20 dob_10;
		string10 pob_id_1;
		string10 pob_id_2;
		string10 pob_id_3;
		string10 pob_id_4;
		string10 pob_id_5;
		string10 pob_id_6;
		string10 pob_id_7;
		string10 pob_id_8;
		string10 pob_id_9;
		string10 pob_id_10;
		string80 pob_1;
		string80 pob_2;
		string80 pob_3;
		string80 pob_4;
		string80 pob_5;
		string80 pob_6;
		string80 pob_7;
		string80 pob_8;
		string80 pob_9;
		string80 pob_10;
		string10 id_id_1;
		string10 id_id_2;
		string10 id_id_3;
		string10 id_id_4;
		string10 id_id_5;
		string10 id_id_6;
		string10 id_id_7;
		string10 id_id_8;
		string10 id_id_9;
		string10 id_id_10;
		string40 id_type_1;
		string40 id_type_2;
		string40 id_type_3;
		string40 id_type_4;
		string40 id_type_5;
		string40 id_type_6;
		string40 id_type_7;
		string40 id_type_8;
		string40 id_type_9;
		string40 id_type_10;
		string30 id_number_1;
		string30 id_number_2;
		string30 id_number_3;
		string30 id_number_4;
		string30 id_number_5;
		string30 id_number_6;
		string30 id_number_7;
		string30 id_number_8;
		string30 id_number_9;
		string30 id_number_10;
		string60 id_country_1;
		string60 id_country_2;
		string60 id_country_3;
		string60 id_country_4;
		string60 id_country_5;
		string60 id_country_6;
		string60 id_country_7;
		string60 id_country_8;
		string60 id_country_9;
		string60 id_country_10;
		string20 id_issue_date_1;
		string20 id_issue_date_2;
		string20 id_issue_date_3;
		string20 id_issue_date_4;
		string20 id_issue_date_5;
		string20 id_issue_date_6;
		string20 id_issue_date_7;
		string20 id_issue_date_8;
		string20 id_issue_date_9;
		string20 id_issue_date_10;
		string20 id_expiration_date_1;
		string20 id_expiration_date_2;
		string20 id_expiration_date_3;
		string20 id_expiration_date_4;
		string20 id_expiration_date_5;
		string20 id_expiration_date_6;
		string20 id_expiration_date_7;
		string20 id_expiration_date_8;
		string20 id_expiration_date_9;
		string20 id_expiration_date_10;
		string350 passport_details;
		string20 sanctions_program_1;
		string20 sanctions_program_2 ;
		string20 sanctions_program_3;
		string20 sanctions_program_4;
		string20 sanctions_program_5;
		string20 sanctions_program_6;
		string20 sanctions_program_7;
		string20 sanctions_program_8;
		string20 sanctions_program_9;
		string20 sanctions_program_10;
	end;
end;