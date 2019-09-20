EXPORT layouts := module

EXPORT BuildVersionRecord := RECORD
    string   DateTimeStamp;
    string   VersionNumber;
    boolean  UseProd;
    boolean  IsFullbuild;
    string   LatestRowDateTime;
    string   LatestRowRecID;
END;

export raw := record
    string200 provenance;
    string date_time;
    string org_id;
    string event_id;
    string api_type;
    string event_type;
    string policy_score;
    string reason_code;
    string request_id;
    string request_result;
    string review_status;
    string risk_rating;
    string service_type;
    string browser_language;
    string browser_string_hash;
    string browser_string;
    string css_file_loaded;
    string css_image_loaded;
    string detected_fl;
    string device_activities;
    string device_assert_history;
    string device_attributes;
    string device_first_seen;
    string device_id;
    string device_last_assertion;
    string device_last_event;
    string device_last_update;
    string device_match_result;
    string device_result;
    string device_score;
    string device_worst_score;
    string enabled_ck;
    string enabled_fl;
    string enabled_im;
    string enabled_js;
    string first_party_cookie;
    string flash_anomaly;
    string flash_guid;
    string flash_lang;
    string flash_os;
    string flash_system_state;
    string flash_tcp_tstmp_rate;
    string flash_tstmp_measure_time;
    string flash_version;
    string headers_name_value_hash;
    string headers_order_string_hash;
    string http_os_signature;
    string http_os_sig_raw;
    string http_referer;
    string https_proxy_flag;
    string image_anomaly;
    string image_loaded;
    string local_time_offset;
    string local_time_offset_range;
    string os_anomaly;
    string os;
    string os_fonts_hash;
    string os_fonts_number;
    string plugin_adobe_acrobat;
    string plugin_flash;
    string plugin_hash;
    string plugin_realplayer;
    string plugin_shockwave;
    string plugin_silverlight;
    string plugin_windows_media_player;
    string profiling_datetime;
    string screen_res;
    string session_anomaly;
    string session_id;
    string silverlight_guid;
    string system_state;
    string tcp_os_signature;
    string tcp_os_sig_raw;
    string tcp_tstmp_rate;
    string third_party_cookie;
    string time_zone;
    string transaction_id;
    string tstmp_measure_time;
    string local_attrib_1;
    string local_attrib_2;
    string local_attrib_3;
    string local_attrib_4;
    string local_attrib_5;
    string custom_match_1;
    string custom_match_2;
    string custom_match_3;
    string custom_match_4;
    string custom_match_5;
    string custom_match_6;
    string custom_match_7;
    string custom_match_8;
    string ua_agent;
    string ua_browser;
    string ua_mobile;
    string ua_os;
    string ua_platform;
    string ua_proxy;
    string offset_measure_time;
    string screen_res_anomaly;
    string screen_aspect_ratio_anomaly;
    string time_zone_dst_offset;
    string timezone_offset_anomaly;
    string request_duration;
    string profile_api_timedelta;
    string url_anomaly;
    string browser_language_anomaly;
    string browser_string_mismatch;
    string browser_string_anomaly;
    string js_browser_string;
    string mime_type_hash;
    string mime_type_number;
    string plugin_number;
    string plugin_quicktime;
    string plugin_java;
    string plugin_vlc_player;
    string plugin_devalvr;
    string plugin_svg_viewer;
    string multiple_session_id;
    string device_id_reason_code;
    string unknown_session;
    string localstorage_guid;
    string fuzzy_device_id;
    string fuzzy_device_id_confidence;
    string fuzzy_device_match_result;
    string fuzzy_device_activities;
    string fuzzy_device_assert_history;
    string fuzzy_device_attributes;
    string fuzzy_device_last_update;
    string fuzzy_device_last_assertion;
    string fuzzy_device_last_event;
    string fuzzy_device_first_seen;
    string fuzzy_device_result;
    string fuzzy_device_score;
    string fuzzy_device_worst_score;
    string custom_count_1;
    string custom_count_2;
    string custom_count_3;
    string custom_count_4;
    string input_ip_address;
    string tps_result;
    string tps_error;
    string tps_vendor_error;
    string tps_vendor_result;
    string tps_was_timeout;
    string policy;
    string error_detail;
    string cidr_number;
    string true_ip_activities;
    string true_ip_assert_history;
    string true_ip_attributes;
    string true_ip_city;
    string true_ip_first_seen;
    string true_ip_geo;
    string true_ip;
    string true_ip_isp;
    string true_ip_last_assertion;
    string true_ip_last_event;
    string true_ip_last_update;
    string true_ip_latitude;
    string true_ip_longitude;
    string true_ip_organization;
    string true_ip_region;
    string true_ip_result;
    string true_ip_score;
    string true_ip_worst_score;
    string proxy_ip_activities;
    string proxy_ip_assert_history;
    string proxy_ip_attributes;
    string proxy_ip_city;
    string proxy_ip_first_seen;
    string proxy_ip_geo;
    string proxy_ip;
    string proxy_ip_isp;
    string proxy_ip_last_assertion;
    string proxy_ip_last_event;
    string proxy_ip_last_update;
    string proxy_ip_latitude;
    string proxy_ip_longitude;
    string proxy_ip_organization;
    string proxy_ip_region;
    string proxy_ip_result;
    string proxy_ip_score;
    string proxy_ip_worst_score;
    string proxy_type;
    string proxy_name;
    string account_name_activities;
    string account_name_assert_history;
    string account_name_attributes;
    string account_name;
    string account_name_first_seen;
    string account_name_last_assertion;
    string account_name_last_event;
    string account_name_last_update;
    string account_name_result;
    string account_name_score;
    string account_name_worst_score;
    string account_login_activities;
    string account_login_assert_history;
    string account_login_attributes;
    string account_login;
    string account_login_first_seen;
    string account_login_last_assertion;
    string account_login_last_event;
    string account_login_last_update;
    string account_login_result;
    string account_login_score;
    string account_login_worst_score;
    string password_hash_activities;
    string password_hash_assert_history;
    string password_hash_attributes;
    string password_hash;
    string password_hash_first_seen;
    string password_hash_last_assertion;
    string password_hash_last_event;
    string password_hash_last_update;
    string password_hash_result;
    string password_hash_score;
    string password_hash_worst_score;
    string account_number_activities;
    string account_number_assert_history;
    string account_number_attributes;
    string account_number;
    string account_number_first_seen;
    string account_number_last_assertion;
    string account_number_last_event;
    string account_number_last_update;
    string account_number_result;
    string account_number_score;
    string account_number_worst_score;
    string online_id_handle;
    string online_tld;
    string drivers_licence_number_hash;
    string ssn_hash;
    string online_id;
    string online_id_activities;
    string online_id_assert_history;
    string online_id_attributes;
    string online_id_first_seen;
    string online_id_last_assertion;
    string online_id_last_event;
    string online_id_last_update;
    string online_id_result;
    string online_id_score;
    string online_id_worst_score;
    string drivers_licence_hash_activities;
    string drivers_licence_hash_assert_history;
    string drivers_licence_hash_attributes;
    string drivers_licence_hash_first_seen;
    string drivers_licence_hash_last_assertion;
    string drivers_licence_hash_last_event;
    string drivers_licence_hash_last_update;
    string drivers_licence_hash_result;
    string drivers_licence_hash_score;
    string drivers_licence_hash_worst_score;
    string ssn_hash_activities;
    string ssn_hash_assert_history;
    string ssn_hash_attributes;
    string ssn_hash_first_seen;
    string ssn_hash_last_assertion;
    string ssn_hash_last_event;
    string ssn_hash_last_update;
    string ssn_hash_result;
    string ssn_hash_score;
    string ssn_hash_worst_score;
    string account_email_activities;
    string account_email_assert_history;
    string account_email_attributes;
    string account_email;
    string account_email_first_seen;
    string account_email_last_assertion;
    string account_email_last_event;
    string account_email_last_update;
    string account_email_result;
    string account_email_score;
    string account_email_worst_score;
    string account_address_activities;
    string account_address_assert_history;
    string account_address_attributes;
    string account_address_city;
    string account_address_country;
    string account_address_first_seen;
    string account_address_last_assertion;
    string account_address_last_event;
    string account_address_last_update;
    string account_address_result;
    string account_address_score;
    string account_address_state;
    string account_address_street1;
    string account_address_street2;
    string account_address_worst_score;
    string account_address_zip;
    string account_telephone_activities;
    string account_telephone_assert_history;
    string account_telephone_attributes;
    string account_telephone;
    string account_telephone_first_seen;
    string account_telephone_last_assertion;
    string account_telephone_last_event;
    string account_telephone_last_update;
    string account_telephone_result;
    string account_telephone_score;
    string account_telephone_worst_score;
    string shipping_address_activities;
    string shipping_address_assert_history;
    string shipping_address_attributes;
    string shipping_address_city;
    string shipping_address_country;
    string shipping_address_first_seen;
    string shipping_address_last_assertion;
    string shipping_address_last_event;
    string shipping_address_last_update;
    string shipping_address_result;
    string shipping_address_score;
    string shipping_address_state;
    string shipping_address_street1;
    string shipping_address_street2;
    string shipping_address_worst_score;
    string shipping_address_zip;
    string cc_bin_number;
    string cc_number_hash_activities;
    string cc_number_hash_assert_history;
    string cc_number_hash_attributes;
    string cc_number_hash;
    string cc_number_hash_first_seen;
    string cc_number_hash_last_assertion;
    string cc_number_hash_last_event;
    string cc_number_hash_last_update;
    string cc_number_hash_result;
    string cc_number_hash_score;
    string cc_number_hash_worst_score;
    string ach_account_hash;
    string ach_routing_number;
    string payment_gateway_provider;
    string payment_request_type;
    string payment_response_code;
    string payment_response;
    string processing_provider;
    string settlement_amount;
    string settlement_currency;
    string transaction_amount;
    string transaction_auth_amount;
    string transaction_auth_currency;
    string transaction_currency;
    string transaction_shipping_amount;
    string transaction_shipping_currency;
    string ach_number;
    string ach_number_activities;
    string ach_number_assert_history;
    string ach_number_attributes;
    string ach_number_first_seen;
    string ach_number_last_assertion;
    string ach_number_last_event;
    string ach_number_last_update;
    string ach_number_result;
    string ach_number_score;
    string ach_number_worst_score;
    string cc_bin_number_geo;
    string encrypted_data_blob;
    string import_id;
    string device_fingerprint;
    string device_fingerprint_activities;
    string device_fingerprint_assert_history;
    string device_fingerprint_attributes;
    string device_fingerprint_first_seen;
    string device_fingerprint_last_assertion;
    string device_fingerprint_last_event;
    string device_fingerprint_last_update;
    string device_fingerprint_result;
    string device_fingerprint_score;
    string device_fingerprint_worst_score;
    string page_fingerprint;
    string page_fingerprint_activities;
    string page_fingerprint_assert_history;
    string page_fingerprint_attributes;
    string page_fingerprint_first_seen;
    string page_fingerprint_last_assertion;
    string page_fingerprint_last_event;
    string page_fingerprint_last_update;
    string page_fingerprint_result;
    string page_fingerprint_score;
    string page_fingerprint_worst_score;
    string page_fingerprint_check;
    string page_summary;
    string unknown_page_diff;
    string page_id;
    string enabled_services;
    string page_fingerprint_diff;
    string tcp_os_sig_adv_mss;
    string tcp_os_sig_snd_mss;
    string tcp_os_sig_rcv_mss;
    string http_os_sig_adv_mss;
    string http_os_sig_snd_mss;
    string http_os_sig_rcv_mss;
    string tcp_os_sig_ttl;
    string http_os_sig_ttl;
    string profiling_delta;
    string profiling_site_id;
    string http_referer_domain;
    string profiled_domain;
    string http_referer_url;
    string profiled_url;
    string condition_attrib_1;
    string condition_attrib_2;
    string condition_attrib_3;
    string condition_attrib_4;
    string condition_attrib_5;
    string condition_attrib_6;
    string condition_attrib_7;
    string condition_attrib_8;
    string condition_attrib_9;
    string condition_attrib_10;
    string condition_attrib_11;
    string condition_attrib_12;
    string condition_attrib_13;
    string condition_attrib_14;
    string condition_attrib_15;
    string condition_attrib_16;
    string condition_attrib_17;
    string condition_attrib_18;
    string unencrypted_condition_attrib_1;
    string unencrypted_condition_attrib_2;
    string tmx_reason_code;
    string related_device_id;
    string related_request_id;
    string related_custom_id;
    string tcp_connection_type;
    string http_connection_type;
    string profile_arf_millisec;
    string page_time_on;
    string screen_res_alt;
    string page_fingerprint_match;
    string honeypot_fingerprint_check;
    string honeypot_fingerprint_diff;
    string honeypot_fingerprint;
    string honeypot_unknown_diff;
    string honeypot_fingerprint_match;
    string js_fonts_hash;
    string js_fonts_number;
    string summary_reason_code;
    string tmx_policy_score;
    string tmx_review_status;
    string tmx_risk_rating;
    string tmx_summary_reason_code;
    string custom_mobile_1;
    string custom_mobile_2;
    string custom_mobile_3;
    string custom_mobile_4;
    string custom_mobile_5;
    string agent_device_id;
    string agent_device_state;
    string hw_latitude;
    string hw_longitude;
    string hw_gps_accuracy;
    string experiment_1;
    string experiment_2;
    string experiment_3;
    string experiment_4;
    string experiment_5;
    string agent_type;
    string agent_version;
    string dns_ip;
    string dns_ip_city;
    string dns_ip_geo;
    string dns_ip_isp;
    string dns_ip_latitude;
    string dns_ip_longitude;
    string dns_ip_organization;
    string dns_ip_region;
    string cc_bin_number_type;
    string cc_bin_number_brand;
    string cc_bin_number_category;
    string cc_bin_number_org;
    string screen_color_depth;
    string local_attrib_6;
    string local_attrib_7;
    string local_attrib_8;
    string local_attrib_9;
    string local_attrib_10;
    string js_fonts_list;
    string etag_guid;
    string agent_session_id;
    string agent_event_time;
    string agent_os;
    string fw_name;
    string av_name;
    string os_daysupdated;
    string browser_process;
    string browser_version;
    string hdd_encryption_name;
    string pwd_policy_min_length;
    string pwd_policy_auto_lock_minutes;
    string agent_health_details;
    string jb_root;
    string jb_root_reason;
    string fw_status;
    string av_enabled;
    string av_uptodate;
    string os_update_strategy;
    string hdd_encryption_status;
    string pwd_policy_enabled;
    string pwd_policy_complexity;
    string pwd_policy_max_days;
    string pwd_policy_min_days;
    string pwd_policy_auto_logon;
    string agent_health_status;
    string custom_output_1;
    string custom_output_2;
    string custom_output_3;
    string custom_output_4;
    string custom_output_5;
    string custom_output_6;
    string custom_output_7;
    string custom_output_8;
    string custom_output_9;
    string custom_output_10;
    string input_ip_activities;
    string input_ip_assert_history;
    string input_ip_attributes;
    string input_ip_city;
    string input_ip_first_seen;
    string input_ip_geo;
    string input_ip_isp;
    string input_ip_last_assertion;
    string input_ip_last_event;
    string input_ip_last_update;
    string input_ip_latitude;
    string input_ip_longitude;
    string input_ip_organization;
    string input_ip_region;
    string input_ip_result;
    string input_ip_score;
    string input_ip_worst_score;
    string profile_org_id;
    string agent_os_version;
    string agent_language;
    string agent_locale;
    string agent_brand;
    string agent_model;
    string apprep_selfhash;
    string apprep_selfhash_category;
    string apprep_installedapps;
    string apprep_runningapps;
    string apprep_installed_unknown;
    string apprep_running_unknown;
    string apprep_installed_malicious;
    string apprep_running_malicious;
    string apprep_installed_unwanted;
    string apprep_running_unwanted;
    string apprep_installed_suspicious;
    string apprep_running_suspicious;
    string apprep_installed_moderate;
    string apprep_running_moderate;
    string apprep_installed_benign;
    string apprep_running_benign;
    string action;
    string experiment_mobile_1;
    string experiment_mobile_2;
    string experiment_mobile_3;
    string experiment_mobile_4;
    string experiment_mobile_5;
    string experiment_mobile_6;
    string experiment_mobile_7;
    string experiment_mobile_8;
    string experiment_mobile_9;
    string experiment_mobile_10;
    string agent_image_creation;
    string agent_app_links;
    string agent_free_space;
    string agent_name;
    string agent_app_info;
    string agent_bssid;
    string agent_ssid;
    string agent_boot_time;
    string agent_connection_type;
    string tmx_variables;
    string api_site_id;
    string remote_desktop;
    string true_ip_organization_type;
    string true_ip_postal_code;
    string true_ip_routing_type;
    string true_ip_country_code;
    string true_ip_connection_type;
    string true_ip_home;
    string true_ip_hosting_facility;
    string true_ip_line_speed;
    string proxy_ip_organization_type;
    string proxy_ip_postal_code;
    string proxy_ip_routing_type;
    string proxy_ip_country_code;
    string proxy_ip_connection_type;
    string proxy_ip_home;
    string proxy_ip_hosting_facility;
    string proxy_ip_line_speed;
    string dns_ip_organization_type;
    string dns_ip_postal_code;
    string dns_ip_routing_type;
    string dns_ip_country_code;
    string dns_ip_connection_type;
    string dns_ip_home;
    string dns_ip_hosting_facility;
    string dns_ip_line_speed;
    string input_ip_organization_type;
    string input_ip_postal_code;
    string input_ip_routing_type;
    string input_ip_country_code;
    string input_ip_connection_type;
    string input_ip_home;
    string input_ip_hosting_facility;
    string input_ip_line_speed;
    string agent_total_space;
    string agent_signal_strength;
    string agent_wps_accuracy;
    string page_fingerprint_hooks;
    string honeypot_fingerprint_hooks;
    string carrier_id;
    string carrier_id_activities;
    string carrier_id_assert_history;
    string carrier_id_attributes;
    string carrier_id_first_seen;
    string carrier_id_last_assertion;
    string carrier_id_last_event;
    string carrier_id_last_update;
    string carrier_id_result;
    string carrier_id_score;
    string carrier_id_worst_score;
    string tmx_raw_score;
    string tmx_fraud_rating;
    string tmx_p_score;
    string session_id_query_count;
    string input_latitude;
    string input_longitude;
    string tmx_risk_rank;
    string cba_score;
    string policy_version;
    string agent_profiling_delta;
    string js_os;
    string js_browser;
    string js_browser_string_hash;
    string browser;
    string os_version;
    string browser_anomaly;
    string agent_wps_latitude;
    string agent_wps_longitude;
    string agent_cell_id;
    string true_ip_region_iso_code;
    string proxy_ip_region_iso_code;
    string dns_ip_region_iso_code;
    string input_ip_region_iso_code;
    string fuzzy_device_id_reason_code;
    string additional_data;
    string event_tag;
    string agent_publickey_hash;
    string agent_publickey_hash_type;
    string input_request_id;
    string tmx_internal_variables;
    string apiversion;
    string segment_name;
    string html_location_latitude;
    string html_location_longitude;
    string html_location_accuracy;
    string html_location_altitude;
    string html_location_heading;
    string webrtc_external_ip;
    string webrtc_internal_ip;
    string webrtc_ipv6;
    string agent_publickey_hash_activities;
    string agent_publickey_hash_assert_history;
    string agent_publickey_hash_attributes;
    string agent_publickey_hash_first_seen;
    string agent_publickey_hash_last_assertion;
    string agent_publickey_hash_last_event;
    string agent_publickey_hash_last_update;
    string agent_publickey_hash_result;
    string agent_publickey_hash_score;
    string agent_publickey_hash_worst_score;
    string smart_learning_policy_score;
    string smart_learning_risk_rank;
    string smart_learning_fraud_rating;
    string smart_learning_p_score;
    string smart_learning_variables;
    string smart_learning_reason_code;
    string smart_learning_summary_reason_code;
    string yyyymm;
    string carrier_name;
    string carrier_mobile_number;
    string carrier_mobile_number_activities;
    string carrier_mobile_number_assert_history;
    string carrier_mobile_number_attributes;
    string carrier_mobile_number_first_seen;
    string carrier_mobile_number_last_assertion;
    string carrier_mobile_number_last_event;
    string carrier_mobile_number_last_update;
    string carrier_mobile_number_result;
    string carrier_mobile_number_score;
    string carrier_mobile_number_worst_score;
    string carrier_mobile_number_match_result;
    string carrier_account;
    string carrier_account_activities;
    string carrier_account_assert_history;
    string carrier_account_attributes;
    string carrier_account_first_seen;
    string carrier_account_last_assertion;
    string carrier_account_last_event;
    string carrier_account_last_update;
    string carrier_account_result;
    string carrier_account_score;
    string carrier_account_worst_score;
    string carrier_account_match_result;
    string experiment_6;
    string experiment_7;
    string experiment_8;
    string experiment_9;
    string experiment_10;
    string account_email_domain;
    string private_browsing;
    string policy_site_id;
    string account_first_name;
    string account_last_name;
    string agent_device_caps;
    string virtual_machine;
    string virtual_machine_reason;
    string customer_event_type;
    string application_name;
    string line_of_business;
    string local_attrib_11;
    string local_attrib_12;
    string local_attrib_13;
    string local_attrib_14;
    string local_attrib_15;
    string account_date_of_birth;
    string digital_id;
    string digital_id_confidence;
    string digital_id_reason_code;
    string digital_id_activities;
    string digital_id_attributes;
    string digital_id_first_seen;
    string digital_id_last_event;
    string digital_id_last_update;
    string digital_id_result;
    string digital_id_score;
    string test_digital_id;
    string test_digital_id_confidence;
    string test_digital_id_reason_code;
    string test_digital_id_activities;
    string test_digital_id_attributes;
    string test_digital_id_first_seen;
    string test_digital_id_last_event;
    string test_digital_id_last_update;
    string test_digital_id_result;
    string test_digital_id_score;
    string account_address_zip_latitude;
    string account_address_zip_longitude;
    string shipping_address_zip_latitude;
    string shipping_address_zip_longitude;
    string carrier_id_token;
    string webgl_hash;
    string canvas_hash;
    string targeted_malware;
    string local_ipv4;
    string local_ipv6;
    string mac_address;
    string flash_version_detected;
    string page_fingerprint_diff_names;
    string honeypot_fingerprint_diff_names;
    string advertising_id;
    string device_imei;
    string account_home_phone;
    string account_work_phone;
    string external_device_info;
    string account_address_zip_normalized;
    string shipping_address_zip_normalized;
    string selinux_status;
    string app_integrity_score;
    string custom_count_5;
    string custom_count_6;
    string custom_count_7;
    string custom_count_8;
    string custom_count_9;
    string custom_count_10;
    string custom_count_11;
    string custom_count_12;
    string custom_count_13;
    string custom_count_14;
    string custom_count_15;
    string custom_output_11;
    string custom_output_12;
    string custom_output_13;
    string custom_output_14;
    string custom_output_15;
    string custom_output_16;
    string custom_output_17;
    string custom_output_18;
    string custom_output_19;
    string custom_output_20;
    string ua_os_alt;
    string ua_os_version_alt;
    string ua_browser_alt;
    string ua_browser_version_alt;
    string virtual_device;
    string virtual_device_reason;
    string dns_ip_assert_history;
    string dns_ip_attributes;
    string dns_ip_activities;
    string primary_industry;
    string secondary_industry;
    string ship_address_is_bill_address;
    string merchant_category_code;
    string merchant_country_code;
    string merchant_name;
    string merchant_id;
    string auth_methods;
    string device_health_reasons;
    string local_attrib_1_activities;
    string local_attrib_2_activities;
    string local_attrib_3_activities;
    string local_attrib_4_activities;
    string local_attrib_5_activities;
    string local_attrib_6_activities;
    string local_attrib_7_activities;
    string local_attrib_8_activities;
    string local_attrib_9_activities;
    string local_attrib_10_activities;
    string local_attrib_11_activities;
    string local_attrib_12_activities;
    string local_attrib_13_activities;
    string local_attrib_14_activities;
    string local_attrib_15_activities;
    string local_attrib_1_first_seen;
    string local_attrib_2_first_seen;
    string local_attrib_3_first_seen;
    string local_attrib_4_first_seen;
    string local_attrib_5_first_seen;
    string local_attrib_6_first_seen;
    string local_attrib_7_first_seen;
    string local_attrib_8_first_seen;
    string local_attrib_9_first_seen;
    string local_attrib_10_first_seen;
    string local_attrib_11_first_seen;
    string local_attrib_12_first_seen;
    string local_attrib_13_first_seen;
    string local_attrib_14_first_seen;
    string local_attrib_15_first_seen;
    string experiment_mobile_array;
    string experiment_array;
    string web_session_id;
    string web_session_id_activities;
    string web_session_id_attributes;
    string web_session_id_first_seen;
    string web_session_id_last_event;
    string web_session_id_last_update;
    string web_session_id_result;
    string web_session_id_score;
    string wurfl_info;
    string collected_ip_addresses;
    string exact_id_health;
    string use_test_apn;
    string challenger_policy;
    string challenger_policy_score;
    string challenger_reason_code;
    string challenger_risk_rating;
    string challenger_summary_reason_code;
    string challenger_review_status;
    string digital_id_confidence_rating;
    string digital_id_trust_score_reason_code;
    string digital_id_trust_score_summary_reason_code;
    string digital_id_trust_score;
    string digital_id_trust_score_rating;
    string digital_id_trust_score_variables;
    string rules;
    string external_guid;
    string global_third_party_cookie;
    string national_id_type;
    string national_id_number;
    string threeds_comp_ind;
    string targeted_storage;
    string turn_os_sig_raw;
    string turn_os_sig_ttl;
    string turn_os_signature;
    string turn_system_state;
    string turn_tcp_tstmp_rate;
    string org_group_id;
    string ssl_fp_client;
    string ssl_fp_category;
    string digital_id_summary_reason_code;
