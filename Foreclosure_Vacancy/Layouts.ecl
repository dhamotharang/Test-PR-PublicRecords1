import ut, iesp;

EXPORT Layouts := MODULE
	export Foreclosure_Full :=  record
		string70 foreclosure_id;
		string2  state;
		string3  county;
		string18 batch_date_and_seq_nbr;
		string3  deed_category;
		string55 deed_desc;
		string3  document_type;
		string40 document_desc;
		string8  recording_date;
		string4  document_year;
		string12 document_nbr;
		string6  document_book;
		string6  document_pages;
		string5  title_company_code;
		string60 title_company_name;
		string60 attorney_name;
		string10 attorney_phone_nbr;
		string30 first_defendant_borrower_owner_first_name;
		string30 first_defendant_borrower_owner_last_name;
		string30 first_defendant_borrower_company_name;
		string30 second_defendant_borrower_owner_first_name;
		string30 second_defendant_borrower_owner_last_name;
		string30 second_defendant_borrower_company_name;
		string30 third_defendant_borrower_owner_first_name;
		string30 third_defendant_borrower_owner_last_name;
		string30 third_defendant_borrower_company_name;
		string30 fourth_defendant_borrower_owner_first_name;
		string30 fourth_defendant_borrower_owner_last_name;
		string30 fourth_defendant_borrower_company_name;
		string1  defendant_borrower_owner_et_al_indicator;
		string10 et_al_desc;
		string10 date_of_default;
		string11 amount_of_default;
		string10 filing_date;
		string1  lis_pendens_type;
		string30 plaintiff_1;
		string30 plaintiff_2;
		string11 final_judgment_amount;
		string10 auction_date;
		string10 auction_time;
		string30 street_address_of_auction_call;
		string25 city_of_auction_call;
		string2  state_of_auction_call;
		string11 opening_bid;
		string4  tax_year;
		string11 sales_price;
		string1  situs_address_indicator_1;
		string5  situs_house_number_prefix_1;
		string10 situs_house_number_1;
		string10 situs_house_number_suffix_1;
		string30 situs_street_name_1;
		string5  situs_mode_1;
		string2  situs_direction_1;
		string2  situs_quadrant_1;
		string6  apartment_unit;
		string40 property_city_1;
		string2  property_state_1;
		string9  property_address_zip_code_1;
		string4  carrier_code;
		string60 full_site_address_unparsed_1;
		string30 lender_beneficiary_first_name;
		string30 lender_beneficiary_last_name;
		string30 lender_beneficiary_company_name;
		string60 lender_beneficiary_mailing_address;
		string40 lender_beneficiary_city;
		string2  lender_beneficiary_state;
		string9  lender_beneficiary_zip;
		string10 lender_phone;
		string20 trustee_sale_number;
		string8  original_loan_date;
		string8  original_loan_recording_date;
		string11 original_loan_amount;
		string12 original_document_number;
		string6  original_recording_book;
		string6  original_recording_page;
		string45 parcel_number_parcel_id;
		string45 parcel_number_unmatched_id;
		string8  last_full_sale_transfer_date;
		string11 transfer_value;
		string1  situs_address_indicator_2;
		string5  situs_house_number_prefix_2;
		string10 situs_house_number_2;
		string10 situs_house_number_suffix_2;
		string30 situs_street_name_2;
		string5  situs_mode_2;
		string2  situs_direction_2;
		string2  situs_quadrant_2;
		string6  apartment_unit_2;
		string40 property_city_2;
		string2  property_state_2;
		string9  property_address_zip_code_2;
		string4  carrier_code_2;
		string60 full_site_address_unparsed_2;
		string3  property_indicator;
		string55 property_desc;
		string4  use_code;
		string55 use_desc;
		string5  number_of_units;
		string9  living_area_square_feet;
		string5  number_of_bedrooms;
		string5  number_of_bathrooms;
		string3  number_of_garages;
		string10 zoning_code;
		string9  lot_size;
		string4  year_built;
		string11 current_land_value;
		string11 current_improvement_value;
		string3  section;
		string3  township;
		string3  foreclosure_range;
		string5  lot_orig;
		string5  block;
		string30 tract_subdivision_name;
		string6  map_book;
		string6  map_page;
		string5  unit_nbr;
		string250 expanded_legal;
		string250 legal_2;
		string250 legal_3;
		string50 legal_4;
		string5  name1_prefix;
		string20 name1_first;
		string20 name1_middle;
		string20 name1_last;
		string5  name1_suffix;
		string3  name1_score;
		string60 name1_company;
		string5  name2_prefix;
		string20 name2_first;
		string20 name2_middle;
		string20 name2_last;
		string5  name2_suffix;
		string3  name2_score;
		string60 name2_company;
		string10 situs1_prim_range;
		string2  situs1_predir;
		string28 situs1_prim_name;
		string4  situs1_addr_suffix;
		string2  situs1_postdir;
		string10 situs1_unit_desig;
		string8  situs1_sec_range;
		string25 situs1_p_city_name;
		string25 situs1_v_city_name;
		string2  situs1_st;
		string5  situs1_zip;
		string4  situs1_zip4;
		string4  situs1_cart;
		string1  situs1_cr_sort_sz;
		string4  situs1_lot;
		string1  situs1_lot_order;
		string2  situs1_dpbc;
		string1  situs1_chk_digit;
		string2  situs1_record_type;
		string2  situs1_ace_fips_st;
		string3  situs1_fipscounty;
		string10 situs1_geo_lat;
		string11 situs1_geo_long;
		string4  situs1_msa;
		string7  situs1_geo_blk;
		string1  situs1_geo_match;
		string4  situs1_err_stat;
		string8 process_date;
	end;

 
	export ADVO_full := record
		string60	UniqueID;		
		string5 	zip;
		string10 	prim_range;
		string28 	prim_name;
		string4 	addr_suffix;
		string2 	predir;
		string2 	postdir;
		string8 	sec_range;
		string5 	zip_5;
		string4 	route_num;
		string4 	zip_4;
		string9 	walk_sequence;
		string10 	street_num;
		string2 	street_pre_directional;
		string28 	street_name;
		string2 	street_post_directional;
		string4 	street_suffix;
		string4 	secondary_unit_designator;
		string8 	secondary_unit_number;
		string1 	address_vacancy_indicator;
		string1 	throw_back_indicator;
		string1 	seasonal_delivery_indicator;
		string5 	seasonal_start_suppression_date;
		string5 	seasonal_end_suppression_date;
		string1 	dnd_indicator;
		string1 	college_indicator;
		string10 	college_start_suppression_date;
		string10 	college_end_suppression_date;
		string1 	address_style_flag;
		string5 	simplify_address_count;
		string1 	drop_indicator;
		string1 	residential_or_business_ind;
		string2 	dpbc_digit;
		string1 	dpbc_check_digit;
		string10 	update_date;
		string10 	file_release_date;
		string10 	override_file_release_date;
		string3 	county_num;
		string28 	county_name;
		string28 	city_name;
		string2 	state_code;
		string2 	state_num;
		string2 	congressional_district_number;
		string1 	owgm_indicator;
		string1 	record_type_code;
		string10 	advo_key;
		string1 	address_type;
		string1 	mixed_address_usage;
		string8 	date_first_seen;
		string8 	date_last_seen;
		string8 	date_vendor_first_reported;
		string8 	date_vendor_last_reported;
		string8 	vac_begdt;
		string8 	vac_enddt;
		string8 	months_vac_curr;
		string8 	months_vac_max;
		string8 	vac_count;
		string10 	unit_desig;
		string25 	p_city_name;
		string25 	v_city_name;
		string2 	st;
		string4 	zip4;
		string4 	cart;
		string1 	cr_sort_sz;
		string4 	lot;
		string1 	lot_order;
		string2 	dbpc;
		string1 	chk_digit;
		string2 	rec_type;
		string2 	fips_county;
		string3 	county;
		string10 	geo_lat;
		string11 	geo_long;
		string4 	msa;
		string7 	geo_blk;
		string1 	geo_match;
		string4 	err_stat;
	end;
