import ut;

export fn_Search(GROUPED DATASET(Layout_Batch_In) seqd, DATASET(GlobalWatchLists.Layout_SearchFile) ds) :=
FUNCTION

Layout_Working := Layout_Search_Working;

// tokenize
Layout_Working tokenize(Layout_Batch_In le) :=
TRANSFORM
	formatted := IF(le.name_unparsed<>'', le.name_unparsed, TRIM(le.name_first+' '+le.name_middle+' '+le.name_last, LEFT, RIGHT));
	
	cl := LENGTH(TRIM(le.country));
	formatted_country := IF(cl=2 AND ut.Country_ISO2_To_Name(le.country)<>'',ut.Country_ISO2_To_Name(le.country),
							IF(cl=3 AND ut.Country_ISO3_To_Name(le.country)<>'',ut.Country_ISO3_To_Name(le.country),le.country));
	
	token_input := DATASET([{formatted, translate_searchtype(le.search_type), le.seq}], GlobalWatchLists.Layout_SearchFile_In)+
					IF(formatted_country<>'',DATASET([{formatted_country, constants.country_code, le.seq}], GlobalWatchLists.Layout_SearchFile_In));
	
	SELF.tokens := globalwatchlists.fn_Format_SearchFile(token_input, true);
	SELF.name := formatted;
	SELF.version_number := (unsigned)le.version_number;
	SELF := le;
	SELF.ids := [];
	SELF.id := 0;
	SELF.score := 0;
END;
p1 := PROJECT(seqd, tokenize(LEFT));

// Search through the in-memory file
unsigned calcRadius(unsigned len) :=
IF(len <= 2, 0, 
	IF(len < 8, len / 2, len * .4));

// added match rank to ensure exact matches don't get crowded out of the 10000 tokens
temp := record
	integer match_rank; 
	ds;
end;

{unsigned6 id, STRING1 etype, integer match_rank} norm_ids(temp le, INTEGER i) :=
TRANSFORM
	SELF.id := le.ids[i].id;
	SELF.etype := le.etype;
	self.match_rank := le.match_rank;
END;

Layout_Working proc(Layout_Working le) :=
TRANSFORM
	x := IF(EXISTS(le.tokens),
		 CHOOSEN(ds(EXISTS(le.tokens(ds.etype=le.tokens.etype AND
									 Stringlib.EditDistance(ds.tkn,le.tokens.tkn) < calcRadius(LENGTH(TRIM(le.tokens.tkn)))))), 50000));
	
	x_exact := x(tkn in set(le.tokens, tkn));
	x_loose := x(tkn not in set(le.tokens, tkn));
	
	// don't let exact token matches get crowded out of the 10000
	xall := ungroup(
					project(x_loose, transform(temp, self.match_rank := 2, self := left)) +  // loose match ranked 2nd behind exact match
					project(x_exact, transform(temp, self.match_rank := 1, self := left)) 
					);
	
	xn := NORMALIZE(xall, COUNT(LEFT.ids), norm_ids(LEFT, COUNTER));

	SELF.ids := PROJECT(TOPN(DEDUP(xn,id,all),10000, match_rank, etype, id), TRANSFORM({unsigned6 id}, SELF := LEFT));
	
	SELF.seq := le.seq;
	SELF := le;
END;
procd := PROJECT(p1, proc(LEFT));

// Normalize the identified IDs
Layout_Working norm(Layout_Working le, INTEGER i) :=
TRANSFORM
	SELF.id := le.ids[i].id;
	SELF := le;
END;
n := NORMALIZE(procd, COUNT(LEFT.ids), norm(LEFT, COUNTER));

RETURN n;
END;
