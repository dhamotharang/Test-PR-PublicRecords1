party_raw := uccv2_services.layout_ucc_party_raw_src;

EXPORT layout_ucc_party_address_src := RECORD
  // original
  party_raw.orig_address1;
  party_raw.orig_address2;
  party_raw.orig_city;
  party_raw.orig_state;
  party_raw.orig_zip5;
  party_raw.orig_zip4;
  party_raw.orig_country;
  party_raw.orig_province;
  party_raw.orig_postal_code;
  party_raw.foreign_indc;
  
  // assimilated from cleaned
  party_raw.address1;
  party_raw.address2;
  
  // cleaned
  party_raw.prim_range;
  party_raw.predir;
  party_raw.prim_name;
  party_raw.addr_suffix;
  party_raw.postdir;
  party_raw.unit_desig;
  party_raw.sec_range;
  party_raw.p_city_name;
  party_raw.v_city_name;
  party_raw.st;
  party_raw.zip5;
  party_raw.zip4;
  party_raw.geo_lat;
  party_raw.geo_long;
  party_raw.geo_match;
END;
