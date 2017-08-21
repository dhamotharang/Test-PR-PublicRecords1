IMPORT ut,SALT33;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT BaseFile_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(BaseFile_Layout_PhonesInfo)
    UNSIGNED1 source_Invalid;
    UNSIGNED1 dt_first_reported_Invalid;
    UNSIGNED1 dt_last_reported_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 phonetype_Invalid;
    UNSIGNED1 reply_code_Invalid;
    UNSIGNED1 local_routing_number_Invalid;
    UNSIGNED1 account_owner_Invalid;
    UNSIGNED1 carrier_name_Invalid;
    UNSIGNED1 carrier_category_Invalid;
    UNSIGNED1 local_area_transport_area_Invalid;
    UNSIGNED1 country_code_Invalid;
    UNSIGNED1 dial_type_Invalid;
    UNSIGNED1 routing_code_Invalid;
    UNSIGNED1 porting_dt_Invalid;
    UNSIGNED1 porting_time_Invalid;
    UNSIGNED1 country_abbr_Invalid;
    UNSIGNED1 vendor_first_reported_dt_Invalid;
    UNSIGNED1 vendor_first_reported_time_Invalid;
    UNSIGNED1 vendor_last_reported_dt_Invalid;
    UNSIGNED1 vendor_last_reported_time_Invalid;
    UNSIGNED1 port_start_dt_Invalid;
    UNSIGNED1 port_start_time_Invalid;
    UNSIGNED1 port_end_dt_Invalid;
    UNSIGNED1 port_end_time_Invalid;
    UNSIGNED1 remove_port_dt_Invalid;
    UNSIGNED1 serv_Invalid;
    UNSIGNED1 line_Invalid;
    UNSIGNED1 spid_Invalid;
    UNSIGNED1 operator_fullname_Invalid;
    UNSIGNED1 number_in_service_Invalid;
    UNSIGNED1 high_risk_indicator_Invalid;
    UNSIGNED1 prepaid_Invalid;
    UNSIGNED1 phone_swap_Invalid;
    UNSIGNED1 swap_start_dt_Invalid;
    UNSIGNED1 swap_start_time_Invalid;
    UNSIGNED1 swap_end_dt_Invalid;
    UNSIGNED1 swap_end_time_Invalid;
    UNSIGNED1 deact_code_Invalid;
    UNSIGNED1 deact_start_dt_Invalid;
    UNSIGNED1 deact_start_time_Invalid;
    UNSIGNED1 deact_end_dt_Invalid;
    UNSIGNED1 deact_end_time_Invalid;
    UNSIGNED1 react_start_dt_Invalid;
    UNSIGNED1 react_start_time_Invalid;
    UNSIGNED1 react_end_dt_Invalid;
    UNSIGNED1 react_end_time_Invalid;
    UNSIGNED1 is_deact_Invalid;
    UNSIGNED1 is_react_Invalid;
    UNSIGNED1 call_forward_dt_Invalid;
    UNSIGNED1 caller_id_Invalid;
    UNSIGNED1 subpoena_company_name_Invalid;
    UNSIGNED1 subpoena_contact_name_Invalid;
    UNSIGNED1 subpoena_carrier_address_Invalid;
    UNSIGNED1 subpoena_carrier_city_Invalid;
    UNSIGNED1 subpoena_carrier_state_Invalid;
    UNSIGNED1 subpoena_carrier_zip_Invalid;
    UNSIGNED1 subpoena_email_Invalid;
    UNSIGNED1 subpoena_contact_phone_Invalid;
    UNSIGNED1 subpoena_contact_fax_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(BaseFile_Layout_PhonesInfo)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(BaseFile_Layout_PhonesInfo) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.source_Invalid := BaseFile_Fields.InValid_source((SALT33.StrType)le.source);
    SELF.dt_first_reported_Invalid := BaseFile_Fields.InValid_dt_first_reported((SALT33.StrType)le.dt_first_reported);
    SELF.dt_last_reported_Invalid := BaseFile_Fields.InValid_dt_last_reported((SALT33.StrType)le.dt_last_reported);
    SELF.phone_Invalid := BaseFile_Fields.InValid_phone((SALT33.StrType)le.phone);
    SELF.phonetype_Invalid := BaseFile_Fields.InValid_phonetype((SALT33.StrType)le.phonetype);
    SELF.reply_code_Invalid := BaseFile_Fields.InValid_reply_code((SALT33.StrType)le.reply_code);
    SELF.local_routing_number_Invalid := BaseFile_Fields.InValid_local_routing_number((SALT33.StrType)le.local_routing_number);
    SELF.account_owner_Invalid := BaseFile_Fields.InValid_account_owner((SALT33.StrType)le.account_owner);
    SELF.carrier_name_Invalid := BaseFile_Fields.InValid_carrier_name((SALT33.StrType)le.carrier_name);
    SELF.carrier_category_Invalid := BaseFile_Fields.InValid_carrier_category((SALT33.StrType)le.carrier_category);
    SELF.local_area_transport_area_Invalid := BaseFile_Fields.InValid_local_area_transport_area((SALT33.StrType)le.local_area_transport_area);
    SELF.country_code_Invalid := BaseFile_Fields.InValid_country_code((SALT33.StrType)le.country_code);
    SELF.dial_type_Invalid := BaseFile_Fields.InValid_dial_type((SALT33.StrType)le.dial_type);
    SELF.routing_code_Invalid := BaseFile_Fields.InValid_routing_code((SALT33.StrType)le.routing_code);
    SELF.porting_dt_Invalid := BaseFile_Fields.InValid_porting_dt((SALT33.StrType)le.porting_dt);
    SELF.porting_time_Invalid := BaseFile_Fields.InValid_porting_time((SALT33.StrType)le.porting_time);
    SELF.country_abbr_Invalid := BaseFile_Fields.InValid_country_abbr((SALT33.StrType)le.country_abbr);
    SELF.vendor_first_reported_dt_Invalid := BaseFile_Fields.InValid_vendor_first_reported_dt((SALT33.StrType)le.vendor_first_reported_dt);
    SELF.vendor_first_reported_time_Invalid := BaseFile_Fields.InValid_vendor_first_reported_time((SALT33.StrType)le.vendor_first_reported_time);
    SELF.vendor_last_reported_dt_Invalid := BaseFile_Fields.InValid_vendor_last_reported_dt((SALT33.StrType)le.vendor_last_reported_dt);
    SELF.vendor_last_reported_time_Invalid := BaseFile_Fields.InValid_vendor_last_reported_time((SALT33.StrType)le.vendor_last_reported_time);
    SELF.port_start_dt_Invalid := BaseFile_Fields.InValid_port_start_dt((SALT33.StrType)le.port_start_dt);
    SELF.port_start_time_Invalid := BaseFile_Fields.InValid_port_start_time((SALT33.StrType)le.port_start_time);
    SELF.port_end_dt_Invalid := BaseFile_Fields.InValid_port_end_dt((SALT33.StrType)le.port_end_dt);
    SELF.port_end_time_Invalid := BaseFile_Fields.InValid_port_end_time((SALT33.StrType)le.port_end_time);
    SELF.remove_port_dt_Invalid := BaseFile_Fields.InValid_remove_port_dt((SALT33.StrType)le.remove_port_dt);
    SELF.serv_Invalid := BaseFile_Fields.InValid_serv((SALT33.StrType)le.serv);
    SELF.line_Invalid := BaseFile_Fields.InValid_line((SALT33.StrType)le.line);
    SELF.spid_Invalid := BaseFile_Fields.InValid_spid((SALT33.StrType)le.spid);
    SELF.operator_fullname_Invalid := BaseFile_Fields.InValid_operator_fullname((SALT33.StrType)le.operator_fullname);
    SELF.number_in_service_Invalid := BaseFile_Fields.InValid_number_in_service((SALT33.StrType)le.number_in_service);
    SELF.high_risk_indicator_Invalid := BaseFile_Fields.InValid_high_risk_indicator((SALT33.StrType)le.high_risk_indicator);
    SELF.prepaid_Invalid := BaseFile_Fields.InValid_prepaid((SALT33.StrType)le.prepaid);
    SELF.phone_swap_Invalid := BaseFile_Fields.InValid_phone_swap((SALT33.StrType)le.phone_swap);
    SELF.swap_start_dt_Invalid := BaseFile_Fields.InValid_swap_start_dt((SALT33.StrType)le.swap_start_dt);
    SELF.swap_start_time_Invalid := BaseFile_Fields.InValid_swap_start_time((SALT33.StrType)le.swap_start_time);
    SELF.swap_end_dt_Invalid := BaseFile_Fields.InValid_swap_end_dt((SALT33.StrType)le.swap_end_dt);
    SELF.swap_end_time_Invalid := BaseFile_Fields.InValid_swap_end_time((SALT33.StrType)le.swap_end_time);
    SELF.deact_code_Invalid := BaseFile_Fields.InValid_deact_code((SALT33.StrType)le.deact_code);
    SELF.deact_start_dt_Invalid := BaseFile_Fields.InValid_deact_start_dt((SALT33.StrType)le.deact_start_dt);
    SELF.deact_start_time_Invalid := BaseFile_Fields.InValid_deact_start_time((SALT33.StrType)le.deact_start_time);
    SELF.deact_end_dt_Invalid := BaseFile_Fields.InValid_deact_end_dt((SALT33.StrType)le.deact_end_dt);
    SELF.deact_end_time_Invalid := BaseFile_Fields.InValid_deact_end_time((SALT33.StrType)le.deact_end_time);
    SELF.react_start_dt_Invalid := BaseFile_Fields.InValid_react_start_dt((SALT33.StrType)le.react_start_dt);
    SELF.react_start_time_Invalid := BaseFile_Fields.InValid_react_start_time((SALT33.StrType)le.react_start_time);
    SELF.react_end_dt_Invalid := BaseFile_Fields.InValid_react_end_dt((SALT33.StrType)le.react_end_dt);
    SELF.react_end_time_Invalid := BaseFile_Fields.InValid_react_end_time((SALT33.StrType)le.react_end_time);
    SELF.is_deact_Invalid := BaseFile_Fields.InValid_is_deact((SALT33.StrType)le.is_deact);
    SELF.is_react_Invalid := BaseFile_Fields.InValid_is_react((SALT33.StrType)le.is_react);
    SELF.call_forward_dt_Invalid := BaseFile_Fields.InValid_call_forward_dt((SALT33.StrType)le.call_forward_dt);
    SELF.caller_id_Invalid := BaseFile_Fields.InValid_caller_id((SALT33.StrType)le.caller_id);
    SELF.subpoena_company_name_Invalid := BaseFile_Fields.InValid_subpoena_company_name((SALT33.StrType)le.subpoena_company_name);
    SELF.subpoena_contact_name_Invalid := BaseFile_Fields.InValid_subpoena_contact_name((SALT33.StrType)le.subpoena_contact_name);
    SELF.subpoena_carrier_address_Invalid := BaseFile_Fields.InValid_subpoena_carrier_address((SALT33.StrType)le.subpoena_carrier_address);
    SELF.subpoena_carrier_city_Invalid := BaseFile_Fields.InValid_subpoena_carrier_city((SALT33.StrType)le.subpoena_carrier_city);
    SELF.subpoena_carrier_state_Invalid := BaseFile_Fields.InValid_subpoena_carrier_state((SALT33.StrType)le.subpoena_carrier_state);
    SELF.subpoena_carrier_zip_Invalid := BaseFile_Fields.InValid_subpoena_carrier_zip((SALT33.StrType)le.subpoena_carrier_zip);
    SELF.subpoena_email_Invalid := BaseFile_Fields.InValid_subpoena_email((SALT33.StrType)le.subpoena_email);
    SELF.subpoena_contact_phone_Invalid := BaseFile_Fields.InValid_subpoena_contact_phone((SALT33.StrType)le.subpoena_contact_phone);
    SELF.subpoena_contact_fax_Invalid := BaseFile_Fields.InValid_subpoena_contact_fax((SALT33.StrType)le.subpoena_contact_fax);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),BaseFile_Layout_PhonesInfo);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.source_Invalid << 0 ) + ( le.dt_first_reported_Invalid << 2 ) + ( le.dt_last_reported_Invalid << 3 ) + ( le.phone_Invalid << 4 ) + ( le.phonetype_Invalid << 5 ) + ( le.reply_code_Invalid << 6 ) + ( le.local_routing_number_Invalid << 7 ) + ( le.account_owner_Invalid << 8 ) + ( le.carrier_name_Invalid << 9 ) + ( le.carrier_category_Invalid << 10 ) + ( le.local_area_transport_area_Invalid << 11 ) + ( le.country_code_Invalid << 12 ) + ( le.dial_type_Invalid << 13 ) + ( le.routing_code_Invalid << 14 ) + ( le.porting_dt_Invalid << 15 ) + ( le.porting_time_Invalid << 16 ) + ( le.country_abbr_Invalid << 17 ) + ( le.vendor_first_reported_dt_Invalid << 18 ) + ( le.vendor_first_reported_time_Invalid << 19 ) + ( le.vendor_last_reported_dt_Invalid << 20 ) + ( le.vendor_last_reported_time_Invalid << 21 ) + ( le.port_start_dt_Invalid << 22 ) + ( le.port_start_time_Invalid << 23 ) + ( le.port_end_dt_Invalid << 24 ) + ( le.port_end_time_Invalid << 25 ) + ( le.remove_port_dt_Invalid << 26 ) + ( le.serv_Invalid << 27 ) + ( le.line_Invalid << 28 ) + ( le.spid_Invalid << 29 ) + ( le.operator_fullname_Invalid << 30 ) + ( le.number_in_service_Invalid << 31 ) + ( le.high_risk_indicator_Invalid << 32 ) + ( le.prepaid_Invalid << 33 ) + ( le.phone_swap_Invalid << 34 ) + ( le.swap_start_dt_Invalid << 35 ) + ( le.swap_start_time_Invalid << 36 ) + ( le.swap_end_dt_Invalid << 37 ) + ( le.swap_end_time_Invalid << 38 ) + ( le.deact_code_Invalid << 39 ) + ( le.deact_start_dt_Invalid << 40 ) + ( le.deact_start_time_Invalid << 41 ) + ( le.deact_end_dt_Invalid << 42 ) + ( le.deact_end_time_Invalid << 43 ) + ( le.react_start_dt_Invalid << 44 ) + ( le.react_start_time_Invalid << 45 ) + ( le.react_end_dt_Invalid << 46 ) + ( le.react_end_time_Invalid << 47 ) + ( le.is_deact_Invalid << 48 ) + ( le.is_react_Invalid << 49 ) + ( le.call_forward_dt_Invalid << 50 ) + ( le.caller_id_Invalid << 51 ) + ( le.subpoena_company_name_Invalid << 52 ) + ( le.subpoena_contact_name_Invalid << 53 ) + ( le.subpoena_carrier_address_Invalid << 54 ) + ( le.subpoena_carrier_city_Invalid << 55 ) + ( le.subpoena_carrier_state_Invalid << 56 ) + ( le.subpoena_carrier_zip_Invalid << 57 ) + ( le.subpoena_email_Invalid << 58 ) + ( le.subpoena_contact_phone_Invalid << 59 ) + ( le.subpoena_contact_fax_Invalid << 60 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,BaseFile_Layout_PhonesInfo);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.source_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.dt_first_reported_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.dt_last_reported_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.phonetype_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.reply_code_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.local_routing_number_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.account_owner_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.carrier_name_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.carrier_category_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.local_area_transport_area_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.country_code_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.dial_type_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.routing_code_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.porting_dt_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.porting_time_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.country_abbr_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.vendor_first_reported_dt_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.vendor_first_reported_time_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.vendor_last_reported_dt_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.vendor_last_reported_time_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.port_start_dt_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.port_start_time_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.port_end_dt_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.port_end_time_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.remove_port_dt_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.serv_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.line_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.spid_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.operator_fullname_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.number_in_service_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.high_risk_indicator_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.prepaid_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.phone_swap_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.swap_start_dt_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.swap_start_time_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.swap_end_dt_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.swap_end_time_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.deact_code_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.deact_start_dt_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.deact_start_time_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.deact_end_dt_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.deact_end_time_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.react_start_dt_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.react_start_time_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.react_end_dt_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.react_end_time_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.is_deact_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.is_react_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.call_forward_dt_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.caller_id_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.subpoena_company_name_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.subpoena_contact_name_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.subpoena_carrier_address_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.subpoena_carrier_city_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.subpoena_carrier_state_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.subpoena_carrier_zip_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.subpoena_email_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.subpoena_contact_phone_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.subpoena_contact_fax_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    source_ENUM_ErrorCount := COUNT(GROUP,h.source_Invalid=1);
    source_LENGTH_ErrorCount := COUNT(GROUP,h.source_Invalid=2);
    source_Total_ErrorCount := COUNT(GROUP,h.source_Invalid>0);
    dt_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_reported_Invalid=1);
    dt_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_reported_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    phonetype_ENUM_ErrorCount := COUNT(GROUP,h.phonetype_Invalid=1);
    reply_code_ALLOW_ErrorCount := COUNT(GROUP,h.reply_code_Invalid=1);
    local_routing_number_ALLOW_ErrorCount := COUNT(GROUP,h.local_routing_number_Invalid=1);
    account_owner_ALLOW_ErrorCount := COUNT(GROUP,h.account_owner_Invalid=1);
    carrier_name_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_name_Invalid=1);
    carrier_category_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_category_Invalid=1);
    local_area_transport_area_ALLOW_ErrorCount := COUNT(GROUP,h.local_area_transport_area_Invalid=1);
    country_code_ALLOW_ErrorCount := COUNT(GROUP,h.country_code_Invalid=1);
    dial_type_ALLOW_ErrorCount := COUNT(GROUP,h.dial_type_Invalid=1);
    routing_code_ALLOW_ErrorCount := COUNT(GROUP,h.routing_code_Invalid=1);
    porting_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.porting_dt_Invalid=1);
    porting_time_ALLOW_ErrorCount := COUNT(GROUP,h.porting_time_Invalid=1);
    country_abbr_ALLOW_ErrorCount := COUNT(GROUP,h.country_abbr_Invalid=1);
    vendor_first_reported_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.vendor_first_reported_dt_Invalid=1);
    vendor_first_reported_time_ALLOW_ErrorCount := COUNT(GROUP,h.vendor_first_reported_time_Invalid=1);
    vendor_last_reported_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.vendor_last_reported_dt_Invalid=1);
    vendor_last_reported_time_ALLOW_ErrorCount := COUNT(GROUP,h.vendor_last_reported_time_Invalid=1);
    port_start_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.port_start_dt_Invalid=1);
    port_start_time_ALLOW_ErrorCount := COUNT(GROUP,h.port_start_time_Invalid=1);
    port_end_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.port_end_dt_Invalid=1);
    port_end_time_ALLOW_ErrorCount := COUNT(GROUP,h.port_end_time_Invalid=1);
    remove_port_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.remove_port_dt_Invalid=1);
    serv_ALLOW_ErrorCount := COUNT(GROUP,h.serv_Invalid=1);
    line_ALLOW_ErrorCount := COUNT(GROUP,h.line_Invalid=1);
    spid_ALLOW_ErrorCount := COUNT(GROUP,h.spid_Invalid=1);
    operator_fullname_ALLOW_ErrorCount := COUNT(GROUP,h.operator_fullname_Invalid=1);
    number_in_service_ALLOW_ErrorCount := COUNT(GROUP,h.number_in_service_Invalid=1);
    high_risk_indicator_ALLOW_ErrorCount := COUNT(GROUP,h.high_risk_indicator_Invalid=1);
    prepaid_ALLOW_ErrorCount := COUNT(GROUP,h.prepaid_Invalid=1);
    phone_swap_ALLOW_ErrorCount := COUNT(GROUP,h.phone_swap_Invalid=1);
    swap_start_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.swap_start_dt_Invalid=1);
    swap_start_time_ALLOW_ErrorCount := COUNT(GROUP,h.swap_start_time_Invalid=1);
    swap_end_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.swap_end_dt_Invalid=1);
    swap_end_time_ALLOW_ErrorCount := COUNT(GROUP,h.swap_end_time_Invalid=1);
    deact_code_ENUM_ErrorCount := COUNT(GROUP,h.deact_code_Invalid=1);
    deact_start_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.deact_start_dt_Invalid=1);
    deact_start_time_ALLOW_ErrorCount := COUNT(GROUP,h.deact_start_time_Invalid=1);
    deact_end_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.deact_end_dt_Invalid=1);
    deact_end_time_ALLOW_ErrorCount := COUNT(GROUP,h.deact_end_time_Invalid=1);
    react_start_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.react_start_dt_Invalid=1);
    react_start_time_ALLOW_ErrorCount := COUNT(GROUP,h.react_start_time_Invalid=1);
    react_end_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.react_end_dt_Invalid=1);
    react_end_time_ALLOW_ErrorCount := COUNT(GROUP,h.react_end_time_Invalid=1);
    is_deact_ALLOW_ErrorCount := COUNT(GROUP,h.is_deact_Invalid=1);
    is_react_ALLOW_ErrorCount := COUNT(GROUP,h.is_react_Invalid=1);
    call_forward_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.call_forward_dt_Invalid=1);
    caller_id_ALLOW_ErrorCount := COUNT(GROUP,h.caller_id_Invalid=1);
    subpoena_company_name_ALLOW_ErrorCount := COUNT(GROUP,h.subpoena_company_name_Invalid=1);
    subpoena_contact_name_ALLOW_ErrorCount := COUNT(GROUP,h.subpoena_contact_name_Invalid=1);
    subpoena_carrier_address_ALLOW_ErrorCount := COUNT(GROUP,h.subpoena_carrier_address_Invalid=1);
    subpoena_carrier_city_ALLOW_ErrorCount := COUNT(GROUP,h.subpoena_carrier_city_Invalid=1);
    subpoena_carrier_state_ALLOW_ErrorCount := COUNT(GROUP,h.subpoena_carrier_state_Invalid=1);
    subpoena_carrier_zip_ALLOW_ErrorCount := COUNT(GROUP,h.subpoena_carrier_zip_Invalid=1);
    subpoena_email_ALLOW_ErrorCount := COUNT(GROUP,h.subpoena_email_Invalid=1);
    subpoena_contact_phone_ALLOW_ErrorCount := COUNT(GROUP,h.subpoena_contact_phone_Invalid=1);
    subpoena_contact_fax_ALLOW_ErrorCount := COUNT(GROUP,h.subpoena_contact_fax_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT33.StrType ErrorMessage;
    SALT33.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.source_Invalid,le.dt_first_reported_Invalid,le.dt_last_reported_Invalid,le.phone_Invalid,le.phonetype_Invalid,le.reply_code_Invalid,le.local_routing_number_Invalid,le.account_owner_Invalid,le.carrier_name_Invalid,le.carrier_category_Invalid,le.local_area_transport_area_Invalid,le.country_code_Invalid,le.dial_type_Invalid,le.routing_code_Invalid,le.porting_dt_Invalid,le.porting_time_Invalid,le.country_abbr_Invalid,le.vendor_first_reported_dt_Invalid,le.vendor_first_reported_time_Invalid,le.vendor_last_reported_dt_Invalid,le.vendor_last_reported_time_Invalid,le.port_start_dt_Invalid,le.port_start_time_Invalid,le.port_end_dt_Invalid,le.port_end_time_Invalid,le.remove_port_dt_Invalid,le.serv_Invalid,le.line_Invalid,le.spid_Invalid,le.operator_fullname_Invalid,le.number_in_service_Invalid,le.high_risk_indicator_Invalid,le.prepaid_Invalid,le.phone_swap_Invalid,le.swap_start_dt_Invalid,le.swap_start_time_Invalid,le.swap_end_dt_Invalid,le.swap_end_time_Invalid,le.deact_code_Invalid,le.deact_start_dt_Invalid,le.deact_start_time_Invalid,le.deact_end_dt_Invalid,le.deact_end_time_Invalid,le.react_start_dt_Invalid,le.react_start_time_Invalid,le.react_end_dt_Invalid,le.react_end_time_Invalid,le.is_deact_Invalid,le.is_react_Invalid,le.call_forward_dt_Invalid,le.caller_id_Invalid,le.subpoena_company_name_Invalid,le.subpoena_contact_name_Invalid,le.subpoena_carrier_address_Invalid,le.subpoena_carrier_city_Invalid,le.subpoena_carrier_state_Invalid,le.subpoena_carrier_zip_Invalid,le.subpoena_email_Invalid,le.subpoena_contact_phone_Invalid,le.subpoena_contact_fax_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,BaseFile_Fields.InvalidMessage_source(le.source_Invalid),BaseFile_Fields.InvalidMessage_dt_first_reported(le.dt_first_reported_Invalid),BaseFile_Fields.InvalidMessage_dt_last_reported(le.dt_last_reported_Invalid),BaseFile_Fields.InvalidMessage_phone(le.phone_Invalid),BaseFile_Fields.InvalidMessage_phonetype(le.phonetype_Invalid),BaseFile_Fields.InvalidMessage_reply_code(le.reply_code_Invalid),BaseFile_Fields.InvalidMessage_local_routing_number(le.local_routing_number_Invalid),BaseFile_Fields.InvalidMessage_account_owner(le.account_owner_Invalid),BaseFile_Fields.InvalidMessage_carrier_name(le.carrier_name_Invalid),BaseFile_Fields.InvalidMessage_carrier_category(le.carrier_category_Invalid),BaseFile_Fields.InvalidMessage_local_area_transport_area(le.local_area_transport_area_Invalid),BaseFile_Fields.InvalidMessage_country_code(le.country_code_Invalid),BaseFile_Fields.InvalidMessage_dial_type(le.dial_type_Invalid),BaseFile_Fields.InvalidMessage_routing_code(le.routing_code_Invalid),BaseFile_Fields.InvalidMessage_porting_dt(le.porting_dt_Invalid),BaseFile_Fields.InvalidMessage_porting_time(le.porting_time_Invalid),BaseFile_Fields.InvalidMessage_country_abbr(le.country_abbr_Invalid),BaseFile_Fields.InvalidMessage_vendor_first_reported_dt(le.vendor_first_reported_dt_Invalid),BaseFile_Fields.InvalidMessage_vendor_first_reported_time(le.vendor_first_reported_time_Invalid),BaseFile_Fields.InvalidMessage_vendor_last_reported_dt(le.vendor_last_reported_dt_Invalid),BaseFile_Fields.InvalidMessage_vendor_last_reported_time(le.vendor_last_reported_time_Invalid),BaseFile_Fields.InvalidMessage_port_start_dt(le.port_start_dt_Invalid),BaseFile_Fields.InvalidMessage_port_start_time(le.port_start_time_Invalid),BaseFile_Fields.InvalidMessage_port_end_dt(le.port_end_dt_Invalid),BaseFile_Fields.InvalidMessage_port_end_time(le.port_end_time_Invalid),BaseFile_Fields.InvalidMessage_remove_port_dt(le.remove_port_dt_Invalid),BaseFile_Fields.InvalidMessage_serv(le.serv_Invalid),BaseFile_Fields.InvalidMessage_line(le.line_Invalid),BaseFile_Fields.InvalidMessage_spid(le.spid_Invalid),BaseFile_Fields.InvalidMessage_operator_fullname(le.operator_fullname_Invalid),BaseFile_Fields.InvalidMessage_number_in_service(le.number_in_service_Invalid),BaseFile_Fields.InvalidMessage_high_risk_indicator(le.high_risk_indicator_Invalid),BaseFile_Fields.InvalidMessage_prepaid(le.prepaid_Invalid),BaseFile_Fields.InvalidMessage_phone_swap(le.phone_swap_Invalid),BaseFile_Fields.InvalidMessage_swap_start_dt(le.swap_start_dt_Invalid),BaseFile_Fields.InvalidMessage_swap_start_time(le.swap_start_time_Invalid),BaseFile_Fields.InvalidMessage_swap_end_dt(le.swap_end_dt_Invalid),BaseFile_Fields.InvalidMessage_swap_end_time(le.swap_end_time_Invalid),BaseFile_Fields.InvalidMessage_deact_code(le.deact_code_Invalid),BaseFile_Fields.InvalidMessage_deact_start_dt(le.deact_start_dt_Invalid),BaseFile_Fields.InvalidMessage_deact_start_time(le.deact_start_time_Invalid),BaseFile_Fields.InvalidMessage_deact_end_dt(le.deact_end_dt_Invalid),BaseFile_Fields.InvalidMessage_deact_end_time(le.deact_end_time_Invalid),BaseFile_Fields.InvalidMessage_react_start_dt(le.react_start_dt_Invalid),BaseFile_Fields.InvalidMessage_react_start_time(le.react_start_time_Invalid),BaseFile_Fields.InvalidMessage_react_end_dt(le.react_end_dt_Invalid),BaseFile_Fields.InvalidMessage_react_end_time(le.react_end_time_Invalid),BaseFile_Fields.InvalidMessage_is_deact(le.is_deact_Invalid),BaseFile_Fields.InvalidMessage_is_react(le.is_react_Invalid),BaseFile_Fields.InvalidMessage_call_forward_dt(le.call_forward_dt_Invalid),BaseFile_Fields.InvalidMessage_caller_id(le.caller_id_Invalid),BaseFile_Fields.InvalidMessage_subpoena_company_name(le.subpoena_company_name_Invalid),BaseFile_Fields.InvalidMessage_subpoena_contact_name(le.subpoena_contact_name_Invalid),BaseFile_Fields.InvalidMessage_subpoena_carrier_address(le.subpoena_carrier_address_Invalid),BaseFile_Fields.InvalidMessage_subpoena_carrier_city(le.subpoena_carrier_city_Invalid),BaseFile_Fields.InvalidMessage_subpoena_carrier_state(le.subpoena_carrier_state_Invalid),BaseFile_Fields.InvalidMessage_subpoena_carrier_zip(le.subpoena_carrier_zip_Invalid),BaseFile_Fields.InvalidMessage_subpoena_email(le.subpoena_email_Invalid),BaseFile_Fields.InvalidMessage_subpoena_contact_phone(le.subpoena_contact_phone_Invalid),BaseFile_Fields.InvalidMessage_subpoena_contact_fax(le.subpoena_contact_fax_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.source_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.dt_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phonetype_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.reply_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.local_routing_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.account_owner_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.carrier_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.carrier_category_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.local_area_transport_area_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.country_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dial_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.routing_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.porting_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.porting_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.country_abbr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vendor_first_reported_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.vendor_first_reported_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vendor_last_reported_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.vendor_last_reported_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.port_start_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.port_start_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.port_end_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.port_end_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.remove_port_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.serv_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.line_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.operator_fullname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.number_in_service_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.high_risk_indicator_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prepaid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_swap_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.swap_start_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.swap_start_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.swap_end_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.swap_end_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.deact_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.deact_start_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.deact_start_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.deact_end_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.deact_end_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.react_start_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.react_start_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.react_end_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.react_end_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.is_deact_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.is_react_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.call_forward_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.caller_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subpoena_company_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subpoena_contact_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subpoena_carrier_address_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subpoena_carrier_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subpoena_carrier_state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subpoena_carrier_zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subpoena_email_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subpoena_contact_phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subpoena_contact_fax_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'source','dt_first_reported','dt_last_reported','phone','phonetype','reply_code','local_routing_number','account_owner','carrier_name','carrier_category','local_area_transport_area','country_code','dial_type','routing_code','porting_dt','porting_time','country_abbr','vendor_first_reported_dt','vendor_first_reported_time','vendor_last_reported_dt','vendor_last_reported_time','port_start_dt','port_start_time','port_end_dt','port_end_time','remove_port_dt','serv','line','spid','operator_fullname','number_in_service','high_risk_indicator','prepaid','phone_swap','swap_start_dt','swap_start_time','swap_end_dt','swap_end_time','deact_code','deact_start_dt','deact_start_time','deact_end_dt','deact_end_time','react_start_dt','react_start_time','react_end_dt','react_end_time','is_deact','is_react','call_forward_dt','caller_id','subpoena_company_name','subpoena_contact_name','subpoena_carrier_address','subpoena_carrier_city','subpoena_carrier_state','subpoena_carrier_zip','subpoena_email','subpoena_contact_phone','subpoena_contact_fax','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Source','Invalid_Date','Invalid_Date','Invalid_Phone','Invalid_Phone_Type','Invalid_Num','Invalid_Num','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Num','Invalid_Num','Invalid_Dial_Type','Invalid_Num','Invalid_Date','Invalid_Num','Invalid_ISO2','Invalid_Date','Invalid_Num','Invalid_Date','Invalid_Num','Invalid_Date','Invalid_Num','Invalid_Future_Date','Invalid_Num','Invalid_Future_Date','Invalid_Zero_Three','Invalid_Zero_Three','Invalid_Num','Invalid_Char','Invalid_Num_In_Service','Invalid_YN','Invalid_YN','Invalid_Num','Invalid_Date','Invalid_Num','Invalid_Future_Date','Invalid_Num','Invalid_Deact','Invalid_Date','Invalid_Num','Invalid_Future_Date','Invalid_Num','Invalid_Date','Invalid_Num','Invalid_Future_Date','Invalid_Num','Invalid_YN','Invalid_YN','Invalid_Date','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_State','Invalid_Num_Blank','Invalid_Char','Invalid_Phone','Invalid_Phone','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.source,(SALT33.StrType)le.dt_first_reported,(SALT33.StrType)le.dt_last_reported,(SALT33.StrType)le.phone,(SALT33.StrType)le.phonetype,(SALT33.StrType)le.reply_code,(SALT33.StrType)le.local_routing_number,(SALT33.StrType)le.account_owner,(SALT33.StrType)le.carrier_name,(SALT33.StrType)le.carrier_category,(SALT33.StrType)le.local_area_transport_area,(SALT33.StrType)le.country_code,(SALT33.StrType)le.dial_type,(SALT33.StrType)le.routing_code,(SALT33.StrType)le.porting_dt,(SALT33.StrType)le.porting_time,(SALT33.StrType)le.country_abbr,(SALT33.StrType)le.vendor_first_reported_dt,(SALT33.StrType)le.vendor_first_reported_time,(SALT33.StrType)le.vendor_last_reported_dt,(SALT33.StrType)le.vendor_last_reported_time,(SALT33.StrType)le.port_start_dt,(SALT33.StrType)le.port_start_time,(SALT33.StrType)le.port_end_dt,(SALT33.StrType)le.port_end_time,(SALT33.StrType)le.remove_port_dt,(SALT33.StrType)le.serv,(SALT33.StrType)le.line,(SALT33.StrType)le.spid,(SALT33.StrType)le.operator_fullname,(SALT33.StrType)le.number_in_service,(SALT33.StrType)le.high_risk_indicator,(SALT33.StrType)le.prepaid,(SALT33.StrType)le.phone_swap,(SALT33.StrType)le.swap_start_dt,(SALT33.StrType)le.swap_start_time,(SALT33.StrType)le.swap_end_dt,(SALT33.StrType)le.swap_end_time,(SALT33.StrType)le.deact_code,(SALT33.StrType)le.deact_start_dt,(SALT33.StrType)le.deact_start_time,(SALT33.StrType)le.deact_end_dt,(SALT33.StrType)le.deact_end_time,(SALT33.StrType)le.react_start_dt,(SALT33.StrType)le.react_start_time,(SALT33.StrType)le.react_end_dt,(SALT33.StrType)le.react_end_time,(SALT33.StrType)le.is_deact,(SALT33.StrType)le.is_react,(SALT33.StrType)le.call_forward_dt,(SALT33.StrType)le.caller_id,(SALT33.StrType)le.subpoena_company_name,(SALT33.StrType)le.subpoena_contact_name,(SALT33.StrType)le.subpoena_carrier_address,(SALT33.StrType)le.subpoena_carrier_city,(SALT33.StrType)le.subpoena_carrier_state,(SALT33.StrType)le.subpoena_carrier_zip,(SALT33.StrType)le.subpoena_email,(SALT33.StrType)le.subpoena_contact_phone,(SALT33.StrType)le.subpoena_contact_fax,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,60,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'source:Invalid_Source:ENUM','source:Invalid_Source:LENGTH'
          ,'dt_first_reported:Invalid_Date:CUSTOM'
          ,'dt_last_reported:Invalid_Date:CUSTOM'
          ,'phone:Invalid_Phone:ALLOW'
          ,'phonetype:Invalid_Phone_Type:ENUM'
          ,'reply_code:Invalid_Num:ALLOW'
          ,'local_routing_number:Invalid_Num:ALLOW'
          ,'account_owner:Invalid_Char:ALLOW'
          ,'carrier_name:Invalid_Char:ALLOW'
          ,'carrier_category:Invalid_Char:ALLOW'
          ,'local_area_transport_area:Invalid_Num:ALLOW'
          ,'country_code:Invalid_Num:ALLOW'
          ,'dial_type:Invalid_Dial_Type:ALLOW'
          ,'routing_code:Invalid_Num:ALLOW'
          ,'porting_dt:Invalid_Date:CUSTOM'
          ,'porting_time:Invalid_Num:ALLOW'
          ,'country_abbr:Invalid_ISO2:ALLOW'
          ,'vendor_first_reported_dt:Invalid_Date:CUSTOM'
          ,'vendor_first_reported_time:Invalid_Num:ALLOW'
          ,'vendor_last_reported_dt:Invalid_Date:CUSTOM'
          ,'vendor_last_reported_time:Invalid_Num:ALLOW'
          ,'port_start_dt:Invalid_Date:CUSTOM'
          ,'port_start_time:Invalid_Num:ALLOW'
          ,'port_end_dt:Invalid_Future_Date:CUSTOM'
          ,'port_end_time:Invalid_Num:ALLOW'
          ,'remove_port_dt:Invalid_Future_Date:CUSTOM'
          ,'serv:Invalid_Zero_Three:ALLOW'
          ,'line:Invalid_Zero_Three:ALLOW'
          ,'spid:Invalid_Num:ALLOW'
          ,'operator_fullname:Invalid_Char:ALLOW'
          ,'number_in_service:Invalid_Num_In_Service:ALLOW'
          ,'high_risk_indicator:Invalid_YN:ALLOW'
          ,'prepaid:Invalid_YN:ALLOW'
          ,'phone_swap:Invalid_Num:ALLOW'
          ,'swap_start_dt:Invalid_Date:CUSTOM'
          ,'swap_start_time:Invalid_Num:ALLOW'
          ,'swap_end_dt:Invalid_Future_Date:CUSTOM'
          ,'swap_end_time:Invalid_Num:ALLOW'
          ,'deact_code:Invalid_Deact:ENUM'
          ,'deact_start_dt:Invalid_Date:CUSTOM'
          ,'deact_start_time:Invalid_Num:ALLOW'
          ,'deact_end_dt:Invalid_Future_Date:CUSTOM'
          ,'deact_end_time:Invalid_Num:ALLOW'
          ,'react_start_dt:Invalid_Date:CUSTOM'
          ,'react_start_time:Invalid_Num:ALLOW'
          ,'react_end_dt:Invalid_Future_Date:CUSTOM'
          ,'react_end_time:Invalid_Num:ALLOW'
          ,'is_deact:Invalid_YN:ALLOW'
          ,'is_react:Invalid_YN:ALLOW'
          ,'call_forward_dt:Invalid_Date:CUSTOM'
          ,'caller_id:Invalid_Char:ALLOW'
          ,'subpoena_company_name:Invalid_Char:ALLOW'
          ,'subpoena_contact_name:Invalid_Char:ALLOW'
          ,'subpoena_carrier_address:Invalid_Char:ALLOW'
          ,'subpoena_carrier_city:Invalid_Char:ALLOW'
          ,'subpoena_carrier_state:Invalid_State:ALLOW'
          ,'subpoena_carrier_zip:Invalid_Num_Blank:ALLOW'
          ,'subpoena_email:Invalid_Char:ALLOW'
          ,'subpoena_contact_phone:Invalid_Phone:ALLOW'
          ,'subpoena_contact_fax:Invalid_Phone:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,BaseFile_Fields.InvalidMessage_source(1),BaseFile_Fields.InvalidMessage_source(2)
          ,BaseFile_Fields.InvalidMessage_dt_first_reported(1)
          ,BaseFile_Fields.InvalidMessage_dt_last_reported(1)
          ,BaseFile_Fields.InvalidMessage_phone(1)
          ,BaseFile_Fields.InvalidMessage_phonetype(1)
          ,BaseFile_Fields.InvalidMessage_reply_code(1)
          ,BaseFile_Fields.InvalidMessage_local_routing_number(1)
          ,BaseFile_Fields.InvalidMessage_account_owner(1)
          ,BaseFile_Fields.InvalidMessage_carrier_name(1)
          ,BaseFile_Fields.InvalidMessage_carrier_category(1)
          ,BaseFile_Fields.InvalidMessage_local_area_transport_area(1)
          ,BaseFile_Fields.InvalidMessage_country_code(1)
          ,BaseFile_Fields.InvalidMessage_dial_type(1)
          ,BaseFile_Fields.InvalidMessage_routing_code(1)
          ,BaseFile_Fields.InvalidMessage_porting_dt(1)
          ,BaseFile_Fields.InvalidMessage_porting_time(1)
          ,BaseFile_Fields.InvalidMessage_country_abbr(1)
          ,BaseFile_Fields.InvalidMessage_vendor_first_reported_dt(1)
          ,BaseFile_Fields.InvalidMessage_vendor_first_reported_time(1)
          ,BaseFile_Fields.InvalidMessage_vendor_last_reported_dt(1)
          ,BaseFile_Fields.InvalidMessage_vendor_last_reported_time(1)
          ,BaseFile_Fields.InvalidMessage_port_start_dt(1)
          ,BaseFile_Fields.InvalidMessage_port_start_time(1)
          ,BaseFile_Fields.InvalidMessage_port_end_dt(1)
          ,BaseFile_Fields.InvalidMessage_port_end_time(1)
          ,BaseFile_Fields.InvalidMessage_remove_port_dt(1)
          ,BaseFile_Fields.InvalidMessage_serv(1)
          ,BaseFile_Fields.InvalidMessage_line(1)
          ,BaseFile_Fields.InvalidMessage_spid(1)
          ,BaseFile_Fields.InvalidMessage_operator_fullname(1)
          ,BaseFile_Fields.InvalidMessage_number_in_service(1)
          ,BaseFile_Fields.InvalidMessage_high_risk_indicator(1)
          ,BaseFile_Fields.InvalidMessage_prepaid(1)
          ,BaseFile_Fields.InvalidMessage_phone_swap(1)
          ,BaseFile_Fields.InvalidMessage_swap_start_dt(1)
          ,BaseFile_Fields.InvalidMessage_swap_start_time(1)
          ,BaseFile_Fields.InvalidMessage_swap_end_dt(1)
          ,BaseFile_Fields.InvalidMessage_swap_end_time(1)
          ,BaseFile_Fields.InvalidMessage_deact_code(1)
          ,BaseFile_Fields.InvalidMessage_deact_start_dt(1)
          ,BaseFile_Fields.InvalidMessage_deact_start_time(1)
          ,BaseFile_Fields.InvalidMessage_deact_end_dt(1)
          ,BaseFile_Fields.InvalidMessage_deact_end_time(1)
          ,BaseFile_Fields.InvalidMessage_react_start_dt(1)
          ,BaseFile_Fields.InvalidMessage_react_start_time(1)
          ,BaseFile_Fields.InvalidMessage_react_end_dt(1)
          ,BaseFile_Fields.InvalidMessage_react_end_time(1)
          ,BaseFile_Fields.InvalidMessage_is_deact(1)
          ,BaseFile_Fields.InvalidMessage_is_react(1)
          ,BaseFile_Fields.InvalidMessage_call_forward_dt(1)
          ,BaseFile_Fields.InvalidMessage_caller_id(1)
          ,BaseFile_Fields.InvalidMessage_subpoena_company_name(1)
          ,BaseFile_Fields.InvalidMessage_subpoena_contact_name(1)
          ,BaseFile_Fields.InvalidMessage_subpoena_carrier_address(1)
          ,BaseFile_Fields.InvalidMessage_subpoena_carrier_city(1)
          ,BaseFile_Fields.InvalidMessage_subpoena_carrier_state(1)
          ,BaseFile_Fields.InvalidMessage_subpoena_carrier_zip(1)
          ,BaseFile_Fields.InvalidMessage_subpoena_email(1)
          ,BaseFile_Fields.InvalidMessage_subpoena_contact_phone(1)
          ,BaseFile_Fields.InvalidMessage_subpoena_contact_fax(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.source_ENUM_ErrorCount,le.source_LENGTH_ErrorCount
          ,le.dt_first_reported_CUSTOM_ErrorCount
          ,le.dt_last_reported_CUSTOM_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.phonetype_ENUM_ErrorCount
          ,le.reply_code_ALLOW_ErrorCount
          ,le.local_routing_number_ALLOW_ErrorCount
          ,le.account_owner_ALLOW_ErrorCount
          ,le.carrier_name_ALLOW_ErrorCount
          ,le.carrier_category_ALLOW_ErrorCount
          ,le.local_area_transport_area_ALLOW_ErrorCount
          ,le.country_code_ALLOW_ErrorCount
          ,le.dial_type_ALLOW_ErrorCount
          ,le.routing_code_ALLOW_ErrorCount
          ,le.porting_dt_CUSTOM_ErrorCount
          ,le.porting_time_ALLOW_ErrorCount
          ,le.country_abbr_ALLOW_ErrorCount
          ,le.vendor_first_reported_dt_CUSTOM_ErrorCount
          ,le.vendor_first_reported_time_ALLOW_ErrorCount
          ,le.vendor_last_reported_dt_CUSTOM_ErrorCount
          ,le.vendor_last_reported_time_ALLOW_ErrorCount
          ,le.port_start_dt_CUSTOM_ErrorCount
          ,le.port_start_time_ALLOW_ErrorCount
          ,le.port_end_dt_CUSTOM_ErrorCount
          ,le.port_end_time_ALLOW_ErrorCount
          ,le.remove_port_dt_CUSTOM_ErrorCount
          ,le.serv_ALLOW_ErrorCount
          ,le.line_ALLOW_ErrorCount
          ,le.spid_ALLOW_ErrorCount
          ,le.operator_fullname_ALLOW_ErrorCount
          ,le.number_in_service_ALLOW_ErrorCount
          ,le.high_risk_indicator_ALLOW_ErrorCount
          ,le.prepaid_ALLOW_ErrorCount
          ,le.phone_swap_ALLOW_ErrorCount
          ,le.swap_start_dt_CUSTOM_ErrorCount
          ,le.swap_start_time_ALLOW_ErrorCount
          ,le.swap_end_dt_CUSTOM_ErrorCount
          ,le.swap_end_time_ALLOW_ErrorCount
          ,le.deact_code_ENUM_ErrorCount
          ,le.deact_start_dt_CUSTOM_ErrorCount
          ,le.deact_start_time_ALLOW_ErrorCount
          ,le.deact_end_dt_CUSTOM_ErrorCount
          ,le.deact_end_time_ALLOW_ErrorCount
          ,le.react_start_dt_CUSTOM_ErrorCount
          ,le.react_start_time_ALLOW_ErrorCount
          ,le.react_end_dt_CUSTOM_ErrorCount
          ,le.react_end_time_ALLOW_ErrorCount
          ,le.is_deact_ALLOW_ErrorCount
          ,le.is_react_ALLOW_ErrorCount
          ,le.call_forward_dt_CUSTOM_ErrorCount
          ,le.caller_id_ALLOW_ErrorCount
          ,le.subpoena_company_name_ALLOW_ErrorCount
          ,le.subpoena_contact_name_ALLOW_ErrorCount
          ,le.subpoena_carrier_address_ALLOW_ErrorCount
          ,le.subpoena_carrier_city_ALLOW_ErrorCount
          ,le.subpoena_carrier_state_ALLOW_ErrorCount
          ,le.subpoena_carrier_zip_ALLOW_ErrorCount
          ,le.subpoena_email_ALLOW_ErrorCount
          ,le.subpoena_contact_phone_ALLOW_ErrorCount
          ,le.subpoena_contact_fax_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.source_ENUM_ErrorCount,le.source_LENGTH_ErrorCount
          ,le.dt_first_reported_CUSTOM_ErrorCount
          ,le.dt_last_reported_CUSTOM_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.phonetype_ENUM_ErrorCount
          ,le.reply_code_ALLOW_ErrorCount
          ,le.local_routing_number_ALLOW_ErrorCount
          ,le.account_owner_ALLOW_ErrorCount
          ,le.carrier_name_ALLOW_ErrorCount
          ,le.carrier_category_ALLOW_ErrorCount
          ,le.local_area_transport_area_ALLOW_ErrorCount
          ,le.country_code_ALLOW_ErrorCount
          ,le.dial_type_ALLOW_ErrorCount
          ,le.routing_code_ALLOW_ErrorCount
          ,le.porting_dt_CUSTOM_ErrorCount
          ,le.porting_time_ALLOW_ErrorCount
          ,le.country_abbr_ALLOW_ErrorCount
          ,le.vendor_first_reported_dt_CUSTOM_ErrorCount
          ,le.vendor_first_reported_time_ALLOW_ErrorCount
          ,le.vendor_last_reported_dt_CUSTOM_ErrorCount
          ,le.vendor_last_reported_time_ALLOW_ErrorCount
          ,le.port_start_dt_CUSTOM_ErrorCount
          ,le.port_start_time_ALLOW_ErrorCount
          ,le.port_end_dt_CUSTOM_ErrorCount
          ,le.port_end_time_ALLOW_ErrorCount
          ,le.remove_port_dt_CUSTOM_ErrorCount
          ,le.serv_ALLOW_ErrorCount
          ,le.line_ALLOW_ErrorCount
          ,le.spid_ALLOW_ErrorCount
          ,le.operator_fullname_ALLOW_ErrorCount
          ,le.number_in_service_ALLOW_ErrorCount
          ,le.high_risk_indicator_ALLOW_ErrorCount
          ,le.prepaid_ALLOW_ErrorCount
          ,le.phone_swap_ALLOW_ErrorCount
          ,le.swap_start_dt_CUSTOM_ErrorCount
          ,le.swap_start_time_ALLOW_ErrorCount
          ,le.swap_end_dt_CUSTOM_ErrorCount
          ,le.swap_end_time_ALLOW_ErrorCount
          ,le.deact_code_ENUM_ErrorCount
          ,le.deact_start_dt_CUSTOM_ErrorCount
          ,le.deact_start_time_ALLOW_ErrorCount
          ,le.deact_end_dt_CUSTOM_ErrorCount
          ,le.deact_end_time_ALLOW_ErrorCount
          ,le.react_start_dt_CUSTOM_ErrorCount
          ,le.react_start_time_ALLOW_ErrorCount
          ,le.react_end_dt_CUSTOM_ErrorCount
          ,le.react_end_time_ALLOW_ErrorCount
          ,le.is_deact_ALLOW_ErrorCount
          ,le.is_react_ALLOW_ErrorCount
          ,le.call_forward_dt_CUSTOM_ErrorCount
          ,le.caller_id_ALLOW_ErrorCount
          ,le.subpoena_company_name_ALLOW_ErrorCount
          ,le.subpoena_contact_name_ALLOW_ErrorCount
          ,le.subpoena_carrier_address_ALLOW_ErrorCount
          ,le.subpoena_carrier_city_ALLOW_ErrorCount
          ,le.subpoena_carrier_state_ALLOW_ErrorCount
          ,le.subpoena_carrier_zip_ALLOW_ErrorCount
          ,le.subpoena_email_ALLOW_ErrorCount
          ,le.subpoena_contact_phone_ALLOW_ErrorCount
          ,le.subpoena_contact_fax_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,61,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT33.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT33.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
