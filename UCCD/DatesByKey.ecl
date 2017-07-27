import ut;
e := uccd.File_WithExpEvent(ucc_key <> '');

//get my fields
rec := record
string50  ucc_key;
string8	  dt_first_seen;
string8		dt_last_seen;
end;

rec tra(e l) := transform
	self.ucc_key := l.ucc_key;
	self.dt_first_seen := if((integer)l.orig_filing_date > 0 and l.orig_filing_date < l.filing_date, l.orig_filing_date, l.filing_date);
	self.dt_last_seen := if(l.orig_filing_date > l.filing_date, l.orig_filing_date, l.filing_date);
end;

p := project(e, tra(left)); 

//roll up the dates
rec rollem(rec l, rec r) := transform
	self.ucc_key := if(l.ucc_key <> '', l.ucc_key, r.ucc_key);
	self.dt_first_seen := if((integer)l.dt_first_seen > 0 and l.dt_first_seen < r.dt_first_seen, l.dt_first_seen, r.dt_first_seen);//ut.mac_roll_DFS(dt_first_seen)
	self.dt_last_seen := if((integer)l.dt_last_seen > 0 and l.dt_last_seen < r.dt_last_seen, l.dt_last_seen, r.dt_last_seen);//ut.mac_roll_DLS(dt_last_seen)
end;

rld := rollup(p, left.ucc_key = right.ucc_key, rollem(left, right));

export DatesByKey := rld;