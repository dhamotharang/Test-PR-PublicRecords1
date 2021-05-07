import ut;

_DEBUG := FALSE;
// _DEBUG := TRUE;

in_rec := RECORD
  unsigned6 did;
  string20 fname;
  string20 lname;
  string20 ref;
END;

key_rec := RECORD
  unsigned6 did;
  string8 dob;
  string20 fname;
  string20 lname;
  string5 zip;
  string20 fav_color;
  unsigned8 record_sid;
  unsigned4 dt_effective_first;
  unsigned4 dt_effective_last;
  UNSIGNED1 delta_ind; // 0 - main record,  1 - delta add, 2 - delta update, 3 - delta delete
END;

out_rec := RECORD
  unsigned6 did;
  string8 dob;
  string20 fname;
  string20 lname;
  string5 zip;
  string20 fav_color;
  unsigned8 record_sid;
  unsigned4 dt_effective_first;
  unsigned4 dt_effective_last;
  UNSIGNED1 delta_ind;
  string20 ref := '';
END;

// just to simulate project after rollup macro (if in_rec changes, needs to be updated)
processLeftOuterRes() := MACRO
  SELF.did := LEFT.did; 
  SELF.fname := LEFT.fname; 
  SELF.lname := LEFT.lname; 
  SELF.ref := LEFT.ref; 
  SELF.dob := IF(LEFT.is_delta_delete, '', LEFT.dob);
  SELF.zip := IF(LEFT.is_delta_delete, '', LEFT.zip);
  SELF.fav_color := IF(LEFT.is_delta_delete, '', LEFT.fav_color);
  SELF.record_sid := IF(LEFT.is_delta_delete, 0, LEFT.record_sid);
  SELF.dt_effective_first := IF(LEFT.is_delta_delete, 0, LEFT.dt_effective_first);
  SELF.dt_effective_last := IF(LEFT.is_delta_delete, 0, LEFT.dt_effective_last);
  SELF.delta_ind := IF(LEFT.is_delta_delete, 0, LEFT.delta_ind);
  SELF := []
ENDMACRO;

runT(__tlabel, __inrecs, __key_recs, __delta_recs, __joinCond, __expected_recs, LEFTOUTER = FALSE) := FUNCTIONMACRO
  LOCAL __payload_recs := __key_recs + __delta_recs;
  LOCAL __jrecs := JOIN(__inrecs, __payload_recs, __joinCond, 
    #IF(LEFTOUTER)
    TRANSFORM(out_rec, SELF := LEFT; SELF := RIGHT), LEFT OUTER
    #ELSE
    TRANSFORM(out_rec, SELF.ref := LEFT.ref; SELF := RIGHT)
    #END
    );
  #IF(LEFTOUTER)
    LOCAL __mac_res := dx_common.Incrementals.mac_Rollupv2(__jrecs, flag_deletes := TRUE);
    LOCAL __mac_res_post := PROJECT(__mac_res, TRANSFORM(RECORDOF(__expected_recs), processLeftOuterRes()));
  #ELSE
    LOCAL __mac_res := dx_common.Incrementals.mac_Rollupv2(__jrecs);
    // LOCAL __mac_res := dx_common.Incrementals.mac_Rollup(__jrecs);
    LOCAL __mac_res_post := __mac_res;
  #END
  LOCAL __eval_recs := ut.CompareDatasets(SORT(__mac_res_post, RECORD), SORT(__expected_recs, RECORD));
  LOCAL __assert_cond := ~EXISTS(__eval_recs(__diff));
  IF(_DEBUG, output(__inrecs, named('inrecs_'+__tlabel)));
  IF(_DEBUG, output(__key_recs, named('key_recs_'+__tlabel)));
  IF(_DEBUG, output(__payload_recs, named('payload_recs_'+__tlabel)));
  IF(_DEBUG, output(__jrecs, named('jrecs_'+__tlabel)));
  IF(_DEBUG, output(__mac_res, named('mac_res_'+__tlabel)));
  IF(_DEBUG, output(__mac_res_post, named('mac_res_post_'+__tlabel)));
  IF(_DEBUG, output(__expected_recs, named('expected_recs_'+__tlabel)));
  output(__eval_recs, named('eval_recs_'+__tlabel));
  assert(__assert_cond);
  RETURN __assert_cond;
ENDMACRO;

// ********************************************
// t000: no record_sids in payload
inrecs_000 := DATASET([
  {1000, 'JOHN', 'SMITH', 'REF1'}
  ,{2000, 'MARY', 'SMITH', 'REF2'}
], in_rec);  
key_recs_000 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 0, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 0, 20210101, 0, 0}
  ], key_rec);
delta_recs_000 := DATASET([], key_rec);
payload_recs_000 := key_recs_000 + delta_recs_000;
expected_000 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 0, 20210101, 0, 0, 'REF1'}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 0, 20210101, 0, 0, 'REF2'}
], out_rec);

// ********************************************
// t001: inner join, no dupes, no deltas
inrecs_001 := DATASET([
  {1000, 'JOHN', 'SMITH', 'REF1'}
], in_rec);  
key_recs_001 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_001 := DATASET([], key_rec);
payload_recs_001 := key_recs_001 + delta_recs_001;
expected_001 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0, 'REF1'}
], out_rec);

