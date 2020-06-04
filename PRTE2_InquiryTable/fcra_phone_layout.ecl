mbslayout := RECORD
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

ccpalayout := RECORD
   unsigned4 global_sid;
   unsigned8 record_sid;
  END;

Export fcra_phone_layout:=RECORD
  string10 phone10;
  mbslayout mbs;
  allowlayout allow_flags;
  businfolayout bus_intel;
  persondatalayout person_q;
  busdatalayout bus_q;
  bususerdatalayout bususer_q;
  permissablelayout permissions;
  searchlayout search_info;
  ccpalayout ccpa;
  unsigned8 __internal_fpos__;
 END;
