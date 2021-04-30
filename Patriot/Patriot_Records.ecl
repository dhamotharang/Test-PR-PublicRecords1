import doxie,ut,address;


export Patriot_Records(REAL threshold_value, STRING200 surname_val, STRING200 givenname_val,
				   STRING200 othername_val, STRING200 unparsedname_val, STRING200 allentities_val,
				   STRING50 id_val, STRING50 Addr1_val, STRING50 Addr2_val, STRING40 city_val,
				   STRING40 state_val, STRING40 PostalCode_val, STRING40 Country_val,
				   STRING40 BlockedCountryName_val, SET OF STRING10 Lists_val) :=

FUNCTION
/*
real threshold_value := .75 : STORED('Threshold');
STRING200 surname_val := '' : STORED('SurName');
STRING200 givenname_val := '' : STORED('GivenName');
STRING200 OtherName_val := '' : STORED('OtherName');
STRING200 UnParsedName_val := '' : STORED('UnParsedName');
STRING200 AllEntities_val := '' : STORED('AllEntities');
STRING50  id_val := '' : STORED('Id');
STRING50  Addr1_val := '' : STORED('Addr1');
STRING50  Addr2_val := '' : STORED('Addr2');
STRING40  city_val := '' : STORED('City');
STRING40  state_val := '' : STORED('State');
STRING40  PostalCode_val := '' : STORED('PostalCode');
STRING40  Country_val := '' : STORED('Country');
STRING40  BlockedCountryName_val := '' : STORED('BlockedCountryName');
SET of STRING10 Lists_val := [] : STORED('Lists');
*/

List_ds := DATASET(Lists_val, {STRING10 l});
list_ds cap(list_ds le) :=
TRANSFORM
	SELF.l := Stringlib.StringToUpperCase(le.l);
END;
Lists_value := SET(PROJECT(list_ds, cap(LEFT)),l);

STRING100 country_value := StringLib.StringToUppercase(Country_val);
STRING100 blocked_country_value := StringLib.StringToUppercase(BlockedCountryName_val);

bigE := IF(UnParsedName_val<>'',UnParsedName_val,AllEntities_val);
p := address.CleanPerson73(bigE);

STRING fname_value := IF(bigE<>'',p[6..25],Stringlib.StringToUpperCase(givenname_val));
STRING mname_value := IF(bigE<>'',p[26..45],'');
STRING lname_value := IF(bigE<>'',p[46..66],Stringlib.StringToUpperCase(givenname_val));
STRING company_value := IF(OtherName_val<>'',Stringlib.StringToUpperCase(OtherName_val),
									Stringlib.StringToUpperCase(AllEntities_val));

pat := patriot.key_patriot_file;

ret :=
RECORD
	STRING10 pty_key;
	STRING1 match_type;
	decimal6_5 match_score;
	STRING40 matchedCountry;
	decimal6_5 matchCountry_score;
END;

ret slimper(pat le) :=
TRANSFORM
	SELF.pty_key := le.pty_key;
	SELF.match_type := 'P';
	
	didMatchCountry := Country_val = '' OR ut.StringSimilar(TRIM(country_value),TRIM(le.country)) <= 2;
	SELF.matchCountry_score := ut.max2(0,
							10 - ut.StringSimilar(country_value, le.country)) / 10;
	
	decimal6_5 score :=  ut.max2(0,
			10 - datalib.namematch(le.fname,le.mname,le.lname,fname_value,mname_value,lname_value)) / 10;
	SELF.match_score := IF(score < threshold_value OR score < .1 OR
					 ~didMatchCountry OR
					(patriot.Source2SourceCode(le.source) NOT IN Lists_val AND Lists_val<>[]), SKIP, score);
	SELF.matchedCountry := IF(didMatchCountry AND Country_val<>'',le.country,'');
					
END;
findper := PROJECT(pat((fname_value<>'' OR lname_value<>'') AND 
				datalib.namematch(fname,mname,lname,fname_value,mname_value,lname_value)<10), slimper(LEFT));

