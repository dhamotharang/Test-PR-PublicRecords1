import TopBusiness_Metadata;

export Function_Phrase_Replace(
	dataset({string120 clean_company_name;string120 repl_phrase;}) unique_company_names_1) := function
	
	unique_company_names := distribute(unique_company_names_1,hash64(clean_company_name));

	pattern p_word := pattern('[^ ]+');
	pattern p_ws := pattern('[ ]+');
	pattern p_phrase := p_word (p_ws p_word)*;
	pattern p_search := (p_phrase after (first or p_ws)) before (p_ws or last);

	tempparserec := record
		unique_company_names.clean_company_name;
		string phrase := matchtext(p_phrase);
		unsigned startpos := matchposition(p_phrase);
		unsigned endpos := matchposition(p_phrase) + matchlength(p_phrase) - 1;
	end;

	tempparse := distributed(parse(unique_company_names,clean_company_name,p_search,tempparserec,scan all),hash64(clean_company_name));
	
	tempjoinrec := record
		tempparserec.clean_company_name;
		TopBusiness_Metadata.PhraseReplacements.phrase_priority;
		tempparserec.phrase;
		tempparserec.startpos;
		tempparserec.endpos;
		TopBusiness_Metadata.PhraseReplacements.repl_phrase;
	end;

	tempparsejoin := join(tempparse,TopBusiness_Metadata.PhraseReplacements,
		left.phrase = right.find_phrase,
		transform(tempjoinrec,
			self.phrase_priority := right.phrase_priority,
			self.repl_phrase := if(right.phrase_priority = 0,left.phrase,right.repl_phrase),
			self := left),
		left outer,
		lookup);

	tempsort := sort(tempparsejoin,clean_company_name,if(phrase_priority = 0,1,0),phrase_priority,startpos,-endpos,local);

	tempsequence := ungroup(project(group(tempsort,clean_company_name,local),transform({unsigned seq;tempsort;},self.seq := counter,self := left)));

	submacro(din,tout,rout) := macro
		tout := dedup(sorted(din,clean_company_name,seq,local),clean_company_name,local);
		rout := join(din,tout,
			left.clean_company_name = right.clean_company_name and
			(
				(left.startpos < right.startpos and left.endpos < right.startpos) or
				(left.startpos > right.endpos and left.endpos > right.endpos)
			),
			transform(left),
			local);
	endmacro;
	
	// Take the tops for each
	submacro(tempsequence,tops_1,remove_1);
	submacro(remove_1,tops_2,remove_2);
	submacro(remove_2,tops_3,remove_3);
	submacro(remove_3,tops_4,remove_4);
	submacro(remove_4,tops_5,remove_5);
	submacro(remove_5,tops_6,remove_6);
	submacro(remove_6,tops_7,remove_7);
	submacro(remove_7,tops_8,remove_8);
	
	return dedup(project(rollup(sort(tops_1 + tops_2 + tops_3 + tops_4 + tops_5 + tops_6 + tops_7 + tops_8,clean_company_name,startpos,local),
		transform(recordof(tops_8),
			self.repl_phrase := left.repl_phrase + ' ' + right.repl_phrase,
			self := left),
		clean_company_name,local),recordof(unique_company_names)) + unique_company_names,record,all,local);

end;
