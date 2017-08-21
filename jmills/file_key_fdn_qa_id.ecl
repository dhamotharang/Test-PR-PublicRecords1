//////////CHILDREN////////////
/*
source := RECORD
   string25 source_type;
   string10 primary_source_entity;
   string10 expectation_of_victim_entities;
   string100 industry_segment;
  END;

activity := RECORD
   string25 suspected_discrepancy;
   string10 confidence_that_activity_was_deceitful;
   string15 workflow_stage_committed;
   string15 workflow_stage_detected;
   string10 channels;
   string50 category_or_fraudtype;
   string150 description;
   string50 threat;
   string12 exposure;
   string12 write_off_loss;
   string12 mitigated;
   string10 alert_level;
  END;

entity := RECORD
   string25 entity_type;
   string25 entity_sub_type;
   string25 role;
   string10 evidence;
   string10 investigated_count;
  END;

permissible_use_access := RECORD
   unsigned6 fdn_file_info_id;
   string100 fdn_file_code;
   unsigned6 gc_id;
   unsigned3 file_type;
   string256 description;
   unsigned3 primary_source_entity;
   unsigned6 ind_type;
   string256 ind_type_description;
   unsigned3 update_freq;
   unsigned6 expiration_days;
   unsigned6 post_contract_expiration_days;
   unsigned3 status;
   unsigned3 product_include;
   string20 date_added;
   string30 user_added;
   string20 date_changed;
   string30 user_changed;
   string100 p_industry_segment;
   string20 usage_term;
  END;

layout_clean_name := RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
  END;

layout_clean182_fips := RECORD
   string10 prim_range;
   string2 predir;
   string28 prim_name;
   string4 addr_suffix;
   string2 postdir;
   string10 unit_desig;
   string8 sec_range;
   string25 p_city_name;
   string25 v_city_name;
   string2 st;
   string5 zip;
   string4 zip4;
   string4 cart;
   string1 cr_sort_sz;
   string4 lot;
   string1 lot_order;
   string2 dbpc;
   string1 chk_digit;
   string2 rec_type;
   string2 fips_state;
   string3 fips_county;
   string10 geo_lat;
   string11 geo_long;
   string4 msa;
   string7 geo_blk;
   string1 geo_match;
   string4 err_stat;
  END;

clean_phones := RECORD
   string10 phone_number;
   string10 cell_phone;
   string10 work_phone;
  END;
*/
#CONSTANT('DataLocationCC', 'NONAME');  
import FraudDefenseNetwork;
key_in := dataset('~thor_data400::key::fdn::qa::id', FraudDefenseNetwork.Layouts.Base.main, THOR);

layout_key_out := RECORD

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


