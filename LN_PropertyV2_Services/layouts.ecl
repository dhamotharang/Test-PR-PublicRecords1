import doxie, doxie_cbrs, BIPV2, LN_PropertyV2_Services, FFD;

export layouts := module
	
	// common layouts --------------------------------------------------

	export fid := record
		LN_PropertyV2_Services.keys.assessor().ln_fares_id;
		unsigned6 search_did := 0;  // this is the did that was used to begin the original search for property.
	end;										// This can be used to select correct corrections to be applied.  And support NonSubjectSuppression
	
	export search_fid := record(fid)
		boolean isDeepDive := false;
	end;
	
	export _faresIds := record
		fid;
	end;
	
	export pen := record
		unsigned2 penalt;
		unsigned2 cPenalt;
	end;
	export core := record
		search_fid;
		string1 fid_type;
		string8 fid_type_desc; // Deed or Assessed
		pen;
		string8 sortby_date := '';
		LN_PropertyV2_Services.keys.assessor().vendor_source_flag;
		string5 vendor_source_desc;
		string1 current_record;
		integer key_robustness_score := 0;
		integer total_robustness_score := 0;
		integer2 num_recs := -1;
		// NOTE: num_recs is used internally as part of the "early marshalling" process,
		//       as part of computing the RecordsAvailable output.  It is not used directly
		//       by ESP or the customers, and ideally should probably have been thinned from
		//       the final output.  A -1 value indicates marshalling was deferred.  See
		//       LN_PropertyV2_Services.Marshall for all the ugly details.
	end;

	export search_did		:= doxie.layout_references;
	export search_bdid	:= doxie_cbrs.layout_references;
	export search_pnum	:= { typeof(LN_PropertyV2_Services.keys.assessor().apna_or_pin_number) pnum; };
	
	export search_addr	:= record
		LN_PropertyV2_Services.keys.search().prim_name;
		LN_PropertyV2_Services.keys.search().prim_range;
		LN_PropertyV2_Services.keys.search().zip;
		LN_PropertyV2_Services.keys.search().predir;
		LN_PropertyV2_Services.keys.search().postdir;
		LN_PropertyV2_Services.keys.search().suffix;
		LN_PropertyV2_Services.keys.search().sec_range;
	end;
	
	// baseParties ----------------------------------------------
	
	export baseParties := module
	
		// keys.deed
		export baseDeed := record
			//combine buyers and borrowers and set flag to indicate which type
			//a record can never have both
			string1   buyer_or_borrower_ind; //new - 'O' for buyer, 'B' for borrower
			string80  name1; //new
			string2   name1_id_code; //new
			string80  name2; //new
			string2   name2_id_code; //new
			
			string40  mailing_care_of; //new
			string70  mailing_street; //new
			string6   mailing_unit_number; //new
			string51  mailing_csz; //new
			string1   mailing_address_cd; //new 
			
			string80  seller1;
			string80  seller2;
			string70  seller_mailing_full_street_address;
			string6   seller_mailing_address_unit_number;
			string51  seller_mailing_address_citystatezip;
			
			string70  property_full_street_address;
			string6   property_address_unit_number;
			string51  property_address_citystatezip;

			string1   addl_name_flag; 
			string1   prop_addr_propagated_ind; //new
		end;
	
		// keys.assessor
		export baseAssess := record
			string80	assessee_name;
			string60	second_assessee_name;
			// string3		assessee_ownership_rights_code;
			// string2		assessee_relationship_code;
			// string10	assessee_phone_number;

			// string45	contract_owner;
			// string1		assessee_name_type_code;
			// string1		second_assessee_name_type_code;
			// string1		mail_care_of_name_type_code;
			
			// string60	mailing_care_of_name;
			string80	mailing_full_street_address;
			string6		mailing_unit_number;
			string51	mailing_city_state_zip;
			
			string60	property_full_street_address;
			string6		property_unit_number;
			string51  property_city_state_zip;
			string3		property_country_code;
			// string1		property_address_code;

			string1		assessee_name_indicator;
			string1		second_assessee_name_indicator;
			string1		mail_care_of_name_indicator;  
		end;
	end; // baseParties
	
	
	// parties --------------------------------------------------
	
	export parties := module
	
												
 		export raw_source := { LN_PropertyV2_Services.keys.search() , unsigned6 search_did , FFD.Layouts.CommonRawRecordElements};

		
		export entity := record
			LN_PropertyV2_Services.keys.search().title;
			LN_PropertyV2_Services.keys.search().fname;
			LN_PropertyV2_Services.keys.search().mname;
			LN_PropertyV2_Services.keys.search().lname;
			LN_PropertyV2_Services.keys.search().name_suffix;
			LN_PropertyV2_Services.keys.search().cname;
			string12 did;
			string12 bdid;
			BIPV2.IDlayouts.l_header_ids;
			LN_PropertyV2_Services.keys.search().app_ssn;
			FFD.Layouts.CommonRawRecordElements;
		end;
		
		export orig := record
			unsigned2	name_seq;
			string120	orig_name;
			string2		id_code;
			string54	id_desc;
		end;
	
		export pparty := record
			// typeof(keys.search().source_code_2) addr_type;
			// string16 addr_type_name;
			typeof(LN_PropertyV2_Services.keys.search().source_code_1) party_type;
			string8 party_type_name;
			// keys.search().nameasis;
			string80	orig_addr;
			string6		orig_unit;
			string51	orig_csz;
			LN_PropertyV2_Services.keys.search().prim_range;
			LN_PropertyV2_Services.keys.search().predir;
			LN_PropertyV2_Services.keys.search().prim_name;
			LN_PropertyV2_Services.keys.search().suffix;
			LN_PropertyV2_Services.keys.search().postdir;
			LN_PropertyV2_Services.keys.search().unit_desig;
			LN_PropertyV2_Services.keys.search().sec_range;
			LN_PropertyV2_Services.keys.search().p_city_name;
			LN_PropertyV2_Services.keys.search().v_city_name;
			LN_PropertyV2_Services.keys.search().st;
			LN_PropertyV2_Services.keys.search().zip;
			LN_PropertyV2_Services.keys.search().zip4;
			LN_PropertyV2_Services.keys.search().cart;
			LN_PropertyV2_Services.keys.search().cr_sort_sz;
			LN_PropertyV2_Services.keys.search().lot;
			LN_PropertyV2_Services.keys.search().lot_order;
			LN_PropertyV2_Services.keys.search().dbpc;
			LN_PropertyV2_Services.keys.search().chk_digit;
			LN_PropertyV2_Services.keys.search().rec_type;
			LN_PropertyV2_Services.keys.search().county;
			string18	county_name;				// max=18
			LN_PropertyV2_Services.keys.search().geo_lat;
			LN_PropertyV2_Services.keys.search().geo_long;
			LN_PropertyV2_Services.keys.search().msa;
			LN_PropertyV2_Services.keys.search().geo_blk;
			LN_PropertyV2_Services.keys.search().geo_match;
			LN_PropertyV2_Services.keys.search().phone_number;
			dataset(entity) entity { maxcount(LN_PropertyV2_Services.consts.max_entities) };
			dataset(orig) orig_names { maxcount(LN_PropertyV2_Services.consts.max_names) };
			integer2	xadl2_weight := 0;
		end;
		
		
		export tmp1 := record
			core;
			unsigned2 county_pen;
			LN_PropertyV2_Services.keys.search().dt_last_seen;
			LN_PropertyV2_Services.keys.search().dt_vendor_last_reported;
			typeof(LN_PropertyV2_Services.keys.search().source_code_2) addr_type;
			pparty;
			entity;
		end;

		export tmp2 := record
			core;
			unsigned2 county_pen;
			LN_PropertyV2_Services.keys.search().dt_last_seen;
			LN_PropertyV2_Services.keys.search().dt_vendor_last_reported;
			pparty;
		end;

		export matched_pparty := record
			typeof(LN_PropertyV2_Services.keys.search().source_code_1) party_type;
			string8 party_type_name;
			LN_PropertyV2_Services.keys.search().prim_range;
			LN_PropertyV2_Services.keys.search().predir;
			LN_PropertyV2_Services.keys.search().prim_name;
			LN_PropertyV2_Services.keys.search().suffix;
			LN_PropertyV2_Services.keys.search().postdir;
			LN_PropertyV2_Services.keys.search().unit_desig;
			LN_PropertyV2_Services.keys.search().sec_range;
			LN_PropertyV2_Services.keys.search().p_city_name;
			LN_PropertyV2_Services.keys.search().v_city_name;
			LN_PropertyV2_Services.keys.search().st;
			LN_PropertyV2_Services.keys.search().zip;
			LN_PropertyV2_Services.keys.search().zip4;
			LN_PropertyV2_Services.keys.search().phone_number;
			entity entity;
			integer2	xadl2_weight := 0;
		end;
		
		export rolled := record
			core;
			unsigned2 county_pen;
			dataset(pparty) parties { maxcount(LN_PropertyV2_Services.consts.max_parties) };
			matched_pparty matched_party;
		end;
	
	end; // parties
	

	// assessments --------------------------------------------------
	
	export assess := module
	
		export raw_source := {
													{search_fid} OR {core.sortby_date} OR 
													{LN_PropertyV2_Services.keys.assessor()} OR 
													{LN_PropertyV2_Services.keys.addl_fares_t} OR 
													{LN_PropertyV2_Services.keys.addl_legal()} OR 
													{FFD.Layouts.CommonRawRecordElements}
													}; 
