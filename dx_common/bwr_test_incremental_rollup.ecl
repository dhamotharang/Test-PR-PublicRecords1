
// Use to test incremental rollup logic.
//  -- can be tested in conjuction with a test delta rid key.

test_rec := RECORD
  integer seq;
  unsigned8 record_sid; 
  unsigned6 did; 
  string8 dob; 
  string20 fname; 
  string20 lname; 
  string5 zip; 
  unsigned4 dt_effective_first; 
  unsigned4 dt_effective_last;
  UNSIGNED1 delta_ind := 0; // 0 - main record, 1 - incremental  
END;

IND_MAIN_REC := 0;
IND_DELTA_REC := 1;

test_recs := DATASET([
   {1, 100, 1100, '19700101', 'JOHN', 'SMITH', '30005', 20160103, 0, IND_MAIN_REC}
  ,{2, 101, 1100, '19710217', 'JONNY', 'SMITH', '30005', 20151214, 0, IND_MAIN_REC}
  ,{3, 102, 1100, '', 'JOHN', 'SMITH', '30005', 20100402, 0, IND_MAIN_REC}
  ,{4, 103, 1100, '19700101', 'JONNY', 'SMITH', '30009', 20141119, 0, IND_MAIN_REC}
  ,{5, 104, 1100, '19700101', 'JONNY', 'SMITH', '30009', 20120719, 0, IND_MAIN_REC}
  ,{6, 107, 1100, '19700101', 'JON', 'SMITH', '30009', 20120719, 0, IND_MAIN_REC}
  ,{7, 105, 1105, '0', 'JONATHAN', 'SMITH', '30009', 20200820, 0, IND_DELTA_REC} // new record
  ,{8, 106, 1106, '0', 'JOHN', 'SMITHY', '30005', 20200820, 0, IND_DELTA_REC} // new record
  ,{9, 107, 1107, '19720501', 'JOHN', 'SMITH', '30009', 20200820, 0, IND_DELTA_REC} // update existing record
  ,{10, 103, 1100, '19700101', 'JONNY', 'SMITH', '30005', 20200821, 20200821, IND_DELTA_REC} // delete existing record
  ,{11, 102, 1100, '', 'JOHN', 'SMITH', '30005', 20200821, 20200821, IND_DELTA_REC} // delete existing record
  ,{12, 102, 1100, '', 'JOHN', 'SMITH', '30005', 20200822, 0, IND_DELTA_REC} // add previously deleted record
], test_rec);

// use for building test rid key
test_base_recs := test_recs + DATASET([
  {13, 100, 1100, '19700101', '(DROP)JOHN', 'SMITH', '30005', 20200822, 0, IND_DELTA_REC} // update in delta rid key only
  ], test_rec);
  
expected_results := dataset([
  // {1, 100, 1100, '19700101', 'JOHN', 'SMITH', '30005', 20160103, 0, false}, // should drop if using delta rid key
  {2, 101, 1100, '19710217', 'JONNY', 'SMITH', '30005', 20151214, 0, IND_MAIN_REC}
  ,{3, 102, 1100, '', 'JOHN', 'SMITH', '30005', 20200822, 0, IND_DELTA_REC} 
  ,{4, 104, 1100, '19700101', 'JONNY', 'SMITH', '30009', 20120719, 0, IND_MAIN_REC}
  ,{5, 105, 1105, '0', 'JONATHAN', 'SMITH', '30009', 20200820, 0, IND_DELTA_REC}
  ,{6, 106, 1106, '0', 'JOHN', 'SMITHY', '30005', 20170102, 0, IND_DELTA_REC}
  ,{7, 107, 1107, '19720501', 'JOHN', 'SMITH', '30009', 20150805, 0, IND_DELTA_REC}
  ], test_rec);

mod_key := MODULE
  EXPORT layout := dx_common.layout_ridkey;
  SHARED base_file := '~cloud::poc::base_delta_rid';
  SHARED base_recs := DATASET(base_file, test_rec, THOR);
  SHARED delta_recs := PROJECT(base_recs(delta_ind=IND_DELTA_REC), TRANSFORM(layout, SELF := LEFT));
  EXPORT build_base := output(test_base_recs,, base_file, OVERWRITE);  
  EXPORT key := INDEX(delta_recs, {record_sid}, {delta_recs}, '~cloud::poc::key_delta_rid');
  EXPORT build_key:= BUILDINDEX(key, OVERWRITE);
END;

buildRidKey := SEQUENTIAL(
  // mod_key.build_base;
  // mod_key.build_key;
  output(mod_key.key, named('key_delta_rid'));
);

// results := dx_common.Incrementals.mac_Rollup(test_recs);
results := dx_common.Incrementals.mac_Rollup(test_recs, mod_key.key);
// results := dx_common.Incrementals.mac_Rollup(test_recs, mod_key.key,,,,TRUE);

eval_recs := join(expected_results, results, 
  left.record_sid = right.record_sid and 
  left.did = right.did and
  left.dob = right.dob and
  left.fname = right.fname and
  left.lname = right.lname and
  left.zip = right.zip,
  // transform(left),
  full only);

outputResults := SEQUENTIAL(
  output(test_recs, named('test_recs'));
  output(mod_key.key, named('key_delta_rid'));
  output(sort(results, record_sid), named('results'));
  output(sort(expected_results, record_sid), named('expected_results'));
  output(eval_recs, named('eval_recs')); // if empty = success
);

// buildRidKey;
outputResults;



