// calculates and adds best_phone number using Gong daily data (updated by did and hhid);
// output records' number is as least as in the input;

import didville, Doxie, dx_Gong, Suppress;

export Gong_Append(GROUPED DATASET(didville.Layout_Did_OutBatch) infile,
  Doxie.IDataAccess mod_access,
  boolean ismarketing=false) :=
FUNCTION

lx := RECORD
  infile;
  unsigned3 dl := 0;
  UNSIGNED4 global_sid := 0;
  UNSIGNED8 record_sid := 0;
  UNSIGNED6 key_did := 0;
  STRING10 hhid_phone := '';
  STRING11 hhid_filedate := '';
END;

// JOIN against DID
key_did := dx_Gong.key_did();
lx take_did(didville.Layout_Did_OutBatch le, key_did ri) := TRANSFORM
  SELF.best_phone := IF((unsigned)ri.phone10=0,'',ri.phone10);
  SELF.dl := (unsigned3)(ri.filedate[1..6]);
  SELF.global_sid := ri.global_sid;
  SELF.record_sid := ri.record_sid;
  SELF.key_did := ri.l_did;
  SELF := le;
END;

_j_did := JOIN (infile, key_did,
               LEFT.did<>0 AND keyed(LEFT.did=RIGHT.l_did) AND
               (~ismarketing OR RIGHT.cr_sort_sz<>'Y'),
               take_did (Left, Right), LEFT OUTER, ATMOST(20));

j_did_suppressed := Suppress.MAC_FlagSuppressedSource(_j_did, mod_access, key_did);

j_did := PROJECT(j_did_suppressed, TRANSFORM(lx,
  SELF.best_phone := IF(LEFT.is_suppressed, '', LEFT.best_phone);
  SELF.dl := IF(LEFT.is_suppressed, 0, LEFT.dl);
  SELF.global_sid := IF(LEFT.is_suppressed, 0, LEFT.global_sid);
  SELF.record_sid := IF(LEFT.is_suppressed, 0, LEFT.record_sid);
  SELF.key_did := IF(LEFT.is_suppressed, 0, LEFT.key_did);
  SELF := LEFT
));

//this is done for the case when several did-records belong to one sequence
done_by_did := DEDUP(SORT(j_did, did, -dl, -LENGTH(TRIM(best_phone)), best_phone), did);

// JOIN against HHID
key_HHID := dx_Gong.key_hhid();
lx take_hhid(lx le, key_HHID ri) :=
TRANSFORM
  SELF.hhid_phone := ri.phone10;
  SELF.hhid_filedate := ri.filedate;
  SELF.global_sid := ri.global_sid;
  SELF.record_sid := ri.record_sid;
  SELF.key_did := ri.did;
  SELF := le;
END;
j_hhid_all := JOIN (done_by_did, key_HHID,
  LEFT.best_phone='' AND
  LEFT.hhid<>0 AND keyed(LEFT.hhid=RIGHT.s_hhid) AND
  (~ismarketing OR RIGHT.cr_sort_sz<>'Y'),
  take_hhid(LEFT,RIGHT), LEFT OUTER, ATMOST(20));

j_hhid_sup := suppress.MAC_FlagSuppressedSource(j_hhid_all,mod_access,key_did);
j_hhid := PROJECT(j_hhid_sup, TRANSFORM(lx,
  SELF.best_phone := IF(LEFT.is_suppressed OR (unsigned) LEFT.hhid_phone=0, LEFT.best_phone, LEFT.hhid_phone);
  SELF.dl := IF(LEFT.is_suppressed OR (unsigned) LEFT.hhid_phone=0, LEFT.dl, (unsigned3)(LEFT.hhid_filedate[1..6]));
  SELF := LEFT;
  ));

//this is done for the case when several did-hhid-records belong to one sequence
j_unique := DEDUP(SORT(j_hhid, did, hhid, -dl, -LENGTH(TRIM(best_phone)), best_phone), did, hhid);
RETURN PROJECT (j_unique, TRANSFORM(didville.Layout_Did_OutBatch, SELF := LEFT));

END;