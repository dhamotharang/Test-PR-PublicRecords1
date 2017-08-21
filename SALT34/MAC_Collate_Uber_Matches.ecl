EXPORT MAC_Collate_Uber_Matches(Key,Wds,s,in_dt_first_field='',in_dt_last_filed='',asofdate=0,in_partition_field='',in_partition='') := MACRO
indexOutputRecord := RECORD(SALT34.Layout_Uber_Record)
  UNSIGNED1 Weight;
	END;
#uniquename(into)
indexOutputRecord %into%(Key le,UNSIGNED2 s) := TRANSFORM
  SELF.Weight := (s+50) / 100;
  SELF := le;
  END;	

doIndexRead(UNSIGNED4 id,UNSIGNED2 fld,UNSIGNED2 spc) := STEPPED( PROJECT( key( word_id = id, field=fld 
#IF ( #TEXT(in_dt_first_field) <> '' AND #TEXT(in_dt_last_field) <> '')
 ,( asofdate = 0 OR (( asofdate >= in_dt_first_field OR in_dt_first_field = 0 AND in_dt_last_field <> 0 ) AND ( asofdate <= in_dt_last_field OR in_dt_last_field = 0 AND in_dt_first_field <> 0 )))
#END	
#IF ( #TEXT(in_partition_field) <> '' )
 , in_partition_field = in_partition OR in_partition_field = ''
#END	
), %into%(LEFT,spc)), uid, PRIORITY(4000-spc));
doJoin(SET OF DATASET(indexOutputRecord) inputs) := FUNCTION
    indexOutputRecord createMatchRecord(indexOutputRecord firstMatch, DATASET(indexOutputRecord) allMatches) := TRANSFORM
		    SELF.weight := sum(allmatches,weight);
        SELF := firstMatch;
    END;
    RETURN join(inputs, STEPPED(LEFT.uid = RIGHT.uid), createMatchRecord(LEFT, ROWS(LEFT)), SORTED(uid));
END;
#uniquename(r)
%r% := RECORDOF(wds);
doAction(SET OF DATASET(indexOutputRecord) allInputs, DATASET(%r%) words, INTEGER stage) := FUNCTION
    numWords := COUNT(words);
    sillyIntegerDs := NORMALIZE(DATASET([0],{INTEGER x}), numWords, TRANSFORM({INTEGER x}, SELF.x := COUNTER));
    sillyIntegerSet := SET(sillyIntegerDs, x);
	wordInputs := RANGE(allInputs, sillyIntegerSet);		// allInputs[1..count(words)]
    result := IF (stage <= numWords,
					doIndexRead(words[noboundcheck stage].word_id,words[noboundcheck stage].field,words[noboundcheck stage].uid),
					doJoin(RANGE(allInputs, sillyIntegerSet)));
	return result;
END;
nullInput := DATASET([], indexOutputRecord);
s := GRAPH(nullInput, COUNT(wds)+1, doAction(ROWSET(LEFT), wds, COUNTER), PARALLEL);
ENDMACRO;
