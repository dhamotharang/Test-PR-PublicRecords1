import Address,Patriot,ut,Risk_Indicators;

export getWatchLists(grouped DATASET(Layout_Output) inl) :=
FUNCTION

pat := patriot.key_patriot_file;
pat_bdid := patriot.key_bdid_patriot_file;
pat_phon := patriot.Key_Phonetic_Name;


Layout_Output append_PatbyBDID(Layout_Output l, pat_bdid r) :=
TRANSFORM
	SELF.watchlist_table := r.source;
	SELF.watchlist_record_number := r.pty_key;
	self.watchlist_fname := r.fname;
	self.watchlist_lname := r.lname;
	SELF.watchlist_cmpy := r.cname;
	SELF.watchlist_address := Risk_Indicators.MOD_AddressClean.street_address('',r.prim_range, r.predir, r.prim_name,
									r.suffix, r.postdir, r.unit_desig, r.sec_range);
	SELF.watchlist_city := r.p_city_name;
	SELF.watchlist_state := r.st;
	SELF.watchlist_zip := r.zip;
	SELF.watchlist_country := r.country; 
	INTEGER watchlist_num_with_name := 0; // TODO: not implemented
	SELF := l;
END;

pj1 := JOIN(inl(bdid != 0), pat_bdid, keyed(LEFT.bdid=RIGHT.bdid) and right.source IN patriot.OFAC_SourceSet, append_PatbyBDID(LEFT,RIGHT), LEFT OUTER, KEEP(1));

//----------------[ by name ]-----------------------

slimrec := record
	inl.seq;
	inl.company_name;
	inl.alt_company_name;
	string120 norm_cname := '';
	string50	phon := '';
	pat.pty_key;
	pat.source;
end;

string os(string s) := if (s = '', '', trim(s) + ' ');

slimrec into_slim(inl L, integer C) := transform
	self.norm_cname := if (C = 1, L.company_name, if (L.alt_company_name = '', skip, L.alt_company_name));
	self.phon := '';
	self.pty_key := '';
	self.source := '';
	self := L;
end;

inl_slim := normalize(inl,2,into_slim(LEFT, COUNTER));

Token   name := Pattern ('[a-zA-Z]+');
Rule   is_a_name := name;
emptywords := ['THE','AN','TO','OF','FOR','A','AND'];

slimrec into_parse(inl_slim L) := transform
	self.phon := if (stringlib.stringtouppercase(matchtext(is_a_name)) not in emptywords, metaphonelib.dmetaphone1(matchtext(is_a_name)), '');
	self := L;
end;

inl_phon := global(parse(inl_slim, norm_cname, is_a_name, into_parse(LEFT), maxlength(50)));

slimrec check_names(inl_phon L, pat_phon R) := transform
	lencmpy := length(trim(l.norm_cname));
	self.pty_key := if (ut.CompanySimilar100(l.norm_cname, r.cname[1..lencmpy]) <= 20, R.pty_key, skip);
	self.source := R.source;
	self := L;
end;

match_by_name := join (Inl_phon(phon != ''), pat_phon,  
					keyed(left.phon = right.pnamecomponent) and
					keyed(right.source = 'Office of Foreign Asset Control'),
				   check_names(LEFT,RIGHT));


mbn := dedup(sort(match_by_name, seq), seq);

patrec := record
	pat;
	unsigned4	seq;
end;

patrec get_pat_Recs(match_by_name L, pat R) := transform
	self.seq := L.seq;
	self := R;
end;

patrecs := join(mbn, pat,
			left.pty_key != '' and
			keyed(left.pty_key = right.pty_key) and
			keyed(right.source = 'Office of Foreign Asset Control'),
		  get_pat_recs(LEFT,RIGHT), keep(1));
		  
