import gong, NID;

export Search_Lname_Fname(STRING20 lname_v, STRING1 useSimilarLastNames_v, STRING20 fname_v, STRING1 useFirstInitial_v, STRING1 useSimilarFirstNames_v, DATASET(EDA_VIA_XML.Layout_City_List) city_list_v) := FUNCTION

partial := IF(LENGTH(Stringlib.StringFilter(lname_v,'*'))>0, true, false);

input_rec := RECORD
	string20 lname;
	string20 fname;
	string25 city;
	string2 state;
END;

input := dataset([{Stringlib.StringFindReplace(lname_v,'*',' '), fname_v, '', ''}], input_rec);

/*
input_rec addPreferred(input_rec l, INTEGER c) := TRANSFORM
	SELF.fname := IF(c=1, l.fname, datalib.preferredFirst(l.fname));
	SELF := l;
END;

input_w_preferred := NORMALIZE(input,
														IF((useSimilarFirstNames_v='Y')AND(datalib.preferredFirst(LEFT.fname)<>LEFT.fname),2,1), 
														addPreferred(LEFT, COUNTER));
*/

input_rec addInitial(input_rec l, INTEGER c) := TRANSFORM
	SELF.fname := IF(c=1, l.fname, l.fname[1..1]);
	SELF := l;
END;

input_w_initial := NORMALIZE(input, IF(useFirstInitial_v = 'Y', 2, 1), addInitial(LEFT, COUNTER));

input_rec mergeCities(EDA_VIA_XML.Layout_City_List l, input_rec r) := TRANSFORM
	SELF.lname := r.lname;
	SELF.fname := r.fname;
	SELF.city := l.city;
	SELF.state := l.st;
END;

search_terms := JOIN(city_list_v, input_w_initial, true, mergeCities(LEFT,RIGHT), LEFT OUTER, ALL);

lname_filt := MACRO
	KEYED(partial AND LEFT.lname=RIGHT.lname[1..LENGTH(TRIM(LEFT.lname))] OR LEFT.lname=RIGHT.lname)
ENDMACRO;

baseFull := JOIN(search_terms, EDA_VIA_XML.Key_st_lname_fname_city,
								TRIM(LEFT.city)<>'' AND
								KEYED(LEFT.state=RIGHT.st) AND
								lname_filt() AND
								KEYED(LEFT.fname=RIGHT.fname or 
								      (useSimilarFirstNames_v='Y' and NID.mod_PFirstTools.RinPFL(left.fname,right.fname))) AND 
								KEYED(LEFT.city=RIGHT.city),
							TRANSFORM(gong.Layout_bscurrent_raw, 
							          self.sequence_number := (string10)right.sequence_number,
							          SELF:=RIGHT),
							LIMIT(0), KEEP(10000)
					);
					
baseLnameFnameSt := JOIN(search_terms, EDA_VIA_XML.Key_st_lname_fname_city, 
								TRIM(LEFT.city)='' AND
								KEYED(LEFT.state=RIGHT.st) AND
								lname_filt() AND
								KEYED(LEFT.fname=RIGHT.fname or 
								      (useSimilarFirstNames_v='Y' and NID.mod_PFirstTools.RinPFL(left.fname,right.fname))),
							TRANSFORM(gong.Layout_bscurrent_raw, 
							          self.sequence_number := (string10)right.sequence_number,
							          SELF:=RIGHT),
							LIMIT(0), KEEP(10000)
					);
					
lfname_results := baseFull + baseLnameFnameSt;

EDA_VIA_XML.Layout_Gong_Extended addScore(gong.Layout_bscurrent_raw l) := TRANSFORM
  SELF.score := 100 - IF(lname_v <> l.name_last, 20, 0) - IF(fname_v <> l.name_first, 20, 0);
	SELF := l;
END;

return PROJECT(lfname_results, addScore(LEFT));

END;