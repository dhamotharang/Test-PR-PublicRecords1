IMPORT dx_common, dx_Property, doxie;

// NOTE: Testcases below are somewhat superficial. This unit test suite needs to be expanded to include
//  a test key with fake/canned data and then drive the testcases based on that.

// key must have incremental metadata fields (dx_common.dx_common.layout_metadata)
myKey := dx_Property.Key_Foreclosures_FID;

fids := dataset([
     {'003010557BANKOFAMERICA', 1}
    ,{'003010557BANKOFAMERICANA', 2}
    ,{'004618319CITIZENSBANKNA', 3}
    ,{'003010557BANKOFAMERICANA', 4}
    ,{'(011)0615-0041-0000FEDERALNATIONALMORTGAGEASSOCIATION', 5} // multiple matches
    ,{'003010557BANKOFAMERICANA', 6}
    ,{'(011)0615-0041-0000FEDERALNATIONALMORTGAGEASSOCIATION', 7} // multiple matches
    ,{'NONONONONO', 100}
  ], {string70 fid; unsigned ref;});


frecs_get_a := dx_common.Incrementals.mac_Fetch(fids, myKey,
  KEYED(LEFT.fid = RIGHT.fid),
  {string10 situs1_prim_range; string28 situs1_prim_name; string5 situs1_zip;}
  );
OUTPUT(SORT(frecs_get_a, ref), NAMED('test_get_a'));
ASSERT(COUNT(frecs_get_a)=9, 'assert get_a');

frecs_get_b := dx_common.Incrementals.mac_Fetch(fids, myKey,
  KEYED(LEFT.fid = RIGHT.fid),
  {string10 situs1_prim_range; string28 situs1_prim_name; string5 situs1_zip;},
  inf_limit_number := 10000,
  inf_keep_number := 1
  );
OUTPUT(SORT(frecs_get_b, ref), NAMED('test_get_b'));  
ASSERT(COUNT(frecs_get_b)=7, 'assert get_b');

// testing with delta keep number
frecs_get_c := dx_common.Incrementals.mac_Fetch(fids, myKey,
  KEYED(LEFT.fid = RIGHT.fid),
  {string10 situs1_prim_range; string28 situs1_prim_name; string5 situs1_zip;},
  inf_limit_number := 10000,
  inf_keep_number := 1,
  inf_delta_keep_number := 100 
  );
OUTPUT(SORT(frecs_get_c, ref), NAMED('test_get_c'));
ASSERT(COUNT(frecs_get_c)=7, 'assert get c');

// testing with grouped input
gfids := GROUP(SORT(fids, fid), fid);
frecs_get_d := dx_common.Incrementals.mac_Fetch(gfids, myKey,
  KEYED(LEFT.fid = RIGHT.fid),
  {string10 situs1_prim_range; string28 situs1_prim_name; string5 situs1_zip;},
  inf_limit_number := 10000,
  inf_keep_number := 1
  );
OUTPUT(SORT(frecs_get_d, ref), NAMED('test_get_d')); 
ASSERT(COUNT(frecs_get_d)=7, 'assert get d');
// line below will trigger "branches of the condition have different grouping" error. 
// branch_get_c := IF(~EXISTS(frecs_get_c), gfids, gfids + PROJECT(frecs_get_c, TRANSFORM(RECORDOF(fids), SELF := LEFT)));
// branch_get_c;

frecs_append_a := dx_common.Incrementals.mac_Fetch(fids, myKey,
  KEYED(LEFT.fid = RIGHT.fid),
  {string10 situs1_prim_range; string28 situs1_prim_name; string5 situs1_zip;},
  LEFT_OUTER_JOIN := TRUE);
OUTPUT(SORT(frecs_append_a, ref), NAMED('test_append_a')); 
ASSERT(COUNT(frecs_append_a)=10, 'assert append a');

frecs_append_b := dx_common.Incrementals.mac_Fetch(fids, myKey,
  KEYED(LEFT.fid = RIGHT.fid),
  {string10 situs1_prim_range; string28 situs1_prim_name; string5 situs1_zip;},
  inf_limit_number := 10000,
  inf_keep_number := 1,
  LEFT_OUTER_JOIN := TRUE
  );
OUTPUT(SORT(frecs_append_b, ref), NAMED('test_append_b'));
ASSERT(COUNT(frecs_append_b)=8, 'assert append b');

frecs_append_c := dx_common.Incrementals.mac_Fetch(fids, myKey,
  KEYED(LEFT.fid = RIGHT.fid),
  {string10 situs1_prim_range; string28 situs1_prim_name; string5 situs1_zip;},
  inf_keep_number := 1,
  inf_delta_keep_number := 100,
  LEFT_OUTER_JOIN := TRUE
  );
OUTPUT(SORT(frecs_append_c, ref), NAMED('test_append_c'));
ASSERT(COUNT(frecs_append_c)=8, 'assert append c');




