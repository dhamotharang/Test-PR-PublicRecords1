IMPORT ut;
EXPORT Make_DictStat(DATASET(Layout_Dictionary) dict, 
										 DATASET(Layout_DocSize) d_size) := FUNCTION

	Layout_DictStats extDict(Layout_Dictionary dct) := TRANSFORM
		SELF.maxDocFreq := dct.docFreq;
		SELF.maxFreq := dct.freq;
		SELF.uniqueNominals := 1;
		SELF.meanDocSize := 0;
		SELF.docCount := 0;
    SELF.version := 1;
	END;
	dct0 := PROJECT(dict, extDict(LEFT));
	
	Layout_DictStats rollDict(Layout_DictStats l, layout_DictStats r):=TRANSFORM
		SELF.maxDocFreq := IF(l.maxDocFreq>r.maxDocFreq, l.maxDocFreq, r.maxDocFreq);
		SELF.maxFreq := IF(l.maxFreq>r.maxFreq, l.maxFreq, r.maxFreq);
		SELF.uniqueNominals := l.uniqueNominals + r.uniqueNominals;
		SELF.meanDocSize := 0;
		SELF.docCount := 0;
    SELF.version := 1;
	END;
	
	dct1 := ROLLUP(dct0, rollDict(LEFT,RIGHT), TRUE, LOCAL);
	fromDict := ROLLUP(dct1, rollDict(LEFT,RIGHT), TRUE);
	
	Layout_DictStats extInv(Layout_DocSize dsize) := TRANSFORM
		SELF.meanDocSize := dsize.doc_size;
		SELF.docCount := 1;
    SELF.version := 1;
		SELF := [];
	END;
	inv0 := PROJECT(d_size, extInv(LEFT));
	
	Layout_DictStats rollInv(Layout_DictStats l, Layout_DictStats r) := TRANSFORM
		SELF.meanDocSize := l.meanDocSize + r.meanDocSize;
		SELF.docCount := l.docCount + r.docCount;
		SELF := l;
	END;
	inv1 := ROLLUP(inv0, rollInv(LEFT,RIGHT), TRUE, LOCAL);
	inv2 := ROLLUP(inv1, rollInv(LEFT,RIGHT), TRUE);
	
	Layout_DictStats calcDocLen(Layout_DictStats l) := TRANSFORM
		SELF.meanDocSize := l.meanDocSize / l.docCount;
		SELF.docCount := l.docCount;
    SELF.version := 1;
		SELF := [];
	END;
	fromInv := PROJECT(inv2, calcDocLen(LEFT));
	
	Layout_DictStats rollFinal(Layout_DictStats l, Layout_DictStats r) := TRANSFORM
		SELF.maxDocFreq := IF(l.maxDocFreq<0, l.maxDocFreq, r.maxDocFreq);
		SELF.maxFreq := IF(l.maxFreq>0, l.maxFreq, r.maxFreq);
		SELF.uniqueNominals := IF(l.uniqueNominals>0, l.uniqueNominals, r.uniqueNominals);
		SELF.meanDocSize := IF(l.meanDocSize>0, l.meanDocSize, r.meanDocSize);
		SELF.docCount := IF(l.docCount>0, l.docCount, r.docCount);
    SELF.version := 1;
	END;
	rslt := ROLLUP(fromDict+fromInv, rollFinal(LEFT,RIGHT), TRUE);

	RETURN rslt;
END : DEPRECATED('Use new Build_From_Posting');