/* 		record
   			search_fid;
   			core.sortby_date;
   			LN_PropertyV2_Services.keys.assessor();
   			LN_PropertyV2_Services.keys.addl_fares_t;
   			LN_PropertyV2_Services.keys.addl_legal();
   			FFD.Layouts.CommonRawRecordElements;
   		end;
*/
	
		export filing_info := module
			export narrow := record
				LN_PropertyV2_Services.keys.assessor().state_code;
				LN_PropertyV2_Services.keys.assessor().county_name;
				LN_PropertyV2_Services.keys.assessor().apna_or_pin_number;
			end;
			
			export wider := record
				narrow;
				LN_PropertyV2_Services.keys.assessor().fips_code;
				LN_PropertyV2_Services.keys.assessor().duplicate_apn_multiple_address_id;
			end;
			
			export widest := record
				wider;
				LN_PropertyV2_Services.keys.assessor().tape_cut_date;
				LN_PropertyV2_Services.keys.assessor().edition_number;
				LN_PropertyV2_Services.keys.assessor().certification_date;
			end;
		end; // filing_info
		
		export owner_info := module
			export narrow := record
				// keys.assessor().assessee_name;					// in parties
				// keys.assessor().second_assessee_name;	// in parties
				LN_PropertyV2_Services.keys.assessor().assessee_ownership_rights_code;
				string47 assessee_ownership_rights_desc;
			end;
			
			export wider := record
				narrow;
				LN_PropertyV2_Services.keys.assessor().assessee_relationship_code;
				string47 assessee_relationship_desc;
			end;
			
			export widest := record
				wider;
				// assessee_vesting_id_code;
				// assessee_vesting_id_desc - Covered by assessee_ownership_rights_desc and assessee_relationship_desc
				LN_PropertyV2_Services.keys.assessor().assessee_phone_number;
				LN_PropertyV2_Services.keys.assessor().tax_account_number;
				LN_PropertyV2_Services.keys.assessor().contract_owner;
				LN_PropertyV2_Services.keys.assessor().assessee_name_type_code;
				string10 assessee_name_type_desc;
				LN_PropertyV2_Services.keys.assessor().second_assessee_name_type_code;
				string10 second_assessee_name_type_desc;
			end;
		end; // owner_info
		
		export address_info := module
			/* The narrow and wider portions of address_info are covered in parties
			export narrow := record
				keys.assessor().mailing_full_street_address;
				keys.assessor().mailing_unit_number;
				keys.assessor().mailing_city_state_zip;
				keys.assessor().property_full_street_address;
				keys.assessor().property_unit_number;
				keys.assessor().property_city_state_zip;
				keys.assessor().property_country_code;
			end;
			
			export wider := record
				narrow;
			end;
			*/
			
			export widest := record
				// wider;
				LN_PropertyV2_Services.keys.assessor().mail_care_of_name_type_code;
				string10 mail_care_of_name_type_desc;
				LN_PropertyV2_Services.keys.assessor().mailing_care_of_name;
				LN_PropertyV2_Services.keys.assessor().property_address_code;
				string76 property_address_desc;
				// property_address_source_flag - Covered by property_address_code
			end;
		end; // address_info

		export legal_info := module
			export narrow := record
				LN_PropertyV2_Services.keys.assessor().owner_occupied;
				LN_PropertyV2_Services.keys.assessor().recording_date;
				LN_PropertyV2_Services.keys.assessor().prior_recording_date;
				LN_PropertyV2_Services.keys.assessor().county_land_use_description;
				LN_PropertyV2_Services.keys.assessor().standardized_land_use_code;
				string76 standardized_land_use_desc;
				LN_PropertyV2_Services.keys.assessor().legal_brief_description;
			end;
			
			export wider := record
				narrow;
				LN_PropertyV2_Services.keys.assessor().legal_lot_number;
				LN_PropertyV2_Services.keys.assessor().legal_subdivision_name;
				LN_PropertyV2_Services.keys.assessor().record_type_code;
				string103 record_type_desc;
				LN_PropertyV2_Services.keys.assessor().recorder_book_number;
				LN_PropertyV2_Services.keys.assessor().recorder_page_number;
			end;
			
			export widest := record
				wider;
				LN_PropertyV2_Services.keys.assessor().legal_lot_code;
				string54 legal_lot_desc;
				LN_PropertyV2_Services.keys.assessor().legal_land_lot;
				LN_PropertyV2_Services.keys.assessor().legal_block;
				LN_PropertyV2_Services.keys.assessor().legal_section;
				LN_PropertyV2_Services.keys.assessor().legal_district;
				LN_PropertyV2_Services.keys.assessor().legal_unit;
				LN_PropertyV2_Services.keys.assessor().legal_city_municipality_township;
				LN_PropertyV2_Services.keys.assessor().legal_phase_number;
				LN_PropertyV2_Services.keys.assessor().legal_tract_number;
				LN_PropertyV2_Services.keys.assessor().legal_sec_twn_rng_mer;
				LN_PropertyV2_Services.keys.assessor().legal_assessor_map_ref;
				LN_PropertyV2_Services.keys.assessor().census_tract;
				LN_PropertyV2_Services.keys.assessor().ownership_type_code;
				string17 ownership_type_desc;
				LN_PropertyV2_Services.keys.assessor().new_record_type_code;
				string35 new_record_type_desc;
				LN_PropertyV2_Services.keys.assessor().timeshare_code;
				LN_PropertyV2_Services.keys.assessor().zoning;
				LN_PropertyV2_Services.keys.assessor().recorder_document_number;
				LN_PropertyV2_Services.keys.assessor().transfer_date;
				LN_PropertyV2_Services.keys.assessor().document_type;
				string36 document_type_desc;
				LN_PropertyV2_Services.keys.assessor().prior_transfer_date;
			end;
		end; // legal_info
		
		
		export sales_info := module
			export narrow := record
				LN_PropertyV2_Services.keys.assessor().sale_date;
				LN_PropertyV2_Services.keys.assessor().sales_price;
			end;
			
			export wider := record
				narrow;
			end;
			
			export widest := record
				wider;
				LN_PropertyV2_Services.keys.assessor().sales_price_code;
				string108 sales_price_desc;
				LN_PropertyV2_Services.keys.assessor().prior_sales_price;
				LN_PropertyV2_Services.keys.assessor().prior_sales_price_code;
				string108 prior_sales_price_desc;
			end;
		end; // sales_info
		
		
		export mortgage_info := module		
			export wider := record
				LN_PropertyV2_Services.keys.assessor().mortgage_loan_amount;
				LN_PropertyV2_Services.keys.assessor().mortgage_loan_type_code;
				string31 mortgage_loan_type_desc;
			end;
			
			export widest := record
				wider;
			end;
		end; // mortgage_info
		
		
		export lender_info := module
			export wider := record
				LN_PropertyV2_Services.keys.assessor().mortgage_lender_name;
			end;
			
			export widest := record
				wider;
				LN_PropertyV2_Services.keys.assessor().mortgage_lender_type_code;
				string30 mortgage_lender_type_desc;
			end;
		end; // lender_info
		
		
		export assessment_info := module
			export narrow := record
				LN_PropertyV2_Services.keys.assessor().assessed_total_value;
				LN_PropertyV2_Services.keys.assessor().assessed_value_year;
				LN_PropertyV2_Services.keys.assessor().homestead_homeowner_exemption;
			end;
			
			export wider := record
				narrow;
				LN_PropertyV2_Services.keys.assessor().assessed_improvement_value;
				LN_PropertyV2_Services.keys.assessor().market_land_value;
				LN_PropertyV2_Services.keys.assessor().market_improvement_value;
				LN_PropertyV2_Services.keys.assessor().market_total_value;
				LN_PropertyV2_Services.keys.assessor().market_value_year;
			end;
			
			export widest := record
				wider;
				LN_PropertyV2_Services.keys.assessor().assessed_land_value;
			end;
		end; // assessment_info

		export tax_info := module
			export narrow := record
				LN_PropertyV2_Services.keys.assessor().tax_year;
			end;
			
			export wider := record
				narrow;
				LN_PropertyV2_Services.keys.assessor().tax_amount;
			end;
			
			export widest := record
				wider;
				LN_PropertyV2_Services.keys.assessor().tax_exemption1_code;
				LN_PropertyV2_Services.keys.assessor().tax_exemption2_code;
				LN_PropertyV2_Services.keys.assessor().tax_exemption3_code;
				LN_PropertyV2_Services.keys.assessor().tax_exemption4_code;
				string21 tax_exemption1_desc;
				string21 tax_exemption2_desc;
				string21 tax_exemption3_desc;
				string21 tax_exemption4_desc;
				LN_PropertyV2_Services.keys.assessor().tax_rate_code_area;
				LN_PropertyV2_Services.keys.assessor().tax_delinquent_year;
				LN_PropertyV2_Services.keys.assessor().school_tax_district1;
				LN_PropertyV2_Services.keys.assessor().school_tax_district2;
				LN_PropertyV2_Services.keys.assessor().school_tax_district3;
			end;
		end; // tax_info
		
		
		export property_info := module
			export wider := record
				LN_PropertyV2_Services.keys.assessor().land_square_footage;
				LN_PropertyV2_Services.keys.assessor().year_built;
				LN_PropertyV2_Services.keys.assessor().no_of_stories;
				string28 no_of_stories_desc;
				LN_PropertyV2_Services.keys.assessor().no_of_bedrooms;
				LN_PropertyV2_Services.keys.assessor().no_of_baths;
				LN_PropertyV2_Services.keys.assessor().no_of_partial_baths;
				LN_PropertyV2_Services.keys.assessor().garage_type_code;
				string30 garage_type_desc;
				LN_PropertyV2_Services.keys.assessor().pool_code;
				string27 pool_desc;
				LN_PropertyV2_Services.keys.assessor().exterior_walls_code;
				string30 exterior_walls_desc;
				LN_PropertyV2_Services.keys.assessor().roof_type_code;
				string20 roof_type_desc;
				LN_PropertyV2_Services.keys.assessor().heating_code;
				string28 heating_desc;
				LN_PropertyV2_Services.keys.assessor().heating_fuel_type_code;
				string23 heating_fuel_type_desc;
				LN_PropertyV2_Services.keys.assessor().air_conditioning_code;
				string28 air_conditioning_desc;
				LN_PropertyV2_Services.keys.assessor().air_conditioning_type_code;
				string18 air_conditioning_type_desc;
			end;
			
			export widest := record
				wider;
				// california_homeowner_exemption - Covered by homestead_homeowner_exemption
				// lot_size_or_area - Covered by land_acres, land_square_footage, land_dimensions
				LN_PropertyV2_Services.keys.assessor().land_acres;
				LN_PropertyV2_Services.keys.assessor().land_dimensions;
				LN_PropertyV2_Services.keys.assessor().building_area;
				LN_PropertyV2_Services.keys.assessor().building_area1;
				LN_PropertyV2_Services.keys.assessor().building_area2;
				LN_PropertyV2_Services.keys.assessor().building_area3;
				LN_PropertyV2_Services.keys.assessor().building_area4;
				LN_PropertyV2_Services.keys.assessor().building_area5;
				LN_PropertyV2_Services.keys.assessor().building_area6;
				LN_PropertyV2_Services.keys.assessor().building_area7;
				LN_PropertyV2_Services.keys.assessor().building_area_indicator;
				LN_PropertyV2_Services.keys.assessor().building_area1_indicator;
				LN_PropertyV2_Services.keys.assessor().building_area2_indicator;
				LN_PropertyV2_Services.keys.assessor().building_area3_indicator;
				LN_PropertyV2_Services.keys.assessor().building_area4_indicator;
				LN_PropertyV2_Services.keys.assessor().building_area5_indicator;
				LN_PropertyV2_Services.keys.assessor().building_area6_indicator;
				LN_PropertyV2_Services.keys.assessor().building_area7_indicator;
				string30 building_area_desc;
				string30 building_area1_desc;
				string30 building_area2_desc;
				string30 building_area3_desc;
				string30 building_area4_desc;
				string30 building_area5_desc;
				string30 building_area6_desc;
				string30 building_area7_desc;
				LN_PropertyV2_Services.keys.assessor().effective_year_built;
				LN_PropertyV2_Services.keys.assessor().no_of_buildings;
				LN_PropertyV2_Services.keys.assessor().no_of_units;
				LN_PropertyV2_Services.keys.assessor().no_of_rooms;
				LN_PropertyV2_Services.keys.assessor().parking_no_of_cars;
				
				LN_PropertyV2_Services.keys.assessor().style_code;
				string29 style_desc;
				LN_PropertyV2_Services.keys.assessor().type_construction_code;
				string27 type_construction_desc;
				LN_PropertyV2_Services.keys.assessor().foundation_code;
				string31 foundation_desc;
				LN_PropertyV2_Services.keys.assessor().roof_cover_code;
				string28 roof_cover_desc;
				LN_PropertyV2_Services.keys.assessor().elevator;
				LN_PropertyV2_Services.keys.assessor().fireplace_indicator;
				string3 fireplace_indicator_desc;
				LN_PropertyV2_Services.keys.assessor().fireplace_number;
				LN_PropertyV2_Services.keys.assessor().basement_code;
				string25 basement_desc;
				LN_PropertyV2_Services.keys.assessor().building_class_code;
				string210 building_class_desc;
				
				LN_PropertyV2_Services.keys.assessor().site_influence1_code;
				LN_PropertyV2_Services.keys.assessor().site_influence2_code;
				LN_PropertyV2_Services.keys.assessor().site_influence3_code;
				LN_PropertyV2_Services.keys.assessor().site_influence4_code;
				LN_PropertyV2_Services.keys.assessor().site_influence5_code;
				string29 site_influence1_desc;
				string29 site_influence2_desc;
				string29 site_influence3_desc;
				string29 site_influence4_desc;
				string29 site_influence5_desc;
				
				LN_PropertyV2_Services.keys.assessor().amenities1_code;
				LN_PropertyV2_Services.keys.assessor().amenities2_code;
				LN_PropertyV2_Services.keys.assessor().amenities3_code;
				LN_PropertyV2_Services.keys.assessor().amenities4_code;
				LN_PropertyV2_Services.keys.assessor().amenities5_code;
				string17 amenities1_desc;
				string17 amenities2_desc;
				string17 amenities3_desc;
				string17 amenities4_desc;
				string17 amenities5_desc;
				
				LN_PropertyV2_Services.keys.assessor().other_buildings1_code;
				LN_PropertyV2_Services.keys.assessor().other_buildings2_code;
				LN_PropertyV2_Services.keys.assessor().other_buildings3_code;
				LN_PropertyV2_Services.keys.assessor().other_buildings4_code;
				LN_PropertyV2_Services.keys.assessor().other_buildings5_code;
				string28 other_buildings1_desc;
				string28 other_buildings2_desc;
				string28 other_buildings3_desc;
				string28 other_buildings4_desc;
				string28 other_buildings5_desc;
				
				// NOTE: keys need to go back to original fieldnames in 1/09
				// keys.assessor().condo_project_name;
				typeof(LN_PropertyV2_Services.keys.assessor().condo_project_or_building_name) condo_project_name;
				// keys.assessor().building_name;
				typeof(LN_PropertyV2_Services.keys.assessor().condo_project_or_building_name) building_name;
				LN_PropertyV2_Services.keys.assessor().comments;
				
				LN_PropertyV2_Services.keys.assessor().neighborhood_code;
			end;
		end; // property_info
		
		
		export fares_info := module
			/*export narrow := record
				keys.addl_fares_t.fares_seller_name; in parties
			end;*/
			
			export wider := record
				// narrow;
				LN_PropertyV2_Services.keys.addl_fares_t.fares_living_square_feet;
			end;
			
			export widest := record
				wider;
				LN_PropertyV2_Services.keys.addl_fares_t.fares_iris_apn;
				// keys.addl_fares_t.fares_non_parsed_assessee_name; // in parties
				// keys.addl_fares_t.fares_non_parsed_second_assessee_name; // in parties
				
				// fares_legal2 - Covered by addl_legal
				// fares_legal3 - Covered by addl_legal
				LN_PropertyV2_Services.keys.addl_legal().addl_legal;
				
				LN_PropertyV2_Services.keys.addl_fares_t.fares_calculated_land_value;
				LN_PropertyV2_Services.keys.addl_fares_t.fares_calculated_improvement_value;
				LN_PropertyV2_Services.keys.addl_fares_t.fares_calculated_total_value;
				LN_PropertyV2_Services.keys.addl_fares_t.fares_adjusted_gross_square_feet;
				LN_PropertyV2_Services.keys.addl_fares_t.fares_no_of_full_baths;
				LN_PropertyV2_Services.keys.addl_fares_t.fares_no_of_half_baths;
				LN_PropertyV2_Services.keys.addl_fares_t.fares_pool_indicator;
				
				LN_PropertyV2_Services.keys.addl_fares_t.fares_frame;
				string25 fares_frame_desc;
				LN_PropertyV2_Services.keys.addl_fares_t.fares_electric_energy;
				string20 fares_electric_energy_desc;
				
				LN_PropertyV2_Services.keys.addl_fares_t.fares_sewer;
				string12 fares_sewer_desc;
				LN_PropertyV2_Services.keys.addl_fares_t.fares_water;
				string12 fares_water_desc;
				LN_PropertyV2_Services.keys.addl_fares_t.fares_condition;
				string18 fares_condition_desc;
			end;
		end; // fares_info
		
		export result := module
			export narrow := record
				filing_info.narrow;
				owner_info.narrow;
				// address_info.narrow;
				legal_info.narrow;
				sales_info.narrow;
				// mortgage_info.narrow;
				// lender_info.narrow;
				assessment_info.narrow;
				tax_info.narrow;
				// property_info.narrow;
				// fares_info.narrow;
				FFD.Layouts.CommonRawRecordElements;
			end;
			
			export wider := record
				filing_info.wider;
				owner_info.wider;
				// address_info.wider;
				legal_info.wider;
				sales_info.wider;
				mortgage_info.wider;
				lender_info.wider;
				assessment_info.wider;
				tax_info.wider;
				property_info.wider;
				fares_info.wider;
				FFD.Layouts.CommonRawRecordElements;
			end;
			
			export widest := record
				filing_info.widest;
				owner_info.widest;
				address_info.widest;
				legal_info.widest;
				sales_info.widest;
				mortgage_info.widest;
				lender_info.widest;
				assessment_info.widest;
				tax_info.widest;
				property_info.widest;
				fares_info.widest;
				FFD.Layouts.CommonRawRecordElements;
			end;
			
			export tmp := record
				core;
				widest;
				baseParties.baseAssess;
				
				// NOTE: Needed for "details" section
				LN_PropertyV2_Services.keys.assessor().fares_unformatted_apn;
				LN_PropertyV2_Services.keys.assessor().floor_cover_code;
				string20 floor_cover_desc;
				LN_PropertyV2_Services.keys.assessor().no_of_plumbing_fixtures;
				LN_PropertyV2_Services.keys.assessor().building_quality_code;
				string15 building_quality_desc;
				LN_PropertyV2_Services.keys.addl_fares_t.fares_basement_square_feet;
				LN_PropertyV2_Services.keys.addl_fares_t.fares_garage_square_feet;
				udecimal5_2 percent_improved;
				LN_PropertyV2_Services.keys.addl_fares_t.fares_fire_place_type;
				string30 fares_fire_place_type_desc;
				LN_PropertyV2_Services.keys.addl_fares_t.fares_no_of_bath_fixtures;
				LN_PropertyV2_Services.keys.addl_fares_t.fares_parking_type;
				string30 fares_parking_type_desc;
				LN_PropertyV2_Services.keys.addl_fares_t.fares_property_indicator;
				string35 fares_property_indicator_desc;
				LN_PropertyV2_Services.keys.addl_fares_t.fares_stories_code;
				string30 fares_stories_desc;
				LN_PropertyV2_Services.keys.addl_fares_t.fares_second_mortgage_amt;
				LN_PropertyV2_Services.keys.addl_fares_t.fares_quarter;
				LN_PropertyV2_Services.keys.addl_fares_t.fares_ground_floor_square_feet;
				FFD.Layouts.CommonRawRecordElements;
			end;
			
			
			export rolled_narrow := record
				core;
				dataset(narrow) assessments { maxcount(LN_PropertyV2_Services.consts.max_assess) };
			end;
			
			export rolled_wider := record
				core;
				dataset(wider) assessments { maxcount(LN_PropertyV2_Services.consts.max_assess) };
			end;
			
			export rolled_widest := record
				core;
				dataset(widest) assessments { maxcount(LN_PropertyV2_Services.consts.max_assess) };
			end;
			
			export rolled_tmp := record
				core;
				dataset(tmp) assessments { maxcount(LN_PropertyV2_Services.consts.max_assess) };
			end;
			
		end; // result
		
	end; // assess
	
	
	// deeds --------------------------------------------------
	
	export deeds := module
		
		export raw_source :={
													{search_fid} OR {core.sortby_date} OR 
													{LN_PropertyV2_Services.keys.deed()} OR 
													{LN_PropertyV2_Services.keys.addl_fares_d} 
													OR {FFD.Layouts.CommonRawRecordElements} 
												 };
		
