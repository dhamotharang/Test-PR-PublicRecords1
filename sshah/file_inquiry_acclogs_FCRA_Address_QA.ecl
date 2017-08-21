//EXPORT file_inquiry_acclogs_FCRA_Address_QA := 'todo';

//EXPORT file_inquiry_aaclogs_FCRA_Phone := 'todo';

//EXPORT file_Doxie_Bocashell_Crim_FCRA := 'todo';

import Inquiry_acclogs;

Key_in:=Inquiry_acclogs.Key_FCRA_Address;

layout_out:= 
  
RECORD

string5 zip;
  string28 prim_name;
  string10 prim_range;
  string8 sec_range;

  //string10 phone10;
 // mbslayout mbs;
 string mbs_company_id;
   string mbs_global_company_id;
  //allowlayout allow_flags;
	unsigned8 allow_flags_allowflags;
  //businfolayout bus_intel;
	string bus_intel_primary_market_code;
   string bus_intel_secondary_market_code;
   string bus_intel_industry_1_code;
   string bus_intel_industry_2_code;
   string bus_intel_sub_market;
   string bus_intel_vertical;
   string bus_intel_use;
   string bus_intel_industry;
  //persondatalayout person_q;
	string   person_q_full_name;
string   person_q_first_name;
string   person_q_middle_name;
string   person_q_last_name;
string   person_q_address;
string   person_q_city;
string   person_q_state;
string   person_q_zip;
string   person_q_personal_phone;
string   person_q_work_phone;
string   person_q_dob;
string   person_q_dl;
string   person_q_dl_st;
string   person_q_email_address;
string   person_q_ssn;
string   person_q_linkid;
string   Person_q_ipaddr;
string5   person_q_title;
string20   person_q_fname;
string20   person_q_mname;
string20   person_q_lname;
string5   person_q_name_suffix;
string10   person_q_prim_range;
string2   person_q_predir;
string28   person_q_prim_name;
string4   person_q_addr_suffix;
string2   person_q_postdir;
string10   person_q_unit_desig;
string8   person_q_sec_range;
string25   person_q_v_city_name;
string2   person_q_st;
string5   person_q_zip5;
string4   person_q_zip4;
string2   person_q_addr_rec_type;
string2   person_q_fips_state;
string3   person_q_fips_county;
string10   person_q_geo_lat;
string11   person_q_geo_long;
string4   person_q_cbsa;
string7   person_q_geo_blk;
string1   person_q_geo_match;
string4   person_q_err_stat;
string   person_q_appended_ssn;
unsigned6   person_q_appended_adl;

  //busdatalayout bus_q;
	string   bus_q_cname;
string   bus_q_address;
string   bus_q_city;
string   bus_q_state;
string   bus_q_zip;
string   bus_q_company_phone;
string   bus_q_ein;
string   bus_q_charter_number;
string   bus_q_ucc_number;
string   bus_q_domain_name;
string10   bus_q_prim_range;
string2   bus_q_predir;
string28   bus_q_prim_name;
string4   bus_q_addr_suffix;
string2   bus_q_postdir;
string10   bus_q_unit_desig;
string8   bus_q_sec_range;
string25   bus_q_v_city_name;
string2   bus_q_st;
string5   bus_q_zip5;
string4   bus_q_zip4;
string2   bus_q_addr_rec_type;
string2   bus_q_fips_state;
string3   bus_q_fips_county;
string10   bus_q_geo_lat;
string11   bus_q_geo_long;
string4   bus_q_cbsa;
string7   bus_q_geo_blk;
string1   bus_q_geo_match;
string4   bus_q_err_stat;
unsigned6   bus_q_appended_bdid;
string   bus_q_appended_ein;

  //bususerdatalayout bususer_q;
	string   bususer_q_personal_phone;
string   bususer_q_dob;
string   bususer_q_dl;
string   bususer_q_dl_st;
string   bususer_q_ssn;
string5   bususer_q_title;
string20   bususer_q_fname;
string20   bususer_q_mname;
string20   bususer_q_lname;
string5   bususer_q_name_suffix;
string10   bususer_q_prim_range;
string2   bususer_q_predir;
string28   bususer_q_prim_name;
string4   bususer_q_addr_suffix;
string2   bususer_q_postdir;
string10   bususer_q_unit_desig;
string8   bususer_q_sec_range;
string25   bususer_q_v_city_name;
string2   bususer_q_st;
string5   bususer_q_zip5;
string4   bususer_q_zip4;
string2   bususer_q_addr_rec_type;
string2   bususer_q_fips_state;
string3   bususer_q_fips_county;
string10   bususer_q_geo_lat;
string11   bususer_q_geo_long;
string4   bususer_q_cbsa;
string7   bususer_q_geo_blk;
string1   bususer_q_geo_match;
string4   bususer_q_err_stat;
string   bususer_q_appended_ssn;
unsigned6   bususer_q_appended_adl;

  //permissablelayout permissions;
	string permissions_glb_purpose;
   string permissions_dppa_purpose;
   string permissions_fcra_purpose;
  //searchlayout search_info;
	string search_info_datetime;
   string search_info_start_monitor;
   string search_info_stop_monitor;
   string search_info_login_history_id;
   string search_info_transaction_id;
   string search_info_sequence_number;
   string search_info_method;
   string search_info_product_code;
   string search_info_transaction_type;
   string search_info_function_description;
   string search_info_ipaddr;
  //unsigned8 __internal_fpos__;
 END;
