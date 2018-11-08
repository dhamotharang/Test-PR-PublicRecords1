EXPORT Mac_Collate_WordBag_Matches4(n,indexOutputRecord,doIndexRead,joinfieldppp,joinfieldpp,joinfieldp,joinfield,steppedmatches) := MACRO
doJoin(SET OF DATASET(indexOutputRecord) inputs) := FUNCTION
    indexOutputRecord createMatchRecord(indexOutputRecord firstMatch, DATASET(indexOutputRecord) allMatches) := TRANSFORM
		    SELF.gss_word_weight := SUM(allmatches,gss_word_weight);
        SELF := firstMatch;
    END;
    RETURN MERGEJOIN(inputs, STEPPED(LEFT.joinfield = RIGHT.joinfield AND LEFT.joinfieldp = RIGHT.joinfieldp AND LEFT.joinfieldpp = RIGHT.joinfieldpp AND LEFT.joinfieldppp = RIGHT.joinfieldppp)
		//, createMatchRecord(LEFT, ROWS(LEFT))
		, SORTED(joinfieldppp,joinfieldpp,joinfieldp,joinfield)
		, ASSERT SORTED);
END;
#uniquename(r)
%r% := RECORDOF(n);
doAction(SET OF DATASET(indexOutputRecord) allInputs, DATASET(%r%) words, INTEGER stage) := FUNCTION
		//pr := DEDUP(PROJECT(doIndexRead(words[noboundcheck stage].hsh,words[noboundcheck stage].spec),indexOutputRecord),joinfield,joinfieldp,joinfieldpp,joinfieldppp);
		pr := PROJECT(doIndexRead(words[noboundcheck stage].hsh,words[noboundcheck stage].spec),indexOutputRecord);
    result := IF (stage = 1, pr, doJoin([allInputs[stage-1], pr]));
	RETURN result;
END;
nullInput := DATASET([], indexOutputRecord);
steppedMatches0 := GRAPH(nullInput, count(n), doAction(rowset(LEFT), n, COUNTER), PARALLEL);
steppedMatches1 := GROUP(steppedMatches0,joinfieldppp,joinfieldpp,joinfieldp,joinfield);
    indexOutputRecord rlup(DATASET(indexOutputRecord) allMatches) := TRANSFORM
//		    SELF.gss_word_weight := SUM(DEDUP(SORT(allmatches,gss_hash),gss_hash),gss_word_weight);
// Expediant hack with similar execution profile to desired code (above)
		    SELF.gss_word_weight := SUM(DEDUP(SORT(allmatches,gss_word_weight),gss_word_weight),gss_word_weight); 
        SELF := allmatches[1];
    END;
steppedMatches := ROLLUP(steppedMatches1, GROUP, rlup(ROWS(LEFT)));
  ENDMACRO;
