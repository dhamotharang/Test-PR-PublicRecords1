import header,lib_metaphone, lib_stringlib;

//
// This is an implementation of the Moxie CheckNameVariants functionality 
//
// Returns up to the 'num_variants' preferred candidates for the input name 
// (input name will always be returned, plus the next N best)
//

// currently have an issue where these functions are getting called even when CheckNameVariants is false
// so much unnecessary work is being done and discarded.
//
// adding a boolean value to control the retrieval of the nameVariants
// use it to filter the index reads 
// 
export NameVariants(string name, unsigned1 num_variants, boolean isFCRA, boolean checkNameVariants = true) := MODULE

	shared MAX_SCORE_THRESHOLD := 99;  // maximum allowable score

	shared ph1 := (string6)metaphonelib.DMetaPhone1(name);
	shared ph2 := (string6)metaphonelib.DMetaPhone2(name);
	shared phon_set := [ph1, ph2];
	
	// only use phonetic candidates if the metaphone1 and metaphone2 values are different
	shared diff_phons := ph1 <> ph2;

  // add a blank to the front and back of the input name
	// then create trigrams from each 3 positions of the name
	ngram_pre := ' ' + trim(name) + ' ';

	tri_layout := {string3 trigram};
	num_trigrams := LENGTH(name);
	nada := DATASET([{''}], tri_layout);

	tri_layout getTrigrams(nada l,integer c) := transform
		start := c;
		stop := c+2;
		SELF.trigram := ngram_pre[start..stop];
	end;
	 
	trigrams := normalize(nada, num_trigrams, getTrigrams(LEFT, COUNTER)); 
	shared ngram_set := SET(trigrams,trigram);

	// layouts
	shared tmp_layout := RECORD
		string20 name;
		string10 cnt;
		unsigned score := 0;
	END;
	
	// macro to return the phonetic matches 
	shared mac_get_phon_matches(keyname,srchfield,namefield,res) := MACRO
		#uniquename(cands)
		// apply the guard as a filter
		
		// phonetic keys only contain the 10 most frequent names for the phonetic equivalent
		// phon_set can have at most 2 different values, so adding limit of 20 to prevent the warning
		%cands% := IF(checkNameVariants, project(LIMIT(keyname(keyed(srchfield in phon_set)),20, SKIP), 
											 TRANSFORM(tmp_layout, SELF.name := LEFT.namefield; SELF.cnt := LEFT._count)));
		res := IF(diff_phons, %cands%);
	ENDMACRO;

	// macro to return the ngram matches
	shared mac_get_ngram_matches(keyname,namefield,res) := MACRO 
		// apply the guard as a filter
		
		// ngram keys have all of the names for any given trigram;
		// based on analysis of the most frequent trigram variations and a common name that shares the most frequently 
		// occurring trigrams (e.g., BANNISTER), setting the limit to 40K to eliminate the warning, and to prevent the
		// SKIP from occurring
		//res := project(LIMIT(keyname(keyed(ngram in ngram_set)),40000,SKIP), 
		//							 TRANSFORM(tmp_layout, SELF.name := LEFT.namefield; SELF.cnt := LEFT._count))(checkNameVariants);
		
		res := IF(checkNameVariants, project(LIMIT(keyname(keyed(ngram in ngram_set)),40000,SKIP), 
                   TRANSFORM(tmp_layout, SELF.name := LEFT.namefield; SELF.cnt := LEFT._count)));

									 
	ENDMACRO;
		
	// scoring algorithm for selecting the best name variants	
	shared tmp_layout scoreThem(tmp_layout l) := TRANSFORM
		edist := stringlib.editDistance(name, l.name);
		edist_scaled := (edist * 100) / length(name);
		
		// discard any that aren't within an edit distance of 30
		// also remove the input name (edist = 0) -- makes it easier to always add it to the list later
		// in the event it either wasn't found in either key, or wasn't frequent enough to score in the top 10
		self.name := if (edist = 0 or (edist > 2 and edist_scaled > 30), SKIP, l.name);

		// bias for first chars differing
		first_chars_diff_bias := if(name[1] <> l.name[1], 1, 0);

		// bias for phonetic equivalents not matching
		tmp_ph1 := (string6)metaphonelib.DMetaPhone1(l.name);
		diff_phonetics_bias := if(ph1 <> tmp_ph1, 1, 0);
		
		base_score := (edist + first_chars_diff_bias + diff_phonetics_bias) * 4;

		// inverse logarithmic score 
		// cnt is a string10, freq_score is the number of leading zeroes, larger actual number (fewer zeroes) 
		// means better score
		searchpattern := '^0+';
		freq_score := length(REGEXFIND(searchpattern, l.cnt, 0));

		self.score := base_score + freq_score;
		self := l;
	end;

	// common function to process name variant sets
	shared processMatches(dataset(tmp_layout) variants) := FUNCTION
		scored_matches := project(variants, scoreThem(LEFT));
		deduped_matches := dedup(sort(scored_matches(score < MAX_SCORE_THRESHOLD), score, -cnt, name), score, name);
		// always echo the input name
		in_name := dataset([{name,'',0}], tmp_layout);
		return set(in_name & choosen(deduped_matches, num_variants-1),name);
	END;
		
	// Fname variants
	fname_phon_key := if(isFCRA, Header.key_Phonetic_equivs_fname_fcra, Header.key_Phonetic_equivs_fname);
	fname_ngram_key := if(isFCRA, Header.key_fname_ngram_fcra, Header.key_fname_ngram);

	mac_get_phon_matches(fname_phon_key,ph_fname,fname,phon_matches)	
	mac_get_ngram_matches(fname_ngram_key,fname,ngram_matches)
		
	export fnames := processMatches(phon_matches + ngram_matches);

	// Lname variants
	lname_phon_key := if(isFCRA, Header.key_Phonetic_equivs_lname_fcra, Header.key_Phonetic_equivs_lname);
	lname_ngram_key :=  if(isFCRA, Header.key_lname_ngram_fcra, Header.key_lname_ngram);

	mac_get_phon_matches(lname_phon_key,ph_lname,lname,phon_matches)
	mac_get_ngram_matches(lname_ngram_key,lname,ngram_matches)

	export lnames := processMatches(phon_matches + ngram_matches);
	
END;