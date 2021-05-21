import Data_services, LN_PropertyV2_Fast; 

File_Assessment_bitmap := dataset(
																	 LN_PropertyV2_Fast.filenames.baseFull.assessment
																	,LN_PropertyV2.Layouts.layout_property_common_model_base_scrubs
																	,flat,opt);

ln_propertyv2.layout_property_common_model_base	tRemoveGarbageChars(File_Assessment_bitmap pInput)	:=
transform
	                  
                 
 	self.vendor_source_flag                             :=	regexreplace('[^ -~]+', pInput.vendor_source_flag                    , '');       
  self.current_record                                 :=	regexreplace('[^ -~]+', pInput.current_record                        , '');    
 	self.fips_code                                      :=	regexreplace('[^ -~]+', pInput.fips_code                             , '');    
 	self.state_code                                     :=	regexreplace('[^ -~]+', pInput.state_code                            , '');    
 	self.county_name                                    :=	regexreplace('[^ -~]+', pInput.county_name                           , '');    
	self.old_apn                                        :=	regexreplace('[^ -~]+', pInput.old_apn                               , '');    
 	self.apna_or_pin_number                             :=	regexreplace('[^ -~]+', pInput.apna_or_pin_number                    , '');    
 	self.fares_unformatted_apn                          :=	regexreplace('[^ -~]+', pInput.fares_unformatted_apn                 , '');    
 	self.duplicate_apn_multiple_address_id              :=	regexreplace('[^ -~]+', pInput.duplicate_apn_multiple_address_id     , '');    
 	self.assessee_name                                  :=	regexreplace('[^ -~]+', pInput.assessee_name                         , '');    
 	self.second_assessee_name                           :=	regexreplace('[^ -~]+', pInput.second_assessee_name                  , '');    
 	self.assessee_ownership_rights_code                 :=	regexreplace('[^ -~]+', pInput.assessee_ownership_rights_code        , '');    
 	self.assessee_relationship_code                     :=	regexreplace('[^ -~]+', pInput.assessee_relationship_code            , '');    
 	self.assessee_phone_number                          :=	regexreplace('[^ -~]+', pInput.assessee_phone_number                 , '');    
 	self.tax_account_number                             :=	regexreplace('[^ -~]+', pInput.tax_account_number                    , '');    
 	self.contract_owner                                 :=	regexreplace('[^ -~]+', pInput.contract_owner                        , '');    
 	self.assessee_name_type_code                        :=	regexreplace('[^ -~]+', pInput.assessee_name_type_code               , '');    
 	self.second_assessee_name_type_code                 :=	regexreplace('[^ -~]+', pInput.second_assessee_name_type_code        , '');    
 	self.mail_care_of_name_type_code                    :=	regexreplace('[^ -~]+', pInput.mail_care_of_name_type_code           , '');    
 	self.mailing_care_of_name                           :=	regexreplace('[^ -~]+', pInput.mailing_care_of_name                  , '');    
 	self.mailing_full_street_address                    :=	regexreplace('[^ -~]+', pInput.mailing_full_street_address           , '');    
 	self.mailing_unit_number                            :=	regexreplace('[^ -~]+', pInput.mailing_unit_number                   , '');    
 	self.mailing_city_state_zip                         :=	regexreplace('[^ -~]+', pInput.mailing_city_state_zip                , '');    
 	self.property_full_street_address                   :=	regexreplace('[^ -~]+', pInput.property_full_street_address          , '');    
 	self.property_unit_number                           :=	regexreplace('[^ -~]+', pInput.property_unit_number                  , '');    
 	self.property_city_state_zip                        :=	regexreplace('[^ -~]+', pInput.property_city_state_zip               , '');    
 	self.property_country_code                          :=	regexreplace('[^ -~]+', pInput.property_country_code                 , '');    
 	self.property_address_code                          :=	regexreplace('[^ -~]+', pInput.property_address_code                 , '');    
 	self.legal_lot_code                                 :=	regexreplace('[^ -~]+', pInput.legal_lot_code                        , '');    
 	self.legal_lot_number                               :=	regexreplace('[^ -~]+', pInput.legal_lot_number                      , '');    
 	self.legal_land_lot                                 :=	regexreplace('[^ -~]+', pInput.legal_land_lot                        , '');    
 	self.legal_block                                    :=	regexreplace('[^ -~]+', pInput.legal_block                           , '');    
 	self.legal_section                                  :=	regexreplace('[^ -~]+', pInput.legal_section                         , '');    
 	self.legal_district                                 :=	regexreplace('[^ -~]+', pInput.legal_district                        , '');    
 	self.legal_unit                                     :=	regexreplace('[^ -~]+', pInput.legal_unit                            , '');    
 	self.legal_city_municipality_township               :=	regexreplace('[^ -~]+', pInput.legal_city_municipality_township      , '');    
 	self.legal_subdivision_name                         :=	regexreplace('[^ -~]+', pInput.legal_subdivision_name                , '');    
 	self.legal_phase_number                             :=	regexreplace('[^ -~]+', pInput.legal_phase_number                    , '');    
 	self.legal_tract_number                             :=	regexreplace('[^ -~]+', pInput.legal_tract_number                    , '');    
 	self.legal_sec_twn_rng_mer                          :=	regexreplace('[^ -~]+', pInput.legal_sec_twn_rng_mer                 , '');    
  self.	legal_brief_description                       :=	regexreplace('[^ -~]+', pInput.	legal_brief_description              , '');   
 	self.legal_assessor_map_ref                         :=	regexreplace('[^ -~]+', pInput.legal_assessor_map_ref                , '');    
 	self.census_tract                                   :=	regexreplace('[^ -~]+', pInput.census_tract                          , '');    
 	self.record_type_code                               :=	regexreplace('[^ -~]+', pInput.record_type_code                      , '');    
 	self.ownership_type_code                            :=	regexreplace('[^ -~]+', pInput.ownership_type_code                   , '');    
 	self.new_record_type_code                           :=	regexreplace('[^ -~]+', pInput.new_record_type_code                  , '');    
	self.state_land_use_code                            :=	regexreplace('[^ -~]+', pInput.state_land_use_code                   , '');  
 	self.county_land_use_code                           :=	regexreplace('[^ -~]+', pInput.county_land_use_code                  , '');    
 	self.county_land_use_description                    :=	regexreplace('[^ -~]+', pInput.county_land_use_description           , '');    
 	self.standardized_land_use_code                     :=	regexreplace('[^ -~]+', pInput.standardized_land_use_code            , '');    
 	self.timeshare_code                                 :=	regexreplace('[^ -~]+', pInput.timeshare_code                        , '');    
 	self.zoning                                         :=	regexreplace('[^ -~]+', pInput.zoning                                , '');    
 	self.owner_occupied                                 :=	regexreplace('[^ -~]+', pInput.owner_occupied                        , '');    
 	self.recorder_document_number                       :=	regexreplace('[^ -~]+', pInput.recorder_document_number              , '');    
 	self.recorder_book_number                           :=	regexreplace('[^ -~]+', pInput.recorder_book_number                  , '');    
 	self.recorder_page_number                           :=	regexreplace('[^ -~]+', pInput.recorder_page_number                  , '');    
 	self.transfer_date                                  :=	regexreplace('[^ -~]+', pInput.transfer_date                         , '');    
 	self.recording_date                                 :=	regexreplace('[^ -~]+', pInput.recording_date                        , '');    
 	self.sale_date                                      :=	regexreplace('[^ -~]+', pInput.sale_date                             , '');    
 	self.document_type                                  :=	regexreplace('[^ -~]+', pInput.document_type                         , '');    
 	self.sales_price                                    :=	regexreplace('[^ -~]+', pInput.sales_price                           , '');    
 	self.sales_price_code                               :=	regexreplace('[^ -~]+', pInput.sales_price_code                      , '');    
 	self.mortgage_loan_amount                           :=	regexreplace('[^ -~]+', pInput.mortgage_loan_amount                  , '');    
 	self.mortgage_loan_type_code                        :=	regexreplace('[^ -~]+', pInput.mortgage_loan_type_code               , '');    
 	self.mortgage_lender_name                           :=	regexreplace('[^ -~]+', pInput.mortgage_lender_name                  , '');    
 	self.mortgage_lender_type_code                      :=	regexreplace('[^ -~]+', pInput.mortgage_lender_type_code             , '');    
 	self.prior_transfer_date                            :=	regexreplace('[^ -~]+', pInput.prior_transfer_date                   , '');    
 	self.prior_recording_date                           :=	regexreplace('[^ -~]+', pInput.prior_recording_date                  , '');    
 	self.prior_sales_price                              :=	regexreplace('[^ -~]+', pInput.prior_sales_price                     , '');    
 	self.prior_sales_price_code                         :=	regexreplace('[^ -~]+', pInput.prior_sales_price_code                , '');    
 	self.assessed_land_value                            :=	regexreplace('[^ -~]+', pInput.assessed_land_value                   , '');    
 	self.assessed_improvement_value                     :=	regexreplace('[^ -~]+', pInput.assessed_improvement_value            , '');    
 	self.assessed_total_value                           :=	regexreplace('[^ -~]+', pInput.assessed_total_value                  , '');    
 	self.assessed_value_year                            :=	regexreplace('[^ -~]+', pInput.assessed_value_year                   , '');    
 	self.market_land_value                              :=	regexreplace('[^ -~]+', pInput.market_land_value                     , '');    
 	self.market_improvement_value                       :=	regexreplace('[^ -~]+', pInput.market_improvement_value              , '');    
 	self.market_total_value                             :=	regexreplace('[^ -~]+', pInput.market_total_value                    , '');    
 	self.market_value_year                              :=	regexreplace('[^ -~]+', pInput.market_value_year                     , '');    
 	self.homestead_homeowner_exemption                  :=	regexreplace('[^ -~]+', pInput.homestead_homeowner_exemption         , '');    
 	self.tax_exemption1_code                            :=	regexreplace('[^ -~]+', pInput.tax_exemption1_code                   , '');    
 	self.tax_exemption2_code                            :=	regexreplace('[^ -~]+', pInput.tax_exemption2_code                   , '');    
 	self.tax_exemption3_code                            :=	regexreplace('[^ -~]+', pInput.tax_exemption3_code                   , '');    
 	self.tax_exemption4_code                            :=	regexreplace('[^ -~]+', pInput.tax_exemption4_code                   , '');    
 	self.tax_rate_code_area                             :=	regexreplace('[^ -~]+', pInput.tax_rate_code_area                    , '');    
 	self.tax_amount                                     :=	regexreplace('[^ -~]+', pInput.tax_amount                            , '');    
 	self.tax_year                                       :=	regexreplace('[^ -~]+', pInput.tax_year                              , '');    
 	self.tax_delinquent_year                            :=	regexreplace('[^ -~]+', pInput.tax_delinquent_year                   , '');    
 	self.school_tax_district1                           :=	regexreplace('[^ -~]+', pInput.school_tax_district1                  , '');    
 	self.school_tax_district1_indicator                 :=	regexreplace('[^ -~]+', pInput.school_tax_district1_indicator        , '');    
 	self.school_tax_district2                           :=	regexreplace('[^ -~]+', pInput.school_tax_district2                  , '');    
 	self.school_tax_district2_indicator                 :=	regexreplace('[^ -~]+', pInput.school_tax_district2_indicator        , '');    
 	self.school_tax_district3                           :=	regexreplace('[^ -~]+', pInput.school_tax_district3                  , '');    
 	self.school_tax_district3_indicator                 :=	regexreplace('[^ -~]+', pInput.school_tax_district3_indicator        , '');    
	self.lot_size                                       :=	regexreplace('[^ -~]+', pInput.lot_size                              , '');  
	self.lot_size_acres                                 :=	regexreplace('[^ -~]+', pInput.lot_size_acres                        , '');  
	self.lot_size_frontage_feet                         :=	regexreplace('[^ -~]+', pInput.lot_size_frontage_feet                , '');  
	self.lot_size_depth_feet                            :=	regexreplace('[^ -~]+', pInput.lot_size_depth_feet                   , '');  
 	self.land_acres                                     :=	regexreplace('[^ -~]+', pInput.land_acres                            , '');    
 	self.land_square_footage                            :=	regexreplace('[^ -~]+', pInput.land_square_footage                   , '');    
 	self.land_dimensions                                :=	regexreplace('[^ -~]+', pInput.land_dimensions                       , '');    
 	self.building_area                                  :=	regexreplace('[^ -~]+', pInput.building_area                         , '');    
 	self.building_area_indicator                        :=	regexreplace('[^ -~]+', pInput.building_area_indicator               , '');    
 	self.building_area1                                 :=	regexreplace('[^ -~]+', pInput.building_area1                        , '');    
 	self.building_area1_indicator                       :=	regexreplace('[^ -~]+', pInput.building_area1_indicator              , '');    
 	self.building_area2                                 :=	regexreplace('[^ -~]+', pInput.building_area2                        , '');    
 	self.building_area2_indicator                       :=	regexreplace('[^ -~]+', pInput.building_area2_indicator              , '');    
 	self.building_area3                                 :=	regexreplace('[^ -~]+', pInput.building_area3                        , '');    
 	self.building_area3_indicator                       :=	regexreplace('[^ -~]+', pInput.building_area3_indicator              , '');    
 	self.building_area4                                 :=	regexreplace('[^ -~]+', pInput.building_area4                        , '');    
 	self.building_area4_indicator                       :=	regexreplace('[^ -~]+', pInput.building_area4_indicator              , '');    
 	self.building_area5                                 :=	regexreplace('[^ -~]+', pInput.building_area5                        , '');    
 	self.building_area5_indicator                       :=	regexreplace('[^ -~]+', pInput.building_area5_indicator              , '');    
 	self.building_area6                                 :=	regexreplace('[^ -~]+', pInput.building_area6                        , '');    
 	self.building_area6_indicator                       :=	regexreplace('[^ -~]+', pInput.building_area6_indicator              , '');    
 	self.building_area7                                 :=	regexreplace('[^ -~]+', pInput.building_area7                        , '');    
 	self.building_area7_indicator                       :=	regexreplace('[^ -~]+', pInput.building_area7_indicator              , '');    
 	self.year_built                                     :=	regexreplace('[^ -~]+', pInput.year_built                            , '');    
 	self.effective_year_built                           :=	regexreplace('[^ -~]+', pInput.effective_year_built                  , '');    
 	self.no_of_buildings                                :=	regexreplace('[^ -~]+', pInput.no_of_buildings                       , '');    
 	self.no_of_stories                                  :=	regexreplace('[^ -~]+', pInput.no_of_stories                         , '');    
 	self.no_of_units                                    :=	regexreplace('[^ -~]+', pInput.no_of_units                           , '');    
 	self.no_of_rooms                                    :=	regexreplace('[^ -~]+', pInput.no_of_rooms                           , '');    
 	self.no_of_bedrooms                                 :=	regexreplace('[^ -~]+', pInput.no_of_bedrooms                        , '');    
 	self.no_of_baths                                    :=	regexreplace('[^ -~]+', pInput.no_of_baths                           , '');    
 	self.no_of_partial_baths                            :=	regexreplace('[^ -~]+', pInput.no_of_partial_baths                   , '');    
	self.	no_of_plumbing_fixtures                       :=	regexreplace('[^ -~]+', pInput.	no_of_plumbing_fixtures              , '');   
 	self.garage_type_code                               :=	regexreplace('[^ -~]+', pInput.garage_type_code                      , '');    
 	self.parking_no_of_cars                             :=	regexreplace('[^ -~]+', pInput.parking_no_of_cars                    , '');    
 	self.pool_code                                      :=	regexreplace('[^ -~]+', pInput.pool_code                             , '');    
 	self.style_code                                     :=	regexreplace('[^ -~]+', pInput.style_code                            , '');    
 	self.type_construction_code                         :=	regexreplace('[^ -~]+', pInput.type_construction_code                , '');    
 	self.foundation_code                                :=	regexreplace('[^ -~]+', pInput.foundation_code                       , '');    
	self.	building_quality_code                         :=	regexreplace('[^ -~]+', pInput.	building_quality_code                , '');   
	self.	building_condition_code                       :=	regexreplace('[^ -~]+', pInput.	building_condition_code              , '');   
 	self.exterior_walls_code                            :=	regexreplace('[^ -~]+', pInput.exterior_walls_code                   , '');    
	self.	interior_walls_code                           :=	regexreplace('[^ -~]+', pInput.	interior_walls_code                  , '');   
 	self.roof_cover_code                                :=	regexreplace('[^ -~]+', pInput.roof_cover_code                       , '');    
 	self.roof_type_code                                 :=	regexreplace('[^ -~]+', pInput.roof_type_code                        , '');    
	self.	floor_cover_code                              :=	regexreplace('[^ -~]+', pInput.	floor_cover_code                     , '');   
	self.	water_code                                    :=	regexreplace('[^ -~]+', pInput.	water_code                           , '');   
	self.	sewer_code                                    :=	regexreplace('[^ -~]+', pInput.	sewer_code                           , '');   
 	self.heating_code                                   :=	regexreplace('[^ -~]+', pInput.heating_code                          , '');    
 	self.heating_fuel_type_code                         :=	regexreplace('[^ -~]+', pInput.heating_fuel_type_code                , '');    
 	self.air_conditioning_code                          :=	regexreplace('[^ -~]+', pInput.air_conditioning_code                 , '');    
 	self.air_conditioning_type_code                     :=	regexreplace('[^ -~]+', pInput.air_conditioning_type_code            , '');    
 	self.elevator                                       :=	regexreplace('[^ -~]+', pInput.elevator                              , '');    
 	self.fireplace_indicator                            :=	regexreplace('[^ -~]+', pInput.fireplace_indicator                   , '');    
 	self.fireplace_number                               :=	regexreplace('[^ -~]+', pInput.fireplace_number                      , '');    
 	self.basement_code                                  :=	regexreplace('[^ -~]+', pInput.basement_code                         , '');    
 	self.building_class_code                            :=	regexreplace('[^ -~]+', pInput.building_class_code                   , '');    
 	self.site_influence1_code                           :=	regexreplace('[^ -~]+', pInput.site_influence1_code                  , '');    
 	self.site_influence2_code                           :=	regexreplace('[^ -~]+', pInput.site_influence2_code                  , '');    
 	self.site_influence3_code                           :=	regexreplace('[^ -~]+', pInput.site_influence3_code                  , '');    
 	self.site_influence4_code                           :=	regexreplace('[^ -~]+', pInput.site_influence4_code                  , '');    
 	self.site_influence5_code                           :=	regexreplace('[^ -~]+', pInput.site_influence5_code                  , '');    
 	self.amenities1_code                                :=	regexreplace('[^ -~]+', pInput.amenities1_code                       , '');    
 	self.amenities2_code                                :=	regexreplace('[^ -~]+', pInput.amenities2_code                       , '');    
 	self.amenities3_code                                :=	regexreplace('[^ -~]+', pInput.amenities3_code                       , '');    
 	self.amenities4_code                                :=	regexreplace('[^ -~]+', pInput.amenities4_code                       , '');    
 	self.amenities5_code                                :=	regexreplace('[^ -~]+', pInput.amenities5_code                       , '');    
	self.	amenities2_code1                              :=	regexreplace('[^ -~]+', pInput.	amenities2_code1                     , '');   
	self.	amenities2_code2                              :=	regexreplace('[^ -~]+', pInput.	amenities2_code2                     , '');   
	self.	amenities2_code3                              :=	regexreplace('[^ -~]+', pInput.	amenities2_code3                     , '');   
	self.	amenities2_code4                              :=	regexreplace('[^ -~]+', pInput.	amenities2_code4                     , '');   
	self.	amenities2_code5                              :=	regexreplace('[^ -~]+', pInput.	amenities2_code5                     , '');   
	self.	extra_features1_area                          :=	regexreplace('[^ -~]+', pInput.	extra_features1_area                 , '');   
	self.	extra_features1_indicator                     :=	regexreplace('[^ -~]+', pInput.	extra_features1_indicator            , '');   
	self.	extra_features2_area                          :=	regexreplace('[^ -~]+', pInput.	extra_features2_area                 , '');   
	self.	extra_features2_indicator                     :=	regexreplace('[^ -~]+', pInput.	extra_features2_indicator            , '');   
	self.	extra_features3_area	                        :=	regexreplace('[^ -~]+', pInput.	extra_features3_area	               , '');   
	self.	extra_features3_indicator                     :=	regexreplace('[^ -~]+', pInput.	extra_features3_indicator            , '');   
	self.	extra_features4_area                          :=	regexreplace('[^ -~]+', pInput.	extra_features4_area                 , '');   
	self.	extra_features4_indicator                     :=	regexreplace('[^ -~]+', pInput.	extra_features4_indicator            , '');   
 	self.other_buildings1_code                          :=	regexreplace('[^ -~]+', pInput.other_buildings1_code                 , '');    
 	self.other_buildings2_code                          :=	regexreplace('[^ -~]+', pInput.other_buildings2_code                 , '');    
 	self.other_buildings3_code                          :=	regexreplace('[^ -~]+', pInput.other_buildings3_code                 , '');    
 	self.other_buildings4_code                          :=	regexreplace('[^ -~]+', pInput.other_buildings4_code                 , '');    
 	self.other_buildings5_code                          :=	regexreplace('[^ -~]+', pInput.other_buildings5_code                 , '');    
	self.	other_impr_building1_indicator                :=	regexreplace('[^ -~]+', pInput.	other_impr_building1_indicator       , '');   
	self.	other_impr_building2_indicator                :=	regexreplace('[^ -~]+', pInput.	other_impr_building2_indicator       , '');   
	self.	other_impr_building3_indicator                :=	regexreplace('[^ -~]+', pInput.	other_impr_building3_indicator       , '');   
	self.	other_impr_building4_indicator                :=	regexreplace('[^ -~]+', pInput.	other_impr_building4_indicator       , '');   
	self.	other_impr_building5_indicator                :=	regexreplace('[^ -~]+', pInput.	other_impr_building5_indicator       , '');   
	self.	other_impr_building_area1                     :=	regexreplace('[^ -~]+', pInput.	other_impr_building_area1            , '');   
	self.	other_impr_building_area2                     :=	regexreplace('[^ -~]+', pInput.	other_impr_building_area2            , '');   
	self.	other_impr_building_area3                     :=	regexreplace('[^ -~]+', pInput.	other_impr_building_area3            , '');   
	self.	other_impr_building_area4                     :=	regexreplace('[^ -~]+', pInput.	other_impr_building_area4            , '');   
	self.	other_impr_building_area5                     :=	regexreplace('[^ -~]+', pInput.	other_impr_building_area5            , '');   
	self.	topograpy_code                                :=	regexreplace('[^ -~]+', pInput.	topograpy_code                       , '');   
 	self.neighborhood_code                              :=	regexreplace('[^ -~]+', pInput.neighborhood_code                     , '');    
 	self.condo_project_or_building_name                 :=	regexreplace('[^ -~]+', pInput.condo_project_or_building_name        , '');    
 	self.assessee_name_indicator                        :=	regexreplace('[^ -~]+', pInput.assessee_name_indicator               , '');    
 	self.second_assessee_name_indicator                 :=	regexreplace('[^ -~]+', pInput.second_assessee_name_indicator        , '');    
	self.	other_rooms_indicator                         :=	regexreplace('[^ -~]+', pInput.	other_rooms_indicator                , '');   
 	self.mail_care_of_name_indicator                    :=	regexreplace('[^ -~]+', pInput.mail_care_of_name_indicator           , '');    
  self.	comments                                      :=	regexreplace('[^ -~]+', pInput.	comments                             , '');   
	self.	tape_cut_date                                 :=	regexreplace('[^ -~]+', pInput.	tape_cut_date                        , '');   
	self.	certification_date                            :=	regexreplace('[^ -~]+', pInput.	certification_date                   , '');   
	self.	edition_number                                :=	regexreplace('[^ -~]+', pInput.	edition_number                       , '');   
	self.	prop_addr_propagated_ind                      :=	regexreplace('[^ -~]+', pInput.	prop_addr_propagated_ind             , '');   

	self																	:=	pInput;
end;


export File_Assessment := project(File_Assessment_bitmap , tRemoveGarbageChars(LEFT));
