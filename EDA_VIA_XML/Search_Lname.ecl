import gong;

export Search_Lname(STRING20 lname_v, STRING1 useSimilarLastNames_v, DATASET(EDA_VIA_XML.Layout_City_List) city_list_v) := FUNCTION

partial := IF(LENGTH(Stringlib.StringFilter(lname_v,'*'))>0, true, false);

input_rec := RECORD
	string20 lname;
	string25 city;
	string2 state;
END;

input := dataset([{Stringlib.StringFindReplace(lname_v,'*',' '), '', ''}], input_rec);

input_rec mergeCities(EDA_VIA_XML.Layout_City_List l, input_rec r) := TRANSFORM
	SELF.lname := r.lname;
	SELF.city := l.city;
	SELF.state := l.st;
END;

search_terms := JOIN(city_list_v, input, true, mergeCities(LEFT,RIGHT), LEFT OUTER, ALL);

lname_filt := MACRO
	KEYED(partial AND LEFT.lname=RIGHT.lname[1..LENGTH(TRIM(LEFT.lname))] OR LEFT.lname=RIGHT.lname)
ENDMACRO;

baseFull := JOIN(search_terms, EDA_VIA_XML.Key_st_lname_city,
								TRIM(LEFT.city)<>'' AND
								KEYED(LEFT.state=RIGHT.st) AND
								lname_filt() AND
								KEYED(LEFT.city=RIGHT.city),
							TRANSFORM(gong.Layout_bscurrent_raw, 
							          self.sequence_number := (string10)right.sequence_number,
							          SELF:=RIGHT),
							LIMIT(0), KEEP(10000)
					);
					
baseLnameSt := JOIN(search_terms, EDA_VIA_XML.Key_st_lname_city, 
								TRIM(LEFT.city)='' AND
								KEYED(LEFT.state=RIGHT.st) AND
								lname_filt(),
							TRANSFORM(gong.Layout_bscurrent_raw, 
							self.sequence_number := (string10)right.sequence_number,
							SELF:=RIGHT),
							LIMIT(0), KEEP(10000)
					);

lname_results := baseFull + baseLnameSt;

EDA_VIA_XML.Layout_Gong_Extended addScore(gong.Layout_bscurrent_raw l) := TRANSFORM
  SELF.score := 100 - IF(lname_v <> l.name_last, 20, 0);
	SELF := l;
END;

return PROJECT(lname_results, addScore(LEFT));

END;