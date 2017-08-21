EXPORT layout_ln_propertyv2_key_ownership_did_true := RECORD
  unsigned6 did;
  boolean current;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  string5 fips_code;
  string45 unformatted_apn;
  unsigned8 rawaid;
  unsigned8 aceaid;
  // DATASET(l_hist_thin) hist{maxcount(100)};
	string12 ln_fares_id;
  string7 dt_seen;
  // DATASET(l_owner_thin) owners{maxcount(10)};
	string3 owner_thin_did;
  string10 which_orig;
  string14 isbdid;
  string __internal_fpos__;
 END;
