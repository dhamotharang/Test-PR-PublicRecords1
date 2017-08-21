import lib_fileservices, property, ln_mortgage, ln_functions, ut, ln_property;

export fileProcessC_BuildBaseFile() := function



//  Grab current property deeds ##########################################################
Deedsource_file := Property.File_Fares_Deeds;

LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE MapToCommonModel(Deedsource_file L) := TRANSFORM
  self.ln_fares_id                           := L.fares_id;
  self.process_date                          := L.process_date;
  self.vendor_source_flag                    := L.vendor;
  self.from_file                             := 'F';
  self.fips_code                             := L.fips;
  self.state                                 := if(L.prop_state!='',L.prop_state,L.prop_ace_state);
  self.county_name                           := '';
  self.apnt_or_pin_number                    := ut.fn_KeepPrintableChars(L.apn_parcel_number_formatted);
  self.tax_id_number                         := L.account_number;
  self.multi_apn_flag                        := L.multi_apn_count;
  self.buyer1                                := ut.fn_KeepPrintableChars(LN_Functions.Function_CombineFirstLastCorpNames(L.owner_buyer_last_name, L.owner_buyer_first_name));
  self.buyer_mailing_address_care_of_name    := L.c_o_name;
  string v_buyer_mailing_full_street_address := l.owner_house_number_prefix
                                              + ' '+if((integer)l.owner_house_number<>0,regexreplace('^0*',trim(L.owner_house_number,left,right),''),'')
											  + ' '+l.owner_house_number_suffix
											  + ' '+l.owner_street_direction
											  + ' '+regexreplace('^0*',trim(L.owner_street_name,left,right),'')
											  + ' '+l.owner_mode
											  + ' '+l.owner_quadrant
											  ;
  self.buyer_mailing_full_street_address     := stringlib.stringcleanspaces(v_buyer_mailing_full_street_address);
  self.buyer_mailing_address_unit_number     := L.owner_apartment_unit;
  self.buyer_mailing_address_citystatezip    := LN_Functions.Function_CombineCityStateZip(L.owner_city, L.owner_state, if(length(trim(l.owner_zip_code))=9,l.owner_zip_code[1..5]+'-'+l.owner_zip_code[6..9],L.owner_zip_code), '');
  self.seller1                               := ut.fn_KeepPrintableChars(L.seller_name);
  string v_property_full_street_address      := l.prop_house_number_prefix
                                              + ' '+if((integer)l.prop_house_number<>0,regexreplace('^0*',trim(L.prop_house_number,left,right),''),'')
											  + ' '+l.prop_house_number_suffix
											  + ' '+regexreplace('^0*',trim(L.prop_street_name,left,right),'')
											  + ' '+l.prop_mode
											  + ' '+l.prop_direction
											  + ' '+l.prop_quadrant
											  ;
  self.property_full_street_address          := stringlib.stringcleanspaces(v_property_full_street_address);
  self.property_address_unit_number          := L.prop_apartment_unit;
  self.property_address_code                 := L.address_indicator;
  self.property_address_citystatezip         := trim(LN_Functions.Function_CombineCityStateZip(L.prop_city, L.prop_state, if(length(trim(l.prop_property_address_zip_code_))=9,l.prop_property_address_zip_code_[1..5]+'-'+l.prop_property_address_zip_code_[6..9],L.prop_property_address_zip_code_), ''),left,right);
  self.contract_date                         := L.sale_date_yyyymmdd;
  self.recording_date                        := L.recording_date_yyyymmdd;
  self.document_number                       := ut.fn_KeepPrintableChars(L.document_number);
  self.document_type_code                    := L.document_type;
  self.recorder_book_number                  := L.book_page_6x6[1..6];
  self.recorder_page_number                  := L.book_page_6x6[7..12];
  self.sales_price                           := L.sale_amount;
  self.sales_price_code                      := L.sale_code;
  self.first_td_loan_amount                  := L.mortgage_amount;
  self.first_td_loan_type_code               := L.mortgage_loan_type_code;
  self.first_td_due_date                     := L.mortgage_due_date;
  self.type_financing                        := L.mortgage_interest_rate_type;
  self.title_company_name                    := ut.fn_KeepPrintableChars(L.title_company_name);
  self.partial_interest_transferred          := L.ownership_transfer_percentage;
  self.lender_name                           := ut.fn_KeepPrintableChars(trim(trim(if(trim(L.lender_last_name,left,right)='PRIVATE INDIVIDUAL','',trim(L.lender_last_name,left,right)) +
                                                ' ' + trim(L.lender_first_name,left,right),left,right),left,right));  
  self.assessment_match_land_use_code        := L.universal_luse_code;
  self.property_use_code                     := L.property_indicator_code;
  self.fares_unformatted_apn                 := L.apn_parcel_number_unformatted;
  self.fares_corporate_indicator             := L.corporate_indicator;
  self.fares_transaction_type                := L.transaction_type;
  self.fares_lender_address                  := L.lender_address;
  self.fares_mortgage_deed_type              := L.mortgage_deed_type;
  self.fares_mortgage_term_code              := L.mortgage_term_code;
  self.fares_mortgage_term                   := L.mortgage_term;
  self.fares_building_square_feet            := L.building_square_feet;
  self.fares_foreclosure                     := L.foreclosure;
  self.fares_refi_flag                       := L.refi_flag;
  self.fares_equity_flag                     := L.equity_flag;
  self.fares_iris_apn                        := L.Iris_apn;  
  self.second_td_loan_amount                 := if(trim(L.second_mortgage_amount)!='','00'+L.second_mortgage_amount[1..9],'');
  self.fares_mortgage_date                   := L.mortgage_date;
  self                                       := [];
