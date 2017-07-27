// calculates and adds best_phone number using Gong daily data (updated by did and hhid);
// output records' number is as least as in the input;

import didville, gong;

export Gong_Append(GROUPED DATASET(didville.Layout_Did_OutBatch) infile, boolean ismarketing=false) :=
FUNCTION

lx := RECORD
	infile;
	unsigned3 dl := 0;
END;

// JOIN against DID
lx take_did(didville.Layout_Did_OutBatch le, gong.key_did ri) := TRANSFORM
	SELF.best_phone := IF((unsigned)ri.phone10=0,'',ri.phone10);
	SELF.dl := (unsigned3)(ri.filedate[1..6]);
	SELF := le;
END;
j_did := JOIN (infile, gong.key_did, 
               LEFT.did<>0 AND keyed(LEFT.did=RIGHT.l_did) AND
               (~ismarketing OR RIGHT.cr_sort_sz<>'Y'),
               take_did (Left, Right), LEFT OUTER, ATMOST(20));

//this is done for the case when several did-records belong to one sequence
done_by_did := DEDUP(SORT(j_did, did, -dl, -LENGTH(TRIM(best_phone)), best_phone), did);

// JOIN against HHID
lx take_hhid(lx le, gong.Key_HHID ri) :=
TRANSFORM
	SELF.best_phone := IF((unsigned)ri.phone10=0,le.best_phone,ri.phone10);
	SELF.dl := IF((unsigned)ri.phone10=0,le.dl,(unsigned3)(ri.filedate[1..6]));
	SELF := le;
END;
j_hhid := JOIN (done_by_did, gong.Key_HHID, 
								LEFT.best_phone='' AND
								LEFT.hhid<>0 AND keyed(LEFT.hhid=RIGHT.s_hhid) AND
               (~ismarketing OR RIGHT.cr_sort_sz<>'Y'),
								take_hhid(LEFT,RIGHT), LEFT OUTER, ATMOST(20));

//this is done for the case when several did-hhid-records belong to one sequence
j_unique := DEDUP(SORT(j_hhid, did, hhid, -dl, -LENGTH(TRIM(best_phone)), best_phone), did, hhid);
RETURN PROJECT (j_unique, TRANSFORM(didville.Layout_Did_OutBatch, SELF := LEFT));

END;