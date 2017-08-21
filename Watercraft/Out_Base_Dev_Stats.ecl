import watercraft,strata;

ds_main   := watercraft.File_Base_Main_Dev;
ds_cg     := watercraft.File_Base_Coastguard_Dev;
ds_search := watercraft.File_Base_Search_Dev;

rPopulationStats_ds_main
 :=
  record
    CountGroup := count(group);
    watercraft_key_CountNonBlank                                := sum(group,if(ds_main.watercraft_key<>'',1,0));
    sequence_key_CountNonBlank                                  := sum(group,if(ds_main.sequence_key<>'',1,0));
    watercraft_id_CountNonBlank                                 := sum(group,if(ds_main.watercraft_id<>'',1,0));
    ds_main.state_origin;
    ds_main.source_code;
    st_registration_CountNonBlank                               := sum(group,if(ds_main.st_registration<>'',1,0));
    county_registration_CountNonBlank                           := sum(group,if(ds_main.county_registration<>'',1,0));
    registration_number_CountNonBlank                           := sum(group,if(ds_main.registration_number<>'',1,0));
    hull_number_CountNonBlank                                   := sum(group,if(ds_main.hull_number<>'',1,0));
    propulsion_code_CountNonBlank                               := sum(group,if(ds_main.propulsion_code<>'',1,0));
    propulsion_description_CountNonBlank                        := sum(group,if(ds_main.propulsion_description<>'',1,0));
    vehicle_type_code_CountNonBlank                             := sum(group,if(ds_main.vehicle_type_code<>'',1,0));
    vehicle_type_description_CountNonBlank                      := sum(group,if(ds_main.vehicle_type_description<>'',1,0));
    fuel_code_CountNonBlank                                     := sum(group,if(ds_main.fuel_code<>'',1,0));
    fuel_description_CountNonBlank                              := sum(group,if(ds_main.fuel_description<>'',1,0));
    hull_type_code_CountNonBlank                                := sum(group,if(ds_main.hull_type_code<>'',1,0));
    hull_type_description_CountNonBlank                         := sum(group,if(ds_main.hull_type_description<>'',1,0));
    use_code_CountNonBlank                                      := sum(group,if(ds_main.use_code<>'',1,0));
    use_description_CountNonBlank                               := sum(group,if(ds_main.use_description<>'',1,0));
    model_year_CountNonBlank                                    := sum(group,if(ds_main.model_year<>'',1,0));
    watercraft_name_CountNonBlank                               := sum(group,if(ds_main.watercraft_name<>'',1,0));
    watercraft_class_code_CountNonBlank                         := sum(group,if(ds_main.watercraft_class_code<>'',1,0));
    watercraft_class_description_CountNonBlank                  := sum(group,if(ds_main.watercraft_class_description<>'',1,0));
    watercraft_make_code_CountNonBlank                          := sum(group,if(ds_main.watercraft_make_code<>'',1,0));
    watercraft_make_description_CountNonBlank                   := sum(group,if(ds_main.watercraft_make_description<>'',1,0));
    watercraft_model_code_CountNonBlank                         := sum(group,if(ds_main.watercraft_model_code<>'',1,0));
    watercraft_model_description_CountNonBlank                  := sum(group,if(ds_main.watercraft_model_description<>'',1,0));
    watercraft_length_CountNonBlank                             := sum(group,if(ds_main.watercraft_length<>'',1,0));
    watercraft_width_CountNonBlank                              := sum(group,if(ds_main.watercraft_width<>'',1,0));
    watercraft_weight_CountNonBlank                             := sum(group,if(ds_main.watercraft_weight<>'',1,0));
    watercraft_color_1_code_CountNonBlank                       := sum(group,if(ds_main.watercraft_color_1_code<>'',1,0));
    watercraft_color_1_description_CountNonBlank                := sum(group,if(ds_main.watercraft_color_1_description<>'',1,0));
    watercraft_color_2_code_CountNonBlank                       := sum(group,if(ds_main.watercraft_color_2_code<>'',1,0));
    watercraft_color_2_description_CountNonBlank                := sum(group,if(ds_main.watercraft_color_2_description<>'',1,0));
    watercraft_toilet_code_CountNonBlank                        := sum(group,if(ds_main.watercraft_toilet_code<>'',1,0));
    watercraft_toilet_description_CountNonBlank                 := sum(group,if(ds_main.watercraft_toilet_description<>'',1,0));
    watercraft_number_of_engines_CountNonBlank                  := sum(group,if(ds_main.watercraft_number_of_engines<>'',1,0));
    watercraft_hp_1_CountNonBlank                               := sum(group,if(ds_main.watercraft_hp_1<>'',1,0));
    watercraft_hp_2_CountNonBlank                               := sum(group,if(ds_main.watercraft_hp_2<>'',1,0));
    watercraft_hp_3_CountNonBlank                               := sum(group,if(ds_main.watercraft_hp_3<>'',1,0));
    engine_number_1_CountNonBlank                               := sum(group,if(ds_main.engine_number_1<>'',1,0));
    engine_number_2_CountNonBlank                               := sum(group,if(ds_main.engine_number_2<>'',1,0));
    engine_number_3_CountNonBlank                               := sum(group,if(ds_main.engine_number_3<>'',1,0));
    engine_make_1_CountNonBlank                                 := sum(group,if(ds_main.engine_make_1<>'',1,0));
    engine_make_2_CountNonBlank                                 := sum(group,if(ds_main.engine_make_2<>'',1,0));
    engine_make_3_CountNonBlank                                 := sum(group,if(ds_main.engine_make_3<>'',1,0));
    engine_model_1_CountNonBlank                                := sum(group,if(ds_main.engine_model_1<>'',1,0));
    engine_model_2_CountNonBlank                                := sum(group,if(ds_main.engine_model_2<>'',1,0));
    engine_model_3_CountNonBlank                                := sum(group,if(ds_main.engine_model_3<>'',1,0));
    engine_year_1_CountNonBlank                                 := sum(group,if(ds_main.engine_year_1<>'',1,0));
    engine_year_2_CountNonBlank                                 := sum(group,if(ds_main.engine_year_2<>'',1,0));
    engine_year_3_CountNonBlank                                 := sum(group,if(ds_main.engine_year_3<>'',1,0));
    coast_guard_documented_flag_CountNonBlank                   := sum(group,if(ds_main.coast_guard_documented_flag<>'',1,0));
    coast_guard_number_CountNonBlank                            := sum(group,if(ds_main.coast_guard_number<>'',1,0));
    registration_date_CountNonBlank                             := sum(group,if(ds_main.registration_date<>'',1,0));
    registration_expiration_date_CountNonBlank                  := sum(group,if(ds_main.registration_expiration_date<>'',1,0));
    registration_status_code_CountNonBlank                      := sum(group,if(ds_main.registration_status_code<>'',1,0));
    registration_status_description_CountNonBlank               := sum(group,if(ds_main.registration_status_description<>'',1,0));
    registration_status_date_CountNonBlank                      := sum(group,if(ds_main.registration_status_date<>'',1,0));
    registration_renewal_date_CountNonBlank                     := sum(group,if(ds_main.registration_renewal_date<>'',1,0));
    decal_number_CountNonBlank                                  := sum(group,if(ds_main.decal_number<>'',1,0));
    transaction_type_code_CountNonBlank                         := sum(group,if(ds_main.transaction_type_code<>'',1,0));
    transaction_type_description_CountNonBlank                  := sum(group,if(ds_main.transaction_type_description<>'',1,0));
    title_state_CountNonBlank                                   := sum(group,if(ds_main.title_state<>'',1,0));
    title_status_code_CountNonBlank                             := sum(group,if(ds_main.title_status_code<>'',1,0));
    title_status_description_CountNonBlank                      := sum(group,if(ds_main.title_status_description<>'',1,0));
    title_number_CountNonBlank                                  := sum(group,if(ds_main.title_number<>'',1,0));
    title_issue_date_CountNonBlank                              := sum(group,if(ds_main.title_issue_date<>'',1,0));
    title_type_code_CountNonBlank                               := sum(group,if(ds_main.title_type_code<>'',1,0));
    title_type_description_CountNonBlank                        := sum(group,if(ds_main.title_type_description<>'',1,0));
    additional_owner_count_CountNonBlank                        := sum(group,if(ds_main.additional_owner_count<>'',1,0));
    lien_1_indicator_CountNonBlank                              := sum(group,if(ds_main.lien_1_indicator<>'',1,0));
    lien_1_name_CountNonBlank                                   := sum(group,if(ds_main.lien_1_name<>'',1,0));
    lien_1_date_CountNonBlank                                   := sum(group,if(ds_main.lien_1_date<>'',1,0));
    lien_1_address_1_CountNonBlank                              := sum(group,if(ds_main.lien_1_address_1<>'',1,0));
    lien_1_address_2_CountNonBlank                              := sum(group,if(ds_main.lien_1_address_2<>'',1,0));
    lien_1_city_CountNonBlank                                   := sum(group,if(ds_main.lien_1_city<>'',1,0));
    lien_1_state_CountNonBlank                                  := sum(group,if(ds_main.lien_1_state<>'',1,0));
    lien_1_zip_CountNonBlank                                    := sum(group,if(ds_main.lien_1_zip<>'',1,0));
    lien_2_indicator_CountNonBlank                              := sum(group,if(ds_main.lien_2_indicator<>'',1,0));
    lien_2_name_CountNonBlank                                   := sum(group,if(ds_main.lien_2_name<>'',1,0));
    lien_2_date_CountNonBlank                                   := sum(group,if(ds_main.lien_2_date<>'',1,0));
    lien_2_address_1_CountNonBlank                              := sum(group,if(ds_main.lien_2_address_1<>'',1,0));
    lien_2_address_2_CountNonBlank                              := sum(group,if(ds_main.lien_2_address_2<>'',1,0));
    lien_2_city_CountNonBlank                                   := sum(group,if(ds_main.lien_2_city<>'',1,0));
    lien_2_state_CountNonBlank                                  := sum(group,if(ds_main.lien_2_state<>'',1,0));
    lien_2_zip_CountNonBlank                                    := sum(group,if(ds_main.lien_2_zip<>'',1,0));
    state_purchased_CountNonBlank                               := sum(group,if(ds_main.state_purchased<>'',1,0));
    purchase_date_CountNonBlank                                 := sum(group,if(ds_main.purchase_date<>'',1,0));
    dealer_CountNonBlank                                        := sum(group,if(ds_main.dealer<>'',1,0));
    purchase_price_CountNonBlank                                := sum(group,if(ds_main.purchase_price<>'',1,0));
    new_used_flag_CountNonBlank                                 := sum(group,if(ds_main.new_used_flag<>'',1,0));
    watercraft_status_code_CountNonBlank                        := sum(group,if(ds_main.watercraft_status_code<>'',1,0));
    watercraft_status_description_CountNonBlank                 := sum(group,if(ds_main.watercraft_status_description<>'',1,0));
    history_flag_CountNonBlank                                  := sum(group,if(ds_main.history_flag<>'',1,0));
    coastguard_flag_CountNonBlank                               := sum(group,if(ds_main.coastguard_flag<>'',1,0));
