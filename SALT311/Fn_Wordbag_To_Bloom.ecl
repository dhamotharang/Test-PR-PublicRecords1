// MORE - Drop into C++
EXPORT Fn_Wordbag_To_Bloom(StrType si) := FUNCTION
	r := RECORD
		UNSIGNED4 low;
		UNSIGNED4 high;
  END;
	
	UNSIGNED4 chartobit(STRING1 c) := 1 << MAP( c = ' ' => 27,
																						c > 'Z' => 28,
																						c < 'A' => 29,
																						TRANSFER(c,UNSIGNED1)-TRANSFER('A',UNSIGNED1)
																						);
	rd := RECORD
		StrType s;
	END;
	
	d := DATASET([{si}],rd); // Parameter into dataset to allow normalize
	r split(d le,UNSIGNED2 c) := TRANSFORM
		SELF.low := chartobit(GetNthWord(le.s,c)[1]);
		SELF.high := chartobit(GetNthWord(le.s,c)[2]);
  END;
	UNSIGNED2 nwds := WordCount(si)/2; // Use rounding to 'strim' of extra word
	SS := NORMALIZE(d,nwds,split(LEFT,COUNTER*2));
	RR := ROLLUP(SS,TRUE,TRANSFORM(r,SELF.low := LEFT.low | RIGHT.low, SELF.high := LEFT.high | RIGHT.high));
	RETURN (RR[1].high << 32) | RR[1].low;
  END;