end;

export strings:=record
    string25 provenance;
    raw - [provenance];
end;

// PREVIOUSLY export prepped:=record //KJE - per Danny reviewed 12/11, should be BASE
export base := record
    string25 provenance
    ,string23 date_time
    ,string8 org_id
    ,string11 event_id
    ,string206 api_type// {blob,maxlength(206)}
    ,string376 event_type// {blob,maxlength(376)}
    ,integer2 policy_score
    ,string reason_code {blob,maxlength(12059)}
    ,string32 request_id
    ,string40 request_result
    ,string15 review_status
    ,string15 risk_rating
    ,string service_type {blob,maxlength(281)}
    ,string browser_language {blob,maxlength(281)}
    ,string35 browser_string_hash
    ,string browser_string {blob,maxlength(285)}
    ,boolean css_file_loaded
    ,boolean css_image_loaded
    ,boolean detected_fl
    ,string device_activities {blob,maxlength(318)}
    ,string52 device_assert_history
    ,string device_attributes {blob,maxlength(347)}
    ,string10 device_first_seen
    ,string32 device_id
    ,string10 device_last_assertion
    ,string10 device_last_event
    ,string10 device_last_update
    ,string20 device_match_result
    ,string10 device_result
    ,integer2 device_score
    ,integer2 device_worst_score
    ,boolean enabled_ck
    ,boolean enabled_fl
    ,boolean enabled_im
    ,boolean enabled_js
    ,string first_party_cookie {blob,maxlength(281)}
    ,boolean flash_anomaly
    ,string35 flash_guid
    ,string flash_lang {blob,maxlength(164)}
    ,string flash_os {blob,maxlength(281)}
    ,integer4 flash_system_state
    ,integer4 flash_tcp_tstmp_rate
    ,integer4 flash_tstmp_measure_time
    ,string54 flash_version
    ,string35 headers_name_value_hash
    ,string35 headers_order_string_hash
    ,string35 http_os_signature
    ,string http_os_sig_raw {blob,maxlength(217)}
    ,string35 http_referer
    ,integer4 https_proxy_flag
    ,boolean image_anomaly
    ,boolean image_loaded
    ,real4 local_time_offset
    ,real4 local_time_offset_range
    ,boolean os_anomaly
    ,string15 os
    ,string44 os_fonts_hash
    ,integer4 os_fonts_number
    ,string17 plugin_adobe_acrobat
    ,string19 plugin_flash
    ,string35 plugin_hash
    ,string17 plugin_realplayer
    ,string17 plugin_shockwave
    ,string12 plugin_silverlight
    ,string24 plugin_windows_media_player
    ,string10 profiling_datetime
    ,string13 screen_res
    ,boolean session_anomaly
    ,string session_id {blob,maxlength(936)}
    ,string35 silverlight_guid
    ,integer4 system_state
    ,string34 tcp_os_signature
    ,string tcp_os_sig_raw {blob,maxlength(217)}
    ,integer4 tcp_tstmp_rate
    ,string35 third_party_cookie
    ,integer4 time_zone
    ,string transaction_id {blob,maxlength(541)}
    ,integer4 tstmp_measure_time
    ,string35 local_attrib_1
    ,string35 local_attrib_2
    ,string35 local_attrib_3
    ,string35 local_attrib_4
    ,string35 local_attrib_5
    ,string35 custom_match_1
    ,string35 custom_match_2
    ,string35 custom_match_3
    ,string35 custom_match_4
    ,string35 custom_match_5
    ,string35 custom_match_6
    ,string35 custom_match_7
    ,string35 custom_match_8
    ,string ua_agent
    ,string44 ua_browser
    ,boolean ua_mobile
    ,string62 ua_os
    ,string54 ua_platform
    ,boolean ua_proxy
    ,unsigned8 offset_measure_time
    ,boolean screen_res_anomaly
    ,boolean screen_aspect_ratio_anomaly
    ,integer4 time_zone_dst_offset
    ,boolean timezone_offset_anomaly
    ,integer4 request_duration
    ,integer4 profile_api_timedelta
    ,boolean url_anomaly
    ,boolean browser_language_anomaly
    ,boolean browser_string_mismatch
    ,boolean browser_string_anomaly
    ,string js_browser_string {blob,maxlength(842)}
    ,string35 mime_type_hash
    ,integer4 mime_type_number
    ,integer4 plugin_number
    ,string17 plugin_quicktime
    ,string17 plugin_java
    ,string17 plugin_vlc_player
    ,string17 plugin_devalvr
    ,string17 plugin_svg_viewer
    ,boolean multiple_session_id
    ,string19 device_id_reason_code
    ,boolean unknown_session
    ,string35 localstorage_guid
    ,string32 fuzzy_device_id
    ,real4 fuzzy_device_id_confidence
    ,string11 fuzzy_device_match_result
    ,string fuzzy_device_activities {blob,maxlength(300)}
    ,string20 fuzzy_device_assert_history
    ,string fuzzy_device_attributes {blob,maxlength(300)}
    ,string10 fuzzy_device_last_update
    ,string10 fuzzy_device_last_assertion
    ,string10 fuzzy_device_last_event
    ,string10 fuzzy_device_first_seen
    ,string10 fuzzy_device_result
    ,integer2 fuzzy_device_score
    ,integer2 fuzzy_device_worst_score
    ,real4 custom_count_1
    ,real4 custom_count_2
    ,real4 custom_count_3
    ,real4 custom_count_4
    ,string43 input_ip_address
    ,string8 tps_result
    ,string123 tps_error
    ,string3 tps_vendor_error
    ,string tps_vendor_result
    ,boolean tps_was_timeout
    ,string policy {blob,maxlength(281)}
    ,string error_detail {blob,maxlength(281)}
    ,integer2 cidr_number
    ,string true_ip_activities {blob,maxlength(300)}
    ,string39 true_ip_assert_history
    ,string true_ip_attributes {blob,maxlength(377)}
    ,string55 true_ip_city
    ,string10 true_ip_first_seen
    ,string2 true_ip_geo
    ,string39 true_ip
    ,string55 true_ip_isp
    ,string10 true_ip_last_assertion
    ,string10 true_ip_last_event
    ,string10 true_ip_last_update
    ,real4 true_ip_latitude
    ,real4 true_ip_longitude
    ,string55 true_ip_organization
    ,string55 true_ip_region
    ,string10 true_ip_result
    ,integer2 true_ip_score
    ,integer2 true_ip_worst_score
    ,string proxy_ip_activities {blob,maxlength(195)}
    ,string20 proxy_ip_assert_history
    ,string proxy_ip_attributes {blob,maxlength(375)}
    ,string55 proxy_ip_city
    ,string10 proxy_ip_first_seen
    ,string2 proxy_ip_geo
    ,string17 proxy_ip
    ,string55 proxy_ip_isp
    ,string10 proxy_ip_last_assertion
    ,string10 proxy_ip_last_event
    ,string10 proxy_ip_last_update
    ,real4 proxy_ip_latitude
    ,real4 proxy_ip_longitude
    ,string55 proxy_ip_organization
    ,string55 proxy_ip_region
    ,string10 proxy_ip_result
    ,integer2 proxy_ip_score
    ,integer2 proxy_ip_worst_score
    ,string12 proxy_type
    ,string10 proxy_name
    ,string85 account_name_activities
    ,string36 account_name_assert_history
    ,string100 account_name_attributes
    ,string35 account_name
    ,string10 account_name_first_seen
    ,string10 account_name_last_assertion
    ,string10 account_name_last_event
    ,string10 account_name_last_update
    ,string10 account_name_result
    ,integer2 account_name_score
    ,integer2 account_name_worst_score
    ,string account_login_activities {blob,maxlength(486)}
    ,string36 account_login_assert_history
    ,string account_login_attributes {blob,maxlength(195)}
    ,string35 account_login
    ,string10 account_login_first_seen
    ,string10 account_login_last_assertion
    ,string10 account_login_last_event
    ,string10 account_login_last_update
    ,string10 account_login_result
    ,integer2 account_login_score
    ,integer2 account_login_worst_score
    ,string58 password_hash_activities
    ,string35 password_hash_assert_history
    ,string58 password_hash_attributes
    ,string35 password_hash
    ,string10 password_hash_first_seen
    ,string10 password_hash_last_assertion
    ,string10 password_hash_last_event
    ,string10 password_hash_last_update
    ,string10 password_hash_result
    ,integer2 password_hash_score
    ,integer2 password_hash_worst_score
    ,string account_number_activities {blob,maxlength(179)}
    ,string32 account_number_assert_history
    ,string138 account_number_attributes
    ,string35 account_number
    ,string10 account_number_first_seen
    ,string10 account_number_last_assertion
    ,string10 account_number_last_event
    ,string10 account_number_last_update
    ,string10 account_number_result
    ,integer2 account_number_score
    ,integer2 account_number_worst_score
    ,string35 online_id_handle
    ,string35 online_tld
    ,string35 drivers_licence_number_hash
    ,string35 ssn_hash
    ,string35 online_id
    ,string32 online_id_activities
    ,string20 online_id_assert_history
    ,string32 online_id_attributes
    ,string10 online_id_first_seen
    ,string10 online_id_last_assertion
    ,string10 online_id_last_event
    ,string10 online_id_last_update
    ,string10 online_id_result
    ,integer2 online_id_score
    ,integer2 online_id_worst_score
    ,string32 drivers_licence_hash_activities
    ,string20 drivers_licence_hash_assert_history
    ,string32 drivers_licence_hash_attributes
    ,string10 drivers_licence_hash_first_seen
    ,string10 drivers_licence_hash_last_assertion
    ,string10 drivers_licence_hash_last_event
    ,string10 drivers_licence_hash_last_update
    ,string10 drivers_licence_hash_result
    ,integer2 drivers_licence_hash_score
    ,integer2 drivers_licence_hash_worst_score
    ,string43 ssn_hash_activities
    ,string20 ssn_hash_assert_history
    ,string43 ssn_hash_attributes
    ,string10 ssn_hash_first_seen
    ,string10 ssn_hash_last_assertion
    ,string10 ssn_hash_last_event
    ,string10 ssn_hash_last_update
    ,string10 ssn_hash_result
    ,integer2 ssn_hash_score
    ,integer2 ssn_hash_worst_score
    ,string account_email_activities {blob,maxlength(308)}
    ,string52 account_email_assert_history
    ,string account_email_attributes {blob,maxlength(222)}
    ,string35 account_email
    ,string10 account_email_first_seen
    ,string10 account_email_last_assertion
    ,string10 account_email_last_event
    ,string10 account_email_last_update
    ,string10 account_email_result
    ,integer2 account_email_score
    ,integer2 account_email_worst_score
    ,string51 account_address_activities
    ,string20 account_address_assert_history
    ,string51 account_address_attributes
    ,string35 account_address_city
    ,string35 account_address_country
    ,string10 account_address_first_seen
    ,string10 account_address_last_assertion
    ,string10 account_address_last_event
    ,string10 account_address_last_update
    ,string10 account_address_result
    ,integer2 account_address_score
    ,string35 account_address_state
    ,string35 account_address_street1
    ,string35 account_address_street2
    ,integer2 account_address_worst_score
    ,string35 account_address_zip
    ,string107 account_telephone_activities
    ,string32 account_telephone_assert_history
    ,string107 account_telephone_attributes
    ,string35 account_telephone
    ,string10 account_telephone_first_seen
    ,string10 account_telephone_last_assertion
    ,string10 account_telephone_last_event
    ,string10 account_telephone_last_update
    ,string10 account_telephone_result
    ,integer2 account_telephone_score
    ,integer2 account_telephone_worst_score
    ,string102 shipping_address_activities
    ,string20 shipping_address_assert_history
    ,string102 shipping_address_attributes
    ,string35 shipping_address_city
    ,string35 shipping_address_country
    ,string10 shipping_address_first_seen
    ,string10 shipping_address_last_assertion
    ,string10 shipping_address_last_event
    ,string10 shipping_address_last_update
    ,string10 shipping_address_result
    ,integer2 shipping_address_score
    ,string35 shipping_address_state
    ,string35 shipping_address_street1
    ,string35 shipping_address_street2
    ,integer2 shipping_address_worst_score
    ,string35 shipping_address_zip
    ,integer4 cc_bin_number
    ,string102 cc_number_hash_activities
    ,string35 cc_number_hash_assert_history
    ,string102 cc_number_hash_attributes
    ,string35 cc_number_hash
    ,string10 cc_number_hash_first_seen
    ,string10 cc_number_hash_last_assertion
    ,string10 cc_number_hash_last_event
    ,string10 cc_number_hash_last_update
    ,string10 cc_number_hash_result
    ,integer2 cc_number_hash_score
    ,integer2 cc_number_hash_worst_score
    ,string35 ach_account_hash
    ,string35 ach_routing_number
    ,string39 payment_gateway_provider
    ,string20 payment_request_type
    ,string23 payment_response_code
    ,string18 payment_response
    ,string22 processing_provider
    ,real4 settlement_amount
    ,string7 settlement_currency
    ,real4 transaction_amount
    ,real4 transaction_auth_amount
    ,string3 transaction_auth_currency
    ,string25 transaction_currency
    ,real4 transaction_shipping_amount
    ,string19 transaction_shipping_currency
    ,string35 ach_number
    ,string32 ach_number_activities
    ,string20 ach_number_assert_history
    ,string32 ach_number_attributes
    ,string10 ach_number_first_seen
    ,string10 ach_number_last_assertion
    ,string10 ach_number_last_event
    ,string10 ach_number_last_update
    ,string10 ach_number_result
    ,integer2 ach_number_score
    ,integer2 ach_number_worst_score
    ,string3 cc_bin_number_geo
    ,string encrypted_data_blob {blob,maxlength(1862)}
    ,integer4 import_id
    ,string44 device_fingerprint
    ,string72 device_fingerprint_activities
    ,string20 device_fingerprint_assert_history
    ,string72 device_fingerprint_attributes
    ,string10 device_fingerprint_first_seen
    ,string10 device_fingerprint_last_assertion
    ,string10 device_fingerprint_last_event
    ,string10 device_fingerprint_last_update
    ,string10 device_fingerprint_result
    ,integer2 device_fingerprint_score
    ,integer2 device_fingerprint_worst_score
    ,string44 page_fingerprint
    ,string135 page_fingerprint_activities
    ,string page_fingerprint_assert_history
    ,string page_fingerprint_attributes
    ,string10 page_fingerprint_first_seen
    ,string10 page_fingerprint_last_assertion
    ,string10 page_fingerprint_last_event
    ,string10 page_fingerprint_last_update
    ,string10 page_fingerprint_result
    ,integer2 page_fingerprint_score
    ,integer2 page_fingerprint_worst_score
    ,boolean page_fingerprint_check
    ,string page_summary {blob,maxlength(281)}
    ,string unknown_page_diff {blob,maxlength(549976)}
    ,integer4 page_id
    ,string24 enabled_services
    ,string page_fingerprint_diff {blob,maxlength(14816)}
    ,integer4 tcp_os_sig_adv_mss
    ,integer4 tcp_os_sig_snd_mss
    ,integer4 tcp_os_sig_rcv_mss
    ,integer4 http_os_sig_adv_mss
    ,integer4 http_os_sig_snd_mss
    ,integer4 http_os_sig_rcv_mss
    ,integer4 tcp_os_sig_ttl
    ,integer4 http_os_sig_ttl
    ,integer4 profiling_delta
    ,string15 profiling_site_id
    ,string http_referer_domain {blob,maxlength(183)}
    ,string profiled_domain {blob,maxlength(281)}
    ,string http_referer_url {blob,maxlength(400)}
    ,string profiled_url {blob,maxlength(323)}
    ,string35 condition_attrib_1
    ,string35 condition_attrib_2
    ,string35 condition_attrib_3
    ,string35 condition_attrib_4
    ,string35 condition_attrib_5
    ,string35 condition_attrib_6
    ,string35 condition_attrib_7
    ,string35 condition_attrib_8
    ,string35 condition_attrib_9
    ,string35 condition_attrib_10
    ,string35 condition_attrib_11
    ,string35 condition_attrib_12
    ,string35 condition_attrib_13
    ,string35 condition_attrib_14
    ,string35 condition_attrib_15
    ,string35 condition_attrib_16
    ,string35 condition_attrib_17
    ,string35 condition_attrib_18
    ,string unencrypted_condition_attrib_1 {blob,maxlength(281)}
    ,string unencrypted_condition_attrib_2 {blob,maxlength(369)}
    ,string tmx_reason_code {blob,maxlength(17931)}
    ,string related_device_id {blob,maxlength(1635)}
    ,string related_request_id {blob,maxlength(1635)}
    ,string related_custom_id {blob,maxlength(1255)}
    ,string23 tcp_connection_type
    ,string23 http_connection_type
    ,unsigned8 profile_arf_millisec
    ,integer4 page_time_on
    ,string11 screen_res_alt
    ,string18 page_fingerprint_match
    ,boolean honeypot_fingerprint_check
    ,string honeypot_fingerprint_diff {blob,maxlength(82398)}
    ,string44 honeypot_fingerprint
    ,string honeypot_unknown_diff {blob,maxlength(549976)}
    ,string18 honeypot_fingerprint_match
    ,string35 js_fonts_hash
    ,integer4 js_fonts_number
    ,string summary_reason_code {blob,maxlength(828)}
    ,integer2 tmx_policy_score
    ,string4 tmx_review_status
    ,string8 tmx_risk_rating
    ,string tmx_summary_reason_code {blob,maxlength(237)}
    ,string129 custom_mobile_1
    ,string custom_mobile_2 {blob,maxlength(281)}
    ,string129 custom_mobile_3
    ,string129 custom_mobile_4
    ,string129 custom_mobile_5
    ,string44 agent_device_id
    ,string35 agent_device_state
    ,real4 hw_latitude
    ,real4 hw_longitude
    ,real4 hw_gps_accuracy
    ,string experiment_1 {blob,maxlength(4224)}
    ,string68 experiment_2
    ,string18 experiment_3
    ,real4 experiment_4
    ,real4 experiment_5
    ,string34 agent_type
    ,string22 agent_version
    ,string17 dns_ip
    ,string55 dns_ip_city
    ,string2 dns_ip_geo
    ,string55 dns_ip_isp
    ,real4 dns_ip_latitude
    ,real4 dns_ip_longitude
    ,string55 dns_ip_organization
    ,string55 dns_ip_region
    ,string13 cc_bin_number_type
    ,string28 cc_bin_number_brand
    ,string35 cc_bin_number_category
    ,string96 cc_bin_number_org
    ,integer4 screen_color_depth
    ,string35 local_attrib_6
    ,string35 local_attrib_7
    ,string35 local_attrib_8
    ,string35 local_attrib_9
    ,string35 local_attrib_10
    ,string js_fonts_list {blob,maxlength(4224)}
    ,string35 etag_guid
    ,string70 agent_session_id
    ,string10 agent_event_time
    ,string123 agent_os
    ,string48 fw_name
    ,string55 av_name
    ,integer2 os_daysupdated
    ,string30 browser_process
    ,string26 browser_version
    ,string15 hdd_encryption_name
    ,integer2 pwd_policy_min_length
    ,integer2 pwd_policy_auto_lock_minutes
    ,string61 agent_health_details
    ,integer2 jb_root
    ,string jb_root_reason {blob,maxlength(579)}
    ,string9 fw_status
    ,string9 av_enabled
    ,string3 av_uptodate
    ,string10 os_update_strategy
    ,string3 hdd_encryption_status
    ,string3 pwd_policy_enabled
    ,string9 pwd_policy_complexity
    ,integer2 pwd_policy_max_days
    ,integer2 pwd_policy_min_days
    ,string3 pwd_policy_auto_logon
    ,string7 agent_health_status
    ,string146 custom_output_1
    ,string37 custom_output_2
    ,string37 custom_output_3
    ,string37 custom_output_4
    ,string37 custom_output_5
    ,string37 custom_output_6
    ,string37 custom_output_7
    ,string37 custom_output_8
    ,string74 custom_output_9
    ,string37 custom_output_10
    ,string input_ip_activities {blob,maxlength(300)}
    ,string22 input_ip_assert_history
    ,string input_ip_attributes {blob,maxlength(375)}
    ,string55 input_ip_city
    ,string10 input_ip_first_seen
    ,string2 input_ip_geo
    ,string55 input_ip_isp
    ,string10 input_ip_last_assertion
    ,string10 input_ip_last_event
    ,string10 input_ip_last_update
    ,real4 input_ip_latitude
    ,real4 input_ip_longitude
    ,string55 input_ip_organization
    ,string55 input_ip_region
    ,string10 input_ip_result
    ,integer2 input_ip_score
    ,integer2 input_ip_worst_score
    ,string9 profile_org_id
    ,string95 agent_os_version
    ,string21 agent_language
    ,string21 agent_locale
    ,string agent_brand {blob,maxlength(220)}
    ,string agent_model {blob,maxlength(156)}
    ,string apprep_selfhash {blob,maxlength(238)}
    ,string12 apprep_selfhash_category
    ,integer2 apprep_installedapps
    ,integer2 apprep_runningapps
    ,string apprep_installed_unknown {blob,maxlength(35827)}
    ,string apprep_running_unknown {blob,maxlength(3193)}
    ,string apprep_installed_malicious {blob,maxlength(1124)}
    ,string apprep_running_malicious {blob,maxlength(943)}
    ,string apprep_installed_unwanted {blob,maxlength(1015)}
    ,string apprep_running_unwanted {blob,maxlength(253)}
    ,string apprep_installed_suspicious {blob,maxlength(12595)}
    ,string apprep_running_suspicious {blob,maxlength(1342)}
    ,string apprep_installed_moderate {blob,maxlength(12631)}
    ,string apprep_running_moderate {blob,maxlength(2649)}
    ,string apprep_installed_benign {blob,maxlength(22360)}
    ,string apprep_running_benign {blob,maxlength(2903)}
    ,string30 action
    ,string69 experiment_mobile_1
    ,string73 experiment_mobile_2
    ,string experiment_mobile_3
    ,string experiment_mobile_4
    ,string experiment_mobile_5
    ,string2 experiment_mobile_6
    ,string experiment_mobile_7 {blob,maxlength(283)}
    ,string experiment_mobile_8
    ,string experiment_mobile_9
    ,string experiment_mobile_10 {blob,maxlength(373)}
    ,string10 agent_image_creation
    ,string92 agent_app_links
    ,unsigned8 agent_free_space
    ,string44 agent_name
    ,string112 agent_app_info
    ,string25 agent_bssid
    ,string61 agent_ssid
    ,string10 agent_boot_time
    ,string21 agent_connection_type
    ,string tmx_variables {blob,maxlength(11259)}
    ,string18 api_site_id
    ,string87 remote_desktop
    ,string32 true_ip_organization_type
    ,string10 true_ip_postal_code
    ,string21 true_ip_routing_type
    ,string true_ip_country_code
    ,string20 true_ip_connection_type
    ,boolean true_ip_home
    ,boolean true_ip_hosting_facility
    ,string7 true_ip_line_speed
    ,string32 proxy_ip_organization_type
    ,string10 proxy_ip_postal_code
    ,string21 proxy_ip_routing_type
    ,string proxy_ip_country_code
    ,string20 proxy_ip_connection_type
    ,boolean proxy_ip_home
    ,boolean proxy_ip_hosting_facility
    ,string7 proxy_ip_line_speed
    ,string32 dns_ip_organization_type
    ,string10 dns_ip_postal_code
    ,string21 dns_ip_routing_type
    ,string dns_ip_country_code
    ,string20 dns_ip_connection_type
    ,boolean dns_ip_home
    ,boolean dns_ip_hosting_facility
    ,string7 dns_ip_line_speed
    ,string32 input_ip_organization_type
    ,string10 input_ip_postal_code
    ,string21 input_ip_routing_type
    ,string2 input_ip_country_code
    ,string20 input_ip_connection_type
    ,boolean input_ip_home
    ,boolean input_ip_hosting_facility
    ,string7 input_ip_line_speed
    ,unsigned8 agent_total_space
    ,real4 agent_signal_strength
    ,real4 agent_wps_accuracy
    ,string page_fingerprint_hooks {blob,maxlength(48503)}
    ,string honeypot_fingerprint_hooks {blob,maxlength(27291)}
    ,string carrier_id
    ,string carrier_id_activities
    ,string carrier_id_assert_history
    ,string carrier_id_attributes
    ,string10 carrier_id_first_seen
    ,string10 carrier_id_last_assertion
    ,string10 carrier_id_last_event
    ,string10 carrier_id_last_update
    ,string carrier_id_result
    ,integer2 carrier_id_score
    ,integer2 carrier_id_worst_score
    ,integer2 tmx_raw_score
    ,string tmx_fraud_rating
    ,real4 tmx_p_score
    ,integer4 session_id_query_count
    ,real4 input_latitude
    ,real4 input_longitude
    ,real4 tmx_risk_rank
    ,real4 cba_score
    ,integer4 policy_version
    ,integer4 agent_profiling_delta
    ,string js_os {blob,maxlength(281)}
    ,string js_browser {blob,maxlength(281)}
    ,string35 js_browser_string_hash
    ,string19 browser
    ,string95 os_version
    ,boolean browser_anomaly
    ,real4 agent_wps_latitude
    ,real4 agent_wps_longitude
    ,string61 agent_cell_id
    ,string2 true_ip_region_iso_code
    ,string2 proxy_ip_region_iso_code
    ,string2 dns_ip_region_iso_code
    ,string2 input_ip_region_iso_code
    ,string fuzzy_device_id_reason_code {blob,maxlength(231)}
    ,string32 additional_data
    ,string19 event_tag
    ,string44 agent_publickey_hash
    ,string agent_publickey_hash_type {blob,maxlength(281)}
    ,string55 input_request_id
    ,string tmx_internal_variables {blob,maxlength(9338)}
    ,string5 apiversion
    ,string11 segment_name
    ,real4 html_location_latitude
    ,real4 html_location_longitude
    ,real4 html_location_accuracy
    ,real4 html_location_altitude
    ,real4 html_location_heading
    ,string webrtc_external_ip {blob,maxlength(281)}
    ,string webrtc_internal_ip {blob,maxlength(281)}
    ,string webrtc_ipv6 {blob,maxlength(281)}
    ,string107 agent_publickey_hash_activities
    ,string20 agent_publickey_hash_assert_history
    ,string107 agent_publickey_hash_attributes
    ,string10 agent_publickey_hash_first_seen
    ,string10 agent_publickey_hash_last_assertion
    ,string10 agent_publickey_hash_last_event
    ,string10 agent_publickey_hash_last_update
    ,string10 agent_publickey_hash_result
    ,integer2 agent_publickey_hash_score
    ,integer2 agent_publickey_hash_worst_score
    ,integer2 smart_learning_policy_score
    ,real4 smart_learning_risk_rank
    ,string10 smart_learning_fraud_rating
    ,real4 smart_learning_p_score
    ,string smart_learning_variables {blob,maxlength(2463)}
    ,string smart_learning_reason_code {blob,maxlength(527)}
    ,string22 smart_learning_summary_reason_code
    ,integer4 yyyymm
    ,string carrier_name
    ,string carrier_mobile_number
    ,string carrier_mobile_number_activities
    ,string carrier_mobile_number_assert_history
    ,string carrier_mobile_number_attributes
    ,string10 carrier_mobile_number_first_seen
    ,string10 carrier_mobile_number_last_assertion
    ,string10 carrier_mobile_number_last_event
    ,string10 carrier_mobile_number_last_update
    ,string carrier_mobile_number_result
    ,integer2 carrier_mobile_number_score
    ,integer2 carrier_mobile_number_worst_score
    ,string carrier_mobile_number_match_result
    ,string carrier_account
    ,string carrier_account_activities
    ,string carrier_account_assert_history
    ,string carrier_account_attributes
    ,string10 carrier_account_first_seen
    ,string10 carrier_account_last_assertion
    ,string10 carrier_account_last_event
    ,string10 carrier_account_last_update
    ,string carrier_account_result
    ,integer2 carrier_account_score
    ,integer2 carrier_account_worst_score
    ,string carrier_account_match_result
    ,string experiment_6 {blob,maxlength(4224)}
    ,string experiment_7 {blob,maxlength(3634)}
    ,string8 experiment_8
    ,string experiment_9
    ,string25 experiment_10
    ,string account_email_domain {blob,maxlength(256)}
    ,boolean private_browsing
    ,string30 policy_site_id
    ,string35 account_first_name
    ,string35 account_last_name
    ,string4 agent_device_caps
    ,integer2 virtual_machine
    ,string virtual_machine_reason
    ,string58 customer_event_type
    ,string35 application_name
    ,string line_of_business {blob,maxlength(281)}
    ,string35 local_attrib_11
    ,string35 local_attrib_12
    ,string35 local_attrib_13
    ,string35 local_attrib_14
    ,string35 local_attrib_15
    ,string35 account_date_of_birth
    ,string32 digital_id
    ,integer4 digital_id_confidence
    ,string digital_id_reason_code {blob,maxlength(446)}
    ,string107 digital_id_activities
    ,string107 digital_id_attributes
    ,string10 digital_id_first_seen
    ,string10 digital_id_last_event
    ,string10 digital_id_last_update
    ,string20 digital_id_result
    ,integer4 digital_id_score
    ,string test_digital_id
    ,integer4 test_digital_id_confidence
    ,string test_digital_id_reason_code {blob,maxlength(446)}
    ,string test_digital_id_activities
    ,string test_digital_id_attributes
    ,string10 test_digital_id_first_seen
    ,string10 test_digital_id_last_event
    ,string10 test_digital_id_last_update
    ,string test_digital_id_result
    ,integer4 test_digital_id_score
    ,real4 account_address_zip_latitude
    ,real4 account_address_zip_longitude
    ,real4 shipping_address_zip_latitude
    ,real4 shipping_address_zip_longitude
    ,string30 carrier_id_token
    ,string webgl_hash {blob,maxlength(281)}
    ,string canvas_hash {blob,maxlength(281)}
    ,string targeted_malware {blob,maxlength(385)}
    ,string local_ipv4 {blob,maxlength(281)}
    ,string local_ipv6 {blob,maxlength(281)}
    ,string mac_address {blob,maxlength(281)}
    ,string flash_version_detected
    ,string page_fingerprint_diff_names {blob,maxlength(14814)}
    ,string honeypot_fingerprint_diff_names {blob,maxlength(77561)}
    ,string40 advertising_id
    ,string99 device_imei
    ,string35 account_home_phone
    ,string35 account_work_phone
    ,string external_device_info
    ,string account_address_zip_normalized
    ,string shipping_address_zip_normalized
    ,string11 selinux_status
    ,integer2 app_integrity_score
    ,real4 custom_count_5
    ,real4 custom_count_6
    ,real4 custom_count_7
    ,real4 custom_count_8
    ,real4 custom_count_9
    ,real4 custom_count_10
    ,real4 custom_count_11
    ,real4 custom_count_12
    ,real4 custom_count_13
    ,real4 custom_count_14
    ,real4 custom_count_15
    ,string37 custom_output_11
    ,string37 custom_output_12
    ,string37 custom_output_13
    ,string37 custom_output_14
    ,string37 custom_output_15
    ,string37 custom_output_16
    ,string37 custom_output_17
    ,string37 custom_output_18
    ,string37 custom_output_19
    ,string37 custom_output_20
    ,string62 ua_os_alt
    ,string67 ua_os_version_alt
    ,string28 ua_browser_alt
    ,string66 ua_browser_version_alt
    ,integer2 virtual_device
    ,string virtual_device_reason {blob,maxlength(464)}
    ,string22 dns_ip_assert_history
    ,string dns_ip_attributes {blob,maxlength(249)}
    ,string dns_ip_activities {blob,maxlength(180)}
    ,string11 primary_industry
    ,string22 secondary_industry
    ,boolean ship_address_is_bill_address
    ,integer2 merchant_category_code
    ,string merchant_country_code {blob,maxlength(396)}
    ,string merchant_name {blob,maxlength(396)}
    ,string merchant_id {blob,maxlength(352)}
    ,string41 auth_methods
    ,string device_health_reasons {blob,maxlength(150)}
    ,string local_attrib_1_activities {blob,maxlength(517)}
    ,string local_attrib_2_activities {blob,maxlength(205)}
    ,string100 local_attrib_3_activities
    ,string local_attrib_4_activities {blob,maxlength(278)}
    ,string62 local_attrib_5_activities
    ,string102 local_attrib_6_activities
    ,string58 local_attrib_7_activities
    ,string58 local_attrib_8_activities
    ,string58 local_attrib_9_activities
    ,string74 local_attrib_10_activities
    ,string56 local_attrib_11_activities
    ,string74 local_attrib_12_activities
    ,string56 local_attrib_13_activities
    ,string56 local_attrib_14_activities
    ,string56 local_attrib_15_activities
    ,string10 local_attrib_1_first_seen
    ,string10 local_attrib_2_first_seen
    ,string10 local_attrib_3_first_seen
    ,string10 local_attrib_4_first_seen
    ,string10 local_attrib_5_first_seen
    ,string10 local_attrib_6_first_seen
    ,string10 local_attrib_7_first_seen
    ,string10 local_attrib_8_first_seen
    ,string10 local_attrib_9_first_seen
    ,string10 local_attrib_10_first_seen
    ,string10 local_attrib_11_first_seen
    ,string10 local_attrib_12_first_seen
    ,string10 local_attrib_13_first_seen
    ,string10 local_attrib_14_first_seen
    ,string10 local_attrib_15_first_seen
    ,string experiment_mobile_array {blob,maxlength(1981)}
    ,string experiment_array
    ,string70 web_session_id
    ,string122 web_session_id_activities
    ,string web_session_id_attributes
    ,string10 web_session_id_first_seen
    ,string10 web_session_id_last_event
    ,string10 web_session_id_last_update
    ,string10 web_session_id_result
    ,integer4 web_session_id_score
    ,string wurfl_info {blob,maxlength(688)}
    ,string collected_ip_addresses {blob,maxlength(2080)}
    ,string139 exact_id_health
    ,boolean use_test_apn
    ,string41 challenger_policy
    ,integer2 challenger_policy_score
    ,string challenger_reason_code {blob,maxlength(3862)}
    ,string8 challenger_risk_rating
    ,string124 challenger_summary_reason_code
    ,string7 challenger_review_status
    ,string10 digital_id_confidence_rating
    ,string digital_id_trust_score_reason_code {blob,maxlength(827)}
    ,string57 digital_id_trust_score_summary_reason_code
    ,real4 digital_id_trust_score
    ,string10 digital_id_trust_score_rating
    ,string digital_id_trust_score_variables {blob,maxlength(2421)}
    ,string rules {blob,maxlength(396)}
    ,string35 external_guid
    ,string global_third_party_cookie
    ,string national_id_type
    ,string national_id_number
    ,string threeds_comp_ind
    ,string targeted_storage {blob,maxlength(211)}
    ,string3 turn_os_sig_raw
    ,integer2 turn_os_sig_ttl
    ,string11 turn_os_signature
    ,integer4 turn_system_state
    ,integer4 turn_tcp_tstmp_rate
    ,string org_group_id
    ,string ssl_fp_client
    ,string ssl_fp_category
    ,string digital_id_summary_reason_code // KJE - discrepency found on THOR_DEV wwtm::in::log file