///////////////////////////ORIGINAL////////////////////////////////
//RECORD,maxlength(60000)
/*  unsigned8 record_id;
  unsigned8 uid;
  string12 customer_id;
  string12 sub_customer_id;
  string60 vendor_id;
  string12 sub_sub_customer_id;
  string20 customer_event_id;
  string12 sub_customer_event_id;
  string12 sub_sub_customer_event_id;
  string12 ln_product_id;
  string12 ln_sub_product_id;
  string12 ln_sub_sub_product_id;
  string12 ln_product_key;
  string8 ln_report_date;
  string10 ln_report_time;
  string8 reported_date;
  string10 reported_time;
  string8 event_date;
  string10 event_end_date;
  string25 event_location;
  string25 event_type_1;
  string25 event_type_2;
  string25 event_type_3;
  unsigned8 household_id;
  string250 reason_description;
  string25 investigation_referral_case_id;
  string8 investigation_referral_date_opened;
  string8 investigation_referral_date_closed;
  string20 customer_fraud_code_1;
  string20 customer_fraud_code_2;
  string10 type_of_referral;
  string20 referral_reason;
  string25 disposition;
  string3 mitigated;
  string10 mitigated_amount;
  string20 external_referral_or_casenumber;
  string5 fraud_point_score;
  unsigned6 customer_person_id;
  string50 raw_title;
  string100 raw_first_name;
  string60 raw_middle_name;
  string100 raw_last_name;
  string10 raw_orig_suffix;
  string100 raw_full_name;
  string10 ssn;
  string10 dob;
  string25 drivers_license;
  string2 drivers_license_state;
  string8 person_date;
  string10 name_type;
  string10 income;
  string5 own_or_rent;
  unsigned8 rawlinkid;
  string100 street_1;
  string50 street_2;
  string100 city;
  string10 state;
  string10 zip;
  string20 gps_coordinates;
  string10 address_date;
  string10 address_type;
  unsigned6 appended_provider_id;
  string100 business_name;
  string10 tin;
  string10 fein;
  string10 npi;
  string10 business_type_1;
  string10 business_type_2;
  string10 business_date;
  string12 phone_number;
  string12 cell_phone;
  string12 work_phone;
  string10 contact_type;
  string8 contact_date;
  string25 carrier;
  string25 contact_location;
  string25 contact;
  string25 call_records;
  string1 in_service;
  string50 email_address;
  string10 email_address_type;
  string8 email_date;
  string15 host;
  string25 alias;
  string25 location;
  string25 ip_address;
  string8 ip_address_date;
  string10 version;
  string10 class;
  string10 subnet_mask;
  string2 reserved;
  string10 isp;
  string12 device_id;
  string8 device_date;
  string20 unique_number;
  string10 mac_address;
  string20 serial_number;
  string25 device_type;
  string25 device_identification_provider;
  string20 transaction_id;
  string10 transaction_type;
  string12 amount_of_loss;
  string12 professional_id;
  string10 profession_type;
  string12 corresponding_professional_ids;
  string2 licensed_pr_state;
  // source classification_source;
   string25 source_type;
   string10 primary_source_entity;
   string10 expectation_of_victim_entities;
   string100 industry_segment;
	 
  // activity classification_activity;
	 string25 suspected_discrepancy;
   string10 confidence_that_activity_was_deceitful;
   string15 workflow_stage_committed;
   string15 workflow_stage_detected;
   string10 channels;
   string50 category_or_fraudtype;
   string150 description;
   string50 threat;
   string12 exposure;
   string12 write_off_loss;
   string12 mitigated;
   string10 alert_level;

  // entity classification_entity;
   string25 entity_type;
   string25 entity_sub_type;
   string25 role;
   string10 evidence;
   string10 investigated_count;
	 
  // permissible_use_access classification_permissible_use_access;
	 unsigned6 fdn_file_info_id;
   string100 fdn_file_code;
   unsigned6 gc_id;
   unsigned3 file_type;
   string256 description;
   unsigned3 primary_source_entity;
   unsigned6 ind_type;
   string256 ind_type_description;
   unsigned3 update_freq;
   unsigned6 expiration_days;
   unsigned6 post_contract_expiration_days;
   unsigned3 status;
   unsigned3 product_include;
   string20 date_added;
   string30 user_added;
   string20 date_changed;
   string30 user_changed;
   string100 p_industry_segment;
   string20 usage_term;
	 
	//Remaining Main Records 
  string20 source;
  unsigned4 process_date;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_last_reported;
  unsigned4 dt_vendor_first_reported;
  unsigned6 source_rec_id;
  // layout_clean_name cleaned_name;
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;

//Remaining Main Records
  unsigned8 nid;
  unsigned2 name_ind;
	
  // layout_clean182_fips clean_address;
	 string10 prim_range;
   string2 predir;
   string28 prim_name;
   string4 addr_suffix;
   string2 postdir;
   string10 unit_desig;
   string8 sec_range;
   string25 p_city_name;
   string25 v_city_name;
   string2 st;
   string5 zip;
   string4 zip4;
   string4 cart;
   string1 cr_sort_sz;
   string4 lot;
   string1 lot_order;
   string2 dbpc;
   string1 chk_digit;
   string2 rec_type;
   string2 fips_state;
   string3 fips_county;
   string10 geo_lat;
   string11 geo_long;
   string4 msa;
   string7 geo_blk;
   string1 geo_match;
   string4 err_stat;
	
	//Remaining Main Records
  string100 address_1;
  string50 address_2;
  unsigned8 rawaid;
  unsigned8 aceaid;
  unsigned2 address_ind;
  unsigned6 did;
  unsigned1 did_score;
  string100 clean_business_name;
  unsigned6 bdid;
  unsigned1 bdid_score;
  unsigned6 dotid;
  unsigned2 dotscore;
  unsigned2 dotweight;
  unsigned6 empid;
  unsigned2 empscore;
  unsigned2 empweight;
  unsigned6 powid;
  unsigned2 powscore;
  unsigned2 powweight;
  unsigned6 proxid;
  unsigned2 proxscore;
  unsigned2 proxweight;
  unsigned6 seleid;
  unsigned2 selescore;
  unsigned2 seleweight;
  unsigned6 orgid;
  unsigned2 orgscore;
  unsigned2 orgweight;
  unsigned6 ultid;
  unsigned2 ultscore;
  unsigned2 ultweight;
  
	// clean_phones clean_phones;
	 string10 phone_number;
   string10 cell_phone;
   string10 work_phone;
   unsigned8 __internal_fpos__;
 END;
*/
layout_key_out makerecord (key_in L) := transform
self.record_id := L.record_id;
self.uid := L.uid;
self.customer_id := L.customer_id;
self.sub_customer_id := L.sub_customer_id;
self.vendor_id := L.vendor_id;
self.sub_sub_customer_id := L.sub_sub_customer_id;
self.customer_event_id := L.customer_event_id;
self.sub_customer_event_id := L.sub_customer_event_id;
self.sub_sub_customer_event_id := L.sub_sub_customer_event_id;
self.ln_product_id := L.ln_product_id;
self.ln_sub_product_id := L.ln_sub_product_id;
self.ln_sub_sub_product_id := L.ln_sub_sub_product_id;
self.ln_product_key := L.ln_product_key;
self.ln_report_date := L.ln_report_date;
self.ln_report_time := L.ln_report_time;
self.reported_date := L.reported_date;
self.reported_time := L.reported_time;
self.event_date := L.event_date;
self.event_end_date := L.event_end_date;
self.event_location := L.event_location;
self.event_type_1 := L.event_type_1;
self.event_type_2 := L.event_type_2;
self.event_type_3 := L.event_type_3;
self.household_id := L.household_id;
self.reason_description := L.reason_description;
self.investigation_referral_case_id := L.investigation_referral_case_id;
self.investigation_referral_date_opened := L.investigation_referral_date_opened;
self.investigation_referral_date_closed := L.investigation_referral_date_closed;
self.customer_fraud_code_1 := L.customer_fraud_code_1;
self.customer_fraud_code_2 := L.customer_fraud_code_2;
self.type_of_referral := L.type_of_referral;
self.referral_reason := L.referral_reason;
self.disposition := L.disposition;
self.mitigated := L.mitigated;
self.mitigated_amount := L.mitigated_amount;
self.external_referral_or_casenumber := L.external_referral_or_casenumber;
self.fraud_point_score := L.fraud_point_score;
self.customer_person_id := L.customer_person_id;
self.raw_title := L.raw_title;
self.raw_first_name := L.raw_first_name;
self.raw_middle_name := L.raw_middle_name;
self.raw_last_name := L.raw_last_name;
self.raw_orig_suffix := L.raw_orig_suffix;
self.raw_full_name := L.raw_full_name;
self.ssn := L.ssn;
self.dob := L.dob;
self.drivers_license := L.drivers_license;
self.drivers_license_state := L.drivers_license_state;
self.person_date := L.person_date;
self.name_type := L.name_type;
self.income := L.income;
self.own_or_rent := L.own_or_rent;
self.rawlinkid := L.rawlinkid;
self.street_1 := L.street_1;
self.street_2 := L.street_2;
self.city := L.city;
self.state := L.state;
self.zip := L.zip;
self.gps_coordinates := L.gps_coordinates;
self.address_date := L.address_date;
self.address_type := L.address_type;
self.appended_provider_id := L.appended_provider_id;
self.business_name := L.business_name;
self.tin := L.tin;
self.fein := L.fein;
self.npi := L.npi;
self.business_type_1 := L.business_type_1;
self.business_type_2 := L.business_type_2;
self.business_date := L.business_date;
self.phone_number := L.phone_number;
self.cell_phone := L.cell_phone;
self.work_phone := L.work_phone;
self.contact_type := L.contact_type;
self.contact_date := L.contact_date;
self.carrier := L.carrier;
self.contact_location := L.contact_location;
self.contact := L.contact;
self.call_records := L.call_records;
self.in_service := L.in_service;
self.email_address := L.email_address;
self.email_address_type := L.email_address_type;
self.email_date := L.email_date;
self.host := L.host;
self.alias := L.alias;
self.location := L.location;
self.ip_address := L.ip_address;
self.ip_address_date := L.ip_address_date;
self.version := L.version;
self.class := L.class;
self.subnet_mask := L.subnet_mask;
self.reserved := L.reserved;
self.isp := L.isp;
self.device_id := L.device_id;
self.device_date := L.device_date;
self.unique_number := L.unique_number;
self.mac_address := L.mac_address;
self.serial_number := L.serial_number;
self.device_type := L.device_type;
self.device_identification_provider := L.device_identification_provider;
self.transaction_id := L.transaction_id;
self.transaction_type := L.transaction_type;
self.amount_of_loss := L.amount_of_loss;
self.professional_id := L.professional_id;
self.profession_type := L.profession_type;
self.corresponding_professional_ids := L.corresponding_professional_ids;
self.licensed_pr_state := L.licensed_pr_state;
//CLASSIFICATION_SOURCE
self.classification_source_source_type := L.classification_source.source_type;
self.classification_source_primary_source_entity := L.classification_source.primary_source_entity;
self.classification_source_expectation_of_victim_entities := L.classification_source.expectation_of_victim_entities;
self.classification_source_industry_segment := L.classification_source.industry_segment;

