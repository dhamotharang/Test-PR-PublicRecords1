IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_Property_deed) h) := MODULE
 
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
    populated_from_file_cnt := COUNT(GROUP,h.from_file <> (TYPEOF(h.from_file))'');
    populated_from_file_pcnt := AVE(GROUP,IF(h.from_file = (TYPEOF(h.from_file))'',0,100));
    maxlength_from_file := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.from_file)));
    avelength_from_file := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.from_file)),h.from_file<>(typeof(h.from_file))'');
    populated_fips_code_cnt := COUNT(GROUP,h.fips_code <> (TYPEOF(h.fips_code))'');
    populated_fips_code_pcnt := AVE(GROUP,IF(h.fips_code = (TYPEOF(h.fips_code))'',0,100));
    maxlength_fips_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_code)));
    avelength_fips_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_code)),h.fips_code<>(typeof(h.fips_code))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_county_name_cnt := COUNT(GROUP,h.county_name <> (TYPEOF(h.county_name))'');
    populated_county_name_pcnt := AVE(GROUP,IF(h.county_name = (TYPEOF(h.county_name))'',0,100));
    maxlength_county_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_name)));
    avelength_county_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_name)),h.county_name<>(typeof(h.county_name))'');
    populated_record_type_cnt := COUNT(GROUP,h.record_type <> (TYPEOF(h.record_type))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_apnt_or_pin_number_cnt := COUNT(GROUP,h.apnt_or_pin_number <> (TYPEOF(h.apnt_or_pin_number))'');
    populated_apnt_or_pin_number_pcnt := AVE(GROUP,IF(h.apnt_or_pin_number = (TYPEOF(h.apnt_or_pin_number))'',0,100));
    maxlength_apnt_or_pin_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.apnt_or_pin_number)));
    avelength_apnt_or_pin_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.apnt_or_pin_number)),h.apnt_or_pin_number<>(typeof(h.apnt_or_pin_number))'');
    populated_fares_unformatted_apn_cnt := COUNT(GROUP,h.fares_unformatted_apn <> (TYPEOF(h.fares_unformatted_apn))'');
    populated_fares_unformatted_apn_pcnt := AVE(GROUP,IF(h.fares_unformatted_apn = (TYPEOF(h.fares_unformatted_apn))'',0,100));
    maxlength_fares_unformatted_apn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fares_unformatted_apn)));
    avelength_fares_unformatted_apn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fares_unformatted_apn)),h.fares_unformatted_apn<>(typeof(h.fares_unformatted_apn))'');
    populated_multi_apn_flag_cnt := COUNT(GROUP,h.multi_apn_flag <> (TYPEOF(h.multi_apn_flag))'');
    populated_multi_apn_flag_pcnt := AVE(GROUP,IF(h.multi_apn_flag = (TYPEOF(h.multi_apn_flag))'',0,100));
    maxlength_multi_apn_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.multi_apn_flag)));
    avelength_multi_apn_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.multi_apn_flag)),h.multi_apn_flag<>(typeof(h.multi_apn_flag))'');
    populated_tax_id_number_cnt := COUNT(GROUP,h.tax_id_number <> (TYPEOF(h.tax_id_number))'');
    populated_tax_id_number_pcnt := AVE(GROUP,IF(h.tax_id_number = (TYPEOF(h.tax_id_number))'',0,100));
    maxlength_tax_id_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_id_number)));
    avelength_tax_id_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_id_number)),h.tax_id_number<>(typeof(h.tax_id_number))'');
    populated_excise_tax_number_cnt := COUNT(GROUP,h.excise_tax_number <> (TYPEOF(h.excise_tax_number))'');
    populated_excise_tax_number_pcnt := AVE(GROUP,IF(h.excise_tax_number = (TYPEOF(h.excise_tax_number))'',0,100));
    maxlength_excise_tax_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.excise_tax_number)));
    avelength_excise_tax_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.excise_tax_number)),h.excise_tax_number<>(typeof(h.excise_tax_number))'');
    populated_buyer_or_borrower_ind_cnt := COUNT(GROUP,h.buyer_or_borrower_ind <> (TYPEOF(h.buyer_or_borrower_ind))'');
    populated_buyer_or_borrower_ind_pcnt := AVE(GROUP,IF(h.buyer_or_borrower_ind = (TYPEOF(h.buyer_or_borrower_ind))'',0,100));
    maxlength_buyer_or_borrower_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer_or_borrower_ind)));
    avelength_buyer_or_borrower_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer_or_borrower_ind)),h.buyer_or_borrower_ind<>(typeof(h.buyer_or_borrower_ind))'');
    populated_name1_cnt := COUNT(GROUP,h.name1 <> (TYPEOF(h.name1))'');
    populated_name1_pcnt := AVE(GROUP,IF(h.name1 = (TYPEOF(h.name1))'',0,100));
    maxlength_name1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name1)));
    avelength_name1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name1)),h.name1<>(typeof(h.name1))'');
    populated_name1_id_code_cnt := COUNT(GROUP,h.name1_id_code <> (TYPEOF(h.name1_id_code))'');
    populated_name1_id_code_pcnt := AVE(GROUP,IF(h.name1_id_code = (TYPEOF(h.name1_id_code))'',0,100));
    maxlength_name1_id_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name1_id_code)));
    avelength_name1_id_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name1_id_code)),h.name1_id_code<>(typeof(h.name1_id_code))'');
    populated_name2_cnt := COUNT(GROUP,h.name2 <> (TYPEOF(h.name2))'');
    populated_name2_pcnt := AVE(GROUP,IF(h.name2 = (TYPEOF(h.name2))'',0,100));
    maxlength_name2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name2)));
    avelength_name2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name2)),h.name2<>(typeof(h.name2))'');
    populated_name2_id_code_cnt := COUNT(GROUP,h.name2_id_code <> (TYPEOF(h.name2_id_code))'');
    populated_name2_id_code_pcnt := AVE(GROUP,IF(h.name2_id_code = (TYPEOF(h.name2_id_code))'',0,100));
    maxlength_name2_id_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name2_id_code)));
    avelength_name2_id_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name2_id_code)),h.name2_id_code<>(typeof(h.name2_id_code))'');
    populated_vesting_code_cnt := COUNT(GROUP,h.vesting_code <> (TYPEOF(h.vesting_code))'');
    populated_vesting_code_pcnt := AVE(GROUP,IF(h.vesting_code = (TYPEOF(h.vesting_code))'',0,100));
    maxlength_vesting_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vesting_code)));
    avelength_vesting_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vesting_code)),h.vesting_code<>(typeof(h.vesting_code))'');
    populated_addendum_flag_cnt := COUNT(GROUP,h.addendum_flag <> (TYPEOF(h.addendum_flag))'');
    populated_addendum_flag_pcnt := AVE(GROUP,IF(h.addendum_flag = (TYPEOF(h.addendum_flag))'',0,100));
    maxlength_addendum_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addendum_flag)));
    avelength_addendum_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addendum_flag)),h.addendum_flag<>(typeof(h.addendum_flag))'');
    populated_phone_number_cnt := COUNT(GROUP,h.phone_number <> (TYPEOF(h.phone_number))'');
    populated_phone_number_pcnt := AVE(GROUP,IF(h.phone_number = (TYPEOF(h.phone_number))'',0,100));
    maxlength_phone_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_number)));
    avelength_phone_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_number)),h.phone_number<>(typeof(h.phone_number))'');
    populated_mailing_care_of_cnt := COUNT(GROUP,h.mailing_care_of <> (TYPEOF(h.mailing_care_of))'');
    populated_mailing_care_of_pcnt := AVE(GROUP,IF(h.mailing_care_of = (TYPEOF(h.mailing_care_of))'',0,100));
    maxlength_mailing_care_of := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_care_of)));
    avelength_mailing_care_of := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_care_of)),h.mailing_care_of<>(typeof(h.mailing_care_of))'');
    populated_mailing_street_cnt := COUNT(GROUP,h.mailing_street <> (TYPEOF(h.mailing_street))'');
    populated_mailing_street_pcnt := AVE(GROUP,IF(h.mailing_street = (TYPEOF(h.mailing_street))'',0,100));
    maxlength_mailing_street := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_street)));
    avelength_mailing_street := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_street)),h.mailing_street<>(typeof(h.mailing_street))'');
    populated_mailing_unit_number_cnt := COUNT(GROUP,h.mailing_unit_number <> (TYPEOF(h.mailing_unit_number))'');
    populated_mailing_unit_number_pcnt := AVE(GROUP,IF(h.mailing_unit_number = (TYPEOF(h.mailing_unit_number))'',0,100));
    maxlength_mailing_unit_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_unit_number)));
    avelength_mailing_unit_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_unit_number)),h.mailing_unit_number<>(typeof(h.mailing_unit_number))'');
    populated_mailing_csz_cnt := COUNT(GROUP,h.mailing_csz <> (TYPEOF(h.mailing_csz))'');
    populated_mailing_csz_pcnt := AVE(GROUP,IF(h.mailing_csz = (TYPEOF(h.mailing_csz))'',0,100));
    maxlength_mailing_csz := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_csz)));
    avelength_mailing_csz := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_csz)),h.mailing_csz<>(typeof(h.mailing_csz))'');
    populated_mailing_address_cd_cnt := COUNT(GROUP,h.mailing_address_cd <> (TYPEOF(h.mailing_address_cd))'');
    populated_mailing_address_cd_pcnt := AVE(GROUP,IF(h.mailing_address_cd = (TYPEOF(h.mailing_address_cd))'',0,100));
    maxlength_mailing_address_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_address_cd)));
    avelength_mailing_address_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_address_cd)),h.mailing_address_cd<>(typeof(h.mailing_address_cd))'');
    populated_seller1_cnt := COUNT(GROUP,h.seller1 <> (TYPEOF(h.seller1))'');
    populated_seller1_pcnt := AVE(GROUP,IF(h.seller1 = (TYPEOF(h.seller1))'',0,100));
    maxlength_seller1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seller1)));
    avelength_seller1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seller1)),h.seller1<>(typeof(h.seller1))'');
    populated_seller1_id_code_cnt := COUNT(GROUP,h.seller1_id_code <> (TYPEOF(h.seller1_id_code))'');
    populated_seller1_id_code_pcnt := AVE(GROUP,IF(h.seller1_id_code = (TYPEOF(h.seller1_id_code))'',0,100));
    maxlength_seller1_id_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seller1_id_code)));
    avelength_seller1_id_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seller1_id_code)),h.seller1_id_code<>(typeof(h.seller1_id_code))'');
    populated_seller2_cnt := COUNT(GROUP,h.seller2 <> (TYPEOF(h.seller2))'');
    populated_seller2_pcnt := AVE(GROUP,IF(h.seller2 = (TYPEOF(h.seller2))'',0,100));
    maxlength_seller2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seller2)));
    avelength_seller2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seller2)),h.seller2<>(typeof(h.seller2))'');
    populated_seller2_id_code_cnt := COUNT(GROUP,h.seller2_id_code <> (TYPEOF(h.seller2_id_code))'');
    populated_seller2_id_code_pcnt := AVE(GROUP,IF(h.seller2_id_code = (TYPEOF(h.seller2_id_code))'',0,100));
    maxlength_seller2_id_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seller2_id_code)));
    avelength_seller2_id_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seller2_id_code)),h.seller2_id_code<>(typeof(h.seller2_id_code))'');
    populated_seller_addendum_flag_cnt := COUNT(GROUP,h.seller_addendum_flag <> (TYPEOF(h.seller_addendum_flag))'');
    populated_seller_addendum_flag_pcnt := AVE(GROUP,IF(h.seller_addendum_flag = (TYPEOF(h.seller_addendum_flag))'',0,100));
    maxlength_seller_addendum_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seller_addendum_flag)));
    avelength_seller_addendum_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seller_addendum_flag)),h.seller_addendum_flag<>(typeof(h.seller_addendum_flag))'');
    populated_seller_mailing_full_street_address_cnt := COUNT(GROUP,h.seller_mailing_full_street_address <> (TYPEOF(h.seller_mailing_full_street_address))'');
    populated_seller_mailing_full_street_address_pcnt := AVE(GROUP,IF(h.seller_mailing_full_street_address = (TYPEOF(h.seller_mailing_full_street_address))'',0,100));
    maxlength_seller_mailing_full_street_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seller_mailing_full_street_address)));
    avelength_seller_mailing_full_street_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seller_mailing_full_street_address)),h.seller_mailing_full_street_address<>(typeof(h.seller_mailing_full_street_address))'');
    populated_seller_mailing_address_unit_number_cnt := COUNT(GROUP,h.seller_mailing_address_unit_number <> (TYPEOF(h.seller_mailing_address_unit_number))'');
    populated_seller_mailing_address_unit_number_pcnt := AVE(GROUP,IF(h.seller_mailing_address_unit_number = (TYPEOF(h.seller_mailing_address_unit_number))'',0,100));
    maxlength_seller_mailing_address_unit_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seller_mailing_address_unit_number)));
    avelength_seller_mailing_address_unit_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seller_mailing_address_unit_number)),h.seller_mailing_address_unit_number<>(typeof(h.seller_mailing_address_unit_number))'');
    populated_seller_mailing_address_citystatezip_cnt := COUNT(GROUP,h.seller_mailing_address_citystatezip <> (TYPEOF(h.seller_mailing_address_citystatezip))'');
    populated_seller_mailing_address_citystatezip_pcnt := AVE(GROUP,IF(h.seller_mailing_address_citystatezip = (TYPEOF(h.seller_mailing_address_citystatezip))'',0,100));
    maxlength_seller_mailing_address_citystatezip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seller_mailing_address_citystatezip)));
    avelength_seller_mailing_address_citystatezip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seller_mailing_address_citystatezip)),h.seller_mailing_address_citystatezip<>(typeof(h.seller_mailing_address_citystatezip))'');
    populated_property_full_street_address_cnt := COUNT(GROUP,h.property_full_street_address <> (TYPEOF(h.property_full_street_address))'');
    populated_property_full_street_address_pcnt := AVE(GROUP,IF(h.property_full_street_address = (TYPEOF(h.property_full_street_address))'',0,100));
    maxlength_property_full_street_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_full_street_address)));
    avelength_property_full_street_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_full_street_address)),h.property_full_street_address<>(typeof(h.property_full_street_address))'');
    populated_property_address_unit_number_cnt := COUNT(GROUP,h.property_address_unit_number <> (TYPEOF(h.property_address_unit_number))'');
    populated_property_address_unit_number_pcnt := AVE(GROUP,IF(h.property_address_unit_number = (TYPEOF(h.property_address_unit_number))'',0,100));
    maxlength_property_address_unit_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_address_unit_number)));
    avelength_property_address_unit_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_address_unit_number)),h.property_address_unit_number<>(typeof(h.property_address_unit_number))'');
    populated_property_address_citystatezip_cnt := COUNT(GROUP,h.property_address_citystatezip <> (TYPEOF(h.property_address_citystatezip))'');
    populated_property_address_citystatezip_pcnt := AVE(GROUP,IF(h.property_address_citystatezip = (TYPEOF(h.property_address_citystatezip))'',0,100));
    maxlength_property_address_citystatezip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_address_citystatezip)));
    avelength_property_address_citystatezip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_address_citystatezip)),h.property_address_citystatezip<>(typeof(h.property_address_citystatezip))'');
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
    populated_legal_land_lot_cnt := COUNT(GROUP,h.legal_land_lot <> (TYPEOF(h.legal_land_lot))'');
    populated_legal_land_lot_pcnt := AVE(GROUP,IF(h.legal_land_lot = (TYPEOF(h.legal_land_lot))'',0,100));
    maxlength_legal_land_lot := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_land_lot)));
    avelength_legal_land_lot := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_land_lot)),h.legal_land_lot<>(typeof(h.legal_land_lot))'');
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
    populated_recorder_map_reference_cnt := COUNT(GROUP,h.recorder_map_reference <> (TYPEOF(h.recorder_map_reference))'');
    populated_recorder_map_reference_pcnt := AVE(GROUP,IF(h.recorder_map_reference = (TYPEOF(h.recorder_map_reference))'',0,100));
    maxlength_recorder_map_reference := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recorder_map_reference)));
    avelength_recorder_map_reference := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recorder_map_reference)),h.recorder_map_reference<>(typeof(h.recorder_map_reference))'');
    populated_complete_legal_description_code_cnt := COUNT(GROUP,h.complete_legal_description_code <> (TYPEOF(h.complete_legal_description_code))'');
    populated_complete_legal_description_code_pcnt := AVE(GROUP,IF(h.complete_legal_description_code = (TYPEOF(h.complete_legal_description_code))'',0,100));
    maxlength_complete_legal_description_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.complete_legal_description_code)));
    avelength_complete_legal_description_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.complete_legal_description_code)),h.complete_legal_description_code<>(typeof(h.complete_legal_description_code))'');
    populated_contract_date_cnt := COUNT(GROUP,h.contract_date <> (TYPEOF(h.contract_date))'');
    populated_contract_date_pcnt := AVE(GROUP,IF(h.contract_date = (TYPEOF(h.contract_date))'',0,100));
    maxlength_contract_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contract_date)));
    avelength_contract_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contract_date)),h.contract_date<>(typeof(h.contract_date))'');
    populated_recording_date_cnt := COUNT(GROUP,h.recording_date <> (TYPEOF(h.recording_date))'');
    populated_recording_date_pcnt := AVE(GROUP,IF(h.recording_date = (TYPEOF(h.recording_date))'',0,100));
    maxlength_recording_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recording_date)));
    avelength_recording_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recording_date)),h.recording_date<>(typeof(h.recording_date))'');
    populated_arm_reset_date_cnt := COUNT(GROUP,h.arm_reset_date <> (TYPEOF(h.arm_reset_date))'');
    populated_arm_reset_date_pcnt := AVE(GROUP,IF(h.arm_reset_date = (TYPEOF(h.arm_reset_date))'',0,100));
    maxlength_arm_reset_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.arm_reset_date)));
    avelength_arm_reset_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.arm_reset_date)),h.arm_reset_date<>(typeof(h.arm_reset_date))'');
    populated_document_number_cnt := COUNT(GROUP,h.document_number <> (TYPEOF(h.document_number))'');
    populated_document_number_pcnt := AVE(GROUP,IF(h.document_number = (TYPEOF(h.document_number))'',0,100));
    maxlength_document_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.document_number)));
    avelength_document_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.document_number)),h.document_number<>(typeof(h.document_number))'');
    populated_document_type_code_cnt := COUNT(GROUP,h.document_type_code <> (TYPEOF(h.document_type_code))'');
    populated_document_type_code_pcnt := AVE(GROUP,IF(h.document_type_code = (TYPEOF(h.document_type_code))'',0,100));
    maxlength_document_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.document_type_code)));
    avelength_document_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.document_type_code)),h.document_type_code<>(typeof(h.document_type_code))'');
    populated_loan_number_cnt := COUNT(GROUP,h.loan_number <> (TYPEOF(h.loan_number))'');
    populated_loan_number_pcnt := AVE(GROUP,IF(h.loan_number = (TYPEOF(h.loan_number))'',0,100));
    maxlength_loan_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.loan_number)));
    avelength_loan_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.loan_number)),h.loan_number<>(typeof(h.loan_number))'');
    populated_recorder_book_number_cnt := COUNT(GROUP,h.recorder_book_number <> (TYPEOF(h.recorder_book_number))'');
    populated_recorder_book_number_pcnt := AVE(GROUP,IF(h.recorder_book_number = (TYPEOF(h.recorder_book_number))'',0,100));
    maxlength_recorder_book_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recorder_book_number)));
    avelength_recorder_book_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recorder_book_number)),h.recorder_book_number<>(typeof(h.recorder_book_number))'');
    populated_recorder_page_number_cnt := COUNT(GROUP,h.recorder_page_number <> (TYPEOF(h.recorder_page_number))'');
    populated_recorder_page_number_pcnt := AVE(GROUP,IF(h.recorder_page_number = (TYPEOF(h.recorder_page_number))'',0,100));
    maxlength_recorder_page_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recorder_page_number)));
    avelength_recorder_page_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recorder_page_number)),h.recorder_page_number<>(typeof(h.recorder_page_number))'');
    populated_concurrent_mortgage_book_page_document_number_cnt := COUNT(GROUP,h.concurrent_mortgage_book_page_document_number <> (TYPEOF(h.concurrent_mortgage_book_page_document_number))'');
    populated_concurrent_mortgage_book_page_document_number_pcnt := AVE(GROUP,IF(h.concurrent_mortgage_book_page_document_number = (TYPEOF(h.concurrent_mortgage_book_page_document_number))'',0,100));
    maxlength_concurrent_mortgage_book_page_document_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.concurrent_mortgage_book_page_document_number)));
    avelength_concurrent_mortgage_book_page_document_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.concurrent_mortgage_book_page_document_number)),h.concurrent_mortgage_book_page_document_number<>(typeof(h.concurrent_mortgage_book_page_document_number))'');
    populated_sales_price_cnt := COUNT(GROUP,h.sales_price <> (TYPEOF(h.sales_price))'');
    populated_sales_price_pcnt := AVE(GROUP,IF(h.sales_price = (TYPEOF(h.sales_price))'',0,100));
    maxlength_sales_price := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sales_price)));
    avelength_sales_price := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sales_price)),h.sales_price<>(typeof(h.sales_price))'');
    populated_sales_price_code_cnt := COUNT(GROUP,h.sales_price_code <> (TYPEOF(h.sales_price_code))'');
    populated_sales_price_code_pcnt := AVE(GROUP,IF(h.sales_price_code = (TYPEOF(h.sales_price_code))'',0,100));
    maxlength_sales_price_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sales_price_code)));
    avelength_sales_price_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sales_price_code)),h.sales_price_code<>(typeof(h.sales_price_code))'');
    populated_city_transfer_tax_cnt := COUNT(GROUP,h.city_transfer_tax <> (TYPEOF(h.city_transfer_tax))'');
    populated_city_transfer_tax_pcnt := AVE(GROUP,IF(h.city_transfer_tax = (TYPEOF(h.city_transfer_tax))'',0,100));
    maxlength_city_transfer_tax := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_transfer_tax)));
    avelength_city_transfer_tax := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_transfer_tax)),h.city_transfer_tax<>(typeof(h.city_transfer_tax))'');
    populated_county_transfer_tax_cnt := COUNT(GROUP,h.county_transfer_tax <> (TYPEOF(h.county_transfer_tax))'');
    populated_county_transfer_tax_pcnt := AVE(GROUP,IF(h.county_transfer_tax = (TYPEOF(h.county_transfer_tax))'',0,100));
    maxlength_county_transfer_tax := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_transfer_tax)));
    avelength_county_transfer_tax := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_transfer_tax)),h.county_transfer_tax<>(typeof(h.county_transfer_tax))'');
    populated_total_transfer_tax_cnt := COUNT(GROUP,h.total_transfer_tax <> (TYPEOF(h.total_transfer_tax))'');
    populated_total_transfer_tax_pcnt := AVE(GROUP,IF(h.total_transfer_tax = (TYPEOF(h.total_transfer_tax))'',0,100));
    maxlength_total_transfer_tax := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_transfer_tax)));
    avelength_total_transfer_tax := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_transfer_tax)),h.total_transfer_tax<>(typeof(h.total_transfer_tax))'');
    populated_first_td_loan_amount_cnt := COUNT(GROUP,h.first_td_loan_amount <> (TYPEOF(h.first_td_loan_amount))'');
    populated_first_td_loan_amount_pcnt := AVE(GROUP,IF(h.first_td_loan_amount = (TYPEOF(h.first_td_loan_amount))'',0,100));
    maxlength_first_td_loan_amount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_td_loan_amount)));
    avelength_first_td_loan_amount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_td_loan_amount)),h.first_td_loan_amount<>(typeof(h.first_td_loan_amount))'');
    populated_second_td_loan_amount_cnt := COUNT(GROUP,h.second_td_loan_amount <> (TYPEOF(h.second_td_loan_amount))'');
    populated_second_td_loan_amount_pcnt := AVE(GROUP,IF(h.second_td_loan_amount = (TYPEOF(h.second_td_loan_amount))'',0,100));
    maxlength_second_td_loan_amount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.second_td_loan_amount)));
    avelength_second_td_loan_amount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.second_td_loan_amount)),h.second_td_loan_amount<>(typeof(h.second_td_loan_amount))'');
    populated_first_td_lender_type_code_cnt := COUNT(GROUP,h.first_td_lender_type_code <> (TYPEOF(h.first_td_lender_type_code))'');
    populated_first_td_lender_type_code_pcnt := AVE(GROUP,IF(h.first_td_lender_type_code = (TYPEOF(h.first_td_lender_type_code))'',0,100));
    maxlength_first_td_lender_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_td_lender_type_code)));
    avelength_first_td_lender_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_td_lender_type_code)),h.first_td_lender_type_code<>(typeof(h.first_td_lender_type_code))'');
    populated_second_td_lender_type_code_cnt := COUNT(GROUP,h.second_td_lender_type_code <> (TYPEOF(h.second_td_lender_type_code))'');
    populated_second_td_lender_type_code_pcnt := AVE(GROUP,IF(h.second_td_lender_type_code = (TYPEOF(h.second_td_lender_type_code))'',0,100));
    maxlength_second_td_lender_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.second_td_lender_type_code)));
    avelength_second_td_lender_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.second_td_lender_type_code)),h.second_td_lender_type_code<>(typeof(h.second_td_lender_type_code))'');
    populated_first_td_loan_type_code_cnt := COUNT(GROUP,h.first_td_loan_type_code <> (TYPEOF(h.first_td_loan_type_code))'');
    populated_first_td_loan_type_code_pcnt := AVE(GROUP,IF(h.first_td_loan_type_code = (TYPEOF(h.first_td_loan_type_code))'',0,100));
    maxlength_first_td_loan_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_td_loan_type_code)));
    avelength_first_td_loan_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_td_loan_type_code)),h.first_td_loan_type_code<>(typeof(h.first_td_loan_type_code))'');
    populated_type_financing_cnt := COUNT(GROUP,h.type_financing <> (TYPEOF(h.type_financing))'');
    populated_type_financing_pcnt := AVE(GROUP,IF(h.type_financing = (TYPEOF(h.type_financing))'',0,100));
    maxlength_type_financing := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.type_financing)));
    avelength_type_financing := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.type_financing)),h.type_financing<>(typeof(h.type_financing))'');
    populated_first_td_interest_rate_cnt := COUNT(GROUP,h.first_td_interest_rate <> (TYPEOF(h.first_td_interest_rate))'');
    populated_first_td_interest_rate_pcnt := AVE(GROUP,IF(h.first_td_interest_rate = (TYPEOF(h.first_td_interest_rate))'',0,100));
    maxlength_first_td_interest_rate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_td_interest_rate)));
    avelength_first_td_interest_rate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_td_interest_rate)),h.first_td_interest_rate<>(typeof(h.first_td_interest_rate))'');
    populated_first_td_due_date_cnt := COUNT(GROUP,h.first_td_due_date <> (TYPEOF(h.first_td_due_date))'');
    populated_first_td_due_date_pcnt := AVE(GROUP,IF(h.first_td_due_date = (TYPEOF(h.first_td_due_date))'',0,100));
    maxlength_first_td_due_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_td_due_date)));
    avelength_first_td_due_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_td_due_date)),h.first_td_due_date<>(typeof(h.first_td_due_date))'');
    populated_title_company_name_cnt := COUNT(GROUP,h.title_company_name <> (TYPEOF(h.title_company_name))'');
    populated_title_company_name_pcnt := AVE(GROUP,IF(h.title_company_name = (TYPEOF(h.title_company_name))'',0,100));
    maxlength_title_company_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_company_name)));
    avelength_title_company_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_company_name)),h.title_company_name<>(typeof(h.title_company_name))'');
    populated_partial_interest_transferred_cnt := COUNT(GROUP,h.partial_interest_transferred <> (TYPEOF(h.partial_interest_transferred))'');
    populated_partial_interest_transferred_pcnt := AVE(GROUP,IF(h.partial_interest_transferred = (TYPEOF(h.partial_interest_transferred))'',0,100));
    maxlength_partial_interest_transferred := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.partial_interest_transferred)));
    avelength_partial_interest_transferred := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.partial_interest_transferred)),h.partial_interest_transferred<>(typeof(h.partial_interest_transferred))'');
    populated_loan_term_months_cnt := COUNT(GROUP,h.loan_term_months <> (TYPEOF(h.loan_term_months))'');
    populated_loan_term_months_pcnt := AVE(GROUP,IF(h.loan_term_months = (TYPEOF(h.loan_term_months))'',0,100));
    maxlength_loan_term_months := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.loan_term_months)));
    avelength_loan_term_months := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.loan_term_months)),h.loan_term_months<>(typeof(h.loan_term_months))'');
    populated_loan_term_years_cnt := COUNT(GROUP,h.loan_term_years <> (TYPEOF(h.loan_term_years))'');
    populated_loan_term_years_pcnt := AVE(GROUP,IF(h.loan_term_years = (TYPEOF(h.loan_term_years))'',0,100));
    maxlength_loan_term_years := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.loan_term_years)));
    avelength_loan_term_years := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.loan_term_years)),h.loan_term_years<>(typeof(h.loan_term_years))'');
    populated_lender_name_cnt := COUNT(GROUP,h.lender_name <> (TYPEOF(h.lender_name))'');
    populated_lender_name_pcnt := AVE(GROUP,IF(h.lender_name = (TYPEOF(h.lender_name))'',0,100));
    maxlength_lender_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lender_name)));
    avelength_lender_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lender_name)),h.lender_name<>(typeof(h.lender_name))'');
    populated_lender_name_id_cnt := COUNT(GROUP,h.lender_name_id <> (TYPEOF(h.lender_name_id))'');
    populated_lender_name_id_pcnt := AVE(GROUP,IF(h.lender_name_id = (TYPEOF(h.lender_name_id))'',0,100));
    maxlength_lender_name_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lender_name_id)));
    avelength_lender_name_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lender_name_id)),h.lender_name_id<>(typeof(h.lender_name_id))'');
    populated_lender_dba_aka_name_cnt := COUNT(GROUP,h.lender_dba_aka_name <> (TYPEOF(h.lender_dba_aka_name))'');
    populated_lender_dba_aka_name_pcnt := AVE(GROUP,IF(h.lender_dba_aka_name = (TYPEOF(h.lender_dba_aka_name))'',0,100));
    maxlength_lender_dba_aka_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lender_dba_aka_name)));
    avelength_lender_dba_aka_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lender_dba_aka_name)),h.lender_dba_aka_name<>(typeof(h.lender_dba_aka_name))'');
    populated_lender_full_street_address_cnt := COUNT(GROUP,h.lender_full_street_address <> (TYPEOF(h.lender_full_street_address))'');
    populated_lender_full_street_address_pcnt := AVE(GROUP,IF(h.lender_full_street_address = (TYPEOF(h.lender_full_street_address))'',0,100));
    maxlength_lender_full_street_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lender_full_street_address)));
    avelength_lender_full_street_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lender_full_street_address)),h.lender_full_street_address<>(typeof(h.lender_full_street_address))'');
    populated_lender_address_unit_number_cnt := COUNT(GROUP,h.lender_address_unit_number <> (TYPEOF(h.lender_address_unit_number))'');
    populated_lender_address_unit_number_pcnt := AVE(GROUP,IF(h.lender_address_unit_number = (TYPEOF(h.lender_address_unit_number))'',0,100));
    maxlength_lender_address_unit_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lender_address_unit_number)));
    avelength_lender_address_unit_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lender_address_unit_number)),h.lender_address_unit_number<>(typeof(h.lender_address_unit_number))'');
    populated_lender_address_citystatezip_cnt := COUNT(GROUP,h.lender_address_citystatezip <> (TYPEOF(h.lender_address_citystatezip))'');
    populated_lender_address_citystatezip_pcnt := AVE(GROUP,IF(h.lender_address_citystatezip = (TYPEOF(h.lender_address_citystatezip))'',0,100));
    maxlength_lender_address_citystatezip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lender_address_citystatezip)));
    avelength_lender_address_citystatezip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lender_address_citystatezip)),h.lender_address_citystatezip<>(typeof(h.lender_address_citystatezip))'');
    populated_assessment_match_land_use_code_cnt := COUNT(GROUP,h.assessment_match_land_use_code <> (TYPEOF(h.assessment_match_land_use_code))'');
    populated_assessment_match_land_use_code_pcnt := AVE(GROUP,IF(h.assessment_match_land_use_code = (TYPEOF(h.assessment_match_land_use_code))'',0,100));
    maxlength_assessment_match_land_use_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessment_match_land_use_code)));
    avelength_assessment_match_land_use_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessment_match_land_use_code)),h.assessment_match_land_use_code<>(typeof(h.assessment_match_land_use_code))'');
    populated_property_use_code_cnt := COUNT(GROUP,h.property_use_code <> (TYPEOF(h.property_use_code))'');
    populated_property_use_code_pcnt := AVE(GROUP,IF(h.property_use_code = (TYPEOF(h.property_use_code))'',0,100));
    maxlength_property_use_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_use_code)));
    avelength_property_use_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_use_code)),h.property_use_code<>(typeof(h.property_use_code))'');
    populated_condo_code_cnt := COUNT(GROUP,h.condo_code <> (TYPEOF(h.condo_code))'');
    populated_condo_code_pcnt := AVE(GROUP,IF(h.condo_code = (TYPEOF(h.condo_code))'',0,100));
    maxlength_condo_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.condo_code)));
    avelength_condo_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.condo_code)),h.condo_code<>(typeof(h.condo_code))'');
    populated_timeshare_flag_cnt := COUNT(GROUP,h.timeshare_flag <> (TYPEOF(h.timeshare_flag))'');
    populated_timeshare_flag_pcnt := AVE(GROUP,IF(h.timeshare_flag = (TYPEOF(h.timeshare_flag))'',0,100));
    maxlength_timeshare_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.timeshare_flag)));
    avelength_timeshare_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.timeshare_flag)),h.timeshare_flag<>(typeof(h.timeshare_flag))'');
    populated_land_lot_size_cnt := COUNT(GROUP,h.land_lot_size <> (TYPEOF(h.land_lot_size))'');
    populated_land_lot_size_pcnt := AVE(GROUP,IF(h.land_lot_size = (TYPEOF(h.land_lot_size))'',0,100));
    maxlength_land_lot_size := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.land_lot_size)));
    avelength_land_lot_size := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.land_lot_size)),h.land_lot_size<>(typeof(h.land_lot_size))'');
    populated_hawaii_tct_cnt := COUNT(GROUP,h.hawaii_tct <> (TYPEOF(h.hawaii_tct))'');
    populated_hawaii_tct_pcnt := AVE(GROUP,IF(h.hawaii_tct = (TYPEOF(h.hawaii_tct))'',0,100));
    maxlength_hawaii_tct := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hawaii_tct)));
    avelength_hawaii_tct := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hawaii_tct)),h.hawaii_tct<>(typeof(h.hawaii_tct))'');
    populated_hawaii_condo_cpr_code_cnt := COUNT(GROUP,h.hawaii_condo_cpr_code <> (TYPEOF(h.hawaii_condo_cpr_code))'');
    populated_hawaii_condo_cpr_code_pcnt := AVE(GROUP,IF(h.hawaii_condo_cpr_code = (TYPEOF(h.hawaii_condo_cpr_code))'',0,100));
    maxlength_hawaii_condo_cpr_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hawaii_condo_cpr_code)));
    avelength_hawaii_condo_cpr_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hawaii_condo_cpr_code)),h.hawaii_condo_cpr_code<>(typeof(h.hawaii_condo_cpr_code))'');
    populated_hawaii_condo_name_cnt := COUNT(GROUP,h.hawaii_condo_name <> (TYPEOF(h.hawaii_condo_name))'');
    populated_hawaii_condo_name_pcnt := AVE(GROUP,IF(h.hawaii_condo_name = (TYPEOF(h.hawaii_condo_name))'',0,100));
    maxlength_hawaii_condo_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hawaii_condo_name)));
    avelength_hawaii_condo_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hawaii_condo_name)),h.hawaii_condo_name<>(typeof(h.hawaii_condo_name))'');
    populated_filler_except_hawaii_cnt := COUNT(GROUP,h.filler_except_hawaii <> (TYPEOF(h.filler_except_hawaii))'');
    populated_filler_except_hawaii_pcnt := AVE(GROUP,IF(h.filler_except_hawaii = (TYPEOF(h.filler_except_hawaii))'',0,100));
    maxlength_filler_except_hawaii := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler_except_hawaii)));
    avelength_filler_except_hawaii := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler_except_hawaii)),h.filler_except_hawaii<>(typeof(h.filler_except_hawaii))'');
    populated_rate_change_frequency_cnt := COUNT(GROUP,h.rate_change_frequency <> (TYPEOF(h.rate_change_frequency))'');
    populated_rate_change_frequency_pcnt := AVE(GROUP,IF(h.rate_change_frequency = (TYPEOF(h.rate_change_frequency))'',0,100));
    maxlength_rate_change_frequency := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rate_change_frequency)));
    avelength_rate_change_frequency := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rate_change_frequency)),h.rate_change_frequency<>(typeof(h.rate_change_frequency))'');
    populated_change_index_cnt := COUNT(GROUP,h.change_index <> (TYPEOF(h.change_index))'');
    populated_change_index_pcnt := AVE(GROUP,IF(h.change_index = (TYPEOF(h.change_index))'',0,100));
    maxlength_change_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.change_index)));
    avelength_change_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.change_index)),h.change_index<>(typeof(h.change_index))'');
    populated_adjustable_rate_index_cnt := COUNT(GROUP,h.adjustable_rate_index <> (TYPEOF(h.adjustable_rate_index))'');
    populated_adjustable_rate_index_pcnt := AVE(GROUP,IF(h.adjustable_rate_index = (TYPEOF(h.adjustable_rate_index))'',0,100));
    maxlength_adjustable_rate_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.adjustable_rate_index)));
    avelength_adjustable_rate_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.adjustable_rate_index)),h.adjustable_rate_index<>(typeof(h.adjustable_rate_index))'');
    populated_adjustable_rate_rider_cnt := COUNT(GROUP,h.adjustable_rate_rider <> (TYPEOF(h.adjustable_rate_rider))'');
    populated_adjustable_rate_rider_pcnt := AVE(GROUP,IF(h.adjustable_rate_rider = (TYPEOF(h.adjustable_rate_rider))'',0,100));
    maxlength_adjustable_rate_rider := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.adjustable_rate_rider)));
    avelength_adjustable_rate_rider := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.adjustable_rate_rider)),h.adjustable_rate_rider<>(typeof(h.adjustable_rate_rider))'');
    populated_graduated_payment_rider_cnt := COUNT(GROUP,h.graduated_payment_rider <> (TYPEOF(h.graduated_payment_rider))'');
    populated_graduated_payment_rider_pcnt := AVE(GROUP,IF(h.graduated_payment_rider = (TYPEOF(h.graduated_payment_rider))'',0,100));
    maxlength_graduated_payment_rider := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.graduated_payment_rider)));
    avelength_graduated_payment_rider := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.graduated_payment_rider)),h.graduated_payment_rider<>(typeof(h.graduated_payment_rider))'');
    populated_balloon_rider_cnt := COUNT(GROUP,h.balloon_rider <> (TYPEOF(h.balloon_rider))'');
    populated_balloon_rider_pcnt := AVE(GROUP,IF(h.balloon_rider = (TYPEOF(h.balloon_rider))'',0,100));
    maxlength_balloon_rider := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.balloon_rider)));
    avelength_balloon_rider := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.balloon_rider)),h.balloon_rider<>(typeof(h.balloon_rider))'');
    populated_fixed_step_rate_rider_cnt := COUNT(GROUP,h.fixed_step_rate_rider <> (TYPEOF(h.fixed_step_rate_rider))'');
    populated_fixed_step_rate_rider_pcnt := AVE(GROUP,IF(h.fixed_step_rate_rider = (TYPEOF(h.fixed_step_rate_rider))'',0,100));
    maxlength_fixed_step_rate_rider := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fixed_step_rate_rider)));
    avelength_fixed_step_rate_rider := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fixed_step_rate_rider)),h.fixed_step_rate_rider<>(typeof(h.fixed_step_rate_rider))'');
    populated_condominium_rider_cnt := COUNT(GROUP,h.condominium_rider <> (TYPEOF(h.condominium_rider))'');
    populated_condominium_rider_pcnt := AVE(GROUP,IF(h.condominium_rider = (TYPEOF(h.condominium_rider))'',0,100));
    maxlength_condominium_rider := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.condominium_rider)));
    avelength_condominium_rider := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.condominium_rider)),h.condominium_rider<>(typeof(h.condominium_rider))'');
    populated_planned_unit_development_rider_cnt := COUNT(GROUP,h.planned_unit_development_rider <> (TYPEOF(h.planned_unit_development_rider))'');
    populated_planned_unit_development_rider_pcnt := AVE(GROUP,IF(h.planned_unit_development_rider = (TYPEOF(h.planned_unit_development_rider))'',0,100));
    maxlength_planned_unit_development_rider := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.planned_unit_development_rider)));
    avelength_planned_unit_development_rider := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.planned_unit_development_rider)),h.planned_unit_development_rider<>(typeof(h.planned_unit_development_rider))'');
    populated_rate_improvement_rider_cnt := COUNT(GROUP,h.rate_improvement_rider <> (TYPEOF(h.rate_improvement_rider))'');
    populated_rate_improvement_rider_pcnt := AVE(GROUP,IF(h.rate_improvement_rider = (TYPEOF(h.rate_improvement_rider))'',0,100));
    maxlength_rate_improvement_rider := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rate_improvement_rider)));
    avelength_rate_improvement_rider := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rate_improvement_rider)),h.rate_improvement_rider<>(typeof(h.rate_improvement_rider))'');
    populated_assumability_rider_cnt := COUNT(GROUP,h.assumability_rider <> (TYPEOF(h.assumability_rider))'');
    populated_assumability_rider_pcnt := AVE(GROUP,IF(h.assumability_rider = (TYPEOF(h.assumability_rider))'',0,100));
    maxlength_assumability_rider := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assumability_rider)));
    avelength_assumability_rider := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assumability_rider)),h.assumability_rider<>(typeof(h.assumability_rider))'');
    populated_prepayment_rider_cnt := COUNT(GROUP,h.prepayment_rider <> (TYPEOF(h.prepayment_rider))'');
    populated_prepayment_rider_pcnt := AVE(GROUP,IF(h.prepayment_rider = (TYPEOF(h.prepayment_rider))'',0,100));
    maxlength_prepayment_rider := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prepayment_rider)));
    avelength_prepayment_rider := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prepayment_rider)),h.prepayment_rider<>(typeof(h.prepayment_rider))'');
    populated_one_four_family_rider_cnt := COUNT(GROUP,h.one_four_family_rider <> (TYPEOF(h.one_four_family_rider))'');
    populated_one_four_family_rider_pcnt := AVE(GROUP,IF(h.one_four_family_rider = (TYPEOF(h.one_four_family_rider))'',0,100));
    maxlength_one_four_family_rider := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.one_four_family_rider)));
    avelength_one_four_family_rider := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.one_four_family_rider)),h.one_four_family_rider<>(typeof(h.one_four_family_rider))'');
    populated_biweekly_payment_rider_cnt := COUNT(GROUP,h.biweekly_payment_rider <> (TYPEOF(h.biweekly_payment_rider))'');
    populated_biweekly_payment_rider_pcnt := AVE(GROUP,IF(h.biweekly_payment_rider = (TYPEOF(h.biweekly_payment_rider))'',0,100));
    maxlength_biweekly_payment_rider := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.biweekly_payment_rider)));
    avelength_biweekly_payment_rider := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.biweekly_payment_rider)),h.biweekly_payment_rider<>(typeof(h.biweekly_payment_rider))'');
    populated_second_home_rider_cnt := COUNT(GROUP,h.second_home_rider <> (TYPEOF(h.second_home_rider))'');
    populated_second_home_rider_pcnt := AVE(GROUP,IF(h.second_home_rider = (TYPEOF(h.second_home_rider))'',0,100));
    maxlength_second_home_rider := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.second_home_rider)));
    avelength_second_home_rider := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.second_home_rider)),h.second_home_rider<>(typeof(h.second_home_rider))'');
    populated_data_source_code_cnt := COUNT(GROUP,h.data_source_code <> (TYPEOF(h.data_source_code))'');
    populated_data_source_code_pcnt := AVE(GROUP,IF(h.data_source_code = (TYPEOF(h.data_source_code))'',0,100));
    maxlength_data_source_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.data_source_code)));
    avelength_data_source_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.data_source_code)),h.data_source_code<>(typeof(h.data_source_code))'');
    populated_main_record_id_code_cnt := COUNT(GROUP,h.main_record_id_code <> (TYPEOF(h.main_record_id_code))'');
    populated_main_record_id_code_pcnt := AVE(GROUP,IF(h.main_record_id_code = (TYPEOF(h.main_record_id_code))'',0,100));
    maxlength_main_record_id_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.main_record_id_code)));
    avelength_main_record_id_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.main_record_id_code)),h.main_record_id_code<>(typeof(h.main_record_id_code))'');
    populated_addl_name_flag_cnt := COUNT(GROUP,h.addl_name_flag <> (TYPEOF(h.addl_name_flag))'');
    populated_addl_name_flag_pcnt := AVE(GROUP,IF(h.addl_name_flag = (TYPEOF(h.addl_name_flag))'',0,100));
    maxlength_addl_name_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addl_name_flag)));
    avelength_addl_name_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addl_name_flag)),h.addl_name_flag<>(typeof(h.addl_name_flag))'');
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
    populated_ln_buyer_mailing_country_code_cnt := COUNT(GROUP,h.ln_buyer_mailing_country_code <> (TYPEOF(h.ln_buyer_mailing_country_code))'');
    populated_ln_buyer_mailing_country_code_pcnt := AVE(GROUP,IF(h.ln_buyer_mailing_country_code = (TYPEOF(h.ln_buyer_mailing_country_code))'',0,100));
    maxlength_ln_buyer_mailing_country_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_buyer_mailing_country_code)));
    avelength_ln_buyer_mailing_country_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_buyer_mailing_country_code)),h.ln_buyer_mailing_country_code<>(typeof(h.ln_buyer_mailing_country_code))'');
    populated_ln_seller_mailing_country_code_cnt := COUNT(GROUP,h.ln_seller_mailing_country_code <> (TYPEOF(h.ln_seller_mailing_country_code))'');
    populated_ln_seller_mailing_country_code_pcnt := AVE(GROUP,IF(h.ln_seller_mailing_country_code = (TYPEOF(h.ln_seller_mailing_country_code))'',0,100));
    maxlength_ln_seller_mailing_country_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_seller_mailing_country_code)));
    avelength_ln_seller_mailing_country_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_seller_mailing_country_code)),h.ln_seller_mailing_country_code<>(typeof(h.ln_seller_mailing_country_code))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,fips_code,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_ln_fares_id_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_vendor_source_flag_pcnt *   0.00 / 100 + T.Populated_current_record_pcnt *   0.00 / 100 + T.Populated_from_file_pcnt *   0.00 / 100 + T.Populated_fips_code_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_county_name_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_apnt_or_pin_number_pcnt *   0.00 / 100 + T.Populated_fares_unformatted_apn_pcnt *   0.00 / 100 + T.Populated_multi_apn_flag_pcnt *   0.00 / 100 + T.Populated_tax_id_number_pcnt *   0.00 / 100 + T.Populated_excise_tax_number_pcnt *   0.00 / 100 + T.Populated_buyer_or_borrower_ind_pcnt *   0.00 / 100 + T.Populated_name1_pcnt *   0.00 / 100 + T.Populated_name1_id_code_pcnt *   0.00 / 100 + T.Populated_name2_pcnt *   0.00 / 100 + T.Populated_name2_id_code_pcnt *   0.00 / 100 + T.Populated_vesting_code_pcnt *   0.00 / 100 + T.Populated_addendum_flag_pcnt *   0.00 / 100 + T.Populated_phone_number_pcnt *   0.00 / 100 + T.Populated_mailing_care_of_pcnt *   0.00 / 100 + T.Populated_mailing_street_pcnt *   0.00 / 100 + T.Populated_mailing_unit_number_pcnt *   0.00 / 100 + T.Populated_mailing_csz_pcnt *   0.00 / 100 + T.Populated_mailing_address_cd_pcnt *   0.00 / 100 + T.Populated_seller1_pcnt *   0.00 / 100 + T.Populated_seller1_id_code_pcnt *   0.00 / 100 + T.Populated_seller2_pcnt *   0.00 / 100 + T.Populated_seller2_id_code_pcnt *   0.00 / 100 + T.Populated_seller_addendum_flag_pcnt *   0.00 / 100 + T.Populated_seller_mailing_full_street_address_pcnt *   0.00 / 100 + T.Populated_seller_mailing_address_unit_number_pcnt *   0.00 / 100 + T.Populated_seller_mailing_address_citystatezip_pcnt *   0.00 / 100 + T.Populated_property_full_street_address_pcnt *   0.00 / 100 + T.Populated_property_address_unit_number_pcnt *   0.00 / 100 + T.Populated_property_address_citystatezip_pcnt *   0.00 / 100 + T.Populated_property_address_code_pcnt *   0.00 / 100 + T.Populated_legal_lot_code_pcnt *   0.00 / 100 + T.Populated_legal_lot_number_pcnt *   0.00 / 100 + T.Populated_legal_block_pcnt *   0.00 / 100 + T.Populated_legal_section_pcnt *   0.00 / 100 + T.Populated_legal_district_pcnt *   0.00 / 100 + T.Populated_legal_land_lot_pcnt *   0.00 / 100 + T.Populated_legal_unit_pcnt *   0.00 / 100 + T.Populated_legal_city_municipality_township_pcnt *   0.00 / 100 + T.Populated_legal_subdivision_name_pcnt *   0.00 / 100 + T.Populated_legal_phase_number_pcnt *   0.00 / 100 + T.Populated_legal_tract_number_pcnt *   0.00 / 100 + T.Populated_legal_sec_twn_rng_mer_pcnt *   0.00 / 100 + T.Populated_legal_brief_description_pcnt *   0.00 / 100 + T.Populated_recorder_map_reference_pcnt *   0.00 / 100 + T.Populated_complete_legal_description_code_pcnt *   0.00 / 100 + T.Populated_contract_date_pcnt *   0.00 / 100 + T.Populated_recording_date_pcnt *   0.00 / 100 + T.Populated_arm_reset_date_pcnt *   0.00 / 100 + T.Populated_document_number_pcnt *   0.00 / 100 + T.Populated_document_type_code_pcnt *   0.00 / 100 + T.Populated_loan_number_pcnt *   0.00 / 100 + T.Populated_recorder_book_number_pcnt *   0.00 / 100 + T.Populated_recorder_page_number_pcnt *   0.00 / 100 + T.Populated_concurrent_mortgage_book_page_document_number_pcnt *   0.00 / 100 + T.Populated_sales_price_pcnt *   0.00 / 100 + T.Populated_sales_price_code_pcnt *   0.00 / 100 + T.Populated_city_transfer_tax_pcnt *   0.00 / 100 + T.Populated_county_transfer_tax_pcnt *   0.00 / 100 + T.Populated_total_transfer_tax_pcnt *   0.00 / 100 + T.Populated_first_td_loan_amount_pcnt *   0.00 / 100 + T.Populated_second_td_loan_amount_pcnt *   0.00 / 100 + T.Populated_first_td_lender_type_code_pcnt *   0.00 / 100 + T.Populated_second_td_lender_type_code_pcnt *   0.00 / 100 + T.Populated_first_td_loan_type_code_pcnt *   0.00 / 100 + T.Populated_type_financing_pcnt *   0.00 / 100 + T.Populated_first_td_interest_rate_pcnt *   0.00 / 100 + T.Populated_first_td_due_date_pcnt *   0.00 / 100 + T.Populated_title_company_name_pcnt *   0.00 / 100 + T.Populated_partial_interest_transferred_pcnt *   0.00 / 100 + T.Populated_loan_term_months_pcnt *   0.00 / 100 + T.Populated_loan_term_years_pcnt *   0.00 / 100 + T.Populated_lender_name_pcnt *   0.00 / 100 + T.Populated_lender_name_id_pcnt *   0.00 / 100 + T.Populated_lender_dba_aka_name_pcnt *   0.00 / 100 + T.Populated_lender_full_street_address_pcnt *   0.00 / 100 + T.Populated_lender_address_unit_number_pcnt *   0.00 / 100 + T.Populated_lender_address_citystatezip_pcnt *   0.00 / 100 + T.Populated_assessment_match_land_use_code_pcnt *   0.00 / 100 + T.Populated_property_use_code_pcnt *   0.00 / 100 + T.Populated_condo_code_pcnt *   0.00 / 100 + T.Populated_timeshare_flag_pcnt *   0.00 / 100 + T.Populated_land_lot_size_pcnt *   0.00 / 100 + T.Populated_hawaii_tct_pcnt *   0.00 / 100 + T.Populated_hawaii_condo_cpr_code_pcnt *   0.00 / 100 + T.Populated_hawaii_condo_name_pcnt *   0.00 / 100 + T.Populated_filler_except_hawaii_pcnt *   0.00 / 100 + T.Populated_rate_change_frequency_pcnt *   0.00 / 100 + T.Populated_change_index_pcnt *   0.00 / 100 + T.Populated_adjustable_rate_index_pcnt *   0.00 / 100 + T.Populated_adjustable_rate_rider_pcnt *   0.00 / 100 + T.Populated_graduated_payment_rider_pcnt *   0.00 / 100 + T.Populated_balloon_rider_pcnt *   0.00 / 100 + T.Populated_fixed_step_rate_rider_pcnt *   0.00 / 100 + T.Populated_condominium_rider_pcnt *   0.00 / 100 + T.Populated_planned_unit_development_rider_pcnt *   0.00 / 100 + T.Populated_rate_improvement_rider_pcnt *   0.00 / 100 + T.Populated_assumability_rider_pcnt *   0.00 / 100 + T.Populated_prepayment_rider_pcnt *   0.00 / 100 + T.Populated_one_four_family_rider_pcnt *   0.00 / 100 + T.Populated_biweekly_payment_rider_pcnt *   0.00 / 100 + T.Populated_second_home_rider_pcnt *   0.00 / 100 + T.Populated_data_source_code_pcnt *   0.00 / 100 + T.Populated_main_record_id_code_pcnt *   0.00 / 100 + T.Populated_addl_name_flag_pcnt *   0.00 / 100 + T.Populated_prop_addr_propagated_ind_pcnt *   0.00 / 100 + T.Populated_ln_ownership_rights_pcnt *   0.00 / 100 + T.Populated_ln_relationship_type_pcnt *   0.00 / 100 + T.Populated_ln_buyer_mailing_country_code_pcnt *   0.00 / 100 + T.Populated_ln_seller_mailing_country_code_pcnt *   0.00 / 100;
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
    SELF.LinkingPotential := 0 + le.Populated_ln_fares_id_pcnt*ri.Populated_ln_fares_id_pcnt *   0.00 / 10000 + le.Populated_process_date_pcnt*ri.Populated_process_date_pcnt *   0.00 / 10000 + le.Populated_vendor_source_flag_pcnt*ri.Populated_vendor_source_flag_pcnt *   0.00 / 10000 + le.Populated_current_record_pcnt*ri.Populated_current_record_pcnt *   0.00 / 10000 + le.Populated_from_file_pcnt*ri.Populated_from_file_pcnt *   0.00 / 10000 + le.Populated_fips_code_pcnt*ri.Populated_fips_code_pcnt *   0.00 / 10000 + le.Populated_state_pcnt*ri.Populated_state_pcnt *   0.00 / 10000 + le.Populated_county_name_pcnt*ri.Populated_county_name_pcnt *   0.00 / 10000 + le.Populated_record_type_pcnt*ri.Populated_record_type_pcnt *   0.00 / 10000 + le.Populated_apnt_or_pin_number_pcnt*ri.Populated_apnt_or_pin_number_pcnt *   0.00 / 10000 + le.Populated_fares_unformatted_apn_pcnt*ri.Populated_fares_unformatted_apn_pcnt *   0.00 / 10000 + le.Populated_multi_apn_flag_pcnt*ri.Populated_multi_apn_flag_pcnt *   0.00 / 10000 + le.Populated_tax_id_number_pcnt*ri.Populated_tax_id_number_pcnt *   0.00 / 10000 + le.Populated_excise_tax_number_pcnt*ri.Populated_excise_tax_number_pcnt *   0.00 / 10000 + le.Populated_buyer_or_borrower_ind_pcnt*ri.Populated_buyer_or_borrower_ind_pcnt *   0.00 / 10000 + le.Populated_name1_pcnt*ri.Populated_name1_pcnt *   0.00 / 10000 + le.Populated_name1_id_code_pcnt*ri.Populated_name1_id_code_pcnt *   0.00 / 10000 + le.Populated_name2_pcnt*ri.Populated_name2_pcnt *   0.00 / 10000 + le.Populated_name2_id_code_pcnt*ri.Populated_name2_id_code_pcnt *   0.00 / 10000 + le.Populated_vesting_code_pcnt*ri.Populated_vesting_code_pcnt *   0.00 / 10000 + le.Populated_addendum_flag_pcnt*ri.Populated_addendum_flag_pcnt *   0.00 / 10000 + le.Populated_phone_number_pcnt*ri.Populated_phone_number_pcnt *   0.00 / 10000 + le.Populated_mailing_care_of_pcnt*ri.Populated_mailing_care_of_pcnt *   0.00 / 10000 + le.Populated_mailing_street_pcnt*ri.Populated_mailing_street_pcnt *   0.00 / 10000 + le.Populated_mailing_unit_number_pcnt*ri.Populated_mailing_unit_number_pcnt *   0.00 / 10000 + le.Populated_mailing_csz_pcnt*ri.Populated_mailing_csz_pcnt *   0.00 / 10000 + le.Populated_mailing_address_cd_pcnt*ri.Populated_mailing_address_cd_pcnt *   0.00 / 10000 + le.Populated_seller1_pcnt*ri.Populated_seller1_pcnt *   0.00 / 10000 + le.Populated_seller1_id_code_pcnt*ri.Populated_seller1_id_code_pcnt *   0.00 / 10000 + le.Populated_seller2_pcnt*ri.Populated_seller2_pcnt *   0.00 / 10000 + le.Populated_seller2_id_code_pcnt*ri.Populated_seller2_id_code_pcnt *   0.00 / 10000 + le.Populated_seller_addendum_flag_pcnt*ri.Populated_seller_addendum_flag_pcnt *   0.00 / 10000 + le.Populated_seller_mailing_full_street_address_pcnt*ri.Populated_seller_mailing_full_street_address_pcnt *   0.00 / 10000 + le.Populated_seller_mailing_address_unit_number_pcnt*ri.Populated_seller_mailing_address_unit_number_pcnt *   0.00 / 10000 + le.Populated_seller_mailing_address_citystatezip_pcnt*ri.Populated_seller_mailing_address_citystatezip_pcnt *   0.00 / 10000 + le.Populated_property_full_street_address_pcnt*ri.Populated_property_full_street_address_pcnt *   0.00 / 10000 + le.Populated_property_address_unit_number_pcnt*ri.Populated_property_address_unit_number_pcnt *   0.00 / 10000 + le.Populated_property_address_citystatezip_pcnt*ri.Populated_property_address_citystatezip_pcnt *   0.00 / 10000 + le.Populated_property_address_code_pcnt*ri.Populated_property_address_code_pcnt *   0.00 / 10000 + le.Populated_legal_lot_code_pcnt*ri.Populated_legal_lot_code_pcnt *   0.00 / 10000 + le.Populated_legal_lot_number_pcnt*ri.Populated_legal_lot_number_pcnt *   0.00 / 10000 + le.Populated_legal_block_pcnt*ri.Populated_legal_block_pcnt *   0.00 / 10000 + le.Populated_legal_section_pcnt*ri.Populated_legal_section_pcnt *   0.00 / 10000 + le.Populated_legal_district_pcnt*ri.Populated_legal_district_pcnt *   0.00 / 10000 + le.Populated_legal_land_lot_pcnt*ri.Populated_legal_land_lot_pcnt *   0.00 / 10000 + le.Populated_legal_unit_pcnt*ri.Populated_legal_unit_pcnt *   0.00 / 10000 + le.Populated_legal_city_municipality_township_pcnt*ri.Populated_legal_city_municipality_township_pcnt *   0.00 / 10000 + le.Populated_legal_subdivision_name_pcnt*ri.Populated_legal_subdivision_name_pcnt *   0.00 / 10000 + le.Populated_legal_phase_number_pcnt*ri.Populated_legal_phase_number_pcnt *   0.00 / 10000 + le.Populated_legal_tract_number_pcnt*ri.Populated_legal_tract_number_pcnt *   0.00 / 10000 + le.Populated_legal_sec_twn_rng_mer_pcnt*ri.Populated_legal_sec_twn_rng_mer_pcnt *   0.00 / 10000 + le.Populated_legal_brief_description_pcnt*ri.Populated_legal_brief_description_pcnt *   0.00 / 10000 + le.Populated_recorder_map_reference_pcnt*ri.Populated_recorder_map_reference_pcnt *   0.00 / 10000 + le.Populated_complete_legal_description_code_pcnt*ri.Populated_complete_legal_description_code_pcnt *   0.00 / 10000 + le.Populated_contract_date_pcnt*ri.Populated_contract_date_pcnt *   0.00 / 10000 + le.Populated_recording_date_pcnt*ri.Populated_recording_date_pcnt *   0.00 / 10000 + le.Populated_arm_reset_date_pcnt*ri.Populated_arm_reset_date_pcnt *   0.00 / 10000 + le.Populated_document_number_pcnt*ri.Populated_document_number_pcnt *   0.00 / 10000 + le.Populated_document_type_code_pcnt*ri.Populated_document_type_code_pcnt *   0.00 / 10000 + le.Populated_loan_number_pcnt*ri.Populated_loan_number_pcnt *   0.00 / 10000 + le.Populated_recorder_book_number_pcnt*ri.Populated_recorder_book_number_pcnt *   0.00 / 10000 + le.Populated_recorder_page_number_pcnt*ri.Populated_recorder_page_number_pcnt *   0.00 / 10000 + le.Populated_concurrent_mortgage_book_page_document_number_pcnt*ri.Populated_concurrent_mortgage_book_page_document_number_pcnt *   0.00 / 10000 + le.Populated_sales_price_pcnt*ri.Populated_sales_price_pcnt *   0.00 / 10000 + le.Populated_sales_price_code_pcnt*ri.Populated_sales_price_code_pcnt *   0.00 / 10000 + le.Populated_city_transfer_tax_pcnt*ri.Populated_city_transfer_tax_pcnt *   0.00 / 10000 + le.Populated_county_transfer_tax_pcnt*ri.Populated_county_transfer_tax_pcnt *   0.00 / 10000 + le.Populated_total_transfer_tax_pcnt*ri.Populated_total_transfer_tax_pcnt *   0.00 / 10000 + le.Populated_first_td_loan_amount_pcnt*ri.Populated_first_td_loan_amount_pcnt *   0.00 / 10000 + le.Populated_second_td_loan_amount_pcnt*ri.Populated_second_td_loan_amount_pcnt *   0.00 / 10000 + le.Populated_first_td_lender_type_code_pcnt*ri.Populated_first_td_lender_type_code_pcnt *   0.00 / 10000 + le.Populated_second_td_lender_type_code_pcnt*ri.Populated_second_td_lender_type_code_pcnt *   0.00 / 10000 + le.Populated_first_td_loan_type_code_pcnt*ri.Populated_first_td_loan_type_code_pcnt *   0.00 / 10000 + le.Populated_type_financing_pcnt*ri.Populated_type_financing_pcnt *   0.00 / 10000 + le.Populated_first_td_interest_rate_pcnt*ri.Populated_first_td_interest_rate_pcnt *   0.00 / 10000 + le.Populated_first_td_due_date_pcnt*ri.Populated_first_td_due_date_pcnt *   0.00 / 10000 + le.Populated_title_company_name_pcnt*ri.Populated_title_company_name_pcnt *   0.00 / 10000 + le.Populated_partial_interest_transferred_pcnt*ri.Populated_partial_interest_transferred_pcnt *   0.00 / 10000 + le.Populated_loan_term_months_pcnt*ri.Populated_loan_term_months_pcnt *   0.00 / 10000 + le.Populated_loan_term_years_pcnt*ri.Populated_loan_term_years_pcnt *   0.00 / 10000 + le.Populated_lender_name_pcnt*ri.Populated_lender_name_pcnt *   0.00 / 10000 + le.Populated_lender_name_id_pcnt*ri.Populated_lender_name_id_pcnt *   0.00 / 10000 + le.Populated_lender_dba_aka_name_pcnt*ri.Populated_lender_dba_aka_name_pcnt *   0.00 / 10000 + le.Populated_lender_full_street_address_pcnt*ri.Populated_lender_full_street_address_pcnt *   0.00 / 10000 + le.Populated_lender_address_unit_number_pcnt*ri.Populated_lender_address_unit_number_pcnt *   0.00 / 10000 + le.Populated_lender_address_citystatezip_pcnt*ri.Populated_lender_address_citystatezip_pcnt *   0.00 / 10000 + le.Populated_assessment_match_land_use_code_pcnt*ri.Populated_assessment_match_land_use_code_pcnt *   0.00 / 10000 + le.Populated_property_use_code_pcnt*ri.Populated_property_use_code_pcnt *   0.00 / 10000 + le.Populated_condo_code_pcnt*ri.Populated_condo_code_pcnt *   0.00 / 10000 + le.Populated_timeshare_flag_pcnt*ri.Populated_timeshare_flag_pcnt *   0.00 / 10000 + le.Populated_land_lot_size_pcnt*ri.Populated_land_lot_size_pcnt *   0.00 / 10000 + le.Populated_hawaii_tct_pcnt*ri.Populated_hawaii_tct_pcnt *   0.00 / 10000 + le.Populated_hawaii_condo_cpr_code_pcnt*ri.Populated_hawaii_condo_cpr_code_pcnt *   0.00 / 10000 + le.Populated_hawaii_condo_name_pcnt*ri.Populated_hawaii_condo_name_pcnt *   0.00 / 10000 + le.Populated_filler_except_hawaii_pcnt*ri.Populated_filler_except_hawaii_pcnt *   0.00 / 10000 + le.Populated_rate_change_frequency_pcnt*ri.Populated_rate_change_frequency_pcnt *   0.00 / 10000 + le.Populated_change_index_pcnt*ri.Populated_change_index_pcnt *   0.00 / 10000 + le.Populated_adjustable_rate_index_pcnt*ri.Populated_adjustable_rate_index_pcnt *   0.00 / 10000 + le.Populated_adjustable_rate_rider_pcnt*ri.Populated_adjustable_rate_rider_pcnt *   0.00 / 10000 + le.Populated_graduated_payment_rider_pcnt*ri.Populated_graduated_payment_rider_pcnt *   0.00 / 10000 + le.Populated_balloon_rider_pcnt*ri.Populated_balloon_rider_pcnt *   0.00 / 10000 + le.Populated_fixed_step_rate_rider_pcnt*ri.Populated_fixed_step_rate_rider_pcnt *   0.00 / 10000 + le.Populated_condominium_rider_pcnt*ri.Populated_condominium_rider_pcnt *   0.00 / 10000 + le.Populated_planned_unit_development_rider_pcnt*ri.Populated_planned_unit_development_rider_pcnt *   0.00 / 10000 + le.Populated_rate_improvement_rider_pcnt*ri.Populated_rate_improvement_rider_pcnt *   0.00 / 10000 + le.Populated_assumability_rider_pcnt*ri.Populated_assumability_rider_pcnt *   0.00 / 10000 + le.Populated_prepayment_rider_pcnt*ri.Populated_prepayment_rider_pcnt *   0.00 / 10000 + le.Populated_one_four_family_rider_pcnt*ri.Populated_one_four_family_rider_pcnt *   0.00 / 10000 + le.Populated_biweekly_payment_rider_pcnt*ri.Populated_biweekly_payment_rider_pcnt *   0.00 / 10000 + le.Populated_second_home_rider_pcnt*ri.Populated_second_home_rider_pcnt *   0.00 / 10000 + le.Populated_data_source_code_pcnt*ri.Populated_data_source_code_pcnt *   0.00 / 10000 + le.Populated_main_record_id_code_pcnt*ri.Populated_main_record_id_code_pcnt *   0.00 / 10000 + le.Populated_addl_name_flag_pcnt*ri.Populated_addl_name_flag_pcnt *   0.00 / 10000 + le.Populated_prop_addr_propagated_ind_pcnt*ri.Populated_prop_addr_propagated_ind_pcnt *   0.00 / 10000 + le.Populated_ln_ownership_rights_pcnt*ri.Populated_ln_ownership_rights_pcnt *   0.00 / 10000 + le.Populated_ln_relationship_type_pcnt*ri.Populated_ln_relationship_type_pcnt *   0.00 / 10000 + le.Populated_ln_buyer_mailing_country_code_pcnt*ri.Populated_ln_buyer_mailing_country_code_pcnt *   0.00 / 10000 + le.Populated_ln_seller_mailing_country_code_pcnt*ri.Populated_ln_seller_mailing_country_code_pcnt *   0.00 / 10000;
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
  SELF.FieldName := CHOOSE(C,'ln_fares_id','process_date','vendor_source_flag','current_record','from_file','fips_code','state','county_name','record_type','apnt_or_pin_number','fares_unformatted_apn','multi_apn_flag','tax_id_number','excise_tax_number','buyer_or_borrower_ind','name1','name1_id_code','name2','name2_id_code','vesting_code','addendum_flag','phone_number','mailing_care_of','mailing_street','mailing_unit_number','mailing_csz','mailing_address_cd','seller1','seller1_id_code','seller2','seller2_id_code','seller_addendum_flag','seller_mailing_full_street_address','seller_mailing_address_unit_number','seller_mailing_address_citystatezip','property_full_street_address','property_address_unit_number','property_address_citystatezip','property_address_code','legal_lot_code','legal_lot_number','legal_block','legal_section','legal_district','legal_land_lot','legal_unit','legal_city_municipality_township','legal_subdivision_name','legal_phase_number','legal_tract_number','legal_sec_twn_rng_mer','legal_brief_description','recorder_map_reference','complete_legal_description_code','contract_date','recording_date','arm_reset_date','document_number','document_type_code','loan_number','recorder_book_number','recorder_page_number','concurrent_mortgage_book_page_document_number','sales_price','sales_price_code','city_transfer_tax','county_transfer_tax','total_transfer_tax','first_td_loan_amount','second_td_loan_amount','first_td_lender_type_code','second_td_lender_type_code','first_td_loan_type_code','type_financing','first_td_interest_rate','first_td_due_date','title_company_name','partial_interest_transferred','loan_term_months','loan_term_years','lender_name','lender_name_id','lender_dba_aka_name','lender_full_street_address','lender_address_unit_number','lender_address_citystatezip','assessment_match_land_use_code','property_use_code','condo_code','timeshare_flag','land_lot_size','hawaii_tct','hawaii_condo_cpr_code','hawaii_condo_name','filler_except_hawaii','rate_change_frequency','change_index','adjustable_rate_index','adjustable_rate_rider','graduated_payment_rider','balloon_rider','fixed_step_rate_rider','condominium_rider','planned_unit_development_rider','rate_improvement_rider','assumability_rider','prepayment_rider','one_four_family_rider','biweekly_payment_rider','second_home_rider','data_source_code','main_record_id_code','addl_name_flag','prop_addr_propagated_ind','ln_ownership_rights','ln_relationship_type','ln_buyer_mailing_country_code','ln_seller_mailing_country_code');
  SELF.populated_pcnt := CHOOSE(C,le.populated_ln_fares_id_pcnt,le.populated_process_date_pcnt,le.populated_vendor_source_flag_pcnt,le.populated_current_record_pcnt,le.populated_from_file_pcnt,le.populated_fips_code_pcnt,le.populated_state_pcnt,le.populated_county_name_pcnt,le.populated_record_type_pcnt,le.populated_apnt_or_pin_number_pcnt,le.populated_fares_unformatted_apn_pcnt,le.populated_multi_apn_flag_pcnt,le.populated_tax_id_number_pcnt,le.populated_excise_tax_number_pcnt,le.populated_buyer_or_borrower_ind_pcnt,le.populated_name1_pcnt,le.populated_name1_id_code_pcnt,le.populated_name2_pcnt,le.populated_name2_id_code_pcnt,le.populated_vesting_code_pcnt,le.populated_addendum_flag_pcnt,le.populated_phone_number_pcnt,le.populated_mailing_care_of_pcnt,le.populated_mailing_street_pcnt,le.populated_mailing_unit_number_pcnt,le.populated_mailing_csz_pcnt,le.populated_mailing_address_cd_pcnt,le.populated_seller1_pcnt,le.populated_seller1_id_code_pcnt,le.populated_seller2_pcnt,le.populated_seller2_id_code_pcnt,le.populated_seller_addendum_flag_pcnt,le.populated_seller_mailing_full_street_address_pcnt,le.populated_seller_mailing_address_unit_number_pcnt,le.populated_seller_mailing_address_citystatezip_pcnt,le.populated_property_full_street_address_pcnt,le.populated_property_address_unit_number_pcnt,le.populated_property_address_citystatezip_pcnt,le.populated_property_address_code_pcnt,le.populated_legal_lot_code_pcnt,le.populated_legal_lot_number_pcnt,le.populated_legal_block_pcnt,le.populated_legal_section_pcnt,le.populated_legal_district_pcnt,le.populated_legal_land_lot_pcnt,le.populated_legal_unit_pcnt,le.populated_legal_city_municipality_township_pcnt,le.populated_legal_subdivision_name_pcnt,le.populated_legal_phase_number_pcnt,le.populated_legal_tract_number_pcnt,le.populated_legal_sec_twn_rng_mer_pcnt,le.populated_legal_brief_description_pcnt,le.populated_recorder_map_reference_pcnt,le.populated_complete_legal_description_code_pcnt,le.populated_contract_date_pcnt,le.populated_recording_date_pcnt,le.populated_arm_reset_date_pcnt,le.populated_document_number_pcnt,le.populated_document_type_code_pcnt,le.populated_loan_number_pcnt,le.populated_recorder_book_number_pcnt,le.populated_recorder_page_number_pcnt,le.populated_concurrent_mortgage_book_page_document_number_pcnt,le.populated_sales_price_pcnt,le.populated_sales_price_code_pcnt,le.populated_city_transfer_tax_pcnt,le.populated_county_transfer_tax_pcnt,le.populated_total_transfer_tax_pcnt,le.populated_first_td_loan_amount_pcnt,le.populated_second_td_loan_amount_pcnt,le.populated_first_td_lender_type_code_pcnt,le.populated_second_td_lender_type_code_pcnt,le.populated_first_td_loan_type_code_pcnt,le.populated_type_financing_pcnt,le.populated_first_td_interest_rate_pcnt,le.populated_first_td_due_date_pcnt,le.populated_title_company_name_pcnt,le.populated_partial_interest_transferred_pcnt,le.populated_loan_term_months_pcnt,le.populated_loan_term_years_pcnt,le.populated_lender_name_pcnt,le.populated_lender_name_id_pcnt,le.populated_lender_dba_aka_name_pcnt,le.populated_lender_full_street_address_pcnt,le.populated_lender_address_unit_number_pcnt,le.populated_lender_address_citystatezip_pcnt,le.populated_assessment_match_land_use_code_pcnt,le.populated_property_use_code_pcnt,le.populated_condo_code_pcnt,le.populated_timeshare_flag_pcnt,le.populated_land_lot_size_pcnt,le.populated_hawaii_tct_pcnt,le.populated_hawaii_condo_cpr_code_pcnt,le.populated_hawaii_condo_name_pcnt,le.populated_filler_except_hawaii_pcnt,le.populated_rate_change_frequency_pcnt,le.populated_change_index_pcnt,le.populated_adjustable_rate_index_pcnt,le.populated_adjustable_rate_rider_pcnt,le.populated_graduated_payment_rider_pcnt,le.populated_balloon_rider_pcnt,le.populated_fixed_step_rate_rider_pcnt,le.populated_condominium_rider_pcnt,le.populated_planned_unit_development_rider_pcnt,le.populated_rate_improvement_rider_pcnt,le.populated_assumability_rider_pcnt,le.populated_prepayment_rider_pcnt,le.populated_one_four_family_rider_pcnt,le.populated_biweekly_payment_rider_pcnt,le.populated_second_home_rider_pcnt,le.populated_data_source_code_pcnt,le.populated_main_record_id_code_pcnt,le.populated_addl_name_flag_pcnt,le.populated_prop_addr_propagated_ind_pcnt,le.populated_ln_ownership_rights_pcnt,le.populated_ln_relationship_type_pcnt,le.populated_ln_buyer_mailing_country_code_pcnt,le.populated_ln_seller_mailing_country_code_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_ln_fares_id,le.maxlength_process_date,le.maxlength_vendor_source_flag,le.maxlength_current_record,le.maxlength_from_file,le.maxlength_fips_code,le.maxlength_state,le.maxlength_county_name,le.maxlength_record_type,le.maxlength_apnt_or_pin_number,le.maxlength_fares_unformatted_apn,le.maxlength_multi_apn_flag,le.maxlength_tax_id_number,le.maxlength_excise_tax_number,le.maxlength_buyer_or_borrower_ind,le.maxlength_name1,le.maxlength_name1_id_code,le.maxlength_name2,le.maxlength_name2_id_code,le.maxlength_vesting_code,le.maxlength_addendum_flag,le.maxlength_phone_number,le.maxlength_mailing_care_of,le.maxlength_mailing_street,le.maxlength_mailing_unit_number,le.maxlength_mailing_csz,le.maxlength_mailing_address_cd,le.maxlength_seller1,le.maxlength_seller1_id_code,le.maxlength_seller2,le.maxlength_seller2_id_code,le.maxlength_seller_addendum_flag,le.maxlength_seller_mailing_full_street_address,le.maxlength_seller_mailing_address_unit_number,le.maxlength_seller_mailing_address_citystatezip,le.maxlength_property_full_street_address,le.maxlength_property_address_unit_number,le.maxlength_property_address_citystatezip,le.maxlength_property_address_code,le.maxlength_legal_lot_code,le.maxlength_legal_lot_number,le.maxlength_legal_block,le.maxlength_legal_section,le.maxlength_legal_district,le.maxlength_legal_land_lot,le.maxlength_legal_unit,le.maxlength_legal_city_municipality_township,le.maxlength_legal_subdivision_name,le.maxlength_legal_phase_number,le.maxlength_legal_tract_number,le.maxlength_legal_sec_twn_rng_mer,le.maxlength_legal_brief_description,le.maxlength_recorder_map_reference,le.maxlength_complete_legal_description_code,le.maxlength_contract_date,le.maxlength_recording_date,le.maxlength_arm_reset_date,le.maxlength_document_number,le.maxlength_document_type_code,le.maxlength_loan_number,le.maxlength_recorder_book_number,le.maxlength_recorder_page_number,le.maxlength_concurrent_mortgage_book_page_document_number,le.maxlength_sales_price,le.maxlength_sales_price_code,le.maxlength_city_transfer_tax,le.maxlength_county_transfer_tax,le.maxlength_total_transfer_tax,le.maxlength_first_td_loan_amount,le.maxlength_second_td_loan_amount,le.maxlength_first_td_lender_type_code,le.maxlength_second_td_lender_type_code,le.maxlength_first_td_loan_type_code,le.maxlength_type_financing,le.maxlength_first_td_interest_rate,le.maxlength_first_td_due_date,le.maxlength_title_company_name,le.maxlength_partial_interest_transferred,le.maxlength_loan_term_months,le.maxlength_loan_term_years,le.maxlength_lender_name,le.maxlength_lender_name_id,le.maxlength_lender_dba_aka_name,le.maxlength_lender_full_street_address,le.maxlength_lender_address_unit_number,le.maxlength_lender_address_citystatezip,le.maxlength_assessment_match_land_use_code,le.maxlength_property_use_code,le.maxlength_condo_code,le.maxlength_timeshare_flag,le.maxlength_land_lot_size,le.maxlength_hawaii_tct,le.maxlength_hawaii_condo_cpr_code,le.maxlength_hawaii_condo_name,le.maxlength_filler_except_hawaii,le.maxlength_rate_change_frequency,le.maxlength_change_index,le.maxlength_adjustable_rate_index,le.maxlength_adjustable_rate_rider,le.maxlength_graduated_payment_rider,le.maxlength_balloon_rider,le.maxlength_fixed_step_rate_rider,le.maxlength_condominium_rider,le.maxlength_planned_unit_development_rider,le.maxlength_rate_improvement_rider,le.maxlength_assumability_rider,le.maxlength_prepayment_rider,le.maxlength_one_four_family_rider,le.maxlength_biweekly_payment_rider,le.maxlength_second_home_rider,le.maxlength_data_source_code,le.maxlength_main_record_id_code,le.maxlength_addl_name_flag,le.maxlength_prop_addr_propagated_ind,le.maxlength_ln_ownership_rights,le.maxlength_ln_relationship_type,le.maxlength_ln_buyer_mailing_country_code,le.maxlength_ln_seller_mailing_country_code);
  SELF.avelength := CHOOSE(C,le.avelength_ln_fares_id,le.avelength_process_date,le.avelength_vendor_source_flag,le.avelength_current_record,le.avelength_from_file,le.avelength_fips_code,le.avelength_state,le.avelength_county_name,le.avelength_record_type,le.avelength_apnt_or_pin_number,le.avelength_fares_unformatted_apn,le.avelength_multi_apn_flag,le.avelength_tax_id_number,le.avelength_excise_tax_number,le.avelength_buyer_or_borrower_ind,le.avelength_name1,le.avelength_name1_id_code,le.avelength_name2,le.avelength_name2_id_code,le.avelength_vesting_code,le.avelength_addendum_flag,le.avelength_phone_number,le.avelength_mailing_care_of,le.avelength_mailing_street,le.avelength_mailing_unit_number,le.avelength_mailing_csz,le.avelength_mailing_address_cd,le.avelength_seller1,le.avelength_seller1_id_code,le.avelength_seller2,le.avelength_seller2_id_code,le.avelength_seller_addendum_flag,le.avelength_seller_mailing_full_street_address,le.avelength_seller_mailing_address_unit_number,le.avelength_seller_mailing_address_citystatezip,le.avelength_property_full_street_address,le.avelength_property_address_unit_number,le.avelength_property_address_citystatezip,le.avelength_property_address_code,le.avelength_legal_lot_code,le.avelength_legal_lot_number,le.avelength_legal_block,le.avelength_legal_section,le.avelength_legal_district,le.avelength_legal_land_lot,le.avelength_legal_unit,le.avelength_legal_city_municipality_township,le.avelength_legal_subdivision_name,le.avelength_legal_phase_number,le.avelength_legal_tract_number,le.avelength_legal_sec_twn_rng_mer,le.avelength_legal_brief_description,le.avelength_recorder_map_reference,le.avelength_complete_legal_description_code,le.avelength_contract_date,le.avelength_recording_date,le.avelength_arm_reset_date,le.avelength_document_number,le.avelength_document_type_code,le.avelength_loan_number,le.avelength_recorder_book_number,le.avelength_recorder_page_number,le.avelength_concurrent_mortgage_book_page_document_number,le.avelength_sales_price,le.avelength_sales_price_code,le.avelength_city_transfer_tax,le.avelength_county_transfer_tax,le.avelength_total_transfer_tax,le.avelength_first_td_loan_amount,le.avelength_second_td_loan_amount,le.avelength_first_td_lender_type_code,le.avelength_second_td_lender_type_code,le.avelength_first_td_loan_type_code,le.avelength_type_financing,le.avelength_first_td_interest_rate,le.avelength_first_td_due_date,le.avelength_title_company_name,le.avelength_partial_interest_transferred,le.avelength_loan_term_months,le.avelength_loan_term_years,le.avelength_lender_name,le.avelength_lender_name_id,le.avelength_lender_dba_aka_name,le.avelength_lender_full_street_address,le.avelength_lender_address_unit_number,le.avelength_lender_address_citystatezip,le.avelength_assessment_match_land_use_code,le.avelength_property_use_code,le.avelength_condo_code,le.avelength_timeshare_flag,le.avelength_land_lot_size,le.avelength_hawaii_tct,le.avelength_hawaii_condo_cpr_code,le.avelength_hawaii_condo_name,le.avelength_filler_except_hawaii,le.avelength_rate_change_frequency,le.avelength_change_index,le.avelength_adjustable_rate_index,le.avelength_adjustable_rate_rider,le.avelength_graduated_payment_rider,le.avelength_balloon_rider,le.avelength_fixed_step_rate_rider,le.avelength_condominium_rider,le.avelength_planned_unit_development_rider,le.avelength_rate_improvement_rider,le.avelength_assumability_rider,le.avelength_prepayment_rider,le.avelength_one_four_family_rider,le.avelength_biweekly_payment_rider,le.avelength_second_home_rider,le.avelength_data_source_code,le.avelength_main_record_id_code,le.avelength_addl_name_flag,le.avelength_prop_addr_propagated_ind,le.avelength_ln_ownership_rights,le.avelength_ln_relationship_type,le.avelength_ln_buyer_mailing_country_code,le.avelength_ln_seller_mailing_country_code);
