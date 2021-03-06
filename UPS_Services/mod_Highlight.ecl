IMPORT iesp;

export mod_Highlight(SearchParams searchVals) := MODULE
	shared outLayout := iesp.rightaddress.t_RightAddressSearchRecord;

	// shared highlightStartTag := '<span style="background-color: yellow">';
	// shared highlightEndTag := '</span>';
	shared highlightStartTag := '<em>';
	shared highlightEndTag := '</em>';

	shared addrInputs := searchVals.addrQueryInputs;
	shared nameInputs := searchVals.nameQueryInputs;
	shared phoneInput := searchVals.phoneQueryInput;
	
	export HighlightLayout := RECORD
		UNSIGNED2 tokPos;
		STRING60  tokVal;
		BOOLEAN  highlight := false;
	END;

	shared addrLayout := iesp.rightaddress.t_RAAddressWithPhones;
	shared nameLayout := iesp.rightaddress.t_HighlightedNameAndCompany;
	shared phoneLayout := iesp.rightaddress.t_HighlightedPhoneInfo;

	// break a string into tokens (uses parser).  For the purpose of this fn, a
	// token is any string of consecutive non-whitespace characters.
	export DATASET(HighlightLayout) fn_TokenizeString(STRING s) := FUNCTION
		PATTERN p_word := PATTERN('[^[:space:]]+');
		RULE r_word := p_word;

		wordsRec := RECORD
			STRING60 val := MATCHTEXT(r_word);
		END;

		// doh!  Parser requires input is a dataset, so...
		ds := DATASET( [ { s } ], wordsRec );
		
		// we don't want to call the parser if we can avoid it.  In most cases,
		// (fname, mname, lname, prim_range, predir, suffix, postdir, state, and
		// zip), a field will contain only a single token.  A multi-token field is
		// the exception (companyname, prim_name, city).  If a field does not 
		// contain whitespace, it's only a single token and does not need to be
		// parsed.
		words := if(LENGTH(TRIM(s)) = LENGTH(TRIM(s, ALL)), ds,  // if no whitespace, don't parse
																												PARSE(ds, val, r_word, wordsRec, SCAN));

		// build the basic highlighted tokens record
		HighlightLayout WordsToHighlight(wordsRec L, INTEGER c) := TRANSFORM
			SELF.tokPos := c;					// enumerate the tokens so we can put them back together later
			SELF.tokVal := L.val;
			SELF.highlight := false;  // highlighting is false until we know otherwise
		END;

		hlwords := PROJECT(words, WordsToHighlight(LEFT, COUNTER));
		return hlwords;
	END;

	shared emptyToks := DATASET([], HighlightLayout);
	
	shared MAC_MakeToks(toks, field) := MACRO
		shared toks := if(field <> '', fn_TokenizeString(field), emptyToks);
	ENDMACRO;

	// when checking name response for highlighting, it's important to
	// remember that if an input name contains spaces, it may be put into
	// the full name field!
	// TODO - don't parse the full name three times!
	// TODO - do we want to use full name toks for first, middle, and last?

	shared BOOLEAN useFullName := nameInputs.First = '' AND 
																nameInputs.Middle = '' AND 
																nameInputs.Last = '' AND 
																nameInputs.Full <> '';

	MAC_MakeToks(inNameFirstToks, if(useFullName, nameInputs.Full, nameInputs.First));
	MAC_MakeToks(inNameMiddleToks, if(useFullName, nameInputs.Full, nameInputs.Middle));
	MAC_MakeToks(inNameLastToks, if(useFullName, nameInputs.Full, nameInputs.Last));

	MAC_MakeToks(inNameCompanyToks, nameInputs.CompanyName);

	MAC_MakeToks(inAddrPrimRangeToks, addrInputs.StreetNumber);
	
	// predirection and postdirection should be considered interchangable
	MAC_MakeToks(predirToks, addrInputs.StreetPredirection);
	MAC_MakeToks(postdirToks, addrInputs.StreetPostdirection);
	shared inAddrDirToks := predirToks + postdirToks;
	
	MAC_MakeToks(inAddrPrimNameToks, addrInputs.StreetName);
	MAC_MakeToks(inAddrSuffixToks, addrinputs.StreetSuffix);
	MAC_MakeToks(inAddrSecRangeToks, addrInputs.UnitNumber);
	MAC_MakeToks(inAddrCityToks, addrInputs.City);
	MAC_MakeToks(inAddrStateToks, addrInputs.State);
	MAC_MakeToks(inAddrZipToks, addrInputs.Zip5);

	MAC_MakeToks(inPhoneToks, phoneInput);

	// takes two sets of tokens:  input values and response values, and returns
	// a set of tokens (based on the response tokens) with the highlight flag
	// set for any token matching an input token.
	export DATASET(HighlightLayout) fn_HighlightTokens(DATASET(HighlightLayout) in_toks, DATASET(HighlightLayout) resp_toks) := FUNCTION

		// for each token in the input values (in_toks), we're going to find all
		// of the matching tokens in resp_toks.  indTermsLayout holds one input
		// token and all matching response tokens.
		indTermsLayout := RECORD
			DATASET(HighlightLayout) resp_toks {MAXCOUNT(100)};
			STRING60 value_to_highlight;
		END;

		// this is a crude way of associating response tokens with input tokens.
		// For each matching token, we set the highlight flag to true.

		indTermsLayout findHighlights(HighlightLayout L) := TRANSFORM
			matchingToks := resp_toks(tokVal = L.tokVal);  // matching responses

			// set hihglight on matching responses true
			HighlightLayout setHighlight(HighlightLayout L) := TRANSFORM
				SELF.highlight := true;
				SELF := L;
			END;

			SELF.resp_toks := PROJECT(matchingToks, setHighlight(LEFT));

			SELF.value_to_highlight := L.tokVal;  // the input token...
		END;

		highlightedTerms := PROJECT(in_toks, findHighlights(LEFT));

		// now, highlightedTerms is ALL of the response terms which will be
		// highlighted.  We just need to put everything back together, including
		// the unhighlighted tokens.  Gather all of the highlighted terms...

		indTermsLayout GatherTerms(indTermsLayout L, indTermsLayout R) := TRANSFORM
			SELF.resp_toks := L.resp_toks + R.resp_toks;
			SELF.value_to_highlight := '';
		END;

		// ... and add back in all of the unhighlighted terms.
		allTerms := ROLLUP(highlightedTerms, TRUE, GatherTerms(LEFT, RIGHT))[1].resp_toks + resp_toks;

		// We have lots of dupes now.  Sort them, and roll them up so that any
		// true values are kept.  If a term does not have a true value, we'll 
		// default to keeping the false value.

		srtTerms := SORT(allTerms, tokPos, tokVal);

		HighlightLayout GatherTrueValues(HighlightLayout L, HighlightLayout R) := TRANSFORM
			SELF.highlight := L.highlight OR R.highlight;
			SELF := L;
		END;

		rolledTerms := ROLLUP(srtTerms, 
													LEFT.tokPos = RIGHT.tokPos AND LEFT.tokVal = RIGHT.tokVal, 
													GatherTrueValues(LEFT, RIGHT));		
		return rolledTerms;
	END;

	// takes two strings (an input value and a response value), and highlights
	// any tokens in the response value string matching a token in the input
	// values string.
	export STRING fn_HighlightReusingInputs(DATASET(HighlightLayout) inToks, STRING response) := FUNCTION
		respToks := fn_TokenizeString(response);

		toStringLayout := RECORD
			STRING1000 outStr;  // a field used to build the output string
		END;

		toStringLayout toStringTransform(HighlightLayout L) := TRANSFORM
			leftTok := TRIM(L.tokVal);
			SELF.outStr := if(L.highlight, highlightStartTag + leftTok + highlightEndTag, leftTok);
		END;

		hlToks := PROJECT(fn_HighlightTokens(inToks, respToks), toStringTransform(LEFT));

		toStringLayout RollupTokens(toStringLayout L, toStringLayout R) := TRANSFORM
			SELF.outStr := TRIM(TRIM(L.outStr) + ' ' + R.outStr);
		END;

		rollToks := ROLLUP(hlToks, TRUE, RollupTokens(LEFT, RIGHT));

		#if(false)
		// some debug output...
		output(inToks, NAMED('inToks'));
		output(respToks, NAMED('respToks'));
		output(hlToks, NAMED('highlightedToks'));
		output(rollToks, NAMED('rollToks'));		
		#end

		return rollToks[1].outStr;
	END;

	// takes two strings (an input value and a response value), and highlights
	// any tokens in the response value string matching a token in the input
	// values string.
	export STRING fn_Highlight(STRING input, STRING response) := FUNCTION
		inToks := fn_TokenizeString(input);
		return fn_HighlightReusingInputs(inToks, response);
	END;

	shared phoneLayout HighlightPhoneTransform(phoneLayout P) := TRANSFORM
		SELF.phone10 := if(EXISTS(inPhoneToks) AND P.Phone10 <> '', fn_HighlightReusingInputs(inPhoneToks, P.Phone10), P.Phone10);
		SELF := P;
	END;

	shared addrLayout HighlightAddressTransform(addrLayout A) := TRANSFORM

		MAC_AddrHighlight(field, toks) := MACRO
			SELF.field := if(EXISTS(toks) AND A.field <> '', fn_HighlightReusingInputs(toks, A.field), A.field);
		ENDMACRO;

		MAC_AddrHighlight(StreetNumber, inAddrPrimRangeToks);
		MAC_AddrHighlight(StreetPredirection, inAddrDirToks);
		MAC_AddrHighlight(StreetName, inAddrPrimNameToks);
		MAC_AddrHighlight(StreetSuffix, inAddrSuffixToks);
		MAC_AddrHighlight(StreetPostdirection, inAddrDirToks);
		MAC_AddrHighlight(UnitNumber, inAddrSecRangeToks);
		MAC_AddrHighlight(City, inAddrCityToks);
		MAC_AddrHighlight(State, inAddrStateToks);
		MAC_AddrHighlight(Zip5, inAddrZipToks);
		
		SELF.Phones := PROJECT(A.Phones, HighlightPhoneTransform(LEFT));

		SELF := A;
	END;

	shared nameLayout HighlightNameTransform(nameLayout N) := TRANSFORM

		MAC_NameHighlight(field, toks) := MACRO
			SELF.field := if(EXISTS(toks) AND N.field <> '', fn_HighlightReusingInputs(toks, N.field), N.field);
		ENDMACRO;

		MAC_NameHighlight(First, inNameFirstToks);
		MAC_NameHighlight(Middle, inNameMiddleToks);
		MAC_NameHighlight(Last, inNameLastToks);
		MAC_NameHighlight(CompanyName, inNameCompanyToks);
		SELF := N;
	END;

	export nameLayout highlightName(nameLayout inName) := FUNCTION
		return PROJECT(inName, HighlightNameTransform(LEFT));
	END;

	export addrLayout highlightAddress(addrLayout inAddr) := FUNCTION
		return PROJECT(inAddr, HighlightAddressTransform(LEFT));
	END;

	// apply highlighting to all names/addresses
	export DATASET(outLayout) doAll(DATASET(outLayout) records) := FUNCTION

		outLayout DoHighlight(outLayout L) := TRANSFORM

			SELF.Names := PROJECT(L.Names, HighlightNameTransform(LEFT));
			SELF.Addresses := PROJECT(L.Addresses, HighlightAddressTransform(LEFT));
			SELF := L;

		END;

		return PROJECT(records, DoHighlight(LEFT));
	END;

	// apply highlighting to only the (one) best name and (one) best address.
	export DATASET(outLayout) doBest(DATASET(outLayout) records) := FUNCTION

		outLayout DoHighlight(outLayout L) := TRANSFORM
			bestName := 1;  				// best name (for UPS_Services) is always first
			bestAddr := L.BestAddress;

			numNames := COUNT(L.Names);
			numAddrs := COUNT(L.Addresses);

			dsBestName := DATASET( [ highlightName(L.Names[bestName]) ], nameLayout );
			dsBestAddr := DATASET( [ highlightAddress(L.Addresses[bestAddr]) ], addrLayout );

			SELF.Names := if(numNames = 1, dsBestName,
																		 dsBestName + L.Names[2..numNames]);

			SELF.Addresses := MAP(bestAddr = 1 AND numAddrs = 1 => dsBestAddr,  // only one address
														bestAddr = 1 AND numAddrs > 1 => dsBestAddr + L.Addresses[2..numAddrs],
														bestAddr > 1 AND numAddrs = bestAddr => L.Addresses[1..bestAddr - 1] + dsBestAddr,
														L.Addresses[1..bestAddr - 1] + dsBestAddr + L.Addresses[bestAddr + 1..numAddrs]);

			SELF := L;

		END;

		return PROJECT(records, DoHighlight(LEFT));
	END;
END;