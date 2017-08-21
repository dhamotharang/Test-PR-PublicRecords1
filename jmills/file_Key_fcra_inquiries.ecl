import FCRA;

/*mbslayout := RECORD
   string company_id;
   string global_company_id;
  END;

allowlayout := RECORD
   unsigned8 allowflags;
  END;

businfolayout := RECORD
   string primary_market_code;
   string secondary_market_code;
   string industry_1_code;
   string industry_2_code;
   string sub_market;
   string vertical;
   string use;
   string industry;
  END;

persondatalayout := RECORD
   string full_name;
   string first_name;
   string middle_name;
   string last_name;
   string address;
   string city;
   string state;
   string zip;
   string personal_phone;
   string work_phone;
   string dob;
   string dl;
   string dl_st;
   string email_address;
   string ssn;
   string linkid;
   string ipaddr;
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
  END;

busdatalayout := RECORD
   string cname;
   string address;
   string city;
   string state;
   string zip;
   string company_phone;
   string ein;
   string charter_number;
   string ucc_number;
   string domain_name;
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
   unsigned6 appended_bdid;
   string appended_ein;
  END;

bususerdatalayout := RECORD
   string first_name;
   string middle_name;
   string last_name;
   string address;
   string city;
   string state;
   string zip;
   string personal_phone;
   string dob;
   string dl;
   string dl_st;
   string ssn;
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
  END;

permissablelayout := RECORD
   string glb_purpose;
   string dppa_purpose;
   string fcra_purpose;
  END;

searchlayout := RECORD
   string datetime;
   string start_monitor;
   string stop_monitor;
   string login_history_id;
   string transaction_id;
   string sequence_number;
   string method;
   string product_code;
   string transaction_type;
   string function_description;
   string ipaddr;
  END;

layout_addr_flags := RECORD
    string1 dwelltype;
    string1 valid;
    string1 prisonaddr;
    string1 highrisk;
    string1 corpmil;
    string1 donotdeliver;
    string1 deliverystatus;
    string1 addresstype;
    string1 dropindicator;
   END;

layout_address_characteristics := RECORD
   layout_addr_flags addr_flags;
   string10 listed_phone;
   string20 listed_phone_fname;
   string20 listed_phone_lname;
  END;

layout_phone_characteristics := RECORD
   string1 phone_indicator;
   string2 phone_type;
   string10 listed_prim_range;
   string2 listed_predir;
   string28 listed_prim_name;
   string4 listed_suffix;
   string2 listed_postdir;
   string10 listed_unit_desig;
   string8 listed_sec_range;
   string25 listed_city_name;
   string2 listed_st;
   string5 listed_zip;
   string20 listed_fname;
   string20 listed_lname;
   string2 disconnects_last_12months;
   string1 zipcode_phone_match;
   string50 highriskphone_description;
  END;

RECORD
  string20 flag_file_id;
  mbslayout mbs;
  allowlayout allow_flags;
  businfolayout bus_intel;
  persondatalayout person_q;
  busdatalayout bus_q;
  bususerdatalayout bususer_q;
  permissablelayout permissions;
  searchlayout search_info;
  string source;
  unsigned8 persistent_record_id;
  layout_address_characteristics address_characteristics;
  layout_phone_characteristics phone_characteristics;
  unsigned8 __internal_fpos__;
 END;*/
 
 layout_key_out := RECORD
 string20 flag_file_id;
 //mbslayout mbs;
 string company_id;
 string global_company_id;
 //allowlayout allow_flags;
 unsigned8 allowflags;
 //businfolayout bus_intel;
 string primary_market_code;
 string secondary_market_code;
 string industry_1_code;
 string industry_2_code;
 string sub_market;
 string vertical;
 string use;
 string industry;
 //persondatalayout person_q;
 string full_name;
 string first_name;
 string middle_name;
 string last_name;
 string address;
 string city;
 string state;
 string zip;
 string personal_phone;
 string work_phone;
 string dob;
 string dl;
 string dl_st;
 string email_address;
 string ssn;
 string linkid;
 string ipaddr;
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
 //busdatalayout bus_q;
 string bus_cname;
 string bus_address;
 string bus_city;
 string bus_state;
 string bus_zip;
 string bus_company_phone;
 string bus_ein;
 string bus_charter_number;
 string bus_ucc_number;
 string bus_domain_name;
 string10 bus_prim_range;
 string2 bus_predir;
 string28 bus_prim_name;
 string4 bus_addr_suffix;
 string2 bus_postdir;
 string10 bus_unit_desig;
 string8 bus_sec_range;
 string25 bus_v_city_name;
 string2 bus_st;
 string5 bus_zip5;
 string4 bus_zip4;
 string2 bus_addr_rec_type;
 string2 bus_fips_state;
 string3 bus_fips_county;
 string10 bus_geo_lat;
 string11 bus_geo_long;
 string4 bus_cbsa;
 string7 bus_geo_blk;
 string1 bus_geo_match;
 string4 bus_err_stat;
 unsigned6 bus_appended_bdid;
 string bus_appended_ein;
 //bususerdatalayout bususer_q;
 string user_first_name;
 string user_middle_name;
 string user_last_name;
 string user_address;
 string user_city;
 string user_state;
 string user_zip;
 string user_personal_phone;
 string user_dob;
 string user_dl;
 string user_dl_st;
 string user_ssn;
 string5 user_title;
 string20 user_fname;
 string20 user_mname;
 string20 user_lname;
 string5 user_name_suffix;
 string10 user_prim_range;
 string2 user_predir;
 string28 user_prim_name;
 string4 user_addr_suffix;
 string2 user_postdir;
 string10 user_unit_desig;
 string8 user_sec_range;
 string25 user_v_city_name;
 string2 user_st;
 string5 user_zip5;
 string4 user_zip4;
 string2 user_addr_rec_type;
 string2 user_fips_state;
 string3 user_fips_county;
 string10 user_geo_lat;
 string11 user_geo_long;
 string4 user_cbsa;
 string7 user_geo_blk;
 string1 user_geo_match;
 string4 user_err_stat;
 string user_appended_ssn;
 unsigned6 user_appended_adl;
 //permissablelayout permissions;
 string glb_purpose;
 string dppa_purpose;
 string fcra_purpose;
 //searchlayout search_info;
 string search_datetime;
 string search_start_monitor;
 string search_stop_monitor;
 string search_login_history_id;
 string search_transaction_id;
 string search_sequence_number;
 string search_method;
 string search_product_code;
 string search_transaction_type;
 string search_function_description;
 string search_ipaddr;
 //string source;
 string source;
 //unsigned8 persistent_record_id;
 unsigned8 persistent_record_id;
 //layout_address_characteristics address_characteristics;
 //layout_addr_flags addr_flags;
 string10 listed_phone;
 string20 listed_phone_fname;
 string20 listed_phone_lname;
 //layout_phone_characteristics phone_characteristics;
 string1 phone_indicator;
 string2 phone_type;
 string10 listed_prim_range;
 string2 listed_predir;
 string28 listed_prim_name;
 string4 listed_suffix;
 string2 listed_postdir;
 string10 listed_unit_desig;
 string8 listed_sec_range;
 string25 listed_city_name;
 string2 listed_st;
 string5 listed_zip;
 string20 listed_fname;
 string20 listed_lname;
 string2 disconnects_last_12months;
 string1 zipcode_phone_match;
 string50 highriskphone_description;
