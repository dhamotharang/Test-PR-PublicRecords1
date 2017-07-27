import ut;

export fn_Format_SearchFile(DATASET(Layout_SearchFile_In) infile, boolean isOneID = false) :=
FUNCTION

i := constants.individual_code;
b := constants.both_code;
n := constants.non_individual_code;

// format
// B=Both get both an I and an N record
Layout_SearchFile_In clean_person(Layout_SearchFile_In le) :=
TRANSFORM
	SELF.name := person_cleaner(le.name);
	SELF.etype := i;
	SELF := le;
END;
person_cleaned := PROJECT(infile(etype IN [i, b]), clean_person(LEFT));

Layout_SearchFile_In clean_company(Layout_SearchFile_In le) :=
TRANSFORM
	SELF.name := company_cleaner(le.name);
	SELF.etype := IF(le.etype IN [n,b], n, le.etype);
	SELF := le;
END;
// includes b, c and anything unknown
company_cleaned := PROJECT(infile(etype <> i), clean_company(LEFT));
all_clean := person_cleaned + company_cleaned;

Layout_SearchFile norm(Layout_SearchFile_In le, INTEGER c) :=
TRANSFORM
	w := ut.word(le.name, c);
	SELF.tkn := IF(LENGTH(TRIM(w))<2 OR
					(w IN stopwords.lname AND le.etype=i) OR 
					(w IN stopwords.cname AND le.etype=n), SKIP, w);
	SELF.etype := le.etype;
	SELF.ids:= PROJECT(le, TRANSFORM({unsigned6 id}, SELF := LEFT));
	SELF := le;
END;
normed := NORMALIZE(all_clean, ut.NoWords(LEFT.name), norm(LEFT, COUNTER));

Layout_SearchFile roller(Layout_SearchFile le, Layout_SearchFile ri) :=
TRANSFORM
	SELF.ids := le.ids+ri.ids;
	SELF := le;
END;

s := SORT(normed, tkn, etype);
rolled := ROLLUP(s,LEFT.tkn=RIGHT.tkn AND LEFT.etype=RIGHT.etype /* AND COUNT(LEFT.ids)<599 */, roller(LEFT,RIGHT));

RETURN IF(isOneID, dedup(normed, tkn, etype, all), rolled);
END;