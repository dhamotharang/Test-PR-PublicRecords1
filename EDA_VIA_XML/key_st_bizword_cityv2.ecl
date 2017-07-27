import gong, gong_v2, doxie;

input_recs := project(Gong_v2.proc_roxie_keybuild_prep_current2((listing_type_bus = 'B') AND (TRIM(listed_name)<>'')), 
				  transform(gong_v2.Layout_bscurrent_raw, self:=left, self := []));

Layout_extra := RECORD
  STRING30	word;
input_recs;
END;


Layout_extra addWords(input_recs l, integer c) := TRANSFORM
	SELF.word := Stringlib.StringExtract(Stringlib.StringFindReplace(TRIM(l.listed_name),' ',','), c);
	SELF := l;
END;

with_words := NORMALIZE(input_recs,
							 LENGTH(Stringlib.StringFilter(TRIM(LEFT.listed_name),' '))+1,
					  	 addWords(LEFT, COUNTER));
							 
key_recs := DEDUP(SORT(with_words(TRIM(word)<>''), RECORD), RECORD);

export Key_st_bizword_cityv2 := 
       index(key_recs,
             {string2 st := st,
						  string30 word := word,
							string25 city := p_city_name},
             {key_recs},
		   Gong_v2.thor_cluster + 'key::gongv2_eda_st_bizword_city_' + doxie.Version_SuperKey);