//CLASSIFICATION_ACTIVITY
self.classification_activity_suspected_discrepancy := L.classification_activity.suspected_discrepancy;
self.classification_activity_confidence_that_activity_was_deceitful := L.classification_activity.confidence_that_activity_was_deceitful;
self.classification_activity_workflow_stage_committed := L.classification_activity.workflow_stage_committed;
self.classification_activity_workflow_stage_detected := L.classification_activity.workflow_stage_detected;
self.classification_activity_channels := L.classification_activity.channels;
self.classification_activity_category_or_fraudtype := L.classification_activity.category_or_fraudtype;
self.classification_activity_description := L.classification_activity.description;
self.classification_activity_threat := L.classification_activity.threat;
self.classification_activity_exposure := L.classification_activity.exposure;
self.classification_activity_write_off_loss := L.classification_activity.write_off_loss;
self.classification_activity_mitigated := L.classification_activity.mitigated;
self.classification_activity_alert_level := L.classification_activity.alert_level;


self.classification_entity_entity_type := L.classification_entity.entity_type;
self.classification_entity_entity_sub_type := L.classification_entity.entity_sub_type;
self.classification_entity_role := L.classification_entity.role;
self.classification_entity_evidence := L.classification_entity.evidence;
self.classification_entity_investigated_count := L.classification_entity.investigated_count;

