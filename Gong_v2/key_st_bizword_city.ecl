import gong, doxie;

input_recs := Gong_v2.proc_roxie_keybuild_prep2((listing_type_bus = 'B') AND (TRIM(company_name)<>''));

Layout_extra := record
input_recs;
string30 word;
end;


Layout_extra addWords(input_recs l, integer c) := TRANSFORM
	SELF.word := Stringlib.StringExtract(Stringlib.StringFindReplace(TRIM(l.company_name),' ',','), c);
	SELF := l;
END;

with_words := NORMALIZE(input_recs,
							 LENGTH(Stringlib.StringFilter(TRIM(LEFT.company_name),' '))+1,
					  	 addWords(LEFT, COUNTER));
							 
key_recs := DEDUP(SORT(with_words(TRIM(word)<>''), RECORD), RECORD);

export Key_st_bizword_city := 
       index(key_recs,
             {string2 st := st,
						  string30 word := word,
							string25 city := p_city_name},
             {key_recs},
		     Gong_v2.thor_cluster+'key::gongv2_eda_st_bizword_city_' + doxie.Version_SuperKey);