// ********************************************
// t002: inner join, single delta update 
inrecs_002 := DATASET([
  {2000, 'MARY', 'SMITH', 'REF1'}
], in_rec);  
key_recs_002 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_002 := DATASET([
  {2000, '19830101', 'M', 'SMITH', '30005', 'YELLOW', 101, 20210401, 0, 2}
], key_rec);
expected_002 := DATASET([
  {2000, '19830101', 'M', 'SMITH', '30005', 'YELLOW', 101, 20210401, 0, 2, 'REF1'}
], out_rec);

// ********************************************
// t003: inner join, single delta delete 
inrecs_003 := DATASET([
  {2000, 'MARY', 'SMITH', 'REF1'}
], in_rec);  
key_recs_003 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_003 := DATASET([
  {2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210201, 20210201, 3}
], key_rec);
expected_003 := DATASET([], out_rec);

// ********************************************
// t004: inner join, hard delete, update
inrecs_004 := DATASET([
  {2000, 'MARY', 'SMITH', 'REF1'}
], in_rec);  
key_recs_004 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_004 := DATASET([
  {2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 20210202, 3}
  ,{2000, '19830101', 'M', 'SMITH', '30005', 'YELLOW', 101, 20210202, 0, 2}
], key_rec);
expected_004 := DATASET([
  {2000, '19830101', 'M', 'SMITH', '30005', 'YELLOW', 101, 20210202, 0, 2, 'REF1'}
], out_rec);

// ********************************************
// t005: inner join, hard delete, update, no match (fname,lname)
inrecs_005 := DATASET([
  {2000, 'MARY', 'SMITH', 'REF1'}
], in_rec);  
key_recs_005 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_005 := DATASET([
  {2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 20210202, 3}
  ,{2000, '19830101', 'M', 'SMITH', '30005', 'YELLOW', 101, 20210202, 0, 2}
], key_rec);
expected_005 := DATASET([
], out_rec);

// ********************************************
// t006: inner join, hard delete, update match search criteria (fname,lname)
inrecs_006 := DATASET([
  {2000, 'M', 'SMITH', 'REF1'}
], in_rec);  
key_recs_006 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_006 := DATASET([
  {2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 20210202, 3}
  ,{2000, '19830101', 'M', 'SMITH', '30005', 'YELLOW', 101, 20210202, 0, 2}
], key_rec);
expected_006 := DATASET([
  {2000, '19830101', 'M', 'SMITH', '30005', 'YELLOW', 101, 20210202, 0, 2, 'REF1'}
], out_rec);

// ********************************************
// t010: inner join, duplicate input, no delta (FAIL)
inrecs_010 := DATASET([
  {1000, 'JOHN', 'SMITH', 'REF1'}
  ,{1000, 'JOHN', 'SMITH', 'REF2'}
], in_rec);  
key_recs_010 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_010 := DATASET([
], key_rec);
expected_010 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0, 'REF1'}
  ,{1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0, 'REF2'}
], out_rec);

// ********************************************
// t011: inner join, duplicate input, delta delete
inrecs_011 := DATASET([
  {1000, 'JOHN', 'SMITH', 'REF1'}
  ,{1000, 'JOHN', 'SMITH', 'REF2'}
], in_rec);  
key_recs_011 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_011 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 20210203, 3} // delete
], key_rec);
expected_011 := DATASET([
], out_rec);

// ********************************************
// t012: inner join, duplicate input, delta hard-delete, update
inrecs_012 := DATASET([
  {1000, 'JOHN', 'SMITH', 'REF1'}
  ,{1000, 'JOHN', 'SMITH', 'REF2'}
], in_rec);  
key_recs_012 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_012 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 20210203, 3} // delete
  ,{1000, '19800204', 'J', 'SMITH', '30005', 'RED', 100, 20210203, 0, 2} // update
], key_rec);
expected_012 := DATASET([
  {1000, '19800204', 'J', 'SMITH', '30005', 'RED', 100, 20210203, 0, 2, 'REF1'}
  ,{1000, '19800204', 'J', 'SMITH', '30005', 'RED', 100, 20210203, 0, 2, 'REF2'}
], out_rec);

// ********************************************
// t013: inner join, duplicate input, delta hard-delete, update drops matching records (fname + lname)
inrecs_013 := DATASET([
  {1000, 'JOHN', 'SMITH', 'REF1'}
  ,{2000, 'MARY', 'SMITH', 'REF2'}
  ,{1000, 'JOHN', 'SMITH', 'REF3'}
], in_rec);  
key_recs_013 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_013 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 20210203, 3} // delete
  ,{1000, '19800204', 'J', 'SMITH', '30005', 'RED', 100, 20210203, 0, 2} // update
], key_rec);
expected_013 := DATASET([
  {2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0, 'REF2'}
], out_rec);


