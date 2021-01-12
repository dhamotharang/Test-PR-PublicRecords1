IMPORT SALT311,STD;
EXPORT Deltabase_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 81;
  EXPORT NumRulesFromFieldType := 81;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 57;
  EXPORT NumFieldsWithPossibleEdits := 57;
  EXPORT NumRulesWithPossibleEdits := 81;
  EXPORT Expanded_Layout := RECORD(Deltabase_Layout_Deltabase)
    UNSIGNED1 inqlog_id_Invalid;
    BOOLEAN inqlog_id_wouldClean;
    UNSIGNED1 customer_id_Invalid;
    BOOLEAN customer_id_wouldClean;
    UNSIGNED1 transaction_id_Invalid;
    BOOLEAN transaction_id_wouldClean;
    UNSIGNED1 date_of_transaction_Invalid;
    BOOLEAN date_of_transaction_wouldClean;
    UNSIGNED1 household_id_Invalid;
    BOOLEAN household_id_wouldClean;
    UNSIGNED1 customer_person_id_Invalid;
    BOOLEAN customer_person_id_wouldClean;
    UNSIGNED1 customer_program_Invalid;
    BOOLEAN customer_program_wouldClean;
    UNSIGNED1 reason_for_transaction_activity_Invalid;
    BOOLEAN reason_for_transaction_activity_wouldClean;
    UNSIGNED1 inquiry_source_Invalid;
    BOOLEAN inquiry_source_wouldClean;
    UNSIGNED1 customer_county_Invalid;
    BOOLEAN customer_county_wouldClean;
    UNSIGNED1 customer_state_Invalid;
    BOOLEAN customer_state_wouldClean;
    UNSIGNED1 customer_agency_vertical_type_Invalid;
    BOOLEAN customer_agency_vertical_type_wouldClean;
    UNSIGNED1 ssn_Invalid;
    BOOLEAN ssn_wouldClean;
    UNSIGNED1 dob_Invalid;
    BOOLEAN dob_wouldClean;
    UNSIGNED1 rawlinkid_Invalid;
    BOOLEAN rawlinkid_wouldClean;
    UNSIGNED1 raw_full_name_Invalid;
    BOOLEAN raw_full_name_wouldClean;
    UNSIGNED1 raw_title_Invalid;
    BOOLEAN raw_title_wouldClean;
    UNSIGNED1 raw_first_name_Invalid;
    BOOLEAN raw_first_name_wouldClean;
    UNSIGNED1 raw_middle_name_Invalid;
    BOOLEAN raw_middle_name_wouldClean;
    UNSIGNED1 raw_last_name_Invalid;
    BOOLEAN raw_last_name_wouldClean;
    UNSIGNED1 raw_orig_suffix_Invalid;
    BOOLEAN raw_orig_suffix_wouldClean;
    UNSIGNED1 full_address_Invalid;
    BOOLEAN full_address_wouldClean;
    UNSIGNED1 street_1_Invalid;
    BOOLEAN street_1_wouldClean;
    UNSIGNED1 city_Invalid;
    BOOLEAN city_wouldClean;
    UNSIGNED1 state_Invalid;
    BOOLEAN state_wouldClean;
    UNSIGNED1 zip_Invalid;
    BOOLEAN zip_wouldClean;
    UNSIGNED1 county_Invalid;
    BOOLEAN county_wouldClean;
    UNSIGNED1 mailing_street_1_Invalid;
    BOOLEAN mailing_street_1_wouldClean;
    UNSIGNED1 mailing_city_Invalid;
    BOOLEAN mailing_city_wouldClean;
    UNSIGNED1 mailing_state_Invalid;
    BOOLEAN mailing_state_wouldClean;
    UNSIGNED1 mailing_zip_Invalid;
    BOOLEAN mailing_zip_wouldClean;
    UNSIGNED1 mailing_county_Invalid;
    BOOLEAN mailing_county_wouldClean;
    UNSIGNED1 phone_number_Invalid;
    BOOLEAN phone_number_wouldClean;
    UNSIGNED1 ultid_Invalid;
    BOOLEAN ultid_wouldClean;
    UNSIGNED1 orgid_Invalid;
    BOOLEAN orgid_wouldClean;
    UNSIGNED1 seleid_Invalid;
    BOOLEAN seleid_wouldClean;
    UNSIGNED1 tin_Invalid;
    BOOLEAN tin_wouldClean;
    UNSIGNED1 email_address_Invalid;
    BOOLEAN email_address_wouldClean;
    UNSIGNED1 appended_provider_id_Invalid;
    BOOLEAN appended_provider_id_wouldClean;
    UNSIGNED1 lnpid_Invalid;
    BOOLEAN lnpid_wouldClean;
    UNSIGNED1 npi_Invalid;
    BOOLEAN npi_wouldClean;
    UNSIGNED1 ip_address_Invalid;
    BOOLEAN ip_address_wouldClean;
    UNSIGNED1 device_id_Invalid;
    BOOLEAN device_id_wouldClean;
    UNSIGNED1 professional_id_Invalid;
    BOOLEAN professional_id_wouldClean;
    UNSIGNED1 bank_routing_number_1_Invalid;
    BOOLEAN bank_routing_number_1_wouldClean;
    UNSIGNED1 bank_account_number_1_Invalid;
    BOOLEAN bank_account_number_1_wouldClean;
    UNSIGNED1 drivers_license_state_Invalid;
    BOOLEAN drivers_license_state_wouldClean;
    UNSIGNED1 drivers_license_Invalid;
    BOOLEAN drivers_license_wouldClean;
    UNSIGNED1 geo_lat_Invalid;
    BOOLEAN geo_lat_wouldClean;
    UNSIGNED1 geo_long_Invalid;
    BOOLEAN geo_long_wouldClean;
    UNSIGNED1 reported_date_Invalid;
    BOOLEAN reported_date_wouldClean;
    UNSIGNED1 file_type_Invalid;
    BOOLEAN file_type_wouldClean;
    UNSIGNED1 deceitful_confidence_Invalid;
    BOOLEAN deceitful_confidence_wouldClean;
    UNSIGNED1 reported_by_Invalid;
    BOOLEAN reported_by_wouldClean;
    UNSIGNED1 reason_description_Invalid;
    BOOLEAN reason_description_wouldClean;
    UNSIGNED1 event_type_1_Invalid;
    BOOLEAN event_type_1_wouldClean;
    UNSIGNED1 event_entity_1_Invalid;
    BOOLEAN event_entity_1_wouldClean;
  END;
  EXPORT  Bitmap_Layout := RECORD(Deltabase_Layout_Deltabase)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsCleanBits1;
  END;
  EXPORT Rule_Layout := RECORD(Deltabase_Layout_Deltabase)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'inqlog_id:invalid_numeric:ALLOW'
          ,'customer_id:invalid_numeric_string:ALLOW'
          ,'transaction_id:invalid_alphanumeric:ALLOW'
          ,'date_of_transaction:invalid_date:LEFTTRIM','date_of_transaction:invalid_date:ALLOW'
          ,'household_id:invalid_alphanumeric:ALLOW'
          ,'customer_person_id:invalid_alphanumeric:ALLOW'
          ,'customer_program:invalid_alpha:ALLOW'
          ,'reason_for_transaction_activity:invalid_alphanumeric:ALLOW'
          ,'inquiry_source:invalid_alphanumeric:ALLOW'
          ,'customer_county:invalid_alphanumeric:ALLOW'
          ,'customer_state:invalid_state:LEFTTRIM','customer_state:invalid_state:ALLOW','customer_state:invalid_state:LENGTHS'
          ,'customer_agency_vertical_type:invalid_alphanumeric:ALLOW'
          ,'ssn:invalid_ssn:LEFTTRIM','ssn:invalid_ssn:ALLOW','ssn:invalid_ssn:LENGTHS'
          ,'dob:invalid_date:LEFTTRIM','dob:invalid_date:ALLOW'
          ,'rawlinkid:invalid_numeric:ALLOW'
          ,'raw_full_name:invalid_name:LEFTTRIM','raw_full_name:invalid_name:ALLOW'
          ,'raw_title:invalid_alphanumeric:ALLOW'
          ,'raw_first_name:invalid_name:LEFTTRIM','raw_first_name:invalid_name:ALLOW'
          ,'raw_middle_name:invalid_name:LEFTTRIM','raw_middle_name:invalid_name:ALLOW'
          ,'raw_last_name:invalid_name:LEFTTRIM','raw_last_name:invalid_name:ALLOW'
          ,'raw_orig_suffix:invalid_alphanumeric:ALLOW'
          ,'full_address:invalid_alphanumeric:ALLOW'
          ,'street_1:invalid_alphanumeric:ALLOW'
          ,'city:invalid_name:LEFTTRIM','city:invalid_name:ALLOW'
          ,'state:invalid_state:LEFTTRIM','state:invalid_state:ALLOW','state:invalid_state:LENGTHS'
          ,'zip:invalid_zip:LEFTTRIM','zip:invalid_zip:ALLOW','zip:invalid_zip:LENGTHS'
          ,'county:invalid_alphanumeric:ALLOW'
          ,'mailing_street_1:invalid_alphanumeric:ALLOW'
          ,'mailing_city:invalid_name:LEFTTRIM','mailing_city:invalid_name:ALLOW'
          ,'mailing_state:invalid_state:LEFTTRIM','mailing_state:invalid_state:ALLOW','mailing_state:invalid_state:LENGTHS'
          ,'mailing_zip:invalid_zip:LEFTTRIM','mailing_zip:invalid_zip:ALLOW','mailing_zip:invalid_zip:LENGTHS'
          ,'mailing_county:invalid_alphanumeric:ALLOW'
          ,'phone_number:invalid_phone:LEFTTRIM','phone_number:invalid_phone:ALLOW','phone_number:invalid_phone:LENGTHS'
          ,'ultid:invalid_numeric:ALLOW'
          ,'orgid:invalid_numeric:ALLOW'
          ,'seleid:invalid_numeric:ALLOW'
          ,'tin:invalid_alphanumeric:ALLOW'
          ,'email_address:invalid_email:ALLOW'
          ,'appended_provider_id:invalid_numeric:ALLOW'
          ,'lnpid:invalid_numeric:ALLOW'
          ,'npi:invalid_alphanumeric:ALLOW'
          ,'ip_address:invalid_ip:LEFTTRIM','ip_address:invalid_ip:ALLOW'
          ,'device_id:invalid_alphanumeric:ALLOW'
          ,'professional_id:invalid_alphanumeric:ALLOW'
          ,'bank_routing_number_1:invalid_alphanumeric:ALLOW'
          ,'bank_account_number_1:invalid_alphanumeric:ALLOW'
          ,'drivers_license_state:invalid_alphanumeric:ALLOW'
          ,'drivers_license:invalid_alphanumeric:ALLOW'
          ,'geo_lat:invalid_real_string:ALLOW'
          ,'geo_long:invalid_real_string:ALLOW'
          ,'reported_date:invalid_date:LEFTTRIM','reported_date:invalid_date:ALLOW'
          ,'file_type:invalid_numeric:ALLOW'
          ,'deceitful_confidence:invalid_numeric_string:ALLOW'
          ,'reported_by:invalid_alphanumeric:ALLOW'
          ,'reason_description:invalid_alphanumeric:ALLOW'
          ,'event_type_1:invalid_numeric_string:ALLOW'
          ,'event_entity_1:invalid_alphanumeric:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY'
          ,'record:Number_Edited_Records:SUMMARY'
          ,'rule:Number_Edited_Rules:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Deltabase_Fields.InvalidMessage_inqlog_id(1)
          ,Deltabase_Fields.InvalidMessage_customer_id(1)
          ,Deltabase_Fields.InvalidMessage_transaction_id(1)
          ,Deltabase_Fields.InvalidMessage_date_of_transaction(1),Deltabase_Fields.InvalidMessage_date_of_transaction(2)
          ,Deltabase_Fields.InvalidMessage_household_id(1)
          ,Deltabase_Fields.InvalidMessage_customer_person_id(1)
          ,Deltabase_Fields.InvalidMessage_customer_program(1)
          ,Deltabase_Fields.InvalidMessage_reason_for_transaction_activity(1)
          ,Deltabase_Fields.InvalidMessage_inquiry_source(1)
          ,Deltabase_Fields.InvalidMessage_customer_county(1)
          ,Deltabase_Fields.InvalidMessage_customer_state(1),Deltabase_Fields.InvalidMessage_customer_state(2),Deltabase_Fields.InvalidMessage_customer_state(3)
          ,Deltabase_Fields.InvalidMessage_customer_agency_vertical_type(1)
          ,Deltabase_Fields.InvalidMessage_ssn(1),Deltabase_Fields.InvalidMessage_ssn(2),Deltabase_Fields.InvalidMessage_ssn(3)
          ,Deltabase_Fields.InvalidMessage_dob(1),Deltabase_Fields.InvalidMessage_dob(2)
          ,Deltabase_Fields.InvalidMessage_rawlinkid(1)
          ,Deltabase_Fields.InvalidMessage_raw_full_name(1),Deltabase_Fields.InvalidMessage_raw_full_name(2)
          ,Deltabase_Fields.InvalidMessage_raw_title(1)
          ,Deltabase_Fields.InvalidMessage_raw_first_name(1),Deltabase_Fields.InvalidMessage_raw_first_name(2)
          ,Deltabase_Fields.InvalidMessage_raw_middle_name(1),Deltabase_Fields.InvalidMessage_raw_middle_name(2)
          ,Deltabase_Fields.InvalidMessage_raw_last_name(1),Deltabase_Fields.InvalidMessage_raw_last_name(2)
          ,Deltabase_Fields.InvalidMessage_raw_orig_suffix(1)
          ,Deltabase_Fields.InvalidMessage_full_address(1)
          ,Deltabase_Fields.InvalidMessage_street_1(1)
          ,Deltabase_Fields.InvalidMessage_city(1),Deltabase_Fields.InvalidMessage_city(2)
          ,Deltabase_Fields.InvalidMessage_state(1),Deltabase_Fields.InvalidMessage_state(2),Deltabase_Fields.InvalidMessage_state(3)
          ,Deltabase_Fields.InvalidMessage_zip(1),Deltabase_Fields.InvalidMessage_zip(2),Deltabase_Fields.InvalidMessage_zip(3)
          ,Deltabase_Fields.InvalidMessage_county(1)
          ,Deltabase_Fields.InvalidMessage_mailing_street_1(1)
          ,Deltabase_Fields.InvalidMessage_mailing_city(1),Deltabase_Fields.InvalidMessage_mailing_city(2)
          ,Deltabase_Fields.InvalidMessage_mailing_state(1),Deltabase_Fields.InvalidMessage_mailing_state(2),Deltabase_Fields.InvalidMessage_mailing_state(3)
          ,Deltabase_Fields.InvalidMessage_mailing_zip(1),Deltabase_Fields.InvalidMessage_mailing_zip(2),Deltabase_Fields.InvalidMessage_mailing_zip(3)
          ,Deltabase_Fields.InvalidMessage_mailing_county(1)
          ,Deltabase_Fields.InvalidMessage_phone_number(1),Deltabase_Fields.InvalidMessage_phone_number(2),Deltabase_Fields.InvalidMessage_phone_number(3)
          ,Deltabase_Fields.InvalidMessage_ultid(1)
          ,Deltabase_Fields.InvalidMessage_orgid(1)
          ,Deltabase_Fields.InvalidMessage_seleid(1)
          ,Deltabase_Fields.InvalidMessage_tin(1)
          ,Deltabase_Fields.InvalidMessage_email_address(1)
          ,Deltabase_Fields.InvalidMessage_appended_provider_id(1)
          ,Deltabase_Fields.InvalidMessage_lnpid(1)
          ,Deltabase_Fields.InvalidMessage_npi(1)
          ,Deltabase_Fields.InvalidMessage_ip_address(1),Deltabase_Fields.InvalidMessage_ip_address(2)
          ,Deltabase_Fields.InvalidMessage_device_id(1)
          ,Deltabase_Fields.InvalidMessage_professional_id(1)
          ,Deltabase_Fields.InvalidMessage_bank_routing_number_1(1)
          ,Deltabase_Fields.InvalidMessage_bank_account_number_1(1)
          ,Deltabase_Fields.InvalidMessage_drivers_license_state(1)
          ,Deltabase_Fields.InvalidMessage_drivers_license(1)
          ,Deltabase_Fields.InvalidMessage_geo_lat(1)
          ,Deltabase_Fields.InvalidMessage_geo_long(1)
          ,Deltabase_Fields.InvalidMessage_reported_date(1),Deltabase_Fields.InvalidMessage_reported_date(2)
          ,Deltabase_Fields.InvalidMessage_file_type(1)
          ,Deltabase_Fields.InvalidMessage_deceitful_confidence(1)
          ,Deltabase_Fields.InvalidMessage_reported_by(1)
          ,Deltabase_Fields.InvalidMessage_reason_description(1)
          ,Deltabase_Fields.InvalidMessage_event_type_1(1)
          ,Deltabase_Fields.InvalidMessage_event_entity_1(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors'
          ,'Edited records'
          ,'Rules leading to edits','UNKNOWN');
