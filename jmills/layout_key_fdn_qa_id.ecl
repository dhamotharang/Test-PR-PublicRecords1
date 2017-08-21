EXPORT layout_key_fdn_qa_id := RECORD
unsigned8	record_id;
unsigned8	uid;
string12	customer_id;
string12	sub_customer_id;
string60	vendor_id;
string12	sub_sub_customer_id;
string20	customer_event_id;
string12	sub_customer_event_id;
string12	sub_sub_customer_event_id;
string12	ln_product_id;
string12	ln_sub_product_id;
string12	ln_sub_sub_product_id;
string12	ln_product_key;
string8	ln_report_date;
string10	ln_report_time;
string8	reported_date;
string10	reported_time;
string8	event_date;
string10	event_end_date;
string25	event_location;
string25	event_type_1;
string25	event_type_2;
string25	event_type_3;
unsigned8	household_id;
string250	reason_description;
string25	investigation_referral_case_id;
string8	investigation_referral_date_opened;
string8	investigation_referral_date_closed;
string20	customer_fraud_code_1;
string20	customer_fraud_code_2;
string10	type_of_referral;
string20	referral_reason;
string25	disposition;
string3	mitigated;
string10	mitigated_amount;
string20	external_referral_or_casenumber;
string5	fraud_point_score;
unsigned6	customer_person_id;
string50	raw_title;
string100	raw_first_name;
string60	raw_middle_name;
string100	raw_last_name;
string10	raw_orig_suffix;
string100	raw_full_name;
string10	ssn;
string10	dob;
string25	drivers_license;
string2	drivers_license_state;
string8	person_date;
string10	name_type;
string10	income;
string5	own_or_rent;
unsigned8	rawlinkid;
string100	street_1;
string50	street_2;
string100	city;
string10	state;
string10	zip;
string20	gps_coordinates;
string10	address_date;
string10	address_type;
unsigned6	appended_provider_id;
string100	business_name;
string10	tin;
string10	fein;
string10	npi;
string10	business_type_1;
string10	business_type_2;
string10	business_date;
string12	phone_number;
string12	cell_phone;
string12	work_phone;
string10	contact_type;
string8	contact_date;
string25	carrier;
string25	contact_location;
string25	contact;
string25	call_records;
string1	in_service;
string50	email_address;
string10	email_address_type;
string8	email_date;
string15	host;
string25	alias;
string25	location;
string25	ip_address;
string8	ip_address_date;
string10	version;
string10	class;
string10	subnet_mask;
string2	reserved;
string10	isp;
string12	device_id;
string8	device_date;
string20	unique_number;
string10	mac_address;
string20	serial_number;
string25	device_type;
string25	device_identification_provider;
string20	transaction_id;
string10	transaction_type;
string12	amount_of_loss;
string12	professional_id;
string10	profession_type;
string12	corresponding_professional_ids;
string2	licensed_pr_state;
//CLASSIFICATION_SOURCE	
string25	classification_source_source_type;
string10	classification_source_primary_source_entity;
string10	classification_source_expectation_of_victim_entities;
string100	classification_source_industry_segment;
	
//CLASSIFICATION_ACTIVITY	
string25	classification_activity_suspected_discrepancy;
string10	classification_activity_confidence_that_activity_was_deceitful;
string15	classification_activity_workflow_stage_committed;
string15	classification_activity_workflow_stage_detected;
string10	classification_activity_channels;
string50	classification_activity_category_or_fraudtype;
string150	classification_activity_description;
string50	classification_activity_threat;
string12	classification_activity_exposure;
string12	classification_activity_write_off_loss;
string12	classification_activity_mitigated;
string10	classification_activity_alert_level;
	
//CLASSIFICATION_ENTITY	
string25	classification_entity_entity_type;
string25	classification_entity_entity_sub_type;
string25	classification_entity_role;
string10	classification_entity_evidence;
string10	classification_entity_investigated_count;
	