ret slimco(pat le) :=
TRANSFORM, SKIP(patriot.Source2SourceCode(le.source) NOT IN Lists_val AND Lists_val<>[])
	SELF.pty_key := le.pty_key;
	SELF.match_type := 'C';
	
	didMatchCountry := Country_val = '' OR ut.StringSimilar(TRIM(country_value),TRIM(le.country)) <= 2;
	SELF.matchCountry_score := ut.max2(0,
							10 - ut.StringSimilar(country_value, le.country)) / 10;
	
	decimal6_5 score := ut.max2(0,
			10 - ut.CompanySimilar(le.cname,company_value)) / 10;
	
	SELF.match_score := IF(score < threshold_value OR score < .1 OR
					~didMatchCountry OR
					(patriot.Source2SourceCode(le.source) NOT IN Lists_val AND Lists_val<>[]), SKIP, score);
	SELF.matchedCountry := IF(didMatchCountry AND Country_val<>'',le.country,'');
END;			
findco  := PROJECT(pat(company_value<>'' AND ut.CompanySimilar(cname,company_value) < 10), slimco(LEFT));

finder := DEDUP(findper+findco,pty_key,ALL);

lx :=
RECORD
	Layout_Attus_Out;
	boolean isAlias;
END;

lx getFile(ret le, PATRIOT.key_patriot_key ri) :=
TRANSFORM
	addsep(STRING75 str) := IF(LENGTH(TRIM(str))=0,'','|');

	decimal6_5 per_score := ut.max2(0,
			10 - datalib.namematch(ri.fname,ri.mname,ri.lname,fname_value,mname_value,lname_value))/10;
	decimal6_5 co_score := ut.max2(0,
			10 - ut.CompanySimilar(ri.cname,company_value))/10;
	
	decimal6_5 final_score := IF(le.match_type='P',per_score,co_score);
	
	SELF.EntityId := ri.pty_key;
	
	SELF.FullName := ri.orig_pty_name;
	SELF.LastName := ri.lname;
	SELF.FirstName := ri.fname;
	SELF.OtherName := ri.cname;
	SELF.IsAliasHit := 0;
	SELF.Score := IF(final_score <= .9, final_score+.1, final_score);
	SELF.ThisEntityMaxScore := SELF.Score;
	SELF.EntityType := IF(le.match_type='P', 'Individual', 'Company');
	SELF.Programs := ri.source;
	SELF.Remarks := TRIM(ri.remarks_1) + addsep(ri.remarks_2) +
					TRIM(ri.remarks_2) + addsep(ri.remarks_3) +
					TRIM(ri.remarks_3) + addsep(ri.remarks_4) +
					TRIM(ri.remarks_4) + addsep(ri.remarks_5) +
					TRIM(ri.remarks_5) + addsep(ri.remarks_6) +
					TRIM(ri.remarks_6) + addsep(ri.remarks_7) +
					TRIM(ri.remarks_7) + addsep(ri.remarks_8) +
					TRIM(ri.remarks_8) + addsep(ri.remarks_9);

	SELF.isAlias := ri.name_type='AKA';
	SELF.Aliases := [];
	SELF.Addresses := [];
	SELF.Countries := ROW({le.matchedCountry,le.matchCountry_score},Layout_Country);
END;
j := JOIN(finder,PATRIOT.key_patriot_key,keyed(LEFT.pty_key=RIGHT.pty_key),getFile(LEFT,RIGHT));

// TODO: check that everyone has a non-alias, and only 1 non-alias: not the case, but this compensates somewhat
s := DEDUP(SORT(j(~isAlias), EntityId, -Score),EntityId);

i := DEDUP(j(isAlias),EntityId,fullname,entitytype,score,all);

Layout_Attus_Out tofinal(s le) :=
TRANSFORM
	SELF := le;
END;
s_final := PROJECT(s, tofinal(LEFT));

typeof(recordof(j.Aliases)) getAlias(lx le) :=
TRANSFORM
	SELF.FullName := le.FullName;
	SELF.EntityType := le.EntityType;
	SELF.Score := le.Score;
END;

Layout_Attus_Out denorm(Layout_Attus_Out le, lx ri) :=
TRANSFORM
	SELF.Aliases := le.Aliases+PROJECT(ri,getAlias(LEFT));
	SELF.isAliasHit := le.isAliasHit | (INTEGER)(ri.Score >= threshold_value);
	SELF.ThisEntityMaxScore := IF(ri.Score > le.ThisEntityMaxScore, ri.Score, le.ThisEntityMaxScore);
	SELF := le;
END;
d := DENORMALIZE(s_final,i,LEFT.EntityId=RIGHT.EntityId,denorm(LEFT,RIGHT));

RETURN SORT(d,-ThisEntityMaxScore,-score,entityid);

END;