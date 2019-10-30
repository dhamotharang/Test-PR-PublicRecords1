Import gong, doxie, prte2_gong, Prte2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
input_recs := prte2_gong.files.Gong_Raw((listing_type_bus = 'B') AND (TRIM(listed_name)<>''));
#ELSE
input_recs := gong.File_Gong_Full((listing_type_bus = 'B') AND (TRIM(listed_name)<>''));
#END;

Layout_extra := RECORD
  STRING30	word;
	UNSIGNED8	freq;
END;

Layout_extra addWords(input_recs l, integer c) := TRANSFORM
	SELF.word := Stringlib.StringExtract(Stringlib.StringFindReplace(TRIM(l.listed_name),' ',','), c);
	SELF.freq := 1;
END;

with_words := NORMALIZE(input_recs,
							 LENGTH(Stringlib.StringFilter(TRIM(LEFT.listed_name),' '))+1,
					  	 addWords(LEFT, COUNTER));
							 
sort_words := SORT(with_words(TRIM(word)<>''), word);

Layout_extra tallyWords(Layout_extra l, Layout_extra r) := TRANSFORM
	SELF.word := l.word;
	SELF.freq := l.freq + r.freq;
END;

key_recs := ROLLUP(sort_words, LEFT.word=RIGHT.word, tallyWords(LEFT,RIGHT));

export Key_bizword_frequency := 
       index(key_recs,
             {string30 word := word,
							unsigned8 freq := freq},
             {key_recs},
		   '~thor_data400::key::gong_eda_bizword_frequency_' + doxie.Version_SuperKey);