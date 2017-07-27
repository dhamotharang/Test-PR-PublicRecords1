import did_regression;

old := old_recs;
new := new_recs;

//count by score in each file
old_score_rec := record
	old.number_cohabits;
	integer old_count := count(group);
end;

old_scores := table(old, old_score_rec, number_cohabits);


new_score_rec := record
	new.number_cohabits;
	integer new_count := count(group);
end;

new_scores := table(new, new_score_rec, number_cohabits);

both_score_rec := record
	integer number_cohabits;
	integer old_count;
	integer new_count;
	integer difference;
	string10 percentage_diff;
end;

both_score_rec combine_scores(old_scores l, new_scores r) := transform
	self.number_cohabits := if(l.number_cohabits = 0, r.number_cohabits, l.number_cohabits);
	self.old_count := l.old_count;
	self.new_count := r.new_count;
	self.difference := r.new_count - l.old_count;
	self.percentage_diff := did_regression.percentage_diff(l.old_count, r.new_count);
end;

export counts_by_score := join(old_scores, new_scores,
					left.number_cohabits = right.number_cohabits,
					combine_scores(left, right),
					full outer, hash) : persist('counts_by_score');