/* 		record
   																search_fid;
   																core.sortby_date;
   																LN_PropertyV2_Services.keys.deed();
   																LN_PropertyV2_Services.keys.addl_fares_d;
   																FFD.Layouts.CommonRawRecordElements;
   													end;
*/
															
		export filing_info := module
			export narrow := record
				LN_PropertyV2_Services.keys.deed().state;
				LN_PropertyV2_Services.keys.deed().county_name;
				LN_PropertyV2_Services.keys.deed().apnt_or_pin_number;
			end;
			
			export wider := record
				narrow;
			end;
			
			export widest := record
				wider;
				LN_PropertyV2_Services.keys.deed().fips_code;
				LN_PropertyV2_Services.keys.deed().record_type;
				string77 record_type_desc;
				LN_PropertyV2_Services.keys.deed().multi_apn_flag;
			end;
		end; // filing_info
		
		export name_info := module
			/* The narrow and wider portions of deeds.name_info are covered in parties
			export narrow := record
				typeof(keys.deed().name1) buyer1;
				typeof(keys.deed().name2) buyer2;
				keys.deed().seller1;
				keys.deed().seller2;
			end;
			
			export wider := record
				narrow;
				typeof(keys.deed().name1) borrower1;
				typeof(keys.deed().name2) borrower2;
			end;
			*/
			
			export widest := record
				// wider; // in parties
				typeof(LN_PropertyV2_Services.keys.deed().name1_id_code)	buyer1_id_code;
				typeof(LN_PropertyV2_Services.keys.deed().name2_id_code)	buyer2_id_code;
				typeof(LN_PropertyV2_Services.keys.deed().vesting_code)	buyer_vesting_code;
				typeof(LN_PropertyV2_Services.keys.deed().addendum_flag)	buyer_addendum_flag;
				typeof(LN_PropertyV2_Services.keys.deed().name1_id_code)	borrower1_id_code;
				typeof(LN_PropertyV2_Services.keys.deed().name2_id_code)	borrower2_id_code;
				typeof(LN_PropertyV2_Services.keys.deed().vesting_code)	borrower_vesting_code;
				LN_PropertyV2_Services.keys.deed().seller1_id_code;
				LN_PropertyV2_Services.keys.deed().seller2_id_code;
				LN_PropertyV2_Services.keys.deed().seller_addendum_flag;
				
				string54 buyer1_id_desc;
				string54 buyer2_id_desc;
				string24 buyer_vesting_desc;
				string54 borrower1_id_desc;
				string54 borrower2_id_desc;
				string24 borrower_vesting_desc;
				string54 seller1_id_desc;
				string54 seller2_id_desc;
			end;
		end; // name_info
		
		export lender_info := module
			export wider := record
				LN_PropertyV2_Services.keys.deed().lender_name;
			end;
			
			export widest := record
				wider;
				LN_PropertyV2_Services.keys.deed().lender_name_id;
				LN_PropertyV2_Services.keys.deed().lender_dba_aka_name;
				LN_PropertyV2_Services.keys.deed().tax_id_number;
			end;
		end; // lender_info
		
		export phone_info := module
			export widest := record
				LN_PropertyV2_Services.keys.deed().phone_number;
			end;
		end; // phone_info
		
		/* The entire deeds.address_info section is now covered in parties
		export address_info := module
			export narrow := record
				typeof(keys.deed().mailing_street)			buyer_mailing_full_street_address;
				typeof(keys.deed().mailing_unit_number)	buyer_mailing_address_unit_number;
				typeof(keys.deed().mailing_csz)					buyer_mailing_address_citystatezip;
				keys.deed().seller_mailing_full_street_address;
				keys.deed().seller_mailing_address_unit_number;
				keys.deed().seller_mailing_address_citystatezip;
			end;
			
			export wider := record
				narrow;
				typeof(keys.deed().mailing_street)			borrower_mailing_full_street_address;
				typeof(keys.deed().mailing_unit_number)	borrower_mailing_unit_number;
				typeof(keys.deed().mailing_csz)					borrower_mailing_citystatezip;
				typeof(keys.deed().mailing_address_cd)	borrower_address_code;
			end;
			
			export widest := record
				wider;
				typeof(keys.deed().mailing_care_of)			buyer_mailing_address_care_of_name;
			end;
		end; // address_info
		*/
		
		export propertyAddress_info := module
			export narrow := record
				// keys.deed().property_full_street_address;	// in parties
				// keys.deed().property_address_unit_number;	// in parties
				// keys.deed().property_address_citystatezip;	// in parties
				LN_PropertyV2_Services.keys.deed().property_address_code;
				string76 property_address_desc;
				// hawaii_property_address_unit_number - covered elsewhere
			end;
			
			export wider := record
				narrow;
			end;
			
			export widest := record
				wider;
				LN_PropertyV2_Services.keys.deed().lender_full_street_address;
				LN_PropertyV2_Services.keys.deed().lender_address_unit_number;
				LN_PropertyV2_Services.keys.deed().lender_address_citystatezip;
			end;
		end; // propertyAddress_info
		
		export legal_info := module
			export narrow := record
				LN_PropertyV2_Services.keys.deed().legal_brief_description;
				LN_PropertyV2_Services.keys.deed().contract_date;
				LN_PropertyV2_Services.keys.deed().recording_date;
				LN_PropertyV2_Services.keys.deed().document_type_code;
				string70 document_type_desc;
			end;
			
			export wider := record
				narrow;
				LN_PropertyV2_Services.keys.deed().arm_reset_date;
				LN_PropertyV2_Services.keys.deed().document_number;
				LN_PropertyV2_Services.keys.deed().recorder_book_number;
				LN_PropertyV2_Services.keys.deed().recorder_page_number;
				LN_PropertyV2_Services.keys.deed().land_lot_size;
			end;
			
			export widest := record
				wider;
				LN_PropertyV2_Services.keys.deed().legal_lot_code;
				string54 legal_lot_desc;
				LN_PropertyV2_Services.keys.deed().legal_lot_number;
				LN_PropertyV2_Services.keys.deed().legal_block;
				LN_PropertyV2_Services.keys.deed().legal_section;
				LN_PropertyV2_Services.keys.deed().legal_district;
				LN_PropertyV2_Services.keys.deed().legal_land_lot;
				LN_PropertyV2_Services.keys.deed().legal_unit;
				LN_PropertyV2_Services.keys.deed().legal_city_municipality_township;
				LN_PropertyV2_Services.keys.deed().legal_subdivision_name;
				LN_PropertyV2_Services.keys.deed().legal_phase_number;
				LN_PropertyV2_Services.keys.deed().legal_tract_number;
				LN_PropertyV2_Services.keys.deed().legal_sec_twn_rng_mer;
				LN_PropertyV2_Services.keys.deed().recorder_map_reference;
				LN_PropertyV2_Services.keys.deed().complete_legal_description_code;
				// complete_legal_description_desc - not covered by CodesV3
				LN_PropertyV2_Services.keys.deed().loan_number;
				LN_PropertyV2_Services.keys.deed().concurrent_mortgage_book_page_document_number;
				// hawaii_legal - covered elsewhere
				LN_PropertyV2_Services.keys.deed().hawaii_tct;
				LN_PropertyV2_Services.keys.deed().hawaii_condo_cpr_code;
				// hawaii_condo_cpr_desc - not covered by CodesV3
				LN_PropertyV2_Services.keys.deed().hawaii_condo_name;
				LN_PropertyV2_Services.keys.deed().filler_except_hawaii;
			end;
		end; // legal_info
		
		export sales_info := module
			export narrow := record
				LN_PropertyV2_Services.keys.deed().sales_price;
			end;
			
			export wider := record
				narrow;
				LN_PropertyV2_Services.keys.deed().city_transfer_tax;
				LN_PropertyV2_Services.keys.deed().county_transfer_tax;
				LN_PropertyV2_Services.keys.deed().total_transfer_tax;
			end;
			
			export widest := record
				wider;
				LN_PropertyV2_Services.keys.deed().sales_price_code;
				string143 sales_price_desc;
				LN_PropertyV2_Services.keys.deed().excise_tax_number;
			end;
		end; // sales_info
		
		export property_info := module
			export narrow := record
				LN_PropertyV2_Services.keys.deed().property_use_code;
				string41 property_use_desc;
			end;
			
			export wider := record
				narrow;
			end;
			
			export widest := record
				wider;
				LN_PropertyV2_Services.keys.deed().assessment_match_land_use_code;
				string76 assessment_match_land_use_desc;
				LN_PropertyV2_Services.keys.deed().condo_code;
				string17 condo_desc;
				LN_PropertyV2_Services.keys.deed().timeshare_flag;
			end;
		end; // property_info
		
		export mortgage_info := module
			export narrow := record
				LN_PropertyV2_Services.keys.deed().first_td_loan_amount;
			end;
			
			export wider := record
				narrow;
				LN_PropertyV2_Services.keys.deed().first_td_loan_type_code;
				string39 first_td_loan_type_desc;
				LN_PropertyV2_Services.keys.deed().type_financing;
				string27 type_financing_desc;
				LN_PropertyV2_Services.keys.deed().first_td_interest_rate;
				LN_PropertyV2_Services.keys.deed().first_td_due_date;
				LN_PropertyV2_Services.keys.deed().title_company_name;
			end;
			
			export widest := record
				wider;
				LN_PropertyV2_Services.keys.deed().rate_change_frequency;
				string27 rate_change_frequency_desc;
				LN_PropertyV2_Services.keys.deed().change_index;
				LN_PropertyV2_Services.keys.deed().adjustable_rate_index;
				string55 adjustable_rate_index_desc;
				LN_PropertyV2_Services.keys.deed().adjustable_rate_rider;
				LN_PropertyV2_Services.keys.deed().graduated_payment_rider;
				LN_PropertyV2_Services.keys.deed().balloon_rider;
				LN_PropertyV2_Services.keys.deed().fixed_step_rate_rider;
				string36 fixed_step_rate_rider_desc;
				LN_PropertyV2_Services.keys.deed().condominium_rider;
				LN_PropertyV2_Services.keys.deed().planned_unit_development_rider;
				LN_PropertyV2_Services.keys.deed().rate_improvement_rider;
				LN_PropertyV2_Services.keys.deed().assumability_rider;
				LN_PropertyV2_Services.keys.deed().prepayment_rider;
				LN_PropertyV2_Services.keys.deed().one_four_family_rider;
				LN_PropertyV2_Services.keys.deed().biweekly_payment_rider;
				LN_PropertyV2_Services.keys.deed().second_home_rider;
				LN_PropertyV2_Services.keys.deed().second_td_loan_amount;
				LN_PropertyV2_Services.keys.deed().first_td_lender_type_code;
				string26 first_td_lender_type_desc;
				LN_PropertyV2_Services.keys.deed().second_td_lender_type_code;
				string26 second_td_lender_type_desc;
				LN_PropertyV2_Services.keys.deed().partial_interest_transferred;
				LN_PropertyV2_Services.keys.deed().loan_term_months;
				LN_PropertyV2_Services.keys.deed().loan_term_years;
			end;
		end; // mortgage_info
		
		export addl_fares_info := module
			export wider := record
				LN_PropertyV2_Services.keys.addl_fares_d.fares_transaction_type;
				string33 fares_transaction_type_desc;
				LN_PropertyV2_Services.keys.addl_fares_d.fares_mortgage_deed_type;
				string69 fares_mortgage_deed_type_desc;
				LN_PropertyV2_Services.keys.addl_fares_d.fares_mortgage_term_code;
				string6 fares_mortgage_term_code_desc;
				LN_PropertyV2_Services.keys.addl_fares_d.fares_mortgage_term;
				LN_PropertyV2_Services.keys.addl_fares_d.fares_iris_apn;
				string22 MortgageDeedSubtype := '';
			end;
			
			export widest := record
				wider;
				LN_PropertyV2_Services.keys.addl_fares_d.fares_lender_address;
				LN_PropertyV2_Services.keys.addl_fares_d.fares_mortgage_date;
				LN_PropertyV2_Services.keys.addl_fares_d.fares_building_square_feet;
				LN_PropertyV2_Services.keys.addl_fares_d.fares_foreclosure;
				string19 fares_foreclosure_desc;
				LN_PropertyV2_Services.keys.addl_fares_d.fares_refi_flag;
				string22 fares_refi_flag_desc;
				LN_PropertyV2_Services.keys.addl_fares_d.fares_equity_flag;
				string11 fares_equity_flag_desc;
			end;
		end; // addl_fares_info
	
		export result := module
			export narrow2 := record
				filing_info.narrow;
				// name_info.narrow;		// in parties
				// lender_info.narrow;
				// phone_info.narrow;
				// address_info.narrow;	// in parties
				// propertyAddress_info.narrow;	// in parties
				legal_info.narrow;
				sales_info.narrow;
				property_info.narrow;
				mortgage_info.narrow;
				// addl_fares_info.narrow;
				FFD.Layouts.CommonRawRecordElements;
			end;
				
			export wider2 := record
				filing_info.wider;
				// name_info.wider;			// in parties
				lender_info.wider;
				// phone_info.wider;
				// address_info.wider;	// in parties
				// propertyAddress_info.wider;	// in parties
				legal_info.wider;
				sales_info.wider;
				property_info.wider;
				mortgage_info.wider;
				addl_fares_info.wider;
				FFD.Layouts.CommonRawRecordElements;
			end;
			
			export widest2 := record
				filing_info.widest;
				name_info.widest;
				lender_info.widest;
				phone_info.widest;
				// address_info.widest;	// in parties
				propertyAddress_info.widest;
				legal_info.widest;
				sales_info.widest;
				property_info.widest;
				mortgage_info.widest;
				addl_fares_info.widest;
				FFD.Layouts.CommonRawRecordElements;
			end;
			
			
			export tmp := record
				core;
				widest2;
				baseParties.baseDeed;
				
				// NOTE: Needed for "details" section
				LN_PropertyV2_Services.keys.deed().fares_unformatted_apn;
				LN_PropertyV2_Services.keys.addl_fares_d.fares_prior_doc_number;
				LN_PropertyV2_Services.keys.addl_fares_d.fares_prior_sales_code;
				string120 fares_prior_sales_desc;
			end;
			
			
			export rolled_narrow := record
				core;
				dataset(narrow2) deeds { maxcount(LN_PropertyV2_Services.consts.max_deeds) };
			end;
	
			export rolled_wider := record
				core;
				dataset(wider2) deeds { maxcount(LN_PropertyV2_Services.consts.max_deeds) };
			end;
	
			export rolled_widest := record
				core;
				dataset(widest2) deeds { maxcount(LN_PropertyV2_Services.consts.max_deeds) };
			end;
	
			export rolled_tmp := record
				core;
				dataset(tmp) deeds { maxcount(LN_PropertyV2_Services.consts.max_deeds) };
			end;
	
		end; // result
		
	end; // deeds
	
	
	// details ------------------------------------------------
	export details := module
	
		export result := record
			// NOTE: The XPATH-style comments in this section are referring to XML
			// tag names in the informal spec provided by FDS, which motivated the
			// creation of the "details" section.  They should probably be removed
			// once we have signoff that these are the right fields to add.
			
			// tax_info/standard_use
			LN_PropertyV2_Services.keys.assessor().standardized_land_use_code;
			string76 standardized_land_use_desc;
			LN_PropertyV2_Services.keys.deed().property_use_code;
			string41 property_use_desc;
			
			// tax_info/assessed_value
			LN_PropertyV2_Services.keys.addl_fares_t.fares_calculated_total_value;
			LN_PropertyV2_Services.keys.addl_fares_t.fares_calculated_land_value;
			// keys.assessor().assessed_land_value;
			
			// tax_info/tax_amount
			LN_PropertyV2_Services.keys.assessor().tax_amount;
			LN_PropertyV2_Services.keys.deed().city_transfer_tax;
			LN_PropertyV2_Services.keys.deed().county_transfer_tax;
			LN_PropertyV2_Services.keys.deed().total_transfer_tax;
			
			// tax_info/lot_size
			LN_PropertyV2_Services.keys.assessor().land_acres;
			LN_PropertyV2_Services.keys.assessor().land_square_footage;
			
			// tax_info/lot_width and lot_depth
			LN_PropertyV2_Services.keys.assessor().land_dimensions;
			
			// tax_info/year_built
			LN_PropertyV2_Services.keys.assessor().year_built;
			
			// tax_info/eff_year_built
			LN_PropertyV2_Services.keys.assessor().effective_year_built;
			
			// building_info/owner_corporate_ind
			LN_PropertyV2_Services.keys.addl_fares_d.fares_corporate_indicator;
			
			// building_info/improvement_value
			LN_PropertyV2_Services.keys.addl_fares_t.fares_calculated_improvement_value;
			// keys.assessor().assessed_improvement_value;
			// keys.assessor().market_improvement_value;
			
			// building_info/mobile_home
			// property_indicator_code // STUB - where is this?
			// also see property_use_desc above
			
			// building_info/num_units
			LN_PropertyV2_Services.keys.assessor().no_of_units;
			
			// building_info/num_stories
			LN_PropertyV2_Services.keys.assessor().no_of_stories;
			
			// building_info/num_baths
			LN_PropertyV2_Services.keys.assessor().no_of_baths;
			LN_PropertyV2_Services.keys.assessor().no_of_partial_baths;
			LN_PropertyV2_Services.keys.addl_fares_t.fares_no_of_full_baths;
			LN_PropertyV2_Services.keys.addl_fares_t.fares_no_of_half_baths;
			
			// building_info/num_bedrooms
			LN_PropertyV2_Services.keys.assessor().no_of_bedrooms;
			
			// building_info/num_room
			LN_PropertyV2_Services.keys.assessor().no_of_rooms;
			
			// building_info/pool
			LN_PropertyV2_Services.keys.addl_fares_t.fares_pool_indicator;
			LN_PropertyV2_Services.keys.assessor().pool_code;
			string27 pool_desc;
			
			// building_info/fireplace
			LN_PropertyV2_Services.keys.assessor().fireplace_indicator;
			string3 fireplace_indicator_desc;
			
			// building_info/num_fireplaces
			LN_PropertyV2_Services.keys.assessor().fireplace_number;
			
			// building_info/garage
			LN_PropertyV2_Services.keys.assessor().garage_type_code;
			string30 garage_type_desc;
			LN_PropertyV2_Services.keys.assessor().parking_no_of_cars;
			
			// building_info/cooling_type
			LN_PropertyV2_Services.keys.assessor().air_conditioning_code;
			string28 air_conditioning_desc;
			LN_PropertyV2_Services.keys.assessor().air_conditioning_type_code;
			string18 air_conditioning_type_desc;
			
			// building_info/heating_type
			LN_PropertyV2_Services.keys.assessor().heating_code;
			string28 heating_desc;
			LN_PropertyV2_Services.keys.assessor().heating_fuel_type_code;
			string23 heating_fuel_type_desc;
			
			// building_info/roof
			LN_PropertyV2_Services.keys.assessor().roof_cover_code;
			string28 roof_cover_desc;
			LN_PropertyV2_Services.keys.assessor().roof_type_code;
			string20 roof_type_desc;
			
			// building_info/construction_type
			LN_PropertyV2_Services.keys.assessor().type_construction_code;
			string27 type_construction_desc;
			
			// building_info/building_size
			LN_PropertyV2_Services.keys.addl_fares_d.fares_building_square_feet;
			LN_PropertyV2_Services.keys.addl_fares_t.fares_living_square_feet;
			LN_PropertyV2_Services.keys.addl_fares_t.fares_adjusted_gross_square_feet;
			
			LN_PropertyV2_Services.keys.assessor().building_area;
			LN_PropertyV2_Services.keys.assessor().building_area1;
			LN_PropertyV2_Services.keys.assessor().building_area2;
			LN_PropertyV2_Services.keys.assessor().building_area3;
			LN_PropertyV2_Services.keys.assessor().building_area4;
			LN_PropertyV2_Services.keys.assessor().building_area5;
			LN_PropertyV2_Services.keys.assessor().building_area6;
			LN_PropertyV2_Services.keys.assessor().building_area7;
			
			LN_PropertyV2_Services.keys.assessor().building_area_indicator;
			LN_PropertyV2_Services.keys.assessor().building_area1_indicator;
			LN_PropertyV2_Services.keys.assessor().building_area2_indicator;
			LN_PropertyV2_Services.keys.assessor().building_area3_indicator;
			LN_PropertyV2_Services.keys.assessor().building_area4_indicator;
			LN_PropertyV2_Services.keys.assessor().building_area5_indicator;
			LN_PropertyV2_Services.keys.assessor().building_area6_indicator;
			LN_PropertyV2_Services.keys.assessor().building_area7_indicator;
			
			string30 building_area_desc;
			string30 building_area1_desc;
			string30 building_area2_desc;
			string30 building_area3_desc;
			string30 building_area4_desc;
			string30 building_area5_desc;
			string30 building_area6_desc;
			string30 building_area7_desc;
			
			// loan_info/sale_doc_num
			LN_PropertyV2_Services.keys.deed().document_number;
			LN_PropertyV2_Services.keys.assessor().recorder_document_number;
			
			// loan_info/sale_type
			// keys.addl_fares_d.fares_transaction_type; // appears below
			
			// loan_info/first_loan_amt
			LN_PropertyV2_Services.keys.deed().first_td_loan_amount;
			LN_PropertyV2_Services.keys.assessor().mortgage_loan_amount;
			
			// loan_info/second_loan_amt
			LN_PropertyV2_Services.keys.deed().second_td_loan_amount;
			LN_PropertyV2_Services.keys.addl_fares_t.fares_second_mortgage_amt;
			
			// loan_info/mortgage_due_dt
			LN_PropertyV2_Services.keys.deed().first_td_due_date;
			
			// loan_info/loan_type
			LN_PropertyV2_Services.keys.deed().first_td_loan_type_code;
			string39 first_td_loan_type_desc;
			LN_PropertyV2_Services.keys.assessor().mortgage_loan_type_code;
			string31 mortgage_loan_type_desc;
			
			// loan_info/tran_type
			LN_PropertyV2_Services.keys.addl_fares_d.fares_transaction_type;
			string33 fares_transaction_type_desc;
			
			// loan_info/deed_type
			LN_PropertyV2_Services.keys.addl_fares_d.fares_mortgage_deed_type;
			string69 fares_mortgage_deed_type_desc;
			
			// loan_info/lender_name
			LN_PropertyV2_Services.keys.assessor().mortgage_lender_name;
			LN_PropertyV2_Services.keys.deed().lender_name;
			LN_PropertyV2_Services.keys.deed().lender_name_id;
			LN_PropertyV2_Services.keys.deed().lender_dba_aka_name;
			LN_PropertyV2_Services.keys.deed().lender_full_street_address;
			LN_PropertyV2_Services.keys.deed().lender_address_unit_number;
			LN_PropertyV2_Services.keys.deed().lender_address_citystatezip;
			
			// loan_info/title_company
			LN_PropertyV2_Services.keys.deed().title_company_name;
			
			// location_info/zoning
			LN_PropertyV2_Services.keys.assessor().zoning;
			
			// location_info/tract_num
			LN_PropertyV2_Services.keys.assessor().legal_tract_number;			// also deed
			LN_PropertyV2_Services.keys.assessor().census_tract;
			
			// location_info/block_num
			LN_PropertyV2_Services.keys.assessor().legal_block;						// also deed
			
			// location_info/lot_num
			LN_PropertyV2_Services.keys.assessor().legal_lot_number;				// also deed
			
			// location_info/range
			LN_PropertyV2_Services.keys.assessor().legal_district;					// also deed
			
			// location_info/township
			LN_PropertyV2_Services.keys.assessor().legal_city_municipality_township;	// also deed
			
			// location_info/section
			LN_PropertyV2_Services.keys.assessor().legal_section;					// also deed
			
			// location_info/quarter
			
			// location_info/subdivision_name
			LN_PropertyV2_Services.keys.assessor().legal_subdivision_name;	// also deed
			
			LN_PropertyV2_Services.keys.assessor().fips_code;
			LN_PropertyV2_Services.keys.assessor().apna_or_pin_number;
			LN_PropertyV2_Services.keys.assessor().fares_unformatted_apn;
			LN_PropertyV2_Services.keys.assessor().legal_sec_twn_rng_mer;
  		LN_PropertyV2_Services.keys.assessor().site_influence1_code;
			LN_PropertyV2_Services.keys.assessor().site_influence2_code;
			LN_PropertyV2_Services.keys.assessor().site_influence3_code;
			LN_PropertyV2_Services.keys.assessor().site_influence4_code;
			LN_PropertyV2_Services.keys.assessor().site_influence5_code;
			string29 site_influence1_desc;
			string29 site_influence2_desc;
			string29 site_influence3_desc;
			string29 site_influence4_desc;
			string29 site_influence5_desc;
			LN_PropertyV2_Services.keys.assessor().sales_price_code;
			string108 sales_price_desc;
			LN_PropertyV2_Services.keys.assessor().prior_transfer_date;
			LN_PropertyV2_Services.keys.addl_fares_d.fares_prior_doc_number;
			LN_PropertyV2_Services.keys.assessor().prior_sales_price;
			LN_PropertyV2_Services.keys.assessor().prior_sales_price_code;
			string108 prior_sales_price_desc;
			LN_PropertyV2_Services.keys.deed().contract_date;
			LN_PropertyV2_Services.keys.assessor().sales_price;
			LN_PropertyV2_Services.keys.deed().first_td_interest_rate;
			LN_PropertyV2_Services.keys.deed().type_financing;
			string27 type_financing_desc;
			
			LN_PropertyV2_Services.keys.assessor().assessed_land_value;
			LN_PropertyV2_Services.keys.assessor().assessed_improvement_value;
			LN_PropertyV2_Services.keys.assessor().assessed_total_value;
			LN_PropertyV2_Services.keys.assessor().assessed_value_year;
			LN_PropertyV2_Services.keys.assessor().market_land_value;
			LN_PropertyV2_Services.keys.assessor().market_improvement_value;
			LN_PropertyV2_Services.keys.assessor().market_total_value;
			LN_PropertyV2_Services.keys.assessor().market_value_year;
			
			LN_PropertyV2_Services.keys.assessor().tax_rate_code_area;
			udecimal5_2 percent_improved;
			
			LN_PropertyV2_Services.keys.addl_fares_t.fares_condition;
			string18 fares_condition_desc;
			LN_PropertyV2_Services.keys.assessor().foundation_code;
			string31 foundation_desc;
			LN_PropertyV2_Services.keys.assessor().exterior_walls_code;
			string30 exterior_walls_desc;
			LN_PropertyV2_Services.keys.assessor().floor_cover_code;
			string20 floor_cover_desc;
			LN_PropertyV2_Services.keys.addl_fares_t.fares_frame;
			string25 fares_frame_desc;
			LN_PropertyV2_Services.keys.assessor().style_code;
			string29 style_desc;
			LN_PropertyV2_Services.keys.assessor().basement_code;
			string25 basement_desc;
			LN_PropertyV2_Services.keys.addl_fares_t.fares_basement_square_feet;
			LN_PropertyV2_Services.keys.addl_fares_t.fares_garage_square_feet;
			LN_PropertyV2_Services.keys.assessor().no_of_plumbing_fixtures;
			
			LN_PropertyV2_Services.keys.addl_fares_t.fares_water;
			string12 fares_water_desc;
			LN_PropertyV2_Services.keys.addl_fares_t.fares_sewer;
			string12 fares_sewer_desc;
			
			LN_PropertyV2_Services.keys.assessor().building_quality_code;
			string15 building_quality_desc;
			
			LN_PropertyV2_Services.keys.search().geo_lat;
			LN_PropertyV2_Services.keys.search().geo_long;
			
			LN_PropertyV2_Services.keys.addl_fares_t.fares_fire_place_type;
			string30 fares_fire_place_type_desc;
			LN_PropertyV2_Services.keys.addl_fares_t.fares_no_of_bath_fixtures;
			LN_PropertyV2_Services.keys.addl_fares_t.fares_parking_type;
			string30 fares_parking_type_desc;
			LN_PropertyV2_Services.keys.addl_fares_t.fares_property_indicator;
			string35 fares_property_indicator_desc;
			LN_PropertyV2_Services.keys.addl_fares_d.fares_prior_sales_code;
			string120 fares_prior_sales_desc;
			LN_PropertyV2_Services.keys.addl_fares_t.fares_stories_code;
			string30 fares_stories_desc;
			
			LN_PropertyV2_Services.keys.addl_fares_t.fares_quarter;
			LN_PropertyV2_Services.keys.addl_fares_t.fares_ground_floor_square_feet;
			FFD.Layouts.CommonRawRecordElements;
		end;	
		
	
		export rolled := record
			core;
			dataset(result) details { maxcount(LN_PropertyV2_Services.consts.max_details) };
		end;
		
	end; // details
	
	
	// combined -----------------------------------------------

	export combined := module
	
		shared fid_type_cnt := record
			integer2 num_deeds := -1;
			integer2 num_assess := -1;
		end;
			
		export narrow := record
			core;
			dataset(deeds.result.narrow2)	deeds				{ maxcount(LN_PropertyV2_Services.consts.max_deeds)		};
			dataset(assess.result.narrow)	assessments	{ maxcount(LN_PropertyV2_Services.consts.max_assess)		};
			dataset(details.result)				details			{ maxcount(LN_PropertyV2_Services.consts.max_details)	};
			dataset(parties.pparty)				parties			{ maxcount(LN_PropertyV2_Services.consts.max_parties)	};
			parties.matched_pparty matched_party;
			fid_type_cnt;
		end;
		
	
		export wider := record
			core;
			dataset(deeds.result.wider2)	deeds				{ maxcount(LN_PropertyV2_Services.consts.max_deeds)		};
			dataset(assess.result.wider)	assessments	{ maxcount(LN_PropertyV2_Services.consts.max_assess)		};
			dataset(parties.pparty)				parties			{ maxcount(LN_PropertyV2_Services.consts.max_parties)	};
		end;
		
		export widest := record
			core;
			dataset(deeds.result.widest2)	deeds				{ maxcount(LN_PropertyV2_Services.consts.max_deeds)		};
			dataset(assess.result.widest)	assessments	{ maxcount(LN_PropertyV2_Services.consts.max_assess)		};
			dataset(parties.pparty)				parties			{ maxcount(LN_PropertyV2_Services.consts.max_parties)	};
			fid_type_cnt;
		end;
		
		
		export tmp := record
			core;
			dataset(deeds.result.tmp)			deeds				{ maxcount(LN_PropertyV2_Services.consts.max_deeds)		};
			dataset(assess.result.tmp)		assessments	{ maxcount(LN_PropertyV2_Services.consts.max_assess)		};
			dataset(details.result)				details			{ maxcount(LN_PropertyV2_Services.consts.max_details)	};
			dataset(parties.pparty)				parties			{ maxcount(LN_PropertyV2_Services.consts.max_parties)	};
			parties.matched_pparty matched_party;
			fid_type_cnt;
		end;
		
	end; // combined
	
	
	// output -----------------------------------------------
	
	export out_narrow				:= { combined.narrow;	};
	export out_wider				:= { combined.wider;	};
	export out_widest				:= { combined.widest;	};
	
	export out_crs		:= record(combined.wider)
		integer3	address_seq_no := -1;
		boolean		owned := false;
		
	end;
	
	export batch_in := RECORD
		string20		acctno				:= '';
		unsigned6 	did						:= 0;		
		STRING20 		name_first    := '';
		STRING20 		name_middle   := '';
		STRING20 		name_last     := '';
		STRING5	 		name_suffix   := '';
		string100		addr 					:= ''; 
		STRING10  	prim_range 		:= '';
		STRING2   	predir     		:= '';
		STRING28  	prim_name  		:= '';
		STRING4   	addr_suffix 	:= '';
		STRING2   	postdir     	:= '';
		STRING10  	unit_desig  	:= '';
		STRING8   	sec_range  	 	:= '';
		STRING25  	p_city_name		:= '';
		STRING2   	st          	:= '';
		STRING5   	z5      		  := '';
		STRING4   	zip4        	:= '';
		string18 		county_name   := '';
		string9			ssn						:= '';
		string8 		dob						:= '';
		string10  	homephone 		:= '';
		STRING120 	comp_name     := '';
		STRING9   	FEIN          := '';
		STRING45  	apn           := '';
		STRING5   	fips_code     := '';
		UNSIGNED6 	DotID 				:= 0;
		UNSIGNED6 	EmpID 				:= 0;
		UNSIGNED6 	POWID 				:= 0;
		UNSIGNED6 	ProxID 				:= 0;
		UNSIGNED6 	SELEID 				:= 0; 
		UNSIGNED6 	OrgID 				:= 0;
		UNSIGNED6 	UltID 				:= 0;
	END;

	export batch_in_plus_date_filter := RECORD(batch_in)
		STRING4 min_year := '0';
		STRING4 max_year := '9999';
	END;
	

end; // layouts