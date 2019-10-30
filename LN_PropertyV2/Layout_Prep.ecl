import aid;

EXPORT	Layout_Prep	:=
module
	export	In	:=
	module	
		// Assessments raw payload layout
		export	AssessmentPayload	:=
		record
			string1998	Payload;
			string1			MainRecordCode;
			string1			RecordType;
		end;
		
		// Deeds raw payload layout
		export	DeedPayload	:=
		record
			string1299	Payload;
			string1			MainRecordCode;
			string200		RemainingPayload;
		end;
		
		// Mortgage raw payload layout
		export	MortgagePayload	:=
		record
			string1249	Payload;
			string1			MainRecordCode;
		end;
		
		// Assessment additional legal
		export	AddlLegal	:=
		record
			string1			replacement_record_ind;
			string2			state_code;	
			string25		county_name;	
			string45		apna_or_pin_number;	
			string2			duplicate_apn_multiple_address_id;
			string1924	legal_description;
			string2			record_type;		
		end;
		
		// Assessment additional names
		export	AddlName	:=
		record
			string1		replacement_record_ind;
			string2		state_code;	
			string25	county_name;	
			string45	apna_or_pin_number;	
			string2		duplicate_apn_multiple_address_id;
			string80	addl_owner_name_1;
			string1		LA_addl_owner_name_ind_1;
			string1		addl_owner_name_type_1;
			string80	addl_owner_name_2;
			string1		LA_addl_owner_name_ind_2;
			string1		addl_owner_name_type_2;
			string80	addl_owner_name_3;
			string1		LA_addl_owner_name_ind_3;
			string1		addl_owner_name_type_3;
			string80	addl_owner_name_4;
			string1		LA_addl_owner_name_ind_4;
			string1		addl_owner_name_type_4;
			string80	addl_owner_name_5;
			string1		LA_addl_owner_name_ind_5;
			string1		addl_owner_name_type_5;
			string80	addl_owner_name_6;
			string1		LA_addl_owner_name_ind_6;
			string1		addl_owner_name_type_6;
			string80	addl_owner_name_7;
			string1		LA_addl_owner_name_ind_7;
			string1		addl_owner_name_type_7;
			string80	addl_owner_name_8;
			string1		LA_addl_owner_name_ind_8;
			string1		addl_owner_name_type_8;
			string80	addl_owner_name_9;
			string1		LA_addl_owner_name_ind_9;
			string1		addl_owner_name_type_9;
			string80	addl_owner_name_10;
			string1		LA_addl_owner_name_ind_10;
			string1		addl_owner_name_type_10;
			string80	addl_owner_name_11;
			string1		LA_addl_owner_name_ind_11;
			string1		addl_owner_name_type_11;
			string80	addl_owner_name_12;
			string1		LA_addl_owner_name_ind_12;
			string1		addl_owner_name_type_12;
			string80	addl_owner_name_13;
			string1		LA_addl_owner_name_ind_13;
			string1		addl_owner_name_type_13;
			string80	addl_owner_name_14;
			string1		LA_addl_owner_name_ind_14;
			string1		addl_owner_name_type_14;
			string80	addl_owner_name_15;
			string1		LA_addl_owner_name_ind_15;
			string1		addl_owner_name_type_15;
			string80	addl_owner_name_16;
			string1		LA_addl_owner_name_ind_16;
			string1		addl_owner_name_type_16;
			string80	addl_owner_name_17;
			string1		LA_addl_owner_name_ind_17;
			string1		addl_owner_name_type_17;
			string80	addl_owner_name_18;
			string1		LA_addl_owner_name_ind_18;
			string1		addl_owner_name_type_18;
			string80	addl_owner_name_19;
			string1		LA_addl_owner_name_ind_19;
			string1		addl_owner_name_type_19;
			string80	addl_owner_name_20;
			string1		LA_addl_owner_name_ind_20;
			string1		addl_owner_name_type_20;
			string80	addl_owner_name_21;
			string1		LA_addl_owner_name_ind_21;
			string1		addl_owner_name_type_21;
			string80	addl_owner_name_22;
			string1		LA_addl_owner_name_ind_22;
			string1		addl_owner_name_type_22;
			string80	addl_owner_name_23;
			string1		LA_addl_owner_name_ind_23;
			string1		addl_owner_name_type_23;
			string38	filler;
			string2		record_type;
		end;
		
		// Assessment main
		export	Assessment	:=
		record
			string1 	replacement_record_ind;
			string2		state_code;	
			string25	county_name;	
			string45	apna_or_pin_number;	
			string2		duplicate_apn_multiple_address_id;	
			string1		property_address_source_flag;	
			string7		property_house_number;	
			string6		property_house_alpha;	
			string2		property_street_direction_left;	
			string30	property_street_name;	
			string4		property_street_suffix;	
			string2		property_street_direction_right;	
			string6		property_unit_number;	
			string60	property_full_street_address;
			string30	property_city_name;	
			string2		property_state;	
			string5		property_zip_code;	
			string4		property_zip_4;	
			string80	assessee_name;	
			string60	second_assessee_name;	
			string2		assessee_vesting_id_code;	
			string30	tax_account_number;	
			string60	mailing_care_of_name;	
			string7		mailing_house_number;	
			string6		mailing_house_alpha;	
			string2		mailing_street_direction_left;	
			string30	mailing_street_name;	
			string4		mailing_street_suffix;	
			string2		mailing_street_direction_right;	
			string6		mailing_unit_number;	
			string80	mailing_full_street_address;	
			string30	mailing_city_name;	
			string2		mailing_state;	
			string5		mailing_zip_code;	
			string4		mailing_zip_4;	
			string10	state_land_use_code;	
			string1		owner_occupied;	
			string10	assessed_land_value;	
			string10	assessed_improvement_value;	
			string11	total_assessed_value;	
			string4		assessment_year;	
			string1		california_homeowner_exemption;	
			string1		tax_exemption1_code;
			string1		tax_exemption2_code;
			string1		tax_exemption3_code;
			string1		tax_exemption4_code;	
			string18	tax_rate_code_area;	
			string10	tax_amount;	
			string4		tax_year;	
			string4		tax_delinquent_year;	
			string20	recorder_document_number;	
			string10	recorder_book_number;	
			string10	recorder_page_number;	
			string8		recording_date;	
			string25	document_type;	
			string10	sales_price;	
			string1		sales_price_code;	
			string8		prior_recording_date;	
			string10	prior_sales_price;	
			string1		prior_sales_code;	
			string2		legal_lot_code;	
			string7		legal_lot_number;
			string10	legal_land_lot;	
			string7		legal_block;	
			string7		legal_section;	
			string12	legal_district;	
			string6		legal_unit;	
			string30	legal_city_municipality_township;	
			string40	legal_subdivision_name;	
			string7		legal_phase_number;	
			string10	legal_tract_number;	
			string30	legal_sec_twn_rng_mer;	
			string125	legal_brief_description;	
			string15	legal_assessor_map_ref;	
			string45	county_land_use_description;	
			string8		county_land_use_code;	
			string4		standardized_land_use_code;	
			string1		timeshare_code;	
			string25	zoning;	
			string14	lot_size_or_area;	
			string9		building_area;	
			string4		year_built;	
			string3		no_of_buildings;	
			string5		no_of_stories;	
			string4		no_of_units;	
			string2		no_of_rooms;	
			string2		no_of_bedrooms;	
			string4		no_of_baths;	
			string2		no_of_partial_baths;	
			string1		garage_type;	
			string4		parking_no_of_cars;	
			string1		pool;	
			string50	mailing_city_state_zip;	
			string5		fips_code;	
			string6		tape_cut_date;	
			string6		census_tract;	
			string2		record_type;	
			string10	market_land_value;	
			string10	market_improvement_value;	
			string11	market_total_value;	
			string4		market_value_year;	
			string1		building_class;	
			string1		style;	
			string1		type_construction;	
			string1		exterior_walls;	
			string1		foundation;	
			string1		roof_cover;	
			string1		heating;	
			string1		air_conditioning;	
			string1		elevator;	
			string1		fireplace;	
			string1		basement;	
			string2		edition_number;	
			string3		property_country_code;	
			string1		building_area_indicator;	
			string1		property_address_match_code_LA_only;	
			string4		property_address_unit_designator_LA_only;	
			string8		property_address_unit_number_LA_only;	
			string4		property_address_carrier_route_LA_only;	
			string1		property_address_geocode_match_code_LA_only;	
			string10	property_address_latitude_LA_only;	
			string11	property_address_longitude_LA_only;	
			string16	property_address_census_tract_block_LA_only;	
			string1		mailing_address_match_code_LA_only;	
			string4		mailing_address_unit_designator_LA_only;	
			string8		mailing_address_unit_number_LA_only;	
			string4		mailing_address_carrier_route_LA_only;	
			string1		assessee_name_indicator;	
			string1		second_assessee_name_indicator;	
			string1		mail_care_of_name_indicator;	
			string1		assessee_name_type;	
			string1		second_assessee_name_type;	
			string1		mail_care_of_name_type;	
			string8		certification_date;	
			string9 	lot_size;
			string2 	building_quality;
			string2 	floor_cover;
			string3 	no_of_plumbing_fixtures;
			string8		building_area1;	
			string2		building_area1_indicator;	
			string8		building_area2;	
			string2		building_area2_indicator;	
			string8		building_area3;	
			string2		building_area3_indicator;	
			string8		building_area4;	
			string2		building_area4_indicator;	
			string8		building_area5;	
			string2		building_area5_indicator;	
			string8		building_area6;	
			string2		building_area6_indicator;	
			string8		building_area7;	
			string2		building_area7_indicator;	
			string4		effective_year_built;	
			string1		heating_fuel_type;	
			string1		air_conditioning_type;
			string10	lot_size_acres;
			string40	mortgage_lender_name;
			string1		interior_walls;
			string15	school_tax_district1;	
			string1		school_tax_district1_indicator;	
			string15	school_tax_district2;	
			string1		school_tax_district2_indicator;	
			string15	school_tax_district3;	
			string1		school_tax_district3_indicator;	
			string1 	site_influence1;
			string1 	site_influence2;
			string1		amenities1_code1;
			string1		amenities1_code2;
			string1		amenities1_code3;
			string1		amenities1_code4;
			string1		amenities1_code5;
			string2		other_impr_building1_indicator;
			string2		other_impr_building2_indicator;
			string2		other_impr_building3_indicator;
			string2		other_impr_building4_indicator;
			string9		neighborhood_code;	
			string20	condo_project_or_building_name;
			string2		other_impr_building5_indicator;
			string1		amenities2_code1;
			string1		amenities2_code2;
			string1		amenities2_code3;
			string1		amenities2_code4;
			string1		amenities2_code5;
			string9		other_impr_building_area1;
			string9		other_impr_building_area2;
			string9		other_impr_building_area3;
			string9		other_impr_building_area4;
			string9		other_impr_building_area5;
			string5 	other_rooms;
			string9 	extra_features1_area;
			string2 	extra_features1_indicator;
			string1 	topography;
			string1		roof_type;
			string9 	extra_features2_area;
			string2 	extra_features2_indicator;
			string9 	extra_features3_area;
			string2 	extra_features3_indicator;
			string9 	extra_features4_area;
			string2 	extra_features4_indicator;
			string31 	old_apn;
			string1 	building_condition;
			string10 	lot_size_frontage;
			string10 	lot_size_depth;
			string120	comments;	
			string1		water;
			string1		sewer;
			string2		new_record_type;
		end;
		
		// Deed main
		export	Deed	:=
		record
			string1		replacement_record_ind;
			string3		data_source_code;
			string1		record_type;
			string18	county_name;
			string2		state;
			string5		fips_code;
			string8		recording_date;
			string10	recorder_book_number;
			string10	recorder_page_number;
			string20	document_number;
			string2		document_type_code;
			string41	apnt_or_pin_number;
			string4		assessment_match_land_use_code;
			string1		multi_apn_flag;
			string2		partial_interest_transferred;
			string40	seller1_first_middle_name;
			string40	seller1_last_or_corp_name;
			string2		seller1_id_code;
			string40	seller2_first_middle_name;
			string40	seller2_last_or_corp_name;
			string2		seller2_id_code;
			string1		seller_addendum_flag;
			string51	seller_mailing_full_street_address;
			string6		seller_mailing_address_unit_number;
			string30	seller_mailing_address_city;
			string2		seller_mailing_address_state;
			string5		seller_mailing_address_zip_code;
			string4		seller_mailing_address_zip_4;
			string40	buyer1_first_middle_name;
			string40	buyer1_last_or_corp_name;
			string2		buyer1_id_code;
			string40	buyer2_first_middle_name;
			string40	buyer2_last_or_corp_name;
			string2		buyer2_id_code;
			string2		buyer_vesting_code;
			string1		buyer_addendum_flag;
			string40	buyer_mailing_address_care_of_name;
			string1		rate_change_frequency;
			string4		change_index;
			string15	adjustable_rate_index;
			string1		adjustable_rate_rider;
			string1		graduated_payment_rider;
			string1		balloon_rider;
			string1		fixed_step_rate_rider;
			string1		condominium_rider;
			string1		planned_unit_development_rider;
			string1		rate_improvement_rider;
			string1		assumability_rider;
			string1		prepayment_rider;
			string1		one_four_family_rider;
			string1		biweekly_payment_rider;
			string1		second_home_rider;
			string19	concurrent_mortgage_book_page_document_number;
			string6		buyer_mailing_address_unit_number;
			string30	buyer_mailing_address_city;
			string2		buyer_mailing_address_state;
			string5		buyer_mailing_address_zip_code;
			string4		buyer_mailing_address_zip_4;
			string2		legal_lot_code;
			string10	legal_lot_number;
			string7		legal_block;
			string7		legal_section;
			string7		legal_district;
			string7		legal_land_lot;
			string6		legal_unit;
			string30	legal_city_municipality_township;
			string50	legal_subdivision_name;
			string7		legal_phase_number;
			string10	legal_tract_number;
			string100	legal_brief_description_opt_hawaii_condo_cpr_code;
			string30	legal_sec_twn_rng_mer_opt_hawaii_condo_name;
			string20	recorder_map_reference;
			string1		property_address_code;
			string51	hawaii_legal;
			string6		property_address_unit_number;
			string30	property_address_city;
			string2		property_address_state;
			string5		property_address_zip_code;
			string4		property_address_zip_4;
			string3		property_use_code;
			string1		timeshare_flag;
			string1		filler_except_hawaii;
			string10	land_lot_size;
			string8		contract_date;
			string10	sales_price;
			string1		sales_price_code;
			string7		city_transfer_tax;
			string7		county_transfer_tax;
			string7		total_transfer_tax;
			string40	lender_name;
			string6		lender_name_id;
			string1		first_td_lender_type_code;
			string9		first_td_loan_amount;
			string1		first_td_loan_type;
			string4		type_financing;
			string4		first_td_interest_rate;
			string8		first_td_due_date;
			string9		second_td_loan_amount;
			string28	title_company_name;
			string2		second_td_lender_type_code;
			string8		arm_reset_date;
			string1		filler3;
			string4		reserved2;
			string10	excise_tax_number;
			string6		hawaii_tct;
			string5		lender_address_zip_code;
			string8		data_entry_date;
			string4		data_entry_operator_code;
			string1		main_record_id_code;
			string60	property_full_street_address;
			string60	buyer_mailing_full_street_address;
			string10	phone_number_or_hawaii_property_address_unit_number;
			string1		complete_legal_description_code;
			string39	tax_id_number;
			string1		assessment_record_match_flag;
			string29	reserved3;
			// BK Adjustment
			///*
			string4	FirstChangeDate_IntRateNotGreaterThan9999miliPercent;
			string4	FirstChangeDate_IntRateNotLessThan9999miliPercent;
			string4	MaximumInterestRate;
			string2	PrepaymentTerm;
			string2	InterestOnlyFlag;
			string10	Reserved4;
			string16	Reserved5;
			string100 raw_file_name;
			//*/

		end;
		
		// Deed additional buyer or seller
		export	AddlBuyerSeller	:=
		record
			string1		buyer_seller_ind;
			string1		replacement_record_ind;
			string3		data_source_code;
			string1		record_type;
			string18	county_name;
			string2		state;
			string5		fips_code;
			string8		recording_date;
			string10	recorder_book_number;
			string10	recorder_page_number;
			string20	document_number;
			string2		buyer_seller_document_type;
			string40	buyer_seller3_first_middle_name;
			string40	buyer_seller3_last_or_corp_name;
			string2		buyer_seller3_id_code;
			string40	buyer_seller4_first_middle_name;
			string40	buyer_seller4_last_or_corp_name;
			string2		buyer_seller4_id_code;
			string40	buyer_seller5_first_middle_name;
			string40	buyer_seller5_last_or_corp_name;
			string2		buyer_seller5_id_code;
			string40	buyer_seller6_first_middle_name;
			string40	buyer_seller6_last_or_corp_name;
			string2		buyer_seller6_id_code;
			string40	buyer_seller7_first_middle_name;
			string40	buyer_seller7_last_or_corp_name;
			string2		buyer_seller7_id_code;
			string40	buyer_seller8_first_middle_name;
			string40	buyer_seller8_last_or_corp_name;
			string2		buyer_seller8_id_code;
			string40	buyer_seller9_first_middle_name;
			string40	buyer_seller9_last_or_corp_name;
			string2		buyer_seller9_id_code;
			string40	buyer_seller10_first_middle_name;
			string40	buyer_seller10_last_or_corp_name;
			string2		buyer_seller10_id_code;
			string40	buyer_seller11_first_middle_name;
			string40	buyer_seller11_last_or_corp_name;
			string2		buyer_seller11_id_code;
			string40	buyer_seller12_first_middle_name;
			string40	buyer_seller12_last_or_corp_name;
			string2		buyer_seller12_id_code;
			string40	buyer_seller13_first_middle_name;
			string40	buyer_seller13_last_or_corp_name;
			string2		buyer_seller13_id_code;
			string40	buyer_seller14_first_middle_name;
			string40	buyer_seller14_last_or_corp_name;
			string2		buyer_seller14_id_code;
			string40	buyer_seller15_first_middle_name;
			string40	buyer_seller15_last_or_corp_name;
			string2		buyer_seller15_id_code;
			string40	buyer_seller16_first_middle_name;
			string40	buyer_seller16_last_or_corp_name;
			string2		buyer_seller16_id_code;
			string72	buyer_seller_filler;
			string1		buyer_seller_record_code;
			string200	buyer_seller_filler2;
		end;
		
		// Mortgage main
		export	Mortgage	:=
		record
			string1		replacement_record_ind;
			string1		record_type;
			string18	county_name;
			string2		state;
			string5		fips_code;
			string8		recording_date;
			string10	recorder_book_number;
			string10	recorder_page_number;
			string20	document_number;
			string45	apn_number;
			string40	borrower1_first_middle_name;
			string40	borrower1_last_or_corp_name;
			string2		borrower1_id_code;
			string40	borrower2_first_middle_name;
			string40	borrower2_last_or_corp_name;
			string2		borrower2_id_code;
			string2		borrower_vesting_code;
			string10	legal_lot_number;
			string7		legal_block;
			string7		legal_section;
			string7		legal_district;
			string7		legal_land_lot;
			string6		legal_unit;
			string30	legal_city_municipality_township;
			string50	legal_subdivision_name;
			string7		legal_phase_number;
			string10	legal_tract_number;
			string100	legal_brief_description;
			string30	legal_sec_twn_rng_mer;
			string60	property_full_street_address;
			string6		property_address_unit_number;
			string30	property_address_city;
			string2		property_address_state;
			string5		property_address_zip_code;
			string4		property_address_zip_4;
			string3		property_use_code;
			string40	lender_name;
			string6		lender_name_id;
			string1		first_td_lender_type_code;
			string9		first_td_loan_amount;
			string1		first_td_loan_type_code;
			string4		type_financing;
			string4		first_td_interest_rate;
			string8		first_td_due_date;
			string8		data_entry_date;
			string4		data_entry_operator_code;
			string15	adjustable_rate_index;
			string2		rate_change_frequency;
			string1		adjustable_rate_rider;
			string1		graduated_payment_rider;
			string1		balloon_rider;
			string1		fixed_step_rate_rider;
			string1		condominium_rider;
			string1		planned_unit_development_rider;
			string1		rate_improvement_rider;
			string1		assumability_rider;
			string1		prepayment_rider;
			string1		one_four_family_rider;
			string1		biweekly_payment_rider;
			string1		second_home_rider;
			string4		change_index;
			string8		arm_reset_date;
			string60	borrower_mailing_full_street_address;
			string6		borrower_mailing_unit_number;
			string30	borrower_mailing_city;
			string2		borrower_mailing_state;
			string5		borrower_mailing_zip_code;
			string4		borrower_mailing_zip_4;
			string8		contract_date;
			string28	title_company_name;
			string40	lender_dba_aka_name;
			string60	lender_full_street_address;
			string6		lender_address_unit_number;
			string30	lender_address_city;
			string2		lender_address_state;
			string5		lender_address_zip_code;
			string4		lender_address_zip_4;
			string3		loan_term_months;
			string2		loan_term_years;
			string20	loan_number;
			string71	filler;
			string1		main_record_id_code;
			string3		data_source_code;
			string68	filler2;
			
			// bk
			///*
			string1	MultiAPNFlag;
			string1	PropertyAddressSourceCode;
			string112	Filler102_1to5;
			string2	DocumentTypeCode;
			string1	BorrowerNameAddendum;
			string2	LegalLotCode_CompleteLegalDescCode;
			string20	RecordersMapReference;
			string14	Filler104;
			string41	TaxIDNumber;
			string2	PrepaymentTerm;
			string4	fistChangeDateIntRateNotGreaterThan;
			string4	firstChangeDateIntRateNotLessThan;
			string4	MaximumInterestRate;
			string2	Reserved201;
			string2	InterestOnlyFlag;
			string3	Reserved202;
			//*/
		end;
		
		// Additional borrower names
		export	AddlBorrower	:=
		record
			string1		replacement_record_ind;
			string1		record_type;
			string18	county_name;
			string2		state;
			string5		fips_code;
			string8		recording_date;
			string10	recorder_book_number;
			string10	recorder_page_number;
			string20	document_number;
			string45	apnt_or_pin_number;
			string40	borrower3_first_middle_name;
			string40	borrower3_last_or_corp_name;
			string2		borrower3_id_code;
			string40	borrower4_first_middle_name;
			string40	borrower4_last_or_corp_name;
			string2		borrower4_id_code;
			string40	borrower5_first_middle_name;
			string40	borrower5_last_or_corp_name;
			string2		borrower5_id_code;
			string40	borrower6_first_middle_name;
			string40	borrower6_last_or_corp_name;
			string2		borrower6_id_code;
			string40	borrower7_first_middle_name;
			string40	borrower7_last_or_corp_name;
			string2		borrower7_id_code;
			string40	borrower8_first_middle_name;
			string40	borrower8_last_or_corp_name;
			string2		borrower8_id_code;
			string40	borrower9_first_middle_name;
			string40	borrower9_last_or_corp_name;
			string2		borrower9_id_code;
			string40	borrower10_first_middle_name;
			string40	borrower10_last_or_corp_name;
			string2		borrower10_id_code;
			string40	borrower11_first_middle_name;
			string40	borrower11_last_or_corp_name;
			string2		borrower11_id_code;
			string40	borrower12_first_middle_name;
			string40	borrower12_last_or_corp_name;
			string2		borrower12_id_code;
			string40	borrower13_first_middle_name;
			string40	borrower13_last_or_corp_name;
			string2		borrower13_id_code;
			string40	borrower14_first_middle_name;
			string40	borrower14_last_or_corp_name;
			string2		borrower14_id_code;
			string40	borrower15_first_middle_name;
			string40	borrower15_last_or_corp_name;
			string2		borrower15_id_code;
			string64	borrower_filler_1;
			string1		borrower_record_code;
		end;
	
	end;
	
	export	Temp	:=
	module		
		export	AddlLegal	:=
		record(LN_PropertyV2.Layout_Addl_legal)
			string1	Append_ReplRecordInd;
		end;
		
		export	AddlNameTemp	:=
		record(In.AddlName)
			string12	ln_fares_id;
			string8		dt_first_seen;
			string8		dt_last_seen;
			string100	Append_PrepMailingAddr1;
			string50	Append_PrepMailingAddr2;
			string100	Append_PrepPropertyAddr1;
			string50	Append_PrepPropertyAddr2;
		end;
		
		export	AddlName	:=
		record(LN_PropertyV2.Layout_Addl_Names)
			string1	Append_ReplRecordInd;
		end;
		
		export	Assessment	:=
		record(LN_Propertyv2.layout_property_common_model_base)
			string1		Append_ReplRecordInd;
			string100	Append_PrepMailingAddr1;
			string50	Append_PrepMailingAddr2;
			string100	Append_PrepPropertyAddr1;
			string50	Append_PrepPropertyAddr2;
			
			AID.Common.xAID	Append_RawAID;
			string10	prim_range;
			string2		predir;
			string28	prim_name;
			string4		suffix;
			string2		postdir;
			string10	unit_desig;
			string8		sec_range;
			string25	p_city_name;
			string25	v_city_name;
			string2		st;
			string5		zip;
			string4		zip4;
			string4		cart;
			string1		cr_sort_sz;
			string4		lot;
			string1		lot_order;
			string2		dbpc;
			string1		chk_digit;
			string2		rec_type;
			string5		county;
			string10	geo_lat;
			string11	geo_long;
			string4		msa;
			string7		geo_blk;
			string1		geo_match;
			string4		err_stat;
		end;
		
		export	Deed	:=
		record(LN_Propertyv2.Layout_Deed_Mortgage_Common_Model_Base)
			string1		Append_ReplRecordInd;
			string51	Append_HawaiiLegal;
			string100	Append_PrepMailingAddr1;
			string50	Append_PrepMailingAddr2;
			string100	Append_PrepSellerMailingAddr1;
			string50	Append_PrepSellerMailingAddr2;
			string100	Append_PrepPropertyAddr1;
			string50	Append_PrepPropertyAddr2;
		end;
		
		export	AddlBuyerSellerTemp	:=
		record
			string12	ln_fares_id;
			string8		dt_first_seen;
			string8		dt_last_seen;
			string1		buyer_seller_ind;
			string1		replacement_record_ind;
			string3		data_source_code;
			string1		record_type;
			string18	county_name;
			string2		state;
			string5		fips_code;
			string8		recording_date;
			string10	recorder_book_number;
			string10	recorder_page_number;
			string20	document_number;
			string2		buyer_seller_document_type;
			string80	buyer_seller3;
			string2		buyer_seller3_id_code;
			string40	buyer_seller4;
			string2		buyer_seller4_id_code;
			string40	buyer_seller5;
			string2		buyer_seller5_id_code;
			string40	buyer_seller6;
			string2		buyer_seller6_id_code;
			string40	buyer_seller7;
			string2		buyer_seller7_id_code;
			string40	buyer_seller8;
			string2		buyer_seller8_id_code;
			string40	buyer_seller9;
			string2		buyer_seller9_id_code;
			string40	buyer_seller10;
			string2		buyer_seller10_id_code;
			string40	buyer_seller11;
			string2		buyer_seller11_id_code;
			string40	buyer_seller12;
			string2		buyer_seller12_id_code;
			string40	buyer_seller13;
			string2		buyer_seller13_id_code;
			string40	buyer_seller14;
			string2		buyer_seller14_id_code;
			string40	buyer_seller15;
			string2		buyer_seller15_id_code;
			string40	buyer_seller16;
			string2		buyer_seller16_id_code;
			string72	buyer_seller_filler;
			string1		buyer_seller_record_code;
			string200	buyer_seller_filler2;
			string41	Append_ApntOrPinNumber;
			string100	Append_PrepMailingAddr1;
			string50	Append_PrepMailingAddr2;
			string100	Append_PrepSellerMailingAddr1;
			string50	Append_PrepSellerMailingAddr2;
			string100	Append_PrepPropertyAddr1;
			string50	Append_PrepPropertyAddr2;
		end;
		
		export	AddlBuyerSeller	:=
		record(LN_PropertyV2.Layout_Addl_Names)
			string1	Append_ReplRecordInd;
		end;
		
		export	AddlBorrowerTemp	:=
		record
			string12	ln_fares_id;
			string8		dt_first_seen;
			string8		dt_last_seen;
			string1		buyer_seller_ind;
			string1		replacement_record_ind;
			string3		data_source_code;
			string1		record_type;
			string18	county_name;
			string2		state;
			string5		fips_code;
			string45	apnt_or_pin_number;
			string8		recording_date;
			string10	recorder_book_number;
			string10	recorder_page_number;
			string20	document_number;
			string80	borrower3;
			string2		borrower3_id_code;
			string40	borrower4;
			string2		borrower4_id_code;
			string40	borrower5;
			string2		borrower5_id_code;
			string40	borrower6;
			string2		borrower6_id_code;
			string40	borrower7;
			string2		borrower7_id_code;
			string40	borrower8;
			string2		borrower8_id_code;
			string40	borrower9;
			string2		borrower9_id_code;
			string40	borrower10;
			string2		borrower10_id_code;
			string40	borrower11;
			string2		borrower11_id_code;
			string40	borrower12;
			string2		borrower12_id_code;
			string40	borrower13;
			string2		borrower13_id_code;
			string40	borrower14;
			string2		borrower14_id_code;
			string40	borrower15;
			string2		borrower15_id_code;
			string64	borrower_filler_1;
			string1		borrower_record_code;
			string100	Append_PrepMailingAddr1;
			string50	Append_PrepMailingAddr2;
			string100	Append_PrepPropertyAddr1;
			string50	Append_PrepPropertyAddr2;
		end;
		
		export	AddlBorrower	:=
		record(LN_PropertyV2.Layout_Addl_Names)
			string1	Append_ReplRecordInd;
		end;
		
		export	SearchTemp	:=
		record(LN_Propertyv2.Layout_Deed_Mortgage_Property_Search)
		  string3   ln_buyer_mailing_country_code;
      string3   ln_seller_mailing_country_code;
			string1		Append_ReplRecordInd;
			string100	Append_PrepMailingAddr1;
			string50	Append_PrepMailingAddr2;
			string100	Append_PrepSellerMailingAddr1;
			string50	Append_PrepSellerMailingAddr2;
			string100	Append_PrepPropertyAddr1;
			string50	Append_PrepPropertyAddr2;
		end;
		
		export	Search	:=
		record(LN_Propertyv2.Layout_Deed_Mortgage_Property_Search)
			string1	Append_ReplRecordInd;
		end;
		
		export AddlNameInfo	:= 
			record(LN_Propertyv2.layout_addl_name_info)
			string1 Append_ReplRecordInd;
		end;
	end;
	/*
	export	AssessmentCleanName	:=
	record(AssessmentRaw)
		string70	careof_pname1;
		string80	careof_cname1;
		string70	careof_pname2;
		string80	careof_cname2;
		string70	assessee2_pname1;
		string80	assessee2_cname1;
		string70	assessee2_pname2;
		string80	assessee2_cname2;
		string70	assessee1_pname1;
		string80	assessee1_cname1;
		string70	assessee1_pname2;
		string80	assessee1_cname2;
	end;
	*/
end;