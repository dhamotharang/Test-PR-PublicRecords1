import business_header,did_regression;

old := relgroup_sample_old;
new := relgroup_sample_new;


//count by score in each file
old_score_rec := record
	old.group_type;
	integer old_count := count(group);
end;

old_scores := table(old, old_score_rec, group_type);


new_score_rec := record
	new.group_type;
	integer new_count := count(group);
end;

new_scores := table(new, new_score_rec, group_type);

both_score_rec := record
	string2 group_type;
	integer old_count;
	integer new_count;
	integer difference;
	string10 percentage_diff;
end;

both_score_rec combine_scores(old_scores l, new_scores r) := transform
	self.group_type := l.group_type;//if(l.number_cohabits = 0, r.number_cohabits, l.number_cohabits);
	self.old_count := l.old_count;
	self.new_count := r.new_count;
	self.difference := r.new_count - l.old_count;
	self.percentage_diff := did_regression.percentage_diff(l.old_count, r.new_count);
end;

export Relgroup_Counts_By_Type := join(old_scores, new_scores,
					left.group_type = right.group_type,
					combine_scores(left, right),
					full outer, hash) : persist('BR_RelGroup_Counts_By_Type');