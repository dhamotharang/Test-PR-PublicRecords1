IMPORT SALT311,STD;
EXPORT Input_hygiene(dataset(Input_layout_FCC) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_license_type_cnt := COUNT(GROUP,h.license_type <> (TYPEOF(h.license_type))'');
    populated_license_type_pcnt := AVE(GROUP,IF(h.license_type = (TYPEOF(h.license_type))'',0,100));
    maxlength_license_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.license_type)));
    avelength_license_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.license_type)),h.license_type<>(typeof(h.license_type))'');
    populated_file_number_cnt := COUNT(GROUP,h.file_number <> (TYPEOF(h.file_number))'');
    populated_file_number_pcnt := AVE(GROUP,IF(h.file_number = (TYPEOF(h.file_number))'',0,100));
    maxlength_file_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_number)));
    avelength_file_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_number)),h.file_number<>(typeof(h.file_number))'');
    populated_callsign_of_license_cnt := COUNT(GROUP,h.callsign_of_license <> (TYPEOF(h.callsign_of_license))'');
    populated_callsign_of_license_pcnt := AVE(GROUP,IF(h.callsign_of_license = (TYPEOF(h.callsign_of_license))'',0,100));
    maxlength_callsign_of_license := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.callsign_of_license)));
    avelength_callsign_of_license := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.callsign_of_license)),h.callsign_of_license<>(typeof(h.callsign_of_license))'');
    populated_radio_service_code_cnt := COUNT(GROUP,h.radio_service_code <> (TYPEOF(h.radio_service_code))'');
    populated_radio_service_code_pcnt := AVE(GROUP,IF(h.radio_service_code = (TYPEOF(h.radio_service_code))'',0,100));
    maxlength_radio_service_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.radio_service_code)));
    avelength_radio_service_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.radio_service_code)),h.radio_service_code<>(typeof(h.radio_service_code))'');
    populated_licensees_name_cnt := COUNT(GROUP,h.licensees_name <> (TYPEOF(h.licensees_name))'');
    populated_licensees_name_pcnt := AVE(GROUP,IF(h.licensees_name = (TYPEOF(h.licensees_name))'',0,100));
    maxlength_licensees_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensees_name)));
    avelength_licensees_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensees_name)),h.licensees_name<>(typeof(h.licensees_name))'');
    populated_licensees_attention_line_cnt := COUNT(GROUP,h.licensees_attention_line <> (TYPEOF(h.licensees_attention_line))'');
    populated_licensees_attention_line_pcnt := AVE(GROUP,IF(h.licensees_attention_line = (TYPEOF(h.licensees_attention_line))'',0,100));
    maxlength_licensees_attention_line := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensees_attention_line)));
    avelength_licensees_attention_line := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensees_attention_line)),h.licensees_attention_line<>(typeof(h.licensees_attention_line))'');
    populated_dba_name_cnt := COUNT(GROUP,h.dba_name <> (TYPEOF(h.dba_name))'');
    populated_dba_name_pcnt := AVE(GROUP,IF(h.dba_name = (TYPEOF(h.dba_name))'',0,100));
    maxlength_dba_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dba_name)));
    avelength_dba_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dba_name)),h.dba_name<>(typeof(h.dba_name))'');
    populated_licensees_street_cnt := COUNT(GROUP,h.licensees_street <> (TYPEOF(h.licensees_street))'');
    populated_licensees_street_pcnt := AVE(GROUP,IF(h.licensees_street = (TYPEOF(h.licensees_street))'',0,100));
    maxlength_licensees_street := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensees_street)));
    avelength_licensees_street := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensees_street)),h.licensees_street<>(typeof(h.licensees_street))'');
    populated_licensees_city_cnt := COUNT(GROUP,h.licensees_city <> (TYPEOF(h.licensees_city))'');
    populated_licensees_city_pcnt := AVE(GROUP,IF(h.licensees_city = (TYPEOF(h.licensees_city))'',0,100));
    maxlength_licensees_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensees_city)));
    avelength_licensees_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensees_city)),h.licensees_city<>(typeof(h.licensees_city))'');
    populated_licensees_state_cnt := COUNT(GROUP,h.licensees_state <> (TYPEOF(h.licensees_state))'');
    populated_licensees_state_pcnt := AVE(GROUP,IF(h.licensees_state = (TYPEOF(h.licensees_state))'',0,100));
    maxlength_licensees_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensees_state)));
    avelength_licensees_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensees_state)),h.licensees_state<>(typeof(h.licensees_state))'');
    populated_licensees_zip_cnt := COUNT(GROUP,h.licensees_zip <> (TYPEOF(h.licensees_zip))'');
    populated_licensees_zip_pcnt := AVE(GROUP,IF(h.licensees_zip = (TYPEOF(h.licensees_zip))'',0,100));
    maxlength_licensees_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensees_zip)));
    avelength_licensees_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensees_zip)),h.licensees_zip<>(typeof(h.licensees_zip))'');
    populated_licensees_phone_cnt := COUNT(GROUP,h.licensees_phone <> (TYPEOF(h.licensees_phone))'');
    populated_licensees_phone_pcnt := AVE(GROUP,IF(h.licensees_phone = (TYPEOF(h.licensees_phone))'',0,100));
    maxlength_licensees_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensees_phone)));
    avelength_licensees_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.licensees_phone)),h.licensees_phone<>(typeof(h.licensees_phone))'');
    populated_date_application_received_at_fcc_cnt := COUNT(GROUP,h.date_application_received_at_fcc <> (TYPEOF(h.date_application_received_at_fcc))'');
    populated_date_application_received_at_fcc_pcnt := AVE(GROUP,IF(h.date_application_received_at_fcc = (TYPEOF(h.date_application_received_at_fcc))'',0,100));
    maxlength_date_application_received_at_fcc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_application_received_at_fcc)));
    avelength_date_application_received_at_fcc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_application_received_at_fcc)),h.date_application_received_at_fcc<>(typeof(h.date_application_received_at_fcc))'');
    populated_date_license_issued_cnt := COUNT(GROUP,h.date_license_issued <> (TYPEOF(h.date_license_issued))'');
    populated_date_license_issued_pcnt := AVE(GROUP,IF(h.date_license_issued = (TYPEOF(h.date_license_issued))'',0,100));
    maxlength_date_license_issued := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_license_issued)));
    avelength_date_license_issued := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_license_issued)),h.date_license_issued<>(typeof(h.date_license_issued))'');
    populated_date_license_expires_cnt := COUNT(GROUP,h.date_license_expires <> (TYPEOF(h.date_license_expires))'');
    populated_date_license_expires_pcnt := AVE(GROUP,IF(h.date_license_expires = (TYPEOF(h.date_license_expires))'',0,100));
    maxlength_date_license_expires := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_license_expires)));
    avelength_date_license_expires := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_license_expires)),h.date_license_expires<>(typeof(h.date_license_expires))'');
    populated_date_of_last_change_cnt := COUNT(GROUP,h.date_of_last_change <> (TYPEOF(h.date_of_last_change))'');
    populated_date_of_last_change_pcnt := AVE(GROUP,IF(h.date_of_last_change = (TYPEOF(h.date_of_last_change))'',0,100));
    maxlength_date_of_last_change := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_of_last_change)));
    avelength_date_of_last_change := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_of_last_change)),h.date_of_last_change<>(typeof(h.date_of_last_change))'');
    populated_type_of_last_change_cnt := COUNT(GROUP,h.type_of_last_change <> (TYPEOF(h.type_of_last_change))'');
    populated_type_of_last_change_pcnt := AVE(GROUP,IF(h.type_of_last_change = (TYPEOF(h.type_of_last_change))'',0,100));
    maxlength_type_of_last_change := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.type_of_last_change)));
    avelength_type_of_last_change := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.type_of_last_change)),h.type_of_last_change<>(typeof(h.type_of_last_change))'');
    populated_latitude_cnt := COUNT(GROUP,h.latitude <> (TYPEOF(h.latitude))'');
    populated_latitude_pcnt := AVE(GROUP,IF(h.latitude = (TYPEOF(h.latitude))'',0,100));
    maxlength_latitude := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.latitude)));
    avelength_latitude := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.latitude)),h.latitude<>(typeof(h.latitude))'');
    populated_longitude_cnt := COUNT(GROUP,h.longitude <> (TYPEOF(h.longitude))'');
    populated_longitude_pcnt := AVE(GROUP,IF(h.longitude = (TYPEOF(h.longitude))'',0,100));
    maxlength_longitude := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.longitude)));
    avelength_longitude := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.longitude)),h.longitude<>(typeof(h.longitude))'');
    populated_transmitters_street_cnt := COUNT(GROUP,h.transmitters_street <> (TYPEOF(h.transmitters_street))'');
    populated_transmitters_street_pcnt := AVE(GROUP,IF(h.transmitters_street = (TYPEOF(h.transmitters_street))'',0,100));
    maxlength_transmitters_street := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmitters_street)));
    avelength_transmitters_street := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmitters_street)),h.transmitters_street<>(typeof(h.transmitters_street))'');
    populated_transmitters_city_cnt := COUNT(GROUP,h.transmitters_city <> (TYPEOF(h.transmitters_city))'');
    populated_transmitters_city_pcnt := AVE(GROUP,IF(h.transmitters_city = (TYPEOF(h.transmitters_city))'',0,100));
    maxlength_transmitters_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmitters_city)));
    avelength_transmitters_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmitters_city)),h.transmitters_city<>(typeof(h.transmitters_city))'');
    populated_transmitters_county_cnt := COUNT(GROUP,h.transmitters_county <> (TYPEOF(h.transmitters_county))'');
    populated_transmitters_county_pcnt := AVE(GROUP,IF(h.transmitters_county = (TYPEOF(h.transmitters_county))'',0,100));
    maxlength_transmitters_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmitters_county)));
    avelength_transmitters_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmitters_county)),h.transmitters_county<>(typeof(h.transmitters_county))'');
    populated_transmitters_state_cnt := COUNT(GROUP,h.transmitters_state <> (TYPEOF(h.transmitters_state))'');
    populated_transmitters_state_pcnt := AVE(GROUP,IF(h.transmitters_state = (TYPEOF(h.transmitters_state))'',0,100));
    maxlength_transmitters_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmitters_state)));
    avelength_transmitters_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmitters_state)),h.transmitters_state<>(typeof(h.transmitters_state))'');
    populated_transmitters_antenna_height_cnt := COUNT(GROUP,h.transmitters_antenna_height <> (TYPEOF(h.transmitters_antenna_height))'');
    populated_transmitters_antenna_height_pcnt := AVE(GROUP,IF(h.transmitters_antenna_height = (TYPEOF(h.transmitters_antenna_height))'',0,100));
    maxlength_transmitters_antenna_height := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmitters_antenna_height)));
    avelength_transmitters_antenna_height := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmitters_antenna_height)),h.transmitters_antenna_height<>(typeof(h.transmitters_antenna_height))'');
    populated_transmitters_height_above_avg_terra_cnt := COUNT(GROUP,h.transmitters_height_above_avg_terra <> (TYPEOF(h.transmitters_height_above_avg_terra))'');
    populated_transmitters_height_above_avg_terra_pcnt := AVE(GROUP,IF(h.transmitters_height_above_avg_terra = (TYPEOF(h.transmitters_height_above_avg_terra))'',0,100));
    maxlength_transmitters_height_above_avg_terra := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmitters_height_above_avg_terra)));
    avelength_transmitters_height_above_avg_terra := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmitters_height_above_avg_terra)),h.transmitters_height_above_avg_terra<>(typeof(h.transmitters_height_above_avg_terra))'');
    populated_transmitters_height_above_ground_le_cnt := COUNT(GROUP,h.transmitters_height_above_ground_le <> (TYPEOF(h.transmitters_height_above_ground_le))'');
    populated_transmitters_height_above_ground_le_pcnt := AVE(GROUP,IF(h.transmitters_height_above_ground_le = (TYPEOF(h.transmitters_height_above_ground_le))'',0,100));
    maxlength_transmitters_height_above_ground_le := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmitters_height_above_ground_le)));
    avelength_transmitters_height_above_ground_le := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmitters_height_above_ground_le)),h.transmitters_height_above_ground_le<>(typeof(h.transmitters_height_above_ground_le))'');
    populated_power_of_this_frequency_cnt := COUNT(GROUP,h.power_of_this_frequency <> (TYPEOF(h.power_of_this_frequency))'');
    populated_power_of_this_frequency_pcnt := AVE(GROUP,IF(h.power_of_this_frequency = (TYPEOF(h.power_of_this_frequency))'',0,100));
    maxlength_power_of_this_frequency := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.power_of_this_frequency)));
    avelength_power_of_this_frequency := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.power_of_this_frequency)),h.power_of_this_frequency<>(typeof(h.power_of_this_frequency))'');
    populated_frequency_mhz_cnt := COUNT(GROUP,h.frequency_mhz <> (TYPEOF(h.frequency_mhz))'');
    populated_frequency_mhz_pcnt := AVE(GROUP,IF(h.frequency_mhz = (TYPEOF(h.frequency_mhz))'',0,100));
    maxlength_frequency_mhz := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.frequency_mhz)));
    avelength_frequency_mhz := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.frequency_mhz)),h.frequency_mhz<>(typeof(h.frequency_mhz))'');
    populated_class_of_station_cnt := COUNT(GROUP,h.class_of_station <> (TYPEOF(h.class_of_station))'');
    populated_class_of_station_pcnt := AVE(GROUP,IF(h.class_of_station = (TYPEOF(h.class_of_station))'',0,100));
    maxlength_class_of_station := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.class_of_station)));
    avelength_class_of_station := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.class_of_station)),h.class_of_station<>(typeof(h.class_of_station))'');
    populated_number_of_units_authorized_on_freq_cnt := COUNT(GROUP,h.number_of_units_authorized_on_freq <> (TYPEOF(h.number_of_units_authorized_on_freq))'');
    populated_number_of_units_authorized_on_freq_pcnt := AVE(GROUP,IF(h.number_of_units_authorized_on_freq = (TYPEOF(h.number_of_units_authorized_on_freq))'',0,100));
    maxlength_number_of_units_authorized_on_freq := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.number_of_units_authorized_on_freq)));
    avelength_number_of_units_authorized_on_freq := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.number_of_units_authorized_on_freq)),h.number_of_units_authorized_on_freq<>(typeof(h.number_of_units_authorized_on_freq))'');
    populated_effective_radiated_power_cnt := COUNT(GROUP,h.effective_radiated_power <> (TYPEOF(h.effective_radiated_power))'');
    populated_effective_radiated_power_pcnt := AVE(GROUP,IF(h.effective_radiated_power = (TYPEOF(h.effective_radiated_power))'',0,100));
    maxlength_effective_radiated_power := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.effective_radiated_power)));
    avelength_effective_radiated_power := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.effective_radiated_power)),h.effective_radiated_power<>(typeof(h.effective_radiated_power))'');
    populated_emissions_codes_cnt := COUNT(GROUP,h.emissions_codes <> (TYPEOF(h.emissions_codes))'');
    populated_emissions_codes_pcnt := AVE(GROUP,IF(h.emissions_codes = (TYPEOF(h.emissions_codes))'',0,100));
    maxlength_emissions_codes := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.emissions_codes)));
    avelength_emissions_codes := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.emissions_codes)),h.emissions_codes<>(typeof(h.emissions_codes))'');
    populated_frequency_coordination_number_cnt := COUNT(GROUP,h.frequency_coordination_number <> (TYPEOF(h.frequency_coordination_number))'');
    populated_frequency_coordination_number_pcnt := AVE(GROUP,IF(h.frequency_coordination_number = (TYPEOF(h.frequency_coordination_number))'',0,100));
    maxlength_frequency_coordination_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.frequency_coordination_number)));
    avelength_frequency_coordination_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.frequency_coordination_number)),h.frequency_coordination_number<>(typeof(h.frequency_coordination_number))'');
    populated_paging_license_status_cnt := COUNT(GROUP,h.paging_license_status <> (TYPEOF(h.paging_license_status))'');
    populated_paging_license_status_pcnt := AVE(GROUP,IF(h.paging_license_status = (TYPEOF(h.paging_license_status))'',0,100));
    maxlength_paging_license_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.paging_license_status)));
    avelength_paging_license_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.paging_license_status)),h.paging_license_status<>(typeof(h.paging_license_status))'');
    populated_control_point_for_the_system_cnt := COUNT(GROUP,h.control_point_for_the_system <> (TYPEOF(h.control_point_for_the_system))'');
    populated_control_point_for_the_system_pcnt := AVE(GROUP,IF(h.control_point_for_the_system = (TYPEOF(h.control_point_for_the_system))'',0,100));
    maxlength_control_point_for_the_system := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.control_point_for_the_system)));
    avelength_control_point_for_the_system := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.control_point_for_the_system)),h.control_point_for_the_system<>(typeof(h.control_point_for_the_system))'');
    populated_pending_or_granted_cnt := COUNT(GROUP,h.pending_or_granted <> (TYPEOF(h.pending_or_granted))'');
    populated_pending_or_granted_pcnt := AVE(GROUP,IF(h.pending_or_granted = (TYPEOF(h.pending_or_granted))'',0,100));
    maxlength_pending_or_granted := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pending_or_granted)));
    avelength_pending_or_granted := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pending_or_granted)),h.pending_or_granted<>(typeof(h.pending_or_granted))'');
    populated_firm_preparing_application_cnt := COUNT(GROUP,h.firm_preparing_application <> (TYPEOF(h.firm_preparing_application))'');
    populated_firm_preparing_application_pcnt := AVE(GROUP,IF(h.firm_preparing_application = (TYPEOF(h.firm_preparing_application))'',0,100));
    maxlength_firm_preparing_application := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.firm_preparing_application)));
    avelength_firm_preparing_application := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.firm_preparing_application)),h.firm_preparing_application<>(typeof(h.firm_preparing_application))'');
    populated_contact_firms_street_address_cnt := COUNT(GROUP,h.contact_firms_street_address <> (TYPEOF(h.contact_firms_street_address))'');
    populated_contact_firms_street_address_pcnt := AVE(GROUP,IF(h.contact_firms_street_address = (TYPEOF(h.contact_firms_street_address))'',0,100));
    maxlength_contact_firms_street_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_firms_street_address)));
    avelength_contact_firms_street_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_firms_street_address)),h.contact_firms_street_address<>(typeof(h.contact_firms_street_address))'');
    populated_contact_firms_city_cnt := COUNT(GROUP,h.contact_firms_city <> (TYPEOF(h.contact_firms_city))'');
    populated_contact_firms_city_pcnt := AVE(GROUP,IF(h.contact_firms_city = (TYPEOF(h.contact_firms_city))'',0,100));
    maxlength_contact_firms_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_firms_city)));
    avelength_contact_firms_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_firms_city)),h.contact_firms_city<>(typeof(h.contact_firms_city))'');
    populated_contact_firms_state_cnt := COUNT(GROUP,h.contact_firms_state <> (TYPEOF(h.contact_firms_state))'');
    populated_contact_firms_state_pcnt := AVE(GROUP,IF(h.contact_firms_state = (TYPEOF(h.contact_firms_state))'',0,100));
    maxlength_contact_firms_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_firms_state)));
    avelength_contact_firms_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_firms_state)),h.contact_firms_state<>(typeof(h.contact_firms_state))'');
    populated_contact_firms_zipcode_cnt := COUNT(GROUP,h.contact_firms_zipcode <> (TYPEOF(h.contact_firms_zipcode))'');
    populated_contact_firms_zipcode_pcnt := AVE(GROUP,IF(h.contact_firms_zipcode = (TYPEOF(h.contact_firms_zipcode))'',0,100));
    maxlength_contact_firms_zipcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_firms_zipcode)));
    avelength_contact_firms_zipcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_firms_zipcode)),h.contact_firms_zipcode<>(typeof(h.contact_firms_zipcode))'');
    populated_contact_firms_phone_number_cnt := COUNT(GROUP,h.contact_firms_phone_number <> (TYPEOF(h.contact_firms_phone_number))'');
    populated_contact_firms_phone_number_pcnt := AVE(GROUP,IF(h.contact_firms_phone_number = (TYPEOF(h.contact_firms_phone_number))'',0,100));
    maxlength_contact_firms_phone_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_firms_phone_number)));
    avelength_contact_firms_phone_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_firms_phone_number)),h.contact_firms_phone_number<>(typeof(h.contact_firms_phone_number))'');
    populated_contact_firms_fax_number_cnt := COUNT(GROUP,h.contact_firms_fax_number <> (TYPEOF(h.contact_firms_fax_number))'');
    populated_contact_firms_fax_number_pcnt := AVE(GROUP,IF(h.contact_firms_fax_number = (TYPEOF(h.contact_firms_fax_number))'',0,100));
    maxlength_contact_firms_fax_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_firms_fax_number)));
    avelength_contact_firms_fax_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_firms_fax_number)),h.contact_firms_fax_number<>(typeof(h.contact_firms_fax_number))'');
    populated_unique_key_cnt := COUNT(GROUP,h.unique_key <> (TYPEOF(h.unique_key))'');
    populated_unique_key_pcnt := AVE(GROUP,IF(h.unique_key = (TYPEOF(h.unique_key))'',0,100));
    maxlength_unique_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unique_key)));
    avelength_unique_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unique_key)),h.unique_key<>(typeof(h.unique_key))'');
    populated_crlf_cnt := COUNT(GROUP,h.crlf <> (TYPEOF(h.crlf))'');
    populated_crlf_pcnt := AVE(GROUP,IF(h.crlf = (TYPEOF(h.crlf))'',0,100));
    maxlength_crlf := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.crlf)));
    avelength_crlf := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.crlf)),h.crlf<>(typeof(h.crlf))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_license_type_pcnt *   0.00 / 100 + T.Populated_file_number_pcnt *   0.00 / 100 + T.Populated_callsign_of_license_pcnt *   0.00 / 100 + T.Populated_radio_service_code_pcnt *   0.00 / 100 + T.Populated_licensees_name_pcnt *   0.00 / 100 + T.Populated_licensees_attention_line_pcnt *   0.00 / 100 + T.Populated_dba_name_pcnt *   0.00 / 100 + T.Populated_licensees_street_pcnt *   0.00 / 100 + T.Populated_licensees_city_pcnt *   0.00 / 100 + T.Populated_licensees_state_pcnt *   0.00 / 100 + T.Populated_licensees_zip_pcnt *   0.00 / 100 + T.Populated_licensees_phone_pcnt *   0.00 / 100 + T.Populated_date_application_received_at_fcc_pcnt *   0.00 / 100 + T.Populated_date_license_issued_pcnt *   0.00 / 100 + T.Populated_date_license_expires_pcnt *   0.00 / 100 + T.Populated_date_of_last_change_pcnt *   0.00 / 100 + T.Populated_type_of_last_change_pcnt *   0.00 / 100 + T.Populated_latitude_pcnt *   0.00 / 100 + T.Populated_longitude_pcnt *   0.00 / 100 + T.Populated_transmitters_street_pcnt *   0.00 / 100 + T.Populated_transmitters_city_pcnt *   0.00 / 100 + T.Populated_transmitters_county_pcnt *   0.00 / 100 + T.Populated_transmitters_state_pcnt *   0.00 / 100 + T.Populated_transmitters_antenna_height_pcnt *   0.00 / 100 + T.Populated_transmitters_height_above_avg_terra_pcnt *   0.00 / 100 + T.Populated_transmitters_height_above_ground_le_pcnt *   0.00 / 100 + T.Populated_power_of_this_frequency_pcnt *   0.00 / 100 + T.Populated_frequency_mhz_pcnt *   0.00 / 100 + T.Populated_class_of_station_pcnt *   0.00 / 100 + T.Populated_number_of_units_authorized_on_freq_pcnt *   0.00 / 100 + T.Populated_effective_radiated_power_pcnt *   0.00 / 100 + T.Populated_emissions_codes_pcnt *   0.00 / 100 + T.Populated_frequency_coordination_number_pcnt *   0.00 / 100 + T.Populated_paging_license_status_pcnt *   0.00 / 100 + T.Populated_control_point_for_the_system_pcnt *   0.00 / 100 + T.Populated_pending_or_granted_pcnt *   0.00 / 100 + T.Populated_firm_preparing_application_pcnt *   0.00 / 100 + T.Populated_contact_firms_street_address_pcnt *   0.00 / 100 + T.Populated_contact_firms_city_pcnt *   0.00 / 100 + T.Populated_contact_firms_state_pcnt *   0.00 / 100 + T.Populated_contact_firms_zipcode_pcnt *   0.00 / 100 + T.Populated_contact_firms_phone_number_pcnt *   0.00 / 100 + T.Populated_contact_firms_fax_number_pcnt *   0.00 / 100 + T.Populated_unique_key_pcnt *   0.00 / 100 + T.Populated_crlf_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'license_type','file_number','callsign_of_license','radio_service_code','licensees_name','licensees_attention_line','dba_name','licensees_street','licensees_city','licensees_state','licensees_zip','licensees_phone','date_application_received_at_fcc','date_license_issued','date_license_expires','date_of_last_change','type_of_last_change','latitude','longitude','transmitters_street','transmitters_city','transmitters_county','transmitters_state','transmitters_antenna_height','transmitters_height_above_avg_terra','transmitters_height_above_ground_le','power_of_this_frequency','frequency_mhz','class_of_station','number_of_units_authorized_on_freq','effective_radiated_power','emissions_codes','frequency_coordination_number','paging_license_status','control_point_for_the_system','pending_or_granted','firm_preparing_application','contact_firms_street_address','contact_firms_city','contact_firms_state','contact_firms_zipcode','contact_firms_phone_number','contact_firms_fax_number','unique_key','crlf');
  SELF.populated_pcnt := CHOOSE(C,le.populated_license_type_pcnt,le.populated_file_number_pcnt,le.populated_callsign_of_license_pcnt,le.populated_radio_service_code_pcnt,le.populated_licensees_name_pcnt,le.populated_licensees_attention_line_pcnt,le.populated_dba_name_pcnt,le.populated_licensees_street_pcnt,le.populated_licensees_city_pcnt,le.populated_licensees_state_pcnt,le.populated_licensees_zip_pcnt,le.populated_licensees_phone_pcnt,le.populated_date_application_received_at_fcc_pcnt,le.populated_date_license_issued_pcnt,le.populated_date_license_expires_pcnt,le.populated_date_of_last_change_pcnt,le.populated_type_of_last_change_pcnt,le.populated_latitude_pcnt,le.populated_longitude_pcnt,le.populated_transmitters_street_pcnt,le.populated_transmitters_city_pcnt,le.populated_transmitters_county_pcnt,le.populated_transmitters_state_pcnt,le.populated_transmitters_antenna_height_pcnt,le.populated_transmitters_height_above_avg_terra_pcnt,le.populated_transmitters_height_above_ground_le_pcnt,le.populated_power_of_this_frequency_pcnt,le.populated_frequency_mhz_pcnt,le.populated_class_of_station_pcnt,le.populated_number_of_units_authorized_on_freq_pcnt,le.populated_effective_radiated_power_pcnt,le.populated_emissions_codes_pcnt,le.populated_frequency_coordination_number_pcnt,le.populated_paging_license_status_pcnt,le.populated_control_point_for_the_system_pcnt,le.populated_pending_or_granted_pcnt,le.populated_firm_preparing_application_pcnt,le.populated_contact_firms_street_address_pcnt,le.populated_contact_firms_city_pcnt,le.populated_contact_firms_state_pcnt,le.populated_contact_firms_zipcode_pcnt,le.populated_contact_firms_phone_number_pcnt,le.populated_contact_firms_fax_number_pcnt,le.populated_unique_key_pcnt,le.populated_crlf_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_license_type,le.maxlength_file_number,le.maxlength_callsign_of_license,le.maxlength_radio_service_code,le.maxlength_licensees_name,le.maxlength_licensees_attention_line,le.maxlength_dba_name,le.maxlength_licensees_street,le.maxlength_licensees_city,le.maxlength_licensees_state,le.maxlength_licensees_zip,le.maxlength_licensees_phone,le.maxlength_date_application_received_at_fcc,le.maxlength_date_license_issued,le.maxlength_date_license_expires,le.maxlength_date_of_last_change,le.maxlength_type_of_last_change,le.maxlength_latitude,le.maxlength_longitude,le.maxlength_transmitters_street,le.maxlength_transmitters_city,le.maxlength_transmitters_county,le.maxlength_transmitters_state,le.maxlength_transmitters_antenna_height,le.maxlength_transmitters_height_above_avg_terra,le.maxlength_transmitters_height_above_ground_le,le.maxlength_power_of_this_frequency,le.maxlength_frequency_mhz,le.maxlength_class_of_station,le.maxlength_number_of_units_authorized_on_freq,le.maxlength_effective_radiated_power,le.maxlength_emissions_codes,le.maxlength_frequency_coordination_number,le.maxlength_paging_license_status,le.maxlength_control_point_for_the_system,le.maxlength_pending_or_granted,le.maxlength_firm_preparing_application,le.maxlength_contact_firms_street_address,le.maxlength_contact_firms_city,le.maxlength_contact_firms_state,le.maxlength_contact_firms_zipcode,le.maxlength_contact_firms_phone_number,le.maxlength_contact_firms_fax_number,le.maxlength_unique_key,le.maxlength_crlf);
  SELF.avelength := CHOOSE(C,le.avelength_license_type,le.avelength_file_number,le.avelength_callsign_of_license,le.avelength_radio_service_code,le.avelength_licensees_name,le.avelength_licensees_attention_line,le.avelength_dba_name,le.avelength_licensees_street,le.avelength_licensees_city,le.avelength_licensees_state,le.avelength_licensees_zip,le.avelength_licensees_phone,le.avelength_date_application_received_at_fcc,le.avelength_date_license_issued,le.avelength_date_license_expires,le.avelength_date_of_last_change,le.avelength_type_of_last_change,le.avelength_latitude,le.avelength_longitude,le.avelength_transmitters_street,le.avelength_transmitters_city,le.avelength_transmitters_county,le.avelength_transmitters_state,le.avelength_transmitters_antenna_height,le.avelength_transmitters_height_above_avg_terra,le.avelength_transmitters_height_above_ground_le,le.avelength_power_of_this_frequency,le.avelength_frequency_mhz,le.avelength_class_of_station,le.avelength_number_of_units_authorized_on_freq,le.avelength_effective_radiated_power,le.avelength_emissions_codes,le.avelength_frequency_coordination_number,le.avelength_paging_license_status,le.avelength_control_point_for_the_system,le.avelength_pending_or_granted,le.avelength_firm_preparing_application,le.avelength_contact_firms_street_address,le.avelength_contact_firms_city,le.avelength_contact_firms_state,le.avelength_contact_firms_zipcode,le.avelength_contact_firms_phone_number,le.avelength_contact_firms_fax_number,le.avelength_unique_key,le.avelength_crlf);
