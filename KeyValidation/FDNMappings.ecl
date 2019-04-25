EXPORT FDNMappings := module

		//DID Key
		export DIDKeyName := 'DID';
		export DIDKeyType := 'Search Key';
		export DIDKeySet := ['uid', 'record_id'];
		export DIDParentSet := ['left.uid', 'left.record_id'];
		export DIDIgnoredFields := ['did', 'qa_defined_empty'];
		export DIDUniqueField := ['record_id'];
		export DIDParentName := 'FDNDS';
		
		//Email Key
		export EmailKeyName := 'Email';
		export EmailKeyType := 'Search Key';
		export EmailKeySet := ['email_address', 'record_id', 'uid'];
		export EmailParentSet := ['left.email_address', 'left.record_id', 'left.uid'];
		export EmailIgnoredFields := ['qa_defined_empty'];
		export EmailUniqueField := ['record_id'];
		export EmailParentName := 'FDNDS';
		
		//IP Key
		export IPKeyName := 'IP';
		export IPKeyType := 'Search Key';
		export IPKeySet := ['ip_address', 'record_id', 'uid'];
		export IPParentSet := ['left.ip_address', 'left.record_id', 'left.uid'];
		export IPIgnoredFields := ['qa_defined_empty'];
		export IPUniqueField := ['record_id'];
		export IPParentName := 'FDNDS';
		
		
		//ID Key
		export IDKeyName := 'ID';
		export IDKeyType := 'Payload Key';
		export IDKeySet := [ 'record_id', 'uid', 'customer_id', 'sub_customer_id', 'vendor_id', 'offender_key', 'sub_sub_customer_id', 'customer_event_id', 'sub_customer_event_id', 
		'sub_sub_customer_event_id', 'ln_product_id', 'ln_sub_product_id', 'ln_sub_sub_product_id', 'ln_product_key', 'ln_report_date', 'ln_report_time', 
		'reported_date', 'reported_time', 'event_date', 'event_end_date', 'event_location', 'event_type_1', 'event_type_2', 'event_type_3', 'household_id', 
		'reason_description', 'investigation_referral_case_id', 'investigation_referral_date_opened', 'investigation_referral_date_closed', 'customer_fraud_code_1', 
		'customer_fraud_code_2', 'type_of_referral', 'referral_reason', 'disposition', 'mitigated', 'mitigated_amount', 'external_referral_or_casenumber', 
		'fraud_point_score', 'customer_person_id', 'raw_title', 'raw_first_name', 'raw_middle_name', 'raw_last_name', 'raw_orig_suffix', 'raw_full_name', 
		'ssn', 'dob', 'drivers_license', 'drivers_license_state', 'person_date', 'name_type', 'income', 'own_or_rent', 'rawlinkid', 'street_1', 'street_2', 'city', 
		'state', 'zip', 'gps_coordinates', 'address_date', 'address_type', 'appended_provider_id', 'business_name', 'tin', 'fein', 'npi', 'business_type_1', 
		'business_type_2', 'business_date', 'phone_number', 'cell_phone', 'work_phone', 'contact_type', 'contact_date', 'carrier', 'contact_location', 'contact',
		'call_records', 'in_service', 'email_address', 'email_address_type', 'email_date', 'host', 'alias', 'location', 'ip_address', 'ip_address_date', 'version', 'class', 
		'subnet_mask', 'reserved', 'isp', 'device_id', 'device_date', 'unique_number', 'mac_address', 'serial_number', 'device_type', 'device_identification_provider', 
		'transaction_id', 'transaction_type', 'amount_of_loss', 'professional_id', 'profession_type', 'corresponding_professional_ids', 'licensed_pr_state', 'source', 
		'process_date', 'dt_first_seen', 'dt_last_seen', 'dt_vendor_last_reported', 'dt_vendor_first_reported', 'source_rec_id', 'nid', 'name_ind', 'address_1', 
		'address_2', 'rawaid', 'aceaid', 'address_ind',  'did_score', 'clean_business_name', 'bdid', 'bdid_score', 'dotid', 'dotscore', 'dotweight', 'empid', 
		'empscore', 'empweight', 'powid', 'powscore', 'powweight', 'proxid', 'proxscore', 'proxweight', 'seleid', 'selescore', 'seleweight', 'orgid', 'orgscore', 
		'orgweight', 'ultid', 'ultscore', 'ultweight', 'classification_source__source_type', 'classification_source__primary_source_entity', 
		'classification_source__expectation_of_victim_entities', 'classification_source__industry_segment', 'classification_activity__suspected_discrepancy', 
		'classification_activity__confidence_that_activity_was_deceitful', 'classification_activity__workflow_stage_committed', 
		'classification_activity__workflow_stage_detected', 'classification_activity__channels', 'classification_activity__category_or_fraudtype',
		 'classification_activity__description', 'classification_activity__threat', 'classification_activity__exposure', 'classification_activity__write_off_loss',
		 'classification_activity__mitigated', 'classification_activity__alert_level', 'classification_entity__entity_type', 'classification_entity__entity_sub_type',
		 'classification_entity__role', 'classification_entity__evidence', 'classification_entity__investigated_count', 'classification_permissible_use_access__fdn_file_info_id',
		 'classification_permissible_use_access__fdn_file_code', 'classification_permissible_use_access__gc_id', 'classification_permissible_use_access__file_type',
		 'classification_permissible_use_access__description', 'classification_permissible_use_access__primary_source_entity',
		 'classification_permissible_use_access__ind_type', 'classification_permissible_use_access__ind_type_description',
		 'classification_permissible_use_access__update_freq', 'classification_permissible_use_access__expiration_days',
		 'classification_permissible_use_access__post_contract_expiration_days', 'classification_permissible_use_access__status',
		 'classification_permissible_use_access__product_include', 'classification_permissible_use_access__date_added', 
		 'classification_permissible_use_access__user_added', 'classification_permissible_use_access__date_changed', 
		 'classification_permissible_use_access__user_changed', 'classification_permissible_use_access__p_industry_segment', 
		 'classification_permissible_use_access__usage_term', 'cleaned_name__title', 'cleaned_name__fname', 'cleaned_name__mname', 'cleaned_name__lname',
		 'cleaned_name__name_suffix', 'cleaned_name__name_score', 'clean_address__prim_range', 'clean_address__predir', 'clean_address__prim_name', 
		 'clean_address__addr_suffix', 'clean_address__postdir', 'clean_address__unit_desig', 'clean_address__sec_range', 'clean_address__p_city_name',
		 'clean_address__v_city_name', 'clean_address__st', 'clean_address__zip', 'clean_address__zip4', 'clean_address__cart', 'clean_address__cr_sort_sz', 
		 'clean_address__lot', 'clean_address__lot_order', 'clean_address__dbpc', 'clean_address__chk_digit', 'clean_address__rec_type', 'clean_address__fips_state',
		 'clean_address__fips_county', 'clean_address__geo_lat', 'clean_address__geo_long', 'clean_address__msa', 'clean_address__geo_blk', 
		 'clean_address__geo_match', 'clean_address__err_stat', 'clean_phones__phone_number', 'clean_phones__cell_phone', 'clean_phones__work_phone' ];
		export IDParentSet := [ 'left.record_id', 'left.uid', 'left.customer_id', 'left.sub_customer_id', 'left.vendor_id', 'left.offender_key', 'left.sub_sub_customer_id', 'left.customer_event_id', 
		'left.sub_customer_event_id', 'left.sub_sub_customer_event_id', 'left.ln_product_id', 'left.ln_sub_product_id', 'left.ln_sub_sub_product_id', 'left.ln_product_key', 
		'left.ln_report_date', 'left.ln_report_time', 'left.reported_date', 'left.reported_time', 'left.event_date', 'left.event_end_date', 'left.event_location', 'left.event_type_1', 
		'left.event_type_2', 'left.event_type_3', 'left.household_id', 'left.reason_description', 'left.investigation_referral_case_id', 'left.investigation_referral_date_opened', 
		'left.investigation_referral_date_closed', 'left.customer_fraud_code_1', 'left.customer_fraud_code_2', 'left.type_of_referral', 'left.referral_reason', 'left.disposition',
		 'left.mitigated', 'left.mitigated_amount', 'left.external_referral_or_casenumber', 'left.fraud_point_score', 'left.customer_person_id', 'left.raw_title', 'left.raw_first_name',
		 'left.raw_middle_name', 'left.raw_last_name', 'left.raw_orig_suffix', 'left.raw_full_name', 'left.ssn', 'left.dob', 'left.drivers_license', 'left.drivers_license_state', 
		 'left.person_date', 'left.name_type', 'left.income', 'left.own_or_rent', 'left.rawlinkid', 'left.street_1', 'left.street_2', 'left.city', 'left.state', 'left.zip', 'left.gps_coordinates', 
		 'left.address_date', 'left.address_type', 'left.appended_provider_id', 'left.business_name', 'left.tin', 'left.fein', 'left.npi', 'left.business_type_1', 'left.business_type_2',
		 'left.business_date', 'left.phone_number', 'left.cell_phone', 'left.work_phone', 'left.contact_type', 'left.contact_date', 'left.carrier', 'left.contact_location', 'left.contact', 
		 'left.call_records', 'left.in_service', 'left.email_address', 'left.email_address_type', 'left.email_date', 'left.host', 'left.alias', 'left.location', 'left.ip_address', 
		 'left.ip_address_date', 'left.version', 'left.class', 'left.subnet_mask', 'left.reserved', 'left.isp', 'left.device_id', 'left.device_date', 'left.unique_number',
		 'left.mac_address', 'left.serial_number', 'left.device_type', 'left.device_identification_provider', 'left.transaction_id', 'left.transaction_type', 'left.amount_of_loss', 
		 'left.professional_id', 'left.profession_type', 'left.corresponding_professional_ids', 'left.licensed_pr_state', 'left.source', 'left.process_date', 'left.dt_first_seen', 
		 'left.dt_last_seen', 'left.dt_vendor_last_reported', 'left.dt_vendor_first_reported', 'left.source_rec_id', 'left.nid', 'left.name_ind', 'left.address_1', 'left.address_2', 
		 'left.rawaid', 'left.aceaid', 'left.address_ind',  'left.did_score', 'left.clean_business_name', 'left.bdid', 'left.bdid_score', 'left.dotid', 'left.dotscore', 
		 'left.dotweight', 'left.empid', 'left.empscore', 'left.empweight', 'left.powid', 'left.powscore', 'left.powweight', 'left.proxid', 'left.proxscore', 'left.proxweight', 
		 'left.seleid', 'left.selescore', 'left.seleweight', 'left.orgid', 'left.orgscore', 'left.orgweight', 'left.ultid', 'left.ultscore', 'left.ultweight', 
		 'left.classification_source__source_type', 'left.classification_source__primary_source_entity', 'left.classification_source__expectation_of_victim_entities', 
		 'left.classification_source__industry_segment', 'left.classification_activity__suspected_discrepancy', 
		 'left.classification_activity__confidence_that_activity_was_deceitful', 'left.classification_activity__workflow_stage_committed', 
		 'left.classification_activity__workflow_stage_detected', 'left.classification_activity__channels', 'left.classification_activity__category_or_fraudtype', 
		 'left.classification_activity__description', 'left.classification_activity__threat', 'left.classification_activity__exposure', 'left.classification_activity__write_off_loss',
		 'left.classification_activity__mitigated', 'left.classification_activity__alert_level', 'left.classification_entity__entity_type', 'left.classification_entity__entity_sub_type',
		 'left.classification_entity__role', 'left.classification_entity__evidence', 'left.classification_entity__investigated_count',
		 'left.classification_permissible_use_access__fdn_file_info_id', 'left.classification_permissible_use_access__fdn_file_code',
		 'left.classification_permissible_use_access__gc_id', 'left.classification_permissible_use_access__file_type', 
		 'left.classification_permissible_use_access__description', 'left.classification_permissible_use_access__primary_source_entity',
		 'left.classification_permissible_use_access__ind_type', 'left.classification_permissible_use_access__ind_type_description',
		 'left.classification_permissible_use_access__update_freq', 'left.classification_permissible_use_access__expiration_days', 
		 'left.classification_permissible_use_access__post_contract_expiration_days', 'left.classification_permissible_use_access__status', 
		 'left.classification_permissible_use_access__product_include', 'left.classification_permissible_use_access__date_added', 
		 'left.classification_permissible_use_access__user_added', 'left.classification_permissible_use_access__date_changed', 
		 'left.classification_permissible_use_access__user_changed', 'left.classification_permissible_use_access__p_industry_segment',
		 'left.classification_permissible_use_access__usage_term', 'left.cleaned_name__title', 'left.cleaned_name__fname', 'left.cleaned_name__mname', 
		 'left.cleaned_name__lname', 'left.cleaned_name__name_suffix', 'left.cleaned_name__name_score', 'left.clean_address__prim_range',
		 'left.clean_address__predir', 'left.clean_address__prim_name', 'left.clean_address__addr_suffix', 'left.clean_address__postdir',
		 'left.clean_address__unit_desig', 'left.clean_address__sec_range', 'left.clean_address__p_city_name', 'left.clean_address__v_city_name', 
		 'left.clean_address__st', 'left.clean_address__zip', 'left.clean_address__zip4', 'left.clean_address__cart', 'left.clean_address__cr_sort_sz', 
		 'left.clean_address__lot', 'left.clean_address__lot_order', 'left.clean_address__dbpc', 'left.clean_address__chk_digit', 'left.clean_address__rec_type',
		 'left.clean_address__fips_state', 'left.clean_address__fips_county', 'left.clean_address__geo_lat', 'left.clean_address__geo_long', 
		 'left.clean_address__msa', 'left.clean_address__geo_blk', 'left.clean_address__geo_match', 'left.clean_address__err_stat', 
		 'left.clean_phones__phone_number', 'left.clean_phones__cell_phone', 'left.clean_phones__work_phone'  ];
		export IDIgnoredFields := ['did', '__internal_fpos__', 'qa_defined_empty'];
		export IDUniqueField := ['record_id'];
		export IDParentName := 'FDNDS';

		//PayloadAK Key
		export PayloadAKKeyName := 'PayloadAK';
		export PayloadAKKeyType := 'Payload Key';
		export PayloadAKKeySet := [ 'record_id', 'customer_id', 'sub_customer_id', 'sub_sub_customer_id', 'customer_event_id', 'sub_customer_event_id', 'sub_sub_customer_event_id', 'ln_report_date', 'ln_report_time', 'reported_date', 'reported_time', 'event_date', 'event_end_date', 'event_location', 'event_type_1', 'event_type_2', 'event_type_3', 'household_id', 'reason_description', 'investigation_referral_case_id', 'investigation_referral_date_opened', 'investigation_referral_date_closed', 'customer_fraud_code_1', 'customer_fraud_code_2', 'type_of_referral', 'referral_reason', 'disposition', 'mitigated', 'mitigated_amount', 'external_referral_or_casenumber', 'fraud_point_score', 'customer_person_id', 'raw_title', 'raw_first_name', 'raw_middle_name', 'raw_last_name', 'raw_orig_suffix', 'raw_full_name', 'ssn', 'dob', 'drivers_license', 'drivers_license_state', 'person_date', 'name_type', 'income', 'own_or_rent', 'rawlinkid', 'street_1', 'street_2', 'city', 'state', 'zip', 'gps_coordinates', 'address_date', 'address_type', 'appended_provider_id', 'business_name', 'tin', 'fein', 'npi', 'business_type_1', 'business_type_2', 'business_date', 'phone_number', 'cell_phone', 'work_phone', 'contact_type', 'contact_date', 'carrier', 'contact_location', 'contact', 'call_records', 'in_service', 'source', 'process_date', 'dt_first_seen', 'dt_last_seen', 'dt_vendor_last_reported', 'dt_vendor_first_reported', 'source_rec_id', 'nid', 'name_ind', 'address_1', 'address_2', 'rawaid', 'aceaid', 'address_ind', 'did_score', 'clean_business_name', 'bdid', 'bdid_score', 'uid', 'dotid', 'dotscore', 'dotweight', 'empid', 'empscore', 'empweight', 'powid', 'powscore', 'powweight', 'proxid', 'proxscore', 'proxweight', 'seleid', 'selescore', 'seleweight', 'orgid', 'orgscore', 'orgweight', 'ultid', 'ultscore', 'ultweight', 'cleaned_name__title', 'cleaned_name__fname', 'cleaned_name__mname', 'cleaned_name__lname', 'cleaned_name__name_suffix', 'cleaned_name__name_score', 'clean_address__prim_range', 'clean_address__predir', 'clean_address__prim_name', 'clean_address__addr_suffix', 'clean_address__postdir', 'clean_address__unit_desig', 'clean_address__sec_range', 'clean_address__p_city_name', 'clean_address__v_city_name', 'clean_address__st', 'clean_address__zip', 'clean_address__zip4', 'clean_address__cart', 'clean_address__cr_sort_sz', 'clean_address__lot', 'clean_address__lot_order', 'clean_address__dbpc', 'clean_address__chk_digit', 'clean_address__rec_type', 'clean_address__fips_state', 'clean_address__fips_county', 'clean_address__geo_lat', 'clean_address__geo_long', 'clean_address__msa', 'clean_address__geo_blk', 'clean_address__geo_match', 'clean_address__err_stat', 'clean_phones__phone_number', 'clean_phones__cell_phone', 'clean_phones__work_phone' ];
		export PayloadAKParentSet := [ 'left.record_id', 'left.customer_id', 'left.sub_customer_id', 'left.sub_sub_customer_id', 'left.customer_event_id', 'left.sub_customer_event_id', 'left.sub_sub_customer_event_id', 'left.ln_report_date', 'left.ln_report_time', 'left.reported_date', 'left.reported_time', 'left.event_date', 'left.event_end_date', 'left.event_location', 'left.event_type_1', 'left.event_type_2', 'left.event_type_3', 'left.household_id', 'left.reason_description', 'left.investigation_referral_case_id', 'left.investigation_referral_date_opened', 'left.investigation_referral_date_closed', 'left.customer_fraud_code_1', 'left.customer_fraud_code_2', 'left.type_of_referral', 'left.referral_reason', 'left.disposition', 'left.mitigated', 'left.mitigated_amount', 'left.external_referral_or_casenumber', 'left.fraud_point_score', 'left.customer_person_id', 'left.raw_title', 'left.raw_first_name', 'left.raw_middle_name', 'left.raw_last_name', 'left.raw_orig_suffix', 'left.raw_full_name', 'left.ssn', 'left.dob', 'left.drivers_license', 'left.drivers_license_state', 'left.person_date', 'left.name_type', 'left.income', 'left.own_or_rent', 'left.rawlinkid', 'left.street_1', 'left.street_2', 'left.city', 'left.state', 'left.zip', 'left.gps_coordinates', 'left.address_date', 'left.address_type', 'left.appended_provider_id', 'left.business_name', 'left.tin', 'left.fein', 'left.npi', 'left.business_type_1', 'left.business_type_2', 'left.business_date', 'left.phone_number', 'left.cell_phone', 'left.work_phone', 'left.contact_type', 'left.contact_date', 'left.carrier', 'left.contact_location', 'left.contact', 'left.call_records', 'left.in_service', 'left.source', 'left.process_date', 'left.dt_first_seen', 'left.dt_last_seen', 'left.dt_vendor_last_reported', 'left.dt_vendor_first_reported', 'left.source_rec_id', 'left.nid', 'left.name_ind', 'left.address_1', 'left.address_2', 'left.rawaid', 'left.aceaid', 'left.address_ind', 'left.did_score', 'left.clean_business_name', 'left.bdid', 'left.bdid_score', 'left.uid', 'left.dotid', 'left.dotscore', 'left.dotweight', 'left.empid', 'left.empscore', 'left.empweight', 'left.powid', 'left.powscore', 'left.powweight', 'left.proxid', 'left.proxscore', 'left.proxweight', 'left.seleid', 'left.selescore', 'left.seleweight', 'left.orgid', 'left.orgscore', 'left.orgweight', 'left.ultid', 'left.ultscore', 'left.ultweight', 'left.cleaned_name__title', 'left.cleaned_name__fname', 'left.cleaned_name__mname', 'left.cleaned_name__lname', 'left.cleaned_name__name_suffix', 'left.cleaned_name__name_score', 'left.clean_address__prim_range', 'left.clean_address__predir', 'left.clean_address__prim_name', 'left.clean_address__addr_suffix', 'left.clean_address__postdir', 'left.clean_address__unit_desig', 'left.clean_address__sec_range', 'left.clean_address__p_city_name', 'left.clean_address__v_city_name', 'left.clean_address__st', 'left.clean_address__zip', 'left.clean_address__zip4', 'left.clean_address__cart', 'left.clean_address__cr_sort_sz', 'left.clean_address__lot', 'left.clean_address__lot_order', 'left.clean_address__dbpc', 'left.clean_address__chk_digit', 'left.clean_address__rec_type', 'left.clean_address__fips_state', 'left.clean_address__fips_county', 'left.clean_address__geo_lat', 'left.clean_address__geo_long', 'left.clean_address__msa', 'left.clean_address__geo_blk', 'left.clean_address__geo_match', 'left.clean_address__err_stat', 'left.clean_phones__phone_number', 'left.clean_phones__cell_phone', 'left.clean_phones__work_phone' ];
		export PayloadAKIgnoredFields := ['did', 'fakeid', '__internal_fpos__', 'qa_defined_empty'];
		export PayloadAKUniqueField := ['record_id'];
		export PayloadAKParentName := 'FDNDS';



end;