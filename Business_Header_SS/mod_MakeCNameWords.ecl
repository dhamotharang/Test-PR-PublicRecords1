import text,ut,lib_metaphone,LN_PropertyV2,Business_Header_SS;

export mod_MakeCNameWords :=
MODULE


//*****
// A FUNCTION TO FIND THE WORDS AND SEQUENCE THEM
//*****

export words_sequenced(
	dataset(Business_Header_SS.layout_MakeCNameWords) infile
	) :=
FUNCTION

	// If no filepos given, lets create a record in that field
	ut.MAC_Sequence_Records(infile, __filepos, infile_wrid)

	bh_slim := if(exists(infile(__filepos > 0)),
					infile,
					infile_wrid);

	bh_dist := DISTRIBUTE(bh_slim, HASH(bdid));
	bh_sort := SORT(bh_dist, bdid, company_name, state,lookups, LOCAL);
	bh_ded1 := DEDUP(bh_sort, bdid, company_name, state,lookups, LOCAL);

	// Nix blank states if the same bdid/name has a state.
	TYPEOF(bh_ded1) ReplaceBlank(bh_ded1 l, bh_ded1 r) := TRANSFORM
		SELF := r;
	END;

	bh_ded := ROLLUP(bh_ded1, LEFT.bdid = RIGHT.bdid AND
								LEFT.company_name = RIGHT.company_name AND
								Left.lookups = RIGHT.lookups and
								LEFT.state = '',
								ReplaceBlank(LEFT, RIGHT), LOCAL);

	PATTERN namechar := text.Alpha | text.Digit;
	PATTERN not_namechar := PATTERN('[^A-Za-z0-9]');
	PATTERN wrd := namechar+;
	PATTERN co_name := wrd (LAST | not_namechar);

	// Must match Layout_Header_Word_Index
	words_layout := RECORD //must match "words_layout" definition below by type
		STRING40  word := MATCHTEXT(wrd);
		STRING2   state := bh_ded.state;
		UNSIGNED1 seq := MATCHPOSITION(wrd);
		UNSIGNED8 filepos := bh_ded.__filepos;
		UNSIGNED6 bdid := bh_ded.bdid;
		unsigned4 lookups := bh_ded.lookups;
	END;

	words := PARSE(	bh_ded, company_name, 
				co_name, words_layout,
				SCAN);

	// Order the words found in the same record
	words_distrib := DISTRIBUTE(words, HASH(filepos));
	words_group := GROUP(SORT(words_distrib, filepos, seq, LOCAL), filepos, LOCAL);
	words_dedup := DEDUP(words_group, filepos, word, seq);

	words_layout Sequence(words_layout l, words_layout r) := TRANSFORM
		SELF.seq := IF(l.seq = 0, 1, l.seq + 1);
		SELF := r;
	END;

	return ITERATE(words_dedup, Sequence(LEFT, RIGHT));
end;


//*****
// A FUNCTION TO ROLL UP THE WORDS IN EITHER DIRECTION

// forward produces words that are 
// word1 + word2 + word3
// word2 + word3
// word3
// so, you need a leading match when they enter word1

// reverse produces words that are
// word 1 + word2
// word 1
// so, if you use both forward and backward, you dont need the leading match

//*****

shared words_layout := RECORD //must match "words_layout" definition above by type
	STRING40  word;
	STRING2   state;
	UNSIGNED1 seq;
	UNSIGNED8 filepos;
	UNSIGNED6 bdid;
	unsigned4 lookups;
END;

shared 	layout_sub_seq := RECORD
	STRING120 word;
	STRING15 metaphone;
	STRING2   state;
	UNSIGNED1 seq;
	UNSIGNED1 right_seq;
	UNSIGNED8 filepos;
	UNSIGNED6 bdid;
	unsigned4 lookups;
END;

export subsequence_rolled(
	grouped dataset(words_layout) infile,
	boolean inReverse = FALSE
	) :=