END;
EXPORT invSummary := NORMALIZE(summary0, 45, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.license_type),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.callsign_of_license),TRIM((SALT311.StrType)le.radio_service_code),TRIM((SALT311.StrType)le.licensees_name),TRIM((SALT311.StrType)le.licensees_attention_line),TRIM((SALT311.StrType)le.dba_name),TRIM((SALT311.StrType)le.licensees_street),TRIM((SALT311.StrType)le.licensees_city),TRIM((SALT311.StrType)le.licensees_state),TRIM((SALT311.StrType)le.licensees_zip),TRIM((SALT311.StrType)le.licensees_phone),TRIM((SALT311.StrType)le.date_application_received_at_fcc),TRIM((SALT311.StrType)le.date_license_issued),TRIM((SALT311.StrType)le.date_license_expires),TRIM((SALT311.StrType)le.date_of_last_change),TRIM((SALT311.StrType)le.type_of_last_change),TRIM((SALT311.StrType)le.latitude),TRIM((SALT311.StrType)le.longitude),TRIM((SALT311.StrType)le.transmitters_street),TRIM((SALT311.StrType)le.transmitters_city),TRIM((SALT311.StrType)le.transmitters_county),TRIM((SALT311.StrType)le.transmitters_state),TRIM((SALT311.StrType)le.transmitters_antenna_height),TRIM((SALT311.StrType)le.transmitters_height_above_avg_terra),TRIM((SALT311.StrType)le.transmitters_height_above_ground_le),TRIM((SALT311.StrType)le.power_of_this_frequency),TRIM((SALT311.StrType)le.frequency_mhz),TRIM((SALT311.StrType)le.class_of_station),TRIM((SALT311.StrType)le.number_of_units_authorized_on_freq),TRIM((SALT311.StrType)le.effective_radiated_power),TRIM((SALT311.StrType)le.emissions_codes),TRIM((SALT311.StrType)le.frequency_coordination_number),TRIM((SALT311.StrType)le.paging_license_status),TRIM((SALT311.StrType)le.control_point_for_the_system),TRIM((SALT311.StrType)le.pending_or_granted),TRIM((SALT311.StrType)le.firm_preparing_application),TRIM((SALT311.StrType)le.contact_firms_street_address),TRIM((SALT311.StrType)le.contact_firms_city),TRIM((SALT311.StrType)le.contact_firms_state),TRIM((SALT311.StrType)le.contact_firms_zipcode),TRIM((SALT311.StrType)le.contact_firms_phone_number),TRIM((SALT311.StrType)le.contact_firms_fax_number),TRIM((SALT311.StrType)le.unique_key),TRIM((SALT311.StrType)le.crlf)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,45,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 45);
  SELF.FldNo2 := 1 + (C % 45);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.license_type),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.callsign_of_license),TRIM((SALT311.StrType)le.radio_service_code),TRIM((SALT311.StrType)le.licensees_name),TRIM((SALT311.StrType)le.licensees_attention_line),TRIM((SALT311.StrType)le.dba_name),TRIM((SALT311.StrType)le.licensees_street),TRIM((SALT311.StrType)le.licensees_city),TRIM((SALT311.StrType)le.licensees_state),TRIM((SALT311.StrType)le.licensees_zip),TRIM((SALT311.StrType)le.licensees_phone),TRIM((SALT311.StrType)le.date_application_received_at_fcc),TRIM((SALT311.StrType)le.date_license_issued),TRIM((SALT311.StrType)le.date_license_expires),TRIM((SALT311.StrType)le.date_of_last_change),TRIM((SALT311.StrType)le.type_of_last_change),TRIM((SALT311.StrType)le.latitude),TRIM((SALT311.StrType)le.longitude),TRIM((SALT311.StrType)le.transmitters_street),TRIM((SALT311.StrType)le.transmitters_city),TRIM((SALT311.StrType)le.transmitters_county),TRIM((SALT311.StrType)le.transmitters_state),TRIM((SALT311.StrType)le.transmitters_antenna_height),TRIM((SALT311.StrType)le.transmitters_height_above_avg_terra),TRIM((SALT311.StrType)le.transmitters_height_above_ground_le),TRIM((SALT311.StrType)le.power_of_this_frequency),TRIM((SALT311.StrType)le.frequency_mhz),TRIM((SALT311.StrType)le.class_of_station),TRIM((SALT311.StrType)le.number_of_units_authorized_on_freq),TRIM((SALT311.StrType)le.effective_radiated_power),TRIM((SALT311.StrType)le.emissions_codes),TRIM((SALT311.StrType)le.frequency_coordination_number),TRIM((SALT311.StrType)le.paging_license_status),TRIM((SALT311.StrType)le.control_point_for_the_system),TRIM((SALT311.StrType)le.pending_or_granted),TRIM((SALT311.StrType)le.firm_preparing_application),TRIM((SALT311.StrType)le.contact_firms_street_address),TRIM((SALT311.StrType)le.contact_firms_city),TRIM((SALT311.StrType)le.contact_firms_state),TRIM((SALT311.StrType)le.contact_firms_zipcode),TRIM((SALT311.StrType)le.contact_firms_phone_number),TRIM((SALT311.StrType)le.contact_firms_fax_number),TRIM((SALT311.StrType)le.unique_key),TRIM((SALT311.StrType)le.crlf)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.license_type),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.callsign_of_license),TRIM((SALT311.StrType)le.radio_service_code),TRIM((SALT311.StrType)le.licensees_name),TRIM((SALT311.StrType)le.licensees_attention_line),TRIM((SALT311.StrType)le.dba_name),TRIM((SALT311.StrType)le.licensees_street),TRIM((SALT311.StrType)le.licensees_city),TRIM((SALT311.StrType)le.licensees_state),TRIM((SALT311.StrType)le.licensees_zip),TRIM((SALT311.StrType)le.licensees_phone),TRIM((SALT311.StrType)le.date_application_received_at_fcc),TRIM((SALT311.StrType)le.date_license_issued),TRIM((SALT311.StrType)le.date_license_expires),TRIM((SALT311.StrType)le.date_of_last_change),TRIM((SALT311.StrType)le.type_of_last_change),TRIM((SALT311.StrType)le.latitude),TRIM((SALT311.StrType)le.longitude),TRIM((SALT311.StrType)le.transmitters_street),TRIM((SALT311.StrType)le.transmitters_city),TRIM((SALT311.StrType)le.transmitters_county),TRIM((SALT311.StrType)le.transmitters_state),TRIM((SALT311.StrType)le.transmitters_antenna_height),TRIM((SALT311.StrType)le.transmitters_height_above_avg_terra),TRIM((SALT311.StrType)le.transmitters_height_above_ground_le),TRIM((SALT311.StrType)le.power_of_this_frequency),TRIM((SALT311.StrType)le.frequency_mhz),TRIM((SALT311.StrType)le.class_of_station),TRIM((SALT311.StrType)le.number_of_units_authorized_on_freq),TRIM((SALT311.StrType)le.effective_radiated_power),TRIM((SALT311.StrType)le.emissions_codes),TRIM((SALT311.StrType)le.frequency_coordination_number),TRIM((SALT311.StrType)le.paging_license_status),TRIM((SALT311.StrType)le.control_point_for_the_system),TRIM((SALT311.StrType)le.pending_or_granted),TRIM((SALT311.StrType)le.firm_preparing_application),TRIM((SALT311.StrType)le.contact_firms_street_address),TRIM((SALT311.StrType)le.contact_firms_city),TRIM((SALT311.StrType)le.contact_firms_state),TRIM((SALT311.StrType)le.contact_firms_zipcode),TRIM((SALT311.StrType)le.contact_firms_phone_number),TRIM((SALT311.StrType)le.contact_firms_fax_number),TRIM((SALT311.StrType)le.unique_key),TRIM((SALT311.StrType)le.crlf)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),45*45,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'license_type'}
      ,{2,'file_number'}
      ,{3,'callsign_of_license'}
      ,{4,'radio_service_code'}
      ,{5,'licensees_name'}
      ,{6,'licensees_attention_line'}
      ,{7,'dba_name'}
      ,{8,'licensees_street'}
      ,{9,'licensees_city'}
      ,{10,'licensees_state'}
      ,{11,'licensees_zip'}
      ,{12,'licensees_phone'}
      ,{13,'date_application_received_at_fcc'}
      ,{14,'date_license_issued'}
      ,{15,'date_license_expires'}
      ,{16,'date_of_last_change'}
      ,{17,'type_of_last_change'}
      ,{18,'latitude'}
      ,{19,'longitude'}
      ,{20,'transmitters_street'}
      ,{21,'transmitters_city'}
      ,{22,'transmitters_county'}
      ,{23,'transmitters_state'}
      ,{24,'transmitters_antenna_height'}
      ,{25,'transmitters_height_above_avg_terra'}
      ,{26,'transmitters_height_above_ground_le'}
      ,{27,'power_of_this_frequency'}
      ,{28,'frequency_mhz'}
      ,{29,'class_of_station'}
      ,{30,'number_of_units_authorized_on_freq'}
      ,{31,'effective_radiated_power'}
      ,{32,'emissions_codes'}
      ,{33,'frequency_coordination_number'}
      ,{34,'paging_license_status'}
      ,{35,'control_point_for_the_system'}
      ,{36,'pending_or_granted'}
      ,{37,'firm_preparing_application'}
      ,{38,'contact_firms_street_address'}
      ,{39,'contact_firms_city'}
      ,{40,'contact_firms_state'}
      ,{41,'contact_firms_zipcode'}
      ,{42,'contact_firms_phone_number'}
      ,{43,'contact_firms_fax_number'}
      ,{44,'unique_key'}
      ,{45,'crlf'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_Fields.InValid_license_type((SALT311.StrType)le.license_type),
    Input_Fields.InValid_file_number((SALT311.StrType)le.file_number),
    Input_Fields.InValid_callsign_of_license((SALT311.StrType)le.callsign_of_license),
    Input_Fields.InValid_radio_service_code((SALT311.StrType)le.radio_service_code),
    Input_Fields.InValid_licensees_name((SALT311.StrType)le.licensees_name),
    Input_Fields.InValid_licensees_attention_line((SALT311.StrType)le.licensees_attention_line),
    Input_Fields.InValid_dba_name((SALT311.StrType)le.dba_name),
    Input_Fields.InValid_licensees_street((SALT311.StrType)le.licensees_street),
    Input_Fields.InValid_licensees_city((SALT311.StrType)le.licensees_city),
    Input_Fields.InValid_licensees_state((SALT311.StrType)le.licensees_state),
    Input_Fields.InValid_licensees_zip((SALT311.StrType)le.licensees_zip),
    Input_Fields.InValid_licensees_phone((SALT311.StrType)le.licensees_phone),
    Input_Fields.InValid_date_application_received_at_fcc((SALT311.StrType)le.date_application_received_at_fcc),
    Input_Fields.InValid_date_license_issued((SALT311.StrType)le.date_license_issued),
    Input_Fields.InValid_date_license_expires((SALT311.StrType)le.date_license_expires),
    Input_Fields.InValid_date_of_last_change((SALT311.StrType)le.date_of_last_change),
    Input_Fields.InValid_type_of_last_change((SALT311.StrType)le.type_of_last_change),
    Input_Fields.InValid_latitude((SALT311.StrType)le.latitude),
    Input_Fields.InValid_longitude((SALT311.StrType)le.longitude),
    Input_Fields.InValid_transmitters_street((SALT311.StrType)le.transmitters_street),
    Input_Fields.InValid_transmitters_city((SALT311.StrType)le.transmitters_city),
    Input_Fields.InValid_transmitters_county((SALT311.StrType)le.transmitters_county),
    Input_Fields.InValid_transmitters_state((SALT311.StrType)le.transmitters_state),
    Input_Fields.InValid_transmitters_antenna_height((SALT311.StrType)le.transmitters_antenna_height),
    Input_Fields.InValid_transmitters_height_above_avg_terra((SALT311.StrType)le.transmitters_height_above_avg_terra),
    Input_Fields.InValid_transmitters_height_above_ground_le((SALT311.StrType)le.transmitters_height_above_ground_le),
    Input_Fields.InValid_power_of_this_frequency((SALT311.StrType)le.power_of_this_frequency),
    Input_Fields.InValid_frequency_mhz((SALT311.StrType)le.frequency_mhz),
    Input_Fields.InValid_class_of_station((SALT311.StrType)le.class_of_station),
    Input_Fields.InValid_number_of_units_authorized_on_freq((SALT311.StrType)le.number_of_units_authorized_on_freq),
    Input_Fields.InValid_effective_radiated_power((SALT311.StrType)le.effective_radiated_power),
    Input_Fields.InValid_emissions_codes((SALT311.StrType)le.emissions_codes),
    Input_Fields.InValid_frequency_coordination_number((SALT311.StrType)le.frequency_coordination_number),
    Input_Fields.InValid_paging_license_status((SALT311.StrType)le.paging_license_status),
    Input_Fields.InValid_control_point_for_the_system((SALT311.StrType)le.control_point_for_the_system),
    Input_Fields.InValid_pending_or_granted((SALT311.StrType)le.pending_or_granted),
    Input_Fields.InValid_firm_preparing_application((SALT311.StrType)le.firm_preparing_application),
    Input_Fields.InValid_contact_firms_street_address((SALT311.StrType)le.contact_firms_street_address),
    Input_Fields.InValid_contact_firms_city((SALT311.StrType)le.contact_firms_city),
    Input_Fields.InValid_contact_firms_state((SALT311.StrType)le.contact_firms_state),
    Input_Fields.InValid_contact_firms_zipcode((SALT311.StrType)le.contact_firms_zipcode),
    Input_Fields.InValid_contact_firms_phone_number((SALT311.StrType)le.contact_firms_phone_number),
    Input_Fields.InValid_contact_firms_fax_number((SALT311.StrType)le.contact_firms_fax_number),
    Input_Fields.InValid_unique_key((SALT311.StrType)le.unique_key),
    Input_Fields.InValid_crlf((SALT311.StrType)le.crlf),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,45,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Input_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_AlphaNum','Invalid_AlphaNum','Unknown','Invalid_Alpha','Invalid_AlphaNumChar','Unknown','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaChar','Invalid_State','Invalid_Zip','Invalid_Phone','Invalid_Date','Invalid_Date','Invalid_Future','Invalid_Date','Invalid_Alpha','Invalid_Float','Invalid_Float','Invalid_AlphaNumChar','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_State','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_AlphaNum','Invalid_No','Invalid_Float','Invalid_AlphaNum','Invalid_AlphaNumChar','Invalid_Alpha','Invalid_AlphaNumChar','Invalid_Alpha','Unknown','Invalid_AlphaNumChar','Invalid_AlphaChar','Invalid_State','Invalid_Zip','Invalid_Phone','Invalid_Phone','Invalid_AlphaNumChar','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_Fields.InValidMessage_license_type(TotalErrors.ErrorNum),Input_Fields.InValidMessage_file_number(TotalErrors.ErrorNum),Input_Fields.InValidMessage_callsign_of_license(TotalErrors.ErrorNum),Input_Fields.InValidMessage_radio_service_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_licensees_name(TotalErrors.ErrorNum),Input_Fields.InValidMessage_licensees_attention_line(TotalErrors.ErrorNum),Input_Fields.InValidMessage_dba_name(TotalErrors.ErrorNum),Input_Fields.InValidMessage_licensees_street(TotalErrors.ErrorNum),Input_Fields.InValidMessage_licensees_city(TotalErrors.ErrorNum),Input_Fields.InValidMessage_licensees_state(TotalErrors.ErrorNum),Input_Fields.InValidMessage_licensees_zip(TotalErrors.ErrorNum),Input_Fields.InValidMessage_licensees_phone(TotalErrors.ErrorNum),Input_Fields.InValidMessage_date_application_received_at_fcc(TotalErrors.ErrorNum),Input_Fields.InValidMessage_date_license_issued(TotalErrors.ErrorNum),Input_Fields.InValidMessage_date_license_expires(TotalErrors.ErrorNum),Input_Fields.InValidMessage_date_of_last_change(TotalErrors.ErrorNum),Input_Fields.InValidMessage_type_of_last_change(TotalErrors.ErrorNum),Input_Fields.InValidMessage_latitude(TotalErrors.ErrorNum),Input_Fields.InValidMessage_longitude(TotalErrors.ErrorNum),Input_Fields.InValidMessage_transmitters_street(TotalErrors.ErrorNum),Input_Fields.InValidMessage_transmitters_city(TotalErrors.ErrorNum),Input_Fields.InValidMessage_transmitters_county(TotalErrors.ErrorNum),Input_Fields.InValidMessage_transmitters_state(TotalErrors.ErrorNum),Input_Fields.InValidMessage_transmitters_antenna_height(TotalErrors.ErrorNum),Input_Fields.InValidMessage_transmitters_height_above_avg_terra(TotalErrors.ErrorNum),Input_Fields.InValidMessage_transmitters_height_above_ground_le(TotalErrors.ErrorNum),Input_Fields.InValidMessage_power_of_this_frequency(TotalErrors.ErrorNum),Input_Fields.InValidMessage_frequency_mhz(TotalErrors.ErrorNum),Input_Fields.InValidMessage_class_of_station(TotalErrors.ErrorNum),Input_Fields.InValidMessage_number_of_units_authorized_on_freq(TotalErrors.ErrorNum),Input_Fields.InValidMessage_effective_radiated_power(TotalErrors.ErrorNum),Input_Fields.InValidMessage_emissions_codes(TotalErrors.ErrorNum),Input_Fields.InValidMessage_frequency_coordination_number(TotalErrors.ErrorNum),Input_Fields.InValidMessage_paging_license_status(TotalErrors.ErrorNum),Input_Fields.InValidMessage_control_point_for_the_system(TotalErrors.ErrorNum),Input_Fields.InValidMessage_pending_or_granted(TotalErrors.ErrorNum),Input_Fields.InValidMessage_firm_preparing_application(TotalErrors.ErrorNum),Input_Fields.InValidMessage_contact_firms_street_address(TotalErrors.ErrorNum),Input_Fields.InValidMessage_contact_firms_city(TotalErrors.ErrorNum),Input_Fields.InValidMessage_contact_firms_state(TotalErrors.ErrorNum),Input_Fields.InValidMessage_contact_firms_zipcode(TotalErrors.ErrorNum),Input_Fields.InValidMessage_contact_firms_phone_number(TotalErrors.ErrorNum),Input_Fields.InValidMessage_contact_firms_fax_number(TotalErrors.ErrorNum),Input_Fields.InValidMessage_unique_key(TotalErrors.ErrorNum),Input_Fields.InValidMessage_crlf(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FCC, Input_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
