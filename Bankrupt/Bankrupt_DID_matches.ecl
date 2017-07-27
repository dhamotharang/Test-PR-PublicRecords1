import watchdog,ut,header;

b := Bankrupt.File_BK_Search((integer)debtor_did>0);

slim_bank := record
	unsigned6 did := b.debtor_did;
	b.court_code;
	b.case_number;
	string20 fname := b.debtor_fname;
	string20 lname := b.debtor_lname;
	string9 best_ssn := '';
	string4 birth_year := '';
end;

slim_b := DISTRIBUTE(TABLE(b, slim_bank), HASH(did));
best_file := DISTRIBUTE(watchdog.File_Best, HASH(did));

slim_bank addBest(slim_bank L, watchdog.Layout_Best R) := 
TRANSFORM
	SELF.best_ssn := r.ssn;
	SELF.birth_year := (string)(r.dob div 10000);
	SELF := L;
END;
with_best := join(slim_b, best_file, LEFT.did = RIGHT.did, addBest(LEFT, RIGHT), LOCAL);

did_out := header.Layout_PairMatch;

did_out matchingDIDs(slim_bank L, slim_bank R) := 
transform
 self.new_rid := if(L.did > R.did, R.did, L.did);
 self.old_rid := if(L.did > R.did, L.did, R.did);
 self.pflag := 15;
end;

bank_dist := distribute(with_best,hash(court_code, case_number));

j := join(bank_dist, bank_dist, LEFT.court_code = RIGHT.court_code AND 
								LEFT.case_number = RIGHT.case_number AND 
								LEFT.fname = RIGHT.fname AND LEFT.lname = RIGHT.lname AND 
								LEFT.did != RIGHT.did AND 
								ut.nneq_ssn(LEFT.best_ssn, RIGHT.best_ssn) AND
								ut.NNEQ_Int(left.birth_year,right.birth_year), 
			matchingDIDs(LEFT, RIGHT), LOCAL);

dup := dedup(j, new_rid, old_rid, all);

export Bankrupt_DID_matches := dup : persist('persist::bankrupt_did_matches');