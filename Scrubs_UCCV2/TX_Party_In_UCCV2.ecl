IMPORT Scrubs_UCCV2, Data_Services;

EXPORT TX_Party_In_UCCV2 := DATASET(Data_Services.foreign_prod + 'thor_data400::base::UCC::Party::tx', 
                                     Scrubs_UCCV2.TX_Party_Layout_UCCV2, THOR);


// SHARED old_layout := RECORD, maxLength(32767)
// string31 tmsid;
  // string23 rmsid;
  // string120 orig_name;
  // string25 orig_lname;
  // string25 orig_fname;
  // string35 orig_mname;
  // string10 orig_suffix;
  // string9 duns_number;
  // string9 hq_duns_number;
  // string9 ssn;
  // string10 fein;
  // string45 incorp_state;
  // string30 corp_number;
  // string30 corp_type;
  // string60 orig_address1;
  // string60 orig_address2;
  // string30 orig_city;
  // string2 orig_state;
  // string5 orig_zip5;
  // string4 orig_zip4;
  // string30 orig_country;
  // string30 orig_province;
  // string9 orig_postal_code;
  // string1 foreign_indc;
  // string1 party_type;
  // unsigned integer6 dt_first_seen;
  // unsigned integer6 dt_last_seen;
  // unsigned integer6 dt_vendor_last_reported;
  // unsigned integer6 dt_vendor_first_reported;
  // string8 process_date;
  // string5 title;
  // string20 fname;
  // string20 mname;
  // string20 lname;
  // string5 name_suffix;
  // string3 name_score;
  // string60 company_name;
  // string10 prim_range;
  // string2 predir;
  // string28 prim_name;
  // string4 suffix;
  // string2 postdir;
  // string10 unit_desig;
  // string8 sec_range;
  // string25 p_city_name;
  // string25 v_city_name;
  // string2 st;
  // string5 zip5;
  // string4 zip4;
  // string3 county;
  // string4 cart;
  // string1 cr_sort_sz;
  // string4 lot;
  // string1 lot_order;
  // string2 dpbc;
  // string1 chk_digit;
  // string2 rec_type;
  // string2 ace_fips_st;
  // string3 ace_fips_county;
  // string10 geo_lat;
  // string11 geo_long;
  // string4 msa;
  // string7 geo_blk;
  // string1 geo_match;
  // string4 err_stat;
  // unsigned integer6 bdid;
  // unsigned integer6 did;
  // unsigned integer6 did_score;
  // unsigned integer6 bdid_score;
// END;

// SHARED TX_Party_In_UCCV2_old := DATASET(Data_Services.foreign_prod + 'thor_data400::base::UCC::Party::tx_father', 
                                         // old_layout, THOR);

// SHARED TX_Party_In_UCCV2_new := DATASET(Data_Services.foreign_prod + 'thor_data400::base::UCC::Party::tx', 
                                         // Scrubs_UCCV2.TX_Party_Layout_UCCV2, THOR);

// EXPORT TX_Party_In_UCCV2 := PROJECT(TX_Party_In_UCCV2_old, TRANSFORM(Scrubs_UCCV2.TX_Party_Layout_UCCV2, SELF := LEFT, SELF := [])) + TX_Party_In_UCCV2_new;