//Working Data Layouts
	export in_data := record
		string60	UniqueID;
		string30	acctno;
		string20	first_name;
		string1		middle_initial;
		string20	last_name;
		string60	street_address;
		string5		apt;
		string20	city;
		string2		state;
		string5		zip;
		string4		zip4;
	end;

	export in_clean := record
		string60	UniqueID_in;
		STRING20	first_name_in;
		STRING1		middle_initial_in;
		STRING20	last_name_in;
		STRING60	street_address_in;
		STRING5		apt_in;
		STRING20	city_in;
		STRING2		state_in;
		STRING5		zip_in;
		STRING4		zip4_in;
		//appended
		STRING10 	prim_range;
		STRING2  	predir;
		STRING28 	prim_name;
		STRING4  	suffix;
		STRING2  	postdir;
		STRING10 	unit_desig;
		STRING8  	sec_range;
		STRING25 	p_city_name;
		STRING2  	st;
		STRING5  	zip;
		STRING4  	zip4;
		STRING10 	geo_lat;
		STRING11 	geo_long;
		STRING7	 	geo_blk;
		STRING8		DMS_lat;
		STRING7		DMS_long;
		STRING5	 	county;
		STRING4  	msa;
		STRING1	 	geo_match;
		STRING12	geolink;
	end;

	export ADVO := record
		string60	UniqueID;
		STRING1		Potentially_Vacant := 'N';
		STRING10	Vacancy_First_Seen;
		STRING3		Vacancy_count;
		STRING3		Vacancy_current_duration;
		STRING3		Vacancy_max_duration;
	end;

	export Foreclosure := record
		Foreclosure_Full;
		string60	fc_unique_ID;
		string2		fc_count_12mo;						//prefill field
		string1		fc_found_12mo;						//prefill field
		STRING1		FC_IND := 'N';						//foreclosure match by name and address
		STRING1		FC_ADDR_IND := 'N';				//foreclosure match by address
		STRING1		prev_foreclosure_type;		//previous foreclosure type
		STRING2		OWNER_TYPE := 'UK';				//Derived: FO-First Owner, SO-Second Owner, UK-Unknown
		STRING10	CP_DATA_DATE;							//Derived newest of filing_date and record_date
		STRING1		FORECLOSURE_STAGE := '0'; //1-4, 1-Notice of delinquency, 2-Court affirmed, 3-Foreclosure, 4-Deed Transfer (to auction or purchase);
		STRING3		DEED_EVENT_TYPE_CD; 	 		//deed_category
		STRING55	DEED_EVENT_TYPE_DESC; 	 	//deed_desc 
		STRING3		DOC_TYPE_CD; 	 						//document_type 
		STRING40	DOC_TYPE_DESC;  	 				//document_desc
		STRING11	CP_SALE_AMT; 	 						//sales_price
		STRING11	CP_DFLT_AMT; 	 						//amount_of_default
		STRING10	CP_DFLT_DT;  	 						//date_of_default, format YYYYMMDD
		STRING10	CP_AUCTION_DT; 	 					//auction_date, format YYYYMMDD
		STRING30	LNDR_CMPNY_NAME; 	 				//lender_beneficiary_company_name
		STRING3		PROPERTY_TYPE_CD; 	 			//property_indicator
		STRING55	PROPERTY_TYPE_DESC; 	 		//property_desc
		STRING30	OWNR_1_FIRST_NAME; 	 			//first_defendant_borrower_owner_first_name
		STRING30	OWNR_1_LAST_NAME; 	 			//first_defendant_borrower_owner_last_name
		STRING30	OWNR_1_CMPNY_NAME; 	 			//first_defendant_borrower_company_name
		STRING30	OWNR_2_FIRST_NAME; 	 			//second_defendant_borrower_owner_first_name
		STRING30	OWNR_2_LAST_NAME; 	 			//second_defendant_borrower_owner_last_name
		STRING30	OWNR_3_FIRST_NAME; 	 			//third_defendant_borrower_owner_first_name
		STRING30	OWNR_3_LAST_NAME; 	 			//third_defendant_borrower_owner_last_name
		STRING30	OWNR_4_FIRST_NAME; 	 			//fourth_defendant_borrower_owner_first_name
		STRING30	OWNR_4_LAST_NAME; 	 			//fourth_defendant_borrower_owner_last_name
		STRING10	CP_FILING_DT; 	 					//filing_date, format YYYYMMDD
		STRING10	CP_RECORDING_DT; 	 				//recording_date, format YYYYMMDD
		STRING30	SUBDV_NAME; 	 						//tract_subdivision_name
		STRING20	COURT_CASE_NBR; 	 				//court_case_nbr
		STRING30	PLNTFF1_NAME; 	 					//plaintiff_1
		STRING30	PLNTFF2_NAME; 	 					//plaintiff_2
		STRING30	TRUSTEE_NAME; 	 					//trustee_name
		STRING60	TRUSTEE_ADDR; 	 					//trustee_mailing_address
		STRING40	TRUSTEE_CITY; 	 					//trustee_city
		STRING2		TRUSTEE_STATE; 	 					//trustee_state
		STRING9		TRUSTEE_ZIPCD; 	 					//trustee_zip
		STRING10	TRUSTEE_PHONE_NBR; 	 			//trustee_phone
		STRING8		ORIG_LOAN_DT; 	 					//original_loan_date
		STRING8		ORIG_LOAN_RECORDING_DT; 	//original_loan_recording_date
		STRING8		LAST_FULLSALE_TRNSFR_DT; 	//last_full_sale_transfer_date
		STRING250	EXPAND_LEGAL_DESC; 	 			//expanded_legal
		STRING250	LEGAL_DESC_2; 	 					//legal_2
		STRING250	LEGAL_DESC_3; 	 					//legal_3
		STRING50	LEGAL_DESC_4; 	 					//legal_4
		STRING1 SOURCE;        //vendor_source
	end;