// ********************************************
// t020:  inner join, single input, multiple matches, no deltas
inrecs_020 := DATASET([
  {1000, 'JOHN', 'SMITH', 'REF1'}
], in_rec);  
key_recs_020 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ,{1000, '19800204', 'J', 'SMITH', '30005', 'YELLOW', 102, 20210201, 0, 0}
  ], key_rec);
delta_recs_020 := DATASET([], key_rec);
expected_020 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0, 'REF1'}
  ,{1000, '19800204', 'J', 'SMITH', '30005', 'YELLOW', 102, 20210201, 0, 0, 'REF1'}
], out_rec);

// ********************************************
// t021:  inner join, single input, multiple matches, delta hard delete + update
inrecs_021 := DATASET([
  {1000, 'JOHN', 'SMITH', 'REF1'}
], in_rec);  
key_recs_021 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ,{1000, '19800204', 'J', 'SMITH', '30005', 'YELLOW', 102, 20210201, 0, 0}
  ], key_rec);
delta_recs_021 := DATASET([
  {1000, '19800204', 'J', 'SMITH', '30005', 'YELLOW', 102, 20210201, 20210301, 3} 
  ,{1000, '19800204', 'J', 'SMITH', '30005', 'RED', 102, 20210301, 0, 1} 
], key_rec);
expected_021 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0, 'REF1'}
  ,{1000, '19800204', 'J', 'SMITH', '30005', 'RED', 102, 20210301, 0, 1, 'REF1'}
], out_rec);

// ********************************************
// t030:  inner join, multiple input, multiple matches, no deltas (FAIL)
inrecs_030 := DATASET([
  {1000, 'JOHN', 'SMITH', 'REF1'}
  ,{1000, 'JOHN', 'SMITH', 'REF2'}
], in_rec);  
key_recs_030 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ,{1000, '19800204', 'J', 'SMITH', '30005', 'YELLOW', 102, 20210201, 0, 0}
  ], key_rec);
delta_recs_030 := DATASET([], key_rec);
expected_030 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0, 'REF1'}
  ,{1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0, 'REF2'}
  ,{1000, '19800204', 'J', 'SMITH', '30005', 'YELLOW', 102, 20210201, 0, 0, 'REF1'}
  ,{1000, '19800204', 'J', 'SMITH', '30005', 'YELLOW', 102, 20210201, 0, 0, 'REF2'}
], out_rec);

// ********************************************
// t031:  inner join, multiple input, multiple matches, delta delete 
inrecs_031 := DATASET([
  {1000, 'JOHN', 'SMITH', 'REF1'}
  ,{1000, 'JOHN', 'SMITH', 'REF2'}
], in_rec);  
key_recs_031 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ,{1000, '19800204', 'J', 'SMITH', '30005', 'YELLOW', 102, 20210201, 0, 0}
  ], key_rec);
delta_recs_031 := DATASET([
  {1000, '19800204', 'J', 'SMITH', '30005', 'YELLOW', 102, 20210201, 20210301, 3} // delete
], key_rec);
expected_031 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0, 'REF1'}
  ,{1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0, 'REF2'}
], out_rec);

// ********************************************
// t050: left outer join, input with match, no dupes, no deltas
inrecs_050 := DATASET([
  {1000, 'JOHN', 'SMITH', 'REF1'}
], in_rec);  
key_recs_050 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_050 := DATASET([], key_rec);
expected_050 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0, 'REF1'}
], out_rec);

// ********************************************
// t051: left outer join, input with no match, no dupes, no deltas
inrecs_051 := DATASET([
  {1500, 'PETER', 'SMITH', 'REF1'}
], in_rec);  
key_recs_051 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_051 := DATASET([], key_rec);
expected_051 := DATASET([
  {1500, '', 'PETER', 'SMITH', '', '', 0, 0, 0, 0, 'REF1'}
], out_rec);

// ********************************************
// t052: left outer join, input with dupes, no match, no deltas
inrecs_052 := DATASET([
  {1500, 'PETER', 'SMITH', 'REF1'}
  ,{2500, 'JAMES', 'SMITH', 'REF2'}
  ,{1500, 'PETER', 'SMITH', 'REF3'}
], in_rec);  
key_recs_052 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_052 := DATASET([], key_rec);
expected_052 := DATASET([
  {1500, '', 'PETER', 'SMITH', '', '', 0, 0, 0, 0, 'REF1'}
  ,{2500, '', 'JAMES', 'SMITH', '', '', 0, 0, 0, 0, 'REF2'}
  ,{1500, '', 'PETER', 'SMITH', '', '', 0, 0, 0, 0, 'REF3'}
], out_rec);

// ********************************************
// t053: left outer join, input with dupes, 1 match, no deltas
inrecs_053 := DATASET([
  {1500, 'PETER', 'SMITH', 'REF1'}
  ,{2000, 'MARY', 'SMITH', 'REF2'}
  ,{1500, 'PETER', 'SMITH', 'REF3'}
], in_rec);  
key_recs_053 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_053 := DATASET([], key_rec);
expected_053 := DATASET([
  {1500, '', 'PETER', 'SMITH', '', '', 0, 0, 0, 0, 'REF1'}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0, 'REF2'}
  ,{1500, '', 'PETER', 'SMITH', '', '', 0, 0, 0, 0, 'REF3'}
], out_rec);

