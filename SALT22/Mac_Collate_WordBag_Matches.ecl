export Mac_Collate_WordBag_Matches(n,indexOutputRecord,doIndexRead,joinfield,steppedmatches) := MACRO
doJoin(set of dataset(indexOutputRecord) inputs) := function
    indexOutputRecord createMatchRecord(indexOutputRecord firstMatch, dataset(indexOutputRecord) allMatches) := transform
		    self.gss_word_weight := sum(allmatches,gss_word_weight);
        self := firstMatch;
    end;
    return join(inputs, stepped(left.joinfield = right.joinfield), createMatchRecord(LEFT, ROWS(LEFT)), sorted(joinfield));
end;
#uniquename(r)
%r% := recordof(n);
doAction(set of dataset(indexOutputRecord) allInputs, dataset(%r%) words, integer stage) := function
    numWords := count(words);
    sillyIntegerDs := normalize(dataset([0],{integer x}), numWords, transform({integer x}, self.x := counter));
    sillyIntegerSet := set(sillyIntegerDs, x);
	wordInputs := RANGE(allInputs, sillyIntegerSet);		// allInputs[1..count(words)]
    result := if (stage <= numWords,
					doIndexRead(words[noboundcheck stage].hsh,words[noboundcheck stage].spec),
					doJoin(RANGE(allInputs, sillyIntegerSet)));
	return result;
end;
nullInput := dataset([], indexOutputRecord);
steppedMatches := GRAPH(nullInput, count(n)+1, doAction(rowset(left), n, counter), parallel);
  endmacro;
