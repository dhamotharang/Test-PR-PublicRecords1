// Output(ln_propertyv2.key_ownership.did(true));

// #CONSTANT('DataLocationCC', 'NONAME');  
import ln_propertyv2;
// key_in := ln_propertyv2.key_ownership.did(true);

layout_key_out := RECORD
/*l_owner_thin := RECORD
    unsigned6 did;
    unsigned1 which_orig;
    boolean isbdid;
   END;

l_hist_thin := RECORD
   string12 ln_fares_id;
   unsigned4 dt_seen;
   DATASET(l_owner_thin) owners{maxcount(10)};
	 unsigned6 did;
   unsigned1 which_orig;
   boolean isbdid;
  END;*/

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

 key_in := ln_propertyv2.key_ownership.did(true);

// transform statement
layout_key_out makerecord (key_in L) := transform

self.did := L.did;
self.current := L.current;
self.dt_first_seen := L.dt_first_seen;
self.dt_last_seen := L.dt_last_seen;
self.fips_code := L.fips_code;
self.unformatted_apn := L.unformatted_apn;
self.rawaid := L.rawaid;
self.aceaid := L.aceaid;
self.ln_fares_id  := 'LN FARES ID';
self.dt_seen  := 'DT SEEN' ;
self.owner_thin_did  := 'OWNER THIN DID';
self.which_orig  := 'WHICH ORIG';
self.isbdid  := 'ISBID T OR F';
self.__internal_fpos__  := 'INTERNAL FPOS';
END;

EXPORT file_ln_propertyv2_key_ownership_did_true := project(key_in,makerecord(left));
