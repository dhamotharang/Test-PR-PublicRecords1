import header, ut, Watchdog;

Slim_DL := 
RECORD
	File_DL.did;
	File_DL.orig_state;
	File_DL.dl_number;
	File_DL.fname;
	File_DL.mname;
	File_DL.lname;
	File_DL.name_suffix;
	QSTRING9 ssn := '';
	QSTRING4 dob := '';
END;
t := TABLE(File_DL(did > 0, LENGTH(TRIM(dl_number)) != 0), Slim_DL);

ut.MAC_Remove_Withdups(t,dl_number,20,nodup)

DLDist := DISTRIBUTE(nodup, HASH(did));
BestDist := Watchdog.File_Best;

Slim_DL addDOBSSN (Slim_DL L, Watchdog.Layout_Best R) :=
TRANSFORM
	SELF.ssn := R.ssn;
	SELF.dob := IF(R.dob = 0, '', (QSTRING4)(R.dob DIV 10000));
	SELF := L;
END;

BestDL := JOIN(DLDist, BestDist, LEFT.did = RIGHT.did, addDOBSSN(LEFT, RIGHT), LEFT OUTER, LOCAL);


PairMatchTest :=
RECORD
	Header.Layout_PairMatch;
END;

// Find possible DID matches
PairMatchTest matchDIDs (Slim_DL L, Slim_DL R) :=
TRANSFORM
	SELF.old_rid := if(l.did < r.did, r.did, l.did);
	SELF.new_rid := if(l.did > r.did, r.did, l.did);
	SELF.pflag := 12;
end;

dist := DISTRIBUTE(BestDL, HASH(orig_state, dl_number));

j := JOIN(dist, dist, LEFT.orig_state = RIGHT.orig_state AND LEFT.dl_number = RIGHT.dl_number AND
					  LEFT.fname = RIGHT.fname AND LEFT.mname = RIGHT.mname AND LEFT.lname = RIGHT.lname AND
					  ut.NNEQ_Suffix(LEFT.name_suffix, RIGHT.name_suffix) AND 
					  ut.NNEQ_Int(LEFT.dob, RIGHT.dob) AND ut.NNEQ_SSN(LEFT.ssn, RIGHT.ssn) AND
					  LEFT.did != RIGHT.did,
		  matchDIDs(LEFT, RIGHT), LOCAL);

ddp := dedup(j, old_rid, new_rid, all);

export DL_DID_matches := ddp : PERSIST('persist::DL_DID_matches');