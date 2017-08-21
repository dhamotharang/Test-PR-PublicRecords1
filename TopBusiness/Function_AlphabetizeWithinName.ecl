import ut;

export Function_AlphabetizeWithinName(
	dataset({string120 clean_company_name;string120 repl_phrase;}) indata_1) := function
	
	indata := distributed(indata_1,hash64(clean_company_name));
	
	tempdedup := dedup(indata,clean_company_name,repl_phrase,all,local);
	
	pattern p_ws := ' ';
	pattern p_word := pattern('[^ ]+');
	pattern p_find := (p_word after (first or p_ws)) before (p_ws or last);
	
	tempnormalize := parse(tempdedup,repl_phrase,p_find,transform({recordof(indata);string word;},
		self.word := matchtext(p_word),
		self := left),
		scan all);
	
	// tempnormalize := normalize(tempdedup,ut.NoWords(trim(left.repl_phrase)),
		// transform({recordof(indata);string word;},
			// self.word := ut.Word(trim(left.repl_phrase),counter),
			// self := left));
		
	tempresort := sort(tempnormalize(word != ''),clean_company_name,repl_phrase,word,local);

	temprollup := rollup(tempresort,
		left.clean_company_name = right.clean_company_name and
		left.repl_phrase = right.repl_phrase,
		transform(recordof(tempresort),
			self.clean_company_name := left.clean_company_name,
			self.repl_phrase := left.repl_phrase,
			self.word := trim(left.word) + ' ' + right.word),
		local);

	tempjoin := join(
		indata,
		temprollup(repl_phrase != word),
		left.clean_company_name = right.clean_company_name and
		left.repl_phrase = right.repl_phrase,
		transform(recordof(indata),
			self.clean_company_name := left.clean_company_name,
			self.repl_phrase := right.word,
			self := left),
		local);
			
	return dedup(indata + tempjoin,record,all,local);

end;
