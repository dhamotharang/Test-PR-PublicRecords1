import Address,Patriot, ut, RiskWise;

export getWatchLists(GROUPED DATASET(Layout_Output) inl, boolean ofac_only = false, boolean From_BIID = false) :=
FUNCTION

pat := patriot.key_patriot_file;
pat_did := patriot.key_did_patriot_file;
pat_phon := patriot.Key_Phonetic_Name;

Layout_Output append_PatbyDid(Layout_Output le, pat_did ri) :=
TRANSFORM
	SELF.watchlist_table := ri.source;
	SELF.watchlist_record_number := ri.pty_key;
	SELF.watchlist_fname := ri.fname;
	SELF.watchlist_lname := ri.lname;
	SELF.watchlist_address := Address.Addr1FromComponents(ri.prim_range, ri.predir, ri.prim_name,
									ri.suffix, ri.postdir, ri.unit_desig, ri.sec_range);
	SELF.watchlist_city := ri.v_city_name;
	SELF.watchlist_state := ri.st;
	SELF.watchlist_zip := ri.zip;
	SELF.watchlist_contry := ri.country; 
	SELF.watchlist_entity_name := ri.cname;
	INTEGER watchlist_num_with_name := 0; // TODO: not implemented

	SELF := le;
END;

pj1 := JOIN(inl(did != 0), pat_did,
			//left.did != 0 and 
			keyed(LEFT.did=RIGHT.did) AND
			(~ofac_only or RIGHT.pty_key[1..4]='OFAC') AND
			RIGHT.pty_key[1..3]<>'PEP', 
		  append_PatbyDid(LEFT,RIGHT), LEFT OUTER, KEEP(1));
		  


//------------[ NAME ONLY ]-----------------
unsigned2 def_score := 255;
slimrec := record
	inl.seq;
	inl.fname;
	inl.mname;
	inl.lname;
	string100 full_name;
	string50	phon;
	inl.employer_name;	
	pat.pty_key;
	pat.source;
	unsigned2 name_score := def_score;
	unsigned2 cmpy_score := def_score;
end;

string os(string s) := if (s = '', ' ', ' ' +trim(s) + ' ');

slimrec into_slim_name(inl L) := transform
	self.full_name := trim(L.fname) + os(L.mname) + trim(L.lname);
	self.phon := '';
	self.pty_key := '';
	self.source := '';
	self := L;
end;

slimrec into_slim_cmpy(inl L) := transform
	self.full_name := trim(L.employer_name);
	self.phon := '';
	self.pty_key := '';
	self.source := '';
	self := L;
end;
inl_name := project(inl,into_slim_name(LEFT));
inl_cmpy := project(inl,into_slim_cmpy(left));
inl_slim := inl_name + if (~from_BIID, inl_cmpy);

Token   name := Pattern ('[a-zA-Z]+');
Rule   is_a_name := name;
emptywords := ['THE','AN','TO','OF','FOR','A','AND'];

slimrec into_parse1(slimrec le) := transform
	self.phon := if (stringlib.stringtouppercase(matchtext(is_a_name)) not in emptywords, metaphonelib.dmetaphone1(matchtext(is_a_name)), '');
	self.name_score := def_score;
	self.cmpy_score := def_score;
	self := le;
end;

name_phon := global(parse(inl_slim, full_name, is_a_name, into_parse1(LEFT), maxlength(50)));

slimrec check_names(slimrec le, pat_phon rt) := transform	
	self.source := rt.source;
	lencmpy := length(trim(le.employer_name));
	self.pty_key := if (datalib.namematch(le.fname,'',le.lname,rt.fname,'',rt.lname)<=3 or
					datalib.namematch(le.fname,'',le.lname,rt.mname,'',rt.lname)<=3 or
					if (~from_BIID,ut.CompanySimilar100(le.employer_name, rt.cname[1..lencmpy])<=20, false), rt.pty_key, skip);
	self.name_score := datalib.namematch(le.fname,'',le.lname,rt.fname,'',rt.lname);
	self.cmpy_score := if (~from_BIID,ut.CompanySimilar100(le.employer_name, rt.cname[1..lencmpy]), 255);
	self := le;
end;

match_by_name := join (name_phon, pat_phon, 
					keyed(left.phon = right.pnamecomponent) and 
					keyed(right.source IN Patriot.OFAC_SourceSet),
				   check_names(LEFT,RIGHT));

