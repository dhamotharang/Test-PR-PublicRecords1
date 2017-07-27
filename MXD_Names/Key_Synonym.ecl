Import ut, Data_Services, doxie, MXD_Common;

l_raw := RECORD
	unicode				term1 := u'';
	unicode				term2 := u'';
END;

// ds_synonym_raw := DATASET('~thor_data400::in::mxdata::synonyms::raw', 
synonym_raw := DATASET(ut.foreign_dataland+'thor_data400::in::mxdata::synonyms::20110811::raw', 
											 l_raw, 
											 CSV(UNICODE, HEADING(1), SEPARATOR('|'), TERMINATOR(['\n','\r\n','\n\r']), QUOTE('"')));


Layout_Key_Synonym := record
	string6 	term1M1;
	string6 	term1M2;
	string40 	t1;	// the clean, flat string version of term1
	string6 	term2M1;
	string6 	term2M2;	
	string40 	t2;  // the clean, flat string version of term2
	unicode40 term1;
	unicode40 term2;
	unsigned2	score;
end;

Layout_Base_Synonym := record
	Layout_Key_Synonym;	
	unsigned8 fpos{virtual(fileposition)} := 0;
end;


// these are synonyms provided by the vendor, so we'll assume they are all valid name variants.
// we do however want to have a score in place to possibly sort which variants are better than other.

Layout_Base_Synonym to_base_file(synonym_raw l, integer c) := transform

		_t1		 := if(c=1, l.term1, l.term2); // reverse order if c=2
		_t2		 := if(c=1, l.term2, l.term1); 
		_term1 := UnicodeLib.UnicodeCleanSpaces(UnicodeLib.UnicodeToUpperCase(_t1));
		_term2 := UnicodeLib.UnicodeCleanSpaces(UnicodeLib.UnicodeToUpperCase(_t2));															
		_t1_flat := (string) MXD_Common.FN_Unicode2Flat(_term1);															
		_t2_flat := (string) MXD_Common.FN_Unicode2Flat(_term2);																	
		
		_t1m1	:= MetaphoneLib.DMetaphone1(_t1_flat)[1..6];
		_t1m2	:= MetaphoneLib.DMetaphone2(_t1_flat)[1..6];
		_t2m1	:= MetaphoneLib.DMetaphone1(_t2_flat)[1..6];
		_t2m2	:= MetaphoneLib.DMetaphone2(_t2_flat)[1..6];

		// code below similar to ut.NameVariants
		
		edist := stringlib.editDistance(_t1_flat, _t2_flat);
		edist_scaled := (edist * 100) / length(_t1_flat);
		
		// bias for first chars differing
		first_chars_diff_bias := if(_t1_flat[1] <> _t2_flat[1], 1, 0);

		// bias for phonetic equivalents not matching
		diff_phonetics_bias := if(_t2m1 <> _t1m1, 1, 0);
		
		self.score 	 := (edist + first_chars_diff_bias + diff_phonetics_bias) * 4;		
		self.term1	 := if(length(_t1_flat)>=3, _term1, skip), //probably not a good idea to have short synonym, so let's skip it.
		self.term2	 := if(length(_t2_flat)>0, _term2, skip),
		self.term1M1 := _t1m1,
		self.term1M2 := _t1m2,
		self.term2M1 := _t2m1,
		self.term2M2 := _t2m2,															
		self.t1	 		 := _t1_flat,
		self.t2	 		 := _t2_flat,
		
		self 				 := l
end;

// normalize records so we can index by both term1 and term2.
ds_synonym_norm := normalize(synonym_raw, 2, to_base_file(left, counter));
ds_synonym_dist	:= distribute(ds_synonym_norm, hash(t1));
ds_synonym_base := dedup(sort(ds_synonym_dist, t1, t2, local), t1, t2, local);	
						
ds_synonyms := project(ds_synonym_base, transform(Layout_Key_Synonym, self := left));
Export Key_Synonym := 	Index(ds_synonyms, {term1M1, term1M2, t1}, {term2M1, term2M2, t2, term1, term2, score}, 
																Data_Services.Data_location.Prefix('MXData')+'thor_data400::key::mxd_names::'+doxie.Version_SuperKey+'::synonym_idx');	