Layout_out makerecord (Key_in L):= Transform

self.zip:= l.zip;
self.prim_name:= l.prim_name;
self.prim_range:= l.prim_range;
self.sec_range:= l.sec_range;
//self.phone10 := l.phone10;
self.mbs_company_id := l.mbs.company_id;
self.mbs_global_company_id := l.mbs.global_company_id;
self.allow_flags_allowflags:= l.allow_flags.allowflags;
self.bus_intel_primary_market_code:=	l.bus_intel.primary_market_code;
self.bus_intel_secondary_market_code:=	l.bus_intel.secondary_market_code;
self.bus_intel_industry_1_code:=	l.bus_intel.industry_1_code;
self.bus_intel_industry_2_code:=	l.bus_intel.industry_2_code;
self.bus_intel_sub_market:=	l.bus_intel.sub_market;
self.bus_intel_vertical:=	l.bus_intel.vertical;
self.bus_intel_use:=	l.bus_intel.use;
self.bus_intel_industry:=	l.bus_intel.industry;
self.person_q_full_name:=	l.person_q.full_name;
self.person_q_first_name:=	l.person_q.first_name;
self.person_q_middle_name:=	l.person_q.middle_name;
self.person_q_last_name:=	l.person_q.last_name;
self.person_q_address:=	l.person_q.address;
self.person_q_city:=	l.person_q.city;
self.person_q_state:=	l.person_q.state;
self.person_q_zip:=	l.person_q.zip;
self.person_q_personal_phone:=	l.person_q.personal_phone;
self.person_q_work_phone:=	l.person_q.work_phone;
self.person_q_dob:=	l.person_q.dob;
self.person_q_dl:=	l.person_q.dl;
self.person_q_dl_st:=	l.person_q.dl_st;
self.person_q_email_address:=	l.person_q.email_address;
self.person_q_ssn:=	l.person_q.ssn;

