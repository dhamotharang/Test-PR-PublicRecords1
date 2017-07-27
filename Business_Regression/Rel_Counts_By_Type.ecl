import business_header,did_regression;

old_in := rel_sample_old;
new_in := rel_sample_new;

//translate the boolean fields
strec := record
	unsigned6 bdid1;
	unsigned6 bdid2;
	string30 reltype;
end;

strec translate(business_header.Layout_Business_Relative l) := transform
	self.reltype := map(
		l.corp_charter_number => 'corp_charter_number',
		l.business_registration => 'business_registration',
		l.bankruptcy_filing => 'bankruptcy_filing',
		l.duns_number => 'duns_number',
		l.duns_tree => 'duns_tree',
		l.edgar_cik => 'edgar_cik',
		l.name => 'name',
		l.name_address => 'name_address',
		l.name_phone => 'name_phone',
		l.gong_group => 'gong_group',
		l.ucc_filing => 'ucc_filing',
		l.fbn_filing => 'fbn_filing',
		l.fein => 'fein',
		l.phone => 'phone',
		l.addr => 'addr',
		l.mail_addr => 'mail_addr',
		l.rel_group => 'rel_group',
		'error: missing type');
	self := l;
end;

old := project(old_in, translate(left));
new := project(new_in, translate(left));


//count by score in each file
old_score_rec := record
	old.reltype;
	integer old_count := count(group);
end;

old_scores := table(old, old_score_rec, reltype);


new_score_rec := record
	new.reltype;
	integer new_count := count(group);
end;

new_scores := table(new, new_score_rec, reltype);

both_score_rec := record
	string30 reltype;
	integer old_count;
	integer new_count;
	integer difference;
	string10 percentage_diff;
end;

both_score_rec combine_scores(old_scores l, new_scores r) := transform
	self.reltype := l.reltype;//if(l.number_cohabits = 0, r.number_cohabits, l.number_cohabits);
	self.old_count := l.old_count;
	self.new_count := r.new_count;
	self.difference := r.new_count - l.old_count;
	self.percentage_diff := did_regression.percentage_diff(l.old_count, r.new_count);
end;

export Rel_Counts_By_Type := join(old_scores, new_scores,
					left.reltype = right.reltype,
					combine_scores(left, right),
					full outer, hash) : persist('BR_Rel_Counts_By_Type');