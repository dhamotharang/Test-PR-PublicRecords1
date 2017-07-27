old := bc_sample_old;
new := bc_sample_new;

old_count_by_did_rec := record
	old.bdid;
	integer old_count := count(group);
end;

old_count_by_did := table(old, old_count_by_did_rec, bdid);

new_count_by_did_rec := record
	new.bdid;
	integer new_count := count(group);
end;

new_count_by_did := table(new, new_count_by_did_rec, bdid);

both_count_by_did_rec := record
	integer bdid;
	integer old_count;
	integer new_count;
	integer difference;
	string5 shift;
end;

both_count_by_did_rec combine_counts(old_count_by_did l, new_count_by_did r) := transform
	self.bdid := if(l.bdid = 0, r.bdid, l.bdid);
	self.old_count := l.old_count;
	self.new_count := r.new_count;
	self.difference := r.new_count - l.old_count;
	self.shift := map(l.bdid = 0 => 'NEW',
					  r.bdid = 0 => 'GONE',
					  self.difference > 0 => 'UP',
					  self.difference < 0 => 'DOWN', 'NONE');
end;

export BC_Counts_By_BDID := join(old_count_by_did, new_count_by_did,
						  left.bdid = right.bdid,
						  combine_counts(left, right),
						  full outer, hash) : persist('bc_counts_by_did');