//CLASSIFICATION_PERMISSIBLE_USE_ACCESS	
unsigned6	classification_permissible_use_access_fdn_file_info_id;
string100	classification_permissible_use_access_fdn_file_code;
unsigned6	classification_permissible_use_access_gc_id;
unsigned3	classification_permissible_use_access_file_type;
string256	classification_permissible_use_access_description;
unsigned3	classification_permissible_use_access_primary_source_entity;
unsigned6	classification_permissible_use_access_ind_type;
string256	classification_permissible_use_access_ind_type_description;
unsigned3	classification_permissible_use_access_update_freq;
unsigned6	classification_permissible_use_access_expiration_days;
unsigned6	classification_permissible_use_access_post_contract_expiration_days;
unsigned3	classification_permissible_use_access_status;
unsigned3	classification_permissible_use_access_product_include;
string20	classification_permissible_use_access_date_added;
string30	classification_permissible_use_access_user_added;
string20	classification_permissible_use_access_date_changed;
string30	classification_permissible_use_access_user_changed;
string100	classification_permissible_use_access_p_industry_segment;
string20	classification_permissible_use_access_usage_term;
	
//REMAINING MAIN RECORDS	
string20	source;
unsigned4	process_date;
unsigned4	dt_first_seen;
unsigned4	dt_last_seen;
unsigned4	dt_vendor_last_reported;
unsigned4	dt_vendor_first_reported;
unsigned6	source_rec_id;
	
//CLEANED_NAME	
string5	cleaned_name_title;
string20	cleaned_name_fname;
string20	cleaned_name_mname;
string20	cleaned_name_lname;
string5	cleaned_name_name_suffix;
string3	cleaned_name_name_score;
	
//REMAINING MAIN RECORDS	
unsigned8	nid;
unsigned2	name_ind;
	
//CLEAN_ADDRESS	
string10	clean_address_prim_range;
string2	clean_address_predir;
string28	clean_address_prim_name;
string4	clean_address_addr_suffix;
string2	clean_address_postdir;
string10	clean_address_unit_desig;
string8	clean_address_sec_range;
string25	clean_address_p_city_name;
string25	clean_address_v_city_name;
string2	clean_address_st;
string5	clean_address_zip;
string4	clean_address_zip4;
string4	clean_address_cart;
string1	clean_address_cr_sort_sz;
string4	clean_address_lot;
string1	clean_address_lot_order;
string2	clean_address_dbpc;
string1	clean_address_chk_digit;
string2	clean_address_rec_type;
string2	clean_address_fips_state;
string3	clean_address_fips_county;
string10	clean_address_geo_lat;
string11	clean_address_geo_long;
string4	clean_address_msa;
string7	clean_address_geo_blk;
string1	clean_address_geo_match;
string4	clean_address_err_stat;
	
//REMAINING_MAIN_RECORDS	
string100	address_1;
string50	address_2;
unsigned8	rawaid;
unsigned8	aceaid;
unsigned2	address_ind;
unsigned6	did;
unsigned1	did_score;
string100	clean_business_name;
unsigned6	bdid;
unsigned1	bdid_score;
unsigned6	dotid;
unsigned2	dotscore;
unsigned2	dotweight;
unsigned6	empid;
unsigned2	empscore;
unsigned2	empweight;
unsigned6	powid;
unsigned2	powscore;
unsigned2	powweight;
unsigned6	proxid;
unsigned2	proxscore;
unsigned2	proxweight;
unsigned6	seleid;
unsigned2	selescore;
unsigned2	seleweight;
unsigned6	orgid;
unsigned2	orgscore;
unsigned2	orgweight;
unsigned6	ultid;
unsigned2	ultscore;
unsigned2	ultweight;
	
//CLEAN_PHONES	
string10	clean_phones_phone_number;
string10	clean_phones_cell_phone;
string10	clean_phones_work_phone;
	
//REMAINING_MAIN_RECORDS	
// unsigned8	__internal_fpos__;
END;	