EXPORT FromNone(DATASET(Deltabase_Layout_Deltabase) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.inqlog_id_Invalid := Deltabase_Fields.InValid_inqlog_id((SALT311.StrType)le.inqlog_id);
    SELF.inqlog_id := IF(SELF.inqlog_id_Invalid=0 OR NOT withOnfail, le.inqlog_id, (TYPEOF(le.inqlog_id))''); // ONFAIL(BLANK)
    SELF.inqlog_id_wouldClean :=  SELF.inqlog_id_Invalid > 0;
    SELF.customer_id_Invalid := Deltabase_Fields.InValid_customer_id((SALT311.StrType)le.customer_id);
    SELF.customer_id := IF(SELF.customer_id_Invalid=0 OR NOT withOnfail, le.customer_id, (TYPEOF(le.customer_id))''); // ONFAIL(BLANK)
    SELF.customer_id_wouldClean :=  SELF.customer_id_Invalid > 0;
    SELF.transaction_id_Invalid := Deltabase_Fields.InValid_transaction_id((SALT311.StrType)le.transaction_id);
    SELF.transaction_id := IF(SELF.transaction_id_Invalid=0 OR NOT withOnfail, le.transaction_id, (TYPEOF(le.transaction_id))''); // ONFAIL(BLANK)
    SELF.transaction_id_wouldClean :=  SELF.transaction_id_Invalid > 0;
    SELF.date_of_transaction_Invalid := Deltabase_Fields.InValid_date_of_transaction((SALT311.StrType)le.date_of_transaction);
    SELF.date_of_transaction := IF(SELF.date_of_transaction_Invalid=0 OR NOT withOnfail, le.date_of_transaction, (TYPEOF(le.date_of_transaction))''); // ONFAIL(BLANK)
    SELF.date_of_transaction_wouldClean :=  SELF.date_of_transaction_Invalid > 0;
    SELF.household_id_Invalid := Deltabase_Fields.InValid_household_id((SALT311.StrType)le.household_id);
    SELF.household_id := IF(SELF.household_id_Invalid=0 OR NOT withOnfail, le.household_id, (TYPEOF(le.household_id))''); // ONFAIL(BLANK)
    SELF.household_id_wouldClean :=  SELF.household_id_Invalid > 0;
    SELF.customer_person_id_Invalid := Deltabase_Fields.InValid_customer_person_id((SALT311.StrType)le.customer_person_id);
    SELF.customer_person_id := IF(SELF.customer_person_id_Invalid=0 OR NOT withOnfail, le.customer_person_id, (TYPEOF(le.customer_person_id))''); // ONFAIL(BLANK)
    SELF.customer_person_id_wouldClean :=  SELF.customer_person_id_Invalid > 0;
    SELF.customer_program_Invalid := Deltabase_Fields.InValid_customer_program((SALT311.StrType)le.customer_program);
    SELF.customer_program := IF(SELF.customer_program_Invalid=0 OR NOT withOnfail, le.customer_program, (TYPEOF(le.customer_program))''); // ONFAIL(BLANK)
    SELF.customer_program_wouldClean :=  SELF.customer_program_Invalid > 0;
    SELF.reason_for_transaction_activity_Invalid := Deltabase_Fields.InValid_reason_for_transaction_activity((SALT311.StrType)le.reason_for_transaction_activity);
    SELF.reason_for_transaction_activity := IF(SELF.reason_for_transaction_activity_Invalid=0 OR NOT withOnfail, le.reason_for_transaction_activity, (TYPEOF(le.reason_for_transaction_activity))''); // ONFAIL(BLANK)
    SELF.reason_for_transaction_activity_wouldClean :=  SELF.reason_for_transaction_activity_Invalid > 0;
    SELF.inquiry_source_Invalid := Deltabase_Fields.InValid_inquiry_source((SALT311.StrType)le.inquiry_source);
    SELF.inquiry_source := IF(SELF.inquiry_source_Invalid=0 OR NOT withOnfail, le.inquiry_source, (TYPEOF(le.inquiry_source))''); // ONFAIL(BLANK)
    SELF.inquiry_source_wouldClean :=  SELF.inquiry_source_Invalid > 0;
    SELF.customer_county_Invalid := Deltabase_Fields.InValid_customer_county((SALT311.StrType)le.customer_county);
    SELF.customer_county := IF(SELF.customer_county_Invalid=0 OR NOT withOnfail, le.customer_county, (TYPEOF(le.customer_county))''); // ONFAIL(BLANK)
    SELF.customer_county_wouldClean :=  SELF.customer_county_Invalid > 0;
    SELF.customer_state_Invalid := Deltabase_Fields.InValid_customer_state((SALT311.StrType)le.customer_state);
    SELF.customer_state := IF(SELF.customer_state_Invalid=0 OR NOT withOnfail, le.customer_state, (TYPEOF(le.customer_state))''); // ONFAIL(BLANK)
    SELF.customer_state_wouldClean :=  SELF.customer_state_Invalid > 0;
    SELF.customer_agency_vertical_type_Invalid := Deltabase_Fields.InValid_customer_agency_vertical_type((SALT311.StrType)le.customer_agency_vertical_type);
    SELF.customer_agency_vertical_type := IF(SELF.customer_agency_vertical_type_Invalid=0 OR NOT withOnfail, le.customer_agency_vertical_type, (TYPEOF(le.customer_agency_vertical_type))''); // ONFAIL(BLANK)
    SELF.customer_agency_vertical_type_wouldClean :=  SELF.customer_agency_vertical_type_Invalid > 0;
    SELF.ssn_Invalid := Deltabase_Fields.InValid_ssn((SALT311.StrType)le.ssn);
    SELF.ssn := IF(SELF.ssn_Invalid=0 OR NOT withOnfail, le.ssn, (TYPEOF(le.ssn))''); // ONFAIL(BLANK)
    SELF.ssn_wouldClean :=  SELF.ssn_Invalid > 0;
    SELF.dob_Invalid := Deltabase_Fields.InValid_dob((SALT311.StrType)le.dob);
    SELF.dob := IF(SELF.dob_Invalid=0 OR NOT withOnfail, le.dob, (TYPEOF(le.dob))''); // ONFAIL(BLANK)
    SELF.dob_wouldClean :=  SELF.dob_Invalid > 0;
    SELF.rawlinkid_Invalid := Deltabase_Fields.InValid_rawlinkid((SALT311.StrType)le.rawlinkid);
    SELF.rawlinkid := IF(SELF.rawlinkid_Invalid=0 OR NOT withOnfail, le.rawlinkid, (TYPEOF(le.rawlinkid))''); // ONFAIL(BLANK)
    SELF.rawlinkid_wouldClean :=  SELF.rawlinkid_Invalid > 0;
    SELF.raw_full_name_Invalid := Deltabase_Fields.InValid_raw_full_name((SALT311.StrType)le.raw_full_name);
    SELF.raw_full_name := IF(SELF.raw_full_name_Invalid=0 OR NOT withOnfail, le.raw_full_name, (TYPEOF(le.raw_full_name))''); // ONFAIL(BLANK)
    SELF.raw_full_name_wouldClean :=  SELF.raw_full_name_Invalid > 0;
    SELF.raw_title_Invalid := Deltabase_Fields.InValid_raw_title((SALT311.StrType)le.raw_title);
    SELF.raw_title := IF(SELF.raw_title_Invalid=0 OR NOT withOnfail, le.raw_title, (TYPEOF(le.raw_title))''); // ONFAIL(BLANK)
    SELF.raw_title_wouldClean :=  SELF.raw_title_Invalid > 0;
    SELF.raw_first_name_Invalid := Deltabase_Fields.InValid_raw_first_name((SALT311.StrType)le.raw_first_name);
    SELF.raw_first_name := IF(SELF.raw_first_name_Invalid=0 OR NOT withOnfail, le.raw_first_name, (TYPEOF(le.raw_first_name))''); // ONFAIL(BLANK)
    SELF.raw_first_name_wouldClean :=  SELF.raw_first_name_Invalid > 0;
    SELF.raw_middle_name_Invalid := Deltabase_Fields.InValid_raw_middle_name((SALT311.StrType)le.raw_middle_name);
    SELF.raw_middle_name := IF(SELF.raw_middle_name_Invalid=0 OR NOT withOnfail, le.raw_middle_name, (TYPEOF(le.raw_middle_name))''); // ONFAIL(BLANK)
    SELF.raw_middle_name_wouldClean :=  SELF.raw_middle_name_Invalid > 0;
    SELF.raw_last_name_Invalid := Deltabase_Fields.InValid_raw_last_name((SALT311.StrType)le.raw_last_name);
    SELF.raw_last_name := IF(SELF.raw_last_name_Invalid=0 OR NOT withOnfail, le.raw_last_name, (TYPEOF(le.raw_last_name))''); // ONFAIL(BLANK)
    SELF.raw_last_name_wouldClean :=  SELF.raw_last_name_Invalid > 0;
    SELF.raw_orig_suffix_Invalid := Deltabase_Fields.InValid_raw_orig_suffix((SALT311.StrType)le.raw_orig_suffix);
    SELF.raw_orig_suffix := IF(SELF.raw_orig_suffix_Invalid=0 OR NOT withOnfail, le.raw_orig_suffix, (TYPEOF(le.raw_orig_suffix))''); // ONFAIL(BLANK)
    SELF.raw_orig_suffix_wouldClean :=  SELF.raw_orig_suffix_Invalid > 0;
    SELF.full_address_Invalid := Deltabase_Fields.InValid_full_address((SALT311.StrType)le.full_address);
    SELF.full_address := IF(SELF.full_address_Invalid=0 OR NOT withOnfail, le.full_address, (TYPEOF(le.full_address))''); // ONFAIL(BLANK)
    SELF.full_address_wouldClean :=  SELF.full_address_Invalid > 0;
    SELF.street_1_Invalid := Deltabase_Fields.InValid_street_1((SALT311.StrType)le.street_1);
    SELF.street_1 := IF(SELF.street_1_Invalid=0 OR NOT withOnfail, le.street_1, (TYPEOF(le.street_1))''); // ONFAIL(BLANK)
    SELF.street_1_wouldClean :=  SELF.street_1_Invalid > 0;
    SELF.city_Invalid := Deltabase_Fields.InValid_city((SALT311.StrType)le.city);
    SELF.city := IF(SELF.city_Invalid=0 OR NOT withOnfail, le.city, (TYPEOF(le.city))''); // ONFAIL(BLANK)
    SELF.city_wouldClean :=  SELF.city_Invalid > 0;
    SELF.state_Invalid := Deltabase_Fields.InValid_state((SALT311.StrType)le.state);
    SELF.state := IF(SELF.state_Invalid=0 OR NOT withOnfail, le.state, (TYPEOF(le.state))''); // ONFAIL(BLANK)
    SELF.state_wouldClean :=  SELF.state_Invalid > 0;
    SELF.zip_Invalid := Deltabase_Fields.InValid_zip((SALT311.StrType)le.zip);
    SELF.zip := IF(SELF.zip_Invalid=0 OR NOT withOnfail, le.zip, (TYPEOF(le.zip))''); // ONFAIL(BLANK)
    SELF.zip_wouldClean :=  SELF.zip_Invalid > 0;
    SELF.county_Invalid := Deltabase_Fields.InValid_county((SALT311.StrType)le.county);
    SELF.county := IF(SELF.county_Invalid=0 OR NOT withOnfail, le.county, (TYPEOF(le.county))''); // ONFAIL(BLANK)
    SELF.county_wouldClean :=  SELF.county_Invalid > 0;
    SELF.mailing_street_1_Invalid := Deltabase_Fields.InValid_mailing_street_1((SALT311.StrType)le.mailing_street_1);
    SELF.mailing_street_1 := IF(SELF.mailing_street_1_Invalid=0 OR NOT withOnfail, le.mailing_street_1, (TYPEOF(le.mailing_street_1))''); // ONFAIL(BLANK)
    SELF.mailing_street_1_wouldClean :=  SELF.mailing_street_1_Invalid > 0;
    SELF.mailing_city_Invalid := Deltabase_Fields.InValid_mailing_city((SALT311.StrType)le.mailing_city);
    SELF.mailing_city := IF(SELF.mailing_city_Invalid=0 OR NOT withOnfail, le.mailing_city, (TYPEOF(le.mailing_city))''); // ONFAIL(BLANK)
    SELF.mailing_city_wouldClean :=  SELF.mailing_city_Invalid > 0;
    SELF.mailing_state_Invalid := Deltabase_Fields.InValid_mailing_state((SALT311.StrType)le.mailing_state);
    SELF.mailing_state := IF(SELF.mailing_state_Invalid=0 OR NOT withOnfail, le.mailing_state, (TYPEOF(le.mailing_state))''); // ONFAIL(BLANK)
    SELF.mailing_state_wouldClean :=  SELF.mailing_state_Invalid > 0;
    SELF.mailing_zip_Invalid := Deltabase_Fields.InValid_mailing_zip((SALT311.StrType)le.mailing_zip);
    SELF.mailing_zip := IF(SELF.mailing_zip_Invalid=0 OR NOT withOnfail, le.mailing_zip, (TYPEOF(le.mailing_zip))''); // ONFAIL(BLANK)
    SELF.mailing_zip_wouldClean :=  SELF.mailing_zip_Invalid > 0;
    SELF.mailing_county_Invalid := Deltabase_Fields.InValid_mailing_county((SALT311.StrType)le.mailing_county);
    SELF.mailing_county := IF(SELF.mailing_county_Invalid=0 OR NOT withOnfail, le.mailing_county, (TYPEOF(le.mailing_county))''); // ONFAIL(BLANK)
    SELF.mailing_county_wouldClean :=  SELF.mailing_county_Invalid > 0;
    SELF.phone_number_Invalid := Deltabase_Fields.InValid_phone_number((SALT311.StrType)le.phone_number);
    SELF.phone_number := IF(SELF.phone_number_Invalid=0 OR NOT withOnfail, le.phone_number, (TYPEOF(le.phone_number))''); // ONFAIL(BLANK)
    SELF.phone_number_wouldClean :=  SELF.phone_number_Invalid > 0;
    SELF.ultid_Invalid := Deltabase_Fields.InValid_ultid((SALT311.StrType)le.ultid);
    SELF.ultid := IF(SELF.ultid_Invalid=0 OR NOT withOnfail, le.ultid, (TYPEOF(le.ultid))''); // ONFAIL(BLANK)
    SELF.ultid_wouldClean :=  SELF.ultid_Invalid > 0;
    SELF.orgid_Invalid := Deltabase_Fields.InValid_orgid((SALT311.StrType)le.orgid);
    SELF.orgid := IF(SELF.orgid_Invalid=0 OR NOT withOnfail, le.orgid, (TYPEOF(le.orgid))''); // ONFAIL(BLANK)
    SELF.orgid_wouldClean :=  SELF.orgid_Invalid > 0;
    SELF.seleid_Invalid := Deltabase_Fields.InValid_seleid((SALT311.StrType)le.seleid);
    SELF.seleid := IF(SELF.seleid_Invalid=0 OR NOT withOnfail, le.seleid, (TYPEOF(le.seleid))''); // ONFAIL(BLANK)
    SELF.seleid_wouldClean :=  SELF.seleid_Invalid > 0;
    SELF.tin_Invalid := Deltabase_Fields.InValid_tin((SALT311.StrType)le.tin);
    SELF.tin := IF(SELF.tin_Invalid=0 OR NOT withOnfail, le.tin, (TYPEOF(le.tin))''); // ONFAIL(BLANK)
    SELF.tin_wouldClean :=  SELF.tin_Invalid > 0;
    SELF.email_address_Invalid := Deltabase_Fields.InValid_email_address((SALT311.StrType)le.email_address);
    SELF.email_address := IF(SELF.email_address_Invalid=0 OR NOT withOnfail, le.email_address, (TYPEOF(le.email_address))''); // ONFAIL(BLANK)
    SELF.email_address_wouldClean :=  SELF.email_address_Invalid > 0;
    SELF.appended_provider_id_Invalid := Deltabase_Fields.InValid_appended_provider_id((SALT311.StrType)le.appended_provider_id);
    SELF.appended_provider_id := IF(SELF.appended_provider_id_Invalid=0 OR NOT withOnfail, le.appended_provider_id, (TYPEOF(le.appended_provider_id))''); // ONFAIL(BLANK)
    SELF.appended_provider_id_wouldClean :=  SELF.appended_provider_id_Invalid > 0;
    SELF.lnpid_Invalid := Deltabase_Fields.InValid_lnpid((SALT311.StrType)le.lnpid);
    SELF.lnpid := IF(SELF.lnpid_Invalid=0 OR NOT withOnfail, le.lnpid, (TYPEOF(le.lnpid))''); // ONFAIL(BLANK)
    SELF.lnpid_wouldClean :=  SELF.lnpid_Invalid > 0;
    SELF.npi_Invalid := Deltabase_Fields.InValid_npi((SALT311.StrType)le.npi);
    SELF.npi := IF(SELF.npi_Invalid=0 OR NOT withOnfail, le.npi, (TYPEOF(le.npi))''); // ONFAIL(BLANK)
    SELF.npi_wouldClean :=  SELF.npi_Invalid > 0;
    SELF.ip_address_Invalid := Deltabase_Fields.InValid_ip_address((SALT311.StrType)le.ip_address);
    SELF.ip_address := IF(SELF.ip_address_Invalid=0 OR NOT withOnfail, le.ip_address, (TYPEOF(le.ip_address))''); // ONFAIL(BLANK)
    SELF.ip_address_wouldClean :=  SELF.ip_address_Invalid > 0;
    SELF.device_id_Invalid := Deltabase_Fields.InValid_device_id((SALT311.StrType)le.device_id);
    SELF.device_id := IF(SELF.device_id_Invalid=0 OR NOT withOnfail, le.device_id, (TYPEOF(le.device_id))''); // ONFAIL(BLANK)
    SELF.device_id_wouldClean :=  SELF.device_id_Invalid > 0;
    SELF.professional_id_Invalid := Deltabase_Fields.InValid_professional_id((SALT311.StrType)le.professional_id);
    SELF.professional_id := IF(SELF.professional_id_Invalid=0 OR NOT withOnfail, le.professional_id, (TYPEOF(le.professional_id))''); // ONFAIL(BLANK)
    SELF.professional_id_wouldClean :=  SELF.professional_id_Invalid > 0;
    SELF.bank_routing_number_1_Invalid := Deltabase_Fields.InValid_bank_routing_number_1((SALT311.StrType)le.bank_routing_number_1);
    SELF.bank_routing_number_1 := IF(SELF.bank_routing_number_1_Invalid=0 OR NOT withOnfail, le.bank_routing_number_1, (TYPEOF(le.bank_routing_number_1))''); // ONFAIL(BLANK)
    SELF.bank_routing_number_1_wouldClean :=  SELF.bank_routing_number_1_Invalid > 0;
    SELF.bank_account_number_1_Invalid := Deltabase_Fields.InValid_bank_account_number_1((SALT311.StrType)le.bank_account_number_1);
    SELF.bank_account_number_1 := IF(SELF.bank_account_number_1_Invalid=0 OR NOT withOnfail, le.bank_account_number_1, (TYPEOF(le.bank_account_number_1))''); // ONFAIL(BLANK)
    SELF.bank_account_number_1_wouldClean :=  SELF.bank_account_number_1_Invalid > 0;
    SELF.drivers_license_state_Invalid := Deltabase_Fields.InValid_drivers_license_state((SALT311.StrType)le.drivers_license_state);
    SELF.drivers_license_state := IF(SELF.drivers_license_state_Invalid=0 OR NOT withOnfail, le.drivers_license_state, (TYPEOF(le.drivers_license_state))''); // ONFAIL(BLANK)
    SELF.drivers_license_state_wouldClean :=  SELF.drivers_license_state_Invalid > 0;
    SELF.drivers_license_Invalid := Deltabase_Fields.InValid_drivers_license((SALT311.StrType)le.drivers_license);
    SELF.drivers_license := IF(SELF.drivers_license_Invalid=0 OR NOT withOnfail, le.drivers_license, (TYPEOF(le.drivers_license))''); // ONFAIL(BLANK)
    SELF.drivers_license_wouldClean :=  SELF.drivers_license_Invalid > 0;
    SELF.geo_lat_Invalid := Deltabase_Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat);
    SELF.geo_lat := IF(SELF.geo_lat_Invalid=0 OR NOT withOnfail, le.geo_lat, (TYPEOF(le.geo_lat))''); // ONFAIL(BLANK)
    SELF.geo_lat_wouldClean :=  SELF.geo_lat_Invalid > 0;
    SELF.geo_long_Invalid := Deltabase_Fields.InValid_geo_long((SALT311.StrType)le.geo_long);
    SELF.geo_long := IF(SELF.geo_long_Invalid=0 OR NOT withOnfail, le.geo_long, (TYPEOF(le.geo_long))''); // ONFAIL(BLANK)
    SELF.geo_long_wouldClean :=  SELF.geo_long_Invalid > 0;
    SELF.reported_date_Invalid := Deltabase_Fields.InValid_reported_date((SALT311.StrType)le.reported_date);
    SELF.reported_date := IF(SELF.reported_date_Invalid=0 OR NOT withOnfail, le.reported_date, (TYPEOF(le.reported_date))''); // ONFAIL(BLANK)
    SELF.reported_date_wouldClean :=  SELF.reported_date_Invalid > 0;
    SELF.file_type_Invalid := Deltabase_Fields.InValid_file_type((SALT311.StrType)le.file_type);
    SELF.file_type := IF(SELF.file_type_Invalid=0 OR NOT withOnfail, le.file_type, (TYPEOF(le.file_type))''); // ONFAIL(BLANK)
    SELF.file_type_wouldClean :=  SELF.file_type_Invalid > 0;
    SELF.deceitful_confidence_Invalid := Deltabase_Fields.InValid_deceitful_confidence((SALT311.StrType)le.deceitful_confidence);
    SELF.deceitful_confidence := IF(SELF.deceitful_confidence_Invalid=0 OR NOT withOnfail, le.deceitful_confidence, (TYPEOF(le.deceitful_confidence))''); // ONFAIL(BLANK)
    SELF.deceitful_confidence_wouldClean :=  SELF.deceitful_confidence_Invalid > 0;
    SELF.reported_by_Invalid := Deltabase_Fields.InValid_reported_by((SALT311.StrType)le.reported_by);
    SELF.reported_by := IF(SELF.reported_by_Invalid=0 OR NOT withOnfail, le.reported_by, (TYPEOF(le.reported_by))''); // ONFAIL(BLANK)
    SELF.reported_by_wouldClean :=  SELF.reported_by_Invalid > 0;
    SELF.reason_description_Invalid := Deltabase_Fields.InValid_reason_description((SALT311.StrType)le.reason_description);
    SELF.reason_description := IF(SELF.reason_description_Invalid=0 OR NOT withOnfail, le.reason_description, (TYPEOF(le.reason_description))''); // ONFAIL(BLANK)
    SELF.reason_description_wouldClean :=  SELF.reason_description_Invalid > 0;
    SELF.event_type_1_Invalid := Deltabase_Fields.InValid_event_type_1((SALT311.StrType)le.event_type_1);
    SELF.event_type_1 := IF(SELF.event_type_1_Invalid=0 OR NOT withOnfail, le.event_type_1, (TYPEOF(le.event_type_1))''); // ONFAIL(BLANK)
    SELF.event_type_1_wouldClean :=  SELF.event_type_1_Invalid > 0;
    SELF.event_entity_1_Invalid := Deltabase_Fields.InValid_event_entity_1((SALT311.StrType)le.event_entity_1);
    SELF.event_entity_1 := IF(SELF.event_entity_1_Invalid=0 OR NOT withOnfail, le.event_entity_1, (TYPEOF(le.event_entity_1))''); // ONFAIL(BLANK)
    SELF.event_entity_1_wouldClean :=  SELF.event_entity_1_Invalid > 0;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Deltabase_Layout_Deltabase);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.inqlog_id_Invalid << 0 ) + ( le.customer_id_Invalid << 1 ) + ( le.transaction_id_Invalid << 2 ) + ( le.date_of_transaction_Invalid << 3 ) + ( le.household_id_Invalid << 5 ) + ( le.customer_person_id_Invalid << 6 ) + ( le.customer_program_Invalid << 7 ) + ( le.reason_for_transaction_activity_Invalid << 8 ) + ( le.inquiry_source_Invalid << 9 ) + ( le.customer_county_Invalid << 10 ) + ( le.customer_state_Invalid << 11 ) + ( le.customer_agency_vertical_type_Invalid << 13 ) + ( le.ssn_Invalid << 14 ) + ( le.dob_Invalid << 16 ) + ( le.rawlinkid_Invalid << 18 ) + ( le.raw_full_name_Invalid << 19 ) + ( le.raw_title_Invalid << 21 ) + ( le.raw_first_name_Invalid << 22 ) + ( le.raw_middle_name_Invalid << 24 ) + ( le.raw_last_name_Invalid << 26 ) + ( le.raw_orig_suffix_Invalid << 28 ) + ( le.full_address_Invalid << 29 ) + ( le.street_1_Invalid << 30 ) + ( le.city_Invalid << 31 ) + ( le.state_Invalid << 33 ) + ( le.zip_Invalid << 35 ) + ( le.county_Invalid << 37 ) + ( le.mailing_street_1_Invalid << 38 ) + ( le.mailing_city_Invalid << 39 ) + ( le.mailing_state_Invalid << 41 ) + ( le.mailing_zip_Invalid << 43 ) + ( le.mailing_county_Invalid << 45 ) + ( le.phone_number_Invalid << 46 ) + ( le.ultid_Invalid << 48 ) + ( le.orgid_Invalid << 49 ) + ( le.seleid_Invalid << 50 ) + ( le.tin_Invalid << 51 ) + ( le.email_address_Invalid << 52 ) + ( le.appended_provider_id_Invalid << 53 ) + ( le.lnpid_Invalid << 54 ) + ( le.npi_Invalid << 55 ) + ( le.ip_address_Invalid << 56 ) + ( le.device_id_Invalid << 58 ) + ( le.professional_id_Invalid << 59 ) + ( le.bank_routing_number_1_Invalid << 60 ) + ( le.bank_account_number_1_Invalid << 61 ) + ( le.drivers_license_state_Invalid << 62 ) + ( le.drivers_license_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.geo_lat_Invalid << 0 ) + ( le.geo_long_Invalid << 1 ) + ( le.reported_date_Invalid << 2 ) + ( le.file_type_Invalid << 4 ) + ( le.deceitful_confidence_Invalid << 5 ) + ( le.reported_by_Invalid << 6 ) + ( le.reason_description_Invalid << 7 ) + ( le.event_type_1_Invalid << 8 ) + ( le.event_entity_1_Invalid << 9 );
    SELF.ScrubsCleanBits1 := ( IF(le.inqlog_id_wouldClean, 1, 0) << 0 ) + ( IF(le.customer_id_wouldClean, 1, 0) << 1 ) + ( IF(le.transaction_id_wouldClean, 1, 0) << 2 ) + ( IF(le.date_of_transaction_wouldClean, 1, 0) << 3 ) + ( IF(le.household_id_wouldClean, 1, 0) << 4 ) + ( IF(le.customer_person_id_wouldClean, 1, 0) << 5 ) + ( IF(le.customer_program_wouldClean, 1, 0) << 6 ) + ( IF(le.reason_for_transaction_activity_wouldClean, 1, 0) << 7 ) + ( IF(le.inquiry_source_wouldClean, 1, 0) << 8 ) + ( IF(le.customer_county_wouldClean, 1, 0) << 9 ) + ( IF(le.customer_state_wouldClean, 1, 0) << 10 ) + ( IF(le.customer_agency_vertical_type_wouldClean, 1, 0) << 11 ) + ( IF(le.ssn_wouldClean, 1, 0) << 12 ) + ( IF(le.dob_wouldClean, 1, 0) << 13 ) + ( IF(le.rawlinkid_wouldClean, 1, 0) << 14 ) + ( IF(le.raw_full_name_wouldClean, 1, 0) << 15 ) + ( IF(le.raw_title_wouldClean, 1, 0) << 16 ) + ( IF(le.raw_first_name_wouldClean, 1, 0) << 17 ) + ( IF(le.raw_middle_name_wouldClean, 1, 0) << 18 ) + ( IF(le.raw_last_name_wouldClean, 1, 0) << 19 ) + ( IF(le.raw_orig_suffix_wouldClean, 1, 0) << 20 ) + ( IF(le.full_address_wouldClean, 1, 0) << 21 ) + ( IF(le.street_1_wouldClean, 1, 0) << 22 ) + ( IF(le.city_wouldClean, 1, 0) << 23 ) + ( IF(le.state_wouldClean, 1, 0) << 24 ) + ( IF(le.zip_wouldClean, 1, 0) << 25 ) + ( IF(le.county_wouldClean, 1, 0) << 26 ) + ( IF(le.mailing_street_1_wouldClean, 1, 0) << 27 ) + ( IF(le.mailing_city_wouldClean, 1, 0) << 28 ) + ( IF(le.mailing_state_wouldClean, 1, 0) << 29 ) + ( IF(le.mailing_zip_wouldClean, 1, 0) << 30 ) + ( IF(le.mailing_county_wouldClean, 1, 0) << 31 ) + ( IF(le.phone_number_wouldClean, 1, 0) << 32 ) + ( IF(le.ultid_wouldClean, 1, 0) << 33 ) + ( IF(le.orgid_wouldClean, 1, 0) << 34 ) + ( IF(le.seleid_wouldClean, 1, 0) << 35 ) + ( IF(le.tin_wouldClean, 1, 0) << 36 ) + ( IF(le.email_address_wouldClean, 1, 0) << 37 ) + ( IF(le.appended_provider_id_wouldClean, 1, 0) << 38 ) + ( IF(le.lnpid_wouldClean, 1, 0) << 39 ) + ( IF(le.npi_wouldClean, 1, 0) << 40 ) + ( IF(le.ip_address_wouldClean, 1, 0) << 41 ) + ( IF(le.device_id_wouldClean, 1, 0) << 42 ) + ( IF(le.professional_id_wouldClean, 1, 0) << 43 ) + ( IF(le.bank_routing_number_1_wouldClean, 1, 0) << 44 ) + ( IF(le.bank_account_number_1_wouldClean, 1, 0) << 45 ) + ( IF(le.drivers_license_state_wouldClean, 1, 0) << 46 ) + ( IF(le.drivers_license_wouldClean, 1, 0) << 47 ) + ( IF(le.geo_lat_wouldClean, 1, 0) << 48 ) + ( IF(le.geo_long_wouldClean, 1, 0) << 49 ) + ( IF(le.reported_date_wouldClean, 1, 0) << 50 ) + ( IF(le.file_type_wouldClean, 1, 0) << 51 ) + ( IF(le.deceitful_confidence_wouldClean, 1, 0) << 52 ) + ( IF(le.reported_by_wouldClean, 1, 0) << 53 ) + ( IF(le.reason_description_wouldClean, 1, 0) << 54 ) + ( IF(le.event_type_1_wouldClean, 1, 0) << 55 ) + ( IF(le.event_entity_1_wouldClean, 1, 0) << 56 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0 OR (mask&le.ScrubsBits2)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND le.ScrubsBits2=0 AND c=1,'',SKIP));
    SELF := le;
  END;
  unrolled := NORMALIZE(BitmapInfile,NumRules,IntoRule(LEFT,COUNTER));
  Rule_Layout toRoll(Rule_Layout le,Rule_Layout ri) := TRANSFORM
    SELF.Rules := TRIM(le.Rules) + IF(LENGTH(TRIM(le.Rules))>0 AND LENGTH(TRIM(ri.Rules))>0,',','') + TRIM(ri.Rules);
    SELF := le;
  END;
  EXPORT RulesInfile := ROLLUP(unrolled,toRoll(LEFT,RIGHT),EXCEPT Rules);
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Deltabase_Layout_Deltabase);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.inqlog_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.customer_id_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.transaction_id_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.date_of_transaction_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.household_id_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.customer_person_id_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.customer_program_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.reason_for_transaction_activity_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.inquiry_source_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.customer_county_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.customer_state_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.customer_agency_vertical_type_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.ssn_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.rawlinkid_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.raw_full_name_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.raw_title_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.raw_first_name_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.raw_middle_name_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.raw_last_name_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.raw_orig_suffix_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.full_address_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.street_1_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 31) & 3;
    SELF.state_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.county_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.mailing_street_1_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.mailing_city_Invalid := (le.ScrubsBits1 >> 39) & 3;
    SELF.mailing_state_Invalid := (le.ScrubsBits1 >> 41) & 3;
    SELF.mailing_zip_Invalid := (le.ScrubsBits1 >> 43) & 3;
    SELF.mailing_county_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.phone_number_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.ultid_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.orgid_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.seleid_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.tin_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.email_address_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.appended_provider_id_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.lnpid_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.npi_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.ip_address_Invalid := (le.ScrubsBits1 >> 56) & 3;
    SELF.device_id_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.professional_id_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.bank_routing_number_1_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.bank_account_number_1_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.drivers_license_state_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.drivers_license_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.geo_lat_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.geo_long_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.reported_date_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.file_type_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.deceitful_confidence_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.reported_by_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.reason_description_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.event_type_1_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.event_entity_1_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.inqlog_id_wouldClean := le.ScrubsCleanBits1 >> 0;
    SELF.customer_id_wouldClean := le.ScrubsCleanBits1 >> 1;
    SELF.transaction_id_wouldClean := le.ScrubsCleanBits1 >> 2;
    SELF.date_of_transaction_wouldClean := le.ScrubsCleanBits1 >> 3;
    SELF.household_id_wouldClean := le.ScrubsCleanBits1 >> 4;
    SELF.customer_person_id_wouldClean := le.ScrubsCleanBits1 >> 5;
    SELF.customer_program_wouldClean := le.ScrubsCleanBits1 >> 6;
    SELF.reason_for_transaction_activity_wouldClean := le.ScrubsCleanBits1 >> 7;
    SELF.inquiry_source_wouldClean := le.ScrubsCleanBits1 >> 8;
    SELF.customer_county_wouldClean := le.ScrubsCleanBits1 >> 9;
    SELF.customer_state_wouldClean := le.ScrubsCleanBits1 >> 10;
    SELF.customer_agency_vertical_type_wouldClean := le.ScrubsCleanBits1 >> 11;
    SELF.ssn_wouldClean := le.ScrubsCleanBits1 >> 12;
    SELF.dob_wouldClean := le.ScrubsCleanBits1 >> 13;
    SELF.rawlinkid_wouldClean := le.ScrubsCleanBits1 >> 14;
    SELF.raw_full_name_wouldClean := le.ScrubsCleanBits1 >> 15;
    SELF.raw_title_wouldClean := le.ScrubsCleanBits1 >> 16;
    SELF.raw_first_name_wouldClean := le.ScrubsCleanBits1 >> 17;
    SELF.raw_middle_name_wouldClean := le.ScrubsCleanBits1 >> 18;
    SELF.raw_last_name_wouldClean := le.ScrubsCleanBits1 >> 19;
    SELF.raw_orig_suffix_wouldClean := le.ScrubsCleanBits1 >> 20;
    SELF.full_address_wouldClean := le.ScrubsCleanBits1 >> 21;
    SELF.street_1_wouldClean := le.ScrubsCleanBits1 >> 22;
    SELF.city_wouldClean := le.ScrubsCleanBits1 >> 23;
    SELF.state_wouldClean := le.ScrubsCleanBits1 >> 24;
    SELF.zip_wouldClean := le.ScrubsCleanBits1 >> 25;
    SELF.county_wouldClean := le.ScrubsCleanBits1 >> 26;
    SELF.mailing_street_1_wouldClean := le.ScrubsCleanBits1 >> 27;
    SELF.mailing_city_wouldClean := le.ScrubsCleanBits1 >> 28;
    SELF.mailing_state_wouldClean := le.ScrubsCleanBits1 >> 29;
    SELF.mailing_zip_wouldClean := le.ScrubsCleanBits1 >> 30;
    SELF.mailing_county_wouldClean := le.ScrubsCleanBits1 >> 31;
    SELF.phone_number_wouldClean := le.ScrubsCleanBits1 >> 32;
    SELF.ultid_wouldClean := le.ScrubsCleanBits1 >> 33;
    SELF.orgid_wouldClean := le.ScrubsCleanBits1 >> 34;
    SELF.seleid_wouldClean := le.ScrubsCleanBits1 >> 35;
    SELF.tin_wouldClean := le.ScrubsCleanBits1 >> 36;
    SELF.email_address_wouldClean := le.ScrubsCleanBits1 >> 37;
    SELF.appended_provider_id_wouldClean := le.ScrubsCleanBits1 >> 38;
    SELF.lnpid_wouldClean := le.ScrubsCleanBits1 >> 39;
    SELF.npi_wouldClean := le.ScrubsCleanBits1 >> 40;
    SELF.ip_address_wouldClean := le.ScrubsCleanBits1 >> 41;
    SELF.device_id_wouldClean := le.ScrubsCleanBits1 >> 42;
    SELF.professional_id_wouldClean := le.ScrubsCleanBits1 >> 43;
    SELF.bank_routing_number_1_wouldClean := le.ScrubsCleanBits1 >> 44;
    SELF.bank_account_number_1_wouldClean := le.ScrubsCleanBits1 >> 45;
    SELF.drivers_license_state_wouldClean := le.ScrubsCleanBits1 >> 46;
    SELF.drivers_license_wouldClean := le.ScrubsCleanBits1 >> 47;
    SELF.geo_lat_wouldClean := le.ScrubsCleanBits1 >> 48;
    SELF.geo_long_wouldClean := le.ScrubsCleanBits1 >> 49;
    SELF.reported_date_wouldClean := le.ScrubsCleanBits1 >> 50;
    SELF.file_type_wouldClean := le.ScrubsCleanBits1 >> 51;
    SELF.deceitful_confidence_wouldClean := le.ScrubsCleanBits1 >> 52;
    SELF.reported_by_wouldClean := le.ScrubsCleanBits1 >> 53;
    SELF.reason_description_wouldClean := le.ScrubsCleanBits1 >> 54;
    SELF.event_type_1_wouldClean := le.ScrubsCleanBits1 >> 55;
    SELF.event_entity_1_wouldClean := le.ScrubsCleanBits1 >> 56;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    inqlog_id_ALLOW_ErrorCount := COUNT(GROUP,h.inqlog_id_Invalid=1);
    inqlog_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.inqlog_id_Invalid=1 AND h.inqlog_id_wouldClean);
    customer_id_ALLOW_ErrorCount := COUNT(GROUP,h.customer_id_Invalid=1);
    customer_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.customer_id_Invalid=1 AND h.customer_id_wouldClean);
    transaction_id_ALLOW_ErrorCount := COUNT(GROUP,h.transaction_id_Invalid=1);
    transaction_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.transaction_id_Invalid=1 AND h.transaction_id_wouldClean);
    date_of_transaction_LEFTTRIM_ErrorCount := COUNT(GROUP,h.date_of_transaction_Invalid=1);
    date_of_transaction_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.date_of_transaction_Invalid=1 AND h.date_of_transaction_wouldClean);
    date_of_transaction_ALLOW_ErrorCount := COUNT(GROUP,h.date_of_transaction_Invalid=2);
    date_of_transaction_ALLOW_WouldModifyCount := COUNT(GROUP,h.date_of_transaction_Invalid=2 AND h.date_of_transaction_wouldClean);
    date_of_transaction_Total_ErrorCount := COUNT(GROUP,h.date_of_transaction_Invalid>0);
    household_id_ALLOW_ErrorCount := COUNT(GROUP,h.household_id_Invalid=1);
    household_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.household_id_Invalid=1 AND h.household_id_wouldClean);
    customer_person_id_ALLOW_ErrorCount := COUNT(GROUP,h.customer_person_id_Invalid=1);
    customer_person_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.customer_person_id_Invalid=1 AND h.customer_person_id_wouldClean);
    customer_program_ALLOW_ErrorCount := COUNT(GROUP,h.customer_program_Invalid=1);
    customer_program_ALLOW_WouldModifyCount := COUNT(GROUP,h.customer_program_Invalid=1 AND h.customer_program_wouldClean);
    reason_for_transaction_activity_ALLOW_ErrorCount := COUNT(GROUP,h.reason_for_transaction_activity_Invalid=1);
    reason_for_transaction_activity_ALLOW_WouldModifyCount := COUNT(GROUP,h.reason_for_transaction_activity_Invalid=1 AND h.reason_for_transaction_activity_wouldClean);
    inquiry_source_ALLOW_ErrorCount := COUNT(GROUP,h.inquiry_source_Invalid=1);
    inquiry_source_ALLOW_WouldModifyCount := COUNT(GROUP,h.inquiry_source_Invalid=1 AND h.inquiry_source_wouldClean);
    customer_county_ALLOW_ErrorCount := COUNT(GROUP,h.customer_county_Invalid=1);
    customer_county_ALLOW_WouldModifyCount := COUNT(GROUP,h.customer_county_Invalid=1 AND h.customer_county_wouldClean);
    customer_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.customer_state_Invalid=1);
    customer_state_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.customer_state_Invalid=1 AND h.customer_state_wouldClean);
    customer_state_ALLOW_ErrorCount := COUNT(GROUP,h.customer_state_Invalid=2);
    customer_state_ALLOW_WouldModifyCount := COUNT(GROUP,h.customer_state_Invalid=2 AND h.customer_state_wouldClean);
    customer_state_LENGTHS_ErrorCount := COUNT(GROUP,h.customer_state_Invalid=3);
    customer_state_LENGTHS_WouldModifyCount := COUNT(GROUP,h.customer_state_Invalid=3 AND h.customer_state_wouldClean);
    customer_state_Total_ErrorCount := COUNT(GROUP,h.customer_state_Invalid>0);
    customer_agency_vertical_type_ALLOW_ErrorCount := COUNT(GROUP,h.customer_agency_vertical_type_Invalid=1);
    customer_agency_vertical_type_ALLOW_WouldModifyCount := COUNT(GROUP,h.customer_agency_vertical_type_Invalid=1 AND h.customer_agency_vertical_type_wouldClean);
    ssn_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    ssn_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.ssn_Invalid=1 AND h.ssn_wouldClean);
    ssn_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_Invalid=2);
    ssn_ALLOW_WouldModifyCount := COUNT(GROUP,h.ssn_Invalid=2 AND h.ssn_wouldClean);
    ssn_LENGTHS_ErrorCount := COUNT(GROUP,h.ssn_Invalid=3);
    ssn_LENGTHS_WouldModifyCount := COUNT(GROUP,h.ssn_Invalid=3 AND h.ssn_wouldClean);
    ssn_Total_ErrorCount := COUNT(GROUP,h.ssn_Invalid>0);
    dob_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    dob_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.dob_Invalid=1 AND h.dob_wouldClean);
    dob_ALLOW_ErrorCount := COUNT(GROUP,h.dob_Invalid=2);
    dob_ALLOW_WouldModifyCount := COUNT(GROUP,h.dob_Invalid=2 AND h.dob_wouldClean);
    dob_Total_ErrorCount := COUNT(GROUP,h.dob_Invalid>0);
    rawlinkid_ALLOW_ErrorCount := COUNT(GROUP,h.rawlinkid_Invalid=1);
    rawlinkid_ALLOW_WouldModifyCount := COUNT(GROUP,h.rawlinkid_Invalid=1 AND h.rawlinkid_wouldClean);
    raw_full_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.raw_full_name_Invalid=1);
    raw_full_name_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.raw_full_name_Invalid=1 AND h.raw_full_name_wouldClean);
    raw_full_name_ALLOW_ErrorCount := COUNT(GROUP,h.raw_full_name_Invalid=2);
    raw_full_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.raw_full_name_Invalid=2 AND h.raw_full_name_wouldClean);
    raw_full_name_Total_ErrorCount := COUNT(GROUP,h.raw_full_name_Invalid>0);
    raw_title_ALLOW_ErrorCount := COUNT(GROUP,h.raw_title_Invalid=1);
    raw_title_ALLOW_WouldModifyCount := COUNT(GROUP,h.raw_title_Invalid=1 AND h.raw_title_wouldClean);
    raw_first_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.raw_first_name_Invalid=1);
    raw_first_name_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.raw_first_name_Invalid=1 AND h.raw_first_name_wouldClean);
    raw_first_name_ALLOW_ErrorCount := COUNT(GROUP,h.raw_first_name_Invalid=2);
    raw_first_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.raw_first_name_Invalid=2 AND h.raw_first_name_wouldClean);
    raw_first_name_Total_ErrorCount := COUNT(GROUP,h.raw_first_name_Invalid>0);
    raw_middle_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.raw_middle_name_Invalid=1);
    raw_middle_name_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.raw_middle_name_Invalid=1 AND h.raw_middle_name_wouldClean);
    raw_middle_name_ALLOW_ErrorCount := COUNT(GROUP,h.raw_middle_name_Invalid=2);
    raw_middle_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.raw_middle_name_Invalid=2 AND h.raw_middle_name_wouldClean);
    raw_middle_name_Total_ErrorCount := COUNT(GROUP,h.raw_middle_name_Invalid>0);
    raw_last_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.raw_last_name_Invalid=1);
    raw_last_name_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.raw_last_name_Invalid=1 AND h.raw_last_name_wouldClean);
    raw_last_name_ALLOW_ErrorCount := COUNT(GROUP,h.raw_last_name_Invalid=2);
    raw_last_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.raw_last_name_Invalid=2 AND h.raw_last_name_wouldClean);
    raw_last_name_Total_ErrorCount := COUNT(GROUP,h.raw_last_name_Invalid>0);
    raw_orig_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.raw_orig_suffix_Invalid=1);
    raw_orig_suffix_ALLOW_WouldModifyCount := COUNT(GROUP,h.raw_orig_suffix_Invalid=1 AND h.raw_orig_suffix_wouldClean);
    full_address_ALLOW_ErrorCount := COUNT(GROUP,h.full_address_Invalid=1);
    full_address_ALLOW_WouldModifyCount := COUNT(GROUP,h.full_address_Invalid=1 AND h.full_address_wouldClean);
    street_1_ALLOW_ErrorCount := COUNT(GROUP,h.street_1_Invalid=1);
    street_1_ALLOW_WouldModifyCount := COUNT(GROUP,h.street_1_Invalid=1 AND h.street_1_wouldClean);
    city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    city_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.city_Invalid=1 AND h.city_wouldClean);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=2);
    city_ALLOW_WouldModifyCount := COUNT(GROUP,h.city_Invalid=2 AND h.city_wouldClean);
    city_Total_ErrorCount := COUNT(GROUP,h.city_Invalid>0);
    state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.state_Invalid=1 AND h.state_wouldClean);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_ALLOW_WouldModifyCount := COUNT(GROUP,h.state_Invalid=2 AND h.state_wouldClean);
    state_LENGTHS_ErrorCount := COUNT(GROUP,h.state_Invalid=3);
    state_LENGTHS_WouldModifyCount := COUNT(GROUP,h.state_Invalid=3 AND h.state_wouldClean);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.zip_Invalid=1 AND h.zip_wouldClean);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_ALLOW_WouldModifyCount := COUNT(GROUP,h.zip_Invalid=2 AND h.zip_wouldClean);
    zip_LENGTHS_ErrorCount := COUNT(GROUP,h.zip_Invalid=3);
    zip_LENGTHS_WouldModifyCount := COUNT(GROUP,h.zip_Invalid=3 AND h.zip_wouldClean);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    county_ALLOW_ErrorCount := COUNT(GROUP,h.county_Invalid=1);
    county_ALLOW_WouldModifyCount := COUNT(GROUP,h.county_Invalid=1 AND h.county_wouldClean);
    mailing_street_1_ALLOW_ErrorCount := COUNT(GROUP,h.mailing_street_1_Invalid=1);
    mailing_street_1_ALLOW_WouldModifyCount := COUNT(GROUP,h.mailing_street_1_Invalid=1 AND h.mailing_street_1_wouldClean);
    mailing_city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.mailing_city_Invalid=1);
    mailing_city_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.mailing_city_Invalid=1 AND h.mailing_city_wouldClean);
    mailing_city_ALLOW_ErrorCount := COUNT(GROUP,h.mailing_city_Invalid=2);
    mailing_city_ALLOW_WouldModifyCount := COUNT(GROUP,h.mailing_city_Invalid=2 AND h.mailing_city_wouldClean);
    mailing_city_Total_ErrorCount := COUNT(GROUP,h.mailing_city_Invalid>0);
    mailing_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.mailing_state_Invalid=1);
    mailing_state_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.mailing_state_Invalid=1 AND h.mailing_state_wouldClean);
    mailing_state_ALLOW_ErrorCount := COUNT(GROUP,h.mailing_state_Invalid=2);
    mailing_state_ALLOW_WouldModifyCount := COUNT(GROUP,h.mailing_state_Invalid=2 AND h.mailing_state_wouldClean);
    mailing_state_LENGTHS_ErrorCount := COUNT(GROUP,h.mailing_state_Invalid=3);
    mailing_state_LENGTHS_WouldModifyCount := COUNT(GROUP,h.mailing_state_Invalid=3 AND h.mailing_state_wouldClean);
    mailing_state_Total_ErrorCount := COUNT(GROUP,h.mailing_state_Invalid>0);
    mailing_zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.mailing_zip_Invalid=1);
    mailing_zip_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.mailing_zip_Invalid=1 AND h.mailing_zip_wouldClean);
    mailing_zip_ALLOW_ErrorCount := COUNT(GROUP,h.mailing_zip_Invalid=2);
    mailing_zip_ALLOW_WouldModifyCount := COUNT(GROUP,h.mailing_zip_Invalid=2 AND h.mailing_zip_wouldClean);
    mailing_zip_LENGTHS_ErrorCount := COUNT(GROUP,h.mailing_zip_Invalid=3);
    mailing_zip_LENGTHS_WouldModifyCount := COUNT(GROUP,h.mailing_zip_Invalid=3 AND h.mailing_zip_wouldClean);
    mailing_zip_Total_ErrorCount := COUNT(GROUP,h.mailing_zip_Invalid>0);
    mailing_county_ALLOW_ErrorCount := COUNT(GROUP,h.mailing_county_Invalid=1);
    mailing_county_ALLOW_WouldModifyCount := COUNT(GROUP,h.mailing_county_Invalid=1 AND h.mailing_county_wouldClean);
    phone_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phone_number_Invalid=1);
    phone_number_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.phone_number_Invalid=1 AND h.phone_number_wouldClean);
    phone_number_ALLOW_ErrorCount := COUNT(GROUP,h.phone_number_Invalid=2);
    phone_number_ALLOW_WouldModifyCount := COUNT(GROUP,h.phone_number_Invalid=2 AND h.phone_number_wouldClean);
    phone_number_LENGTHS_ErrorCount := COUNT(GROUP,h.phone_number_Invalid=3);
    phone_number_LENGTHS_WouldModifyCount := COUNT(GROUP,h.phone_number_Invalid=3 AND h.phone_number_wouldClean);
    phone_number_Total_ErrorCount := COUNT(GROUP,h.phone_number_Invalid>0);
    ultid_ALLOW_ErrorCount := COUNT(GROUP,h.ultid_Invalid=1);
    ultid_ALLOW_WouldModifyCount := COUNT(GROUP,h.ultid_Invalid=1 AND h.ultid_wouldClean);
    orgid_ALLOW_ErrorCount := COUNT(GROUP,h.orgid_Invalid=1);
    orgid_ALLOW_WouldModifyCount := COUNT(GROUP,h.orgid_Invalid=1 AND h.orgid_wouldClean);
    seleid_ALLOW_ErrorCount := COUNT(GROUP,h.seleid_Invalid=1);
    seleid_ALLOW_WouldModifyCount := COUNT(GROUP,h.seleid_Invalid=1 AND h.seleid_wouldClean);
    tin_ALLOW_ErrorCount := COUNT(GROUP,h.tin_Invalid=1);
    tin_ALLOW_WouldModifyCount := COUNT(GROUP,h.tin_Invalid=1 AND h.tin_wouldClean);
    email_address_ALLOW_ErrorCount := COUNT(GROUP,h.email_address_Invalid=1);
    email_address_ALLOW_WouldModifyCount := COUNT(GROUP,h.email_address_Invalid=1 AND h.email_address_wouldClean);
    appended_provider_id_ALLOW_ErrorCount := COUNT(GROUP,h.appended_provider_id_Invalid=1);
    appended_provider_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.appended_provider_id_Invalid=1 AND h.appended_provider_id_wouldClean);
    lnpid_ALLOW_ErrorCount := COUNT(GROUP,h.lnpid_Invalid=1);
    lnpid_ALLOW_WouldModifyCount := COUNT(GROUP,h.lnpid_Invalid=1 AND h.lnpid_wouldClean);
    npi_ALLOW_ErrorCount := COUNT(GROUP,h.npi_Invalid=1);
    npi_ALLOW_WouldModifyCount := COUNT(GROUP,h.npi_Invalid=1 AND h.npi_wouldClean);
    ip_address_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ip_address_Invalid=1);
    ip_address_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.ip_address_Invalid=1 AND h.ip_address_wouldClean);
    ip_address_ALLOW_ErrorCount := COUNT(GROUP,h.ip_address_Invalid=2);
    ip_address_ALLOW_WouldModifyCount := COUNT(GROUP,h.ip_address_Invalid=2 AND h.ip_address_wouldClean);
    ip_address_Total_ErrorCount := COUNT(GROUP,h.ip_address_Invalid>0);
    device_id_ALLOW_ErrorCount := COUNT(GROUP,h.device_id_Invalid=1);
    device_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.device_id_Invalid=1 AND h.device_id_wouldClean);
    professional_id_ALLOW_ErrorCount := COUNT(GROUP,h.professional_id_Invalid=1);
    professional_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.professional_id_Invalid=1 AND h.professional_id_wouldClean);
    bank_routing_number_1_ALLOW_ErrorCount := COUNT(GROUP,h.bank_routing_number_1_Invalid=1);
    bank_routing_number_1_ALLOW_WouldModifyCount := COUNT(GROUP,h.bank_routing_number_1_Invalid=1 AND h.bank_routing_number_1_wouldClean);
    bank_account_number_1_ALLOW_ErrorCount := COUNT(GROUP,h.bank_account_number_1_Invalid=1);
    bank_account_number_1_ALLOW_WouldModifyCount := COUNT(GROUP,h.bank_account_number_1_Invalid=1 AND h.bank_account_number_1_wouldClean);
    drivers_license_state_ALLOW_ErrorCount := COUNT(GROUP,h.drivers_license_state_Invalid=1);
    drivers_license_state_ALLOW_WouldModifyCount := COUNT(GROUP,h.drivers_license_state_Invalid=1 AND h.drivers_license_state_wouldClean);
    drivers_license_ALLOW_ErrorCount := COUNT(GROUP,h.drivers_license_Invalid=1);
    drivers_license_ALLOW_WouldModifyCount := COUNT(GROUP,h.drivers_license_Invalid=1 AND h.drivers_license_wouldClean);
    geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=1);
    geo_lat_ALLOW_WouldModifyCount := COUNT(GROUP,h.geo_lat_Invalid=1 AND h.geo_lat_wouldClean);
    geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=1);
    geo_long_ALLOW_WouldModifyCount := COUNT(GROUP,h.geo_long_Invalid=1 AND h.geo_long_wouldClean);
    reported_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.reported_date_Invalid=1);
    reported_date_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.reported_date_Invalid=1 AND h.reported_date_wouldClean);
    reported_date_ALLOW_ErrorCount := COUNT(GROUP,h.reported_date_Invalid=2);
    reported_date_ALLOW_WouldModifyCount := COUNT(GROUP,h.reported_date_Invalid=2 AND h.reported_date_wouldClean);
    reported_date_Total_ErrorCount := COUNT(GROUP,h.reported_date_Invalid>0);
    file_type_ALLOW_ErrorCount := COUNT(GROUP,h.file_type_Invalid=1);
    file_type_ALLOW_WouldModifyCount := COUNT(GROUP,h.file_type_Invalid=1 AND h.file_type_wouldClean);
    deceitful_confidence_ALLOW_ErrorCount := COUNT(GROUP,h.deceitful_confidence_Invalid=1);
    deceitful_confidence_ALLOW_WouldModifyCount := COUNT(GROUP,h.deceitful_confidence_Invalid=1 AND h.deceitful_confidence_wouldClean);
    reported_by_ALLOW_ErrorCount := COUNT(GROUP,h.reported_by_Invalid=1);
    reported_by_ALLOW_WouldModifyCount := COUNT(GROUP,h.reported_by_Invalid=1 AND h.reported_by_wouldClean);
    reason_description_ALLOW_ErrorCount := COUNT(GROUP,h.reason_description_Invalid=1);
    reason_description_ALLOW_WouldModifyCount := COUNT(GROUP,h.reason_description_Invalid=1 AND h.reason_description_wouldClean);
    event_type_1_ALLOW_ErrorCount := COUNT(GROUP,h.event_type_1_Invalid=1);
    event_type_1_ALLOW_WouldModifyCount := COUNT(GROUP,h.event_type_1_Invalid=1 AND h.event_type_1_wouldClean);
    event_entity_1_ALLOW_ErrorCount := COUNT(GROUP,h.event_entity_1_Invalid=1);
    event_entity_1_ALLOW_WouldModifyCount := COUNT(GROUP,h.event_entity_1_Invalid=1 AND h.event_entity_1_wouldClean);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.inqlog_id_Invalid > 0 OR h.customer_id_Invalid > 0 OR h.transaction_id_Invalid > 0 OR h.date_of_transaction_Invalid > 0 OR h.household_id_Invalid > 0 OR h.customer_person_id_Invalid > 0 OR h.customer_program_Invalid > 0 OR h.reason_for_transaction_activity_Invalid > 0 OR h.inquiry_source_Invalid > 0 OR h.customer_county_Invalid > 0 OR h.customer_state_Invalid > 0 OR h.customer_agency_vertical_type_Invalid > 0 OR h.ssn_Invalid > 0 OR h.dob_Invalid > 0 OR h.rawlinkid_Invalid > 0 OR h.raw_full_name_Invalid > 0 OR h.raw_title_Invalid > 0 OR h.raw_first_name_Invalid > 0 OR h.raw_middle_name_Invalid > 0 OR h.raw_last_name_Invalid > 0 OR h.raw_orig_suffix_Invalid > 0 OR h.full_address_Invalid > 0 OR h.street_1_Invalid > 0 OR h.city_Invalid > 0 OR h.state_Invalid > 0 OR h.zip_Invalid > 0 OR h.county_Invalid > 0 OR h.mailing_street_1_Invalid > 0 OR h.mailing_city_Invalid > 0 OR h.mailing_state_Invalid > 0 OR h.mailing_zip_Invalid > 0 OR h.mailing_county_Invalid > 0 OR h.phone_number_Invalid > 0 OR h.ultid_Invalid > 0 OR h.orgid_Invalid > 0 OR h.seleid_Invalid > 0 OR h.tin_Invalid > 0 OR h.email_address_Invalid > 0 OR h.appended_provider_id_Invalid > 0 OR h.lnpid_Invalid > 0 OR h.npi_Invalid > 0 OR h.ip_address_Invalid > 0 OR h.device_id_Invalid > 0 OR h.professional_id_Invalid > 0 OR h.bank_routing_number_1_Invalid > 0 OR h.bank_account_number_1_Invalid > 0 OR h.drivers_license_state_Invalid > 0 OR h.drivers_license_Invalid > 0 OR h.geo_lat_Invalid > 0 OR h.geo_long_Invalid > 0 OR h.reported_date_Invalid > 0 OR h.file_type_Invalid > 0 OR h.deceitful_confidence_Invalid > 0 OR h.reported_by_Invalid > 0 OR h.reason_description_Invalid > 0 OR h.event_type_1_Invalid > 0 OR h.event_entity_1_Invalid > 0);
    AnyRule_WithEditsCount := COUNT(GROUP, h.inqlog_id_wouldClean OR h.customer_id_wouldClean OR h.transaction_id_wouldClean OR h.date_of_transaction_wouldClean OR h.household_id_wouldClean OR h.customer_person_id_wouldClean OR h.customer_program_wouldClean OR h.reason_for_transaction_activity_wouldClean OR h.inquiry_source_wouldClean OR h.customer_county_wouldClean OR h.customer_state_wouldClean OR h.customer_agency_vertical_type_wouldClean OR h.ssn_wouldClean OR h.dob_wouldClean OR h.rawlinkid_wouldClean OR h.raw_full_name_wouldClean OR h.raw_title_wouldClean OR h.raw_first_name_wouldClean OR h.raw_middle_name_wouldClean OR h.raw_last_name_wouldClean OR h.raw_orig_suffix_wouldClean OR h.full_address_wouldClean OR h.street_1_wouldClean OR h.city_wouldClean OR h.state_wouldClean OR h.zip_wouldClean OR h.county_wouldClean OR h.mailing_street_1_wouldClean OR h.mailing_city_wouldClean OR h.mailing_state_wouldClean OR h.mailing_zip_wouldClean OR h.mailing_county_wouldClean OR h.phone_number_wouldClean OR h.ultid_wouldClean OR h.orgid_wouldClean OR h.seleid_wouldClean OR h.tin_wouldClean OR h.email_address_wouldClean OR h.appended_provider_id_wouldClean OR h.lnpid_wouldClean OR h.npi_wouldClean OR h.ip_address_wouldClean OR h.device_id_wouldClean OR h.professional_id_wouldClean OR h.bank_routing_number_1_wouldClean OR h.bank_account_number_1_wouldClean OR h.drivers_license_state_wouldClean OR h.drivers_license_wouldClean OR h.geo_lat_wouldClean OR h.geo_long_wouldClean OR h.reported_date_wouldClean OR h.file_type_wouldClean OR h.deceitful_confidence_wouldClean OR h.reported_by_wouldClean OR h.reason_description_wouldClean OR h.event_type_1_wouldClean OR h.event_entity_1_wouldClean);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
    Rules_WithEdits := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.inqlog_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.customer_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.transaction_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_of_transaction_Total_ErrorCount > 0, 1, 0) + IF(le.household_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.customer_person_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.customer_program_ALLOW_ErrorCount > 0, 1, 0) + IF(le.reason_for_transaction_activity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.inquiry_source_ALLOW_ErrorCount > 0, 1, 0) + IF(le.customer_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.customer_state_Total_ErrorCount > 0, 1, 0) + IF(le.customer_agency_vertical_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ssn_Total_ErrorCount > 0, 1, 0) + IF(le.dob_Total_ErrorCount > 0, 1, 0) + IF(le.rawlinkid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.raw_full_name_Total_ErrorCount > 0, 1, 0) + IF(le.raw_title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.raw_first_name_Total_ErrorCount > 0, 1, 0) + IF(le.raw_middle_name_Total_ErrorCount > 0, 1, 0) + IF(le.raw_last_name_Total_ErrorCount > 0, 1, 0) + IF(le.raw_orig_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.full_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.street_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_Total_ErrorCount > 0, 1, 0) + IF(le.state_Total_ErrorCount > 0, 1, 0) + IF(le.zip_Total_ErrorCount > 0, 1, 0) + IF(le.county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailing_street_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailing_city_Total_ErrorCount > 0, 1, 0) + IF(le.mailing_state_Total_ErrorCount > 0, 1, 0) + IF(le.mailing_zip_Total_ErrorCount > 0, 1, 0) + IF(le.mailing_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_number_Total_ErrorCount > 0, 1, 0) + IF(le.ultid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orgid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seleid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.tin_ALLOW_ErrorCount > 0, 1, 0) + IF(le.email_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.appended_provider_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lnpid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.npi_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ip_address_Total_ErrorCount > 0, 1, 0) + IF(le.device_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.professional_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bank_routing_number_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bank_account_number_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.drivers_license_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.drivers_license_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.reported_date_Total_ErrorCount > 0, 1, 0) + IF(le.file_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.deceitful_confidence_ALLOW_ErrorCount > 0, 1, 0) + IF(le.reported_by_ALLOW_ErrorCount > 0, 1, 0) + IF(le.reason_description_ALLOW_ErrorCount > 0, 1, 0) + IF(le.event_type_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.event_entity_1_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.inqlog_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.customer_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.transaction_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_of_transaction_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.date_of_transaction_ALLOW_ErrorCount > 0, 1, 0) + IF(le.household_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.customer_person_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.customer_program_ALLOW_ErrorCount > 0, 1, 0) + IF(le.reason_for_transaction_activity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.inquiry_source_ALLOW_ErrorCount > 0, 1, 0) + IF(le.customer_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.customer_state_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.customer_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.customer_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.customer_agency_vertical_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ssn_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ssn_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dob_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.dob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawlinkid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.raw_full_name_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.raw_full_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.raw_title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.raw_first_name_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.raw_first_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.raw_middle_name_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.raw_middle_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.raw_last_name_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.raw_last_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.raw_orig_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.full_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.street_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailing_street_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailing_city_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.mailing_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailing_state_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.mailing_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailing_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mailing_zip_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.mailing_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailing_zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mailing_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_number_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.phone_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ultid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orgid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seleid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.tin_ALLOW_ErrorCount > 0, 1, 0) + IF(le.email_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.appended_provider_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lnpid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.npi_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ip_address_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.ip_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.device_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.professional_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bank_routing_number_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bank_account_number_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.drivers_license_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.drivers_license_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.reported_date_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.reported_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.file_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.deceitful_confidence_ALLOW_ErrorCount > 0, 1, 0) + IF(le.reported_by_ALLOW_ErrorCount > 0, 1, 0) + IF(le.reason_description_ALLOW_ErrorCount > 0, 1, 0) + IF(le.event_type_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.event_entity_1_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF.Rules_WithEdits := IF(le.inqlog_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.customer_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.transaction_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.date_of_transaction_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.date_of_transaction_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.household_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.customer_person_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.customer_program_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.reason_for_transaction_activity_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.inquiry_source_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.customer_county_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.customer_state_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.customer_state_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.customer_state_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.customer_agency_vertical_type_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.ssn_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.ssn_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.ssn_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.dob_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.dob_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.rawlinkid_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.raw_full_name_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.raw_full_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.raw_title_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.raw_first_name_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.raw_first_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.raw_middle_name_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.raw_middle_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.raw_last_name_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.raw_last_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.raw_orig_suffix_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.full_address_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.street_1_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.city_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.city_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.state_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.state_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.state_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.zip_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.zip_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.zip_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.county_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.mailing_street_1_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.mailing_city_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.mailing_city_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.mailing_state_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.mailing_state_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.mailing_state_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.mailing_zip_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.mailing_zip_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.mailing_zip_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.mailing_county_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.phone_number_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.phone_number_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.phone_number_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.ultid_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orgid_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.seleid_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.tin_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.email_address_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.appended_provider_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.lnpid_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.npi_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.ip_address_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.ip_address_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.device_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.professional_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.bank_routing_number_1_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.bank_account_number_1_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.drivers_license_state_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.drivers_license_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.geo_lat_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.geo_long_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.reported_date_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.reported_date_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.file_type_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.deceitful_confidence_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.reported_by_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.reason_description_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.event_type_1_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.event_entity_1_ALLOW_WouldModifyCount > 0, 1, 0);
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.inqlog_id_Invalid,le.customer_id_Invalid,le.transaction_id_Invalid,le.date_of_transaction_Invalid,le.household_id_Invalid,le.customer_person_id_Invalid,le.customer_program_Invalid,le.reason_for_transaction_activity_Invalid,le.inquiry_source_Invalid,le.customer_county_Invalid,le.customer_state_Invalid,le.customer_agency_vertical_type_Invalid,le.ssn_Invalid,le.dob_Invalid,le.rawlinkid_Invalid,le.raw_full_name_Invalid,le.raw_title_Invalid,le.raw_first_name_Invalid,le.raw_middle_name_Invalid,le.raw_last_name_Invalid,le.raw_orig_suffix_Invalid,le.full_address_Invalid,le.street_1_Invalid,le.city_Invalid,le.state_Invalid,le.zip_Invalid,le.county_Invalid,le.mailing_street_1_Invalid,le.mailing_city_Invalid,le.mailing_state_Invalid,le.mailing_zip_Invalid,le.mailing_county_Invalid,le.phone_number_Invalid,le.ultid_Invalid,le.orgid_Invalid,le.seleid_Invalid,le.tin_Invalid,le.email_address_Invalid,le.appended_provider_id_Invalid,le.lnpid_Invalid,le.npi_Invalid,le.ip_address_Invalid,le.device_id_Invalid,le.professional_id_Invalid,le.bank_routing_number_1_Invalid,le.bank_account_number_1_Invalid,le.drivers_license_state_Invalid,le.drivers_license_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.reported_date_Invalid,le.file_type_Invalid,le.deceitful_confidence_Invalid,le.reported_by_Invalid,le.reason_description_Invalid,le.event_type_1_Invalid,le.event_entity_1_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Deltabase_Fields.InvalidMessage_inqlog_id(le.inqlog_id_Invalid),Deltabase_Fields.InvalidMessage_customer_id(le.customer_id_Invalid),Deltabase_Fields.InvalidMessage_transaction_id(le.transaction_id_Invalid),Deltabase_Fields.InvalidMessage_date_of_transaction(le.date_of_transaction_Invalid),Deltabase_Fields.InvalidMessage_household_id(le.household_id_Invalid),Deltabase_Fields.InvalidMessage_customer_person_id(le.customer_person_id_Invalid),Deltabase_Fields.InvalidMessage_customer_program(le.customer_program_Invalid),Deltabase_Fields.InvalidMessage_reason_for_transaction_activity(le.reason_for_transaction_activity_Invalid),Deltabase_Fields.InvalidMessage_inquiry_source(le.inquiry_source_Invalid),Deltabase_Fields.InvalidMessage_customer_county(le.customer_county_Invalid),Deltabase_Fields.InvalidMessage_customer_state(le.customer_state_Invalid),Deltabase_Fields.InvalidMessage_customer_agency_vertical_type(le.customer_agency_vertical_type_Invalid),Deltabase_Fields.InvalidMessage_ssn(le.ssn_Invalid),Deltabase_Fields.InvalidMessage_dob(le.dob_Invalid),Deltabase_Fields.InvalidMessage_rawlinkid(le.rawlinkid_Invalid),Deltabase_Fields.InvalidMessage_raw_full_name(le.raw_full_name_Invalid),Deltabase_Fields.InvalidMessage_raw_title(le.raw_title_Invalid),Deltabase_Fields.InvalidMessage_raw_first_name(le.raw_first_name_Invalid),Deltabase_Fields.InvalidMessage_raw_middle_name(le.raw_middle_name_Invalid),Deltabase_Fields.InvalidMessage_raw_last_name(le.raw_last_name_Invalid),Deltabase_Fields.InvalidMessage_raw_orig_suffix(le.raw_orig_suffix_Invalid),Deltabase_Fields.InvalidMessage_full_address(le.full_address_Invalid),Deltabase_Fields.InvalidMessage_street_1(le.street_1_Invalid),Deltabase_Fields.InvalidMessage_city(le.city_Invalid),Deltabase_Fields.InvalidMessage_state(le.state_Invalid),Deltabase_Fields.InvalidMessage_zip(le.zip_Invalid),Deltabase_Fields.InvalidMessage_county(le.county_Invalid),Deltabase_Fields.InvalidMessage_mailing_street_1(le.mailing_street_1_Invalid),Deltabase_Fields.InvalidMessage_mailing_city(le.mailing_city_Invalid),Deltabase_Fields.InvalidMessage_mailing_state(le.mailing_state_Invalid),Deltabase_Fields.InvalidMessage_mailing_zip(le.mailing_zip_Invalid),Deltabase_Fields.InvalidMessage_mailing_county(le.mailing_county_Invalid),Deltabase_Fields.InvalidMessage_phone_number(le.phone_number_Invalid),Deltabase_Fields.InvalidMessage_ultid(le.ultid_Invalid),Deltabase_Fields.InvalidMessage_orgid(le.orgid_Invalid),Deltabase_Fields.InvalidMessage_seleid(le.seleid_Invalid),Deltabase_Fields.InvalidMessage_tin(le.tin_Invalid),Deltabase_Fields.InvalidMessage_email_address(le.email_address_Invalid),Deltabase_Fields.InvalidMessage_appended_provider_id(le.appended_provider_id_Invalid),Deltabase_Fields.InvalidMessage_lnpid(le.lnpid_Invalid),Deltabase_Fields.InvalidMessage_npi(le.npi_Invalid),Deltabase_Fields.InvalidMessage_ip_address(le.ip_address_Invalid),Deltabase_Fields.InvalidMessage_device_id(le.device_id_Invalid),Deltabase_Fields.InvalidMessage_professional_id(le.professional_id_Invalid),Deltabase_Fields.InvalidMessage_bank_routing_number_1(le.bank_routing_number_1_Invalid),Deltabase_Fields.InvalidMessage_bank_account_number_1(le.bank_account_number_1_Invalid),Deltabase_Fields.InvalidMessage_drivers_license_state(le.drivers_license_state_Invalid),Deltabase_Fields.InvalidMessage_drivers_license(le.drivers_license_Invalid),Deltabase_Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),Deltabase_Fields.InvalidMessage_geo_long(le.geo_long_Invalid),Deltabase_Fields.InvalidMessage_reported_date(le.reported_date_Invalid),Deltabase_Fields.InvalidMessage_file_type(le.file_type_Invalid),Deltabase_Fields.InvalidMessage_deceitful_confidence(le.deceitful_confidence_Invalid),Deltabase_Fields.InvalidMessage_reported_by(le.reported_by_Invalid),Deltabase_Fields.InvalidMessage_reason_description(le.reason_description_Invalid),Deltabase_Fields.InvalidMessage_event_type_1(le.event_type_1_Invalid),Deltabase_Fields.InvalidMessage_event_entity_1(le.event_entity_1_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.inqlog_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.customer_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.transaction_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.date_of_transaction_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.household_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.customer_person_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.customer_program_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.reason_for_transaction_activity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.inquiry_source_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.customer_county_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.customer_state_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.customer_agency_vertical_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ssn_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.rawlinkid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.raw_full_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.raw_title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.raw_first_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.raw_middle_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.raw_last_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.raw_orig_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.full_address_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.street_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.county_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mailing_street_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mailing_city_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.mailing_state_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mailing_zip_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mailing_county_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_number_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ultid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orgid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.seleid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.tin_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.email_address_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.appended_provider_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lnpid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.npi_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ip_address_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.device_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.professional_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bank_routing_number_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bank_account_number_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.drivers_license_state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.drivers_license_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_lat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_long_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.reported_date_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.file_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.deceitful_confidence_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.reported_by_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.reason_description_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.event_type_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.event_entity_1_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'inqlog_id','customer_id','transaction_id','date_of_transaction','household_id','customer_person_id','customer_program','reason_for_transaction_activity','inquiry_source','customer_county','customer_state','customer_agency_vertical_type','ssn','dob','rawlinkid','raw_full_name','raw_title','raw_first_name','raw_middle_name','raw_last_name','raw_orig_suffix','full_address','street_1','city','state','zip','county','mailing_street_1','mailing_city','mailing_state','mailing_zip','mailing_county','phone_number','ultid','orgid','seleid','tin','email_address','appended_provider_id','lnpid','npi','ip_address','device_id','professional_id','bank_routing_number_1','bank_account_number_1','drivers_license_state','drivers_license','geo_lat','geo_long','reported_date','file_type','deceitful_confidence','reported_by','reason_description','event_type_1','event_entity_1','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric','invalid_numeric_string','invalid_alphanumeric','invalid_date','invalid_alphanumeric','invalid_alphanumeric','invalid_alpha','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_state','invalid_alphanumeric','invalid_ssn','invalid_date','invalid_numeric','invalid_name','invalid_alphanumeric','invalid_name','invalid_name','invalid_name','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_name','invalid_state','invalid_zip','invalid_alphanumeric','invalid_alphanumeric','invalid_name','invalid_state','invalid_zip','invalid_alphanumeric','invalid_phone','invalid_numeric','invalid_numeric','invalid_numeric','invalid_alphanumeric','invalid_email','invalid_numeric','invalid_numeric','invalid_alphanumeric','invalid_ip','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_real_string','invalid_real_string','invalid_date','invalid_numeric','invalid_numeric_string','invalid_alphanumeric','invalid_alphanumeric','invalid_numeric_string','invalid_alphanumeric','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.inqlog_id,(SALT311.StrType)le.customer_id,(SALT311.StrType)le.transaction_id,(SALT311.StrType)le.date_of_transaction,(SALT311.StrType)le.household_id,(SALT311.StrType)le.customer_person_id,(SALT311.StrType)le.customer_program,(SALT311.StrType)le.reason_for_transaction_activity,(SALT311.StrType)le.inquiry_source,(SALT311.StrType)le.customer_county,(SALT311.StrType)le.customer_state,(SALT311.StrType)le.customer_agency_vertical_type,(SALT311.StrType)le.ssn,(SALT311.StrType)le.dob,(SALT311.StrType)le.rawlinkid,(SALT311.StrType)le.raw_full_name,(SALT311.StrType)le.raw_title,(SALT311.StrType)le.raw_first_name,(SALT311.StrType)le.raw_middle_name,(SALT311.StrType)le.raw_last_name,(SALT311.StrType)le.raw_orig_suffix,(SALT311.StrType)le.full_address,(SALT311.StrType)le.street_1,(SALT311.StrType)le.city,(SALT311.StrType)le.state,(SALT311.StrType)le.zip,(SALT311.StrType)le.county,(SALT311.StrType)le.mailing_street_1,(SALT311.StrType)le.mailing_city,(SALT311.StrType)le.mailing_state,(SALT311.StrType)le.mailing_zip,(SALT311.StrType)le.mailing_county,(SALT311.StrType)le.phone_number,(SALT311.StrType)le.ultid,(SALT311.StrType)le.orgid,(SALT311.StrType)le.seleid,(SALT311.StrType)le.tin,(SALT311.StrType)le.email_address,(SALT311.StrType)le.appended_provider_id,(SALT311.StrType)le.lnpid,(SALT311.StrType)le.npi,(SALT311.StrType)le.ip_address,(SALT311.StrType)le.device_id,(SALT311.StrType)le.professional_id,(SALT311.StrType)le.bank_routing_number_1,(SALT311.StrType)le.bank_account_number_1,(SALT311.StrType)le.drivers_license_state,(SALT311.StrType)le.drivers_license,(SALT311.StrType)le.geo_lat,(SALT311.StrType)le.geo_long,(SALT311.StrType)le.reported_date,(SALT311.StrType)le.file_type,(SALT311.StrType)le.deceitful_confidence,(SALT311.StrType)le.reported_by,(SALT311.StrType)le.reason_description,(SALT311.StrType)le.event_type_1,(SALT311.StrType)le.event_entity_1,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,57,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Deltabase_Layout_Deltabase) prevDS = DATASET([], Deltabase_Layout_Deltabase), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.inqlog_id_ALLOW_ErrorCount
          ,le.customer_id_ALLOW_ErrorCount
          ,le.transaction_id_ALLOW_ErrorCount
          ,le.date_of_transaction_LEFTTRIM_ErrorCount,le.date_of_transaction_ALLOW_ErrorCount
          ,le.household_id_ALLOW_ErrorCount
          ,le.customer_person_id_ALLOW_ErrorCount
          ,le.customer_program_ALLOW_ErrorCount
          ,le.reason_for_transaction_activity_ALLOW_ErrorCount
          ,le.inquiry_source_ALLOW_ErrorCount
          ,le.customer_county_ALLOW_ErrorCount
          ,le.customer_state_LEFTTRIM_ErrorCount,le.customer_state_ALLOW_ErrorCount,le.customer_state_LENGTHS_ErrorCount
          ,le.customer_agency_vertical_type_ALLOW_ErrorCount
          ,le.ssn_LEFTTRIM_ErrorCount,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTHS_ErrorCount
          ,le.dob_LEFTTRIM_ErrorCount,le.dob_ALLOW_ErrorCount
          ,le.rawlinkid_ALLOW_ErrorCount
          ,le.raw_full_name_LEFTTRIM_ErrorCount,le.raw_full_name_ALLOW_ErrorCount
          ,le.raw_title_ALLOW_ErrorCount
          ,le.raw_first_name_LEFTTRIM_ErrorCount,le.raw_first_name_ALLOW_ErrorCount
          ,le.raw_middle_name_LEFTTRIM_ErrorCount,le.raw_middle_name_ALLOW_ErrorCount
          ,le.raw_last_name_LEFTTRIM_ErrorCount,le.raw_last_name_ALLOW_ErrorCount
          ,le.raw_orig_suffix_ALLOW_ErrorCount
          ,le.full_address_ALLOW_ErrorCount
          ,le.street_1_ALLOW_ErrorCount
          ,le.city_LEFTTRIM_ErrorCount,le.city_ALLOW_ErrorCount
          ,le.state_LEFTTRIM_ErrorCount,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.zip_LEFTTRIM_ErrorCount,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount
          ,le.county_ALLOW_ErrorCount
          ,le.mailing_street_1_ALLOW_ErrorCount
          ,le.mailing_city_LEFTTRIM_ErrorCount,le.mailing_city_ALLOW_ErrorCount
          ,le.mailing_state_LEFTTRIM_ErrorCount,le.mailing_state_ALLOW_ErrorCount,le.mailing_state_LENGTHS_ErrorCount
          ,le.mailing_zip_LEFTTRIM_ErrorCount,le.mailing_zip_ALLOW_ErrorCount,le.mailing_zip_LENGTHS_ErrorCount
          ,le.mailing_county_ALLOW_ErrorCount
          ,le.phone_number_LEFTTRIM_ErrorCount,le.phone_number_ALLOW_ErrorCount,le.phone_number_LENGTHS_ErrorCount
          ,le.ultid_ALLOW_ErrorCount
          ,le.orgid_ALLOW_ErrorCount
          ,le.seleid_ALLOW_ErrorCount
          ,le.tin_ALLOW_ErrorCount
          ,le.email_address_ALLOW_ErrorCount
          ,le.appended_provider_id_ALLOW_ErrorCount
          ,le.lnpid_ALLOW_ErrorCount
          ,le.npi_ALLOW_ErrorCount
          ,le.ip_address_LEFTTRIM_ErrorCount,le.ip_address_ALLOW_ErrorCount
          ,le.device_id_ALLOW_ErrorCount
          ,le.professional_id_ALLOW_ErrorCount
          ,le.bank_routing_number_1_ALLOW_ErrorCount
          ,le.bank_account_number_1_ALLOW_ErrorCount
          ,le.drivers_license_state_ALLOW_ErrorCount
          ,le.drivers_license_ALLOW_ErrorCount
          ,le.geo_lat_ALLOW_ErrorCount
          ,le.geo_long_ALLOW_ErrorCount
          ,le.reported_date_LEFTTRIM_ErrorCount,le.reported_date_ALLOW_ErrorCount
          ,le.file_type_ALLOW_ErrorCount
          ,le.deceitful_confidence_ALLOW_ErrorCount
          ,le.reported_by_ALLOW_ErrorCount
          ,le.reason_description_ALLOW_ErrorCount
          ,le.event_type_1_ALLOW_ErrorCount
          ,le.event_entity_1_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount
          ,le.AnyRule_WithEditsCount
          ,le.Rules_WithEdits,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.inqlog_id_ALLOW_ErrorCount
          ,le.customer_id_ALLOW_ErrorCount
          ,le.transaction_id_ALLOW_ErrorCount
          ,le.date_of_transaction_LEFTTRIM_ErrorCount,le.date_of_transaction_ALLOW_ErrorCount
          ,le.household_id_ALLOW_ErrorCount
          ,le.customer_person_id_ALLOW_ErrorCount
          ,le.customer_program_ALLOW_ErrorCount
          ,le.reason_for_transaction_activity_ALLOW_ErrorCount
          ,le.inquiry_source_ALLOW_ErrorCount
          ,le.customer_county_ALLOW_ErrorCount
          ,le.customer_state_LEFTTRIM_ErrorCount,le.customer_state_ALLOW_ErrorCount,le.customer_state_LENGTHS_ErrorCount
          ,le.customer_agency_vertical_type_ALLOW_ErrorCount
          ,le.ssn_LEFTTRIM_ErrorCount,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTHS_ErrorCount
          ,le.dob_LEFTTRIM_ErrorCount,le.dob_ALLOW_ErrorCount
          ,le.rawlinkid_ALLOW_ErrorCount
          ,le.raw_full_name_LEFTTRIM_ErrorCount,le.raw_full_name_ALLOW_ErrorCount
          ,le.raw_title_ALLOW_ErrorCount
          ,le.raw_first_name_LEFTTRIM_ErrorCount,le.raw_first_name_ALLOW_ErrorCount
          ,le.raw_middle_name_LEFTTRIM_ErrorCount,le.raw_middle_name_ALLOW_ErrorCount
          ,le.raw_last_name_LEFTTRIM_ErrorCount,le.raw_last_name_ALLOW_ErrorCount
          ,le.raw_orig_suffix_ALLOW_ErrorCount
          ,le.full_address_ALLOW_ErrorCount
          ,le.street_1_ALLOW_ErrorCount
          ,le.city_LEFTTRIM_ErrorCount,le.city_ALLOW_ErrorCount
          ,le.state_LEFTTRIM_ErrorCount,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.zip_LEFTTRIM_ErrorCount,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount
          ,le.county_ALLOW_ErrorCount
          ,le.mailing_street_1_ALLOW_ErrorCount
          ,le.mailing_city_LEFTTRIM_ErrorCount,le.mailing_city_ALLOW_ErrorCount
          ,le.mailing_state_LEFTTRIM_ErrorCount,le.mailing_state_ALLOW_ErrorCount,le.mailing_state_LENGTHS_ErrorCount
          ,le.mailing_zip_LEFTTRIM_ErrorCount,le.mailing_zip_ALLOW_ErrorCount,le.mailing_zip_LENGTHS_ErrorCount
          ,le.mailing_county_ALLOW_ErrorCount
          ,le.phone_number_LEFTTRIM_ErrorCount,le.phone_number_ALLOW_ErrorCount,le.phone_number_LENGTHS_ErrorCount
          ,le.ultid_ALLOW_ErrorCount
          ,le.orgid_ALLOW_ErrorCount
          ,le.seleid_ALLOW_ErrorCount
          ,le.tin_ALLOW_ErrorCount
          ,le.email_address_ALLOW_ErrorCount
          ,le.appended_provider_id_ALLOW_ErrorCount
          ,le.lnpid_ALLOW_ErrorCount
          ,le.npi_ALLOW_ErrorCount
          ,le.ip_address_LEFTTRIM_ErrorCount,le.ip_address_ALLOW_ErrorCount
          ,le.device_id_ALLOW_ErrorCount
          ,le.professional_id_ALLOW_ErrorCount
          ,le.bank_routing_number_1_ALLOW_ErrorCount
          ,le.bank_account_number_1_ALLOW_ErrorCount
          ,le.drivers_license_state_ALLOW_ErrorCount
          ,le.drivers_license_ALLOW_ErrorCount
          ,le.geo_lat_ALLOW_ErrorCount
          ,le.geo_long_ALLOW_ErrorCount
          ,le.reported_date_LEFTTRIM_ErrorCount,le.reported_date_ALLOW_ErrorCount
          ,le.file_type_ALLOW_ErrorCount
          ,le.deceitful_confidence_ALLOW_ErrorCount
          ,le.reported_by_ALLOW_ErrorCount
          ,le.reason_description_ALLOW_ErrorCount
          ,le.event_type_1_ALLOW_ErrorCount
          ,le.event_entity_1_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithEditsCount/SELF.recordstotal * 100)
          ,IF(NumRulesWithPossibleEdits = 0, 0, le.Rules_WithEdits/NumRulesWithPossibleEdits * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 9,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
    // field population stats
    mod_hygiene := Deltabase_hygiene(PROJECT(h, Deltabase_Layout_Deltabase));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'inqlog_id:' + getFieldTypeText(h.inqlog_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'customer_id:' + getFieldTypeText(h.customer_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transaction_id:' + getFieldTypeText(h.transaction_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_of_transaction:' + getFieldTypeText(h.date_of_transaction) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'household_id:' + getFieldTypeText(h.household_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'customer_person_id:' + getFieldTypeText(h.customer_person_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'customer_program:' + getFieldTypeText(h.customer_program) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'reason_for_transaction_activity:' + getFieldTypeText(h.reason_for_transaction_activity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'inquiry_source:' + getFieldTypeText(h.inquiry_source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'customer_county:' + getFieldTypeText(h.customer_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'customer_state:' + getFieldTypeText(h.customer_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'customer_agency_vertical_type:' + getFieldTypeText(h.customer_agency_vertical_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ssn:' + getFieldTypeText(h.ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dob:' + getFieldTypeText(h.dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawlinkid:' + getFieldTypeText(h.rawlinkid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'raw_full_name:' + getFieldTypeText(h.raw_full_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'raw_title:' + getFieldTypeText(h.raw_title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'raw_first_name:' + getFieldTypeText(h.raw_first_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'raw_middle_name:' + getFieldTypeText(h.raw_middle_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'raw_last_name:' + getFieldTypeText(h.raw_last_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'raw_orig_suffix:' + getFieldTypeText(h.raw_orig_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'full_address:' + getFieldTypeText(h.full_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street_1:' + getFieldTypeText(h.street_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county:' + getFieldTypeText(h.county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_street_1:' + getFieldTypeText(h.mailing_street_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_city:' + getFieldTypeText(h.mailing_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_state:' + getFieldTypeText(h.mailing_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_zip:' + getFieldTypeText(h.mailing_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_county:' + getFieldTypeText(h.mailing_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_number:' + getFieldTypeText(h.phone_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultid:' + getFieldTypeText(h.ultid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgid:' + getFieldTypeText(h.orgid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seleid:' + getFieldTypeText(h.seleid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tin:' + getFieldTypeText(h.tin) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email_address:' + getFieldTypeText(h.email_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'appended_provider_id:' + getFieldTypeText(h.appended_provider_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lnpid:' + getFieldTypeText(h.lnpid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'npi:' + getFieldTypeText(h.npi) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ip_address:' + getFieldTypeText(h.ip_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'device_id:' + getFieldTypeText(h.device_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'professional_id:' + getFieldTypeText(h.professional_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bank_routing_number_1:' + getFieldTypeText(h.bank_routing_number_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bank_account_number_1:' + getFieldTypeText(h.bank_account_number_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'drivers_license_state:' + getFieldTypeText(h.drivers_license_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'drivers_license:' + getFieldTypeText(h.drivers_license) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'reported_date:' + getFieldTypeText(h.reported_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'file_type:' + getFieldTypeText(h.file_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'deceitful_confidence:' + getFieldTypeText(h.deceitful_confidence) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'reported_by:' + getFieldTypeText(h.reported_by) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'reason_description:' + getFieldTypeText(h.reason_description) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'event_type_1:' + getFieldTypeText(h.event_type_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'event_entity_1:' + getFieldTypeText(h.event_entity_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_inqlog_id_cnt
          ,le.populated_customer_id_cnt
          ,le.populated_transaction_id_cnt
          ,le.populated_date_of_transaction_cnt
          ,le.populated_household_id_cnt
          ,le.populated_customer_person_id_cnt
          ,le.populated_customer_program_cnt
          ,le.populated_reason_for_transaction_activity_cnt
          ,le.populated_inquiry_source_cnt
          ,le.populated_customer_county_cnt
          ,le.populated_customer_state_cnt
          ,le.populated_customer_agency_vertical_type_cnt
          ,le.populated_ssn_cnt
          ,le.populated_dob_cnt
          ,le.populated_rawlinkid_cnt
          ,le.populated_raw_full_name_cnt
          ,le.populated_raw_title_cnt
          ,le.populated_raw_first_name_cnt
          ,le.populated_raw_middle_name_cnt
          ,le.populated_raw_last_name_cnt
          ,le.populated_raw_orig_suffix_cnt
          ,le.populated_full_address_cnt
          ,le.populated_street_1_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_zip_cnt
          ,le.populated_county_cnt
          ,le.populated_mailing_street_1_cnt
          ,le.populated_mailing_city_cnt
          ,le.populated_mailing_state_cnt
          ,le.populated_mailing_zip_cnt
          ,le.populated_mailing_county_cnt
          ,le.populated_phone_number_cnt
          ,le.populated_ultid_cnt
          ,le.populated_orgid_cnt
          ,le.populated_seleid_cnt
          ,le.populated_tin_cnt
          ,le.populated_email_address_cnt
          ,le.populated_appended_provider_id_cnt
          ,le.populated_lnpid_cnt
          ,le.populated_npi_cnt
          ,le.populated_ip_address_cnt
          ,le.populated_device_id_cnt
          ,le.populated_professional_id_cnt
          ,le.populated_bank_routing_number_1_cnt
          ,le.populated_bank_account_number_1_cnt
          ,le.populated_drivers_license_state_cnt
          ,le.populated_drivers_license_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_reported_date_cnt
          ,le.populated_file_type_cnt
          ,le.populated_deceitful_confidence_cnt
          ,le.populated_reported_by_cnt
          ,le.populated_reason_description_cnt
          ,le.populated_event_type_1_cnt
          ,le.populated_event_entity_1_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_inqlog_id_pcnt
          ,le.populated_customer_id_pcnt
          ,le.populated_transaction_id_pcnt
          ,le.populated_date_of_transaction_pcnt
          ,le.populated_household_id_pcnt
          ,le.populated_customer_person_id_pcnt
          ,le.populated_customer_program_pcnt
          ,le.populated_reason_for_transaction_activity_pcnt
          ,le.populated_inquiry_source_pcnt
          ,le.populated_customer_county_pcnt
          ,le.populated_customer_state_pcnt
          ,le.populated_customer_agency_vertical_type_pcnt
          ,le.populated_ssn_pcnt
          ,le.populated_dob_pcnt
          ,le.populated_rawlinkid_pcnt
          ,le.populated_raw_full_name_pcnt
          ,le.populated_raw_title_pcnt
          ,le.populated_raw_first_name_pcnt
          ,le.populated_raw_middle_name_pcnt
          ,le.populated_raw_last_name_pcnt
          ,le.populated_raw_orig_suffix_pcnt
          ,le.populated_full_address_pcnt
          ,le.populated_street_1_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_county_pcnt
          ,le.populated_mailing_street_1_pcnt
          ,le.populated_mailing_city_pcnt
          ,le.populated_mailing_state_pcnt
          ,le.populated_mailing_zip_pcnt
          ,le.populated_mailing_county_pcnt
          ,le.populated_phone_number_pcnt
          ,le.populated_ultid_pcnt
          ,le.populated_orgid_pcnt
          ,le.populated_seleid_pcnt
          ,le.populated_tin_pcnt
          ,le.populated_email_address_pcnt
          ,le.populated_appended_provider_id_pcnt
          ,le.populated_lnpid_pcnt
          ,le.populated_npi_pcnt
          ,le.populated_ip_address_pcnt
          ,le.populated_device_id_pcnt
          ,le.populated_professional_id_pcnt
          ,le.populated_bank_routing_number_1_pcnt
          ,le.populated_bank_account_number_1_pcnt
          ,le.populated_drivers_license_state_pcnt
          ,le.populated_drivers_license_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_reported_date_pcnt
          ,le.populated_file_type_pcnt
          ,le.populated_deceitful_confidence_pcnt
          ,le.populated_reported_by_pcnt
          ,le.populated_reason_description_pcnt
          ,le.populated_event_type_1_pcnt
          ,le.populated_event_entity_1_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,57,xNormHygieneStats(LEFT,COUNTER,'POP'));
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
    mod_Delta := Deltabase_Delta(prevDS, PROJECT(h, Deltabase_Layout_Deltabase));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),57,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
EXPORT StandardStats(DATASET(Deltabase_Layout_Deltabase) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_FraudGov, Deltabase_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
