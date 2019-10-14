﻿EXPORT Layouts := MODULE

Export HMS_Base_Layout:=Record
  unsigned8 source_rid;
  string100 ln_key;
  string25 hms_src;
  string100 key;
  string25 id;
  string100 entityid;
  string50 license_number;
  string license_class_type;
  string2 license_state;
  string status;
  string issue_date;
  string expiration_date;
  string qualifier1;
  string qualifier2;
  string qualifier3;
  string qualifier4;
  string qualifier5;
  string rawclass;
  string rawissue_date;
  string rawexpiration_date;
  string rawstatus;
  string raw_number;
  string100 name;
  string50 first;
  string10 middle;
  string50 last;
  string10 suffix;
  string10 cred;
  unsigned3 age;
  string20 dateofbirth;
  string50 email;
  string1 gender;
  string20 dateofdeath;
  string50 firmname;
  string50 street1;
  string25 street2;
  string25 street3;
  string50 city;
  string2 address_state;
  string12 orig_zip;
  string50 orig_county;
  string50 country;
  string25 address_type;
  string20 phone1;
  string20 phone2;
  string20 phone3;
  string20 fax1;
  string20 fax2;
  string20 fax3;
  string20 other_phone1;
  string50 description;
  string25 specialty_class_type;
  string15 phone_number;
  string25 phone_type;
  string50 language;
  string50 graduated;
  string50 school;
  string50 location;
  string50 board;
  string50 offense;
  string20 offense_date;
  string50 action;
  string20 action_date;
  string20 action_start;
  string20 action_end;
  string50 npi_number;
  string50 csr_number;
  string50 dea_number;
  string prepped_addr1;
  string prepped_addr2;
  string20 clean_phone;
  string20 clean_phone1;
  string20 clean_phone2;
  string20 clean_phone3;
  string20 clean_fax1;
  string20 clean_fax2;
  string20 clean_fax3;
  string20 clean_other_phone1;
  string20 clean_dateofbirth;
  string20 clean_dateofdeath;
  string50 clean_company_name;
  string clean_issue_date;
  string clean_expiration_date;
  string20 clean_offense_date;
  string20 clean_action_date;
  string10 src;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned8 lnpid;
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
  string2 fips_st;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  unsigned8 rawaid;
  unsigned8 aceaid;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string1 name_type;
  unsigned8 nid;
  unsigned6 did;
  unsigned1 did_score;
  unsigned6 bdid;
  unsigned1 bdid_score;
  unsigned4 best_dob;
  string9 best_ssn;
  string5 clean_zip5;
  string4 clean_zip4;
  unsigned6 dotid;
  unsigned2 dotscore;
  unsigned2 dotweight;
  unsigned6 empid;
  unsigned2 empscore;
  unsigned2 empweight;
  unsigned6 powid;
  unsigned2 powscore;
  unsigned2 powweight;
  unsigned6 proxid;
  unsigned2 proxscore;
  unsigned2 proxweight;
  unsigned6 seleid;
  unsigned2 selescore;
  unsigned2 seleweight;
  unsigned6 orgid;
  unsigned2 orgscore;
  unsigned2 orgweight;
  unsigned6 ultid;
  unsigned2 ultscore;
  unsigned2 ultweight;
  string in_state;
  string in_class;
  string in_status;
  string in_qualifier1;
  string in_qualifier2;
  string mapped_class;
  string mapped_status;
  string mapped_qualifier1;
  string mapped_qualifier2;
  string mapped_pdma;
  string mapped_pract_type;
  string50 source_code;
  string15 taxonomy_code;
  string file_date;
  unsigned4 global_sid;
  unsigned8 record_sid;
 END;

Export Lnpid_Layout:=RECORD
  unsigned8 lnpid;
  string first;
  string middle;
  string last;
  string suffix;
  string cred;
  string practitioner_type;
  string firm_name;
  string address1;
  string address2;
  string city;
  string state;
  string zip;
  string phone1;
  string phone2;
  string fax1;
  string date_born;
  string date_died;
  string gender;
  string stlic_number;
  string stlic_state;
  string stlic_type;
  string stlic_status;
  string stlic_qualifier;
  string stlic_subqualifier;
  string stlic_issue_date;
  string stlic_exp_date;
  string npi;
  string taxonomy_code;
  string dea1;
  string hms_spec1;
  string hms_spec2;
  string append_prep_address1;
  string append_prep_addresslast;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
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
  string4 zip4;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string18 county_name;
  unsigned6 hms_lid;
  unsigned6 hms_agid;
  string1 advo_home_or_business;
  unsigned8 rawaid;
  unsigned4 clean_stlic_issue_date;
  unsigned4 clean_stlic_exp_date;
  unsigned2 lnpid_score;
  unsigned2 lnpid_weight;
  unsigned2 lnpid_distance;
  unsigned4 lnpid_keysused;
 END;


End;