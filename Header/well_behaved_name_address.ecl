import ut;

export well_behaved_name_address
 (dataset(header.Layout_MatchCandidates) mr,
  boolean new_version = false) :=
FUNCTION

// Blank old, bad SSN's
// Find all SSN/Name/DID Combinations
hd := DISTRIBUTE(mr,HASH(did)); 

mac_ssn_overlap(hd,wbna_j3);

//hd blank_ssn(hd le, wbna_j3 ri) :=
hd blank_ssn(mr le, wbna_j3 ri) := //Already distributed
TRANSFORM
	SELF.ssn := IF(ri.ssn<>'','',le.ssn);
	SELF := le;
END;

h := JOIN(hd,
					DEDUP(SORT(DISTRIBUTE(wbna_j3,HASH(did)),did,ssn,local),did,ssn,local),
					LEFT.did=RIGHT.did AND LEFT.ssn=RIGHT.ssn, blank_ssn(LEFT,RIGHT), LEFT OUTER, LOCAL);


// do well_behaved
r := record
  qstring20 fname := datalib.PreferredFirstNew(h.fname,new_version);
  qstring20 lname := h.lname;
  h.zip;
  h.dob;
  h.ssn;
  h.prim_range;
  h.prim_name;
  h.did;
  end;

//t := distribute(table(h(dob<>0 or ssn<>'',prim_name<>'',fname<>''),r),hash(fname,lname,zip,prim_range,prim_name));
t0 := distribute(table(h(prim_name not in ['','NONE'],fname<>'', did<>0),r),hash(lname,zip,prim_range,prim_name));

//generate a first initial record when needed
t := t0 +
			project(t0,
					transform(r, self.fname := metaphonelib.DMetaPhone1(left.fname)[1],
										   self := left));

r_1 := record
  t.fname;
  t.lname;
  t.zip;
  t.prim_range;
  t.prim_name;
  dob_max := max(group,t.dob div 100);
  dob_min := min(group,if ( t.dob=0,99999999,t.dob div 100));
  ssn_max := max(group,t.ssn);
  ssn_min := min(group,if ( t.ssn='','999999999',t.ssn));
  dob_did_max := max(group, IF(t.dob=0,0,t.did));
  dob_did_min := min(group, IF(t.dob=0,999999999999,t.did));
	ssn_did_max := max(group, IF(t.ssn='',0,t.did));
  ssn_did_min := min(group, IF(t.ssn='',999999999999,t.did));
  end;

tt := table(t,r_1,fname,lname,zip,prim_range,prim_name,local);


return tt(ut.isWellBehaved(dob_max,    dob_min, 
                                     ssn_max,    ssn_min,
						             dob_did_max,dob_did_min,
						             ssn_did_max,ssn_did_min
						            )
		           );
										 											 
END;