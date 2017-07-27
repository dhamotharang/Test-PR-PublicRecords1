// Property Deed and Mortgage records
IMPORT LN_PropertyV2,BIPV2;
EXPORT Layout_Property_DM_Extract := RECORD
	LN_PropertyV2.layout_deed_mortgage_common_model_base.ln_fares_id;
	LN_PropertyV2.layout_deed_mortgage_common_model_base.process_date;
	LN_PropertyV2.layout_deed_mortgage_common_model_base.state;
	LN_PropertyV2.layout_deed_mortgage_common_model_base.county_name;
	LN_PropertyV2.layout_deed_mortgage_common_model_base.record_type;
	LN_PropertyV2.layout_deed_mortgage_common_model_base.apnt_or_pin_number;
	LN_PropertyV2.layout_deed_mortgage_common_model_base.fares_unformatted_apn;
	LN_PropertyV2.layout_deed_mortgage_common_model_base.buyer_or_borrower_ind; //new - 'O' for buyer, 'B' for borrower
	LN_PropertyV2.layout_deed_mortgage_common_model_base.name1; //new
	LN_PropertyV2.layout_deed_mortgage_common_model_base.name1_id_code; //new
	LN_PropertyV2.layout_deed_mortgage_common_model_base.name2; //new
	LN_PropertyV2.layout_deed_mortgage_common_model_base.name2_id_code; //new
	// LN_PropertyV2.layout_deed_mortgage_common_model_base.phone_number; //new 
	LN_PropertyV2.layout_deed_mortgage_common_model_base.mailing_care_of; //new
	LN_PropertyV2.layout_deed_mortgage_common_model_base.mailing_street; //new
	LN_PropertyV2.layout_deed_mortgage_common_model_base.mailing_unit_number; //new
	LN_PropertyV2.layout_deed_mortgage_common_model_base.mailing_csz; //new
	LN_PropertyV2.layout_deed_mortgage_common_model_base.mailing_address_cd; //new 
	LN_PropertyV2.layout_deed_mortgage_common_model_base.seller1;
	LN_PropertyV2.layout_deed_mortgage_common_model_base.seller1_id_code;
	LN_PropertyV2.layout_deed_mortgage_common_model_base.seller2;
	LN_PropertyV2.layout_deed_mortgage_common_model_base.seller2_id_code;
	LN_PropertyV2.layout_deed_mortgage_common_model_base.seller_addendum_flag;
	LN_PropertyV2.layout_deed_mortgage_common_model_base.seller_mailing_full_street_address;
	LN_PropertyV2.layout_deed_mortgage_common_model_base.seller_mailing_address_unit_number;
	LN_PropertyV2.layout_deed_mortgage_common_model_base.seller_mailing_address_citystatezip;
	LN_PropertyV2.layout_deed_mortgage_common_model_base.property_full_street_address;
	LN_PropertyV2.layout_deed_mortgage_common_model_base.property_address_unit_number;
	LN_PropertyV2.layout_deed_mortgage_common_model_base.property_address_citystatezip;
	LN_PropertyV2.layout_deed_mortgage_common_model_base.property_address_code;
	LN_PropertyV2.layout_deed_mortgage_common_model_base.contract_date;
	LN_PropertyV2.layout_deed_mortgage_common_model_base.recording_date;
	LN_PropertyV2.layout_deed_mortgage_common_model_base.main_record_id_code; //new - in okc deed
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
	STRING2	 source;
	UNSIGNED6 did;
	UNSIGNED6 bdid;
	UNSIGNED6 rid;
	UNSIGNED6 sid;
	BIPV2.IDlayouts.l_xlink_ids;
END;