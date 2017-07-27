EXPORT Mac_Collate_WordBag_Matches1(n,indexOutputRecord,doIndexRead,joinfield,steppedmatches) := MACRO
doJoin(SET OF DATASET(indexOutputRecord) inputs) := FUNCTION
    indexOutputRecord createMatchRecord(indexOutputRecord firstMatch, DATASET(indexOutputRecord) allMatches) := TRANSFORM
		    SELF.gss_word_weight := SUM(allmatches,gss_word_weight);
        SELF := firstMatch;
    END;
    RETURN JOIN(inputs, STEPPED(LEFT.joinfield = RIGHT.joinfield), createMatchRecord(LEFT, ROWS(LEFT)), SORTED(joinfield));
END;
#uniquename(r)
%r% := RECORDOF(n);
doAction(SET OF DATASET(indexOutputRecord) allInputs, DATASET(%r%) words, INTEGER stage) := FUNCTION
    numWords := COUNT(words);
    sillyIntegerDs := NORMALIZE(DATASET([0],{INTEGER x}), numWords, TRANSFORM({INTEGER x}, SELF.x := COUNTER));
    sillyIntegerSet := SET(sillyIntegerDs, x);
	wordInputs := RANGE(allInputs, sillyIntegerSet);		// allInputs[1..count(words)]
    result := IF (stage <= numWords,
					doIndexRead(words[noboundcheck stage].hsh,words[noboundcheck stage].spec),
					doJoin(RANGE(allInputs, sillyIntegerSet)));
	RETURN result;
END;
nullInput := DATASET([], indexOutputRecord);
steppedMatches := GRAPH(nullInput, count(n)+1, doAction(rowset(LEFT), n, COUNTER), PARALLEL);
  ENDMACRO;
