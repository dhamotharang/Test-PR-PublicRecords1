EXPORT BOOLEAN WithinEditN_BloomFilter(STRING hashl, STRING bitvecl, STRING hashr, STRING bitvecr, StrType l, StrType r, UNSIGNED1 d, UNSIGNED1 edit_threshold=0) := 
	BloomFilter(hashl, bitvecl, hashr, bitvecr) AND WithinEditN(l,r,d,edit_threshold);
