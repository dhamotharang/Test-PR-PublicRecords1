// Output(ln_propertyv2.key_ownership_did(true));

// #CONSTANT('DataLocationCC', 'NONAME');  
import ln_propertyv2;
// key_in := ln_propertyv2.key_ownership_did(true);

layout_key_out := RECORD
/*l_hist := RECORD
   unsigned4 dt_seen;
   string12 ln_fares_id;
   unsigned6 owner_did;
  END;

RECORD
  unsigned6 did;
  boolean current;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  DATASET(l_hist) hist{maxcount(100)};
	unsigned4 dt_seen;
  string12 ln_fares_id;
  unsigned6 owner_did;
  string20 fname;
  string20 lname;
  string5 fips_code;
  string45 unformatted_apn;
  string2 orig_state;
  string30 orig_county;
  string250 legal_brief_description;
  unsigned8 rawaid;
  unsigned8 aceaid;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 suffix;
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
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  unsigned8 __internal_fpos__;
 END;*/


  unsigned6 did;
  boolean current;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  // DATASET(l_hist) hist{maxcount(100)};
	string7 dt_seen;
  string12 ln_fares_id;
  string3 owner_did;
  string20 fname;
  string20 lname;
  string5 fips_code;
  string45 unformatted_apn;
  string2 orig_state;
  string30 orig_county;
  string250 legal_brief_description;
  unsigned8 rawaid;
  unsigned8 aceaid;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 suffix;
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
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  unsigned8 __internal_fpos__;
 END;

 key_in := ln_propertyv2.key_ownership_did(true);

// transform statement
layout_key_out makerecord (key_in L) := transform

self.did := L.did;
self.current := L.current;
self.dt_first_seen := L.dt_first_seen;
self.dt_last_seen := L.dt_last_seen;
self.dt_seen := 'DT SEEN';
self.ln_fares_id := 'LN FARES ID';
self.owner_did := 'OWNER DID';
self.fname := L.fname;
self.lname := L.lname;
self.fips_code := L.fips_code;
self.unformatted_apn := L.unformatted_apn;
self.orig_state := L.orig_state;
self.orig_county := L.orig_county;
self.legal_brief_description := L.legal_brief_description;
self.rawaid := L.rawaid;
self.aceaid := L.aceaid;
self.prim_range := L.prim_range;
self.predir := L.predir;
self.prim_name := L.prim_name;
self.suffix := L.suffix;
self.postdir := L.postdir;
self.unit_desig := L.unit_desig;
self.sec_range := L.sec_range;
self.p_city_name := L.p_city_name;
self.v_city_name := L.v_city_name;
self.st := L.st;
self.zip := L.zip;
self.zip4 := L.zip4;
self.cart := L.cart;
self.cr_sort_sz := L.cr_sort_sz;
self.lot := L.lot;
self.lot_order := L.lot_order;
self.dbpc := L.dbpc;
self.chk_digit := L.chk_digit;
self.rec_type := L.rec_type;
self.county := L.county;
self.geo_lat := L.geo_lat;
self.geo_long := L.geo_long;
self.msa := L.msa;
self.geo_blk := L.geo_blk;
self.geo_match := L.geo_match;
self.__internal_fpos__ := L.__internal_fpos__;
END;

EXPORT file_ln_propertyv2_key_ownership_did_true1 := project(key_in,makerecord(left));
