IMPORT SALT311,STD;
EXPORT Deltabase_hygiene(dataset(Deltabase_layout_Deltabase) h) := MODULE
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_inqlog_id_cnt := COUNT(GROUP,h.inqlog_id <> (TYPEOF(h.inqlog_id))'');
    populated_inqlog_id_pcnt := AVE(GROUP,IF(h.inqlog_id = (TYPEOF(h.inqlog_id))'',0,100));
    maxlength_inqlog_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.inqlog_id)));
    avelength_inqlog_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.inqlog_id)),h.inqlog_id<>(typeof(h.inqlog_id))'');
    populated_customer_id_cnt := COUNT(GROUP,h.customer_id <> (TYPEOF(h.customer_id))'');
    populated_customer_id_pcnt := AVE(GROUP,IF(h.customer_id = (TYPEOF(h.customer_id))'',0,100));
    maxlength_customer_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.customer_id)));
    avelength_customer_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.customer_id)),h.customer_id<>(typeof(h.customer_id))'');
    populated_transaction_id_cnt := COUNT(GROUP,h.transaction_id <> (TYPEOF(h.transaction_id))'');
    populated_transaction_id_pcnt := AVE(GROUP,IF(h.transaction_id = (TYPEOF(h.transaction_id))'',0,100));
    maxlength_transaction_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_id)));
    avelength_transaction_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_id)),h.transaction_id<>(typeof(h.transaction_id))'');
    populated_date_of_transaction_cnt := COUNT(GROUP,h.date_of_transaction <> (TYPEOF(h.date_of_transaction))'');
    populated_date_of_transaction_pcnt := AVE(GROUP,IF(h.date_of_transaction = (TYPEOF(h.date_of_transaction))'',0,100));
    maxlength_date_of_transaction := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_of_transaction)));
    avelength_date_of_transaction := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_of_transaction)),h.date_of_transaction<>(typeof(h.date_of_transaction))'');
    populated_household_id_cnt := COUNT(GROUP,h.household_id <> (TYPEOF(h.household_id))'');
    populated_household_id_pcnt := AVE(GROUP,IF(h.household_id = (TYPEOF(h.household_id))'',0,100));
    maxlength_household_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.household_id)));
    avelength_household_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.household_id)),h.household_id<>(typeof(h.household_id))'');
    populated_customer_person_id_cnt := COUNT(GROUP,h.customer_person_id <> (TYPEOF(h.customer_person_id))'');
    populated_customer_person_id_pcnt := AVE(GROUP,IF(h.customer_person_id = (TYPEOF(h.customer_person_id))'',0,100));
    maxlength_customer_person_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.customer_person_id)));
    avelength_customer_person_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.customer_person_id)),h.customer_person_id<>(typeof(h.customer_person_id))'');
    populated_customer_program_cnt := COUNT(GROUP,h.customer_program <> (TYPEOF(h.customer_program))'');
    populated_customer_program_pcnt := AVE(GROUP,IF(h.customer_program = (TYPEOF(h.customer_program))'',0,100));
    maxlength_customer_program := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.customer_program)));
    avelength_customer_program := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.customer_program)),h.customer_program<>(typeof(h.customer_program))'');
    populated_reason_for_transaction_activity_cnt := COUNT(GROUP,h.reason_for_transaction_activity <> (TYPEOF(h.reason_for_transaction_activity))'');
    populated_reason_for_transaction_activity_pcnt := AVE(GROUP,IF(h.reason_for_transaction_activity = (TYPEOF(h.reason_for_transaction_activity))'',0,100));
    maxlength_reason_for_transaction_activity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.reason_for_transaction_activity)));
    avelength_reason_for_transaction_activity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.reason_for_transaction_activity)),h.reason_for_transaction_activity<>(typeof(h.reason_for_transaction_activity))'');
    populated_inquiry_source_cnt := COUNT(GROUP,h.inquiry_source <> (TYPEOF(h.inquiry_source))'');
    populated_inquiry_source_pcnt := AVE(GROUP,IF(h.inquiry_source = (TYPEOF(h.inquiry_source))'',0,100));
    maxlength_inquiry_source := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.inquiry_source)));
    avelength_inquiry_source := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.inquiry_source)),h.inquiry_source<>(typeof(h.inquiry_source))'');
    populated_customer_county_cnt := COUNT(GROUP,h.customer_county <> (TYPEOF(h.customer_county))'');
    populated_customer_county_pcnt := AVE(GROUP,IF(h.customer_county = (TYPEOF(h.customer_county))'',0,100));
    maxlength_customer_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.customer_county)));
    avelength_customer_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.customer_county)),h.customer_county<>(typeof(h.customer_county))'');
    populated_customer_state_cnt := COUNT(GROUP,h.customer_state <> (TYPEOF(h.customer_state))'');
    populated_customer_state_pcnt := AVE(GROUP,IF(h.customer_state = (TYPEOF(h.customer_state))'',0,100));
    maxlength_customer_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.customer_state)));
    avelength_customer_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.customer_state)),h.customer_state<>(typeof(h.customer_state))'');
    populated_customer_agency_vertical_type_cnt := COUNT(GROUP,h.customer_agency_vertical_type <> (TYPEOF(h.customer_agency_vertical_type))'');
    populated_customer_agency_vertical_type_pcnt := AVE(GROUP,IF(h.customer_agency_vertical_type = (TYPEOF(h.customer_agency_vertical_type))'',0,100));
    maxlength_customer_agency_vertical_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.customer_agency_vertical_type)));
    avelength_customer_agency_vertical_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.customer_agency_vertical_type)),h.customer_agency_vertical_type<>(typeof(h.customer_agency_vertical_type))'');
    populated_ssn_cnt := COUNT(GROUP,h.ssn <> (TYPEOF(h.ssn))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_dob_cnt := COUNT(GROUP,h.dob <> (TYPEOF(h.dob))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_rawlinkid_cnt := COUNT(GROUP,h.rawlinkid <> (TYPEOF(h.rawlinkid))'');
    populated_rawlinkid_pcnt := AVE(GROUP,IF(h.rawlinkid = (TYPEOF(h.rawlinkid))'',0,100));
    maxlength_rawlinkid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawlinkid)));
    avelength_rawlinkid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawlinkid)),h.rawlinkid<>(typeof(h.rawlinkid))'');
    populated_raw_full_name_cnt := COUNT(GROUP,h.raw_full_name <> (TYPEOF(h.raw_full_name))'');
    populated_raw_full_name_pcnt := AVE(GROUP,IF(h.raw_full_name = (TYPEOF(h.raw_full_name))'',0,100));
    maxlength_raw_full_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.raw_full_name)));
    avelength_raw_full_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.raw_full_name)),h.raw_full_name<>(typeof(h.raw_full_name))'');
    populated_raw_title_cnt := COUNT(GROUP,h.raw_title <> (TYPEOF(h.raw_title))'');
    populated_raw_title_pcnt := AVE(GROUP,IF(h.raw_title = (TYPEOF(h.raw_title))'',0,100));
    maxlength_raw_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.raw_title)));
    avelength_raw_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.raw_title)),h.raw_title<>(typeof(h.raw_title))'');
    populated_raw_first_name_cnt := COUNT(GROUP,h.raw_first_name <> (TYPEOF(h.raw_first_name))'');
    populated_raw_first_name_pcnt := AVE(GROUP,IF(h.raw_first_name = (TYPEOF(h.raw_first_name))'',0,100));
    maxlength_raw_first_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.raw_first_name)));
    avelength_raw_first_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.raw_first_name)),h.raw_first_name<>(typeof(h.raw_first_name))'');
    populated_raw_middle_name_cnt := COUNT(GROUP,h.raw_middle_name <> (TYPEOF(h.raw_middle_name))'');
    populated_raw_middle_name_pcnt := AVE(GROUP,IF(h.raw_middle_name = (TYPEOF(h.raw_middle_name))'',0,100));
    maxlength_raw_middle_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.raw_middle_name)));
    avelength_raw_middle_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.raw_middle_name)),h.raw_middle_name<>(typeof(h.raw_middle_name))'');
    populated_raw_last_name_cnt := COUNT(GROUP,h.raw_last_name <> (TYPEOF(h.raw_last_name))'');
    populated_raw_last_name_pcnt := AVE(GROUP,IF(h.raw_last_name = (TYPEOF(h.raw_last_name))'',0,100));
    maxlength_raw_last_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.raw_last_name)));
    avelength_raw_last_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.raw_last_name)),h.raw_last_name<>(typeof(h.raw_last_name))'');
    populated_raw_orig_suffix_cnt := COUNT(GROUP,h.raw_orig_suffix <> (TYPEOF(h.raw_orig_suffix))'');
    populated_raw_orig_suffix_pcnt := AVE(GROUP,IF(h.raw_orig_suffix = (TYPEOF(h.raw_orig_suffix))'',0,100));
    maxlength_raw_orig_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.raw_orig_suffix)));
    avelength_raw_orig_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.raw_orig_suffix)),h.raw_orig_suffix<>(typeof(h.raw_orig_suffix))'');
    populated_full_address_cnt := COUNT(GROUP,h.full_address <> (TYPEOF(h.full_address))'');
    populated_full_address_pcnt := AVE(GROUP,IF(h.full_address = (TYPEOF(h.full_address))'',0,100));
    maxlength_full_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.full_address)));
    avelength_full_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.full_address)),h.full_address<>(typeof(h.full_address))'');
    populated_street_1_cnt := COUNT(GROUP,h.street_1 <> (TYPEOF(h.street_1))'');
    populated_street_1_pcnt := AVE(GROUP,IF(h.street_1 = (TYPEOF(h.street_1))'',0,100));
    maxlength_street_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.street_1)));
    avelength_street_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.street_1)),h.street_1<>(typeof(h.street_1))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_county_cnt := COUNT(GROUP,h.county <> (TYPEOF(h.county))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_mailing_street_1_cnt := COUNT(GROUP,h.mailing_street_1 <> (TYPEOF(h.mailing_street_1))'');
    populated_mailing_street_1_pcnt := AVE(GROUP,IF(h.mailing_street_1 = (TYPEOF(h.mailing_street_1))'',0,100));
    maxlength_mailing_street_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_street_1)));
    avelength_mailing_street_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_street_1)),h.mailing_street_1<>(typeof(h.mailing_street_1))'');
    populated_mailing_city_cnt := COUNT(GROUP,h.mailing_city <> (TYPEOF(h.mailing_city))'');
    populated_mailing_city_pcnt := AVE(GROUP,IF(h.mailing_city = (TYPEOF(h.mailing_city))'',0,100));
    maxlength_mailing_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_city)));
    avelength_mailing_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_city)),h.mailing_city<>(typeof(h.mailing_city))'');
    populated_mailing_state_cnt := COUNT(GROUP,h.mailing_state <> (TYPEOF(h.mailing_state))'');
    populated_mailing_state_pcnt := AVE(GROUP,IF(h.mailing_state = (TYPEOF(h.mailing_state))'',0,100));
    maxlength_mailing_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_state)));
    avelength_mailing_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_state)),h.mailing_state<>(typeof(h.mailing_state))'');
    populated_mailing_zip_cnt := COUNT(GROUP,h.mailing_zip <> (TYPEOF(h.mailing_zip))'');
    populated_mailing_zip_pcnt := AVE(GROUP,IF(h.mailing_zip = (TYPEOF(h.mailing_zip))'',0,100));
    maxlength_mailing_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_zip)));
    avelength_mailing_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_zip)),h.mailing_zip<>(typeof(h.mailing_zip))'');
    populated_mailing_county_cnt := COUNT(GROUP,h.mailing_county <> (TYPEOF(h.mailing_county))'');
    populated_mailing_county_pcnt := AVE(GROUP,IF(h.mailing_county = (TYPEOF(h.mailing_county))'',0,100));
    maxlength_mailing_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_county)));
    avelength_mailing_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_county)),h.mailing_county<>(typeof(h.mailing_county))'');
    populated_phone_number_cnt := COUNT(GROUP,h.phone_number <> (TYPEOF(h.phone_number))'');
    populated_phone_number_pcnt := AVE(GROUP,IF(h.phone_number = (TYPEOF(h.phone_number))'',0,100));
    maxlength_phone_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_number)));
    avelength_phone_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_number)),h.phone_number<>(typeof(h.phone_number))'');
    populated_ultid_cnt := COUNT(GROUP,h.ultid <> (TYPEOF(h.ultid))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_orgid_cnt := COUNT(GROUP,h.orgid <> (TYPEOF(h.orgid))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_seleid_cnt := COUNT(GROUP,h.seleid <> (TYPEOF(h.seleid))'');
    populated_seleid_pcnt := AVE(GROUP,IF(h.seleid = (TYPEOF(h.seleid))'',0,100));
    maxlength_seleid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleid)));
    avelength_seleid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleid)),h.seleid<>(typeof(h.seleid))'');
    populated_tin_cnt := COUNT(GROUP,h.tin <> (TYPEOF(h.tin))'');
    populated_tin_pcnt := AVE(GROUP,IF(h.tin = (TYPEOF(h.tin))'',0,100));
    maxlength_tin := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tin)));
    avelength_tin := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tin)),h.tin<>(typeof(h.tin))'');
    populated_email_address_cnt := COUNT(GROUP,h.email_address <> (TYPEOF(h.email_address))'');
    populated_email_address_pcnt := AVE(GROUP,IF(h.email_address = (TYPEOF(h.email_address))'',0,100));
    maxlength_email_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email_address)));
    avelength_email_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email_address)),h.email_address<>(typeof(h.email_address))'');
    populated_appended_provider_id_cnt := COUNT(GROUP,h.appended_provider_id <> (TYPEOF(h.appended_provider_id))'');
    populated_appended_provider_id_pcnt := AVE(GROUP,IF(h.appended_provider_id = (TYPEOF(h.appended_provider_id))'',0,100));
    maxlength_appended_provider_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.appended_provider_id)));
    avelength_appended_provider_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.appended_provider_id)),h.appended_provider_id<>(typeof(h.appended_provider_id))'');
    populated_lnpid_cnt := COUNT(GROUP,h.lnpid <> (TYPEOF(h.lnpid))'');
    populated_lnpid_pcnt := AVE(GROUP,IF(h.lnpid = (TYPEOF(h.lnpid))'',0,100));
    maxlength_lnpid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lnpid)));
    avelength_lnpid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lnpid)),h.lnpid<>(typeof(h.lnpid))'');
    populated_npi_cnt := COUNT(GROUP,h.npi <> (TYPEOF(h.npi))'');
    populated_npi_pcnt := AVE(GROUP,IF(h.npi = (TYPEOF(h.npi))'',0,100));
    maxlength_npi := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.npi)));
    avelength_npi := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.npi)),h.npi<>(typeof(h.npi))'');
    populated_ip_address_cnt := COUNT(GROUP,h.ip_address <> (TYPEOF(h.ip_address))'');
    populated_ip_address_pcnt := AVE(GROUP,IF(h.ip_address = (TYPEOF(h.ip_address))'',0,100));
    maxlength_ip_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ip_address)));
    avelength_ip_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ip_address)),h.ip_address<>(typeof(h.ip_address))'');
    populated_device_id_cnt := COUNT(GROUP,h.device_id <> (TYPEOF(h.device_id))'');
    populated_device_id_pcnt := AVE(GROUP,IF(h.device_id = (TYPEOF(h.device_id))'',0,100));
    maxlength_device_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.device_id)));
    avelength_device_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.device_id)),h.device_id<>(typeof(h.device_id))'');
    populated_professional_id_cnt := COUNT(GROUP,h.professional_id <> (TYPEOF(h.professional_id))'');
    populated_professional_id_pcnt := AVE(GROUP,IF(h.professional_id = (TYPEOF(h.professional_id))'',0,100));
    maxlength_professional_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.professional_id)));
    avelength_professional_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.professional_id)),h.professional_id<>(typeof(h.professional_id))'');
    populated_bank_routing_number_1_cnt := COUNT(GROUP,h.bank_routing_number_1 <> (TYPEOF(h.bank_routing_number_1))'');
    populated_bank_routing_number_1_pcnt := AVE(GROUP,IF(h.bank_routing_number_1 = (TYPEOF(h.bank_routing_number_1))'',0,100));
    maxlength_bank_routing_number_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bank_routing_number_1)));
    avelength_bank_routing_number_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bank_routing_number_1)),h.bank_routing_number_1<>(typeof(h.bank_routing_number_1))'');
    populated_bank_account_number_1_cnt := COUNT(GROUP,h.bank_account_number_1 <> (TYPEOF(h.bank_account_number_1))'');
    populated_bank_account_number_1_pcnt := AVE(GROUP,IF(h.bank_account_number_1 = (TYPEOF(h.bank_account_number_1))'',0,100));
    maxlength_bank_account_number_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bank_account_number_1)));
    avelength_bank_account_number_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bank_account_number_1)),h.bank_account_number_1<>(typeof(h.bank_account_number_1))'');
    populated_drivers_license_state_cnt := COUNT(GROUP,h.drivers_license_state <> (TYPEOF(h.drivers_license_state))'');
    populated_drivers_license_state_pcnt := AVE(GROUP,IF(h.drivers_license_state = (TYPEOF(h.drivers_license_state))'',0,100));
    maxlength_drivers_license_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.drivers_license_state)));
    avelength_drivers_license_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.drivers_license_state)),h.drivers_license_state<>(typeof(h.drivers_license_state))'');
    populated_drivers_license_cnt := COUNT(GROUP,h.drivers_license <> (TYPEOF(h.drivers_license))'');
    populated_drivers_license_pcnt := AVE(GROUP,IF(h.drivers_license = (TYPEOF(h.drivers_license))'',0,100));
    maxlength_drivers_license := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.drivers_license)));
    avelength_drivers_license := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.drivers_license)),h.drivers_license<>(typeof(h.drivers_license))'');
    populated_geo_lat_cnt := COUNT(GROUP,h.geo_lat <> (TYPEOF(h.geo_lat))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_cnt := COUNT(GROUP,h.geo_long <> (TYPEOF(h.geo_long))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_reported_date_cnt := COUNT(GROUP,h.reported_date <> (TYPEOF(h.reported_date))'');
    populated_reported_date_pcnt := AVE(GROUP,IF(h.reported_date = (TYPEOF(h.reported_date))'',0,100));
    maxlength_reported_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.reported_date)));
    avelength_reported_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.reported_date)),h.reported_date<>(typeof(h.reported_date))'');
    populated_file_type_cnt := COUNT(GROUP,h.file_type <> (TYPEOF(h.file_type))'');
    populated_file_type_pcnt := AVE(GROUP,IF(h.file_type = (TYPEOF(h.file_type))'',0,100));
    maxlength_file_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_type)));
    avelength_file_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_type)),h.file_type<>(typeof(h.file_type))'');
    populated_deceitful_confidence_cnt := COUNT(GROUP,h.deceitful_confidence <> (TYPEOF(h.deceitful_confidence))'');
    populated_deceitful_confidence_pcnt := AVE(GROUP,IF(h.deceitful_confidence = (TYPEOF(h.deceitful_confidence))'',0,100));
    maxlength_deceitful_confidence := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.deceitful_confidence)));
    avelength_deceitful_confidence := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.deceitful_confidence)),h.deceitful_confidence<>(typeof(h.deceitful_confidence))'');
    populated_reported_by_cnt := COUNT(GROUP,h.reported_by <> (TYPEOF(h.reported_by))'');
    populated_reported_by_pcnt := AVE(GROUP,IF(h.reported_by = (TYPEOF(h.reported_by))'',0,100));
    maxlength_reported_by := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.reported_by)));
    avelength_reported_by := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.reported_by)),h.reported_by<>(typeof(h.reported_by))'');
    populated_reason_description_cnt := COUNT(GROUP,h.reason_description <> (TYPEOF(h.reason_description))'');
    populated_reason_description_pcnt := AVE(GROUP,IF(h.reason_description = (TYPEOF(h.reason_description))'',0,100));
    maxlength_reason_description := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.reason_description)));
    avelength_reason_description := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.reason_description)),h.reason_description<>(typeof(h.reason_description))'');
    populated_event_type_1_cnt := COUNT(GROUP,h.event_type_1 <> (TYPEOF(h.event_type_1))'');
    populated_event_type_1_pcnt := AVE(GROUP,IF(h.event_type_1 = (TYPEOF(h.event_type_1))'',0,100));
    maxlength_event_type_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.event_type_1)));
    avelength_event_type_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.event_type_1)),h.event_type_1<>(typeof(h.event_type_1))'');
    populated_event_entity_1_cnt := COUNT(GROUP,h.event_entity_1 <> (TYPEOF(h.event_entity_1))'');
    populated_event_entity_1_pcnt := AVE(GROUP,IF(h.event_entity_1 = (TYPEOF(h.event_entity_1))'',0,100));
    maxlength_event_entity_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.event_entity_1)));
    avelength_event_entity_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.event_entity_1)),h.event_entity_1<>(typeof(h.event_entity_1))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_inqlog_id_pcnt *   0.00 / 100 + T.Populated_customer_id_pcnt *   0.00 / 100 + T.Populated_transaction_id_pcnt *   0.00 / 100 + T.Populated_date_of_transaction_pcnt *   0.00 / 100 + T.Populated_household_id_pcnt *   0.00 / 100 + T.Populated_customer_person_id_pcnt *   0.00 / 100 + T.Populated_customer_program_pcnt *   0.00 / 100 + T.Populated_reason_for_transaction_activity_pcnt *   0.00 / 100 + T.Populated_inquiry_source_pcnt *   0.00 / 100 + T.Populated_customer_county_pcnt *   0.00 / 100 + T.Populated_customer_state_pcnt *   0.00 / 100 + T.Populated_customer_agency_vertical_type_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_rawlinkid_pcnt *   0.00 / 100 + T.Populated_raw_full_name_pcnt *   0.00 / 100 + T.Populated_raw_title_pcnt *   0.00 / 100 + T.Populated_raw_first_name_pcnt *   0.00 / 100 + T.Populated_raw_middle_name_pcnt *   0.00 / 100 + T.Populated_raw_last_name_pcnt *   0.00 / 100 + T.Populated_raw_orig_suffix_pcnt *   0.00 / 100 + T.Populated_full_address_pcnt *   0.00 / 100 + T.Populated_street_1_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_mailing_street_1_pcnt *   0.00 / 100 + T.Populated_mailing_city_pcnt *   0.00 / 100 + T.Populated_mailing_state_pcnt *   0.00 / 100 + T.Populated_mailing_zip_pcnt *   0.00 / 100 + T.Populated_mailing_county_pcnt *   0.00 / 100 + T.Populated_phone_number_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_tin_pcnt *   0.00 / 100 + T.Populated_email_address_pcnt *   0.00 / 100 + T.Populated_appended_provider_id_pcnt *   0.00 / 100 + T.Populated_lnpid_pcnt *   0.00 / 100 + T.Populated_npi_pcnt *   0.00 / 100 + T.Populated_ip_address_pcnt *   0.00 / 100 + T.Populated_device_id_pcnt *   0.00 / 100 + T.Populated_professional_id_pcnt *   0.00 / 100 + T.Populated_bank_routing_number_1_pcnt *   0.00 / 100 + T.Populated_bank_account_number_1_pcnt *   0.00 / 100 + T.Populated_drivers_license_state_pcnt *   0.00 / 100 + T.Populated_drivers_license_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_reported_date_pcnt *   0.00 / 100 + T.Populated_file_type_pcnt *   0.00 / 100 + T.Populated_deceitful_confidence_pcnt *   0.00 / 100 + T.Populated_reported_by_pcnt *   0.00 / 100 + T.Populated_reason_description_pcnt *   0.00 / 100 + T.Populated_event_type_1_pcnt *   0.00 / 100 + T.Populated_event_entity_1_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'inqlog_id','customer_id','transaction_id','date_of_transaction','household_id','customer_person_id','customer_program','reason_for_transaction_activity','inquiry_source','customer_county','customer_state','customer_agency_vertical_type','ssn','dob','rawlinkid','raw_full_name','raw_title','raw_first_name','raw_middle_name','raw_last_name','raw_orig_suffix','full_address','street_1','city','state','zip','county','mailing_street_1','mailing_city','mailing_state','mailing_zip','mailing_county','phone_number','ultid','orgid','seleid','tin','email_address','appended_provider_id','lnpid','npi','ip_address','device_id','professional_id','bank_routing_number_1','bank_account_number_1','drivers_license_state','drivers_license','geo_lat','geo_long','reported_date','file_type','deceitful_confidence','reported_by','reason_description','event_type_1','event_entity_1');
  SELF.populated_pcnt := CHOOSE(C,le.populated_inqlog_id_pcnt,le.populated_customer_id_pcnt,le.populated_transaction_id_pcnt,le.populated_date_of_transaction_pcnt,le.populated_household_id_pcnt,le.populated_customer_person_id_pcnt,le.populated_customer_program_pcnt,le.populated_reason_for_transaction_activity_pcnt,le.populated_inquiry_source_pcnt,le.populated_customer_county_pcnt,le.populated_customer_state_pcnt,le.populated_customer_agency_vertical_type_pcnt,le.populated_ssn_pcnt,le.populated_dob_pcnt,le.populated_rawlinkid_pcnt,le.populated_raw_full_name_pcnt,le.populated_raw_title_pcnt,le.populated_raw_first_name_pcnt,le.populated_raw_middle_name_pcnt,le.populated_raw_last_name_pcnt,le.populated_raw_orig_suffix_pcnt,le.populated_full_address_pcnt,le.populated_street_1_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip_pcnt,le.populated_county_pcnt,le.populated_mailing_street_1_pcnt,le.populated_mailing_city_pcnt,le.populated_mailing_state_pcnt,le.populated_mailing_zip_pcnt,le.populated_mailing_county_pcnt,le.populated_phone_number_pcnt,le.populated_ultid_pcnt,le.populated_orgid_pcnt,le.populated_seleid_pcnt,le.populated_tin_pcnt,le.populated_email_address_pcnt,le.populated_appended_provider_id_pcnt,le.populated_lnpid_pcnt,le.populated_npi_pcnt,le.populated_ip_address_pcnt,le.populated_device_id_pcnt,le.populated_professional_id_pcnt,le.populated_bank_routing_number_1_pcnt,le.populated_bank_account_number_1_pcnt,le.populated_drivers_license_state_pcnt,le.populated_drivers_license_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_reported_date_pcnt,le.populated_file_type_pcnt,le.populated_deceitful_confidence_pcnt,le.populated_reported_by_pcnt,le.populated_reason_description_pcnt,le.populated_event_type_1_pcnt,le.populated_event_entity_1_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_inqlog_id,le.maxlength_customer_id,le.maxlength_transaction_id,le.maxlength_date_of_transaction,le.maxlength_household_id,le.maxlength_customer_person_id,le.maxlength_customer_program,le.maxlength_reason_for_transaction_activity,le.maxlength_inquiry_source,le.maxlength_customer_county,le.maxlength_customer_state,le.maxlength_customer_agency_vertical_type,le.maxlength_ssn,le.maxlength_dob,le.maxlength_rawlinkid,le.maxlength_raw_full_name,le.maxlength_raw_title,le.maxlength_raw_first_name,le.maxlength_raw_middle_name,le.maxlength_raw_last_name,le.maxlength_raw_orig_suffix,le.maxlength_full_address,le.maxlength_street_1,le.maxlength_city,le.maxlength_state,le.maxlength_zip,le.maxlength_county,le.maxlength_mailing_street_1,le.maxlength_mailing_city,le.maxlength_mailing_state,le.maxlength_mailing_zip,le.maxlength_mailing_county,le.maxlength_phone_number,le.maxlength_ultid,le.maxlength_orgid,le.maxlength_seleid,le.maxlength_tin,le.maxlength_email_address,le.maxlength_appended_provider_id,le.maxlength_lnpid,le.maxlength_npi,le.maxlength_ip_address,le.maxlength_device_id,le.maxlength_professional_id,le.maxlength_bank_routing_number_1,le.maxlength_bank_account_number_1,le.maxlength_drivers_license_state,le.maxlength_drivers_license,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_reported_date,le.maxlength_file_type,le.maxlength_deceitful_confidence,le.maxlength_reported_by,le.maxlength_reason_description,le.maxlength_event_type_1,le.maxlength_event_entity_1);
  SELF.avelength := CHOOSE(C,le.avelength_inqlog_id,le.avelength_customer_id,le.avelength_transaction_id,le.avelength_date_of_transaction,le.avelength_household_id,le.avelength_customer_person_id,le.avelength_customer_program,le.avelength_reason_for_transaction_activity,le.avelength_inquiry_source,le.avelength_customer_county,le.avelength_customer_state,le.avelength_customer_agency_vertical_type,le.avelength_ssn,le.avelength_dob,le.avelength_rawlinkid,le.avelength_raw_full_name,le.avelength_raw_title,le.avelength_raw_first_name,le.avelength_raw_middle_name,le.avelength_raw_last_name,le.avelength_raw_orig_suffix,le.avelength_full_address,le.avelength_street_1,le.avelength_city,le.avelength_state,le.avelength_zip,le.avelength_county,le.avelength_mailing_street_1,le.avelength_mailing_city,le.avelength_mailing_state,le.avelength_mailing_zip,le.avelength_mailing_county,le.avelength_phone_number,le.avelength_ultid,le.avelength_orgid,le.avelength_seleid,le.avelength_tin,le.avelength_email_address,le.avelength_appended_provider_id,le.avelength_lnpid,le.avelength_npi,le.avelength_ip_address,le.avelength_device_id,le.avelength_professional_id,le.avelength_bank_routing_number_1,le.avelength_bank_account_number_1,le.avelength_drivers_license_state,le.avelength_drivers_license,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_reported_date,le.avelength_file_type,le.avelength_deceitful_confidence,le.avelength_reported_by,le.avelength_reason_description,le.avelength_event_type_1,le.avelength_event_entity_1);
