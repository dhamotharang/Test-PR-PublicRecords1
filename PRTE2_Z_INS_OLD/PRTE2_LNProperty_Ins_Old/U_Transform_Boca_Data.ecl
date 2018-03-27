// Experimenting with simplifying the HUGE Boca Base file
// Most of this probably isn't ideal yet.

IMPORT PRTE2, address, ut, doxie, NID;

EXPORT U_Transform_Boca_Data(STRING pindexversion) := MODULE

		DataIn := Files.BOCA_BASE_SF_DS_PROD;
		LNPropertyRec := Layouts.layout_LNP_V2_expanded_payload;
		ViewableRec := z_Layout_Batch_in;
		
		string8 today_date := ut.GetDate; 
	
		EXPORT ViewableRec  Reformat_BocaDS (LNPropertyRec L, Integer C) := TRANSFORM
					// string clean_address := address.CleanAddress182(l.address, l.city + ' ' + l.st + ' ' + l.zip);
					// SELF.fakeid     := (unsigned) 16000000 + C;  
					// SELF.zero       := (unsigned1)0;
					// SELF.prim_name  :=  clean_address [13..40];
					// SELF.prim_range := clean_address [1..10];
 
					// SELF.sec_range  := L.Apt;
					// SELF.city_code  := doxie.Make_CityCode(L.city);
					// SELF.st         := IF(clean_address [115..116] > ' ',clean_address [115..116],L.st);
					// self.state      := IF(clean_address [115..116] > ' ',clean_address [115..116],L.st);
					// self.zip        := clean_address[117..121]; 
					// self.zip4       := clean_address[122..125];
					SELF.phone      := L.deed_phone_number;
					SELF.dph_lname  := metaphonelib.DMetaPhone1(l.lname);
					SELF.pfname     := NID.PreferredFirstVersionedStr(L.fname,2);
					SELF.minit      := L.mname [1..1];
					SELF.msa        := clean_address [167..170];
					SELF.err_stat   := clean_address[179..182];
					SELF.cart       := clean_address[126..129];
					SELF.cr_sort_sz := clean_address[130];
					SELF.lot        := clean_address[131..134];
					SELF.lot_order  := clean_address[135];
					SELF.dbpc       := clean_address[136..137];
					SELF.chk_digit  := clean_address[138];
					SELF.rec_type   := clean_address[139..140];
					SELF.county     := clean_address[141..145];
					self.geo_lat    := clean_address[146..155];
					self.geo_long   := clean_address[156..166];
					SELF.geo_blk    := clean_address[171..177];
					SELF.geo_match  := clean_address[178];
					SELF.p_city_name := clean_address[65..89];
					SELF.v_city_name := clean_address[90..114];
					self.s4         := (unsigned) l.ssn[6..9];
					SELF.yob        := (unsigned2) L.DOB [1..4];
					SELF.DOB        := (unsigned4) L.DOB;
					self.s1         :=  l.ssn[1..1];
					self.s2         :=  l.ssn[2..2];
					self.s3         :=  l.ssn[3..3];
 
					self.s5         :=  l.ssn[5..5]; 
					self.s6         :=  l.ssn[6..6];
					self.s7         :=  l.ssn[7..7];
					self.s8         :=  l.ssn[8..8];
					self.s9         :=  l.ssn[9..9];		
 
					SELF.which_orig := 'T';
					SELF.dt_first_seen            := (unsigned)today_date[1..6];		//TODO - might want to take from spreadsheet
					SELF.dt_last_seen             := (unsigned)today_date[1..6];		//TODO - might want to take from spreadsheet
					SELF.dt_vendor_first_reported := (unsigned)today_date[1..6];		//TODO - might want to take from spreadsheet
					SELF.dt_vendor_last_reported  := (unsigned)today_date[1..6];		//TODO - might want to take from spreadsheet
					SELF.vendor_source_flag       := L.fid_type;
					SELF.process_date             := today_date;
					SELF.source_code_2            := 'P';
					SELF.source_code_1            := 'O';
					SELF.source_code   := 'OP';
					SELF.app_tax_id  := L.deed_tax_id_number;
					SELF.app_ssn     := L.ssn;
					SELF.person_name.fname := L.fname;
					SELF.person_name.mname := L.mname;
					SELF.person_name.lname := L.lname;
					self.nameasis  := IF(l.mname > '', TRIM(L.fname) + ' ' + TRIM(L.mname)  + ' ' + TRIM(l.lname),
																			TRIM(L.fname)  + ' ' + TRIM(L.lname));
					SELF.person_addr.prim_range   := clean_address [1..10];
					SELF.person_addr.predir       := clean_address[11..12];
					SELF.person_addr.prim_name    := clean_address [13..40];
					SELF.person_addr.addr_suffix  := clean_address [41..44];
					Self.person_addr.postdir      := clean_address [45..46];
					SELF.person_addr.unit_desig   := clean_address [47..56];
 
					SELF.person_addr.sec_range    := L.Apt;
					SELF.person_addr.st := IF(clean_address [115..116] > ' ',clean_address [115..116],L.property_st);
					SELF.person_addr.zip5 := IF( clean_address [117..121] > '0', (string5) clean_address [117..121], L.zip);
					SELF.person_addr.zip4 := IF (clean_address [122..125] > '0', (string) clean_address [122..125], (string) L.property_zip4);
					SELF.person_addr.geo_lat      := L.property_geo_lat;
					SELF.person_addr.geo_long     := L.property_geo_long;
					SELF.person_addr.fips_state   := clean_address[141..142];
					SELF.person_addr.fips_county  := clean_address[143..145];
					SELF.person_addr.v_city_name  := IF (clean_address [90..114] > '', clean_address [90..114], L.property_v_city_name);
					SELF.person_addr.err_stat 		:=  clean_address [179..182];	
					SELF.person_addr.geo_blk			:= 	clean_address [171..177];
					SELF.person_addr.geo_match		:= 	clean_address [178];
					SELF.person_addr.cbsa					:= 	clean_address [167..170];
					SELF.predir                   :=  clean_address[11..12];
					SELF.postdir                  :=  clean_address [45..46];
					SELF.suffix                   := clean_address [41..44];
					SELF.proc_date                := (unsigned8) pIndexVersion [1..8];
					SELF.current_record           := 'Y';
					SELF.from_file                := IF (L.fid_type = 'A', 'F', 'D');
					SELF.fips_code                := IF(L.Deed_fips_code > '', L.Deed_fips_code, L.assess_fips_code);
					SELF.state_code               := L.assess_state_code;
					SELF.county_name              := L.assess_county_name;
					self.p_county_name            := self.county_name;
					self.o_county_name            := self.county_name;
					SELF.apnt_or_pin_number       := L.assess_apna_or_pin_number;
					SELF.multi_apn_flag           := L.assess_duplicate_apn_multitude_address_id;
					SELF.assessee_name            := TRIM(L.fname + ' ' + L.lname);
					SELF.assessee_ownership_rights_code := L.assess_assessee_ownership_rights_desc;
					SELF.assessee_relationship_code     := L.assess_assessee_relationship_desc;
					SELF.assessee_phone_number    := L.assess_assessee_phone_number;
					SELF.tax_account_number       := '9923' + TRIM(L.assess_tax_account_number[1..3]) + L.ssn[7..9];
					SELF.contract_owner           := L.assess_contract_owner;
					SELF.assessee_name_type_code  := L.assess_assessee_name_type_desc;
					SELF.second_assessee_name_type_code := L.assess_second_assessee_name_type_desc;
					SELF.mail_care_of_name_type_code    := L.assess_mail_care_of_name_type_desc;
					SELF.mailing_care_of_name     := L.assess_mailing_care_of_name;
					SELF.property_full_street_address   := L.property_orig_address;
					SELF.property_address_unit_number     := L.property_orig_unit;
					SELF.property_address_citystatezip  := L.property_orig_csz;
					SELF.property_address_code    := L.assess_property_address_desc;
					SELF.property_city_state_zip  := L.property_orig_csz;
					SELF.legal_lot_number         := L.deed_legal_lot_no;
					self.lot_size                 := L.deed_land_lot_size;
					SELF.legal_lot_code           := L.assess_legal_lot_desc;
					SELF.legal_land_lot           := L.assess_legal_land_lot;
					SELF.legal_block              := L.assess_legal_block;
					SELF.legal_section            := L.assess_legal_section;
					SELF.legal_district           := L.assess_legal_district;
					SELF.legal_unit               := L.assess_legal_unit;
					SELF.legal_city_municipality_township := L.assess_legal_city_municipal_township;
					SELF.legal_subdivision_name   := L.deed_legal_subdivision_name;
					SELF.legal_phase_number       := L.deed_legal_phase_number;
					SELF.legal_tract_number       := L.assess_legal_tract_number;
					SELF.legal_sec_twn_rng_mer    := L.deed_legal_sec_twn_rng_mer;
					SELF.legal_brief_description  := L.deed_legal_brief_desc;
					SELF.recorder_map_reference   := L.assess_legal_assessor_map_ref;
					SELF.census_tract             := L.deed_legal_tract_number;
					SELF.document_type_code       := L.deed_document_type_code;
 
					SELF.new_record_type_code     := L.assess_new_record_type_desc;
					SELF.county_land_use_description := L.assess_county_land_use_desc;
					SELF.assessment_match_land_use_code := L.assess_standardized_land_use_desc;
					SELF.timeshare_flag          := L.assess_timeshare_code;
					SELF.property_use_code       := L.assess_zoning;
 
					SELF.document_number         := L.assess_recorder_document_number;
					SELF.recorder_book_number    := L.assess_recorder_book_number;
					SELF.recorder_page_number    := L.assess_recorder_page_number;
 
					SELF.recording_date          := L.assess_recording_date;
					SELF.contract_date           := L.assess_sale_date;
 
					SELF.sales_price             := L.assess_sales_price;
					SELF.sales_price_code        := L.assess_sales_price_desc;
					SELF.first_td_loan_amount    := L.assess_mortgage_loan_amount;
					SELF.first_td_loan_type_code := L.assess_mortgage_loan_type_desc;
					SELF.lender_name             := L.assess_mortgage_lender_name;
 
					SELF.market_total_value      := L.assess_market_total_value;
					SELF.market_value_year       := L.assess_market_value_year;
					SELF.homestead_homeowner_exemption := L.assess_homestead_homeowner_exempt;
					SELF.tax_exemption1_code     := L.assess_tax_exemption1_desc;
					SELF.tax_exemption2_code     := L.assess_tax_exemption2_desc;
					SELF.tax_exemption3_code     := L.assess_tax_exemption3_desc;
					SELF.tax_exemption4_code     := L.assess_tax_exemption4_desc;
 
					SELF.tax_rate_code_area      := L.assess_tax_rate_code;
					SELF.tax_amount              := L.assess_tax_amount;
					SELF.tax_year                := L.assess_tax_year;
					SELF.tax_delinquent_year     := L.assess_tax_delinquent_year;
					SELF.school_tax_district1    := L.assess_school_tax_district_1;
					SELF.school_tax_district2    := L.assess_school_tax_district_2;
					SELF.school_tax_district3    := L.assess_school_tax_district_3;
					SELF.land_square_footage     := L.assess_land_square_footage;
					SELF.year_built              := L.assess_year_built;
					SELF.effective_year_built    := L.assess_effective_year_built;
					SELF.no_of_buildings         := L. assess_no_of_buildings;
					SELF.no_of_stories           := L.assess_no_of_stories;
					SELF.no_of_units             := L.assess_no_of_units;
					SELF.no_of_rooms             := L.assess_no_of_rooms;
					SELf.no_of_bedrooms          := L.assess_no_of_bedrooms;
					SELF.no_of_baths             := L.assess_no_of_baths;
					SELF.no_of_partial_baths     := L.assess_no_of_partial_baths;
					SELF.garage_type_code        := L.assess_garage_type_desc;
					SELF.parking_no_of_cars      := L.assess_parking_no_of_cars;
					SELF.pool_code               := L.assess_pool_desc;
 
					SELF.record_type              := L.Deed_record_type;
 
					iris_apn := stringlib.stringfilter(L.deed_iris_apn,
									'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ');
					deed_apn := stringlib.stringfilter(L.deed_apnt_or_pin_number,
									'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ');
					assess_apn := stringlib.stringfilter(L.assess_apna_or_pin_number,
									'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ');
 
					self.fares_unformatted_apn    := IF(iris_apn != '',iris_apn, IF(deed_apn != '',deed_apn, assess_apn));
 
					SELF.tax_id_number            := L.deed_tax_id_number;
					SELF.excise_tax_number        := L. deed_excise_tax_number;
 
					SELF.name1                    := TRIM(L.fname,right,left) + ', ' + TRIM(L.lname,right,left);
					SELF.name1_id_code            := L.buyer_1_id_desc;
					SELF.vesting_code             := L.borrower_vesting_desc;
					SELF.mailing_care_of          := L.assess_mailing_care_of_name;
					SELF.seller1                  := L.seller_1_orig_name;
					SELF.seller1_id_code          := L.seller_1_id_desc;
 
					SELF.complete_legal_description_code := L.deed_complete_legal_desc_code;
 
					SELF.arm_reset_date           := L.deed_arm_reset_date;
 
					SELF.loan_number              := L.deed_loan_number;
 
					SELF.concurrent_mortgage_book_page_document_number := L.deed_concurrent_mortg_book_page_doc_no;
 
					SELF.city_transfer_tax        := L.deed_city_transfer_tax;
					SELF.county_transfer_tax      := L.deed_county_transfer_tax;
					SELF.total_transfer_tax       := L.deed_total_transfer_tax;
 
					SELF.second_td_loan_amount    := L.deed_second_td_loan_amount;
					SELF.first_td_lender_type_code  := L.deed_first_td_lender_type_desc;
					SELF.second_td_lender_type_code := L.deed_second_td_lender_type_desc;
 
					SELF.type_financing           := L.deed_type_financing;
					SELF.first_td_interest_rate   := L.deed_first_td_interest_rate;
					SELF.first_td_due_date        := L.deed_first_td_due_date;
					SELF.title_company_name       := L.deed_title_company_name;
					SELF.partial_interest_transferred := L.deed_partial_interest_transferred;
					SELF.loan_term_months         := L.deed_loan_term_months;
					SELf.loan_term_years          := L.deed_loan_term_years;
 
					SELF.lender_name_id           := L.deed_lender_name_id;
					SELF.lender_dba_aka_name      := L.deed_lender_dba_aka_name;
					SELF.lender_full_street_address  := L.deed_lender_full_st_addr;
					SELF.lender_address_unit_number  := L.deed_lender_addr_unit_no;
					SELF.lender_address_citystatezip := L.deed_lender_addr_citystatezip;
 
					SELF.condo_code               := L.deed_condo_desc;
 
					SELF.land_lot_size            := L.deed_land_lot_size;
					SELF.hawaii_tct               := L.deed_hawaii_tct;
					SELF.hawaii_condo_cpr_code    := L.deed_hawaii_condo_cpr_code;
					SELf.hawaii_condo_name        := L.deed_hawaii_condo_name;
					SELF.filler_except_hawaii     :=L.deed_filler_except_hawaii;
					SELF.change_index             := L.deed_change_index;
					SELF.adjustable_rate_index    := L.deed_adjustable_rate_index;
					SELF.adjustable_rate_rider    := L.deed_adjustable_rate_rider;
					SELF.graduated_payment_rider  := L.deed_graduated_payment_rider;
					SELF.balloon_rider            := L.deed_balloon_rider;
					SELF.fixed_step_rate_rider    := L.deed_fixed_step_rate_rider;
					SELF.condominium_rider        := L.deed_condominium_rider;
					SELF.planned_unit_development_rider := L.deed_planned_unit_development_rider;
					SELf.assumability_rider       := L.deed_assumability_rider;
					SELF.prepayment_rider         := L.deed_prepayment_rider;
					SELF.one_four_family_rider    := L.deed_one_four_family_rider;
					SELF.biweekly_payment_rider   := L.deed_biweekly_payment_rider;
					SELF.second_home_rider        := L.deed_second_home_rider;
					SELF.data_source_code         := 'TST';
					SELF.elevator                 := L.assess_elevator;
					SELF.fireplace_indicator      := L.assess_fireplace_indicator_desc;
					SELF.fireplace_number         := L.assess_fireplace_number;
					SELF.basement_code            := L.assess_basement_desc;
					SELF.building_class_code      := L.assess_building_class_desc;
					SELF.neighborhood_code := L.assess_neighborhood_code;
					SELF.condo_project_or_building_name := IF (L.assess_condo_project_name > '', 
																									L.assess_condo_project_name,
																									L.assess_building_name);																				
					SELF.assessee_name_indicator := L.assess_assessee_name_type_desc;
					SELF.second_assessee_name_indicator := L.assess_second_assessee_name_type_desc;	
 
					SELF.comments               := L.assess_comments;
					SELF.tape_cut_date          := L.assess_tape_cut_date;
					SELF.certification_date     := L.assess_certification_date;
					SELF.edition_number         := L.assess_edition_number;
 
 
					SELF.exterior_walls_code   := MAP(L.assess_exterior_walls_desc = 'SIDING (ALUM/VINYL)' => 'SID',
																			L.assess_exterior_walls_desc = 'ROCK'                    => 'ROC',
																			L.assess_exterior_walls_desc = 'BRICK'                   => 'BRI',
																			L.assess_exterior_walls_desc = 'WOOD FRAME'              => 'WDF',
																			L.assess_exterior_walls_desc = 'STUCCO'                  => 'STU',
																			L.assess_exterior_walls_desc = 'PREFAB'                  => 'PRF',
																			L.assess_exterior_walls_desc = 'METAL'                   => 'MET',
																			''); 
					SELF.type_construction_code := MAP(L.assess_type_construction_desc = 'FRAME'    => 'FRM',
																			L.assess_type_construction_desc = 'CUSTOM'        => 'CUS',
																			L.assess_type_construction_desc = 'WOOD'          => 'WOO',
																			L.assess_type_construction_desc = 'BRICK'         => 'BRK',
																			L.assess_type_construction_desc = 'ADOBE'         => 'ADB',
																			L.assess_type_construction_desc = 'LOG'           => 'LOGS',
																			L.assess_type_construction_desc = 'OTHER'         => 'OTH',
																			''); 
					SELF.foundation_code        := MAP(L.assess_foundation_desc = 'SLAB'    => 'SLB',
																			L.assess_foundation_desc = 'CONCRETE BLOCK'    => 'CNB',
																			L.assess_foundation_desc = 'CONCRETE'          => 'CRE',
																			L.assess_foundation_desc = 'BRICK'             => 'BRK',
																			L.assess_foundation_desc = 'WOOD'              => 'WOO',
																			L.assess_foundation_desc = 'STONE'             => 'STO',
																			L.assess_foundation_desc = 'STANDARD'          => 'STD',
																			L.assess_foundation_desc = 'OTHER'             => 'OTH',
																			'');
					self.heating_code    := MAP(L.assess_heating_desc = 'FORCED AIR'       => 'FA0',
																		L.assess_heating_desc = 'CENTRAL'          => 'CL0',
																		L.assess_heating_desc = 'HEAT PUMP'        => 'HP0',
																		L.assess_heating_desc = 'FLOOR FURNACE'    => 'FF0',
																		L.assess_heating_desc = 'FIREPLACE'        => 'FP0',
																		'');							
					SELF.heating_fuel_type_code  := MAP(L.assess_heating_fuel_type_desc = 'COAL'    => 'FCO',
																						L.assess_heating_fuel_type_desc = 'GAS'     => 'FGA',
																						L.assess_heating_fuel_type_desc = 'SOLAR'   => 'FSO',
																						L.assess_heating_fuel_type_desc = 'WOOD'    => 'FWD',
																						L.assess_heating_fuel_type_desc = 'OIL'     => 'FOI',
																						'');
					SELF.roof_type_code   := MAP(L.assess_roof_type_desc = 'GABLE'    => 'G00',
																		 L.assess_roof_type_desc = 'FLAT'     => 'F00',	
																		 L.assess_roof_type_desc = 'PITCHED'  => 'P00',
																		 L.assess_roof_type_desc = 'A-FRAME'  => 'A00',
																		 L.assess_roof_type_desc = 'FRAME'    => 'E00',
																		 L.assess_roof_type_desc = 'DORMER'   => 'D00',
																		 '');
					self.roof_cover_code  := MAP(L.assess_roof_cover_desc = 'ASPHALT'  => 'ASP',
																		 L.assess_roof_cover_desc = 'ASBESTOS' => 'ASB',
																		 L.assess_roof_cover_desc = 'SHINGLE'  => 'SHI',
																		 L.assess_roof_cover_desc = 'SLATE'    => 'SSH',
																		 L.assess_roof_cover_desc = 'TILE'     => 'TIL',
																		 L.assess_roof_cover_desc = 'TIN'      => 'TIN',
																		 L.assess_roof_cover_desc = 'OTHER'    => 'OTH',
																		 '');
					SELF.style_code  := MAP(L.assess_style_desc = 'CAPE COD'       => 'CAP',
																L.assess_style_desc = 'RANCH/RAMBLER'  => 'RAN',	
																L.assess_style_desc = 'CONVENTIONAL'   => 'CON',
																L.assess_style_desc = 'DUPLEX'         => 'DUP',
																L.assess_style_desc = 'SPLIT LEVEL'    => 'SPL',
																L.assess_style_desc = 'MODERN'         => 'MOD',
																L.assess_style_desc = 'HISTORICAL'     => 'HST',
																'');									
					SELF.standardized_land_use_code := MAP
							(L.assess_style_desc = 'SINGLE FAMILY RESIDENTIAL'                => 'SFR',
							 L.assess_style_desc = 'RESIDENTIAL (GENERAL) (SINGLE FAMILY)'    => 'RES',
							 L.assess_style_desc = 'RURAL RESIDENTIAL (AGRICULTURAL)'         => 'RRR',
							 L.assess_style_desc [1..20] = 'PRESUMED RESIDENTIAL'             => 'PRS',
							 '');		
					SELF := L;
					SELF := [];
			END;    	
END;			