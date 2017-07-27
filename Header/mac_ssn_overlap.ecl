import ut;

/*Note that this code is taken from what used to be in
  well_behaved_name_address.  However, because it could
  also be used for a DodgyDids improvement, this macro 
  was created.
*/

export mac_ssn_overlap(infile, outfile) := 
macro

#uniquename(ssn_overlap_rec)

ssn_overlap_rec :=
RECORD
	infile.did;
	infile.ssn;
	infile.fname;
	dt_last_seen := MAX(GROUP,infile.dt_last_seen);
	valid_ssn := MAX(GROUP,IF(infile.valid_ssn='G',1,0));
END;
t1 := TABLE(infile(ssn<>'',fname<>''),ssn_overlap_rec,did,ssn,fname,LOCAL);// CHECK islocal?

// Find all SSN/DID Combinations
r2 :=
RECORD
	t1.did;
	t1.ssn;
	dt_last_seen := MAX(GROUP,t1.dt_last_seen);
END;
t2 := TABLE(t1,r2,did,ssn,LOCAL);// is local?

// all did/ssn combinations that have an old ssn
t2_old := t2(ut.GetAge((STRING)dt_last_seen)>5);


// get the names for all did/ssn combinations that have an old ssn
j := JOIN(t2_old, t1, LEFT.did=RIGHT.did AND LEFT.ssn=RIGHT.ssn, LOCAL); //is local?

// For each first name, make sure there's a different DID with a matching ssn that does not have the same first name
// Where the SSN is 'G'
candidates := DISTRIBUTE(j,HASH(ssn));
cmp := DISTRIBUTE(t1(valid_ssn=1), HASH(ssn));
// This is set of did/ssn pairs where there is definitely another did with that ssn
j2 := JOIN(candidates,cmp,LEFT.ssn=RIGHT.ssn AND LEFT.did<>RIGHT.did, KEEP(1), LOCAL);
// This is the set of did/ssn to blank out ssn
j3 := JOIN(j2,cmp,LEFT.ssn=RIGHT.ssn AND LEFT.did<>RIGHT.did AND LEFT.fname=RIGHT.fname, LEFT ONLY, LOCAL);// : persist('wbna_j3');

outfile := j3;

endmacro;