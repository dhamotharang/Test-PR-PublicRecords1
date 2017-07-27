export Function_RemoveSuffixes(
	dataset({string120 clean_company_name;string120 repl_phrase;}) company_names) := function

	tempnormalized := normalize(company_names,2,
		transform(recordof(company_names),
			self.clean_company_name := left.clean_company_name,
			self.repl_phrase := choose(counter,
				left.clean_company_name,
				trim(regexreplace(' (AND|LTD|INC|LLC|MR|MRS|MS|MISS|MD|DVM|DDS|PHD|CPA|ATTY|LWYR|THE|ATT AT LAW|ATTORNEY|ATTORNEY AT LAW|ATTYS|DC|DMD|DO|DR|ESQ|OD|REV) ',' ' + left.repl_phrase + ' ',' '),left,right)),
			self := left));
	
	return dedup(dedup(tempnormalized,record,all,local),record,all);
				
	
	
	// pattern p_suffix := pattern('AND|LTD|INC|LLC|MR|MRS|MS|MISS|MD|DVM|DDS|PHD|CPA|ATTY|LWYR|THE|ATT AT LAW|ATTORNEY|ATTORNEY AT LAW|ATTYS|DC|DMD|DO|DR|ESQ|OD|REV');
	// pattern p_ws := pattern(' ')+;
	// pattern p_word := pattern('[^ ]+');
	// pattern p_rest := p_word (p_ws p_word)*;
	// pattern p_rest_1 := p_rest;
	// pattern p_rest_2 := p_rest;

	// pattern p_find := first opt(p_ws) (p_rest_1 p_ws     ((    ((p_rest p_ws p_suffix) or (p_rest penalty(1))) opt(p_ws) last;
	// pattern p_find := first opt(p_ws) ((p_rest p_ws p_suffix) or (p_rest penalty(1))) opt(p_ws) last;

	// return parse(company_names,repl_phrase,p_find,transform(recordof(company_names),
		// self.clean_company_name := left.clean_company_name,
		// self.repl_phrase := matchtext(p_rest),
		// self := left),scan all); /* i'm doing scan all in order to get the originals, PLUS the parsed */
		
end;