END;
EXPORT invSummary := NORMALIZE(summary0, 57, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.inqlog_id <> 0,TRIM((SALT311.StrType)le.inqlog_id), ''),TRIM((SALT311.StrType)le.customer_id),TRIM((SALT311.StrType)le.transaction_id),TRIM((SALT311.StrType)le.date_of_transaction),TRIM((SALT311.StrType)le.household_id),TRIM((SALT311.StrType)le.customer_person_id),TRIM((SALT311.StrType)le.customer_program),TRIM((SALT311.StrType)le.reason_for_transaction_activity),TRIM((SALT311.StrType)le.inquiry_source),TRIM((SALT311.StrType)le.customer_county),TRIM((SALT311.StrType)le.customer_state),TRIM((SALT311.StrType)le.customer_agency_vertical_type),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.dob),IF (le.rawlinkid <> 0,TRIM((SALT311.StrType)le.rawlinkid), ''),TRIM((SALT311.StrType)le.raw_full_name),TRIM((SALT311.StrType)le.raw_title),TRIM((SALT311.StrType)le.raw_first_name),TRIM((SALT311.StrType)le.raw_middle_name),TRIM((SALT311.StrType)le.raw_last_name),TRIM((SALT311.StrType)le.raw_orig_suffix),TRIM((SALT311.StrType)le.full_address),TRIM((SALT311.StrType)le.street_1),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.mailing_street_1),TRIM((SALT311.StrType)le.mailing_city),TRIM((SALT311.StrType)le.mailing_state),TRIM((SALT311.StrType)le.mailing_zip),TRIM((SALT311.StrType)le.mailing_county),TRIM((SALT311.StrType)le.phone_number),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),TRIM((SALT311.StrType)le.tin),TRIM((SALT311.StrType)le.email_address),IF (le.appended_provider_id <> 0,TRIM((SALT311.StrType)le.appended_provider_id), ''),IF (le.lnpid <> 0,TRIM((SALT311.StrType)le.lnpid), ''),TRIM((SALT311.StrType)le.npi),TRIM((SALT311.StrType)le.ip_address),TRIM((SALT311.StrType)le.device_id),TRIM((SALT311.StrType)le.professional_id),TRIM((SALT311.StrType)le.bank_routing_number_1),TRIM((SALT311.StrType)le.bank_account_number_1),TRIM((SALT311.StrType)le.drivers_license_state),TRIM((SALT311.StrType)le.drivers_license),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.reported_date),IF (le.file_type <> 0,TRIM((SALT311.StrType)le.file_type), ''),TRIM((SALT311.StrType)le.deceitful_confidence),TRIM((SALT311.StrType)le.reported_by),TRIM((SALT311.StrType)le.reason_description),TRIM((SALT311.StrType)le.event_type_1),TRIM((SALT311.StrType)le.event_entity_1)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,57,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 57);
  SELF.FldNo2 := 1 + (C % 57);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.inqlog_id <> 0,TRIM((SALT311.StrType)le.inqlog_id), ''),TRIM((SALT311.StrType)le.customer_id),TRIM((SALT311.StrType)le.transaction_id),TRIM((SALT311.StrType)le.date_of_transaction),TRIM((SALT311.StrType)le.household_id),TRIM((SALT311.StrType)le.customer_person_id),TRIM((SALT311.StrType)le.customer_program),TRIM((SALT311.StrType)le.reason_for_transaction_activity),TRIM((SALT311.StrType)le.inquiry_source),TRIM((SALT311.StrType)le.customer_county),TRIM((SALT311.StrType)le.customer_state),TRIM((SALT311.StrType)le.customer_agency_vertical_type),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.dob),IF (le.rawlinkid <> 0,TRIM((SALT311.StrType)le.rawlinkid), ''),TRIM((SALT311.StrType)le.raw_full_name),TRIM((SALT311.StrType)le.raw_title),TRIM((SALT311.StrType)le.raw_first_name),TRIM((SALT311.StrType)le.raw_middle_name),TRIM((SALT311.StrType)le.raw_last_name),TRIM((SALT311.StrType)le.raw_orig_suffix),TRIM((SALT311.StrType)le.full_address),TRIM((SALT311.StrType)le.street_1),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.mailing_street_1),TRIM((SALT311.StrType)le.mailing_city),TRIM((SALT311.StrType)le.mailing_state),TRIM((SALT311.StrType)le.mailing_zip),TRIM((SALT311.StrType)le.mailing_county),TRIM((SALT311.StrType)le.phone_number),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),TRIM((SALT311.StrType)le.tin),TRIM((SALT311.StrType)le.email_address),IF (le.appended_provider_id <> 0,TRIM((SALT311.StrType)le.appended_provider_id), ''),IF (le.lnpid <> 0,TRIM((SALT311.StrType)le.lnpid), ''),TRIM((SALT311.StrType)le.npi),TRIM((SALT311.StrType)le.ip_address),TRIM((SALT311.StrType)le.device_id),TRIM((SALT311.StrType)le.professional_id),TRIM((SALT311.StrType)le.bank_routing_number_1),TRIM((SALT311.StrType)le.bank_account_number_1),TRIM((SALT311.StrType)le.drivers_license_state),TRIM((SALT311.StrType)le.drivers_license),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.reported_date),IF (le.file_type <> 0,TRIM((SALT311.StrType)le.file_type), ''),TRIM((SALT311.StrType)le.deceitful_confidence),TRIM((SALT311.StrType)le.reported_by),TRIM((SALT311.StrType)le.reason_description),TRIM((SALT311.StrType)le.event_type_1),TRIM((SALT311.StrType)le.event_entity_1)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.inqlog_id <> 0,TRIM((SALT311.StrType)le.inqlog_id), ''),TRIM((SALT311.StrType)le.customer_id),TRIM((SALT311.StrType)le.transaction_id),TRIM((SALT311.StrType)le.date_of_transaction),TRIM((SALT311.StrType)le.household_id),TRIM((SALT311.StrType)le.customer_person_id),TRIM((SALT311.StrType)le.customer_program),TRIM((SALT311.StrType)le.reason_for_transaction_activity),TRIM((SALT311.StrType)le.inquiry_source),TRIM((SALT311.StrType)le.customer_county),TRIM((SALT311.StrType)le.customer_state),TRIM((SALT311.StrType)le.customer_agency_vertical_type),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.dob),IF (le.rawlinkid <> 0,TRIM((SALT311.StrType)le.rawlinkid), ''),TRIM((SALT311.StrType)le.raw_full_name),TRIM((SALT311.StrType)le.raw_title),TRIM((SALT311.StrType)le.raw_first_name),TRIM((SALT311.StrType)le.raw_middle_name),TRIM((SALT311.StrType)le.raw_last_name),TRIM((SALT311.StrType)le.raw_orig_suffix),TRIM((SALT311.StrType)le.full_address),TRIM((SALT311.StrType)le.street_1),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.mailing_street_1),TRIM((SALT311.StrType)le.mailing_city),TRIM((SALT311.StrType)le.mailing_state),TRIM((SALT311.StrType)le.mailing_zip),TRIM((SALT311.StrType)le.mailing_county),TRIM((SALT311.StrType)le.phone_number),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),TRIM((SALT311.StrType)le.tin),TRIM((SALT311.StrType)le.email_address),IF (le.appended_provider_id <> 0,TRIM((SALT311.StrType)le.appended_provider_id), ''),IF (le.lnpid <> 0,TRIM((SALT311.StrType)le.lnpid), ''),TRIM((SALT311.StrType)le.npi),TRIM((SALT311.StrType)le.ip_address),TRIM((SALT311.StrType)le.device_id),TRIM((SALT311.StrType)le.professional_id),TRIM((SALT311.StrType)le.bank_routing_number_1),TRIM((SALT311.StrType)le.bank_account_number_1),TRIM((SALT311.StrType)le.drivers_license_state),TRIM((SALT311.StrType)le.drivers_license),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.reported_date),IF (le.file_type <> 0,TRIM((SALT311.StrType)le.file_type), ''),TRIM((SALT311.StrType)le.deceitful_confidence),TRIM((SALT311.StrType)le.reported_by),TRIM((SALT311.StrType)le.reason_description),TRIM((SALT311.StrType)le.event_type_1),TRIM((SALT311.StrType)le.event_entity_1)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),57*57,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'inqlog_id'}
      ,{2,'customer_id'}
      ,{3,'transaction_id'}
      ,{4,'date_of_transaction'}
      ,{5,'household_id'}
      ,{6,'customer_person_id'}
      ,{7,'customer_program'}
      ,{8,'reason_for_transaction_activity'}
      ,{9,'inquiry_source'}
      ,{10,'customer_county'}
      ,{11,'customer_state'}
      ,{12,'customer_agency_vertical_type'}
      ,{13,'ssn'}
      ,{14,'dob'}
      ,{15,'rawlinkid'}
      ,{16,'raw_full_name'}
      ,{17,'raw_title'}
      ,{18,'raw_first_name'}
      ,{19,'raw_middle_name'}
      ,{20,'raw_last_name'}
      ,{21,'raw_orig_suffix'}
      ,{22,'full_address'}
      ,{23,'street_1'}
      ,{24,'city'}
      ,{25,'state'}
      ,{26,'zip'}
      ,{27,'county'}
      ,{28,'mailing_street_1'}
      ,{29,'mailing_city'}
      ,{30,'mailing_state'}
      ,{31,'mailing_zip'}
      ,{32,'mailing_county'}
      ,{33,'phone_number'}
      ,{34,'ultid'}
      ,{35,'orgid'}
      ,{36,'seleid'}
      ,{37,'tin'}
      ,{38,'email_address'}
      ,{39,'appended_provider_id'}
      ,{40,'lnpid'}
      ,{41,'npi'}
      ,{42,'ip_address'}
      ,{43,'device_id'}
      ,{44,'professional_id'}
      ,{45,'bank_routing_number_1'}
      ,{46,'bank_account_number_1'}
      ,{47,'drivers_license_state'}
      ,{48,'drivers_license'}
      ,{49,'geo_lat'}
      ,{50,'geo_long'}
      ,{51,'reported_date'}
      ,{52,'file_type'}
      ,{53,'deceitful_confidence'}
      ,{54,'reported_by'}
      ,{55,'reason_description'}
      ,{56,'event_type_1'}
      ,{57,'event_entity_1'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Deltabase_Fields.InValid_inqlog_id((SALT311.StrType)le.inqlog_id),
    Deltabase_Fields.InValid_customer_id((SALT311.StrType)le.customer_id),
    Deltabase_Fields.InValid_transaction_id((SALT311.StrType)le.transaction_id),
    Deltabase_Fields.InValid_date_of_transaction((SALT311.StrType)le.date_of_transaction),
    Deltabase_Fields.InValid_household_id((SALT311.StrType)le.household_id),
    Deltabase_Fields.InValid_customer_person_id((SALT311.StrType)le.customer_person_id),
    Deltabase_Fields.InValid_customer_program((SALT311.StrType)le.customer_program),
    Deltabase_Fields.InValid_reason_for_transaction_activity((SALT311.StrType)le.reason_for_transaction_activity),
    Deltabase_Fields.InValid_inquiry_source((SALT311.StrType)le.inquiry_source),
    Deltabase_Fields.InValid_customer_county((SALT311.StrType)le.customer_county),
    Deltabase_Fields.InValid_customer_state((SALT311.StrType)le.customer_state),
    Deltabase_Fields.InValid_customer_agency_vertical_type((SALT311.StrType)le.customer_agency_vertical_type),
    Deltabase_Fields.InValid_ssn((SALT311.StrType)le.ssn),
    Deltabase_Fields.InValid_dob((SALT311.StrType)le.dob),
    Deltabase_Fields.InValid_rawlinkid((SALT311.StrType)le.rawlinkid),
    Deltabase_Fields.InValid_raw_full_name((SALT311.StrType)le.raw_full_name),
    Deltabase_Fields.InValid_raw_title((SALT311.StrType)le.raw_title),
    Deltabase_Fields.InValid_raw_first_name((SALT311.StrType)le.raw_first_name),
    Deltabase_Fields.InValid_raw_middle_name((SALT311.StrType)le.raw_middle_name),
    Deltabase_Fields.InValid_raw_last_name((SALT311.StrType)le.raw_last_name),
    Deltabase_Fields.InValid_raw_orig_suffix((SALT311.StrType)le.raw_orig_suffix),
    Deltabase_Fields.InValid_full_address((SALT311.StrType)le.full_address),
    Deltabase_Fields.InValid_street_1((SALT311.StrType)le.street_1),
    Deltabase_Fields.InValid_city((SALT311.StrType)le.city),
    Deltabase_Fields.InValid_state((SALT311.StrType)le.state),
    Deltabase_Fields.InValid_zip((SALT311.StrType)le.zip),
    Deltabase_Fields.InValid_county((SALT311.StrType)le.county),
    Deltabase_Fields.InValid_mailing_street_1((SALT311.StrType)le.mailing_street_1),
    Deltabase_Fields.InValid_mailing_city((SALT311.StrType)le.mailing_city),
    Deltabase_Fields.InValid_mailing_state((SALT311.StrType)le.mailing_state),
    Deltabase_Fields.InValid_mailing_zip((SALT311.StrType)le.mailing_zip),
    Deltabase_Fields.InValid_mailing_county((SALT311.StrType)le.mailing_county),
    Deltabase_Fields.InValid_phone_number((SALT311.StrType)le.phone_number),
    Deltabase_Fields.InValid_ultid((SALT311.StrType)le.ultid),
    Deltabase_Fields.InValid_orgid((SALT311.StrType)le.orgid),
    Deltabase_Fields.InValid_seleid((SALT311.StrType)le.seleid),
    Deltabase_Fields.InValid_tin((SALT311.StrType)le.tin),
    Deltabase_Fields.InValid_email_address((SALT311.StrType)le.email_address),
    Deltabase_Fields.InValid_appended_provider_id((SALT311.StrType)le.appended_provider_id),
    Deltabase_Fields.InValid_lnpid((SALT311.StrType)le.lnpid),
    Deltabase_Fields.InValid_npi((SALT311.StrType)le.npi),
    Deltabase_Fields.InValid_ip_address((SALT311.StrType)le.ip_address),
    Deltabase_Fields.InValid_device_id((SALT311.StrType)le.device_id),
    Deltabase_Fields.InValid_professional_id((SALT311.StrType)le.professional_id),
    Deltabase_Fields.InValid_bank_routing_number_1((SALT311.StrType)le.bank_routing_number_1),
    Deltabase_Fields.InValid_bank_account_number_1((SALT311.StrType)le.bank_account_number_1),
    Deltabase_Fields.InValid_drivers_license_state((SALT311.StrType)le.drivers_license_state),
    Deltabase_Fields.InValid_drivers_license((SALT311.StrType)le.drivers_license),
    Deltabase_Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat),
    Deltabase_Fields.InValid_geo_long((SALT311.StrType)le.geo_long),
    Deltabase_Fields.InValid_reported_date((SALT311.StrType)le.reported_date),
    Deltabase_Fields.InValid_file_type((SALT311.StrType)le.file_type),
    Deltabase_Fields.InValid_deceitful_confidence((SALT311.StrType)le.deceitful_confidence),
    Deltabase_Fields.InValid_reported_by((SALT311.StrType)le.reported_by),
    Deltabase_Fields.InValid_reason_description((SALT311.StrType)le.reason_description),
    Deltabase_Fields.InValid_event_type_1((SALT311.StrType)le.event_type_1),
    Deltabase_Fields.InValid_event_entity_1((SALT311.StrType)le.event_entity_1),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,57,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Deltabase_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric','invalid_numeric_string','invalid_alphanumeric','invalid_date','invalid_alphanumeric','invalid_alphanumeric','invalid_alpha','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_state','invalid_alphanumeric','invalid_ssn','invalid_date','invalid_numeric','invalid_name','invalid_alphanumeric','invalid_name','invalid_name','invalid_name','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_name','invalid_state','invalid_zip','invalid_alphanumeric','invalid_alphanumeric','invalid_name','invalid_state','invalid_zip','invalid_alphanumeric','invalid_phone','invalid_numeric','invalid_numeric','invalid_numeric','invalid_alphanumeric','invalid_email','invalid_numeric','invalid_numeric','invalid_alphanumeric','invalid_ip','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_real_string','invalid_real_string','invalid_date','invalid_numeric','invalid_numeric_string','invalid_alphanumeric','invalid_alphanumeric','invalid_numeric_string','invalid_alphanumeric');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Deltabase_Fields.InValidMessage_inqlog_id(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_customer_id(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_transaction_id(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_date_of_transaction(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_household_id(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_customer_person_id(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_customer_program(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_reason_for_transaction_activity(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_inquiry_source(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_customer_county(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_customer_state(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_customer_agency_vertical_type(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_dob(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_rawlinkid(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_raw_full_name(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_raw_title(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_raw_first_name(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_raw_middle_name(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_raw_last_name(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_raw_orig_suffix(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_full_address(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_street_1(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_city(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_state(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_zip(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_county(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_mailing_street_1(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_mailing_city(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_mailing_state(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_mailing_zip(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_mailing_county(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_phone_number(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_tin(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_email_address(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_appended_provider_id(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_lnpid(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_npi(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_ip_address(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_device_id(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_professional_id(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_bank_routing_number_1(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_bank_account_number_1(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_drivers_license_state(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_drivers_license(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_reported_date(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_file_type(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_deceitful_confidence(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_reported_by(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_reason_description(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_event_type_1(TotalErrors.ErrorNum),Deltabase_Fields.InValidMessage_event_entity_1(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FraudGov, Deltabase_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
