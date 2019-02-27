IMPORT strata, Overrides, FCRA;

EXPORT Verify_Deprecated_Keys := FUNCTION

  RETURN PARALLEL(
  
     // DF- - Show counts of blanked out fields in thor_data400::key::override::fcra::thrive::qa::ffid
     OUTPUT(strata.macf_pops(Overrides.Keys.Thrive,,,,,,FALSE,['phone_work','phone_home','phone_cell',
                              'monthsemployed','own_home','is_military','drvlic_state','monthsatbank','ip','yrsthere','besttime',
                              'credit','loanamt','loantype','ratetype','mortrate','ltv','propertytype','datecollected','title',
                              'fips_st','fips_county','clean_phone_work','clean_phone_home','clean_phone_cell']))
                              
     // DF- - Show counts of blanked out fields in thor_data400::key::override::fcra::paw::qa::ffid
    ,OUTPUT(strata.macf_pops(Overrides.Keys.paw,,,,,,FALSE,['company_department','company_fein','dead_flag',
                              'dppa_state','title']))
                                                      
     // DF- - Show counts of blanked out fields in thor_data400::key::override::fcra::hunting_fishing::qa::ffid
    ,OUTPUT(strata.macf_pops(Overrides.Keys.hunting_fishing,,,,,,FALSE,
                        ['ace_fips_st', 'active_other', 'active_status', 'agecat', 'antelope', 'anterless', 'archery', 'bear'
                         ,'biggame', 'bighorn', 'blind', 'bonus', 'buffalo', 'combosuper', 'cougar', 'crewmemeber'
                         ,'day1', 'day14to15', 'day3', 'day7', 'dayfiller', 'deer', 'disabled', 'drawing'
                         ,'duck', 'elk', 'fallfishing', 'family', 'fish', 'freshwater', 'goose', 'gun'
                         ,'headhousehold', 'historyfiller', 'hunt', 'huntfill1', 'huntfiller', 'indian', 'javelina', 'junior'
                         ,'lakesandresevoirs', 'landowner', 'lifetimepermit', 'lottery', 'lowincome', 'maiden_name', 'maiden_prior', 'mail_ace_fips_st'
                         ,'mail_ace_zip', 'mail_addr_suffix', 'mail_addr1', 'mail_addr2', 'mail_cart', 'mail_chk_digit', 'mail_city'
                         ,'mail_county', 'mail_cr_sort_sz', 'mail_dpbc', 'mail_err_stat', 'mail_fipscounty', 'mail_geo_blk', 'mail_geo_lat'
                         ,'mail_geo_long', 'mail_geo_match', 'mail_lot', 'mail_lot_order', 'mail_msa', 'mail_p_city_name', 'mail_postdir'
                         ,'mail_predir', 'mail_prim_name', 'mail_prim_range', 'mail_record_type', 'mail_sec_range', 'mail_st', 'mail_state'
                         ,'mail_unit_desig', 'mail_v_city_name', 'mail_zip', 'mail_zip4', 'migbird', 'moose', 'motorvoterid'
                         ,'muzzle', 'nonresident', 'occupation', 'other_phone', 'otherbirds', 'pheasant', 'phone', 'place_of_birth'
                         ,'poliparty', 'race', 'record_type', 'regdate', 'regioncounty', 'regsource', 'res_county', 'resident'
                         ,'retarded', 'salmon', 'saltwater', 'seasonannual', 'seniorcit', 'serviceman', 'setlinefish', 'shellfishcrab'
                         ,'shellfishlobster', 'sikebull', 'skipass', 'smallgame', 'snowmobile', 'source_voterid', 'sportsman', 'steelhead'
                         ,'sturgeon', 'sturgeon2', 'trap', 'trout', 'turkey', 'votefiller', 'votefiller2', 'voterstatus'
                         ,'whitejubherring', 'work_phone'])) 

		 //ADVO -show counts of blanked out fields in thor_data400::key::override::fcra::advo::qa::ffid
		 ,OUTPUT(strata.macf_pops(FCRA.Key_Override_ADVO_ffid,,,,,,FALSE,
															['college_end_suppression_date','college_start_suppression_date', 
															 'seasonal_end_suppression_date','seasonal_start_suppression_date']),named('override_advo_deprecation_stats'))
		 //Alloy Student
		 ,OUTPUT(strata.macf_pops(FCRA.key_Override_Alloy_FFID,,,,,,FALSE,
															['address_info_code','clean_fips_county','clean_phone_number','clean_title',
															 'clean_v_city_name','gender_code','home_housing_code','home_info_time_zone',
															 'home_phone_number','intl_exchange_student_code','key_code','school_address_1_primary',
															 'school_address_2_secondary','school_city','school_housing_code',
															 'school_info_time_zone','school_phone_number','school_state','school_zip4',
															 'school_zip5']),named('override_alloystudent_deprecation_stats'))

		 //AVM - Show counts of blanked out fields in thor_data400::key::override::fcra::avm::qa::ffid
		 ,OUTPUT(strata.macf_pops(FCRA.Key_Override_AVM_FFID,,,,,,FALSE,['fips_code']),named('override_avm_ffid_deprecation_stats'))

		 //Bankruptcy- show counts of blanked out fields in thor_data400::key::override::fcra::bankrupt_filing::qa::ffid_v3
		 ,OUTPUT(strata.macf_pops(FCRA.key_override_bkv3_main_ffid,,,,,,FALSE,
															['assets','complaint_deadline','confheardate','datereclosed',
															 'liabilities','planconfdate']),named('override_bankrupt_filing_deprecation_stats'))
		 //Show counts of blanked out fields in thor_data400::key::override::fcra::bankrupt_search::qa::ffid_v3
		 ,OUTPUT(strata.macf_pops(FCRA.key_override_bkv3_search_ffid,,,,,,FALSE,
															['delete_flag','holdcase','tax_id']),named('override_bankrupt_search_deprecation_stats'))

		 //Crim
		 //Show counts of blanked out fields in thor_data400::key::override::fcra::crim::qa::activity
		 ,OUTPUT(strata.macf_pops(FCRA.key_override_crim.activity,,,,,,FALSE,
															['off_comp']),named('override_crim_activity_deprecation_stats'))
		 //Show counts of blanked out fields in thor_data400::key::override::fcra::crim::qa::courtoffenses
		 ,OUTPUT(strata.macf_pops(FCRA.key_override_crim.court_offenses,,,,,,FALSE,
															['appeal_date','appeal_final_decision','appeal_off_disp','arr_date','arr_disp_code',
															 'arr_disp_date','arr_disp_desc_1','arr_disp_desc_2','arr_off_code','arr_off_desc_1',
															 'arr_off_desc_2','arr_off_lev','arr_off_lev_mapped','arr_off_type_cd',
															 'arr_off_type_desc','arr_statute','arr_statute_desc','community_service',
															 'court_additional_statutes','court_appeal_flag','court_cd','court_county',
															 'court_disp_code','court_dt','court_off_desc_2','court_off_type_cd',
															 'court_off_type_desc','court_statute_desc','le_agency_cd','off_comp','off_delete_flag',
															 'probation_desc2','pros_act_filed','pros_assgn','pros_assgn_cd','pros_chg_rej',
															 'pros_off_code','pros_off_desc_1','pros_off_desc_2','pros_off_lev','pros_off_type_cd',
															 'pros_off_type_desc','pros_refer','pros_refer_cd','restitution','sent_addl_prov_code',
															 'sent_addl_prov_desc_1','sent_addl_prov_desc_2','sent_agency_rec_cust',
															 'sent_agency_rec_cust_ori','sent_consec','sent_court_cost','sent_date',
															 'sent_susp_court_fine','sent_susp_time','traffic_dl_no','traffic_dl_st',
															 'traffic_ticket_number']),named('override_crim_courtoffenses_deprecation_stats'))
		 //Show counts of blanked out fields in thor_data400::key::override::fcra::crim::qa::offenders
		 ,OUTPUT(strata.macf_pops(FCRA.key_override_crim.offenders,,,,,,FALSE,
															['_3g_offender','ace_fips_county','ace_fips_st','age','case_type','citizenship',
															 'clean_errors','county_of_birth','current_residence_county','dle_num','dob_alias',
															 'eye_color','fbi_num','hair_color','height','image_link','ins_num',
															 'legal_residence_county','party_status','place_of_birth','race','record_setup_date',
															 'record_type','scars_marks_tattoos_1','scars_marks_tattoos_2','scars_marks_tattoos_3',
															 'scars_marks_tattoos_4','scars_marks_tattoos_5','sex_offender','skin_color',
															 'street_address_3','street_address_4','street_address_5','violent_offender',
															 'vop_offender','weight','']),named('override_crim_offenders_deprecation_stats'))
		 //Show counts of blanked out fields in thor_data400::key::override::fcra::crim::qa::offenders_plus
		 ,OUTPUT(strata.macf_pops(FCRA.key_override_crim.offenders_plus,,,,,,FALSE,
															['_3g_offender','ace_fips_county','ace_fips_st','age','case_type','citizenship',
															 'clean_errors','county_of_birth','current_residence_county','dle_num','dob_alias',
															 'eye_color','fbi_num','hair_color','height','image_link','ins_num',
															 'legal_residence_county','party_status','place_of_birth','race','record_setup_date',
															 'record_type','scars_marks_tattoos_1','scars_marks_tattoos_2','scars_marks_tattoos_3',
															 'scars_marks_tattoos_4','scars_marks_tattoos_5','sex_offender','skin_color',
															 'street_address_3','street_address_4','street_address_5','violent_offender',
															 'vop_offender','weight','']),named('override_crim_offenders_plus_deprecation_stats'))
		 //Show counts of blanked out fields in thor_data400::key::override::fcra::crim::qa::offenses
		 ,OUTPUT(strata.macf_pops(FCRA.key_override_crim.offenses,,,,,,FALSE,
															['add_off_cd','add_off_desc','adj_wthd','arr_date','arr_disp_cd','arr_disp_date',
															 'arr_disp_desc_1','arr_disp_desc_2','arr_disp_desc_3','chg','chg_typ_flg','court_cd',
															 'court_county','ct_addl_desc_cd','ct_chg','ct_chg_typ_flg','ct_disp_cd','ct_disp_desc_2',
															 'ct_disp_dt','ct_dist','ct_fnl_plea','ct_fnl_plea_cd','ct_off_code','ct_off_desc_1',
															 'ct_off_desc_2','cty_conv_cd','off_of_record','record_type','stc_cd','stc_comp',
															 'stc_desc_3','stc_desc_4','total_num_of_offenses']),named('override_crim_offenses_deprecation_stats'))
		 //Show counts of blanked out fields in thor_data400::key::override::fcra::crim::qa::punishment
		 ,OUTPUT(strata.macf_pops(FCRA.key_override_crim.punishment,,,,,,FALSE,
															['casepull_date','ctl_rel_dt','cur_loc_inm_cd','cur_loc_sec','cur_sec_class_dt',
															 'cur_stat_inm','gain_time','gain_time_eff_dt','inm_com_cty','inm_com_cty_cd',
															 'mutl_part_pgm_dt','office_phone','office_region','par_cty_cd','par_cur_stat',
															 'par_sch_end_dt','par_status_dt','parole_active_flag','presump_par_rel_dt',
															 'prison_status','record_type','recv_dept_code','recv_dept_date','release_type',
															 'sent_date','supv_office','supv_officer','tdcjid_admit_date','tdcjid_unit_assigned',
															 'tdcjid_unit_type']),named('override_crim_punishment_deprecation_stats'))

		 //Death Master - show counts of blanked out fields in thor_data400::key::override::fcra::did_death::qa::ffid
		 ,OUTPUT(strata.macf_pops(FCRA.key_override_death_master.did_death,,,,,,FALSE,
															['st_country_code','zip_lastpayment']),named('override_deathmaster_did_deprecation_stats'))

		 //Email_data - show counts of blanked out fields in thor_200::key::email_data::fcra::qa::did
		 ,OUTPUT(strata.macf_pops(FCRA.Key_Override_Email_Data_ffid,,,,,,FALSE,['orig_ip']),named('overrides_email_data_stats'))

		 //FAA  DF-21779 
		 //Show counts of blanked out fields in thor_data400::key::override::fcra::aircraft::qa::ffid
		 ,OUTPUT(strata.macf_pops(FCRA.key_override_aircraft_ffid,,,,,,FALSE,['ace_fips_st','certification',
															 'compname','country','fract_owner','last_action_date','orig_county',
															 'region','status_code','title','type_registrant']),named('overrides_faa_aircraft_deprecation_stats'))
		 //Show counts of blanked out fields in thor_data400::key::override::fcra::aircrafts::qa::ffid
		 ,OUTPUT(strata.macf_pops(FCRA.key_override_faa.aircraft,,,,,,FALSE,['ace_fips_st','certification',
															 'compname','country','fract_owner','last_action_date','orig_county',
															 'region','status_code','title','type_registrant']),named('overrides_faa_aircrafts_deprecation_stats'))
		 //Show counts of blanked out fields in thor_data400::key::override::fcra::aircraft_details::qa::ffid
		 ,OUTPUT(strata.macf_pops(FCRA.key_override_faa.aircraft_details,,,,,,FALSE,['aircraft_category_code',
															 'aircraft_cruising_speed','aircraft_weight','amateur_certification_code',
															 'lf','number_of_engines','number_of_seats']),named('overrides_faa_aircraft_info_deprecation_stats'))
		 //Show counts of blanked out fields in thor_data400::key::override::fcra::aircraft_engine::qa::ffid
		 ,OUTPUT(strata.macf_pops(FCRA.key_override_faa.aircraft_engine,,,,,,FALSE,['fuel_consumed','lf']),named('overrides_faa_engine_info_deprecation_stats'))
		 // Show counts of blanked out fields in thor_data400::key::override::fcra::pilot_certificate::qa::ffid
		 ,OUTPUT(strata.macf_pops(FCRA.key_override_faa.airmen_cert,,,,,,FALSE,['ratings']),named('overrides_faa_airmen_certs_deprecation_stats'))
		 //Show counts of blanked out fields in thor_data400::key::override::fcra::pilot_registration::qa::ffid
		 ,OUTPUT(strata.macf_pops(FCRA.key_override_faa.airmen_reg,,,,,,FALSE,['ace_fips_st','country',															 'region','title']),named('overrides_faa_airmen_reg_deprecation_stats'))


		 //Gong
		 ,OUTPUT(strata.macf_pops(FCRA.Key_Override_Gong_FFID,,,,,,FALSE,
															['caption_text','county_code','designation','disc_cnt18','disc_cnt6','prior_area_code',
															 'see_also_text']),named('overrides_gong_fcra_deprecation_stats'))

		 //LienV2
		 ,OUTPUT(strata.macf_pops(FCRA.key_Override_liensv2_main_ffid,,,,,,FALSE,
														  ['accident_date','accident_date','agency_city','case_title','date_vendor_removed','filing_time',
														   'judg_vacated_date','judge','lapse_date','legal_block','legal_borough',
														   'legal_lot','sherrif_indc','tax_code','vendor_entry_date']),named('overrides_liens_main_fcra_deprecation_stats'))
		 ,OUTPUT(strata.macf_pops(FCRA.key_Override_liensv2_party_ffid,,,,,,FALSE,
															['phone','tax_id']),named('overrides_liens_party_fcra_deprecation_stats'))

		 //Marriage and Dovorce
		 ,OUTPUT(strata.macf_pops(FCRA.key_override_marriage.marriage_main,,,,,,FALSE,['divorce_docket_volume','divorce_filing_dt',
															 'filing_subtype','grounds_for_divorce','marriage_docket_volume','marriage_duration','marriage_duration_cd',
															 'marriage_filing_dt','number_of_children','place_of_marriage','type_of_ceremony']),named('overrides_mdv2_main_fcra_deprecation_stats'))
		 ,OUTPUT(strata.macf_pops(FCRA.key_override_marriage.marriage_search,,,,,,FALSE,['age','birth_state','how_marriage_ended','last_marriage_end_dt',
															 'party_county','previous_marital_status','race','times_married','title']),named('overrides_mdv2_srch_fcra_deprecation_stats'))

		 //Prof License MARI
		 ,OUTPUT(strata.macf_pops(FCRA.Key_Override_Proflic_Mari_ffid.proflic_mari,,,,,,FALSE,
														  ['active_flag','addl_license_spec','addr_addr1_1','addr_addr2_1','addr_bus_ind',
															 'addr_carrier_rte_1','addr_city_1','addr_cntry_1','addr_cnty_1','addr_delivery_pt_1',
															 'addr_id_1','addr_state_1','addr_zip4_1','addr_zip5_1','affil_key','affil_type_cd',
															 'agency_id','agency_status','append_busaceaid','append_busaddrfirst','append_busaddrlast',
															 'append_busrawaid','append_mailaddrfirst','append_mailaddrlast','birth_dte','bk_class',
															 'bk_class_desc','brkr_license_nbr','brkr_license_nbr_type','bus_ace_fips_st',
															 'bus_addr_suffix','bus_cart','bus_chk_digit','bus_county','bus_cr_sort_sz','bus_dpbc',
															 'bus_err_stat','bus_geo_blk','bus_geo_lat','bus_geo_long','bus_geo_match','bus_lot',
															 'bus_lot_order','bus_msa','bus_p_city_name','bus_postdir','bus_predir','bus_prim_name',
															 'bus_prim_range','bus_rec_type','bus_sec_range','bus_state','bus_unit_desig',
															 'bus_v_city_name','bus_zip4','bus_zip5','business_type','charter','cln_license_nbr',
															 'cmc_slpk','cont_education_ernd','cont_education_req','cont_education_term','credential',
															 'dba_flag','disp_type_cd','disp_type_desc','displinary_action','docket_id',
															 'domestic_off_nbr','email','fed_rssd','federal_regulator','foreign_nmls_id',
															 'foreign_off_nbr','gen_nbr','gender','genlink','hcr_location','hcr_rssd','hqtr_city',
															 'hqtr_name','inst_beg_dte','is_authorized_conduct','is_authorized_license','license_id',
															 'license_nbr_contact','location_type','match_id','mltreckey','name_company',
															 'name_company_dba','name_contact_first','name_contact_last','name_contact_mid',
															 'name_contact_nick','name_contact_prefx','name_contact_sufx','name_contact_ttl',
															 'name_dba','name_dba_orig','name_dba_prefx','name_dba_sufx','name_format',
															 'name_mari_dba','name_mari_org','name_nick','name_office','name_org','name_org_orig',
															 'name_org_prefx','name_org_sufx','name_type','off_license_nbr','off_license_nbr_type',
															 'office_parse','old_cmc_slpk','ooc_ind_1','ooc_ind_2','origin_cd','origin_cd_desc',
															 'pcmc_slpk','phn_contact','phn_contact_ext','phn_contact_fax','phn_fax_1','phn_fax_2',
															 'phn_mari_1','phn_mari_2','phn_mari_fax_1','phn_mari_fax_2','phn_phone_1','phn_phone_2',
															 'prev_cmc_slpk','prev_mltreckey','prev_pcmc_slpk','prev_primary_key','prov_stat',
															 'provnote_1','provnote_2','provnote_3','rec_key','reg_agent','regulator','research_ind',
															 'result_cd_1','result_cd_2','site_location','ssn_taxid_1','ssn_taxid_2','start_dte',
															 'std_prof_cd','store_nbr','store_nbr_dba','sud_key_1','sud_key_2','tax_type_1',
															 'tax_type_2','title','type_cd','url','violation_case_nbr','violation_desc','violation_dte']),named('overrides_mari_fcra_deprecation_stats'))

		 //Property
		 ,OUTPUT(strata.macf_pops(FCRA.Key_Override_Property.assessment,,,,,,FALSE,
															['air_conditioning_code','air_conditioning_type_code','amenities1_code','amenities2_code',
															 'amenities2_code1','amenities2_code2','amenities2_code3','amenities2_code4','amenities2_code5',
															 'amenities3_code','amenities4_code','amenities5_code','assessee_name_indicator',
															 'assessee_phone_number','basement_code','building_area4','building_area4_indicator',
															 'building_area5','building_area5_indicator','building_area6','building_area6_indicator',
															 'building_area7','building_area7_indicator','building_class_code','building_condition_code',
															 'building_quality_code','census_tract','certification_date','comments',
															 'condo_project_or_building_name','contract_owner','duplicate_apn_multiple_address_id',
															 'effective_year_built','elevator','exterior_walls_code','extra_features1_area',
															 'extra_features1_indicator','extra_features2_area','extra_features2_indicator',
															 'extra_features3_area','extra_features3_indicator','extra_features4_area',
															 'extra_features4_indicator','fireplace_indicator','fireplace_number','floor_cover_code',
															 'heating_code','heating_fuel_type_code','interior_walls_code','land_dimensions',
															 'land_square_footage','legal_assessor_map_ref','legal_block','legal_brief_description',
															 'legal_city_municipality_township','legal_district','legal_land_lot','legal_land_lot',
															 'legal_lot_code','legal_lot_code','legal_lot_number','legal_lot_number','legal_phase_number',
															 'legal_phase_number','legal_sec_twn_rng_mer','legal_sec_twn_rng_mer','legal_section',
															 'legal_section','legal_subdivision_name','legal_subdivision_name','legal_tract_number',
															 'legal_tract_number','legal_unit','legal_unit','lot_size_depth_feet','lot_size_frontage_feet',
															 'mail_care_of_name_indicator','mortgage_lender_type_code','mortgage_loan_amount',
															 'mortgage_loan_type_code','neighborhood_code','new_record_type_code','no_of_plumbing_fixtures',
															 'other_buildings1_code','other_buildings2_code','other_buildings3_code',
															 'other_buildings4_code','other_buildings5_code','other_impr_building_area1',
															 'other_impr_building_area2','other_impr_building_area3','other_impr_building_area4',
															 'other_impr_building_area5','other_impr_building1_indicator','other_impr_building2_indicator',
															 'other_impr_building3_indicator','other_impr_building4_indicator',
															 'other_impr_building5_indicator','other_rooms_indicator','ownership_type_code',
															 'parking_no_of_cars','prior_recording_date','prior_transfer_date','proc_date',
															 'property_address_code','record_type_code','sale_date','school_tax_district2',
															 'school_tax_district2_indicator','school_tax_district3','school_tax_district3_indicator',
															 'second_assessee_name_indicator','sewer_code','site_influence1_code','site_influence2_code',
															 'site_influence3_code','site_influence4_code','site_influence5_code','state_code',
															 'state_land_use_code','tax_delinquent_year','tax_exemption1_code','tax_exemption2_code',
															 'tax_exemption3_code','tax_exemption4_code','tax_rate_code_area','timeshare_code',
															 'topograpy_code','transfer_date','water_code']),named('overrides_propertyv2_assessor_fcra_deprecation_stats'))
		 ,OUTPUT(strata.macf_pops(FCRA.Key_Override_Property.deed,,,,,,FALSE,
															['addendum_flag','adjustable_rate_index','adjustable_rate_rider','arm_reset_date','assumability_rider','balloon_rider','biweekly_payment_rider',
															 'change_index','city_transfer_tax','condominium_rider','county_transfer_tax','excise_tax_number','filler_except_hawaii','fixed_step_rate_rider',
															 'graduated_payment_rider','hawaii_condo_cpr_code','hawaii_condo_name','hawaii_tct','legal_block','legal_city_municipality_township','legal_district',
															 'legal_land_lot','legal_lot_code','legal_lot_number','legal_phase_number','legal_sec_twn_rng_mer','legal_section','legal_subdivision_name',
															 'legal_tract_number','legal_unit','lender_address_citystatezip','lender_address_unit_number','lender_dba_aka_name','lender_full_street_address',
															 'lender_name_id','loan_term_months','loan_term_years','mailing_address_cd','multi_apn_flag','one_four_family_rider','partial_interest_transferred',
															 'planned_unit_development_rider','prepayment_rider','property_address_code','rate_improvement_rider','second_home_rider',
															 'second_td_lender_type_code','second_td_loan_amount','seller_addendum_flag','tax_id_number','timeshare_flag','total_transfer_tax']),named('overrides_propertyv2_deed_fcra_deprecation_stats'))
	
		 //Sex Offender - show counts of blanked out fields in thor_data400::key::override::fcra::so_main::qa::ffid
		 ,OUTPUT(strata.macf_pops(FCRA.key_override_sexoffender.so_main,,,,,,FALSE,
														  ['addl_comments_1','addl_comments_2','age','build_type','corrective_lense_flag','dna','dob_aka','doc_number','employer','employer_address_1',
															 'employer_address_2','employer_address_3','employer_address_4','employer_address_5','employer_comments','employer_county',
															 'employer_phone','ethnicity','fbi_number','fingerprint_date','fingerprint_link','image_date','image_link','intnet_email_address_1',
															 'intnet_email_address_2','intnet_email_address_3','intnet_email_address_4','intnet_email_address_5','intnet_instant_message_addr_1',
															 'intnet_instant_message_addr_2','intnet_instant_message_addr_3','intnet_instant_message_addr_4','intnet_instant_message_addr_5','intnet_user_name_1',
															 'intnet_user_name_1_url','intnet_user_name_2','intnet_user_name_2_url','intnet_user_name_3','intnet_user_name_3_url',
															 'intnet_user_name_4','intnet_user_name_4_url','intnet_user_name_5','intnet_user_name_5_url','ncic_number',
															 'offender_category','offender_status','orig_dl_date','orig_dl_link','orig_dl_number',
															 'orig_dl_state','orig_registration_number_1','orig_registration_number_2','orig_registration_number_3','orig_registration_number_4',
															 'orig_registration_number_5','orig_state','orig_state_code','orig_veh_color_1','orig_veh_color_2',
															 'orig_veh_color_3','orig_veh_color_4','orig_veh_color_5','orig_veh_location_1','orig_veh_location_2',
															 'orig_veh_location_3','orig_veh_location_4','orig_veh_location_5','orig_veh_make_model_1','orig_veh_make_model_2',
															 'orig_veh_make_model_3','orig_veh_make_model_4','orig_veh_make_model_5','orig_veh_plate_1','orig_veh_plate_2',
															 'orig_veh_plate_3','orig_veh_plate_4','orig_veh_plate_5','orig_veh_state_1','orig_veh_state_2',
															 'orig_veh_state_3','orig_veh_state_4','orig_veh_state_5','orig_veh_year_1','orig_veh_year_2',
															 'orig_veh_year_3','orig_veh_year_4','orig_veh_year_5','other_registration_address_1','other_registration_address_2',
															 'other_registration_address_3','other_registration_address_4','other_registration_address_5','other_registration_county','other_registration_phone',
															 'palmprint_date','palmprint_link','passport_authority','passport_code','passport_date',
															 'passport_dob','passport_endorsement','passport_expiration_date','passport_first_name','passport_given_name',
															 'passport_issue_date','passport_link','passport_nationality','passport_number','passport_place_of_birth',
															 'passport_sex','passport_type','police_agency','police_agency_address_1','police_agency_address_2',
															 'police_agency_contact_name','police_agency_phone','professional_licenses_1','professional_licenses_2','professional_licenses_3',
															 'professional_licenses_4','professional_licenses_5','reg_date_1_type','reg_date_2','reg_date_2_type',
															 'reg_date_3','reg_date_3_type','registration_address_3','registration_address_4','registration_address_5',
															 'registration_cell_phone','registration_home_phone','registration_type','risk_description','risk_level_code',
															 'scars_marks_tattoos','school','school_address_1','school_address_2','school_address_3',
															 'school_address_4','school_address_5','school_comments','school_county','school_phone',
															 'shoe_size','skin_tone','ssn','st_id_number','temp_lodge_address_1',
															 'temp_lodge_address_2','temp_lodge_address_3','temp_lodge_address_4','temp_lodge_address_5','temp_lodge_county','temp_lodge_phone'])
																,named('override_so_main_deprecation_stats'))
		 //Show counts of blanked out fields in thor_data400::key::override::fcra::so_offenses::qa::ffid
		 ,OUTPUT(strata.macf_pops(FCRA.key_override_sexoffender.so_offenses,,,,,,FALSE,
															['arrest_date','arrest_warrant','conviction_date','conviction_jurisdiction','court','court_case_number',
															 'offense_category','offense_code_or_statute','offense_date','offense_description','offense_description_2',
															 'sentence_description','sentence_description_2','victim_age','victim_gender','victim_minor','victim_relationship'])
															 ,named('override_so_offenses_deprecation_stats'))

		 //Student - Show counts of blanked out fields in thor_data400::key::override::fcra::student::qa::ffid
		 ,OUTPUT(strata.macf_pops(FCRA.Key_Override_Student_FFID,,,,,,FALSE,['county_number','delivery_point_barcode','fips_county',
															 'gender','gender_code','head_of_household_first_name','head_of_household_gender','head_of_household_gender_code',
															 'income_level','income_level_code','telephone','title']),named('override_student_stats'))
		 ,OUTPUT(strata.macf_pops(FCRA.Key_Override_Student_New_FFID,,,,,,FALSE,['county_number','delivery_point_barcode','fips_county',
															 'gender','gender_code','head_of_household_first_name','head_of_household_gender','head_of_household_gender_code',
															 'income_level','income_level_code','new_income_level','new_income_level_code','telephone','title']),
															 named('override_student_new_deprecation_stats'))

		 //Watercraft
		 ,OUTPUT(strata.macf_pops(FCRA.key_override_watercraft_FFID,,,,,,FALSE,
															['company_name','gender','orig_fips','orig_province','phone_2','title']))

		 ,OUTPUT(strata.macf_pops(FCRA.key_override_watercraft.sid,,,,,,FALSE,
															['company_name','gender','orig_fips','orig_province','phone_2','title']))

		 ,OUTPUT(strata.macf_pops(FCRA.key_override_watercraft.cid,,,,,,FALSE,
															['call_sign','date_expires','date_issued','doc_certificate_status','flag','hailing_port',
															 'hailing_port_province','hailing_port_state','home_port_name','home_port_province','home_port_state',
															 'hull_builder_name','hull_design_type','hull_identification_number','hull_material','imo_number',
															 'itc_breadth','itc_depth','itc_gross_tons','itc_net_tons','itc_tons_cod_ind','main_hp_ahead',
															 'main_hp_astern','name_of_vessel','official_number','party_database_key','party_identification_number',
															 'propulsion_type','registered_breadth','registered_depth','registered_gross_tons','registered_length',
															 'registered_net_tons','sail_ind','self_propelled_indicator','ship_yard','trade_ind_coastwise_unrestricted',
															 'trade_ind_fishery','trade_ind_great_lakes','trade_ind_limited_coastwise_bowaters_only',
															 'trade_ind_limited_coastwise_oil_spill_response_only','trade_ind_limited_coastwise_restricted',
															 'trade_ind_limited_coastwise_under_charter_to_citizen','trade_ind_limited_fishery_only',
															 'trade_ind_limited_recreation_great_lakes_use_only','trade_ind_limited_registry_cross_border_financing',
															 'trade_ind_limited_registry_no_foreign_voyage','trade_ind_limited_registry_trade_with_canada_only',
															 'trade_ind_recreation','trade_ind_registry','vessel_build_year','vessel_complete_build_city',
															 'vessel_complete_build_country','vessel_complete_build_province','vessel_complete_build_state',
															 'vessel_database_key','vessel_hull_build_city','vessel_hull_build_country','vessel_hull_build_province',
															 'vessel_hull_build_state','vessel_id','vessel_service_type']))
		 ,OUTPUT(strata.macf_pops(FCRA.key_override_watercraft.wid,,,,,,FALSE,
															['additional_owner_count','coast_guard_documented_flag','coast_guard_number','coastguard_flag',
															 'county_registration','dealer','decal_number','engine_make_1','engine_make_2','engine_make_3','engine_model_1',
															 'engine_model_2','engine_model_3','engine_number_1','engine_number_2','engine_number_3','engine_year_1',
															 'engine_year_2','engine_year_3','fuel_code','fuel_description','lien_2_address_1','lien_2_address_2',
															 'lien_2_city','lien_2_date','lien_2_indicator','lien_2_name','lien_2_state','lien_2_zip','new_used_flag',
															 'propulsion_code','propulsion_description','purchase_date','purchase_price','registration_expiration_date',
															 'registration_renewal_date','registration_status_code','registration_status_date','registration_status_description',
															 'signatory','state_purchased','title_state','title_type_code','title_type_description',
															 'transaction_type_code','transaction_type_description','use_code','use_description','vehicle_type_code',
															 'watercraft_color_1_code','watercraft_color_1_description','watercraft_color_2_code',
															 'watercraft_color_2_description','watercraft_hp_1','watercraft_hp_2','watercraft_hp_3',
															 'watercraft_name','watercraft_number_of_engines','watercraft_status_code','watercraft_status_description',
															 'watercraft_toilet_code','watercraft_toilet_description','watercraft_weight','watercraft_width']))

  );






END;