// ********************************************
// t054: left outer join, match on delta delete, no dupes
inrecs_054 := DATASET([
   {1000, 'JOHN', 'SMITH', 'REF1'}
  ,{1500, 'PETER', 'SMITH', 'REF2'}
], in_rec);  
key_recs_054 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_054 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210201, 20210201, 0}
], key_rec);
expected_054 := DATASET([
  {1000, '', 'JOHN', 'SMITH', '', '', 0, 0, 0, 0, 'REF1'}
  ,{1500, '', 'PETER', 'SMITH', '', '', 0, 0, 0, 0, 'REF2'}
], out_rec);

// ********************************************
// t055: left outer join, match on delta delete, with dupes
inrecs_055 := DATASET([
   {1000, 'JOHN', 'SMITH', 'REF1'}
  ,{1500, 'PETER', 'SMITH', 'REF2'}
  ,{1000, 'JOHN', 'SMITH', 'REF3'}
], in_rec);  
key_recs_055 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_055 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210201, 20210201, 0}
], key_rec);
expected_055 := DATASET([
  {1000, '', 'JOHN', 'SMITH', '', '', 0, 0, 0, 0, 'REF1'}
  ,{1500, '', 'PETER', 'SMITH', '', '', 0, 0, 0, 0, 'REF2'}
  ,{1000, '', 'JOHN', 'SMITH', '', '', 0, 0, 0, 0, 'REF3'}
], out_rec);

// ********************************************
// t056: left outer join, match on delta hard-delete with update, no dupes
inrecs_056 := DATASET([
   {1000, 'JOHN', 'SMITH', 'REF1'}
  ,{1500, 'PETER', 'SMITH', 'REF2'}
], in_rec);  
key_recs_056 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_056 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210201, 20210201, 0}
  ,{1000, '19800204', 'JOHN', 'SMITH', '30005', 'GREEN', 100, 20210202, 0, 0}
], key_rec);
expected_056 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'GREEN', 100, 20210202, 0, 0, 'REF1'}
  ,{1500, '', 'PETER', 'SMITH', '', '', 0, 0, 0, 0, 'REF2'}
], out_rec);

// ********************************************
// t057: left outer join, match on delta hard-delete with update, with dupes
inrecs_057 := DATASET([
   {1000, 'JOHN', 'SMITH', 'REF1'}
  ,{1500, 'PETER', 'SMITH', 'REF2'}
  ,{1000, 'JOHN', 'SMITH', 'REF3'}
], in_rec);  
key_recs_057 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_057 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 20210202, 0}
  ,{1000, '19800204', 'JOHN', 'SMITH', '30005', 'GREEN', 100, 20210202, 0, 0}
], key_rec);
expected_057 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'GREEN', 100, 20210202, 0, 0, 'REF1'}
  ,{1500, '', 'PETER', 'SMITH', '', '', 0, 0, 0, 0, 'REF2'}
  ,{1000, '19800204', 'JOHN', 'SMITH', '30005', 'GREEN', 100, 20210202, 0, 0, 'REF3'}
], out_rec);

// ********************************************
// t058: left outer join, match on delta hard-delete + update + delete, no dupes
inrecs_058 := DATASET([
   {1000, 'JOHN', 'SMITH', 'REF1'}
  ,{1500, 'PETER', 'SMITH', 'REF2'}
], in_rec);  
key_recs_058 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_058:= DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210201, 20210201, 0}
  ,{1000, '19800204', 'JOHN', 'SMITH', '30005', 'GREEN', 100, 20210301, 0, 0}
  ,{1000, '19800204', 'JOHN', 'SMITH', '30005', 'GREEN', 100, 20210401, 20210401, 0}
], key_rec);
expected_058 := DATASET([
  {1000, '', 'JOHN', 'SMITH', '', '', 0, 0, 0, 0, 'REF1'}
  ,{1500, '', 'PETER', 'SMITH', '', '', 0, 0, 0, 0, 'REF2'}
], out_rec);

// ********************************************
// t059: left outer join, match on delta hard-delete + update + hard-delete + update
inrecs_059 := DATASET([
   {1000, 'JOHN', 'SMITH', 'REF1'}
  ,{1500, 'PETER', 'SMITH', 'REF2'}
], in_rec);  
key_recs_059 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_059 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 20210201, 0}
  ,{1000, '19800204', 'JOHN', 'SMITH', '30005', 'GREEN', 100, 20210201, 0, 0}
  ,{1000, '19800204', 'JOHN', 'SMITH', '30005', 'GREEN', 100, 20210201, 20210301, 0}
  ,{1000, '19800204', 'JOHN', 'SMITH', '30005', 'RED', 100, 20210301, 0, 0}
], key_rec);
expected_059 := DATASET([
   {1000, '19800204', 'JOHN', 'SMITH', '30005', 'RED', 100, 20210301, 0, 0, 'REF1'}
  ,{1500, '', 'PETER', 'SMITH', '', '', 0, 0, 0, 0, 'REF2'}
], out_rec);

