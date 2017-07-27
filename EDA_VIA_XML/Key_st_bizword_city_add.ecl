import gong, doxie;

input_recs := gong.file_daily_full((listing_type_bus = 'B') AND (TRIM(listed_name)<>''));

Layout_extra := RECORD
  STRING30	word;
	STRING25	city;
	gong.Layout_bscurrent_raw;
END;

Layout_extra addOrig(gong.Layout_bscurrent_raw l) := TRANSFORM
  SELF.word := '';
	SELF.city := l.p_city_name;
	SELF := l;
END;

orig_cities := PROJECT(input_recs, addOrig(LEFT));

Layout_extra addExtra(gong.Layout_bscurrent_raw l, integer c) := TRANSFORM
	SELF.word := '';
	SELF.city := StringLib.StringExtract(ZipLib.ZipToCities(l.z5),c+1);
	SELF := l;
END;

extra_cities := NORMALIZE(input_recs(TRIM(z5)<>''),
							 (INTEGER)StringLib.StringExtract(ZipLib.ZipToCities(LEFT.z5),1),
					  	 addExtra(LEFT, COUNTER));

all_cities := DEDUP(SORT(orig_cities + extra_cities(TRIM(city)<>''), RECORD), RECORD);

Layout_extra addWords(Layout_extra l, integer c) := TRANSFORM
	SELF.word := Stringlib.StringExtract(Stringlib.StringFindReplace(TRIM(l.listed_name),' ',','), c);
	SELF := l;
END;

with_words := NORMALIZE(all_cities,
							 LENGTH(Stringlib.StringFilter(TRIM(LEFT.listed_name),' '))+1,
					  	 addWords(LEFT, COUNTER));
							 
key_recs := DEDUP(SORT(with_words(TRIM(word)<>''), RECORD), RECORD);

export Key_st_bizword_city_add := 
       index(key_recs,
             {string2 st := st,
						  string30 word := word,
							string25 city := city},
             {key_recs},
		   '~thor_data400::key::gong_eda_st_bizword_city_add_' + doxie.Version_SuperKey, OPT);