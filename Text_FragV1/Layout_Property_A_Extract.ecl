// Property assessment records
IMPORT LN_PropertyV2,BIPV2;
EXPORT Layout_Property_A_Extract := RECORD
  LN_PropertyV2.layout_property_common_model_base.ln_fares_id;
  LN_PropertyV2.layout_property_common_model_base.process_date;
  LN_PropertyV2.layout_property_common_model_base.vendor_source_flag;
  LN_PropertyV2.layout_property_common_model_base.current_record;
  LN_PropertyV2.layout_property_common_model_base.fips_code;
  LN_PropertyV2.layout_property_common_model_base.state_code;
  LN_PropertyV2.layout_property_common_model_base.county_name;
	LN_PropertyV2.layout_property_common_model_base.old_apn;
  LN_PropertyV2.layout_property_common_model_base.apna_or_pin_number;
  LN_PropertyV2.layout_property_common_model_base.fares_unformatted_apn;
  LN_PropertyV2.layout_property_common_model_base.duplicate_apn_multiple_address_id;
  LN_PropertyV2.layout_property_common_model_base.contract_owner;
  LN_PropertyV2.layout_property_common_model_base.assessee_name;
  LN_PropertyV2.layout_property_common_model_base.second_assessee_name;
  LN_PropertyV2.layout_property_common_model_base.assessee_ownership_rights_code;
  LN_PropertyV2.layout_property_common_model_base.assessee_relationship_code;
  LN_PropertyV2.layout_property_common_model_base.assessee_phone_number;
  LN_PropertyV2.layout_property_common_model_base.mailing_care_of_name;
  LN_PropertyV2.layout_property_common_model_base.mailing_full_street_address;
  LN_PropertyV2.layout_property_common_model_base.mailing_unit_number;
  LN_PropertyV2.layout_property_common_model_base.mailing_city_state_zip;
  LN_PropertyV2.layout_property_common_model_base.property_full_street_address;
  LN_PropertyV2.layout_property_common_model_base.property_unit_number;
  LN_PropertyV2.layout_property_common_model_base.property_city_state_zip;
  LN_PropertyV2.layout_property_common_model_base.property_country_code;
  LN_PropertyV2.layout_property_common_model_base.recording_date;
  LN_PropertyV2.layout_property_common_model_base.sale_date;
	LN_PropertyV2.layout_search_out.title;
  LN_PropertyV2.layout_search_out.fname;
  LN_PropertyV2.layout_search_out.mname;
  LN_PropertyV2.layout_search_out.lname;
  LN_PropertyV2.layout_search_out.name_suffix;
  LN_PropertyV2.layout_search_out.cname;
  LN_PropertyV2.layout_search_out.nameasis;
  LN_PropertyV2.layout_search_out.prim_range;
  LN_PropertyV2.layout_search_out.predir;
  LN_PropertyV2.layout_search_out.prim_name;
  LN_PropertyV2.layout_search_out.suffix;
  LN_PropertyV2.layout_search_out.postdir;
  LN_PropertyV2.layout_search_out.unit_desig;
  LN_PropertyV2.layout_search_out.sec_range;
  LN_PropertyV2.layout_search_out.v_city_name;
  LN_PropertyV2.layout_search_out.st;
  LN_PropertyV2.layout_search_out.zip;
  LN_PropertyV2.layout_search_out.zip4;
  LN_PropertyV2.layout_search_out.phone_number;
  LN_PropertyV2.layout_search_out.dt_first_seen; //new
  LN_PropertyV2.layout_search_out.dt_last_seen; //new
  LN_PropertyV2.layout_search_out.dt_vendor_first_reported; //new
  LN_PropertyV2.layout_search_out.dt_vendor_last_reported; //new
	STRING2   source;
	UNSIGNED6	did;
	UNSIGNED6	bdid;
	UNSIGNED6 rid;
	UNSIGNED6	sid;
	BIPV2.IDlayouts.l_xlink_ids;
END;