end;

rPopulationStats_ds_cg
 :=
  record
    CountGroup := count(group);
    watercraft_key_CountNonBlank                                                     := sum(group,if(ds_cg.watercraft_key<>'',1,0));
    sequence_key_CountNonBlank                                                       := sum(group,if(ds_cg.sequence_key<>'',1,0));
    ds_cg.state_origin;
    ds_cg.source_code;
    vessel_id_CountNonBlank                                                          := sum(group,if(ds_cg.vessel_id<>'',1,0));
    vessel_database_key_CountNonBlank                                                := sum(group,if(ds_cg.vessel_database_key<>'',1,0));
    name_of_vessel_CountNonBlank                                                     := sum(group,if(ds_cg.name_of_vessel<>'',1,0));
    call_sign_CountNonBlank                                                          := sum(group,if(ds_cg.call_sign<>'',1,0));
    official_number_CountNonBlank                                                    := sum(group,if(ds_cg.official_number<>'',1,0));
    imo_number_CountNonBlank                                                         := sum(group,if(ds_cg.imo_number<>'',1,0));
    hull_number_CountNonBlank                                                        := sum(group,if(ds_cg.hull_number<>'',1,0));
    hull_identification_number_CountNonBlank                                         := sum(group,if(ds_cg.hull_identification_number<>'',1,0));
    vessel_service_type_CountNonBlank                                                := sum(group,if(ds_cg.vessel_service_type<>'',1,0));
    flag_CountNonBlank                                                               := sum(group,if(ds_cg.flag<>'',1,0));
    self_propelled_indicator_CountNonBlank                                           := sum(group,if(ds_cg.self_propelled_indicator<>'',1,0));
    registered_gross_tons_CountNonBlank                                              := sum(group,if(ds_cg.registered_gross_tons<>'',1,0));
    registered_net_tons_CountNonBlank                                                := sum(group,if(ds_cg.registered_net_tons<>'',1,0));
    registered_length_CountNonBlank                                                  := sum(group,if(ds_cg.registered_length<>'',1,0));
    registered_breadth_CountNonBlank                                                 := sum(group,if(ds_cg.registered_breadth<>'',1,0));
    registered_depth_CountNonBlank                                                   := sum(group,if(ds_cg.registered_depth<>'',1,0));
    itc_gross_tons_CountNonBlank                                                     := sum(group,if(ds_cg.itc_gross_tons<>'',1,0));
    itc_net_tons_CountNonBlank                                                       := sum(group,if(ds_cg.itc_net_tons<>'',1,0));
    itc_length_CountNonBlank                                                         := sum(group,if(ds_cg.itc_length<>'',1,0));
    itc_breadth_CountNonBlank                                                        := sum(group,if(ds_cg.itc_breadth<>'',1,0));
    itc_depth_CountNonBlank                                                          := sum(group,if(ds_cg.itc_depth<>'',1,0));
    hailing_port_CountNonBlank                                                       := sum(group,if(ds_cg.hailing_port<>'',1,0));
    hailing_port_state_CountNonBlank                                                 := sum(group,if(ds_cg.hailing_port_state<>'',1,0));
    hailing_port_province_CountNonBlank                                              := sum(group,if(ds_cg.hailing_port_province<>'',1,0));
    home_port_name_CountNonBlank                                                     := sum(group,if(ds_cg.home_port_name<>'',1,0));
    home_port_state_CountNonBlank                                                    := sum(group,if(ds_cg.home_port_state<>'',1,0));
    home_port_province_CountNonBlank                                                 := sum(group,if(ds_cg.home_port_province<>'',1,0));
    trade_ind_coastwise_unrestricted_CountNonBlank                                   := sum(group,if(ds_cg.trade_ind_coastwise_unrestricted<>'',1,0));
    trade_ind_limited_coastwise_bowaters_only_CountNonBlank                          := sum(group,if(ds_cg.trade_ind_limited_coastwise_bowaters_only<>'',1,0));
    trade_ind_limited_coastwise_restricted_CountNonBlank                             := sum(group,if(ds_cg.trade_ind_limited_coastwise_restricted<>'',1,0));
    trade_ind_limited_coastwise_oil_spill_response_only_CountNonBlank                := sum(group,if(ds_cg.trade_ind_limited_coastwise_oil_spill_response_only<>'',1,0));
    trade_ind_limited_coastwise_under_charter_to_citizen_CountNonBlank               := sum(group,if(ds_cg.trade_ind_limited_coastwise_under_charter_to_citizen<>'',1,0));
    trade_ind_fishery_CountNonBlank                                                  := sum(group,if(ds_cg.trade_ind_fishery<>'',1,0));
    trade_ind_limited_fishery_only_CountNonBlank                                     := sum(group,if(ds_cg.trade_ind_limited_fishery_only<>'',1,0));
    trade_ind_recreation_CountNonBlank                                               := sum(group,if(ds_cg.trade_ind_recreation<>'',1,0));
    trade_ind_limited_recreation_great_lakes_use_only_CountNonBlank                  := sum(group,if(ds_cg.trade_ind_limited_recreation_great_lakes_use_only<>'',1,0));
    trade_ind_registry_CountNonBlank                                                 := sum(group,if(ds_cg.trade_ind_registry<>'',1,0));
    trade_ind_limited_registry_cross_border_financing_CountNonBlank                  := sum(group,if(ds_cg.trade_ind_limited_registry_cross_border_financing<>'',1,0));
    trade_ind_limited_registry_no_foreign_voyage_CountNonBlank                       := sum(group,if(ds_cg.trade_ind_limited_registry_no_foreign_voyage<>'',1,0));
    trade_ind_limited_registry_trade_with_canada_only_CountNonBlank                  := sum(group,if(ds_cg.trade_ind_limited_registry_trade_with_canada_only<>'',1,0));
    trade_ind_great_lakes_CountNonBlank                                              := sum(group,if(ds_cg.trade_ind_great_lakes<>'',1,0));
    vessel_complete_build_city_CountNonBlank                                         := sum(group,if(ds_cg.vessel_complete_build_city<>'',1,0));
    vessel_complete_build_state_CountNonBlank                                        := sum(group,if(ds_cg.vessel_complete_build_state<>'',1,0));
    vessel_complete_build_province_CountNonBlank                                     := sum(group,if(ds_cg.vessel_complete_build_province<>'',1,0));
    vessel_complete_build_country_CountNonBlank                                      := sum(group,if(ds_cg.vessel_complete_build_country<>'',1,0));
    vessel_build_year_CountNonBlank                                                  := sum(group,if(ds_cg.vessel_build_year<>'',1,0));
    vessel_hull_build_city_CountNonBlank                                             := sum(group,if(ds_cg.vessel_hull_build_city<>'',1,0));
    vessel_hull_build_state_CountNonBlank                                            := sum(group,if(ds_cg.vessel_hull_build_state<>'',1,0));
    vessel_hull_build_province_CountNonBlank                                         := sum(group,if(ds_cg.vessel_hull_build_province<>'',1,0));
    vessel_hull_build_country_CountNonBlank                                          := sum(group,if(ds_cg.vessel_hull_build_country<>'',1,0));
    party_identification_number_CountNonBlank                                        := sum(group,if(ds_cg.party_identification_number<>'',1,0));
    main_hp_ahead_CountNonBlank                                                      := sum(group,if(ds_cg.main_hp_ahead<>'',1,0));
    main_hp_astern_CountNonBlank                                                     := sum(group,if(ds_cg.main_hp_astern<>'',1,0));
    propulsion_type_CountNonBlank                                                    := sum(group,if(ds_cg.propulsion_type<>'',1,0));
    hull_material_CountNonBlank                                                      := sum(group,if(ds_cg.hull_material<>'',1,0));
    ship_yard_CountNonBlank                                                          := sum(group,if(ds_cg.ship_yard<>'',1,0));
    hull_builder_name_CountNonBlank                                                  := sum(group,if(ds_cg.hull_builder_name<>'',1,0));
    doc_certificate_status_CountNonBlank                                             := sum(group,if(ds_cg.doc_certificate_status<>'',1,0));
    date_issued_CountNonBlank                                                        := sum(group,if(ds_cg.date_issued<>'',1,0));
    date_expires_CountNonBlank                                                       := sum(group,if(ds_cg.date_expires<>'',1,0));
    hull_design_type_CountNonBlank                                                   := sum(group,if(ds_cg.hull_design_type<>'',1,0));
    sail_ind_CountNonBlank                                                           := sum(group,if(ds_cg.sail_ind<>'',1,0));
    party_database_key_CountNonBlank                                                 := sum(group,if(ds_cg.party_database_key<>'',1,0));
    itc_tons_cod_ind_CountNonBlank                                                   := sum(group,if(ds_cg.itc_tons_cod_ind<>'',1,0));
