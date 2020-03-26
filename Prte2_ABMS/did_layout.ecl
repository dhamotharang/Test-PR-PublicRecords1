﻿Import Prte2;
layout_clean182_fips := RECORD
   string10 prim_range;
   string2 predir;
   string28 prim_name;
   string4 addr_suffix;
   string2 postdir;
   string10 unit_desig;
   string8 sec_range;
   string25 p_city_name;
   string25 v_city_name;
   string2 st;
   string5 zip;
   string4 zip4;
   string4 cart;
   string1 cr_sort_sz;
   string4 lot;
   string1 lot_order;
   string2 dbpc;
   string1 chk_digit;
   string2 rec_type;
   string2 fips_state;
   string3 fips_county;
   string10 geo_lat;
   string11 geo_long;
   string4 msa;
   string7 geo_blk;
   string1 geo_match;
   string4 err_stat;
  END;

layout_clean_name := RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
  END;

cleaned_phone := RECORD
   string10 phone;
  END;

Export did_layout:=RECORD
  unsigned6 did;
  string8 biog_number;
  string2 birth_day;
  string2 birth_month;
  string4 birth_year;
  string1 birth_date_suppress_ind;
  string67 birth_city;
  string67 birth_state;
  string67 birth_nation;
  string1 birth_location_suppress_ind;
  string40 first_name;
  string30 middle_name;
  string40 last_name;
  string15 name_suffix;
  string4 placement_cert;
  string100 placement_city;
  string2 placement_state;
  string1 gender;
  string1 board_certified;
  string10 npi;
  string10 dod;
  string4 board_code;
  string100 board_name;
  string1 participation;
  string8 moc_cert_id;
  string100 moc_cert_name;
  unsigned6 address_id;
  string2 state;
  string9 full_zip;
  string60 org1;
  string40 line1;
  string40 line2;
  string40 line3;
  string40 city;
  string40 country;
  string1 address_type;
  string1 address_suppress_ind;
  string6 contact_type;
  string250 description;
  string3 area_code;
  string3 exchange;
  string4 phone_last_four;
  unsigned6 address_occurrence_number;
  unsigned6 contact_occurrence_number;
  string8 dob;
  string1 dead_ind;
  string60 org_name;
  string40 additional_org_text;
  string40 address1;
  string40 address2;
  string10 phone_number;
  string website;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  string1 record_type;
  string board_source;
  unsigned8 raw_aid;
  unsigned8 ace_aid;
  unsigned6 bdid;
  unsigned1 bdid_score;
  unsigned8 lnpid;
  layout_clean182_fips clean_company_address;
  layout_clean_name clean_name;
  cleaned_phone clean_phone;
  string address_type_desc;
 	PRTE2.LAYOUTS.DEFLT_CPA;
 END;
