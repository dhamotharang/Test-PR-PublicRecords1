﻿Import data_services;
source := RECORD
   unsigned2 source_type_id;
   string25 source_type;
   unsigned2 primary_source_entity_id;
   string10 primary_source_entity;
   unsigned2 expectation_of_victim_entities_id;
   string10 expectation_of_victim_entities;
   string100 industry_segment;
   string2 customer_state;
   string3 customer_county;
   string customer_vertical;
  END;

activity := RECORD
   unsigned2 suspected_discrepancy_id;
   string25 suspected_discrepancy;
   unsigned2 confidence_that_activity_was_deceitful_id;
   string10 confidence_that_activity_was_deceitful;
   unsigned2 workflow_stage_committed_id;
   string15 workflow_stage_committed;
   unsigned2 workflow_stage_detected_id;
   string15 workflow_stage_detected;
   unsigned2 channels_id;
   string10 channels;
   string50 category_or_fraudtype;
   string250 description;
   unsigned2 threat_id;
   string50 threat;
   string12 exposure;
   string12 write_off_loss;
   string12 mitigated;
   unsigned2 alert_level_id;
   string10 alert_level;
  END;

entity := RECORD
   unsigned2 entity_type_id;
   string25 entity_type;
   unsigned2 entity_sub_type_id;
   string25 entity_sub_type;
   unsigned2 role_id;
   string25 role;
   unsigned2 evidence_id;
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

address_cleaner := RECORD
   string100 street_1;
   string50 street_2;
   string100 city;
   string10 state;
   string10 zip;
   string10 address_type;
   string100 address_1;
   string50 address_2;
   layout_clean182_fips clean_address;
  END;

r :=RECORD,maxlength(60000)
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  unsigned6 powid;
  unsigned6 empid;
  unsigned6 dotid;
  unsigned2 ultscore;
  unsigned2 orgscore;
  unsigned2 selescore;
  unsigned2 proxscore;
  unsigned2 powscore;
  unsigned2 empscore;
  unsigned2 dotscore;
  unsigned2 ultweight;
  unsigned2 orgweight;
  unsigned2 seleweight;
  unsigned2 proxweight;
  unsigned2 powweight;
  unsigned2 empweight;
  unsigned2 dotweight;
  unsigned8 record_id;
  string12 customer_id;
  string12 sub_customer_id;
  string60 vendor_id;
  string60 offender_key;
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
  string75 event_location;
  string75 event_type_1;
  string75 event_type_2;
  string75 event_type_3;
  string20 household_id;
  string250 reason_description;
  string25 investigation_referral_case_id;
  string8 investigation_referral_date_opened;
  string8 investigation_referral_date_closed;
  string20 customer_fraud_code_1;
  string20 customer_fraud_code_2;
  string25 type_of_referral;
  string50 referral_reason;
  string25 disposition;
  string3 mitigated;
  string10 mitigated_amount;
  string20 external_referral_or_casenumber;
  string5 fraud_point_score;
  string20 customer_person_id;
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
  unsigned8 lnpid;
  string100 business_name;
  string10 tin;
  string10 fein;
  string10 npi;
  string25 business_type_1;
  string25 business_type_2;
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
  string	 host;
  string25 alias;
  string25 location;
  string25 ip_address;
  string8 ip_address_date;
  string10 version;
  string10 class;
  string10 subnet_mask;
  string2 reserved;
  string75 isp;
  string50 device_id;
  string8 device_date;
  string20 unique_number;
  string25 mac_address;
  string20 serial_number;
  string25 device_type;
  string25 device_identification_provider;
  string	 transaction_id;
  string10 transaction_type;
  string12 amount_of_loss;
  string12 professional_id;
  string50 profession_type;
  string12 corresponding_professional_ids;
  string2 licensed_pr_state;
  source classification_source;
  activity classification_activity;
  entity classification_entity;
  permissible_use_access classification_permissible_use_access;
  unsigned8 uid;
  string100 source;
  unsigned4 process_date;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_last_reported;
  unsigned4 dt_vendor_first_reported;
  unsigned6 source_rec_id;
  layout_clean_name cleaned_name;
  unsigned8 nid;
  unsigned2 name_ind;
  layout_clean182_fips clean_address;
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
  clean_phones clean_phones;
  string1 head_of_household_indicator;
  string20 relationship_indicator;
  string3 county;
  address_cleaner additional_address;
  string1 race;
  string1 ethnicity;
  string20 bank_routing_number_1;
  string20 bank_account_number_1;
  string20 bank_routing_number_2;
  string20 bank_account_number_2;
  string30 reported_by;
  string60 name_risk_code;
  string60 ssn_risk_code;
  string60 dob_risk_code;
  string60 drivers_license_risk_code;
  string60 physical_address_risk_code;
  string60 phone_risk_code;
  string60 cell_phone_risk_code;
  string60 work_phone_risk_code;
  string60 bank_account_1_risk_code;
  string60 bank_account_2_risk_code;
  string60 email_address_risk_code;
  string30 ip_address_fraud_code;
  string60 business_risk_code;
  string60 mailing_address_risk_code;
  string60 device_risk_code;
  string10 tax_preparer_id;
  string8 start_date;
  string8 end_date;
  string10 amount_paid;
  string10 region_code;
  string10 investigator_id;
  integer1 fp;
 END;

 
d	:=dataset([],r);

EXPORT Key_Linkids(string Platform) :=	Index(d,{ultid,orgid,seleid,proxid,powid,empid,dotid},{d},
																							data_services.Data_location.Prefix(Platform) +'thor_data400::key::' 
																							+Platform	+'::qa::linkids');