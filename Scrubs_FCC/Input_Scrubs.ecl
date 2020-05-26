IMPORT SALT311,STD;
IMPORT Scrubs,Scrubs_FCC; // Import modules for FieldTypes attribute definitions
EXPORT Input_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 46;
  EXPORT NumRulesFromFieldType := 46;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 41;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Input_Layout_FCC)
    UNSIGNED1 license_type_Invalid;
    UNSIGNED1 file_number_Invalid;
    UNSIGNED1 radio_service_code_Invalid;
    UNSIGNED1 licensees_name_Invalid;
    UNSIGNED1 dba_name_Invalid;
    UNSIGNED1 licensees_street_Invalid;
    UNSIGNED1 licensees_city_Invalid;
    UNSIGNED1 licensees_state_Invalid;
    UNSIGNED1 licensees_zip_Invalid;
    UNSIGNED1 licensees_phone_Invalid;
    UNSIGNED1 date_application_received_at_fcc_Invalid;
    UNSIGNED1 date_license_issued_Invalid;
    UNSIGNED1 date_license_expires_Invalid;
    UNSIGNED1 date_of_last_change_Invalid;
    UNSIGNED1 type_of_last_change_Invalid;
    UNSIGNED1 latitude_Invalid;
    UNSIGNED1 longitude_Invalid;
    UNSIGNED1 transmitters_street_Invalid;
    UNSIGNED1 transmitters_city_Invalid;
    UNSIGNED1 transmitters_county_Invalid;
    UNSIGNED1 transmitters_state_Invalid;
    UNSIGNED1 transmitters_antenna_height_Invalid;
    UNSIGNED1 transmitters_height_above_avg_terra_Invalid;
    UNSIGNED1 transmitters_height_above_ground_le_Invalid;
    UNSIGNED1 power_of_this_frequency_Invalid;
    UNSIGNED1 frequency_mhz_Invalid;
    UNSIGNED1 class_of_station_Invalid;
    UNSIGNED1 number_of_units_authorized_on_freq_Invalid;
    UNSIGNED1 effective_radiated_power_Invalid;
    UNSIGNED1 emissions_codes_Invalid;
    UNSIGNED1 frequency_coordination_number_Invalid;
    UNSIGNED1 paging_license_status_Invalid;
    UNSIGNED1 control_point_for_the_system_Invalid;
    UNSIGNED1 pending_or_granted_Invalid;
    UNSIGNED1 contact_firms_street_address_Invalid;
    UNSIGNED1 contact_firms_city_Invalid;
    UNSIGNED1 contact_firms_state_Invalid;
    UNSIGNED1 contact_firms_zipcode_Invalid;
    UNSIGNED1 contact_firms_phone_number_Invalid;
    UNSIGNED1 contact_firms_fax_number_Invalid;
    UNSIGNED1 unique_key_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Input_Layout_FCC)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Input_Layout_FCC)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'license_type:Invalid_AlphaNum:CUSTOM'
          ,'file_number:Invalid_AlphaNum:CUSTOM'
          ,'radio_service_code:Invalid_Alpha:CUSTOM'
          ,'licensees_name:Invalid_AlphaNumChar:CUSTOM'
          ,'dba_name:Invalid_AlphaNumChar:CUSTOM'
          ,'licensees_street:Invalid_AlphaNumChar:CUSTOM'
          ,'licensees_city:Invalid_AlphaChar:CUSTOM'
          ,'licensees_state:Invalid_State:LENGTHS'
          ,'licensees_zip:Invalid_Zip:ALLOW','licensees_zip:Invalid_Zip:LENGTHS'
          ,'licensees_phone:Invalid_Phone:ALLOW','licensees_phone:Invalid_Phone:LENGTHS'
          ,'date_application_received_at_fcc:Invalid_Date:CUSTOM'
          ,'date_license_issued:Invalid_Date:CUSTOM'
          ,'date_license_expires:Invalid_Future:CUSTOM'
          ,'date_of_last_change:Invalid_Date:CUSTOM'
          ,'type_of_last_change:Invalid_Alpha:CUSTOM'
          ,'latitude:Invalid_Float:ALLOW'
          ,'longitude:Invalid_Float:ALLOW'
          ,'transmitters_street:Invalid_AlphaNumChar:CUSTOM'
          ,'transmitters_city:Invalid_AlphaChar:CUSTOM'
          ,'transmitters_county:Invalid_AlphaChar:CUSTOM'
          ,'transmitters_state:Invalid_State:LENGTHS'
          ,'transmitters_antenna_height:Invalid_Float:ALLOW'
          ,'transmitters_height_above_avg_terra:Invalid_Float:ALLOW'
          ,'transmitters_height_above_ground_le:Invalid_Float:ALLOW'
          ,'power_of_this_frequency:Invalid_Float:ALLOW'
          ,'frequency_mhz:Invalid_Float:ALLOW'
          ,'class_of_station:Invalid_AlphaNum:CUSTOM'
          ,'number_of_units_authorized_on_freq:Invalid_No:ALLOW'
          ,'effective_radiated_power:Invalid_Float:ALLOW'
          ,'emissions_codes:Invalid_AlphaNum:CUSTOM'
          ,'frequency_coordination_number:Invalid_AlphaNumChar:CUSTOM'
          ,'paging_license_status:Invalid_Alpha:CUSTOM'
          ,'control_point_for_the_system:Invalid_AlphaNumChar:CUSTOM'
          ,'pending_or_granted:Invalid_Alpha:CUSTOM'
          ,'contact_firms_street_address:Invalid_AlphaNumChar:CUSTOM'
          ,'contact_firms_city:Invalid_AlphaChar:CUSTOM'
          ,'contact_firms_state:Invalid_State:LENGTHS'
          ,'contact_firms_zipcode:Invalid_Zip:ALLOW','contact_firms_zipcode:Invalid_Zip:LENGTHS'
          ,'contact_firms_phone_number:Invalid_Phone:ALLOW','contact_firms_phone_number:Invalid_Phone:LENGTHS'
          ,'contact_firms_fax_number:Invalid_Phone:ALLOW','contact_firms_fax_number:Invalid_Phone:LENGTHS'
          ,'unique_key:Invalid_AlphaNumChar:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Input_Fields.InvalidMessage_license_type(1)
          ,Input_Fields.InvalidMessage_file_number(1)
          ,Input_Fields.InvalidMessage_radio_service_code(1)
          ,Input_Fields.InvalidMessage_licensees_name(1)
          ,Input_Fields.InvalidMessage_dba_name(1)
          ,Input_Fields.InvalidMessage_licensees_street(1)
          ,Input_Fields.InvalidMessage_licensees_city(1)
          ,Input_Fields.InvalidMessage_licensees_state(1)
          ,Input_Fields.InvalidMessage_licensees_zip(1),Input_Fields.InvalidMessage_licensees_zip(2)
          ,Input_Fields.InvalidMessage_licensees_phone(1),Input_Fields.InvalidMessage_licensees_phone(2)
          ,Input_Fields.InvalidMessage_date_application_received_at_fcc(1)
          ,Input_Fields.InvalidMessage_date_license_issued(1)
          ,Input_Fields.InvalidMessage_date_license_expires(1)
          ,Input_Fields.InvalidMessage_date_of_last_change(1)
          ,Input_Fields.InvalidMessage_type_of_last_change(1)
          ,Input_Fields.InvalidMessage_latitude(1)
          ,Input_Fields.InvalidMessage_longitude(1)
          ,Input_Fields.InvalidMessage_transmitters_street(1)
          ,Input_Fields.InvalidMessage_transmitters_city(1)
          ,Input_Fields.InvalidMessage_transmitters_county(1)
          ,Input_Fields.InvalidMessage_transmitters_state(1)
          ,Input_Fields.InvalidMessage_transmitters_antenna_height(1)
          ,Input_Fields.InvalidMessage_transmitters_height_above_avg_terra(1)
          ,Input_Fields.InvalidMessage_transmitters_height_above_ground_le(1)
          ,Input_Fields.InvalidMessage_power_of_this_frequency(1)
          ,Input_Fields.InvalidMessage_frequency_mhz(1)
          ,Input_Fields.InvalidMessage_class_of_station(1)
          ,Input_Fields.InvalidMessage_number_of_units_authorized_on_freq(1)
          ,Input_Fields.InvalidMessage_effective_radiated_power(1)
          ,Input_Fields.InvalidMessage_emissions_codes(1)
          ,Input_Fields.InvalidMessage_frequency_coordination_number(1)
          ,Input_Fields.InvalidMessage_paging_license_status(1)
          ,Input_Fields.InvalidMessage_control_point_for_the_system(1)
          ,Input_Fields.InvalidMessage_pending_or_granted(1)
          ,Input_Fields.InvalidMessage_contact_firms_street_address(1)
          ,Input_Fields.InvalidMessage_contact_firms_city(1)
          ,Input_Fields.InvalidMessage_contact_firms_state(1)
          ,Input_Fields.InvalidMessage_contact_firms_zipcode(1),Input_Fields.InvalidMessage_contact_firms_zipcode(2)
          ,Input_Fields.InvalidMessage_contact_firms_phone_number(1),Input_Fields.InvalidMessage_contact_firms_phone_number(2)
          ,Input_Fields.InvalidMessage_contact_firms_fax_number(1),Input_Fields.InvalidMessage_contact_firms_fax_number(2)
          ,Input_Fields.InvalidMessage_unique_key(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Input_Layout_FCC) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.license_type_Invalid := Input_Fields.InValid_license_type((SALT311.StrType)le.license_type);
    SELF.file_number_Invalid := Input_Fields.InValid_file_number((SALT311.StrType)le.file_number);
    SELF.radio_service_code_Invalid := Input_Fields.InValid_radio_service_code((SALT311.StrType)le.radio_service_code);
    SELF.licensees_name_Invalid := Input_Fields.InValid_licensees_name((SALT311.StrType)le.licensees_name);
    SELF.dba_name_Invalid := Input_Fields.InValid_dba_name((SALT311.StrType)le.dba_name);
    SELF.licensees_street_Invalid := Input_Fields.InValid_licensees_street((SALT311.StrType)le.licensees_street);
    SELF.licensees_city_Invalid := Input_Fields.InValid_licensees_city((SALT311.StrType)le.licensees_city);
    SELF.licensees_state_Invalid := Input_Fields.InValid_licensees_state((SALT311.StrType)le.licensees_state);
    SELF.licensees_zip_Invalid := Input_Fields.InValid_licensees_zip((SALT311.StrType)le.licensees_zip);
    SELF.licensees_phone_Invalid := Input_Fields.InValid_licensees_phone((SALT311.StrType)le.licensees_phone);
    SELF.date_application_received_at_fcc_Invalid := Input_Fields.InValid_date_application_received_at_fcc((SALT311.StrType)le.date_application_received_at_fcc);
    SELF.date_license_issued_Invalid := Input_Fields.InValid_date_license_issued((SALT311.StrType)le.date_license_issued);
    SELF.date_license_expires_Invalid := Input_Fields.InValid_date_license_expires((SALT311.StrType)le.date_license_expires);
    SELF.date_of_last_change_Invalid := Input_Fields.InValid_date_of_last_change((SALT311.StrType)le.date_of_last_change);
    SELF.type_of_last_change_Invalid := Input_Fields.InValid_type_of_last_change((SALT311.StrType)le.type_of_last_change);
    SELF.latitude_Invalid := Input_Fields.InValid_latitude((SALT311.StrType)le.latitude);
    SELF.longitude_Invalid := Input_Fields.InValid_longitude((SALT311.StrType)le.longitude);
    SELF.transmitters_street_Invalid := Input_Fields.InValid_transmitters_street((SALT311.StrType)le.transmitters_street);
    SELF.transmitters_city_Invalid := Input_Fields.InValid_transmitters_city((SALT311.StrType)le.transmitters_city);
    SELF.transmitters_county_Invalid := Input_Fields.InValid_transmitters_county((SALT311.StrType)le.transmitters_county);
    SELF.transmitters_state_Invalid := Input_Fields.InValid_transmitters_state((SALT311.StrType)le.transmitters_state);
    SELF.transmitters_antenna_height_Invalid := Input_Fields.InValid_transmitters_antenna_height((SALT311.StrType)le.transmitters_antenna_height);
    SELF.transmitters_height_above_avg_terra_Invalid := Input_Fields.InValid_transmitters_height_above_avg_terra((SALT311.StrType)le.transmitters_height_above_avg_terra);
    SELF.transmitters_height_above_ground_le_Invalid := Input_Fields.InValid_transmitters_height_above_ground_le((SALT311.StrType)le.transmitters_height_above_ground_le);
    SELF.power_of_this_frequency_Invalid := Input_Fields.InValid_power_of_this_frequency((SALT311.StrType)le.power_of_this_frequency);
    SELF.frequency_mhz_Invalid := Input_Fields.InValid_frequency_mhz((SALT311.StrType)le.frequency_mhz);
    SELF.class_of_station_Invalid := Input_Fields.InValid_class_of_station((SALT311.StrType)le.class_of_station);
    SELF.number_of_units_authorized_on_freq_Invalid := Input_Fields.InValid_number_of_units_authorized_on_freq((SALT311.StrType)le.number_of_units_authorized_on_freq);
    SELF.effective_radiated_power_Invalid := Input_Fields.InValid_effective_radiated_power((SALT311.StrType)le.effective_radiated_power);
    SELF.emissions_codes_Invalid := Input_Fields.InValid_emissions_codes((SALT311.StrType)le.emissions_codes);
    SELF.frequency_coordination_number_Invalid := Input_Fields.InValid_frequency_coordination_number((SALT311.StrType)le.frequency_coordination_number);
    SELF.paging_license_status_Invalid := Input_Fields.InValid_paging_license_status((SALT311.StrType)le.paging_license_status);
    SELF.control_point_for_the_system_Invalid := Input_Fields.InValid_control_point_for_the_system((SALT311.StrType)le.control_point_for_the_system);
    SELF.pending_or_granted_Invalid := Input_Fields.InValid_pending_or_granted((SALT311.StrType)le.pending_or_granted);
    SELF.contact_firms_street_address_Invalid := Input_Fields.InValid_contact_firms_street_address((SALT311.StrType)le.contact_firms_street_address);
    SELF.contact_firms_city_Invalid := Input_Fields.InValid_contact_firms_city((SALT311.StrType)le.contact_firms_city);
    SELF.contact_firms_state_Invalid := Input_Fields.InValid_contact_firms_state((SALT311.StrType)le.contact_firms_state);
    SELF.contact_firms_zipcode_Invalid := Input_Fields.InValid_contact_firms_zipcode((SALT311.StrType)le.contact_firms_zipcode);
    SELF.contact_firms_phone_number_Invalid := Input_Fields.InValid_contact_firms_phone_number((SALT311.StrType)le.contact_firms_phone_number);
    SELF.contact_firms_fax_number_Invalid := Input_Fields.InValid_contact_firms_fax_number((SALT311.StrType)le.contact_firms_fax_number);
    SELF.unique_key_Invalid := Input_Fields.InValid_unique_key((SALT311.StrType)le.unique_key);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Input_Layout_FCC);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.license_type_Invalid << 0 ) + ( le.file_number_Invalid << 1 ) + ( le.radio_service_code_Invalid << 2 ) + ( le.licensees_name_Invalid << 3 ) + ( le.dba_name_Invalid << 4 ) + ( le.licensees_street_Invalid << 5 ) + ( le.licensees_city_Invalid << 6 ) + ( le.licensees_state_Invalid << 7 ) + ( le.licensees_zip_Invalid << 8 ) + ( le.licensees_phone_Invalid << 10 ) + ( le.date_application_received_at_fcc_Invalid << 12 ) + ( le.date_license_issued_Invalid << 13 ) + ( le.date_license_expires_Invalid << 14 ) + ( le.date_of_last_change_Invalid << 15 ) + ( le.type_of_last_change_Invalid << 16 ) + ( le.latitude_Invalid << 17 ) + ( le.longitude_Invalid << 18 ) + ( le.transmitters_street_Invalid << 19 ) + ( le.transmitters_city_Invalid << 20 ) + ( le.transmitters_county_Invalid << 21 ) + ( le.transmitters_state_Invalid << 22 ) + ( le.transmitters_antenna_height_Invalid << 23 ) + ( le.transmitters_height_above_avg_terra_Invalid << 24 ) + ( le.transmitters_height_above_ground_le_Invalid << 25 ) + ( le.power_of_this_frequency_Invalid << 26 ) + ( le.frequency_mhz_Invalid << 27 ) + ( le.class_of_station_Invalid << 28 ) + ( le.number_of_units_authorized_on_freq_Invalid << 29 ) + ( le.effective_radiated_power_Invalid << 30 ) + ( le.emissions_codes_Invalid << 31 ) + ( le.frequency_coordination_number_Invalid << 32 ) + ( le.paging_license_status_Invalid << 33 ) + ( le.control_point_for_the_system_Invalid << 34 ) + ( le.pending_or_granted_Invalid << 35 ) + ( le.contact_firms_street_address_Invalid << 36 ) + ( le.contact_firms_city_Invalid << 37 ) + ( le.contact_firms_state_Invalid << 38 ) + ( le.contact_firms_zipcode_Invalid << 39 ) + ( le.contact_firms_phone_number_Invalid << 41 ) + ( le.contact_firms_fax_number_Invalid << 43 ) + ( le.unique_key_Invalid << 45 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND c=1,'',SKIP));
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
  EXPORT Infile := PROJECT(h,Input_Layout_FCC);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.license_type_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.file_number_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.radio_service_code_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.licensees_name_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.dba_name_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.licensees_street_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.licensees_city_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.licensees_state_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.licensees_zip_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.licensees_phone_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.date_application_received_at_fcc_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.date_license_issued_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.date_license_expires_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.date_of_last_change_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.type_of_last_change_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.latitude_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.longitude_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.transmitters_street_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.transmitters_city_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.transmitters_county_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.transmitters_state_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.transmitters_antenna_height_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.transmitters_height_above_avg_terra_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.transmitters_height_above_ground_le_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.power_of_this_frequency_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.frequency_mhz_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.class_of_station_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.number_of_units_authorized_on_freq_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.effective_radiated_power_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.emissions_codes_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.frequency_coordination_number_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.paging_license_status_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.control_point_for_the_system_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.pending_or_granted_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.contact_firms_street_address_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.contact_firms_city_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.contact_firms_state_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.contact_firms_zipcode_Invalid := (le.ScrubsBits1 >> 39) & 3;
    SELF.contact_firms_phone_number_Invalid := (le.ScrubsBits1 >> 41) & 3;
    SELF.contact_firms_fax_number_Invalid := (le.ScrubsBits1 >> 43) & 3;
    SELF.unique_key_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    license_type_CUSTOM_ErrorCount := COUNT(GROUP,h.license_type_Invalid=1);
    file_number_CUSTOM_ErrorCount := COUNT(GROUP,h.file_number_Invalid=1);
    radio_service_code_CUSTOM_ErrorCount := COUNT(GROUP,h.radio_service_code_Invalid=1);
    licensees_name_CUSTOM_ErrorCount := COUNT(GROUP,h.licensees_name_Invalid=1);
    dba_name_CUSTOM_ErrorCount := COUNT(GROUP,h.dba_name_Invalid=1);
    licensees_street_CUSTOM_ErrorCount := COUNT(GROUP,h.licensees_street_Invalid=1);
    licensees_city_CUSTOM_ErrorCount := COUNT(GROUP,h.licensees_city_Invalid=1);
    licensees_state_LENGTHS_ErrorCount := COUNT(GROUP,h.licensees_state_Invalid=1);
    licensees_zip_ALLOW_ErrorCount := COUNT(GROUP,h.licensees_zip_Invalid=1);
    licensees_zip_LENGTHS_ErrorCount := COUNT(GROUP,h.licensees_zip_Invalid=2);
    licensees_zip_Total_ErrorCount := COUNT(GROUP,h.licensees_zip_Invalid>0);
    licensees_phone_ALLOW_ErrorCount := COUNT(GROUP,h.licensees_phone_Invalid=1);
    licensees_phone_LENGTHS_ErrorCount := COUNT(GROUP,h.licensees_phone_Invalid=2);
    licensees_phone_Total_ErrorCount := COUNT(GROUP,h.licensees_phone_Invalid>0);
    date_application_received_at_fcc_CUSTOM_ErrorCount := COUNT(GROUP,h.date_application_received_at_fcc_Invalid=1);
    date_license_issued_CUSTOM_ErrorCount := COUNT(GROUP,h.date_license_issued_Invalid=1);
    date_license_expires_CUSTOM_ErrorCount := COUNT(GROUP,h.date_license_expires_Invalid=1);
    date_of_last_change_CUSTOM_ErrorCount := COUNT(GROUP,h.date_of_last_change_Invalid=1);
    type_of_last_change_CUSTOM_ErrorCount := COUNT(GROUP,h.type_of_last_change_Invalid=1);
    latitude_ALLOW_ErrorCount := COUNT(GROUP,h.latitude_Invalid=1);
    longitude_ALLOW_ErrorCount := COUNT(GROUP,h.longitude_Invalid=1);
    transmitters_street_CUSTOM_ErrorCount := COUNT(GROUP,h.transmitters_street_Invalid=1);
    transmitters_city_CUSTOM_ErrorCount := COUNT(GROUP,h.transmitters_city_Invalid=1);
    transmitters_county_CUSTOM_ErrorCount := COUNT(GROUP,h.transmitters_county_Invalid=1);
    transmitters_state_LENGTHS_ErrorCount := COUNT(GROUP,h.transmitters_state_Invalid=1);
    transmitters_antenna_height_ALLOW_ErrorCount := COUNT(GROUP,h.transmitters_antenna_height_Invalid=1);
    transmitters_height_above_avg_terra_ALLOW_ErrorCount := COUNT(GROUP,h.transmitters_height_above_avg_terra_Invalid=1);
    transmitters_height_above_ground_le_ALLOW_ErrorCount := COUNT(GROUP,h.transmitters_height_above_ground_le_Invalid=1);
    power_of_this_frequency_ALLOW_ErrorCount := COUNT(GROUP,h.power_of_this_frequency_Invalid=1);
    frequency_mhz_ALLOW_ErrorCount := COUNT(GROUP,h.frequency_mhz_Invalid=1);
    class_of_station_CUSTOM_ErrorCount := COUNT(GROUP,h.class_of_station_Invalid=1);
    number_of_units_authorized_on_freq_ALLOW_ErrorCount := COUNT(GROUP,h.number_of_units_authorized_on_freq_Invalid=1);
    effective_radiated_power_ALLOW_ErrorCount := COUNT(GROUP,h.effective_radiated_power_Invalid=1);
    emissions_codes_CUSTOM_ErrorCount := COUNT(GROUP,h.emissions_codes_Invalid=1);
    frequency_coordination_number_CUSTOM_ErrorCount := COUNT(GROUP,h.frequency_coordination_number_Invalid=1);
    paging_license_status_CUSTOM_ErrorCount := COUNT(GROUP,h.paging_license_status_Invalid=1);
    control_point_for_the_system_CUSTOM_ErrorCount := COUNT(GROUP,h.control_point_for_the_system_Invalid=1);
    pending_or_granted_CUSTOM_ErrorCount := COUNT(GROUP,h.pending_or_granted_Invalid=1);
    contact_firms_street_address_CUSTOM_ErrorCount := COUNT(GROUP,h.contact_firms_street_address_Invalid=1);
    contact_firms_city_CUSTOM_ErrorCount := COUNT(GROUP,h.contact_firms_city_Invalid=1);
    contact_firms_state_LENGTHS_ErrorCount := COUNT(GROUP,h.contact_firms_state_Invalid=1);
    contact_firms_zipcode_ALLOW_ErrorCount := COUNT(GROUP,h.contact_firms_zipcode_Invalid=1);
    contact_firms_zipcode_LENGTHS_ErrorCount := COUNT(GROUP,h.contact_firms_zipcode_Invalid=2);
    contact_firms_zipcode_Total_ErrorCount := COUNT(GROUP,h.contact_firms_zipcode_Invalid>0);
    contact_firms_phone_number_ALLOW_ErrorCount := COUNT(GROUP,h.contact_firms_phone_number_Invalid=1);
    contact_firms_phone_number_LENGTHS_ErrorCount := COUNT(GROUP,h.contact_firms_phone_number_Invalid=2);
    contact_firms_phone_number_Total_ErrorCount := COUNT(GROUP,h.contact_firms_phone_number_Invalid>0);
    contact_firms_fax_number_ALLOW_ErrorCount := COUNT(GROUP,h.contact_firms_fax_number_Invalid=1);
    contact_firms_fax_number_LENGTHS_ErrorCount := COUNT(GROUP,h.contact_firms_fax_number_Invalid=2);
    contact_firms_fax_number_Total_ErrorCount := COUNT(GROUP,h.contact_firms_fax_number_Invalid>0);
    unique_key_CUSTOM_ErrorCount := COUNT(GROUP,h.unique_key_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.license_type_Invalid > 0 OR h.file_number_Invalid > 0 OR h.radio_service_code_Invalid > 0 OR h.licensees_name_Invalid > 0 OR h.dba_name_Invalid > 0 OR h.licensees_street_Invalid > 0 OR h.licensees_city_Invalid > 0 OR h.licensees_state_Invalid > 0 OR h.licensees_zip_Invalid > 0 OR h.licensees_phone_Invalid > 0 OR h.date_application_received_at_fcc_Invalid > 0 OR h.date_license_issued_Invalid > 0 OR h.date_license_expires_Invalid > 0 OR h.date_of_last_change_Invalid > 0 OR h.type_of_last_change_Invalid > 0 OR h.latitude_Invalid > 0 OR h.longitude_Invalid > 0 OR h.transmitters_street_Invalid > 0 OR h.transmitters_city_Invalid > 0 OR h.transmitters_county_Invalid > 0 OR h.transmitters_state_Invalid > 0 OR h.transmitters_antenna_height_Invalid > 0 OR h.transmitters_height_above_avg_terra_Invalid > 0 OR h.transmitters_height_above_ground_le_Invalid > 0 OR h.power_of_this_frequency_Invalid > 0 OR h.frequency_mhz_Invalid > 0 OR h.class_of_station_Invalid > 0 OR h.number_of_units_authorized_on_freq_Invalid > 0 OR h.effective_radiated_power_Invalid > 0 OR h.emissions_codes_Invalid > 0 OR h.frequency_coordination_number_Invalid > 0 OR h.paging_license_status_Invalid > 0 OR h.control_point_for_the_system_Invalid > 0 OR h.pending_or_granted_Invalid > 0 OR h.contact_firms_street_address_Invalid > 0 OR h.contact_firms_city_Invalid > 0 OR h.contact_firms_state_Invalid > 0 OR h.contact_firms_zipcode_Invalid > 0 OR h.contact_firms_phone_number_Invalid > 0 OR h.contact_firms_fax_number_Invalid > 0 OR h.unique_key_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.license_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.file_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.radio_service_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.licensees_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dba_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.licensees_street_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.licensees_city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.licensees_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.licensees_zip_Total_ErrorCount > 0, 1, 0) + IF(le.licensees_phone_Total_ErrorCount > 0, 1, 0) + IF(le.date_application_received_at_fcc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_license_issued_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_license_expires_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_of_last_change_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.type_of_last_change_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.latitude_ALLOW_ErrorCount > 0, 1, 0) + IF(le.longitude_ALLOW_ErrorCount > 0, 1, 0) + IF(le.transmitters_street_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.transmitters_city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.transmitters_county_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.transmitters_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.transmitters_antenna_height_ALLOW_ErrorCount > 0, 1, 0) + IF(le.transmitters_height_above_avg_terra_ALLOW_ErrorCount > 0, 1, 0) + IF(le.transmitters_height_above_ground_le_ALLOW_ErrorCount > 0, 1, 0) + IF(le.power_of_this_frequency_ALLOW_ErrorCount > 0, 1, 0) + IF(le.frequency_mhz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.class_of_station_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.number_of_units_authorized_on_freq_ALLOW_ErrorCount > 0, 1, 0) + IF(le.effective_radiated_power_ALLOW_ErrorCount > 0, 1, 0) + IF(le.emissions_codes_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.frequency_coordination_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.paging_license_status_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.control_point_for_the_system_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.pending_or_granted_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_firms_street_address_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_firms_city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_firms_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.contact_firms_zipcode_Total_ErrorCount > 0, 1, 0) + IF(le.contact_firms_phone_number_Total_ErrorCount > 0, 1, 0) + IF(le.contact_firms_fax_number_Total_ErrorCount > 0, 1, 0) + IF(le.unique_key_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.license_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.file_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.radio_service_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.licensees_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dba_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.licensees_street_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.licensees_city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.licensees_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.licensees_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.licensees_zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.licensees_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.licensees_phone_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.date_application_received_at_fcc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_license_issued_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_license_expires_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_of_last_change_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.type_of_last_change_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.latitude_ALLOW_ErrorCount > 0, 1, 0) + IF(le.longitude_ALLOW_ErrorCount > 0, 1, 0) + IF(le.transmitters_street_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.transmitters_city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.transmitters_county_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.transmitters_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.transmitters_antenna_height_ALLOW_ErrorCount > 0, 1, 0) + IF(le.transmitters_height_above_avg_terra_ALLOW_ErrorCount > 0, 1, 0) + IF(le.transmitters_height_above_ground_le_ALLOW_ErrorCount > 0, 1, 0) + IF(le.power_of_this_frequency_ALLOW_ErrorCount > 0, 1, 0) + IF(le.frequency_mhz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.class_of_station_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.number_of_units_authorized_on_freq_ALLOW_ErrorCount > 0, 1, 0) + IF(le.effective_radiated_power_ALLOW_ErrorCount > 0, 1, 0) + IF(le.emissions_codes_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.frequency_coordination_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.paging_license_status_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.control_point_for_the_system_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.pending_or_granted_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_firms_street_address_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_firms_city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_firms_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.contact_firms_zipcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_firms_zipcode_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.contact_firms_phone_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_firms_phone_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.contact_firms_fax_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_firms_fax_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.unique_key_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.license_type_Invalid,le.file_number_Invalid,le.radio_service_code_Invalid,le.licensees_name_Invalid,le.dba_name_Invalid,le.licensees_street_Invalid,le.licensees_city_Invalid,le.licensees_state_Invalid,le.licensees_zip_Invalid,le.licensees_phone_Invalid,le.date_application_received_at_fcc_Invalid,le.date_license_issued_Invalid,le.date_license_expires_Invalid,le.date_of_last_change_Invalid,le.type_of_last_change_Invalid,le.latitude_Invalid,le.longitude_Invalid,le.transmitters_street_Invalid,le.transmitters_city_Invalid,le.transmitters_county_Invalid,le.transmitters_state_Invalid,le.transmitters_antenna_height_Invalid,le.transmitters_height_above_avg_terra_Invalid,le.transmitters_height_above_ground_le_Invalid,le.power_of_this_frequency_Invalid,le.frequency_mhz_Invalid,le.class_of_station_Invalid,le.number_of_units_authorized_on_freq_Invalid,le.effective_radiated_power_Invalid,le.emissions_codes_Invalid,le.frequency_coordination_number_Invalid,le.paging_license_status_Invalid,le.control_point_for_the_system_Invalid,le.pending_or_granted_Invalid,le.contact_firms_street_address_Invalid,le.contact_firms_city_Invalid,le.contact_firms_state_Invalid,le.contact_firms_zipcode_Invalid,le.contact_firms_phone_number_Invalid,le.contact_firms_fax_number_Invalid,le.unique_key_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Input_Fields.InvalidMessage_license_type(le.license_type_Invalid),Input_Fields.InvalidMessage_file_number(le.file_number_Invalid),Input_Fields.InvalidMessage_radio_service_code(le.radio_service_code_Invalid),Input_Fields.InvalidMessage_licensees_name(le.licensees_name_Invalid),Input_Fields.InvalidMessage_dba_name(le.dba_name_Invalid),Input_Fields.InvalidMessage_licensees_street(le.licensees_street_Invalid),Input_Fields.InvalidMessage_licensees_city(le.licensees_city_Invalid),Input_Fields.InvalidMessage_licensees_state(le.licensees_state_Invalid),Input_Fields.InvalidMessage_licensees_zip(le.licensees_zip_Invalid),Input_Fields.InvalidMessage_licensees_phone(le.licensees_phone_Invalid),Input_Fields.InvalidMessage_date_application_received_at_fcc(le.date_application_received_at_fcc_Invalid),Input_Fields.InvalidMessage_date_license_issued(le.date_license_issued_Invalid),Input_Fields.InvalidMessage_date_license_expires(le.date_license_expires_Invalid),Input_Fields.InvalidMessage_date_of_last_change(le.date_of_last_change_Invalid),Input_Fields.InvalidMessage_type_of_last_change(le.type_of_last_change_Invalid),Input_Fields.InvalidMessage_latitude(le.latitude_Invalid),Input_Fields.InvalidMessage_longitude(le.longitude_Invalid),Input_Fields.InvalidMessage_transmitters_street(le.transmitters_street_Invalid),Input_Fields.InvalidMessage_transmitters_city(le.transmitters_city_Invalid),Input_Fields.InvalidMessage_transmitters_county(le.transmitters_county_Invalid),Input_Fields.InvalidMessage_transmitters_state(le.transmitters_state_Invalid),Input_Fields.InvalidMessage_transmitters_antenna_height(le.transmitters_antenna_height_Invalid),Input_Fields.InvalidMessage_transmitters_height_above_avg_terra(le.transmitters_height_above_avg_terra_Invalid),Input_Fields.InvalidMessage_transmitters_height_above_ground_le(le.transmitters_height_above_ground_le_Invalid),Input_Fields.InvalidMessage_power_of_this_frequency(le.power_of_this_frequency_Invalid),Input_Fields.InvalidMessage_frequency_mhz(le.frequency_mhz_Invalid),Input_Fields.InvalidMessage_class_of_station(le.class_of_station_Invalid),Input_Fields.InvalidMessage_number_of_units_authorized_on_freq(le.number_of_units_authorized_on_freq_Invalid),Input_Fields.InvalidMessage_effective_radiated_power(le.effective_radiated_power_Invalid),Input_Fields.InvalidMessage_emissions_codes(le.emissions_codes_Invalid),Input_Fields.InvalidMessage_frequency_coordination_number(le.frequency_coordination_number_Invalid),Input_Fields.InvalidMessage_paging_license_status(le.paging_license_status_Invalid),Input_Fields.InvalidMessage_control_point_for_the_system(le.control_point_for_the_system_Invalid),Input_Fields.InvalidMessage_pending_or_granted(le.pending_or_granted_Invalid),Input_Fields.InvalidMessage_contact_firms_street_address(le.contact_firms_street_address_Invalid),Input_Fields.InvalidMessage_contact_firms_city(le.contact_firms_city_Invalid),Input_Fields.InvalidMessage_contact_firms_state(le.contact_firms_state_Invalid),Input_Fields.InvalidMessage_contact_firms_zipcode(le.contact_firms_zipcode_Invalid),Input_Fields.InvalidMessage_contact_firms_phone_number(le.contact_firms_phone_number_Invalid),Input_Fields.InvalidMessage_contact_firms_fax_number(le.contact_firms_fax_number_Invalid),Input_Fields.InvalidMessage_unique_key(le.unique_key_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.license_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.file_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.radio_service_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.licensees_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dba_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.licensees_street_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.licensees_city_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.licensees_state_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.licensees_zip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.licensees_phone_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.date_application_received_at_fcc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_license_issued_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_license_expires_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_of_last_change_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.type_of_last_change_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.latitude_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.longitude_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.transmitters_street_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.transmitters_city_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.transmitters_county_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.transmitters_state_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.transmitters_antenna_height_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.transmitters_height_above_avg_terra_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.transmitters_height_above_ground_le_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.power_of_this_frequency_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.frequency_mhz_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.class_of_station_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.number_of_units_authorized_on_freq_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.effective_radiated_power_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.emissions_codes_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.frequency_coordination_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.paging_license_status_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.control_point_for_the_system_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.pending_or_granted_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.contact_firms_street_address_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.contact_firms_city_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.contact_firms_state_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.contact_firms_zipcode_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.contact_firms_phone_number_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.contact_firms_fax_number_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.unique_key_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'license_type','file_number','radio_service_code','licensees_name','dba_name','licensees_street','licensees_city','licensees_state','licensees_zip','licensees_phone','date_application_received_at_fcc','date_license_issued','date_license_expires','date_of_last_change','type_of_last_change','latitude','longitude','transmitters_street','transmitters_city','transmitters_county','transmitters_state','transmitters_antenna_height','transmitters_height_above_avg_terra','transmitters_height_above_ground_le','power_of_this_frequency','frequency_mhz','class_of_station','number_of_units_authorized_on_freq','effective_radiated_power','emissions_codes','frequency_coordination_number','paging_license_status','control_point_for_the_system','pending_or_granted','contact_firms_street_address','contact_firms_city','contact_firms_state','contact_firms_zipcode','contact_firms_phone_number','contact_firms_fax_number','unique_key','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_AlphaNum','Invalid_AlphaNum','Invalid_Alpha','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaChar','Invalid_State','Invalid_Zip','Invalid_Phone','Invalid_Date','Invalid_Date','Invalid_Future','Invalid_Date','Invalid_Alpha','Invalid_Float','Invalid_Float','Invalid_AlphaNumChar','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_State','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_AlphaNum','Invalid_No','Invalid_Float','Invalid_AlphaNum','Invalid_AlphaNumChar','Invalid_Alpha','Invalid_AlphaNumChar','Invalid_Alpha','Invalid_AlphaNumChar','Invalid_AlphaChar','Invalid_State','Invalid_Zip','Invalid_Phone','Invalid_Phone','Invalid_AlphaNumChar','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.license_type,(SALT311.StrType)le.file_number,(SALT311.StrType)le.radio_service_code,(SALT311.StrType)le.licensees_name,(SALT311.StrType)le.dba_name,(SALT311.StrType)le.licensees_street,(SALT311.StrType)le.licensees_city,(SALT311.StrType)le.licensees_state,(SALT311.StrType)le.licensees_zip,(SALT311.StrType)le.licensees_phone,(SALT311.StrType)le.date_application_received_at_fcc,(SALT311.StrType)le.date_license_issued,(SALT311.StrType)le.date_license_expires,(SALT311.StrType)le.date_of_last_change,(SALT311.StrType)le.type_of_last_change,(SALT311.StrType)le.latitude,(SALT311.StrType)le.longitude,(SALT311.StrType)le.transmitters_street,(SALT311.StrType)le.transmitters_city,(SALT311.StrType)le.transmitters_county,(SALT311.StrType)le.transmitters_state,(SALT311.StrType)le.transmitters_antenna_height,(SALT311.StrType)le.transmitters_height_above_avg_terra,(SALT311.StrType)le.transmitters_height_above_ground_le,(SALT311.StrType)le.power_of_this_frequency,(SALT311.StrType)le.frequency_mhz,(SALT311.StrType)le.class_of_station,(SALT311.StrType)le.number_of_units_authorized_on_freq,(SALT311.StrType)le.effective_radiated_power,(SALT311.StrType)le.emissions_codes,(SALT311.StrType)le.frequency_coordination_number,(SALT311.StrType)le.paging_license_status,(SALT311.StrType)le.control_point_for_the_system,(SALT311.StrType)le.pending_or_granted,(SALT311.StrType)le.contact_firms_street_address,(SALT311.StrType)le.contact_firms_city,(SALT311.StrType)le.contact_firms_state,(SALT311.StrType)le.contact_firms_zipcode,(SALT311.StrType)le.contact_firms_phone_number,(SALT311.StrType)le.contact_firms_fax_number,(SALT311.StrType)le.unique_key,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,41,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Input_Layout_FCC) prevDS = DATASET([], Input_Layout_FCC), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.license_type_CUSTOM_ErrorCount
          ,le.file_number_CUSTOM_ErrorCount
          ,le.radio_service_code_CUSTOM_ErrorCount
          ,le.licensees_name_CUSTOM_ErrorCount
          ,le.dba_name_CUSTOM_ErrorCount
          ,le.licensees_street_CUSTOM_ErrorCount
          ,le.licensees_city_CUSTOM_ErrorCount
          ,le.licensees_state_LENGTHS_ErrorCount
          ,le.licensees_zip_ALLOW_ErrorCount,le.licensees_zip_LENGTHS_ErrorCount
          ,le.licensees_phone_ALLOW_ErrorCount,le.licensees_phone_LENGTHS_ErrorCount
          ,le.date_application_received_at_fcc_CUSTOM_ErrorCount
          ,le.date_license_issued_CUSTOM_ErrorCount
          ,le.date_license_expires_CUSTOM_ErrorCount
          ,le.date_of_last_change_CUSTOM_ErrorCount
          ,le.type_of_last_change_CUSTOM_ErrorCount
          ,le.latitude_ALLOW_ErrorCount
          ,le.longitude_ALLOW_ErrorCount
          ,le.transmitters_street_CUSTOM_ErrorCount
          ,le.transmitters_city_CUSTOM_ErrorCount
          ,le.transmitters_county_CUSTOM_ErrorCount
          ,le.transmitters_state_LENGTHS_ErrorCount
          ,le.transmitters_antenna_height_ALLOW_ErrorCount
          ,le.transmitters_height_above_avg_terra_ALLOW_ErrorCount
          ,le.transmitters_height_above_ground_le_ALLOW_ErrorCount
          ,le.power_of_this_frequency_ALLOW_ErrorCount
          ,le.frequency_mhz_ALLOW_ErrorCount
          ,le.class_of_station_CUSTOM_ErrorCount
          ,le.number_of_units_authorized_on_freq_ALLOW_ErrorCount
          ,le.effective_radiated_power_ALLOW_ErrorCount
          ,le.emissions_codes_CUSTOM_ErrorCount
          ,le.frequency_coordination_number_CUSTOM_ErrorCount
          ,le.paging_license_status_CUSTOM_ErrorCount
          ,le.control_point_for_the_system_CUSTOM_ErrorCount
          ,le.pending_or_granted_CUSTOM_ErrorCount
          ,le.contact_firms_street_address_CUSTOM_ErrorCount
          ,le.contact_firms_city_CUSTOM_ErrorCount
          ,le.contact_firms_state_LENGTHS_ErrorCount
          ,le.contact_firms_zipcode_ALLOW_ErrorCount,le.contact_firms_zipcode_LENGTHS_ErrorCount
          ,le.contact_firms_phone_number_ALLOW_ErrorCount,le.contact_firms_phone_number_LENGTHS_ErrorCount
          ,le.contact_firms_fax_number_ALLOW_ErrorCount,le.contact_firms_fax_number_LENGTHS_ErrorCount
          ,le.unique_key_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.license_type_CUSTOM_ErrorCount
          ,le.file_number_CUSTOM_ErrorCount
          ,le.radio_service_code_CUSTOM_ErrorCount
          ,le.licensees_name_CUSTOM_ErrorCount
          ,le.dba_name_CUSTOM_ErrorCount
          ,le.licensees_street_CUSTOM_ErrorCount
          ,le.licensees_city_CUSTOM_ErrorCount
          ,le.licensees_state_LENGTHS_ErrorCount
          ,le.licensees_zip_ALLOW_ErrorCount,le.licensees_zip_LENGTHS_ErrorCount
          ,le.licensees_phone_ALLOW_ErrorCount,le.licensees_phone_LENGTHS_ErrorCount
          ,le.date_application_received_at_fcc_CUSTOM_ErrorCount
          ,le.date_license_issued_CUSTOM_ErrorCount
          ,le.date_license_expires_CUSTOM_ErrorCount
          ,le.date_of_last_change_CUSTOM_ErrorCount
          ,le.type_of_last_change_CUSTOM_ErrorCount
          ,le.latitude_ALLOW_ErrorCount
          ,le.longitude_ALLOW_ErrorCount
          ,le.transmitters_street_CUSTOM_ErrorCount
          ,le.transmitters_city_CUSTOM_ErrorCount
          ,le.transmitters_county_CUSTOM_ErrorCount
          ,le.transmitters_state_LENGTHS_ErrorCount
          ,le.transmitters_antenna_height_ALLOW_ErrorCount
          ,le.transmitters_height_above_avg_terra_ALLOW_ErrorCount
          ,le.transmitters_height_above_ground_le_ALLOW_ErrorCount
          ,le.power_of_this_frequency_ALLOW_ErrorCount
          ,le.frequency_mhz_ALLOW_ErrorCount
          ,le.class_of_station_CUSTOM_ErrorCount
          ,le.number_of_units_authorized_on_freq_ALLOW_ErrorCount
          ,le.effective_radiated_power_ALLOW_ErrorCount
          ,le.emissions_codes_CUSTOM_ErrorCount
          ,le.frequency_coordination_number_CUSTOM_ErrorCount
          ,le.paging_license_status_CUSTOM_ErrorCount
          ,le.control_point_for_the_system_CUSTOM_ErrorCount
          ,le.pending_or_granted_CUSTOM_ErrorCount
          ,le.contact_firms_street_address_CUSTOM_ErrorCount
          ,le.contact_firms_city_CUSTOM_ErrorCount
          ,le.contact_firms_state_LENGTHS_ErrorCount
          ,le.contact_firms_zipcode_ALLOW_ErrorCount,le.contact_firms_zipcode_LENGTHS_ErrorCount
          ,le.contact_firms_phone_number_ALLOW_ErrorCount,le.contact_firms_phone_number_LENGTHS_ErrorCount
          ,le.contact_firms_fax_number_ALLOW_ErrorCount,le.contact_firms_fax_number_LENGTHS_ErrorCount
          ,le.unique_key_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 7,Into(LEFT,COUNTER));
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
    mod_hygiene := Input_hygiene(PROJECT(h, Input_Layout_FCC));
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
          ,'license_type:' + getFieldTypeText(h.license_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'file_number:' + getFieldTypeText(h.file_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'callsign_of_license:' + getFieldTypeText(h.callsign_of_license) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'radio_service_code:' + getFieldTypeText(h.radio_service_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'licensees_name:' + getFieldTypeText(h.licensees_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'licensees_attention_line:' + getFieldTypeText(h.licensees_attention_line) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dba_name:' + getFieldTypeText(h.dba_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'licensees_street:' + getFieldTypeText(h.licensees_street) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'licensees_city:' + getFieldTypeText(h.licensees_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'licensees_state:' + getFieldTypeText(h.licensees_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'licensees_zip:' + getFieldTypeText(h.licensees_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'licensees_phone:' + getFieldTypeText(h.licensees_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_application_received_at_fcc:' + getFieldTypeText(h.date_application_received_at_fcc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_license_issued:' + getFieldTypeText(h.date_license_issued) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_license_expires:' + getFieldTypeText(h.date_license_expires) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_of_last_change:' + getFieldTypeText(h.date_of_last_change) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'type_of_last_change:' + getFieldTypeText(h.type_of_last_change) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'latitude:' + getFieldTypeText(h.latitude) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'longitude:' + getFieldTypeText(h.longitude) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transmitters_street:' + getFieldTypeText(h.transmitters_street) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transmitters_city:' + getFieldTypeText(h.transmitters_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transmitters_county:' + getFieldTypeText(h.transmitters_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transmitters_state:' + getFieldTypeText(h.transmitters_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transmitters_antenna_height:' + getFieldTypeText(h.transmitters_antenna_height) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transmitters_height_above_avg_terra:' + getFieldTypeText(h.transmitters_height_above_avg_terra) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transmitters_height_above_ground_le:' + getFieldTypeText(h.transmitters_height_above_ground_le) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'power_of_this_frequency:' + getFieldTypeText(h.power_of_this_frequency) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'frequency_mhz:' + getFieldTypeText(h.frequency_mhz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'class_of_station:' + getFieldTypeText(h.class_of_station) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'number_of_units_authorized_on_freq:' + getFieldTypeText(h.number_of_units_authorized_on_freq) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'effective_radiated_power:' + getFieldTypeText(h.effective_radiated_power) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'emissions_codes:' + getFieldTypeText(h.emissions_codes) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'frequency_coordination_number:' + getFieldTypeText(h.frequency_coordination_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'paging_license_status:' + getFieldTypeText(h.paging_license_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'control_point_for_the_system:' + getFieldTypeText(h.control_point_for_the_system) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pending_or_granted:' + getFieldTypeText(h.pending_or_granted) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'firm_preparing_application:' + getFieldTypeText(h.firm_preparing_application) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_firms_street_address:' + getFieldTypeText(h.contact_firms_street_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_firms_city:' + getFieldTypeText(h.contact_firms_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_firms_state:' + getFieldTypeText(h.contact_firms_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_firms_zipcode:' + getFieldTypeText(h.contact_firms_zipcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_firms_phone_number:' + getFieldTypeText(h.contact_firms_phone_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_firms_fax_number:' + getFieldTypeText(h.contact_firms_fax_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unique_key:' + getFieldTypeText(h.unique_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'crlf:' + getFieldTypeText(h.crlf) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_license_type_cnt
          ,le.populated_file_number_cnt
          ,le.populated_callsign_of_license_cnt
          ,le.populated_radio_service_code_cnt
          ,le.populated_licensees_name_cnt
          ,le.populated_licensees_attention_line_cnt
          ,le.populated_dba_name_cnt
          ,le.populated_licensees_street_cnt
          ,le.populated_licensees_city_cnt
          ,le.populated_licensees_state_cnt
          ,le.populated_licensees_zip_cnt
          ,le.populated_licensees_phone_cnt
          ,le.populated_date_application_received_at_fcc_cnt
          ,le.populated_date_license_issued_cnt
          ,le.populated_date_license_expires_cnt
          ,le.populated_date_of_last_change_cnt
          ,le.populated_type_of_last_change_cnt
          ,le.populated_latitude_cnt
          ,le.populated_longitude_cnt
          ,le.populated_transmitters_street_cnt
          ,le.populated_transmitters_city_cnt
          ,le.populated_transmitters_county_cnt
          ,le.populated_transmitters_state_cnt
          ,le.populated_transmitters_antenna_height_cnt
          ,le.populated_transmitters_height_above_avg_terra_cnt
          ,le.populated_transmitters_height_above_ground_le_cnt
          ,le.populated_power_of_this_frequency_cnt
          ,le.populated_frequency_mhz_cnt
          ,le.populated_class_of_station_cnt
          ,le.populated_number_of_units_authorized_on_freq_cnt
          ,le.populated_effective_radiated_power_cnt
          ,le.populated_emissions_codes_cnt
          ,le.populated_frequency_coordination_number_cnt
          ,le.populated_paging_license_status_cnt
          ,le.populated_control_point_for_the_system_cnt
          ,le.populated_pending_or_granted_cnt
          ,le.populated_firm_preparing_application_cnt
          ,le.populated_contact_firms_street_address_cnt
          ,le.populated_contact_firms_city_cnt
          ,le.populated_contact_firms_state_cnt
          ,le.populated_contact_firms_zipcode_cnt
          ,le.populated_contact_firms_phone_number_cnt
          ,le.populated_contact_firms_fax_number_cnt
          ,le.populated_unique_key_cnt
          ,le.populated_crlf_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_license_type_pcnt
          ,le.populated_file_number_pcnt
          ,le.populated_callsign_of_license_pcnt
          ,le.populated_radio_service_code_pcnt
          ,le.populated_licensees_name_pcnt
          ,le.populated_licensees_attention_line_pcnt
          ,le.populated_dba_name_pcnt
          ,le.populated_licensees_street_pcnt
          ,le.populated_licensees_city_pcnt
          ,le.populated_licensees_state_pcnt
          ,le.populated_licensees_zip_pcnt
          ,le.populated_licensees_phone_pcnt
          ,le.populated_date_application_received_at_fcc_pcnt
          ,le.populated_date_license_issued_pcnt
          ,le.populated_date_license_expires_pcnt
          ,le.populated_date_of_last_change_pcnt
          ,le.populated_type_of_last_change_pcnt
          ,le.populated_latitude_pcnt
          ,le.populated_longitude_pcnt
          ,le.populated_transmitters_street_pcnt
          ,le.populated_transmitters_city_pcnt
          ,le.populated_transmitters_county_pcnt
          ,le.populated_transmitters_state_pcnt
          ,le.populated_transmitters_antenna_height_pcnt
          ,le.populated_transmitters_height_above_avg_terra_pcnt
          ,le.populated_transmitters_height_above_ground_le_pcnt
          ,le.populated_power_of_this_frequency_pcnt
          ,le.populated_frequency_mhz_pcnt
          ,le.populated_class_of_station_pcnt
          ,le.populated_number_of_units_authorized_on_freq_pcnt
          ,le.populated_effective_radiated_power_pcnt
          ,le.populated_emissions_codes_pcnt
          ,le.populated_frequency_coordination_number_pcnt
          ,le.populated_paging_license_status_pcnt
          ,le.populated_control_point_for_the_system_pcnt
          ,le.populated_pending_or_granted_pcnt
          ,le.populated_firm_preparing_application_pcnt
          ,le.populated_contact_firms_street_address_pcnt
          ,le.populated_contact_firms_city_pcnt
          ,le.populated_contact_firms_state_pcnt
          ,le.populated_contact_firms_zipcode_pcnt
          ,le.populated_contact_firms_phone_number_pcnt
          ,le.populated_contact_firms_fax_number_pcnt
          ,le.populated_unique_key_pcnt
          ,le.populated_crlf_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,45,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Input_Delta(prevDS, PROJECT(h, Input_Layout_FCC));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),45,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Input_Layout_FCC) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_FCC, Input_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
