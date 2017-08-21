IMPORT standard;

export layout_SANCTN_party_clean_blk :=
RECORD
  string8 batch_number;
  string8 incident_number;
  string8 party_number;
  string1 record_type;
  string4 order_number;
  string45 party_name;
  string45 party_position;
  string45 party_vocation;
  string70 party_firm;
  string45 inaddress;
  string45 incity;
  string20 instate;
  string10 inzip;
  string11 ssnumber;
  string10 fines_levied;
  string10 restitution;
  string1 ok_for_fcr;
  string255 party_text;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string45 cname;
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
  string5 zip5;
  string4 zip4;
  string2 fips_state;
  string3 fips_county;
  string2 addr_rec_type;
  string10 geo_lat;
  string11 geo_long;
  string4 cbsa;
  string7 geo_blk;
  string1 geo_match;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string4 err_stat;
  string blk;
  unsigned6 did;
  unsigned3 did_score;
  unsigned6 bdid;
  unsigned3 bdid_score;
  string9 ssn_appended;
 END;