slimrec roll_names(slimrec le, slimrec rt) := transform
	nc := le.name_score<=rt.name_score;
	cc := le.cmpy_score<=rt.cmpy_score;
	self := if(nc or cc,le, rt);
end;

rNames := rollup(sort(match_by_name,seq),true,roll_names(left, right));

patrec := record
	pat;
	unsigned4	seq;
end;

patrec get_pat_Recs(match_by_name L, pat R) := transform
	self.seq := L.seq;
	self := R;
end;

patrecs := join(rNames, pat,
			left.pty_key != '' and keyed(left.pty_key = right.pty_key) and
			keyed(right.source IN Patriot.OFAC_SourceSet),
			get_pat_recs(LEFT,RIGHT),
			ATMOST(keyed(left.pty_key = right.pty_key) and keyed(right.source IN Patriot.OFAC_SourceSet),RiskWise.max_atmost));

xlayout := record
	inl;
	unsigned ofc_name_score := def_score;
	unsigned ofc_cmpy_score := def_score;
end;
	
xlayout append_PatbyName(Layout_Output le, patrecs ri) :=
TRANSFORM
	SELF.watchlist_table := if(ri.pty_key='', '', ri.source);
	SELF.watchlist_record_number := if(ri.pty_key='', '', ri.pty_key);
	SELF.watchlist_fname := if(ri.pty_key='', '', ri.fname);
	SELF.watchlist_lname := if(ri.pty_key='', '', ri.lname);
	SELF.watchlist_address := if(ri.pty_key='', '', if(ri.prim_name='', ri.addr_1,
										Address.Addr1FromComponents(ri.prim_range, ri.predir, ri.prim_name,
																ri.suffix, ri.postdir, ri.unit_desig, ri.sec_range)));
	SELF.watchlist_city := if(ri.pty_key='', '', ri.v_city_name);
	SELF.watchlist_state := if(ri.pty_key='', '', ri.st);
	SELF.watchlist_zip := if(ri.pty_key='', '', ri.zip);
	SELF.watchlist_contry := if(ri.pty_key='', '', ri.country);
	SELF.watchlist_entity_name := if(ri.pty_key='', '', ri.cname); 
	INTEGER watchlist_num_with_name := 0; // TODO: not implemented
	self.ofc_name_score := datalib.namematch(le.fname,'',le.lname,ri.fname,'',ri.lname);
	self.ofc_cmpy_score := if (~from_BIID,ut.CompanySimilar100(le.employer_name, ri.cname), 255);	
	SELF := le;
END;

wScores := join(inl, patrecs,
			left.seq = right.seq,
		  append_patbyname(LEFT,RIGHT), left outer, lookup);
		  
xlayout roll_alert(xlayout le, xlayout rt) := transform
	self := if(le.ofc_name_score <= rt.ofc_name_score or le.ofc_cmpy_score <= rt.ofc_cmpy_score,le, rt)
end;

pj2 := rollup(wScores,true,roll_alert(left,right));

layout_output rejoin(pj2 L, pj1 R) := transform
	SELF.watchlist_table := if (R.watchlist_table != '', R.watchlist_table, L.watchlist_table);
	SELF.watchlist_record_number := if (R.watchlist_record_number != '', R.watchlist_record_number, L.watchlist_record_number);
	SELF.watchlist_fname := if (R.watchlist_fname != '', R.watchlist_fname, L.watchlist_fname);
	SELF.watchlist_lname := if (R.watchlist_lname != '', R.watchlist_lname, L.watchlist_lname);
	SELF.watchlist_address := if (R.watchlist_address != '', R.watchlist_address, L.watchlist_address);
	SELF.watchlist_city := if (R.watchlist_city != '', R.watchlist_city, L.watchlist_city);
	SELF.watchlist_state := if (R.watchlist_state != '', R.watchlist_state, L.watchlist_state);
	SELF.watchlist_zip := if (R.watchlist_zip != '', R.watchlist_zip, L.watchlist_zip);
	SELF.watchlist_entity_name := if (R.watchlist_entity_name != '', R.watchlist_entity_name, L.watchlist_entity_name);
	self := L;
end;

pj3 := join(pj2, pj1, left.seq = right.seq,
			rejoin(LEFT,RIGHT), lookup, left outer);
			
/*
output(rNames, named('rNames'));
output(patrecs, named('patrecs'));
output(wScores, named('wScores'));
output(pj2, named('pj2'));
*/
return pj3;


END;