IMPORT HealthCareProvider;
//export layout_HealthProvider := HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header;

//
// Modified layout used beginning it37 ... until the above header was checked in  for the rerun of
// it40
//
// export layout_HealthProvider := RECORD
    // HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header;
    // string1 DID_FLAG := '';
// END;


// export layout_HealthProvider := RECORD
  // unsigned8 rid;
  // unsigned8 lnpid;
  // unsigned8 did;
  // unsigned8 bdid;
  // unsigned6 dotid;
  // unsigned6 empid;
  // unsigned6 powid;
  // unsigned6 proxid;
  // unsigned6 seleid;
  // unsigned6 orgid;
  // unsigned6 ultid;
  // string2 src;
  // unsigned8 source_rid;
  // unsigned4 dt_first_seen;
  // unsigned4 dt_last_seen;
  // unsigned4 dt_vendor_first_reported;
  // unsigned4 dt_vendor_last_reported;
  // unsigned4 dt_lic_expiration;
  // unsigned4 dt_dea_expiration;
  // string1 ambiguous;
  // string1 consumer_disclosure;
  // string1 ssn_flag;
  // string1 dob_flag;
  // string1 lic_nbr_flag;
  // string1 fname_flag;
  // string1 mname_flag;
  // string1 lname_flag;
  // string1 addr_flag;
  // string1 tax_id_flag;
  // string1 fein_flag;
  // string1 upin_flag;
  // string1 npi_number_flag;
  // string1 dea_number_flag;
  // string1 phone_flag;
  // string1 clia_number_flag;
  // string1 suppress_address;
  // string9 ssn;
  // unsigned4 dob;
  // string10 phone;
  // string25 lic_nbr;
  // string2 lic_state;
  // string30 lic_type;
  // string5 title;
  // string20 fname;
  // string20 mname;
  // string28 lname;
  // string5 sname;
  // string120 cname;
  // string8 sic_code;
  // string1 gender;
  // string1 derived_gender;
  // unsigned8 address_id;
  // string1 address_classification;
  // string10 prim_range;
  // string2 predir;
  // string28 prim_name;
  // string4 addr_suffix;
  // string2 postdir;
  // string10 unit_desig;
  // string8 sec_range;
  // string25 p_city_name;
  // string25 v_city_name;
  // string2 st;
  // string5 zip;
  // string4 zip4;
  // string4 cart;
  // string1 cr_sort_sz;
  // string4 lot;
  // string1 lot_order;
  // string2 dbpc;
  // string1 chk_digit;
  // string2 rec_type;
  // string2 fips_state;
  // string3 fips_county;
  // string10 geo_lat;
  // string11 geo_long;
  // string4 msa;
  // string7 geo_blk;
  // string1 geo_match;
  // string4 err_stat;
  // string1 death_ind;
  // unsigned4 dod;
  // unsigned4 tax_id;
  // unsigned4 fein;
  // string6 upin;
  // string10 npi_number;
  // string10 dea_number;
  // string10 clia_number;
  // string30 vendor_id;
  // string1 did_flag;
// END;

//
// Used beginning it47
//
export layout_HealthProvider := HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header;