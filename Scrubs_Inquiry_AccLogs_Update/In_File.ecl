IMPORT Inquiry_AccLogs;

// based on inputs to: Inquiry_AccLogs.ProcBuildUpdateKeys

out_record := RECORD
string mbslayout_company_id;
string mbslayout_global_company_id;
unsigned8 allowlayout_allowflags;
string businfolayout_primary_market_code;
string businfolayout_secondary_market_code;
string businfolayout_industry_1_code;
string businfolayout_industry_2_code;
string businfolayout_sub_market;
string businfolayout_vertical;
string businfolayout_use;
string businfolayout_industry;
string persondatalayout_full_name;
string persondatalayout_first_name;
string persondatalayout_middle_name;
string persondatalayout_last_name;
string persondatalayout_address;
string persondatalayout_city;
string persondatalayout_state;
string persondatalayout_zip;
string persondatalayout_personal_phone;
string persondatalayout_work_phone;
string persondatalayout_dob;
string persondatalayout_dl;
string persondatalayout_dl_st;
string persondatalayout_email_address;
string persondatalayout_ssn;
string persondatalayout_linkid;
string persondatalayout_ipaddr;
string5 persondatalayout_title;
string20 persondatalayout_fname;
string20 persondatalayout_mname;
string20 persondatalayout_lname;
string5 persondatalayout_name_suffix;
string10 persondatalayout_prim_range;
string2 persondatalayout_predir;
string28 persondatalayout_prim_name;
string4 persondatalayout_addr_suffix;
string2 persondatalayout_postdir;
string10 persondatalayout_unit_desig;
string8 persondatalayout_sec_range;
string25 persondatalayout_v_city_name;
string2 persondatalayout_st;
string5 persondatalayout_zip5;
string4 persondatalayout_zip4;
string2 persondatalayout_addr_rec_type;
string2 persondatalayout_fips_state;
string3 persondatalayout_fips_county;
string10 persondatalayout_geo_lat;
string11 persondatalayout_geo_long;
string4 persondatalayout_cbsa;
string7 persondatalayout_geo_blk;
string1 persondatalayout_geo_match;
string4 persondatalayout_err_stat;
string persondatalayout_appended_ssn;
unsigned6 persondatalayout_appended_adl;
string permissablelayout_glb_purpose;
string permissablelayout_dppa_purpose;
string permissablelayout_fcra_purpose;
string searchlayout_datetime;
string searchlayout_start_monitor;
string searchlayout_stop_monitor;
string searchlayout_login_history_id;
string searchlayout_transaction_id;
string searchlayout_sequence_number;
string searchlayout_method;
string searchlayout_product_code;
string searchlayout_transaction_type;
string searchlayout_function_description;
string searchlayout_ipaddr;
  string3 fraudpoint_score;
END;



out_record reformat(inquiry_acclogs.Layout.common_indexes L) := TRANSFORM

