//replicates person_models.FN_Person_Names to be used for data layer
import dx_Header, ut, STD;

export FN_Person_Names(dataset(dx_header.Layout_Header) d_) := function

todays_date := ((string)STD.Date.Today())[1..6];

d_slim_l := record
d_.did;
d_.lname;
d_.fname;
d_.dt_first_seen;
d_.dt_last_seen;
end;

d := project(d_, d_slim_l);

//***** GET THE NAME STATS
  r := record
		d.did;
		d.lname;
		unsigned1 parent_lname_count := 0;
		boolean early_lname :=  false;
		unsigned4 first_seen := min(group,if(d.dt_first_seen=0,999999,d.dt_first_seen));
		// unsigned4 v_first_seen := min(group,if(d.dt_vendor_first_reported=0,999999,d.dt_vendor_first_reported));
		unsigned4 last_seen :=  max(group,d.dt_last_seen);
		// unsigned4 v_last_seen :=  max(group,d.dt_vendor_last_reported);
		// today := ;
		real8 av_fs := ave(group,if(d.dt_first_seen=0,(unsigned3)todays_date,d.dt_first_seen));
		real8 av_ls := ave(group,if(d.dt_last_seen=0, (unsigned3)todays_date,d.dt_last_seen));
  end;

	
t := table(distribute(d, hash(did))(lname <> ''),r,did,lname, local);	

//***** COUNT NAMES PER DID
recdidcount := {t.did, unsigned1 cnt := count(group)};
recout := {t, unsigned1 cnt};

didcount := table(t, recdidcount, did, local);

tc := 		 join(distribute(t, hash(did)), 
					 distribute(didcount, hash(did)), 
					 left.did = right.did, 
					 transform(recout,
									   self.cnt := right.cnt,
										 self := left),
						local);


//***** CHECK FOR PARENT NAMES
kpl := pull(dx_Header.key_ParentLnames());
recout addpn(tc l, kpl r) := transform
	self.parent_lname_count := r.cnt;
	self := l;
end;

tc2 := 			join(distribute(tc, hash(did)), 
					  distribute(kpl, hash(did)), 
						left.did = right.did and
						left.lname = right.lname,
						addpn(left, right),
						left outer,
						limit(ut.limits.default, skip),
						local);


//***** PICK AN EARLY LNAME
recout tra(recout l, recout r) := transform
	self.early_lname := l.lname = '' ;//or l.first_seen = r.first_seen and l.last_seen = r.last_seen;
	self := r;
end;

p := iterate(sort(group(tc2,did), first_seen, -parent_lname_count, last_seen, av_fs, av_ls), tra(left, right));

// output(d, named('d'));
// output(t, named('t'));
// output(tc, named('tc'));
// output(tc2, named('tc2'));
// output(p, named('p'));

return p;
end;
