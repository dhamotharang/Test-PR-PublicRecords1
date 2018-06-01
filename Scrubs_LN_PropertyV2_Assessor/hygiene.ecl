IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_Property_Assessor) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := IF(Glob, (TYPEOF(h.fips_code))'', MAX(GROUP,h.fips_code));
    NumberOfRecords := COUNT(GROUP);
    populated_ln_fares_id_cnt := COUNT(GROUP,h.ln_fares_id <> (TYPEOF(h.ln_fares_id))'');
    populated_ln_fares_id_pcnt := AVE(GROUP,IF(h.ln_fares_id = (TYPEOF(h.ln_fares_id))'',0,100));
    maxlength_ln_fares_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_fares_id)));
    avelength_ln_fares_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_fares_id)),h.ln_fares_id<>(typeof(h.ln_fares_id))'');
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_vendor_source_flag_cnt := COUNT(GROUP,h.vendor_source_flag <> (TYPEOF(h.vendor_source_flag))'');
    populated_vendor_source_flag_pcnt := AVE(GROUP,IF(h.vendor_source_flag = (TYPEOF(h.vendor_source_flag))'',0,100));
    maxlength_vendor_source_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor_source_flag)));
    avelength_vendor_source_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor_source_flag)),h.vendor_source_flag<>(typeof(h.vendor_source_flag))'');
    populated_current_record_cnt := COUNT(GROUP,h.current_record <> (TYPEOF(h.current_record))'');
    populated_current_record_pcnt := AVE(GROUP,IF(h.current_record = (TYPEOF(h.current_record))'',0,100));
    maxlength_current_record := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_record)));
    avelength_current_record := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_record)),h.current_record<>(typeof(h.current_record))'');
    populated_fips_code_cnt := COUNT(GROUP,h.fips_code <> (TYPEOF(h.fips_code))'');
    populated_fips_code_pcnt := AVE(GROUP,IF(h.fips_code = (TYPEOF(h.fips_code))'',0,100));
    maxlength_fips_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_code)));
    avelength_fips_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_code)),h.fips_code<>(typeof(h.fips_code))'');
    populated_state_code_cnt := COUNT(GROUP,h.state_code <> (TYPEOF(h.state_code))'');
    populated_state_code_pcnt := AVE(GROUP,IF(h.state_code = (TYPEOF(h.state_code))'',0,100));
    maxlength_state_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_code)));
    avelength_state_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_code)),h.state_code<>(typeof(h.state_code))'');
    populated_county_name_cnt := COUNT(GROUP,h.county_name <> (TYPEOF(h.county_name))'');
    populated_county_name_pcnt := AVE(GROUP,IF(h.county_name = (TYPEOF(h.county_name))'',0,100));
    maxlength_county_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_name)));
    avelength_county_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_name)),h.county_name<>(typeof(h.county_name))'');
    populated_old_apn_cnt := COUNT(GROUP,h.old_apn <> (TYPEOF(h.old_apn))'');
    populated_old_apn_pcnt := AVE(GROUP,IF(h.old_apn = (TYPEOF(h.old_apn))'',0,100));
    maxlength_old_apn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.old_apn)));
    avelength_old_apn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.old_apn)),h.old_apn<>(typeof(h.old_apn))'');
    populated_apna_or_pin_number_cnt := COUNT(GROUP,h.apna_or_pin_number <> (TYPEOF(h.apna_or_pin_number))'');
    populated_apna_or_pin_number_pcnt := AVE(GROUP,IF(h.apna_or_pin_number = (TYPEOF(h.apna_or_pin_number))'',0,100));
    maxlength_apna_or_pin_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.apna_or_pin_number)));
    avelength_apna_or_pin_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.apna_or_pin_number)),h.apna_or_pin_number<>(typeof(h.apna_or_pin_number))'');
    populated_fares_unformatted_apn_cnt := COUNT(GROUP,h.fares_unformatted_apn <> (TYPEOF(h.fares_unformatted_apn))'');
    populated_fares_unformatted_apn_pcnt := AVE(GROUP,IF(h.fares_unformatted_apn = (TYPEOF(h.fares_unformatted_apn))'',0,100));
    maxlength_fares_unformatted_apn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fares_unformatted_apn)));
    avelength_fares_unformatted_apn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fares_unformatted_apn)),h.fares_unformatted_apn<>(typeof(h.fares_unformatted_apn))'');
    populated_duplicate_apn_multiple_address_id_cnt := COUNT(GROUP,h.duplicate_apn_multiple_address_id <> (TYPEOF(h.duplicate_apn_multiple_address_id))'');
    populated_duplicate_apn_multiple_address_id_pcnt := AVE(GROUP,IF(h.duplicate_apn_multiple_address_id = (TYPEOF(h.duplicate_apn_multiple_address_id))'',0,100));
    maxlength_duplicate_apn_multiple_address_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.duplicate_apn_multiple_address_id)));
    avelength_duplicate_apn_multiple_address_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.duplicate_apn_multiple_address_id)),h.duplicate_apn_multiple_address_id<>(typeof(h.duplicate_apn_multiple_address_id))'');
    populated_assessee_name_cnt := COUNT(GROUP,h.assessee_name <> (TYPEOF(h.assessee_name))'');
    populated_assessee_name_pcnt := AVE(GROUP,IF(h.assessee_name = (TYPEOF(h.assessee_name))'',0,100));
    maxlength_assessee_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessee_name)));
    avelength_assessee_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessee_name)),h.assessee_name<>(typeof(h.assessee_name))'');
    populated_second_assessee_name_cnt := COUNT(GROUP,h.second_assessee_name <> (TYPEOF(h.second_assessee_name))'');
    populated_second_assessee_name_pcnt := AVE(GROUP,IF(h.second_assessee_name = (TYPEOF(h.second_assessee_name))'',0,100));
    maxlength_second_assessee_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.second_assessee_name)));
    avelength_second_assessee_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.second_assessee_name)),h.second_assessee_name<>(typeof(h.second_assessee_name))'');
    populated_assessee_ownership_rights_code_cnt := COUNT(GROUP,h.assessee_ownership_rights_code <> (TYPEOF(h.assessee_ownership_rights_code))'');
    populated_assessee_ownership_rights_code_pcnt := AVE(GROUP,IF(h.assessee_ownership_rights_code = (TYPEOF(h.assessee_ownership_rights_code))'',0,100));
    maxlength_assessee_ownership_rights_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessee_ownership_rights_code)));
    avelength_assessee_ownership_rights_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessee_ownership_rights_code)),h.assessee_ownership_rights_code<>(typeof(h.assessee_ownership_rights_code))'');
    populated_assessee_relationship_code_cnt := COUNT(GROUP,h.assessee_relationship_code <> (TYPEOF(h.assessee_relationship_code))'');
    populated_assessee_relationship_code_pcnt := AVE(GROUP,IF(h.assessee_relationship_code = (TYPEOF(h.assessee_relationship_code))'',0,100));
    maxlength_assessee_relationship_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessee_relationship_code)));
    avelength_assessee_relationship_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessee_relationship_code)),h.assessee_relationship_code<>(typeof(h.assessee_relationship_code))'');
    populated_assessee_phone_number_cnt := COUNT(GROUP,h.assessee_phone_number <> (TYPEOF(h.assessee_phone_number))'');
    populated_assessee_phone_number_pcnt := AVE(GROUP,IF(h.assessee_phone_number = (TYPEOF(h.assessee_phone_number))'',0,100));
    maxlength_assessee_phone_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessee_phone_number)));
    avelength_assessee_phone_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessee_phone_number)),h.assessee_phone_number<>(typeof(h.assessee_phone_number))'');
    populated_tax_account_number_cnt := COUNT(GROUP,h.tax_account_number <> (TYPEOF(h.tax_account_number))'');
    populated_tax_account_number_pcnt := AVE(GROUP,IF(h.tax_account_number = (TYPEOF(h.tax_account_number))'',0,100));
    maxlength_tax_account_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_account_number)));
    avelength_tax_account_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_account_number)),h.tax_account_number<>(typeof(h.tax_account_number))'');
    populated_contract_owner_cnt := COUNT(GROUP,h.contract_owner <> (TYPEOF(h.contract_owner))'');
    populated_contract_owner_pcnt := AVE(GROUP,IF(h.contract_owner = (TYPEOF(h.contract_owner))'',0,100));
    maxlength_contract_owner := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contract_owner)));
    avelength_contract_owner := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contract_owner)),h.contract_owner<>(typeof(h.contract_owner))'');
    populated_assessee_name_type_code_cnt := COUNT(GROUP,h.assessee_name_type_code <> (TYPEOF(h.assessee_name_type_code))'');
    populated_assessee_name_type_code_pcnt := AVE(GROUP,IF(h.assessee_name_type_code = (TYPEOF(h.assessee_name_type_code))'',0,100));
    maxlength_assessee_name_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessee_name_type_code)));
    avelength_assessee_name_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessee_name_type_code)),h.assessee_name_type_code<>(typeof(h.assessee_name_type_code))'');
    populated_second_assessee_name_type_code_cnt := COUNT(GROUP,h.second_assessee_name_type_code <> (TYPEOF(h.second_assessee_name_type_code))'');
    populated_second_assessee_name_type_code_pcnt := AVE(GROUP,IF(h.second_assessee_name_type_code = (TYPEOF(h.second_assessee_name_type_code))'',0,100));
    maxlength_second_assessee_name_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.second_assessee_name_type_code)));
    avelength_second_assessee_name_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.second_assessee_name_type_code)),h.second_assessee_name_type_code<>(typeof(h.second_assessee_name_type_code))'');
    populated_mail_care_of_name_type_code_cnt := COUNT(GROUP,h.mail_care_of_name_type_code <> (TYPEOF(h.mail_care_of_name_type_code))'');
    populated_mail_care_of_name_type_code_pcnt := AVE(GROUP,IF(h.mail_care_of_name_type_code = (TYPEOF(h.mail_care_of_name_type_code))'',0,100));
    maxlength_mail_care_of_name_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_care_of_name_type_code)));
    avelength_mail_care_of_name_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_care_of_name_type_code)),h.mail_care_of_name_type_code<>(typeof(h.mail_care_of_name_type_code))'');
    populated_mailing_care_of_name_cnt := COUNT(GROUP,h.mailing_care_of_name <> (TYPEOF(h.mailing_care_of_name))'');
    populated_mailing_care_of_name_pcnt := AVE(GROUP,IF(h.mailing_care_of_name = (TYPEOF(h.mailing_care_of_name))'',0,100));
    maxlength_mailing_care_of_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_care_of_name)));
    avelength_mailing_care_of_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_care_of_name)),h.mailing_care_of_name<>(typeof(h.mailing_care_of_name))'');
    populated_mailing_full_street_address_cnt := COUNT(GROUP,h.mailing_full_street_address <> (TYPEOF(h.mailing_full_street_address))'');
    populated_mailing_full_street_address_pcnt := AVE(GROUP,IF(h.mailing_full_street_address = (TYPEOF(h.mailing_full_street_address))'',0,100));
    maxlength_mailing_full_street_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_full_street_address)));
    avelength_mailing_full_street_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_full_street_address)),h.mailing_full_street_address<>(typeof(h.mailing_full_street_address))'');
    populated_mailing_unit_number_cnt := COUNT(GROUP,h.mailing_unit_number <> (TYPEOF(h.mailing_unit_number))'');
    populated_mailing_unit_number_pcnt := AVE(GROUP,IF(h.mailing_unit_number = (TYPEOF(h.mailing_unit_number))'',0,100));
    maxlength_mailing_unit_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_unit_number)));
    avelength_mailing_unit_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_unit_number)),h.mailing_unit_number<>(typeof(h.mailing_unit_number))'');
    populated_mailing_city_state_zip_cnt := COUNT(GROUP,h.mailing_city_state_zip <> (TYPEOF(h.mailing_city_state_zip))'');
    populated_mailing_city_state_zip_pcnt := AVE(GROUP,IF(h.mailing_city_state_zip = (TYPEOF(h.mailing_city_state_zip))'',0,100));
    maxlength_mailing_city_state_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_city_state_zip)));
    avelength_mailing_city_state_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_city_state_zip)),h.mailing_city_state_zip<>(typeof(h.mailing_city_state_zip))'');
    populated_property_full_street_address_cnt := COUNT(GROUP,h.property_full_street_address <> (TYPEOF(h.property_full_street_address))'');
    populated_property_full_street_address_pcnt := AVE(GROUP,IF(h.property_full_street_address = (TYPEOF(h.property_full_street_address))'',0,100));
    maxlength_property_full_street_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_full_street_address)));
    avelength_property_full_street_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_full_street_address)),h.property_full_street_address<>(typeof(h.property_full_street_address))'');
    populated_property_unit_number_cnt := COUNT(GROUP,h.property_unit_number <> (TYPEOF(h.property_unit_number))'');
    populated_property_unit_number_pcnt := AVE(GROUP,IF(h.property_unit_number = (TYPEOF(h.property_unit_number))'',0,100));
    maxlength_property_unit_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_unit_number)));
    avelength_property_unit_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_unit_number)),h.property_unit_number<>(typeof(h.property_unit_number))'');
    populated_property_city_state_zip_cnt := COUNT(GROUP,h.property_city_state_zip <> (TYPEOF(h.property_city_state_zip))'');
    populated_property_city_state_zip_pcnt := AVE(GROUP,IF(h.property_city_state_zip = (TYPEOF(h.property_city_state_zip))'',0,100));
    maxlength_property_city_state_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_city_state_zip)));
    avelength_property_city_state_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_city_state_zip)),h.property_city_state_zip<>(typeof(h.property_city_state_zip))'');
    populated_property_country_code_cnt := COUNT(GROUP,h.property_country_code <> (TYPEOF(h.property_country_code))'');
    populated_property_country_code_pcnt := AVE(GROUP,IF(h.property_country_code = (TYPEOF(h.property_country_code))'',0,100));
    maxlength_property_country_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_country_code)));
    avelength_property_country_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_country_code)),h.property_country_code<>(typeof(h.property_country_code))'');
    populated_property_address_code_cnt := COUNT(GROUP,h.property_address_code <> (TYPEOF(h.property_address_code))'');
    populated_property_address_code_pcnt := AVE(GROUP,IF(h.property_address_code = (TYPEOF(h.property_address_code))'',0,100));
    maxlength_property_address_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_address_code)));
    avelength_property_address_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_address_code)),h.property_address_code<>(typeof(h.property_address_code))'');
    populated_legal_lot_code_cnt := COUNT(GROUP,h.legal_lot_code <> (TYPEOF(h.legal_lot_code))'');
    populated_legal_lot_code_pcnt := AVE(GROUP,IF(h.legal_lot_code = (TYPEOF(h.legal_lot_code))'',0,100));
    maxlength_legal_lot_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_lot_code)));
    avelength_legal_lot_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_lot_code)),h.legal_lot_code<>(typeof(h.legal_lot_code))'');
    populated_legal_lot_number_cnt := COUNT(GROUP,h.legal_lot_number <> (TYPEOF(h.legal_lot_number))'');
    populated_legal_lot_number_pcnt := AVE(GROUP,IF(h.legal_lot_number = (TYPEOF(h.legal_lot_number))'',0,100));
    maxlength_legal_lot_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_lot_number)));
    avelength_legal_lot_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_lot_number)),h.legal_lot_number<>(typeof(h.legal_lot_number))'');
    populated_legal_land_lot_cnt := COUNT(GROUP,h.legal_land_lot <> (TYPEOF(h.legal_land_lot))'');
    populated_legal_land_lot_pcnt := AVE(GROUP,IF(h.legal_land_lot = (TYPEOF(h.legal_land_lot))'',0,100));
    maxlength_legal_land_lot := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_land_lot)));
    avelength_legal_land_lot := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_land_lot)),h.legal_land_lot<>(typeof(h.legal_land_lot))'');
    populated_legal_block_cnt := COUNT(GROUP,h.legal_block <> (TYPEOF(h.legal_block))'');
    populated_legal_block_pcnt := AVE(GROUP,IF(h.legal_block = (TYPEOF(h.legal_block))'',0,100));
    maxlength_legal_block := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_block)));
    avelength_legal_block := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_block)),h.legal_block<>(typeof(h.legal_block))'');
    populated_legal_section_cnt := COUNT(GROUP,h.legal_section <> (TYPEOF(h.legal_section))'');
    populated_legal_section_pcnt := AVE(GROUP,IF(h.legal_section = (TYPEOF(h.legal_section))'',0,100));
    maxlength_legal_section := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_section)));
    avelength_legal_section := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_section)),h.legal_section<>(typeof(h.legal_section))'');
    populated_legal_district_cnt := COUNT(GROUP,h.legal_district <> (TYPEOF(h.legal_district))'');
    populated_legal_district_pcnt := AVE(GROUP,IF(h.legal_district = (TYPEOF(h.legal_district))'',0,100));
    maxlength_legal_district := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_district)));
    avelength_legal_district := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_district)),h.legal_district<>(typeof(h.legal_district))'');
    populated_legal_unit_cnt := COUNT(GROUP,h.legal_unit <> (TYPEOF(h.legal_unit))'');
    populated_legal_unit_pcnt := AVE(GROUP,IF(h.legal_unit = (TYPEOF(h.legal_unit))'',0,100));
    maxlength_legal_unit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_unit)));
    avelength_legal_unit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_unit)),h.legal_unit<>(typeof(h.legal_unit))'');
    populated_legal_city_municipality_township_cnt := COUNT(GROUP,h.legal_city_municipality_township <> (TYPEOF(h.legal_city_municipality_township))'');
    populated_legal_city_municipality_township_pcnt := AVE(GROUP,IF(h.legal_city_municipality_township = (TYPEOF(h.legal_city_municipality_township))'',0,100));
    maxlength_legal_city_municipality_township := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_city_municipality_township)));
    avelength_legal_city_municipality_township := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_city_municipality_township)),h.legal_city_municipality_township<>(typeof(h.legal_city_municipality_township))'');
    populated_legal_subdivision_name_cnt := COUNT(GROUP,h.legal_subdivision_name <> (TYPEOF(h.legal_subdivision_name))'');
    populated_legal_subdivision_name_pcnt := AVE(GROUP,IF(h.legal_subdivision_name = (TYPEOF(h.legal_subdivision_name))'',0,100));
    maxlength_legal_subdivision_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_subdivision_name)));
    avelength_legal_subdivision_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_subdivision_name)),h.legal_subdivision_name<>(typeof(h.legal_subdivision_name))'');
    populated_legal_phase_number_cnt := COUNT(GROUP,h.legal_phase_number <> (TYPEOF(h.legal_phase_number))'');
    populated_legal_phase_number_pcnt := AVE(GROUP,IF(h.legal_phase_number = (TYPEOF(h.legal_phase_number))'',0,100));
    maxlength_legal_phase_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_phase_number)));
    avelength_legal_phase_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_phase_number)),h.legal_phase_number<>(typeof(h.legal_phase_number))'');
    populated_legal_tract_number_cnt := COUNT(GROUP,h.legal_tract_number <> (TYPEOF(h.legal_tract_number))'');
    populated_legal_tract_number_pcnt := AVE(GROUP,IF(h.legal_tract_number = (TYPEOF(h.legal_tract_number))'',0,100));
    maxlength_legal_tract_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_tract_number)));
    avelength_legal_tract_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_tract_number)),h.legal_tract_number<>(typeof(h.legal_tract_number))'');
    populated_legal_sec_twn_rng_mer_cnt := COUNT(GROUP,h.legal_sec_twn_rng_mer <> (TYPEOF(h.legal_sec_twn_rng_mer))'');
    populated_legal_sec_twn_rng_mer_pcnt := AVE(GROUP,IF(h.legal_sec_twn_rng_mer = (TYPEOF(h.legal_sec_twn_rng_mer))'',0,100));
    maxlength_legal_sec_twn_rng_mer := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_sec_twn_rng_mer)));
    avelength_legal_sec_twn_rng_mer := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_sec_twn_rng_mer)),h.legal_sec_twn_rng_mer<>(typeof(h.legal_sec_twn_rng_mer))'');
    populated_legal_brief_description_cnt := COUNT(GROUP,h.legal_brief_description <> (TYPEOF(h.legal_brief_description))'');
    populated_legal_brief_description_pcnt := AVE(GROUP,IF(h.legal_brief_description = (TYPEOF(h.legal_brief_description))'',0,100));
    maxlength_legal_brief_description := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_brief_description)));
    avelength_legal_brief_description := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_brief_description)),h.legal_brief_description<>(typeof(h.legal_brief_description))'');
    populated_legal_assessor_map_ref_cnt := COUNT(GROUP,h.legal_assessor_map_ref <> (TYPEOF(h.legal_assessor_map_ref))'');
    populated_legal_assessor_map_ref_pcnt := AVE(GROUP,IF(h.legal_assessor_map_ref = (TYPEOF(h.legal_assessor_map_ref))'',0,100));
    maxlength_legal_assessor_map_ref := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_assessor_map_ref)));
    avelength_legal_assessor_map_ref := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_assessor_map_ref)),h.legal_assessor_map_ref<>(typeof(h.legal_assessor_map_ref))'');
    populated_census_tract_cnt := COUNT(GROUP,h.census_tract <> (TYPEOF(h.census_tract))'');
    populated_census_tract_pcnt := AVE(GROUP,IF(h.census_tract = (TYPEOF(h.census_tract))'',0,100));
    maxlength_census_tract := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.census_tract)));
    avelength_census_tract := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.census_tract)),h.census_tract<>(typeof(h.census_tract))'');
    populated_record_type_code_cnt := COUNT(GROUP,h.record_type_code <> (TYPEOF(h.record_type_code))'');
    populated_record_type_code_pcnt := AVE(GROUP,IF(h.record_type_code = (TYPEOF(h.record_type_code))'',0,100));
    maxlength_record_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type_code)));
    avelength_record_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type_code)),h.record_type_code<>(typeof(h.record_type_code))'');
    populated_ownership_type_code_cnt := COUNT(GROUP,h.ownership_type_code <> (TYPEOF(h.ownership_type_code))'');
    populated_ownership_type_code_pcnt := AVE(GROUP,IF(h.ownership_type_code = (TYPEOF(h.ownership_type_code))'',0,100));
    maxlength_ownership_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ownership_type_code)));
    avelength_ownership_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ownership_type_code)),h.ownership_type_code<>(typeof(h.ownership_type_code))'');
    populated_new_record_type_code_cnt := COUNT(GROUP,h.new_record_type_code <> (TYPEOF(h.new_record_type_code))'');
    populated_new_record_type_code_pcnt := AVE(GROUP,IF(h.new_record_type_code = (TYPEOF(h.new_record_type_code))'',0,100));
    maxlength_new_record_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.new_record_type_code)));
    avelength_new_record_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.new_record_type_code)),h.new_record_type_code<>(typeof(h.new_record_type_code))'');
    populated_state_land_use_code_cnt := COUNT(GROUP,h.state_land_use_code <> (TYPEOF(h.state_land_use_code))'');
    populated_state_land_use_code_pcnt := AVE(GROUP,IF(h.state_land_use_code = (TYPEOF(h.state_land_use_code))'',0,100));
    maxlength_state_land_use_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_land_use_code)));
    avelength_state_land_use_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_land_use_code)),h.state_land_use_code<>(typeof(h.state_land_use_code))'');
    populated_county_land_use_code_cnt := COUNT(GROUP,h.county_land_use_code <> (TYPEOF(h.county_land_use_code))'');
    populated_county_land_use_code_pcnt := AVE(GROUP,IF(h.county_land_use_code = (TYPEOF(h.county_land_use_code))'',0,100));
    maxlength_county_land_use_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_land_use_code)));
    avelength_county_land_use_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_land_use_code)),h.county_land_use_code<>(typeof(h.county_land_use_code))'');
    populated_county_land_use_description_cnt := COUNT(GROUP,h.county_land_use_description <> (TYPEOF(h.county_land_use_description))'');
    populated_county_land_use_description_pcnt := AVE(GROUP,IF(h.county_land_use_description = (TYPEOF(h.county_land_use_description))'',0,100));
    maxlength_county_land_use_description := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_land_use_description)));
    avelength_county_land_use_description := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_land_use_description)),h.county_land_use_description<>(typeof(h.county_land_use_description))'');
    populated_standardized_land_use_code_cnt := COUNT(GROUP,h.standardized_land_use_code <> (TYPEOF(h.standardized_land_use_code))'');
    populated_standardized_land_use_code_pcnt := AVE(GROUP,IF(h.standardized_land_use_code = (TYPEOF(h.standardized_land_use_code))'',0,100));
    maxlength_standardized_land_use_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.standardized_land_use_code)));
    avelength_standardized_land_use_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.standardized_land_use_code)),h.standardized_land_use_code<>(typeof(h.standardized_land_use_code))'');
    populated_timeshare_code_cnt := COUNT(GROUP,h.timeshare_code <> (TYPEOF(h.timeshare_code))'');
    populated_timeshare_code_pcnt := AVE(GROUP,IF(h.timeshare_code = (TYPEOF(h.timeshare_code))'',0,100));
    maxlength_timeshare_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.timeshare_code)));
    avelength_timeshare_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.timeshare_code)),h.timeshare_code<>(typeof(h.timeshare_code))'');
    populated_zoning_cnt := COUNT(GROUP,h.zoning <> (TYPEOF(h.zoning))'');
    populated_zoning_pcnt := AVE(GROUP,IF(h.zoning = (TYPEOF(h.zoning))'',0,100));
    maxlength_zoning := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zoning)));
    avelength_zoning := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zoning)),h.zoning<>(typeof(h.zoning))'');
    populated_owner_occupied_cnt := COUNT(GROUP,h.owner_occupied <> (TYPEOF(h.owner_occupied))'');
    populated_owner_occupied_pcnt := AVE(GROUP,IF(h.owner_occupied = (TYPEOF(h.owner_occupied))'',0,100));
    maxlength_owner_occupied := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.owner_occupied)));
    avelength_owner_occupied := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.owner_occupied)),h.owner_occupied<>(typeof(h.owner_occupied))'');
    populated_recorder_document_number_cnt := COUNT(GROUP,h.recorder_document_number <> (TYPEOF(h.recorder_document_number))'');
    populated_recorder_document_number_pcnt := AVE(GROUP,IF(h.recorder_document_number = (TYPEOF(h.recorder_document_number))'',0,100));
    maxlength_recorder_document_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recorder_document_number)));
    avelength_recorder_document_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recorder_document_number)),h.recorder_document_number<>(typeof(h.recorder_document_number))'');
    populated_recorder_book_number_cnt := COUNT(GROUP,h.recorder_book_number <> (TYPEOF(h.recorder_book_number))'');
    populated_recorder_book_number_pcnt := AVE(GROUP,IF(h.recorder_book_number = (TYPEOF(h.recorder_book_number))'',0,100));
    maxlength_recorder_book_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recorder_book_number)));
    avelength_recorder_book_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recorder_book_number)),h.recorder_book_number<>(typeof(h.recorder_book_number))'');
    populated_recorder_page_number_cnt := COUNT(GROUP,h.recorder_page_number <> (TYPEOF(h.recorder_page_number))'');
    populated_recorder_page_number_pcnt := AVE(GROUP,IF(h.recorder_page_number = (TYPEOF(h.recorder_page_number))'',0,100));
    maxlength_recorder_page_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recorder_page_number)));
    avelength_recorder_page_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recorder_page_number)),h.recorder_page_number<>(typeof(h.recorder_page_number))'');
    populated_transfer_date_cnt := COUNT(GROUP,h.transfer_date <> (TYPEOF(h.transfer_date))'');
    populated_transfer_date_pcnt := AVE(GROUP,IF(h.transfer_date = (TYPEOF(h.transfer_date))'',0,100));
    maxlength_transfer_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transfer_date)));
    avelength_transfer_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transfer_date)),h.transfer_date<>(typeof(h.transfer_date))'');
    populated_recording_date_cnt := COUNT(GROUP,h.recording_date <> (TYPEOF(h.recording_date))'');
    populated_recording_date_pcnt := AVE(GROUP,IF(h.recording_date = (TYPEOF(h.recording_date))'',0,100));
    maxlength_recording_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recording_date)));
    avelength_recording_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recording_date)),h.recording_date<>(typeof(h.recording_date))'');
    populated_sale_date_cnt := COUNT(GROUP,h.sale_date <> (TYPEOF(h.sale_date))'');
    populated_sale_date_pcnt := AVE(GROUP,IF(h.sale_date = (TYPEOF(h.sale_date))'',0,100));
    maxlength_sale_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sale_date)));
    avelength_sale_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sale_date)),h.sale_date<>(typeof(h.sale_date))'');
    populated_document_type_cnt := COUNT(GROUP,h.document_type <> (TYPEOF(h.document_type))'');
    populated_document_type_pcnt := AVE(GROUP,IF(h.document_type = (TYPEOF(h.document_type))'',0,100));
    maxlength_document_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.document_type)));
    avelength_document_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.document_type)),h.document_type<>(typeof(h.document_type))'');
    populated_sales_price_cnt := COUNT(GROUP,h.sales_price <> (TYPEOF(h.sales_price))'');
    populated_sales_price_pcnt := AVE(GROUP,IF(h.sales_price = (TYPEOF(h.sales_price))'',0,100));
    maxlength_sales_price := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sales_price)));
    avelength_sales_price := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sales_price)),h.sales_price<>(typeof(h.sales_price))'');
    populated_sales_price_code_cnt := COUNT(GROUP,h.sales_price_code <> (TYPEOF(h.sales_price_code))'');
    populated_sales_price_code_pcnt := AVE(GROUP,IF(h.sales_price_code = (TYPEOF(h.sales_price_code))'',0,100));
    maxlength_sales_price_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sales_price_code)));
    avelength_sales_price_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sales_price_code)),h.sales_price_code<>(typeof(h.sales_price_code))'');
    populated_mortgage_loan_amount_cnt := COUNT(GROUP,h.mortgage_loan_amount <> (TYPEOF(h.mortgage_loan_amount))'');
    populated_mortgage_loan_amount_pcnt := AVE(GROUP,IF(h.mortgage_loan_amount = (TYPEOF(h.mortgage_loan_amount))'',0,100));
    maxlength_mortgage_loan_amount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mortgage_loan_amount)));
    avelength_mortgage_loan_amount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mortgage_loan_amount)),h.mortgage_loan_amount<>(typeof(h.mortgage_loan_amount))'');
    populated_mortgage_loan_type_code_cnt := COUNT(GROUP,h.mortgage_loan_type_code <> (TYPEOF(h.mortgage_loan_type_code))'');
    populated_mortgage_loan_type_code_pcnt := AVE(GROUP,IF(h.mortgage_loan_type_code = (TYPEOF(h.mortgage_loan_type_code))'',0,100));
    maxlength_mortgage_loan_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mortgage_loan_type_code)));
    avelength_mortgage_loan_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mortgage_loan_type_code)),h.mortgage_loan_type_code<>(typeof(h.mortgage_loan_type_code))'');
    populated_mortgage_lender_name_cnt := COUNT(GROUP,h.mortgage_lender_name <> (TYPEOF(h.mortgage_lender_name))'');
    populated_mortgage_lender_name_pcnt := AVE(GROUP,IF(h.mortgage_lender_name = (TYPEOF(h.mortgage_lender_name))'',0,100));
    maxlength_mortgage_lender_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mortgage_lender_name)));
    avelength_mortgage_lender_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mortgage_lender_name)),h.mortgage_lender_name<>(typeof(h.mortgage_lender_name))'');
    populated_mortgage_lender_type_code_cnt := COUNT(GROUP,h.mortgage_lender_type_code <> (TYPEOF(h.mortgage_lender_type_code))'');
    populated_mortgage_lender_type_code_pcnt := AVE(GROUP,IF(h.mortgage_lender_type_code = (TYPEOF(h.mortgage_lender_type_code))'',0,100));
    maxlength_mortgage_lender_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mortgage_lender_type_code)));
    avelength_mortgage_lender_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mortgage_lender_type_code)),h.mortgage_lender_type_code<>(typeof(h.mortgage_lender_type_code))'');
    populated_prior_transfer_date_cnt := COUNT(GROUP,h.prior_transfer_date <> (TYPEOF(h.prior_transfer_date))'');
    populated_prior_transfer_date_pcnt := AVE(GROUP,IF(h.prior_transfer_date = (TYPEOF(h.prior_transfer_date))'',0,100));
    maxlength_prior_transfer_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prior_transfer_date)));
    avelength_prior_transfer_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prior_transfer_date)),h.prior_transfer_date<>(typeof(h.prior_transfer_date))'');
    populated_prior_recording_date_cnt := COUNT(GROUP,h.prior_recording_date <> (TYPEOF(h.prior_recording_date))'');
    populated_prior_recording_date_pcnt := AVE(GROUP,IF(h.prior_recording_date = (TYPEOF(h.prior_recording_date))'',0,100));
    maxlength_prior_recording_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prior_recording_date)));
    avelength_prior_recording_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prior_recording_date)),h.prior_recording_date<>(typeof(h.prior_recording_date))'');
    populated_prior_sales_price_cnt := COUNT(GROUP,h.prior_sales_price <> (TYPEOF(h.prior_sales_price))'');
    populated_prior_sales_price_pcnt := AVE(GROUP,IF(h.prior_sales_price = (TYPEOF(h.prior_sales_price))'',0,100));
    maxlength_prior_sales_price := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prior_sales_price)));
    avelength_prior_sales_price := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prior_sales_price)),h.prior_sales_price<>(typeof(h.prior_sales_price))'');
    populated_prior_sales_price_code_cnt := COUNT(GROUP,h.prior_sales_price_code <> (TYPEOF(h.prior_sales_price_code))'');
    populated_prior_sales_price_code_pcnt := AVE(GROUP,IF(h.prior_sales_price_code = (TYPEOF(h.prior_sales_price_code))'',0,100));
    maxlength_prior_sales_price_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prior_sales_price_code)));
    avelength_prior_sales_price_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prior_sales_price_code)),h.prior_sales_price_code<>(typeof(h.prior_sales_price_code))'');
    populated_assessed_land_value_cnt := COUNT(GROUP,h.assessed_land_value <> (TYPEOF(h.assessed_land_value))'');
    populated_assessed_land_value_pcnt := AVE(GROUP,IF(h.assessed_land_value = (TYPEOF(h.assessed_land_value))'',0,100));
    maxlength_assessed_land_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessed_land_value)));
    avelength_assessed_land_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessed_land_value)),h.assessed_land_value<>(typeof(h.assessed_land_value))'');
    populated_assessed_improvement_value_cnt := COUNT(GROUP,h.assessed_improvement_value <> (TYPEOF(h.assessed_improvement_value))'');
    populated_assessed_improvement_value_pcnt := AVE(GROUP,IF(h.assessed_improvement_value = (TYPEOF(h.assessed_improvement_value))'',0,100));
    maxlength_assessed_improvement_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessed_improvement_value)));
    avelength_assessed_improvement_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessed_improvement_value)),h.assessed_improvement_value<>(typeof(h.assessed_improvement_value))'');
    populated_assessed_total_value_cnt := COUNT(GROUP,h.assessed_total_value <> (TYPEOF(h.assessed_total_value))'');
    populated_assessed_total_value_pcnt := AVE(GROUP,IF(h.assessed_total_value = (TYPEOF(h.assessed_total_value))'',0,100));
    maxlength_assessed_total_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessed_total_value)));
    avelength_assessed_total_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessed_total_value)),h.assessed_total_value<>(typeof(h.assessed_total_value))'');
    populated_assessed_value_year_cnt := COUNT(GROUP,h.assessed_value_year <> (TYPEOF(h.assessed_value_year))'');
    populated_assessed_value_year_pcnt := AVE(GROUP,IF(h.assessed_value_year = (TYPEOF(h.assessed_value_year))'',0,100));
    maxlength_assessed_value_year := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessed_value_year)));
    avelength_assessed_value_year := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessed_value_year)),h.assessed_value_year<>(typeof(h.assessed_value_year))'');
    populated_market_land_value_cnt := COUNT(GROUP,h.market_land_value <> (TYPEOF(h.market_land_value))'');
    populated_market_land_value_pcnt := AVE(GROUP,IF(h.market_land_value = (TYPEOF(h.market_land_value))'',0,100));
    maxlength_market_land_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.market_land_value)));
    avelength_market_land_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.market_land_value)),h.market_land_value<>(typeof(h.market_land_value))'');
    populated_market_improvement_value_cnt := COUNT(GROUP,h.market_improvement_value <> (TYPEOF(h.market_improvement_value))'');
    populated_market_improvement_value_pcnt := AVE(GROUP,IF(h.market_improvement_value = (TYPEOF(h.market_improvement_value))'',0,100));
    maxlength_market_improvement_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.market_improvement_value)));
    avelength_market_improvement_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.market_improvement_value)),h.market_improvement_value<>(typeof(h.market_improvement_value))'');
    populated_market_total_value_cnt := COUNT(GROUP,h.market_total_value <> (TYPEOF(h.market_total_value))'');
    populated_market_total_value_pcnt := AVE(GROUP,IF(h.market_total_value = (TYPEOF(h.market_total_value))'',0,100));
    maxlength_market_total_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.market_total_value)));
    avelength_market_total_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.market_total_value)),h.market_total_value<>(typeof(h.market_total_value))'');
    populated_market_value_year_cnt := COUNT(GROUP,h.market_value_year <> (TYPEOF(h.market_value_year))'');
    populated_market_value_year_pcnt := AVE(GROUP,IF(h.market_value_year = (TYPEOF(h.market_value_year))'',0,100));
    maxlength_market_value_year := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.market_value_year)));
    avelength_market_value_year := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.market_value_year)),h.market_value_year<>(typeof(h.market_value_year))'');
    populated_homestead_homeowner_exemption_cnt := COUNT(GROUP,h.homestead_homeowner_exemption <> (TYPEOF(h.homestead_homeowner_exemption))'');
    populated_homestead_homeowner_exemption_pcnt := AVE(GROUP,IF(h.homestead_homeowner_exemption = (TYPEOF(h.homestead_homeowner_exemption))'',0,100));
    maxlength_homestead_homeowner_exemption := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.homestead_homeowner_exemption)));
    avelength_homestead_homeowner_exemption := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.homestead_homeowner_exemption)),h.homestead_homeowner_exemption<>(typeof(h.homestead_homeowner_exemption))'');
    populated_tax_exemption1_code_cnt := COUNT(GROUP,h.tax_exemption1_code <> (TYPEOF(h.tax_exemption1_code))'');
    populated_tax_exemption1_code_pcnt := AVE(GROUP,IF(h.tax_exemption1_code = (TYPEOF(h.tax_exemption1_code))'',0,100));
    maxlength_tax_exemption1_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_exemption1_code)));
    avelength_tax_exemption1_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_exemption1_code)),h.tax_exemption1_code<>(typeof(h.tax_exemption1_code))'');
    populated_tax_exemption2_code_cnt := COUNT(GROUP,h.tax_exemption2_code <> (TYPEOF(h.tax_exemption2_code))'');
    populated_tax_exemption2_code_pcnt := AVE(GROUP,IF(h.tax_exemption2_code = (TYPEOF(h.tax_exemption2_code))'',0,100));
    maxlength_tax_exemption2_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_exemption2_code)));
    avelength_tax_exemption2_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_exemption2_code)),h.tax_exemption2_code<>(typeof(h.tax_exemption2_code))'');
    populated_tax_exemption3_code_cnt := COUNT(GROUP,h.tax_exemption3_code <> (TYPEOF(h.tax_exemption3_code))'');
    populated_tax_exemption3_code_pcnt := AVE(GROUP,IF(h.tax_exemption3_code = (TYPEOF(h.tax_exemption3_code))'',0,100));
    maxlength_tax_exemption3_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_exemption3_code)));
    avelength_tax_exemption3_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_exemption3_code)),h.tax_exemption3_code<>(typeof(h.tax_exemption3_code))'');
    populated_tax_exemption4_code_cnt := COUNT(GROUP,h.tax_exemption4_code <> (TYPEOF(h.tax_exemption4_code))'');
    populated_tax_exemption4_code_pcnt := AVE(GROUP,IF(h.tax_exemption4_code = (TYPEOF(h.tax_exemption4_code))'',0,100));
    maxlength_tax_exemption4_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_exemption4_code)));
    avelength_tax_exemption4_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_exemption4_code)),h.tax_exemption4_code<>(typeof(h.tax_exemption4_code))'');
    populated_tax_rate_code_area_cnt := COUNT(GROUP,h.tax_rate_code_area <> (TYPEOF(h.tax_rate_code_area))'');
    populated_tax_rate_code_area_pcnt := AVE(GROUP,IF(h.tax_rate_code_area = (TYPEOF(h.tax_rate_code_area))'',0,100));
    maxlength_tax_rate_code_area := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_rate_code_area)));
    avelength_tax_rate_code_area := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_rate_code_area)),h.tax_rate_code_area<>(typeof(h.tax_rate_code_area))'');
    populated_tax_amount_cnt := COUNT(GROUP,h.tax_amount <> (TYPEOF(h.tax_amount))'');
    populated_tax_amount_pcnt := AVE(GROUP,IF(h.tax_amount = (TYPEOF(h.tax_amount))'',0,100));
    maxlength_tax_amount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_amount)));
    avelength_tax_amount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_amount)),h.tax_amount<>(typeof(h.tax_amount))'');
    populated_tax_year_cnt := COUNT(GROUP,h.tax_year <> (TYPEOF(h.tax_year))'');
    populated_tax_year_pcnt := AVE(GROUP,IF(h.tax_year = (TYPEOF(h.tax_year))'',0,100));
    maxlength_tax_year := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_year)));
    avelength_tax_year := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_year)),h.tax_year<>(typeof(h.tax_year))'');
    populated_tax_delinquent_year_cnt := COUNT(GROUP,h.tax_delinquent_year <> (TYPEOF(h.tax_delinquent_year))'');
    populated_tax_delinquent_year_pcnt := AVE(GROUP,IF(h.tax_delinquent_year = (TYPEOF(h.tax_delinquent_year))'',0,100));
    maxlength_tax_delinquent_year := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_delinquent_year)));
    avelength_tax_delinquent_year := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_delinquent_year)),h.tax_delinquent_year<>(typeof(h.tax_delinquent_year))'');
    populated_school_tax_district1_cnt := COUNT(GROUP,h.school_tax_district1 <> (TYPEOF(h.school_tax_district1))'');
    populated_school_tax_district1_pcnt := AVE(GROUP,IF(h.school_tax_district1 = (TYPEOF(h.school_tax_district1))'',0,100));
    maxlength_school_tax_district1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.school_tax_district1)));
    avelength_school_tax_district1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.school_tax_district1)),h.school_tax_district1<>(typeof(h.school_tax_district1))'');
    populated_school_tax_district1_indicator_cnt := COUNT(GROUP,h.school_tax_district1_indicator <> (TYPEOF(h.school_tax_district1_indicator))'');
    populated_school_tax_district1_indicator_pcnt := AVE(GROUP,IF(h.school_tax_district1_indicator = (TYPEOF(h.school_tax_district1_indicator))'',0,100));
    maxlength_school_tax_district1_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.school_tax_district1_indicator)));
    avelength_school_tax_district1_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.school_tax_district1_indicator)),h.school_tax_district1_indicator<>(typeof(h.school_tax_district1_indicator))'');
    populated_school_tax_district2_cnt := COUNT(GROUP,h.school_tax_district2 <> (TYPEOF(h.school_tax_district2))'');
    populated_school_tax_district2_pcnt := AVE(GROUP,IF(h.school_tax_district2 = (TYPEOF(h.school_tax_district2))'',0,100));
    maxlength_school_tax_district2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.school_tax_district2)));
    avelength_school_tax_district2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.school_tax_district2)),h.school_tax_district2<>(typeof(h.school_tax_district2))'');
    populated_school_tax_district2_indicator_cnt := COUNT(GROUP,h.school_tax_district2_indicator <> (TYPEOF(h.school_tax_district2_indicator))'');
    populated_school_tax_district2_indicator_pcnt := AVE(GROUP,IF(h.school_tax_district2_indicator = (TYPEOF(h.school_tax_district2_indicator))'',0,100));
    maxlength_school_tax_district2_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.school_tax_district2_indicator)));
    avelength_school_tax_district2_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.school_tax_district2_indicator)),h.school_tax_district2_indicator<>(typeof(h.school_tax_district2_indicator))'');
    populated_school_tax_district3_cnt := COUNT(GROUP,h.school_tax_district3 <> (TYPEOF(h.school_tax_district3))'');
    populated_school_tax_district3_pcnt := AVE(GROUP,IF(h.school_tax_district3 = (TYPEOF(h.school_tax_district3))'',0,100));
    maxlength_school_tax_district3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.school_tax_district3)));
    avelength_school_tax_district3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.school_tax_district3)),h.school_tax_district3<>(typeof(h.school_tax_district3))'');
    populated_school_tax_district3_indicator_cnt := COUNT(GROUP,h.school_tax_district3_indicator <> (TYPEOF(h.school_tax_district3_indicator))'');
    populated_school_tax_district3_indicator_pcnt := AVE(GROUP,IF(h.school_tax_district3_indicator = (TYPEOF(h.school_tax_district3_indicator))'',0,100));
    maxlength_school_tax_district3_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.school_tax_district3_indicator)));
    avelength_school_tax_district3_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.school_tax_district3_indicator)),h.school_tax_district3_indicator<>(typeof(h.school_tax_district3_indicator))'');
    populated_lot_size_cnt := COUNT(GROUP,h.lot_size <> (TYPEOF(h.lot_size))'');
    populated_lot_size_pcnt := AVE(GROUP,IF(h.lot_size = (TYPEOF(h.lot_size))'',0,100));
    maxlength_lot_size := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_size)));
    avelength_lot_size := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_size)),h.lot_size<>(typeof(h.lot_size))'');
    populated_lot_size_acres_cnt := COUNT(GROUP,h.lot_size_acres <> (TYPEOF(h.lot_size_acres))'');
    populated_lot_size_acres_pcnt := AVE(GROUP,IF(h.lot_size_acres = (TYPEOF(h.lot_size_acres))'',0,100));
    maxlength_lot_size_acres := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_size_acres)));
    avelength_lot_size_acres := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_size_acres)),h.lot_size_acres<>(typeof(h.lot_size_acres))'');
    populated_lot_size_frontage_feet_cnt := COUNT(GROUP,h.lot_size_frontage_feet <> (TYPEOF(h.lot_size_frontage_feet))'');
    populated_lot_size_frontage_feet_pcnt := AVE(GROUP,IF(h.lot_size_frontage_feet = (TYPEOF(h.lot_size_frontage_feet))'',0,100));
    maxlength_lot_size_frontage_feet := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_size_frontage_feet)));
    avelength_lot_size_frontage_feet := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_size_frontage_feet)),h.lot_size_frontage_feet<>(typeof(h.lot_size_frontage_feet))'');
    populated_lot_size_depth_feet_cnt := COUNT(GROUP,h.lot_size_depth_feet <> (TYPEOF(h.lot_size_depth_feet))'');
    populated_lot_size_depth_feet_pcnt := AVE(GROUP,IF(h.lot_size_depth_feet = (TYPEOF(h.lot_size_depth_feet))'',0,100));
    maxlength_lot_size_depth_feet := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_size_depth_feet)));
    avelength_lot_size_depth_feet := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_size_depth_feet)),h.lot_size_depth_feet<>(typeof(h.lot_size_depth_feet))'');
    populated_land_acres_cnt := COUNT(GROUP,h.land_acres <> (TYPEOF(h.land_acres))'');
    populated_land_acres_pcnt := AVE(GROUP,IF(h.land_acres = (TYPEOF(h.land_acres))'',0,100));
    maxlength_land_acres := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.land_acres)));
    avelength_land_acres := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.land_acres)),h.land_acres<>(typeof(h.land_acres))'');
    populated_land_square_footage_cnt := COUNT(GROUP,h.land_square_footage <> (TYPEOF(h.land_square_footage))'');
    populated_land_square_footage_pcnt := AVE(GROUP,IF(h.land_square_footage = (TYPEOF(h.land_square_footage))'',0,100));
    maxlength_land_square_footage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.land_square_footage)));
    avelength_land_square_footage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.land_square_footage)),h.land_square_footage<>(typeof(h.land_square_footage))'');
    populated_land_dimensions_cnt := COUNT(GROUP,h.land_dimensions <> (TYPEOF(h.land_dimensions))'');
    populated_land_dimensions_pcnt := AVE(GROUP,IF(h.land_dimensions = (TYPEOF(h.land_dimensions))'',0,100));
    maxlength_land_dimensions := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.land_dimensions)));
    avelength_land_dimensions := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.land_dimensions)),h.land_dimensions<>(typeof(h.land_dimensions))'');
    populated_building_area_cnt := COUNT(GROUP,h.building_area <> (TYPEOF(h.building_area))'');
    populated_building_area_pcnt := AVE(GROUP,IF(h.building_area = (TYPEOF(h.building_area))'',0,100));
    maxlength_building_area := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area)));
    avelength_building_area := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area)),h.building_area<>(typeof(h.building_area))'');
    populated_building_area_indicator_cnt := COUNT(GROUP,h.building_area_indicator <> (TYPEOF(h.building_area_indicator))'');
    populated_building_area_indicator_pcnt := AVE(GROUP,IF(h.building_area_indicator = (TYPEOF(h.building_area_indicator))'',0,100));
    maxlength_building_area_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area_indicator)));
    avelength_building_area_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area_indicator)),h.building_area_indicator<>(typeof(h.building_area_indicator))'');
    populated_building_area1_cnt := COUNT(GROUP,h.building_area1 <> (TYPEOF(h.building_area1))'');
    populated_building_area1_pcnt := AVE(GROUP,IF(h.building_area1 = (TYPEOF(h.building_area1))'',0,100));
    maxlength_building_area1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area1)));
    avelength_building_area1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area1)),h.building_area1<>(typeof(h.building_area1))'');
    populated_building_area1_indicator_cnt := COUNT(GROUP,h.building_area1_indicator <> (TYPEOF(h.building_area1_indicator))'');
    populated_building_area1_indicator_pcnt := AVE(GROUP,IF(h.building_area1_indicator = (TYPEOF(h.building_area1_indicator))'',0,100));
    maxlength_building_area1_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area1_indicator)));
    avelength_building_area1_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area1_indicator)),h.building_area1_indicator<>(typeof(h.building_area1_indicator))'');
    populated_building_area2_cnt := COUNT(GROUP,h.building_area2 <> (TYPEOF(h.building_area2))'');
    populated_building_area2_pcnt := AVE(GROUP,IF(h.building_area2 = (TYPEOF(h.building_area2))'',0,100));
    maxlength_building_area2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area2)));
    avelength_building_area2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area2)),h.building_area2<>(typeof(h.building_area2))'');
    populated_building_area2_indicator_cnt := COUNT(GROUP,h.building_area2_indicator <> (TYPEOF(h.building_area2_indicator))'');
    populated_building_area2_indicator_pcnt := AVE(GROUP,IF(h.building_area2_indicator = (TYPEOF(h.building_area2_indicator))'',0,100));
    maxlength_building_area2_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area2_indicator)));
    avelength_building_area2_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area2_indicator)),h.building_area2_indicator<>(typeof(h.building_area2_indicator))'');
    populated_building_area3_cnt := COUNT(GROUP,h.building_area3 <> (TYPEOF(h.building_area3))'');
    populated_building_area3_pcnt := AVE(GROUP,IF(h.building_area3 = (TYPEOF(h.building_area3))'',0,100));
    maxlength_building_area3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area3)));
    avelength_building_area3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area3)),h.building_area3<>(typeof(h.building_area3))'');
    populated_building_area3_indicator_cnt := COUNT(GROUP,h.building_area3_indicator <> (TYPEOF(h.building_area3_indicator))'');
    populated_building_area3_indicator_pcnt := AVE(GROUP,IF(h.building_area3_indicator = (TYPEOF(h.building_area3_indicator))'',0,100));
    maxlength_building_area3_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area3_indicator)));
    avelength_building_area3_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area3_indicator)),h.building_area3_indicator<>(typeof(h.building_area3_indicator))'');
    populated_building_area4_cnt := COUNT(GROUP,h.building_area4 <> (TYPEOF(h.building_area4))'');
    populated_building_area4_pcnt := AVE(GROUP,IF(h.building_area4 = (TYPEOF(h.building_area4))'',0,100));
    maxlength_building_area4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area4)));
    avelength_building_area4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area4)),h.building_area4<>(typeof(h.building_area4))'');
    populated_building_area4_indicator_cnt := COUNT(GROUP,h.building_area4_indicator <> (TYPEOF(h.building_area4_indicator))'');
    populated_building_area4_indicator_pcnt := AVE(GROUP,IF(h.building_area4_indicator = (TYPEOF(h.building_area4_indicator))'',0,100));
    maxlength_building_area4_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area4_indicator)));
    avelength_building_area4_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area4_indicator)),h.building_area4_indicator<>(typeof(h.building_area4_indicator))'');
    populated_building_area5_cnt := COUNT(GROUP,h.building_area5 <> (TYPEOF(h.building_area5))'');
    populated_building_area5_pcnt := AVE(GROUP,IF(h.building_area5 = (TYPEOF(h.building_area5))'',0,100));
    maxlength_building_area5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area5)));
    avelength_building_area5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area5)),h.building_area5<>(typeof(h.building_area5))'');
    populated_building_area5_indicator_cnt := COUNT(GROUP,h.building_area5_indicator <> (TYPEOF(h.building_area5_indicator))'');
    populated_building_area5_indicator_pcnt := AVE(GROUP,IF(h.building_area5_indicator = (TYPEOF(h.building_area5_indicator))'',0,100));
    maxlength_building_area5_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area5_indicator)));
    avelength_building_area5_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area5_indicator)),h.building_area5_indicator<>(typeof(h.building_area5_indicator))'');
    populated_building_area6_cnt := COUNT(GROUP,h.building_area6 <> (TYPEOF(h.building_area6))'');
    populated_building_area6_pcnt := AVE(GROUP,IF(h.building_area6 = (TYPEOF(h.building_area6))'',0,100));
    maxlength_building_area6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area6)));
    avelength_building_area6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area6)),h.building_area6<>(typeof(h.building_area6))'');
    populated_building_area6_indicator_cnt := COUNT(GROUP,h.building_area6_indicator <> (TYPEOF(h.building_area6_indicator))'');
    populated_building_area6_indicator_pcnt := AVE(GROUP,IF(h.building_area6_indicator = (TYPEOF(h.building_area6_indicator))'',0,100));
    maxlength_building_area6_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area6_indicator)));
    avelength_building_area6_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area6_indicator)),h.building_area6_indicator<>(typeof(h.building_area6_indicator))'');
    populated_building_area7_cnt := COUNT(GROUP,h.building_area7 <> (TYPEOF(h.building_area7))'');
    populated_building_area7_pcnt := AVE(GROUP,IF(h.building_area7 = (TYPEOF(h.building_area7))'',0,100));
    maxlength_building_area7 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area7)));
    avelength_building_area7 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area7)),h.building_area7<>(typeof(h.building_area7))'');
    populated_building_area7_indicator_cnt := COUNT(GROUP,h.building_area7_indicator <> (TYPEOF(h.building_area7_indicator))'');
    populated_building_area7_indicator_pcnt := AVE(GROUP,IF(h.building_area7_indicator = (TYPEOF(h.building_area7_indicator))'',0,100));
    maxlength_building_area7_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area7_indicator)));
    avelength_building_area7_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_area7_indicator)),h.building_area7_indicator<>(typeof(h.building_area7_indicator))'');
    populated_year_built_cnt := COUNT(GROUP,h.year_built <> (TYPEOF(h.year_built))'');
    populated_year_built_pcnt := AVE(GROUP,IF(h.year_built = (TYPEOF(h.year_built))'',0,100));
    maxlength_year_built := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.year_built)));
    avelength_year_built := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.year_built)),h.year_built<>(typeof(h.year_built))'');
    populated_effective_year_built_cnt := COUNT(GROUP,h.effective_year_built <> (TYPEOF(h.effective_year_built))'');
    populated_effective_year_built_pcnt := AVE(GROUP,IF(h.effective_year_built = (TYPEOF(h.effective_year_built))'',0,100));
    maxlength_effective_year_built := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.effective_year_built)));
    avelength_effective_year_built := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.effective_year_built)),h.effective_year_built<>(typeof(h.effective_year_built))'');
    populated_no_of_buildings_cnt := COUNT(GROUP,h.no_of_buildings <> (TYPEOF(h.no_of_buildings))'');
    populated_no_of_buildings_pcnt := AVE(GROUP,IF(h.no_of_buildings = (TYPEOF(h.no_of_buildings))'',0,100));
    maxlength_no_of_buildings := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_buildings)));
    avelength_no_of_buildings := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_buildings)),h.no_of_buildings<>(typeof(h.no_of_buildings))'');
    populated_no_of_stories_cnt := COUNT(GROUP,h.no_of_stories <> (TYPEOF(h.no_of_stories))'');
    populated_no_of_stories_pcnt := AVE(GROUP,IF(h.no_of_stories = (TYPEOF(h.no_of_stories))'',0,100));
    maxlength_no_of_stories := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_stories)));
    avelength_no_of_stories := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_stories)),h.no_of_stories<>(typeof(h.no_of_stories))'');
    populated_no_of_units_cnt := COUNT(GROUP,h.no_of_units <> (TYPEOF(h.no_of_units))'');
    populated_no_of_units_pcnt := AVE(GROUP,IF(h.no_of_units = (TYPEOF(h.no_of_units))'',0,100));
    maxlength_no_of_units := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_units)));
    avelength_no_of_units := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_units)),h.no_of_units<>(typeof(h.no_of_units))'');
    populated_no_of_rooms_cnt := COUNT(GROUP,h.no_of_rooms <> (TYPEOF(h.no_of_rooms))'');
    populated_no_of_rooms_pcnt := AVE(GROUP,IF(h.no_of_rooms = (TYPEOF(h.no_of_rooms))'',0,100));
    maxlength_no_of_rooms := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_rooms)));
    avelength_no_of_rooms := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_rooms)),h.no_of_rooms<>(typeof(h.no_of_rooms))'');
    populated_no_of_bedrooms_cnt := COUNT(GROUP,h.no_of_bedrooms <> (TYPEOF(h.no_of_bedrooms))'');
    populated_no_of_bedrooms_pcnt := AVE(GROUP,IF(h.no_of_bedrooms = (TYPEOF(h.no_of_bedrooms))'',0,100));
    maxlength_no_of_bedrooms := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_bedrooms)));
    avelength_no_of_bedrooms := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_bedrooms)),h.no_of_bedrooms<>(typeof(h.no_of_bedrooms))'');
    populated_no_of_baths_cnt := COUNT(GROUP,h.no_of_baths <> (TYPEOF(h.no_of_baths))'');
    populated_no_of_baths_pcnt := AVE(GROUP,IF(h.no_of_baths = (TYPEOF(h.no_of_baths))'',0,100));
    maxlength_no_of_baths := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_baths)));
    avelength_no_of_baths := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_baths)),h.no_of_baths<>(typeof(h.no_of_baths))'');
    populated_no_of_partial_baths_cnt := COUNT(GROUP,h.no_of_partial_baths <> (TYPEOF(h.no_of_partial_baths))'');
    populated_no_of_partial_baths_pcnt := AVE(GROUP,IF(h.no_of_partial_baths = (TYPEOF(h.no_of_partial_baths))'',0,100));
    maxlength_no_of_partial_baths := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_partial_baths)));
    avelength_no_of_partial_baths := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_partial_baths)),h.no_of_partial_baths<>(typeof(h.no_of_partial_baths))'');
    populated_no_of_plumbing_fixtures_cnt := COUNT(GROUP,h.no_of_plumbing_fixtures <> (TYPEOF(h.no_of_plumbing_fixtures))'');
    populated_no_of_plumbing_fixtures_pcnt := AVE(GROUP,IF(h.no_of_plumbing_fixtures = (TYPEOF(h.no_of_plumbing_fixtures))'',0,100));
    maxlength_no_of_plumbing_fixtures := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_plumbing_fixtures)));
    avelength_no_of_plumbing_fixtures := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_plumbing_fixtures)),h.no_of_plumbing_fixtures<>(typeof(h.no_of_plumbing_fixtures))'');
    populated_garage_type_code_cnt := COUNT(GROUP,h.garage_type_code <> (TYPEOF(h.garage_type_code))'');
    populated_garage_type_code_pcnt := AVE(GROUP,IF(h.garage_type_code = (TYPEOF(h.garage_type_code))'',0,100));
    maxlength_garage_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.garage_type_code)));
    avelength_garage_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.garage_type_code)),h.garage_type_code<>(typeof(h.garage_type_code))'');
    populated_parking_no_of_cars_cnt := COUNT(GROUP,h.parking_no_of_cars <> (TYPEOF(h.parking_no_of_cars))'');
    populated_parking_no_of_cars_pcnt := AVE(GROUP,IF(h.parking_no_of_cars = (TYPEOF(h.parking_no_of_cars))'',0,100));
    maxlength_parking_no_of_cars := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.parking_no_of_cars)));
    avelength_parking_no_of_cars := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.parking_no_of_cars)),h.parking_no_of_cars<>(typeof(h.parking_no_of_cars))'');
    populated_pool_code_cnt := COUNT(GROUP,h.pool_code <> (TYPEOF(h.pool_code))'');
    populated_pool_code_pcnt := AVE(GROUP,IF(h.pool_code = (TYPEOF(h.pool_code))'',0,100));
    maxlength_pool_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pool_code)));
    avelength_pool_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pool_code)),h.pool_code<>(typeof(h.pool_code))'');
    populated_style_code_cnt := COUNT(GROUP,h.style_code <> (TYPEOF(h.style_code))'');
    populated_style_code_pcnt := AVE(GROUP,IF(h.style_code = (TYPEOF(h.style_code))'',0,100));
    maxlength_style_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.style_code)));
    avelength_style_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.style_code)),h.style_code<>(typeof(h.style_code))'');
    populated_type_construction_code_cnt := COUNT(GROUP,h.type_construction_code <> (TYPEOF(h.type_construction_code))'');
    populated_type_construction_code_pcnt := AVE(GROUP,IF(h.type_construction_code = (TYPEOF(h.type_construction_code))'',0,100));
    maxlength_type_construction_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.type_construction_code)));
    avelength_type_construction_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.type_construction_code)),h.type_construction_code<>(typeof(h.type_construction_code))'');
    populated_foundation_code_cnt := COUNT(GROUP,h.foundation_code <> (TYPEOF(h.foundation_code))'');
    populated_foundation_code_pcnt := AVE(GROUP,IF(h.foundation_code = (TYPEOF(h.foundation_code))'',0,100));
    maxlength_foundation_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.foundation_code)));
    avelength_foundation_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.foundation_code)),h.foundation_code<>(typeof(h.foundation_code))'');
    populated_building_quality_code_cnt := COUNT(GROUP,h.building_quality_code <> (TYPEOF(h.building_quality_code))'');
    populated_building_quality_code_pcnt := AVE(GROUP,IF(h.building_quality_code = (TYPEOF(h.building_quality_code))'',0,100));
    maxlength_building_quality_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_quality_code)));
    avelength_building_quality_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_quality_code)),h.building_quality_code<>(typeof(h.building_quality_code))'');
    populated_building_condition_code_cnt := COUNT(GROUP,h.building_condition_code <> (TYPEOF(h.building_condition_code))'');
    populated_building_condition_code_pcnt := AVE(GROUP,IF(h.building_condition_code = (TYPEOF(h.building_condition_code))'',0,100));
    maxlength_building_condition_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_condition_code)));
    avelength_building_condition_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_condition_code)),h.building_condition_code<>(typeof(h.building_condition_code))'');
    populated_exterior_walls_code_cnt := COUNT(GROUP,h.exterior_walls_code <> (TYPEOF(h.exterior_walls_code))'');
    populated_exterior_walls_code_pcnt := AVE(GROUP,IF(h.exterior_walls_code = (TYPEOF(h.exterior_walls_code))'',0,100));
    maxlength_exterior_walls_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.exterior_walls_code)));
    avelength_exterior_walls_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.exterior_walls_code)),h.exterior_walls_code<>(typeof(h.exterior_walls_code))'');
    populated_interior_walls_code_cnt := COUNT(GROUP,h.interior_walls_code <> (TYPEOF(h.interior_walls_code))'');
    populated_interior_walls_code_pcnt := AVE(GROUP,IF(h.interior_walls_code = (TYPEOF(h.interior_walls_code))'',0,100));
    maxlength_interior_walls_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.interior_walls_code)));
    avelength_interior_walls_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.interior_walls_code)),h.interior_walls_code<>(typeof(h.interior_walls_code))'');
    populated_roof_cover_code_cnt := COUNT(GROUP,h.roof_cover_code <> (TYPEOF(h.roof_cover_code))'');
    populated_roof_cover_code_pcnt := AVE(GROUP,IF(h.roof_cover_code = (TYPEOF(h.roof_cover_code))'',0,100));
    maxlength_roof_cover_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.roof_cover_code)));
    avelength_roof_cover_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.roof_cover_code)),h.roof_cover_code<>(typeof(h.roof_cover_code))'');
    populated_roof_type_code_cnt := COUNT(GROUP,h.roof_type_code <> (TYPEOF(h.roof_type_code))'');
    populated_roof_type_code_pcnt := AVE(GROUP,IF(h.roof_type_code = (TYPEOF(h.roof_type_code))'',0,100));
    maxlength_roof_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.roof_type_code)));
    avelength_roof_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.roof_type_code)),h.roof_type_code<>(typeof(h.roof_type_code))'');
    populated_floor_cover_code_cnt := COUNT(GROUP,h.floor_cover_code <> (TYPEOF(h.floor_cover_code))'');
    populated_floor_cover_code_pcnt := AVE(GROUP,IF(h.floor_cover_code = (TYPEOF(h.floor_cover_code))'',0,100));
    maxlength_floor_cover_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.floor_cover_code)));
    avelength_floor_cover_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.floor_cover_code)),h.floor_cover_code<>(typeof(h.floor_cover_code))'');
    populated_water_code_cnt := COUNT(GROUP,h.water_code <> (TYPEOF(h.water_code))'');
    populated_water_code_pcnt := AVE(GROUP,IF(h.water_code = (TYPEOF(h.water_code))'',0,100));
    maxlength_water_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.water_code)));
    avelength_water_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.water_code)),h.water_code<>(typeof(h.water_code))'');
    populated_sewer_code_cnt := COUNT(GROUP,h.sewer_code <> (TYPEOF(h.sewer_code))'');
    populated_sewer_code_pcnt := AVE(GROUP,IF(h.sewer_code = (TYPEOF(h.sewer_code))'',0,100));
    maxlength_sewer_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sewer_code)));
    avelength_sewer_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sewer_code)),h.sewer_code<>(typeof(h.sewer_code))'');
    populated_heating_code_cnt := COUNT(GROUP,h.heating_code <> (TYPEOF(h.heating_code))'');
    populated_heating_code_pcnt := AVE(GROUP,IF(h.heating_code = (TYPEOF(h.heating_code))'',0,100));
    maxlength_heating_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.heating_code)));
    avelength_heating_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.heating_code)),h.heating_code<>(typeof(h.heating_code))'');
    populated_heating_fuel_type_code_cnt := COUNT(GROUP,h.heating_fuel_type_code <> (TYPEOF(h.heating_fuel_type_code))'');
    populated_heating_fuel_type_code_pcnt := AVE(GROUP,IF(h.heating_fuel_type_code = (TYPEOF(h.heating_fuel_type_code))'',0,100));
    maxlength_heating_fuel_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.heating_fuel_type_code)));
    avelength_heating_fuel_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.heating_fuel_type_code)),h.heating_fuel_type_code<>(typeof(h.heating_fuel_type_code))'');
    populated_air_conditioning_code_cnt := COUNT(GROUP,h.air_conditioning_code <> (TYPEOF(h.air_conditioning_code))'');
    populated_air_conditioning_code_pcnt := AVE(GROUP,IF(h.air_conditioning_code = (TYPEOF(h.air_conditioning_code))'',0,100));
    maxlength_air_conditioning_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.air_conditioning_code)));
    avelength_air_conditioning_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.air_conditioning_code)),h.air_conditioning_code<>(typeof(h.air_conditioning_code))'');
    populated_air_conditioning_type_code_cnt := COUNT(GROUP,h.air_conditioning_type_code <> (TYPEOF(h.air_conditioning_type_code))'');
    populated_air_conditioning_type_code_pcnt := AVE(GROUP,IF(h.air_conditioning_type_code = (TYPEOF(h.air_conditioning_type_code))'',0,100));
    maxlength_air_conditioning_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.air_conditioning_type_code)));
    avelength_air_conditioning_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.air_conditioning_type_code)),h.air_conditioning_type_code<>(typeof(h.air_conditioning_type_code))'');
    populated_elevator_cnt := COUNT(GROUP,h.elevator <> (TYPEOF(h.elevator))'');
    populated_elevator_pcnt := AVE(GROUP,IF(h.elevator = (TYPEOF(h.elevator))'',0,100));
    maxlength_elevator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.elevator)));
    avelength_elevator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.elevator)),h.elevator<>(typeof(h.elevator))'');
    populated_fireplace_indicator_cnt := COUNT(GROUP,h.fireplace_indicator <> (TYPEOF(h.fireplace_indicator))'');
    populated_fireplace_indicator_pcnt := AVE(GROUP,IF(h.fireplace_indicator = (TYPEOF(h.fireplace_indicator))'',0,100));
    maxlength_fireplace_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fireplace_indicator)));
    avelength_fireplace_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fireplace_indicator)),h.fireplace_indicator<>(typeof(h.fireplace_indicator))'');
    populated_fireplace_number_cnt := COUNT(GROUP,h.fireplace_number <> (TYPEOF(h.fireplace_number))'');
    populated_fireplace_number_pcnt := AVE(GROUP,IF(h.fireplace_number = (TYPEOF(h.fireplace_number))'',0,100));
    maxlength_fireplace_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fireplace_number)));
    avelength_fireplace_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fireplace_number)),h.fireplace_number<>(typeof(h.fireplace_number))'');
    populated_basement_code_cnt := COUNT(GROUP,h.basement_code <> (TYPEOF(h.basement_code))'');
    populated_basement_code_pcnt := AVE(GROUP,IF(h.basement_code = (TYPEOF(h.basement_code))'',0,100));
    maxlength_basement_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.basement_code)));
    avelength_basement_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.basement_code)),h.basement_code<>(typeof(h.basement_code))'');
    populated_building_class_code_cnt := COUNT(GROUP,h.building_class_code <> (TYPEOF(h.building_class_code))'');
    populated_building_class_code_pcnt := AVE(GROUP,IF(h.building_class_code = (TYPEOF(h.building_class_code))'',0,100));
    maxlength_building_class_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_class_code)));
    avelength_building_class_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_class_code)),h.building_class_code<>(typeof(h.building_class_code))'');
    populated_site_influence1_code_cnt := COUNT(GROUP,h.site_influence1_code <> (TYPEOF(h.site_influence1_code))'');
    populated_site_influence1_code_pcnt := AVE(GROUP,IF(h.site_influence1_code = (TYPEOF(h.site_influence1_code))'',0,100));
    maxlength_site_influence1_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_influence1_code)));
    avelength_site_influence1_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_influence1_code)),h.site_influence1_code<>(typeof(h.site_influence1_code))'');
    populated_site_influence2_code_cnt := COUNT(GROUP,h.site_influence2_code <> (TYPEOF(h.site_influence2_code))'');
    populated_site_influence2_code_pcnt := AVE(GROUP,IF(h.site_influence2_code = (TYPEOF(h.site_influence2_code))'',0,100));
    maxlength_site_influence2_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_influence2_code)));
    avelength_site_influence2_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_influence2_code)),h.site_influence2_code<>(typeof(h.site_influence2_code))'');
    populated_site_influence3_code_cnt := COUNT(GROUP,h.site_influence3_code <> (TYPEOF(h.site_influence3_code))'');
    populated_site_influence3_code_pcnt := AVE(GROUP,IF(h.site_influence3_code = (TYPEOF(h.site_influence3_code))'',0,100));
    maxlength_site_influence3_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_influence3_code)));
    avelength_site_influence3_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_influence3_code)),h.site_influence3_code<>(typeof(h.site_influence3_code))'');
    populated_site_influence4_code_cnt := COUNT(GROUP,h.site_influence4_code <> (TYPEOF(h.site_influence4_code))'');
    populated_site_influence4_code_pcnt := AVE(GROUP,IF(h.site_influence4_code = (TYPEOF(h.site_influence4_code))'',0,100));
    maxlength_site_influence4_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_influence4_code)));
    avelength_site_influence4_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_influence4_code)),h.site_influence4_code<>(typeof(h.site_influence4_code))'');
    populated_site_influence5_code_cnt := COUNT(GROUP,h.site_influence5_code <> (TYPEOF(h.site_influence5_code))'');
    populated_site_influence5_code_pcnt := AVE(GROUP,IF(h.site_influence5_code = (TYPEOF(h.site_influence5_code))'',0,100));
    maxlength_site_influence5_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_influence5_code)));
    avelength_site_influence5_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_influence5_code)),h.site_influence5_code<>(typeof(h.site_influence5_code))'');
    populated_amenities1_code_cnt := COUNT(GROUP,h.amenities1_code <> (TYPEOF(h.amenities1_code))'');
    populated_amenities1_code_pcnt := AVE(GROUP,IF(h.amenities1_code = (TYPEOF(h.amenities1_code))'',0,100));
    maxlength_amenities1_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.amenities1_code)));
    avelength_amenities1_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.amenities1_code)),h.amenities1_code<>(typeof(h.amenities1_code))'');
    populated_amenities2_code_cnt := COUNT(GROUP,h.amenities2_code <> (TYPEOF(h.amenities2_code))'');
    populated_amenities2_code_pcnt := AVE(GROUP,IF(h.amenities2_code = (TYPEOF(h.amenities2_code))'',0,100));
    maxlength_amenities2_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.amenities2_code)));
    avelength_amenities2_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.amenities2_code)),h.amenities2_code<>(typeof(h.amenities2_code))'');
    populated_amenities3_code_cnt := COUNT(GROUP,h.amenities3_code <> (TYPEOF(h.amenities3_code))'');
    populated_amenities3_code_pcnt := AVE(GROUP,IF(h.amenities3_code = (TYPEOF(h.amenities3_code))'',0,100));
    maxlength_amenities3_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.amenities3_code)));
    avelength_amenities3_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.amenities3_code)),h.amenities3_code<>(typeof(h.amenities3_code))'');
    populated_amenities4_code_cnt := COUNT(GROUP,h.amenities4_code <> (TYPEOF(h.amenities4_code))'');
    populated_amenities4_code_pcnt := AVE(GROUP,IF(h.amenities4_code = (TYPEOF(h.amenities4_code))'',0,100));
    maxlength_amenities4_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.amenities4_code)));
    avelength_amenities4_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.amenities4_code)),h.amenities4_code<>(typeof(h.amenities4_code))'');
    populated_amenities5_code_cnt := COUNT(GROUP,h.amenities5_code <> (TYPEOF(h.amenities5_code))'');
    populated_amenities5_code_pcnt := AVE(GROUP,IF(h.amenities5_code = (TYPEOF(h.amenities5_code))'',0,100));
    maxlength_amenities5_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.amenities5_code)));
    avelength_amenities5_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.amenities5_code)),h.amenities5_code<>(typeof(h.amenities5_code))'');
    populated_amenities2_code1_cnt := COUNT(GROUP,h.amenities2_code1 <> (TYPEOF(h.amenities2_code1))'');
    populated_amenities2_code1_pcnt := AVE(GROUP,IF(h.amenities2_code1 = (TYPEOF(h.amenities2_code1))'',0,100));
    maxlength_amenities2_code1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.amenities2_code1)));
    avelength_amenities2_code1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.amenities2_code1)),h.amenities2_code1<>(typeof(h.amenities2_code1))'');
    populated_amenities2_code2_cnt := COUNT(GROUP,h.amenities2_code2 <> (TYPEOF(h.amenities2_code2))'');
    populated_amenities2_code2_pcnt := AVE(GROUP,IF(h.amenities2_code2 = (TYPEOF(h.amenities2_code2))'',0,100));
    maxlength_amenities2_code2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.amenities2_code2)));
    avelength_amenities2_code2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.amenities2_code2)),h.amenities2_code2<>(typeof(h.amenities2_code2))'');
    populated_amenities2_code3_cnt := COUNT(GROUP,h.amenities2_code3 <> (TYPEOF(h.amenities2_code3))'');
    populated_amenities2_code3_pcnt := AVE(GROUP,IF(h.amenities2_code3 = (TYPEOF(h.amenities2_code3))'',0,100));
    maxlength_amenities2_code3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.amenities2_code3)));
    avelength_amenities2_code3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.amenities2_code3)),h.amenities2_code3<>(typeof(h.amenities2_code3))'');
    populated_amenities2_code4_cnt := COUNT(GROUP,h.amenities2_code4 <> (TYPEOF(h.amenities2_code4))'');
    populated_amenities2_code4_pcnt := AVE(GROUP,IF(h.amenities2_code4 = (TYPEOF(h.amenities2_code4))'',0,100));
    maxlength_amenities2_code4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.amenities2_code4)));
    avelength_amenities2_code4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.amenities2_code4)),h.amenities2_code4<>(typeof(h.amenities2_code4))'');
    populated_amenities2_code5_cnt := COUNT(GROUP,h.amenities2_code5 <> (TYPEOF(h.amenities2_code5))'');
    populated_amenities2_code5_pcnt := AVE(GROUP,IF(h.amenities2_code5 = (TYPEOF(h.amenities2_code5))'',0,100));
    maxlength_amenities2_code5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.amenities2_code5)));
    avelength_amenities2_code5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.amenities2_code5)),h.amenities2_code5<>(typeof(h.amenities2_code5))'');
    populated_extra_features1_area_cnt := COUNT(GROUP,h.extra_features1_area <> (TYPEOF(h.extra_features1_area))'');
    populated_extra_features1_area_pcnt := AVE(GROUP,IF(h.extra_features1_area = (TYPEOF(h.extra_features1_area))'',0,100));
    maxlength_extra_features1_area := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.extra_features1_area)));
    avelength_extra_features1_area := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.extra_features1_area)),h.extra_features1_area<>(typeof(h.extra_features1_area))'');
    populated_extra_features1_indicator_cnt := COUNT(GROUP,h.extra_features1_indicator <> (TYPEOF(h.extra_features1_indicator))'');
    populated_extra_features1_indicator_pcnt := AVE(GROUP,IF(h.extra_features1_indicator = (TYPEOF(h.extra_features1_indicator))'',0,100));
    maxlength_extra_features1_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.extra_features1_indicator)));
    avelength_extra_features1_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.extra_features1_indicator)),h.extra_features1_indicator<>(typeof(h.extra_features1_indicator))'');
    populated_extra_features2_area_cnt := COUNT(GROUP,h.extra_features2_area <> (TYPEOF(h.extra_features2_area))'');
    populated_extra_features2_area_pcnt := AVE(GROUP,IF(h.extra_features2_area = (TYPEOF(h.extra_features2_area))'',0,100));
    maxlength_extra_features2_area := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.extra_features2_area)));
    avelength_extra_features2_area := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.extra_features2_area)),h.extra_features2_area<>(typeof(h.extra_features2_area))'');
    populated_extra_features2_indicator_cnt := COUNT(GROUP,h.extra_features2_indicator <> (TYPEOF(h.extra_features2_indicator))'');
    populated_extra_features2_indicator_pcnt := AVE(GROUP,IF(h.extra_features2_indicator = (TYPEOF(h.extra_features2_indicator))'',0,100));
    maxlength_extra_features2_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.extra_features2_indicator)));
    avelength_extra_features2_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.extra_features2_indicator)),h.extra_features2_indicator<>(typeof(h.extra_features2_indicator))'');
    populated_extra_features3_area_cnt := COUNT(GROUP,h.extra_features3_area <> (TYPEOF(h.extra_features3_area))'');
    populated_extra_features3_area_pcnt := AVE(GROUP,IF(h.extra_features3_area = (TYPEOF(h.extra_features3_area))'',0,100));
    maxlength_extra_features3_area := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.extra_features3_area)));
    avelength_extra_features3_area := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.extra_features3_area)),h.extra_features3_area<>(typeof(h.extra_features3_area))'');
    populated_extra_features3_indicator_cnt := COUNT(GROUP,h.extra_features3_indicator <> (TYPEOF(h.extra_features3_indicator))'');
    populated_extra_features3_indicator_pcnt := AVE(GROUP,IF(h.extra_features3_indicator = (TYPEOF(h.extra_features3_indicator))'',0,100));
    maxlength_extra_features3_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.extra_features3_indicator)));
    avelength_extra_features3_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.extra_features3_indicator)),h.extra_features3_indicator<>(typeof(h.extra_features3_indicator))'');
    populated_extra_features4_area_cnt := COUNT(GROUP,h.extra_features4_area <> (TYPEOF(h.extra_features4_area))'');
    populated_extra_features4_area_pcnt := AVE(GROUP,IF(h.extra_features4_area = (TYPEOF(h.extra_features4_area))'',0,100));
    maxlength_extra_features4_area := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.extra_features4_area)));
    avelength_extra_features4_area := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.extra_features4_area)),h.extra_features4_area<>(typeof(h.extra_features4_area))'');
    populated_extra_features4_indicator_cnt := COUNT(GROUP,h.extra_features4_indicator <> (TYPEOF(h.extra_features4_indicator))'');
    populated_extra_features4_indicator_pcnt := AVE(GROUP,IF(h.extra_features4_indicator = (TYPEOF(h.extra_features4_indicator))'',0,100));
    maxlength_extra_features4_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.extra_features4_indicator)));
    avelength_extra_features4_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.extra_features4_indicator)),h.extra_features4_indicator<>(typeof(h.extra_features4_indicator))'');
    populated_other_buildings1_code_cnt := COUNT(GROUP,h.other_buildings1_code <> (TYPEOF(h.other_buildings1_code))'');
    populated_other_buildings1_code_pcnt := AVE(GROUP,IF(h.other_buildings1_code = (TYPEOF(h.other_buildings1_code))'',0,100));
    maxlength_other_buildings1_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_buildings1_code)));
    avelength_other_buildings1_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_buildings1_code)),h.other_buildings1_code<>(typeof(h.other_buildings1_code))'');
    populated_other_buildings2_code_cnt := COUNT(GROUP,h.other_buildings2_code <> (TYPEOF(h.other_buildings2_code))'');
    populated_other_buildings2_code_pcnt := AVE(GROUP,IF(h.other_buildings2_code = (TYPEOF(h.other_buildings2_code))'',0,100));
    maxlength_other_buildings2_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_buildings2_code)));
    avelength_other_buildings2_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_buildings2_code)),h.other_buildings2_code<>(typeof(h.other_buildings2_code))'');
    populated_other_buildings3_code_cnt := COUNT(GROUP,h.other_buildings3_code <> (TYPEOF(h.other_buildings3_code))'');
    populated_other_buildings3_code_pcnt := AVE(GROUP,IF(h.other_buildings3_code = (TYPEOF(h.other_buildings3_code))'',0,100));
    maxlength_other_buildings3_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_buildings3_code)));
    avelength_other_buildings3_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_buildings3_code)),h.other_buildings3_code<>(typeof(h.other_buildings3_code))'');
    populated_other_buildings4_code_cnt := COUNT(GROUP,h.other_buildings4_code <> (TYPEOF(h.other_buildings4_code))'');
    populated_other_buildings4_code_pcnt := AVE(GROUP,IF(h.other_buildings4_code = (TYPEOF(h.other_buildings4_code))'',0,100));
    maxlength_other_buildings4_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_buildings4_code)));
    avelength_other_buildings4_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_buildings4_code)),h.other_buildings4_code<>(typeof(h.other_buildings4_code))'');
    populated_other_buildings5_code_cnt := COUNT(GROUP,h.other_buildings5_code <> (TYPEOF(h.other_buildings5_code))'');
    populated_other_buildings5_code_pcnt := AVE(GROUP,IF(h.other_buildings5_code = (TYPEOF(h.other_buildings5_code))'',0,100));
    maxlength_other_buildings5_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_buildings5_code)));
    avelength_other_buildings5_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_buildings5_code)),h.other_buildings5_code<>(typeof(h.other_buildings5_code))'');
    populated_other_impr_building1_indicator_cnt := COUNT(GROUP,h.other_impr_building1_indicator <> (TYPEOF(h.other_impr_building1_indicator))'');
    populated_other_impr_building1_indicator_pcnt := AVE(GROUP,IF(h.other_impr_building1_indicator = (TYPEOF(h.other_impr_building1_indicator))'',0,100));
    maxlength_other_impr_building1_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_impr_building1_indicator)));
    avelength_other_impr_building1_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_impr_building1_indicator)),h.other_impr_building1_indicator<>(typeof(h.other_impr_building1_indicator))'');
    populated_other_impr_building2_indicator_cnt := COUNT(GROUP,h.other_impr_building2_indicator <> (TYPEOF(h.other_impr_building2_indicator))'');
    populated_other_impr_building2_indicator_pcnt := AVE(GROUP,IF(h.other_impr_building2_indicator = (TYPEOF(h.other_impr_building2_indicator))'',0,100));
    maxlength_other_impr_building2_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_impr_building2_indicator)));
    avelength_other_impr_building2_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_impr_building2_indicator)),h.other_impr_building2_indicator<>(typeof(h.other_impr_building2_indicator))'');
    populated_other_impr_building3_indicator_cnt := COUNT(GROUP,h.other_impr_building3_indicator <> (TYPEOF(h.other_impr_building3_indicator))'');
    populated_other_impr_building3_indicator_pcnt := AVE(GROUP,IF(h.other_impr_building3_indicator = (TYPEOF(h.other_impr_building3_indicator))'',0,100));
    maxlength_other_impr_building3_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_impr_building3_indicator)));
    avelength_other_impr_building3_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_impr_building3_indicator)),h.other_impr_building3_indicator<>(typeof(h.other_impr_building3_indicator))'');
    populated_other_impr_building4_indicator_cnt := COUNT(GROUP,h.other_impr_building4_indicator <> (TYPEOF(h.other_impr_building4_indicator))'');
    populated_other_impr_building4_indicator_pcnt := AVE(GROUP,IF(h.other_impr_building4_indicator = (TYPEOF(h.other_impr_building4_indicator))'',0,100));
    maxlength_other_impr_building4_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_impr_building4_indicator)));
    avelength_other_impr_building4_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_impr_building4_indicator)),h.other_impr_building4_indicator<>(typeof(h.other_impr_building4_indicator))'');
    populated_other_impr_building5_indicator_cnt := COUNT(GROUP,h.other_impr_building5_indicator <> (TYPEOF(h.other_impr_building5_indicator))'');
    populated_other_impr_building5_indicator_pcnt := AVE(GROUP,IF(h.other_impr_building5_indicator = (TYPEOF(h.other_impr_building5_indicator))'',0,100));
    maxlength_other_impr_building5_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_impr_building5_indicator)));
    avelength_other_impr_building5_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_impr_building5_indicator)),h.other_impr_building5_indicator<>(typeof(h.other_impr_building5_indicator))'');
    populated_other_impr_building_area1_cnt := COUNT(GROUP,h.other_impr_building_area1 <> (TYPEOF(h.other_impr_building_area1))'');
    populated_other_impr_building_area1_pcnt := AVE(GROUP,IF(h.other_impr_building_area1 = (TYPEOF(h.other_impr_building_area1))'',0,100));
    maxlength_other_impr_building_area1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_impr_building_area1)));
    avelength_other_impr_building_area1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_impr_building_area1)),h.other_impr_building_area1<>(typeof(h.other_impr_building_area1))'');
    populated_other_impr_building_area2_cnt := COUNT(GROUP,h.other_impr_building_area2 <> (TYPEOF(h.other_impr_building_area2))'');
    populated_other_impr_building_area2_pcnt := AVE(GROUP,IF(h.other_impr_building_area2 = (TYPEOF(h.other_impr_building_area2))'',0,100));
    maxlength_other_impr_building_area2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_impr_building_area2)));
    avelength_other_impr_building_area2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_impr_building_area2)),h.other_impr_building_area2<>(typeof(h.other_impr_building_area2))'');
    populated_other_impr_building_area3_cnt := COUNT(GROUP,h.other_impr_building_area3 <> (TYPEOF(h.other_impr_building_area3))'');
    populated_other_impr_building_area3_pcnt := AVE(GROUP,IF(h.other_impr_building_area3 = (TYPEOF(h.other_impr_building_area3))'',0,100));
    maxlength_other_impr_building_area3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_impr_building_area3)));
    avelength_other_impr_building_area3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_impr_building_area3)),h.other_impr_building_area3<>(typeof(h.other_impr_building_area3))'');
    populated_other_impr_building_area4_cnt := COUNT(GROUP,h.other_impr_building_area4 <> (TYPEOF(h.other_impr_building_area4))'');
    populated_other_impr_building_area4_pcnt := AVE(GROUP,IF(h.other_impr_building_area4 = (TYPEOF(h.other_impr_building_area4))'',0,100));
    maxlength_other_impr_building_area4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_impr_building_area4)));
    avelength_other_impr_building_area4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_impr_building_area4)),h.other_impr_building_area4<>(typeof(h.other_impr_building_area4))'');
    populated_other_impr_building_area5_cnt := COUNT(GROUP,h.other_impr_building_area5 <> (TYPEOF(h.other_impr_building_area5))'');
    populated_other_impr_building_area5_pcnt := AVE(GROUP,IF(h.other_impr_building_area5 = (TYPEOF(h.other_impr_building_area5))'',0,100));
    maxlength_other_impr_building_area5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_impr_building_area5)));
    avelength_other_impr_building_area5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_impr_building_area5)),h.other_impr_building_area5<>(typeof(h.other_impr_building_area5))'');
    populated_topograpy_code_cnt := COUNT(GROUP,h.topograpy_code <> (TYPEOF(h.topograpy_code))'');
    populated_topograpy_code_pcnt := AVE(GROUP,IF(h.topograpy_code = (TYPEOF(h.topograpy_code))'',0,100));
    maxlength_topograpy_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.topograpy_code)));
    avelength_topograpy_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.topograpy_code)),h.topograpy_code<>(typeof(h.topograpy_code))'');
    populated_neighborhood_code_cnt := COUNT(GROUP,h.neighborhood_code <> (TYPEOF(h.neighborhood_code))'');
    populated_neighborhood_code_pcnt := AVE(GROUP,IF(h.neighborhood_code = (TYPEOF(h.neighborhood_code))'',0,100));
    maxlength_neighborhood_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.neighborhood_code)));
    avelength_neighborhood_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.neighborhood_code)),h.neighborhood_code<>(typeof(h.neighborhood_code))'');
    populated_condo_project_or_building_name_cnt := COUNT(GROUP,h.condo_project_or_building_name <> (TYPEOF(h.condo_project_or_building_name))'');
    populated_condo_project_or_building_name_pcnt := AVE(GROUP,IF(h.condo_project_or_building_name = (TYPEOF(h.condo_project_or_building_name))'',0,100));
    maxlength_condo_project_or_building_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.condo_project_or_building_name)));
    avelength_condo_project_or_building_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.condo_project_or_building_name)),h.condo_project_or_building_name<>(typeof(h.condo_project_or_building_name))'');
    populated_assessee_name_indicator_cnt := COUNT(GROUP,h.assessee_name_indicator <> (TYPEOF(h.assessee_name_indicator))'');
    populated_assessee_name_indicator_pcnt := AVE(GROUP,IF(h.assessee_name_indicator = (TYPEOF(h.assessee_name_indicator))'',0,100));
    maxlength_assessee_name_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessee_name_indicator)));
    avelength_assessee_name_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessee_name_indicator)),h.assessee_name_indicator<>(typeof(h.assessee_name_indicator))'');
    populated_second_assessee_name_indicator_cnt := COUNT(GROUP,h.second_assessee_name_indicator <> (TYPEOF(h.second_assessee_name_indicator))'');
    populated_second_assessee_name_indicator_pcnt := AVE(GROUP,IF(h.second_assessee_name_indicator = (TYPEOF(h.second_assessee_name_indicator))'',0,100));
    maxlength_second_assessee_name_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.second_assessee_name_indicator)));
    avelength_second_assessee_name_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.second_assessee_name_indicator)),h.second_assessee_name_indicator<>(typeof(h.second_assessee_name_indicator))'');
    populated_other_rooms_indicator_cnt := COUNT(GROUP,h.other_rooms_indicator <> (TYPEOF(h.other_rooms_indicator))'');
    populated_other_rooms_indicator_pcnt := AVE(GROUP,IF(h.other_rooms_indicator = (TYPEOF(h.other_rooms_indicator))'',0,100));
    maxlength_other_rooms_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_rooms_indicator)));
    avelength_other_rooms_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_rooms_indicator)),h.other_rooms_indicator<>(typeof(h.other_rooms_indicator))'');
    populated_mail_care_of_name_indicator_cnt := COUNT(GROUP,h.mail_care_of_name_indicator <> (TYPEOF(h.mail_care_of_name_indicator))'');
    populated_mail_care_of_name_indicator_pcnt := AVE(GROUP,IF(h.mail_care_of_name_indicator = (TYPEOF(h.mail_care_of_name_indicator))'',0,100));
    maxlength_mail_care_of_name_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_care_of_name_indicator)));
    avelength_mail_care_of_name_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_care_of_name_indicator)),h.mail_care_of_name_indicator<>(typeof(h.mail_care_of_name_indicator))'');
    populated_comments_cnt := COUNT(GROUP,h.comments <> (TYPEOF(h.comments))'');
    populated_comments_pcnt := AVE(GROUP,IF(h.comments = (TYPEOF(h.comments))'',0,100));
    maxlength_comments := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.comments)));
    avelength_comments := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.comments)),h.comments<>(typeof(h.comments))'');
    populated_tape_cut_date_cnt := COUNT(GROUP,h.tape_cut_date <> (TYPEOF(h.tape_cut_date))'');
    populated_tape_cut_date_pcnt := AVE(GROUP,IF(h.tape_cut_date = (TYPEOF(h.tape_cut_date))'',0,100));
    maxlength_tape_cut_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tape_cut_date)));
    avelength_tape_cut_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tape_cut_date)),h.tape_cut_date<>(typeof(h.tape_cut_date))'');
    populated_certification_date_cnt := COUNT(GROUP,h.certification_date <> (TYPEOF(h.certification_date))'');
    populated_certification_date_pcnt := AVE(GROUP,IF(h.certification_date = (TYPEOF(h.certification_date))'',0,100));
    maxlength_certification_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certification_date)));
    avelength_certification_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certification_date)),h.certification_date<>(typeof(h.certification_date))'');
    populated_edition_number_cnt := COUNT(GROUP,h.edition_number <> (TYPEOF(h.edition_number))'');
    populated_edition_number_pcnt := AVE(GROUP,IF(h.edition_number = (TYPEOF(h.edition_number))'',0,100));
    maxlength_edition_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.edition_number)));
    avelength_edition_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.edition_number)),h.edition_number<>(typeof(h.edition_number))'');
    populated_prop_addr_propagated_ind_cnt := COUNT(GROUP,h.prop_addr_propagated_ind <> (TYPEOF(h.prop_addr_propagated_ind))'');
    populated_prop_addr_propagated_ind_pcnt := AVE(GROUP,IF(h.prop_addr_propagated_ind = (TYPEOF(h.prop_addr_propagated_ind))'',0,100));
    maxlength_prop_addr_propagated_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_propagated_ind)));
    avelength_prop_addr_propagated_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_propagated_ind)),h.prop_addr_propagated_ind<>(typeof(h.prop_addr_propagated_ind))'');
    populated_ln_ownership_rights_cnt := COUNT(GROUP,h.ln_ownership_rights <> (TYPEOF(h.ln_ownership_rights))'');
    populated_ln_ownership_rights_pcnt := AVE(GROUP,IF(h.ln_ownership_rights = (TYPEOF(h.ln_ownership_rights))'',0,100));
    maxlength_ln_ownership_rights := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_ownership_rights)));
    avelength_ln_ownership_rights := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_ownership_rights)),h.ln_ownership_rights<>(typeof(h.ln_ownership_rights))'');
    populated_ln_relationship_type_cnt := COUNT(GROUP,h.ln_relationship_type <> (TYPEOF(h.ln_relationship_type))'');
    populated_ln_relationship_type_pcnt := AVE(GROUP,IF(h.ln_relationship_type = (TYPEOF(h.ln_relationship_type))'',0,100));
    maxlength_ln_relationship_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_relationship_type)));
    avelength_ln_relationship_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_relationship_type)),h.ln_relationship_type<>(typeof(h.ln_relationship_type))'');
    populated_ln_mailing_country_code_cnt := COUNT(GROUP,h.ln_mailing_country_code <> (TYPEOF(h.ln_mailing_country_code))'');
    populated_ln_mailing_country_code_pcnt := AVE(GROUP,IF(h.ln_mailing_country_code = (TYPEOF(h.ln_mailing_country_code))'',0,100));
    maxlength_ln_mailing_country_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_mailing_country_code)));
    avelength_ln_mailing_country_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_mailing_country_code)),h.ln_mailing_country_code<>(typeof(h.ln_mailing_country_code))'');
    populated_ln_property_name_cnt := COUNT(GROUP,h.ln_property_name <> (TYPEOF(h.ln_property_name))'');
    populated_ln_property_name_pcnt := AVE(GROUP,IF(h.ln_property_name = (TYPEOF(h.ln_property_name))'',0,100));
    maxlength_ln_property_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_property_name)));
    avelength_ln_property_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_property_name)),h.ln_property_name<>(typeof(h.ln_property_name))'');
    populated_ln_property_name_type_cnt := COUNT(GROUP,h.ln_property_name_type <> (TYPEOF(h.ln_property_name_type))'');
    populated_ln_property_name_type_pcnt := AVE(GROUP,IF(h.ln_property_name_type = (TYPEOF(h.ln_property_name_type))'',0,100));
    maxlength_ln_property_name_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_property_name_type)));
    avelength_ln_property_name_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_property_name_type)),h.ln_property_name_type<>(typeof(h.ln_property_name_type))'');
    populated_ln_land_use_category_cnt := COUNT(GROUP,h.ln_land_use_category <> (TYPEOF(h.ln_land_use_category))'');
    populated_ln_land_use_category_pcnt := AVE(GROUP,IF(h.ln_land_use_category = (TYPEOF(h.ln_land_use_category))'',0,100));
    maxlength_ln_land_use_category := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_land_use_category)));
    avelength_ln_land_use_category := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_land_use_category)),h.ln_land_use_category<>(typeof(h.ln_land_use_category))'');
    populated_ln_lot_cnt := COUNT(GROUP,h.ln_lot <> (TYPEOF(h.ln_lot))'');
    populated_ln_lot_pcnt := AVE(GROUP,IF(h.ln_lot = (TYPEOF(h.ln_lot))'',0,100));
    maxlength_ln_lot := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_lot)));
    avelength_ln_lot := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_lot)),h.ln_lot<>(typeof(h.ln_lot))'');
    populated_ln_block_cnt := COUNT(GROUP,h.ln_block <> (TYPEOF(h.ln_block))'');
    populated_ln_block_pcnt := AVE(GROUP,IF(h.ln_block = (TYPEOF(h.ln_block))'',0,100));
    maxlength_ln_block := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_block)));
    avelength_ln_block := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_block)),h.ln_block<>(typeof(h.ln_block))'');
    populated_ln_unit_cnt := COUNT(GROUP,h.ln_unit <> (TYPEOF(h.ln_unit))'');
    populated_ln_unit_pcnt := AVE(GROUP,IF(h.ln_unit = (TYPEOF(h.ln_unit))'',0,100));
    maxlength_ln_unit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_unit)));
    avelength_ln_unit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_unit)),h.ln_unit<>(typeof(h.ln_unit))'');
    populated_ln_subfloor_cnt := COUNT(GROUP,h.ln_subfloor <> (TYPEOF(h.ln_subfloor))'');
    populated_ln_subfloor_pcnt := AVE(GROUP,IF(h.ln_subfloor = (TYPEOF(h.ln_subfloor))'',0,100));
    maxlength_ln_subfloor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_subfloor)));
    avelength_ln_subfloor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_subfloor)),h.ln_subfloor<>(typeof(h.ln_subfloor))'');
    populated_ln_floor_cover_cnt := COUNT(GROUP,h.ln_floor_cover <> (TYPEOF(h.ln_floor_cover))'');
    populated_ln_floor_cover_pcnt := AVE(GROUP,IF(h.ln_floor_cover = (TYPEOF(h.ln_floor_cover))'',0,100));
    maxlength_ln_floor_cover := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_floor_cover)));
    avelength_ln_floor_cover := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_floor_cover)),h.ln_floor_cover<>(typeof(h.ln_floor_cover))'');
    populated_ln_mobile_home_indicator_cnt := COUNT(GROUP,h.ln_mobile_home_indicator <> (TYPEOF(h.ln_mobile_home_indicator))'');
    populated_ln_mobile_home_indicator_pcnt := AVE(GROUP,IF(h.ln_mobile_home_indicator = (TYPEOF(h.ln_mobile_home_indicator))'',0,100));
    maxlength_ln_mobile_home_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_mobile_home_indicator)));
    avelength_ln_mobile_home_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_mobile_home_indicator)),h.ln_mobile_home_indicator<>(typeof(h.ln_mobile_home_indicator))'');
    populated_ln_condo_indicator_cnt := COUNT(GROUP,h.ln_condo_indicator <> (TYPEOF(h.ln_condo_indicator))'');
    populated_ln_condo_indicator_pcnt := AVE(GROUP,IF(h.ln_condo_indicator = (TYPEOF(h.ln_condo_indicator))'',0,100));
    maxlength_ln_condo_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_condo_indicator)));
    avelength_ln_condo_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_condo_indicator)),h.ln_condo_indicator<>(typeof(h.ln_condo_indicator))'');
    populated_ln_property_tax_exemption_cnt := COUNT(GROUP,h.ln_property_tax_exemption <> (TYPEOF(h.ln_property_tax_exemption))'');
    populated_ln_property_tax_exemption_pcnt := AVE(GROUP,IF(h.ln_property_tax_exemption = (TYPEOF(h.ln_property_tax_exemption))'',0,100));
    maxlength_ln_property_tax_exemption := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_property_tax_exemption)));
    avelength_ln_property_tax_exemption := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_property_tax_exemption)),h.ln_property_tax_exemption<>(typeof(h.ln_property_tax_exemption))'');
    populated_ln_veteran_status_cnt := COUNT(GROUP,h.ln_veteran_status <> (TYPEOF(h.ln_veteran_status))'');
    populated_ln_veteran_status_pcnt := AVE(GROUP,IF(h.ln_veteran_status = (TYPEOF(h.ln_veteran_status))'',0,100));
    maxlength_ln_veteran_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_veteran_status)));
    avelength_ln_veteran_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_veteran_status)),h.ln_veteran_status<>(typeof(h.ln_veteran_status))'');
    populated_ln_old_apn_indicator_cnt := COUNT(GROUP,h.ln_old_apn_indicator <> (TYPEOF(h.ln_old_apn_indicator))'');
    populated_ln_old_apn_indicator_pcnt := AVE(GROUP,IF(h.ln_old_apn_indicator = (TYPEOF(h.ln_old_apn_indicator))'',0,100));
    maxlength_ln_old_apn_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_old_apn_indicator)));
    avelength_ln_old_apn_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_old_apn_indicator)),h.ln_old_apn_indicator<>(typeof(h.ln_old_apn_indicator))'');
    populated_fips_cnt := COUNT(GROUP,h.fips <> (TYPEOF(h.fips))'');
    populated_fips_pcnt := AVE(GROUP,IF(h.fips = (TYPEOF(h.fips))'',0,100));
    maxlength_fips := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips)));
    avelength_fips := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips)),h.fips<>(typeof(h.fips))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,fips_code,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_ln_fares_id_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_vendor_source_flag_pcnt *   0.00 / 100 + T.Populated_current_record_pcnt *   0.00 / 100 + T.Populated_fips_code_pcnt *   0.00 / 100 + T.Populated_state_code_pcnt *   0.00 / 100 + T.Populated_county_name_pcnt *   0.00 / 100 + T.Populated_old_apn_pcnt *   0.00 / 100 + T.Populated_apna_or_pin_number_pcnt *   0.00 / 100 + T.Populated_fares_unformatted_apn_pcnt *   0.00 / 100 + T.Populated_duplicate_apn_multiple_address_id_pcnt *   0.00 / 100 + T.Populated_assessee_name_pcnt *   0.00 / 100 + T.Populated_second_assessee_name_pcnt *   0.00 / 100 + T.Populated_assessee_ownership_rights_code_pcnt *   0.00 / 100 + T.Populated_assessee_relationship_code_pcnt *   0.00 / 100 + T.Populated_assessee_phone_number_pcnt *   0.00 / 100 + T.Populated_tax_account_number_pcnt *   0.00 / 100 + T.Populated_contract_owner_pcnt *   0.00 / 100 + T.Populated_assessee_name_type_code_pcnt *   0.00 / 100 + T.Populated_second_assessee_name_type_code_pcnt *   0.00 / 100 + T.Populated_mail_care_of_name_type_code_pcnt *   0.00 / 100 + T.Populated_mailing_care_of_name_pcnt *   0.00 / 100 + T.Populated_mailing_full_street_address_pcnt *   0.00 / 100 + T.Populated_mailing_unit_number_pcnt *   0.00 / 100 + T.Populated_mailing_city_state_zip_pcnt *   0.00 / 100 + T.Populated_property_full_street_address_pcnt *   0.00 / 100 + T.Populated_property_unit_number_pcnt *   0.00 / 100 + T.Populated_property_city_state_zip_pcnt *   0.00 / 100 + T.Populated_property_country_code_pcnt *   0.00 / 100 + T.Populated_property_address_code_pcnt *   0.00 / 100 + T.Populated_legal_lot_code_pcnt *   0.00 / 100 + T.Populated_legal_lot_number_pcnt *   0.00 / 100 + T.Populated_legal_land_lot_pcnt *   0.00 / 100 + T.Populated_legal_block_pcnt *   0.00 / 100 + T.Populated_legal_section_pcnt *   0.00 / 100 + T.Populated_legal_district_pcnt *   0.00 / 100 + T.Populated_legal_unit_pcnt *   0.00 / 100 + T.Populated_legal_city_municipality_township_pcnt *   0.00 / 100 + T.Populated_legal_subdivision_name_pcnt *   0.00 / 100 + T.Populated_legal_phase_number_pcnt *   0.00 / 100 + T.Populated_legal_tract_number_pcnt *   0.00 / 100 + T.Populated_legal_sec_twn_rng_mer_pcnt *   0.00 / 100 + T.Populated_legal_brief_description_pcnt *   0.00 / 100 + T.Populated_legal_assessor_map_ref_pcnt *   0.00 / 100 + T.Populated_census_tract_pcnt *   0.00 / 100 + T.Populated_record_type_code_pcnt *   0.00 / 100 + T.Populated_ownership_type_code_pcnt *   0.00 / 100 + T.Populated_new_record_type_code_pcnt *   0.00 / 100 + T.Populated_state_land_use_code_pcnt *   0.00 / 100 + T.Populated_county_land_use_code_pcnt *   0.00 / 100 + T.Populated_county_land_use_description_pcnt *   0.00 / 100 + T.Populated_standardized_land_use_code_pcnt *   0.00 / 100 + T.Populated_timeshare_code_pcnt *   0.00 / 100 + T.Populated_zoning_pcnt *   0.00 / 100 + T.Populated_owner_occupied_pcnt *   0.00 / 100 + T.Populated_recorder_document_number_pcnt *   0.00 / 100 + T.Populated_recorder_book_number_pcnt *   0.00 / 100 + T.Populated_recorder_page_number_pcnt *   0.00 / 100 + T.Populated_transfer_date_pcnt *   0.00 / 100 + T.Populated_recording_date_pcnt *   0.00 / 100 + T.Populated_sale_date_pcnt *   0.00 / 100 + T.Populated_document_type_pcnt *   0.00 / 100 + T.Populated_sales_price_pcnt *   0.00 / 100 + T.Populated_sales_price_code_pcnt *   0.00 / 100 + T.Populated_mortgage_loan_amount_pcnt *   0.00 / 100 + T.Populated_mortgage_loan_type_code_pcnt *   0.00 / 100 + T.Populated_mortgage_lender_name_pcnt *   0.00 / 100 + T.Populated_mortgage_lender_type_code_pcnt *   0.00 / 100 + T.Populated_prior_transfer_date_pcnt *   0.00 / 100 + T.Populated_prior_recording_date_pcnt *   0.00 / 100 + T.Populated_prior_sales_price_pcnt *   0.00 / 100 + T.Populated_prior_sales_price_code_pcnt *   0.00 / 100 + T.Populated_assessed_land_value_pcnt *   0.00 / 100 + T.Populated_assessed_improvement_value_pcnt *   0.00 / 100 + T.Populated_assessed_total_value_pcnt *   0.00 / 100 + T.Populated_assessed_value_year_pcnt *   0.00 / 100 + T.Populated_market_land_value_pcnt *   0.00 / 100 + T.Populated_market_improvement_value_pcnt *   0.00 / 100 + T.Populated_market_total_value_pcnt *   0.00 / 100 + T.Populated_market_value_year_pcnt *   0.00 / 100 + T.Populated_homestead_homeowner_exemption_pcnt *   0.00 / 100 + T.Populated_tax_exemption1_code_pcnt *   0.00 / 100 + T.Populated_tax_exemption2_code_pcnt *   0.00 / 100 + T.Populated_tax_exemption3_code_pcnt *   0.00 / 100 + T.Populated_tax_exemption4_code_pcnt *   0.00 / 100 + T.Populated_tax_rate_code_area_pcnt *   0.00 / 100 + T.Populated_tax_amount_pcnt *   0.00 / 100 + T.Populated_tax_year_pcnt *   0.00 / 100 + T.Populated_tax_delinquent_year_pcnt *   0.00 / 100 + T.Populated_school_tax_district1_pcnt *   0.00 / 100 + T.Populated_school_tax_district1_indicator_pcnt *   0.00 / 100 + T.Populated_school_tax_district2_pcnt *   0.00 / 100 + T.Populated_school_tax_district2_indicator_pcnt *   0.00 / 100 + T.Populated_school_tax_district3_pcnt *   0.00 / 100 + T.Populated_school_tax_district3_indicator_pcnt *   0.00 / 100 + T.Populated_lot_size_pcnt *   0.00 / 100 + T.Populated_lot_size_acres_pcnt *   0.00 / 100 + T.Populated_lot_size_frontage_feet_pcnt *   0.00 / 100 + T.Populated_lot_size_depth_feet_pcnt *   0.00 / 100 + T.Populated_land_acres_pcnt *   0.00 / 100 + T.Populated_land_square_footage_pcnt *   0.00 / 100 + T.Populated_land_dimensions_pcnt *   0.00 / 100 + T.Populated_building_area_pcnt *   0.00 / 100 + T.Populated_building_area_indicator_pcnt *   0.00 / 100 + T.Populated_building_area1_pcnt *   0.00 / 100 + T.Populated_building_area1_indicator_pcnt *   0.00 / 100 + T.Populated_building_area2_pcnt *   0.00 / 100 + T.Populated_building_area2_indicator_pcnt *   0.00 / 100 + T.Populated_building_area3_pcnt *   0.00 / 100 + T.Populated_building_area3_indicator_pcnt *   0.00 / 100 + T.Populated_building_area4_pcnt *   0.00 / 100 + T.Populated_building_area4_indicator_pcnt *   0.00 / 100 + T.Populated_building_area5_pcnt *   0.00 / 100 + T.Populated_building_area5_indicator_pcnt *   0.00 / 100 + T.Populated_building_area6_pcnt *   0.00 / 100 + T.Populated_building_area6_indicator_pcnt *   0.00 / 100 + T.Populated_building_area7_pcnt *   0.00 / 100 + T.Populated_building_area7_indicator_pcnt *   0.00 / 100 + T.Populated_year_built_pcnt *   0.00 / 100 + T.Populated_effective_year_built_pcnt *   0.00 / 100 + T.Populated_no_of_buildings_pcnt *   0.00 / 100 + T.Populated_no_of_stories_pcnt *   0.00 / 100 + T.Populated_no_of_units_pcnt *   0.00 / 100 + T.Populated_no_of_rooms_pcnt *   0.00 / 100 + T.Populated_no_of_bedrooms_pcnt *   0.00 / 100 + T.Populated_no_of_baths_pcnt *   0.00 / 100 + T.Populated_no_of_partial_baths_pcnt *   0.00 / 100 + T.Populated_no_of_plumbing_fixtures_pcnt *   0.00 / 100 + T.Populated_garage_type_code_pcnt *   0.00 / 100 + T.Populated_parking_no_of_cars_pcnt *   0.00 / 100 + T.Populated_pool_code_pcnt *   0.00 / 100 + T.Populated_style_code_pcnt *   0.00 / 100 + T.Populated_type_construction_code_pcnt *   0.00 / 100 + T.Populated_foundation_code_pcnt *   0.00 / 100 + T.Populated_building_quality_code_pcnt *   0.00 / 100 + T.Populated_building_condition_code_pcnt *   0.00 / 100 + T.Populated_exterior_walls_code_pcnt *   0.00 / 100 + T.Populated_interior_walls_code_pcnt *   0.00 / 100 + T.Populated_roof_cover_code_pcnt *   0.00 / 100 + T.Populated_roof_type_code_pcnt *   0.00 / 100 + T.Populated_floor_cover_code_pcnt *   0.00 / 100 + T.Populated_water_code_pcnt *   0.00 / 100 + T.Populated_sewer_code_pcnt *   0.00 / 100 + T.Populated_heating_code_pcnt *   0.00 / 100 + T.Populated_heating_fuel_type_code_pcnt *   0.00 / 100 + T.Populated_air_conditioning_code_pcnt *   0.00 / 100 + T.Populated_air_conditioning_type_code_pcnt *   0.00 / 100 + T.Populated_elevator_pcnt *   0.00 / 100 + T.Populated_fireplace_indicator_pcnt *   0.00 / 100 + T.Populated_fireplace_number_pcnt *   0.00 / 100 + T.Populated_basement_code_pcnt *   0.00 / 100 + T.Populated_building_class_code_pcnt *   0.00 / 100 + T.Populated_site_influence1_code_pcnt *   0.00 / 100 + T.Populated_site_influence2_code_pcnt *   0.00 / 100 + T.Populated_site_influence3_code_pcnt *   0.00 / 100 + T.Populated_site_influence4_code_pcnt *   0.00 / 100 + T.Populated_site_influence5_code_pcnt *   0.00 / 100 + T.Populated_amenities1_code_pcnt *   0.00 / 100 + T.Populated_amenities2_code_pcnt *   0.00 / 100 + T.Populated_amenities3_code_pcnt *   0.00 / 100 + T.Populated_amenities4_code_pcnt *   0.00 / 100 + T.Populated_amenities5_code_pcnt *   0.00 / 100 + T.Populated_amenities2_code1_pcnt *   0.00 / 100 + T.Populated_amenities2_code2_pcnt *   0.00 / 100 + T.Populated_amenities2_code3_pcnt *   0.00 / 100 + T.Populated_amenities2_code4_pcnt *   0.00 / 100 + T.Populated_amenities2_code5_pcnt *   0.00 / 100 + T.Populated_extra_features1_area_pcnt *   0.00 / 100 + T.Populated_extra_features1_indicator_pcnt *   0.00 / 100 + T.Populated_extra_features2_area_pcnt *   0.00 / 100 + T.Populated_extra_features2_indicator_pcnt *   0.00 / 100 + T.Populated_extra_features3_area_pcnt *   0.00 / 100 + T.Populated_extra_features3_indicator_pcnt *   0.00 / 100 + T.Populated_extra_features4_area_pcnt *   0.00 / 100 + T.Populated_extra_features4_indicator_pcnt *   0.00 / 100 + T.Populated_other_buildings1_code_pcnt *   0.00 / 100 + T.Populated_other_buildings2_code_pcnt *   0.00 / 100 + T.Populated_other_buildings3_code_pcnt *   0.00 / 100 + T.Populated_other_buildings4_code_pcnt *   0.00 / 100 + T.Populated_other_buildings5_code_pcnt *   0.00 / 100 + T.Populated_other_impr_building1_indicator_pcnt *   0.00 / 100 + T.Populated_other_impr_building2_indicator_pcnt *   0.00 / 100 + T.Populated_other_impr_building3_indicator_pcnt *   0.00 / 100 + T.Populated_other_impr_building4_indicator_pcnt *   0.00 / 100 + T.Populated_other_impr_building5_indicator_pcnt *   0.00 / 100 + T.Populated_other_impr_building_area1_pcnt *   0.00 / 100 + T.Populated_other_impr_building_area2_pcnt *   0.00 / 100 + T.Populated_other_impr_building_area3_pcnt *   0.00 / 100 + T.Populated_other_impr_building_area4_pcnt *   0.00 / 100 + T.Populated_other_impr_building_area5_pcnt *   0.00 / 100 + T.Populated_topograpy_code_pcnt *   0.00 / 100 + T.Populated_neighborhood_code_pcnt *   0.00 / 100 + T.Populated_condo_project_or_building_name_pcnt *   0.00 / 100 + T.Populated_assessee_name_indicator_pcnt *   0.00 / 100 + T.Populated_second_assessee_name_indicator_pcnt *   0.00 / 100 + T.Populated_other_rooms_indicator_pcnt *   0.00 / 100 + T.Populated_mail_care_of_name_indicator_pcnt *   0.00 / 100 + T.Populated_comments_pcnt *   0.00 / 100 + T.Populated_tape_cut_date_pcnt *   0.00 / 100 + T.Populated_certification_date_pcnt *   0.00 / 100 + T.Populated_edition_number_pcnt *   0.00 / 100 + T.Populated_prop_addr_propagated_ind_pcnt *   0.00 / 100 + T.Populated_ln_ownership_rights_pcnt *   0.00 / 100 + T.Populated_ln_relationship_type_pcnt *   0.00 / 100 + T.Populated_ln_mailing_country_code_pcnt *   0.00 / 100 + T.Populated_ln_property_name_pcnt *   0.00 / 100 + T.Populated_ln_property_name_type_pcnt *   0.00 / 100 + T.Populated_ln_land_use_category_pcnt *   0.00 / 100 + T.Populated_ln_lot_pcnt *   0.00 / 100 + T.Populated_ln_block_pcnt *   0.00 / 100 + T.Populated_ln_unit_pcnt *   0.00 / 100 + T.Populated_ln_subfloor_pcnt *   0.00 / 100 + T.Populated_ln_floor_cover_pcnt *   0.00 / 100 + T.Populated_ln_mobile_home_indicator_pcnt *   0.00 / 100 + T.Populated_ln_condo_indicator_pcnt *   0.00 / 100 + T.Populated_ln_property_tax_exemption_pcnt *   0.00 / 100 + T.Populated_ln_veteran_status_pcnt *   0.00 / 100 + T.Populated_ln_old_apn_indicator_pcnt *   0.00 / 100 + T.Populated_fips_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);
  R := RECORD
    STRING fips_code1;
    STRING fips_code2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.fips_code1 := le.Source;
    SELF.fips_code2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_ln_fares_id_pcnt*ri.Populated_ln_fares_id_pcnt *   0.00 / 10000 + le.Populated_process_date_pcnt*ri.Populated_process_date_pcnt *   0.00 / 10000 + le.Populated_vendor_source_flag_pcnt*ri.Populated_vendor_source_flag_pcnt *   0.00 / 10000 + le.Populated_current_record_pcnt*ri.Populated_current_record_pcnt *   0.00 / 10000 + le.Populated_fips_code_pcnt*ri.Populated_fips_code_pcnt *   0.00 / 10000 + le.Populated_state_code_pcnt*ri.Populated_state_code_pcnt *   0.00 / 10000 + le.Populated_county_name_pcnt*ri.Populated_county_name_pcnt *   0.00 / 10000 + le.Populated_old_apn_pcnt*ri.Populated_old_apn_pcnt *   0.00 / 10000 + le.Populated_apna_or_pin_number_pcnt*ri.Populated_apna_or_pin_number_pcnt *   0.00 / 10000 + le.Populated_fares_unformatted_apn_pcnt*ri.Populated_fares_unformatted_apn_pcnt *   0.00 / 10000 + le.Populated_duplicate_apn_multiple_address_id_pcnt*ri.Populated_duplicate_apn_multiple_address_id_pcnt *   0.00 / 10000 + le.Populated_assessee_name_pcnt*ri.Populated_assessee_name_pcnt *   0.00 / 10000 + le.Populated_second_assessee_name_pcnt*ri.Populated_second_assessee_name_pcnt *   0.00 / 10000 + le.Populated_assessee_ownership_rights_code_pcnt*ri.Populated_assessee_ownership_rights_code_pcnt *   0.00 / 10000 + le.Populated_assessee_relationship_code_pcnt*ri.Populated_assessee_relationship_code_pcnt *   0.00 / 10000 + le.Populated_assessee_phone_number_pcnt*ri.Populated_assessee_phone_number_pcnt *   0.00 / 10000 + le.Populated_tax_account_number_pcnt*ri.Populated_tax_account_number_pcnt *   0.00 / 10000 + le.Populated_contract_owner_pcnt*ri.Populated_contract_owner_pcnt *   0.00 / 10000 + le.Populated_assessee_name_type_code_pcnt*ri.Populated_assessee_name_type_code_pcnt *   0.00 / 10000 + le.Populated_second_assessee_name_type_code_pcnt*ri.Populated_second_assessee_name_type_code_pcnt *   0.00 / 10000 + le.Populated_mail_care_of_name_type_code_pcnt*ri.Populated_mail_care_of_name_type_code_pcnt *   0.00 / 10000 + le.Populated_mailing_care_of_name_pcnt*ri.Populated_mailing_care_of_name_pcnt *   0.00 / 10000 + le.Populated_mailing_full_street_address_pcnt*ri.Populated_mailing_full_street_address_pcnt *   0.00 / 10000 + le.Populated_mailing_unit_number_pcnt*ri.Populated_mailing_unit_number_pcnt *   0.00 / 10000 + le.Populated_mailing_city_state_zip_pcnt*ri.Populated_mailing_city_state_zip_pcnt *   0.00 / 10000 + le.Populated_property_full_street_address_pcnt*ri.Populated_property_full_street_address_pcnt *   0.00 / 10000 + le.Populated_property_unit_number_pcnt*ri.Populated_property_unit_number_pcnt *   0.00 / 10000 + le.Populated_property_city_state_zip_pcnt*ri.Populated_property_city_state_zip_pcnt *   0.00 / 10000 + le.Populated_property_country_code_pcnt*ri.Populated_property_country_code_pcnt *   0.00 / 10000 + le.Populated_property_address_code_pcnt*ri.Populated_property_address_code_pcnt *   0.00 / 10000 + le.Populated_legal_lot_code_pcnt*ri.Populated_legal_lot_code_pcnt *   0.00 / 10000 + le.Populated_legal_lot_number_pcnt*ri.Populated_legal_lot_number_pcnt *   0.00 / 10000 + le.Populated_legal_land_lot_pcnt*ri.Populated_legal_land_lot_pcnt *   0.00 / 10000 + le.Populated_legal_block_pcnt*ri.Populated_legal_block_pcnt *   0.00 / 10000 + le.Populated_legal_section_pcnt*ri.Populated_legal_section_pcnt *   0.00 / 10000 + le.Populated_legal_district_pcnt*ri.Populated_legal_district_pcnt *   0.00 / 10000 + le.Populated_legal_unit_pcnt*ri.Populated_legal_unit_pcnt *   0.00 / 10000 + le.Populated_legal_city_municipality_township_pcnt*ri.Populated_legal_city_municipality_township_pcnt *   0.00 / 10000 + le.Populated_legal_subdivision_name_pcnt*ri.Populated_legal_subdivision_name_pcnt *   0.00 / 10000 + le.Populated_legal_phase_number_pcnt*ri.Populated_legal_phase_number_pcnt *   0.00 / 10000 + le.Populated_legal_tract_number_pcnt*ri.Populated_legal_tract_number_pcnt *   0.00 / 10000 + le.Populated_legal_sec_twn_rng_mer_pcnt*ri.Populated_legal_sec_twn_rng_mer_pcnt *   0.00 / 10000 + le.Populated_legal_brief_description_pcnt*ri.Populated_legal_brief_description_pcnt *   0.00 / 10000 + le.Populated_legal_assessor_map_ref_pcnt*ri.Populated_legal_assessor_map_ref_pcnt *   0.00 / 10000 + le.Populated_census_tract_pcnt*ri.Populated_census_tract_pcnt *   0.00 / 10000 + le.Populated_record_type_code_pcnt*ri.Populated_record_type_code_pcnt *   0.00 / 10000 + le.Populated_ownership_type_code_pcnt*ri.Populated_ownership_type_code_pcnt *   0.00 / 10000 + le.Populated_new_record_type_code_pcnt*ri.Populated_new_record_type_code_pcnt *   0.00 / 10000 + le.Populated_state_land_use_code_pcnt*ri.Populated_state_land_use_code_pcnt *   0.00 / 10000 + le.Populated_county_land_use_code_pcnt*ri.Populated_county_land_use_code_pcnt *   0.00 / 10000 + le.Populated_county_land_use_description_pcnt*ri.Populated_county_land_use_description_pcnt *   0.00 / 10000 + le.Populated_standardized_land_use_code_pcnt*ri.Populated_standardized_land_use_code_pcnt *   0.00 / 10000 + le.Populated_timeshare_code_pcnt*ri.Populated_timeshare_code_pcnt *   0.00 / 10000 + le.Populated_zoning_pcnt*ri.Populated_zoning_pcnt *   0.00 / 10000 + le.Populated_owner_occupied_pcnt*ri.Populated_owner_occupied_pcnt *   0.00 / 10000 + le.Populated_recorder_document_number_pcnt*ri.Populated_recorder_document_number_pcnt *   0.00 / 10000 + le.Populated_recorder_book_number_pcnt*ri.Populated_recorder_book_number_pcnt *   0.00 / 10000 + le.Populated_recorder_page_number_pcnt*ri.Populated_recorder_page_number_pcnt *   0.00 / 10000 + le.Populated_transfer_date_pcnt*ri.Populated_transfer_date_pcnt *   0.00 / 10000 + le.Populated_recording_date_pcnt*ri.Populated_recording_date_pcnt *   0.00 / 10000 + le.Populated_sale_date_pcnt*ri.Populated_sale_date_pcnt *   0.00 / 10000 + le.Populated_document_type_pcnt*ri.Populated_document_type_pcnt *   0.00 / 10000 + le.Populated_sales_price_pcnt*ri.Populated_sales_price_pcnt *   0.00 / 10000 + le.Populated_sales_price_code_pcnt*ri.Populated_sales_price_code_pcnt *   0.00 / 10000 + le.Populated_mortgage_loan_amount_pcnt*ri.Populated_mortgage_loan_amount_pcnt *   0.00 / 10000 + le.Populated_mortgage_loan_type_code_pcnt*ri.Populated_mortgage_loan_type_code_pcnt *   0.00 / 10000 + le.Populated_mortgage_lender_name_pcnt*ri.Populated_mortgage_lender_name_pcnt *   0.00 / 10000 + le.Populated_mortgage_lender_type_code_pcnt*ri.Populated_mortgage_lender_type_code_pcnt *   0.00 / 10000 + le.Populated_prior_transfer_date_pcnt*ri.Populated_prior_transfer_date_pcnt *   0.00 / 10000 + le.Populated_prior_recording_date_pcnt*ri.Populated_prior_recording_date_pcnt *   0.00 / 10000 + le.Populated_prior_sales_price_pcnt*ri.Populated_prior_sales_price_pcnt *   0.00 / 10000 + le.Populated_prior_sales_price_code_pcnt*ri.Populated_prior_sales_price_code_pcnt *   0.00 / 10000 + le.Populated_assessed_land_value_pcnt*ri.Populated_assessed_land_value_pcnt *   0.00 / 10000 + le.Populated_assessed_improvement_value_pcnt*ri.Populated_assessed_improvement_value_pcnt *   0.00 / 10000 + le.Populated_assessed_total_value_pcnt*ri.Populated_assessed_total_value_pcnt *   0.00 / 10000 + le.Populated_assessed_value_year_pcnt*ri.Populated_assessed_value_year_pcnt *   0.00 / 10000 + le.Populated_market_land_value_pcnt*ri.Populated_market_land_value_pcnt *   0.00 / 10000 + le.Populated_market_improvement_value_pcnt*ri.Populated_market_improvement_value_pcnt *   0.00 / 10000 + le.Populated_market_total_value_pcnt*ri.Populated_market_total_value_pcnt *   0.00 / 10000 + le.Populated_market_value_year_pcnt*ri.Populated_market_value_year_pcnt *   0.00 / 10000 + le.Populated_homestead_homeowner_exemption_pcnt*ri.Populated_homestead_homeowner_exemption_pcnt *   0.00 / 10000 + le.Populated_tax_exemption1_code_pcnt*ri.Populated_tax_exemption1_code_pcnt *   0.00 / 10000 + le.Populated_tax_exemption2_code_pcnt*ri.Populated_tax_exemption2_code_pcnt *   0.00 / 10000 + le.Populated_tax_exemption3_code_pcnt*ri.Populated_tax_exemption3_code_pcnt *   0.00 / 10000 + le.Populated_tax_exemption4_code_pcnt*ri.Populated_tax_exemption4_code_pcnt *   0.00 / 10000 + le.Populated_tax_rate_code_area_pcnt*ri.Populated_tax_rate_code_area_pcnt *   0.00 / 10000 + le.Populated_tax_amount_pcnt*ri.Populated_tax_amount_pcnt *   0.00 / 10000 + le.Populated_tax_year_pcnt*ri.Populated_tax_year_pcnt *   0.00 / 10000 + le.Populated_tax_delinquent_year_pcnt*ri.Populated_tax_delinquent_year_pcnt *   0.00 / 10000 + le.Populated_school_tax_district1_pcnt*ri.Populated_school_tax_district1_pcnt *   0.00 / 10000 + le.Populated_school_tax_district1_indicator_pcnt*ri.Populated_school_tax_district1_indicator_pcnt *   0.00 / 10000 + le.Populated_school_tax_district2_pcnt*ri.Populated_school_tax_district2_pcnt *   0.00 / 10000 + le.Populated_school_tax_district2_indicator_pcnt*ri.Populated_school_tax_district2_indicator_pcnt *   0.00 / 10000 + le.Populated_school_tax_district3_pcnt*ri.Populated_school_tax_district3_pcnt *   0.00 / 10000 + le.Populated_school_tax_district3_indicator_pcnt*ri.Populated_school_tax_district3_indicator_pcnt *   0.00 / 10000 + le.Populated_lot_size_pcnt*ri.Populated_lot_size_pcnt *   0.00 / 10000 + le.Populated_lot_size_acres_pcnt*ri.Populated_lot_size_acres_pcnt *   0.00 / 10000 + le.Populated_lot_size_frontage_feet_pcnt*ri.Populated_lot_size_frontage_feet_pcnt *   0.00 / 10000 + le.Populated_lot_size_depth_feet_pcnt*ri.Populated_lot_size_depth_feet_pcnt *   0.00 / 10000 + le.Populated_land_acres_pcnt*ri.Populated_land_acres_pcnt *   0.00 / 10000 + le.Populated_land_square_footage_pcnt*ri.Populated_land_square_footage_pcnt *   0.00 / 10000 + le.Populated_land_dimensions_pcnt*ri.Populated_land_dimensions_pcnt *   0.00 / 10000 + le.Populated_building_area_pcnt*ri.Populated_building_area_pcnt *   0.00 / 10000 + le.Populated_building_area_indicator_pcnt*ri.Populated_building_area_indicator_pcnt *   0.00 / 10000 + le.Populated_building_area1_pcnt*ri.Populated_building_area1_pcnt *   0.00 / 10000 + le.Populated_building_area1_indicator_pcnt*ri.Populated_building_area1_indicator_pcnt *   0.00 / 10000 + le.Populated_building_area2_pcnt*ri.Populated_building_area2_pcnt *   0.00 / 10000 + le.Populated_building_area2_indicator_pcnt*ri.Populated_building_area2_indicator_pcnt *   0.00 / 10000 + le.Populated_building_area3_pcnt*ri.Populated_building_area3_pcnt *   0.00 / 10000 + le.Populated_building_area3_indicator_pcnt*ri.Populated_building_area3_indicator_pcnt *   0.00 / 10000 + le.Populated_building_area4_pcnt*ri.Populated_building_area4_pcnt *   0.00 / 10000 + le.Populated_building_area4_indicator_pcnt*ri.Populated_building_area4_indicator_pcnt *   0.00 / 10000 + le.Populated_building_area5_pcnt*ri.Populated_building_area5_pcnt *   0.00 / 10000 + le.Populated_building_area5_indicator_pcnt*ri.Populated_building_area5_indicator_pcnt *   0.00 / 10000 + le.Populated_building_area6_pcnt*ri.Populated_building_area6_pcnt *   0.00 / 10000 + le.Populated_building_area6_indicator_pcnt*ri.Populated_building_area6_indicator_pcnt *   0.00 / 10000 + le.Populated_building_area7_pcnt*ri.Populated_building_area7_pcnt *   0.00 / 10000 + le.Populated_building_area7_indicator_pcnt*ri.Populated_building_area7_indicator_pcnt *   0.00 / 10000 + le.Populated_year_built_pcnt*ri.Populated_year_built_pcnt *   0.00 / 10000 + le.Populated_effective_year_built_pcnt*ri.Populated_effective_year_built_pcnt *   0.00 / 10000 + le.Populated_no_of_buildings_pcnt*ri.Populated_no_of_buildings_pcnt *   0.00 / 10000 + le.Populated_no_of_stories_pcnt*ri.Populated_no_of_stories_pcnt *   0.00 / 10000 + le.Populated_no_of_units_pcnt*ri.Populated_no_of_units_pcnt *   0.00 / 10000 + le.Populated_no_of_rooms_pcnt*ri.Populated_no_of_rooms_pcnt *   0.00 / 10000 + le.Populated_no_of_bedrooms_pcnt*ri.Populated_no_of_bedrooms_pcnt *   0.00 / 10000 + le.Populated_no_of_baths_pcnt*ri.Populated_no_of_baths_pcnt *   0.00 / 10000 + le.Populated_no_of_partial_baths_pcnt*ri.Populated_no_of_partial_baths_pcnt *   0.00 / 10000 + le.Populated_no_of_plumbing_fixtures_pcnt*ri.Populated_no_of_plumbing_fixtures_pcnt *   0.00 / 10000 + le.Populated_garage_type_code_pcnt*ri.Populated_garage_type_code_pcnt *   0.00 / 10000 + le.Populated_parking_no_of_cars_pcnt*ri.Populated_parking_no_of_cars_pcnt *   0.00 / 10000 + le.Populated_pool_code_pcnt*ri.Populated_pool_code_pcnt *   0.00 / 10000 + le.Populated_style_code_pcnt*ri.Populated_style_code_pcnt *   0.00 / 10000 + le.Populated_type_construction_code_pcnt*ri.Populated_type_construction_code_pcnt *   0.00 / 10000 + le.Populated_foundation_code_pcnt*ri.Populated_foundation_code_pcnt *   0.00 / 10000 + le.Populated_building_quality_code_pcnt*ri.Populated_building_quality_code_pcnt *   0.00 / 10000 + le.Populated_building_condition_code_pcnt*ri.Populated_building_condition_code_pcnt *   0.00 / 10000 + le.Populated_exterior_walls_code_pcnt*ri.Populated_exterior_walls_code_pcnt *   0.00 / 10000 + le.Populated_interior_walls_code_pcnt*ri.Populated_interior_walls_code_pcnt *   0.00 / 10000 + le.Populated_roof_cover_code_pcnt*ri.Populated_roof_cover_code_pcnt *   0.00 / 10000 + le.Populated_roof_type_code_pcnt*ri.Populated_roof_type_code_pcnt *   0.00 / 10000 + le.Populated_floor_cover_code_pcnt*ri.Populated_floor_cover_code_pcnt *   0.00 / 10000 + le.Populated_water_code_pcnt*ri.Populated_water_code_pcnt *   0.00 / 10000 + le.Populated_sewer_code_pcnt*ri.Populated_sewer_code_pcnt *   0.00 / 10000 + le.Populated_heating_code_pcnt*ri.Populated_heating_code_pcnt *   0.00 / 10000 + le.Populated_heating_fuel_type_code_pcnt*ri.Populated_heating_fuel_type_code_pcnt *   0.00 / 10000 + le.Populated_air_conditioning_code_pcnt*ri.Populated_air_conditioning_code_pcnt *   0.00 / 10000 + le.Populated_air_conditioning_type_code_pcnt*ri.Populated_air_conditioning_type_code_pcnt *   0.00 / 10000 + le.Populated_elevator_pcnt*ri.Populated_elevator_pcnt *   0.00 / 10000 + le.Populated_fireplace_indicator_pcnt*ri.Populated_fireplace_indicator_pcnt *   0.00 / 10000 + le.Populated_fireplace_number_pcnt*ri.Populated_fireplace_number_pcnt *   0.00 / 10000 + le.Populated_basement_code_pcnt*ri.Populated_basement_code_pcnt *   0.00 / 10000 + le.Populated_building_class_code_pcnt*ri.Populated_building_class_code_pcnt *   0.00 / 10000 + le.Populated_site_influence1_code_pcnt*ri.Populated_site_influence1_code_pcnt *   0.00 / 10000 + le.Populated_site_influence2_code_pcnt*ri.Populated_site_influence2_code_pcnt *   0.00 / 10000 + le.Populated_site_influence3_code_pcnt*ri.Populated_site_influence3_code_pcnt *   0.00 / 10000 + le.Populated_site_influence4_code_pcnt*ri.Populated_site_influence4_code_pcnt *   0.00 / 10000 + le.Populated_site_influence5_code_pcnt*ri.Populated_site_influence5_code_pcnt *   0.00 / 10000 + le.Populated_amenities1_code_pcnt*ri.Populated_amenities1_code_pcnt *   0.00 / 10000 + le.Populated_amenities2_code_pcnt*ri.Populated_amenities2_code_pcnt *   0.00 / 10000 + le.Populated_amenities3_code_pcnt*ri.Populated_amenities3_code_pcnt *   0.00 / 10000 + le.Populated_amenities4_code_pcnt*ri.Populated_amenities4_code_pcnt *   0.00 / 10000 + le.Populated_amenities5_code_pcnt*ri.Populated_amenities5_code_pcnt *   0.00 / 10000 + le.Populated_amenities2_code1_pcnt*ri.Populated_amenities2_code1_pcnt *   0.00 / 10000 + le.Populated_amenities2_code2_pcnt*ri.Populated_amenities2_code2_pcnt *   0.00 / 10000 + le.Populated_amenities2_code3_pcnt*ri.Populated_amenities2_code3_pcnt *   0.00 / 10000 + le.Populated_amenities2_code4_pcnt*ri.Populated_amenities2_code4_pcnt *   0.00 / 10000 + le.Populated_amenities2_code5_pcnt*ri.Populated_amenities2_code5_pcnt *   0.00 / 10000 + le.Populated_extra_features1_area_pcnt*ri.Populated_extra_features1_area_pcnt *   0.00 / 10000 + le.Populated_extra_features1_indicator_pcnt*ri.Populated_extra_features1_indicator_pcnt *   0.00 / 10000 + le.Populated_extra_features2_area_pcnt*ri.Populated_extra_features2_area_pcnt *   0.00 / 10000 + le.Populated_extra_features2_indicator_pcnt*ri.Populated_extra_features2_indicator_pcnt *   0.00 / 10000 + le.Populated_extra_features3_area_pcnt*ri.Populated_extra_features3_area_pcnt *   0.00 / 10000 + le.Populated_extra_features3_indicator_pcnt*ri.Populated_extra_features3_indicator_pcnt *   0.00 / 10000 + le.Populated_extra_features4_area_pcnt*ri.Populated_extra_features4_area_pcnt *   0.00 / 10000 + le.Populated_extra_features4_indicator_pcnt*ri.Populated_extra_features4_indicator_pcnt *   0.00 / 10000 + le.Populated_other_buildings1_code_pcnt*ri.Populated_other_buildings1_code_pcnt *   0.00 / 10000 + le.Populated_other_buildings2_code_pcnt*ri.Populated_other_buildings2_code_pcnt *   0.00 / 10000 + le.Populated_other_buildings3_code_pcnt*ri.Populated_other_buildings3_code_pcnt *   0.00 / 10000 + le.Populated_other_buildings4_code_pcnt*ri.Populated_other_buildings4_code_pcnt *   0.00 / 10000 + le.Populated_other_buildings5_code_pcnt*ri.Populated_other_buildings5_code_pcnt *   0.00 / 10000 + le.Populated_other_impr_building1_indicator_pcnt*ri.Populated_other_impr_building1_indicator_pcnt *   0.00 / 10000 + le.Populated_other_impr_building2_indicator_pcnt*ri.Populated_other_impr_building2_indicator_pcnt *   0.00 / 10000 + le.Populated_other_impr_building3_indicator_pcnt*ri.Populated_other_impr_building3_indicator_pcnt *   0.00 / 10000 + le.Populated_other_impr_building4_indicator_pcnt*ri.Populated_other_impr_building4_indicator_pcnt *   0.00 / 10000 + le.Populated_other_impr_building5_indicator_pcnt*ri.Populated_other_impr_building5_indicator_pcnt *   0.00 / 10000 + le.Populated_other_impr_building_area1_pcnt*ri.Populated_other_impr_building_area1_pcnt *   0.00 / 10000 + le.Populated_other_impr_building_area2_pcnt*ri.Populated_other_impr_building_area2_pcnt *   0.00 / 10000 + le.Populated_other_impr_building_area3_pcnt*ri.Populated_other_impr_building_area3_pcnt *   0.00 / 10000 + le.Populated_other_impr_building_area4_pcnt*ri.Populated_other_impr_building_area4_pcnt *   0.00 / 10000 + le.Populated_other_impr_building_area5_pcnt*ri.Populated_other_impr_building_area5_pcnt *   0.00 / 10000 + le.Populated_topograpy_code_pcnt*ri.Populated_topograpy_code_pcnt *   0.00 / 10000 + le.Populated_neighborhood_code_pcnt*ri.Populated_neighborhood_code_pcnt *   0.00 / 10000 + le.Populated_condo_project_or_building_name_pcnt*ri.Populated_condo_project_or_building_name_pcnt *   0.00 / 10000 + le.Populated_assessee_name_indicator_pcnt*ri.Populated_assessee_name_indicator_pcnt *   0.00 / 10000 + le.Populated_second_assessee_name_indicator_pcnt*ri.Populated_second_assessee_name_indicator_pcnt *   0.00 / 10000 + le.Populated_other_rooms_indicator_pcnt*ri.Populated_other_rooms_indicator_pcnt *   0.00 / 10000 + le.Populated_mail_care_of_name_indicator_pcnt*ri.Populated_mail_care_of_name_indicator_pcnt *   0.00 / 10000 + le.Populated_comments_pcnt*ri.Populated_comments_pcnt *   0.00 / 10000 + le.Populated_tape_cut_date_pcnt*ri.Populated_tape_cut_date_pcnt *   0.00 / 10000 + le.Populated_certification_date_pcnt*ri.Populated_certification_date_pcnt *   0.00 / 10000 + le.Populated_edition_number_pcnt*ri.Populated_edition_number_pcnt *   0.00 / 10000 + le.Populated_prop_addr_propagated_ind_pcnt*ri.Populated_prop_addr_propagated_ind_pcnt *   0.00 / 10000 + le.Populated_ln_ownership_rights_pcnt*ri.Populated_ln_ownership_rights_pcnt *   0.00 / 10000 + le.Populated_ln_relationship_type_pcnt*ri.Populated_ln_relationship_type_pcnt *   0.00 / 10000 + le.Populated_ln_mailing_country_code_pcnt*ri.Populated_ln_mailing_country_code_pcnt *   0.00 / 10000 + le.Populated_ln_property_name_pcnt*ri.Populated_ln_property_name_pcnt *   0.00 / 10000 + le.Populated_ln_property_name_type_pcnt*ri.Populated_ln_property_name_type_pcnt *   0.00 / 10000 + le.Populated_ln_land_use_category_pcnt*ri.Populated_ln_land_use_category_pcnt *   0.00 / 10000 + le.Populated_ln_lot_pcnt*ri.Populated_ln_lot_pcnt *   0.00 / 10000 + le.Populated_ln_block_pcnt*ri.Populated_ln_block_pcnt *   0.00 / 10000 + le.Populated_ln_unit_pcnt*ri.Populated_ln_unit_pcnt *   0.00 / 10000 + le.Populated_ln_subfloor_pcnt*ri.Populated_ln_subfloor_pcnt *   0.00 / 10000 + le.Populated_ln_floor_cover_pcnt*ri.Populated_ln_floor_cover_pcnt *   0.00 / 10000 + le.Populated_ln_mobile_home_indicator_pcnt*ri.Populated_ln_mobile_home_indicator_pcnt *   0.00 / 10000 + le.Populated_ln_condo_indicator_pcnt*ri.Populated_ln_condo_indicator_pcnt *   0.00 / 10000 + le.Populated_ln_property_tax_exemption_pcnt*ri.Populated_ln_property_tax_exemption_pcnt *   0.00 / 10000 + le.Populated_ln_veteran_status_pcnt*ri.Populated_ln_veteran_status_pcnt *   0.00 / 10000 + le.Populated_ln_old_apn_indicator_pcnt*ri.Populated_ln_old_apn_indicator_pcnt *   0.00 / 10000 + le.Populated_fips_pcnt*ri.Populated_fips_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
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
  SELF.FieldName := CHOOSE(C,'ln_fares_id','process_date','vendor_source_flag','current_record','fips_code','state_code','county_name','old_apn','apna_or_pin_number','fares_unformatted_apn','duplicate_apn_multiple_address_id','assessee_name','second_assessee_name','assessee_ownership_rights_code','assessee_relationship_code','assessee_phone_number','tax_account_number','contract_owner','assessee_name_type_code','second_assessee_name_type_code','mail_care_of_name_type_code','mailing_care_of_name','mailing_full_street_address','mailing_unit_number','mailing_city_state_zip','property_full_street_address','property_unit_number','property_city_state_zip','property_country_code','property_address_code','legal_lot_code','legal_lot_number','legal_land_lot','legal_block','legal_section','legal_district','legal_unit','legal_city_municipality_township','legal_subdivision_name','legal_phase_number','legal_tract_number','legal_sec_twn_rng_mer','legal_brief_description','legal_assessor_map_ref','census_tract','record_type_code','ownership_type_code','new_record_type_code','state_land_use_code','county_land_use_code','county_land_use_description','standardized_land_use_code','timeshare_code','zoning','owner_occupied','recorder_document_number','recorder_book_number','recorder_page_number','transfer_date','recording_date','sale_date','document_type','sales_price','sales_price_code','mortgage_loan_amount','mortgage_loan_type_code','mortgage_lender_name','mortgage_lender_type_code','prior_transfer_date','prior_recording_date','prior_sales_price','prior_sales_price_code','assessed_land_value','assessed_improvement_value','assessed_total_value','assessed_value_year','market_land_value','market_improvement_value','market_total_value','market_value_year','homestead_homeowner_exemption','tax_exemption1_code','tax_exemption2_code','tax_exemption3_code','tax_exemption4_code','tax_rate_code_area','tax_amount','tax_year','tax_delinquent_year','school_tax_district1','school_tax_district1_indicator','school_tax_district2','school_tax_district2_indicator','school_tax_district3','school_tax_district3_indicator','lot_size','lot_size_acres','lot_size_frontage_feet','lot_size_depth_feet','land_acres','land_square_footage','land_dimensions','building_area','building_area_indicator','building_area1','building_area1_indicator','building_area2','building_area2_indicator','building_area3','building_area3_indicator','building_area4','building_area4_indicator','building_area5','building_area5_indicator','building_area6','building_area6_indicator','building_area7','building_area7_indicator','year_built','effective_year_built','no_of_buildings','no_of_stories','no_of_units','no_of_rooms','no_of_bedrooms','no_of_baths','no_of_partial_baths','no_of_plumbing_fixtures','garage_type_code','parking_no_of_cars','pool_code','style_code','type_construction_code','foundation_code','building_quality_code','building_condition_code','exterior_walls_code','interior_walls_code','roof_cover_code','roof_type_code','floor_cover_code','water_code','sewer_code','heating_code','heating_fuel_type_code','air_conditioning_code','air_conditioning_type_code','elevator','fireplace_indicator','fireplace_number','basement_code','building_class_code','site_influence1_code','site_influence2_code','site_influence3_code','site_influence4_code','site_influence5_code','amenities1_code','amenities2_code','amenities3_code','amenities4_code','amenities5_code','amenities2_code1','amenities2_code2','amenities2_code3','amenities2_code4','amenities2_code5','extra_features1_area','extra_features1_indicator','extra_features2_area','extra_features2_indicator','extra_features3_area','extra_features3_indicator','extra_features4_area','extra_features4_indicator','other_buildings1_code','other_buildings2_code','other_buildings3_code','other_buildings4_code','other_buildings5_code','other_impr_building1_indicator','other_impr_building2_indicator','other_impr_building3_indicator','other_impr_building4_indicator','other_impr_building5_indicator','other_impr_building_area1','other_impr_building_area2','other_impr_building_area3','other_impr_building_area4','other_impr_building_area5','topograpy_code','neighborhood_code','condo_project_or_building_name','assessee_name_indicator','second_assessee_name_indicator','other_rooms_indicator','mail_care_of_name_indicator','comments','tape_cut_date','certification_date','edition_number','prop_addr_propagated_ind','ln_ownership_rights','ln_relationship_type','ln_mailing_country_code','ln_property_name','ln_property_name_type','ln_land_use_category','ln_lot','ln_block','ln_unit','ln_subfloor','ln_floor_cover','ln_mobile_home_indicator','ln_condo_indicator','ln_property_tax_exemption','ln_veteran_status','ln_old_apn_indicator','fips');
  SELF.populated_pcnt := CHOOSE(C,le.populated_ln_fares_id_pcnt,le.populated_process_date_pcnt,le.populated_vendor_source_flag_pcnt,le.populated_current_record_pcnt,le.populated_fips_code_pcnt,le.populated_state_code_pcnt,le.populated_county_name_pcnt,le.populated_old_apn_pcnt,le.populated_apna_or_pin_number_pcnt,le.populated_fares_unformatted_apn_pcnt,le.populated_duplicate_apn_multiple_address_id_pcnt,le.populated_assessee_name_pcnt,le.populated_second_assessee_name_pcnt,le.populated_assessee_ownership_rights_code_pcnt,le.populated_assessee_relationship_code_pcnt,le.populated_assessee_phone_number_pcnt,le.populated_tax_account_number_pcnt,le.populated_contract_owner_pcnt,le.populated_assessee_name_type_code_pcnt,le.populated_second_assessee_name_type_code_pcnt,le.populated_mail_care_of_name_type_code_pcnt,le.populated_mailing_care_of_name_pcnt,le.populated_mailing_full_street_address_pcnt,le.populated_mailing_unit_number_pcnt,le.populated_mailing_city_state_zip_pcnt,le.populated_property_full_street_address_pcnt,le.populated_property_unit_number_pcnt,le.populated_property_city_state_zip_pcnt,le.populated_property_country_code_pcnt,le.populated_property_address_code_pcnt,le.populated_legal_lot_code_pcnt,le.populated_legal_lot_number_pcnt,le.populated_legal_land_lot_pcnt,le.populated_legal_block_pcnt,le.populated_legal_section_pcnt,le.populated_legal_district_pcnt,le.populated_legal_unit_pcnt,le.populated_legal_city_municipality_township_pcnt,le.populated_legal_subdivision_name_pcnt,le.populated_legal_phase_number_pcnt,le.populated_legal_tract_number_pcnt,le.populated_legal_sec_twn_rng_mer_pcnt,le.populated_legal_brief_description_pcnt,le.populated_legal_assessor_map_ref_pcnt,le.populated_census_tract_pcnt,le.populated_record_type_code_pcnt,le.populated_ownership_type_code_pcnt,le.populated_new_record_type_code_pcnt,le.populated_state_land_use_code_pcnt,le.populated_county_land_use_code_pcnt,le.populated_county_land_use_description_pcnt,le.populated_standardized_land_use_code_pcnt,le.populated_timeshare_code_pcnt,le.populated_zoning_pcnt,le.populated_owner_occupied_pcnt,le.populated_recorder_document_number_pcnt,le.populated_recorder_book_number_pcnt,le.populated_recorder_page_number_pcnt,le.populated_transfer_date_pcnt,le.populated_recording_date_pcnt,le.populated_sale_date_pcnt,le.populated_document_type_pcnt,le.populated_sales_price_pcnt,le.populated_sales_price_code_pcnt,le.populated_mortgage_loan_amount_pcnt,le.populated_mortgage_loan_type_code_pcnt,le.populated_mortgage_lender_name_pcnt,le.populated_mortgage_lender_type_code_pcnt,le.populated_prior_transfer_date_pcnt,le.populated_prior_recording_date_pcnt,le.populated_prior_sales_price_pcnt,le.populated_prior_sales_price_code_pcnt,le.populated_assessed_land_value_pcnt,le.populated_assessed_improvement_value_pcnt,le.populated_assessed_total_value_pcnt,le.populated_assessed_value_year_pcnt,le.populated_market_land_value_pcnt,le.populated_market_improvement_value_pcnt,le.populated_market_total_value_pcnt,le.populated_market_value_year_pcnt,le.populated_homestead_homeowner_exemption_pcnt,le.populated_tax_exemption1_code_pcnt,le.populated_tax_exemption2_code_pcnt,le.populated_tax_exemption3_code_pcnt,le.populated_tax_exemption4_code_pcnt,le.populated_tax_rate_code_area_pcnt,le.populated_tax_amount_pcnt,le.populated_tax_year_pcnt,le.populated_tax_delinquent_year_pcnt,le.populated_school_tax_district1_pcnt,le.populated_school_tax_district1_indicator_pcnt,le.populated_school_tax_district2_pcnt,le.populated_school_tax_district2_indicator_pcnt,le.populated_school_tax_district3_pcnt,le.populated_school_tax_district3_indicator_pcnt,le.populated_lot_size_pcnt,le.populated_lot_size_acres_pcnt,le.populated_lot_size_frontage_feet_pcnt,le.populated_lot_size_depth_feet_pcnt,le.populated_land_acres_pcnt,le.populated_land_square_footage_pcnt,le.populated_land_dimensions_pcnt,le.populated_building_area_pcnt,le.populated_building_area_indicator_pcnt,le.populated_building_area1_pcnt,le.populated_building_area1_indicator_pcnt,le.populated_building_area2_pcnt,le.populated_building_area2_indicator_pcnt,le.populated_building_area3_pcnt,le.populated_building_area3_indicator_pcnt,le.populated_building_area4_pcnt,le.populated_building_area4_indicator_pcnt,le.populated_building_area5_pcnt,le.populated_building_area5_indicator_pcnt,le.populated_building_area6_pcnt,le.populated_building_area6_indicator_pcnt,le.populated_building_area7_pcnt,le.populated_building_area7_indicator_pcnt,le.populated_year_built_pcnt,le.populated_effective_year_built_pcnt,le.populated_no_of_buildings_pcnt,le.populated_no_of_stories_pcnt,le.populated_no_of_units_pcnt,le.populated_no_of_rooms_pcnt,le.populated_no_of_bedrooms_pcnt,le.populated_no_of_baths_pcnt,le.populated_no_of_partial_baths_pcnt,le.populated_no_of_plumbing_fixtures_pcnt,le.populated_garage_type_code_pcnt,le.populated_parking_no_of_cars_pcnt,le.populated_pool_code_pcnt,le.populated_style_code_pcnt,le.populated_type_construction_code_pcnt,le.populated_foundation_code_pcnt,le.populated_building_quality_code_pcnt,le.populated_building_condition_code_pcnt,le.populated_exterior_walls_code_pcnt,le.populated_interior_walls_code_pcnt,le.populated_roof_cover_code_pcnt,le.populated_roof_type_code_pcnt,le.populated_floor_cover_code_pcnt,le.populated_water_code_pcnt,le.populated_sewer_code_pcnt,le.populated_heating_code_pcnt,le.populated_heating_fuel_type_code_pcnt,le.populated_air_conditioning_code_pcnt,le.populated_air_conditioning_type_code_pcnt,le.populated_elevator_pcnt,le.populated_fireplace_indicator_pcnt,le.populated_fireplace_number_pcnt,le.populated_basement_code_pcnt,le.populated_building_class_code_pcnt,le.populated_site_influence1_code_pcnt,le.populated_site_influence2_code_pcnt,le.populated_site_influence3_code_pcnt,le.populated_site_influence4_code_pcnt,le.populated_site_influence5_code_pcnt,le.populated_amenities1_code_pcnt,le.populated_amenities2_code_pcnt,le.populated_amenities3_code_pcnt,le.populated_amenities4_code_pcnt,le.populated_amenities5_code_pcnt,le.populated_amenities2_code1_pcnt,le.populated_amenities2_code2_pcnt,le.populated_amenities2_code3_pcnt,le.populated_amenities2_code4_pcnt,le.populated_amenities2_code5_pcnt,le.populated_extra_features1_area_pcnt,le.populated_extra_features1_indicator_pcnt,le.populated_extra_features2_area_pcnt,le.populated_extra_features2_indicator_pcnt,le.populated_extra_features3_area_pcnt,le.populated_extra_features3_indicator_pcnt,le.populated_extra_features4_area_pcnt,le.populated_extra_features4_indicator_pcnt,le.populated_other_buildings1_code_pcnt,le.populated_other_buildings2_code_pcnt,le.populated_other_buildings3_code_pcnt,le.populated_other_buildings4_code_pcnt,le.populated_other_buildings5_code_pcnt,le.populated_other_impr_building1_indicator_pcnt,le.populated_other_impr_building2_indicator_pcnt,le.populated_other_impr_building3_indicator_pcnt,le.populated_other_impr_building4_indicator_pcnt,le.populated_other_impr_building5_indicator_pcnt,le.populated_other_impr_building_area1_pcnt,le.populated_other_impr_building_area2_pcnt,le.populated_other_impr_building_area3_pcnt,le.populated_other_impr_building_area4_pcnt,le.populated_other_impr_building_area5_pcnt,le.populated_topograpy_code_pcnt,le.populated_neighborhood_code_pcnt,le.populated_condo_project_or_building_name_pcnt,le.populated_assessee_name_indicator_pcnt,le.populated_second_assessee_name_indicator_pcnt,le.populated_other_rooms_indicator_pcnt,le.populated_mail_care_of_name_indicator_pcnt,le.populated_comments_pcnt,le.populated_tape_cut_date_pcnt,le.populated_certification_date_pcnt,le.populated_edition_number_pcnt,le.populated_prop_addr_propagated_ind_pcnt,le.populated_ln_ownership_rights_pcnt,le.populated_ln_relationship_type_pcnt,le.populated_ln_mailing_country_code_pcnt,le.populated_ln_property_name_pcnt,le.populated_ln_property_name_type_pcnt,le.populated_ln_land_use_category_pcnt,le.populated_ln_lot_pcnt,le.populated_ln_block_pcnt,le.populated_ln_unit_pcnt,le.populated_ln_subfloor_pcnt,le.populated_ln_floor_cover_pcnt,le.populated_ln_mobile_home_indicator_pcnt,le.populated_ln_condo_indicator_pcnt,le.populated_ln_property_tax_exemption_pcnt,le.populated_ln_veteran_status_pcnt,le.populated_ln_old_apn_indicator_pcnt,le.populated_fips_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_ln_fares_id,le.maxlength_process_date,le.maxlength_vendor_source_flag,le.maxlength_current_record,le.maxlength_fips_code,le.maxlength_state_code,le.maxlength_county_name,le.maxlength_old_apn,le.maxlength_apna_or_pin_number,le.maxlength_fares_unformatted_apn,le.maxlength_duplicate_apn_multiple_address_id,le.maxlength_assessee_name,le.maxlength_second_assessee_name,le.maxlength_assessee_ownership_rights_code,le.maxlength_assessee_relationship_code,le.maxlength_assessee_phone_number,le.maxlength_tax_account_number,le.maxlength_contract_owner,le.maxlength_assessee_name_type_code,le.maxlength_second_assessee_name_type_code,le.maxlength_mail_care_of_name_type_code,le.maxlength_mailing_care_of_name,le.maxlength_mailing_full_street_address,le.maxlength_mailing_unit_number,le.maxlength_mailing_city_state_zip,le.maxlength_property_full_street_address,le.maxlength_property_unit_number,le.maxlength_property_city_state_zip,le.maxlength_property_country_code,le.maxlength_property_address_code,le.maxlength_legal_lot_code,le.maxlength_legal_lot_number,le.maxlength_legal_land_lot,le.maxlength_legal_block,le.maxlength_legal_section,le.maxlength_legal_district,le.maxlength_legal_unit,le.maxlength_legal_city_municipality_township,le.maxlength_legal_subdivision_name,le.maxlength_legal_phase_number,le.maxlength_legal_tract_number,le.maxlength_legal_sec_twn_rng_mer,le.maxlength_legal_brief_description,le.maxlength_legal_assessor_map_ref,le.maxlength_census_tract,le.maxlength_record_type_code,le.maxlength_ownership_type_code,le.maxlength_new_record_type_code,le.maxlength_state_land_use_code,le.maxlength_county_land_use_code,le.maxlength_county_land_use_description,le.maxlength_standardized_land_use_code,le.maxlength_timeshare_code,le.maxlength_zoning,le.maxlength_owner_occupied,le.maxlength_recorder_document_number,le.maxlength_recorder_book_number,le.maxlength_recorder_page_number,le.maxlength_transfer_date,le.maxlength_recording_date,le.maxlength_sale_date,le.maxlength_document_type,le.maxlength_sales_price,le.maxlength_sales_price_code,le.maxlength_mortgage_loan_amount,le.maxlength_mortgage_loan_type_code,le.maxlength_mortgage_lender_name,le.maxlength_mortgage_lender_type_code,le.maxlength_prior_transfer_date,le.maxlength_prior_recording_date,le.maxlength_prior_sales_price,le.maxlength_prior_sales_price_code,le.maxlength_assessed_land_value,le.maxlength_assessed_improvement_value,le.maxlength_assessed_total_value,le.maxlength_assessed_value_year,le.maxlength_market_land_value,le.maxlength_market_improvement_value,le.maxlength_market_total_value,le.maxlength_market_value_year,le.maxlength_homestead_homeowner_exemption,le.maxlength_tax_exemption1_code,le.maxlength_tax_exemption2_code,le.maxlength_tax_exemption3_code,le.maxlength_tax_exemption4_code,le.maxlength_tax_rate_code_area,le.maxlength_tax_amount,le.maxlength_tax_year,le.maxlength_tax_delinquent_year,le.maxlength_school_tax_district1,le.maxlength_school_tax_district1_indicator,le.maxlength_school_tax_district2,le.maxlength_school_tax_district2_indicator,le.maxlength_school_tax_district3,le.maxlength_school_tax_district3_indicator,le.maxlength_lot_size,le.maxlength_lot_size_acres,le.maxlength_lot_size_frontage_feet,le.maxlength_lot_size_depth_feet,le.maxlength_land_acres,le.maxlength_land_square_footage,le.maxlength_land_dimensions,le.maxlength_building_area,le.maxlength_building_area_indicator,le.maxlength_building_area1,le.maxlength_building_area1_indicator,le.maxlength_building_area2,le.maxlength_building_area2_indicator,le.maxlength_building_area3,le.maxlength_building_area3_indicator,le.maxlength_building_area4,le.maxlength_building_area4_indicator,le.maxlength_building_area5,le.maxlength_building_area5_indicator,le.maxlength_building_area6,le.maxlength_building_area6_indicator,le.maxlength_building_area7,le.maxlength_building_area7_indicator,le.maxlength_year_built,le.maxlength_effective_year_built,le.maxlength_no_of_buildings,le.maxlength_no_of_stories,le.maxlength_no_of_units,le.maxlength_no_of_rooms,le.maxlength_no_of_bedrooms,le.maxlength_no_of_baths,le.maxlength_no_of_partial_baths,le.maxlength_no_of_plumbing_fixtures,le.maxlength_garage_type_code,le.maxlength_parking_no_of_cars,le.maxlength_pool_code,le.maxlength_style_code,le.maxlength_type_construction_code,le.maxlength_foundation_code,le.maxlength_building_quality_code,le.maxlength_building_condition_code,le.maxlength_exterior_walls_code,le.maxlength_interior_walls_code,le.maxlength_roof_cover_code,le.maxlength_roof_type_code,le.maxlength_floor_cover_code,le.maxlength_water_code,le.maxlength_sewer_code,le.maxlength_heating_code,le.maxlength_heating_fuel_type_code,le.maxlength_air_conditioning_code,le.maxlength_air_conditioning_type_code,le.maxlength_elevator,le.maxlength_fireplace_indicator,le.maxlength_fireplace_number,le.maxlength_basement_code,le.maxlength_building_class_code,le.maxlength_site_influence1_code,le.maxlength_site_influence2_code,le.maxlength_site_influence3_code,le.maxlength_site_influence4_code,le.maxlength_site_influence5_code,le.maxlength_amenities1_code,le.maxlength_amenities2_code,le.maxlength_amenities3_code,le.maxlength_amenities4_code,le.maxlength_amenities5_code,le.maxlength_amenities2_code1,le.maxlength_amenities2_code2,le.maxlength_amenities2_code3,le.maxlength_amenities2_code4,le.maxlength_amenities2_code5,le.maxlength_extra_features1_area,le.maxlength_extra_features1_indicator,le.maxlength_extra_features2_area,le.maxlength_extra_features2_indicator,le.maxlength_extra_features3_area,le.maxlength_extra_features3_indicator,le.maxlength_extra_features4_area,le.maxlength_extra_features4_indicator,le.maxlength_other_buildings1_code,le.maxlength_other_buildings2_code,le.maxlength_other_buildings3_code,le.maxlength_other_buildings4_code,le.maxlength_other_buildings5_code,le.maxlength_other_impr_building1_indicator,le.maxlength_other_impr_building2_indicator,le.maxlength_other_impr_building3_indicator,le.maxlength_other_impr_building4_indicator,le.maxlength_other_impr_building5_indicator,le.maxlength_other_impr_building_area1,le.maxlength_other_impr_building_area2,le.maxlength_other_impr_building_area3,le.maxlength_other_impr_building_area4,le.maxlength_other_impr_building_area5,le.maxlength_topograpy_code,le.maxlength_neighborhood_code,le.maxlength_condo_project_or_building_name,le.maxlength_assessee_name_indicator,le.maxlength_second_assessee_name_indicator,le.maxlength_other_rooms_indicator,le.maxlength_mail_care_of_name_indicator,le.maxlength_comments,le.maxlength_tape_cut_date,le.maxlength_certification_date,le.maxlength_edition_number,le.maxlength_prop_addr_propagated_ind,le.maxlength_ln_ownership_rights,le.maxlength_ln_relationship_type,le.maxlength_ln_mailing_country_code,le.maxlength_ln_property_name,le.maxlength_ln_property_name_type,le.maxlength_ln_land_use_category,le.maxlength_ln_lot,le.maxlength_ln_block,le.maxlength_ln_unit,le.maxlength_ln_subfloor,le.maxlength_ln_floor_cover,le.maxlength_ln_mobile_home_indicator,le.maxlength_ln_condo_indicator,le.maxlength_ln_property_tax_exemption,le.maxlength_ln_veteran_status,le.maxlength_ln_old_apn_indicator,le.maxlength_fips);
  SELF.avelength := CHOOSE(C,le.avelength_ln_fares_id,le.avelength_process_date,le.avelength_vendor_source_flag,le.avelength_current_record,le.avelength_fips_code,le.avelength_state_code,le.avelength_county_name,le.avelength_old_apn,le.avelength_apna_or_pin_number,le.avelength_fares_unformatted_apn,le.avelength_duplicate_apn_multiple_address_id,le.avelength_assessee_name,le.avelength_second_assessee_name,le.avelength_assessee_ownership_rights_code,le.avelength_assessee_relationship_code,le.avelength_assessee_phone_number,le.avelength_tax_account_number,le.avelength_contract_owner,le.avelength_assessee_name_type_code,le.avelength_second_assessee_name_type_code,le.avelength_mail_care_of_name_type_code,le.avelength_mailing_care_of_name,le.avelength_mailing_full_street_address,le.avelength_mailing_unit_number,le.avelength_mailing_city_state_zip,le.avelength_property_full_street_address,le.avelength_property_unit_number,le.avelength_property_city_state_zip,le.avelength_property_country_code,le.avelength_property_address_code,le.avelength_legal_lot_code,le.avelength_legal_lot_number,le.avelength_legal_land_lot,le.avelength_legal_block,le.avelength_legal_section,le.avelength_legal_district,le.avelength_legal_unit,le.avelength_legal_city_municipality_township,le.avelength_legal_subdivision_name,le.avelength_legal_phase_number,le.avelength_legal_tract_number,le.avelength_legal_sec_twn_rng_mer,le.avelength_legal_brief_description,le.avelength_legal_assessor_map_ref,le.avelength_census_tract,le.avelength_record_type_code,le.avelength_ownership_type_code,le.avelength_new_record_type_code,le.avelength_state_land_use_code,le.avelength_county_land_use_code,le.avelength_county_land_use_description,le.avelength_standardized_land_use_code,le.avelength_timeshare_code,le.avelength_zoning,le.avelength_owner_occupied,le.avelength_recorder_document_number,le.avelength_recorder_book_number,le.avelength_recorder_page_number,le.avelength_transfer_date,le.avelength_recording_date,le.avelength_sale_date,le.avelength_document_type,le.avelength_sales_price,le.avelength_sales_price_code,le.avelength_mortgage_loan_amount,le.avelength_mortgage_loan_type_code,le.avelength_mortgage_lender_name,le.avelength_mortgage_lender_type_code,le.avelength_prior_transfer_date,le.avelength_prior_recording_date,le.avelength_prior_sales_price,le.avelength_prior_sales_price_code,le.avelength_assessed_land_value,le.avelength_assessed_improvement_value,le.avelength_assessed_total_value,le.avelength_assessed_value_year,le.avelength_market_land_value,le.avelength_market_improvement_value,le.avelength_market_total_value,le.avelength_market_value_year,le.avelength_homestead_homeowner_exemption,le.avelength_tax_exemption1_code,le.avelength_tax_exemption2_code,le.avelength_tax_exemption3_code,le.avelength_tax_exemption4_code,le.avelength_tax_rate_code_area,le.avelength_tax_amount,le.avelength_tax_year,le.avelength_tax_delinquent_year,le.avelength_school_tax_district1,le.avelength_school_tax_district1_indicator,le.avelength_school_tax_district2,le.avelength_school_tax_district2_indicator,le.avelength_school_tax_district3,le.avelength_school_tax_district3_indicator,le.avelength_lot_size,le.avelength_lot_size_acres,le.avelength_lot_size_frontage_feet,le.avelength_lot_size_depth_feet,le.avelength_land_acres,le.avelength_land_square_footage,le.avelength_land_dimensions,le.avelength_building_area,le.avelength_building_area_indicator,le.avelength_building_area1,le.avelength_building_area1_indicator,le.avelength_building_area2,le.avelength_building_area2_indicator,le.avelength_building_area3,le.avelength_building_area3_indicator,le.avelength_building_area4,le.avelength_building_area4_indicator,le.avelength_building_area5,le.avelength_building_area5_indicator,le.avelength_building_area6,le.avelength_building_area6_indicator,le.avelength_building_area7,le.avelength_building_area7_indicator,le.avelength_year_built,le.avelength_effective_year_built,le.avelength_no_of_buildings,le.avelength_no_of_stories,le.avelength_no_of_units,le.avelength_no_of_rooms,le.avelength_no_of_bedrooms,le.avelength_no_of_baths,le.avelength_no_of_partial_baths,le.avelength_no_of_plumbing_fixtures,le.avelength_garage_type_code,le.avelength_parking_no_of_cars,le.avelength_pool_code,le.avelength_style_code,le.avelength_type_construction_code,le.avelength_foundation_code,le.avelength_building_quality_code,le.avelength_building_condition_code,le.avelength_exterior_walls_code,le.avelength_interior_walls_code,le.avelength_roof_cover_code,le.avelength_roof_type_code,le.avelength_floor_cover_code,le.avelength_water_code,le.avelength_sewer_code,le.avelength_heating_code,le.avelength_heating_fuel_type_code,le.avelength_air_conditioning_code,le.avelength_air_conditioning_type_code,le.avelength_elevator,le.avelength_fireplace_indicator,le.avelength_fireplace_number,le.avelength_basement_code,le.avelength_building_class_code,le.avelength_site_influence1_code,le.avelength_site_influence2_code,le.avelength_site_influence3_code,le.avelength_site_influence4_code,le.avelength_site_influence5_code,le.avelength_amenities1_code,le.avelength_amenities2_code,le.avelength_amenities3_code,le.avelength_amenities4_code,le.avelength_amenities5_code,le.avelength_amenities2_code1,le.avelength_amenities2_code2,le.avelength_amenities2_code3,le.avelength_amenities2_code4,le.avelength_amenities2_code5,le.avelength_extra_features1_area,le.avelength_extra_features1_indicator,le.avelength_extra_features2_area,le.avelength_extra_features2_indicator,le.avelength_extra_features3_area,le.avelength_extra_features3_indicator,le.avelength_extra_features4_area,le.avelength_extra_features4_indicator,le.avelength_other_buildings1_code,le.avelength_other_buildings2_code,le.avelength_other_buildings3_code,le.avelength_other_buildings4_code,le.avelength_other_buildings5_code,le.avelength_other_impr_building1_indicator,le.avelength_other_impr_building2_indicator,le.avelength_other_impr_building3_indicator,le.avelength_other_impr_building4_indicator,le.avelength_other_impr_building5_indicator,le.avelength_other_impr_building_area1,le.avelength_other_impr_building_area2,le.avelength_other_impr_building_area3,le.avelength_other_impr_building_area4,le.avelength_other_impr_building_area5,le.avelength_topograpy_code,le.avelength_neighborhood_code,le.avelength_condo_project_or_building_name,le.avelength_assessee_name_indicator,le.avelength_second_assessee_name_indicator,le.avelength_other_rooms_indicator,le.avelength_mail_care_of_name_indicator,le.avelength_comments,le.avelength_tape_cut_date,le.avelength_certification_date,le.avelength_edition_number,le.avelength_prop_addr_propagated_ind,le.avelength_ln_ownership_rights,le.avelength_ln_relationship_type,le.avelength_ln_mailing_country_code,le.avelength_ln_property_name,le.avelength_ln_property_name_type,le.avelength_ln_land_use_category,le.avelength_ln_lot,le.avelength_ln_block,le.avelength_ln_unit,le.avelength_ln_subfloor,le.avelength_ln_floor_cover,le.avelength_ln_mobile_home_indicator,le.avelength_ln_condo_indicator,le.avelength_ln_property_tax_exemption,le.avelength_ln_veteran_status,le.avelength_ln_old_apn_indicator,le.avelength_fips);