FUNCTION

	words_seq := infile;


	layout_sub_seq CreateSubSeq(words_seq l, words_seq r) := TRANSFORM
		SELF.right_seq := r.seq;
		SELF.word := r.word;
		SELF.metaphone := lib_metaphone.MetaphoneLib.DMetaphone1(r.word);
		SELF := l;
	END;

	subseqs := JOIN(words_seq, words_seq,
		LEFT.filepos = RIGHT.filepos AND
		if(inReverse, RIGHT.seq < LEFT.seq, RIGHT.seq >= LEFT.seq),
		CreateSubSeq(LEFT, RIGHT), LEFT OUTER, LOCAL);

	// Rollup the sequences.
	subseqs_sort := SORT(subseqs, filepos, if(inReverse, -seq, seq), right_seq, LOCAL);

	layout_sub_seq AppendNext(subseqs_sort l, subseqs_sort r) := TRANSFORM
		SELF.word := TRIM(l.word) + r.word;
		SELF.metaphone := TRIM(l.metaphone) + r.metaphone;
		SELF := l;
	END;
	
	
	subseqs_rolled := ROLLUP(subseqs_sort, 
			LEFT.filepos = RIGHT.filepos AND
			LEFT.seq = RIGHT.seq, AppendNext(LEFT, RIGHT), LOCAL)(word <> '')
			+ if(inReverse, subseqs_sort(word <> ''));//this picks up words in the middle (like word2 of four by itself) and necessitates the following dedup

	subseqs_ddp  := dedup(sort(subseqs_rolled, filepos, word, local), filepos, word, local);	//already dist by filepos

	return subseqs_ddp;
end;


//*****
// A FUNCTION TO DEDUP AND PROJECT TO FINAL LAYOUT
//*****

export words_final(
	dataset(layout_sub_seq) infile
	) :=
FUNCTION

	subseqs_rolled := infile;

	subseqs_rolled_dist := distribute(subseqs_rolled,bdid);

	// Dedup identical sequences per bdid
	words_ded := DEDUP(sort(subseqs_rolled_dist, bdid, seq, word, state, lookups,local),bdid, seq, word, state, lookups,local);


	// Get rid of the right_seq field which we don't need.
	outRec := record
		Business_Header_SS.Layout_Header_Word_Index;
		unsigned4 lookups;
		subseqs_rolled.metaphone;
	end;
	
	outRec Strip(words_ded l) := TRANSFORM
		SELF.bh_filepos := l.filepos;
		SELF := l;
	END;

	return PROJECT(words_ded, Strip(LEFT));
	
END;


//*****
// A FUNCTION TO RETURN THE TRADITIONAL BUSINESS WORDS
//*****

export records(
	dataset(Business_Header_SS.layout_MakeCNameWords) infile
	) :=
FUNCTION

	words_seq := words_sequenced(infile);
	subseqs_rolled := subsequence_rolled(project(words_seq, words_layout));
	return words_final(subseqs_rolled);

end;

//*****
// A FUNCTION TO RETURN THE METAPHONE BUSINESS WORDS
//*****

export metaphone :=
MODULE

	export inrec := record(Business_Header_SS.layout_MakeCNameWords)
		string6 zip;
	end;

	export mrecords(
		dataset(inrec) infile
		) :=
	FUNCTION
	
	//**** MAP & TO AND
	infile_mapped :=
	project(
		infile,
		transform(
			inrec,
			self.company_name := ut.mod_AmpersandTools.SimpleReplace(left.company_name), //see bug 22195 
			self := left
		)
	);

	//***** POPULATE THE SEQUENCE FIELD THAT IS EXPECTED BY BUSINESS_HEADER_SS.FN_MAKECNAMEWORDS
	ut.MAC_Sequence_Records(infile_mapped, __filepos, infile_wrid)
	

	//***** THIS IS BASICALLY THE SAME FUNCTIONALITY AS THE TRADITIONAL WORD KEY, BUT IT INCLUDES THE REVERSE ROLLUP AS WELL
	//***** THE REVERSE ROLLUP ALLOWS US TO AVOID A LEADING MATCH ON THE (PHONETIC) WORD - SEE FUNCTION ABOVE
	
	words_seq 							:= words_sequenced(infile_wrid);
	subseqs_rolled_forward	:= subsequence_rolled(project(words_seq, words_layout), FALSE);
	subseqs_rolled_reverse 	:= subsequence_rolled(project(words_seq, words_layout), TRUE);
	subseqs_rolled 					:= subseqs_rolled_forward + subseqs_rolled_reverse;
	wrds_unfiltered					:= words_final(subseqs_rolled);

	//**** FILTER OUT USELESS ENTRIES
	wrds := wrds_unfiltered(word not in LN_PropertyV2.furniture_words);
	
	
	//**** ADD METAPHONE AND ZIP FIELDS AND DROP FILEPOS FIELDS
	outrec := record
		string15 metaphone;
		wrds.word;
		wrds.state;
		wrds.seq;
		wrds.bdid;
		wrds.lookups;
		inrec.zip;
	end;
	
	
	
	//**** POPULATE ZIP
	j := 
	join(
		wrds,
		infile_wrid,
		left.bh_filepos = right.__filepos,
		transform(
			outrec,
			self.zip := right.zip,
			self := left
		),
		hash
	)(metaphone <> '');
	
	return j;
	END;

end;


END;//module