END;

DeedWithLN_Format := PROJECT(Deedsource_file, MapToCommonModel(LEFT));



// Grab current property assessors ##########################################################
Assessorsource_file := Property.File_Fares_Assessor;

LN_Property.Layout_Property_Common_Model_BASE MapToCommonModel2(Assessorsource_file L) := TRANSFORM
  self.ln_fares_id                           := L.fares_id;
  self.process_date                          := L.process_date;
  self.vendor_source_flag                    := L.vendor;
  self.fips_code                             := L.fips_code;
  self.state_code                            := if(trim(L.prop_st)!='',L.prop_st,L.prop_state);
  self.county_name                           := '';
  self.apna_or_pin_number                    := ut.fn_KeepPrintableChars(L.formatted_apn);
  self.assessee_name                         := ut.fn_KeepPrintableChars(L.owner_name);
  self.second_assessee_name                  := ut.fn_KeepPrintableChars(L.owner_name_2);
  self.assessee_ownership_rights_code        := L.owner_ownership_rights_code;
  self.assessee_relationship_code            := L.owner_relationship_code;
  self.assessee_phone_number                 := L.owner_phone;
  self.tax_account_number                    := L.account_num;
  self.assessee_name_type_code               := L.owner_corp_ind;
  string v_mailing_full_street_address := l.own_house_number_prefix
                                              + ' '+if((integer)l.own_house_number<>0,regexreplace('^0*',trim(L.own_house_number,left,right),''),'')
											  + ' '+l.own_house_number_suffix
											  + ' '+l.own_direction
											  + ' '+regexreplace('^0*',trim(L.own_street_name,left,right),'')
											  + ' '+l.own_mode
											  + ' '+l.own_quadrant
											  ;
  self.mailing_full_street_address     := stringlib.stringcleanspaces(v_mailing_full_street_address);												
  self.mailing_unit_number                   := L.own_apt_unit_num;
  self.mailing_city_state_zip                := LN_Functions.Function_CombineCityStateZip(L.own_city, L.own_state, if(length(trim(l.own_zipcode))=9,l.own_zipcode[1..5]+'-'+l.own_zipcode[6..9],L.own_zipcode), '');
  string v_property_full_street_address      := l.prop_house_number_prefix
                                              + ' '+if((integer)l.prop_house_number<>0,regexreplace('^0*',trim(L.prop_house_number,left,right),''),'')
											  + ' '+l.prop_house_number_suffix
											  + ' '+regexreplace('^0*',trim(L.prop_street_name,left,right),'')
											  + ' '+l.prop_mode
											  + ' '+l.prop_direction
											  + ' '+l.prop_quadrant
											  ;
  self.property_full_street_address          := stringlib.stringcleanspaces(v_property_full_street_address); 
  self.property_unit_number                  := L.prop_apt_unit_num;
  self.property_city_state_zip               := trim(LN_Functions.Function_CombineCityStateZip(L.prop_city, L.prop_state, if(length(trim(l.prop_zipcode))=9,l.prop_zipcode[1..5]+'-'+l.prop_zipcode[6..9],L.prop_zipcode), ''),left,right);
  self.property_address_code                 := L.prop_address_indicator;
  self.legal_lot_number                      := L.lot_number;
  self.legal_block                           := L.block_number;
  self.legal_city_municipality_township      := L.municipality_name;
  self.legal_subdivision_name                := ut.fn_KeepPrintableChars(L.subdivision_name);
  string v_section                           := if(trim(L.section)!='','SEC ' + trim(L.section) + ' ','');
  string v_township                          := if(trim(L.township)!='','TWN ' + trim(L.township) + ' ','');
  string v_range                             := if(trim(L._range)!='','RNG '+trim(L._range),'');
  self.legal_sec_twn_rng_mer                 := v_section+v_township+v_range;
  self.legal_brief_description               := ut.fn_KeepPrintableChars(L.legal1);
  self.census_tract                          := L.census_tract;
  self.county_land_use_code                  := L.county_use1;
  self.zoning                                := L.zoning;
  self.recorder_document_number              := ut.fn_KeepPrintableChars(L.document_number);
  self.recorder_book_number                  := L.book_page[1..6];
  self.recorder_page_number                  := L.book_page[7..12];
  self.transfer_date                         := L.document_year;
  self.recording_date                        := L.recording_date;
  self.sale_date                             := L.sale_date;
  self.sales_price                           := L.sale_price;
  self.sales_price_code                      := L.sale_code;
  self.mortgage_loan_amount                  := L.first_motgage_amount;
  self.mortgage_loan_type_code               := L.mortgage_loan_type_code;
  self.mortgage_lender_name                  := ut.fn_KeepPrintableChars(L.lender_name);
  self.prior_transfer_date                   := L.prior_document_year;
  self.prior_recording_date                  := L.prior_recording_date;
  self.prior_sales_price                     := L.prior_sales_price;
  self.prior_sales_price_code                := L.prior_sales_code;
  self.assessed_land_value                   := L.assd_land_val;
  self.assessed_improvement_value            := L.assd_improvement_value;
  self.assessed_total_value                  := L.assd_total_val;
  self.market_land_value                     := L.mkt_land_val;
  self.market_improvement_value              := L.mkt_improvement_val;
  self.market_total_value                    := L.mkt_total_val;
  self.homestead_homeowner_exemption         := L.homestead_exempt;
  self.tax_amount                            := L.tax_amount;
  self.tax_year                              := L.tax_year;
  self.school_tax_district1                  := L.tax_code_area;
  self.land_acres                            := L.acres;
  self.land_square_footage                   := L.land_square_footage;
  self.land_dimensions                       := trim(L.front_footage,left,right)+'X'+trim(L.depth_footage,left,right);
  self.building_area                         := L.universal_building_sq_feet;
  self.building_area_indicator               := L.building_sq_feet_ind;
  self.year_built                            := L.year_built;
  self.effective_year_built                  := L.effective_year_built;
  self.no_of_buildings                       := L.number_of_buildings;
  self.no_of_stories                         := L.stories_number;
  self.no_of_units                           := L.units_number;
  self.no_of_rooms                           := L.total_rooms;
  self.no_of_bedrooms                        := L.bedrooms;
  self.no_of_baths                           := L.total_baths;
  self.garage_type_code                      := L.garage;
  self.parking_no_of_cars                    := L.parking_spaces;
  self.pool_code                             := L.pool_code;
  self.style_code                            := L.style;
  self.type_construction_code                := L.construction_type;
  self.exterior_walls_code                   := L.exterior_walls;
  self.foundation_code                       := L.foundation;
  self.roof_cover_code                       := L.roof_cover;
  self.roof_type_code                        := L.roof_type;
  self.heating_code                          := L.heating;
  self.heating_fuel_type_code                := L.fuel;
  self.air_conditioning_code                 := L.air_conditioning;
  self.fireplace_indicator                   := L.fireplace_ind;
  self.fireplace_number                      := L.fireplace_number;
  self.basement_code                         := L.basement_finish;
  self.site_influence1_code                  := L.location_influence;
  self.other_buildings1_code                 := L.bldg_impv_code;
  self.fares_unformatted_apn                 := L.unformatted_apn;
  self.fares_iris_apn                        := L.Iris_apn;
  self.fares_non_parsed_assessee_name        := ut.fn_KeepPrintableChars(L.owner_name1);
  self.fares_non_parsed_second_assessee_name := ut.fn_KeepPrintableChars(L.owner_name2);
  self.fares_legal2                          := ut.fn_KeepPrintableChars(L.legal2);
  self.fares_legal3                          := ut.fn_KeepPrintableChars(L.legal3);
  self.fares_land_use                        := L.land_use;
  self.fares_seller_name                     := ut.fn_KeepPrintableChars(L.seller_name);
  self.fares_calculated_land_value           := L.land_val_calc;
  self.fares_calculated_improvement_value    := L.improvement_value_calc;
  self.fares_calculated_total_value          := L.total_val_calc; 
  self.fares_living_square_feet              := L.living_square_feet;
  self.fares_adjusted_gross_square_feet      := L.adjusted_gross_square_feet;
  self.fares_no_of_full_baths                := L.full_baths;
  self.fares_no_of_half_baths                := L.half_baths;
  self.fares_pool_indicator                  := L.pool;
  self.fares_frame                           := L.frame;
  self.fares_electric_energy                 := L.electric_energy;
  self.fares_sewer                           := L.sewer;
  self.fares_water                           := L.water;
  self.fares_condition                       := L.condition;  
  self.standardized_land_use_code            := L.land_use;
  self                                       := [];