end;


export key_payload:=record
    unsigned6 recid:=0;
    string8 trans_date;
    string4 trans_hhmm;
    string2 trans_ss;
    string25 provenance
    ,string23 date_time
    ,string8 org_id
    ,string11 event_id
    ,string206 api_type// {blob,maxlength(206)}
    ,string376 event_type// {blob,maxlength(376)}
    ,integer2 policy_score
    ,string reason_code {blob,maxlength(12059)}
    ,string32 request_id
    ,string40 request_result
    ,string15 review_status
    ,string15 risk_rating
    ,string service_type {blob,maxlength(281)}
    ,string browser_language {blob,maxlength(281)}
    ,string35 browser_string_hash
    ,string browser_string {blob,maxlength(285)}
    ,boolean css_file_loaded
    ,boolean css_image_loaded
    ,boolean detected_fl
    ,string device_activities {blob,maxlength(318)}
    ,string52 device_assert_history
    ,string device_attributes {blob,maxlength(347)}
    ,string10 device_first_seen
    ,string32 device_id
    ,string10 device_last_assertion
    ,string10 device_last_event
    ,string10 device_last_update
    ,string20 device_match_result
    ,string10 device_result
    ,integer2 device_score
    ,integer2 device_worst_score
    ,boolean enabled_ck
    ,boolean enabled_fl
    ,boolean enabled_im
    ,boolean enabled_js
    ,string first_party_cookie {blob,maxlength(281)}
    ,boolean flash_anomaly
    ,string35 flash_guid
    ,string flash_lang {blob,maxlength(164)}
    ,string flash_os {blob,maxlength(281)}
    ,integer4 flash_system_state
    ,integer4 flash_tcp_tstmp_rate
    ,integer4 flash_tstmp_measure_time
    ,string54 flash_version
    ,string35 headers_name_value_hash
    ,string35 headers_order_string_hash
    ,string35 http_os_signature
    ,string http_os_sig_raw {blob,maxlength(217)}
    ,string35 http_referer
    ,integer4 https_proxy_flag
    ,boolean image_anomaly
    ,boolean image_loaded
    ,real4 local_time_offset
    ,real4 local_time_offset_range
    ,boolean os_anomaly
    ,string15 os
    ,string44 os_fonts_hash
    ,integer4 os_fonts_number
    ,string17 plugin_adobe_acrobat
    ,string19 plugin_flash
    ,string35 plugin_hash
    ,string17 plugin_realplayer
    ,string17 plugin_shockwave
    ,string12 plugin_silverlight
    ,string24 plugin_windows_media_player
    ,string10 profiling_datetime
    ,string13 screen_res
    ,boolean session_anomaly
    ,string session_id {blob,maxlength(936)}
    ,string35 silverlight_guid
    ,integer4 system_state
    ,string34 tcp_os_signature
    ,string tcp_os_sig_raw {blob,maxlength(217)}
    ,integer4 tcp_tstmp_rate
    ,string35 third_party_cookie
    ,integer4 time_zone
    ,string transaction_id {blob,maxlength(541)}
    ,integer4 tstmp_measure_time
    ,string35 local_attrib_1
    ,string35 local_attrib_2
    ,string35 local_attrib_3
    ,string35 local_attrib_4
    ,string35 local_attrib_5
    ,string35 custom_match_1
    ,string35 custom_match_2
    ,string35 custom_match_3
    ,string35 custom_match_4
    ,string35 custom_match_5
    ,string35 custom_match_6
    ,string35 custom_match_7
    ,string35 custom_match_8
    ,string ua_agent
    ,string44 ua_browser
    ,boolean ua_mobile
    ,string62 ua_os
    ,string54 ua_platform
    ,boolean ua_proxy
    ,unsigned8 offset_measure_time
    ,boolean screen_res_anomaly
    ,boolean screen_aspect_ratio_anomaly
    ,integer4 time_zone_dst_offset
    ,boolean timezone_offset_anomaly
    ,integer4 request_duration
    ,integer4 profile_api_timedelta
    ,boolean url_anomaly
    ,boolean browser_language_anomaly
    ,boolean browser_string_mismatch
    ,boolean browser_string_anomaly
    ,string js_browser_string {blob,maxlength(842)}
    ,string35 mime_type_hash
    ,integer4 mime_type_number
    ,integer4 plugin_number
    ,string17 plugin_quicktime
    ,string17 plugin_java
    ,string17 plugin_vlc_player
    ,string17 plugin_devalvr
    ,string17 plugin_svg_viewer
    ,boolean multiple_session_id
    ,string19 device_id_reason_code
    ,boolean unknown_session
    ,string35 localstorage_guid
    ,string32 fuzzy_device_id
    ,real4 fuzzy_device_id_confidence
    ,string11 fuzzy_device_match_result
    ,string fuzzy_device_activities {blob,maxlength(300)}
    ,string20 fuzzy_device_assert_history
    ,string fuzzy_device_attributes {blob,maxlength(300)}
    ,string10 fuzzy_device_last_update
    ,string10 fuzzy_device_last_assertion
    ,string10 fuzzy_device_last_event
    ,string10 fuzzy_device_first_seen
    ,string10 fuzzy_device_result
    ,integer2 fuzzy_device_score
    ,integer2 fuzzy_device_worst_score
    ,real4 custom_count_1
    ,real4 custom_count_2
    ,real4 custom_count_3
    ,real4 custom_count_4
    ,string43 input_ip_address
    ,string8 tps_result
    ,string123 tps_error
    ,string3 tps_vendor_error
    ,string tps_vendor_result
    ,boolean tps_was_timeout
    ,string policy {blob,maxlength(281)}
    ,string error_detail {blob,maxlength(281)}
    ,integer2 cidr_number
    ,string true_ip_activities {blob,maxlength(300)}
    ,string39 true_ip_assert_history
    ,string true_ip_attributes {blob,maxlength(377)}
    ,string55 true_ip_city
    ,string10 true_ip_first_seen
    ,string2 true_ip_geo
    ,string39 true_ip
    ,string55 true_ip_isp
    ,string10 true_ip_last_assertion
    ,string10 true_ip_last_event
    ,string10 true_ip_last_update
    ,real4 true_ip_latitude
    ,real4 true_ip_longitude
    ,string55 true_ip_organization
    ,string55 true_ip_region
    ,string10 true_ip_result
    ,integer2 true_ip_score
    ,integer2 true_ip_worst_score
    ,string proxy_ip_activities {blob,maxlength(195)}
    ,string20 proxy_ip_assert_history
    ,string proxy_ip_attributes {blob,maxlength(375)}
    ,string55 proxy_ip_city
    ,string10 proxy_ip_first_seen
    ,string2 proxy_ip_geo
    ,string17 proxy_ip
    ,string55 proxy_ip_isp
    ,string10 proxy_ip_last_assertion
    ,string10 proxy_ip_last_event
    ,string10 proxy_ip_last_update
    ,real4 proxy_ip_latitude
    ,real4 proxy_ip_longitude
    ,string55 proxy_ip_organization
    ,string55 proxy_ip_region
    ,string10 proxy_ip_result
    ,integer2 proxy_ip_score
    ,integer2 proxy_ip_worst_score
    ,string12 proxy_type
    ,string10 proxy_name
    ,string85 account_name_activities
    ,string36 account_name_assert_history
    ,string100 account_name_attributes
    ,string35 account_name
    ,string10 account_name_first_seen
    ,string10 account_name_last_assertion
    ,string10 account_name_last_event
    ,string10 account_name_last_update
    ,string10 account_name_result
    ,integer2 account_name_score
    ,integer2 account_name_worst_score
    ,string account_login_activities {blob,maxlength(486)}
    ,string36 account_login_assert_history
    ,string account_login_attributes {blob,maxlength(195)}
    ,string35 account_login
    ,string10 account_login_first_seen
    ,string10 account_login_last_assertion
    ,string10 account_login_last_event
    ,string10 account_login_last_update
    ,string10 account_login_result
    ,integer2 account_login_score
    ,integer2 account_login_worst_score
    ,string58 password_hash_activities
    ,string35 password_hash_assert_history
    ,string58 password_hash_attributes
    ,string35 password_hash
    ,string10 password_hash_first_seen
    ,string10 password_hash_last_assertion
    ,string10 password_hash_last_event
    ,string10 password_hash_last_update
    ,string10 password_hash_result
    ,integer2 password_hash_score
    ,integer2 password_hash_worst_score
    ,string account_number_activities {blob,maxlength(179)}
    ,string32 account_number_assert_history
    ,string138 account_number_attributes
    ,string35 account_number
    ,string10 account_number_first_seen
    ,string10 account_number_last_assertion
    ,string10 account_number_last_event
    ,string10 account_number_last_update
    ,string10 account_number_result
    ,integer2 account_number_score
    ,integer2 account_number_worst_score
    ,string35 online_id_handle
    ,string35 online_tld
    ,string35 drivers_licence_number_hash
    ,string35 ssn_hash
    ,string35 online_id
    ,string32 online_id_activities
    ,string20 online_id_assert_history
    ,string32 online_id_attributes
    ,string10 online_id_first_seen
    ,string10 online_id_last_assertion
    ,string10 online_id_last_event
    ,string10 online_id_last_update
    ,string10 online_id_result
    ,integer2 online_id_score
    ,integer2 online_id_worst_score
    ,string32 drivers_licence_hash_activities
    ,string20 drivers_licence_hash_assert_history
    ,string32 drivers_licence_hash_attributes
    ,string10 drivers_licence_hash_first_seen
    ,string10 drivers_licence_hash_last_assertion
    ,string10 drivers_licence_hash_last_event
    ,string10 drivers_licence_hash_last_update
    ,string10 drivers_licence_hash_result
    ,integer2 drivers_licence_hash_score
    ,integer2 drivers_licence_hash_worst_score
    ,string43 ssn_hash_activities
    ,string20 ssn_hash_assert_history
    ,string43 ssn_hash_attributes
    ,string10 ssn_hash_first_seen
    ,string10 ssn_hash_last_assertion
    ,string10 ssn_hash_last_event
    ,string10 ssn_hash_last_update
    ,string10 ssn_hash_result
    ,integer2 ssn_hash_score
    ,integer2 ssn_hash_worst_score
    ,string account_email_activities {blob,maxlength(308)}
    ,string52 account_email_assert_history
    ,string account_email_attributes {blob,maxlength(222)}
    ,string35 account_email
    ,string10 account_email_first_seen
    ,string10 account_email_last_assertion
    ,string10 account_email_last_event
    ,string10 account_email_last_update
    ,string10 account_email_result
    ,integer2 account_email_score
    ,integer2 account_email_worst_score
    ,string51 account_address_activities
    ,string20 account_address_assert_history
    ,string51 account_address_attributes
    ,string35 account_address_city
    ,string35 account_address_country
    ,string10 account_address_first_seen
    ,string10 account_address_last_assertion
    ,string10 account_address_last_event
    ,string10 account_address_last_update
    ,string10 account_address_result
    ,integer2 account_address_score
    ,string35 account_address_state
    ,string35 account_address_street1
    ,string35 account_address_street2
    ,integer2 account_address_worst_score
    ,string35 account_address_zip
    ,string107 account_telephone_activities
    ,string32 account_telephone_assert_history
    ,string107 account_telephone_attributes
    ,string35 account_telephone
    ,string10 account_telephone_first_seen
    ,string10 account_telephone_last_assertion
    ,string10 account_telephone_last_event
    ,string10 account_telephone_last_update
    ,string10 account_telephone_result
    ,integer2 account_telephone_score
    ,integer2 account_telephone_worst_score
    ,string102 shipping_address_activities
    ,string20 shipping_address_assert_history
    ,string102 shipping_address_attributes
    ,string35 shipping_address_city
    ,string35 shipping_address_country
    ,string10 shipping_address_first_seen
    ,string10 shipping_address_last_assertion
    ,string10 shipping_address_last_event
    ,string10 shipping_address_last_update
    ,string10 shipping_address_result
    ,integer2 shipping_address_score
    ,string35 shipping_address_state
    ,string35 shipping_address_street1
    ,string35 shipping_address_street2
    ,integer2 shipping_address_worst_score
    ,string35 shipping_address_zip
    ,integer4 cc_bin_number
    ,string102 cc_number_hash_activities
    ,string35 cc_number_hash_assert_history
    ,string102 cc_number_hash_attributes
    ,string35 cc_number_hash
    ,string10 cc_number_hash_first_seen
    ,string10 cc_number_hash_last_assertion
    ,string10 cc_number_hash_last_event
    ,string10 cc_number_hash_last_update
    ,string10 cc_number_hash_result
    ,integer2 cc_number_hash_score
    ,integer2 cc_number_hash_worst_score
    ,string35 ach_account_hash
    ,string35 ach_routing_number
    ,string39 payment_gateway_provider
    ,string20 payment_request_type
    ,string23 payment_response_code
    ,string18 payment_response
    ,string22 processing_provider
    ,real4 settlement_amount
    ,string7 settlement_currency
    ,real4 transaction_amount
    ,real4 transaction_auth_amount
    ,string3 transaction_auth_currency
    ,string25 transaction_currency
    ,real4 transaction_shipping_amount
    ,string19 transaction_shipping_currency
    ,string35 ach_number
    ,string32 ach_number_activities
    ,string20 ach_number_assert_history
    ,string32 ach_number_attributes
    ,string10 ach_number_first_seen
    ,string10 ach_number_last_assertion
    ,string10 ach_number_last_event
    ,string10 ach_number_last_update
    ,string10 ach_number_result
    ,integer2 ach_number_score
    ,integer2 ach_number_worst_score
    ,string3 cc_bin_number_geo
    ,string encrypted_data_blob {blob,maxlength(1862)}
    ,integer4 import_id
    ,string44 device_fingerprint
    ,string72 device_fingerprint_activities
    ,string20 device_fingerprint_assert_history
    ,string72 device_fingerprint_attributes
    ,string10 device_fingerprint_first_seen
    ,string10 device_fingerprint_last_assertion
    ,string10 device_fingerprint_last_event
    ,string10 device_fingerprint_last_update
    ,string10 device_fingerprint_result
    ,integer2 device_fingerprint_score
    ,integer2 device_fingerprint_worst_score
    ,string44 page_fingerprint
    ,string135 page_fingerprint_activities
    ,string page_fingerprint_assert_history
    ,string page_fingerprint_attributes
    ,string10 page_fingerprint_first_seen
    ,string10 page_fingerprint_last_assertion
    ,string10 page_fingerprint_last_event
    ,string10 page_fingerprint_last_update
    ,string10 page_fingerprint_result
    ,integer2 page_fingerprint_score
    ,integer2 page_fingerprint_worst_score
    ,boolean page_fingerprint_check
    ,string page_summary {blob,maxlength(281)}
    ,string unknown_page_diff {blob,maxlength(549976)}
    ,integer4 page_id
    ,string24 enabled_services
    ,string page_fingerprint_diff {blob,maxlength(14816)}
    ,integer4 tcp_os_sig_adv_mss
    ,integer4 tcp_os_sig_snd_mss
    ,integer4 tcp_os_sig_rcv_mss
    ,integer4 http_os_sig_adv_mss
    ,integer4 http_os_sig_snd_mss
    ,integer4 http_os_sig_rcv_mss
    ,integer4 tcp_os_sig_ttl
    ,integer4 http_os_sig_ttl
    ,integer4 profiling_delta
    ,string15 profiling_site_id
    ,string http_referer_domain {blob,maxlength(183)}
    ,string profiled_domain {blob,maxlength(281)}
    ,string http_referer_url {blob,maxlength(400)}
    ,string profiled_url {blob,maxlength(323)}
    ,string35 condition_attrib_1
    ,string35 condition_attrib_2
    ,string35 condition_attrib_3
    ,string35 condition_attrib_4
    ,string35 condition_attrib_5
    ,string35 condition_attrib_6
    ,string35 condition_attrib_7
    ,string35 condition_attrib_8
    ,string35 condition_attrib_9
    ,string35 condition_attrib_10
    ,string35 condition_attrib_11
    ,string35 condition_attrib_12
    ,string35 condition_attrib_13
    ,string35 condition_attrib_14
    ,string35 condition_attrib_15
    ,string35 condition_attrib_16
    ,string35 condition_attrib_17
    ,string35 condition_attrib_18
    ,string unencrypted_condition_attrib_1 {blob,maxlength(281)}
    ,string unencrypted_condition_attrib_2 {blob,maxlength(369)}
    ,string tmx_reason_code {blob,maxlength(17931)}
    ,string related_device_id {blob,maxlength(1635)}
    ,string related_request_id {blob,maxlength(1635)}
    ,string related_custom_id {blob,maxlength(1255)}
    ,string23 tcp_connection_type
    ,string23 http_connection_type
    ,unsigned8 profile_arf_millisec
    ,integer4 page_time_on
    ,string11 screen_res_alt
    ,string18 page_fingerprint_match
    ,boolean honeypot_fingerprint_check
    ,string honeypot_fingerprint_diff {blob,maxlength(82398)}
    ,string44 honeypot_fingerprint
    ,string honeypot_unknown_diff {blob,maxlength(549976)}
    ,string18 honeypot_fingerprint_match
    ,string35 js_fonts_hash
    ,integer4 js_fonts_number
    ,string summary_reason_code {blob,maxlength(828)}
    ,integer2 tmx_policy_score
    ,string4 tmx_review_status
    ,string8 tmx_risk_rating
    ,string tmx_summary_reason_code {blob,maxlength(237)}
    ,string129 custom_mobile_1
    ,string custom_mobile_2 {blob,maxlength(281)}
    ,string129 custom_mobile_3
    ,string129 custom_mobile_4
    ,string129 custom_mobile_5
    ,string44 agent_device_id
    ,string35 agent_device_state
    ,real4 hw_latitude
    ,real4 hw_longitude
    ,real4 hw_gps_accuracy
    ,string experiment_1 {blob,maxlength(4224)}
    ,string68 experiment_2
    ,string18 experiment_3
    ,real4 experiment_4
    ,real4 experiment_5
    ,string34 agent_type
    ,string22 agent_version
    ,string17 dns_ip
    ,string55 dns_ip_city
    ,string2 dns_ip_geo
    ,string55 dns_ip_isp
    ,real4 dns_ip_latitude
    ,real4 dns_ip_longitude
    ,string55 dns_ip_organization
    ,string55 dns_ip_region
    ,string13 cc_bin_number_type
    ,string28 cc_bin_number_brand
    ,string35 cc_bin_number_category
    ,string96 cc_bin_number_org
    ,integer4 screen_color_depth
    ,string35 local_attrib_6
    ,string35 local_attrib_7
    ,string35 local_attrib_8
    ,string35 local_attrib_9
    ,string35 local_attrib_10
    ,string js_fonts_list {blob,maxlength(4224)}
    ,string35 etag_guid
    ,string70 agent_session_id
    ,string10 agent_event_time
    ,string123 agent_os
    ,string48 fw_name
    ,string55 av_name
    ,integer2 os_daysupdated
    ,string30 browser_process
    ,string26 browser_version
    ,string15 hdd_encryption_name
    ,integer2 pwd_policy_min_length
    ,integer2 pwd_policy_auto_lock_minutes
    ,string61 agent_health_details
    ,integer2 jb_root
    ,string jb_root_reason {blob,maxlength(579)}
    ,string9 fw_status
    ,string9 av_enabled
    ,string3 av_uptodate
    ,string10 os_update_strategy
    ,string3 hdd_encryption_status
    ,string3 pwd_policy_enabled
    ,string9 pwd_policy_complexity
    ,integer2 pwd_policy_max_days
    ,integer2 pwd_policy_min_days
    ,string3 pwd_policy_auto_logon
    ,string7 agent_health_status
    ,string146 custom_output_1
    ,string37 custom_output_2
    ,string37 custom_output_3
    ,string37 custom_output_4
    ,string37 custom_output_5
    ,string37 custom_output_6
    ,string37 custom_output_7
    ,string37 custom_output_8
    ,string74 custom_output_9
    ,string37 custom_output_10
    ,string input_ip_activities {blob,maxlength(300)}
    ,string22 input_ip_assert_history
    ,string input_ip_attributes {blob,maxlength(375)}
    ,string55 input_ip_city
    ,string10 input_ip_first_seen
    ,string2 input_ip_geo
    ,string55 input_ip_isp
    ,string10 input_ip_last_assertion
    ,string10 input_ip_last_event
    ,string10 input_ip_last_update
    ,real4 input_ip_latitude
    ,real4 input_ip_longitude
    ,string55 input_ip_organization
    ,string55 input_ip_region
    ,string10 input_ip_result
    ,integer2 input_ip_score
    ,integer2 input_ip_worst_score
    ,string9 profile_org_id
    ,string95 agent_os_version
    ,string21 agent_language
    ,string21 agent_locale
    ,string agent_brand {blob,maxlength(220)}
    ,string agent_model {blob,maxlength(156)}
    ,string apprep_selfhash {blob,maxlength(238)}
    ,string12 apprep_selfhash_category
    ,integer2 apprep_installedapps
    ,integer2 apprep_runningapps
    ,string apprep_installed_unknown {blob,maxlength(35827)}
    ,string apprep_running_unknown {blob,maxlength(3193)}
    ,string apprep_installed_malicious {blob,maxlength(1124)}
    ,string apprep_running_malicious {blob,maxlength(943)}
    ,string apprep_installed_unwanted {blob,maxlength(1015)}
    ,string apprep_running_unwanted {blob,maxlength(253)}
    ,string apprep_installed_suspicious {blob,maxlength(12595)}
    ,string apprep_running_suspicious {blob,maxlength(1342)}
    ,string apprep_installed_moderate {blob,maxlength(12631)}
    ,string apprep_running_moderate {blob,maxlength(2649)}
    ,string apprep_installed_benign {blob,maxlength(22360)}
    ,string apprep_running_benign {blob,maxlength(2903)}
    ,string30 action
    ,string69 experiment_mobile_1
    ,string73 experiment_mobile_2
    ,string experiment_mobile_3
    ,string experiment_mobile_4
    ,string experiment_mobile_5
    ,string2 experiment_mobile_6
    ,string experiment_mobile_7 {blob,maxlength(283)}
    ,string experiment_mobile_8
    ,string experiment_mobile_9
    ,string experiment_mobile_10 {blob,maxlength(373)}
    ,string10 agent_image_creation
    ,string92 agent_app_links
    ,unsigned8 agent_free_space
    ,string44 agent_name
    ,string112 agent_app_info
    ,string25 agent_bssid
    ,string61 agent_ssid
    ,string10 agent_boot_time
    ,string21 agent_connection_type
    ,string tmx_variables {blob,maxlength(11259)}
    ,string18 api_site_id
    ,string87 remote_desktop
    ,string32 true_ip_organization_type
    ,string10 true_ip_postal_code
    ,string21 true_ip_routing_type
    ,string true_ip_country_code
    ,string20 true_ip_connection_type
    ,boolean true_ip_home
    ,boolean true_ip_hosting_facility
    ,string7 true_ip_line_speed
    ,string32 proxy_ip_organization_type
    ,string10 proxy_ip_postal_code
    ,string21 proxy_ip_routing_type
    ,string proxy_ip_country_code
    ,string20 proxy_ip_connection_type
    ,boolean proxy_ip_home
    ,boolean proxy_ip_hosting_facility
    ,string7 proxy_ip_line_speed
    ,string32 dns_ip_organization_type
    ,string10 dns_ip_postal_code
    ,string21 dns_ip_routing_type
    ,string dns_ip_country_code
    ,string20 dns_ip_connection_type
    ,boolean dns_ip_home
    ,boolean dns_ip_hosting_facility
    ,string7 dns_ip_line_speed
    ,string32 input_ip_organization_type
    ,string10 input_ip_postal_code
    ,string21 input_ip_routing_type
    ,string2 input_ip_country_code
    ,string20 input_ip_connection_type
    ,boolean input_ip_home
    ,boolean input_ip_hosting_facility
    ,string7 input_ip_line_speed
    ,unsigned8 agent_total_space
    ,real4 agent_signal_strength
    ,real4 agent_wps_accuracy
    ,string page_fingerprint_hooks {blob,maxlength(48503)}
    ,string honeypot_fingerprint_hooks {blob,maxlength(27291)}
    ,string carrier_id
    ,string carrier_id_activities
    ,string carrier_id_assert_history
    ,string carrier_id_attributes
    ,string10 carrier_id_first_seen
    ,string10 carrier_id_last_assertion
    ,string10 carrier_id_last_event
    ,string10 carrier_id_last_update
    ,string carrier_id_result
    ,integer2 carrier_id_score
    ,integer2 carrier_id_worst_score
    ,integer2 tmx_raw_score
    ,string tmx_fraud_rating
    ,real4 tmx_p_score
    ,integer4 session_id_query_count
    ,real4 input_latitude
    ,real4 input_longitude
    ,real4 tmx_risk_rank
    ,real4 cba_score
    ,integer4 policy_version
    ,integer4 agent_profiling_delta
    ,string js_os {blob,maxlength(281)}
    ,string js_browser {blob,maxlength(281)}
    ,string35 js_browser_string_hash
    ,string19 browser
    ,string95 os_version
    ,boolean browser_anomaly
    ,real4 agent_wps_latitude
    ,real4 agent_wps_longitude
    ,string61 agent_cell_id
    ,string2 true_ip_region_iso_code
    ,string2 proxy_ip_region_iso_code
    ,string2 dns_ip_region_iso_code
    ,string2 input_ip_region_iso_code
    ,string fuzzy_device_id_reason_code {blob,maxlength(231)}
    ,string32 additional_data
    ,string19 event_tag
    ,string44 agent_publickey_hash
    ,string agent_publickey_hash_type {blob,maxlength(281)}
    ,string55 input_request_id
    ,string tmx_internal_variables {blob,maxlength(9338)}
    ,string5 apiversion
    ,string11 segment_name
    ,real4 html_location_latitude
    ,real4 html_location_longitude
    ,real4 html_location_accuracy
    ,real4 html_location_altitude
    ,real4 html_location_heading
    ,string webrtc_external_ip {blob,maxlength(281)}
    ,string webrtc_internal_ip {blob,maxlength(281)}
    ,string webrtc_ipv6 {blob,maxlength(281)}
    ,string107 agent_publickey_hash_activities
    ,string20 agent_publickey_hash_assert_history
    ,string107 agent_publickey_hash_attributes
    ,string10 agent_publickey_hash_first_seen
    ,string10 agent_publickey_hash_last_assertion
    ,string10 agent_publickey_hash_last_event
    ,string10 agent_publickey_hash_last_update
    ,string10 agent_publickey_hash_result
    ,integer2 agent_publickey_hash_score
    ,integer2 agent_publickey_hash_worst_score
    ,integer2 smart_learning_policy_score
    ,real4 smart_learning_risk_rank
    ,string10 smart_learning_fraud_rating
    ,real4 smart_learning_p_score
    ,string smart_learning_variables {blob,maxlength(2463)}
    ,string smart_learning_reason_code {blob,maxlength(527)}
    ,string22 smart_learning_summary_reason_code
    ,integer4 yyyymm
    ,string carrier_name
    ,string carrier_mobile_number
    ,string carrier_mobile_number_activities
    ,string carrier_mobile_number_assert_history
    ,string carrier_mobile_number_attributes
    ,string10 carrier_mobile_number_first_seen
    ,string10 carrier_mobile_number_last_assertion
    ,string10 carrier_mobile_number_last_event
    ,string10 carrier_mobile_number_last_update
    ,string carrier_mobile_number_result
    ,integer2 carrier_mobile_number_score
    ,integer2 carrier_mobile_number_worst_score
    ,string carrier_mobile_number_match_result
    ,string carrier_account
    ,string carrier_account_activities
    ,string carrier_account_assert_history
    ,string carrier_account_attributes
    ,string10 carrier_account_first_seen
    ,string10 carrier_account_last_assertion
    ,string10 carrier_account_last_event
    ,string10 carrier_account_last_update
    ,string carrier_account_result
    ,integer2 carrier_account_score
    ,integer2 carrier_account_worst_score
    ,string carrier_account_match_result
    ,string experiment_6 {blob,maxlength(4224)}
    ,string experiment_7 {blob,maxlength(3634)}
    ,string8 experiment_8
    ,string experiment_9
    ,string25 experiment_10
    ,string account_email_domain {blob,maxlength(256)}
    ,boolean private_browsing
    ,string30 policy_site_id
    ,string35 account_first_name
    ,string35 account_last_name
    ,string4 agent_device_caps
    ,integer2 virtual_machine
    ,string virtual_machine_reason
    ,string58 customer_event_type
    ,string35 application_name
    ,string line_of_business {blob,maxlength(281)}
    ,string35 local_attrib_11
    ,string35 local_attrib_12
    ,string35 local_attrib_13
    ,string35 local_attrib_14
    ,string35 local_attrib_15
    ,string35 account_date_of_birth
    ,string32 digital_id
    ,integer4 digital_id_confidence
    ,string digital_id_reason_code {blob,maxlength(446)}
    ,string107 digital_id_activities
    ,string107 digital_id_attributes
    ,string10 digital_id_first_seen
    ,string10 digital_id_last_event
    ,string10 digital_id_last_update
    ,string20 digital_id_result
    ,integer4 digital_id_score
    ,string test_digital_id
    ,integer4 test_digital_id_confidence
    ,string test_digital_id_reason_code {blob,maxlength(446)}
    ,string test_digital_id_activities
    ,string test_digital_id_attributes
    ,string10 test_digital_id_first_seen
    ,string10 test_digital_id_last_event
    ,string10 test_digital_id_last_update
    ,string test_digital_id_result
    ,integer4 test_digital_id_score
    ,real4 account_address_zip_latitude
    ,real4 account_address_zip_longitude
    ,real4 shipping_address_zip_latitude
    ,real4 shipping_address_zip_longitude
    ,string30 carrier_id_token
    ,string webgl_hash {blob,maxlength(281)}
    ,string canvas_hash {blob,maxlength(281)}
    ,string targeted_malware {blob,maxlength(385)}
    ,string local_ipv4 {blob,maxlength(281)}
    ,string local_ipv6 {blob,maxlength(281)}
    ,string mac_address {blob,maxlength(281)}
    ,string flash_version_detected
    ,string page_fingerprint_diff_names {blob,maxlength(14814)}
    ,string honeypot_fingerprint_diff_names {blob,maxlength(77561)}
    ,string40 advertising_id
    ,string99 device_imei
    ,string35 account_home_phone
    ,string35 account_work_phone
    ,string external_device_info
    ,string account_address_zip_normalized
    ,string shipping_address_zip_normalized
    ,string11 selinux_status
    ,integer2 app_integrity_score
    ,real4 custom_count_5
    ,real4 custom_count_6
    ,real4 custom_count_7
    ,real4 custom_count_8
    ,real4 custom_count_9
    ,real4 custom_count_10
    ,real4 custom_count_11
    ,real4 custom_count_12
    ,real4 custom_count_13
    ,real4 custom_count_14
    ,real4 custom_count_15
    ,string37 custom_output_11
    ,string37 custom_output_12
    ,string37 custom_output_13
    ,string37 custom_output_14
    ,string37 custom_output_15
    ,string37 custom_output_16
    ,string37 custom_output_17
    ,string37 custom_output_18
    ,string37 custom_output_19
    ,string37 custom_output_20
    ,string62 ua_os_alt
    ,string67 ua_os_version_alt
    ,string28 ua_browser_alt
    ,string66 ua_browser_version_alt
    ,integer2 virtual_device
    ,string virtual_device_reason {blob,maxlength(464)}
    ,string22 dns_ip_assert_history
    ,string dns_ip_attributes {blob,maxlength(249)}
    ,string dns_ip_activities {blob,maxlength(180)}
    ,string11 primary_industry
    ,string22 secondary_industry
    ,boolean ship_address_is_bill_address
    ,integer2 merchant_category_code
    ,string merchant_country_code {blob,maxlength(396)}
    ,string merchant_name {blob,maxlength(396)}
    ,string merchant_id {blob,maxlength(352)}
    ,string41 auth_methods
    ,string device_health_reasons {blob,maxlength(150)}
    ,string local_attrib_1_activities {blob,maxlength(517)}
    ,string local_attrib_2_activities {blob,maxlength(205)}
    ,string100 local_attrib_3_activities
    ,string local_attrib_4_activities {blob,maxlength(278)}
    ,string62 local_attrib_5_activities
    ,string102 local_attrib_6_activities
    ,string58 local_attrib_7_activities
    ,string58 local_attrib_8_activities
    ,string58 local_attrib_9_activities
    ,string74 local_attrib_10_activities
    ,string56 local_attrib_11_activities
    ,string74 local_attrib_12_activities
    ,string56 local_attrib_13_activities
    ,string56 local_attrib_14_activities
    ,string56 local_attrib_15_activities
    ,string10 local_attrib_1_first_seen
    ,string10 local_attrib_2_first_seen
    ,string10 local_attrib_3_first_seen
    ,string10 local_attrib_4_first_seen
    ,string10 local_attrib_5_first_seen
    ,string10 local_attrib_6_first_seen
    ,string10 local_attrib_7_first_seen
    ,string10 local_attrib_8_first_seen
    ,string10 local_attrib_9_first_seen
    ,string10 local_attrib_10_first_seen
    ,string10 local_attrib_11_first_seen
    ,string10 local_attrib_12_first_seen
    ,string10 local_attrib_13_first_seen
    ,string10 local_attrib_14_first_seen
    ,string10 local_attrib_15_first_seen
    ,string experiment_mobile_array {blob,maxlength(1981)}
    ,string experiment_array
    ,string70 web_session_id
    ,string122 web_session_id_activities
    ,string web_session_id_attributes
    ,string10 web_session_id_first_seen
    ,string10 web_session_id_last_event
    ,string10 web_session_id_last_update
    ,string10 web_session_id_result
    ,integer4 web_session_id_score
    ,string wurfl_info {blob,maxlength(688)}
    ,string collected_ip_addresses {blob,maxlength(2080)}
    ,string139 exact_id_health
    ,boolean use_test_apn
    ,string41 challenger_policy
    ,integer2 challenger_policy_score
    ,string challenger_reason_code {blob,maxlength(3862)}
    ,string8 challenger_risk_rating
    ,string124 challenger_summary_reason_code
    ,string7 challenger_review_status
    ,string10 digital_id_confidence_rating
    ,string digital_id_trust_score_reason_code {blob,maxlength(827)}
    ,string57 digital_id_trust_score_summary_reason_code
    ,real4 digital_id_trust_score
    ,string10 digital_id_trust_score_rating
    ,string digital_id_trust_score_variables {blob,maxlength(2421)}
    ,string rules {blob,maxlength(396)}
    ,string35 external_guid
    ,string global_third_party_cookie
    ,string national_id_type
    ,string national_id_number
    ,string threeds_comp_ind
    ,string targeted_storage {blob,maxlength(211)}
    ,string3 turn_os_sig_raw
    ,integer2 turn_os_sig_ttl
    ,string11 turn_os_signature
    ,integer4 turn_system_state
    ,integer4 turn_tcp_tstmp_rate
    ,string org_group_id
    ,string ssl_fp_client
    ,string ssl_fp_category