// ********************************************
// t060: left outer join, duplicate input, delta hard-delete, update drops matching records (fname + lname)
inrecs_060 := DATASET([
  {1000, 'JOHN', 'SMITH', 'REF1'}
  ,{2000, 'MARY', 'SMITH', 'REF2'}
  ,{1000, 'JOHN', 'SMITH', 'REF3'}
], in_rec);  
key_recs_060 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_060 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 20210205, 3} // delete
  ,{1000, '19800204', 'J', 'SMITH', '30005', 'RED', 100, 20210205, 0, 2} // update
], key_rec);
expected_060 := DATASET([
  {1000, '', 'JOHN', 'SMITH', '', '', 0, 0, 0, 0, 'REF1'}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0, 'REF2'}
  ,{1000, '', 'JOHN', 'SMITH', '', '', 0, 0, 0, 0, 'REF3'}
], out_rec);

// ********************************************
// t061: left outer join, match on delta hard-delete + update + hard-delete + update, join condition includes yellow
inrecs_061 := DATASET([
   {1000, 'JOHN', 'SMITH', 'REF1'}
  ,{1500, 'PETER', 'SMITH', 'REF2'}
], in_rec);
key_recs_061 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_061 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 20210201, 0}
  ,{1000, '19800204', 'JOHN', 'SMITH', '30005', 'GREEN', 100, 20210201, 0, 0}
  ,{1000, '19800204', 'JOHN', 'SMITH', '30005', 'GREEN', 100, 20210201, 20210301, 0}
  ,{1000, '19800204', 'JOHN', 'SMITH', '30005', 'RED', 100, 20210301, 0, 0}
], key_rec);
expected_061 := DATASET([
   {1000, '', 'JOHN', 'SMITH', '', '', 0, 0, 0, 0, 'REF1'}
  ,{1500, '', 'PETER', 'SMITH', '', '', 0, 0, 0, 0, 'REF2'}
], out_rec);

// ********************************************
// t062: left outer join, match on delta hard-delete + update + hard-delete + update, join condition includes green
inrecs_062 := DATASET([
   {1000, 'JOHN', 'SMITH', 'REF1'}
  ,{1500, 'PETER', 'SMITH', 'REF2'}
], in_rec);
key_recs_062 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_062 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 20210201, 0}
  ,{1000, '19800204', 'JOHN', 'SMITH', '30005', 'GREEN', 100, 20210201, 0, 0}
  ,{1000, '19800204', 'JOHN', 'SMITH', '30005', 'GREEN', 100, 20210201, 20210301, 0}
  ,{1000, '19800204', 'JOHN', 'SMITH', '30005', 'RED', 100, 20210301, 0, 0}
], key_rec);
expected_062 := DATASET([
   {1000, '', 'JOHN', 'SMITH', '', '', 0, 0, 0, 0, 'REF1'}
  ,{1500, '', 'PETER', 'SMITH', '', '', 0, 0, 0, 0, 'REF2'}
], out_rec);

// ********************************************
// t063: left outer join, match on delta hard-delete + update + hard-delete + update, join condition includes red
inrecs_063 := DATASET([
   {1000, 'JOHN', 'SMITH', 'REF1'}
  ,{1500, 'PETER', 'SMITH', 'REF2'}
], in_rec);
key_recs_063 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_063 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 20210201, 0}
  ,{1000, '19800204', 'JOHN', 'SMITH', '30005', 'GREEN', 100, 20210201, 0, 0}
  ,{1000, '19800204', 'JOHN', 'SMITH', '30005', 'GREEN', 100, 20210201, 20210301, 0}
  ,{1000, '19800204', 'JOHN', 'SMITH', '30005', 'RED', 100, 20210301, 0, 0}
], key_rec);
expected_063 := DATASET([
   {1000, '19800204', 'JOHN', 'SMITH', '30005', 'RED', 100, 20210301, 0, 0, 'REF1'}
  ,{1500, '', 'PETER', 'SMITH', '', '', 0, 0, 0, 0, 'REF2'}
], out_rec);

// ********************************************
// t064: left outer join, duplicate inputs, 2 updates, matches on did, dob, and color after updates
inrecs_064 := DATASET([
   {1000, 'JOHN', 'SMITH', 'REF1'}
  ,{1500, 'PETER', 'SMITH', 'REF2'}
  ,{1000, 'JOHN', 'SMITH', 'REF1'}
], in_rec);
key_recs_064 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_064 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 20210201, 0}
  ,{1000, '19800204', 'JOHN', 'SMITH', '30005', 'RED', 100, 20210201, 0, 0}
  ,{1000, '19800204', 'JOHN', 'SMITH', '30005', 'RED', 100, 20210201, 20210301, 0}
  ,{1000, '19810306', 'JOHN', 'SMITH', '30005', 'RED', 100, 20210301, 0, 0}
], key_rec);
expected_064 := DATASET([
   {1000, '19810306', 'JOHN', 'SMITH', '30005', 'RED', 100, 20210301, 0, 0, 'REF1'}
  ,{1500, '', 'PETER', 'SMITH', '', '', 0, 0, 0, 0, 'REF2'}
  ,{1000, '19810306', 'JOHN', 'SMITH', '30005', 'RED', 100, 20210301, 0, 0, 'REF1'}
], out_rec);