//Output Layouts

	export Interactive := record
		STRING1		foreclosure_12mo;
		STRING3		foreclosure_type;
		STRING55	foreclosure_type_description;
		STRING10 	foreclosure_date;
		STRING3		foreclosure_count_12mo;
		BOOLEAN		Potentially_Vacant := FALSE;
		STRING10	Vacancy_First_Seen;
		STRING3		Vacancy_count;
		STRING3		Vacancy_current_duration;
		STRING3		Vacancy_max_duration;
	end;	
	export Renewal := record
		string60	fc_unique_ID;
		STRING1		FC_IND := 'N';						//foreclosure match by name and address
		STRING1		FC_ADDR_IND := 'N';				//foreclosure match by address
		STRING2		OWNER_TYPE;								//Derived: NA-No Foreclsoure Found, FO-First Owner, SO-Second Owner, UK-Unknown
		STRING10	CP_DATA_DATE;							//Derived newest of filing_date and record_date
		STRING1		FORECLOSURE_STAGE := '0'; //1-4, 1-Notice of delinquency, 2-Court affirmed, 3-Foreclosure, 4-Deed Transfer (to auction or purchase);
		STRING3		DEED_EVENT_TYPE_CD; 	 		//deed_category
		STRING55	DEED_EVENT_TYPE_DESC; 	 	//deed_desc 
		STRING3		DOC_TYPE_CD; 	 						//document_type 
		STRING40	DOC_TYPE_DESC;  	 				//document_desc
		STRING11	CP_SALE_AMT; 	 						//sales_price
		STRING11	CP_DFLT_AMT; 	 						//amount_of_default
		STRING10	CP_DFLT_DT;  	 						//date_of_default, format YYYYMMDD
		STRING10	CP_AUCTION_DT; 	 					//auction_date, format YYYYMMDD
		STRING30	LNDR_CMPNY_NAME; 	 				//lender_beneficiary_company_name
		STRING2		PROPERTY_TYPE_CD; 	 			//property_indicator
		STRING55	PROPERTY_TYPE_DESC; 	 		//property_desc
		STRING30	OWNR_1_FIRST_NAME; 	 			//first_defendant_borrower_owner_first_name
		STRING30	OWNR_1_LAST_NAME; 	 			//first_defendant_borrower_owner_last_name
		STRING30	OWNR_1_CMPNY_NAME; 	 			//first_defendant_borrower_company_name
		STRING30	OWNR_2_FIRST_NAME; 	 			//second_defendant_borrower_owner_first_name
		STRING30	OWNR_2_LAST_NAME; 	 			//second_defendant_borrower_owner_last_name
		STRING30	OWNR_3_FIRST_NAME; 	 			//third_defendant_borrower_owner_first_name
		STRING30	OWNR_3_LAST_NAME; 	 			//third_defendant_borrower_owner_last_name
		STRING30	OWNR_4_FIRST_NAME; 	 			//fourth_defendant_borrower_owner_first_name
		STRING30	OWNR_4_LAST_NAME; 	 			//fourth_defendant_borrower_owner_last_name
		STRING10	CP_FILING_DT; 	 					//filing_date, format YYYYMMDD
		STRING10	CP_RECORDING_DT; 	 				//recording_date, format YYYYMMDD
		STRING30	SUBDV_NAME; 	 						//tract_subdivision_name
		STRING20	COURT_CASE_NBR; 	 				//court_case_nbr
		STRING30	PLNTFF1_NAME; 	 					//plaintiff_1
		STRING30	PLNTFF2_NAME; 	 					//plaintiff_2
		STRING30	TRUSTEE_NAME; 	 					//trustee_name
		STRING60	TRUSTEE_ADDR; 	 					//trustee_mailing_address
		STRING40	TRUSTEE_CITY; 	 					//trustee_city
		STRING2		TRUSTEE_STATE; 	 					//trustee_state
		STRING9		TRUSTEE_ZIPCD; 	 					//trustee_zip
		STRING10	TRUSTEE_PHONE_NBR; 	 			//trustee_phone
		STRING8		ORIG_LOAN_DT; 	 					//original_loan_date
		STRING8		ORIG_LOAN_RECORDING_DT; 	//original_loan_recording_date
		STRING8		LAST_FULLSALE_TRNSFR_DT; 	//last_full_sale_transfer_date
		STRING250	EXPAND_LEGAL_DESC; 	 			//expanded_legal
		STRING250	LEGAL_DESC_2; 	 					//legal_2
		STRING250	LEGAL_DESC_3; 	 					//legal_3
		STRING50	LEGAL_DESC_4; 	 					//legal_4
	end;
	export FC_Prev := record
		string30 	prev_frst_name1;
		string30 	prev_last_name1;
		string30 	prev_frst_name2;
		string30 	prev_last_name2;
		string1		prev_fc_type;
		string2		prev_owner_type;
	end;
	export Foreclosure_plus := record
		Foreclosure;
		FC_Prev;
	end;
	export Final_Renewal := record
		in_clean;
		STRING1		VACANCY_IND := 'N';							
		STRING10	VAC_BEGDT;								
		Renewal;
	end;
	export Final_Batch := record
		STRING30	ACCTNO;
		Final_Renewal;
	end;
	export Final_Interactive := record
		in_clean;
		Interactive;
	end;
	export Final_Renewal_seed := record
		string20 dataset_name;
		Final_Renewal;
	end;
	export Final_Interactive_seed := record
		string20 dataset_name;
		Final_Interactive
	end;
	export Final_Renewal_seed_key := record
		data16 hashvalue; 
		Final_Renewal_seed;
	end;
	export Final_Interactive_seed_key := record
		data16 hashvalue;
		Final_Interactive_seed;
	end;
	
END;