END;

AssessorWithLN_Format := project(Assessorsource_file, MapToCommonModel2(left));



// Grab property search ##########################################################
File_Fares_Search := dataset('~thor_data400::OUT::Property_DID', property.Layout_prop_out, flat);

outrec := record
  LN_Property.Layout_Deed_Mortgage_Property_Search;
end; 

outrec	redefine_fares(property.File_Fares_Search_DID L) := transform
  self.ln_fares_id        := L.fares_id;
  self.cname              := L._company;
  self.vendor_source_flag := L.vendor;
  self                    := L;
end;

SearchWithLN_Format := project(File_Fares_Search, redefine_fares(left));



// #################################################

combinedAssessor := ln_property.Replace_Assessor + AssessorWithLN_Format + ln_property.irs_dummy_recs_assessor; 
combinedDeed     := ln_property.Replace_Deeds    + DeedWithLN_Format + ln_property.irs_dummy_recs_deed; 
combinedSearch   := ln_property.Replace_Search   + SearchWithLN_Format; 
addlNames        := ln_property.Replace_Addl_Names; 

outSearch := combinedSearch + ln_property.Propagate_Property_Address_Deed(combinedDeed,combinedSearch).new_search_records;

srch0 := ln_property.fn_patch_search(outsearch);

assr0 := ln_property.fn_junk_tax(combinedassessor);

deed0 := ln_property.fn_junk_deed(combineddeed);
deed1 := ln_property.Propagate_Property_Address_Deed(deed0,combinedSearch).deed_result;
deed2 := ln_property.fn_patch_deed(deed1);

ut.MAC_SF_Build_standard(assr0,    ln_property.filenames.versionedBaseAssessor,  buildAssessor,  ln_property.version_build);
ut.MAC_SF_Build_standard(deed2,    ln_property.filenames.versionedBaseDeed,      buildDeed,      ln_property.version_build);
ut.MAC_SF_Build_standard(srch0,    ln_property.filenames.versionedBaseSearch,    buildSearch,    ln_property.version_build);
ut.MAC_SF_Build_standard(addlNames,ln_property.filenames.versionedBaseAddlNames, buildAddlNames, ln_property.version_build);				
			
sequential(buildAssessor, buildDeed, buildSearch, buildAddlNames);

//sequential(buildAddlNames);
																																		
return 'BuildBaseFiles';
end;