// ********************************************
// t065: left outer join, duplicate inputs, 2 updates, no matches but would match after 1st update if not for 2nd
inrecs_065 := DATASET([
   {1000, 'JOHN', 'SMITH', 'REF1'}
  ,{1500, 'PETER', 'SMITH', 'REF2'}
  ,{1000, 'JOHN', 'SMITH', 'REF1'}
], in_rec);
key_recs_065 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_065 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 20210201, 0}
  ,{1000, '19800204', 'JOHN', 'SMITH', '30005', 'RED', 100, 20210201, 0, 0}
  ,{1000, '19800204', 'JOHN', 'SMITH', '30005', 'RED', 100, 20210201, 20210301, 0}
  ,{1000, '19810306', 'JOHN', 'SMITH', '30005', 'RED', 100, 20210301, 0, 0}
], key_rec);
expected_065 := DATASET([
   {1000, '', 'JOHN', 'SMITH', '', '', 0, 0, 0, 0, 'REF1'}
  ,{1500, '', 'PETER', 'SMITH', '', '', 0, 0, 0, 0, 'REF2'}
  ,{1000, '', 'JOHN', 'SMITH', '', '', 0, 0, 0, 0, 'REF1'}
], out_rec);

// ********************************************
// t066: left outer join, duplicate inputs, 2 updates, would match on original if not updated
inrecs_066 := DATASET([
   {1000, 'JOHN', 'SMITH', 'REF1'}
  ,{1500, 'PETER', 'SMITH', 'REF2'}
  ,{1000, 'JOHN', 'SMITH', 'REF1'}
], in_rec);
key_recs_066 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{2000, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 101, 20210101, 0, 0}
  ], key_rec);
delta_recs_066 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 20210201, 0}
  ,{1000, '19800204', 'JOHN', 'SMITH', '30005', 'RED', 100, 20210201, 0, 0}
  ,{1000, '19800204', 'JOHN', 'SMITH', '30005', 'RED', 100, 20210201, 20210301, 0}
  ,{1000, '19810306', 'JOHN', 'SMITH', '30005', 'RED', 100, 20210301, 0, 0}
], key_rec);
expected_066 := DATASET([
   {1000, '', 'JOHN', 'SMITH', '', '', 0, 0, 0, 0, 'REF1'}
  ,{1500, '', 'PETER', 'SMITH', '', '', 0, 0, 0, 0, 'REF2'}
  ,{1000, '', 'JOHN', 'SMITH', '', '', 0, 0, 0, 0, 'REF1'}
], out_rec);

// ********************************************
// t067: inner join, all duplicate inputs, multiple matches
inrecs_067:= DATASET([
  {1000, 'JOHN', 'SMITH', 'REF1'} //  match after two updates, color changes to aqua
  ,{1000, 'JOHN', 'SMITH', 'REF1'} // match after two updates, color changes to aqua
  ,{1500, 'PETER', 'SMITH', 'REF2'} // no match after update, color changes to red
  ,{1500, 'PETER', 'SMITH', 'REF2'} // no match after update, color changes to red
  ,{2000, 'GREG', 'GREGORSON', 'REF3'} // match original, no updates
  ,{2000, 'GREG', 'GREGORSON', 'REF3'} // match original, no updates
  ,{3000, 'ALEX', 'ALEXBURG', 'REF4'} // no matches
  ,{3000, 'ALEX', 'ALEXBURG', 'REF4'} // no matches
  ,{4000, 'DALE', 'DELETEME', 'REF5'} // deleted
  ,{4000, 'DALE', 'DELETEME', 'REF5'} // deleted
], in_rec);
key_recs_067 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{1500, '19841006', 'PETER', 'SMITH', '33441', 'AQUA', 101, 20210101, 0, 0}
  ,{1600, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 102, 20210101, 0, 0}
  ,{2000, '19841006', 'GREG', 'GREGORSON', '22134', 'AQUA', 103, 20210101, 0, 0}
  ,{4000, '19841006', 'DALE', 'DELETEME', '44138', 'AQUA', 104, 20210101, 0, 0}
  ], key_rec);