Layout_Output append_PatbyName(Layout_Output l, patrecs r) :=
TRANSFORM
	SELF.watchlist_table := r.source;
	SELF.watchlist_record_number := r.pty_key;
	self.watchlist_fname := r.fname;
	self.watchlist_lname := r.lname;
     SELF.watchlist_cmpy := r.cname;
	SELF.watchlist_address := Risk_Indicators.MOD_AddressClean.street_address('',r.prim_range, r.predir, r.prim_name,
									r.suffix, r.postdir, r.unit_desig, r.sec_range);
	SELF.watchlist_city := r.p_city_name;
	SELF.watchlist_state := r.st;
	SELF.watchlist_zip := r.zip;
	SELF.watchlist_country := r.country; 
	INTEGER watchlist_num_with_name := 0; // TODO: not implemented
	SELF := l;
END;

pj2 := join(inl, patrecs,
			left.seq = right.seq,
		  append_patbyname(LEFT,RIGHT), left outer, many lookup);


layout_output rejoin(pj2 L, pj1 R) := transform
	SELF.watchlist_table := if (R.watchlist_table != '', R.watchlist_table, L.watchlist_table);
	SELF.watchlist_record_number := if (R.watchlist_record_number != '', R.watchlist_record_number, L.watchlist_record_number);
	SELF.watchlist_fname := if (R.watchlist_fname != '', R.watchlist_fname, L.watchlist_fname);
	SELF.watchlist_lname := if (R.watchlist_lname != '', R.watchlist_lname,L.watchlist_lname);
	self.watchlist_cmpy := if (R.watchlist_cmpy != '', R.watchlist_cmpy, L.watchlist_cmpy);
	SELF.watchlist_address := if (R.watchlist_address != '', R.watchlist_address, L.watchlist_address);
	SELF.watchlist_city := if (R.watchlist_city != '', R.watchlist_city, L.watchlist_city);
	SELF.watchlist_state := if (R.watchlist_state != '', R.watchlist_state, L.watchlist_state);
	SELF.watchlist_zip := if (R.watchlist_zip != '', R.watchlist_zip, L.watchlist_zip);
	self.watchlist_country := if (R.watchlist_country != '', R.watchlist_country, L.watchlist_country);
	self := L;
end;

pj3 := join(pj2, pj1, left.seq = right.seq,
			rejoin(LEFT,RIGHT), left outer, many lookup);

return pj3;

/* ----------------[ old style ]------------------
slimrec := record
	pat.pty_key;
	pat.source;
	qstring120	cn := (qstring120)pat.cname[1..120];
end;

slimtab := table(pat, slimrec);

matchrec := record
	slimtab.pty_key;
	slimtab.source;
	inl.seq;
end;

matchrec get_pty_key(layout_output L, slimtab R) := transform
	self := L;
	self := R;
end;

keys := join(inl(bdid = 0), slimtab,
			right.source = 'Office of Foreign Asset Control' and
			(
				ut.CompanySimilar100(left.company_name, right.cn) <= 10 or
				ut.CompanySimilar100(left.alt_company_name, right.cn) <= 10
			),
		   get_pty_key(LEFT,RIGHT), all);


patrec := record
	pat;
	inl.seq;
end;

patrec get_fullrecs(keys L, pat R) := transform
	self := R;
	self := L;
end;

patmatches := join(keys, pat,
					keyed(left.pty_key = right.pty_key) and
					keyed(left.source = right.source),
				get_fullrecs(LEFT,RIGHT), keep(1));

Layout_Output append_PatbyCompanyName(layout_output l, patmatches r) :=
TRANSFORM
	SELF.watchlist_table := r.source;
	SELF.watchlist_record_number := r.pty_key;
	self.watchlist_fname := r.fname;
	self.watchlist_lname := r.lname;
     SELF.watchlist_cmpy := r.cname;
	SELF.watchlist_address := Address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
									r.suffix, r.postdir, r.unit_desig, r.sec_range);
	SELF.watchlist_city := r.p_city_name;
	SELF.watchlist_state := r.st;
	SELF.watchlist_zip := r.zip;
	SELF.watchlist_country := r.country; 
	INTEGER watchlist_num_with_name := 0; // TODO: not implemented
	SELF := l;
END;

pj2 := JOIN(inl(bdid = 0), 
		  patmatches,
			left.seq = right.seq,
		  append_PatbyCompanyName(LEFT,RIGHT), 
		  LEFT OUTER, KEEP(1));

RETURN pj1 + pj2;
*/
END;