//CLASSIFICATION_PERMISSIBLE_USE_ACCESS
self.classification_permissible_use_access_fdn_file_info_id := L.classification_permissible_use_access.fdn_file_info_id;
self.classification_permissible_use_access_fdn_file_code := L.classification_permissible_use_access.fdn_file_code;
self.classification_permissible_use_access_gc_id := L.classification_permissible_use_access.gc_id;
self.classification_permissible_use_access_file_type := L.classification_permissible_use_access.file_type;
self.classification_permissible_use_access_description := L.classification_permissible_use_access.description;
self.classification_permissible_use_access_primary_source_entity := L.classification_permissible_use_access.primary_source_entity;
self.classification_permissible_use_access_ind_type := L.classification_permissible_use_access.ind_type;
self.classification_permissible_use_access_ind_type_description := L.classification_permissible_use_access.ind_type_description;
self.classification_permissible_use_access_update_freq := L.classification_permissible_use_access.update_freq;
self.classification_permissible_use_access_expiration_days := L.classification_permissible_use_access.expiration_days;
self.classification_permissible_use_access_post_contract_expiration_days := L.classification_permissible_use_access.post_contract_expiration_days;
self.classification_permissible_use_access_status := L.classification_permissible_use_access.status;
self.classification_permissible_use_access_product_include := L.classification_permissible_use_access.product_include;
self.classification_permissible_use_access_date_added := L.classification_permissible_use_access.date_added;
self.classification_permissible_use_access_user_added := L.classification_permissible_use_access.user_added;
self.classification_permissible_use_access_date_changed := L.classification_permissible_use_access.date_changed;
self.classification_permissible_use_access_user_changed := L.classification_permissible_use_access.user_changed;
self.classification_permissible_use_access_p_industry_segment := L.classification_permissible_use_access.p_industry_segment;
self.classification_permissible_use_access_usage_term := L.classification_permissible_use_access.usage_term;