end;

export key_search := record
	string8 org_id;
	string8 trans_date;
	string4 trans_hhmm;
	string2 trans_ss;
	string206 api_type;
	string376 event_type;
	string32 request_id;
	boolean unknown_session;
	// string policy{blob, maxlength(281)};
	string policy;
	integer2 policy_score;
	string40 request_result;
	string15 risk_rating;
	string15 review_status;
	string35 local_attrib_1;
	string35 local_attrib_2;
	string35 local_attrib_3;
	string35 local_attrib_4;
	string35 local_attrib_5;
	string35 local_attrib_6;
	string35 local_attrib_7;
	string35 local_attrib_10;
	string35 condition_attrib_3;
	string35 condition_attrib_4;
	string35 account_login;
	string32 fuzzy_device_id;
	string35 account_email;
	string39 true_ip;
	string32 device_id;
	string35 account_number;
	string32 digital_id;
	string transaction_id;
	// string transaction_id{blob, maxlength(541)};
	string35 account_telephone;
	// string session_id{blob, maxlength(936)};
	string session_id;
	string43 input_ip_address;
	string2 true_ip_geo;
	string35 account_name;
	string35 password_hash;
	string35 ssn_hash;
	// string browser_language{blob, maxlength(281)};
	string browser_language;
	string35 headers_order_string_hash;
	string account_email_domain;
	// string account_email_domain{blob, maxlength(256)};
	// string canvas_hash{blob, maxlength(281)};
	// string webgl_hash{blob, maxlength(281)};
	string canvas_hash;
	string webgl_hash;
	string44 ua_browser;
	string35 account_address_country;
	string line_of_business;
	// string line_of_business{blob, maxlength(281)};
	string62 ua_os;
	string15 os;
	string35 account_address_zip;
	string55 input_ip_isp;
	integer4 cc_bin_number;
	string34 agent_type;
	string17 proxy_ip;
	string55 true_ip_isp;
	string35 cc_number_hash;
	string35 browser_string_hash;
	string35 local_attrib_12;
	integer4 time_zone;
	string19 browser;
	string35 account_address_city;
	unsigned recid;
