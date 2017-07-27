import ut;

export company_name_match_score(string l, string r) :=
	if(r = '' or l = '',
		 255,
		 100 - ut.CompanySimilar100(l, r));