END;
EXPORT invSummary := NORMALIZE(summary0, 219, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.fips_code;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.ln_fares_id),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.vendor_source_flag),TRIM((SALT311.StrType)le.current_record),TRIM((SALT311.StrType)le.fips_code),TRIM((SALT311.StrType)le.state_code),TRIM((SALT311.StrType)le.county_name),TRIM((SALT311.StrType)le.old_apn),TRIM((SALT311.StrType)le.apna_or_pin_number),TRIM((SALT311.StrType)le.fares_unformatted_apn),TRIM((SALT311.StrType)le.duplicate_apn_multiple_address_id),TRIM((SALT311.StrType)le.assessee_name),TRIM((SALT311.StrType)le.second_assessee_name),TRIM((SALT311.StrType)le.assessee_ownership_rights_code),TRIM((SALT311.StrType)le.assessee_relationship_code),TRIM((SALT311.StrType)le.assessee_phone_number),TRIM((SALT311.StrType)le.tax_account_number),TRIM((SALT311.StrType)le.contract_owner),TRIM((SALT311.StrType)le.assessee_name_type_code),TRIM((SALT311.StrType)le.second_assessee_name_type_code),TRIM((SALT311.StrType)le.mail_care_of_name_type_code),TRIM((SALT311.StrType)le.mailing_care_of_name),TRIM((SALT311.StrType)le.mailing_full_street_address),TRIM((SALT311.StrType)le.mailing_unit_number),TRIM((SALT311.StrType)le.mailing_city_state_zip),TRIM((SALT311.StrType)le.property_full_street_address),TRIM((SALT311.StrType)le.property_unit_number),TRIM((SALT311.StrType)le.property_city_state_zip),TRIM((SALT311.StrType)le.property_country_code),TRIM((SALT311.StrType)le.property_address_code),TRIM((SALT311.StrType)le.legal_lot_code),TRIM((SALT311.StrType)le.legal_lot_number),TRIM((SALT311.StrType)le.legal_land_lot),TRIM((SALT311.StrType)le.legal_block),TRIM((SALT311.StrType)le.legal_section),TRIM((SALT311.StrType)le.legal_district),TRIM((SALT311.StrType)le.legal_unit),TRIM((SALT311.StrType)le.legal_city_municipality_township),TRIM((SALT311.StrType)le.legal_subdivision_name),TRIM((SALT311.StrType)le.legal_phase_number),TRIM((SALT311.StrType)le.legal_tract_number),TRIM((SALT311.StrType)le.legal_sec_twn_rng_mer),TRIM((SALT311.StrType)le.legal_brief_description),TRIM((SALT311.StrType)le.legal_assessor_map_ref),TRIM((SALT311.StrType)le.census_tract),TRIM((SALT311.StrType)le.record_type_code),TRIM((SALT311.StrType)le.ownership_type_code),TRIM((SALT311.StrType)le.new_record_type_code),TRIM((SALT311.StrType)le.state_land_use_code),TRIM((SALT311.StrType)le.county_land_use_code),TRIM((SALT311.StrType)le.county_land_use_description),TRIM((SALT311.StrType)le.standardized_land_use_code),TRIM((SALT311.StrType)le.timeshare_code),TRIM((SALT311.StrType)le.zoning),TRIM((SALT311.StrType)le.owner_occupied),TRIM((SALT311.StrType)le.recorder_document_number),TRIM((SALT311.StrType)le.recorder_book_number),TRIM((SALT311.StrType)le.recorder_page_number),TRIM((SALT311.StrType)le.transfer_date),TRIM((SALT311.StrType)le.recording_date),TRIM((SALT311.StrType)le.sale_date),TRIM((SALT311.StrType)le.document_type),TRIM((SALT311.StrType)le.sales_price),TRIM((SALT311.StrType)le.sales_price_code),TRIM((SALT311.StrType)le.mortgage_loan_amount),TRIM((SALT311.StrType)le.mortgage_loan_type_code),TRIM((SALT311.StrType)le.mortgage_lender_name),TRIM((SALT311.StrType)le.mortgage_lender_type_code),TRIM((SALT311.StrType)le.prior_transfer_date),TRIM((SALT311.StrType)le.prior_recording_date),TRIM((SALT311.StrType)le.prior_sales_price),TRIM((SALT311.StrType)le.prior_sales_price_code),TRIM((SALT311.StrType)le.assessed_land_value),TRIM((SALT311.StrType)le.assessed_improvement_value),TRIM((SALT311.StrType)le.assessed_total_value),TRIM((SALT311.StrType)le.assessed_value_year),TRIM((SALT311.StrType)le.market_land_value),TRIM((SALT311.StrType)le.market_improvement_value),TRIM((SALT311.StrType)le.market_total_value),TRIM((SALT311.StrType)le.market_value_year),TRIM((SALT311.StrType)le.homestead_homeowner_exemption),TRIM((SALT311.StrType)le.tax_exemption1_code),TRIM((SALT311.StrType)le.tax_exemption2_code),TRIM((SALT311.StrType)le.tax_exemption3_code),TRIM((SALT311.StrType)le.tax_exemption4_code),TRIM((SALT311.StrType)le.tax_rate_code_area),TRIM((SALT311.StrType)le.tax_amount),TRIM((SALT311.StrType)le.tax_year),TRIM((SALT311.StrType)le.tax_delinquent_year),TRIM((SALT311.StrType)le.school_tax_district1),TRIM((SALT311.StrType)le.school_tax_district1_indicator),TRIM((SALT311.StrType)le.school_tax_district2),TRIM((SALT311.StrType)le.school_tax_district2_indicator),TRIM((SALT311.StrType)le.school_tax_district3),TRIM((SALT311.StrType)le.school_tax_district3_indicator),TRIM((SALT311.StrType)le.lot_size),TRIM((SALT311.StrType)le.lot_size_acres),TRIM((SALT311.StrType)le.lot_size_frontage_feet),TRIM((SALT311.StrType)le.lot_size_depth_feet),TRIM((SALT311.StrType)le.land_acres),TRIM((SALT311.StrType)le.land_square_footage),TRIM((SALT311.StrType)le.land_dimensions),TRIM((SALT311.StrType)le.building_area),TRIM((SALT311.StrType)le.building_area_indicator),TRIM((SALT311.StrType)le.building_area1),TRIM((SALT311.StrType)le.building_area1_indicator),TRIM((SALT311.StrType)le.building_area2),TRIM((SALT311.StrType)le.building_area2_indicator),TRIM((SALT311.StrType)le.building_area3),TRIM((SALT311.StrType)le.building_area3_indicator),TRIM((SALT311.StrType)le.building_area4),TRIM((SALT311.StrType)le.building_area4_indicator),TRIM((SALT311.StrType)le.building_area5),TRIM((SALT311.StrType)le.building_area5_indicator),TRIM((SALT311.StrType)le.building_area6),TRIM((SALT311.StrType)le.building_area6_indicator),TRIM((SALT311.StrType)le.building_area7),TRIM((SALT311.StrType)le.building_area7_indicator),TRIM((SALT311.StrType)le.year_built),TRIM((SALT311.StrType)le.effective_year_built),TRIM((SALT311.StrType)le.no_of_buildings),TRIM((SALT311.StrType)le.no_of_stories),TRIM((SALT311.StrType)le.no_of_units),TRIM((SALT311.StrType)le.no_of_rooms),TRIM((SALT311.StrType)le.no_of_bedrooms),TRIM((SALT311.StrType)le.no_of_baths),TRIM((SALT311.StrType)le.no_of_partial_baths),TRIM((SALT311.StrType)le.no_of_plumbing_fixtures),TRIM((SALT311.StrType)le.garage_type_code),TRIM((SALT311.StrType)le.parking_no_of_cars),TRIM((SALT311.StrType)le.pool_code),TRIM((SALT311.StrType)le.style_code),TRIM((SALT311.StrType)le.type_construction_code),TRIM((SALT311.StrType)le.foundation_code),TRIM((SALT311.StrType)le.building_quality_code),TRIM((SALT311.StrType)le.building_condition_code),TRIM((SALT311.StrType)le.exterior_walls_code),TRIM((SALT311.StrType)le.interior_walls_code),TRIM((SALT311.StrType)le.roof_cover_code),TRIM((SALT311.StrType)le.roof_type_code),TRIM((SALT311.StrType)le.floor_cover_code),TRIM((SALT311.StrType)le.water_code),TRIM((SALT311.StrType)le.sewer_code),TRIM((SALT311.StrType)le.heating_code),TRIM((SALT311.StrType)le.heating_fuel_type_code),TRIM((SALT311.StrType)le.air_conditioning_code),TRIM((SALT311.StrType)le.air_conditioning_type_code),TRIM((SALT311.StrType)le.elevator),TRIM((SALT311.StrType)le.fireplace_indicator),TRIM((SALT311.StrType)le.fireplace_number),TRIM((SALT311.StrType)le.basement_code),TRIM((SALT311.StrType)le.building_class_code),TRIM((SALT311.StrType)le.site_influence1_code),TRIM((SALT311.StrType)le.site_influence2_code),TRIM((SALT311.StrType)le.site_influence3_code),TRIM((SALT311.StrType)le.site_influence4_code),TRIM((SALT311.StrType)le.site_influence5_code),TRIM((SALT311.StrType)le.amenities1_code),TRIM((SALT311.StrType)le.amenities2_code),TRIM((SALT311.StrType)le.amenities3_code),TRIM((SALT311.StrType)le.amenities4_code),TRIM((SALT311.StrType)le.amenities5_code),TRIM((SALT311.StrType)le.amenities2_code1),TRIM((SALT311.StrType)le.amenities2_code2),TRIM((SALT311.StrType)le.amenities2_code3),TRIM((SALT311.StrType)le.amenities2_code4),TRIM((SALT311.StrType)le.amenities2_code5),TRIM((SALT311.StrType)le.extra_features1_area),TRIM((SALT311.StrType)le.extra_features1_indicator),TRIM((SALT311.StrType)le.extra_features2_area),TRIM((SALT311.StrType)le.extra_features2_indicator),TRIM((SALT311.StrType)le.extra_features3_area),TRIM((SALT311.StrType)le.extra_features3_indicator),TRIM((SALT311.StrType)le.extra_features4_area),TRIM((SALT311.StrType)le.extra_features4_indicator),TRIM((SALT311.StrType)le.other_buildings1_code),TRIM((SALT311.StrType)le.other_buildings2_code),TRIM((SALT311.StrType)le.other_buildings3_code),TRIM((SALT311.StrType)le.other_buildings4_code),TRIM((SALT311.StrType)le.other_buildings5_code),TRIM((SALT311.StrType)le.other_impr_building1_indicator),TRIM((SALT311.StrType)le.other_impr_building2_indicator),TRIM((SALT311.StrType)le.other_impr_building3_indicator),TRIM((SALT311.StrType)le.other_impr_building4_indicator),TRIM((SALT311.StrType)le.other_impr_building5_indicator),TRIM((SALT311.StrType)le.other_impr_building_area1),TRIM((SALT311.StrType)le.other_impr_building_area2),TRIM((SALT311.StrType)le.other_impr_building_area3),TRIM((SALT311.StrType)le.other_impr_building_area4),TRIM((SALT311.StrType)le.other_impr_building_area5),TRIM((SALT311.StrType)le.topograpy_code),TRIM((SALT311.StrType)le.neighborhood_code),TRIM((SALT311.StrType)le.condo_project_or_building_name),TRIM((SALT311.StrType)le.assessee_name_indicator),TRIM((SALT311.StrType)le.second_assessee_name_indicator),TRIM((SALT311.StrType)le.other_rooms_indicator),TRIM((SALT311.StrType)le.mail_care_of_name_indicator),TRIM((SALT311.StrType)le.comments),TRIM((SALT311.StrType)le.tape_cut_date),TRIM((SALT311.StrType)le.certification_date),TRIM((SALT311.StrType)le.edition_number),TRIM((SALT311.StrType)le.prop_addr_propagated_ind),TRIM((SALT311.StrType)le.ln_ownership_rights),TRIM((SALT311.StrType)le.ln_relationship_type),TRIM((SALT311.StrType)le.ln_mailing_country_code),TRIM((SALT311.StrType)le.ln_property_name),TRIM((SALT311.StrType)le.ln_property_name_type),TRIM((SALT311.StrType)le.ln_land_use_category),TRIM((SALT311.StrType)le.ln_lot),TRIM((SALT311.StrType)le.ln_block),TRIM((SALT311.StrType)le.ln_unit),TRIM((SALT311.StrType)le.ln_subfloor),TRIM((SALT311.StrType)le.ln_floor_cover),TRIM((SALT311.StrType)le.ln_mobile_home_indicator),TRIM((SALT311.StrType)le.ln_condo_indicator),TRIM((SALT311.StrType)le.ln_property_tax_exemption),TRIM((SALT311.StrType)le.ln_veteran_status),TRIM((SALT311.StrType)le.ln_old_apn_indicator),TRIM((SALT311.StrType)le.fips)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,219,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 219);
  SELF.FldNo2 := 1 + (C % 219);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.ln_fares_id),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.vendor_source_flag),TRIM((SALT311.StrType)le.current_record),TRIM((SALT311.StrType)le.fips_code),TRIM((SALT311.StrType)le.state_code),TRIM((SALT311.StrType)le.county_name),TRIM((SALT311.StrType)le.old_apn),TRIM((SALT311.StrType)le.apna_or_pin_number),TRIM((SALT311.StrType)le.fares_unformatted_apn),TRIM((SALT311.StrType)le.duplicate_apn_multiple_address_id),TRIM((SALT311.StrType)le.assessee_name),TRIM((SALT311.StrType)le.second_assessee_name),TRIM((SALT311.StrType)le.assessee_ownership_rights_code),TRIM((SALT311.StrType)le.assessee_relationship_code),TRIM((SALT311.StrType)le.assessee_phone_number),TRIM((SALT311.StrType)le.tax_account_number),TRIM((SALT311.StrType)le.contract_owner),TRIM((SALT311.StrType)le.assessee_name_type_code),TRIM((SALT311.StrType)le.second_assessee_name_type_code),TRIM((SALT311.StrType)le.mail_care_of_name_type_code),TRIM((SALT311.StrType)le.mailing_care_of_name),TRIM((SALT311.StrType)le.mailing_full_street_address),TRIM((SALT311.StrType)le.mailing_unit_number),TRIM((SALT311.StrType)le.mailing_city_state_zip),TRIM((SALT311.StrType)le.property_full_street_address),TRIM((SALT311.StrType)le.property_unit_number),TRIM((SALT311.StrType)le.property_city_state_zip),TRIM((SALT311.StrType)le.property_country_code),TRIM((SALT311.StrType)le.property_address_code),TRIM((SALT311.StrType)le.legal_lot_code),TRIM((SALT311.StrType)le.legal_lot_number),TRIM((SALT311.StrType)le.legal_land_lot),TRIM((SALT311.StrType)le.legal_block),TRIM((SALT311.StrType)le.legal_section),TRIM((SALT311.StrType)le.legal_district),TRIM((SALT311.StrType)le.legal_unit),TRIM((SALT311.StrType)le.legal_city_municipality_township),TRIM((SALT311.StrType)le.legal_subdivision_name),TRIM((SALT311.StrType)le.legal_phase_number),TRIM((SALT311.StrType)le.legal_tract_number),TRIM((SALT311.StrType)le.legal_sec_twn_rng_mer),TRIM((SALT311.StrType)le.legal_brief_description),TRIM((SALT311.StrType)le.legal_assessor_map_ref),TRIM((SALT311.StrType)le.census_tract),TRIM((SALT311.StrType)le.record_type_code),TRIM((SALT311.StrType)le.ownership_type_code),TRIM((SALT311.StrType)le.new_record_type_code),TRIM((SALT311.StrType)le.state_land_use_code),TRIM((SALT311.StrType)le.county_land_use_code),TRIM((SALT311.StrType)le.county_land_use_description),TRIM((SALT311.StrType)le.standardized_land_use_code),TRIM((SALT311.StrType)le.timeshare_code),TRIM((SALT311.StrType)le.zoning),TRIM((SALT311.StrType)le.owner_occupied),TRIM((SALT311.StrType)le.recorder_document_number),TRIM((SALT311.StrType)le.recorder_book_number),TRIM((SALT311.StrType)le.recorder_page_number),TRIM((SALT311.StrType)le.transfer_date),TRIM((SALT311.StrType)le.recording_date),TRIM((SALT311.StrType)le.sale_date),TRIM((SALT311.StrType)le.document_type),TRIM((SALT311.StrType)le.sales_price),TRIM((SALT311.StrType)le.sales_price_code),TRIM((SALT311.StrType)le.mortgage_loan_amount),TRIM((SALT311.StrType)le.mortgage_loan_type_code),TRIM((SALT311.StrType)le.mortgage_lender_name),TRIM((SALT311.StrType)le.mortgage_lender_type_code),TRIM((SALT311.StrType)le.prior_transfer_date),TRIM((SALT311.StrType)le.prior_recording_date),TRIM((SALT311.StrType)le.prior_sales_price),TRIM((SALT311.StrType)le.prior_sales_price_code),TRIM((SALT311.StrType)le.assessed_land_value),TRIM((SALT311.StrType)le.assessed_improvement_value),TRIM((SALT311.StrType)le.assessed_total_value),TRIM((SALT311.StrType)le.assessed_value_year),TRIM((SALT311.StrType)le.market_land_value),TRIM((SALT311.StrType)le.market_improvement_value),TRIM((SALT311.StrType)le.market_total_value),TRIM((SALT311.StrType)le.market_value_year),TRIM((SALT311.StrType)le.homestead_homeowner_exemption),TRIM((SALT311.StrType)le.tax_exemption1_code),TRIM((SALT311.StrType)le.tax_exemption2_code),TRIM((SALT311.StrType)le.tax_exemption3_code),TRIM((SALT311.StrType)le.tax_exemption4_code),TRIM((SALT311.StrType)le.tax_rate_code_area),TRIM((SALT311.StrType)le.tax_amount),TRIM((SALT311.StrType)le.tax_year),TRIM((SALT311.StrType)le.tax_delinquent_year),TRIM((SALT311.StrType)le.school_tax_district1),TRIM((SALT311.StrType)le.school_tax_district1_indicator),TRIM((SALT311.StrType)le.school_tax_district2),TRIM((SALT311.StrType)le.school_tax_district2_indicator),TRIM((SALT311.StrType)le.school_tax_district3),TRIM((SALT311.StrType)le.school_tax_district3_indicator),TRIM((SALT311.StrType)le.lot_size),TRIM((SALT311.StrType)le.lot_size_acres),TRIM((SALT311.StrType)le.lot_size_frontage_feet),TRIM((SALT311.StrType)le.lot_size_depth_feet),TRIM((SALT311.StrType)le.land_acres),TRIM((SALT311.StrType)le.land_square_footage),TRIM((SALT311.StrType)le.land_dimensions),TRIM((SALT311.StrType)le.building_area),TRIM((SALT311.StrType)le.building_area_indicator),TRIM((SALT311.StrType)le.building_area1),TRIM((SALT311.StrType)le.building_area1_indicator),TRIM((SALT311.StrType)le.building_area2),TRIM((SALT311.StrType)le.building_area2_indicator),TRIM((SALT311.StrType)le.building_area3),TRIM((SALT311.StrType)le.building_area3_indicator),TRIM((SALT311.StrType)le.building_area4),TRIM((SALT311.StrType)le.building_area4_indicator),TRIM((SALT311.StrType)le.building_area5),TRIM((SALT311.StrType)le.building_area5_indicator),TRIM((SALT311.StrType)le.building_area6),TRIM((SALT311.StrType)le.building_area6_indicator),TRIM((SALT311.StrType)le.building_area7),TRIM((SALT311.StrType)le.building_area7_indicator),TRIM((SALT311.StrType)le.year_built),TRIM((SALT311.StrType)le.effective_year_built),TRIM((SALT311.StrType)le.no_of_buildings),TRIM((SALT311.StrType)le.no_of_stories),TRIM((SALT311.StrType)le.no_of_units),TRIM((SALT311.StrType)le.no_of_rooms),TRIM((SALT311.StrType)le.no_of_bedrooms),TRIM((SALT311.StrType)le.no_of_baths),TRIM((SALT311.StrType)le.no_of_partial_baths),TRIM((SALT311.StrType)le.no_of_plumbing_fixtures),TRIM((SALT311.StrType)le.garage_type_code),TRIM((SALT311.StrType)le.parking_no_of_cars),TRIM((SALT311.StrType)le.pool_code),TRIM((SALT311.StrType)le.style_code),TRIM((SALT311.StrType)le.type_construction_code),TRIM((SALT311.StrType)le.foundation_code),TRIM((SALT311.StrType)le.building_quality_code),TRIM((SALT311.StrType)le.building_condition_code),TRIM((SALT311.StrType)le.exterior_walls_code),TRIM((SALT311.StrType)le.interior_walls_code),TRIM((SALT311.StrType)le.roof_cover_code),TRIM((SALT311.StrType)le.roof_type_code),TRIM((SALT311.StrType)le.floor_cover_code),TRIM((SALT311.StrType)le.water_code),TRIM((SALT311.StrType)le.sewer_code),TRIM((SALT311.StrType)le.heating_code),TRIM((SALT311.StrType)le.heating_fuel_type_code),TRIM((SALT311.StrType)le.air_conditioning_code),TRIM((SALT311.StrType)le.air_conditioning_type_code),TRIM((SALT311.StrType)le.elevator),TRIM((SALT311.StrType)le.fireplace_indicator),TRIM((SALT311.StrType)le.fireplace_number),TRIM((SALT311.StrType)le.basement_code),TRIM((SALT311.StrType)le.building_class_code),TRIM((SALT311.StrType)le.site_influence1_code),TRIM((SALT311.StrType)le.site_influence2_code),TRIM((SALT311.StrType)le.site_influence3_code),TRIM((SALT311.StrType)le.site_influence4_code),TRIM((SALT311.StrType)le.site_influence5_code),TRIM((SALT311.StrType)le.amenities1_code),TRIM((SALT311.StrType)le.amenities2_code),TRIM((SALT311.StrType)le.amenities3_code),TRIM((SALT311.StrType)le.amenities4_code),TRIM((SALT311.StrType)le.amenities5_code),TRIM((SALT311.StrType)le.amenities2_code1),TRIM((SALT311.StrType)le.amenities2_code2),TRIM((SALT311.StrType)le.amenities2_code3),TRIM((SALT311.StrType)le.amenities2_code4),TRIM((SALT311.StrType)le.amenities2_code5),TRIM((SALT311.StrType)le.extra_features1_area),TRIM((SALT311.StrType)le.extra_features1_indicator),TRIM((SALT311.StrType)le.extra_features2_area),TRIM((SALT311.StrType)le.extra_features2_indicator),TRIM((SALT311.StrType)le.extra_features3_area),TRIM((SALT311.StrType)le.extra_features3_indicator),TRIM((SALT311.StrType)le.extra_features4_area),TRIM((SALT311.StrType)le.extra_features4_indicator),TRIM((SALT311.StrType)le.other_buildings1_code),TRIM((SALT311.StrType)le.other_buildings2_code),TRIM((SALT311.StrType)le.other_buildings3_code),TRIM((SALT311.StrType)le.other_buildings4_code),TRIM((SALT311.StrType)le.other_buildings5_code),TRIM((SALT311.StrType)le.other_impr_building1_indicator),TRIM((SALT311.StrType)le.other_impr_building2_indicator),TRIM((SALT311.StrType)le.other_impr_building3_indicator),TRIM((SALT311.StrType)le.other_impr_building4_indicator),TRIM((SALT311.StrType)le.other_impr_building5_indicator),TRIM((SALT311.StrType)le.other_impr_building_area1),TRIM((SALT311.StrType)le.other_impr_building_area2),TRIM((SALT311.StrType)le.other_impr_building_area3),TRIM((SALT311.StrType)le.other_impr_building_area4),TRIM((SALT311.StrType)le.other_impr_building_area5),TRIM((SALT311.StrType)le.topograpy_code),TRIM((SALT311.StrType)le.neighborhood_code),TRIM((SALT311.StrType)le.condo_project_or_building_name),TRIM((SALT311.StrType)le.assessee_name_indicator),TRIM((SALT311.StrType)le.second_assessee_name_indicator),TRIM((SALT311.StrType)le.other_rooms_indicator),TRIM((SALT311.StrType)le.mail_care_of_name_indicator),TRIM((SALT311.StrType)le.comments),TRIM((SALT311.StrType)le.tape_cut_date),TRIM((SALT311.StrType)le.certification_date),TRIM((SALT311.StrType)le.edition_number),TRIM((SALT311.StrType)le.prop_addr_propagated_ind),TRIM((SALT311.StrType)le.ln_ownership_rights),TRIM((SALT311.StrType)le.ln_relationship_type),TRIM((SALT311.StrType)le.ln_mailing_country_code),TRIM((SALT311.StrType)le.ln_property_name),TRIM((SALT311.StrType)le.ln_property_name_type),TRIM((SALT311.StrType)le.ln_land_use_category),TRIM((SALT311.StrType)le.ln_lot),TRIM((SALT311.StrType)le.ln_block),TRIM((SALT311.StrType)le.ln_unit),TRIM((SALT311.StrType)le.ln_subfloor),TRIM((SALT311.StrType)le.ln_floor_cover),TRIM((SALT311.StrType)le.ln_mobile_home_indicator),TRIM((SALT311.StrType)le.ln_condo_indicator),TRIM((SALT311.StrType)le.ln_property_tax_exemption),TRIM((SALT311.StrType)le.ln_veteran_status),TRIM((SALT311.StrType)le.ln_old_apn_indicator),TRIM((SALT311.StrType)le.fips)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.ln_fares_id),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.vendor_source_flag),TRIM((SALT311.StrType)le.current_record),TRIM((SALT311.StrType)le.fips_code),TRIM((SALT311.StrType)le.state_code),TRIM((SALT311.StrType)le.county_name),TRIM((SALT311.StrType)le.old_apn),TRIM((SALT311.StrType)le.apna_or_pin_number),TRIM((SALT311.StrType)le.fares_unformatted_apn),TRIM((SALT311.StrType)le.duplicate_apn_multiple_address_id),TRIM((SALT311.StrType)le.assessee_name),TRIM((SALT311.StrType)le.second_assessee_name),TRIM((SALT311.StrType)le.assessee_ownership_rights_code),TRIM((SALT311.StrType)le.assessee_relationship_code),TRIM((SALT311.StrType)le.assessee_phone_number),TRIM((SALT311.StrType)le.tax_account_number),TRIM((SALT311.StrType)le.contract_owner),TRIM((SALT311.StrType)le.assessee_name_type_code),TRIM((SALT311.StrType)le.second_assessee_name_type_code),TRIM((SALT311.StrType)le.mail_care_of_name_type_code),TRIM((SALT311.StrType)le.mailing_care_of_name),TRIM((SALT311.StrType)le.mailing_full_street_address),TRIM((SALT311.StrType)le.mailing_unit_number),TRIM((SALT311.StrType)le.mailing_city_state_zip),TRIM((SALT311.StrType)le.property_full_street_address),TRIM((SALT311.StrType)le.property_unit_number),TRIM((SALT311.StrType)le.property_city_state_zip),TRIM((SALT311.StrType)le.property_country_code),TRIM((SALT311.StrType)le.property_address_code),TRIM((SALT311.StrType)le.legal_lot_code),TRIM((SALT311.StrType)le.legal_lot_number),TRIM((SALT311.StrType)le.legal_land_lot),TRIM((SALT311.StrType)le.legal_block),TRIM((SALT311.StrType)le.legal_section),TRIM((SALT311.StrType)le.legal_district),TRIM((SALT311.StrType)le.legal_unit),TRIM((SALT311.StrType)le.legal_city_municipality_township),TRIM((SALT311.StrType)le.legal_subdivision_name),TRIM((SALT311.StrType)le.legal_phase_number),TRIM((SALT311.StrType)le.legal_tract_number),TRIM((SALT311.StrType)le.legal_sec_twn_rng_mer),TRIM((SALT311.StrType)le.legal_brief_description),TRIM((SALT311.StrType)le.legal_assessor_map_ref),TRIM((SALT311.StrType)le.census_tract),TRIM((SALT311.StrType)le.record_type_code),TRIM((SALT311.StrType)le.ownership_type_code),TRIM((SALT311.StrType)le.new_record_type_code),TRIM((SALT311.StrType)le.state_land_use_code),TRIM((SALT311.StrType)le.county_land_use_code),TRIM((SALT311.StrType)le.county_land_use_description),TRIM((SALT311.StrType)le.standardized_land_use_code),TRIM((SALT311.StrType)le.timeshare_code),TRIM((SALT311.StrType)le.zoning),TRIM((SALT311.StrType)le.owner_occupied),TRIM((SALT311.StrType)le.recorder_document_number),TRIM((SALT311.StrType)le.recorder_book_number),TRIM((SALT311.StrType)le.recorder_page_number),TRIM((SALT311.StrType)le.transfer_date),TRIM((SALT311.StrType)le.recording_date),TRIM((SALT311.StrType)le.sale_date),TRIM((SALT311.StrType)le.document_type),TRIM((SALT311.StrType)le.sales_price),TRIM((SALT311.StrType)le.sales_price_code),TRIM((SALT311.StrType)le.mortgage_loan_amount),TRIM((SALT311.StrType)le.mortgage_loan_type_code),TRIM((SALT311.StrType)le.mortgage_lender_name),TRIM((SALT311.StrType)le.mortgage_lender_type_code),TRIM((SALT311.StrType)le.prior_transfer_date),TRIM((SALT311.StrType)le.prior_recording_date),TRIM((SALT311.StrType)le.prior_sales_price),TRIM((SALT311.StrType)le.prior_sales_price_code),TRIM((SALT311.StrType)le.assessed_land_value),TRIM((SALT311.StrType)le.assessed_improvement_value),TRIM((SALT311.StrType)le.assessed_total_value),TRIM((SALT311.StrType)le.assessed_value_year),TRIM((SALT311.StrType)le.market_land_value),TRIM((SALT311.StrType)le.market_improvement_value),TRIM((SALT311.StrType)le.market_total_value),TRIM((SALT311.StrType)le.market_value_year),TRIM((SALT311.StrType)le.homestead_homeowner_exemption),TRIM((SALT311.StrType)le.tax_exemption1_code),TRIM((SALT311.StrType)le.tax_exemption2_code),TRIM((SALT311.StrType)le.tax_exemption3_code),TRIM((SALT311.StrType)le.tax_exemption4_code),TRIM((SALT311.StrType)le.tax_rate_code_area),TRIM((SALT311.StrType)le.tax_amount),TRIM((SALT311.StrType)le.tax_year),TRIM((SALT311.StrType)le.tax_delinquent_year),TRIM((SALT311.StrType)le.school_tax_district1),TRIM((SALT311.StrType)le.school_tax_district1_indicator),TRIM((SALT311.StrType)le.school_tax_district2),TRIM((SALT311.StrType)le.school_tax_district2_indicator),TRIM((SALT311.StrType)le.school_tax_district3),TRIM((SALT311.StrType)le.school_tax_district3_indicator),TRIM((SALT311.StrType)le.lot_size),TRIM((SALT311.StrType)le.lot_size_acres),TRIM((SALT311.StrType)le.lot_size_frontage_feet),TRIM((SALT311.StrType)le.lot_size_depth_feet),TRIM((SALT311.StrType)le.land_acres),TRIM((SALT311.StrType)le.land_square_footage),TRIM((SALT311.StrType)le.land_dimensions),TRIM((SALT311.StrType)le.building_area),TRIM((SALT311.StrType)le.building_area_indicator),TRIM((SALT311.StrType)le.building_area1),TRIM((SALT311.StrType)le.building_area1_indicator),TRIM((SALT311.StrType)le.building_area2),TRIM((SALT311.StrType)le.building_area2_indicator),TRIM((SALT311.StrType)le.building_area3),TRIM((SALT311.StrType)le.building_area3_indicator),TRIM((SALT311.StrType)le.building_area4),TRIM((SALT311.StrType)le.building_area4_indicator),TRIM((SALT311.StrType)le.building_area5),TRIM((SALT311.StrType)le.building_area5_indicator),TRIM((SALT311.StrType)le.building_area6),TRIM((SALT311.StrType)le.building_area6_indicator),TRIM((SALT311.StrType)le.building_area7),TRIM((SALT311.StrType)le.building_area7_indicator),TRIM((SALT311.StrType)le.year_built),TRIM((SALT311.StrType)le.effective_year_built),TRIM((SALT311.StrType)le.no_of_buildings),TRIM((SALT311.StrType)le.no_of_stories),TRIM((SALT311.StrType)le.no_of_units),TRIM((SALT311.StrType)le.no_of_rooms),TRIM((SALT311.StrType)le.no_of_bedrooms),TRIM((SALT311.StrType)le.no_of_baths),TRIM((SALT311.StrType)le.no_of_partial_baths),TRIM((SALT311.StrType)le.no_of_plumbing_fixtures),TRIM((SALT311.StrType)le.garage_type_code),TRIM((SALT311.StrType)le.parking_no_of_cars),TRIM((SALT311.StrType)le.pool_code),TRIM((SALT311.StrType)le.style_code),TRIM((SALT311.StrType)le.type_construction_code),TRIM((SALT311.StrType)le.foundation_code),TRIM((SALT311.StrType)le.building_quality_code),TRIM((SALT311.StrType)le.building_condition_code),TRIM((SALT311.StrType)le.exterior_walls_code),TRIM((SALT311.StrType)le.interior_walls_code),TRIM((SALT311.StrType)le.roof_cover_code),TRIM((SALT311.StrType)le.roof_type_code),TRIM((SALT311.StrType)le.floor_cover_code),TRIM((SALT311.StrType)le.water_code),TRIM((SALT311.StrType)le.sewer_code),TRIM((SALT311.StrType)le.heating_code),TRIM((SALT311.StrType)le.heating_fuel_type_code),TRIM((SALT311.StrType)le.air_conditioning_code),TRIM((SALT311.StrType)le.air_conditioning_type_code),TRIM((SALT311.StrType)le.elevator),TRIM((SALT311.StrType)le.fireplace_indicator),TRIM((SALT311.StrType)le.fireplace_number),TRIM((SALT311.StrType)le.basement_code),TRIM((SALT311.StrType)le.building_class_code),TRIM((SALT311.StrType)le.site_influence1_code),TRIM((SALT311.StrType)le.site_influence2_code),TRIM((SALT311.StrType)le.site_influence3_code),TRIM((SALT311.StrType)le.site_influence4_code),TRIM((SALT311.StrType)le.site_influence5_code),TRIM((SALT311.StrType)le.amenities1_code),TRIM((SALT311.StrType)le.amenities2_code),TRIM((SALT311.StrType)le.amenities3_code),TRIM((SALT311.StrType)le.amenities4_code),TRIM((SALT311.StrType)le.amenities5_code),TRIM((SALT311.StrType)le.amenities2_code1),TRIM((SALT311.StrType)le.amenities2_code2),TRIM((SALT311.StrType)le.amenities2_code3),TRIM((SALT311.StrType)le.amenities2_code4),TRIM((SALT311.StrType)le.amenities2_code5),TRIM((SALT311.StrType)le.extra_features1_area),TRIM((SALT311.StrType)le.extra_features1_indicator),TRIM((SALT311.StrType)le.extra_features2_area),TRIM((SALT311.StrType)le.extra_features2_indicator),TRIM((SALT311.StrType)le.extra_features3_area),TRIM((SALT311.StrType)le.extra_features3_indicator),TRIM((SALT311.StrType)le.extra_features4_area),TRIM((SALT311.StrType)le.extra_features4_indicator),TRIM((SALT311.StrType)le.other_buildings1_code),TRIM((SALT311.StrType)le.other_buildings2_code),TRIM((SALT311.StrType)le.other_buildings3_code),TRIM((SALT311.StrType)le.other_buildings4_code),TRIM((SALT311.StrType)le.other_buildings5_code),TRIM((SALT311.StrType)le.other_impr_building1_indicator),TRIM((SALT311.StrType)le.other_impr_building2_indicator),TRIM((SALT311.StrType)le.other_impr_building3_indicator),TRIM((SALT311.StrType)le.other_impr_building4_indicator),TRIM((SALT311.StrType)le.other_impr_building5_indicator),TRIM((SALT311.StrType)le.other_impr_building_area1),TRIM((SALT311.StrType)le.other_impr_building_area2),TRIM((SALT311.StrType)le.other_impr_building_area3),TRIM((SALT311.StrType)le.other_impr_building_area4),TRIM((SALT311.StrType)le.other_impr_building_area5),TRIM((SALT311.StrType)le.topograpy_code),TRIM((SALT311.StrType)le.neighborhood_code),TRIM((SALT311.StrType)le.condo_project_or_building_name),TRIM((SALT311.StrType)le.assessee_name_indicator),TRIM((SALT311.StrType)le.second_assessee_name_indicator),TRIM((SALT311.StrType)le.other_rooms_indicator),TRIM((SALT311.StrType)le.mail_care_of_name_indicator),TRIM((SALT311.StrType)le.comments),TRIM((SALT311.StrType)le.tape_cut_date),TRIM((SALT311.StrType)le.certification_date),TRIM((SALT311.StrType)le.edition_number),TRIM((SALT311.StrType)le.prop_addr_propagated_ind),TRIM((SALT311.StrType)le.ln_ownership_rights),TRIM((SALT311.StrType)le.ln_relationship_type),TRIM((SALT311.StrType)le.ln_mailing_country_code),TRIM((SALT311.StrType)le.ln_property_name),TRIM((SALT311.StrType)le.ln_property_name_type),TRIM((SALT311.StrType)le.ln_land_use_category),TRIM((SALT311.StrType)le.ln_lot),TRIM((SALT311.StrType)le.ln_block),TRIM((SALT311.StrType)le.ln_unit),TRIM((SALT311.StrType)le.ln_subfloor),TRIM((SALT311.StrType)le.ln_floor_cover),TRIM((SALT311.StrType)le.ln_mobile_home_indicator),TRIM((SALT311.StrType)le.ln_condo_indicator),TRIM((SALT311.StrType)le.ln_property_tax_exemption),TRIM((SALT311.StrType)le.ln_veteran_status),TRIM((SALT311.StrType)le.ln_old_apn_indicator),TRIM((SALT311.StrType)le.fips)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),219*219,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'ln_fares_id'}
      ,{2,'process_date'}
      ,{3,'vendor_source_flag'}
      ,{4,'current_record'}
      ,{5,'fips_code'}
      ,{6,'state_code'}
      ,{7,'county_name'}
      ,{8,'old_apn'}
      ,{9,'apna_or_pin_number'}
      ,{10,'fares_unformatted_apn'}
      ,{11,'duplicate_apn_multiple_address_id'}
      ,{12,'assessee_name'}
      ,{13,'second_assessee_name'}
      ,{14,'assessee_ownership_rights_code'}
      ,{15,'assessee_relationship_code'}
      ,{16,'assessee_phone_number'}
      ,{17,'tax_account_number'}
      ,{18,'contract_owner'}
      ,{19,'assessee_name_type_code'}
      ,{20,'second_assessee_name_type_code'}
      ,{21,'mail_care_of_name_type_code'}
      ,{22,'mailing_care_of_name'}
      ,{23,'mailing_full_street_address'}
      ,{24,'mailing_unit_number'}
      ,{25,'mailing_city_state_zip'}
      ,{26,'property_full_street_address'}
      ,{27,'property_unit_number'}
      ,{28,'property_city_state_zip'}
      ,{29,'property_country_code'}
      ,{30,'property_address_code'}
      ,{31,'legal_lot_code'}
      ,{32,'legal_lot_number'}
      ,{33,'legal_land_lot'}
      ,{34,'legal_block'}
      ,{35,'legal_section'}
      ,{36,'legal_district'}
      ,{37,'legal_unit'}
      ,{38,'legal_city_municipality_township'}
      ,{39,'legal_subdivision_name'}
      ,{40,'legal_phase_number'}
      ,{41,'legal_tract_number'}
      ,{42,'legal_sec_twn_rng_mer'}
      ,{43,'legal_brief_description'}
      ,{44,'legal_assessor_map_ref'}
      ,{45,'census_tract'}
      ,{46,'record_type_code'}
      ,{47,'ownership_type_code'}
      ,{48,'new_record_type_code'}
      ,{49,'state_land_use_code'}
      ,{50,'county_land_use_code'}
      ,{51,'county_land_use_description'}
      ,{52,'standardized_land_use_code'}
      ,{53,'timeshare_code'}
      ,{54,'zoning'}
      ,{55,'owner_occupied'}
      ,{56,'recorder_document_number'}
      ,{57,'recorder_book_number'}
      ,{58,'recorder_page_number'}
      ,{59,'transfer_date'}
      ,{60,'recording_date'}
      ,{61,'sale_date'}
      ,{62,'document_type'}
      ,{63,'sales_price'}
      ,{64,'sales_price_code'}
      ,{65,'mortgage_loan_amount'}
      ,{66,'mortgage_loan_type_code'}
      ,{67,'mortgage_lender_name'}
      ,{68,'mortgage_lender_type_code'}
      ,{69,'prior_transfer_date'}
      ,{70,'prior_recording_date'}
      ,{71,'prior_sales_price'}
      ,{72,'prior_sales_price_code'}
      ,{73,'assessed_land_value'}
      ,{74,'assessed_improvement_value'}
      ,{75,'assessed_total_value'}
      ,{76,'assessed_value_year'}
      ,{77,'market_land_value'}
      ,{78,'market_improvement_value'}
      ,{79,'market_total_value'}
      ,{80,'market_value_year'}
      ,{81,'homestead_homeowner_exemption'}
      ,{82,'tax_exemption1_code'}
      ,{83,'tax_exemption2_code'}
      ,{84,'tax_exemption3_code'}
      ,{85,'tax_exemption4_code'}
      ,{86,'tax_rate_code_area'}
      ,{87,'tax_amount'}
      ,{88,'tax_year'}
      ,{89,'tax_delinquent_year'}
      ,{90,'school_tax_district1'}
      ,{91,'school_tax_district1_indicator'}
      ,{92,'school_tax_district2'}
      ,{93,'school_tax_district2_indicator'}
      ,{94,'school_tax_district3'}
      ,{95,'school_tax_district3_indicator'}
      ,{96,'lot_size'}
      ,{97,'lot_size_acres'}
      ,{98,'lot_size_frontage_feet'}
      ,{99,'lot_size_depth_feet'}
      ,{100,'land_acres'}
      ,{101,'land_square_footage'}
      ,{102,'land_dimensions'}
      ,{103,'building_area'}
      ,{104,'building_area_indicator'}
      ,{105,'building_area1'}
      ,{106,'building_area1_indicator'}
      ,{107,'building_area2'}
      ,{108,'building_area2_indicator'}
      ,{109,'building_area3'}
      ,{110,'building_area3_indicator'}
      ,{111,'building_area4'}
      ,{112,'building_area4_indicator'}
      ,{113,'building_area5'}
      ,{114,'building_area5_indicator'}
      ,{115,'building_area6'}
      ,{116,'building_area6_indicator'}
      ,{117,'building_area7'}
      ,{118,'building_area7_indicator'}
      ,{119,'year_built'}
      ,{120,'effective_year_built'}
      ,{121,'no_of_buildings'}
      ,{122,'no_of_stories'}
      ,{123,'no_of_units'}
      ,{124,'no_of_rooms'}
      ,{125,'no_of_bedrooms'}
      ,{126,'no_of_baths'}
      ,{127,'no_of_partial_baths'}
      ,{128,'no_of_plumbing_fixtures'}
      ,{129,'garage_type_code'}
      ,{130,'parking_no_of_cars'}
      ,{131,'pool_code'}
      ,{132,'style_code'}
      ,{133,'type_construction_code'}
      ,{134,'foundation_code'}
      ,{135,'building_quality_code'}
      ,{136,'building_condition_code'}
      ,{137,'exterior_walls_code'}
      ,{138,'interior_walls_code'}
      ,{139,'roof_cover_code'}
      ,{140,'roof_type_code'}
      ,{141,'floor_cover_code'}
      ,{142,'water_code'}
      ,{143,'sewer_code'}
      ,{144,'heating_code'}
      ,{145,'heating_fuel_type_code'}
      ,{146,'air_conditioning_code'}
      ,{147,'air_conditioning_type_code'}
      ,{148,'elevator'}
      ,{149,'fireplace_indicator'}
      ,{150,'fireplace_number'}
      ,{151,'basement_code'}
      ,{152,'building_class_code'}
      ,{153,'site_influence1_code'}
      ,{154,'site_influence2_code'}
      ,{155,'site_influence3_code'}
      ,{156,'site_influence4_code'}
      ,{157,'site_influence5_code'}
      ,{158,'amenities1_code'}
      ,{159,'amenities2_code'}
      ,{160,'amenities3_code'}
      ,{161,'amenities4_code'}
      ,{162,'amenities5_code'}
      ,{163,'amenities2_code1'}
      ,{164,'amenities2_code2'}
      ,{165,'amenities2_code3'}
      ,{166,'amenities2_code4'}
      ,{167,'amenities2_code5'}
      ,{168,'extra_features1_area'}
      ,{169,'extra_features1_indicator'}
      ,{170,'extra_features2_area'}
      ,{171,'extra_features2_indicator'}
      ,{172,'extra_features3_area'}
      ,{173,'extra_features3_indicator'}
      ,{174,'extra_features4_area'}
      ,{175,'extra_features4_indicator'}
      ,{176,'other_buildings1_code'}
      ,{177,'other_buildings2_code'}
      ,{178,'other_buildings3_code'}
      ,{179,'other_buildings4_code'}
      ,{180,'other_buildings5_code'}
      ,{181,'other_impr_building1_indicator'}
      ,{182,'other_impr_building2_indicator'}
      ,{183,'other_impr_building3_indicator'}
      ,{184,'other_impr_building4_indicator'}
      ,{185,'other_impr_building5_indicator'}
      ,{186,'other_impr_building_area1'}
      ,{187,'other_impr_building_area2'}
      ,{188,'other_impr_building_area3'}
      ,{189,'other_impr_building_area4'}
      ,{190,'other_impr_building_area5'}
      ,{191,'topograpy_code'}
      ,{192,'neighborhood_code'}
      ,{193,'condo_project_or_building_name'}
      ,{194,'assessee_name_indicator'}
      ,{195,'second_assessee_name_indicator'}
      ,{196,'other_rooms_indicator'}
      ,{197,'mail_care_of_name_indicator'}
      ,{198,'comments'}
      ,{199,'tape_cut_date'}
      ,{200,'certification_date'}
      ,{201,'edition_number'}
      ,{202,'prop_addr_propagated_ind'}
      ,{203,'ln_ownership_rights'}
      ,{204,'ln_relationship_type'}
      ,{205,'ln_mailing_country_code'}
      ,{206,'ln_property_name'}
      ,{207,'ln_property_name_type'}
      ,{208,'ln_land_use_category'}
      ,{209,'ln_lot'}
      ,{210,'ln_block'}
      ,{211,'ln_unit'}
      ,{212,'ln_subfloor'}
      ,{213,'ln_floor_cover'}
      ,{214,'ln_mobile_home_indicator'}
      ,{215,'ln_condo_indicator'}
      ,{216,'ln_property_tax_exemption'}
      ,{217,'ln_veteran_status'}
      ,{218,'ln_old_apn_indicator'}
      ,{219,'fips'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.fips_code) fips_code; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_ln_fares_id((SALT311.StrType)le.ln_fares_id),
    Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Fields.InValid_vendor_source_flag((SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_current_record((SALT311.StrType)le.current_record),
    Fields.InValid_fips_code((SALT311.StrType)le.fips_code),
    Fields.InValid_state_code((SALT311.StrType)le.state_code),
    Fields.InValid_county_name((SALT311.StrType)le.county_name),
    Fields.InValid_old_apn((SALT311.StrType)le.old_apn),
    Fields.InValid_apna_or_pin_number((SALT311.StrType)le.apna_or_pin_number),
    Fields.InValid_fares_unformatted_apn((SALT311.StrType)le.fares_unformatted_apn),
    Fields.InValid_duplicate_apn_multiple_address_id((SALT311.StrType)le.duplicate_apn_multiple_address_id),
    Fields.InValid_assessee_name((SALT311.StrType)le.assessee_name),
    Fields.InValid_second_assessee_name((SALT311.StrType)le.second_assessee_name),
    Fields.InValid_assessee_ownership_rights_code((SALT311.StrType)le.assessee_ownership_rights_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_assessee_relationship_code((SALT311.StrType)le.assessee_relationship_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_assessee_phone_number((SALT311.StrType)le.assessee_phone_number),
    Fields.InValid_tax_account_number((SALT311.StrType)le.tax_account_number),
    Fields.InValid_contract_owner((SALT311.StrType)le.contract_owner),
    Fields.InValid_assessee_name_type_code((SALT311.StrType)le.assessee_name_type_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_second_assessee_name_type_code((SALT311.StrType)le.second_assessee_name_type_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_mail_care_of_name_type_code((SALT311.StrType)le.mail_care_of_name_type_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_mailing_care_of_name((SALT311.StrType)le.mailing_care_of_name),
    Fields.InValid_mailing_full_street_address((SALT311.StrType)le.mailing_full_street_address),
    Fields.InValid_mailing_unit_number((SALT311.StrType)le.mailing_unit_number),
    Fields.InValid_mailing_city_state_zip((SALT311.StrType)le.mailing_city_state_zip),
    Fields.InValid_property_full_street_address((SALT311.StrType)le.property_full_street_address),
    Fields.InValid_property_unit_number((SALT311.StrType)le.property_unit_number),
    Fields.InValid_property_city_state_zip((SALT311.StrType)le.property_city_state_zip),
    Fields.InValid_property_country_code((SALT311.StrType)le.property_country_code),
    Fields.InValid_property_address_code((SALT311.StrType)le.property_address_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_legal_lot_code((SALT311.StrType)le.legal_lot_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_legal_lot_number((SALT311.StrType)le.legal_lot_number),
    Fields.InValid_legal_land_lot((SALT311.StrType)le.legal_land_lot),
    Fields.InValid_legal_block((SALT311.StrType)le.legal_block),
    Fields.InValid_legal_section((SALT311.StrType)le.legal_section),
    Fields.InValid_legal_district((SALT311.StrType)le.legal_district),
    Fields.InValid_legal_unit((SALT311.StrType)le.legal_unit),
    Fields.InValid_legal_city_municipality_township((SALT311.StrType)le.legal_city_municipality_township),
    Fields.InValid_legal_subdivision_name((SALT311.StrType)le.legal_subdivision_name),
    Fields.InValid_legal_phase_number((SALT311.StrType)le.legal_phase_number),
    Fields.InValid_legal_tract_number((SALT311.StrType)le.legal_tract_number),
    Fields.InValid_legal_sec_twn_rng_mer((SALT311.StrType)le.legal_sec_twn_rng_mer),
    Fields.InValid_legal_brief_description((SALT311.StrType)le.legal_brief_description),
    Fields.InValid_legal_assessor_map_ref((SALT311.StrType)le.legal_assessor_map_ref),
    Fields.InValid_census_tract((SALT311.StrType)le.census_tract),
    Fields.InValid_record_type_code((SALT311.StrType)le.record_type_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_ownership_type_code((SALT311.StrType)le.ownership_type_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_new_record_type_code((SALT311.StrType)le.new_record_type_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_state_land_use_code((SALT311.StrType)le.state_land_use_code),
    Fields.InValid_county_land_use_code((SALT311.StrType)le.county_land_use_code),
    Fields.InValid_county_land_use_description((SALT311.StrType)le.county_land_use_description),
    Fields.InValid_standardized_land_use_code((SALT311.StrType)le.standardized_land_use_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_timeshare_code((SALT311.StrType)le.timeshare_code),
    Fields.InValid_zoning((SALT311.StrType)le.zoning),
    Fields.InValid_owner_occupied((SALT311.StrType)le.owner_occupied),
    Fields.InValid_recorder_document_number((SALT311.StrType)le.recorder_document_number),
    Fields.InValid_recorder_book_number((SALT311.StrType)le.recorder_book_number),
    Fields.InValid_recorder_page_number((SALT311.StrType)le.recorder_page_number),
    Fields.InValid_transfer_date((SALT311.StrType)le.transfer_date),
    Fields.InValid_recording_date((SALT311.StrType)le.recording_date),
    Fields.InValid_sale_date((SALT311.StrType)le.sale_date),
    Fields.InValid_document_type((SALT311.StrType)le.document_type,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_sales_price((SALT311.StrType)le.sales_price),
    Fields.InValid_sales_price_code((SALT311.StrType)le.sales_price_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_mortgage_loan_amount((SALT311.StrType)le.mortgage_loan_amount),
    Fields.InValid_mortgage_loan_type_code((SALT311.StrType)le.mortgage_loan_type_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_mortgage_lender_name((SALT311.StrType)le.mortgage_lender_name),
    Fields.InValid_mortgage_lender_type_code((SALT311.StrType)le.mortgage_lender_type_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_prior_transfer_date((SALT311.StrType)le.prior_transfer_date),
    Fields.InValid_prior_recording_date((SALT311.StrType)le.prior_recording_date),
    Fields.InValid_prior_sales_price((SALT311.StrType)le.prior_sales_price),
    Fields.InValid_prior_sales_price_code((SALT311.StrType)le.prior_sales_price_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_assessed_land_value((SALT311.StrType)le.assessed_land_value),
    Fields.InValid_assessed_improvement_value((SALT311.StrType)le.assessed_improvement_value),
    Fields.InValid_assessed_total_value((SALT311.StrType)le.assessed_total_value),
    Fields.InValid_assessed_value_year((SALT311.StrType)le.assessed_value_year),
    Fields.InValid_market_land_value((SALT311.StrType)le.market_land_value),
    Fields.InValid_market_improvement_value((SALT311.StrType)le.market_improvement_value),
    Fields.InValid_market_total_value((SALT311.StrType)le.market_total_value),
    Fields.InValid_market_value_year((SALT311.StrType)le.market_value_year),
    Fields.InValid_homestead_homeowner_exemption((SALT311.StrType)le.homestead_homeowner_exemption),
    Fields.InValid_tax_exemption1_code((SALT311.StrType)le.tax_exemption1_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_tax_exemption2_code((SALT311.StrType)le.tax_exemption2_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_tax_exemption3_code((SALT311.StrType)le.tax_exemption3_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_tax_exemption4_code((SALT311.StrType)le.tax_exemption4_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_tax_rate_code_area((SALT311.StrType)le.tax_rate_code_area),
    Fields.InValid_tax_amount((SALT311.StrType)le.tax_amount),
    Fields.InValid_tax_year((SALT311.StrType)le.tax_year),
    Fields.InValid_tax_delinquent_year((SALT311.StrType)le.tax_delinquent_year),
    Fields.InValid_school_tax_district1((SALT311.StrType)le.school_tax_district1),
    Fields.InValid_school_tax_district1_indicator((SALT311.StrType)le.school_tax_district1_indicator),
    Fields.InValid_school_tax_district2((SALT311.StrType)le.school_tax_district2),
    Fields.InValid_school_tax_district2_indicator((SALT311.StrType)le.school_tax_district2_indicator),
    Fields.InValid_school_tax_district3((SALT311.StrType)le.school_tax_district3),
    Fields.InValid_school_tax_district3_indicator((SALT311.StrType)le.school_tax_district3_indicator),
    Fields.InValid_lot_size((SALT311.StrType)le.lot_size),
    Fields.InValid_lot_size_acres((SALT311.StrType)le.lot_size_acres),
    Fields.InValid_lot_size_frontage_feet((SALT311.StrType)le.lot_size_frontage_feet),
    Fields.InValid_lot_size_depth_feet((SALT311.StrType)le.lot_size_depth_feet),
    Fields.InValid_land_acres((SALT311.StrType)le.land_acres),
    Fields.InValid_land_square_footage((SALT311.StrType)le.land_square_footage),
    Fields.InValid_land_dimensions((SALT311.StrType)le.land_dimensions),
    Fields.InValid_building_area((SALT311.StrType)le.building_area,(SALT311.StrType)le.sales_price),
    Fields.InValid_building_area_indicator((SALT311.StrType)le.building_area_indicator,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_building_area1((SALT311.StrType)le.building_area1,(SALT311.StrType)le.sales_price),
    Fields.InValid_building_area1_indicator((SALT311.StrType)le.building_area1_indicator,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_building_area2((SALT311.StrType)le.building_area2,(SALT311.StrType)le.sales_price),
    Fields.InValid_building_area2_indicator((SALT311.StrType)le.building_area2_indicator,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_building_area3((SALT311.StrType)le.building_area3,(SALT311.StrType)le.sales_price),
    Fields.InValid_building_area3_indicator((SALT311.StrType)le.building_area3_indicator,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_building_area4((SALT311.StrType)le.building_area4,(SALT311.StrType)le.sales_price),
    Fields.InValid_building_area4_indicator((SALT311.StrType)le.building_area4_indicator,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_building_area5((SALT311.StrType)le.building_area5,(SALT311.StrType)le.sales_price),
    Fields.InValid_building_area5_indicator((SALT311.StrType)le.building_area5_indicator,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_building_area6((SALT311.StrType)le.building_area6,(SALT311.StrType)le.sales_price),
    Fields.InValid_building_area6_indicator((SALT311.StrType)le.building_area6_indicator,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_building_area7((SALT311.StrType)le.building_area7,(SALT311.StrType)le.sales_price),
    Fields.InValid_building_area7_indicator((SALT311.StrType)le.building_area7_indicator,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_year_built((SALT311.StrType)le.year_built),
    Fields.InValid_effective_year_built((SALT311.StrType)le.effective_year_built),
    Fields.InValid_no_of_buildings((SALT311.StrType)le.no_of_buildings),
    Fields.InValid_no_of_stories((SALT311.StrType)le.no_of_stories),
    Fields.InValid_no_of_units((SALT311.StrType)le.no_of_units),
    Fields.InValid_no_of_rooms((SALT311.StrType)le.no_of_rooms),
    Fields.InValid_no_of_bedrooms((SALT311.StrType)le.no_of_bedrooms),
    Fields.InValid_no_of_baths((SALT311.StrType)le.no_of_baths),
    Fields.InValid_no_of_partial_baths((SALT311.StrType)le.no_of_partial_baths),
    Fields.InValid_no_of_plumbing_fixtures((SALT311.StrType)le.no_of_plumbing_fixtures),
    Fields.InValid_garage_type_code((SALT311.StrType)le.garage_type_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_parking_no_of_cars((SALT311.StrType)le.parking_no_of_cars),
    Fields.InValid_pool_code((SALT311.StrType)le.pool_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_style_code((SALT311.StrType)le.style_code),
    Fields.InValid_type_construction_code((SALT311.StrType)le.type_construction_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_foundation_code((SALT311.StrType)le.foundation_code),
    Fields.InValid_building_quality_code((SALT311.StrType)le.building_quality_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_building_condition_code((SALT311.StrType)le.building_condition_code),
    Fields.InValid_exterior_walls_code((SALT311.StrType)le.exterior_walls_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_interior_walls_code((SALT311.StrType)le.interior_walls_code),
    Fields.InValid_roof_cover_code((SALT311.StrType)le.roof_cover_code),
    Fields.InValid_roof_type_code((SALT311.StrType)le.roof_type_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_floor_cover_code((SALT311.StrType)le.floor_cover_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_water_code((SALT311.StrType)le.water_code),
    Fields.InValid_sewer_code((SALT311.StrType)le.sewer_code),
    Fields.InValid_heating_code((SALT311.StrType)le.heating_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_heating_fuel_type_code((SALT311.StrType)le.heating_fuel_type_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_air_conditioning_code((SALT311.StrType)le.air_conditioning_code),
    Fields.InValid_air_conditioning_type_code((SALT311.StrType)le.air_conditioning_type_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_elevator((SALT311.StrType)le.elevator),
    Fields.InValid_fireplace_indicator((SALT311.StrType)le.fireplace_indicator,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_fireplace_number((SALT311.StrType)le.fireplace_number),
    Fields.InValid_basement_code((SALT311.StrType)le.basement_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_building_class_code((SALT311.StrType)le.building_class_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_site_influence1_code((SALT311.StrType)le.site_influence1_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_site_influence2_code((SALT311.StrType)le.site_influence2_code),
    Fields.InValid_site_influence3_code((SALT311.StrType)le.site_influence3_code),
    Fields.InValid_site_influence4_code((SALT311.StrType)le.site_influence4_code),
    Fields.InValid_site_influence5_code((SALT311.StrType)le.site_influence5_code),
    Fields.InValid_amenities1_code((SALT311.StrType)le.amenities1_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_amenities2_code((SALT311.StrType)le.amenities2_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_amenities3_code((SALT311.StrType)le.amenities3_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_amenities4_code((SALT311.StrType)le.amenities4_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_amenities5_code((SALT311.StrType)le.amenities5_code),
    Fields.InValid_amenities2_code1((SALT311.StrType)le.amenities2_code1),
    Fields.InValid_amenities2_code2((SALT311.StrType)le.amenities2_code2),
    Fields.InValid_amenities2_code3((SALT311.StrType)le.amenities2_code3),
    Fields.InValid_amenities2_code4((SALT311.StrType)le.amenities2_code4),
    Fields.InValid_amenities2_code5((SALT311.StrType)le.amenities2_code5),
    Fields.InValid_extra_features1_area((SALT311.StrType)le.extra_features1_area),
    Fields.InValid_extra_features1_indicator((SALT311.StrType)le.extra_features1_indicator),
    Fields.InValid_extra_features2_area((SALT311.StrType)le.extra_features2_area),
    Fields.InValid_extra_features2_indicator((SALT311.StrType)le.extra_features2_indicator),
    Fields.InValid_extra_features3_area((SALT311.StrType)le.extra_features3_area),
    Fields.InValid_extra_features3_indicator((SALT311.StrType)le.extra_features3_indicator),
    Fields.InValid_extra_features4_area((SALT311.StrType)le.extra_features4_area),
    Fields.InValid_extra_features4_indicator((SALT311.StrType)le.extra_features4_indicator),
    Fields.InValid_other_buildings1_code((SALT311.StrType)le.other_buildings1_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_other_buildings2_code((SALT311.StrType)le.other_buildings2_code),
    Fields.InValid_other_buildings3_code((SALT311.StrType)le.other_buildings3_code),
    Fields.InValid_other_buildings4_code((SALT311.StrType)le.other_buildings4_code),
    Fields.InValid_other_buildings5_code((SALT311.StrType)le.other_buildings5_code),
    Fields.InValid_other_impr_building1_indicator((SALT311.StrType)le.other_impr_building1_indicator),
    Fields.InValid_other_impr_building2_indicator((SALT311.StrType)le.other_impr_building2_indicator),
    Fields.InValid_other_impr_building3_indicator((SALT311.StrType)le.other_impr_building3_indicator),
    Fields.InValid_other_impr_building4_indicator((SALT311.StrType)le.other_impr_building4_indicator),
    Fields.InValid_other_impr_building5_indicator((SALT311.StrType)le.other_impr_building5_indicator),
    Fields.InValid_other_impr_building_area1((SALT311.StrType)le.other_impr_building_area1),
    Fields.InValid_other_impr_building_area2((SALT311.StrType)le.other_impr_building_area2),
    Fields.InValid_other_impr_building_area3((SALT311.StrType)le.other_impr_building_area3),
    Fields.InValid_other_impr_building_area4((SALT311.StrType)le.other_impr_building_area4),
    Fields.InValid_other_impr_building_area5((SALT311.StrType)le.other_impr_building_area5),
    Fields.InValid_topograpy_code((SALT311.StrType)le.topograpy_code),
    Fields.InValid_neighborhood_code((SALT311.StrType)le.neighborhood_code),
    Fields.InValid_condo_project_or_building_name((SALT311.StrType)le.condo_project_or_building_name),
    Fields.InValid_assessee_name_indicator((SALT311.StrType)le.assessee_name_indicator),
    Fields.InValid_second_assessee_name_indicator((SALT311.StrType)le.second_assessee_name_indicator),
    Fields.InValid_other_rooms_indicator((SALT311.StrType)le.other_rooms_indicator),
    Fields.InValid_mail_care_of_name_indicator((SALT311.StrType)le.mail_care_of_name_indicator),
    Fields.InValid_comments((SALT311.StrType)le.comments),
    Fields.InValid_tape_cut_date((SALT311.StrType)le.tape_cut_date),
    Fields.InValid_certification_date((SALT311.StrType)le.certification_date),
    Fields.InValid_edition_number((SALT311.StrType)le.edition_number),
    Fields.InValid_prop_addr_propagated_ind((SALT311.StrType)le.prop_addr_propagated_ind),
    Fields.InValid_ln_ownership_rights((SALT311.StrType)le.ln_ownership_rights),
    Fields.InValid_ln_relationship_type((SALT311.StrType)le.ln_relationship_type),
    Fields.InValid_ln_mailing_country_code((SALT311.StrType)le.ln_mailing_country_code),
    Fields.InValid_ln_property_name((SALT311.StrType)le.ln_property_name),
    Fields.InValid_ln_property_name_type((SALT311.StrType)le.ln_property_name_type),
    Fields.InValid_ln_land_use_category((SALT311.StrType)le.ln_land_use_category),
    Fields.InValid_ln_lot((SALT311.StrType)le.ln_lot),
    Fields.InValid_ln_block((SALT311.StrType)le.ln_block),
    Fields.InValid_ln_unit((SALT311.StrType)le.ln_unit),
    Fields.InValid_ln_subfloor((SALT311.StrType)le.ln_subfloor),
    Fields.InValid_ln_floor_cover((SALT311.StrType)le.ln_floor_cover),
    Fields.InValid_ln_mobile_home_indicator((SALT311.StrType)le.ln_mobile_home_indicator),
    Fields.InValid_ln_condo_indicator((SALT311.StrType)le.ln_condo_indicator),
    Fields.InValid_ln_property_tax_exemption((SALT311.StrType)le.ln_property_tax_exemption),
    Fields.InValid_ln_veteran_status((SALT311.StrType)le.ln_veteran_status),
    Fields.InValid_ln_old_apn_indicator((SALT311.StrType)le.ln_old_apn_indicator),
    Fields.InValid_fips((SALT311.StrType)le.fips),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.fips_code := le.fips_code;
END;
Errors := NORMALIZE(h,219,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.fips_code;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,fips_code,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.fips_code;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','invalid_date','Unknown','Unknown','invalid_fips','invalid_state_code','invalid_county_name','Unknown','invalid_apn','Unknown','Unknown','invalid_alpha','invalid_alpha','invalid_ownership_rights_code','invalid_relationship_code','invalid_phone','Unknown','Unknown','invalid_name_type_code','invalid_second_name_type_code','invalid_mail_care_of_name_type_code','invalid_alpha','invalid_address','invalid_address','invalid_csz','invalid_address','invalid_address','invalid_csz','Unknown','invalid_property_address_code','invalid_legal_lot_code','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_record_type_code','invalid_ownership_type_code','invalid_new_record_type_code','Unknown','Unknown','Unknown','invalid_land_use','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','invalid_date','invalid_date','invalid_document_type_code','invalid_prop_amount','invalid_sale_code','invalid_prop_amount','invalid_mortgage_loan_type_code','invalid_alpha','invalid_mortgage_lender_type_code','invalid_date','invalid_date','invalid_prop_amount','invalid_prior_sales_price_code','invalid_prop_amount','invalid_prop_amount','invalid_prop_amount','invalid_year','invalid_prop_amount','invalid_prop_amount','invalid_prop_amount','invalid_year','Unknown','invalid_tax_exemption1_code','invalid_tax_exemption2_code','invalid_tax_exemption3_code','invalid_tax_exemption4_code','Unknown','invalid_tax_amount','invalid_year','invalid_year','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_building_area','invalid_building_area_indicator','invalid_building_area','invalid_building_area1_indicator','invalid_building_area','invalid_building_area2_indicator','invalid_building_area','invalid_building_area3_indicator','invalid_building_area','invalid_building_area4_indicator','invalid_building_area','invalid_building_area5_indicator','invalid_building_area','invalid_building_area6_indicator','invalid_building_area','invalid_building_area7_indicator','invalid_year','invalid_year','Unknown','invalid_no_of_stories','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_garage_type_code','Unknown','invalid_pool_code','Unknown','invalid_construction_type','Unknown','invalid_building_quality_code','Unknown','invalid_exterior_walls_code','Unknown','Unknown','invalid_roof_type_code','invalid_floor_cover_code','Unknown','Unknown','invalid_heating_code','invalid_heating_fuel_type_code','Unknown','invalid_air_conditioning_type_code','Unknown','invalid_fireplace_indicator','Unknown','invalid_basement_code','invalid_building_class_code','invalid_site_influence1_code','Unknown','Unknown','Unknown','Unknown','invalid_amenities1_code','invalid_amenities2_code','invalid_amenities3_code','invalid_amenities4_code','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_other_buildings1_code','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_fips');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_ln_fares_id(TotalErrors.ErrorNum),Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_vendor_source_flag(TotalErrors.ErrorNum),Fields.InValidMessage_current_record(TotalErrors.ErrorNum),Fields.InValidMessage_fips_code(TotalErrors.ErrorNum),Fields.InValidMessage_state_code(TotalErrors.ErrorNum),Fields.InValidMessage_county_name(TotalErrors.ErrorNum),Fields.InValidMessage_old_apn(TotalErrors.ErrorNum),Fields.InValidMessage_apna_or_pin_number(TotalErrors.ErrorNum),Fields.InValidMessage_fares_unformatted_apn(TotalErrors.ErrorNum),Fields.InValidMessage_duplicate_apn_multiple_address_id(TotalErrors.ErrorNum),Fields.InValidMessage_assessee_name(TotalErrors.ErrorNum),Fields.InValidMessage_second_assessee_name(TotalErrors.ErrorNum),Fields.InValidMessage_assessee_ownership_rights_code(TotalErrors.ErrorNum),Fields.InValidMessage_assessee_relationship_code(TotalErrors.ErrorNum),Fields.InValidMessage_assessee_phone_number(TotalErrors.ErrorNum),Fields.InValidMessage_tax_account_number(TotalErrors.ErrorNum),Fields.InValidMessage_contract_owner(TotalErrors.ErrorNum),Fields.InValidMessage_assessee_name_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_second_assessee_name_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_mail_care_of_name_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_mailing_care_of_name(TotalErrors.ErrorNum),Fields.InValidMessage_mailing_full_street_address(TotalErrors.ErrorNum),Fields.InValidMessage_mailing_unit_number(TotalErrors.ErrorNum),Fields.InValidMessage_mailing_city_state_zip(TotalErrors.ErrorNum),Fields.InValidMessage_property_full_street_address(TotalErrors.ErrorNum),Fields.InValidMessage_property_unit_number(TotalErrors.ErrorNum),Fields.InValidMessage_property_city_state_zip(TotalErrors.ErrorNum),Fields.InValidMessage_property_country_code(TotalErrors.ErrorNum),Fields.InValidMessage_property_address_code(TotalErrors.ErrorNum),Fields.InValidMessage_legal_lot_code(TotalErrors.ErrorNum),Fields.InValidMessage_legal_lot_number(TotalErrors.ErrorNum),Fields.InValidMessage_legal_land_lot(TotalErrors.ErrorNum),Fields.InValidMessage_legal_block(TotalErrors.ErrorNum),Fields.InValidMessage_legal_section(TotalErrors.ErrorNum),Fields.InValidMessage_legal_district(TotalErrors.ErrorNum),Fields.InValidMessage_legal_unit(TotalErrors.ErrorNum),Fields.InValidMessage_legal_city_municipality_township(TotalErrors.ErrorNum),Fields.InValidMessage_legal_subdivision_name(TotalErrors.ErrorNum),Fields.InValidMessage_legal_phase_number(TotalErrors.ErrorNum),Fields.InValidMessage_legal_tract_number(TotalErrors.ErrorNum),Fields.InValidMessage_legal_sec_twn_rng_mer(TotalErrors.ErrorNum),Fields.InValidMessage_legal_brief_description(TotalErrors.ErrorNum),Fields.InValidMessage_legal_assessor_map_ref(TotalErrors.ErrorNum),Fields.InValidMessage_census_tract(TotalErrors.ErrorNum),Fields.InValidMessage_record_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_ownership_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_new_record_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_state_land_use_code(TotalErrors.ErrorNum),Fields.InValidMessage_county_land_use_code(TotalErrors.ErrorNum),Fields.InValidMessage_county_land_use_description(TotalErrors.ErrorNum),Fields.InValidMessage_standardized_land_use_code(TotalErrors.ErrorNum),Fields.InValidMessage_timeshare_code(TotalErrors.ErrorNum),Fields.InValidMessage_zoning(TotalErrors.ErrorNum),Fields.InValidMessage_owner_occupied(TotalErrors.ErrorNum),Fields.InValidMessage_recorder_document_number(TotalErrors.ErrorNum),Fields.InValidMessage_recorder_book_number(TotalErrors.ErrorNum),Fields.InValidMessage_recorder_page_number(TotalErrors.ErrorNum),Fields.InValidMessage_transfer_date(TotalErrors.ErrorNum),Fields.InValidMessage_recording_date(TotalErrors.ErrorNum),Fields.InValidMessage_sale_date(TotalErrors.ErrorNum),Fields.InValidMessage_document_type(TotalErrors.ErrorNum),Fields.InValidMessage_sales_price(TotalErrors.ErrorNum),Fields.InValidMessage_sales_price_code(TotalErrors.ErrorNum),Fields.InValidMessage_mortgage_loan_amount(TotalErrors.ErrorNum),Fields.InValidMessage_mortgage_loan_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_mortgage_lender_name(TotalErrors.ErrorNum),Fields.InValidMessage_mortgage_lender_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_prior_transfer_date(TotalErrors.ErrorNum),Fields.InValidMessage_prior_recording_date(TotalErrors.ErrorNum),Fields.InValidMessage_prior_sales_price(TotalErrors.ErrorNum),Fields.InValidMessage_prior_sales_price_code(TotalErrors.ErrorNum),Fields.InValidMessage_assessed_land_value(TotalErrors.ErrorNum),Fields.InValidMessage_assessed_improvement_value(TotalErrors.ErrorNum),Fields.InValidMessage_assessed_total_value(TotalErrors.ErrorNum),Fields.InValidMessage_assessed_value_year(TotalErrors.ErrorNum),Fields.InValidMessage_market_land_value(TotalErrors.ErrorNum),Fields.InValidMessage_market_improvement_value(TotalErrors.ErrorNum),Fields.InValidMessage_market_total_value(TotalErrors.ErrorNum),Fields.InValidMessage_market_value_year(TotalErrors.ErrorNum),Fields.InValidMessage_homestead_homeowner_exemption(TotalErrors.ErrorNum),Fields.InValidMessage_tax_exemption1_code(TotalErrors.ErrorNum),Fields.InValidMessage_tax_exemption2_code(TotalErrors.ErrorNum),Fields.InValidMessage_tax_exemption3_code(TotalErrors.ErrorNum),Fields.InValidMessage_tax_exemption4_code(TotalErrors.ErrorNum),Fields.InValidMessage_tax_rate_code_area(TotalErrors.ErrorNum),Fields.InValidMessage_tax_amount(TotalErrors.ErrorNum),Fields.InValidMessage_tax_year(TotalErrors.ErrorNum),Fields.InValidMessage_tax_delinquent_year(TotalErrors.ErrorNum),Fields.InValidMessage_school_tax_district1(TotalErrors.ErrorNum),Fields.InValidMessage_school_tax_district1_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_school_tax_district2(TotalErrors.ErrorNum),Fields.InValidMessage_school_tax_district2_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_school_tax_district3(TotalErrors.ErrorNum),Fields.InValidMessage_school_tax_district3_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_lot_size(TotalErrors.ErrorNum),Fields.InValidMessage_lot_size_acres(TotalErrors.ErrorNum),Fields.InValidMessage_lot_size_frontage_feet(TotalErrors.ErrorNum),Fields.InValidMessage_lot_size_depth_feet(TotalErrors.ErrorNum),Fields.InValidMessage_land_acres(TotalErrors.ErrorNum),Fields.InValidMessage_land_square_footage(TotalErrors.ErrorNum),Fields.InValidMessage_land_dimensions(TotalErrors.ErrorNum),Fields.InValidMessage_building_area(TotalErrors.ErrorNum),Fields.InValidMessage_building_area_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_building_area1(TotalErrors.ErrorNum),Fields.InValidMessage_building_area1_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_building_area2(TotalErrors.ErrorNum),Fields.InValidMessage_building_area2_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_building_area3(TotalErrors.ErrorNum),Fields.InValidMessage_building_area3_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_building_area4(TotalErrors.ErrorNum),Fields.InValidMessage_building_area4_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_building_area5(TotalErrors.ErrorNum),Fields.InValidMessage_building_area5_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_building_area6(TotalErrors.ErrorNum),Fields.InValidMessage_building_area6_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_building_area7(TotalErrors.ErrorNum),Fields.InValidMessage_building_area7_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_year_built(TotalErrors.ErrorNum),Fields.InValidMessage_effective_year_built(TotalErrors.ErrorNum),Fields.InValidMessage_no_of_buildings(TotalErrors.ErrorNum),Fields.InValidMessage_no_of_stories(TotalErrors.ErrorNum),Fields.InValidMessage_no_of_units(TotalErrors.ErrorNum),Fields.InValidMessage_no_of_rooms(TotalErrors.ErrorNum),Fields.InValidMessage_no_of_bedrooms(TotalErrors.ErrorNum),Fields.InValidMessage_no_of_baths(TotalErrors.ErrorNum),Fields.InValidMessage_no_of_partial_baths(TotalErrors.ErrorNum),Fields.InValidMessage_no_of_plumbing_fixtures(TotalErrors.ErrorNum),Fields.InValidMessage_garage_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_parking_no_of_cars(TotalErrors.ErrorNum),Fields.InValidMessage_pool_code(TotalErrors.ErrorNum),Fields.InValidMessage_style_code(TotalErrors.ErrorNum),Fields.InValidMessage_type_construction_code(TotalErrors.ErrorNum),Fields.InValidMessage_foundation_code(TotalErrors.ErrorNum),Fields.InValidMessage_building_quality_code(TotalErrors.ErrorNum),Fields.InValidMessage_building_condition_code(TotalErrors.ErrorNum),Fields.InValidMessage_exterior_walls_code(TotalErrors.ErrorNum),Fields.InValidMessage_interior_walls_code(TotalErrors.ErrorNum),Fields.InValidMessage_roof_cover_code(TotalErrors.ErrorNum),Fields.InValidMessage_roof_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_floor_cover_code(TotalErrors.ErrorNum),Fields.InValidMessage_water_code(TotalErrors.ErrorNum),Fields.InValidMessage_sewer_code(TotalErrors.ErrorNum),Fields.InValidMessage_heating_code(TotalErrors.ErrorNum),Fields.InValidMessage_heating_fuel_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_air_conditioning_code(TotalErrors.ErrorNum),Fields.InValidMessage_air_conditioning_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_elevator(TotalErrors.ErrorNum),Fields.InValidMessage_fireplace_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_fireplace_number(TotalErrors.ErrorNum),Fields.InValidMessage_basement_code(TotalErrors.ErrorNum),Fields.InValidMessage_building_class_code(TotalErrors.ErrorNum),Fields.InValidMessage_site_influence1_code(TotalErrors.ErrorNum),Fields.InValidMessage_site_influence2_code(TotalErrors.ErrorNum),Fields.InValidMessage_site_influence3_code(TotalErrors.ErrorNum),Fields.InValidMessage_site_influence4_code(TotalErrors.ErrorNum),Fields.InValidMessage_site_influence5_code(TotalErrors.ErrorNum),Fields.InValidMessage_amenities1_code(TotalErrors.ErrorNum),Fields.InValidMessage_amenities2_code(TotalErrors.ErrorNum),Fields.InValidMessage_amenities3_code(TotalErrors.ErrorNum),Fields.InValidMessage_amenities4_code(TotalErrors.ErrorNum),Fields.InValidMessage_amenities5_code(TotalErrors.ErrorNum),Fields.InValidMessage_amenities2_code1(TotalErrors.ErrorNum),Fields.InValidMessage_amenities2_code2(TotalErrors.ErrorNum),Fields.InValidMessage_amenities2_code3(TotalErrors.ErrorNum),Fields.InValidMessage_amenities2_code4(TotalErrors.ErrorNum),Fields.InValidMessage_amenities2_code5(TotalErrors.ErrorNum),Fields.InValidMessage_extra_features1_area(TotalErrors.ErrorNum),Fields.InValidMessage_extra_features1_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_extra_features2_area(TotalErrors.ErrorNum),Fields.InValidMessage_extra_features2_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_extra_features3_area(TotalErrors.ErrorNum),Fields.InValidMessage_extra_features3_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_extra_features4_area(TotalErrors.ErrorNum),Fields.InValidMessage_extra_features4_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_other_buildings1_code(TotalErrors.ErrorNum),Fields.InValidMessage_other_buildings2_code(TotalErrors.ErrorNum),Fields.InValidMessage_other_buildings3_code(TotalErrors.ErrorNum),Fields.InValidMessage_other_buildings4_code(TotalErrors.ErrorNum),Fields.InValidMessage_other_buildings5_code(TotalErrors.ErrorNum),Fields.InValidMessage_other_impr_building1_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_other_impr_building2_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_other_impr_building3_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_other_impr_building4_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_other_impr_building5_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_other_impr_building_area1(TotalErrors.ErrorNum),Fields.InValidMessage_other_impr_building_area2(TotalErrors.ErrorNum),Fields.InValidMessage_other_impr_building_area3(TotalErrors.ErrorNum),Fields.InValidMessage_other_impr_building_area4(TotalErrors.ErrorNum),Fields.InValidMessage_other_impr_building_area5(TotalErrors.ErrorNum),Fields.InValidMessage_topograpy_code(TotalErrors.ErrorNum),Fields.InValidMessage_neighborhood_code(TotalErrors.ErrorNum),Fields.InValidMessage_condo_project_or_building_name(TotalErrors.ErrorNum),Fields.InValidMessage_assessee_name_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_second_assessee_name_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_other_rooms_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_mail_care_of_name_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_comments(TotalErrors.ErrorNum),Fields.InValidMessage_tape_cut_date(TotalErrors.ErrorNum),Fields.InValidMessage_certification_date(TotalErrors.ErrorNum),Fields.InValidMessage_edition_number(TotalErrors.ErrorNum),Fields.InValidMessage_prop_addr_propagated_ind(TotalErrors.ErrorNum),Fields.InValidMessage_ln_ownership_rights(TotalErrors.ErrorNum),Fields.InValidMessage_ln_relationship_type(TotalErrors.ErrorNum),Fields.InValidMessage_ln_mailing_country_code(TotalErrors.ErrorNum),Fields.InValidMessage_ln_property_name(TotalErrors.ErrorNum),Fields.InValidMessage_ln_property_name_type(TotalErrors.ErrorNum),Fields.InValidMessage_ln_land_use_category(TotalErrors.ErrorNum),Fields.InValidMessage_ln_lot(TotalErrors.ErrorNum),Fields.InValidMessage_ln_block(TotalErrors.ErrorNum),Fields.InValidMessage_ln_unit(TotalErrors.ErrorNum),Fields.InValidMessage_ln_subfloor(TotalErrors.ErrorNum),Fields.InValidMessage_ln_floor_cover(TotalErrors.ErrorNum),Fields.InValidMessage_ln_mobile_home_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_ln_condo_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_ln_property_tax_exemption(TotalErrors.ErrorNum),Fields.InValidMessage_ln_veteran_status(TotalErrors.ErrorNum),Fields.InValidMessage_ln_old_apn_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_fips(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.fips_code=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
//Compute field consistencies between sources
  SALT311.Mac_SrcFrequency_Outliers(h,standardized_land_use_code,fips_code,standardized_land_use_code_Unusually_Frequent_outliers, standardized_land_use_code_Unique_outliers, standardized_land_use_code_Unique_outlier_sources, standardized_land_use_code_Distinct_outliers,standardized_land_use_code_Distinct_outlier_sources, standardized_land_use_code_Top5_outliers, standardized_land_use_code_Top5_outlier_sources)
  SALT311.Mac_SrcFrequency_Outliers(h,document_type,fips_code,document_type_Unusually_Frequent_outliers, document_type_Unique_outliers, document_type_Unique_outlier_sources, document_type_Distinct_outliers,document_type_Distinct_outlier_sources, document_type_Top5_outliers, document_type_Top5_outlier_sources)
  SALT311.Mac_SrcFrequency_Outliers(h,sales_price,fips_code,sales_price_Unusually_Frequent_outliers, sales_price_Unique_outliers, sales_price_Unique_outlier_sources, sales_price_Distinct_outliers,sales_price_Distinct_outlier_sources, sales_price_Top5_outliers, sales_price_Top5_outlier_sources)
  SALT311.Mac_SrcFrequency_Outliers(h,mortgage_loan_type_code,fips_code,mortgage_loan_type_code_Unusually_Frequent_outliers, mortgage_loan_type_code_Unique_outliers, mortgage_loan_type_code_Unique_outlier_sources, mortgage_loan_type_code_Distinct_outliers,mortgage_loan_type_code_Distinct_outlier_sources, mortgage_loan_type_code_Top5_outliers, mortgage_loan_type_code_Top5_outlier_sources)
EXPORT AllUnusuallyFrequentOutliers := standardized_land_use_code_Unusually_Frequent_outliers + document_type_Unusually_Frequent_outliers + sales_price_Unusually_Frequent_outliers + mortgage_loan_type_code_Unusually_Frequent_outliers;
EXPORT AllUniqueOutliers := standardized_land_use_code_Unique_outliers + document_type_Unique_outliers + sales_price_Unique_outliers + mortgage_loan_type_code_Unique_outliers;
EXPORT AllDistinctOutliers := standardized_land_use_code_Distinct_outliers + document_type_Distinct_outliers + sales_price_Distinct_outliers + mortgage_loan_type_code_Distinct_outliers;
EXPORT AllTop5Outliers := standardized_land_use_code_Top5_outliers + document_type_Top5_outliers + sales_price_Top5_outliers + mortgage_loan_type_code_Top5_outliers;
EXPORT AllUniqueOutlierSources := standardized_land_use_code_Unique_outlier_sources + document_type_Unique_outlier_sources + sales_price_Unique_outlier_sources + mortgage_loan_type_code_Unique_outlier_sources;
EXPORT AllDistinctOutlierSources := standardized_land_use_code_Distinct_outlier_sources + document_type_Distinct_outlier_sources + sales_price_Distinct_outlier_sources + mortgage_loan_type_code_Distinct_outlier_sources;
EXPORT AllTop5OutlierSources := standardized_land_use_code_Top5_outlier_sources + document_type_Top5_outlier_sources + sales_price_Top5_outlier_sources + mortgage_loan_type_code_Top5_outlier_sources;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doSummaryPerSrc = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  fieldPopulationPerSource := Summary('', FALSE);
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_LN_PropertyV2_Assessor, Fields, 'RECORDOF(fieldPopulationOverall)', TRUE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationPerSource_Standard := IF(doSummaryPerSrc, NORMALIZE(fieldPopulationPerSource, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'src', 'src')));
 
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', TRUE, 'all'));
  fieldPopulationPerSource_TotalRecs_Standard := IF(doSummaryPerSrc, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationPerSource, myTimeStamp, 'src', TRUE, 'src'));
 
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & fieldPopulationPerSource_Standard & fieldPopulationPerSource_TotalRecs_Standard & allProfiles_Standard;
END;
END;