//REMAINING MAIN RECORDS
self.source := L.source;
self.process_date := L.process_date;
self.dt_first_seen := L.dt_first_seen;
self.dt_last_seen := L.dt_last_seen;
self.dt_vendor_last_reported := L.dt_vendor_last_reported;
self.dt_vendor_first_reported := L.dt_vendor_first_reported;
self.source_rec_id := L.source_rec_id;

//CLEANED_NAME
self.cleaned_name_title := L.cleaned_name.title;
self.cleaned_name_fname := L.cleaned_name.fname;
self.cleaned_name_mname := L.cleaned_name.mname;
self.cleaned_name_lname := L.cleaned_name.lname;
self.cleaned_name_name_suffix := L.cleaned_name.name_suffix;
self.cleaned_name_name_score := L.cleaned_name.name_score;

//REMAINING MAIN RECORDS
self.nid := L.nid;
self.name_ind := L.name_ind;

//CLEAN_ADDRESS
self.clean_address_prim_range := L.clean_address.prim_range;
self.clean_address_predir := L.clean_address.predir;
self.clean_address_prim_name := L.clean_address.prim_name;
self.clean_address_addr_suffix := L.clean_address.addr_suffix;
self.clean_address_postdir := L.clean_address.postdir;
self.clean_address_unit_desig := L.clean_address.unit_desig;
self.clean_address_sec_range := L.clean_address.sec_range;
self.clean_address_p_city_name := L.clean_address.p_city_name;
self.clean_address_v_city_name := L.clean_address.v_city_name;
self.clean_address_st := L.clean_address.st;
self.clean_address_zip := L.clean_address.zip;
self.clean_address_zip4 := L.clean_address.zip4;
self.clean_address_cart := L.clean_address.cart;
self.clean_address_cr_sort_sz := L.clean_address.cr_sort_sz;
self.clean_address_lot := L.clean_address.lot;
self.clean_address_lot_order := L.clean_address.lot_order;
self.clean_address_dbpc := L.clean_address.dbpc;
self.clean_address_chk_digit := L.clean_address.chk_digit;
self.clean_address_rec_type := L.clean_address.rec_type;
self.clean_address_fips_state := L.clean_address.fips_state;
self.clean_address_fips_county := L.clean_address.fips_county;
self.clean_address_geo_lat := L.clean_address.geo_lat;
self.clean_address_geo_long := L.clean_address.geo_long;
self.clean_address_msa := L.clean_address.msa;
self.clean_address_geo_blk := L.clean_address.geo_blk;
self.clean_address_geo_match := L.clean_address.geo_match;
self.clean_address_err_stat := L.clean_address.err_stat;

//REMAINING_MAIN_RECORDS
self.address_1 := L.address_1;
self.address_2 := L.address_2;
self.rawaid := L.rawaid;
self.aceaid := L.aceaid;
self.address_ind := L.address_ind;
self.did := L.did;
self.did_score := L.did_score;
self.clean_business_name := L.clean_business_name;
self.bdid := L.bdid;
self.bdid_score := L.bdid_score;
self.dotid := L.dotid;
self.dotscore := L.dotscore;
self.dotweight := L.dotweight;
self.empid := L.empid;
self.empscore := L.empscore;
self.empweight := L.empweight;
self.powid := L.powid;
self.powscore := L.powscore;
self.powweight := L.powweight;
self.proxid := L.proxid;
self.proxscore := L.proxscore;
self.proxweight := L.proxweight;
self.seleid := L.seleid;
self.selescore := L.selescore;
self.seleweight := L.seleweight;
self.orgid := L.orgid;
self.orgscore := L.orgscore;
self.orgweight := L.orgweight;
self.ultid := L.ultid;
self.ultscore := L.ultscore;
self.ultweight := L.ultweight;

//CLEAN_PHONES
self.clean_phones_phone_number := L.clean_phones.phone_number;
self.clean_phones_cell_phone := L.clean_phones.cell_phone;
self.clean_phones_work_phone := L.clean_phones.work_phone;

//REMAINING_MAIN_RECORDS
// self.__internal_fpos__ := L.__internal_fpos__;
END;

EXPORT file_key_fdn_qa_id := project(key_in,makerecord(left));