SELF.mbslayout_company_id:=L.mbs.company_id;
SELF.mbslayout_global_company_id:=L.mbs.global_company_id;
SELF.allowlayout_allowflags:=L.allow_flags.allowflags;
SELF.businfolayout_primary_market_code:=L.bus_intel.primary_market_code;
SELF.businfolayout_secondary_market_code:=L.bus_intel.secondary_market_code;
SELF.businfolayout_industry_1_code:=L.bus_intel.industry_1_code;
SELF.businfolayout_industry_2_code:=L.bus_intel.industry_2_code;
SELF.businfolayout_sub_market:=L.bus_intel.sub_market;
SELF.businfolayout_vertical:=L.bus_intel.vertical;
SELF.businfolayout_use:=L.bus_intel.use;
SELF.businfolayout_industry:=L.bus_intel.industry;
SELF.persondatalayout_full_name:=L.person_q.full_name;
SELF.persondatalayout_first_name:=L.person_q.first_name;
SELF.persondatalayout_middle_name:=L.person_q.middle_name;
SELF.persondatalayout_last_name:=L.person_q.last_name;
SELF.persondatalayout_address:=L.person_q.address;
SELF.persondatalayout_city:=L.person_q.city;
SELF.persondatalayout_state:=L.person_q.state;
SELF.persondatalayout_zip:=L.person_q.zip;
SELF.persondatalayout_personal_phone:=L.person_q.personal_phone;
SELF.persondatalayout_work_phone:=L.person_q.work_phone;
SELF.persondatalayout_dob:=L.person_q.dob;
SELF.persondatalayout_dl:=L.person_q.dl;
SELF.persondatalayout_dl_st:=L.person_q.dl_st;
SELF.persondatalayout_email_address:=L.person_q.email_address;
SELF.persondatalayout_ssn:=L.person_q.ssn;
SELF.persondatalayout_linkid:=L.person_q.linkid;
SELF.persondatalayout_ipaddr:=L.person_q.ipaddr;
SELF.persondatalayout_title:=L.person_q.title;
SELF.persondatalayout_fname:=L.person_q.fname;
SELF.persondatalayout_mname:=L.person_q.mname;
SELF.persondatalayout_lname:=L.person_q.lname;
SELF.persondatalayout_name_suffix:=L.person_q.name_suffix;
SELF.persondatalayout_prim_range:=L.person_q.prim_range;
SELF.persondatalayout_predir:=L.person_q.predir;
SELF.persondatalayout_prim_name:=L.person_q.prim_name;
SELF.persondatalayout_addr_suffix:=L.person_q.addr_suffix;
SELF.persondatalayout_postdir:=L.person_q.postdir;
SELF.persondatalayout_unit_desig:=L.person_q.unit_desig;
SELF.persondatalayout_sec_range:=L.person_q.sec_range;
SELF.persondatalayout_v_city_name:=L.person_q.v_city_name;
SELF.persondatalayout_st:=L.person_q.st;
SELF.persondatalayout_zip5:=L.person_q.zip5;
SELF.persondatalayout_zip4:=L.person_q.zip4;
SELF.persondatalayout_addr_rec_type:=L.person_q.addr_rec_type;
SELF.persondatalayout_fips_state:=L.person_q.fips_state;
SELF.persondatalayout_fips_county:=L.person_q.fips_county;
SELF.persondatalayout_geo_lat:=L.person_q.geo_lat;
SELF.persondatalayout_geo_long:=L.person_q.geo_long;
SELF.persondatalayout_cbsa:=L.person_q.cbsa;
SELF.persondatalayout_geo_blk:=L.person_q.geo_blk;
SELF.persondatalayout_geo_match:=L.person_q.geo_match;
SELF.persondatalayout_err_stat:=L.person_q.err_stat;
SELF.persondatalayout_appended_ssn:=L.person_q.appended_ssn;
SELF.persondatalayout_appended_adl:=L.person_q.appended_adl;
SELF.permissablelayout_glb_purpose:=L.permissions.glb_purpose;
SELF.permissablelayout_dppa_purpose:=L.permissions.dppa_purpose;
SELF.permissablelayout_fcra_purpose:=L.permissions.fcra_purpose;
SELF.searchlayout_datetime:=L.search_info.datetime;
SELF.searchlayout_start_monitor:=L.search_info.start_monitor;
SELF.searchlayout_stop_monitor:=L.search_info.stop_monitor;
SELF.searchlayout_login_history_id:=L.search_info.login_history_id;
SELF.searchlayout_transaction_id:=L.search_info.transaction_id;
SELF.searchlayout_sequence_number:=L.search_info.sequence_number;
SELF.searchlayout_method:=L.search_info.method;
SELF.searchlayout_product_code:=L.search_info.product_code;
SELF.searchlayout_transaction_type:=L.search_info.transaction_type;
SELF.searchlayout_function_description:=L.search_info.function_description;
SELF.searchlayout_ipaddr:=L.search_info.ipaddr;
SELF.fraudpoint_score:=L.fraudpoint_score;

END;


In_File_pre := Inquiry_AccLogs.File_Inquiry_Base.Update(

      bus_intel.industry <> ''
	AND StringLib.StringToUpperCase(trim(search_info.function_description)) not in ['MODELS.ITA_BATCH_SERVICE', 'RISKWISE IP SEARCH (NA99)']
  AND stringlib.stringfind(search_info.function_description, 'INTERNATIONAL', 1) = 0
  AND stringlib.stringfind(search_info.function_description, 'INTL', 1) = 0

  

);

EXPORT In_File := project(In_File_pre,reformat(LEFT));