end;

end;

/* KJE - OLD

EXPORT layouts := MODULE

	export input := record
	 string delta_tm_id;                                              //bigint(11) unsigned	NO	PRI	NULL	auto_increment
	 string lexid;                                                    //bigint(15) unsigned	YES	MUL	NULL	
	 string product_code;                                            //	varchar(15)	YES		NULL	
	 string idms_txn_id;                                            //	varchar(25)	YES		NULL	
	 string esp_txn_id;                                             //	varchar(25)	YES		NULL	
	 string device_id;                                             //	varchar(50)	YES	MUL	NULL	
	 string policy_score ;                                         //	int(10)	YES		NULL	//changed from device_score to policy_score per Product
	 string risk_classification;	                                  //varchar(32)	YES		NULL	
	 string review_status;                                          //	varchar(32)	YES		NULL	
	 string session_id;                                              //	varchar(128)	YES		NULL	
	 string org_id;                                                //	varchar(32)	YES		NULL	
	 string policy;                                                  //	varchar(50)	YES		NULL	
	 string event_type;                                            //	varchar(32)	YES		NULL	
	 string service_type;                                          //	varchar(255)	YES		NULL	
	 string input_json;                                             //	text	YES		NULL	
	 string output_json;                                            //	text	YES		NULL	
	 string date_added;                                             //datetime	NO	PRI	CURRENT_TIMESTAMP	
	End;


	import iesp;
			
	export t_TrustDefenderAddress := record
		string255 AddressCity {xpath('AddressCity')};
		string2 AddressCountry {xpath('AddressCountry')};
		string255 AddressState {xpath('AddressState')};
		string255 AddressStreet1 {xpath('AddressStreet1')};
		string255 AddressStreet2 {xpath('AddressStreet2')};
		string8 AddressZip {xpath('AddressZip')};
	end;
			
	export t_TrustDefenderAccount := record
		t_TrustDefenderAddress AccountAddress {xpath('AccountAddress')};
		string255 AccountEmail {xpath('AccountEmail')};
		string255 AccountLogin {xpath('AccountLogin')};
		string255 AccountName {xpath('AccountName')};
		string255 AccountNumber {xpath('AccountNumber')};
		string32 AccountTelephone {xpath('AccountTelephone')};
	end;
			
	export t_TrustDefenderIdentity := record
		t_TrustDefenderAccount TrustDefenderAccount {xpath('TrustDefenderAccount')};
		string40 DriversLicenceNumberHash {xpath('DriversLicenceNumberHash')};
		string40 PasswordHash {xpath('PasswordHash')};
		t_TrustDefenderAddress ShippingAddress {xpath('ShippingAddress')};
		string40 SsnHash {xpath('SsnHash')};
	end;
			
	export t_TrustDefenderDevice := record
		string36 DeviceId {xpath('DeviceId')};
		string255 OnlineIdHandle {xpath('OnlineIdHandle')};
		string255 OnlineTld {xpath('OnlineTld')};
	end;
			
	export t_TrustDefenderPayment := record
		string40 AchAccountHash {xpath('AchAccountHash')};
		string9 AchRoutingNumber {xpath('AchRoutingNumber')};
		string6 CcBinNumber {xpath('CcBinNumber')};
		string40 CcNumberHash {xpath('CcNumberHash')};
		string255 PaymentGatewayProvider {xpath('PaymentGatewayProvider')};
		string255 PaymentRequestType {xpath('PaymentRequestType')};
		string255 PaymentResponse {xpath('PaymentResponse')};
		string255 PaymentResponseCode {xpath('PaymentResponseCode')};
		string255 ProcessingProvider {xpath('ProcessingProvider')};
		string16 SettlementAmount {xpath('SettlementAmount')};
		string3 SettlementCurrency {xpath('SettlementCurrency')};
		string16 TransactionAmount {xpath('TransactionAmount')};
		string16 TransactionAuthAmount {xpath('TransactionAuthAmount')};
		string3 TransactionAuthCurrency {xpath('TransactionAuthCurrency')};
		string3 TransactionCurrency {xpath('TransactionCurrency')};
		string64 TransactionId {xpath('TransactionId')};
		string16 TransactionShippingAmount {xpath('TransactionShippingAmount')};
		string3 TransactionShippingCurrency {xpath('TransactionShippingCurrency')};
	end;
			
	export t_TrustDefenderConditionalAttributes := record
		string255 ConditionAttrib1 {xpath('ConditionAttrib1')};
		string255 ConditionAttrib2 {xpath('ConditionAttrib2')};
		string255 ConditionAttrib3 {xpath('ConditionAttrib3')};
		string255 ConditionAttrib4 {xpath('ConditionAttrib4')};
		string255 ConditionAttrib5 {xpath('ConditionAttrib5')};
		string255 ConditionAttrib6 {xpath('ConditionAttrib6')};
		string255 ConditionAttrib7 {xpath('ConditionAttrib7')};
		string255 ConditionAttrib8 {xpath('ConditionAttrib8')};
		string255 ConditionAttrib9 {xpath('ConditionAttrib9')};
		string255 ConditionAttrib10 {xpath('ConditionAttrib10')};
		string255 ConditionAttrib11 {xpath('ConditionAttrib11')};
		string255 ConditionAttrib12 {xpath('ConditionAttrib12')};
		string255 ConditionAttrib13 {xpath('ConditionAttrib13')};
		string255 ConditionAttrib14 {xpath('ConditionAttrib14')};
		string255 ConditionAttrib15 {xpath('ConditionAttrib15')};
		string255 ConditionAttrib16 {xpath('ConditionAttrib16')};
		string255 ConditionAttrib17 {xpath('ConditionAttrib17')};
		string255 ConditionAttrib18 {xpath('ConditionAttrib18')};
		string255 UnencryptedConditionAttrib1 {xpath('UnencryptedConditionAttrib1')};
		string255 UnencryptedConditionAttrib2 {xpath('UnencryptedConditionAttrib2')};
	end;
			
	export t_TrustDefenderCustomAttributes := record
		string255 LocalAttribute1 {xpath('LocalAttribute1')};
		string255 LocalAttribute2 {xpath('LocalAttribute2')};
		string255 LocalAttribute3 {xpath('LocalAttribute3')};
		string255 LocalAttribute4 {xpath('LocalAttribute4')};
		string255 LocalAttribute5 {xpath('LocalAttribute5')};
		string255 LocalAttribute6 {xpath('LocalAttribute6')};
		string255 LocalAttribute7 {xpath('LocalAttribute7')};
		string255 LocalAttribute8 {xpath('LocalAttribute8')};
		string255 LocalAttribute9 {xpath('LocalAttribute9')};
		string255 LocalAttribute10 {xpath('LocalAttribute10')};
	end;
			
	export t_TrustDefenderUserAccount := record
		string255 OrgId {xpath('OrgId')};
		string255 ApiKey {xpath('ApiKey')};
	end;
			
	 export t_TrustDefenderRequestParameters := record
		string138 SessionId {xpath('SessionId')};
		string10 FinalReviewStatus {xpath('FinalReviewStatus')};
		string40 RequestId {xpath('RequestId')};
		string TagBehavior {xpath('TagBehavior')}; //values['','update','insert','remove','']
		string TagContext {xpath('TagContext')}; //values['','_A_CAPCH','_A_URPWD','_A_BANK','_A_SMS','_A_VOICE','_A_OTPS','_A_OTPH','_A_KBAMN','_A_KBAAV','_A_KBAMX','_A_BIOV','_A_BIOF','_A_BIO','_A_DOCUM','_A_EMAIL','_A_ADDRS','_A_CELL','_A_IDVER','_A_ANLYST','_A_PAYMT','_A_SOC','_A_GEO','_I_BANK','_I_BROK','_I_NBFI','_I_TELC','_I_UTIL','_I_RESO','_I_SOCL','_I_TRVL','_I_ACCOM','_I_GAME','_I_DIGT','_I_AUCT','_I_CLSFD','_I_MRKT','_I_ACCT','_I_LEGAL','_I_HLTH','_I_SAAS','_I_GOV','_I_EDU','_P_ADDR','_P_CARD','_P_FUNDS','_T_TOR','_T_BOT','_T_IPADD','_T_GEOSP','_T_IDSPF','_T_DIDSP','_T_MALW','_T_MITM','']
		string TagName {xpath('TagName')}; //values['','_LOGIN_PASSED','_LOGIN_FAILED','_AUTH_PASSED','_AUTH_FAILED','_ACCEPTED','_REJECTED','_FALSE_POSITIVE','_FALSE_NEGATIVE','_REVIEWED','_REVIEW_PASSED','_REVIEW_FAILED','CHALLENGED','_CHALLENGE_FAILED','_CHALLENGE_PASSED','_FRAUD_PAYMENT','_FRAUD_IDENTITY','_FRAUD_BREACH','_FRAUD_MONEY_LAUNDERING','_FRAUD_MONEY_TRANSFER','_FRAUD_INTERNAL','_FRAUD_MOTO','_WATCH','_COMPROMISED','_TRUSTED','_PRIVILEGED','_THREAT','_LOCK','']
		string3 TagEntityLogic {xpath('TagEntityLogic')};
		string TagTimeStamp {xpath('TagTimeStamp')};
		string TagTimeFrame {xpath('TagTimeFrame')};
		string Notes {xpath('Notes')};
		dataset(iesp.share.t_StringArrayItem) TmxReasonCodes {xpath('TmxReasonCodes/TmxReasonCode'), MAXCOUNT(1)};
	end;
			
	 export t_TrustDefenderOptions := record (iesp.share.t_BaseOption)
		t_TrustDefenderUserAccount TrustDefenderUserAccount {xpath('TrustDefenderUserAccount')};
		string50 Policy {xpath('Policy')};
		string ServiceType {xpath('ServiceType')}; //values['','session-policy','device','did','ip','session','all','']
		string ApiType {xpath('ApiType')}; //values['SessionQuery','AttributeQuery','Update','Query','']
		string UpdateApiAction {xpath('UpdateApiAction')}; //values['','update_review_status','set_trust_tag','remove_trust_tag','add_black_list','add_white_list','add_watch_list','remove_black_list','remove_white_list','remove_watch_list','']
		string QueryApiAction {xpath('QueryApiAction')}; //values['','check_review_status','check_trust_tag','check_black_list','check_white_list','check_watch_list','']
		string EventType {xpath('EventType')}; //values['','LOGIN','PAYMENT','ACCOUNT_CREATION','TRANSFER','AUCTION_BID','DETAILS_CHANGE','ADD_LISTING','ACCOUNT_BALANCE','TRANSACTION_HISTORY','DIGITAL_DOWNLOAD','DIGITAL_STREAM','']
		integer4 ProductCode {xpath('ProductCode')};
	end;
			
	export t_TrustDefenderSearchBy := record
		t_TrustDefenderRequestParameters RequestParameters {xpath('RequestParameters')};
		t_TrustDefenderIdentity Identity {xpath('Identity')};
		t_TrustDefenderDevice DeviceData {xpath('DeviceData')};
		t_TrustDefenderPayment PaymentData {xpath('PaymentData')};
		t_TrustDefenderConditionalAttributes ConditionalAttributes {xpath('ConditionalAttributes')};
		t_TrustDefenderCustomAttributes CustomAttributes {xpath('CustomAttributes')};
	end;
			
	export t_TagWithMessage := record, MAXLENGTH (255)
		string _Value {xpath('_Value')};
		string Content {xpath('Content')};
	end;
			
	export t_TrustDefenderDetailedResponse := record
		t_TagWithMessage AccountAddress {xpath('AccountAddress')};
		t_TagWithMessage AccountAddressCity {xpath('AccountAddressCity')};
		t_TagWithMessage AccountAddressCountry {xpath('AccountAddressCountry')};
		t_TagWithMessage AccountAddressState {xpath('AccountAddressState')};
		t_TagWithMessage AccountAddressStreet1 {xpath('AccountAddressStreet1')};
		t_TagWithMessage AccountAddressStreet2 {xpath('AccountAddressStreet2')};
		t_TagWithMessage AccountAddressZip {xpath('AccountAddressZip')};
		dataset(iesp.share.t_StringArrayItem) AccountAddressActivityRecords {xpath('AccountAddressActivityRecords/AccountAddressActivities'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) AccountAddressAssertHistoryRecords {xpath('AccountAddressAssertHistoryRecords/AccountAddressAssertHistory'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) AccountAddressAttributeRecords {xpath('AccountAddressAttributeRecords/AccountAddressAttributes'), MAXCOUNT(1)};
		string10 AccountAddressFirstSeen {xpath('AccountAddressFirstSeen')};
		string10 AccountAddressLastAssertion {xpath('AccountAddressLastAssertion')};
		string10 AccountAddressLastEvent {xpath('AccountAddressLastEvent')};
		string10 AccountAddressLastUpdate {xpath('AccountAddressLastUpdate')};
		string10 AccountAddressResult {xpath('AccountAddressResult')};
		integer AccountAddressScore {xpath('AccountAddressScore')};
		integer AccountAddressWorstScore {xpath('AccountAddressWorstScore')};
		t_TagWithMessage AccountEmail {xpath('AccountEmail')};
		dataset(iesp.share.t_StringArrayItem) AccountEmailActivityRecords {xpath('AccountEmailActivityRecords/AccountEmailActivities'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) AccountEmailAssertHistoryRecords {xpath('AccountEmailAssertHistoryRecords/AccountEmailAssertHistory'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) AccountEmailAttributeRecords {xpath('AccountEmailAttributeRecords/AccountEmailAttributes'), MAXCOUNT(1)};
		string10 AccountEmailFirstSeen {xpath('AccountEmailFirstSeen')};
		string10 AccountEmailLastAssertion {xpath('AccountEmailLastAssertion')};
		string10 AccountEmailLastEvent {xpath('AccountEmailLastEvent')};
		string10 AccountEmailLastUpdate {xpath('AccountEmailLastUpdate')};
		string10 AccountEmailResult {xpath('AccountEmailResult')};
		integer AccountEmailScore {xpath('AccountEmailScore')};
		integer AccountEmailWorstScore {xpath('AccountEmailWorstScore')};
		t_TagWithMessage AccountLogin {xpath('AccountLogin')};
		dataset(iesp.share.t_StringArrayItem) AccountLoginActivityRecords {xpath('AccountLoginActivityRecords/AccountLoginActivities'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) AccountLoginAssertHistoryRecords {xpath('AccountLoginAssertHistoryRecords/AccountLoginAssertHistory'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) AccountLogAttribueRecords {xpath('AccountLogAttribueRecords/AccountLoginAttributes'), MAXCOUNT(1)};
		string10 AccountLoginFirstSeen {xpath('AccountLoginFirstSeen')};
		string10 AccountLoginLastAssertion {xpath('AccountLoginLastAssertion')};
		string10 AccountLoginLastEvent {xpath('AccountLoginLastEvent')};
		string10 AccountLoginLastUpdate {xpath('AccountLoginLastUpdate')};
		string10 AccountLoginResult {xpath('AccountLoginResult')};
		integer AccountLoginScore {xpath('AccountLoginScore')};
		integer AccountLoginWorstScore {xpath('AccountLoginWorstScore')};
		t_TagWithMessage AccountName {xpath('AccountName')};
		dataset(iesp.share.t_StringArrayItem) AccountNameActivityRecords {xpath('AccountNameActivityRecords/AccountNameActivities'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) AccountNameAssertHistoryRecords {xpath('AccountNameAssertHistoryRecords/AccountNameAssertHistory'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) AccountNameAttributeRecords {xpath('AccountNameAttributeRecords/AccountNameAttributes'), MAXCOUNT(1)};
		string10 AccountNameFirstSeen {xpath('AccountNameFirstSeen')};
		string10 AccountNameLastAssertion {xpath('AccountNameLastAssertion')};
		string10 AccountNameLastEvent {xpath('AccountNameLastEvent')};
		string10 AccountNameLastUpdate {xpath('AccountNameLastUpdate')};
		string10 AccountNameResult {xpath('AccountNameResult')};
		integer AccountNameScore {xpath('AccountNameScore')};
		integer AccountNameWorstScore {xpath('AccountNameWorstScore')};
		t_TagWithMessage AccountNumber {xpath('AccountNumber')};
		dataset(iesp.share.t_StringArrayItem) AccountNumberActivityRecords {xpath('AccountNumberActivityRecords/AccountNumberActivities'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) AccountNumberAssertHistoryRecords {xpath('AccountNumberAssertHistoryRecords/AccountNumberAssertHistory'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) AccountNumberAttributeRecords {xpath('AccountNumberAttributeRecords/AccountNumberAttributes'), MAXCOUNT(1)};
		string10 AccountNumberFirstSeen {xpath('AccountNumberFirstSeen')};
		string10 AccountNumberLastAssertion {xpath('AccountNumberLastAssertion')};
		string10 AccountNumberLastEvent {xpath('AccountNumberLastEvent')};
		string10 AccountNumberLastUpdate {xpath('AccountNumberLastUpdate')};
		string10 AccountNumberResult {xpath('AccountNumberResult')};
		integer AccountNumberScore {xpath('AccountNumberScore')};
		integer AccountNumberWorstScore {xpath('AccountNumberWorstScore')};
		t_TagWithMessage AccountTelephone {xpath('AccountTelephone')};
		dataset(iesp.share.t_StringArrayItem) AccountTelephoneActivityRecords {xpath('AccountTelephoneActivityRecords/AccountTelephoneActivities'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) AccountTelephoneAssertHistoryRecords {xpath('AccountTelephoneAssertHistoryRecords/AccountTelephoneAssertHistory'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) AccountTelephoneAttributeRecords {xpath('AccountTelephoneAttributeRecords/AccountTelephoneAttributes'), MAXCOUNT(1)};
		string10 AccountTelephoneFirstSeen {xpath('AccountTelephoneFirstSeen')};
		string10 AccountTelephoneLastAssertion {xpath('AccountTelephoneLastAssertion')};
		string10 AccountTelephoneLastEvent {xpath('AccountTelephoneLastEvent')};
		string10 AccountTelephoneLastUpdate {xpath('AccountTelephoneLastUpdate')};
		string10 AccountTelephoneResult {xpath('AccountTelephoneResult')};
		integer AccountTelephoneScore {xpath('AccountTelephoneScore')};
		integer AccountTelephoneWorstScore {xpath('AccountTelephoneWorstScore')};
		string40 AchAccountHash {xpath('AchAccountHash')};
		t_TagWithMessage AchNumber {xpath('AchNumber')};
		dataset(iesp.share.t_StringArrayItem) AchNumberActivityRecords {xpath('AchNumberActivityRecords/AchNumberActivities'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) AchNumberAssertHistoryRecords {xpath('AchNumberAssertHistoryRecords/AchNumberAssertHistory'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) AchNumberAttributeRecords {xpath('AchNumberAttributeRecords/AchNumberAttributes'), MAXCOUNT(1)};
		string10 AchNumberFirstSeen {xpath('AchNumberFirstSeen')};
		string10 AchNumberLastAssertion {xpath('AchNumberLastAssertion')};
		string10 AchNumberLastEvent {xpath('AchNumberLastEvent')};
		string10 AchNumberLastUpdate {xpath('AchNumberLastUpdate')};
		string10 AchNumberResult {xpath('AchNumberResult')};
		integer AchNumberScore {xpath('AchNumberScore')};
		integer AchNumberWorstScore {xpath('AchNumberWorstScore')};
		string9 AchRoutingNumber {xpath('AchRoutingNumber')};
		string20 Action {xpath('Action')};
		string32 AgentBrand {xpath('AgentBrand')};
		t_TagWithMessage AgentDeviceId {xpath('AgentDeviceId')};
		dataset(iesp.share.t_StringArrayItem) AgentDeviceIdActivityRecords {xpath('AgentDeviceIdActivityRecords/AgentDeviceIdActivities'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) AgentDeviceIdAssertHistoryRecords {xpath('AgentDeviceIdAssertHistoryRecords/AgentDeviceIdAssertHistory'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) AgentDeviceIdAttributeRecords {xpath('AgentDeviceIdAttributeRecords/AgentDeviceIdAttributes'), MAXCOUNT(1)};
		string10 AgentDeviceIdFirstSeen {xpath('AgentDeviceIdFirstSeen')};
		string10 AgentDeviceIdLastAssertion {xpath('AgentDeviceIdLastAssertion')};
		string10 AgentDeviceIdLastEvent {xpath('AgentDeviceIdLastEvent')};
		string10 AgentDeviceIdLastUpdate {xpath('AgentDeviceIdLastUpdate')};
		string10 AgentDeviceIdResult {xpath('AgentDeviceIdResult')};
		integer AgentDeviceIdScore {xpath('AgentDeviceIdScore')};
		integer AgentDeviceIdWorstScore {xpath('AgentDeviceIdWorstScore')};
		string40 AgentDeviceState {xpath('AgentDeviceState')};
		string24 AgentEventTime {xpath('AgentEventTime')};
		string256 AgentHealthDetails {xpath('AgentHealthDetails')};
		string10 AgentHealthStatus {xpath('AgentHealthStatus')};
		string8 AgentLanguage {xpath('AgentLanguage')};
		string8 AgentLocale {xpath('AgentLocale')};
		string64 AgentModel {xpath('AgentModel')};
		string256 AgentOs {xpath('AgentOs')};
		string32 AgentOsVersion {xpath('AgentOsVersion')};
		string64 AgentSessionId {xpath('AgentSessionId')};
		string128 AgentType {xpath('AgentType')};
		string12 AgentVersion {xpath('AgentVersion')};
		t_TagWithMessage ApiSiteId {xpath('ApiSiteId')};
		string20 ApiType {xpath('ApiType')};
		varstring ApprepInstalledBenign {xpath('ApprepInstalledBenign'), maxlength(65535)}; // Xsd type: string
		varstring ApprepInstalledMalicious {xpath('ApprepInstalledMalicious'), maxlength(65535)}; // Xsd type: string
		varstring ApprepInstalledModerate {xpath('ApprepInstalledModerate'), maxlength(65535)}; // Xsd type: string
		varstring ApprepInstalledSuspicious {xpath('ApprepInstalledSuspicious'), maxlength(65535)}; // Xsd type: string
		varstring ApprepInstalledUnknown {xpath('ApprepInstalledUnknown'), maxlength(65535)}; // Xsd type: string
		varstring ApprepInstalledUnwanted {xpath('ApprepInstalledUnwanted'), maxlength(65535)}; // Xsd type: string
		integer ApprepInstalledApps {xpath('ApprepInstalledApps')};
		varstring ApprepRunningBenign {xpath('ApprepRunningBenign'), maxlength(65535)}; // Xsd type: string
		varstring ApprepRunningMalicious {xpath('ApprepRunningMalicious'), maxlength(65535)}; // Xsd type: string
		varstring ApprepRunningModerate {xpath('ApprepRunningModerate'), maxlength(65535)}; // Xsd type: string
		varstring ApprepRunningSuspicious {xpath('ApprepRunningSuspicious'), maxlength(65535)}; // Xsd type: string
		varstring ApprepRunningUnknown {xpath('ApprepRunningUnknown'), maxlength(65535)}; // Xsd type: string
		varstring ApprepRunningUnwanted {xpath('ApprepRunningUnwanted'), maxlength(65535)}; // Xsd type: string
		integer ApprepRunningApps {xpath('ApprepRunningApps')};
		string12 ApprepSelfhashCategory {xpath('ApprepSelfhashCategory')};
		string32 ApprepSelfhash {xpath('ApprepSelfhash')};
		string8 AvEnabled {xpath('AvEnabled')};
		string256 AvName {xpath('AvName')};
		string8 AvUptodate {xpath('AvUptodate')};
		string64 Browser {xpath('Browser')};
		string3 BrowserLanguageAnomaly {xpath('BrowserLanguageAnomaly')};
		string255 BrowserLanguage {xpath('BrowserLanguage')};
		string64 BrowserProcess {xpath('BrowserProcess')};
		string3 BrowserStringAnomaly {xpath('BrowserStringAnomaly')};
		string32 BrowserStringHash {xpath('BrowserStringHash')};
		string3 BrowserStringMismatch {xpath('BrowserStringMismatch')};
		string255 BrowserString {xpath('BrowserString')};
		string32 BrowserVersion {xpath('BrowserVersion')};
		string32 CcBinNumberBrand {xpath('CcBinNumberBrand')};
		string32 CcBinNumberCategory {xpath('CcBinNumberCategory')};
		string2 CcBinNumberGeo {xpath('CcBinNumberGeo')};
		string128 CcBinNumberOrg {xpath('CcBinNumberOrg')};
		string12 CcBinNumberType {xpath('CcBinNumberType')};
		string6 CcBinNumber {xpath('CcBinNumber')};
		string40 CcNumberHash {xpath('CcNumberHash')};
		integer CidrNumber {xpath('CidrNumber')};
		string3 CssImageLoaded {xpath('CssImageLoaded')};
		integer CustomCount1 {xpath('CustomCount1')};
		integer CustomCount2 {xpath('CustomCount2')};
		integer CustomCount3 {xpath('CustomCount3')};
		integer CustomCount4 {xpath('CustomCount4')};
		string32 CustomMatch1 {xpath('CustomMatch1')};
		string32 CustomMatch2 {xpath('CustomMatch2')};
		string32 CustomMatch3 {xpath('CustomMatch3')};
		string32 CustomMatch4 {xpath('CustomMatch4')};
		string32 CustomMatch5 {xpath('CustomMatch5')};
		string32 CustomMatch6 {xpath('CustomMatch6')};
		string32 CustomMatch7 {xpath('CustomMatch7')};
		string32 CustomMatch8 {xpath('CustomMatch8')};
		string255 CustomMobile1 {xpath('CustomMobile1')};
		string255 CustomMobile2 {xpath('CustomMobile2')};
		string255 CustomMobile3 {xpath('CustomMobile3')};
		string255 CustomMobile4 {xpath('CustomMobile4')};
		string255 CustomMobile5 {xpath('CustomMobile5')};
		integer CustomPolicyScore {xpath('CustomPolicyScore')};
		string32 Datetime {xpath('Datetime')};
		string3 DetectedFl {xpath('DetectedFl')};
		string40 DeviceFingerprint {xpath('DeviceFingerprint')};
		t_TagWithMessage DeviceId {xpath('DeviceId')};
		string6 DeviceIdConfidence {xpath('DeviceIdConfidence')};
		dataset(iesp.share.t_StringArrayItem) DeviceActivityRecords {xpath('DeviceActivityRecords/DeviceActivities'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) DeviceAssertHistoryRecords {xpath('DeviceAssertHistoryRecords/DeviceAssertHistory'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) DeviceAttributeRecords {xpath('DeviceAttributeRecords/DeviceAttributes'), MAXCOUNT(1)};
		string10 DeviceFirstSeen {xpath('DeviceFirstSeen')};
		string10 DeviceLastAssertion {xpath('DeviceLastAssertion')};
		string10 DeviceLastEvent {xpath('DeviceLastEvent')};
		string10 DeviceLastUpdate {xpath('DeviceLastUpdate')};
		integer DeviceScore {xpath('DeviceScore')};
		integer DeviceWorstScore {xpath('DeviceWorstScore')};
		string32 DeviceMatchResult {xpath('DeviceMatchResult')};
		string32 DeviceResult {xpath('DeviceResult')};
		string50 DnsIpCity {xpath('DnsIpCity')};
		string2 DnsIpGeo {xpath('DnsIpGeo')};
		string50 DnsIpIsp {xpath('DnsIpIsp')};
		string10 DnsIpLatitude {xpath('DnsIpLatitude')};
		string11 DnsIpLongitude {xpath('DnsIpLongitude')};
		string50 DnsIpOrganization {xpath('DnsIpOrganization')};
		string5 DnsIpRegion {xpath('DnsIpRegion')};
		string64 DnsIp {xpath('DnsIp')};
		t_TagWithMessage DriversLicenceNumberHash {xpath('DriversLicenceNumberHash')};
		dataset(iesp.share.t_StringArrayItem) DriversLicenceNumberHashActivityRecords {xpath('DriversLicenceNumberHashActivityRecords/DriversLicenceNumberHashActivities'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) DriversLicenceNumberHashAssertHistoryRecords {xpath('DriversLicenceNumberHashAssertHistoryRecords/DriversLicenceNumberHashAssertHistory'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) DriversLicenceNumberHashAttributeRecords {xpath('DriversLicenceNumberHashAttributeRecords/DriversLicenceNumberHashAttributes'), MAXCOUNT(1)};
		string10 DriversLicenceNumberHashFirstSeen {xpath('DriversLicenceNumberHashFirstSeen')};
		string10 DriversLicenceNumberHashLastAssertion {xpath('DriversLicenceNumberHashLastAssertion')};
		string10 DriversLicenceNumberHashLastEvent {xpath('DriversLicenceNumberHashLastEvent')};
		string10 DriversLicenceNumberHashLastUpdate {xpath('DriversLicenceNumberHashLastUpdate')};
		string10 DriversLicenceNumberHashResult {xpath('DriversLicenceNumberHashResult')};
		integer DriversLicenceNumberHashScore {xpath('DriversLicenceNumberHashScore')};
		integer DriversLicenceNumberHashWorstScore {xpath('DriversLicenceNumberHashWorstScore')};
		string3 EnabledCk {xpath('EnabledCk')};
		string3 EnabledFl {xpath('EnabledFl')};
		string3 EnabledIm {xpath('EnabledIm')};
		string3 EnabledJs {xpath('EnabledJs')};
		string32 EnabledServices {xpath('EnabledServices')};
		string255 ErrorDetail {xpath('ErrorDetail')};
		string32 EtagGuid {xpath('EtagGuid')};
		t_TagWithMessage EventType {xpath('EventType')};
		string32 ExtraPortConn {xpath('ExtraPortConn')};
		string40 FinalReviewStatus {xpath('FinalReviewStatus')};
		string32 FirstPartyCookie {xpath('FirstPartyCookie')};
		string3 FlashAnomaly {xpath('FlashAnomaly')};
		string32 FlashGuid {xpath('FlashGuid')};
		string255 FlashLang {xpath('FlashLang')};
		string255 FlashOs {xpath('FlashOs')};
		string255 FlashVersion {xpath('FlashVersion')};
		string6 FuzzyDeviceIdConfidence {xpath('FuzzyDeviceIdConfidence')};
		string36 FuzzyDeviceId {xpath('FuzzyDeviceId')};
		dataset(iesp.share.t_StringArrayItem) FuzzyDeviceActivityRecords {xpath('FuzzyDeviceActivityRecords/FuzzyDeviceActivities'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) FuzzyDeviceAssertHistoryRecords {xpath('FuzzyDeviceAssertHistoryRecords/FuzzyDeviceAssertHistory'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) FuzzyDeviceAttributeRecords {xpath('FuzzyDeviceAttributeRecords/FuzzyDeviceAttributes'), MAXCOUNT(1)};
		string10 FuzzyDeviceFirstSeen {xpath('FuzzyDeviceFirstSeen')};
		string10 FuzzyDeviceLastAssertion {xpath('FuzzyDeviceLastAssertion')};
		string10 FuzzyDeviceLastEvent {xpath('FuzzyDeviceLastEvent')};
		string10 FuzzyDeviceLastUpdate {xpath('FuzzyDeviceLastUpdate')};
		string32 FuzzyDeviceMatchResult {xpath('FuzzyDeviceMatchResult')};
		string32 FuzzyDeviceResult {xpath('FuzzyDeviceResult')};
		integer FuzzyDeviceScore {xpath('FuzzyDeviceScore')};
		integer FuzzyDeviceWorstScore {xpath('FuzzyDeviceWorstScore')};
		string256 FwName {xpath('FwName')};
		string256 FwStatus {xpath('FwStatus')};
		string128 HddEncryptionName {xpath('HddEncryptionName')};
		string5 HddEncryptionStatus {xpath('HddEncryptionStatus')};
		string32 HeadersNameValueHash {xpath('HeadersNameValueHash')};
		string32 HeadersOrderStringHash {xpath('HeadersOrderStringHash')};
		string5 HoneypotFingerprintCheck {xpath('HoneypotFingerprintCheck')};
		string255 HoneypotFingerprintDiff {xpath('HoneypotFingerprintDiff')};
		string32 HoneypotFingerprintMatch {xpath('HoneypotFingerprintMatch')};
		string40 HoneypotFingerprint {xpath('HoneypotFingerprint')};
		varstring HoneypotUnknownDiff {xpath('HoneypotUnknownDiff'), maxlength(65535)}; // Xsd type: string
		integer HttpOsSigAdvMss {xpath('HttpOsSigAdvMss')};
		string255 HttpOsSigRaw {xpath('HttpOsSigRaw')};
		integer HttpOsSigRcvMss {xpath('HttpOsSigRcvMss')};
		integer HttpOsSigSndMss {xpath('HttpOsSigSndMss')};
		integer HttpOsSigTtl {xpath('HttpOsSigTtl')};
		string128 HttpOsSignature {xpath('HttpOsSignature')};
		string12 HttpRefererDomainResult {xpath('HttpRefererDomainResult')};
		string255 HttpRefererDomain {xpath('HttpRefererDomain')};
		string255 HttpRefererUrl {xpath('HttpRefererUrl')};
		string32 HttpReferer {xpath('HttpReferer')};
		string7 HwGpsAccuracy {xpath('HwGpsAccuracy')};
		string10 HwLatitude {xpath('HwLatitude')};
		string11 HwLongitude {xpath('HwLongitude')};
		string3 ImageAnomaly {xpath('ImageAnomaly')};
		string3 ImageLoaded {xpath('ImageLoaded')};
		t_TagWithMessage InputIpCity {xpath('InputIpCity')};
		dataset(iesp.share.t_StringArrayItem) InputIpCityActivityRecords {xpath('InputIpCityActivityRecords/InputIpCityActivities'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) InputIpCityAssertHistoryRecords {xpath('InputIpCityAssertHistoryRecords/InputIpCityAssertHistory'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) InputIpCityAttributeRecords {xpath('InputIpCityAttributeRecords/InputIpCityAttributes'), MAXCOUNT(1)};
		string10 InputIpCityFirstSeen {xpath('InputIpCityFirstSeen')};
		string10 InputIpCityLastAssertion {xpath('InputIpCityLastAssertion')};
		string10 InputIpCityLastEvent {xpath('InputIpCityLastEvent')};
		string10 InputIpCityLastUpdate {xpath('InputIpCityLastUpdate')};
		string10 InputIpCityHashResult {xpath('InputIpCityHashResult')};
		integer InputIpCityScore {xpath('InputIpCityScore')};
		integer InputIpCityWorstScore {xpath('InputIpCityWorstScore')};
		string64 InputIpAddress {xpath('InputIpAddress')};
		string2 InputIpGeo {xpath('InputIpGeo')};
		string50 InputIpIsp {xpath('InputIpIsp')};
		string10 InputIpLatitude {xpath('InputIpLatitude')};
		string11 InputIpLongitude {xpath('InputIpLongitude')};
		string50 InputIpOrganization {xpath('InputIpOrganization')};
		string50 InputIpRegion {xpath('InputIpRegion')};
		string40 InputRequestId {xpath('InputRequestId')};
		string255 JbRootReason {xpath('JbRootReason')};
		integer JbRoot {xpath('JbRoot')};
		string64 JsBrowser {xpath('JsBrowser')};
		string255 JsBrowserString {xpath('JsBrowserString')};
		string32 JsBrowserStringHash {xpath('JsBrowserStringHash')};
		string32 JsFontsHash {xpath('JsFontsHash')};
		string255 JsFontsList {xpath('JsFontsList')};
		integer JsFontsNumber {xpath('JsFontsNumber')};
		string32 JsOs {xpath('JsOs')};
		t_TagWithMessage LocalAttrib1 {xpath('LocalAttrib1')};
		t_TagWithMessage LocalAttrib2 {xpath('LocalAttrib2')};
		t_TagWithMessage LocalAttrib3 {xpath('LocalAttrib3')};
		t_TagWithMessage LocalAttrib4 {xpath('LocalAttrib4')};
		t_TagWithMessage LocalAttrib5 {xpath('LocalAttrib5')};
		t_TagWithMessage LocalAttrib6 {xpath('LocalAttrib6')};
		t_TagWithMessage LocalAttrib7 {xpath('LocalAttrib7')};
		t_TagWithMessage LocalAttrib8 {xpath('LocalAttrib8')};
		t_TagWithMessage LocalAttrib9 {xpath('LocalAttrib9')};
		t_TagWithMessage LocalAttrib10 {xpath('LocalAttrib10')};
		string11 LocalTimeOffsetRange {xpath('LocalTimeOffsetRange')};
		string11 LocalTimeOffset {xpath('LocalTimeOffset')};
		string32 MimeTypeHash {xpath('MimeTypeHash')};
		integer MimeTypeNumber {xpath('MimeTypeNumber')};
		string3 MultipleSessionId {xpath('MultipleSessionId')};
		integer OffsetMeasureTime {xpath('OffsetMeasureTime')};
		string255 OnlineIdHandle {xpath('OnlineIdHandle')};
		string255 OnlineId {xpath('OnlineId')};
		string255 OnlineTld {xpath('OnlineTld')};
		string20 OrgId {xpath('OrgId')};
		string32 Os {xpath('Os')};
		string3 OsAnomaly {xpath('OsAnomaly')};
		integer OsDaysupdated {xpath('OsDaysupdated')};
		string32 OsFontsHash {xpath('OsFontsHash')};
		integer OsFontsNumber {xpath('OsFontsNumber')};
		string128 OsUpdateStrategy {xpath('OsUpdateStrategy')};
		string32 OsVersion {xpath('OsVersion')};
		string5 PageFingerprintCheck {xpath('PageFingerprintCheck')};
		string255 PageFingerprintDiff {xpath('PageFingerprintDiff')};
		string32 PageFingerprintMatch {xpath('PageFingerprintMatch')};
		t_TagWithMessage PageFingerprint {xpath('PageFingerprint')};
		dataset(iesp.share.t_StringArrayItem) PageFingerprintActivityRecords {xpath('PageFingerprintActivityRecords/PageFingerprintActivities'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) PageFingerprintAssertHistoryRecords {xpath('PageFingerprintAssertHistoryRecords/PageFingerprintAssertHistory'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) PageFingerprintAttributeRecords {xpath('PageFingerprintAttributeRecords/PageFingerprintAttributes'), MAXCOUNT(1)};
		string10 PageFingerprintFirstSeen {xpath('PageFingerprintFirstSeen')};
		string10 PageFingerprintLastAssertion {xpath('PageFingerprintLastAssertion')};
		string10 PageFingerprintLastEvent {xpath('PageFingerprintLastEvent')};
		string10 PageFingerprintLastUpdate {xpath('PageFingerprintLastUpdate')};
		string10 PageFingerprintResult {xpath('PageFingerprintResult')};
		integer PageFingerprintScore {xpath('PageFingerprintScore')};
		integer PageFingerprintWorstScore {xpath('PageFingerprintWorstScore')};
		integer PageId {xpath('PageId')};
		string255 PageSummary {xpath('PageSummary')};
		integer PageTimeOn {xpath('PageTimeOn')};
		t_TagWithMessage PasswordHash {xpath('PasswordHash')};
		dataset(iesp.share.t_StringArrayItem) PasswordHashActivityRecords {xpath('PasswordHashActivityRecords/PasswordHashActivities'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) PasswordHashAssertHistoryRecords {xpath('PasswordHashAssertHistoryRecords/PasswordHashAssertHistory'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) PasswordHashAttribureRecords {xpath('PasswordHashAttribureRecords/PasswordHashAttributes'), MAXCOUNT(1)};
		string10 PasswordHashFirstSeen {xpath('PasswordHashFirstSeen')};
		string10 PasswordHashLastAssertion {xpath('PasswordHashLastAssertion')};
		string10 PasswordHashLastEvent {xpath('PasswordHashLastEvent')};
		string10 PasswordHashLastUpdate {xpath('PasswordHashLastUpdate')};
		string10 PasswordHashResult {xpath('PasswordHashResult')};
		integer PasswordHashScore {xpath('PasswordHashScore')};
		integer PasswordHashWorstScore {xpath('PasswordHashWorstScore')};
		string255 PaymentGatewayProvider {xpath('PaymentGatewayProvider')};
		string255 PaymentRequestType {xpath('PaymentRequestType')};
		string255 PaymentResponseCode {xpath('PaymentResponseCode')};
		string255 PaymentResponse {xpath('PaymentResponse')};
		string255 PluginAdobeAcrobat {xpath('PluginAdobeAcrobat')};
		string255 PluginDevalvr {xpath('PluginDevalvr')};
		string255 PluginFlash {xpath('PluginFlash')};
		string255 PluginHash {xpath('PluginHash')};
		string255 PluginJava {xpath('PluginJava')};
		integer PluginNumber {xpath('PluginNumber')};
		string255 PluginQuicktime {xpath('PluginQuicktime')};
		string255 PluginRealplayer {xpath('PluginRealplayer')};
		string255 PluginShockwave {xpath('PluginShockwave')};
		string255 PluginSilverlight {xpath('PluginSilverlight')};
		string255 PluginSvgViewer {xpath('PluginSvgViewer')};
		string255 PluginVlcPlayer {xpath('PluginVlcPlayer')};
		string255 PluginWindowsMediaPlayer {xpath('PluginWindowsMediaPlayer')};
		string128 Policy {xpath('Policy')};
		string4 PolicyScore {xpath('PolicyScore')};
		string255 ProcessingProvider {xpath('ProcessingProvider')};
		integer ProfileApiTimedelta {xpath('ProfileApiTimedelta')};
		string32 ProfileOrgId {xpath('ProfileOrgId')};
		string255 ProfiledDomain {xpath('ProfiledDomain')};
		dataset(iesp.share.t_StringArrayItem) ProfiledDomainActivityRecords {xpath('ProfiledDomainActivityRecords/ProfiledDomainActivities'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) ProfiledDomainAssertHistoryRecords {xpath('ProfiledDomainAssertHistoryRecords/ProfiledDomainAssertHistory'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) ProfileDomainAttributeRecords {xpath('ProfileDomainAttributeRecords/ProfiledDomainAttributes'), MAXCOUNT(1)};
		string10 ProfiledDomainFirstSeen {xpath('ProfiledDomainFirstSeen')};
		string10 ProfiledDomainLastAssertion {xpath('ProfiledDomainLastAssertion')};
		string10 ProfiledDomainLastEvent {xpath('ProfiledDomainLastEvent')};
		string10 ProfiledDomainLastUpdate {xpath('ProfiledDomainLastUpdate')};
		string10 ProfiledDomainResult {xpath('ProfiledDomainResult')};
		integer ProfiledDomainScore {xpath('ProfiledDomainScore')};
		integer ProfiledDomainWorstScore {xpath('ProfiledDomainWorstScore')};
		string255 ProfiledUrl {xpath('ProfiledUrl')};
		integer ProfilingDatetime {xpath('ProfilingDatetime')};
		string64 ProfilingSiteId {xpath('ProfilingSiteId')};
		string50 ProxyIpCity {xpath('ProxyIpCity')};
		string50 ProxyIpGeo {xpath('ProxyIpGeo')};
		string50 ProxyIpIsp {xpath('ProxyIpIsp')};
		string10 ProxyIpLatitude {xpath('ProxyIpLatitude')};
		string11 ProxyIpLongitude {xpath('ProxyIpLongitude')};
		string50 ProxyIpOrganization {xpath('ProxyIpOrganization')};
		string50 ProxyIpRegion {xpath('ProxyIpRegion')};
		string64 ProxyIp {xpath('ProxyIp')};
		string255 ProxyName {xpath('ProxyName')};
		string32 ProxyType {xpath('ProxyType')};
		integer PwdPolicyAutoLockMinutes {xpath('PwdPolicyAutoLockMinutes')};
		string8 PwdPolicyAutoLogon {xpath('PwdPolicyAutoLogon')};
		string8 PwdPolicyComplexity {xpath('PwdPolicyComplexity')};
		string8 PwdPolicyEnabled {xpath('PwdPolicyEnabled')};
		integer PwdPolicyMaxDays {xpath('PwdPolicyMaxDays')};
		integer PwdPolicyMinDays {xpath('PwdPolicyMinDays')};
		dataset(iesp.share.t_StringArrayItem) ReasonCodes {xpath('ReasonCodes/ReasonCode'), MAXCOUNT(1)};
		string255 RelatedCustomId {xpath('RelatedCustomId')};
		dataset(iesp.share.t_StringArrayItem) RelatedDeviceIds {xpath('RelatedDeviceIds/RelatedDeviceId'), MAXCOUNT(1)};
		string255 RelatedRequestId {xpath('RelatedRequestId')};
		string4 RequestDuration {xpath('RequestDuration')};
		string40 RequestId {xpath('RequestId')};
		dataset(iesp.share.t_StringArrayItem) RequestIdActivityRecords {xpath('RequestIdActivityRecords/RequestIdActivities'), MAXCOUNT(1)};
		string64 RequestResult {xpath('RequestResult')};
		string40 ReviewStatus {xpath('ReviewStatus')};
		string32 RiskRating {xpath('RiskRating')};
		string3 ScreenAspectRatioAnomaly {xpath('ScreenAspectRatioAnomaly')};
		integer ScreenColorDepth {xpath('ScreenColorDepth')};
		integer ScreenDpi {xpath('ScreenDpi')};
		string12 ScreenResAlt {xpath('ScreenResAlt')};
		string3 ScreenResAnomaly {xpath('ScreenResAnomaly')};
		string32 ScreenRes {xpath('ScreenRes')};
		string40 ServiceType {xpath('ServiceType')};
		string3 SessionAnomaly {xpath('SessionAnomaly')};
		string128 SessionId {xpath('SessionId')};
		integer SessionIdQueryCount {xpath('SessionIdQueryCount')};
		string16 SettlementAmount {xpath('SettlementAmount')};
		string3 SettlementCurrency {xpath('SettlementCurrency')};
		t_TagWithMessage ShippingAddress {xpath('ShippingAddress')};
		t_TagWithMessage ShippingAddressCity {xpath('ShippingAddressCity')};
		t_TagWithMessage ShippingAddressCountry {xpath('ShippingAddressCountry')};
		t_TagWithMessage ShippingAddressState {xpath('ShippingAddressState')};
		t_TagWithMessage ShippingAddressStreet1 {xpath('ShippingAddressStreet1')};
		t_TagWithMessage ShippingAddressStreet2 {xpath('ShippingAddressStreet2')};
		t_TagWithMessage ShippingAddressZip {xpath('ShippingAddressZip')};
		dataset(iesp.share.t_StringArrayItem) ShippingAddressActivityRecords {xpath('ShippingAddressActivityRecords/ShippingAddressActivities'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) ShippingAddressAssertHistoryRecords {xpath('ShippingAddressAssertHistoryRecords/ShippingAddressAssertHistory'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) ShippingAddressAttributeRecords {xpath('ShippingAddressAttributeRecords/ShippingAddressAttributes'), MAXCOUNT(1)};
		string10 ShippingAddressFirstSeen {xpath('ShippingAddressFirstSeen')};
		string10 ShippingAddressLastAssertion {xpath('ShippingAddressLastAssertion')};
		string10 ShippingAddressLastEvent {xpath('ShippingAddressLastEvent')};
		string10 ShippingAddressLastUpdate {xpath('ShippingAddressLastUpdate')};
		string10 ShippingAddressResult {xpath('ShippingAddressResult')};
		integer ShippingAddressScore {xpath('ShippingAddressScore')};
		integer ShippingAddressWorstScore {xpath('ShippingAddressWorstScore')};
		string40 SsnHash {xpath('SsnHash')};
		dataset(iesp.share.t_StringArrayItem) SummaryReasonCodes {xpath('SummaryReasonCodes/SummaryReasonCode'), MAXCOUNT(1)};
		string4 SummaryRiskScore {xpath('SummaryRiskScore')};
		integer SystemState {xpath('SystemState')};
		t_TagWithMessage TagName {xpath('TagName')};
		string64 TcpConnectionType {xpath('TcpConnectionType')};
		integer TcpOsSigAdvMss {xpath('TcpOsSigAdvMss')};
		string255 TcpOsSigRaw {xpath('TcpOsSigRaw')};
		integer TcpOsSigRcvMss {xpath('TcpOsSigRcvMss')};
		integer TcpOsSigSndMss {xpath('TcpOsSigSndMss')};
		string128 TcpOsSignature {xpath('TcpOsSignature')};
		string32 ThirdPartyCookie {xpath('ThirdPartyCookie')};
		integer TimeZoneDstOffset {xpath('TimeZoneDstOffset')};
		integer TimeZone {xpath('TimeZone')};
		string3 TimezoneOffsetAnomaly {xpath('TimezoneOffsetAnomaly')};
		integer TmxPolicyScore {xpath('TmxPolicyScore')};
		dataset(iesp.share.t_StringArrayItem) TmxReasonCodes {xpath('TmxReasonCodes/TmxReasonCode'), MAXCOUNT(1)};
		string32 TmxReviewStatus {xpath('TmxReviewStatus')};
		string32 TmxRiskRating {xpath('TmxRiskRating')};
		dataset(iesp.share.t_StringArrayItem) TmxSummaryReasonCodes {xpath('TmxSummaryReasonCodes/TmxSummaryReasonCode'), MAXCOUNT(1)};
		string10 tpsResult {xpath('tpsResult')};
		string255 TpsVendorError {xpath('TpsVendorError')};
		string255 TpsVendorResult {xpath('TpsVendorResult')};
		string3 TpsWasTimeout {xpath('TpsWasTimeout')};
		string16 TransactionAmount {xpath('TransactionAmount')};
		string16 TransactionAuthAmount {xpath('TransactionAuthAmount')};
		string3 TransactionAuthCurrency {xpath('TransactionAuthCurrency')};
		string3 TransactionCurrency {xpath('TransactionCurrency')};
		string64 TransactionId {xpath('TransactionId')};
		string16 TransactionShippingAmount {xpath('TransactionShippingAmount')};
		string3 TransactionShippingCurrency {xpath('TransactionShippingCurrency')};
		t_TagWithMessage TrueIp {xpath('TrueIp')};
		dataset(iesp.share.t_StringArrayItem) TrueIpActivityRecords {xpath('TrueIpActivityRecords/TrueIpActivities'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) TrueIpAssertHistoryRecords {xpath('TrueIpAssertHistoryRecords/TrueIpAssertHistory'), MAXCOUNT(1)};
		dataset(iesp.share.t_StringArrayItem) TrueIpAttributeRecords {xpath('TrueIpAttributeRecords/TrueIpAttributes'), MAXCOUNT(1)};
		string10 TrueIpFirstSeen {xpath('TrueIpFirstSeen')};
		string10 TrueIpLastAssertion {xpath('TrueIpLastAssertion')};
		string10 TrueIpLastEvent {xpath('TrueIpLastEvent')};
		string10 TrueIpLastUpdate {xpath('TrueIpLastUpdate')};
		string10 TrueIpResult {xpath('TrueIpResult')};
		integer TrueIpScore {xpath('TrueIpScore')};
		integer TrueIpWorstScore {xpath('TrueIpWorstScore')};
		string50 TrueIpCity {xpath('TrueIpCity')};
		string2 TrueIpGeo {xpath('TrueIpGeo')};
		string50 TrueIpIsp {xpath('TrueIpIsp')};
		string10 TrueIpLatitude {xpath('TrueIpLatitude')};
		string11 TrueIpLongitude {xpath('TrueIpLongitude')};
		string50 TrueIpOrganization {xpath('TrueIpOrganization')};
		string5 TrueIpRegion {xpath('TrueIpRegion')};
		string32 UaAgent {xpath('UaAgent')};
		string144 UaBrowser {xpath('UaBrowser')};
		string3 UaMobile {xpath('UaMobile')};
		string144 UaOs {xpath('UaOs')};
		string144 UaPlatform {xpath('UaPlatform')};
		string3 UaProxy {xpath('UaProxy')};
		varstring UnknownPageDiff {xpath('UnknownPageDiff'), maxlength(65535)}; // Xsd type: string
		string3 UnknownSession {xpath('UnknownSession')};
		string3 UrlAnomaly {xpath('UrlAnomaly')};
	end;
			
	export t_TrustDefenderSummaryResponse := record
		string20 ApiType {xpath('ApiType')};
		string20 Action {xpath('Action')};
		string20 OrgId {xpath('OrgId')};
		string128 Policy {xpath('Policy')};
		string4 PolicyScore {xpath('PolicyScore')};
		string4 RequestDuration {xpath('RequestDuration')};
		string40 InputRequestId {xpath('InputRequestId')};
		string40 RequestId {xpath('RequestId')};
		string64 RequestResult {xpath('RequestResult')};
		string40 ReviewStatus {xpath('ReviewStatus')};
		string40 FinalReviewStatus {xpath('FinalReviewStatus')};
		string32 RiskRating {xpath('RiskRating')};
		string40 ServiceType {xpath('ServiceType')};
		string4 SummaryRiskScore {xpath('SummaryRiskScore')};
		dataset(iesp.share.t_StringArrayItem) ReasonCodes {xpath('ReasonCodes/ReasonCode'), MAXCOUNT(1)};
	end;
			
	export t_TrustDefenderResponse := record
		iesp.share.t_ResponseHeader _Header {xpath('Header')};
		t_TrustDefenderSummaryResponse Summary {xpath('Summary')};
		t_TrustDefenderDetailedResponse _Data {xpath('Data')};
	end;
			
	export t_TrustDefenderRequest := record (iesp.share.t_BaseRequest)
		iesp.share.t_GatewayParams GatewayParams {xpath('GatewayParams')};
		t_TrustDefenderOptions Options {xpath('Options')};
		t_TrustDefenderSearchBy SearchBy {xpath('SearchBy')};
	end;
			
	export t_TrustDefenderResponseEx := record
		t_TrustDefenderResponse response {xpath('response')};
	end;

	export t_TrustDefenderRequestEx := record
		t_TrustDefenderRequest TrustDefenderRequest {xpath('TrustDefenderRequest')};
	end;

	export t_TrustDefenderResponseEx_t := record
	 t_TrustDefenderResponseEx TrustDefenderResponseEx {xpath('TrustDefenderResponseEx')};
	end;

	export tm_conv_lay := record
		string delta_tm_id;             
		string lexid;                   
		string product_code;            
		string idms_txn_id;             
		string esp_txn_id;              
		string device_id;               
		string policy_score;            
		string risk_classification;	   
		string review_status;           
		string session_id;              
		string org_id;                  
		string policy;                  
		string event_type;              
		string service_type;            
		t_TrustDefenderRequestEx;             
		t_TrustDefenderResponseEx_t;        
		string date_added; 
	end;  

	ThreatMetrics := RECORD
		string Event_Type
		,string DeviceID
		,string Device_os
		,string Browser
		,string Browser_Language
		,string Device_First_Seen
		,string DeviceID2
		,string DeviceID2_First_Seen
		,string InputIP
		,string InputIP_City
		,string InputIP_Region
		,string InputIPCountry
		,string TrueIP
		,string TrueIP_City
		,string TrueIP_Region
		,string TrueIP_Country
		,string ProxyIP
		,string ProxyIP_City
		,string ProxyIP_Region
		,string ProxyIP_Country
		,string Proxy_Type
		,string DeviceID_Rejected_c1
		,string DeviceID_Rejected_c12
		,string DeviceID2_Rejected_c1
		,string DeviceID2_Rejected_c12
		,string Email_Rejected_c1
		,string Email_Rejected_c12
		,string Email_Blacklist
		,string DeviceID_Blacklist
		,string DeviceID2_Blacklist
		,string InputIP_Blacklist
		,string TrueIP_Blacklist
		,string ProxyIP_Blacklist
		,string ProxyIP_Hidden
		,string ProxyIP_Anonymous
		,string Virtual_Machine
		,string Known_VPN_ISP
		,string Possible_VPN
		,string ProxyIP_Geo_Mismatch
		,string Language_Geo_Mismatch
		,string Timezone_Geo_Mismatch
		,string Global_Company_ID
		,string transaction_id
		,string Date_time
	end;

	LNappend := record
		unsigned8 allowflags;
		string primary_market_code;
		string secondary_market_code;
		string industry_1_code;
		string industry_2_code;
		string sub_market;
		string vertical;
		string use;
		string industry;
		string5 title;
		string20 fname;
		string20 mname;
		string20 lname;
		string5 name_suffix;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 addr_suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 v_city_name;
		string2 st;
		string5 zip5;
		string4 zip4;
		string2 addr_rec_type;
		string2 fips_state;
		string3 fips_county;
		string10 geo_lat;
		string11 geo_long;
		string4 cbsa;
		string7 geo_blk;
		string1 geo_match;
		string4 err_stat;
		string appended_ssn;
		unsigned6 appended_adl;
		string glb_purpose;
		string dppa_purpose;
		string fcra_purpose;
		string method;
		string product_code;
		string transaction_type;
		string function_name;
  END;

	export Base := RECORD
		unsigned8 lexid;
		ThreatMetrics Orig;
		LNappend Appends;
	END;

	export ThreatMetrics_key := RECORD
		string Event_Type
		,string DeviceID
		,string Device_os
		,string Browser
		,string Browser_Language
		,string Device_First_Seen
		,string DeviceID2
		,string DeviceID2_First_Seen
		,string InputIP
		,string InputIP_City
		,string InputIP_Region
		,string InputIPCountry
		,string TrueIP
		,string TrueIP_City
		,string TrueIP_Region
		,string TrueIP_Country
		,string ProxyIP
		,string ProxyIP_City
		,string ProxyIP_Region
		,string ProxyIP_Country
		,string Proxy_Type
		,boolean DeviceID_Rejected_c1
		,boolean DeviceID_Rejected_c12
		,boolean DeviceID2_Rejected_c1
		,boolean DeviceID2_Rejected_c12
		,boolean Email_Rejected_c1
		,boolean Email_Rejected_c12
		,boolean Email_Blacklist
		,boolean DeviceID_Blacklist
		,boolean DeviceID2_Blacklist
		,boolean InputIP_Blacklist
		,boolean TrueIP_Blacklist
		,boolean ProxyIP_Blacklist
		,boolean ProxyIP_Hidden
		,boolean ProxyIP_Anonymous
		,boolean Virtual_Machine
		,boolean Known_VPN_ISP
		,boolean Possible_VPN
		,boolean ProxyIP_Geo_Mismatch
		,boolean Language_Geo_Mismatch
		,boolean Timezone_Geo_Mismatch
		,string transaction_id
		,string Date_time
	end;

	export LNappend_key := record
		 unsigned8 allowflags;
		 string primary_market_code;
		 string secondary_market_code;
		 string industry_1_code;
		 string industry_2_code;
		 string sub_market;
		 string vertical;
		 string use;
		 string industry;
		 string5 title;
		 string20 fname;
		 string20 mname;
		 string20 lname;
		 string5 name_suffix;
		 string10 prim_range;
		 string2 predir;
		 string28 prim_name;
		 string4 addr_suffix;
		 string2 postdir;
		 string10 unit_desig;
		 string8 sec_range;
		 string25 v_city_name;
		 string2 st;
		 string5 zip5;
		 string4 zip4;
		 string2 addr_rec_type;
		 string2 fips_state;
		 string3 fips_county;
		 string10 geo_lat;
		 string11 geo_long;
		 string4 cbsa;
		 string7 geo_blk;
		 string1 geo_match;
		 string4 err_stat;
		 string appended_ssn;
		 unsigned6 appended_adl;
		 string glb_purpose;
		 string dppa_purpose;
		 string fcra_purpose;
		 string method;
		 string product_code;
		 string transaction_type;
		 string function_name;
  END;

	export Key := RECORD
		unsigned8 lexid;
		ThreatMetrics_key Orig;
		LNappend_key Appends;
	END;

END;

KJE - OLD */