end;

rPopulationStats_ds_search
 :=
  record
    CountGroup := count(group);
    date_first_seen_CountNonBlank                          := sum(group,if(ds_search.date_first_seen<>'',1,0));
    date_last_seen_CountNonBlank                           := sum(group,if(ds_search.date_last_seen<>'',1,0));
    date_vendor_first_reported_CountNonBlank               := sum(group,if(ds_search.date_vendor_first_reported<>'',1,0));
    date_vendor_last_reported_CountNonBlank                := sum(group,if(ds_search.date_vendor_last_reported<>'',1,0));
    watercraft_key_CountNonBlank                           := sum(group,if(ds_search.watercraft_key<>'',1,0));
    sequence_key_CountNonBlank                             := sum(group,if(ds_search.sequence_key<>'',1,0));
    ds_search.state_origin;
    ds_search.source_code;
    dppa_flag_CountNonBlank                                := sum(group,if(ds_search.dppa_flag<>'',1,0));
    orig_name_CountNonBlank                                := sum(group,if(ds_search.orig_name<>'',1,0));
    orig_name_type_code_CountNonBlank                      := sum(group,if(ds_search.orig_name_type_code<>'',1,0));
    orig_name_type_description_CountNonBlank               := sum(group,if(ds_search.orig_name_type_description<>'',1,0));
    orig_name_first_CountNonBlank                          := sum(group,if(ds_search.orig_name_first<>'',1,0));
    orig_name_middle_CountNonBlank                         := sum(group,if(ds_search.orig_name_middle<>'',1,0));
    orig_name_last_CountNonBlank                           := sum(group,if(ds_search.orig_name_last<>'',1,0));
    orig_name_suffix_CountNonBlank                         := sum(group,if(ds_search.orig_name_suffix<>'',1,0));
    orig_address_1_CountNonBlank                           := sum(group,if(ds_search.orig_address_1<>'',1,0));
    orig_address_2_CountNonBlank                           := sum(group,if(ds_search.orig_address_2<>'',1,0));
    orig_city_CountNonBlank                                := sum(group,if(ds_search.orig_city<>'',1,0));
    orig_state_CountNonBlank                               := sum(group,if(ds_search.orig_state<>'',1,0));
    orig_zip_CountNonBlank                                 := sum(group,if(ds_search.orig_zip<>'',1,0));
    orig_fips_CountNonBlank                                := sum(group,if(ds_search.orig_fips<>'',1,0));
    dob_CountNonBlank                                      := sum(group,if(ds_search.dob<>'',1,0));
    orig_ssn_CountNonBlank                                 := sum(group,if(ds_search.orig_ssn<>'',1,0));
    orig_fein_CountNonBlank                                := sum(group,if(ds_search.orig_fein<>'',1,0));
    gender_CountNonBlank                                   := sum(group,if(ds_search.gender<>'',1,0));
    phone_1_CountNonBlank                                  := sum(group,if(ds_search.phone_1<>'',1,0));
    phone_2_CountNonBlank                                  := sum(group,if(ds_search.phone_2<>'',1,0));
    title_CountNonBlank                                    := sum(group,if(ds_search.title<>'',1,0));
    fname_CountNonBlank                                    := sum(group,if(ds_search.fname<>'',1,0));
    mname_CountNonBlank                                    := sum(group,if(ds_search.mname<>'',1,0));
    lname_CountNonBlank                                    := sum(group,if(ds_search.lname<>'',1,0));
    name_suffix_CountNonBlank                              := sum(group,if(ds_search.name_suffix<>'',1,0));
    name_cleaning_score_CountNonBlank                      := sum(group,if(ds_search.name_cleaning_score<>'',1,0));
    company_name_CountNonBlank                             := sum(group,if(ds_search.company_name<>'',1,0));
    prim_range_CountNonBlank                               := sum(group,if(ds_search.prim_range<>'',1,0));
    predir_CountNonBlank                                   := sum(group,if(ds_search.predir<>'',1,0));
    prim_name_CountNonBlank                                := sum(group,if(ds_search.prim_name<>'',1,0));
    suffix_CountNonBlank                                   := sum(group,if(ds_search.suffix<>'',1,0));
    postdir_CountNonBlank                                  := sum(group,if(ds_search.postdir<>'',1,0));
    unit_desig_CountNonBlank                               := sum(group,if(ds_search.unit_desig<>'',1,0));
    sec_range_CountNonBlank                                := sum(group,if(ds_search.sec_range<>'',1,0));
    p_city_name_CountNonBlank                              := sum(group,if(ds_search.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                              := sum(group,if(ds_search.v_city_name<>'',1,0));
    st_CountNonBlank                                       := sum(group,if(ds_search.st<>'',1,0));
    zip5_CountNonBlank                                     := sum(group,if(ds_search.zip5<>'',1,0));
    zip4_CountNonBlank                                     := sum(group,if(ds_search.zip4<>'',1,0));
    county_CountNonBlank                                   := sum(group,if(ds_search.county<>'',1,0));
    cart_CountNonBlank                                     := sum(group,if(ds_search.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                               := sum(group,if(ds_search.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                                      := sum(group,if(ds_search.lot<>'',1,0));
    lot_order_CountNonBlank                                := sum(group,if(ds_search.lot_order<>'',1,0));
    dpbc_CountNonBlank                                     := sum(group,if(ds_search.dpbc<>'',1,0));
    chk_digit_CountNonBlank                                := sum(group,if(ds_search.chk_digit<>'',1,0));
    rec_type_CountNonBlank                                 := sum(group,if(ds_search.rec_type<>'',1,0));
    ace_fips_st_CountNonBlank                              := sum(group,if(ds_search.ace_fips_st<>'',1,0));
    ace_fips_county_CountNonBlank                          := sum(group,if(ds_search.ace_fips_county<>'',1,0));
    geo_lat_CountNonBlank                                  := sum(group,if(ds_search.geo_lat<>'',1,0));
    geo_long_CountNonBlank                                 := sum(group,if(ds_search.geo_long<>'',1,0));
    msa_CountNonBlank                                      := sum(group,if(ds_search.msa<>'',1,0));
    geo_blk_CountNonBlank                                  := sum(group,if(ds_search.geo_blk<>'',1,0));
    geo_match_CountNonBlank                                := sum(group,if(ds_search.geo_match<>'',1,0));
    err_stat_CountNonBlank                                 := sum(group,if(ds_search.err_stat<>'',1,0));
    bdid_CountNonBlank                                     := sum(group,if(ds_search.bdid<>'',1,0));
    fein_CountNonBlank                                     := sum(group,if(ds_search.fein<>'',1,0));
    did_CountNonBlank                                      := sum(group,if(ds_search.did<>'',1,0));
    did_score_CountNonBlank                                := sum(group,if(ds_search.did_score<>'',1,0));
    ssn_CountNonBlank                                      := sum(group,if(ds_search.ssn<>'',1,0));
    history_flag_CountNonBlank                             := sum(group,if(ds_search.history_flag<>'',1,0));
			//BIPV2 fields have been added for Strata
    source_rec_id_CountNonZeros	           								 := sum(group,if(ds_search.source_rec_id<>0,1,0));
    DotID_CountNonZeros	                 									 := sum(group,if(ds_search.DotID<>0,1,0));
    DotScore_CountNonZeros	               								 := sum(group,if(ds_search.DotScore<>0,1,0));
    DotWeight_CountNonZeros	             								 	 := sum(group,if(ds_search.DotWeight<>0,1,0));
    EmpID_CountNonZeros	                   							   := sum(group,if(ds_search.EmpID<>0,1,0));
    EmpScore_CountNonZeros	             									 := sum(group,if(ds_search.EmpScore<>0,1,0));
    EmpWeight_CountNonZeros	                 							 := sum(group,if(ds_search.EmpWeight<>0,1,0));
    POWID_CountNonZeros	                          			   := sum(group,if(ds_search.POWID<>0,1,0));
    POWScore_CountNonZeros	                      			   := sum(group,if(ds_search.POWScore<>0,1,0));
    POWWeight_CountNonZeros	                      			   := sum(group,if(ds_search.POWWeight<>0,1,0));
    ProxID_CountNonZeros	                        			   := sum(group,if(ds_search.ProxID<>0,1,0));
    ProxScore_CountNonZeros	                      			   := sum(group,if(ds_search.ProxScore<>0,1,0));
    ProxWeight_CountNonZeros	                             := sum(group,if(ds_search.ProxWeight<>0,1,0));
    SELEID_CountNonZeros	                                 := sum(group,if(ds_search.SELEID<>0,1,0));
		SELEScore_CountNonZeros	                               := sum(group,if(ds_search.SELEScore<>0,1,0));
		SELEWeight_CountNonZeros	                             := sum(group,if(ds_search.SELEWeight<>0,1,0));
    OrgID_CountNonZeros	                          			   := sum(group,if(ds_search.OrgID<>0,1,0));
    OrgScore_CountNonZeros	                      			   := sum(group,if(ds_search.OrgScore<>0,1,0));
    OrgWeight_CountNonZeros	                      			   := sum(group,if(ds_search.OrgWeight<>0,1,0));
    UltID_CountNonZeros	                          			   := sum(group,if(ds_search.UltID<>0,1,0));
    UltScore_CountNonZeros	                      			   := sum(group,if(ds_search.UltScore<>0,1,0));
    UltWeight_CountNonZeros	                      			   := sum(group,if(ds_search.UltWeight<>0,1,0));
    
end;
  
tStats_main   := table(ds_main,  rPopulationStats_ds_main,  state_origin,source_code,few);
tStats_cg     := table(ds_cg,    rPopulationStats_ds_cg,    state_origin,source_code,few);
tStats_search := table(ds_search,rPopulationStats_ds_search,state_origin,source_code,few);

zOrig_Stats_main   :=     output(choosen(tStats_main,  all));
zOrig_Stats_cg     :=     output(choosen(tStats_cg,    all));
zOrig_Stats_search :=     output(choosen(tStats_search,all));

STRATA.createXMLStats(tStats_main,  'Watercraft','Main',      watercraft.Version_Development,'jtao@seisint.com',zPopulation_Stats_main,  'View','Population')
STRATA.createXMLStats(tStats_cg,    'Watercraft','CoastGuard',watercraft.Version_Development,'jtao@seisint.com',zPopulation_Stats_cg,    'View','Population')
STRATA.createXMLStats(tStats_search,'Watercraft','SearchFile',watercraft.Version_Development,'jtao@seisint.com',zPopulation_Stats_search,'View','Population')

STRATA.createAsHeaderStats(watercraft.Watercraft_as_Header(watercraft.File_Base_Search_Dev,watercraft.File_Base_Main_Dev),'Watercraft','Data',watercraft.Version_Development,'jtao@seisint.com',zAs_Header_Stats)
STRATA.CreateAsBusinessHeaderStats(watercraft.fWatercraft_as_Business_Header(watercraft.File_Base_Search_Dev),'Watercraft','Data',watercraft.Version_Development,'jtao@seisint.com',zRunAsBusinessHeaderStats)

export Out_Base_Dev_Stats := parallel(zOrig_Stats_main
                                      ,zOrig_Stats_cg
																			,zOrig_Stats_search
																			,zPopulation_Stats_main
																			,zPopulation_Stats_cg
																			,zPopulation_Stats_search
																			,zAs_Header_Stats
																			,zRunAsBusinessHeaderStats
																			);