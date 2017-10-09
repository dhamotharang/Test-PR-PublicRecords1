IMPORT ut,SALT34;
EXPORT Fields := MODULE
 
EXPORT SALT34.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'classification_source_source_type','classification_source_primary_source_entity','classification_source_expectation_of_victim_entities','classification_source_industry_segment','classification_activity_suspected_discrepancy','classification_activity_confidence_that_activity_was_deceitful','classification_activity_workflow_stage_committed','classification_activity_workflow_stage_detected','classification_activity_channels','classification_activity_category_or_fraudtype','classification_activity_description','classification_activity_threat','classification_activity_exposure','classification_activity_write_off_loss','classification_activity_mitigated','classification_activity_alert_level','classification_entity_entity_type','classification_entity_entity_sub_type','classification_entity_role','classification_entity_evidence','classification_entity_investigated_count','classification_permissible_use_access_fdn_file_info_id','classification_permissible_use_access_fdn_file_code','classification_permissible_use_access_gc_id','classification_permissible_use_access_file_type','classification_permissible_use_access_description','classification_permissible_use_access_primary_source_entity','classification_permissible_use_access_ind_type','classification_permissible_use_access_ind_type_description','classification_permissible_use_access_update_freq','classification_permissible_use_access_expiration_days','classification_permissible_use_access_post_contract_expiration_days','classification_permissible_use_access_status','classification_permissible_use_access_product_include','classification_permissible_use_access_date_added','classification_permissible_use_access_user_added','classification_permissible_use_access_date_changed','classification_permissible_use_access_user_changed','classification_permissible_use_access_p_industry_segment','classification_permissible_use_access_usage_term','cleaned_name_title','cleaned_name_fname','cleaned_name_mname','cleaned_name_lname','cleaned_name_name_suffix','cleaned_name_name_score','clean_address_prim_range','clean_address_predir','clean_address_prim_name','clean_address_addr_suffix','clean_address_postdir','clean_address_unit_desig','clean_address_sec_range','clean_address_p_city_name','clean_address_v_city_name','clean_address_st','clean_address_zip','clean_address_zip4','clean_address_cart','clean_address_cr_sort_sz','clean_address_lot','clean_address_lot_order','clean_address_dbpc','clean_address_chk_digit','clean_address_rec_type','clean_address_fips_state','clean_address_fips_county','clean_address_geo_lat','clean_address_geo_long','clean_address_msa','clean_address_geo_blk','clean_address_geo_match','clean_address_err_stat','clean_phones_phone_number','clean_phones_cell_phone','clean_phones_work_phone','record_id','uid','customer_id','sub_customer_id','vendor_id','offender_key','sub_sub_customer_id','customer_event_id','sub_customer_event_id','sub_sub_customer_event_id','ln_product_id','ln_sub_product_id','ln_sub_sub_product_id','ln_product_key','ln_report_date','ln_report_time','reported_date','reported_time','event_date','event_end_date','event_location','event_type_1','event_type_2','event_type_3','household_id','reason_description','investigation_referral_case_id','investigation_referral_date_opened','investigation_referral_date_closed','customer_fraud_code_1','customer_fraud_code_2','type_of_referral','referral_reason','disposition','mitigated','mitigated_amount','external_referral_or_casenumber','fraud_point_score','customer_person_id','raw_title','raw_first_name','raw_middle_name','raw_last_name','raw_orig_suffix','raw_full_name','ssn','dob','drivers_license','drivers_license_state','person_date','name_type','income','own_or_rent','rawlinkid','street_1','street_2','city','state','zip','gps_coordinates','address_date','address_type','appended_provider_id','lnpid','business_name','tin','fein','npi','business_type_1','business_type_2','business_date','phone_number','cell_phone','work_phone','contact_type','contact_date','carrier','contact_location','contact','call_records','in_service','email_address','email_address_type','email_date','host','alias','location','ip_address','ip_address_date','version','class','subnet_mask','reserved','isp','device_id','device_date','unique_number','mac_address','serial_number','device_type','device_identification_provider','transaction_id','transaction_type','amount_of_loss','professional_id','profession_type','corresponding_professional_ids','licensed_pr_state','source','process_date','dt_first_seen','dt_last_seen','dt_vendor_last_reported','dt_vendor_first_reported','source_rec_id','nid','name_ind','address_1','address_2','rawaid','aceaid','address_ind','did','did_score','clean_business_name','bdid','bdid_score','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','__internal_fpos__');
EXPORT FieldNum(SALT34.StrType fn) := CASE(fn,'classification_source_source_type' => 0,'classification_source_primary_source_entity' => 1,'classification_source_expectation_of_victim_entities' => 2,'classification_source_industry_segment' => 3,'classification_activity_suspected_discrepancy' => 4,'classification_activity_confidence_that_activity_was_deceitful' => 5,'classification_activity_workflow_stage_committed' => 6,'classification_activity_workflow_stage_detected' => 7,'classification_activity_channels' => 8,'classification_activity_category_or_fraudtype' => 9,'classification_activity_description' => 10,'classification_activity_threat' => 11,'classification_activity_exposure' => 12,'classification_activity_write_off_loss' => 13,'classification_activity_mitigated' => 14,'classification_activity_alert_level' => 15,'classification_entity_entity_type' => 16,'classification_entity_entity_sub_type' => 17,'classification_entity_role' => 18,'classification_entity_evidence' => 19,'classification_entity_investigated_count' => 20,'classification_permissible_use_access_fdn_file_info_id' => 21,'classification_permissible_use_access_fdn_file_code' => 22,'classification_permissible_use_access_gc_id' => 23,'classification_permissible_use_access_file_type' => 24,'classification_permissible_use_access_description' => 25,'classification_permissible_use_access_primary_source_entity' => 26,'classification_permissible_use_access_ind_type' => 27,'classification_permissible_use_access_ind_type_description' => 28,'classification_permissible_use_access_update_freq' => 29,'classification_permissible_use_access_expiration_days' => 30,'classification_permissible_use_access_post_contract_expiration_days' => 31,'classification_permissible_use_access_status' => 32,'classification_permissible_use_access_product_include' => 33,'classification_permissible_use_access_date_added' => 34,'classification_permissible_use_access_user_added' => 35,'classification_permissible_use_access_date_changed' => 36,'classification_permissible_use_access_user_changed' => 37,'classification_permissible_use_access_p_industry_segment' => 38,'classification_permissible_use_access_usage_term' => 39,'cleaned_name_title' => 40,'cleaned_name_fname' => 41,'cleaned_name_mname' => 42,'cleaned_name_lname' => 43,'cleaned_name_name_suffix' => 44,'cleaned_name_name_score' => 45,'clean_address_prim_range' => 46,'clean_address_predir' => 47,'clean_address_prim_name' => 48,'clean_address_addr_suffix' => 49,'clean_address_postdir' => 50,'clean_address_unit_desig' => 51,'clean_address_sec_range' => 52,'clean_address_p_city_name' => 53,'clean_address_v_city_name' => 54,'clean_address_st' => 55,'clean_address_zip' => 56,'clean_address_zip4' => 57,'clean_address_cart' => 58,'clean_address_cr_sort_sz' => 59,'clean_address_lot' => 60,'clean_address_lot_order' => 61,'clean_address_dbpc' => 62,'clean_address_chk_digit' => 63,'clean_address_rec_type' => 64,'clean_address_fips_state' => 65,'clean_address_fips_county' => 66,'clean_address_geo_lat' => 67,'clean_address_geo_long' => 68,'clean_address_msa' => 69,'clean_address_geo_blk' => 70,'clean_address_geo_match' => 71,'clean_address_err_stat' => 72,'clean_phones_phone_number' => 73,'clean_phones_cell_phone' => 74,'clean_phones_work_phone' => 75,'record_id' => 76,'uid' => 77,'customer_id' => 78,'sub_customer_id' => 79,'vendor_id' => 80,'offender_key' => 81,'sub_sub_customer_id' => 82,'customer_event_id' => 83,'sub_customer_event_id' => 84,'sub_sub_customer_event_id' => 85,'ln_product_id' => 86,'ln_sub_product_id' => 87,'ln_sub_sub_product_id' => 88,'ln_product_key' => 89,'ln_report_date' => 90,'ln_report_time' => 91,'reported_date' => 92,'reported_time' => 93,'event_date' => 94,'event_end_date' => 95,'event_location' => 96,'event_type_1' => 97,'event_type_2' => 98,'event_type_3' => 99,'household_id' => 100,'reason_description' => 101,'investigation_referral_case_id' => 102,'investigation_referral_date_opened' => 103,'investigation_referral_date_closed' => 104,'customer_fraud_code_1' => 105,'customer_fraud_code_2' => 106,'type_of_referral' => 107,'referral_reason' => 108,'disposition' => 109,'mitigated' => 110,'mitigated_amount' => 111,'external_referral_or_casenumber' => 112,'fraud_point_score' => 113,'customer_person_id' => 114,'raw_title' => 115,'raw_first_name' => 116,'raw_middle_name' => 117,'raw_last_name' => 118,'raw_orig_suffix' => 119,'raw_full_name' => 120,'ssn' => 121,'dob' => 122,'drivers_license' => 123,'drivers_license_state' => 124,'person_date' => 125,'name_type' => 126,'income' => 127,'own_or_rent' => 128,'rawlinkid' => 129,'street_1' => 130,'street_2' => 131,'city' => 132,'state' => 133,'zip' => 134,'gps_coordinates' => 135,'address_date' => 136,'address_type' => 137,'appended_provider_id' => 138,'lnpid' => 139,'business_name' => 140,'tin' => 141,'fein' => 142,'npi' => 143,'business_type_1' => 144,'business_type_2' => 145,'business_date' => 146,'phone_number' => 147,'cell_phone' => 148,'work_phone' => 149,'contact_type' => 150,'contact_date' => 151,'carrier' => 152,'contact_location' => 153,'contact' => 154,'call_records' => 155,'in_service' => 156,'email_address' => 157,'email_address_type' => 158,'email_date' => 159,'host' => 160,'alias' => 161,'location' => 162,'ip_address' => 163,'ip_address_date' => 164,'version' => 165,'class' => 166,'subnet_mask' => 167,'reserved' => 168,'isp' => 169,'device_id' => 170,'device_date' => 171,'unique_number' => 172,'mac_address' => 173,'serial_number' => 174,'device_type' => 175,'device_identification_provider' => 176,'transaction_id' => 177,'transaction_type' => 178,'amount_of_loss' => 179,'professional_id' => 180,'profession_type' => 181,'corresponding_professional_ids' => 182,'licensed_pr_state' => 183,'source' => 184,'process_date' => 185,'dt_first_seen' => 186,'dt_last_seen' => 187,'dt_vendor_last_reported' => 188,'dt_vendor_first_reported' => 189,'source_rec_id' => 190,'nid' => 191,'name_ind' => 192,'address_1' => 193,'address_2' => 194,'rawaid' => 195,'aceaid' => 196,'address_ind' => 197,'did' => 198,'did_score' => 199,'clean_business_name' => 200,'bdid' => 201,'bdid_score' => 202,'dotid' => 203,'dotscore' => 204,'dotweight' => 205,'empid' => 206,'empscore' => 207,'empweight' => 208,'powid' => 209,'powscore' => 210,'powweight' => 211,'proxid' => 212,'proxscore' => 213,'proxweight' => 214,'seleid' => 215,'selescore' => 216,'seleweight' => 217,'orgid' => 218,'orgscore' => 219,'orgweight' => 220,'ultid' => 221,'ultscore' => 222,'ultweight' => 223,'__internal_fpos__' => 224,0);
 
//Individual field level validation
 
