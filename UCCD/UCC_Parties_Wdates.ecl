import ucc;
cn := ucc.UCC_Parties_Clean_Name;
dt := uccd.DatesByKey;

rec := record
	cn;
	string8 dt_first_seen;
	string8 dt_last_seen;
end;

rec tra(cn l, dt r) := transform
			dfs := map((unsigned)r.dt_first_seen > 0 => r.dt_first_seen,
					l.ucc_process_date > l.insert_date => l.ucc_process_date,
					l.insert_date);
			dls := map((unsigned)r.dt_last_seen > 0 => r.dt_last_seen,
					l.ucc_process_date < l.insert_date and l.ucc_process_date <> '' => l.ucc_process_date,
					l.insert_date);

	self.dt_first_seen := dfs;
	self.dt_last_seen := dls;
	self := l;
end;

jnd := join(cn, dt, left.ucc_key = right.ucc_key, tra(left, right), left outer, hash);

export UCC_Parties_Wdates := jnd;