//unsigned8 __internal_fpos__;

END;

 key_in :=  FCRA.Key_Override_Inquiries_ffid;
 
//transform statement
layout_key_out makerecord (key_in L) := transform
self.flag_file_id := L.flag_file_id;
//mbslayout mbs;
self.company_id := L.mbs.company_id;
self.global_company_id := L.mbs.global_company_id;
//allowlayout allow_flags;
self.allowflags := L.allow_flags.allowflags;
//businfolayout bus_intel;
self.primary_market_code := L.bus_intel.primary_market_code;
self.secondary_market_code := L.bus_intel.secondary_market_code;
self.industry_1_code := L.bus_intel.industry_1_code;
self.industry_2_code := L.bus_intel.industry_2_code;
self.sub_market := L.bus_intel.sub_market;
self.vertical := L.bus_intel.vertical;
self.use := L.bus_intel.use;
self.industry := L.bus_intel.industry;
//persondatalayout person_q;
self.full_name := L.person_q.full_name;
self.first_name := L.person_q.first_name;
self.middle_name := L.person_q.middle_name;
self.last_name := L.person_q.last_name;
self.address := L.person_q.address;
self.city := L.person_q.city;
self.state := L.person_q.state;
self.zip := L.person_q.zip;
self.personal_phone := L.person_q.personal_phone;
self.work_phone := L.person_q.work_phone;
self.dob := L.person_q.dob;
self.dl := L.person_q.dl;
self.dl_st := L.person_q.dl_st;
self.email_address := L.person_q.email_address;
self.ssn := L.person_q.ssn;
self.linkid := L.person_q.linkid;
self.ipaddr := L.person_q.ipaddr;
self.title := L.person_q.title;
self.fname := L.person_q.fname;
self.mname := L.person_q.mname;
self.lname := L.person_q.lname;
self.name_suffix := L.person_q.name_suffix;
self.prim_range := L.person_q.prim_range;
self.predir := L.person_q.predir;
self.prim_name := L.person_q.prim_name;
self.addr_suffix := L.person_q.addr_suffix;
self.postdir := L.person_q.postdir;
self.unit_desig := L.person_q.unit_desig;
self.sec_range := L.person_q.sec_range;
self.v_city_name := L.person_q.v_city_name;
self.st := L.person_q.st;
self.zip5 := L.person_q.zip5;
self.zip4 := L.person_q.zip4;
self.addr_rec_type := L.person_q.addr_rec_type;
self.fips_state := L.person_q.fips_state;
self.fips_county := L.person_q.fips_county;
self.geo_lat := L.person_q.geo_lat;
self.geo_long := L.person_q.geo_long;
self.cbsa := L.person_q.cbsa;
self.geo_blk := L.person_q.geo_blk;
self.geo_match := L.person_q.geo_match;
self.err_stat := L.person_q.err_stat;
self.appended_ssn := L.person_q.appended_ssn;
self.appended_adl := L.person_q.appended_adl;
//busdatalayout bus_q;
self.bus_cname := L.bus_q.cname;
self.bus_address := L.bus_q.address;
self.bus_city := L.bus_q.city;
self.bus_state := L.bus_q.state;
self.bus_zip := L.bus_q.zip;
self.bus_company_phone := L.bus_q.company_phone;
self.bus_ein := L.bus_q.ein;
self.bus_charter_number := L.bus_q.charter_number;
self.bus_ucc_number := L.bus_q.ucc_number;
self.bus_domain_name := L.bus_q.domain_name;
self.bus_prim_range := L.bus_q.prim_range;
self.bus_predir := L.bus_q.predir;
self.bus_prim_name := L.bus_q.prim_name;
self.bus_addr_suffix := L.bus_q.addr_suffix;
self.bus_postdir := L.bus_q.postdir;
self.bus_unit_desig := L.bus_q.unit_desig;
self.bus_sec_range := L.bus_q.sec_range;
self.bus_v_city_name := L.bus_q.v_city_name;
self.bus_st := L.bus_q.st;
self.bus_zip5 := L.bus_q.zip5;
self.bus_zip4 := L.bus_q.zip4;
self.bus_addr_rec_type := L.bus_q.addr_rec_type;
self.bus_fips_state := L.bus_q.fips_state;
self.bus_fips_county := L.bus_q.fips_county;
self.bus_geo_lat := L.bus_q.geo_lat;
self.bus_geo_long := L.bus_q.geo_long;
self.bus_cbsa := L.bus_q.cbsa;
self.bus_geo_blk := L.bus_q.geo_blk;
self.bus_geo_match := L.bus_q.geo_match;
self.bus_err_stat := L.bus_q.err_stat;
self.bus_appended_bdid := L.bus_q.appended_bdid;
self.bus_appended_ein := L.bus_q.appended_ein;
//bususerdatalayoutbus user_q;
self.user_first_name := L.bususer_q.first_name;
self.user_middle_name := L.bususer_q.middle_name;
self.user_last_name := L.bususer_q.last_name;
self.user_address := L.bususer_q.address;
self.user_city := L.bususer_q.city;
self.user_state := L.bususer_q.state;
self.user_zip := L.bususer_q.zip;
self.user_personal_phone := L.bususer_q.personal_phone;
self.user_dob := L.bususer_q.dob;
self.user_dl := L.bususer_q.dl;
self.user_dl_st := L.bususer_q.dl_st;
self.user_ssn := L.bususer_q.ssn;
self.user_title := L.bususer_q.title;
self.user_fname := L.bususer_q.fname;
self.user_mname := L.bususer_q.mname;
self.user_lname := L.bususer_q.lname;
self.user_name_suffix := L.bususer_q.name_suffix;
self.user_prim_range := L.bususer_q.prim_range;
self.user_predir := L.bususer_q.predir;
self.user_prim_name := L.bususer_q.prim_name;
self.user_addr_suffix := L.bususer_q.addr_suffix;
self.user_postdir := L.bususer_q.postdir;
self.user_unit_desig := L.bususer_q.unit_desig;
self.user_sec_range := L.bususer_q.sec_range;
self.user_v_city_name := L.bususer_q.v_city_name;
self.user_st := L.bususer_q.st;
self.user_zip5 := L.bususer_q.zip5;
self.user_zip4 := L.bususer_q.zip4;
self.user_addr_rec_type := L.bususer_q.addr_rec_type;
self.user_fips_state := L.bususer_q.fips_state;
self.user_fips_county := L.bususer_q.fips_county;
self.user_geo_lat := L.bususer_q.geo_lat;
self.user_geo_long := L.bususer_q.geo_long;
self.user_cbsa := L.bususer_q.cbsa;
self.user_geo_blk := L.bususer_q.geo_blk;
self.user_geo_match := L.bususer_q.geo_match;
self.user_err_stat := L.bususer_q.err_stat;
self.user_appended_ssn := L.bususer_q.appended_ssn;
self.user_appended_adl := L.bususer_q.appended_adl;
//permissablelayout permissions;
self.glb_purpose := L.permissions.glb_purpose;
self.dppa_purpose := L.permissions.dppa_purpose;
self.fcra_purpose := L.permissions.fcra_purpose;
//searchlayout search_info;
self.search_datetime := L.search_info.datetime;
self.search_start_monitor := L.search_info.start_monitor;
self.search_stop_monitor := L.search_info.stop_monitor;
self.search_login_history_id := L.search_info.login_history_id;
self.search_transaction_id := L.search_info.transaction_id;
self.search_sequence_number := L.search_info.sequence_number;
self.search_method := L.search_info.method;
self.search_product_code := L.search_info.product_code;
self.search_transaction_type := L.search_info.transaction_type;
self.search_function_description := L.search_info.function_description;
self.search_ipaddr := L.search_info.ipaddr;
//stringsource;
self.source := L.source;
//unsigned8persistent_record_id;
self.persistent_record_id := L.persistent_record_id;
//layout_address_characteristics address_characteristics;
self.listed_phone := L.address_characteristics.listed_phone;
self.listed_phone_fname := L.address_characteristics.listed_phone_fname;
self.listed_phone_lname := L.address_characteristics.listed_phone_lname;
//layout_phone_characteristics phone_characteristics;
self.phone_indicator := L.phone_characteristics.phone_indicator;
self.phone_type := L.phone_characteristics.phone_type;
self.listed_prim_range := L.phone_characteristics.listed_prim_range;
self.listed_predir := L.phone_characteristics.listed_predir;
self.listed_prim_name := L.phone_characteristics.listed_prim_name;
self.listed_suffix := L.phone_characteristics.listed_suffix;
self.listed_postdir := L.phone_characteristics.listed_postdir;
self.listed_unit_desig := L.phone_characteristics.listed_unit_desig;
self.listed_sec_range := L.phone_characteristics.listed_sec_range;
self.listed_city_name := L.phone_characteristics.listed_city_name;
self.listed_st := L.phone_characteristics.listed_st;
self.listed_zip := L.phone_characteristics.listed_zip;
self.listed_fname := L.phone_characteristics.listed_fname;
self.listed_lname := L.phone_characteristics.listed_lname;
self.disconnects_last_12months := L.phone_characteristics.disconnects_last_12months;
self.zipcode_phone_match := L.phone_characteristics.zipcode_phone_match;
self.highriskphone_description := L.phone_characteristics.highriskphone_description;
//unsigned8 __internal_fpos__;

END;




EXPORT file_Key_fcra_inquiries := project(key_in,makerecord(left));