delta_recs_067 := DATASET([
  {1000, '19810204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 20210102, 0}
  ,{1000, '19821214', 'JOHN', 'SMITH', '30005', 'RED', 100, 20210102, 0, 0}
  ,{1000, '19821214', 'JOHN', 'SMITH', '30005', 'RED', 100, 20210102, 20210103, 0}
  ,{1000, '19821214', 'JOHN', 'SMITH', '30005', 'AQUA', 100, 20210103, 0, 0}
  ,{1500, '19841006', 'PETER', 'SMITH', '33441', 'AQUA', 101, 20210101, 20210102, 0}
  ,{1500, '19841006', 'PETER', 'SMITH', '33441', 'RED', 101, 20210102, 0, 0}
  ,{4000, '19841006', 'DALE', 'DELETEME', '44138', 'AQUA', 104, 20210101, 20210102, 0}
], key_rec);
expected_067 := DATASET([
   {1000, '19821214', 'JOHN', 'SMITH', '30005', 'AQUA', 100, 20210103, 0, 0, 'REF1'}
   ,{1000, '19821214', 'JOHN', 'SMITH', '30005', 'AQUA', 100, 20210103, 0, 0, 'REF1'}
   ,{2000, '19841006', 'GREG', 'GREGORSON', '22134', 'AQUA', 103, 20210101, 0, 0, 'REF3'}
   ,{2000, '19841006', 'GREG', 'GREGORSON', '22134', 'AQUA', 103, 20210101, 0, 0, 'REF3'}
], out_rec);

// ********************************************
// t068: LEFT OUTER, all duplicate inputs, multiple matches
inrecs_068 := DATASET([
  {1000, 'JOHN', 'SMITH', 'REF1'} //  match after two updates, color changes to aqua
  ,{1000, 'JOHN', 'SMITH', 'REF1'} // match after two updates, color changes to aqua
  ,{1500, 'PETER', 'SMITH', 'REF2'} // no match after update, color changes to red
  ,{1500, 'PETER', 'SMITH', 'REF2'} // no match after update, color changes to red
  ,{2000, 'GREG', 'GREGORSON', 'REF3'} // match original, no updates
  ,{2000, 'GREG', 'GREGORSON', 'REF3'} // match original, no updates
  ,{3000, 'ALEX', 'ALEXBURG', 'REF4'} // no matches
  ,{3000, 'ALEX', 'ALEXBURG', 'REF4'} // no matches
  ,{4000, 'DALE', 'DELETEME', 'REF5'} // deleted
  ,{4000, 'DALE', 'DELETEME', 'REF5'} // deleted
], in_rec);
key_recs_068 := DATASET([
  {1000, '19800204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 0, 0}
  ,{1500, '19841006', 'PETER', 'SMITH', '33441', 'AQUA', 101, 20210101, 0, 0}
  ,{1600, '19830101', 'MARY', 'SMITH', '30005', 'YELLOW', 102, 20210101, 0, 0}
  ,{2000, '19841006', 'GREG', 'GREGORSON', '22134', 'AQUA', 103, 20210101, 0, 0}
  ,{4000, '19841006', 'DALE', 'DELETEME', '44138', 'AQUA', 104, 20210101, 0, 0}
  ], key_rec);
delta_recs_068 := DATASET([
  {1000, '19810204', 'JOHN', 'SMITH', '30005', 'YELLOW', 100, 20210101, 20210102, 0}
  ,{1000, '19821214', 'JOHN', 'SMITH', '30005', 'RED', 100, 20210102, 0, 0}
  ,{1000, '19821214', 'JOHN', 'SMITH', '30005', 'RED', 100, 20210102, 20210103, 0}
  ,{1000, '19821214', 'JOHN', 'SMITH', '30005', 'AQUA', 100, 20210103, 0, 0}
  ,{1500, '19841006', 'PETER', 'SMITH', '33441', 'AQUA', 101, 20210101, 20210102, 0}
  ,{1500, '19841006', 'PETER', 'SMITH', '33441', 'RED', 101, 20210102, 0, 0}
  ,{4000, '19841006', 'DALE', 'DELETEME', '44138', 'AQUA', 104, 20210101, 20210102, 0}
], key_rec);
expected_068 := DATASET([
   {1000, '19821214', 'JOHN', 'SMITH', '30005', 'AQUA', 100, 20210103, 0, 0, 'REF1'}
   ,{1000, '19821214', 'JOHN', 'SMITH', '30005', 'AQUA', 100, 20210103, 0, 0, 'REF1'}
   ,{2000, '19841006', 'GREG', 'GREGORSON', '22134', 'AQUA', 103, 20210101, 0, 0, 'REF3'}
   ,{2000, '19841006', 'GREG', 'GREGORSON', '22134', 'AQUA', 103, 20210101, 0, 0, 'REF3'}
   ,{1500, '', 'PETER', 'SMITH', '', '', 0, 0, 0, 0, 'REF2'}
   ,{1500, '', 'PETER', 'SMITH', '', '', 0, 0, 0, 0, 'REF2'}
   ,{3000, '', 'ALEX', 'ALEXBURG', '', '', 0, 0, 0, 0, 'REF4'}
   ,{3000, '', 'ALEX', 'ALEXBURG', '', '', 0, 0, 0, 0, 'REF4'}
   ,{4000, '', 'DALE', 'DELETEME', '', '', 0, 0, 0, 0, 'REF5'}
   ,{4000, '', 'DALE', 'DELETEME', '', '', 0, 0, 0, 0, 'REF5'}
], out_rec);

runT('000', inrecs_000, key_recs_000, delta_recs_000, LEFT.did = RIGHT.did, expected_000);
runT('001', inrecs_001, key_recs_001, delta_recs_001, LEFT.did = RIGHT.did, expected_001);
runT('002', inrecs_002, key_recs_002, delta_recs_002, LEFT.did = RIGHT.did, expected_002);
runT('003', inrecs_003, key_recs_003, delta_recs_003, LEFT.did = RIGHT.did, expected_003);
runT('004', inrecs_004, key_recs_004, delta_recs_004, LEFT.did = RIGHT.did, expected_004);
runT('005', inrecs_005, key_recs_005, delta_recs_005, LEFT.fname = RIGHT.fname AND LEFT.lname = RIGHT.lname, expected_005);
runT('006', inrecs_006, key_recs_006, delta_recs_006, LEFT.fname = RIGHT.fname AND LEFT.lname = RIGHT.lname, expected_006);
runT('010', inrecs_010, key_recs_010, delta_recs_010, LEFT.did = RIGHT.did, expected_010);
runT('011', inrecs_011, key_recs_011, delta_recs_011, LEFT.did = RIGHT.did, expected_011);
runT('012', inrecs_012, key_recs_012, delta_recs_012, LEFT.did = RIGHT.did, expected_012);
runT('013', inrecs_013, key_recs_013, delta_recs_013, LEFT.fname = RIGHT.fname AND LEFT.lname = RIGHT.lname, expected_013);
runT('020', inrecs_020, key_recs_020, delta_recs_020, LEFT.did = RIGHT.did, expected_020);
runT('021', inrecs_021, key_recs_021, delta_recs_021, LEFT.did = RIGHT.did, expected_021);
runT('030', inrecs_030, key_recs_030, delta_recs_030, LEFT.did = RIGHT.did, expected_030);
runT('031', inrecs_031, key_recs_031, delta_recs_031, LEFT.did = RIGHT.did, expected_031);
runT('050', inrecs_050, key_recs_050, delta_recs_050, LEFT.did = RIGHT.did, expected_050, LEFTOUTER := TRUE); 
runT('051', inrecs_051, key_recs_051, delta_recs_051, LEFT.did = RIGHT.did, expected_051, LEFTOUTER := TRUE); 
runT('052', inrecs_052, key_recs_052, delta_recs_052, LEFT.did = RIGHT.did, expected_052, LEFTOUTER := TRUE); 
runT('053', inrecs_053, key_recs_053, delta_recs_053, LEFT.did = RIGHT.did, expected_053, LEFTOUTER := TRUE); 
runT('054', inrecs_054, key_recs_054, delta_recs_054, LEFT.did = RIGHT.did, expected_054, LEFTOUTER := TRUE); 
runT('055', inrecs_055, key_recs_055, delta_recs_055, LEFT.did = RIGHT.did, expected_055, LEFTOUTER := TRUE); 
runT('056', inrecs_056, key_recs_056, delta_recs_056, LEFT.did = RIGHT.did, expected_056, LEFTOUTER := TRUE); 
runT('057', inrecs_057, key_recs_057, delta_recs_057, LEFT.did = RIGHT.did, expected_057, LEFTOUTER := TRUE); 
runT('058', inrecs_058, key_recs_058, delta_recs_058, LEFT.did = RIGHT.did, expected_058, LEFTOUTER := TRUE); 
runT('059', inrecs_059, key_recs_059, delta_recs_059, LEFT.did = RIGHT.did, expected_059, LEFTOUTER := TRUE); 
runT('060', inrecs_060, key_recs_060, delta_recs_060, LEFT.fname = RIGHT.fname AND LEFT.lname = RIGHT.lname, expected_060, LEFTOUTER := TRUE); 
runT('061', inrecs_061, key_recs_061, delta_recs_061, LEFT.did = RIGHT.did AND RIGHT.fav_color = 'YELLOW', expected_061, LEFTOUTER := TRUE);
runT('062', inrecs_062, key_recs_062, delta_recs_062, LEFT.did = RIGHT.did AND RIGHT.fav_color = 'GREEN', expected_062, LEFTOUTER := TRUE);
runT('063', inrecs_063, key_recs_063, delta_recs_063, LEFT.did = RIGHT.did AND RIGHT.fav_color = 'RED', expected_063, LEFTOUTER := TRUE);
runT('064', inrecs_064, key_recs_064, delta_recs_064, LEFT.did = RIGHT.did AND RIGHT.fav_color = 'RED' AND (UNSIGNED)RIGHT.dob > 19810101, expected_064, LEFTOUTER := TRUE);
runT('065', inrecs_065, key_recs_065, delta_recs_065, LEFT.did = RIGHT.did AND RIGHT.fav_color = 'RED' AND (UNSIGNED)RIGHT.dob < 19810101, expected_065, LEFTOUTER := TRUE);
runT('066', inrecs_066, key_recs_066, delta_recs_066, LEFT.did = RIGHT.did AND RIGHT.fav_color = 'YELLOW' AND (UNSIGNED)RIGHT.dob < 19810101, expected_066, LEFTOUTER := TRUE);
runT('067', inrecs_067, key_recs_067, delta_recs_067, LEFT.did = RIGHT.did AND RIGHT.fav_color = 'AQUA', expected_067);
runT('068', inrecs_068, key_recs_068, delta_recs_068, LEFT.did = RIGHT.did AND RIGHT.fav_color = 'AQUA', expected_068, LEFTOUTER := TRUE);


