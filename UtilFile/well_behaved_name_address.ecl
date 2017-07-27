import header, ut;
h := header.propagated_header_matchrecs;

// slimrec
r := record
  qstring20 fname := datalib.PreferredFirstNew(h.fname, true);
  qstring20 lname := h.lname;
  h.zip;
  h.dob;
  h.ssn;
  h.prim_range;
  h.prim_name;
  h.did;
  end;

t := distribute(table(h(dob<>0 or ssn<>'',prim_name<>'',fname<>'', did<>0),r),hash(fname,lname,zip,prim_range,prim_name));

// stats on min/max dob and ssn per name/address
r1 := record
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

tt := table(t,r1,fname,lname,zip,prim_range,prim_name,local);

// save records without a lot of variation on ssn or dob
export well_behaved_name_address := tt(ut.isWellBehaved(dob_max, dob_min, 
                                                        ssn_max, ssn_min,
											 dob_did_max, dob_did_min,
											 ssn_did_max, ssn_did_min)) : persist('util_good_name_address');