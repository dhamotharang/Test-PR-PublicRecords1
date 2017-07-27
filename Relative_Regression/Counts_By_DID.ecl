old := old_recs(number_cohabits >= 6);
new := new_recs(number_cohabits >= 6);

old_count_by_did_rec := record
	old.person1;
	integer old_count := count(group);
end;

old_count_by_did := table(old, old_count_by_did_rec, person1);

new_count_by_did_rec := record
	new.person1;
	integer new_count := count(group);
end;

new_count_by_did := table(new, new_count_by_did_rec, person1);

both_count_by_did_rec := record
	integer did;
	integer old_count;
	integer new_count;
	integer difference;
	string5 shift;
end;

both_count_by_did_rec combine_counts(old_count_by_did l, new_count_by_did r) := transform
	self.did := if(l.person1 = 0, r.person1, l.person1);
	self.old_count := l.old_count;
	self.new_count := r.new_count;
	self.difference := r.new_count - l.old_count;
	self.shift := map(l.person1 = 0 => 'NEW',
					  r.person1 = 0 => 'GONE',
					  self.difference > 0 => 'UP',
					  self.difference < 0 => 'DOWN', 'NONE');
end;

export counts_by_did := join(old_count_by_did, new_count_by_did,
						  left.person1 = right.person1,
						  combine_counts(left, right),
						  full outer, hash) : persist('rr_counts_by_did');