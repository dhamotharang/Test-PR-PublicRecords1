// Output(ln_propertyv2.key_ownership.addr(true));

// #CONSTANT('DataLocationCC', 'NONAME');  
import ln_propertyv2;
// key_in := ln_propertyv2.key_ownership.addr(true);

layout_key_out := RECORD
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string8 sec_range;
  string5 zip5;
  unsigned8 rawaid;
  unsigned8 aceaid;
  string5 fips_code;
  string45 unformatted_apn;
  // DATASET(l_hist_thin) hist{maxcount(100)};
	string12 ln_fares_id;
  string7 dt_seen;
  // DATASET(l_owner_thin) owners{maxcount(10)};
  string3 did;
  string10 which_orig;
  string14 isbdid;
  string __internal_fpos__;
 END;

key_in := ln_propertyv2.key_ownership.addr(true);

// transform statement
layout_key_out makerecord (key_in L) := transform
self.prim_range  := L.prim_range;
self.predir  := L.predir;
self.prim_name  := L.prim_name;
self.addr_suffix  := L.addr_suffix;
self.postdir  := L.postdir;
self.sec_range  := L.sec_range;
self.zip5  := L.zip5;
self.rawaid  := L.rawaid;
self.aceaid  := L.aceaid;
self.fips_code  := L.fips_code;
self.unformatted_apn  := L.unformatted_apn;
self.ln_fares_id  := 'LN FARED ID';
self.dt_seen  := 'DT SEEN' ;
self.did  := 'DID';
self.which_orig  := 'WHICH ORIG';
self.isbdid  := 'ISBID T OR F';
self.__internal_fpos__  := 'INTERNAL FPOS';
END;

EXPORT file_ln_propertyv2_key_ownership_addr_true := project(key_in,makerecord(left));
