export MAC_Collate_Uber_Matches(Key,Wds,s) := MACRO
indexOutputRecord := record(SALT26.Layout_Uber_Record)
  unsigned1 Weight;
	end;
#uniquename(into)
indexOutputRecord %into%(Key le,unsigned2 s) := transform
  self.Weight := (s+50) / 100;
  self := le;
  end;	
	
doIndexRead(unsigned4 id,unsigned2 fld,unsigned2 spc) := stepped( project( key( word_id = id, field=fld ), %into%(left,spc)), uid, priority(4000-spc));
doJoin(set of dataset(indexOutputRecord) inputs) := function
    indexOutputRecord createMatchRecord(indexOutputRecord firstMatch, dataset(indexOutputRecord) allMatches) := transform
		    self.weight := sum(allmatches,weight);
        self := firstMatch;
    end;
    return join(inputs, stepped(left.uid = right.uid), createMatchRecord(LEFT, ROWS(LEFT)), sorted(uid));
end;
#uniquename(r)
%r% := recordof(wds);
doAction(set of dataset(indexOutputRecord) allInputs, dataset(%r%) words, integer stage) := function
    numWords := count(words);
    sillyIntegerDs := normalize(dataset([0],{integer x}), numWords, transform({integer x}, self.x := counter));
    sillyIntegerSet := set(sillyIntegerDs, x);
	wordInputs := RANGE(allInputs, sillyIntegerSet);		// allInputs[1..count(words)]
    result := if (stage <= numWords,
					doIndexRead(words[noboundcheck stage].word_id,words[noboundcheck stage].field,words[noboundcheck stage].uid),
					doJoin(RANGE(allInputs, sillyIntegerSet)));
	return result;
end;
nullInput := dataset([], indexOutputRecord);
s := GRAPH(nullInput, count(wds)+1, doAction(rowset(left), wds, counter), parallel);
ENDMACRO;
