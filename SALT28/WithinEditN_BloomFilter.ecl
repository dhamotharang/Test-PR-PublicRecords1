EXPORT BOOLEAN WithinEditN_BloomFilter(STRING hashl, STRING bitvecl, STRING hashr, STRING bitvecr, StrType l, StrType r, UNSIGNED1 d) := 
	BloomFilter(hashl, bitvecl, hashr, bitvecr) AND WithinEditN(l,r,d);
