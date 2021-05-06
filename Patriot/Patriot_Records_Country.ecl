import ut;

export Patriot_Records_Country(REAL threshold_value, STRING40 BlockedCountryName_val) :=
FUNCTION
/*
real threshold_value := .75 : STORED('Threshold');
STRING40  BlockedCountryName_val := '' : STORED('BlockedCountryName');
*/
STRING100 country_value := StringLib.StringToUppercase(BlockedCountryName_val);

dt :=
RECORD
	STRING40 country_name;
END;


// Country Search
dt country_proj(STRING100 le) :=
TRANSFORM
	match := metaphonelib.DMetaPhone1(le)=metaphonelib.DMetaPhone1(country_value);
	SELF.country_name := IF(match, le, SKIP);
END;

country_rec := IF(metaphonelib.DMetaPhone1(country_value) IN PATRIOT.Country_Phonetic_Blacklist, 
				PROJECT(DATASET(PATRIOT.Country_Blacklist,{STRING100 str}), country_proj(LEFT.str)));

Layout_Attus_Out toFinal(country_rec le) :=
TRANSFORM
	score_comp := ut.max2(0,
			10 - ut.StringSimilar(country_value, le.country_name)) / 10;
	score := IF(score_comp < threshold_value OR score_comp < .1, SKIP, score_comp);

	SELF.Countries := ROW({le.country_name,score},Layout_Country);
	SELF.EntityType := 'Country';
	SELF.Aliases := [];
	SELF.Addresses := [];
	SELF := [];
END;

p := PROJECT(country_rec, tofinal(LEFT));

RETURN p;

END;