END;
EXPORT invSummary := NORMALIZE(summary0, 118, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.fips_code;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.ln_fares_id),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.vendor_source_flag),TRIM((SALT311.StrType)le.current_record),TRIM((SALT311.StrType)le.from_file),TRIM((SALT311.StrType)le.fips_code),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.county_name),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.apnt_or_pin_number),TRIM((SALT311.StrType)le.fares_unformatted_apn),TRIM((SALT311.StrType)le.multi_apn_flag),TRIM((SALT311.StrType)le.tax_id_number),TRIM((SALT311.StrType)le.excise_tax_number),TRIM((SALT311.StrType)le.buyer_or_borrower_ind),TRIM((SALT311.StrType)le.name1),TRIM((SALT311.StrType)le.name1_id_code),TRIM((SALT311.StrType)le.name2),TRIM((SALT311.StrType)le.name2_id_code),TRIM((SALT311.StrType)le.vesting_code),TRIM((SALT311.StrType)le.addendum_flag),TRIM((SALT311.StrType)le.phone_number),TRIM((SALT311.StrType)le.mailing_care_of),TRIM((SALT311.StrType)le.mailing_street),TRIM((SALT311.StrType)le.mailing_unit_number),TRIM((SALT311.StrType)le.mailing_csz),TRIM((SALT311.StrType)le.mailing_address_cd),TRIM((SALT311.StrType)le.seller1),TRIM((SALT311.StrType)le.seller1_id_code),TRIM((SALT311.StrType)le.seller2),TRIM((SALT311.StrType)le.seller2_id_code),TRIM((SALT311.StrType)le.seller_addendum_flag),TRIM((SALT311.StrType)le.seller_mailing_full_street_address),TRIM((SALT311.StrType)le.seller_mailing_address_unit_number),TRIM((SALT311.StrType)le.seller_mailing_address_citystatezip),TRIM((SALT311.StrType)le.property_full_street_address),TRIM((SALT311.StrType)le.property_address_unit_number),TRIM((SALT311.StrType)le.property_address_citystatezip),TRIM((SALT311.StrType)le.property_address_code),TRIM((SALT311.StrType)le.legal_lot_code),TRIM((SALT311.StrType)le.legal_lot_number),TRIM((SALT311.StrType)le.legal_block),TRIM((SALT311.StrType)le.legal_section),TRIM((SALT311.StrType)le.legal_district),TRIM((SALT311.StrType)le.legal_land_lot),TRIM((SALT311.StrType)le.legal_unit),TRIM((SALT311.StrType)le.legal_city_municipality_township),TRIM((SALT311.StrType)le.legal_subdivision_name),TRIM((SALT311.StrType)le.legal_phase_number),TRIM((SALT311.StrType)le.legal_tract_number),TRIM((SALT311.StrType)le.legal_sec_twn_rng_mer),TRIM((SALT311.StrType)le.legal_brief_description),TRIM((SALT311.StrType)le.recorder_map_reference),TRIM((SALT311.StrType)le.complete_legal_description_code),TRIM((SALT311.StrType)le.contract_date),TRIM((SALT311.StrType)le.recording_date),TRIM((SALT311.StrType)le.arm_reset_date),TRIM((SALT311.StrType)le.document_number),TRIM((SALT311.StrType)le.document_type_code),TRIM((SALT311.StrType)le.loan_number),TRIM((SALT311.StrType)le.recorder_book_number),TRIM((SALT311.StrType)le.recorder_page_number),TRIM((SALT311.StrType)le.concurrent_mortgage_book_page_document_number),TRIM((SALT311.StrType)le.sales_price),TRIM((SALT311.StrType)le.sales_price_code),TRIM((SALT311.StrType)le.city_transfer_tax),TRIM((SALT311.StrType)le.county_transfer_tax),TRIM((SALT311.StrType)le.total_transfer_tax),TRIM((SALT311.StrType)le.first_td_loan_amount),TRIM((SALT311.StrType)le.second_td_loan_amount),TRIM((SALT311.StrType)le.first_td_lender_type_code),TRIM((SALT311.StrType)le.second_td_lender_type_code),TRIM((SALT311.StrType)le.first_td_loan_type_code),TRIM((SALT311.StrType)le.type_financing),TRIM((SALT311.StrType)le.first_td_interest_rate),TRIM((SALT311.StrType)le.first_td_due_date),TRIM((SALT311.StrType)le.title_company_name),TRIM((SALT311.StrType)le.partial_interest_transferred),TRIM((SALT311.StrType)le.loan_term_months),TRIM((SALT311.StrType)le.loan_term_years),TRIM((SALT311.StrType)le.lender_name),TRIM((SALT311.StrType)le.lender_name_id),TRIM((SALT311.StrType)le.lender_dba_aka_name),TRIM((SALT311.StrType)le.lender_full_street_address),TRIM((SALT311.StrType)le.lender_address_unit_number),TRIM((SALT311.StrType)le.lender_address_citystatezip),TRIM((SALT311.StrType)le.assessment_match_land_use_code),TRIM((SALT311.StrType)le.property_use_code),TRIM((SALT311.StrType)le.condo_code),TRIM((SALT311.StrType)le.timeshare_flag),TRIM((SALT311.StrType)le.land_lot_size),TRIM((SALT311.StrType)le.hawaii_tct),TRIM((SALT311.StrType)le.hawaii_condo_cpr_code),TRIM((SALT311.StrType)le.hawaii_condo_name),TRIM((SALT311.StrType)le.filler_except_hawaii),TRIM((SALT311.StrType)le.rate_change_frequency),TRIM((SALT311.StrType)le.change_index),TRIM((SALT311.StrType)le.adjustable_rate_index),TRIM((SALT311.StrType)le.adjustable_rate_rider),TRIM((SALT311.StrType)le.graduated_payment_rider),TRIM((SALT311.StrType)le.balloon_rider),TRIM((SALT311.StrType)le.fixed_step_rate_rider),TRIM((SALT311.StrType)le.condominium_rider),TRIM((SALT311.StrType)le.planned_unit_development_rider),TRIM((SALT311.StrType)le.rate_improvement_rider),TRIM((SALT311.StrType)le.assumability_rider),TRIM((SALT311.StrType)le.prepayment_rider),TRIM((SALT311.StrType)le.one_four_family_rider),TRIM((SALT311.StrType)le.biweekly_payment_rider),TRIM((SALT311.StrType)le.second_home_rider),TRIM((SALT311.StrType)le.data_source_code),TRIM((SALT311.StrType)le.main_record_id_code),TRIM((SALT311.StrType)le.addl_name_flag),TRIM((SALT311.StrType)le.prop_addr_propagated_ind),TRIM((SALT311.StrType)le.ln_ownership_rights),TRIM((SALT311.StrType)le.ln_relationship_type),TRIM((SALT311.StrType)le.ln_buyer_mailing_country_code),TRIM((SALT311.StrType)le.ln_seller_mailing_country_code)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,118,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 118);
  SELF.FldNo2 := 1 + (C % 118);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.ln_fares_id),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.vendor_source_flag),TRIM((SALT311.StrType)le.current_record),TRIM((SALT311.StrType)le.from_file),TRIM((SALT311.StrType)le.fips_code),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.county_name),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.apnt_or_pin_number),TRIM((SALT311.StrType)le.fares_unformatted_apn),TRIM((SALT311.StrType)le.multi_apn_flag),TRIM((SALT311.StrType)le.tax_id_number),TRIM((SALT311.StrType)le.excise_tax_number),TRIM((SALT311.StrType)le.buyer_or_borrower_ind),TRIM((SALT311.StrType)le.name1),TRIM((SALT311.StrType)le.name1_id_code),TRIM((SALT311.StrType)le.name2),TRIM((SALT311.StrType)le.name2_id_code),TRIM((SALT311.StrType)le.vesting_code),TRIM((SALT311.StrType)le.addendum_flag),TRIM((SALT311.StrType)le.phone_number),TRIM((SALT311.StrType)le.mailing_care_of),TRIM((SALT311.StrType)le.mailing_street),TRIM((SALT311.StrType)le.mailing_unit_number),TRIM((SALT311.StrType)le.mailing_csz),TRIM((SALT311.StrType)le.mailing_address_cd),TRIM((SALT311.StrType)le.seller1),TRIM((SALT311.StrType)le.seller1_id_code),TRIM((SALT311.StrType)le.seller2),TRIM((SALT311.StrType)le.seller2_id_code),TRIM((SALT311.StrType)le.seller_addendum_flag),TRIM((SALT311.StrType)le.seller_mailing_full_street_address),TRIM((SALT311.StrType)le.seller_mailing_address_unit_number),TRIM((SALT311.StrType)le.seller_mailing_address_citystatezip),TRIM((SALT311.StrType)le.property_full_street_address),TRIM((SALT311.StrType)le.property_address_unit_number),TRIM((SALT311.StrType)le.property_address_citystatezip),TRIM((SALT311.StrType)le.property_address_code),TRIM((SALT311.StrType)le.legal_lot_code),TRIM((SALT311.StrType)le.legal_lot_number),TRIM((SALT311.StrType)le.legal_block),TRIM((SALT311.StrType)le.legal_section),TRIM((SALT311.StrType)le.legal_district),TRIM((SALT311.StrType)le.legal_land_lot),TRIM((SALT311.StrType)le.legal_unit),TRIM((SALT311.StrType)le.legal_city_municipality_township),TRIM((SALT311.StrType)le.legal_subdivision_name),TRIM((SALT311.StrType)le.legal_phase_number),TRIM((SALT311.StrType)le.legal_tract_number),TRIM((SALT311.StrType)le.legal_sec_twn_rng_mer),TRIM((SALT311.StrType)le.legal_brief_description),TRIM((SALT311.StrType)le.recorder_map_reference),TRIM((SALT311.StrType)le.complete_legal_description_code),TRIM((SALT311.StrType)le.contract_date),TRIM((SALT311.StrType)le.recording_date),TRIM((SALT311.StrType)le.arm_reset_date),TRIM((SALT311.StrType)le.document_number),TRIM((SALT311.StrType)le.document_type_code),TRIM((SALT311.StrType)le.loan_number),TRIM((SALT311.StrType)le.recorder_book_number),TRIM((SALT311.StrType)le.recorder_page_number),TRIM((SALT311.StrType)le.concurrent_mortgage_book_page_document_number),TRIM((SALT311.StrType)le.sales_price),TRIM((SALT311.StrType)le.sales_price_code),TRIM((SALT311.StrType)le.city_transfer_tax),TRIM((SALT311.StrType)le.county_transfer_tax),TRIM((SALT311.StrType)le.total_transfer_tax),TRIM((SALT311.StrType)le.first_td_loan_amount),TRIM((SALT311.StrType)le.second_td_loan_amount),TRIM((SALT311.StrType)le.first_td_lender_type_code),TRIM((SALT311.StrType)le.second_td_lender_type_code),TRIM((SALT311.StrType)le.first_td_loan_type_code),TRIM((SALT311.StrType)le.type_financing),TRIM((SALT311.StrType)le.first_td_interest_rate),TRIM((SALT311.StrType)le.first_td_due_date),TRIM((SALT311.StrType)le.title_company_name),TRIM((SALT311.StrType)le.partial_interest_transferred),TRIM((SALT311.StrType)le.loan_term_months),TRIM((SALT311.StrType)le.loan_term_years),TRIM((SALT311.StrType)le.lender_name),TRIM((SALT311.StrType)le.lender_name_id),TRIM((SALT311.StrType)le.lender_dba_aka_name),TRIM((SALT311.StrType)le.lender_full_street_address),TRIM((SALT311.StrType)le.lender_address_unit_number),TRIM((SALT311.StrType)le.lender_address_citystatezip),TRIM((SALT311.StrType)le.assessment_match_land_use_code),TRIM((SALT311.StrType)le.property_use_code),TRIM((SALT311.StrType)le.condo_code),TRIM((SALT311.StrType)le.timeshare_flag),TRIM((SALT311.StrType)le.land_lot_size),TRIM((SALT311.StrType)le.hawaii_tct),TRIM((SALT311.StrType)le.hawaii_condo_cpr_code),TRIM((SALT311.StrType)le.hawaii_condo_name),TRIM((SALT311.StrType)le.filler_except_hawaii),TRIM((SALT311.StrType)le.rate_change_frequency),TRIM((SALT311.StrType)le.change_index),TRIM((SALT311.StrType)le.adjustable_rate_index),TRIM((SALT311.StrType)le.adjustable_rate_rider),TRIM((SALT311.StrType)le.graduated_payment_rider),TRIM((SALT311.StrType)le.balloon_rider),TRIM((SALT311.StrType)le.fixed_step_rate_rider),TRIM((SALT311.StrType)le.condominium_rider),TRIM((SALT311.StrType)le.planned_unit_development_rider),TRIM((SALT311.StrType)le.rate_improvement_rider),TRIM((SALT311.StrType)le.assumability_rider),TRIM((SALT311.StrType)le.prepayment_rider),TRIM((SALT311.StrType)le.one_four_family_rider),TRIM((SALT311.StrType)le.biweekly_payment_rider),TRIM((SALT311.StrType)le.second_home_rider),TRIM((SALT311.StrType)le.data_source_code),TRIM((SALT311.StrType)le.main_record_id_code),TRIM((SALT311.StrType)le.addl_name_flag),TRIM((SALT311.StrType)le.prop_addr_propagated_ind),TRIM((SALT311.StrType)le.ln_ownership_rights),TRIM((SALT311.StrType)le.ln_relationship_type),TRIM((SALT311.StrType)le.ln_buyer_mailing_country_code),TRIM((SALT311.StrType)le.ln_seller_mailing_country_code)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.ln_fares_id),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.vendor_source_flag),TRIM((SALT311.StrType)le.current_record),TRIM((SALT311.StrType)le.from_file),TRIM((SALT311.StrType)le.fips_code),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.county_name),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.apnt_or_pin_number),TRIM((SALT311.StrType)le.fares_unformatted_apn),TRIM((SALT311.StrType)le.multi_apn_flag),TRIM((SALT311.StrType)le.tax_id_number),TRIM((SALT311.StrType)le.excise_tax_number),TRIM((SALT311.StrType)le.buyer_or_borrower_ind),TRIM((SALT311.StrType)le.name1),TRIM((SALT311.StrType)le.name1_id_code),TRIM((SALT311.StrType)le.name2),TRIM((SALT311.StrType)le.name2_id_code),TRIM((SALT311.StrType)le.vesting_code),TRIM((SALT311.StrType)le.addendum_flag),TRIM((SALT311.StrType)le.phone_number),TRIM((SALT311.StrType)le.mailing_care_of),TRIM((SALT311.StrType)le.mailing_street),TRIM((SALT311.StrType)le.mailing_unit_number),TRIM((SALT311.StrType)le.mailing_csz),TRIM((SALT311.StrType)le.mailing_address_cd),TRIM((SALT311.StrType)le.seller1),TRIM((SALT311.StrType)le.seller1_id_code),TRIM((SALT311.StrType)le.seller2),TRIM((SALT311.StrType)le.seller2_id_code),TRIM((SALT311.StrType)le.seller_addendum_flag),TRIM((SALT311.StrType)le.seller_mailing_full_street_address),TRIM((SALT311.StrType)le.seller_mailing_address_unit_number),TRIM((SALT311.StrType)le.seller_mailing_address_citystatezip),TRIM((SALT311.StrType)le.property_full_street_address),TRIM((SALT311.StrType)le.property_address_unit_number),TRIM((SALT311.StrType)le.property_address_citystatezip),TRIM((SALT311.StrType)le.property_address_code),TRIM((SALT311.StrType)le.legal_lot_code),TRIM((SALT311.StrType)le.legal_lot_number),TRIM((SALT311.StrType)le.legal_block),TRIM((SALT311.StrType)le.legal_section),TRIM((SALT311.StrType)le.legal_district),TRIM((SALT311.StrType)le.legal_land_lot),TRIM((SALT311.StrType)le.legal_unit),TRIM((SALT311.StrType)le.legal_city_municipality_township),TRIM((SALT311.StrType)le.legal_subdivision_name),TRIM((SALT311.StrType)le.legal_phase_number),TRIM((SALT311.StrType)le.legal_tract_number),TRIM((SALT311.StrType)le.legal_sec_twn_rng_mer),TRIM((SALT311.StrType)le.legal_brief_description),TRIM((SALT311.StrType)le.recorder_map_reference),TRIM((SALT311.StrType)le.complete_legal_description_code),TRIM((SALT311.StrType)le.contract_date),TRIM((SALT311.StrType)le.recording_date),TRIM((SALT311.StrType)le.arm_reset_date),TRIM((SALT311.StrType)le.document_number),TRIM((SALT311.StrType)le.document_type_code),TRIM((SALT311.StrType)le.loan_number),TRIM((SALT311.StrType)le.recorder_book_number),TRIM((SALT311.StrType)le.recorder_page_number),TRIM((SALT311.StrType)le.concurrent_mortgage_book_page_document_number),TRIM((SALT311.StrType)le.sales_price),TRIM((SALT311.StrType)le.sales_price_code),TRIM((SALT311.StrType)le.city_transfer_tax),TRIM((SALT311.StrType)le.county_transfer_tax),TRIM((SALT311.StrType)le.total_transfer_tax),TRIM((SALT311.StrType)le.first_td_loan_amount),TRIM((SALT311.StrType)le.second_td_loan_amount),TRIM((SALT311.StrType)le.first_td_lender_type_code),TRIM((SALT311.StrType)le.second_td_lender_type_code),TRIM((SALT311.StrType)le.first_td_loan_type_code),TRIM((SALT311.StrType)le.type_financing),TRIM((SALT311.StrType)le.first_td_interest_rate),TRIM((SALT311.StrType)le.first_td_due_date),TRIM((SALT311.StrType)le.title_company_name),TRIM((SALT311.StrType)le.partial_interest_transferred),TRIM((SALT311.StrType)le.loan_term_months),TRIM((SALT311.StrType)le.loan_term_years),TRIM((SALT311.StrType)le.lender_name),TRIM((SALT311.StrType)le.lender_name_id),TRIM((SALT311.StrType)le.lender_dba_aka_name),TRIM((SALT311.StrType)le.lender_full_street_address),TRIM((SALT311.StrType)le.lender_address_unit_number),TRIM((SALT311.StrType)le.lender_address_citystatezip),TRIM((SALT311.StrType)le.assessment_match_land_use_code),TRIM((SALT311.StrType)le.property_use_code),TRIM((SALT311.StrType)le.condo_code),TRIM((SALT311.StrType)le.timeshare_flag),TRIM((SALT311.StrType)le.land_lot_size),TRIM((SALT311.StrType)le.hawaii_tct),TRIM((SALT311.StrType)le.hawaii_condo_cpr_code),TRIM((SALT311.StrType)le.hawaii_condo_name),TRIM((SALT311.StrType)le.filler_except_hawaii),TRIM((SALT311.StrType)le.rate_change_frequency),TRIM((SALT311.StrType)le.change_index),TRIM((SALT311.StrType)le.adjustable_rate_index),TRIM((SALT311.StrType)le.adjustable_rate_rider),TRIM((SALT311.StrType)le.graduated_payment_rider),TRIM((SALT311.StrType)le.balloon_rider),TRIM((SALT311.StrType)le.fixed_step_rate_rider),TRIM((SALT311.StrType)le.condominium_rider),TRIM((SALT311.StrType)le.planned_unit_development_rider),TRIM((SALT311.StrType)le.rate_improvement_rider),TRIM((SALT311.StrType)le.assumability_rider),TRIM((SALT311.StrType)le.prepayment_rider),TRIM((SALT311.StrType)le.one_four_family_rider),TRIM((SALT311.StrType)le.biweekly_payment_rider),TRIM((SALT311.StrType)le.second_home_rider),TRIM((SALT311.StrType)le.data_source_code),TRIM((SALT311.StrType)le.main_record_id_code),TRIM((SALT311.StrType)le.addl_name_flag),TRIM((SALT311.StrType)le.prop_addr_propagated_ind),TRIM((SALT311.StrType)le.ln_ownership_rights),TRIM((SALT311.StrType)le.ln_relationship_type),TRIM((SALT311.StrType)le.ln_buyer_mailing_country_code),TRIM((SALT311.StrType)le.ln_seller_mailing_country_code)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),118*118,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'ln_fares_id'}
      ,{2,'process_date'}
      ,{3,'vendor_source_flag'}
      ,{4,'current_record'}
      ,{5,'from_file'}
      ,{6,'fips_code'}
      ,{7,'state'}
      ,{8,'county_name'}
      ,{9,'record_type'}
      ,{10,'apnt_or_pin_number'}
      ,{11,'fares_unformatted_apn'}
      ,{12,'multi_apn_flag'}
      ,{13,'tax_id_number'}
      ,{14,'excise_tax_number'}
      ,{15,'buyer_or_borrower_ind'}
      ,{16,'name1'}
      ,{17,'name1_id_code'}
      ,{18,'name2'}
      ,{19,'name2_id_code'}
      ,{20,'vesting_code'}
      ,{21,'addendum_flag'}
      ,{22,'phone_number'}
      ,{23,'mailing_care_of'}
      ,{24,'mailing_street'}
      ,{25,'mailing_unit_number'}
      ,{26,'mailing_csz'}
      ,{27,'mailing_address_cd'}
      ,{28,'seller1'}
      ,{29,'seller1_id_code'}
      ,{30,'seller2'}
      ,{31,'seller2_id_code'}
      ,{32,'seller_addendum_flag'}
      ,{33,'seller_mailing_full_street_address'}
      ,{34,'seller_mailing_address_unit_number'}
      ,{35,'seller_mailing_address_citystatezip'}
      ,{36,'property_full_street_address'}
      ,{37,'property_address_unit_number'}
      ,{38,'property_address_citystatezip'}
      ,{39,'property_address_code'}
      ,{40,'legal_lot_code'}
      ,{41,'legal_lot_number'}
      ,{42,'legal_block'}
      ,{43,'legal_section'}
      ,{44,'legal_district'}
      ,{45,'legal_land_lot'}
      ,{46,'legal_unit'}
      ,{47,'legal_city_municipality_township'}
      ,{48,'legal_subdivision_name'}
      ,{49,'legal_phase_number'}
      ,{50,'legal_tract_number'}
      ,{51,'legal_sec_twn_rng_mer'}
      ,{52,'legal_brief_description'}
      ,{53,'recorder_map_reference'}
      ,{54,'complete_legal_description_code'}
      ,{55,'contract_date'}
      ,{56,'recording_date'}
      ,{57,'arm_reset_date'}
      ,{58,'document_number'}
      ,{59,'document_type_code'}
      ,{60,'loan_number'}
      ,{61,'recorder_book_number'}
      ,{62,'recorder_page_number'}
      ,{63,'concurrent_mortgage_book_page_document_number'}
      ,{64,'sales_price'}
      ,{65,'sales_price_code'}
      ,{66,'city_transfer_tax'}
      ,{67,'county_transfer_tax'}
      ,{68,'total_transfer_tax'}
      ,{69,'first_td_loan_amount'}
      ,{70,'second_td_loan_amount'}
      ,{71,'first_td_lender_type_code'}
      ,{72,'second_td_lender_type_code'}
      ,{73,'first_td_loan_type_code'}
      ,{74,'type_financing'}
      ,{75,'first_td_interest_rate'}
      ,{76,'first_td_due_date'}
      ,{77,'title_company_name'}
      ,{78,'partial_interest_transferred'}
      ,{79,'loan_term_months'}
      ,{80,'loan_term_years'}
      ,{81,'lender_name'}
      ,{82,'lender_name_id'}
      ,{83,'lender_dba_aka_name'}
      ,{84,'lender_full_street_address'}
      ,{85,'lender_address_unit_number'}
      ,{86,'lender_address_citystatezip'}
      ,{87,'assessment_match_land_use_code'}
      ,{88,'property_use_code'}
      ,{89,'condo_code'}
      ,{90,'timeshare_flag'}
      ,{91,'land_lot_size'}
      ,{92,'hawaii_tct'}
      ,{93,'hawaii_condo_cpr_code'}
      ,{94,'hawaii_condo_name'}
      ,{95,'filler_except_hawaii'}
      ,{96,'rate_change_frequency'}
      ,{97,'change_index'}
      ,{98,'adjustable_rate_index'}
      ,{99,'adjustable_rate_rider'}
      ,{100,'graduated_payment_rider'}
      ,{101,'balloon_rider'}
      ,{102,'fixed_step_rate_rider'}
      ,{103,'condominium_rider'}
      ,{104,'planned_unit_development_rider'}
      ,{105,'rate_improvement_rider'}
      ,{106,'assumability_rider'}
      ,{107,'prepayment_rider'}
      ,{108,'one_four_family_rider'}
      ,{109,'biweekly_payment_rider'}
      ,{110,'second_home_rider'}
      ,{111,'data_source_code'}
      ,{112,'main_record_id_code'}
      ,{113,'addl_name_flag'}
      ,{114,'prop_addr_propagated_ind'}
      ,{115,'ln_ownership_rights'}
      ,{116,'ln_relationship_type'}
      ,{117,'ln_buyer_mailing_country_code'}
      ,{118,'ln_seller_mailing_country_code'}],SALT311.MAC_Character_Counts.Field_Identification);
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
    Fields.InValid_from_file((SALT311.StrType)le.from_file),
    Fields.InValid_fips_code((SALT311.StrType)le.fips_code),
    Fields.InValid_state((SALT311.StrType)le.state),
    Fields.InValid_county_name((SALT311.StrType)le.county_name),
    Fields.InValid_record_type((SALT311.StrType)le.record_type,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_apnt_or_pin_number((SALT311.StrType)le.apnt_or_pin_number),
    Fields.InValid_fares_unformatted_apn((SALT311.StrType)le.fares_unformatted_apn),
    Fields.InValid_multi_apn_flag((SALT311.StrType)le.multi_apn_flag),
    Fields.InValid_tax_id_number((SALT311.StrType)le.tax_id_number),
    Fields.InValid_excise_tax_number((SALT311.StrType)le.excise_tax_number),
    Fields.InValid_buyer_or_borrower_ind((SALT311.StrType)le.buyer_or_borrower_ind),
    Fields.InValid_name1((SALT311.StrType)le.name1),
    Fields.InValid_name1_id_code((SALT311.StrType)le.name1_id_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_name2((SALT311.StrType)le.name2),
    Fields.InValid_name2_id_code((SALT311.StrType)le.name2_id_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_vesting_code((SALT311.StrType)le.vesting_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_addendum_flag((SALT311.StrType)le.addendum_flag),
    Fields.InValid_phone_number((SALT311.StrType)le.phone_number),
    Fields.InValid_mailing_care_of((SALT311.StrType)le.mailing_care_of),
    Fields.InValid_mailing_street((SALT311.StrType)le.mailing_street),
    Fields.InValid_mailing_unit_number((SALT311.StrType)le.mailing_unit_number),
    Fields.InValid_mailing_csz((SALT311.StrType)le.mailing_csz),
    Fields.InValid_mailing_address_cd((SALT311.StrType)le.mailing_address_cd),
    Fields.InValid_seller1((SALT311.StrType)le.seller1),
    Fields.InValid_seller1_id_code((SALT311.StrType)le.seller1_id_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_seller2((SALT311.StrType)le.seller2),
    Fields.InValid_seller2_id_code((SALT311.StrType)le.seller2_id_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_seller_addendum_flag((SALT311.StrType)le.seller_addendum_flag),
    Fields.InValid_seller_mailing_full_street_address((SALT311.StrType)le.seller_mailing_full_street_address),
    Fields.InValid_seller_mailing_address_unit_number((SALT311.StrType)le.seller_mailing_address_unit_number),
    Fields.InValid_seller_mailing_address_citystatezip((SALT311.StrType)le.seller_mailing_address_citystatezip),
    Fields.InValid_property_full_street_address((SALT311.StrType)le.property_full_street_address),
    Fields.InValid_property_address_unit_number((SALT311.StrType)le.property_address_unit_number),
    Fields.InValid_property_address_citystatezip((SALT311.StrType)le.property_address_citystatezip),
    Fields.InValid_property_address_code((SALT311.StrType)le.property_address_code),
    Fields.InValid_legal_lot_code((SALT311.StrType)le.legal_lot_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_legal_lot_number((SALT311.StrType)le.legal_lot_number),
    Fields.InValid_legal_block((SALT311.StrType)le.legal_block),
    Fields.InValid_legal_section((SALT311.StrType)le.legal_section),
    Fields.InValid_legal_district((SALT311.StrType)le.legal_district),
    Fields.InValid_legal_land_lot((SALT311.StrType)le.legal_land_lot),
    Fields.InValid_legal_unit((SALT311.StrType)le.legal_unit),
    Fields.InValid_legal_city_municipality_township((SALT311.StrType)le.legal_city_municipality_township),
    Fields.InValid_legal_subdivision_name((SALT311.StrType)le.legal_subdivision_name),
    Fields.InValid_legal_phase_number((SALT311.StrType)le.legal_phase_number),
    Fields.InValid_legal_tract_number((SALT311.StrType)le.legal_tract_number),
    Fields.InValid_legal_sec_twn_rng_mer((SALT311.StrType)le.legal_sec_twn_rng_mer),
    Fields.InValid_legal_brief_description((SALT311.StrType)le.legal_brief_description),
    Fields.InValid_recorder_map_reference((SALT311.StrType)le.recorder_map_reference),
    Fields.InValid_complete_legal_description_code((SALT311.StrType)le.complete_legal_description_code),
    Fields.InValid_contract_date((SALT311.StrType)le.contract_date),
    Fields.InValid_recording_date((SALT311.StrType)le.recording_date),
    Fields.InValid_arm_reset_date((SALT311.StrType)le.arm_reset_date),
    Fields.InValid_document_number((SALT311.StrType)le.document_number),
    Fields.InValid_document_type_code((SALT311.StrType)le.document_type_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_loan_number((SALT311.StrType)le.loan_number),
    Fields.InValid_recorder_book_number((SALT311.StrType)le.recorder_book_number),
    Fields.InValid_recorder_page_number((SALT311.StrType)le.recorder_page_number),
    Fields.InValid_concurrent_mortgage_book_page_document_number((SALT311.StrType)le.concurrent_mortgage_book_page_document_number),
    Fields.InValid_sales_price((SALT311.StrType)le.sales_price),
    Fields.InValid_sales_price_code((SALT311.StrType)le.sales_price_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_city_transfer_tax((SALT311.StrType)le.city_transfer_tax),
    Fields.InValid_county_transfer_tax((SALT311.StrType)le.county_transfer_tax),
    Fields.InValid_total_transfer_tax((SALT311.StrType)le.total_transfer_tax),
    Fields.InValid_first_td_loan_amount((SALT311.StrType)le.first_td_loan_amount),
    Fields.InValid_second_td_loan_amount((SALT311.StrType)le.second_td_loan_amount),
    Fields.InValid_first_td_lender_type_code((SALT311.StrType)le.first_td_lender_type_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_second_td_lender_type_code((SALT311.StrType)le.second_td_lender_type_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_first_td_loan_type_code((SALT311.StrType)le.first_td_loan_type_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_type_financing((SALT311.StrType)le.type_financing,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_first_td_interest_rate((SALT311.StrType)le.first_td_interest_rate),
    Fields.InValid_first_td_due_date((SALT311.StrType)le.first_td_due_date),
    Fields.InValid_title_company_name((SALT311.StrType)le.title_company_name),
    Fields.InValid_partial_interest_transferred((SALT311.StrType)le.partial_interest_transferred),
    Fields.InValid_loan_term_months((SALT311.StrType)le.loan_term_months),
    Fields.InValid_loan_term_years((SALT311.StrType)le.loan_term_years),
    Fields.InValid_lender_name((SALT311.StrType)le.lender_name),
    Fields.InValid_lender_name_id((SALT311.StrType)le.lender_name_id),
    Fields.InValid_lender_dba_aka_name((SALT311.StrType)le.lender_dba_aka_name),
    Fields.InValid_lender_full_street_address((SALT311.StrType)le.lender_full_street_address),
    Fields.InValid_lender_address_unit_number((SALT311.StrType)le.lender_address_unit_number),
    Fields.InValid_lender_address_citystatezip((SALT311.StrType)le.lender_address_citystatezip),
    Fields.InValid_assessment_match_land_use_code((SALT311.StrType)le.assessment_match_land_use_code),
    Fields.InValid_property_use_code((SALT311.StrType)le.property_use_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_condo_code((SALT311.StrType)le.condo_code,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_timeshare_flag((SALT311.StrType)le.timeshare_flag),
    Fields.InValid_land_lot_size((SALT311.StrType)le.land_lot_size),
    Fields.InValid_hawaii_tct((SALT311.StrType)le.hawaii_tct),
    Fields.InValid_hawaii_condo_cpr_code((SALT311.StrType)le.hawaii_condo_cpr_code),
    Fields.InValid_hawaii_condo_name((SALT311.StrType)le.hawaii_condo_name),
    Fields.InValid_filler_except_hawaii((SALT311.StrType)le.filler_except_hawaii),
    Fields.InValid_rate_change_frequency((SALT311.StrType)le.rate_change_frequency,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_change_index((SALT311.StrType)le.change_index),
    Fields.InValid_adjustable_rate_index((SALT311.StrType)le.adjustable_rate_index,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_adjustable_rate_rider((SALT311.StrType)le.adjustable_rate_rider),
    Fields.InValid_graduated_payment_rider((SALT311.StrType)le.graduated_payment_rider),
    Fields.InValid_balloon_rider((SALT311.StrType)le.balloon_rider),
    Fields.InValid_fixed_step_rate_rider((SALT311.StrType)le.fixed_step_rate_rider,(SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_condominium_rider((SALT311.StrType)le.condominium_rider),
    Fields.InValid_planned_unit_development_rider((SALT311.StrType)le.planned_unit_development_rider),
    Fields.InValid_rate_improvement_rider((SALT311.StrType)le.rate_improvement_rider),
    Fields.InValid_assumability_rider((SALT311.StrType)le.assumability_rider),
    Fields.InValid_prepayment_rider((SALT311.StrType)le.prepayment_rider),
    Fields.InValid_one_four_family_rider((SALT311.StrType)le.one_four_family_rider),
    Fields.InValid_biweekly_payment_rider((SALT311.StrType)le.biweekly_payment_rider),
    Fields.InValid_second_home_rider((SALT311.StrType)le.second_home_rider),
    Fields.InValid_data_source_code((SALT311.StrType)le.data_source_code),
    Fields.InValid_main_record_id_code((SALT311.StrType)le.main_record_id_code),
    Fields.InValid_addl_name_flag((SALT311.StrType)le.addl_name_flag),
    Fields.InValid_prop_addr_propagated_ind((SALT311.StrType)le.prop_addr_propagated_ind),
    Fields.InValid_ln_ownership_rights((SALT311.StrType)le.ln_ownership_rights),
    Fields.InValid_ln_relationship_type((SALT311.StrType)le.ln_relationship_type),
    Fields.InValid_ln_buyer_mailing_country_code((SALT311.StrType)le.ln_buyer_mailing_country_code),
    Fields.InValid_ln_seller_mailing_country_code((SALT311.StrType)le.ln_seller_mailing_country_code),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.fips_code := le.fips_code;
END;
Errors := NORMALIZE(h,118,NoteErrors(LEFT,COUNTER));
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
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','invalid_date','invalid_vendor_source','Unknown','invalid_from_file','invalid_fips','invalid_state_code','invalid_county_name','invalid_record_type','invalid_apn','invalid_apn','Unknown','Unknown','Unknown','invalid_buyer_or_borrower_ind','invalid_alpha','invalid_name1_id_code','invalid_alpha','invalid_name1_id_code','invalid_vesting_code','Unknown','Unknown','invalid_alpha','invalid_address','invalid_address','invalid_zcs','invalid_address','invalid_alpha','invalid_seller1_id_code','invalid_alpha','invalid_seller2_id_code','Unknown','invalid_address','Unknown','Unknown','invalid_address','Unknown','invalid_address','Unknown','invalid_legal_lot_code','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_char','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','invalid_date','invalid_date_future','Unknown','invalid_document_type_code','Unknown','Unknown','Unknown','Unknown','invalid_amount','invalid_sales_price_code','Unknown','Unknown','Unknown','invalid_amount','invalid_amount','invalid_lender_type_code','invalid_lender_type_code','invalid_loan_type_code','invalid_type_financing','Unknown','invalid_date_future','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_address','Unknown','invalid_address','Unknown','invalid_property_use_code','invalid_condo_code','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_rate_change_frequency','Unknown','invalid_adjustable_rate_index','Unknown','Unknown','Unknown','invalid_fixed_step_rate_ride','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_ln_fares_id(TotalErrors.ErrorNum),Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_vendor_source_flag(TotalErrors.ErrorNum),Fields.InValidMessage_current_record(TotalErrors.ErrorNum),Fields.InValidMessage_from_file(TotalErrors.ErrorNum),Fields.InValidMessage_fips_code(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_county_name(TotalErrors.ErrorNum),Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Fields.InValidMessage_apnt_or_pin_number(TotalErrors.ErrorNum),Fields.InValidMessage_fares_unformatted_apn(TotalErrors.ErrorNum),Fields.InValidMessage_multi_apn_flag(TotalErrors.ErrorNum),Fields.InValidMessage_tax_id_number(TotalErrors.ErrorNum),Fields.InValidMessage_excise_tax_number(TotalErrors.ErrorNum),Fields.InValidMessage_buyer_or_borrower_ind(TotalErrors.ErrorNum),Fields.InValidMessage_name1(TotalErrors.ErrorNum),Fields.InValidMessage_name1_id_code(TotalErrors.ErrorNum),Fields.InValidMessage_name2(TotalErrors.ErrorNum),Fields.InValidMessage_name2_id_code(TotalErrors.ErrorNum),Fields.InValidMessage_vesting_code(TotalErrors.ErrorNum),Fields.InValidMessage_addendum_flag(TotalErrors.ErrorNum),Fields.InValidMessage_phone_number(TotalErrors.ErrorNum),Fields.InValidMessage_mailing_care_of(TotalErrors.ErrorNum),Fields.InValidMessage_mailing_street(TotalErrors.ErrorNum),Fields.InValidMessage_mailing_unit_number(TotalErrors.ErrorNum),Fields.InValidMessage_mailing_csz(TotalErrors.ErrorNum),Fields.InValidMessage_mailing_address_cd(TotalErrors.ErrorNum),Fields.InValidMessage_seller1(TotalErrors.ErrorNum),Fields.InValidMessage_seller1_id_code(TotalErrors.ErrorNum),Fields.InValidMessage_seller2(TotalErrors.ErrorNum),Fields.InValidMessage_seller2_id_code(TotalErrors.ErrorNum),Fields.InValidMessage_seller_addendum_flag(TotalErrors.ErrorNum),Fields.InValidMessage_seller_mailing_full_street_address(TotalErrors.ErrorNum),Fields.InValidMessage_seller_mailing_address_unit_number(TotalErrors.ErrorNum),Fields.InValidMessage_seller_mailing_address_citystatezip(TotalErrors.ErrorNum),Fields.InValidMessage_property_full_street_address(TotalErrors.ErrorNum),Fields.InValidMessage_property_address_unit_number(TotalErrors.ErrorNum),Fields.InValidMessage_property_address_citystatezip(TotalErrors.ErrorNum),Fields.InValidMessage_property_address_code(TotalErrors.ErrorNum),Fields.InValidMessage_legal_lot_code(TotalErrors.ErrorNum),Fields.InValidMessage_legal_lot_number(TotalErrors.ErrorNum),Fields.InValidMessage_legal_block(TotalErrors.ErrorNum),Fields.InValidMessage_legal_section(TotalErrors.ErrorNum),Fields.InValidMessage_legal_district(TotalErrors.ErrorNum),Fields.InValidMessage_legal_land_lot(TotalErrors.ErrorNum),Fields.InValidMessage_legal_unit(TotalErrors.ErrorNum),Fields.InValidMessage_legal_city_municipality_township(TotalErrors.ErrorNum),Fields.InValidMessage_legal_subdivision_name(TotalErrors.ErrorNum),Fields.InValidMessage_legal_phase_number(TotalErrors.ErrorNum),Fields.InValidMessage_legal_tract_number(TotalErrors.ErrorNum),Fields.InValidMessage_legal_sec_twn_rng_mer(TotalErrors.ErrorNum),Fields.InValidMessage_legal_brief_description(TotalErrors.ErrorNum),Fields.InValidMessage_recorder_map_reference(TotalErrors.ErrorNum),Fields.InValidMessage_complete_legal_description_code(TotalErrors.ErrorNum),Fields.InValidMessage_contract_date(TotalErrors.ErrorNum),Fields.InValidMessage_recording_date(TotalErrors.ErrorNum),Fields.InValidMessage_arm_reset_date(TotalErrors.ErrorNum),Fields.InValidMessage_document_number(TotalErrors.ErrorNum),Fields.InValidMessage_document_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_loan_number(TotalErrors.ErrorNum),Fields.InValidMessage_recorder_book_number(TotalErrors.ErrorNum),Fields.InValidMessage_recorder_page_number(TotalErrors.ErrorNum),Fields.InValidMessage_concurrent_mortgage_book_page_document_number(TotalErrors.ErrorNum),Fields.InValidMessage_sales_price(TotalErrors.ErrorNum),Fields.InValidMessage_sales_price_code(TotalErrors.ErrorNum),Fields.InValidMessage_city_transfer_tax(TotalErrors.ErrorNum),Fields.InValidMessage_county_transfer_tax(TotalErrors.ErrorNum),Fields.InValidMessage_total_transfer_tax(TotalErrors.ErrorNum),Fields.InValidMessage_first_td_loan_amount(TotalErrors.ErrorNum),Fields.InValidMessage_second_td_loan_amount(TotalErrors.ErrorNum),Fields.InValidMessage_first_td_lender_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_second_td_lender_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_first_td_loan_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_type_financing(TotalErrors.ErrorNum),Fields.InValidMessage_first_td_interest_rate(TotalErrors.ErrorNum),Fields.InValidMessage_first_td_due_date(TotalErrors.ErrorNum),Fields.InValidMessage_title_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_partial_interest_transferred(TotalErrors.ErrorNum),Fields.InValidMessage_loan_term_months(TotalErrors.ErrorNum),Fields.InValidMessage_loan_term_years(TotalErrors.ErrorNum),Fields.InValidMessage_lender_name(TotalErrors.ErrorNum),Fields.InValidMessage_lender_name_id(TotalErrors.ErrorNum),Fields.InValidMessage_lender_dba_aka_name(TotalErrors.ErrorNum),Fields.InValidMessage_lender_full_street_address(TotalErrors.ErrorNum),Fields.InValidMessage_lender_address_unit_number(TotalErrors.ErrorNum),Fields.InValidMessage_lender_address_citystatezip(TotalErrors.ErrorNum),Fields.InValidMessage_assessment_match_land_use_code(TotalErrors.ErrorNum),Fields.InValidMessage_property_use_code(TotalErrors.ErrorNum),Fields.InValidMessage_condo_code(TotalErrors.ErrorNum),Fields.InValidMessage_timeshare_flag(TotalErrors.ErrorNum),Fields.InValidMessage_land_lot_size(TotalErrors.ErrorNum),Fields.InValidMessage_hawaii_tct(TotalErrors.ErrorNum),Fields.InValidMessage_hawaii_condo_cpr_code(TotalErrors.ErrorNum),Fields.InValidMessage_hawaii_condo_name(TotalErrors.ErrorNum),Fields.InValidMessage_filler_except_hawaii(TotalErrors.ErrorNum),Fields.InValidMessage_rate_change_frequency(TotalErrors.ErrorNum),Fields.InValidMessage_change_index(TotalErrors.ErrorNum),Fields.InValidMessage_adjustable_rate_index(TotalErrors.ErrorNum),Fields.InValidMessage_adjustable_rate_rider(TotalErrors.ErrorNum),Fields.InValidMessage_graduated_payment_rider(TotalErrors.ErrorNum),Fields.InValidMessage_balloon_rider(TotalErrors.ErrorNum),Fields.InValidMessage_fixed_step_rate_rider(TotalErrors.ErrorNum),Fields.InValidMessage_condominium_rider(TotalErrors.ErrorNum),Fields.InValidMessage_planned_unit_development_rider(TotalErrors.ErrorNum),Fields.InValidMessage_rate_improvement_rider(TotalErrors.ErrorNum),Fields.InValidMessage_assumability_rider(TotalErrors.ErrorNum),Fields.InValidMessage_prepayment_rider(TotalErrors.ErrorNum),Fields.InValidMessage_one_four_family_rider(TotalErrors.ErrorNum),Fields.InValidMessage_biweekly_payment_rider(TotalErrors.ErrorNum),Fields.InValidMessage_second_home_rider(TotalErrors.ErrorNum),Fields.InValidMessage_data_source_code(TotalErrors.ErrorNum),Fields.InValidMessage_main_record_id_code(TotalErrors.ErrorNum),Fields.InValidMessage_addl_name_flag(TotalErrors.ErrorNum),Fields.InValidMessage_prop_addr_propagated_ind(TotalErrors.ErrorNum),Fields.InValidMessage_ln_ownership_rights(TotalErrors.ErrorNum),Fields.InValidMessage_ln_relationship_type(TotalErrors.ErrorNum),Fields.InValidMessage_ln_buyer_mailing_country_code(TotalErrors.ErrorNum),Fields.InValidMessage_ln_seller_mailing_country_code(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.fips_code=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doSummaryPerSrc = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  fieldPopulationPerSource := Summary('', FALSE);
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_LN_PropertyV2_Deed, Fields, 'RECORDOF(fieldPopulationOverall)', TRUE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationPerSource_Standard := IF(doSummaryPerSrc, NORMALIZE(fieldPopulationPerSource, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'src', 'src')));
 
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', TRUE, 'all'));
  fieldPopulationPerSource_TotalRecs_Standard := IF(doSummaryPerSrc, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationPerSource, myTimeStamp, 'src', TRUE, 'src'));
 
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & fieldPopulationPerSource_Standard & fieldPopulationPerSource_TotalRecs_Standard & allProfiles_Standard;
END;
END;