EXPORT Make_classification_source_source_type(SALT34.StrType s0) := s0;
EXPORT InValid_classification_source_source_type(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_source_source_type(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_source_primary_source_entity(SALT34.StrType s0) := s0;
EXPORT InValid_classification_source_primary_source_entity(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_source_primary_source_entity(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_source_expectation_of_victim_entities(SALT34.StrType s0) := s0;
EXPORT InValid_classification_source_expectation_of_victim_entities(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_source_expectation_of_victim_entities(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_source_industry_segment(SALT34.StrType s0) := s0;
EXPORT InValid_classification_source_industry_segment(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_source_industry_segment(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_activity_suspected_discrepancy(SALT34.StrType s0) := s0;
EXPORT InValid_classification_activity_suspected_discrepancy(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_activity_suspected_discrepancy(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_activity_confidence_that_activity_was_deceitful(SALT34.StrType s0) := s0;
EXPORT InValid_classification_activity_confidence_that_activity_was_deceitful(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_activity_confidence_that_activity_was_deceitful(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_activity_workflow_stage_committed(SALT34.StrType s0) := s0;
EXPORT InValid_classification_activity_workflow_stage_committed(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_activity_workflow_stage_committed(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_activity_workflow_stage_detected(SALT34.StrType s0) := s0;
EXPORT InValid_classification_activity_workflow_stage_detected(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_activity_workflow_stage_detected(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_activity_channels(SALT34.StrType s0) := s0;
EXPORT InValid_classification_activity_channels(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_activity_channels(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_activity_category_or_fraudtype(SALT34.StrType s0) := s0;
EXPORT InValid_classification_activity_category_or_fraudtype(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_activity_category_or_fraudtype(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_activity_description(SALT34.StrType s0) := s0;
EXPORT InValid_classification_activity_description(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_activity_description(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_activity_threat(SALT34.StrType s0) := s0;
EXPORT InValid_classification_activity_threat(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_activity_threat(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_activity_exposure(SALT34.StrType s0) := s0;
EXPORT InValid_classification_activity_exposure(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_activity_exposure(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_activity_write_off_loss(SALT34.StrType s0) := s0;
EXPORT InValid_classification_activity_write_off_loss(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_activity_write_off_loss(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_activity_mitigated(SALT34.StrType s0) := s0;
EXPORT InValid_classification_activity_mitigated(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_activity_mitigated(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_activity_alert_level(SALT34.StrType s0) := s0;
EXPORT InValid_classification_activity_alert_level(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_activity_alert_level(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_entity_entity_type(SALT34.StrType s0) := s0;
EXPORT InValid_classification_entity_entity_type(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_entity_entity_type(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_entity_entity_sub_type(SALT34.StrType s0) := s0;
EXPORT InValid_classification_entity_entity_sub_type(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_entity_entity_sub_type(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_entity_role(SALT34.StrType s0) := s0;
EXPORT InValid_classification_entity_role(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_entity_role(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_entity_evidence(SALT34.StrType s0) := s0;
EXPORT InValid_classification_entity_evidence(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_entity_evidence(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_entity_investigated_count(SALT34.StrType s0) := s0;
EXPORT InValid_classification_entity_investigated_count(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_entity_investigated_count(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_permissible_use_access_fdn_file_info_id(SALT34.StrType s0) := s0;
EXPORT InValid_classification_permissible_use_access_fdn_file_info_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_permissible_use_access_fdn_file_info_id(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_permissible_use_access_fdn_file_code(SALT34.StrType s0) := s0;
EXPORT InValid_classification_permissible_use_access_fdn_file_code(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_permissible_use_access_fdn_file_code(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_permissible_use_access_gc_id(SALT34.StrType s0) := s0;
EXPORT InValid_classification_permissible_use_access_gc_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_permissible_use_access_gc_id(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_permissible_use_access_file_type(SALT34.StrType s0) := s0;
EXPORT InValid_classification_permissible_use_access_file_type(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_permissible_use_access_file_type(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_permissible_use_access_description(SALT34.StrType s0) := s0;
EXPORT InValid_classification_permissible_use_access_description(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_permissible_use_access_description(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_permissible_use_access_primary_source_entity(SALT34.StrType s0) := s0;
EXPORT InValid_classification_permissible_use_access_primary_source_entity(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_permissible_use_access_primary_source_entity(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_permissible_use_access_ind_type(SALT34.StrType s0) := s0;
EXPORT InValid_classification_permissible_use_access_ind_type(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_permissible_use_access_ind_type(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_permissible_use_access_ind_type_description(SALT34.StrType s0) := s0;
EXPORT InValid_classification_permissible_use_access_ind_type_description(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_permissible_use_access_ind_type_description(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_permissible_use_access_update_freq(SALT34.StrType s0) := s0;
EXPORT InValid_classification_permissible_use_access_update_freq(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_permissible_use_access_update_freq(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_permissible_use_access_expiration_days(SALT34.StrType s0) := s0;
EXPORT InValid_classification_permissible_use_access_expiration_days(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_permissible_use_access_expiration_days(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_permissible_use_access_post_contract_expiration_days(SALT34.StrType s0) := s0;
EXPORT InValid_classification_permissible_use_access_post_contract_expiration_days(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_permissible_use_access_post_contract_expiration_days(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_permissible_use_access_status(SALT34.StrType s0) := s0;
EXPORT InValid_classification_permissible_use_access_status(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_permissible_use_access_status(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_permissible_use_access_product_include(SALT34.StrType s0) := s0;
EXPORT InValid_classification_permissible_use_access_product_include(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_permissible_use_access_product_include(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_permissible_use_access_date_added(SALT34.StrType s0) := s0;
EXPORT InValid_classification_permissible_use_access_date_added(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_permissible_use_access_date_added(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_permissible_use_access_user_added(SALT34.StrType s0) := s0;
EXPORT InValid_classification_permissible_use_access_user_added(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_permissible_use_access_user_added(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_permissible_use_access_date_changed(SALT34.StrType s0) := s0;
EXPORT InValid_classification_permissible_use_access_date_changed(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_permissible_use_access_date_changed(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_permissible_use_access_user_changed(SALT34.StrType s0) := s0;
EXPORT InValid_classification_permissible_use_access_user_changed(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_permissible_use_access_user_changed(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_permissible_use_access_p_industry_segment(SALT34.StrType s0) := s0;
EXPORT InValid_classification_permissible_use_access_p_industry_segment(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_permissible_use_access_p_industry_segment(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_permissible_use_access_usage_term(SALT34.StrType s0) := s0;
EXPORT InValid_classification_permissible_use_access_usage_term(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_classification_permissible_use_access_usage_term(UNSIGNED1 wh) := '';
 
EXPORT Make_cleaned_name_title(SALT34.StrType s0) := s0;
EXPORT InValid_cleaned_name_title(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cleaned_name_title(UNSIGNED1 wh) := '';
 
EXPORT Make_cleaned_name_fname(SALT34.StrType s0) := s0;
EXPORT InValid_cleaned_name_fname(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cleaned_name_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_cleaned_name_mname(SALT34.StrType s0) := s0;
EXPORT InValid_cleaned_name_mname(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cleaned_name_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_cleaned_name_lname(SALT34.StrType s0) := s0;
EXPORT InValid_cleaned_name_lname(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cleaned_name_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_cleaned_name_name_suffix(SALT34.StrType s0) := s0;
EXPORT InValid_cleaned_name_name_suffix(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cleaned_name_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_cleaned_name_name_score(SALT34.StrType s0) := s0;
EXPORT InValid_cleaned_name_name_score(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cleaned_name_name_score(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_prim_range(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_prim_range(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_predir(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_predir(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_prim_name(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_prim_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_addr_suffix(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_addr_suffix(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_postdir(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_postdir(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_unit_desig(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_unit_desig(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_sec_range(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_sec_range(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_p_city_name(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_p_city_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_p_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_v_city_name(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_v_city_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_st(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_st(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_st(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_zip(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_zip(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_zip4(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_zip4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_cart(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_cart(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_cart(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_cr_sort_sz(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_cr_sort_sz(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_cr_sort_sz(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_lot(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_lot(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_lot_order(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_lot_order(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_lot_order(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_dbpc(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_dbpc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_dbpc(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_chk_digit(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_chk_digit(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_rec_type(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_rec_type(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_fips_state(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_fips_state(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_fips_state(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_fips_county(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_fips_county(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_fips_county(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_geo_lat(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_geo_lat(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_geo_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_geo_long(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_geo_long(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_geo_long(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_msa(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_msa(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_geo_blk(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_geo_blk(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_geo_match(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_geo_match(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_geo_match(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_address_err_stat(SALT34.StrType s0) := s0;
EXPORT InValid_clean_address_err_stat(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_address_err_stat(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_phones_phone_number(SALT34.StrType s0) := s0;
EXPORT InValid_clean_phones_phone_number(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_phones_phone_number(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_phones_cell_phone(SALT34.StrType s0) := s0;
EXPORT InValid_clean_phones_cell_phone(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_phones_cell_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_phones_work_phone(SALT34.StrType s0) := s0;
EXPORT InValid_clean_phones_work_phone(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_phones_work_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_record_id(SALT34.StrType s0) := s0;
EXPORT InValid_record_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_record_id(UNSIGNED1 wh) := '';
 
EXPORT Make_uid(SALT34.StrType s0) := s0;
EXPORT InValid_uid(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_uid(UNSIGNED1 wh) := '';
 
EXPORT Make_customer_id(SALT34.StrType s0) := s0;
EXPORT InValid_customer_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_customer_id(UNSIGNED1 wh) := '';
 
EXPORT Make_sub_customer_id(SALT34.StrType s0) := s0;
EXPORT InValid_sub_customer_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_sub_customer_id(UNSIGNED1 wh) := '';
 
EXPORT Make_vendor_id(SALT34.StrType s0) := s0;
EXPORT InValid_vendor_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_vendor_id(UNSIGNED1 wh) := '';
 
EXPORT Make_offender_key(SALT34.StrType s0) := s0;
EXPORT InValid_offender_key(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_offender_key(UNSIGNED1 wh) := '';
 
EXPORT Make_sub_sub_customer_id(SALT34.StrType s0) := s0;
EXPORT InValid_sub_sub_customer_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_sub_sub_customer_id(UNSIGNED1 wh) := '';
 
EXPORT Make_customer_event_id(SALT34.StrType s0) := s0;
EXPORT InValid_customer_event_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_customer_event_id(UNSIGNED1 wh) := '';
 
EXPORT Make_sub_customer_event_id(SALT34.StrType s0) := s0;
EXPORT InValid_sub_customer_event_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_sub_customer_event_id(UNSIGNED1 wh) := '';
 
EXPORT Make_sub_sub_customer_event_id(SALT34.StrType s0) := s0;
EXPORT InValid_sub_sub_customer_event_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_sub_sub_customer_event_id(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_product_id(SALT34.StrType s0) := s0;
EXPORT InValid_ln_product_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_ln_product_id(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_sub_product_id(SALT34.StrType s0) := s0;
EXPORT InValid_ln_sub_product_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_ln_sub_product_id(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_sub_sub_product_id(SALT34.StrType s0) := s0;
EXPORT InValid_ln_sub_sub_product_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_ln_sub_sub_product_id(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_product_key(SALT34.StrType s0) := s0;
EXPORT InValid_ln_product_key(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_ln_product_key(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_report_date(SALT34.StrType s0) := s0;
EXPORT InValid_ln_report_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_ln_report_date(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_report_time(SALT34.StrType s0) := s0;
EXPORT InValid_ln_report_time(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_ln_report_time(UNSIGNED1 wh) := '';
 
EXPORT Make_reported_date(SALT34.StrType s0) := s0;
EXPORT InValid_reported_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_reported_date(UNSIGNED1 wh) := '';
 
EXPORT Make_reported_time(SALT34.StrType s0) := s0;
EXPORT InValid_reported_time(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_reported_time(UNSIGNED1 wh) := '';
 
EXPORT Make_event_date(SALT34.StrType s0) := s0;
EXPORT InValid_event_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_event_date(UNSIGNED1 wh) := '';
 
EXPORT Make_event_end_date(SALT34.StrType s0) := s0;
EXPORT InValid_event_end_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_event_end_date(UNSIGNED1 wh) := '';
 
EXPORT Make_event_location(SALT34.StrType s0) := s0;
EXPORT InValid_event_location(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_event_location(UNSIGNED1 wh) := '';
 
EXPORT Make_event_type_1(SALT34.StrType s0) := s0;
EXPORT InValid_event_type_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_event_type_1(UNSIGNED1 wh) := '';
 
EXPORT Make_event_type_2(SALT34.StrType s0) := s0;
EXPORT InValid_event_type_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_event_type_2(UNSIGNED1 wh) := '';
 
EXPORT Make_event_type_3(SALT34.StrType s0) := s0;
EXPORT InValid_event_type_3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_event_type_3(UNSIGNED1 wh) := '';
 
EXPORT Make_household_id(SALT34.StrType s0) := s0;
EXPORT InValid_household_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_household_id(UNSIGNED1 wh) := '';
 
EXPORT Make_reason_description(SALT34.StrType s0) := s0;
EXPORT InValid_reason_description(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_reason_description(UNSIGNED1 wh) := '';
 
EXPORT Make_investigation_referral_case_id(SALT34.StrType s0) := s0;
EXPORT InValid_investigation_referral_case_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_investigation_referral_case_id(UNSIGNED1 wh) := '';
 
EXPORT Make_investigation_referral_date_opened(SALT34.StrType s0) := s0;
EXPORT InValid_investigation_referral_date_opened(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_investigation_referral_date_opened(UNSIGNED1 wh) := '';
 
EXPORT Make_investigation_referral_date_closed(SALT34.StrType s0) := s0;
EXPORT InValid_investigation_referral_date_closed(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_investigation_referral_date_closed(UNSIGNED1 wh) := '';
 
EXPORT Make_customer_fraud_code_1(SALT34.StrType s0) := s0;
EXPORT InValid_customer_fraud_code_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_customer_fraud_code_1(UNSIGNED1 wh) := '';
 
EXPORT Make_customer_fraud_code_2(SALT34.StrType s0) := s0;
EXPORT InValid_customer_fraud_code_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_customer_fraud_code_2(UNSIGNED1 wh) := '';
 
EXPORT Make_type_of_referral(SALT34.StrType s0) := s0;
EXPORT InValid_type_of_referral(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_type_of_referral(UNSIGNED1 wh) := '';
 
EXPORT Make_referral_reason(SALT34.StrType s0) := s0;
EXPORT InValid_referral_reason(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_referral_reason(UNSIGNED1 wh) := '';
 
EXPORT Make_disposition(SALT34.StrType s0) := s0;
EXPORT InValid_disposition(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_disposition(UNSIGNED1 wh) := '';
 
EXPORT Make_mitigated(SALT34.StrType s0) := s0;
EXPORT InValid_mitigated(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_mitigated(UNSIGNED1 wh) := '';
 
EXPORT Make_mitigated_amount(SALT34.StrType s0) := s0;
EXPORT InValid_mitigated_amount(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_mitigated_amount(UNSIGNED1 wh) := '';
 
EXPORT Make_external_referral_or_casenumber(SALT34.StrType s0) := s0;
EXPORT InValid_external_referral_or_casenumber(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_external_referral_or_casenumber(UNSIGNED1 wh) := '';
 
EXPORT Make_fraud_point_score(SALT34.StrType s0) := s0;
EXPORT InValid_fraud_point_score(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_fraud_point_score(UNSIGNED1 wh) := '';
 
EXPORT Make_customer_person_id(SALT34.StrType s0) := s0;
EXPORT InValid_customer_person_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_customer_person_id(UNSIGNED1 wh) := '';
 
EXPORT Make_raw_title(SALT34.StrType s0) := s0;
EXPORT InValid_raw_title(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_raw_title(UNSIGNED1 wh) := '';
 
EXPORT Make_raw_first_name(SALT34.StrType s0) := s0;
EXPORT InValid_raw_first_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_raw_first_name(UNSIGNED1 wh) := '';
 
EXPORT Make_raw_middle_name(SALT34.StrType s0) := s0;
EXPORT InValid_raw_middle_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_raw_middle_name(UNSIGNED1 wh) := '';
 
EXPORT Make_raw_last_name(SALT34.StrType s0) := s0;
EXPORT InValid_raw_last_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_raw_last_name(UNSIGNED1 wh) := '';
 
EXPORT Make_raw_orig_suffix(SALT34.StrType s0) := s0;
EXPORT InValid_raw_orig_suffix(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_raw_orig_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_raw_full_name(SALT34.StrType s0) := s0;
EXPORT InValid_raw_full_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_raw_full_name(UNSIGNED1 wh) := '';
 
EXPORT Make_ssn(SALT34.StrType s0) := s0;
EXPORT InValid_ssn(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := '';
 
EXPORT Make_dob(SALT34.StrType s0) := s0;
EXPORT InValid_dob(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dob(UNSIGNED1 wh) := '';
 
EXPORT Make_drivers_license(SALT34.StrType s0) := s0;
EXPORT InValid_drivers_license(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_drivers_license(UNSIGNED1 wh) := '';
 
EXPORT Make_drivers_license_state(SALT34.StrType s0) := s0;
EXPORT InValid_drivers_license_state(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_drivers_license_state(UNSIGNED1 wh) := '';
 
EXPORT Make_person_date(SALT34.StrType s0) := s0;
EXPORT InValid_person_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_person_date(UNSIGNED1 wh) := '';
 
EXPORT Make_name_type(SALT34.StrType s0) := s0;
EXPORT InValid_name_type(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_name_type(UNSIGNED1 wh) := '';
 
EXPORT Make_income(SALT34.StrType s0) := s0;
EXPORT InValid_income(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_income(UNSIGNED1 wh) := '';
 
EXPORT Make_own_or_rent(SALT34.StrType s0) := s0;
EXPORT InValid_own_or_rent(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_own_or_rent(UNSIGNED1 wh) := '';
 
EXPORT Make_rawlinkid(SALT34.StrType s0) := s0;
EXPORT InValid_rawlinkid(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_rawlinkid(UNSIGNED1 wh) := '';
 
EXPORT Make_street_1(SALT34.StrType s0) := s0;
EXPORT InValid_street_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_street_1(UNSIGNED1 wh) := '';
 
EXPORT Make_street_2(SALT34.StrType s0) := s0;
EXPORT InValid_street_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_street_2(UNSIGNED1 wh) := '';
 
EXPORT Make_city(SALT34.StrType s0) := s0;
EXPORT InValid_city(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_city(UNSIGNED1 wh) := '';
 
EXPORT Make_state(SALT34.StrType s0) := s0;
EXPORT InValid_state(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_state(UNSIGNED1 wh) := '';
 
EXPORT Make_zip(SALT34.StrType s0) := s0;
EXPORT InValid_zip(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_gps_coordinates(SALT34.StrType s0) := s0;
EXPORT InValid_gps_coordinates(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_gps_coordinates(UNSIGNED1 wh) := '';
 
EXPORT Make_address_date(SALT34.StrType s0) := s0;
EXPORT InValid_address_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_address_date(UNSIGNED1 wh) := '';
 
EXPORT Make_address_type(SALT34.StrType s0) := s0;
EXPORT InValid_address_type(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_address_type(UNSIGNED1 wh) := '';
 
EXPORT Make_appended_provider_id(SALT34.StrType s0) := s0;
EXPORT InValid_appended_provider_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_appended_provider_id(UNSIGNED1 wh) := '';
 
EXPORT Make_lnpid(SALT34.StrType s0) := s0;
EXPORT InValid_lnpid(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_lnpid(UNSIGNED1 wh) := '';
 
EXPORT Make_business_name(SALT34.StrType s0) := s0;
EXPORT InValid_business_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_business_name(UNSIGNED1 wh) := '';
 
EXPORT Make_tin(SALT34.StrType s0) := s0;
EXPORT InValid_tin(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_tin(UNSIGNED1 wh) := '';
 
EXPORT Make_fein(SALT34.StrType s0) := s0;
EXPORT InValid_fein(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_fein(UNSIGNED1 wh) := '';
 
EXPORT Make_npi(SALT34.StrType s0) := s0;
EXPORT InValid_npi(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_npi(UNSIGNED1 wh) := '';
 
EXPORT Make_business_type_1(SALT34.StrType s0) := s0;
EXPORT InValid_business_type_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_business_type_1(UNSIGNED1 wh) := '';
 
EXPORT Make_business_type_2(SALT34.StrType s0) := s0;
EXPORT InValid_business_type_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_business_type_2(UNSIGNED1 wh) := '';
 
EXPORT Make_business_date(SALT34.StrType s0) := s0;
EXPORT InValid_business_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_business_date(UNSIGNED1 wh) := '';
 
EXPORT Make_phone_number(SALT34.StrType s0) := s0;
EXPORT InValid_phone_number(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_phone_number(UNSIGNED1 wh) := '';
 
EXPORT Make_cell_phone(SALT34.StrType s0) := s0;
EXPORT InValid_cell_phone(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cell_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_work_phone(SALT34.StrType s0) := s0;
EXPORT InValid_work_phone(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_work_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_type(SALT34.StrType s0) := s0;
EXPORT InValid_contact_type(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_contact_type(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_date(SALT34.StrType s0) := s0;
EXPORT InValid_contact_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_contact_date(UNSIGNED1 wh) := '';
 
EXPORT Make_carrier(SALT34.StrType s0) := s0;
EXPORT InValid_carrier(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_carrier(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_location(SALT34.StrType s0) := s0;
EXPORT InValid_contact_location(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_contact_location(UNSIGNED1 wh) := '';
 
EXPORT Make_contact(SALT34.StrType s0) := s0;
EXPORT InValid_contact(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_contact(UNSIGNED1 wh) := '';
 
EXPORT Make_call_records(SALT34.StrType s0) := s0;
EXPORT InValid_call_records(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_call_records(UNSIGNED1 wh) := '';
 
EXPORT Make_in_service(SALT34.StrType s0) := s0;
EXPORT InValid_in_service(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_in_service(UNSIGNED1 wh) := '';
 
EXPORT Make_email_address(SALT34.StrType s0) := s0;
EXPORT InValid_email_address(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_email_address(UNSIGNED1 wh) := '';
 
EXPORT Make_email_address_type(SALT34.StrType s0) := s0;
EXPORT InValid_email_address_type(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_email_address_type(UNSIGNED1 wh) := '';
 
EXPORT Make_email_date(SALT34.StrType s0) := s0;
EXPORT InValid_email_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_email_date(UNSIGNED1 wh) := '';
 
EXPORT Make_host(SALT34.StrType s0) := s0;
EXPORT InValid_host(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_host(UNSIGNED1 wh) := '';
 
EXPORT Make_alias(SALT34.StrType s0) := s0;
EXPORT InValid_alias(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_alias(UNSIGNED1 wh) := '';
 
EXPORT Make_location(SALT34.StrType s0) := s0;
EXPORT InValid_location(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_location(UNSIGNED1 wh) := '';
 
EXPORT Make_ip_address(SALT34.StrType s0) := s0;
EXPORT InValid_ip_address(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_ip_address(UNSIGNED1 wh) := '';
 
EXPORT Make_ip_address_date(SALT34.StrType s0) := s0;
EXPORT InValid_ip_address_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_ip_address_date(UNSIGNED1 wh) := '';
 
EXPORT Make_version(SALT34.StrType s0) := s0;
EXPORT InValid_version(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_version(UNSIGNED1 wh) := '';
 
EXPORT Make_class(SALT34.StrType s0) := s0;
EXPORT InValid_class(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_class(UNSIGNED1 wh) := '';
 
EXPORT Make_subnet_mask(SALT34.StrType s0) := s0;
EXPORT InValid_subnet_mask(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_subnet_mask(UNSIGNED1 wh) := '';
 
EXPORT Make_reserved(SALT34.StrType s0) := s0;
EXPORT InValid_reserved(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_reserved(UNSIGNED1 wh) := '';
 
EXPORT Make_isp(SALT34.StrType s0) := s0;
EXPORT InValid_isp(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_isp(UNSIGNED1 wh) := '';
 
EXPORT Make_device_id(SALT34.StrType s0) := s0;
EXPORT InValid_device_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_device_id(UNSIGNED1 wh) := '';
 
EXPORT Make_device_date(SALT34.StrType s0) := s0;
EXPORT InValid_device_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_device_date(UNSIGNED1 wh) := '';
 
EXPORT Make_unique_number(SALT34.StrType s0) := s0;
EXPORT InValid_unique_number(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_unique_number(UNSIGNED1 wh) := '';
 
EXPORT Make_mac_address(SALT34.StrType s0) := s0;
EXPORT InValid_mac_address(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_mac_address(UNSIGNED1 wh) := '';
 
EXPORT Make_serial_number(SALT34.StrType s0) := s0;
EXPORT InValid_serial_number(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_serial_number(UNSIGNED1 wh) := '';
 
EXPORT Make_device_type(SALT34.StrType s0) := s0;
EXPORT InValid_device_type(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_device_type(UNSIGNED1 wh) := '';
 
EXPORT Make_device_identification_provider(SALT34.StrType s0) := s0;
EXPORT InValid_device_identification_provider(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_device_identification_provider(UNSIGNED1 wh) := '';
 
EXPORT Make_transaction_id(SALT34.StrType s0) := s0;
EXPORT InValid_transaction_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_transaction_id(UNSIGNED1 wh) := '';
 
EXPORT Make_transaction_type(SALT34.StrType s0) := s0;
EXPORT InValid_transaction_type(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_transaction_type(UNSIGNED1 wh) := '';
 
EXPORT Make_amount_of_loss(SALT34.StrType s0) := s0;
EXPORT InValid_amount_of_loss(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_amount_of_loss(UNSIGNED1 wh) := '';
 
EXPORT Make_professional_id(SALT34.StrType s0) := s0;
EXPORT InValid_professional_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_professional_id(UNSIGNED1 wh) := '';
 
EXPORT Make_profession_type(SALT34.StrType s0) := s0;
EXPORT InValid_profession_type(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_profession_type(UNSIGNED1 wh) := '';
 
EXPORT Make_corresponding_professional_ids(SALT34.StrType s0) := s0;
EXPORT InValid_corresponding_professional_ids(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_corresponding_professional_ids(UNSIGNED1 wh) := '';
 
EXPORT Make_licensed_pr_state(SALT34.StrType s0) := s0;
EXPORT InValid_licensed_pr_state(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_licensed_pr_state(UNSIGNED1 wh) := '';
 
EXPORT Make_source(SALT34.StrType s0) := s0;
EXPORT InValid_source(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_source(UNSIGNED1 wh) := '';
 
EXPORT Make_process_date(SALT34.StrType s0) := s0;
EXPORT InValid_process_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_first_seen(SALT34.StrType s0) := s0;
EXPORT InValid_dt_first_seen(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_last_seen(SALT34.StrType s0) := s0;
EXPORT InValid_dt_last_seen(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_vendor_last_reported(SALT34.StrType s0) := s0;
EXPORT InValid_dt_vendor_last_reported(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_vendor_first_reported(SALT34.StrType s0) := s0;
EXPORT InValid_dt_vendor_first_reported(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := '';
 
EXPORT Make_source_rec_id(SALT34.StrType s0) := s0;
EXPORT InValid_source_rec_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_source_rec_id(UNSIGNED1 wh) := '';
 
EXPORT Make_nid(SALT34.StrType s0) := s0;
EXPORT InValid_nid(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_nid(UNSIGNED1 wh) := '';
 
EXPORT Make_name_ind(SALT34.StrType s0) := s0;
EXPORT InValid_name_ind(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_name_ind(UNSIGNED1 wh) := '';
 
EXPORT Make_address_1(SALT34.StrType s0) := s0;
EXPORT InValid_address_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_address_1(UNSIGNED1 wh) := '';
 
EXPORT Make_address_2(SALT34.StrType s0) := s0;
EXPORT InValid_address_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_address_2(UNSIGNED1 wh) := '';
 
EXPORT Make_rawaid(SALT34.StrType s0) := s0;
EXPORT InValid_rawaid(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_rawaid(UNSIGNED1 wh) := '';
 
EXPORT Make_aceaid(SALT34.StrType s0) := s0;
EXPORT InValid_aceaid(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_aceaid(UNSIGNED1 wh) := '';
 
EXPORT Make_address_ind(SALT34.StrType s0) := s0;
EXPORT InValid_address_ind(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_address_ind(UNSIGNED1 wh) := '';
 
EXPORT Make_did(SALT34.StrType s0) := s0;
EXPORT InValid_did(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_did(UNSIGNED1 wh) := '';
 
EXPORT Make_did_score(SALT34.StrType s0) := s0;
EXPORT InValid_did_score(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_business_name(SALT34.StrType s0) := s0;
EXPORT InValid_clean_business_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_business_name(UNSIGNED1 wh) := '';
 
EXPORT Make_bdid(SALT34.StrType s0) := s0;
EXPORT InValid_bdid(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := '';
 
EXPORT Make_bdid_score(SALT34.StrType s0) := s0;
EXPORT InValid_bdid_score(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_bdid_score(UNSIGNED1 wh) := '';
 
EXPORT Make_dotid(SALT34.StrType s0) := s0;
EXPORT InValid_dotid(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dotid(UNSIGNED1 wh) := '';
 
EXPORT Make_dotscore(SALT34.StrType s0) := s0;
EXPORT InValid_dotscore(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dotscore(UNSIGNED1 wh) := '';
 
EXPORT Make_dotweight(SALT34.StrType s0) := s0;
EXPORT InValid_dotweight(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dotweight(UNSIGNED1 wh) := '';
 
EXPORT Make_empid(SALT34.StrType s0) := s0;
EXPORT InValid_empid(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_empid(UNSIGNED1 wh) := '';
 
EXPORT Make_empscore(SALT34.StrType s0) := s0;
EXPORT InValid_empscore(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_empscore(UNSIGNED1 wh) := '';
 
EXPORT Make_empweight(SALT34.StrType s0) := s0;
EXPORT InValid_empweight(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_empweight(UNSIGNED1 wh) := '';
 
EXPORT Make_powid(SALT34.StrType s0) := s0;
EXPORT InValid_powid(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_powid(UNSIGNED1 wh) := '';
 
EXPORT Make_powscore(SALT34.StrType s0) := s0;
EXPORT InValid_powscore(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_powscore(UNSIGNED1 wh) := '';
 
EXPORT Make_powweight(SALT34.StrType s0) := s0;
EXPORT InValid_powweight(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_powweight(UNSIGNED1 wh) := '';
 
EXPORT Make_proxid(SALT34.StrType s0) := s0;
EXPORT InValid_proxid(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := '';
 
EXPORT Make_proxscore(SALT34.StrType s0) := s0;
EXPORT InValid_proxscore(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_proxscore(UNSIGNED1 wh) := '';
 
EXPORT Make_proxweight(SALT34.StrType s0) := s0;
EXPORT InValid_proxweight(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_proxweight(UNSIGNED1 wh) := '';
 
EXPORT Make_seleid(SALT34.StrType s0) := s0;
EXPORT InValid_seleid(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := '';
 
EXPORT Make_selescore(SALT34.StrType s0) := s0;
EXPORT InValid_selescore(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_selescore(UNSIGNED1 wh) := '';
 
EXPORT Make_seleweight(SALT34.StrType s0) := s0;
EXPORT InValid_seleweight(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_seleweight(UNSIGNED1 wh) := '';
 
EXPORT Make_orgid(SALT34.StrType s0) := s0;
EXPORT InValid_orgid(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := '';
 
EXPORT Make_orgscore(SALT34.StrType s0) := s0;
EXPORT InValid_orgscore(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_orgscore(UNSIGNED1 wh) := '';
 
EXPORT Make_orgweight(SALT34.StrType s0) := s0;
EXPORT InValid_orgweight(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_orgweight(UNSIGNED1 wh) := '';
 
EXPORT Make_ultid(SALT34.StrType s0) := s0;
EXPORT InValid_ultid(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := '';
 
EXPORT Make_ultscore(SALT34.StrType s0) := s0;
EXPORT InValid_ultscore(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_ultscore(UNSIGNED1 wh) := '';
 
EXPORT Make_ultweight(SALT34.StrType s0) := s0;
EXPORT InValid_ultweight(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_ultweight(UNSIGNED1 wh) := '';
 
EXPORT Make___internal_fpos__(SALT34.StrType s0) := s0;
EXPORT InValid___internal_fpos__(SALT34.StrType s) := FALSE;
EXPORT InValidMessage___internal_fpos__(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT34,cramos;
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_classification_source_source_type;
    BOOLEAN Diff_classification_source_primary_source_entity;
    BOOLEAN Diff_classification_source_expectation_of_victim_entities;
    BOOLEAN Diff_classification_source_industry_segment;
    BOOLEAN Diff_classification_activity_suspected_discrepancy;
    BOOLEAN Diff_classification_activity_confidence_that_activity_was_deceitful;
    BOOLEAN Diff_classification_activity_workflow_stage_committed;
    BOOLEAN Diff_classification_activity_workflow_stage_detected;
    BOOLEAN Diff_classification_activity_channels;
    BOOLEAN Diff_classification_activity_category_or_fraudtype;
    BOOLEAN Diff_classification_activity_description;
    BOOLEAN Diff_classification_activity_threat;
    BOOLEAN Diff_classification_activity_exposure;
    BOOLEAN Diff_classification_activity_write_off_loss;
    BOOLEAN Diff_classification_activity_mitigated;
    BOOLEAN Diff_classification_activity_alert_level;
    BOOLEAN Diff_classification_entity_entity_type;
    BOOLEAN Diff_classification_entity_entity_sub_type;
    BOOLEAN Diff_classification_entity_role;
    BOOLEAN Diff_classification_entity_evidence;
    BOOLEAN Diff_classification_entity_investigated_count;
    BOOLEAN Diff_classification_permissible_use_access_fdn_file_info_id;
    BOOLEAN Diff_classification_permissible_use_access_fdn_file_code;
    BOOLEAN Diff_classification_permissible_use_access_gc_id;
    BOOLEAN Diff_classification_permissible_use_access_file_type;
    BOOLEAN Diff_classification_permissible_use_access_description;
    BOOLEAN Diff_classification_permissible_use_access_primary_source_entity;
    BOOLEAN Diff_classification_permissible_use_access_ind_type;
    BOOLEAN Diff_classification_permissible_use_access_ind_type_description;
    BOOLEAN Diff_classification_permissible_use_access_update_freq;
    BOOLEAN Diff_classification_permissible_use_access_expiration_days;
    BOOLEAN Diff_classification_permissible_use_access_post_contract_expiration_days;
    BOOLEAN Diff_classification_permissible_use_access_status;
    BOOLEAN Diff_classification_permissible_use_access_product_include;
    BOOLEAN Diff_classification_permissible_use_access_date_added;
    BOOLEAN Diff_classification_permissible_use_access_user_added;
    BOOLEAN Diff_classification_permissible_use_access_date_changed;
    BOOLEAN Diff_classification_permissible_use_access_user_changed;
    BOOLEAN Diff_classification_permissible_use_access_p_industry_segment;
    BOOLEAN Diff_classification_permissible_use_access_usage_term;
    BOOLEAN Diff_cleaned_name_title;
    BOOLEAN Diff_cleaned_name_fname;
    BOOLEAN Diff_cleaned_name_mname;
    BOOLEAN Diff_cleaned_name_lname;
    BOOLEAN Diff_cleaned_name_name_suffix;
    BOOLEAN Diff_cleaned_name_name_score;
    BOOLEAN Diff_clean_address_prim_range;
    BOOLEAN Diff_clean_address_predir;
    BOOLEAN Diff_clean_address_prim_name;
    BOOLEAN Diff_clean_address_addr_suffix;
    BOOLEAN Diff_clean_address_postdir;
    BOOLEAN Diff_clean_address_unit_desig;
    BOOLEAN Diff_clean_address_sec_range;
    BOOLEAN Diff_clean_address_p_city_name;
    BOOLEAN Diff_clean_address_v_city_name;
    BOOLEAN Diff_clean_address_st;
    BOOLEAN Diff_clean_address_zip;
    BOOLEAN Diff_clean_address_zip4;
    BOOLEAN Diff_clean_address_cart;
    BOOLEAN Diff_clean_address_cr_sort_sz;
    BOOLEAN Diff_clean_address_lot;
    BOOLEAN Diff_clean_address_lot_order;
    BOOLEAN Diff_clean_address_dbpc;
    BOOLEAN Diff_clean_address_chk_digit;
    BOOLEAN Diff_clean_address_rec_type;
    BOOLEAN Diff_clean_address_fips_state;
    BOOLEAN Diff_clean_address_fips_county;
    BOOLEAN Diff_clean_address_geo_lat;
    BOOLEAN Diff_clean_address_geo_long;
    BOOLEAN Diff_clean_address_msa;
    BOOLEAN Diff_clean_address_geo_blk;
    BOOLEAN Diff_clean_address_geo_match;
    BOOLEAN Diff_clean_address_err_stat;
    BOOLEAN Diff_clean_phones_phone_number;
    BOOLEAN Diff_clean_phones_cell_phone;
    BOOLEAN Diff_clean_phones_work_phone;
    BOOLEAN Diff_record_id;
    BOOLEAN Diff_uid;
    BOOLEAN Diff_customer_id;
    BOOLEAN Diff_sub_customer_id;
    BOOLEAN Diff_vendor_id;
    BOOLEAN Diff_offender_key;
    BOOLEAN Diff_sub_sub_customer_id;
    BOOLEAN Diff_customer_event_id;
    BOOLEAN Diff_sub_customer_event_id;
    BOOLEAN Diff_sub_sub_customer_event_id;
    BOOLEAN Diff_ln_product_id;
    BOOLEAN Diff_ln_sub_product_id;
    BOOLEAN Diff_ln_sub_sub_product_id;
    BOOLEAN Diff_ln_product_key;
    BOOLEAN Diff_ln_report_date;
    BOOLEAN Diff_ln_report_time;
    BOOLEAN Diff_reported_date;
    BOOLEAN Diff_reported_time;
    BOOLEAN Diff_event_date;
    BOOLEAN Diff_event_end_date;
    BOOLEAN Diff_event_location;
    BOOLEAN Diff_event_type_1;
    BOOLEAN Diff_event_type_2;
    BOOLEAN Diff_event_type_3;
    BOOLEAN Diff_household_id;
    BOOLEAN Diff_reason_description;
    BOOLEAN Diff_investigation_referral_case_id;
    BOOLEAN Diff_investigation_referral_date_opened;
    BOOLEAN Diff_investigation_referral_date_closed;
    BOOLEAN Diff_customer_fraud_code_1;
    BOOLEAN Diff_customer_fraud_code_2;
    BOOLEAN Diff_type_of_referral;
    BOOLEAN Diff_referral_reason;
    BOOLEAN Diff_disposition;
    BOOLEAN Diff_mitigated;
    BOOLEAN Diff_mitigated_amount;
    BOOLEAN Diff_external_referral_or_casenumber;
    BOOLEAN Diff_fraud_point_score;
    BOOLEAN Diff_customer_person_id;
    BOOLEAN Diff_raw_title;
    BOOLEAN Diff_raw_first_name;
    BOOLEAN Diff_raw_middle_name;
    BOOLEAN Diff_raw_last_name;
    BOOLEAN Diff_raw_orig_suffix;
    BOOLEAN Diff_raw_full_name;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_drivers_license;
    BOOLEAN Diff_drivers_license_state;
    BOOLEAN Diff_person_date;
    BOOLEAN Diff_name_type;
    BOOLEAN Diff_income;
    BOOLEAN Diff_own_or_rent;
    BOOLEAN Diff_rawlinkid;
    BOOLEAN Diff_street_1;
    BOOLEAN Diff_street_2;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_gps_coordinates;
    BOOLEAN Diff_address_date;
    BOOLEAN Diff_address_type;
    BOOLEAN Diff_appended_provider_id;
    BOOLEAN Diff_lnpid;
    BOOLEAN Diff_business_name;
    BOOLEAN Diff_tin;
    BOOLEAN Diff_fein;
    BOOLEAN Diff_npi;
    BOOLEAN Diff_business_type_1;
    BOOLEAN Diff_business_type_2;
    BOOLEAN Diff_business_date;
    BOOLEAN Diff_phone_number;
    BOOLEAN Diff_cell_phone;
    BOOLEAN Diff_work_phone;
    BOOLEAN Diff_contact_type;
    BOOLEAN Diff_contact_date;
    BOOLEAN Diff_carrier;
    BOOLEAN Diff_contact_location;
    BOOLEAN Diff_contact;
    BOOLEAN Diff_call_records;
    BOOLEAN Diff_in_service;
    BOOLEAN Diff_email_address;
    BOOLEAN Diff_email_address_type;
    BOOLEAN Diff_email_date;
    BOOLEAN Diff_host;
    BOOLEAN Diff_alias;
    BOOLEAN Diff_location;
    BOOLEAN Diff_ip_address;
    BOOLEAN Diff_ip_address_date;
    BOOLEAN Diff_version;
    BOOLEAN Diff_class;
    BOOLEAN Diff_subnet_mask;
    BOOLEAN Diff_reserved;
    BOOLEAN Diff_isp;
    BOOLEAN Diff_device_id;
    BOOLEAN Diff_device_date;
    BOOLEAN Diff_unique_number;
    BOOLEAN Diff_mac_address;
    BOOLEAN Diff_serial_number;
    BOOLEAN Diff_device_type;
    BOOLEAN Diff_device_identification_provider;
    BOOLEAN Diff_transaction_id;
    BOOLEAN Diff_transaction_type;
    BOOLEAN Diff_amount_of_loss;
    BOOLEAN Diff_professional_id;
    BOOLEAN Diff_profession_type;
    BOOLEAN Diff_corresponding_professional_ids;
    BOOLEAN Diff_licensed_pr_state;
    BOOLEAN Diff_source;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_source_rec_id;
    BOOLEAN Diff_nid;
    BOOLEAN Diff_name_ind;
    BOOLEAN Diff_address_1;
    BOOLEAN Diff_address_2;
    BOOLEAN Diff_rawaid;
    BOOLEAN Diff_aceaid;
    BOOLEAN Diff_address_ind;
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_clean_business_name;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_bdid_score;
    BOOLEAN Diff_dotid;
    BOOLEAN Diff_dotscore;
    BOOLEAN Diff_dotweight;
    BOOLEAN Diff_empid;
    BOOLEAN Diff_empscore;
    BOOLEAN Diff_empweight;
    BOOLEAN Diff_powid;
    BOOLEAN Diff_powscore;
    BOOLEAN Diff_powweight;
    BOOLEAN Diff_proxid;
    BOOLEAN Diff_proxscore;
    BOOLEAN Diff_proxweight;
    BOOLEAN Diff_seleid;
    BOOLEAN Diff_selescore;
    BOOLEAN Diff_seleweight;
    BOOLEAN Diff_orgid;
    BOOLEAN Diff_orgscore;
    BOOLEAN Diff_orgweight;
    BOOLEAN Diff_ultid;
    BOOLEAN Diff_ultscore;
    BOOLEAN Diff_ultweight;
    BOOLEAN Diff___internal_fpos__;
    UNSIGNED Num_Diffs;
    SALT34.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_classification_source_source_type := le.classification_source_source_type <> ri.classification_source_source_type;
    SELF.Diff_classification_source_primary_source_entity := le.classification_source_primary_source_entity <> ri.classification_source_primary_source_entity;
    SELF.Diff_classification_source_expectation_of_victim_entities := le.classification_source_expectation_of_victim_entities <> ri.classification_source_expectation_of_victim_entities;
    SELF.Diff_classification_source_industry_segment := le.classification_source_industry_segment <> ri.classification_source_industry_segment;
    SELF.Diff_classification_activity_suspected_discrepancy := le.classification_activity_suspected_discrepancy <> ri.classification_activity_suspected_discrepancy;
    SELF.Diff_classification_activity_confidence_that_activity_was_deceitful := le.classification_activity_confidence_that_activity_was_deceitful <> ri.classification_activity_confidence_that_activity_was_deceitful;
    SELF.Diff_classification_activity_workflow_stage_committed := le.classification_activity_workflow_stage_committed <> ri.classification_activity_workflow_stage_committed;
    SELF.Diff_classification_activity_workflow_stage_detected := le.classification_activity_workflow_stage_detected <> ri.classification_activity_workflow_stage_detected;
    SELF.Diff_classification_activity_channels := le.classification_activity_channels <> ri.classification_activity_channels;
    SELF.Diff_classification_activity_category_or_fraudtype := le.classification_activity_category_or_fraudtype <> ri.classification_activity_category_or_fraudtype;
    SELF.Diff_classification_activity_description := le.classification_activity_description <> ri.classification_activity_description;
    SELF.Diff_classification_activity_threat := le.classification_activity_threat <> ri.classification_activity_threat;
    SELF.Diff_classification_activity_exposure := le.classification_activity_exposure <> ri.classification_activity_exposure;
    SELF.Diff_classification_activity_write_off_loss := le.classification_activity_write_off_loss <> ri.classification_activity_write_off_loss;
    SELF.Diff_classification_activity_mitigated := le.classification_activity_mitigated <> ri.classification_activity_mitigated;
    SELF.Diff_classification_activity_alert_level := le.classification_activity_alert_level <> ri.classification_activity_alert_level;
    SELF.Diff_classification_entity_entity_type := le.classification_entity_entity_type <> ri.classification_entity_entity_type;
    SELF.Diff_classification_entity_entity_sub_type := le.classification_entity_entity_sub_type <> ri.classification_entity_entity_sub_type;
    SELF.Diff_classification_entity_role := le.classification_entity_role <> ri.classification_entity_role;
    SELF.Diff_classification_entity_evidence := le.classification_entity_evidence <> ri.classification_entity_evidence;
    SELF.Diff_classification_entity_investigated_count := le.classification_entity_investigated_count <> ri.classification_entity_investigated_count;
    SELF.Diff_classification_permissible_use_access_fdn_file_info_id := le.classification_permissible_use_access_fdn_file_info_id <> ri.classification_permissible_use_access_fdn_file_info_id;
    SELF.Diff_classification_permissible_use_access_fdn_file_code := le.classification_permissible_use_access_fdn_file_code <> ri.classification_permissible_use_access_fdn_file_code;
    SELF.Diff_classification_permissible_use_access_gc_id := le.classification_permissible_use_access_gc_id <> ri.classification_permissible_use_access_gc_id;
    SELF.Diff_classification_permissible_use_access_file_type := le.classification_permissible_use_access_file_type <> ri.classification_permissible_use_access_file_type;
    SELF.Diff_classification_permissible_use_access_description := le.classification_permissible_use_access_description <> ri.classification_permissible_use_access_description;
    SELF.Diff_classification_permissible_use_access_primary_source_entity := le.classification_permissible_use_access_primary_source_entity <> ri.classification_permissible_use_access_primary_source_entity;
    SELF.Diff_classification_permissible_use_access_ind_type := le.classification_permissible_use_access_ind_type <> ri.classification_permissible_use_access_ind_type;
    SELF.Diff_classification_permissible_use_access_ind_type_description := le.classification_permissible_use_access_ind_type_description <> ri.classification_permissible_use_access_ind_type_description;
    SELF.Diff_classification_permissible_use_access_update_freq := le.classification_permissible_use_access_update_freq <> ri.classification_permissible_use_access_update_freq;
    SELF.Diff_classification_permissible_use_access_expiration_days := le.classification_permissible_use_access_expiration_days <> ri.classification_permissible_use_access_expiration_days;
    SELF.Diff_classification_permissible_use_access_post_contract_expiration_days := le.classification_permissible_use_access_post_contract_expiration_days <> ri.classification_permissible_use_access_post_contract_expiration_days;
    SELF.Diff_classification_permissible_use_access_status := le.classification_permissible_use_access_status <> ri.classification_permissible_use_access_status;
    SELF.Diff_classification_permissible_use_access_product_include := le.classification_permissible_use_access_product_include <> ri.classification_permissible_use_access_product_include;
    SELF.Diff_classification_permissible_use_access_date_added := le.classification_permissible_use_access_date_added <> ri.classification_permissible_use_access_date_added;
    SELF.Diff_classification_permissible_use_access_user_added := le.classification_permissible_use_access_user_added <> ri.classification_permissible_use_access_user_added;
    SELF.Diff_classification_permissible_use_access_date_changed := le.classification_permissible_use_access_date_changed <> ri.classification_permissible_use_access_date_changed;
    SELF.Diff_classification_permissible_use_access_user_changed := le.classification_permissible_use_access_user_changed <> ri.classification_permissible_use_access_user_changed;
    SELF.Diff_classification_permissible_use_access_p_industry_segment := le.classification_permissible_use_access_p_industry_segment <> ri.classification_permissible_use_access_p_industry_segment;
    SELF.Diff_classification_permissible_use_access_usage_term := le.classification_permissible_use_access_usage_term <> ri.classification_permissible_use_access_usage_term;
    SELF.Diff_cleaned_name_title := le.cleaned_name_title <> ri.cleaned_name_title;
    SELF.Diff_cleaned_name_fname := le.cleaned_name_fname <> ri.cleaned_name_fname;
    SELF.Diff_cleaned_name_mname := le.cleaned_name_mname <> ri.cleaned_name_mname;
    SELF.Diff_cleaned_name_lname := le.cleaned_name_lname <> ri.cleaned_name_lname;
    SELF.Diff_cleaned_name_name_suffix := le.cleaned_name_name_suffix <> ri.cleaned_name_name_suffix;
    SELF.Diff_cleaned_name_name_score := le.cleaned_name_name_score <> ri.cleaned_name_name_score;
    SELF.Diff_clean_address_prim_range := le.clean_address_prim_range <> ri.clean_address_prim_range;
    SELF.Diff_clean_address_predir := le.clean_address_predir <> ri.clean_address_predir;
    SELF.Diff_clean_address_prim_name := le.clean_address_prim_name <> ri.clean_address_prim_name;
    SELF.Diff_clean_address_addr_suffix := le.clean_address_addr_suffix <> ri.clean_address_addr_suffix;
    SELF.Diff_clean_address_postdir := le.clean_address_postdir <> ri.clean_address_postdir;
    SELF.Diff_clean_address_unit_desig := le.clean_address_unit_desig <> ri.clean_address_unit_desig;
    SELF.Diff_clean_address_sec_range := le.clean_address_sec_range <> ri.clean_address_sec_range;
    SELF.Diff_clean_address_p_city_name := le.clean_address_p_city_name <> ri.clean_address_p_city_name;
    SELF.Diff_clean_address_v_city_name := le.clean_address_v_city_name <> ri.clean_address_v_city_name;
    SELF.Diff_clean_address_st := le.clean_address_st <> ri.clean_address_st;
    SELF.Diff_clean_address_zip := le.clean_address_zip <> ri.clean_address_zip;
    SELF.Diff_clean_address_zip4 := le.clean_address_zip4 <> ri.clean_address_zip4;
    SELF.Diff_clean_address_cart := le.clean_address_cart <> ri.clean_address_cart;
    SELF.Diff_clean_address_cr_sort_sz := le.clean_address_cr_sort_sz <> ri.clean_address_cr_sort_sz;
    SELF.Diff_clean_address_lot := le.clean_address_lot <> ri.clean_address_lot;
    SELF.Diff_clean_address_lot_order := le.clean_address_lot_order <> ri.clean_address_lot_order;
    SELF.Diff_clean_address_dbpc := le.clean_address_dbpc <> ri.clean_address_dbpc;
    SELF.Diff_clean_address_chk_digit := le.clean_address_chk_digit <> ri.clean_address_chk_digit;
    SELF.Diff_clean_address_rec_type := le.clean_address_rec_type <> ri.clean_address_rec_type;
    SELF.Diff_clean_address_fips_state := le.clean_address_fips_state <> ri.clean_address_fips_state;
    SELF.Diff_clean_address_fips_county := le.clean_address_fips_county <> ri.clean_address_fips_county;
    SELF.Diff_clean_address_geo_lat := le.clean_address_geo_lat <> ri.clean_address_geo_lat;
    SELF.Diff_clean_address_geo_long := le.clean_address_geo_long <> ri.clean_address_geo_long;
    SELF.Diff_clean_address_msa := le.clean_address_msa <> ri.clean_address_msa;
    SELF.Diff_clean_address_geo_blk := le.clean_address_geo_blk <> ri.clean_address_geo_blk;
    SELF.Diff_clean_address_geo_match := le.clean_address_geo_match <> ri.clean_address_geo_match;
    SELF.Diff_clean_address_err_stat := le.clean_address_err_stat <> ri.clean_address_err_stat;
    SELF.Diff_clean_phones_phone_number := le.clean_phones_phone_number <> ri.clean_phones_phone_number;
    SELF.Diff_clean_phones_cell_phone := le.clean_phones_cell_phone <> ri.clean_phones_cell_phone;
    SELF.Diff_clean_phones_work_phone := le.clean_phones_work_phone <> ri.clean_phones_work_phone;
    SELF.Diff_record_id := le.record_id <> ri.record_id;
    SELF.Diff_uid := le.uid <> ri.uid;
    SELF.Diff_customer_id := le.customer_id <> ri.customer_id;
    SELF.Diff_sub_customer_id := le.sub_customer_id <> ri.sub_customer_id;
    SELF.Diff_vendor_id := le.vendor_id <> ri.vendor_id;
    SELF.Diff_offender_key := le.offender_key <> ri.offender_key;
    SELF.Diff_sub_sub_customer_id := le.sub_sub_customer_id <> ri.sub_sub_customer_id;
    SELF.Diff_customer_event_id := le.customer_event_id <> ri.customer_event_id;
    SELF.Diff_sub_customer_event_id := le.sub_customer_event_id <> ri.sub_customer_event_id;
    SELF.Diff_sub_sub_customer_event_id := le.sub_sub_customer_event_id <> ri.sub_sub_customer_event_id;
    SELF.Diff_ln_product_id := le.ln_product_id <> ri.ln_product_id;
    SELF.Diff_ln_sub_product_id := le.ln_sub_product_id <> ri.ln_sub_product_id;
    SELF.Diff_ln_sub_sub_product_id := le.ln_sub_sub_product_id <> ri.ln_sub_sub_product_id;
    SELF.Diff_ln_product_key := le.ln_product_key <> ri.ln_product_key;
    SELF.Diff_ln_report_date := le.ln_report_date <> ri.ln_report_date;
    SELF.Diff_ln_report_time := le.ln_report_time <> ri.ln_report_time;
    SELF.Diff_reported_date := le.reported_date <> ri.reported_date;
    SELF.Diff_reported_time := le.reported_time <> ri.reported_time;
    SELF.Diff_event_date := le.event_date <> ri.event_date;
    SELF.Diff_event_end_date := le.event_end_date <> ri.event_end_date;
    SELF.Diff_event_location := le.event_location <> ri.event_location;
    SELF.Diff_event_type_1 := le.event_type_1 <> ri.event_type_1;
    SELF.Diff_event_type_2 := le.event_type_2 <> ri.event_type_2;
    SELF.Diff_event_type_3 := le.event_type_3 <> ri.event_type_3;
    SELF.Diff_household_id := le.household_id <> ri.household_id;
    SELF.Diff_reason_description := le.reason_description <> ri.reason_description;
    SELF.Diff_investigation_referral_case_id := le.investigation_referral_case_id <> ri.investigation_referral_case_id;
    SELF.Diff_investigation_referral_date_opened := le.investigation_referral_date_opened <> ri.investigation_referral_date_opened;
    SELF.Diff_investigation_referral_date_closed := le.investigation_referral_date_closed <> ri.investigation_referral_date_closed;
    SELF.Diff_customer_fraud_code_1 := le.customer_fraud_code_1 <> ri.customer_fraud_code_1;
    SELF.Diff_customer_fraud_code_2 := le.customer_fraud_code_2 <> ri.customer_fraud_code_2;
    SELF.Diff_type_of_referral := le.type_of_referral <> ri.type_of_referral;
    SELF.Diff_referral_reason := le.referral_reason <> ri.referral_reason;
    SELF.Diff_disposition := le.disposition <> ri.disposition;
    SELF.Diff_mitigated := le.mitigated <> ri.mitigated;
    SELF.Diff_mitigated_amount := le.mitigated_amount <> ri.mitigated_amount;
    SELF.Diff_external_referral_or_casenumber := le.external_referral_or_casenumber <> ri.external_referral_or_casenumber;
    SELF.Diff_fraud_point_score := le.fraud_point_score <> ri.fraud_point_score;
    SELF.Diff_customer_person_id := le.customer_person_id <> ri.customer_person_id;
    SELF.Diff_raw_title := le.raw_title <> ri.raw_title;
    SELF.Diff_raw_first_name := le.raw_first_name <> ri.raw_first_name;
    SELF.Diff_raw_middle_name := le.raw_middle_name <> ri.raw_middle_name;
    SELF.Diff_raw_last_name := le.raw_last_name <> ri.raw_last_name;
    SELF.Diff_raw_orig_suffix := le.raw_orig_suffix <> ri.raw_orig_suffix;
    SELF.Diff_raw_full_name := le.raw_full_name <> ri.raw_full_name;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_drivers_license := le.drivers_license <> ri.drivers_license;
    SELF.Diff_drivers_license_state := le.drivers_license_state <> ri.drivers_license_state;
    SELF.Diff_person_date := le.person_date <> ri.person_date;
    SELF.Diff_name_type := le.name_type <> ri.name_type;
    SELF.Diff_income := le.income <> ri.income;
    SELF.Diff_own_or_rent := le.own_or_rent <> ri.own_or_rent;
    SELF.Diff_rawlinkid := le.rawlinkid <> ri.rawlinkid;
    SELF.Diff_street_1 := le.street_1 <> ri.street_1;
    SELF.Diff_street_2 := le.street_2 <> ri.street_2;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_gps_coordinates := le.gps_coordinates <> ri.gps_coordinates;
    SELF.Diff_address_date := le.address_date <> ri.address_date;
    SELF.Diff_address_type := le.address_type <> ri.address_type;
    SELF.Diff_appended_provider_id := le.appended_provider_id <> ri.appended_provider_id;
    SELF.Diff_lnpid := le.lnpid <> ri.lnpid;
    SELF.Diff_business_name := le.business_name <> ri.business_name;
    SELF.Diff_tin := le.tin <> ri.tin;
    SELF.Diff_fein := le.fein <> ri.fein;
    SELF.Diff_npi := le.npi <> ri.npi;
    SELF.Diff_business_type_1 := le.business_type_1 <> ri.business_type_1;
    SELF.Diff_business_type_2 := le.business_type_2 <> ri.business_type_2;
    SELF.Diff_business_date := le.business_date <> ri.business_date;
    SELF.Diff_phone_number := le.phone_number <> ri.phone_number;
    SELF.Diff_cell_phone := le.cell_phone <> ri.cell_phone;
    SELF.Diff_work_phone := le.work_phone <> ri.work_phone;
    SELF.Diff_contact_type := le.contact_type <> ri.contact_type;
    SELF.Diff_contact_date := le.contact_date <> ri.contact_date;
    SELF.Diff_carrier := le.carrier <> ri.carrier;
    SELF.Diff_contact_location := le.contact_location <> ri.contact_location;
    SELF.Diff_contact := le.contact <> ri.contact;
    SELF.Diff_call_records := le.call_records <> ri.call_records;
    SELF.Diff_in_service := le.in_service <> ri.in_service;
    SELF.Diff_email_address := le.email_address <> ri.email_address;
    SELF.Diff_email_address_type := le.email_address_type <> ri.email_address_type;
    SELF.Diff_email_date := le.email_date <> ri.email_date;
    SELF.Diff_host := le.host <> ri.host;
    SELF.Diff_alias := le.alias <> ri.alias;
    SELF.Diff_location := le.location <> ri.location;
    SELF.Diff_ip_address := le.ip_address <> ri.ip_address;
    SELF.Diff_ip_address_date := le.ip_address_date <> ri.ip_address_date;
    SELF.Diff_version := le.version <> ri.version;
    SELF.Diff_class := le.class <> ri.class;
    SELF.Diff_subnet_mask := le.subnet_mask <> ri.subnet_mask;
    SELF.Diff_reserved := le.reserved <> ri.reserved;
    SELF.Diff_isp := le.isp <> ri.isp;
    SELF.Diff_device_id := le.device_id <> ri.device_id;
    SELF.Diff_device_date := le.device_date <> ri.device_date;
    SELF.Diff_unique_number := le.unique_number <> ri.unique_number;
    SELF.Diff_mac_address := le.mac_address <> ri.mac_address;
    SELF.Diff_serial_number := le.serial_number <> ri.serial_number;
    SELF.Diff_device_type := le.device_type <> ri.device_type;
    SELF.Diff_device_identification_provider := le.device_identification_provider <> ri.device_identification_provider;
    SELF.Diff_transaction_id := le.transaction_id <> ri.transaction_id;
    SELF.Diff_transaction_type := le.transaction_type <> ri.transaction_type;
    SELF.Diff_amount_of_loss := le.amount_of_loss <> ri.amount_of_loss;
    SELF.Diff_professional_id := le.professional_id <> ri.professional_id;
    SELF.Diff_profession_type := le.profession_type <> ri.profession_type;
    SELF.Diff_corresponding_professional_ids := le.corresponding_professional_ids <> ri.corresponding_professional_ids;
    SELF.Diff_licensed_pr_state := le.licensed_pr_state <> ri.licensed_pr_state;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_source_rec_id := le.source_rec_id <> ri.source_rec_id;
    SELF.Diff_nid := le.nid <> ri.nid;
    SELF.Diff_name_ind := le.name_ind <> ri.name_ind;
    SELF.Diff_address_1 := le.address_1 <> ri.address_1;
    SELF.Diff_address_2 := le.address_2 <> ri.address_2;
    SELF.Diff_rawaid := le.rawaid <> ri.rawaid;
    SELF.Diff_aceaid := le.aceaid <> ri.aceaid;
    SELF.Diff_address_ind := le.address_ind <> ri.address_ind;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_clean_business_name := le.clean_business_name <> ri.clean_business_name;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_bdid_score := le.bdid_score <> ri.bdid_score;
    SELF.Diff_dotid := le.dotid <> ri.dotid;
    SELF.Diff_dotscore := le.dotscore <> ri.dotscore;
    SELF.Diff_dotweight := le.dotweight <> ri.dotweight;
    SELF.Diff_empid := le.empid <> ri.empid;
    SELF.Diff_empscore := le.empscore <> ri.empscore;
    SELF.Diff_empweight := le.empweight <> ri.empweight;
    SELF.Diff_powid := le.powid <> ri.powid;
    SELF.Diff_powscore := le.powscore <> ri.powscore;
    SELF.Diff_powweight := le.powweight <> ri.powweight;
    SELF.Diff_proxid := le.proxid <> ri.proxid;
    SELF.Diff_proxscore := le.proxscore <> ri.proxscore;
    SELF.Diff_proxweight := le.proxweight <> ri.proxweight;
    SELF.Diff_seleid := le.seleid <> ri.seleid;
    SELF.Diff_selescore := le.selescore <> ri.selescore;
    SELF.Diff_seleweight := le.seleweight <> ri.seleweight;
    SELF.Diff_orgid := le.orgid <> ri.orgid;
    SELF.Diff_orgscore := le.orgscore <> ri.orgscore;
    SELF.Diff_orgweight := le.orgweight <> ri.orgweight;
    SELF.Diff_ultid := le.ultid <> ri.ultid;
    SELF.Diff_ultscore := le.ultscore <> ri.ultscore;
    SELF.Diff_ultweight := le.ultweight <> ri.ultweight;
    SELF.Diff___internal_fpos__ := le.__internal_fpos__ <> ri.__internal_fpos__;
    SELF.Val := (SALT34.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_classification_source_source_type,1,0)+ IF( SELF.Diff_classification_source_primary_source_entity,1,0)+ IF( SELF.Diff_classification_source_expectation_of_victim_entities,1,0)+ IF( SELF.Diff_classification_source_industry_segment,1,0)+ IF( SELF.Diff_classification_activity_suspected_discrepancy,1,0)+ IF( SELF.Diff_classification_activity_confidence_that_activity_was_deceitful,1,0)+ IF( SELF.Diff_classification_activity_workflow_stage_committed,1,0)+ IF( SELF.Diff_classification_activity_workflow_stage_detected,1,0)+ IF( SELF.Diff_classification_activity_channels,1,0)+ IF( SELF.Diff_classification_activity_category_or_fraudtype,1,0)+ IF( SELF.Diff_classification_activity_description,1,0)+ IF( SELF.Diff_classification_activity_threat,1,0)+ IF( SELF.Diff_classification_activity_exposure,1,0)+ IF( SELF.Diff_classification_activity_write_off_loss,1,0)+ IF( SELF.Diff_classification_activity_mitigated,1,0)+ IF( SELF.Diff_classification_activity_alert_level,1,0)+ IF( SELF.Diff_classification_entity_entity_type,1,0)+ IF( SELF.Diff_classification_entity_entity_sub_type,1,0)+ IF( SELF.Diff_classification_entity_role,1,0)+ IF( SELF.Diff_classification_entity_evidence,1,0)+ IF( SELF.Diff_classification_entity_investigated_count,1,0)+ IF( SELF.Diff_classification_permissible_use_access_fdn_file_info_id,1,0)+ IF( SELF.Diff_classification_permissible_use_access_fdn_file_code,1,0)+ IF( SELF.Diff_classification_permissible_use_access_gc_id,1,0)+ IF( SELF.Diff_classification_permissible_use_access_file_type,1,0)+ IF( SELF.Diff_classification_permissible_use_access_description,1,0)+ IF( SELF.Diff_classification_permissible_use_access_primary_source_entity,1,0)+ IF( SELF.Diff_classification_permissible_use_access_ind_type,1,0)+ IF( SELF.Diff_classification_permissible_use_access_ind_type_description,1,0)+ IF( SELF.Diff_classification_permissible_use_access_update_freq,1,0)+ IF( SELF.Diff_classification_permissible_use_access_expiration_days,1,0)+ IF( SELF.Diff_classification_permissible_use_access_post_contract_expiration_days,1,0)+ IF( SELF.Diff_classification_permissible_use_access_status,1,0)+ IF( SELF.Diff_classification_permissible_use_access_product_include,1,0)+ IF( SELF.Diff_classification_permissible_use_access_date_added,1,0)+ IF( SELF.Diff_classification_permissible_use_access_user_added,1,0)+ IF( SELF.Diff_classification_permissible_use_access_date_changed,1,0)+ IF( SELF.Diff_classification_permissible_use_access_user_changed,1,0)+ IF( SELF.Diff_classification_permissible_use_access_p_industry_segment,1,0)+ IF( SELF.Diff_classification_permissible_use_access_usage_term,1,0)+ IF( SELF.Diff_cleaned_name_title,1,0)+ IF( SELF.Diff_cleaned_name_fname,1,0)+ IF( SELF.Diff_cleaned_name_mname,1,0)+ IF( SELF.Diff_cleaned_name_lname,1,0)+ IF( SELF.Diff_cleaned_name_name_suffix,1,0)+ IF( SELF.Diff_cleaned_name_name_score,1,0)+ IF( SELF.Diff_clean_address_prim_range,1,0)+ IF( SELF.Diff_clean_address_predir,1,0)+ IF( SELF.Diff_clean_address_prim_name,1,0)+ IF( SELF.Diff_clean_address_addr_suffix,1,0)+ IF( SELF.Diff_clean_address_postdir,1,0)+ IF( SELF.Diff_clean_address_unit_desig,1,0)+ IF( SELF.Diff_clean_address_sec_range,1,0)+ IF( SELF.Diff_clean_address_p_city_name,1,0)+ IF( SELF.Diff_clean_address_v_city_name,1,0)+ IF( SELF.Diff_clean_address_st,1,0)+ IF( SELF.Diff_clean_address_zip,1,0)+ IF( SELF.Diff_clean_address_zip4,1,0)+ IF( SELF.Diff_clean_address_cart,1,0)+ IF( SELF.Diff_clean_address_cr_sort_sz,1,0)+ IF( SELF.Diff_clean_address_lot,1,0)+ IF( SELF.Diff_clean_address_lot_order,1,0)+ IF( SELF.Diff_clean_address_dbpc,1,0)+ IF( SELF.Diff_clean_address_chk_digit,1,0)+ IF( SELF.Diff_clean_address_rec_type,1,0)+ IF( SELF.Diff_clean_address_fips_state,1,0)+ IF( SELF.Diff_clean_address_fips_county,1,0)+ IF( SELF.Diff_clean_address_geo_lat,1,0)+ IF( SELF.Diff_clean_address_geo_long,1,0)+ IF( SELF.Diff_clean_address_msa,1,0)+ IF( SELF.Diff_clean_address_geo_blk,1,0)+ IF( SELF.Diff_clean_address_geo_match,1,0)+ IF( SELF.Diff_clean_address_err_stat,1,0)+ IF( SELF.Diff_clean_phones_phone_number,1,0)+ IF( SELF.Diff_clean_phones_cell_phone,1,0)+ IF( SELF.Diff_clean_phones_work_phone,1,0)+ IF( SELF.Diff_record_id,1,0)+ IF( SELF.Diff_uid,1,0)+ IF( SELF.Diff_customer_id,1,0)+ IF( SELF.Diff_sub_customer_id,1,0)+ IF( SELF.Diff_vendor_id,1,0)+ IF( SELF.Diff_offender_key,1,0)+ IF( SELF.Diff_sub_sub_customer_id,1,0)+ IF( SELF.Diff_customer_event_id,1,0)+ IF( SELF.Diff_sub_customer_event_id,1,0)+ IF( SELF.Diff_sub_sub_customer_event_id,1,0)+ IF( SELF.Diff_ln_product_id,1,0)+ IF( SELF.Diff_ln_sub_product_id,1,0)+ IF( SELF.Diff_ln_sub_sub_product_id,1,0)+ IF( SELF.Diff_ln_product_key,1,0)+ IF( SELF.Diff_ln_report_date,1,0)+ IF( SELF.Diff_ln_report_time,1,0)+ IF( SELF.Diff_reported_date,1,0)+ IF( SELF.Diff_reported_time,1,0)+ IF( SELF.Diff_event_date,1,0)+ IF( SELF.Diff_event_end_date,1,0)+ IF( SELF.Diff_event_location,1,0)+ IF( SELF.Diff_event_type_1,1,0)+ IF( SELF.Diff_event_type_2,1,0)+ IF( SELF.Diff_event_type_3,1,0)+ IF( SELF.Diff_household_id,1,0)+ IF( SELF.Diff_reason_description,1,0)+ IF( SELF.Diff_investigation_referral_case_id,1,0)+ IF( SELF.Diff_investigation_referral_date_opened,1,0)+ IF( SELF.Diff_investigation_referral_date_closed,1,0)+ IF( SELF.Diff_customer_fraud_code_1,1,0)+ IF( SELF.Diff_customer_fraud_code_2,1,0)+ IF( SELF.Diff_type_of_referral,1,0)+ IF( SELF.Diff_referral_reason,1,0)+ IF( SELF.Diff_disposition,1,0)+ IF( SELF.Diff_mitigated,1,0)+ IF( SELF.Diff_mitigated_amount,1,0)+ IF( SELF.Diff_external_referral_or_casenumber,1,0)+ IF( SELF.Diff_fraud_point_score,1,0)+ IF( SELF.Diff_customer_person_id,1,0)+ IF( SELF.Diff_raw_title,1,0)+ IF( SELF.Diff_raw_first_name,1,0)+ IF( SELF.Diff_raw_middle_name,1,0)+ IF( SELF.Diff_raw_last_name,1,0)+ IF( SELF.Diff_raw_orig_suffix,1,0)+ IF( SELF.Diff_raw_full_name,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_drivers_license,1,0)+ IF( SELF.Diff_drivers_license_state,1,0)+ IF( SELF.Diff_person_date,1,0)+ IF( SELF.Diff_name_type,1,0)+ IF( SELF.Diff_income,1,0)+ IF( SELF.Diff_own_or_rent,1,0)+ IF( SELF.Diff_rawlinkid,1,0)+ IF( SELF.Diff_street_1,1,0)+ IF( SELF.Diff_street_2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_gps_coordinates,1,0)+ IF( SELF.Diff_address_date,1,0)+ IF( SELF.Diff_address_type,1,0)+ IF( SELF.Diff_appended_provider_id,1,0)+ IF( SELF.Diff_lnpid,1,0)+ IF( SELF.Diff_business_name,1,0)+ IF( SELF.Diff_tin,1,0)+ IF( SELF.Diff_fein,1,0)+ IF( SELF.Diff_npi,1,0)+ IF( SELF.Diff_business_type_1,1,0)+ IF( SELF.Diff_business_type_2,1,0)+ IF( SELF.Diff_business_date,1,0)+ IF( SELF.Diff_phone_number,1,0)+ IF( SELF.Diff_cell_phone,1,0)+ IF( SELF.Diff_work_phone,1,0)+ IF( SELF.Diff_contact_type,1,0)+ IF( SELF.Diff_contact_date,1,0)+ IF( SELF.Diff_carrier,1,0)+ IF( SELF.Diff_contact_location,1,0)+ IF( SELF.Diff_contact,1,0)+ IF( SELF.Diff_call_records,1,0)+ IF( SELF.Diff_in_service,1,0)+ IF( SELF.Diff_email_address,1,0)+ IF( SELF.Diff_email_address_type,1,0)+ IF( SELF.Diff_email_date,1,0)+ IF( SELF.Diff_host,1,0)+ IF( SELF.Diff_alias,1,0)+ IF( SELF.Diff_location,1,0)+ IF( SELF.Diff_ip_address,1,0)+ IF( SELF.Diff_ip_address_date,1,0)+ IF( SELF.Diff_version,1,0)+ IF( SELF.Diff_class,1,0)+ IF( SELF.Diff_subnet_mask,1,0)+ IF( SELF.Diff_reserved,1,0)+ IF( SELF.Diff_isp,1,0)+ IF( SELF.Diff_device_id,1,0)+ IF( SELF.Diff_device_date,1,0)+ IF( SELF.Diff_unique_number,1,0)+ IF( SELF.Diff_mac_address,1,0)+ IF( SELF.Diff_serial_number,1,0)+ IF( SELF.Diff_device_type,1,0)+ IF( SELF.Diff_device_identification_provider,1,0)+ IF( SELF.Diff_transaction_id,1,0)+ IF( SELF.Diff_transaction_type,1,0)+ IF( SELF.Diff_amount_of_loss,1,0)+ IF( SELF.Diff_professional_id,1,0)+ IF( SELF.Diff_profession_type,1,0)+ IF( SELF.Diff_corresponding_professional_ids,1,0)+ IF( SELF.Diff_licensed_pr_state,1,0)+ IF( SELF.Diff_source,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_source_rec_id,1,0)+ IF( SELF.Diff_nid,1,0)+ IF( SELF.Diff_name_ind,1,0)+ IF( SELF.Diff_address_1,1,0)+ IF( SELF.Diff_address_2,1,0)+ IF( SELF.Diff_rawaid,1,0)+ IF( SELF.Diff_aceaid,1,0)+ IF( SELF.Diff_address_ind,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_clean_business_name,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_bdid_score,1,0)+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0)+ IF( SELF.Diff___internal_fpos__,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_classification_source_source_type := COUNT(GROUP,%Closest%.Diff_classification_source_source_type);
    Count_Diff_classification_source_primary_source_entity := COUNT(GROUP,%Closest%.Diff_classification_source_primary_source_entity);
    Count_Diff_classification_source_expectation_of_victim_entities := COUNT(GROUP,%Closest%.Diff_classification_source_expectation_of_victim_entities);
    Count_Diff_classification_source_industry_segment := COUNT(GROUP,%Closest%.Diff_classification_source_industry_segment);
    Count_Diff_classification_activity_suspected_discrepancy := COUNT(GROUP,%Closest%.Diff_classification_activity_suspected_discrepancy);
    Count_Diff_classification_activity_confidence_that_activity_was_deceitful := COUNT(GROUP,%Closest%.Diff_classification_activity_confidence_that_activity_was_deceitful);
    Count_Diff_classification_activity_workflow_stage_committed := COUNT(GROUP,%Closest%.Diff_classification_activity_workflow_stage_committed);
    Count_Diff_classification_activity_workflow_stage_detected := COUNT(GROUP,%Closest%.Diff_classification_activity_workflow_stage_detected);
    Count_Diff_classification_activity_channels := COUNT(GROUP,%Closest%.Diff_classification_activity_channels);
    Count_Diff_classification_activity_category_or_fraudtype := COUNT(GROUP,%Closest%.Diff_classification_activity_category_or_fraudtype);
    Count_Diff_classification_activity_description := COUNT(GROUP,%Closest%.Diff_classification_activity_description);
    Count_Diff_classification_activity_threat := COUNT(GROUP,%Closest%.Diff_classification_activity_threat);
    Count_Diff_classification_activity_exposure := COUNT(GROUP,%Closest%.Diff_classification_activity_exposure);
    Count_Diff_classification_activity_write_off_loss := COUNT(GROUP,%Closest%.Diff_classification_activity_write_off_loss);
    Count_Diff_classification_activity_mitigated := COUNT(GROUP,%Closest%.Diff_classification_activity_mitigated);
    Count_Diff_classification_activity_alert_level := COUNT(GROUP,%Closest%.Diff_classification_activity_alert_level);
    Count_Diff_classification_entity_entity_type := COUNT(GROUP,%Closest%.Diff_classification_entity_entity_type);
    Count_Diff_classification_entity_entity_sub_type := COUNT(GROUP,%Closest%.Diff_classification_entity_entity_sub_type);
    Count_Diff_classification_entity_role := COUNT(GROUP,%Closest%.Diff_classification_entity_role);
    Count_Diff_classification_entity_evidence := COUNT(GROUP,%Closest%.Diff_classification_entity_evidence);
    Count_Diff_classification_entity_investigated_count := COUNT(GROUP,%Closest%.Diff_classification_entity_investigated_count);
    Count_Diff_classification_permissible_use_access_fdn_file_info_id := COUNT(GROUP,%Closest%.Diff_classification_permissible_use_access_fdn_file_info_id);
    Count_Diff_classification_permissible_use_access_fdn_file_code := COUNT(GROUP,%Closest%.Diff_classification_permissible_use_access_fdn_file_code);
    Count_Diff_classification_permissible_use_access_gc_id := COUNT(GROUP,%Closest%.Diff_classification_permissible_use_access_gc_id);
    Count_Diff_classification_permissible_use_access_file_type := COUNT(GROUP,%Closest%.Diff_classification_permissible_use_access_file_type);
    Count_Diff_classification_permissible_use_access_description := COUNT(GROUP,%Closest%.Diff_classification_permissible_use_access_description);
    Count_Diff_classification_permissible_use_access_primary_source_entity := COUNT(GROUP,%Closest%.Diff_classification_permissible_use_access_primary_source_entity);
    Count_Diff_classification_permissible_use_access_ind_type := COUNT(GROUP,%Closest%.Diff_classification_permissible_use_access_ind_type);
    Count_Diff_classification_permissible_use_access_ind_type_description := COUNT(GROUP,%Closest%.Diff_classification_permissible_use_access_ind_type_description);
    Count_Diff_classification_permissible_use_access_update_freq := COUNT(GROUP,%Closest%.Diff_classification_permissible_use_access_update_freq);
    Count_Diff_classification_permissible_use_access_expiration_days := COUNT(GROUP,%Closest%.Diff_classification_permissible_use_access_expiration_days);
    Count_Diff_classification_permissible_use_access_post_contract_expiration_days := COUNT(GROUP,%Closest%.Diff_classification_permissible_use_access_post_contract_expiration_days);
    Count_Diff_classification_permissible_use_access_status := COUNT(GROUP,%Closest%.Diff_classification_permissible_use_access_status);
    Count_Diff_classification_permissible_use_access_product_include := COUNT(GROUP,%Closest%.Diff_classification_permissible_use_access_product_include);
    Count_Diff_classification_permissible_use_access_date_added := COUNT(GROUP,%Closest%.Diff_classification_permissible_use_access_date_added);
    Count_Diff_classification_permissible_use_access_user_added := COUNT(GROUP,%Closest%.Diff_classification_permissible_use_access_user_added);
    Count_Diff_classification_permissible_use_access_date_changed := COUNT(GROUP,%Closest%.Diff_classification_permissible_use_access_date_changed);
    Count_Diff_classification_permissible_use_access_user_changed := COUNT(GROUP,%Closest%.Diff_classification_permissible_use_access_user_changed);
    Count_Diff_classification_permissible_use_access_p_industry_segment := COUNT(GROUP,%Closest%.Diff_classification_permissible_use_access_p_industry_segment);
    Count_Diff_classification_permissible_use_access_usage_term := COUNT(GROUP,%Closest%.Diff_classification_permissible_use_access_usage_term);
    Count_Diff_cleaned_name_title := COUNT(GROUP,%Closest%.Diff_cleaned_name_title);
    Count_Diff_cleaned_name_fname := COUNT(GROUP,%Closest%.Diff_cleaned_name_fname);
    Count_Diff_cleaned_name_mname := COUNT(GROUP,%Closest%.Diff_cleaned_name_mname);
    Count_Diff_cleaned_name_lname := COUNT(GROUP,%Closest%.Diff_cleaned_name_lname);
    Count_Diff_cleaned_name_name_suffix := COUNT(GROUP,%Closest%.Diff_cleaned_name_name_suffix);
    Count_Diff_cleaned_name_name_score := COUNT(GROUP,%Closest%.Diff_cleaned_name_name_score);
    Count_Diff_clean_address_prim_range := COUNT(GROUP,%Closest%.Diff_clean_address_prim_range);
    Count_Diff_clean_address_predir := COUNT(GROUP,%Closest%.Diff_clean_address_predir);
    Count_Diff_clean_address_prim_name := COUNT(GROUP,%Closest%.Diff_clean_address_prim_name);
    Count_Diff_clean_address_addr_suffix := COUNT(GROUP,%Closest%.Diff_clean_address_addr_suffix);
    Count_Diff_clean_address_postdir := COUNT(GROUP,%Closest%.Diff_clean_address_postdir);
    Count_Diff_clean_address_unit_desig := COUNT(GROUP,%Closest%.Diff_clean_address_unit_desig);
    Count_Diff_clean_address_sec_range := COUNT(GROUP,%Closest%.Diff_clean_address_sec_range);
    Count_Diff_clean_address_p_city_name := COUNT(GROUP,%Closest%.Diff_clean_address_p_city_name);
    Count_Diff_clean_address_v_city_name := COUNT(GROUP,%Closest%.Diff_clean_address_v_city_name);
    Count_Diff_clean_address_st := COUNT(GROUP,%Closest%.Diff_clean_address_st);
    Count_Diff_clean_address_zip := COUNT(GROUP,%Closest%.Diff_clean_address_zip);
    Count_Diff_clean_address_zip4 := COUNT(GROUP,%Closest%.Diff_clean_address_zip4);
    Count_Diff_clean_address_cart := COUNT(GROUP,%Closest%.Diff_clean_address_cart);
    Count_Diff_clean_address_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_clean_address_cr_sort_sz);
    Count_Diff_clean_address_lot := COUNT(GROUP,%Closest%.Diff_clean_address_lot);
    Count_Diff_clean_address_lot_order := COUNT(GROUP,%Closest%.Diff_clean_address_lot_order);
    Count_Diff_clean_address_dbpc := COUNT(GROUP,%Closest%.Diff_clean_address_dbpc);
    Count_Diff_clean_address_chk_digit := COUNT(GROUP,%Closest%.Diff_clean_address_chk_digit);
    Count_Diff_clean_address_rec_type := COUNT(GROUP,%Closest%.Diff_clean_address_rec_type);
    Count_Diff_clean_address_fips_state := COUNT(GROUP,%Closest%.Diff_clean_address_fips_state);
    Count_Diff_clean_address_fips_county := COUNT(GROUP,%Closest%.Diff_clean_address_fips_county);
    Count_Diff_clean_address_geo_lat := COUNT(GROUP,%Closest%.Diff_clean_address_geo_lat);
    Count_Diff_clean_address_geo_long := COUNT(GROUP,%Closest%.Diff_clean_address_geo_long);
    Count_Diff_clean_address_msa := COUNT(GROUP,%Closest%.Diff_clean_address_msa);
    Count_Diff_clean_address_geo_blk := COUNT(GROUP,%Closest%.Diff_clean_address_geo_blk);
    Count_Diff_clean_address_geo_match := COUNT(GROUP,%Closest%.Diff_clean_address_geo_match);
    Count_Diff_clean_address_err_stat := COUNT(GROUP,%Closest%.Diff_clean_address_err_stat);
    Count_Diff_clean_phones_phone_number := COUNT(GROUP,%Closest%.Diff_clean_phones_phone_number);
    Count_Diff_clean_phones_cell_phone := COUNT(GROUP,%Closest%.Diff_clean_phones_cell_phone);
    Count_Diff_clean_phones_work_phone := COUNT(GROUP,%Closest%.Diff_clean_phones_work_phone);
    Count_Diff_record_id := COUNT(GROUP,%Closest%.Diff_record_id);
    Count_Diff_uid := COUNT(GROUP,%Closest%.Diff_uid);
    Count_Diff_customer_id := COUNT(GROUP,%Closest%.Diff_customer_id);
    Count_Diff_sub_customer_id := COUNT(GROUP,%Closest%.Diff_sub_customer_id);
    Count_Diff_vendor_id := COUNT(GROUP,%Closest%.Diff_vendor_id);
    Count_Diff_offender_key := COUNT(GROUP,%Closest%.Diff_offender_key);
    Count_Diff_sub_sub_customer_id := COUNT(GROUP,%Closest%.Diff_sub_sub_customer_id);
    Count_Diff_customer_event_id := COUNT(GROUP,%Closest%.Diff_customer_event_id);
    Count_Diff_sub_customer_event_id := COUNT(GROUP,%Closest%.Diff_sub_customer_event_id);
    Count_Diff_sub_sub_customer_event_id := COUNT(GROUP,%Closest%.Diff_sub_sub_customer_event_id);
    Count_Diff_ln_product_id := COUNT(GROUP,%Closest%.Diff_ln_product_id);
    Count_Diff_ln_sub_product_id := COUNT(GROUP,%Closest%.Diff_ln_sub_product_id);
    Count_Diff_ln_sub_sub_product_id := COUNT(GROUP,%Closest%.Diff_ln_sub_sub_product_id);
    Count_Diff_ln_product_key := COUNT(GROUP,%Closest%.Diff_ln_product_key);
    Count_Diff_ln_report_date := COUNT(GROUP,%Closest%.Diff_ln_report_date);
    Count_Diff_ln_report_time := COUNT(GROUP,%Closest%.Diff_ln_report_time);
    Count_Diff_reported_date := COUNT(GROUP,%Closest%.Diff_reported_date);
    Count_Diff_reported_time := COUNT(GROUP,%Closest%.Diff_reported_time);
    Count_Diff_event_date := COUNT(GROUP,%Closest%.Diff_event_date);
    Count_Diff_event_end_date := COUNT(GROUP,%Closest%.Diff_event_end_date);
    Count_Diff_event_location := COUNT(GROUP,%Closest%.Diff_event_location);
    Count_Diff_event_type_1 := COUNT(GROUP,%Closest%.Diff_event_type_1);
    Count_Diff_event_type_2 := COUNT(GROUP,%Closest%.Diff_event_type_2);
    Count_Diff_event_type_3 := COUNT(GROUP,%Closest%.Diff_event_type_3);
    Count_Diff_household_id := COUNT(GROUP,%Closest%.Diff_household_id);
    Count_Diff_reason_description := COUNT(GROUP,%Closest%.Diff_reason_description);
    Count_Diff_investigation_referral_case_id := COUNT(GROUP,%Closest%.Diff_investigation_referral_case_id);
    Count_Diff_investigation_referral_date_opened := COUNT(GROUP,%Closest%.Diff_investigation_referral_date_opened);
    Count_Diff_investigation_referral_date_closed := COUNT(GROUP,%Closest%.Diff_investigation_referral_date_closed);
    Count_Diff_customer_fraud_code_1 := COUNT(GROUP,%Closest%.Diff_customer_fraud_code_1);
    Count_Diff_customer_fraud_code_2 := COUNT(GROUP,%Closest%.Diff_customer_fraud_code_2);
    Count_Diff_type_of_referral := COUNT(GROUP,%Closest%.Diff_type_of_referral);
    Count_Diff_referral_reason := COUNT(GROUP,%Closest%.Diff_referral_reason);
    Count_Diff_disposition := COUNT(GROUP,%Closest%.Diff_disposition);
    Count_Diff_mitigated := COUNT(GROUP,%Closest%.Diff_mitigated);
    Count_Diff_mitigated_amount := COUNT(GROUP,%Closest%.Diff_mitigated_amount);
    Count_Diff_external_referral_or_casenumber := COUNT(GROUP,%Closest%.Diff_external_referral_or_casenumber);
    Count_Diff_fraud_point_score := COUNT(GROUP,%Closest%.Diff_fraud_point_score);
    Count_Diff_customer_person_id := COUNT(GROUP,%Closest%.Diff_customer_person_id);
    Count_Diff_raw_title := COUNT(GROUP,%Closest%.Diff_raw_title);
    Count_Diff_raw_first_name := COUNT(GROUP,%Closest%.Diff_raw_first_name);
    Count_Diff_raw_middle_name := COUNT(GROUP,%Closest%.Diff_raw_middle_name);
    Count_Diff_raw_last_name := COUNT(GROUP,%Closest%.Diff_raw_last_name);
    Count_Diff_raw_orig_suffix := COUNT(GROUP,%Closest%.Diff_raw_orig_suffix);
    Count_Diff_raw_full_name := COUNT(GROUP,%Closest%.Diff_raw_full_name);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_drivers_license := COUNT(GROUP,%Closest%.Diff_drivers_license);
    Count_Diff_drivers_license_state := COUNT(GROUP,%Closest%.Diff_drivers_license_state);
    Count_Diff_person_date := COUNT(GROUP,%Closest%.Diff_person_date);
    Count_Diff_name_type := COUNT(GROUP,%Closest%.Diff_name_type);
    Count_Diff_income := COUNT(GROUP,%Closest%.Diff_income);
    Count_Diff_own_or_rent := COUNT(GROUP,%Closest%.Diff_own_or_rent);
    Count_Diff_rawlinkid := COUNT(GROUP,%Closest%.Diff_rawlinkid);
    Count_Diff_street_1 := COUNT(GROUP,%Closest%.Diff_street_1);
    Count_Diff_street_2 := COUNT(GROUP,%Closest%.Diff_street_2);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_gps_coordinates := COUNT(GROUP,%Closest%.Diff_gps_coordinates);
    Count_Diff_address_date := COUNT(GROUP,%Closest%.Diff_address_date);
    Count_Diff_address_type := COUNT(GROUP,%Closest%.Diff_address_type);
    Count_Diff_appended_provider_id := COUNT(GROUP,%Closest%.Diff_appended_provider_id);
    Count_Diff_lnpid := COUNT(GROUP,%Closest%.Diff_lnpid);
    Count_Diff_business_name := COUNT(GROUP,%Closest%.Diff_business_name);
    Count_Diff_tin := COUNT(GROUP,%Closest%.Diff_tin);
    Count_Diff_fein := COUNT(GROUP,%Closest%.Diff_fein);
    Count_Diff_npi := COUNT(GROUP,%Closest%.Diff_npi);
    Count_Diff_business_type_1 := COUNT(GROUP,%Closest%.Diff_business_type_1);
    Count_Diff_business_type_2 := COUNT(GROUP,%Closest%.Diff_business_type_2);
    Count_Diff_business_date := COUNT(GROUP,%Closest%.Diff_business_date);
    Count_Diff_phone_number := COUNT(GROUP,%Closest%.Diff_phone_number);
    Count_Diff_cell_phone := COUNT(GROUP,%Closest%.Diff_cell_phone);
    Count_Diff_work_phone := COUNT(GROUP,%Closest%.Diff_work_phone);
    Count_Diff_contact_type := COUNT(GROUP,%Closest%.Diff_contact_type);
    Count_Diff_contact_date := COUNT(GROUP,%Closest%.Diff_contact_date);
    Count_Diff_carrier := COUNT(GROUP,%Closest%.Diff_carrier);
    Count_Diff_contact_location := COUNT(GROUP,%Closest%.Diff_contact_location);
    Count_Diff_contact := COUNT(GROUP,%Closest%.Diff_contact);
    Count_Diff_call_records := COUNT(GROUP,%Closest%.Diff_call_records);
    Count_Diff_in_service := COUNT(GROUP,%Closest%.Diff_in_service);
    Count_Diff_email_address := COUNT(GROUP,%Closest%.Diff_email_address);
    Count_Diff_email_address_type := COUNT(GROUP,%Closest%.Diff_email_address_type);
    Count_Diff_email_date := COUNT(GROUP,%Closest%.Diff_email_date);
    Count_Diff_host := COUNT(GROUP,%Closest%.Diff_host);
    Count_Diff_alias := COUNT(GROUP,%Closest%.Diff_alias);
    Count_Diff_location := COUNT(GROUP,%Closest%.Diff_location);
    Count_Diff_ip_address := COUNT(GROUP,%Closest%.Diff_ip_address);
    Count_Diff_ip_address_date := COUNT(GROUP,%Closest%.Diff_ip_address_date);
    Count_Diff_version := COUNT(GROUP,%Closest%.Diff_version);
    Count_Diff_class := COUNT(GROUP,%Closest%.Diff_class);
    Count_Diff_subnet_mask := COUNT(GROUP,%Closest%.Diff_subnet_mask);
    Count_Diff_reserved := COUNT(GROUP,%Closest%.Diff_reserved);
    Count_Diff_isp := COUNT(GROUP,%Closest%.Diff_isp);
    Count_Diff_device_id := COUNT(GROUP,%Closest%.Diff_device_id);
    Count_Diff_device_date := COUNT(GROUP,%Closest%.Diff_device_date);
    Count_Diff_unique_number := COUNT(GROUP,%Closest%.Diff_unique_number);
    Count_Diff_mac_address := COUNT(GROUP,%Closest%.Diff_mac_address);
    Count_Diff_serial_number := COUNT(GROUP,%Closest%.Diff_serial_number);
    Count_Diff_device_type := COUNT(GROUP,%Closest%.Diff_device_type);
    Count_Diff_device_identification_provider := COUNT(GROUP,%Closest%.Diff_device_identification_provider);
    Count_Diff_transaction_id := COUNT(GROUP,%Closest%.Diff_transaction_id);
    Count_Diff_transaction_type := COUNT(GROUP,%Closest%.Diff_transaction_type);
    Count_Diff_amount_of_loss := COUNT(GROUP,%Closest%.Diff_amount_of_loss);
    Count_Diff_professional_id := COUNT(GROUP,%Closest%.Diff_professional_id);
    Count_Diff_profession_type := COUNT(GROUP,%Closest%.Diff_profession_type);
    Count_Diff_corresponding_professional_ids := COUNT(GROUP,%Closest%.Diff_corresponding_professional_ids);
    Count_Diff_licensed_pr_state := COUNT(GROUP,%Closest%.Diff_licensed_pr_state);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_source_rec_id := COUNT(GROUP,%Closest%.Diff_source_rec_id);
    Count_Diff_nid := COUNT(GROUP,%Closest%.Diff_nid);
    Count_Diff_name_ind := COUNT(GROUP,%Closest%.Diff_name_ind);
    Count_Diff_address_1 := COUNT(GROUP,%Closest%.Diff_address_1);
    Count_Diff_address_2 := COUNT(GROUP,%Closest%.Diff_address_2);
    Count_Diff_rawaid := COUNT(GROUP,%Closest%.Diff_rawaid);
    Count_Diff_aceaid := COUNT(GROUP,%Closest%.Diff_aceaid);
    Count_Diff_address_ind := COUNT(GROUP,%Closest%.Diff_address_ind);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_clean_business_name := COUNT(GROUP,%Closest%.Diff_clean_business_name);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_bdid_score := COUNT(GROUP,%Closest%.Diff_bdid_score);
    Count_Diff_dotid := COUNT(GROUP,%Closest%.Diff_dotid);
    Count_Diff_dotscore := COUNT(GROUP,%Closest%.Diff_dotscore);
    Count_Diff_dotweight := COUNT(GROUP,%Closest%.Diff_dotweight);
    Count_Diff_empid := COUNT(GROUP,%Closest%.Diff_empid);
    Count_Diff_empscore := COUNT(GROUP,%Closest%.Diff_empscore);
    Count_Diff_empweight := COUNT(GROUP,%Closest%.Diff_empweight);
    Count_Diff_powid := COUNT(GROUP,%Closest%.Diff_powid);
    Count_Diff_powscore := COUNT(GROUP,%Closest%.Diff_powscore);
    Count_Diff_powweight := COUNT(GROUP,%Closest%.Diff_powweight);
    Count_Diff_proxid := COUNT(GROUP,%Closest%.Diff_proxid);
    Count_Diff_proxscore := COUNT(GROUP,%Closest%.Diff_proxscore);
    Count_Diff_proxweight := COUNT(GROUP,%Closest%.Diff_proxweight);
    Count_Diff_seleid := COUNT(GROUP,%Closest%.Diff_seleid);
    Count_Diff_selescore := COUNT(GROUP,%Closest%.Diff_selescore);
    Count_Diff_seleweight := COUNT(GROUP,%Closest%.Diff_seleweight);
    Count_Diff_orgid := COUNT(GROUP,%Closest%.Diff_orgid);
    Count_Diff_orgscore := COUNT(GROUP,%Closest%.Diff_orgscore);
    Count_Diff_orgweight := COUNT(GROUP,%Closest%.Diff_orgweight);
    Count_Diff_ultid := COUNT(GROUP,%Closest%.Diff_ultid);
    Count_Diff_ultscore := COUNT(GROUP,%Closest%.Diff_ultscore);
    Count_Diff_ultweight := COUNT(GROUP,%Closest%.Diff_ultweight);
    Count_Diff___internal_fpos__ := COUNT(GROUP,%Closest%.Diff___internal_fpos__);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