self.person_q_linkid:=	l.person_q.linkid;
self.person_q_ipaddr:=	l.person_q.ipaddr;
self.person_q_title:=	l.person_q.title;
self.person_q_fname:=	l.person_q.fname;
self.person_q_mname:=	l.person_q.mname;
self.person_q_lname:=	l.person_q.lname;
self.person_q_name_suffix:=	l.person_q.name_suffix;
self.person_q_prim_range:=	l.person_q.prim_range;
self.person_q_predir:=	l.person_q.predir;
self.person_q_prim_name:=	l.person_q.prim_name;
self.person_q_addr_suffix:=	l.person_q.addr_suffix;
self.person_q_postdir:=	l.person_q.postdir;
self.person_q_unit_desig:=	l.person_q.unit_desig;
self.person_q_sec_range:=	l.person_q.sec_range;
self.person_q_v_city_name:=	l.person_q.v_city_name;
self.person_q_st:=	l.person_q.st;
self.person_q_zip5:=	l.person_q.zip5;
self.person_q_zip4:=	l.person_q.zip4;
self.person_q_addr_rec_type:=	l.person_q.addr_rec_type;
self.person_q_fips_state:=	l.person_q.fips_state;
self.person_q_fips_county:=	l.person_q.fips_county;
self.person_q_geo_lat:=	l.person_q.geo_lat;
self.person_q_geo_long:=	l.person_q.geo_long;
self.person_q_cbsa:=	l.person_q.cbsa;
self.person_q_geo_blk:=	l.person_q.geo_blk;
self.person_q_geo_match:=	l.person_q.geo_match;
self.person_q_err_stat:=	l.person_q.err_stat;
self.person_q_appended_ssn:=	l.person_q.appended_ssn;
self.person_q_appended_adl:=	l.person_q.appended_adl;
self.bus_q_cname:=	l.bus_q.cname;
self.bus_q_address:=	l.bus_q.address;
self.bus_q_city:=	l.bus_q.city;
self.bus_q_state:=	l.bus_q.state;
self.bus_q_zip:=	l.bus_q.zip;
self.bus_q_company_phone:=	l.bus_q.company_phone;
self.bus_q_ein:=	l.bus_q.ein;
self.bus_q_charter_number:=	l.bus_q.charter_number;
self.bus_q_ucc_number:=	l.bus_q.ucc_number;
self.bus_q_domain_name:=	l.bus_q.domain_name;
self.bus_q_prim_range:=	l.bus_q.prim_range;
self.bus_q_predir:=	l.bus_q.predir;
self.bus_q_prim_name:=	l.bus_q.prim_name;
self.bus_q_addr_suffix:=	l.bus_q.addr_suffix;
self.bus_q_postdir:=	l.bus_q.postdir;
self.bus_q_unit_desig:=	l.bus_q.unit_desig;
self.bus_q_sec_range:=	l.bus_q.sec_range;
self.bus_q_v_city_name:=	l.bus_q.v_city_name;
self.bus_q_st:=	l.bus_q.st;
self.bus_q_zip5:=	l.bus_q.zip5;
self.bus_q_zip4:=	l.bus_q.zip4;
self.bus_q_addr_rec_type:=	l.bus_q.addr_rec_type;
self.bus_q_fips_state:=	l.bus_q.fips_state;
self.bus_q_fips_county:=	l.bus_q.fips_county;
self.bus_q_geo_lat:=	l.bus_q.geo_lat;
self.bus_q_geo_long:=	l.bus_q.geo_long;
self.bus_q_cbsa:=	l.bus_q.cbsa;
self.bus_q_geo_blk:=	l.bus_q.geo_blk;
self.bus_q_geo_match:=	l.bus_q.geo_match;
self.bus_q_err_stat:=	l.bus_q.err_stat;
self.bus_q_appended_bdid:=	l.bus_q.appended_bdid;
self.bus_q_appended_ein:=	l.bus_q.appended_ein;
self.bususer_q_personal_phone:=	l.Bususer_q.personal_phone;
self.bususer_q_dob:=	l.Bususer_q.dob;
self.bususer_q_dl:=	l.Bususer_q.dl;
self.bususer_q_dl_st:=	l.Bususer_q.dl_st;
self.bususer_q_ssn:=	l.Bususer_q.ssn;
self.bususer_q_title:=	l.Bususer_q.title;
self.bususer_q_fname:=	l.Bususer_q.fname;
self.bususer_q_mname:=	l.Bususer_q.mname;
self.bususer_q_lname:=	l.Bususer_q.lname;
self.bususer_q_name_suffix:=	l.Bususer_q.name_suffix;
self.bususer_q_prim_range:=	l.Bususer_q.prim_range;
self.bususer_q_predir:=	l.Bususer_q.predir;
self.bususer_q_prim_name:=	l.Bususer_q.prim_name;
self.bususer_q_addr_suffix:=	l.Bususer_q.addr_suffix;
self.bususer_q_postdir:=	l.Bususer_q.postdir;
self.bususer_q_unit_desig:=	l.Bususer_q.unit_desig;
self.bususer_q_sec_range:=	l.Bususer_q.sec_range;
self.bususer_q_v_city_name:=	l.Bususer_q.v_city_name;
self.bususer_q_st:=	l.Bususer_q.st;
self.bususer_q_zip5:=	l.Bususer_q.zip5;
self.bususer_q_zip4:=	l.Bususer_q.zip4;
self.bususer_q_addr_rec_type:=	l.Bususer_q.addr_rec_type;
self.bususer_q_fips_state:=	l.Bususer_q.fips_state;
self.bususer_q_fips_county:=	l.Bususer_q.fips_county;
self.bususer_q_geo_lat:=	l.Bususer_q.geo_lat;
self.bususer_q_geo_long:=	l.Bususer_q.geo_long;
self.bususer_q_cbsa:=	l.Bususer_q.cbsa;
self.bususer_q_geo_blk:=	l.Bususer_q.geo_blk;
self.bususer_q_geo_match:=	l.Bususer_q.geo_match;
self.bususer_q_err_stat:=	l.Bususer_q.err_stat;
self.bususer_q_appended_ssn:=	l.Bususer_q.appended_ssn;
self.bususer_q_appended_adl:=	l.Bususer_q.appended_adl;
self.permissions_glb_purpose:= l.permissions.glb_purpose;
self.permissions_dppa_purpose:= l.permissions.dppa_purpose;
self.permissions_fcra_purpose:= l.permissions.fcra_purpose;
self.search_info_datetime:=	l.search_info.datetime;
self.search_info_start_monitor:=	l.search_info.start_monitor;
self.search_info_stop_monitor:=	l.search_info.stop_monitor;
self.search_info_login_history_id:=	l.search_info.login_history_id;
self.search_info_transaction_id:=	l.search_info.transaction_id;
self.search_info_sequence_number:=	l.search_info.sequence_number;
self.search_info_method:=	l.search_info.method;
self.search_info_product_code:=	l.search_info.product_code;
self.search_info_transaction_type:=	l.search_info.transaction_type;
self.search_info_function_description:=	l.search_info.function_description;
self.search_info_ipaddr:=	l.search_info.ipaddr;
end;



 
export file_inquiry_acclogs_FCRA_Address_QA:= project(key_in,makerecord(left));


