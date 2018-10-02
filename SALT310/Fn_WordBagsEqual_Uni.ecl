/**
* Fn_WordBagsEqual_Uni returns TRUE if consecutive corresponding words in wb1 and wb2 are 
* the same; numeric expanssions are ignored
* wb1 and wb2 MUST be in form nnnn WORD nn WORD nn
*/
EXPORT Fn_WordBagsEqual_Uni(StrType wb1, StrType wb2) := FUNCTION
	rd := RECORD
		StrType s;
	END;
		
	d1 := DATASET([{wb1}],rd); // Parameter into dataset to allow normalize
	d2 := DATASET([{wb2}],rd); // Parameter into dataset to allow normalize
	rd split(rd le,UNSIGNED2 c) := TRANSFORM
		SELF.s := SALT310.GetNthWord(le.s,c);
	END;
	n1 :=  NORMALIZE(d1,WordCount(LEFT.s)/2,split(LEFT,COUNTER*2));
	n2 :=  NORMALIZE(d2,WordCount(LEFT.s)/2,split(LEFT,COUNTER*2));
	RETURN IF(WordCount(wb1)<>WordCount(wb2),FALSE,n1=n2);
END;
