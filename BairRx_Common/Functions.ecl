IMPORT Bair, STD, SALT32;
EXPORT Functions := MODULE
	EXPORT Trim2Upper(string	pStr)	:= STD.Str.ToUpperCase(Std.Str.CleanSpaces(pStr));
	EXPORT SplitClassCodes(string3 mode, STRING ccodes, boolean clean=false) := FUNCTION
		etype := BairRx_Common.EID.TypeFromString(mode);
		setofCodes := STD.Str.SplitWords(STD.Str.FindReplace(ccodes,',',' '),' ');		
		nl := {string t; string c;};
		dCodes := DATASET([{etype, ccodes}], nl);
		nCodes := NORMALIZE(dCodes, count(setofcodes), TRANSFORM(nl, 
			ncode := (INTEGER) setofcodes[counter];
			isValidCC := BairRx_Common.ClassificationCode.isValidCode(mode,ncode);
			internalCC := BairRx_Common.ClassificationCode.MapClassCode(etype, ncode); // internal code, still used by geohash...
			SELF.c := TRIM(IF(clean, IF(isValidCC, setofcodes[counter], SKIP), IF(internalCC<>'',internalCC,SKIP))), 
			SELF := LEFT)						
			);
		stdCodes := SET(DEDUP(SORT(nCodes(c<>''), t, c), t, c), c);
		RETURN DATASET([{etype, stdCodes}],BairRx_Common.Layouts.ClassCodes);
	END;
	EXPORT DateTimeToString(unsigned7 dtime) := FUNCTION
		string date_time := (string) dtime;
		RETURN date_time[1..4]+'-'+date_time[5..6]+'-'+date_time[7..8]+' '+date_time[9..10]+':'+date_time[11..12]+':'+date_time[13..14]+'.'+date_time[15..17];
	END;
	EXPORT GetClass(string3 m, string rc) := BairRx_Common.ClassificationCode.LookupTable(mode=m, roxie_code=rc)[1].class;
	EXPORT GetDataProviderByORI(string agencyORI) := IF(agencyORI<>'', BairRx_Common.Keys.GroupAccessKey(KEYED(ori=agencyORI))[1].data_provider_id, 0);
	EXPORT DECIMAL5_2 RoundPercentage(part_value, total_value) := FUNCTION
		percent:=(part_value/total_value)*100;
		RETURN MAP((percent >99.99 AND percent<100)=>99.99,(percent>0 AND percent<0.01)=>0.01 ,percent);
	END;
	
	// Function will convert LIKE boolean expression's with a search arg length less then the minumum to a non Like search.
	EXPORT ValidateLikeExp(STRING filterExp) := FUNCTION
	
		PATTERN ws := PATTERN('[[:space:]]+');
		PATTERN anyNoQuote := PATTERN('[\001-\041\043-\377]');
		PATTERN anyNoApos := PATTERN('[\001-\046\050-\377]');
		PATTERN anyChar := PATTERN('[\041-\377]'); // Excludes whitespace(040)
		PATTERN anyNoQuoteApos := PATTERN('[\040-\041\043-\046\050-\377]');
		PATTERN QuoteChar := '\042';
		PATTERN AposChar := '\047';
		PATTERN word := anyChar+ ws | anyChar+ LAST;
		PATTERN LikeQuote := QuoteChar | AposChar;
		PATTERN Like_term := anyNoQuoteApos+;
		PATTERN Like_Prefix := 'WC_';
		PATTERN Like_Seg := anyChar+;
		PATTERN Like_Field := Like_Prefix Like_Seg;
		PATTERN Like_expr := Like_Field ws 'LIKE' ws LikeQuote Like_term LikeQuote;

		RULE myRule := Like_expr | word;

		expLayout := RECORD
			STRING expression;
		END;
		
		expLayout xfr_exp(expLayout l) := TRANSFORM
		
				// If LIKE search arguement length is less than the minumum, convert to non Like search
				SELF.Expression := MAP(MATCHED(Like_expr) => IF (LENGTH(MATCHTEXT(Like_term)) >= BairRx_Common.Constants.Filter.MinWildArgLen,
																															MATCHTEXT(Like_expr),
																															MATCHTEXT(Like_Seg) + '("' +
																															MATCHTEXT(Like_term) + '")'),
															 MATCHTEXT(word));
		END;

		// Convert passed string to datset for PARSE
	  expDset := DATASET([{filterExp}],expLayout);
		
		// Parse passed expression
		expParsed := PARSE(expDset,Expression,myRule,xfr_exp(LEFT),MAX,BEST,MANY,NOCASE);

		expLayout ConcatExp(expLayout l, expLayout r) := TRANSFORM
			SELF.Expression := TRIM(l.Expression) + ' ' + TRIM(r.Expression);
		END;
		expConcat := ROLLUP(expParsed,TRUE,ConcatExp(LEFT,RIGHT));

		RETURN((STRING) expConcat[1].Expression);
	END;
END;