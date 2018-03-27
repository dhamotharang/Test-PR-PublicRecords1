// PRTE2_LNProperty.Transform_Data
// Splitting out a LOT code that was cluttering up the NEW_Proc_Build_LNPropertyV2_keys logic.

// Now that we refreshed from production - need to finalize the layout, as described below.
//   ?? are deeds ready or do they need refreshing?  257 rows only.
 //-------------------------------------------------------------------------------------------------------
	//TODO - plan is to repair all codes in our spreadsheet, remove all desc's from the spreadsheet
 // and then none of these "repair" type steps will be needed 
 // This problem comes from the original spreadsheet coming from the gateway folks and it was NOT based from data, 
 //    it came from responses.
 //-------------------------------------------------------------------------------------------------------
 // 12/19/15 - Modified the code for Alpharetta data to not mess up the codes we fixed via V_Refresh
 //            probably still needs a little more review and simplification, perhaps more v_refresh filling too
 //-------------------------------------------------------------------------------------------------------

IMPORT PRTE2, PRTE2_Common, address, ut, doxie, NID;

EXPORT Transform_Data(STRING pindexversion) := MODULE

		SHARED LNPropertyRec := Layouts.layout_LNP_V2_expanded_payload;
		SHARED string8 today_date := ut.GetDate; 

		// New 11/10/15, moving to phase1 and phase2 sections, second pass to create "O" owner records
		// Currently all of our records are "P" property records
		EXPORT LNPropertyRec  Reformat_PHASE2 (LNPropertyRec L) := TRANSFORM
					// First character indicates type of party ("O" => Buyer/Owner; "B" => Borrower, "S" => Seller); 
					// second character indicates the type of address associated with that party ("O" => Buyer/Owner; "P" => Property).
					SELF.source_code   := 'OO';
					SELF.source_code_1            := 'O';
					SELF.source_code_2            := 'O';
					SELF := L;
		END;
	
		EXPORT LNPropertyRec  Reformat_PHASE1 (z_Layout_Batch_in L, Integer C) := TRANSFORM
					// ln_fares_id must be unique per record (internal use only)
					// ?? Production usually has a few records per ln_fares_id ??? But it doesn't seem to tie 1/property either. Need to research that.
					// l.address should have no unit or unit_desig in it because they have a separate column for Apt#
					SELF.did 				:= (INTEGER)L.did;
					SELF.s_did 			:= (INTEGER)L.did;
					string clean_address := address.CleanAddress182(l.address, l.city + ' ' + l.st + ' ' + l.zip);
					SELF.fakeid     := (unsigned) 16000000 + C;  
					SELF.zero       := (unsigned1)0;
					SELF.prim_name  :=  clean_address [13..40];
					SELF.prim_range := clean_address [1..10];
					// There is no unit_desig field here at this level in the record to fill ...
					SELF.sec_range  := L.Apt;
					SELF.city_code  := doxie.Make_CityCode(L.city);
					SELF.st         := IF(clean_address [115..116] > ' ',clean_address [115..116],L.st);
					self.state      := IF(clean_address [115..116] > ' ',clean_address [115..116],L.st);
					self.zip        := clean_address[117..121]; 
					self.zip4       := clean_address[122..125];
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
					self.s4         := (unsigned) l.ssn[6..9];		//????  This looks ODD??  Should there be S4 below and ssn4 here?
					SELF.yob        := (unsigned2) L.DOB [1..4];
					SELF.DOB        := (unsigned4) L.DOB;
					self.s1         :=  l.ssn[1];
					self.s2         :=  l.ssn[2];
					self.s3         :=  l.ssn[3];
					self.s5         :=  l.ssn[5]; 
					self.s6         :=  l.ssn[6];
					self.s7         :=  l.ssn[7];
					self.s8         :=  l.ssn[8];
					self.s9         :=  l.ssn[9];		
 
					SELF.which_orig := 'T';
					SELF.dt_first_seen            := (unsigned)today_date[1..6];		//TODO - might want to take from BHDR/CSV
					SELF.dt_last_seen             := (unsigned)today_date[1..6];		//TODO - might want to take from BHDR/CSV
					SELF.dt_vendor_first_reported := (unsigned)today_date[1..6];		//TODO - might want to take from BHDR/CSV
					SELF.dt_vendor_last_reported  := (unsigned)today_date[1..6];		//TODO - might want to take from BHDR/CSV
					SELF.process_date             := today_date;

					// Currently we only have two fid_types A or D
					SELF.vendor_source_flag       := IF(L.fid_type='A','F','O');
					// NOTE: LN_PropertyV2.layout_property_common_model_base says possible vendor_source_flags are:
					// Vendor Codes for Source A are "F" and "S"; and for Source B are "D" and "O". (F=FAR_F,  S=FAR_S,  O=OKCTY,   D=DAYTN)
					// if field: from_file =F that is source A; if =D or M, it is a source B record.
					
					//RE:lookups - BOCA PRCT data:  Assess has 3:	1366276 records;  Deed has 5:	1065466 records Plus Boca has some 0 records
					SELF.lookups		:= IF(L.fid_type='A', 3, 5);			// ??????????  we were told any non-zero value should work.
					// SPOTTED THIS IN LN_PropertyV2.file_search_autokey - may want to do someday... for now, just go with Boca 3,5
					// ft		:= L.fid_type;	// ('D' => 'D',	'M' => 'D',	'A' => 'A')  - we have no M types
					// pt		:= L.source_code[1];
					// self.lookups := (unsigned4)(ut.bit_set(1, doxie.lookup_bit( ft )) | ut.bit_set(1, doxie.lookup_bit( 'PARTY_'+pt )));
					// If we have any problems, might need to research 
					// Boca seems to have some zeros for all fid/source_code types - see PRTE2_LNProperty.U_Study_FidType_and_lookups
					// Bottomline: Not doing the production logic right now because we have only two source_codes 
					//      - OO and OP so our numbers would be 19,21 not 3,5 and for now, we'll just imitate Boca PRCT data (except no zeros)
					
					// First character indicates type of party ("O" => Buyer/Owner; "B" => Borrower, "S" => Seller); 
					// second character indicates the type of address associated with that party ("O" => Buyer/Owner; "P" => Property).
					SELF.source_code   := 'OP';
					SELF.source_code_1            := 'O';
					SELF.source_code_2            := 'P';
					SELF.app_tax_id  := L.deed_tax_id_number;
					SELF.app_ssn     := L.ssn;
					SELF.person_name.fname := L.fname;
					SELF.person_name.mname := L.mname;
					SELF.person_name.lname := L.lname;
					self.nameasis  := PRTE2_Common.Functions.appendIf3(L.fname,L.mname,l.lname);
					SELF.person_addr.prim_range   := clean_address [1..10];
					SELF.person_addr.predir       := clean_address[11..12];
					SELF.person_addr.prim_name    := clean_address [13..40];
					SELF.person_addr.addr_suffix  := clean_address [41..44];
					Self.person_addr.postdir      := clean_address [45..46];

					// ERROR CORRECTION:  the clean addresss was not handed any runit_desig so it doesn't have one!!!!
					// SELF.person_addr.unit_desig   := clean_address [47..56];
 					SELF.person_addr.sec_range    := L.Apt;
					SELF.person_addr.unit_desig		:= IF(L.Apt='','','UNIT');
					
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
					// SELF.garage_type_code        := L.assess_garage_type_desc;
					SELF.parking_no_of_cars      := L.assess_parking_no_of_cars;
					// SELF.pool_code               := L.assess_pool_desc;
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
 
					SELF.comments               := L.assess_comments;
					SELF.tape_cut_date          := L.assess_tape_cut_date;
					SELF.certification_date     := L.assess_certification_date;
					SELF.edition_number         := L.assess_edition_number;
 
					self.heating_code    				:= L.assess_heating_code;
					SELF.heating_fuel_type_code := L.assess_heating_fuel_type_code; 
					SELF.roof_type_code   			:= L.assess_roof_type_code;
					SELF.elevator               := L.assess_elevator;
					SELF.fireplace_indicator    := L.assess_fireplace_indicator;
					SELF.fireplace_number       := L.assess_fireplace_number;
					SELF.building_class_code    := L.assess_building_class_code;
					SELF.neighborhood_code 			:= L.assess_neighborhood_code;
					
					SELF.assessee_name_indicator := L.assess_assessee_name_indicator;
					SELF.second_assessee_name_indicator := L.assess_second_assessee_name_indicator;	
					
					// STILL NEED THIS UNTIL WE ADD standardized_land_use_code column to our spreadsheet.
					SELF.standardized_land_use_code := MAP
							(L.assess_style_desc = 'SINGLE FAMILY RESIDENTIAL'                => 'SFR',
							 L.assess_style_desc = 'RESIDENTIAL (GENERAL) (SINGLE FAMILY)'    => 'RES',
							 L.assess_style_desc = 'RURAL RESIDENTIAL (AGRICULTURAL)'         => 'RRR',
							 L.assess_style_desc [1..20] = 'PRESUMED RESIDENTIAL'             => 'PRS',
							 '');		
							 
					// DO WE NEED THIS ????
					SELF.condo_project_or_building_name := IF (L.assess_condo_project_name > '', 
																									L.assess_condo_project_name,
																									L.assess_building_name);																				
							 
					SELF.garage_type_code := L.assess_garage_type_code;
					SELF.pool_code := L.assess_pool_code;
					SELF.style_code  						:= L.assess_style_code;
					SELF.type_construction_code := L.assess_type_construction_code;
					SELF.state_land_use_code := L.assess_state_land_use_code;
					SELF.county_land_use_code := L.assess_county_land_use_code;
					SELF.foundation_code        := L.assess_foundation_code;
					SELF.building_quality_code := L.assess_building_quality_code;
					SELF.building_condition_code := L.assess_building_condition_code;
					SELF.exterior_walls_code   	:= L.assess_exterior_walls_code;
					SELF.interior_walls_code := L.assess_interior_walls_code;
					self.roof_cover_code  			:= L.assess_roof_cover_code;
					SELF.floor_cover_code := L.assess_floor_cover_code;
					SELF.water_code := L.assess_water_code;
					SELF.sewer_code := L.assess_sewer_code;
					SELF.air_conditioning_type_code := L.assess_air_conditioning_type_code;
					SELF.site_influence1_code := L.assess_site_influence1_code;
					SELF.site_influence2_code := L.assess_site_influence2_code;
					SELF.site_influence3_code := L.assess_site_influence3_code;
					SELF.site_influence4_code := L.assess_site_influence4_code;
					SELF.site_influence5_code := L.assess_site_influence5_code;
					SELF.amenities1_code := L.assess_amenities1_code;
					SELF.amenities2_code := L.assess_amenities2_code;
					SELF.amenities3_code := L.assess_amenities3_code;
					SELF.amenities4_code := L.assess_amenities4_code;
					SELF.amenities5_code := L.assess_amenities5_code;
					SELF.amenities2_code1 := L.assess_amenities2_code1;
					SELF.amenities2_code2 := L.assess_amenities2_code2;
					SELF.amenities2_code3 := L.assess_amenities2_code3;
					SELF.amenities2_code4 := L.assess_amenities2_code4;
					SELF.amenities2_code5 := L.assess_amenities2_code5;
					SELF.extra_features1_indicator := L.assess_extra_features1_indicator;
					SELF.extra_features2_indicator := L.assess_extra_features2_indicator;
					SELF.extra_features3_indicator := L.assess_extra_features3_indicator;
					SELF.extra_features4_indicator := L.assess_extra_features4_indicator;
					SELF.other_buildings1_code := L.assess_other_buildings1_code;
					SELF.other_buildings2_code := L.assess_other_buildings2_code;
					SELF.other_buildings3_code := L.assess_other_buildings3_code;
					SELF.other_buildings4_code := L.assess_other_buildings4_code;
					SELF.other_buildings5_code := L.assess_other_buildings5_code;
					SELF.other_impr_building1_indicator := L.assess_other_impr_building1_indicator;
					SELF.other_impr_building2_indicator := L.assess_other_impr_building2_indicator;
					SELF.other_impr_building3_indicator := L.assess_other_impr_building3_indicator;
					SELF.other_impr_building4_indicator := L.assess_other_impr_building4_indicator;
					SELF.other_impr_building5_indicator := L.assess_other_impr_building5_indicator;
					// SELF.other_impr_building1_area := L.assess_other_impr_building1_area;
					// SELF.topography_code := L.assess_topography_code;
					// SELF.assessee_name_indicator := L.assess_assessee_name_indicator;
					// SELF.other_rooms_indicator := L.assess_other_rooms_indicator;
					// SELF.mail_care_of_name_indicator := L.assess_mail_care_of_name_indicator;


// -------------------------------------------------------------------------------------------							 
					SELF := L;
					SELF := [];
			END;    	
END;			