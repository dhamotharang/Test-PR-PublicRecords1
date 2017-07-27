import gong;

export Search_Bizname(STRING120 bizname_v, DATASET(EDA_VIA_XML.Layout_City_List) city_list_v) := FUNCTION

input_rec := RECORD
	string120 word;
	string25 city;
	string2 state;
	unsigned8 freq;
END;

input := dataset([{Stringlib.StringFindReplace(TRIM(bizname_v),' ',','), '', '', 0}], input_rec);

input_rec addWords(input_rec l, integer c) := TRANSFORM
	SELF.word := Stringlib.StringExtract(l.word, c);
	SELF := l;
END;

input_words := DEDUP(SORT(NORMALIZE(input,
							 LENGTH(Stringlib.StringFilter(TRIM(LEFT.word),','))+1,
					  	 addWords(LEFT, COUNTER))(TRIM(word)<>''), RECORD), RECORD);

input_rec lookup_word(input_rec l, EDA_VIA_XML.Key_bizword_frequency r) := TRANSFORM
	SELF.freq := r.freq;
	SELF := l;
END;

freq_words := JOIN(input_words, EDA_VIA_XML.Key_bizword_frequency,
								KEYED(LEFT.word=RIGHT.word),
								lookup_word(LEFT,RIGHT));

search_word := DEDUP(SORT(freq_words, freq), 1);

input_rec mergeCities(EDA_VIA_XML.Layout_City_List l, input_rec r) := TRANSFORM
	SELF.word := r.word;
	SELF.city := l.city;
	SELF.state := l.st;
	SELF.freq := r.freq;
END;

search_terms := JOIN(city_list_v, search_word, true, mergeCities(LEFT,RIGHT), LEFT OUTER, ALL);

baseFull := JOIN(search_terms, EDA_VIA_XML.Key_st_bizword_city,
								TRIM(LEFT.city)<>'' AND
								KEYED(LEFT.state=RIGHT.st) AND
								KEYED(LEFT.word[1..30]=RIGHT.word) AND
								KEYED(LEFT.city=RIGHT.city),
							TRANSFORM(gong.Layout_bscurrent_raw, 
							          self.sequence_number := (string10)right.sequence_number,
							          SELF:=RIGHT),
							LIMIT(0), KEEP(10000)
					);
					
baseWordSt := JOIN(search_terms, EDA_VIA_XML.Key_st_bizword_city, 
								TRIM(LEFT.city)='' AND
								KEYED(LEFT.state=RIGHT.st) AND
								KEYED(LEFT.word[1..30]=RIGHT.word),
							TRANSFORM(gong.Layout_bscurrent_raw, 
							          self.sequence_number := (string10)right.sequence_number,
							          SELF:=RIGHT),
							LIMIT(0), KEEP(10000)
					);
					
candidates := baseFull + baseWordSt;

output_rec := RECORD
	INTEGER8 seq_no;
	gong.Layout_bscurrent_raw;
END;

output_rec addSeqNo(gong.Layout_bscurrent_raw l, INTEGER c) := TRANSFORM
	SELF.seq_no := c;
	SELF := l;
END;
		
sequenced_candidates := PROJECT(candidates, addSeqNo(LEFT, COUNTER));

word_rec := RECORD
    STRING30 word;
		INTEGER8 seq_no;
END;

word_rec addOutputWords(output_rec l, INTEGER c) := TRANSFORM
	SELF.word := Stringlib.StringExtract(Stringlib.StringFindReplace(TRIM(l.listed_name),' ',','), c);
	SELF.seq_no := l.seq_no;
END;

word_list := DEDUP(SORT(NORMALIZE(sequenced_candidates,
							 LENGTH(Stringlib.StringFilter(TRIM(LEFT.listed_name),' '))+1,
					  	 addOutputWords(LEFT, COUNTER))(TRIM(word)<>''), RECORD), RECORD);
							 
joined_list := JOIN(input_words, word_list, LEFT.word=RIGHT.word, TRANSFORM(word_rec, SELF:=RIGHT));

new_rec := record
 joined_list.seq_no;
 integer cnt := count(group);
end;

counts_seq := table(joined_list,new_rec,seq_no);

bizname_results := JOIN(counts_seq(cnt=count(input_words)), sequenced_candidates, LEFT.seq_no=RIGHT.seq_no,
											TRANSFORM(gong.Layout_bscurrent_raw, SELF:=RIGHT));

EDA_VIA_XML.Layout_Gong_Extended addScore(gong.Layout_bscurrent_raw l) := TRANSFORM
  SELF.score := 100;
	SELF := l;
END;

return PROJECT(bizname_results, addScore(LEFT));

END;